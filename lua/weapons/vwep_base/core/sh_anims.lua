function SWEP:PlayAnimation(anim, rate)
    local vm = self:GetOwner():GetViewModel()
    if ( !IsValid(vm) ) then return end

    local sequence = isstring(anim) and vm:LookupSequence(anim) or anim
    if ( sequence == -1 ) then return end

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
    if ( self:GetIronSights() ) then
        shootSequence = self.Primary.SequenceIronSights or shootSequence
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
    if ( self:GetIronSights() ) then
        pumpSequence = self.PumpAction.SequenceIronSights or pumpSequence
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