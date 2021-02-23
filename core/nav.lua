surface.CreateFont("pcheat.fonts.navbar", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

AccessorFunc(PANEL, "body_element", "Body")

function PANEL:Init()
    self.buttons = {}
    self.pnls = {}

    self.active = 0

    self:SetWide(0)
    self:SizeTo(40, 5000, 0.2, 0, -1, function() end)

    self.color = pcheat.theme.accent
end

function PANEL:SetColor(clr)
    self.color = clr
end

function PANEL:AddTab(name, panel, panelFunc, ico)
    ico = ico or ""

    local i = table.Count(self.buttons) + 1
    self.buttons[i] = self:Add("pcheat.hoverButton")
    local btn = self.buttons[i]
    btn.id = i
    btn:Dock(TOP)
    btn:SetText(name)
    btn:SetFont("pcheat.fonts.navbar")
    btn:SetTall(40)
    btn:DockMargin(0, 0, 0, 0)
    btn:SetText("")
    btn:SetContentAlignment(4)
    btn:SetTextInset(0, 0)
    btn:SetIcon(ico)
    btn.DoClick = function(s)
        self:SetActive(s.id)
    end

    self.pnls[i] = self:GetBody():Add(panel)
    local pnl = self.pnls[i]
    pnl:Dock(FILL)
    pnl:SetVisible(false)

    if (panelFunc) then
        panelFunc(pnl)
    end

    return btn
end

function PANEL:SetActive(id)
    local activeBtn = self.buttons[self.active]
    if (activeBtn) then
        activeBtn:SetAlwaysOn(false)
    end

    local activePnl = self.pnls[self.active]
    if (activePnl) then
        activePnl:SetVisible(false)
    end

    self.active = id

    local activeBtn = self.buttons[id]
    if (activeBtn) then
        activeBtn:SetAlwaysOn(true)
    end

    local activePnl = self.pnls[id]
    if (activePnl) then
        activePnl:SetVisible(true)
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBoxEx(6, 0, 0, w, h, pcheat.theme.nav_background, false, false, true, false)
end

vgui.Register("pcheat.sidebar", PANEL, "EditablePanel")