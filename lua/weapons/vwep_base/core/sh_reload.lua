function VWEP:CanReload()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return false end

    if ( self:GetReloading() ) then return false end

    -- We might be wanting to switch fire modes, so prevent reloading
    if ( self.FireModes.Enabled and ply:KeyDown(IN_SPEED) ) then return false end

    return self:Clip1() < self.Primary.ClipSize and self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0
end

function VWEP:Reload()
    if ( !IsFirstTimePredicted() ) then return end
    if ( !self:CanReload() ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    if ( self.PreReload ) then
        self:PreReload()
    end

    local bIronsighted = self:GetIronSights()
    self:SetIronSights(false)
    self:SetReloading(true)

    if ( self.Cycling.Enabled ) then
        if ( self.Cycling.Automatic ) then
            local delayAnimation = self.Cycling.DelayAnimation or self.Cycling.Delay

            if ( CLIENT ) then
                ply:SetAnimation(PLAYER_RELOAD)

                timer.Create("VWEP.Cycling.Animation." .. self:EntIndex(), delayAnimation, 0, function()
                    if ( !IsValid(self) ) then return end

                    ply:SetAnimation(PLAYER_RELOAD)
                end)
            end

            timer.Create("VWEP.Cycling." .. self:EntIndex(), self.Cycling.Delay, 0, function()
                if ( !IsValid(self) ) then return end

                -- Reset the timer incase we set it to 0
                timer.Adjust("VWEP.Cycling." .. self:EntIndex(), self.Cycling.Delay, 0)

                if ( self:Clip1() < self.Primary.ClipSize ) then
                    -- Reset the animation so we can replay the cycling animation
                    self:ResetAnimation()

                    timer.Simple(0, function()
                        local _, duration = self:PlayAnimation(self.Cycling.Sequence, self.Cycling.PlaybackRate)
                        self:QueueIdle()

                        self:SetNextPrimaryFire(CurTime() + duration)
                        self:SetNextSecondaryFire(CurTime() + duration)
                    end)

                    if ( CLIENT ) then
                        local cycleSound, cycleSoundLevel, cycleSoundPitch, cycleSoundVolume, cycleSoundChannel = self.Cycling.Sound, self.Cycling.SoundLevel, self.Cycling.SoundPitch, self.Cycling.SoundVolume, self.Cycling.SoundChannel
                        self:EmitSound(cycleSound, cycleSoundLevel or 60, cycleSoundPitch or 100, cycleSoundVolume or 1, cycleSoundChannel or CHAN_ITEM)
                    end

                    ply:RemoveAmmo(1, self.Primary.Ammo)
                    self:SetClip1(self:Clip1() + 1)
                else
                    timer.Remove("VWEP.Cycling." .. self:EntIndex())
                    timer.Remove("VWEP.Cycling.Animation." .. self:EntIndex())

                    if ( self.Cycling.SequenceExit ) then
                        local _, duration = self:PlayAnimation(self.Cycling.SequenceExit, self.Cycling.PlaybackRate)
                        self:QueueIdle()

                        self:SetNextPrimaryFire(CurTime() + duration)
                        self:SetNextSecondaryFire(CurTime() + duration)
                    end

                    timer.Simple(duration or 0, function()
                        if ( !IsValid(self) ) then return end

                        if ( self.PreReloadFinish ) then
                            self:PreReloadFinish()
                        end

                        self:SetReloading(false)
                        self:SetRunningWait(0)

                        if ( self.PostReloadFinish ) then
                            self:PostReloadFinish()
                        end
                    end)
                end
            end)

            if ( self.Cycling.SequenceEntry ) then
                local _, duration = self:PlayAnimation(self.Cycling.SequenceEntry, self.Cycling.PlaybackRate)

                self:SetNextPrimaryFire(CurTime() + duration)
                self:SetNextSecondaryFire(CurTime() + duration)
            else
                timer.Adjust("VWEP.Cycling." .. self:EntIndex(), 0, 0)
            end
        else
            local _, duration = self:PlayAnimation(self.Cycling.SequenceEntry, self.Cycling.PlaybackRate)
            self:QueueIdle()

            self:SetNextPrimaryFire(CurTime() + duration)
            self:SetNextSecondaryFire(CurTime() + duration)

            timer.Simple(duration, function()
                if ( !IsValid(self) ) then return end

                local ammo = self.Cycling.Ammo
                local ammoToTake = math.min(ammo, ply:GetAmmoCount(self.Primary.Ammo))
                ply:RemoveAmmo(ammoToTake, self.Primary.Ammo)
                self:SetClip1(self:Clip1() + ammoToTake)

                ply:SetAnimation(PLAYER_RELOAD)

                local _, duration = self:PlayAnimation(self.Cycling.Sequence, self.Cycling.PlaybackRate)
                self:QueueIdle()

                self:SetNextPrimaryFire(CurTime() + duration)
                self:SetNextSecondaryFire(CurTime() + duration)

                if ( CLIENT ) then
                    local cycleSound, cycleSoundLevel, cycleSoundPitch, cycleSoundVolume, cycleSoundChannel = self.Cycling.Sound, self.Cycling.SoundLevel, self.Cycling.SoundPitch, self.Cycling.SoundVolume, self.Cycling.SoundChannel
                    self:EmitSound(cycleSound, cycleSoundLevel or 60, cycleSoundPitch or 100, cycleSoundVolume or 1, cycleSoundChannel or CHAN_ITEM)
                end

                timer.Simple(duration, function()
                    if ( !IsValid(self) ) then return end

                    local _, duration = self:PlayAnimation(self.Cycling.SequenceExit, self.Cycling.PlaybackRate)
                    self:QueueIdle()

                    self:SetNextPrimaryFire(CurTime() + duration)
                    self:SetNextSecondaryFire(CurTime() + duration)

                    timer.Simple(duration, function()
                        if ( !IsValid(self) ) then return end

                        if ( self.PreReloadFinish ) then
                            self:PreReloadFinish()
                        end

                        self:SetReloading(false)
                        self:SetRunningWait(0)

                        if ( self.PostReloadFinish ) then
                            self:PostReloadFinish()
                        end
                    end)

                    if ( self.PostReload ) then
                        self:PostReload()
                    end
                end)
            end)
        end
    else
        local clip = self:Clip1()
        local vmReload = self:GetViewModelReloadAnimation(bIronsighted)
        local vm = ply:GetViewModel()
        local _, duration = self:PlayAnimation(vmReload, clip <= 0 and self.Reloading.PlaybackRateEmpty or self.Reloading.PlaybackRate)
        self:QueueIdle()

        self:SetNextPrimaryFire(CurTime() + duration)

        if ( CLIENT ) then
            ply:SetAnimation(PLAYER_RELOAD)

            local reloadSound, reloadSoundLevel, reloadSoundPitch, reloadSoundVolume, reloadSoundChannel = self.Reloading.Sound, self.Reloading.SoundLevel, self.Reloading.SoundPitch, self.Reloading.SoundVolume, self.Reloading.SoundChannel
            self:EmitSound(reloadSound, reloadSoundLevel or 60, reloadSoundPitch or 100, reloadSoundVolume or 1, reloadSoundChannel or CHAN_ITEM)
        end

        timer.Simple(duration, function()
            if ( !IsValid(self) ) then return end

            if ( self.PreReloadFinish ) then
                self:PreReloadFinish()
            end

            self:SetReloading(false)

            local ammo = self.Primary.ClipSize - self:Clip1()
            local ammoToTake = math.min(ammo, ply:GetAmmoCount(self.Primary.Ammo))
            ply:RemoveAmmo(ammoToTake, self.Primary.Ammo)
            self:SetClip1(self:Clip1() + ammoToTake)
            self:SetRunningWait(0)

            if ( self.PostReloadFinish ) then
                self:PostReloadFinish()
            end
        end)

        if ( self.PostReload ) then
            self:PostReload()
        end
    end
end