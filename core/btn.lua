local PANEL = {}

function PANEL:Init()
    self:SetText("")
    self.margin = 5
    self.color = pcheat.theme.accent
    self.icon = ""

    self.lerpR = 255
    self.lerpG = 255
    self.lerpB = 255

    self.alwaysOn = false
end

function PANEL:SetMargin(mat)
    self.margin = mat
end

function PANEL:SetAlwaysOn(t)
    self.alwaysOn = t
end

function PANEL:SetIcon(i)
    self.icon = i
end

function PANEL:SetHoverColor(c)
    self.color = c
end

function PANEL:Paint(w, h)
    if (self:IsHovered() or self.alwaysOn) then
            self.lerpR = Lerp(7 * FrameTime(), self.lerpR, self.color.r)
            self.lerpG = Lerp(7 * FrameTime(), self.lerpG, self.color.g)
            self.lerpB = Lerp(7 * FrameTime(), self.lerpB, self.color.b)
        else
            self.lerpR = Lerp(7 * FrameTime(), self.lerpR, 255)
            self.lerpG = Lerp(7 * FrameTime(), self.lerpG, 255)
            self.lerpB = Lerp(7 * FrameTime(), self.lerpB, 255)
        end
        
        self.Funcolor = Color(self.lerpR, self.lerpG, self.lerpB)
        pcheat.WebImage( self.icon, self.margin, self.margin, w - self.margin * 2, h - self.margin * 2, self.Funcolor, 0, 0 )
end

vgui.Register("pcheat.hoverButton", PANEL, "DButton")

surface.CreateFont("pcheat.fonts.button", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self:SetText("")
    self.margin = 5
    self.color = pcheat.theme.accent
    self.ocolor = pcheat.theme.accent
    self.icon = ""

    self.lerpR = 255
    self.lerpG = 255
    self.lerpB = 255

    self.alwaysOn = false

    self:SetFont("pcheat.fonts.button")
    self:SetColor(pcheat.theme.text)
end

function PANEL:SetMargin(mat)
    self.margin = mat
end

function PANEL:SetAlwaysOn(t)
    self.alwaysOn = t
end

function PANEL:SetIcon(i)
    self.icon = i
end

function PANEL:SetHoverColor(c)
    self.color = c
end

function PANEL:Paint(w, h)
    if (self:IsHovered() or self.alwaysOn) then
            self.lerpR = Lerp(7 * FrameTime(), self.lerpR, self.color.r)
            self.lerpG = Lerp(7 * FrameTime(), self.lerpG, self.color.g)
            self.lerpB = Lerp(7 * FrameTime(), self.lerpB, self.color.b)
        else
            self.lerpR = Lerp(7 * FrameTime(), self.lerpR, self.ocolor.r)
            self.lerpG = Lerp(7 * FrameTime(), self.lerpG, self.ocolor.g)
            self.lerpB = Lerp(7 * FrameTime(), self.lerpB, self.ocolor.b)
        end
        
        self.Funcolor = Color(self.lerpR, self.lerpG, self.lerpB)
        draw.RoundedBox(6, 0, 0, w, h, self.Funcolor)
end

vgui.Register("pcheat.button", PANEL, "DButton")