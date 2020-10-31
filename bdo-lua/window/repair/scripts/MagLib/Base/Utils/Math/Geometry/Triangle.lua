local Triangle = {}
local Math = MagLib.Utils.Math
local Vector = MagLib.Utils.Vector
--[[
  All functions in here regard triangles in a 3D Space but mostly use 2D math and some y coord checks to ensure functionality.
  Often you can define the y coord tollerance as an optional parameter, which has a default value
]]

local defaultYTollerance = 250

-- Utility function to calculate the are of a triangle
local area = function(p1, p2, p3)
	local x1 = p1.X
	local y1 = p1.Z
	local x2 = p2.X
	local y2 = p2.Z
	local x3 = p3.X
	local y3 = p3.Z

	return math.abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0)
end
Triangle.calculateArea = area

--[[
  A function to check whether a position lies inside a given 3D triangle
]]
Triangle.isPosInTriangle = function(triangle, pos, yTollerance)
	if yTollerance == nil then
		yTollerance = defaultYTollerance
	end
	local A = area(triangle[1], triangle[2], triangle[3])

	local A1 = area(pos, triangle[2], triangle[3])
	local A2 = area(triangle[1], pos, triangle[3])
	local A3 = area(triangle[1], triangle[2], pos)

	local averageTriangleY = MagLib.Utils.Math.average({triangle[1].Y, triangle[2].Y, triangle[3].Y})
	if math.abs(averageTriangleY - pos.Y) > yTollerance then
		return false
	end

	return (A == A1 + A2 + A3)
end

Triangle.rotate2D = function(triangle, phi)
	local c, s = math.cos(phi), math.sin(phi)
	local newTriangle = {}
	for k, v in pairs(triangle) do
		table.insert(newTriangle, Vector3(c * v.X - s * v.Z, v.Y, s * v.X + c * v.Z))
	end
	return newTriangle
end

Triangle.averagePos = function(triangle)
	local A = triangle[1]
	local B = triangle[2]
	local C = triangle[3]

	local averageX = Math.average({A.X, B.X, C.X})
	local averageY = Math.average({A.Y, B.Y, C.Y})
	local averageZ = Math.average({A.Z, B.Z, C.Z})

	return Vector3(averageX, averageY, averageZ)
end

Triangle.shift = function(triangle, vector)
	local newTriangle = {}
	newTriangle[1] = Vector.addition(triangle[1], vector)
	newTriangle[2] = Vector.addition(triangle[2], vector)
	newTriangle[3] = Vector.addition(triangle[3], vector)
	return newTriangle
end

---------------------Render stuff--------------
local moduleIndex = 0
Triangle.toRenderModule = function(triangle, lineColor)
	if lineColor == nil then
		lineColor = "FFF54242"
	end
	moduleIndex = moduleIndex + 1
	local module = MagLib.RenderManager.Module("Triangle Render Module #" .. moduleIndex)
	local j = 0
	for i = 1, 3 do
		if i == 1 then
			j = 3
		end

		local verticeI = triangle[i]
		local verticeJ = triangle[j]

		module.addLine(verticeI, verticeJ, lineColor, 3)
		j = i
	end

	return module

end

MagLib.Utils.Math.Geometry.Triangle = Triangle
