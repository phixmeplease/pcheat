surface.CreateFont("pcheat.fonts.text", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self:SetFont("pcheat.fonts.text")
end

function PANEL:Paint(w, h)
    draw.RoundedBox(6, 0, 0, w, h, pcheat.theme.header)
    self:DrawTextEntryText(pcheat.theme.text, pcheat.theme.accent, pcheat.theme.text)
end

vgui.Register("pcheat.textentry", PANEL, "DTextEntry")

pcheat.requestString = function(title, yes_func)
    local frame = vgui.Create("pcheat.frame")
    frame:SetSize(500, 250)
    frame:Center()
    frame:MakePopup()

    local text = frame:Add("pcheat.textentry")
    text:Dock(FILL)
    text:DockMargin(10, 10, 10, 10)
end