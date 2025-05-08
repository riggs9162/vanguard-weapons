function SWEP:CanIronSight()
    local client = self:GetOwner()
    if ( !IsValid(client) ) then return false end

    if ( !self.IronSightsEnabled ) then return false end
    if ( self:GetReloading() ) then return false end

    if ( self.IronSightsCanMove ) then
        local runSpeed = client:GetRunSpeed()
        local vel = client:GetVelocity():Length2D() / runSpeed
        vel = math.Clamp(math.Round(vel, 2), 0, 1)

        if ( vel > self.IronSightsRunSpeed ) then
            return self.IronSightsCanMoveRun and true or false
        end
    end

    return true
end

function SWEP:ThinkIronSights()
    local client = self:GetOwner()
    if ( self:GetIronSights() and !self:CanIronSight() ) then
        self:SetIronSights(false)
        return
    end

    if ( IsFirstTimePredicted() ) then
        if ( self:GetIronSights() and !client:KeyDown(IN_ATTACK2) ) then
            self:SetIronSights(false)
        elseif ( !self:GetIronSights() and client:KeyDown(IN_ATTACK2) and self:CanIronSight() ) then
            self:SetIronSights(true)
        end
    end
end