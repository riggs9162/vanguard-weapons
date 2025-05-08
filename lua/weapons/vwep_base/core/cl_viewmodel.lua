local lerpIron
local lerpLastUpdate = 0
function SWEP:GetViewModelPosition(pos, ang)
    if ( !IsValid(self:GetOwner()) ) then return pos, ang end

    if ( !lerpIron ) then lerpIron = 0 end

    local ft = FrameTime()
    local time = ft * 5

    local bIron = self:GetIronSights()
    lerpIron = Lerp(time, lerpIron, bIron and 1 or 0)

    local offset = self.IronSightsPos or Vector()
    if ( self.IronSightsAng ) then
        ang = ang * 1

        ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x * lerpIron)
        ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y * lerpIron)
        ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * lerpIron)
    end

    pos = pos + offset.x * ang:Right() * lerpIron
    pos = pos + offset.y * ang:Forward() * lerpIron
    pos = pos + offset.z * ang:Up() * lerpIron

    local lerpIronInverted = 1 - lerpIron
    offset = self.ViewModelOffset or Vector()

    pos = pos + offset.x * ang:Right() * lerpIronInverted
    pos = pos + offset.y * ang:Forward() * lerpIronInverted
    pos = pos + offset.z * ang:Up() * lerpIronInverted

    local offsetAng = self.ViewModelOffsetAng or Angle()

    ang:RotateAroundAxis(ang:Right(), offsetAng.p * lerpIronInverted)
    ang:RotateAroundAxis(ang:Up(), offsetAng.y * lerpIronInverted)
    ang:RotateAroundAxis(ang:Forward(), offsetAng.r * lerpIronInverted)

    return pos, ang
end

SWEP.ViewModelElementsStored = SWEP.ViewModelElementsStored or {}

function SWEP:PreDrawViewModel(vm, weapon, client)
    if ( !IsValid(vm) ) then return end
    if ( !IsValid(weapon) ) then return end
    if ( !IsValid(client) ) then return end

    vm:SetModel(self.ViewModel or "")
    vm:SetMaterial(self.ViewModelMaterial or "")
    vm:SetColor(self.ViewModelColor or Color(255, 255, 255, 255))
    vm:SetRenderMode(self.ViewModelRenderMode or RENDERMODE_NORMAL)
    vm:SetRenderFX(self.ViewModelRenderFX or kRenderFxNone)

    if ( self.ViewModelSkin != vm:GetSkin() ) then
        vm:SetSkin(self.ViewModelSkin)
    end

    for k, v in pairs(self.ViewModelBodygroups or {}) do -- don't use ipairs, can't guarantee sequential order
        if ( !isnumber(k) or !isnumber(v) ) then continue end

        if ( vm:GetBodygroup(k) != v ) then
            vm:SetBodygroup(k, v)
        end
    end

    if ( self.ViewModelDynamicLights and #self.ViewModelDynamicLights > 0 ) then
        for k, v in ipairs(self.ViewModelDynamicLights) do
            if ( !v.Pos ) then continue end

            local light = DynamicLight(vm:EntIndex() + k)
            if ( !light ) then continue end

            local col = v.Color
            col.a = col.a or 255

            light.Pos = vm:GetPos() + vm:GetAngles():Forward() * v.Pos.x + vm:GetAngles():Right() * v.Pos.y + vm:GetAngles():Up() * v.Pos.z
            light.Brightness = v.Brightness or 1
            light.Size = v.Size or 128
            light.Decay = v.Decay or 100
            light.R = col.R
            light.G = col.G
            light.B = col.B
            light.DieTime = CurTime() + ( v.DieTime or 0.1 )
        end
    end

    if ( self.ViewModelElements and #self.ViewModelElements > 0 ) then
        for k, v in ipairs(self.ViewModelElements) do
            if ( !v.Model or !v.Bone ) then continue end

            local element = self.ViewModelElementsStored[k]
            if ( !element ) then
                element = ClientsideModel(v.Model, RENDERGROUP_BOTH)
                element:SetNoDraw(true)

                self.ViewModelElementsStored[k] = element
            end

            local bone = vm:LookupBone(v.Bone)
            if ( !bone ) then continue end

            local pos, ang = vm:GetBonePosition(bone)
            if ( !pos or !ang ) then continue end

            pos = pos + ang:Forward() * v.Pos.x + ang:Right() * v.Pos.y + ang:Up() * v.Pos.z
            ang:RotateAroundAxis(ang:Right(), v.Ang.x)
            ang:RotateAroundAxis(ang:Up(), v.Ang.y)
            ang:RotateAroundAxis(ang:Forward(), v.Ang.z)

            element:SetPos(pos)
            element:SetAngles(ang)
            element:SetModelScale(v.Scale or 1, 0)
            element:SetMaterial(v.Material or "")
            element:SetColor(v.Color or Color(255, 255, 255, 255))
            element:SetRenderMode(v.RenderMode or RENDERMODE_NORMAL)
            element:SetRenderFX(v.RenderFX or kRenderFxNone)

            if ( ( v.Skin or 0 ) != element:GetSkin() ) then
                element:SetSkin(v.Skin or 0)
            end

            for k, v in pairs(v.Bodygroups or {}) do -- don't use ipairs, can't guarantee sequential order
                if ( !isnumber(k) or !isnumber(v) ) then continue end

                if ( element:GetBodygroup(k) != v ) then
                    element:SetBodygroup(k, v)
                end
            end

            element:DrawModel()
        end
    end
end