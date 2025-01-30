vanguard.util:IncludeDir("weapons/vwep_base/core")

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
SWEP.Primary.ClipSize = 18 -- Size of a clip
SWEP.Primary.DefaultClip = 18 -- Default number of bullets in a clip
SWEP.Primary.Automatic = false -- Is this weapon automatic
SWEP.Primary.Ammo = "Pistol" -- Type of ammo

-- Primary fire settings
SWEP.Primary.Recoil = 1 -- Recoil effect
SWEP.Primary.Damage = 10 -- Damage per shot
SWEP.Primary.NumShots = 1 -- Number of shots per trigger pull
SWEP.Primary.Cone = 0.02 -- Bullet spread
SWEP.Primary.Delay = 0.5 -- Delay between shots
SWEP.Primary.RPM = 400 -- Rounds per minute, this is used instead of delay if it's set
SWEP.Primary.Sequence = ACT_VM_PRIMARYATTACK -- The shoot animation
SWEP.Primary.SequenceIronSights = ACT_VM_PRIMARYATTACK -- The shoot animation when iron sighting
SWEP.Primary.PlaybackRate = 1 -- The playback rate of the shoot animation
SWEP.Primary.BurstCount = 0 -- Number of shots per burst, 0 for no burst
SWEP.Primary.BurstDelay = 0.2 -- Delay between waves of a burst
SWEP.Primary.CanMove = true -- Can the player shoot while moving?
SWEP.Primary.CanMoveRun = true -- Can the player shoot while running?
SWEP.Primary.RunSpeed = 0.75 -- Check if the player is marked as running at this speed percentange

-- Primary fire event settings, this can be used to play sounds or other effects at certain times during the shoot sequence.
/*
SWEP.Primary.Events = {
    -- Example
    {Time = 0, Function = function(self)
        -- Play a sound 0 seconds into the shoot with the level of 100, pitch of 100, volume of 1 and channel of CHAN_WEAPON
        self:EmitSound("Weapon_Pistol.NPC_Single", 100, 100, 1, CHAN_WEAPON)
    end},
}
*/

-- Primary sound settings
SWEP.Primary.Sound = Sound("Weapon_Pistol.Single") -- Primary fire
SWEP.Primary.SoundEmpty = Sound("Weapon_Pistol.Empty") -- Primary fire when empty
SWEP.Primary.SoundLevel = 100 -- Sound level, used for sound distance
SWEP.Primary.SoundPitch = 100 -- Sound pitch
SWEP.Primary.SoundVolume = 1 -- Sound volume
SWEP.Primary.SoundChannel = CHAN_WEAPON -- Sound channel

-- Iron sights settings
SWEP.IronSightsEnabled = true -- Enable iron sights
SWEP.IronSightsPos = Vector(-5.95, -9.2, 2.7) -- Iron sights position
SWEP.IronSightsAng = Vector(2.6, 1.37, 3.5) -- Iron sights angle
SWEP.IronSightsFOV = 0.75 -- Iron sights field of view
SWEP.IronSightsSensitivity = 0.5 -- Iron sights sensitivity
SWEP.IronSightsCanMove = true -- Can the player iron sight while moving?
SWEP.IronSightsCanMoveRun = false -- Can the player iron sight while running?
SWEP.IronSightsRunSpeed = 0.75 -- Check if the player is marked as running at this speed percentange
SWEP.IronSightsToggle = false -- Is the iron sight a toggle mechanism, mark as false if it's a hold mechanism

-- Iron sights enter sound settings
-- SWEP.IronSightsEnterSound = Sound("weapons/zoom.wav") -- Iron sights enter sound
-- SWEP.IronSightsEnterSoundLevel = 60 -- Iron sights enter sound level, used for sound distance
-- SWEP.IronSightsEnterSoundPitch = 100 -- Iron sights enter sound pitch
-- SWEP.IronSightsEnterSoundVolume = 1 -- Iron sights enter sound volume
-- SWEP.IronSightsEnterSoundChannel = CHAN_ITEM -- Iron sights enter sound channel

-- Iron sights exit sound settings
-- SWEP.IronSightsExitSound = Sound("weapons/zoom.wav") -- Iron sights exit sound
-- SWEP.IronSightsExitSoundLevel = 60 -- Iron sights exit sound level, used for sound distance
-- SWEP.IronSightsExitSoundPitch = 100 -- Iron sights exit sound pitch
-- SWEP.IronSightsExitSoundVolume = 1 -- Iron sights exit sound volume
-- SWEP.IronSightsExitSoundChannel = CHAN_ITEM -- Iron sights exit sound channel

-- Reloading settings
SWEP.Reloading = {}
SWEP.Reloading.Sequence = ACT_VM_RELOAD -- The reload animation
SWEP.Reloading.SequenceIronSights = ACT_VM_RELOAD -- The reload animation when iron sighting
SWEP.Reloading.PlaybackRate = 1 -- The playback rate of the reload animation
SWEP.Reloading.Sound = Sound("Weapon_Pistol.Reload") -- The reload sound
SWEP.Reloading.SoundLevel = 60 -- The reload sound level, used for sound distance
SWEP.Reloading.SoundPitch = 100 -- The reload sound pitch
SWEP.Reloading.SoundVolume = 1 -- The reload sound volume
SWEP.Reloading.SoundChannel = CHAN_WEAPON -- The reload sound channel

-- Reloading event settings, some weapons have custom events for reloading.
-- This only works for the base reloading system and not for cycling.
/*
SWEP.Reloading.Events = {
    -- Example
    {Time = 0.5, TimeEmpty = 0.6, Function = function(self)
        -- Play a sound 0.5 seconds into the reload with the level of 60, pitch of 100, volume of 1 and channel of CHAN_ITEM
        self:EmitSound("Weapon_Pistol.ClipOut", 60, 100, 1, CHAN_ITEM)
    end},
}
*/

-- Cycling settings
SWEP.Cycling = {}
SWEP.Cycling.Enabled = false -- Enable cycling
SWEP.Cycling.Ammo = 1 -- The ammo to give when cycling
SWEP.Cycling.SequenceEntry = nil -- The cycling entry animation
SWEP.Cycling.Sequence = ACT_VM_RELOAD -- The cycling animation
SWEP.Cycling.SequenceExit = nil -- The cycling exit animation
SWEP.Cycling.SequenceIronSightsEntry = nil -- The cycling entry animation when iron sighting
SWEP.Cycling.SequenceIronSights = ACT_VM_RELOAD -- The cycling animation when iron sighting
SWEP.Cycling.SequenceIronSightsExit = nil -- The cycling exit animation when iron sighting
SWEP.Cycling.GiveEntry = false -- Also give ammo when the cycling entry animation is finished
SWEP.Cycling.PlaybackRate = 1 -- The playback rate of the cycling animation
SWEP.Cycling.Sound = Sound("Weapon_Pistol.Reload") -- The cycling sound
SWEP.Cycling.SoundLevel = 60 -- The cycling sound level, used for sound distance
SWEP.Cycling.SoundPitch = 100 -- The cycling sound pitch
SWEP.Cycling.SoundVolume = 1 -- The cycling sound volume
SWEP.Cycling.SoundChannel = CHAN_ITEM -- The cycling sound channel
SWEP.Cycling.Delay = 0.5 -- The delay between cycling
SWEP.Cycling.Automatic = false -- Is the cycling automatic?

-- Pump action settings
SWEP.PumpAction = {}
SWEP.PumpAction.Enabled = false -- Enable pump action
SWEP.PumpAction.Sequence = ACT_SHOTGUN_PUMP -- The pump action animation
SWEP.PumpAction.SequenceIronSights = ACT_SHOTGUN_PUMP -- The pump action animation when iron sighting
SWEP.PumpAction.PlaybackRate = 1 -- The playback rate of the pump action animation
SWEP.PumpAction.Sound = Sound("Weapon_Shotgun.Special1") -- The pump action sound
SWEP.PumpAction.SoundLevel = 60 -- The pump action sound level, used for sound distance
SWEP.PumpAction.SoundPitch = 100 -- The pump action sound pitch
SWEP.PumpAction.SoundVolume = 1 -- The pump action sound volume
SWEP.PumpAction.SoundChannel = CHAN_ITEM -- The pump action sound channel

-- Wind up settings, used for miniguns
SWEP.Winding = {}
SWEP.Winding.Enabled = false -- Enable wind up
SWEP.Winding.Duration = 2 -- The time the owner has to hold the trigger to wind up
SWEP.Winding.MaxDuration = 5 -- The maximum time the owner fire his weapon before it winds down forcefully

SWEP.Winding.SoundUp = Sound("Weapon_Minigun.WindUp") -- The sound that plays when the minigun is winding up
SWEP.Winding.SoundUpLevel = 60 -- The sound level of the wind up sound
SWEP.Winding.SoundUpPitch = 100 -- The sound pitch of the wind up sound
SWEP.Winding.SoundUpVolume = 1 -- The sound volume of the wind up sound
SWEP.Winding.SoundUpChannel = CHAN_ITEM -- The sound channel of the wind up sound

SWEP.Winding.SoundDown = Sound("Weapon_Minigun.WindDown") -- The sound that plays when the minigun is winding down
SWEP.Winding.SoundDownLevel = 60 -- The sound level of the wind down sound
SWEP.Winding.SoundDownPitch = 100 -- The sound pitch of the wind down sound
SWEP.Winding.SoundDownVolume = 1 -- The sound volume of the wind down sound
SWEP.Winding.SoundDownChannel = CHAN_ITEM -- The sound channel of the wind down sound

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

-- Walking animation settings
-- SWEP.Walking = {}
-- SWEP.Walking.Enabled = false -- Enable walking animations
-- SWEP.Walking.PlaybackRate = 1 -- The playback rate of the walking animations
-- SWEP.Walking.SequenceEnter = "walk_enter" -- The walking enter animation
-- SWEP.Walking.SequenceLoop = "walk" -- The walking loop animation
-- SWEP.Walking.SequenceExit = "walk_exit" -- The walking exit animation
-- SWEP.Walking.SequenceEmptyEnter = "walk_empty_enter" -- The walking enter animation when empty
-- SWEP.Walking.SequenceEmptyLoop = "walk_empty" -- The walking loop animation when empty
-- SWEP.Walking.SequenceEmptyExit = "walk_empty_exit" -- The walking exit animation when empty

-- HL2 Pistol Example
-- SWEP.Walking.Enabled = true -- Enable walking animations
-- SWEP.Walking.PlaybackRate = 1 -- The playback rate of the walking animations
-- SWEP.Walking.SequenceEnter = "idletolow" -- The walking enter animation
-- SWEP.Walking.SequenceLoop = "lowidle" -- The walking loop animation
-- SWEP.Walking.SequenceExit = "lowtoidle" -- The walking exit animation
-- SWEP.Walking.SequenceEmptyEnter = "idletolow" -- The walking enter animation when empty
-- SWEP.Walking.SequenceEmptyLoop = "lowidle" -- The walking loop animation when empty
-- SWEP.Walking.SequenceEmptyExit = "lowtoidle" -- The walking exit animation when empty

-- Running animation settings
-- SWEP.Running = {}
-- SWEP.Running.Enabled = false -- Enable running animations
-- SWEP.Running.PlaybackRate = 1 -- The playback rate of the running animations
-- SWEP.Running.SequenceEnter = "run_enter" -- The running enter animation
-- SWEP.Running.SequenceLoop = "run" -- The running loop animation
-- SWEP.Running.SequenceExit = "run_exit" -- The running exit animation
-- SWEP.Running.SequenceEmptyEnter = "run_empty_enter" -- The running enter animation when empty
-- SWEP.Running.SequenceEmptyLoop = "run_empty" -- The running loop animation when empty
-- SWEP.Running.SequenceEmptyExit = "run_empty_exit" -- The running exit animation when empty

-- HL2 Pistol Example
-- SWEP.Running.Enabled = true -- Enable running animations
-- SWEP.Running.PlaybackRate = 1 -- The playback rate of the running animations
-- SWEP.Running.SequenceEnter = "idletolow" -- The running enter animation
-- SWEP.Running.SequenceLoop = "lowidle" -- The running loop animation
-- SWEP.Running.SequenceExit = "lowtoidle" -- The running exit animation
-- SWEP.Running.SequenceEmptyEnter = "idletolow" -- The running enter animation when empty
-- SWEP.Running.SequenceEmptyLoop = "lowidle" -- The running loop animation when empty
-- SWEP.Running.SequenceEmptyExit = "lowtoidle" -- The running exit animation when empty

-- Weapon effects
SWEP.Effects = {}
SWEP.Effects.MuzzleFlash = true -- Enable muzzle flash
SWEP.Effects.MuzzleFlashEffect = "MuzzleFlash" -- Muzzle flash effect
SWEP.Effects.MuzzleFlashFlags = 1 -- Muzzle flash flags
SWEP.Effects.MuzzleFlashScale = 1 -- Muzzle flash scale
SWEP.Effects.MuzzleFlashAttachment = "muzzle" -- Muzzle flash attachment

SWEP.Effects.TracerCustom = false -- Wether or not we are using lua based tracers
SWEP.Effects.TracerEffect = "Tracer" -- Tracer effect
SWEP.Effects.TracerOffset = Vector(0, 0, 0) -- Tracer offset from the world model, only works with lua based tracers

SWEP.FireModes = {}
SWEP.FireModes.Enabled = false -- Enable fire modes
SWEP.FireModes.Sound = Sound("buttons/lever7.wav") -- The fire mode switch sound
SWEP.FireModes.SoundLevel = 60 -- The fire mode switch sound level, used for sound distance
SWEP.FireModes.SoundPitch = 140 -- The fire mode switch sound pitch
SWEP.FireModes.SoundVolume = 1 -- The fire mode switch sound volume
SWEP.FireModes.SoundChannel = CHAN_ITEM -- The fire mode switch sound channel
SWEP.FireModes.SoundDelay = 0.5 -- The fire mode switch sound delay
SWEP.FireModes.Delay = 0.5 -- The fire mode switch delay
SWEP.FireModes.List = {"auto", "burst", "single"}
SWEP.FireModes.Settings = {
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

function SWEP:SetupDataTables()
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

    self:NetworkVar("Float", 0, "NextIdle")
    self:NetworkVar("Int", 0, "FireMode")
    self:NetworkVar("Int", 1, "BurstCount")

    -- Walking
    self:NetworkVar("Bool", 2, "Walking")
    self:NetworkVarNotify("Walking", function(name, old, new)
        self:QueueIdle(0)
        self:SetRunningWait(0)
    end)
    self:NetworkVar("Float", 1, "WalkingWait")

    -- Running
    self:NetworkVar("Bool", 3, "Running")
    self:NetworkVarNotify("Running", function(name, old, new)
        self:QueueIdle(0)
        self:SetWalkingWait(0)
    end)
    self:NetworkVar("Float", 2, "RunningWait")

    -- Cycling
    self:NetworkVar("Bool", 4, "Cycling")
    self:NetworkVar("Float", 3, "CyclingWait")

    -- Winding
    self:NetworkVar("Bool", 5, "Winding")
    self:NetworkVar("Bool", 6, "WindedUp")
    self:NetworkVar("Float", 4, "WindingStart")
    self:NetworkVar("Float", 5, "WindingCooldown")

    if ( self.PostSetupDataTables ) then
        self:PostSetupDataTables()
    end
end

function SWEP:OnIronSightsChanged(name, old, new)
    -- Override this function to do something when the iron sights state changes
end

function SWEP:Initialize()
    if ( self.PreInitialize ) then
        self:PreInitialize()
    end

    self:SetWeaponHoldType(self.HoldType)
    self:SetFireMode(1)

    self:SetIronSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)
    self:SetWalking(false)
    self:SetWalkingWait(0)
    self:SetRunning(false)
    self:SetRunningWait(0)
    self:SetCycling(false)
    self:SetCyclingWait(0)
    self:SetWinding(false)
    self:SetWindedUp(false)
    self:SetWindingStart(0)
    self:SetWindingCooldown(0)
    self:SetNextPrimaryFire(0)
    self:SetNextSecondaryFire(0)

    if ( self.PostInitialize ) then
        self:PostInitialize()
    end
end

function SWEP:QueueIdle(duration)
    local vm = self:GetOwner().GetViewModel and self:GetOwner():GetViewModel() or nil
    if ( !IsValid(vm) ) then return end

    duration = duration or vm:SequenceDuration() / vm:GetPlaybackRate()
    duration = math.Round(duration, 2)

    self:SetNextIdle(CurTime() + duration)
end

function SWEP:SecondaryAttack()
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

function SWEP:ThinkIdle()
    -- Don't idle if cycling or reloading
    if ( self:GetCycling() or self:GetReloading() ) then return end

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

function SWEP:ThinkWalking()
    if ( !self.Walking or !self.Walking.Enabled ) then return end

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

function SWEP:ThinkRunning()
    if ( !self.Running or !self.Running.Enabled ) then return end

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

function SWEP:ThinkWinding()
    if ( !self.Winding or !self.Winding.Enabled ) then return end

    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    local holding = ply:KeyDown(IN_ATTACK)
    if ( holding and !self:GetWinding() and CurTime() > self:GetWindingCooldown() ) then
        print("Start winding")
        self:SetWinding(true)
        self:SetWindingStart(CurTime())

        if ( !self.WindingSoundUp ) then
            self.WindingSoundUp = CreateSound(ply, self.Winding.SoundUp)
            self.WindingSoundUp:SetSoundLevel(self.Winding.SoundUpLevel or 60)
            self.WindingSoundUp:Play()
        elseif ( self.WindingSoundUp and !self.WindingSoundUp:IsPlaying() ) then
            self.WindingSoundUp:Play()
        end
    elseif ( holding and self:GetWinding() and CurTime() - self:GetWindingStart() >= self.Winding.Duration and CurTime() > self:GetWindingCooldown() ) then
        if ( !self:GetWindedUp() ) then
            print("Winded up")
            self:SetWindedUp(true)

            if ( self.WindingSoundUp and self.WindingSoundUp:IsPlaying() ) then
                self.WindingSoundUp:Stop()
            end
        else
            if ( self:CanPrimaryAttack() ) then
                if ( self.Winding.MaxDuration and CurTime() - self:GetWindingStart() >= self.Winding.MaxDuration ) then
                    print("Winding down forcefully")
                    self:SetWinding(false)
                    self:SetWindedUp(false)
                    self:SetWindingCooldown(CurTime() + self.Winding.Duration)

                    if ( self.WindingSoundUp and self.WindingSoundUp:IsPlaying() ) then
                        self.WindingSoundUp:Stop()
                    end

                    if ( self.Winding.SoundDown ) then
                        self:EmitSound(self.Winding.SoundDown, self.Winding.SoundDownLevel or 60, self.Winding.SoundDownPitch or 100, self.Winding.SoundDownVolume or 1, self.Winding.SoundDownChannel or CHAN_ITEM)
                    end
                end
                print("Shooting")
                self:Shoot()
            end
        end
    elseif ( !holding and self:GetWinding() ) then
        if ( self:GetWinding() ) then
            print("Stop winding")
            self:SetWinding(false)
            self:SetWindedUp(false)

            if ( self.WindingSoundUp and self.WindingSoundUp:IsPlaying() ) then
                self.WindingSoundUp:Stop()
            end

            if ( self.Winding.SoundDown ) then
                self:EmitSound(self.Winding.SoundDown, self.Winding.SoundDownLevel or 60, self.Winding.SoundDownPitch or 100, self.Winding.SoundDownVolume or 1, self.Winding.SoundDownChannel or CHAN_ITEM)
            end
        end
    elseif ( !holding and !self:GetWinding() and CurTime() > self:GetWindingCooldown() ) then
        self:SetWindingCooldown(0)
    end
end

function SWEP:Think()
    local ply = self:GetOwner()
    if ( !IsValid(ply) ) then return end

    if ( self.PreThink ) then
        self:PreThink()
    end

    if ( self:GetCycling() or self:GetReloading() ) then
        self:ThinkCycling()
        return
    end

    self:ThinkIdle()
    self:ThinkWalking()
    self:ThinkRunning()
    self:ThinkIronSights()
    self:ThinkFireModes()
    self:ThinkCycling()
    self:ThinkWinding()

    if ( self.PostThink ) then
        self:PostThink()
    end
end

function SWEP:Deploy()
    if ( self.PreDeploy ) then
        self:PreDeploy()
    end

    self:SetIronSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)
    self:SetWalking(false)
    self:SetWalkingWait(0)
    self:SetRunning(false)
    self:SetRunningWait(0)
    self:SetCycling(false)
    self:SetCyclingWait(0)
    self:SetWinding(false)
    self:SetWindedUp(false)
    self:SetWindingStart(0)
    self:SetWindingCooldown(0)
    self:SetNextPrimaryFire(0)
    self:SetNextSecondaryFire(0)

    self:PlayAnimation(self.DeployAnim or ACT_VM_DRAW)
    self:QueueIdle()

    if ( self.PostDeploy ) then
        self:PostDeploy()
    end

    return true
end

function SWEP:Holster()
    if ( self.PreHolster ) then
        self:PreHolster()
    end

    self:SetIronSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)
    self:SetWalking(false)
    self:SetWalkingWait(0)
    self:SetRunning(false)
    self:SetRunningWait(0)
    self:SetCycling(false)
    self:SetCyclingWait(0)
    self:SetWinding(false)
    self:SetWindedUp(false)
    self:SetWindingStart(0)
    self:SetWindingCooldown(0)
    self:SetNextPrimaryFire(0)
    self:SetNextSecondaryFire(0)

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