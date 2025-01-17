function VWEP:GetWorldModelEntity()
    return self.WorldModelEntity
end

function VWEP:SetWorldModelEntity(ent)
    self.WorldModelEntity = ent
end

local WorldModel
function VWEP:DrawWorldModel()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local bone = ply:LookupBone(self.WorldModelBone or "ValveBiped.Bip01_R_Hand")
    if ( !bone ) then return end

    local matrix = ply:GetBoneMatrix(bone)
    if ( !matrix ) then return end

    if ( self.PreDrawWorldModel ) then
        self:PreDrawWorldModel()
    end

    local pos, ang = matrix:GetTranslation(), matrix:GetAngles()
    pos, ang = vanguard.util:Translate(pos, ang, self.WorldModelOffset or Vector(), self.WorldModelOffsetAng or Angle())

    if ( !IsValid(WorldModel) ) then
        WorldModel = ClientsideModel(self.WorldModel, RENDERGROUP_OTHER)
        WorldModel:SetNoDraw(true)

        WorldModel.Owner = ply
    end

    WorldModel:SetModel(self.WorldModel)
    WorldModel:SetPos(pos)
    WorldModel:SetAngles(ang)
    WorldModel:SetupBones()

    WorldModel:SetMaterial(self.WorldModelMaterial or "")
    WorldModel:SetColor(self.WorldModelColor or Color(255, 255, 255, 255))
    WorldModel:SetRenderMode(self.WorldModelRenderMode or RENDERMODE_NORMAL)
    WorldModel:SetRenderFX(self.WorldModelRenderFX or kRenderFxNone)

    WorldModel:SetModelScale(self.WorldModelScale or 1, 0)

    WorldModel:DrawModel()

    if ( self.WorldModelSkin != WorldModel:GetSkin() ) then
        WorldModel:SetSkin(self.WorldModelSkin)
    end

    for k, v in ipairs(self.WorldModelBodygroups or {}) do
        if ( WorldModel:GetBodygroup(k) != v ) then
            WorldModel:SetBodygroup(k, v)
        end
    end

    self:SetWorldModelEntity(WorldModel)

    if ( self.WorldModelDynamicLights and #self.WorldModelDynamicLights > 0 ) then
        for k, v in ipairs(self.WorldModelDynamicLights) do
            if ( !v.Pos ) then continue end

            local light = DynamicLight(self:EntIndex() + k)
            if ( !light ) then continue end

            if ( v.ShouldEmitLight and !v:ShouldEmitLight() ) then
                light.DieTime = CurTime()
                continue
            end

            light.Pos = pos + ang:Forward() * v.Pos.x + ang:Right() * v.Pos.y + ang:Up() * v.Pos.z
            light.Brightness = v.Brightness or 1
            light.Size = v.Size or 128
            light.Decay = v.Decay or 100
            light.R = v.R
            light.G = v.G
            light.B = v.B
            light.DieTime = CurTime() + ( v.DieTime or 0.1 )
        end
    end

    if ( self.PostDrawWorldModel ) then
        self:PostDrawWorldModel()
    end
end