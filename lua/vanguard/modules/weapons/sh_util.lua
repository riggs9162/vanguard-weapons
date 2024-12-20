if ( CLIENT ) then
    function vanguard.util:Translate(originalVec, originalAng, newVec, newAng, mul)
        mul = mul or 1

        originalAng:RotateAroundAxis(originalAng:Right(), newAng.p * mul)
        originalAng:RotateAroundAxis(originalAng:Up(), newAng.y * mul)
        originalAng:RotateAroundAxis(originalAng:Forward(), newAng.r * mul)

        originalVec = originalVec + newVec.x * originalAng:Right() * mul
        originalVec = originalVec + newVec.y * originalAng:Forward() * mul
        originalVec = originalVec + newVec.z * originalAng:Up() * mul

        return originalVec, originalAng
    end
end