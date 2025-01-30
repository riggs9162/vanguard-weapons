local switchCooldown = 0
function SWEP:ThinkFireModes()
    if ( !self.FireModes.Enabled ) then return end

    if ( self.PreThinkFireModes ) then
        self:PreThinkFireModes()
    end

    local preFireModeThink = hook.Run("VWEP_PreFireModeThink", self)
    if ( tobool(preFireModeThink) == false ) then
        return
    elseif ( isfunction(preFireModeThink) ) then
        preFireModeThink(self)
    end

    local owner = self:GetOwner()
    if ( !IsValid(owner) or owner:IsNPC() or owner:IsBot() ) then return end

    if ( owner:KeyDown(IN_SPEED) and owner:KeyDown(IN_RELOAD) ) then
        if ( !switchCooldown or CurTime() > switchCooldown ) then
            self:ToggleFireMode()
            switchCooldown = CurTime() + self.FireModes.Delay -- Cooldown to prevent spamming
        end
    end

    if ( self.PostThinkFireModes ) then
        self:PostThinkFireModes()
    end

    hook.Run("VWEP_PostFireModeThink", self)
end

function SWEP:ToggleFireMode()
    if ( !self.FireModes.Enabled ) then return end

    if ( self.PreToggleFireMode ) then
        self:PreToggleFireMode()
    end

    hook.Run("VWEP_PreFireModeChanged", self)

    -- Store the current fire mode
    local old = self:GetFireMode()

    -- Increment the current fire mode
    self:SetFireMode(self:GetFireMode() + 1)

    -- Loop back to the beginning
    if ( self:GetFireMode() > #self.FireModes.List ) then
        self:SetFireMode(1)
    end

    -- Update settings
    local mode = self.FireModes.List[self:GetFireMode()]
    self.Primary.Automatic = self.FireModes.Settings[mode].Automatic
    self.Primary.BurstCount = self.FireModes.Settings[mode].BurstCount

    -- Sounds
    if ( self.FireModes.Sound ) then
        self:EmitSound(self.FireModes.Sound, self.FireModes.SoundLevel or 60, self.FireModes.SoundPitch or 100, self.FireModes.SoundVolume or 1, self.FireModes.SoundChannel or CHAN_ITEM)
    end

    self:SetNextPrimaryFire(CurTime() + self.FireModes.Delay)
    
    if ( self.PostFireModeChanged ) then
        self:PostFireModeChanged(mode)
    end

    hook.Run("VWEP_PostFireModeChanged", self, old, mode)
end