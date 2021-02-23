--[[
    A Simple Garry's mod drawing library
    Copyright (C) 2016 Bull [STEAM_0:0:42437032] [76561198045139792]
    Freely acquirable at https://github.com/bull29/b_draw-lib
    You can use this anywhere for any purpose as long as you acredit the work to the original author with this notice.
    Optionally, if you choose to use this within your own software, it would be much appreciated if you could inform me of it.
    I love to see what people have done with my code! :)
]]--

file.CreateDir("downloaded_assets")

local exists = file.Exists
local write = file.Write
local fetch = http.Fetch
local white = Color( 255, 255, 255 )
local surface = surface
local crc = util.CRC
local _error = Material("error")
local math = math
local mats = {}
local fetchedavatars = {}

local function fetch_asset(url)
	if not url then return _error end

	if mats[url] then
		return mats[url]
	end

	local crc = crc(url)

	if exists("downloaded_assets/" .. crc .. ".png", "DATA") then
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png", "noclamp smooth")

		return mats[url]
	end

	mats[url] = _error

	fetch(url, function(data)
		write("downloaded_assets/" .. crc .. ".png", data)
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png", "noclamp smooth")
	end)

	return mats[url]
end

function pcheat.WebImage( url, x, y, width, height, color, angle, cornerorigin )
	color = color or white

	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.SetMaterial( fetch_asset( url ) )
	if not angle then
		surface.DrawTexturedRect( x, y, width, height)
	else
		if not cornerorigin then
			surface.DrawTexturedRectRotated( x, y, width, height, angle )
		else
			surface.DrawTexturedRectRotated( x + width / 2, y + height / 2, width, height, angle )
		end
	end
end