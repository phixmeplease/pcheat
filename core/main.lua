pcheat = {}
pcheat.funcs = {}
pcheat.enabled = true
pcheat.frameTitle = "pCheat"
pcheat.chatPrefix = "[pCheat] "
pcheat.theme = {
    background = Color(30, 30, 30),
    header = Color(45, 45, 45),
    title = Color(255, 255, 255),
    accent = Color(255, 75, 75),
    chat = Color(255, 255, 255),
    close = Color(255, 75, 75),
    nav_background = Color(50, 50, 50),
    text = Color(255, 255, 255),
}
pcheat.registeredcheats = {
    ["esp"] = {icon = "https://i.imgur.com/ORK5g3Z.png", options = {["enabled"] = false, ["name"] = true, ["job"] = true, ["health"] = true, ["armor"] = true, ["distance"] = true,["entity_esp"] = true,["show_entity_name"] = true,}},
    ["aimbot"] = {icon = "https://i.imgur.com/2tWK1cW.png", options = {["enabled"] = false, ["No Spread"] = false,}},
}

pcheat.funcs.debugPrint = function(text)
    chat.AddText(pcheat.theme.accent, pcheat.chatPrefix, pcheat.theme.chat, text)
end

-- Includes --
include("mats.lua")
include("shadow.lua")
for k, v in pairs(pcheat.registeredcheats) do
    include("cheat_" .. k .. ".lua")
end
include("btn.lua")
include("nav.lua")
include("textentry.lua")
include("frame.lua")
--------------