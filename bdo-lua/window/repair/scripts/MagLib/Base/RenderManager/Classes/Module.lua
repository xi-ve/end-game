---A RenderModule caches geometric objects and the Handler will render all of them every pulse
local indexCounter = 0
local settings = {}

-- Helper stuff
local Vector

local worldToScreen = MagLib.GameFunctions.worldToScreen
MagLib.Events.addEventHandler("WorldToScreenFunctionUpdated", function()
	worldToScreen = worldToScreen
end)

local distanceFromCamera = MagLib.GameFunctions.distanceFromCamera
MagLib.Events.addEventHandler("DistanceToCameraFunctionUpdated", function()
	distanceFromCamera = distanceFromCamera
end)

local getPlayerPosition = MagLib.GameFunctions.getPlayerPosition
MagLib.Events.addEventHandler("GetPlayerPositionFunctionUpdated", function()
	getPlayerPosition = getPlayerPosition
end)

local shouldRenderEverything = MagLib.GameFunctions.shouldRenderEverything
MagLib.Events.addEventHandler("ShouldRenderEverythingFunctionUpdated", function()
	shouldRenderEverything = shouldRenderEverything
end)

-- OnInit, setting Vector helping var and settings handler
local onInit = function()
	Vector = MagLib.Utils.Vector
	MagLib.Core.Settings.addSettingsToHandler("MagLib_RenderModules", settings)
end
MagLib.Events.addEventHandler("OnInit_Base", onInit)

MagLib.RenderManager.Module = function(name)
	indexCounter = indexCounter + 1
	local Module = {name = name, index = indexCounter, active = false, renderDistance = 5000}
	Module = setmetatable(Module, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__tostring = function(n)
			return "RenderModule " .. n.name
		end
	})

	Module.activate = function()
		Module.active = true
	end

	Module.deactivate = function()
		Module.active = false
	end

	local lines = {}
	local circles = {}
	local rects = {}
	local texts = {}
	local triangles = {}
	local indicators = {}
	local arrows = {}
	local polygons = {}

	Module.clear = function()
		lines = {}
		circles = {}
		rects = {}
		texts = {}
		triangles = {}
		arrows = {}
		indicators = {}
		polygons = {}
	end

	Module.clearLines = function()
		lines = {}
	end

	Module.clearCircles = function()
		circles = {}
	end

	Module.clearRects = function()
		rects = {}
	end

	Module.clearTexts = function()
		texts = {}
	end

	Module.clearTriangles = function()
		triangles = {}
	end

	Module.clearIndicators = function()
		indicators = {}
	end

	Module.clearArrows = function()
		arrows = {}
	end

	Module.clearPolygons = function()
		polygons = {}
	end

	Module.getData = function()
		return {
			lines = lines,
			circles = circles,
			rects = rects,
			texts = texts,
			triangles = triangles,
			indicators = indicators,
			arrows = arrows,
			polygons = polygons
		}
	end

	Module.combineWith = function(otherModule)
		local data = otherModule.getData()

		for _, v in pairs(data.lines) do
			table.insert(lines, v)
		end

		for _, v in pairs(data.circles) do
			table.insert(circles, v)
		end

		for _, v in pairs(data.rects) do
			table.insert(rects, v)
		end

		for _, v in pairs(data.texts) do
			table.insert(texts, v)
		end

		for _, v in pairs(data.triangles) do
			table.insert(triangles, v)
		end

		for _, v in pairs(data.indicators) do
			table.insert(indicators, v)
		end

		for _, v in pairs(data.arrows) do
			table.insert(arrows, v)
		end

		for _, v in pairs(data.polygons) do
			table.insert(polygons, v)
		end
	end

	Module.addLine = function(from, to, color, thickness)
		-- default values
		color = color or MagLib.Utils.Colors.White
		thickness = thickness or 1

		table.insert(lines, {from = from, to = to, color = color, thickness = thickness})
	end

	---Adds a circle to the RenderModule
	---@param center Vector3 The center of the circle in the 3D world
	---@param radius number the radius of the circle
	---@param color string the color to render the circle in
	---@param thickness number the thickness of the outer circle line
	---@param fill boolean if the circle should be filled with color or not
	---@param unroundness number the higher the more edges the circle will have (360/unroundness). unroundness must be a divider of 360, so 360%unroundness == 0
	Module.addCircle = function(center, radius, color, thickness, filled, unroundness)
		-- default values
		color = color or MagLib.Utils.Colors.White
		thickness = thickness or 1
		unroundness = unroundness or 20
		if filled == nil then
			filled = false
		end

		if not MagLib.Utils.Math.divides(unroundness, 360) then
			MagLib.logger.error("RenderModule.addCircle's unroundess parameter must be a divider of 360")
			unroundness = 20 -- default value
		end

		-- Calculating every point in the circle preemtively and only once, this is good for performance if renderModules are not updated every pulse
		local points = {}

		local X, Z
		for angle = 0, 360, unroundness do
			X = center.X + (radius * math.cos(angle / (180 / math.pi)))
			Z = center.Z + (radius * math.sin(angle / (180 / math.pi)))

			table.insert(points, Vector3(X, center.Y, Z))
		end

		table.insert(circles, {
			center = center,
			radius = radius,
			points = points,
			color = color,
			thickness = thickness,
			filled = filled
		})
	end

	Module.addRect = function(center, size, color, thickness, filedl)
	end

	Module.addText = function(text, size, color, pos, offsetX, offsetY)
		table.insert(texts, {text = text, size = size, color = color, pos = pos, offsetX = offsetX, offsetY = offsetY})
	end

	Module.addHorizontalArrow = function(start, towards, length, color, thickness)
		local arrow = MagLib.Utils.Math.Geometry.Arrow.HorizontalArrow(start, towards, length, color, thickness)
		table.insert(arrows, {arrow = arrow, start = start, color = color, thickness = thickness})
	end

	Module.addPlayerCentricIndicator = function(towards, indicatorMaxLength, color, thickness)
		table.insert(indicators, {
			fromPlayer = true,
			from = nil,
			towards = towards,
			indicatorMaxLength = indicatorMaxLength,
			color = color,
			thickness = thickness
		})
	end

	Module.addConvexPolygon = function(points, color, thickness, filled)
		table.insert(polygons, {points = points, color = color, thickness = thickness, filled = filled})
	end

	Module.render = function()
		local renderDistance
		if not shouldRenderEverything() then
			renderDistance = Module.renderDistance
		else
			renderDistance = 1 / 0
		end

		for _, v in pairs(lines) do
			if distanceFromCamera(v.from) < renderDistance or distanceFromCamera(v.to) < renderDistance then
				RenderHelper.DrawWorldLine(v.from, v.to, v.color, v.thickness)
			end
		end

		for _, v in pairs(circles) do
			if distanceFromCamera(v.center) < renderDistance then
				local onScreenPoints = {}
				local pointScreenPos = nil

				for _, point in pairs(v.points) do
					pointScreenPos = worldToScreen(point)
					if pointScreenPos then
						table.insert(onScreenPoints, pointScreenPos)
					end
				end

				Infinity.Rendering.DrawWorldCircle(onScreenPoints, v.radius, RenderHelper.GetColorImVec4FromHexColorString(v.color),
                                   				v.thickness, v.filled)
			end
		end

		for _, v in pairs(rects) do

		end

		for _, v in pairs(texts) do
			if distanceFromCamera(v.pos) < renderDistance then
				RenderHelper.DrawWorldText(v.text, v.size, v.color, v.pos, v.offsetX, v.offsetY)
			end
		end

		for _, v in pairs(arrows) do
			if distanceFromCamera(v.start) < renderDistance then
				v.arrow:draw(v.color, v.thickness)
			end
		end

		local pPos = getPlayerPosition()
		for _, v in pairs(indicators) do
			local startPos = v.from
			if v.fromPlayer then
				startPos = pPos
			end

			local distance = startPos:getDistance(v.towards)
			local lengthDivider = renderDistance / v.indicatorMaxLength
			local length = distance / lengthDivider

			MagLib.Utils.Math.Geometry.Arrow.HorizontalArrow(startPos, v.towards, length):draw(v.color, v.thickness)
		end

		for _, v in pairs(polygons) do
			local onScreenPoints = {}
			local points = v.points

			for _, point in ipairs(points) do
				local screenPos = RenderHelper.ToScreen(point)
				if screenPos ~= nil then
					table.insert(onScreenPoints, screenPos)
				end
			end

			Infinity.Rendering.DrawWorldCircle(onScreenPoints, 100, RenderHelper.GetColorImVec4FromHexColorString(v.color),
                                   			v.thickness, v.filled)
		end
	end

	return Module
end
