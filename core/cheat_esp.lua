local cheat_id = "esp"
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

    self.entesp = self.scroll:Add("DTextEntry")
    self.entesp:Dock(TOP)
    self.entesp:SetTall(50)
    self.entesp:SetText("spawned_weapon, spawned_shipment")
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

hook.Add("HUDPaint", "pcheat.hooks." .. cheat_id .. ".HUDPaint", function()
    if (cheattable.options["enabled"] == true) then
        local curY = 0

        for k, v in pairs(player.GetAll()) do
            if (v == LocalPlayer()) then continue end
            local pos = v:GetPos():ToScreen()

            curY = pos.y
            
            if (cheattable.options["name"]) then
                draw.SimpleText("[Nick] " .. v:Nick() or "Unknown", getFont("name"), pos.x, curY, pcheat.theme.accent, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                curY = curY + 20
            end
            if (cheattable.options["health"]) then
                draw.SimpleText("[Health] " .. v:Health() or "Unknown", getFont("subName"), pos.x, curY, pcheat.theme.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                curY = curY + 20
            end
            if (cheattable.options["armor"]) then
                draw.SimpleText("[Armor] " .. v:Armor() or "Unknown", getFont("subName"), pos.x, curY, pcheat.theme.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                curY = curY + 20
            end
            if (cheattable.options["job"]) then
                draw.SimpleText("[Job] " .. v:getDarkRPVar("job") or "Unknown", getFont("subName"), pos.x, curY, pcheat.theme.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                curY = curY + 20
            end
            if (cheattable.options["distance"]) then
                draw.SimpleText("[Distance] " .. math.floor(v:GetPos():Distance(LocalPlayer():GetPos())), getFont("subName"), pos.x, curY, pcheat.theme.text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                curY = curY + 20
            end
        end
    end
end)