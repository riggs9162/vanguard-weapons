if ( CLIENT ) then
    concommand.Add("vanguard_weapons_toggle_firemode", function(client, cmd, args)
        if ( !IsValid(client) or !client:IsPlayer() ) then return end

        local wep = client:GetActiveWeapon()
        if ( !IsValid(wep) or !wep.IsVWEP ) then return end

        wep:ToggleFireMode()

        net.Start("Vanguard.Weapons.ToggleFireMode")
        net.SendToServer()

        vanguard.util:Message("You have toggled the firemode of your weapon.")
    end)
else
    util.AddNetworkString("Vanguard.Weapons.ToggleFireMode")

    net.Receive("Vanguard.Weapons.ToggleFireMode", function(len, client)
        if ( !IsValid(client) or !client:IsPlayer() ) then return end

        local wep = client:GetActiveWeapon()
        if ( !IsValid(wep) or !wep.IsVWEP ) then return end

        wep:ToggleFireMode()

        vanguard.util:Message(client, " has toggled the firemode of their weapon.")
    end)
end