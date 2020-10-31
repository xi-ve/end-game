local Vector = MagLib.Utils.Vector
local Math = MagLib.Utils.Math
--[[
This Implementations of 3D Polygon related functions often ignores the Y value at first and then arbitrarily tests for a y difference based on the closest corners.
This means it is not a mathematically correct Polygon, but works in most cases. It does not work well for:
  -> Vertical Polygons, it is meant for flat poligons regarding the Y-Axis, where the Y-Axis changes are small, like for a navigation mesh or the grind areas
]]
------------------IndexedPoly START(Only for local use)----------------------

local function normalize_index(index, max_index)
	return (index - 1) % max_index + 1
end

local IndexedPoly = {}
IndexedPoly.__index = IndexedPoly

function IndexedPoly:previous(index)
	return self.previous_index[index] or normalize_index(index - 1, self.chain_size)
end

function IndexedPoly:next(index)
	return self.next_index[index] or normalize_index(index + 1, self.chain_size)
end

function IndexedPoly:getTriangleIndexes(index, revert)
	if revert then
		return {self:next(index), normalize_index(index, self.chain_size), self:previous(index)}
	else
		return {self:previous(index), normalize_index(index, self.chain_size), self:next(index)}
	end
end

function IndexedPoly:remove(index)
	local n = self:next(index)
	local p = self:previous(index)
	self.next_index[p] = n
	self.previous_index[n] = p
	self.next_index[index] = nil
	self.previous_index[index] = nil
end

function IndexedPoly.new(chain_size)
	local indexedPoly = {chain_size = chain_size, previous_index = {}, next_index = {}}
	return setmetatable(indexedPoly, IndexedPoly)
end
------------------IndexedPoly END(Only for local use)----------------------

local Polygon = {}

-- Function that checks if a triangle in a polygon is an ear
local function checkEar(vertices, triangle, reflexVertices)
	for j, _ in pairs(reflexVertices) do
		-- compute zcross_product for j and each edges of the triangle (i-1, i, i+1)
		-- check j is not inside the triangle (i-1, i, i+1)
		-- to be checked
		if Polygon.computeZCrossProduct(vertices, j, triangle[2], triangle[3]) > 0 and
			Polygon.computeZCrossProduct(vertices, j, triangle[3], triangle[1]) > 0 and
			Polygon.computeZCrossProduct(vertices, j, triangle[1], triangle[2]) > 0 then
			return false
		end
	end
	return true
end

Polygon.toTriangles = function(vertices)
	local polySurface = 0
	local coordCount = #vertices
	local indexedPoly = IndexedPoly.new(coordCount)
	local reflexVertices = {}
	local convexVertices = {}
	local earVertices = {}

	-- first phase :
	-- 1) separate reflex and convex vertices.
	-- 2) compute polygon surface to determine vertex chain winding.
	local j = coordCount
	for i = 1, coordCount do
		-- dot product of the z component
		local z = Polygon.computeZCrossProduct(vertices, j, i, i + 1)
		if z < 0 then
			reflexVertices[i] = 1
		else
			convexVertices[i] = 1
		end
		polySurface = polySurface + Polygon.computeSubSurface(vertices, i, i + 1)
		j = i
	end

	local sign = polySurface < 0 and -1 or 1

	-- is it ok if sign == 0 for a given reflex vertex ?
	if sign < 0 then
		reflexVertices, convexVertices = convexVertices, reflexVertices
	end

	-- second phase : identify ears
	local earTips = {}
	for i, _ in pairs(convexVertices) do
		if checkEar(vertices, indexedPoly:getTriangleIndexes(i, sign < 0), reflexVertices) then
			-- print("Ear at #" .. i)
			table.insert(earTips, i)
			earVertices[i] = 1
		end
	end

	if #earTips == 0 then
		print("No ears found!")
		return
	else
		-- print("Found " .. #earTips .. " ears!")
	end
	local triangles = {}

	-- third phase : extract triangles
	for i = 1, coordCount - 2 do
		local earIndex
		-- print("i: " .. i)
		if i % 2 == 1 then
			-- print("this1")
			earIndex = earTips[1]
			table.remove(earTips, 1)
		else
			-- print("this2")
			earIndex = earTips[#earTips]
			table.remove(earTips)
		end
		-- print("earIndex: " .. tostring(earIndex))
		convexVertices[earIndex] = nil
		earVertices[earIndex] = nil

		local triangle = indexedPoly:getTriangleIndexes(earIndex, sign < 0)

		table.insert(triangles, triangle)

		indexedPoly:remove(earIndex)

		for pos, index in ipairs{triangle[1], triangle[3]} do
			triangle = indexedPoly:getTriangleIndexes(index, sign < 0)
			if reflexVertices[index] and Polygon.computeZCrossProduct(vertices, triangle[1], triangle[2], triangle[3]) >= 0 then
				reflexVertices[index] = nil
				convexVertices[index] = 1
			end
			if convexVertices[index] and checkEar(vertices, triangle, reflexVertices) then
				if not earVertices[index] then
					table.insert(earTips, (pos == 1 and 1 or #earTips), index)
					earVertices[index] = 1
				end
			elseif earVertices[index] then
				for i2, j2 in ipairs(earTips) do
					if j2 == index then
						table.remove(earTips, i)
						break
					end
				end
				earVertices[index] = nil
			end
		end
	end

	local triangles_Vectors = {}
	for _, tri in pairs(triangles) do
		local A = vertices[tri[1]]
		local B = vertices[tri[2]]
		local C = vertices[tri[3]]
		table.insert(triangles_Vectors, {A, B, C})
	end
	return triangles_Vectors
end

Polygon.computeSubSurface = function(poly, i1, i2)
	local verticeCount = #poly
	local ver1 = poly[normalize_index(i1, verticeCount)]
	local ver2 = poly[normalize_index(i2, verticeCount)]

	local x1 = ver1.X
	local z1 = ver1.Z
	local x2 = ver2.X
	local z2 = ver2.Z

	return (x2 - x1) * (z2 + z1)
end

Polygon.getWalls = function(vertices)
	local walls = {}
	local amountOfVertices = #vertices
	local j = 0
	for i = 1, amountOfVertices do
		if i == 1 then
			j = amountOfVertices
		end

		local verticeI = vertices[i]
		local verticeJ = vertices[j]

		table.insert(walls, {from = verticeI, to = verticeJ})
		i = j
	end

	return walls
end

Polygon.computeZCrossProduct = function(poly, i1, i2, i3)
	-- print(i1 .. ", " .. i2 .. ", " .. i3)
	-- print(#poly)
	local verticeCount = #poly
	local ver1 = poly[normalize_index(i1, verticeCount)]
	local ver2 = poly[normalize_index(i2, verticeCount)]
	local ver3 = poly[normalize_index(i3, verticeCount)]

	local x1 = ver1.X
	local z1 = ver1.Z
	local x2 = ver2.X
	local z2 = ver2.Z
	local x3 = ver3.X
	local z3 = ver3.Z

	return (x1 - x2) * (z3 - z2) - (z1 - z2) * (x3 - x2)
end

Polygon.isConvex = function(vertices)
	local coordCount = #vertices
	local j = coordCount
	local zsign = 0

	for i = 1, coordCount do
		local zcross = Polygon.computeZCrossProduct(vertices, j, i, i + 1)
		if zsign == 0 then
			zsign = zcross
		elseif zsign * zcross < 0 then
			return false
		end
		j = i
	end

	return true
end

Polygon.isInPolygon = function(vertices, vecToPos, yAxisMaxDiff)
	local result = false
	local amountOfVertices = #vertices
	local j = 0
	local skipNext = false
	for i = 1, amountOfVertices do
		if i == 1 then
			j = amountOfVertices
		end
		if not skipNext then
			local verticeI = vertices[i]
			local verticeJ = vertices[j]
			local polygonWall = Vector.sub(verticeI, verticeJ)

			-- Taking 1 / 3 the average of the walls y and 2 / 3 the vecToPos y.
			local checkStart = Vector3(0, (verticeI.Y + verticeJ.Y + 4 * vecToPos.Y) / 6, 0)
			local checkVec = Vector3(vecToPos.X, 0, vecToPos.Z)
			local collision2D, collisionY, lambda, mue = Vector.twoLinesCollide(verticeJ, polygonWall, checkStart, checkVec,
                                                                    			yAxisMaxDiff)
			lambda = Math.round(lambda, 3)
			mue = Math.round(mue, 6)

			if collision2D and collisionY and lambda >= 0 and lambda <= 1.0 and mue >= 0 and mue <= 1.0 then
				if lambda == 1 then
					skipNext = true
				end

				result = not result
			end
		else
			skipNext = false
		end

		j = i
	end

	return result
end

local moduleIndex = 0
Polygon.toRenderModule = function(vertices, lineColor)
	if lineColor == nil then
		lineColor = "FF552583"
	end
	moduleIndex = moduleIndex + 1
	local module = MagLib.RenderManager.Module("Polygon Render Module #" .. moduleIndex)
	local amountOfVertices = #vertices
	local j = 0
	for i = 1, amountOfVertices do
		if i == 1 then
			j = amountOfVertices
		end

		local verticeI = vertices[i]
		module.addText("Vertice #" .. i, 20, lineColor, verticeI, 0, math.random(-50, 0))
		local verticeJ = vertices[j]
		module.addLine(verticeI, verticeJ, lineColor, 3)
		j = i
	end

	return module
end

Polygon.equals = function(poly1, poly2)
	local polyLength = #poly1
	if polyLength ~= #poly2 then
		return false
	end

	-- Finding poly1[1] in poly2
	local startIndexPoly1 = 1
	local startIndexPoly2 = nil

	local tmp = poly1[1]
	for k, v in pairs(poly2) do
		if Vector.equals(v, tmp) then
			startIndexPoly1 = k
			break
		end
	end

	if startIndexPoly2 == nil then
		return false
	end

	-- Iterate over poly1 and compare with poly2 counterpart
	for k, v in pairs(poly1) do
		local poly2Index = startIndexPoly2 + k
		if poly2Index > polyLength then
			poly2Index = poly2Index - polyLength
		end
		local poly2Part = poly2[poly2Index]
		if not Vector.equals(v, poly2Part) then
			return false
		end
	end

	-- Is the same
	return true
end

MagLib.Utils.Math.Geometry.Polygon = Polygon
