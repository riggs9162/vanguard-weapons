VWEP = SWEP
vanguard.util:Include("shared.lua")

local lerpFOV
local lerpLastUpdate = 0
function VWEP:TranslateFOV(fov)
    if ( !lerpFOV ) then lerpFOV = 1 end

    local owner = self:GetOwner()
    if ( !IsValid(owner) ) then return fov end

    if ( lerpLastUpdate < CurTime() ) then
        local ft = FrameTime()
        local time = ft * 15

        local bIron = self:GetIronSights()
        lerpFOV = Lerp(time, lerpFOV, bIron and self.IronSightsFOV or 1)

        lerpLastUpdate = CurTime()
    end

    return fov * lerpFOV
end

function VWEP:AdjustMouseSensitivity()
    local bIron = self:GetIronSights()
    if ( bIron ) then
        return self.IronSightsSensitivity or 0.5
    else
        return self.Sensitivity or 1
    end
end

function VWEP:EnabledDevMode()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return false end

    return ply:GetNW2Bool("VWEP.DevMode", false)
end

function VWEP:DrawHUD()
    if ( self.PreDrawHUD ) then
        self:PreDrawHUD()
    end

    if ( self.PostDrawHUD ) then
        self:PostDrawHUD()
    end
end