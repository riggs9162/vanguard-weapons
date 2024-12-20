local color = vanguard.info.color

concommand.Add("vanguard_print_ammo_names", function()
    local ammoTable = game.GetAmmoTypes()
    for k, v in ipairs(ammoTable) do
        MsgC(color, "[VANGUARD] [WEAPONS] ", color_white, "Ammo - " .. v .. "\n")
    end
end)