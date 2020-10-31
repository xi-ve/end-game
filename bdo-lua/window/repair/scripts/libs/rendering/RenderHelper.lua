RenderHelper = {}

function RenderHelper.ToScreen(pos)
	local screen = Infinity.Rendering.WorldToScreen(pos)

	if screen == nil or (screen.X == 0 and screen.Y == 0) then
		screen = nil
		return nil
	end
	
	return screen
end

function RenderHelper.GetPolygonCenter(tVectors)
local totalX = 0
local totalY = 0
local totalZ = 0

for k,v in pairs(tVectors) do
	totalX = totalX + v.X
	totalY = totalY + v.Y
	totalZ = totalZ + v.Z
end

local centerX = totalX / table.length(tVectors)
local centerY = totalY / table.length(tVectors)
local centerZ = totalZ / table.length(tVectors)

return Vector3(centerX, centerY, centerZ)
end

function RenderHelper.GetColorImVec4FromHexColorString(hexColorString)
local a = tonumber(string.sub(hexColorString, 1, 2), 16)
local r = tonumber(string.sub(hexColorString, 3, 4), 16)
local g = tonumber(string.sub(hexColorString, 5, 6), 16)
local b = tonumber(string.sub(hexColorString, 7, 8), 16)

return ImVec4(r / 255, g / 255, b / 255, a / 255)
end

function RenderHelper.DrawWorldTextLabels(labels, startpos, vertical, offsetx, offsety)
	local screen = RenderHelper.ToScreen(startpos)

	if screen == nil then
		return
	end

	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end

	if vertical == nil then
		vertical = false
	end

	screen = Vector2(screen.X + offsetx, screen.Y + offsety)

	for k,v in pairs(labels) do
		local width = (string.len(v.Text) * 10)
		local height = v.Size
		
		RenderHelper.DrawRect(screen, width + 2, height + 2, v.LabelColor, 1, 0, v.Filled)

		if v.Border then
			RenderHelper.DrawRect(screen, width + 2 + (v.BorderThickness * 2), height + 2 + (v.BorderThickness * 2), v.LabelBorderColor, v.BorderThickness, 2, false)
		end

		Infinity.Rendering.DrawText(v.Text, Vector2(screen.X , screen.Y - (height/2)), height, RenderHelper.GetColorImVec4FromHexColorString(v.TextColor), true)

		if not vertical then
			screen = Vector2(screen.X + (width / 2), screen.Y)

			if v.Border then
				screen = Vector2(screen.X + (width / 2) + (v.BorderThickness * 2), screen.Y)
			end
		else
			screen = Vector2(screen.X, screen.Y + (height / 2))

			if v.Border then
				screen = Vector2(screen.X , screen.Y + (height / 2) + (v.BorderThickness * 2))
			end
		end
	end
end

function RenderHelper.DrawTextLabels(labels, startpos, vertical, offsetx, offsety)	
	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end

	if vertical == nil then
		vertical = false
	end

	startpos = Vector2(startpos.X + offsetx, startpos.Y + offsety)

	for k,v in pairs(labels) do
		local width = (string.len(v.Text) * 10)
		local height = v.Size
		
		RenderHelper.DrawRect(startpos, width + 2, height + 2, v.LabelColor, 1, 0, v.Filled)

		if v.Border then
			RenderHelper.DrawRect(startpos, width + 2 + (v.BorderThickness * 2), height + 2 + (v.BorderThickness * 2), v.LabelBorderColor, v.BorderThickness, 2, false)
		end

		Infinity.Rendering.DrawText(v.Text, Vector2(startpos.X , startpos.Y - (height/2)), height, RenderHelper.GetColorImVec4FromHexColorString(v.TextColor), true)

		if not vertical then
			startpos = Vector2(startpos.X + (width / 2), startpos.Y)

			if v.Border then
				startpos = Vector2(startpos.X + (width / 2) + (v.BorderThickness * 2), startpos.Y)
			end
		else
			startpos = Vector2(startpos.X, startpos.Y + (height / 2))

			if v.Border then
				startpos = Vector2(startpos.X , startpos.Y + (height / 2) + (v.BorderThickness * 2))
			end
		end
	end
end

function RenderHelper.DrawWorldText(text, size, textColor, startpos, offsetx, offsety)
	local screen = RenderHelper.ToScreen(startpos)

	if screen == nil then
		return
	end

	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end
	
	screen = Vector2(screen.X + offsetx, screen.Y + offsety)
	
	Infinity.Rendering.DrawText(text, screen, size, RenderHelper.GetColorImVec4FromHexColorString(textColor), true)	
end

function RenderHelper.DrawText(text, size, textColor, startpos, offsetx, offsety)	
	if offsetx == nil then
		offsetx = 0
	end

	if offsety == nil then
		offsety = 0
	end
	
	startpos = Vector2(startpos.X + offsetx, startpos.Y + offsety)
	
	Infinity.Rendering.DrawText(text, startpos, size, RenderHelper.GetColorImVec4FromHexColorString(textColor), true)	
end

function RenderHelper.DrawSquare(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawSquare(center, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawRect(center, width, height, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local a = ImVec2(center.X - (width / 2), center.Y - (height / 2))
local b = ImVec2(center.X + (width / 2), center.Y + (height / 2))

Infinity.Rendering.DrawRect(a, b, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawRectFromAB(a, b, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local A = ImVec2(a.X, a.Y)
local B = ImVec2(b.X, b.Y)

Infinity.Rendering.DrawRect(A, B, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawWorldRectFromAB(a, b, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local screenA = RenderHelper.ToScreen(a)
local screenB = RenderHelper.ToScreen(b)

if screenA == nil or screenB == nil then
	return
end

local A = ImVec2(screenA.X, screenA.Y)
local B = ImVec2(screenB.X, screenB.Y)

Infinity.Rendering.DrawRect(A, B, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawRectFromA(a, width, height, color, thickness, rounding, filled)
if filled == nil then
	filled = false
end

if rounding == nil then
	rounding = 0
end

local A = ImVec2(a.X, a.Y)
local B = ImVec2(a.X + width, a.Y + height)

Infinity.Rendering.DrawRect(A, B, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, rounding, filled)
end

function RenderHelper.DrawQuad(a, b, c, d, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawQuad(ImVec2(a.X, a.Y), ImVec2(b.X, b.Y), ImVec2(c.X, c.Y), ImVec2(d.X, d.Y), RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawCircle(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

Infinity.Rendering.DrawCircle(center, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawLine(from, to, color, thickness)
Infinity.Rendering.DrawLine(from, to, RenderHelper.GetColorImVec4FromHexColorString(color), thickness)
end

function RenderHelper.DrawWorldSquare(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

local pts = {}

local screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z + (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))
			
screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z - (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))			
			
screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z - (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))
			
		
screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z + (size / 2)))

if screen == nil then
	return
end

table.insert(pts, Vector2(screen.X, screen.Y))			

Infinity.Rendering.DrawWorldSquare(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)			
end

function RenderHelper.DrawHitBox(actor, color, thickness)
RenderHelper.DrawWorldBox(actor:getPosition(), actor:getBodySize(), color, thickness, actor:getBodyHeight())
end

function RenderHelper.DrawWorldBox(center, size, color, thickness, height)
if height == nil then
	height = size
end

local pts = {}

local screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y + height, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X - (size / 2), center.Y + height, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y + height, center.Z - (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

screen = RenderHelper.ToScreen(Vector3(center.X + (size / 2), center.Y + height, center.Z + (size / 2)))
if screen == nil then
	return
end
table.insert(pts, Vector2(screen.X, screen.Y))

Infinity.Rendering.DrawWorldBox(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled, height)			
end

function RenderHelper.DrawWorldCircle(center, size, color, thickness, filled)
if filled == nil then
	filled = false
end

local pts = {}

local segments = 20
local segmentSize = 360 / segments;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	pts = nil
	return
end

local screen = Vector2(0,0)
local x = 0
local z = 0

for angle = 0, 360, segmentSize do
	x = center.X + (size * math.cos(angle / (180 / math.pi)))
	z = center.Z + (size * math.sin(angle / (180 / math.pi)))

	screen = RenderHelper.ToScreen(Vector3(x, center.Y, z))
	
	if screen ~= nil then
		table.insert(pts, screen)
	end

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircle(pts, size, RenderHelper.GetColorImVec4FromHexColorString(color), thickness, filled)
end

function RenderHelper.DrawWorldCircleFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segments = math.floor(size * 10)
local segmentSize = 360 / segments;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	
	if screen ~= nil then
		table.insert(pts, Vector2(screen.X, screen.Y))
	end

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
end

function RenderHelper.DrawWorldTriangleFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segmentSize = 360 / 3;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
pts = nil
end

function RenderHelper.DrawWorldTriangle(a, b, c, color, thickness, fill)
	local sA = RenderHelper.ToScreen(a)

	if sA == nil then
		return
	end

	local sB = RenderHelper.ToScreen(b)

	if sB == nil then
		return
	end

	local sC = RenderHelper.ToScreen(c)

	if sC == nil then
		return
	end

	Infinity.Rendering.DrawTriangle(ImVec2(sA.X, sA.Y), ImVec2(sB.X, sB.Y), ImVec2(sC.X, sC.Y), RenderHelper.GetColorImVec4FromHexColorString(color), thickness, fill)			
end

function RenderHelper.DrawWorldSquareFilledMulticolor(center, size, colorOutline, colorFill, thickness)
local pts = {}

local segmentSize = 360 / 4;

local sCenter = RenderHelper.ToScreen(center)
if sCenter == nil then
	pts = nil
	return
end

for angle = 0, 360, segmentSize do
	local x = center.X + (size * math.cos(angle / (180 / math.pi)))
	local y = center.Y + (size * math.sin(angle / (180 / math.pi)))

	local screen = RenderHelper.ToScreen(Vector3(x, y, center.Z))
	if screen == nil then
		return
	end

	table.insert(pts, Vector2(screen.X, screen.Y))

	angle = angle + segmentSize
end						

Infinity.Rendering.DrawWorldCircleFilledMulticolor(pts, size, RenderHelper.GetColorImVec4FromHexColorString(colorOutline), RenderHelper.GetColorImVec4FromHexColorString(colorFill), thickness)			
end

function RenderHelper.DrawWorldLine(from, to, color, thickness)
local sFrom = RenderHelper.ToScreen(from)
local sTo = RenderHelper.ToScreen(to)

if sFrom == nil or sTo == nil then
	return
end

Infinity.Rendering.DrawWorldLine(sFrom, sTo, RenderHelper.GetColorImVec4FromHexColorString(color), thickness)
end