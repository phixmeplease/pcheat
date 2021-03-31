local cheat_id = "esp"
local cheattable = pcheat.registeredcheats[cheat_id]
local entesptable = {}

local function getFont(n)
    return "pcheat.fonts." .. cheat_id .. "." .. n
end

local function calcThings(t)
    local nt = {}
    for k, v in pairs(ents.GetAll()) do
        if (table.HasValue(t, v:GetClass())) then
            local cnt = table.Count(nt) + 1

            nt[cnt] = v
        end
    end

    entesptable = nt
end

local function calculateEntityTable(str)
    //if (istable(str)) then return end
    PrintTable(str)
    entesptable = {}

    local newtbl = string.Explode(",", str)
    if (!newtbl) then return end
    local t = {}

    for k, v in pairs(newtbl) do
        local cnt = table.Count(t) + 1

        t[cnt] = newtbl[k]
    end

    calcThings(t)
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
    /*
    self.entesp = self.scroll:Add("pcheat.textentry")
    self.entesp:Dock(TOP)
    self.entesp:SetTall(50)
    self.entesp:SetText("spawned_weapon,spawned_shipment")
    self.entesp:DockMargin(10, 10, 10, 10)

    self.saveentesp = self.scroll:Add("pcheat.button")
    self.saveentesp:Dock(TOP)
    self.saveentesp:SetTall(45)
    self.saveentesp:DockMargin(10, 0, 10, 0)
    self.saveentesp:SetText("Save ESP Table")
    self.saveentesp:SetHoverColor(Color(pcheat.theme.accent.r - 45, pcheat.theme.accent.g - 45, pcheat.theme.accent.b - 45))

    self.saveentesp.DoClick = function()
        calculateEntityTable(self.entesp:GetText())
    end
    */

    self.b = self.scroll:Add("Panel")
    self.b:Dock(TOP)
    self.b:SetTall(10)
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

    if (cheattable.options["show_entity_name"] == true) then
        local ent = LocalPlayer():GetEyeTrace().Entity
        if (!ent) then return end
        draw.SimpleText(ent, getFont("name"), ScrW() / 2, ScrH() - 25, pcheat.theme.accent, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    end

    -- if (cheattable.options["entity_esp"] == true) then
    --     for k, v in pairs(ents.GetAll()) do
    --         local xpos = v:GetPos():ToScreen()
    --         if (!xpos) then return end
    --         draw.SimpleText(v:GetClass(), getFont("name"), xpos.x, xpos.y, pcheat.theme.accent, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    --     end
    -- end
end)

hook.Add("PreDrawHalos", "pcheat.hooks." .. cheat_id .. ".PreDrawHalos", function()
    if (cheattable.options["entity_esp"] == true) then
        halo.Add(entesptable, color_white, 2, 2, 1, true, true)
    end
end)