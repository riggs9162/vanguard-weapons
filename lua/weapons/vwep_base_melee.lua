AddCSLuaFile()

SWEP.Base = "vwep_base" -- Base

-- Information
SWEP.PrintName = "Vanguard Weapon Base" -- Weapon name in the HUD
SWEP.Author = "Riggs" -- Author
SWEP.Instructions = "Left click to shoot, right click to zoom." -- Instructions
SWEP.Category = "Vanguard" -- Category in the spawn menu
SWEP.IsVWEP = true -- Mark this as a Vanguard Weapon Base Weapon, useful for other scripts

-- Weapon settings
SWEP.Slot = 1 -- Slot in the weapon selection menu
SWEP.SlotPos = 1 -- Slot position
SWEP.DrawAmmo = true -- Draw the ammo count
SWEP.DrawCrosshair = true -- Draw the crosshair
SWEP.DrawWeaponInfoBox = false -- Draw the weapon info box

-- Base weapon settings
SWEP.Spawnable = false -- Can be spawned via the Q menu
SWEP.AdminOnly = false -- Admin only spawn

-- Secondary gun settings, unused for now
SWEP.Secondary.ClipSize = -1 -- No secondary clip
SWEP.Secondary.DefaultClip = -1 -- No secondary default clip
SWEP.Secondary.Automatic = false -- Secondary fire automatic?
SWEP.Secondary.Ammo = "none" -- No secondary ammo
SWEP.Secondary.Delay = 0.5 -- Secondary fire delay

-- Weapon settings
SWEP.HoldType = "pistol" -- Weapon hold type
SWEP.UseHands = true -- Use hands model
SWEP.Sensitivity = 1 -- Sensitivity when not aiming

-- Primary gun settings
SWEP.Primary.ClipSize = -1 -- Size of a clip
SWEP.Primary.DefaultClip = -1 -- Default number of bullets in a clip
SWEP.Primary.Automatic = false -- Is this weapon automatic
SWEP.Primary.Ammo = "none" -- Type of ammo

-- Primary fire settings
SWEP.Primary.Recoil = 1 -- Recoil effect
SWEP.Primary.Damage = 10 -- Damage per shot
SWEP.Primary.Delay = 0.5 -- Delay between hits
SWEP.Primary.NextSwing = 0.5 -- Cooldown between swings
SWEP.Primary.Sequence = ACT_VM_HITCENTER -- The swing animation
SWEP.Primary.SequenceHit = ACT_VM_HITCENTER -- The hit animation, optional
SWEP.Primary.PlaybackRate = 1 -- The playback rate of the swing animation
SWEP.Primary.Range = 64 -- The range of the weapon
SWEP.Primary.HullSize = 1 -- The hull size of the weapon
SWEP.Primary.CanMove = true -- Can the player shoot while moving?
SWEP.Primary.CanMoveRun = true -- Can the player shoot while running?
SWEP.Primary.RunSpeed = 0.75 -- Check if the player is marked as running at this speed percentange

-- Primary sound settings
SWEP.Primary.Sound = Sound("Weapon_Pistol.Single") -- Primary fire
SWEP.Primary.SoundLevel = 70 -- Sound level, used for sound distance
SWEP.Primary.SoundPitch = 100 -- Sound pitch
SWEP.Primary.SoundVolume = 1 -- Sound volume
SWEP.Primary.SoundChannel = CHAN_AUTO -- Sound channel

-- Primary sound hit settings
SWEP.Primary.SoundHit = Sound("Flesh.Melee_Hit") -- Sound when hitting flesh
SWEP.Primary.SoundHitWorld = Sound("Weapon_Crowbar.Melee_HitWorld") -- Sound when hitting the world
SWEP.Primary.SoundHitLevel = 70 -- Sound level, used for sound distance
SWEP.Primary.SoundHitPitch = 100 -- Sound pitch
SWEP.Primary.SoundHitVolume = 1 -- Sound volume
SWEP.Primary.SoundHitChannel = CHAN_AUTO -- Sound channel

-- Viewmodel settings
SWEP.ViewModel = "models/weapons/c_pistol.mdl" -- The model used in first-person view
SWEP.ViewModelSkin = 0 -- Viewmodel skin
SWEP.ViewModelBodygroups = {} -- Viewmodel bodygroups
SWEP.ViewModelFOV = 62 -- Viewmodel field of view
SWEP.ViewModelFlip = false -- Flip the viewmodel
SWEP.ViewModelOffset = Vector(0, 0, 0) -- Viewmodel offset
SWEP.ViewModelOffsetAng = Angle(0, 0, 0) -- Viewmodel angle offset
SWEP.ViewModelScale = 1 -- Viewmodel scale
SWEP.ViewModelDynamicLights = {
    --{Pos = Vector(0, 0, 0), Brightness = 1, Size = 1, Decay = 100, Color = Color(255, 255, 255, 255)} -- Example
}

SWEP.ViewModelMaterial = "" -- Viewmodel material
SWEP.ViewModelColor = Color(255, 255, 255, 255) -- Viewmodel color
SWEP.ViewModelRenderMode = RENDERMODE_NORMAL -- Viewmodel render mode
SWEP.ViewModelRenderFX = kRenderFxNone -- Viewmodel render fx

-- Worldmodel settings
SWEP.WorldModel = "models/weapons/w_pistol.mdl" -- The model used in third-person view
SWEP.WorldModelSkin = 0 -- Worldmodel skin
SWEP.WorldModelBodygroups = {} -- Worldmodel bodygroups
SWEP.WorldModelBone = "ValveBiped.Bip01_R_Hand" -- The bone to attach the worldmodel to
SWEP.WorldModelOffset = Vector(0, 0, 0) -- Worldmodel offset
SWEP.WorldModelOffsetAng = Angle(0, 0, 0) -- Worldmodel angle offset
SWEP.WorldModelScale = 1 -- Worldmodel scale
SWEP.WorldModelDynamicLights = {
    --{Pos = Vector(0, 0, 0), Brightness = 1, Size = 1, Decay = 100, Color = Color(255, 255, 255)} -- Example
}

SWEP.WorldModelMaterial = "" -- Worldmodel material
SWEP.WorldModelColor = Color(255, 255, 255, 255) -- Worldmodel color
SWEP.WorldModelRenderMode = RENDERMODE_NORMAL -- Worldmodel render mode
SWEP.WorldModelRenderFX = kRenderFxNone -- Worldmodel render fx

function SWEP:PrimaryAttack()
    if ( !self:CanPrimaryAttack() ) then return end

    local prePrimaryAttack = self.PrePrimaryAttack
    if ( isfunction(prePrimaryAttack) ) then
        if ( prePrimaryAttack(self) == false ) then return end
    end

    if ( self.Primary.Sound ) then
        self:EmitSound(self.Primary.Sound, self.Primary.SoundLevel, self.Primary.SoundPitch, self.Primary.SoundVolume, self.Primary.SoundChannel)
    end

    self:ClubAttack()
    self:ClubEffects()

    local ply = self:GetOwner()
    if ( IsValid(ply) and IsFirstTimePredicted() ) then
        local recoilAngle = self.Primary.RecoilAngle or Angle(-self.Primary.Recoil, math.Rand(-self.Primary.Recoil, self.Primary.Recoil), 0)
        ply:SetEyeAngles(ply:EyeAngles() + Angle(-self.Primary.Recoil, 0, 0))
        ply:ViewPunch(recoilAngle)
    end

    self:SetNextPrimaryFire(CurTime() + self.Primary.NextSwing)

    if ( self.PostPrimaryAttack ) then
        self:PostPrimaryAttack()
    end
end

function SWEP:ClubAttack()
    if ( self.PreClubAttack ) then
        self:PreClubAttack()
    end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local trace = {}
    local hit
    local dmg

    timer.Create("VWEP.ClubAttack." .. self:EntIndex() .. "." .. CurTime(), self.Primary.Delay, 1, function()
        if ( !IsValid(self) or !IsValid(ply) ) then return end


        trace = {}
        trace.start = ply:GetShootPos()
        trace.endpos = trace.start + ply:GetAimVector() * self.Primary.Range
        trace.filter = ply
        trace.mask = MASK_SHOT_HULL
        trace.mins = Vector(-self.Primary.HullSize, -self.Primary.HullSize, -self.Primary.HullSize)
        trace.maxs = Vector(self.Primary.HullSize, self.Primary.HullSize, self.Primary.HullSize)
        
        ply:LagCompensation(true)
        trace = util.TraceHull(trace)
        ply:LagCompensation(false)

        if ( trace.Hit ) then
            hit = trace.Entity

            if ( SERVER ) then
                if ( IsValid(hit) ) then
                    dmg = DamageInfo()
                    dmg:SetAttacker(ply)
                    dmg:SetInflictor(self)
                    dmg:SetDamage(self.Primary.Damage)
                    dmg:SetDamageType(DMG_BULLET)
                    dmg:SetDamagePosition(trace.HitPos)
                    dmg:SetDamageForce(ply:GetAimVector() * 10000)

                    hit:TakeDamageInfo(dmg)
                end
            end
        end

        if ( self.PostClubAttack ) then
            self:PostClubAttack(trace, hit, dmg)
        end
    end)
end

function SWEP:ClubEffects()
    if ( self.PreClubEffects ) then
        self:PreClubEffects()
    end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    self:PlayAnimation(self:GetViewModelShootAnimation(), self.Primary.PlaybackRate)
    self:QueueIdle()

    ply:SetAnimation(PLAYER_ATTACK1)

    timer.Create("VWEP.ClubEffects." .. self:EntIndex() .. "." .. CurTime(), self.Primary.Delay, 1, function()
        if ( !IsValid(self) or !IsValid(ply) ) then return end

        local trace = {}
        trace.start = ply:GetShootPos()
        trace.endpos = trace.start + ply:GetAimVector() * self.Primary.Range
        trace.filter = ply
        trace.mask = MASK_SHOT_HULL
        trace.mins = Vector(-self.Primary.HullSize, -self.Primary.HullSize, -self.Primary.HullSize)
        trace.maxs = Vector(self.Primary.HullSize, self.Primary.HullSize, self.Primary.HullSize)
        trace = util.TraceHull(trace)

        if ( trace.Hit ) then
            local hit = trace.Entity
            if ( IsValid(hit) ) then
                if ( self.Primary.SoundHit ) then
                    local snd = self.Primary.SoundHit
                    local vol = self.Primary.SoundHitVolume
                    local pitch = self.Primary.SoundHitPitch
                    local channel = self.Primary.SoundHitChannel

                    hit:EmitSound(snd, self.Primary.SoundHitLevel, pitch, vol, channel)
                end
            else
                if ( self.Primary.SoundHitWorld ) then
                    local snd = self.Primary.SoundHitWorld
                    local vol = self.Primary.SoundHitVolume
                    local pitch = self.Primary.SoundHitPitch
                    local channel = self.Primary.SoundHitChannel

                    ply:EmitSound(snd, self.Primary.SoundHitLevel, pitch, vol, channel)
                end
            end

            if ( SERVER ) then
                local trace = {}
                trace.start = ply:GetShootPos()
                trace.endpos = trace.start + ply:GetAimVector() * 8192
                trace.filter = ply
                trace.mask = MASK_SHOT
                trace = util.TraceLine(trace)

                if ( trace.HitPos:Distance(trace.StartPos) < self.Primary.Range ) then
                    local bullet = {}
                    bullet.Num = 1
                    bullet.Src = ply:GetShootPos()
                    bullet.Dir = ply:GetAimVector()
                    bullet.Spread = Vector(0, 0, 0)
                    bullet.Tracer = 0
                    bullet.Force = 1
                    bullet.Damage = 0
                    bullet.Attacker = ply

                    ply:FireBullets(bullet)
                end

                debugoverlay.Line(trace.StartPos, trace.HitPos, 5, Color(255, 0, 0), true)
            end
        else
            if ( self.Primary.SoundHitMiss ) then
                local snd = self.Primary.SoundHitMiss
                local vol = self.Primary.SoundHitVolume
                local pitch = self.Primary.SoundHitPitch
                local channel = self.Primary.SoundHitChannel

                ply:EmitSound(snd, self.Primary.SoundHitLevel, pitch, vol, channel)
            end
        end
    end)

    if ( self.PostClubEffects ) then
        self:PostClubEffects()
    end
end

function SWEP:GetViewModelShootAnimation()
    local shootSequence = self.Primary.Sequence or ACT_VM_HITCENTER

    local trace = {}
    trace.start = self:GetOwner():GetShootPos()
    trace.endpos = trace.start + self:GetOwner():GetAimVector() * self.Primary.Range
    trace.filter = self:GetOwner()
    trace.mask = MASK_SHOT_HULL
    trace.mins = Vector(-self.Primary.HullSize, -self.Primary.HullSize, -self.Primary.HullSize)
    trace.maxs = Vector(self.Primary.HullSize, self.Primary.HullSize, self.Primary.HullSize)
    trace = util.TraceHull(trace)

    if ( trace.Hit and self.Primary.SequenceHit ) then
        shootSequence = self.Primary.SequenceHit or ACT_VM_HITCENTER
    end

    if ( isfunction(shootSequence) ) then
        shootSequence = shootSequence(self)
    elseif ( istable(shootSequence) ) then
        shootSequence = shootSequence[math.random(#shootSequence)]
    end

    return shootSequence
end

function SWEP:SecondaryAttack()
    if ( !self:CanSecondaryAttack() ) then return end

    if ( self.PreSecondaryAttack ) then
        self:PreSecondaryAttack()
    end

    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

    if ( self.PostSecondaryAttack ) then
        self:PostSecondaryAttack()
    end
end

function SWEP:CanIronSight()
    return false
end

function SWEP:CanPrimaryAttack()
    if ( self:GetNextPrimaryFire() > CurTime() ) then return false end

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

    if ( self.CanPrimaryAttackOverride ) then
        local ply = self:GetOwner()
        if ( !IsValid(ply) ) then return false end

        return self:CanPrimaryAttackOverride(ply)
    end

    return true
end

function SWEP:CanSecondaryAttack()
    if ( self:GetNextSecondaryFire() > CurTime() ) then return false end

    if ( self.CanSecondaryAttackOverride ) then
        local ply = self:GetOwner()
        if ( !IsValid(ply) ) then return false end

        return self:CanSecondaryAttackOverride(ply)
    end

    return true
end

function SWEP:CanReload()
    return false
end

function SWEP:ThinkIdle()
    if ( !self:GetNextIdle() ) then
        self:SetNextIdle(0)
    end

    if ( self:GetNextIdle() <= 0 ) then return end

    if ( CurTime() > self:GetNextIdle() ) then
        self:SetNextIdle(0)
        self:PlayAnimation(self.IdleAnim or ACT_VM_IDLE, self.IdlePlaybackRate or 1)
    end
end

function SWEP:ThinkWalking()
    if ( CLIENT or !self.Walking or !self.Walking.Enabled ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local sequenceEnter = self.Walking.SequenceEnter
    local sequenceLoop = self.Walking.SequenceLoop
    local sequenceExit = self.Walking.SequenceExit

    local walking = !ply:KeyDown(IN_SPEED) and ply:GetVelocity():LengthSqr() > self.IronSightsRunSpeed ^ 2
    if ( walking and !self:GetWalking() ) then
        self:SetWalking(true)

        if ( sequenceEnter ) then
            local _, duration = self:PlayAnimation(sequenceEnter, self.Walking.PlaybackRate)
            self:QueueIdle(duration)
            self:SetWalkingWait(CurTime() + duration)
        else
            self:QueueIdle(0)
            self:SetWalkingWait(0)
        end
    elseif ( !walking and self:GetWalking() ) then
        self:SetWalking(false)

        if ( sequenceExit ) then
            local _, duration = self:PlayAnimation(sequenceExit, self.Walking.PlaybackRate)
            self:QueueIdle(duration)
            self:SetWalkingWait(CurTime() + duration)
        else
            self:QueueIdle(0)
            self:SetWalkingWait(0)
        end
    elseif ( walking and self:GetWalking() and sequenceLoop and CurTime() > self:GetWalkingWait() ) then
        local _, duration = self:PlayAnimation(sequenceLoop, self.Walking.PlaybackRate)
        self:QueueIdle()
        self:SetWalkingWait(CurTime() + duration)
    end
end

function SWEP:ThinkRunning()
    if ( CLIENT or !self.Running or !self.Running.Enabled ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local sequenceEnter = self.Running.SequenceEnter
    local sequenceLoop = self.Running.SequenceLoop
    local sequenceExit = self.Running.SequenceExit

    local running = ply:KeyDown(IN_SPEED) and ply:GetVelocity():LengthSqr() > self.IronSightsRunSpeed ^ 2
    if ( running and !self:GetRunning() ) then
        self:SetRunning(true)

        if ( sequenceEnter ) then
            local _, duration = self:PlayAnimation(sequenceEnter, self.Running.PlaybackRate)
            self:QueueIdle(duration)
            self:SetRunningWait(CurTime() + duration)
        else
            self:QueueIdle(0)
            self:SetRunningWait(0)
        end
    elseif ( !running and self:GetRunning() ) then
        self:SetRunning(false)

        if ( sequenceExit ) then
            local _, duration = self:PlayAnimation(sequenceExit, self.Running.PlaybackRate)
            self:QueueIdle(duration)
            self:SetRunningWait(CurTime() + duration)
        else
            self:QueueIdle(0)
            self:SetRunningWait(0)
        end
    elseif ( running and self:GetRunning() and sequenceLoop and CurTime() > self:GetRunningWait() ) then
        local _, duration = self:PlayAnimation(sequenceLoop, self.Running.PlaybackRate)
        self:QueueIdle()
        self:SetRunningWait(CurTime() + duration)
    end
end

function SWEP:Think()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    self:ThinkIdle()
    self:ThinkWalking()
    self:ThinkRunning()
end