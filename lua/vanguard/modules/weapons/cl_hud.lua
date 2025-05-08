local debug = CreateClientConVar("vanguard_weapons_debug", 0, true, false)
concommand.Add("vanguard_weapons_debug_toggle", function(client, cmd, args)
    if ( !IsValid(client) or !client:IsPlayer() ) then return end

    local state = debug:GetBool()
    debug:SetBool(!state)

    if ( state ) then
        vanguard.util:Message("Debug mode is now disabled.")
    else
        vanguard.util:Message("Debug mode is now enabled.")
    end
end)

local ignoreKeyValues = {
    ["IsVWEP"] = true
}

local ignoreTypes = {
    ["function"] = true
}

hook.Add("HUDPaint", "Vanguard.Weapons.HUD", function()
    if ( !debug:GetBool() ) then return end

    local client = LocalPlayer()
    if ( !IsValid(client) or !client:IsPlayer() ) then return end

    local weapon = client:GetActiveWeapon()
    if ( !IsValid(weapon) or !weapon.IsVWEP ) then return end

    local weaponTable = weapon:GetTable()

    local x, y = 16, 16
    for k, v in SortedPairs(weaponTable) do
        if ( ignoreKeyValues[k] ) then continue end
        if ( ignoreTypes[type(v)] ) then continue end

        local key = string.Trim(k)
        local value = v
        if ( isvector(v) ) then
            value = "Vector(" .. v.x .. ", " .. v.y .. ", " .. v.z .. ")"
        elseif ( isangle(v) ) then
            value = "Angle(" .. v.p .. ", " .. v.y .. ", " .. v.r .. ")"
        elseif ( isbool(v) ) then
            value = v and "true" or "false"
        elseif ( isstring(v) ) then
            if ( string.len(v) > 0 ) then
                value = v
            else
                value = "Empty String"
            end
        end

        value = tostring(value)

        if ( istable(v) ) then
            if ( table.Count(v) == 0 ) then continue end
            if ( k == "BaseClass" ) then continue end
            if ( k == "ActivityTranslate" ) then continue end
            if ( k == "ActivityTranslateAI" ) then continue end

            w, h = surface.GetTextSize(k .. ": ")
            draw.SimpleText(k .. ": ", "BudgetLabel", x, y, vanguard.info.color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText("table", "BudgetLabel", x + w, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            y = y + 10

            local info = {}
            for k2, v2 in pairs(v) do
                if ( isstring(v2) and string.len(v2) > 0 ) then
                    table.insert(info, {k2, v2})
                elseif ( isnumber(v2) ) then
                    table.insert(info, {k2, tostring(v2)})
                elseif ( isbool(v2) ) then
                    table.insert(info, {k2, v2 and "true" or "false"})
                end
            end

            for k2, v2 in SortedPairs(info) do
                w, h = surface.GetTextSize("   - " .. v2[1] .. ": ")
                draw.SimpleText("   - " .. v2[1] .. ": ", "BudgetLabel", x, y, vanguard.info.color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText(v2[2], "BudgetLabel", x + w, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                y = y + 10
            end
        else
            w, h = surface.GetTextSize(k .. ": ")
            draw.SimpleText(key .. ": ", "BudgetLabel", x, y, vanguard.info.color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(value, "BudgetLabel", x + w, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            y = y + 10
        end
    end
end)