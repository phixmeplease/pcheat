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