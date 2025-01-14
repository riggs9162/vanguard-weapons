function VWEP:CanPrimaryAttack()
    if ( self:GetReloading() ) then return false end

    if ( self.Primary.CanMove ) then
        local ply = self:GetOwner()
        if ( !IsValid(ply) ) then return false end

        local runSpeed = ply:GetRunSpeed()
        local vel = ply:GetVelocity():Length2D() / runSpeed
        vel = math.Round(vel, 2)
        vel = math.Clamp(vel, 0, 1)

        if ( vel > self.Primary.RunSpeed ) then
            return self.Primary.CanMoveRun and true or false
        end
    end

    return self:GetNextPrimaryFire() <= CurTime()
end

function VWEP:CanSecondaryAttack()
    if ( !self.IronSightsEnabled ) then return false end
    if ( self:GetReloading() ) then return false end

    return self:GetNextSecondaryFire() <= CurTime()
end

function VWEP:ShootBullet(damage, num_bullets, aimcone)
    if ( self.PreShootBullet ) then
        self:PreShootBullet(damage, num_bullets, aimcone)
    end

    local bullet = {}
    bullet.Num = num_bullets
    bullet.Src = self:GetOwner():GetShootPos()
    bullet.Dir = self:GetOwner():GetAimVector()
    bullet.Spread = Vector(aimcone, aimcone, 0)
    bullet.Tracer = 1
    bullet.TracerName = self.Effects.TracerEffect
    bullet.Force = damage * 0.5
    bullet.Damage = damage
    bullet.Attacker = self:GetOwner()

    self:GetOwner():FireBullets(bullet)
    self:ShootEffects()

    if ( self.PostShootBullet ) then
        self:PostShootBullet(damage, num_bullets, aimcone, bullet)
    end
end

function VWEP:ShootEffects()
    if ( self.PreShootEffects ) then
        self:PreShootEffects()
    end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local _, duration = self:PlayAnimation(self:GetViewModelShootAnimation(), self.Primary.PlaybackRate)
    self:QueueIdle()

    if ( CLIENT and IsFirstTimePredicted() ) then
        local ent = ply:GetViewModel()
        if ( ply:ShouldDrawLocalPlayer() ) then
            ent = self:GetWorldModelEntity()
        end

        if ( IsValid(ent) and self.Effects.MuzzleFlash ) then
            local effectData = EffectData()
            effectData:SetEntity(ent)
            effectData:SetAttachment(ent:LookupAttachment(self.Effects.MuzzleFlashAttachment or "muzzle"))
            effectData:SetScale(self.Effects.MuzzleFlashScale or 1)
            effectData:SetFlags(self.Effects.MuzzleFlashFlags or 1)

            util.Effect(self.Effects.MuzzleFlashEffect, effectData)
        end
    end

    ply:SetAnimation(PLAYER_ATTACK1)

    if ( self.PumpAction.Enabled ) then
        timer.Simple(duration, function()
            if ( !IsValid(self) ) then return end

            local _, pumpDuration = self:PlayAnimation(self:GetViewModelPumpActionAnimation(), self.PumpAction.PlaybackRate)
            self:QueueIdle()
            self:EmitSound(self.PumpAction.Sound, self.PumpAction.SoundLevel or 60, self.PumpAction.SoundPitch or 100, self.PumpAction.SoundVolume or 1, self.PumpAction.SoundChannel or CHAN_WEAPON)
        end)
    end

    if ( self.PostShootEffects ) then
        self:PostShootEffects()
    end
end

function VWEP:CalculateNextPrimaryFire()
    if ( self.Primary.RPM ) then
        return CurTime() + ( 60 / self.Primary.RPM )
    end

    return CurTime() + self.Primary.Delay
end

function VWEP:Shoot()
    if ( self:Clip1() <= 0 ) then
        self:EmitSound(self.Primary.SoundEmpty, 60, 100, 1, CHAN_WEAPON)
        self:SetNextPrimaryFire(CurTime() + 0.2)
        return
    end

    self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone)

    self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel or 100, self.Primary.SoundPitch or 100, self.Primary.SoundVolume or 1, self.Primary.SoundChannel or CHAN_WEAPON)
    self:TakePrimaryAmmo(1)

    local ply = self:GetOwner()
    if ( CLIENT and IsValid(ply) ) then
        local recoilAngle = Angle(-1, math.random(-1, 1), 0)

        if ( self:GetIronSights() ) then
            recoilAngle = recoilAngle * ( self.Primary.RecoilIronSights or self.Primary.Recoil )
        else
            recoilAngle = recoilAngle * self.Primary.Recoil
        end

        if ( IsFirstTimePredicted() or game.SinglePlayer() ) then
            ply:SetEyeAngles(ply:EyeAngles() + recoilAngle * 0.75)
        end

        ply:ViewPunch(recoilAngle * 0.5)
    end
end

function VWEP:PrimaryAttack()
    if ( !self:CanPrimaryAttack() ) then return end

    local prePrimaryAttack = self.PrePrimaryAttack
    if ( isfunction(prePrimaryAttack) ) then
        if ( prePrimaryAttack(self) == false ) then return end
    end

    if ( self.Primary.BurstCount > 0 ) then
        if ( self:GetBurstCount() >= self.Primary.BurstCount ) then
            self:SetBurstCount(0)
            self:SetNextPrimaryFire(CurTime() + self.Primary.BurstDelay)
        else
            self:Shoot()
            self:SetBurstCount(self:GetBurstCount() + 1)
            self:SetNextPrimaryFire(self:CalculateNextPrimaryFire())
        end
    else
        self:Shoot()
        self:SetNextPrimaryFire(self:CalculateNextPrimaryFire())
    end

    if ( self.PostPrimaryAttack ) then
        self:PostPrimaryAttack()
    end
end