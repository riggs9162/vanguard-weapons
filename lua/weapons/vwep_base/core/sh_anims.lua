function SWEP:PlayAnimation(anim, rate)
    local vm = self:GetOwner():GetViewModel()
    if ( !IsValid(vm) ) then return end

    local sequence = anim
    if ( isstring(anim) ) then
        sequence = vm:LookupSequence(anim)
    elseif ( isfunction(anim) ) then
        sequence = anim(self)
    elseif ( istable(anim) ) then
        sequence = anim[math.random(#anim)]
    end

    if ( !sequence or sequence == -1 ) then return end

    vm:SendViewModelMatchingSequence(sequence)
    vm:SetPlaybackRate(rate or 1)

    return sequence, vm:SequenceDuration(sequence) / vm:GetPlaybackRate()
end

function SWEP:ResetAnimation()
    local vm = self:GetOwner():GetViewModel()
    if ( !IsValid(vm) ) then return end

    vm:ResetSequence(vm:LookupSequence("idle"))
end

function SWEP:GetShootGesture()
    local gesture = self.Primary.Gesture or ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
    if ( self:GetIronSights() ) then
        gesture = self.Primary.GestureIronSights
    end

    if ( isfunction(gesture) ) then
        gesture = gesture(self)
    elseif ( istable(gesture) ) then
        gesture = gesture[math.random(#gesture)]
    end

    return gesture
end

function SWEP:GetViewModelShootAnimation()
    local shootSequence = self.Primary.Sequence or ACT_VM_PRIMARYATTACK
    if ( self.Primary.SequenceIronSights and self:GetIronSights() ) then
        shootSequence = self.Primary.SequenceIronSights
    end

    if ( isfunction(shootSequence) ) then
        shootSequence = shootSequence(self)
    elseif ( istable(shootSequence) ) then
        shootSequence = shootSequence[math.random(#shootSequence)]
    end

    return shootSequence
end

function SWEP:GetViewModelPumpActionAnimation()
    local pumpSequence = self.PumpAction.Sequence or ACT_SHOTGUN_PUMP
    if ( self.PumpAction.SequenceIronSights and self:GetIronSights() ) then
        pumpSequence = pumpSequence
    end

    if ( isfunction(pumpSequence) ) then
        pumpSequence = pumpSequence(self)
    elseif ( istable(pumpSequence) ) then
        pumpSequence = pumpSequence[math.random(#pumpSequence)]
    end

    return pumpSequence
end

function SWEP:GetViewModelReloadAnimation(bIronsighted)
    local clip = self:Clip1()
    local reloadSequence = self.Reloading.Sequence or ACT_VM_RELOAD

    if ( bIronsighted ) then
        if ( clip <= 0 ) then
            reloadSequence = self.Reloading.SequenceIronSightsEmpty or reloadSequence
        else
            reloadSequence = self.Reloading.SequenceIronSights or reloadSequence
        end
    else
        if ( clip <= 0 ) then
            reloadSequence = self.Reloading.SequenceEmpty or reloadSequence
        end
    end

    if ( isfunction(reloadSequence) ) then
        reloadSequence = reloadSequence(self)
    elseif ( istable(reloadSequence) ) then
        reloadSequence = reloadSequence[math.random(#reloadSequence)]
    end

    return reloadSequence
end

function SWEP:GetViewModelCyclingEntryAnimation()
    local entrySequence = self.Cycling.SequenceEntry or ACT_VM_RELOAD
    if ( self:GetIronSights() ) then
        entrySequence = self.Cycling.SequenceEntryIronSights or entrySequence
    end

    if ( isfunction(entrySequence) ) then
        entrySequence = entrySequence(self)
    elseif ( istable(entrySequence) ) then
        entrySequence = entrySequence[math.random(#entrySequence)]
    end

    return entrySequence
end

function SWEP:GetViewModelCyclingExitAnimation()
    local exitSequence = self.Cycling.SequenceExit or ACT_VM_RELOAD
    if ( self:GetIronSights() ) then
        exitSequence = self.Cycling.SequenceExitIronSights or exitSequence
    end

    if ( isfunction(exitSequence) ) then
        exitSequence = exitSequence(self)
    elseif ( istable(exitSequence) ) then
        exitSequence = exitSequence[math.random(#exitSequence)]
    end

    return exitSequence
end

function SWEP:GetViewModelCyclingAnimation()
    local idleSequence = self.Cycling.Sequence or ACT_VM_IDLE
    if ( self:GetIronSights() ) then
        idleSequence = self.Cycling.SequenceIronSights or idleSequence
    end

    if ( isfunction(idleSequence) ) then
        idleSequence = idleSequence(self)
    elseif ( istable(idleSequence) ) then
        idleSequence = idleSequence[math.random(#idleSequence)]
    end

    return idleSequence
end