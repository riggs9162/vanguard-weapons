VWEP = SWEP

vanguard.util:IncludeDir("weapons/vwep_base/core")

-- Information
VWEP.PrintName = "Vanguard Weapon Base" -- Weapon name in the HUD
VWEP.Author = "Riggs" -- Author
VWEP.Instructions = "Left click to shoot, right click to zoom." -- Instructions
VWEP.Category = "Vanguard" -- Category in the spawn menu
VWEP.IsVWEP = true -- Mark this as a Vanguard Weapon Base Weapon, useful for other scripts

-- Weapon settings
VWEP.Slot = 1 -- Slot in the weapon selection menu
VWEP.SlotPos = 1 -- Slot position
VWEP.DrawAmmo = true -- Draw the ammo count
VWEP.DrawCrosshair = true -- Draw the crosshair
VWEP.DrawWeaponInfoBox = false -- Draw the weapon info box

-- Base weapon settings
VWEP.Spawnable = false -- Can be spawned via the Q menu
VWEP.AdminOnly = false -- Admin only spawn

-- Secondary gun settings, unused for now
VWEP.Secondary.ClipSize = -1 -- No secondary clip
VWEP.Secondary.DefaultClip = -1 -- No secondary default clip
VWEP.Secondary.Automatic = false -- Secondary fire automatic?
VWEP.Secondary.Ammo = "none" -- No secondary ammo
VWEP.Secondary.Delay = 0.5 -- Secondary fire delay

-- Weapon settings
VWEP.HoldType = "pistol" -- Weapon hold type
VWEP.UseHands = true -- Use hands model
VWEP.Sensitivity = 1 -- Sensitivity when not aiming

-- Primary gun settings
VWEP.Primary.ClipSize = 18 -- Size of a clip
VWEP.Primary.DefaultClip = 18 -- Default number of bullets in a clip
VWEP.Primary.Automatic = false -- Is this weapon automatic
VWEP.Primary.Ammo = "Pistol" -- Type of ammo

-- Primary fire settings
VWEP.Primary.Recoil = 1 -- Recoil effect
VWEP.Primary.Damage = 10 -- Damage per shot
VWEP.Primary.NumShots = 1 -- Number of shots per trigger pull
VWEP.Primary.Cone = 0.02 -- Bullet spread
VWEP.Primary.Delay = 0.5 -- Delay between shots
VWEP.Primary.RPM = 400 -- Rounds per minute, this is used instead of delay if it's set
VWEP.Primary.Sequence = ACT_VM_PRIMARYATTACK -- The shoot animation
VWEP.Primary.SequenceIronSights = ACT_VM_PRIMARYATTACK -- The shoot animation when iron sighting
VWEP.Primary.PlaybackRate = 1 -- The playback rate of the shoot animation
VWEP.Primary.BurstCount = 0 -- Number of shots per burst, 0 for no burst
VWEP.Primary.BurstDelay = 0.2 -- Delay between waves of a burst
VWEP.Primary.CanMove = true -- Can the player shoot while moving?
VWEP.Primary.CanMoveRun = true -- Can the player shoot while running?
VWEP.Primary.RunSpeed = 0.75 -- Check if the player is marked as running at this speed percentange

-- Primary fire event settings, this can be used to play sounds or other effects at certain times during the shoot sequence.
/*
VWEP.Primary.Events = {
    -- Example
    {Time = 0, Function = function(self)
        -- Play a sound 0 seconds into the shoot with the level of 100, pitch of 100, volume of 1 and channel of CHAN_WEAPON
        self:EmitSound("Weapon_Pistol.NPC_Single", 100, 100, 1, CHAN_WEAPON)
    end},
}
*/

-- Primary sound settings
VWEP.Primary.Sound = Sound("Weapon_Pistol.Single") -- Primary fire
VWEP.Primary.SoundEmpty = Sound("Weapon_Pistol.Empty") -- Primary fire when empty
VWEP.Primary.SoundLevel = 100 -- Sound level, used for sound distance
VWEP.Primary.SoundPitch = 100 -- Sound pitch
VWEP.Primary.SoundVolume = 1 -- Sound volume
VWEP.Primary.SoundChannel = CHAN_WEAPON -- Sound channel

-- Iron sights settings
VWEP.IronSightsEnabled = true -- Enable iron sights
VWEP.IronSightsPos = Vector(-5.95, -9.2, 2.7) -- Iron sights position
VWEP.IronSightsAng = Vector(2.6, 1.37, 3.5) -- Iron sights angle
VWEP.IronSightsFOV = 0.75 -- Iron sights field of view
VWEP.IronSightsSensitivity = 0.5 -- Iron sights sensitivity
VWEP.IronSightsCanMove = true -- Can the player iron sight while moving?
VWEP.IronSightsCanMoveRun = false -- Can the player iron sight while running?
VWEP.IronSightsRunSpeed = 0.75 -- Check if the player is marked as running at this speed percentange
VWEP.IronSightsToggle = false -- Is the iron sight a toggle mechanism, mark as false if it's a hold mechanism

-- Iron sights enter sound settings
VWEP.IronSightsEnterSound = Sound("weapons/zoom.wav") -- Iron sights enter sound
VWEP.IronSightsEnterSoundLevel = 60 -- Iron sights enter sound level, used for sound distance
VWEP.IronSightsEnterSoundPitch = 100 -- Iron sights enter sound pitch
VWEP.IronSightsEnterSoundVolume = 1 -- Iron sights enter sound volume
VWEP.IronSightsEnterSoundChannel = CHAN_ITEM -- Iron sights enter sound channel

-- Iron sights exit sound settings
VWEP.IronSightsExitSound = Sound("weapons/zoom.wav") -- Iron sights exit sound
VWEP.IronSightsExitSoundLevel = 60 -- Iron sights exit sound level, used for sound distance
VWEP.IronSightsExitSoundPitch = 100 -- Iron sights exit sound pitch
VWEP.IronSightsExitSoundVolume = 1 -- Iron sights exit sound volume
VWEP.IronSightsExitSoundChannel = CHAN_ITEM -- Iron sights exit sound channel

-- Reloading settings
VWEP.Reloading = {}
VWEP.Reloading.Sequence = ACT_VM_RELOAD -- The reload animation
VWEP.Reloading.SequenceIronSights = ACT_VM_RELOAD -- The reload animation when iron sighting
VWEP.Reloading.PlaybackRate = 1 -- The playback rate of the reload animation
VWEP.Reloading.Sound = Sound("Weapon_Pistol.Reload") -- The reload sound
VWEP.Reloading.SoundLevel = 60 -- The reload sound level, used for sound distance
VWEP.Reloading.SoundPitch = 100 -- The reload sound pitch
VWEP.Reloading.SoundVolume = 1 -- The reload sound volume
VWEP.Reloading.SoundChannel = CHAN_WEAPON -- The reload sound channel

-- Reloading event settings, some weapons have custom events for reloading.
-- This only works for the base reloading system and not for cycling.
/*
VWEP.Reloading.Events = {
    -- Example
    {Time = 0.5, Function = function(self)
        -- Play a sound 0.5 seconds into the reload with the level of 60, pitch of 100, volume of 1 and channel of CHAN_ITEM
        self:EmitSound("Weapon_Pistol.ClipOut", 60, 100, 1, CHAN_ITEM)
    end},
}
*/

-- Cycling settings
VWEP.Cycling = {}
VWEP.Cycling.Enabled = false -- Enable cycling
VWEP.Cycling.Ammo = 1 -- The ammo to give when cycling
VWEP.Cycling.SequenceEntry = nil -- The cycling entry animation
VWEP.Cycling.Sequence = ACT_VM_RELOAD -- The cycling animation
VWEP.Cycling.SequenceExit = nil -- The cycling exit animation
VWEP.Cycling.SequenceIronSightsEntry = nil -- The cycling entry animation when iron sighting
VWEP.Cycling.SequenceIronSights = ACT_VM_RELOAD -- The cycling animation when iron sighting
VWEP.Cycling.SequenceIronSightsExit = nil -- The cycling exit animation when iron sighting
VWEP.Cycling.PlaybackRate = 1 -- The playback rate of the cycling animation
VWEP.Cycling.Sound = Sound("Weapon_Pistol.Reload") -- The cycling sound
VWEP.Cycling.SoundLevel = 60 -- The cycling sound level, used for sound distance
VWEP.Cycling.SoundPitch = 100 -- The cycling sound pitch
VWEP.Cycling.SoundVolume = 1 -- The cycling sound volume
VWEP.Cycling.SoundChannel = CHAN_ITEM -- The cycling sound channel
VWEP.Cycling.Delay = 0.5 -- The delay between cycling
VWEP.Cycling.Automatic = false -- Is the cycling automatic?

-- Pump action settings
VWEP.PumpAction = {}
VWEP.PumpAction.Enabled = false -- Enable pump action
VWEP.PumpAction.Sequence = ACT_SHOTGUN_PUMP -- The pump action animation
VWEP.PumpAction.SequenceIronSights = ACT_SHOTGUN_PUMP -- The pump action animation when iron sighting
VWEP.PumpAction.PlaybackRate = 1 -- The playback rate of the pump action animation
VWEP.PumpAction.Sound = Sound("Weapon_Shotgun.Special1") -- The pump action sound
VWEP.PumpAction.SoundLevel = 60 -- The pump action sound level, used for sound distance
VWEP.PumpAction.SoundPitch = 100 -- The pump action sound pitch
VWEP.PumpAction.SoundVolume = 1 -- The pump action sound volume
VWEP.PumpAction.SoundChannel = CHAN_ITEM -- The pump action sound channel

-- Viewmodel settings
VWEP.ViewModel = "models/weapons/c_pistol.mdl" -- The model used in first-person view
VWEP.ViewModelSkin = 0 -- Viewmodel skin
VWEP.ViewModelBodygroups = {} -- Viewmodel bodygroups
VWEP.ViewModelFOV = 62 -- Viewmodel field of view
VWEP.ViewModelFlip = false -- Flip the viewmodel
VWEP.ViewModelOffset = Vector(0, 0, 0) -- Viewmodel offset
VWEP.ViewModelOffsetAng = Angle(0, 0, 0) -- Viewmodel angle offset
VWEP.ViewModelScale = 1 -- Viewmodel scale
VWEP.ViewModelDynamicLights = {
    --{Pos = Vector(0, 0, 0), Brightness = 1, Size = 1, Decay = 100, Color = Color(255, 255, 255, 255)} -- Example
}

VWEP.ViewModelMaterial = "" -- Viewmodel material
VWEP.ViewModelColor = Color(255, 255, 255, 255) -- Viewmodel color
VWEP.ViewModelRenderMode = RENDERMODE_NORMAL -- Viewmodel render mode
VWEP.ViewModelRenderFX = kRenderFxNone -- Viewmodel render fx

-- Worldmodel settings
VWEP.WorldModel = "models/weapons/w_pistol.mdl" -- The model used in third-person view
VWEP.WorldModelSkin = 0 -- Worldmodel skin
VWEP.WorldModelBodygroups = {} -- Worldmodel bodygroups
VWEP.WorldModelBone = "ValveBiped.Bip01_R_Hand" -- The bone to attach the worldmodel to
VWEP.WorldModelOffset = Vector(0, 0, 0) -- Worldmodel offset
VWEP.WorldModelOffsetAng = Angle(0, 0, 0) -- Worldmodel angle offset
VWEP.WorldModelScale = 1 -- Worldmodel scale
VWEP.WorldModelDynamicLights = {
    --{Pos = Vector(0, 0, 0), Brightness = 1, Size = 1, Decay = 100, Color = Color(255, 255, 255)} -- Example
}

VWEP.WorldModelMaterial = "" -- Worldmodel material
VWEP.WorldModelColor = Color(255, 255, 255, 255) -- Worldmodel color
VWEP.WorldModelRenderMode = RENDERMODE_NORMAL -- Worldmodel render mode
VWEP.WorldModelRenderFX = kRenderFxNone -- Worldmodel render fx

-- Walking animation settings
-- VWEP.Walking = {}
-- VWEP.Walking.Enabled = false -- Enable walking animations
-- VWEP.Walking.PlaybackRate = 1 -- The playback rate of the walking animations
-- VWEP.Walking.SequenceEnter = "walk_enter" -- The walking enter animation
-- VWEP.Walking.SequenceLoop = "walk" -- The walking loop animation
-- VWEP.Walking.SequenceExit = "walk_exit" -- The walking exit animation
-- VWEP.Walking.SequenceEmptyEnter = "walk_empty_enter" -- The walking enter animation when empty
-- VWEP.Walking.SequenceEmptyLoop = "walk_empty" -- The walking loop animation when empty
-- VWEP.Walking.SequenceEmptyExit = "walk_empty_exit" -- The walking exit animation when empty

-- HL2 Pistol Example
-- VWEP.Walking.Enabled = true -- Enable walking animations
-- VWEP.Walking.PlaybackRate = 1 -- The playback rate of the walking animations
-- VWEP.Walking.SequenceEnter = "idletolow" -- The walking enter animation
-- VWEP.Walking.SequenceLoop = "lowidle" -- The walking loop animation
-- VWEP.Walking.SequenceExit = "lowtoidle" -- The walking exit animation
-- VWEP.Walking.SequenceEmptyEnter = "idletolow" -- The walking enter animation when empty
-- VWEP.Walking.SequenceEmptyLoop = "lowidle" -- The walking loop animation when empty
-- VWEP.Walking.SequenceEmptyExit = "lowtoidle" -- The walking exit animation when empty

-- Running animation settings
-- VWEP.Running = {}
-- VWEP.Running.Enabled = false -- Enable running animations
-- VWEP.Running.PlaybackRate = 1 -- The playback rate of the running animations
-- VWEP.Running.SequenceEnter = "run_enter" -- The running enter animation
-- VWEP.Running.SequenceLoop = "run" -- The running loop animation
-- VWEP.Running.SequenceExit = "run_exit" -- The running exit animation
-- VWEP.Running.SequenceEmptyEnter = "run_empty_enter" -- The running enter animation when empty
-- VWEP.Running.SequenceEmptyLoop = "run_empty" -- The running loop animation when empty
-- VWEP.Running.SequenceEmptyExit = "run_empty_exit" -- The running exit animation when empty

-- HL2 Pistol Example
-- VWEP.Running.Enabled = true -- Enable running animations
-- VWEP.Running.PlaybackRate = 1 -- The playback rate of the running animations
-- VWEP.Running.SequenceEnter = "idletolow" -- The running enter animation
-- VWEP.Running.SequenceLoop = "lowidle" -- The running loop animation
-- VWEP.Running.SequenceExit = "lowtoidle" -- The running exit animation
-- VWEP.Running.SequenceEmptyEnter = "idletolow" -- The running enter animation when empty
-- VWEP.Running.SequenceEmptyLoop = "lowidle" -- The running loop animation when empty
-- VWEP.Running.SequenceEmptyExit = "lowtoidle" -- The running exit animation when empty

-- Weapon effects
VWEP.Effects = {}
VWEP.Effects.MuzzleFlash = true -- Enable muzzle flash
VWEP.Effects.MuzzleFlashEffect = "MuzzleFlash" -- Muzzle flash effect
VWEP.Effects.MuzzleFlashFlags = 1 -- Muzzle flash flags
VWEP.Effects.MuzzleFlashScale = 1 -- Muzzle flash scale
VWEP.Effects.MuzzleFlashAttachment = "muzzle" -- Muzzle flash attachment

VWEP.Effects.Tracer = true -- Enable tracer
VWEP.Effects.TracerEffect = "Tracer" -- Tracer effect
VWEP.Effects.TracerScale = 1 -- Tracer scale
VWEP.Effects.TracerAttachment = "muzzle" -- Tracer attachment

VWEP.FireModes = {}
VWEP.FireModes.Enabled = false -- Enable fire modes
VWEP.FireModes.Sound = Sound("buttons/lever7.wav") -- The fire mode switch sound
VWEP.FireModes.SoundLevel = 60 -- The fire mode switch sound level, used for sound distance
VWEP.FireModes.SoundPitch = 140 -- The fire mode switch sound pitch
VWEP.FireModes.SoundVolume = 1 -- The fire mode switch sound volume
VWEP.FireModes.SoundChannel = CHAN_ITEM -- The fire mode switch sound channel
VWEP.FireModes.SoundDelay = 0.5 -- The fire mode switch sound delay
VWEP.FireModes.Delay = 0.5 -- The fire mode switch delay
VWEP.FireModes.List = {"auto", "burst", "single"}
VWEP.FireModes.Settings = {
    auto = {
        Automatic = true,
        BurstCount = 0
    },
    burst = {
        Automatic = true,
        BurstCount = 3
    },
    single = {
        Automatic = false,
        BurstCount = 0
    }
}

function VWEP:SetupDataTables()
    if ( self.PreSetupDataTables ) then
        self:PreSetupDataTables()
    end

    self:NetworkVar("Bool", 0, "IronSights")
    self:NetworkVarNotify("IronSights", function(name, old, new)
        self:OnIronSightsChanged(name, old, new)

        if ( CLIENT ) then
            if ( new ) then
                local sound = self.IronSightsEnterSound
                if ( sound ) then
                    self:EmitSound(sound, self.IronSightsEnterSoundLevel or 60, self.IronSightsEnterSoundPitch or 100, self.IronSightsEnterSoundVolume or 1, self.IronSightsEnterSoundChannel or CHAN_ITEM)
                end
            else
                local sound = self.IronSightsExitSound
                if ( sound ) then
                    self:EmitSound(sound, self.IronSightsExitSoundLevel or 60, self.IronSightsExitSoundPitch or 100, self.IronSightsExitSoundVolume or 1, self.IronSightsExitSoundChannel or CHAN_ITEM)
                end
            end
        end

        self:QueueIdle(0)
    end)

    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Bool", 2, "Walking")
    self:NetworkVarNotify("Walking", function(name, old, new)
        self:QueueIdle(0)
        self:SetRunningWait(0)
    end)

    self:NetworkVar("Bool", 3, "Running")
    self:NetworkVarNotify("Running", function(name, old, new)
        self:QueueIdle(0)
        self:SetWalkingWait(0)
    end)

    self:NetworkVar("Bool", 4, "Cycling")

    self:NetworkVar("Float", 0, "NextIdle")
    self:NetworkVar("Int", 0, "FireMode")
    self:NetworkVar("Int", 1, "BurstCount")
    self:NetworkVar("Float", 1, "WalkingWait")
    self:NetworkVar("Float", 2, "RunningWait")
    self:NetworkVar("Float", 3, "CyclingWait")

    if ( self.PostSetupDataTables ) then
        self:PostSetupDataTables()
    end
end

function VWEP:OnIronSightsChanged(name, old, new)
    -- Override this function to do something when the iron sights state changes
end

function VWEP:Initialize()
    if ( self.PreInitialize ) then
        self:PreInitialize()
    end

    self:SetWeaponHoldType(self.HoldType)
    self:SetFireMode(1)
    self:SetRunning(false)
    self:SetRunningWait(0)

    if ( self.PostInitialize ) then
        self:PostInitialize()
    end
end

function VWEP:QueueIdle(duration)
    local vm = self:GetOwner().GetViewModel and self:GetOwner():GetViewModel() or nil
    if ( !IsValid(vm) ) then return end

    duration = duration or vm:SequenceDuration() / vm:GetPlaybackRate()
    duration = math.Round(duration, 2)

    self:SetNextIdle(CurTime() + duration)
end

function VWEP:SecondaryAttack()
    if ( !IsFirstTimePredicted() ) then return end
    if ( !self:CanSecondaryAttack() ) then return end

    if ( self.PreSecondaryAttack ) then
        self:PreSecondaryAttack()
    end

    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

    if ( self.PostSecondaryAttack ) then
        self:PostSecondaryAttack()
    end
end

function VWEP:ThinkIdle()
    if ( !self:GetNextIdle() ) then
        self:SetNextIdle(0)
    end

    if ( self:GetNextIdle() <= 0 ) then return end

    if ( CurTime() > self:GetNextIdle() ) then
        self:SetNextIdle(0)

        local clip = self:Clip1()
        local animIdle = self.IdleAnim or ACT_VM_IDLE
        local animEmpty = self.EmptyAnim or ACT_VM_IDLE_EMPTY
        local animIdleIronSights = self.IdleAnimIronSights or ACT_VM_IDLE
        local animEmptyIronSights = self.EmptyAnimIronSights or ACT_VM_IDLE_EMPTY
        local anim = clip > 0 and animIdle or animEmpty
        if ( self:GetIronSights() ) then
            anim = clip > 0 and animIdleIronSights or animEmptyIronSights
        end

        self:PlayAnimation(anim)
    end
end

function VWEP:ThinkWalking()
    if ( CLIENT or !self.Walking or !self.Walking.Enabled ) then return end
    if ( self:GetCycling() or self:GetReloading() ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local clip = self:Clip1()
    local empty = clip <= 0
    local sequenceEnterEmpty = self.Walking.SequenceEmptyEnter
    local sequenceLoopEmpty = self.Walking.SequenceEmptyLoop
    local sequenceExitEmpty = self.Walking.SequenceEmptyExit
    local sequenceEnter = self.Walking.SequenceEnter
    local sequenceLoop = self.Walking.SequenceLoop
    local sequenceExit = self.Walking.SequenceExit

    if ( empty and sequenceEnterEmpty and !sequenceLoopEmpty ) then
        sequenceLoopEmpty = sequenceEnterEmpty
    end

    if ( empty and sequenceLoopEmpty and !sequenceEnterEmpty ) then
        sequenceEnterEmpty = sequenceLoopEmpty
    end

    if ( empty and sequenceExitEmpty and !sequenceEnterEmpty ) then
        sequenceEnterEmpty = sequenceExitEmpty
    end

    if ( empty and sequenceExitEmpty and !sequenceLoopEmpty ) then
        sequenceLoopEmpty = sequenceExitEmpty
    end

    if ( !empty and sequenceEnter and !sequenceLoop ) then
        sequenceLoop = sequenceEnter
    end

    if ( !empty and sequenceLoop and !sequenceEnter ) then
        sequenceEnter = sequenceLoop
    end

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

function VWEP:ThinkRunning()
    if ( CLIENT or !self.Running or !self.Running.Enabled ) then return end
    if ( self:GetCycling() or self:GetReloading() ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local clip = self:Clip1()
    local empty = clip <= 0
    local sequenceEnterEmpty = self.Running.SequenceEmptyEnter
    local sequenceLoopEmpty = self.Running.SequenceEmptyLoop
    local sequenceExitEmpty = self.Running.SequenceEmptyExit
    local sequenceEnter = self.Running.SequenceEnter
    local sequenceLoop = self.Running.SequenceLoop
    local sequenceExit = self.Running.SequenceExit

    if ( empty and sequenceEnterEmpty and !sequenceLoopEmpty ) then
        sequenceLoopEmpty = sequenceEnterEmpty
    end

    if ( empty and sequenceLoopEmpty and !sequenceEnterEmpty ) then
        sequenceEnterEmpty = sequenceLoopEmpty
    end

    if ( empty and sequenceExitEmpty and !sequenceEnterEmpty ) then
        sequenceEnterEmpty = sequenceExitEmpty
    end

    if ( empty and sequenceExitEmpty and !sequenceLoopEmpty ) then
        sequenceLoopEmpty = sequenceExitEmpty
    end

    if ( !empty and sequenceEnter and !sequenceLoop ) then
        sequenceLoop = sequenceEnter
    end

    if ( !empty and sequenceLoop and !sequenceEnter ) then
        sequenceEnter = sequenceLoop
    end

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

function VWEP:Think()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    self:ThinkIdle()
    self:ThinkWalking()
    self:ThinkRunning()
    self:ThinkIronSights()
    self:ThinkFireModes()
    self:ThinkCycling()
end

function VWEP:Deploy()
    if ( self.PreDeploy ) then
        self:PreDeploy()
    end

    self:SetIronSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)

    self:PlayAnimation(self.DeployAnim or ACT_VM_DRAW)
    self:QueueIdle()

    if ( self.PostDeploy ) then
        self:PostDeploy()
    end

    return true
end

function VWEP:Holster()
    if ( self.PreHolster ) then
        self:PreHolster()
    end

    self:SetIronSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)

    -- We might've set the viewmodel material to something else, so we need to reset it
    if ( CLIENT ) then
        timer.Simple(0, function()
            if ( IsValid(self) and IsValid(self:GetOwner()) ) then
                local vm = self:GetOwner().GetViewModel and self:GetOwner():GetViewModel() or nil
                if ( IsValid(vm) ) then
                    vm:SetMaterial("")
                end
            end
        end)
    end

    if ( self.PostHolster ) then
        self:PostHolster()
    end

    return true
end