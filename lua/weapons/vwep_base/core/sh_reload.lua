function SWEP:CanReload()
    local client = self:GetOwner()
    if ( !IsValid(client) ) then return false end

    if ( self:GetReloading() ) then return false end
    if ( self:GetCycling() ) then return false end
    if ( self:GetPumping() ) then return false end
    if ( self:GetRunning() ) then return false end
    if ( self:GetNextPrimaryFire() > CurTime() ) then return false end
    if ( self:GetNextSecondaryFire() > CurTime() ) then return false end

    if ( client.IsWepRaised and !client:IsWepRaised() ) then return false end
    if ( client.IsWeaponRaised and !client:IsWeaponRaised() ) then return false end

    return self:Clip1() < self.Primary.ClipSize and self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0
end

function SWEP:DoCyclingReload()
    local client = self:GetOwner()
    if ( !IsValid(client) ) then return end

    local sequenceEntry = self:GetViewModelCyclingEntryAnimation()
    local sequence = self:GetViewModelCyclingAnimation()
    local sequenceExit = self:GetViewModelCyclingExitAnimation()

    if ( !self:GetReloading() and sequenceEntry ) then
        local _, duration = self:PlayAnimation(sequenceEntry, self.Cycling.PlaybackRate)
        self:SetCyclingWait(CurTime() + duration + ( self.Cycling.Delay or 0 ))

        client:SetAnimation(PLAYER_RELOAD)

        if ( self.Cycling.GiveEntry ) then
            client:RemoveAmmo(1, self.Primary.Ammo)
            self:SetClip1(self:Clip1() + 1)
        end

        self:SetReloading(true)
    elseif ( !self:GetReloading() ) then
        self:SetCycleWait(CurTime())
        self:SetReloading(true)
    elseif ( self:Clip1() < self.Primary.ClipSize ) then
        local _, duration = self:PlayAnimation(sequence, self.Cycling.PlaybackRate)
        self:SetCyclingWait(CurTime() + duration + ( self.Cycling.Delay or 0 ))

        if ( CLIENT ) then
            local cycleSound, cycleSoundLevel, cycleSoundPitch, cycleSoundVolume, cycleSoundChannel = self.Cycling.Sound, self.Cycling.SoundLevel, self.Cycling.SoundPitch, self.Cycling.SoundVolume, self.Cycling.SoundChannel
            self:EmitSound(cycleSound, cycleSoundLevel or 60, cycleSoundPitch or 100, cycleSoundVolume or 1, cycleSoundChannel or CHAN_ITEM)
        end

        client:RemoveAmmo(1, self.Primary.Ammo)
        self:SetClip1(self:Clip1() + 1)
    else
        self:SetReloading(false)
        self:SetCycling(false)

        if ( sequenceExit ) then
            local _, duration = self:PlayAnimation(sequenceExit, self.Cycling.PlaybackRate)
            self:SetCyclingWait(CurTime() + duration + ( self.Cycling.Delay or 0 ))
            self:QueueIdle()
        end

        timer.Simple(duration or 0, function()
            if ( !IsValid(self) ) then return end

            if ( self.PreReloadFinish ) then
                self:PreReloadFinish()
            end

            self:SetReloading(false)
            self:SetCycling(false)

            if ( self.PostReloadFinish ) then
                self:PostReloadFinish()
            end
        end)
    end
end

function SWEP:Reload()
    if ( !self:CanReload() ) then return end

    local client = self:GetOwner()
    if ( !IsValid(client) ) then return end

    if ( self.PreReload ) then
        self:PreReload()
    end

    local bIronsighted = self:GetIronSights()
    self:SetIronSights(false)

    if ( self.Cycling and self.Cycling.Enabled ) then
        if ( self.Cycling.Automatic ) then
            self:SetCycling(true)
            self:SetCyclingWait(CurTime() + ( self.Cycling.Delay or 0 ))
        else
            self:DoCyclingReload()
        end

        return
    end

    self:SetReloading(true)

    local clip = self:Clip1()
    local vmReload = self:GetViewModelReloadAnimation(bIronsighted)
    local vm = client:GetViewModel()
    local _, duration = self:PlayAnimation(vmReload, clip <= 0 and self.Reloading.PlaybackRateEmpty or self.Reloading.PlaybackRate)
    self:QueueIdle()

    if ( self.Reloading.Events ) then
        for _, data in ipairs(self.Reloading.Events) do
            local time = data.Time
            local timeEmpty = data.TimeEmpty

            if ( clip <= 0 and timeEmpty ) then
                time = timeEmpty
            end

            timer.Simple(time, function()
                if ( !IsValid(self) or !IsValid(client) ) then return end

                local func = data.Function
                if ( func ) then
                    func(self, client)
                end
            end)
        end
    end

    if ( CLIENT ) then
        client:SetAnimation(PLAYER_RELOAD)

        local reloadSound, reloadSoundLevel, reloadSoundPitch, reloadSoundVolume, reloadSoundChannel = self.Reloading.Sound, self.Reloading.SoundLevel, self.Reloading.SoundPitch, self.Reloading.SoundVolume, self.Reloading.SoundChannel
        if ( clip <= 0 ) then
            reloadSound = self.Reloading.SoundEmpty or self.Reloading.Sound
        end

        self:EmitSound(reloadSound, reloadSoundLevel or 60, reloadSoundPitch or 100, reloadSoundVolume or 1, reloadSoundChannel or CHAN_ITEM)
    end

    timer.Simple(duration, function()
        if ( !IsValid(self) ) then return end

        if ( self.PreReloadFinish ) then
            self:PreReloadFinish()
        end

        self:SetReloading(false)

        local ammo = self.Primary.ClipSize - self:Clip1()
        local ammoToTake = math.min(ammo, client:GetAmmoCount(self.Primary.Ammo))
        client:RemoveAmmo(ammoToTake, self.Primary.Ammo)
        self:SetClip1(self:Clip1() + ammoToTake)

        self:SetNextPrimaryFire(CurTime() + 0.1)
        self:SetNextSecondaryFire(CurTime() + 0.1)

        if ( self.PostReloadFinish ) then
            self:PostReloadFinish()
        end
    end)

    if ( self.PostReload ) then
        self:PostReload()
    end
end

function SWEP:ThinkCycling()
    if ( !self:GetCycling() ) then return end
    if ( self:GetCyclingWait() > CurTime() ) then return end

    self:DoCyclingReload()
end