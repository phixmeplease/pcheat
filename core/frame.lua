local PANEL = {}

function PANEL:Init()
    self.header = self:Add("Panel")
    self.header:Dock(TOP)
    self.header:SetTall(0)
    self.header:SizeTo(50000, 30, 0.2, 0, -1, function()
        self:MakeCloseButton()
    end)

    self.header.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, pcheat.theme.header, true, true, false, false)
    end
end

function PANEL:MakeCloseButton()
    self.header.cbtn = self.header:Add("DButton")
    self.header.cbtn:Dock(RIGHT)
    self.header.cbtn:SetWide(self.header:GetTall())
    self.header.cbtn:SetText("")
    self.header.cbtn.lerpR = 255
    self.header.cbtn.lerpG = 255
    self.header.cbtn.lerpB = 255
    self.header.cbtn.margin = 8

    self.header.cbtn.DoClick = function(s)
        self:Remove()
    end

    self.header.cbtn.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, pcheat.theme.close.r)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, pcheat.theme.close.g)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, pcheat.theme.close.b)
        else
            s.lerpR = Lerp(7 * FrameTime(), s.lerpR, 255)
            s.lerpG = Lerp(7 * FrameTime(), s.lerpG, 255)
            s.lerpB = Lerp(7 * FrameTime(), s.lerpB, 255)
        end
        
        s.color = Color(s.lerpR, s.lerpG, s.lerpB)
        pcheat.WebImage( "https://i.imgur.com/qEIG9YT.png", s.margin, s.margin, w - s.margin * 2, h - s.margin * 2, s.color, 0, 0 )
    end
end

function PANEL:Paint(w, h)
    local aX, aY = self:LocalToScreen()
    BSHADOWS.BeginShadow()
    draw.RoundedBox(6, aX, aY, w, h, pcheat.theme.background)
    BSHADOWS.EndShadow(3, 1, 1)
end

vgui.Register("pcheat.frame", PANEL, "EditablePanel")

concommand.Add("pcheat_menu", function()
    pcheat.frame = vgui.Create("pcheat.frame")
    pcheat.frame:SetSize(ScrW() * .4, ScrH() * .4)
    pcheat.frame:SetPos(10, 10)
    --pcheat.frame:SetTitle(pcheat.frameTitle)
    pcheat.frame:MakePopup()

    pcheat.frame.sidebar = pcheat.frame:Add("pcheat.sidebar")
    pcheat.frame.sidebar:Dock(LEFT)
    pcheat.frame.sidebar:SetBody(pcheat.frame)
    -- PANEL:AddTab(name, panel, panelFunc, ico)
    for k, v in pairs(pcheat.registeredcheats) do
        pcheat.frame.sidebar:AddTab(k, "pcheat.cheats." .. k, function() end, v.icon)
    end
    pcheat.frame.sidebar:SetActive(1)
end)