local cheat_id = "aimbot"
local cheattable = pcheat.registeredcheats[cheat_id]

local function getFont(n)
    return "pcheat.fonts." .. cheat_id .. "." .. n
end

local PANEL = {}

function PANEL:Init()
    self.scroll = self:Add("DScrollPanel")
    self.scroll:Dock(FILL)

    self:AddOption("enabled")
    for k, v in pairs(cheattable.options) do
        if (k == "enabled") then continue end
        self:AddOption(k)
    end
end

function PANEL:AddOption(name)
        local pnl = self.scroll:Add("DPanel")
        pnl:Dock(TOP)
        pnl:DockMargin(5, 5, 5, 0)
        pnl:SetTall(45)
        pnl.Paint = function(s, w, h)
            draw.SimpleText(name, getFont("name"), 5, h / 2, pcheat.theme.text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        
        local check = pnl:Add("pcheat.hoverButton")
        check:Dock(RIGHT)
        check:SetWide(pnl:GetTall())
        check:SetIcon()
        check:SetIcon("https://i.imgur.com/9bBZurQ.png")
        if (cheattable.options[name] == true) then
            check:SetAlwaysOn(true)
        else
            check:SetAlwaysOn(false)
        end

        check.DoClick = function()
            if (cheattable.options[name] == true) then
                cheattable.options[name] = false
                check:SetAlwaysOn(false)
            else
                cheattable.options[name] = true
                check:SetAlwaysOn(true)
            end
        end
end

vgui.Register("pcheat.cheats." .. cheat_id, PANEL, "Panel")

surface.CreateFont("pcheat.fonts." .. cheat_id .. ".name", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

surface.CreateFont("pcheat.fonts." .. cheat_id .. ".subName", {
    font = "Montserrat Medium",
    size = 20,
    weight = 500,
})

hook.Add("Think", "pcheat.hooks." .. cheat_id .. ".Think", function()
    if (cheattable.options["enabled"] == true) then
        local ply = LocalPlayer()
        local tr = util.GetPlayerTrace(ply)
        local line = util.TraceLine(tr)

        if (!line.HitNonWorld) then return end

        local target = line.Entity
        if (!target) then return end
        if (!target:IsPlayer()) then return end
        
        local hit = target:LookupBone("ValveBiped.Bip01_Spine2")
        if (!hit) then return end

        local pos, ang = target:GetBonePosition(hit)
        if (!pos) then return end
        if (!ang) then return end

        ply:SetEyeAngles((pos - ply:GetShootPos()):Angle())
    end
end)

hook.Add("PlayerSwitchWeapon", "pcheat.hooks." .. cheat_id .. ".PlayerSwitchWeapon", function(ply, _, weap)
    if (cheattable.options["No Spread"] == true) then
        if (ply != LocalPlayer()) then return end
        print("Changed")
        local class = weap:GetClass()
        local isM9K = string.find(class, "m9k")
        local isCW = string.find(class, "cw")
        local isTFA = string.find(class, "tfa")

        if isCW then 
            wep.HipSpread = 0
            wep.AimSpread = 0
            wep.MaxSpreadInc = 0.0000001
            wep.SpreadPerShot = 0
            wep.SpreadCooldown = 0
        elseif (isTFA) then
            wep.Recoil = function() return 0 end
        end
    end
end)