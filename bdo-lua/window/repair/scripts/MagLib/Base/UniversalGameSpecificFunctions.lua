---Game specific functions that need to be overwritten by the game specific implementations
---
-- WorldToScreen. Returns screen position from world position
local GameFuncOverride = {}
WorldToScreen = function(worldPos)
	-- We assume RenderHelper will have a game specific implementation of ToScreen, hence most likely this will not need further overrides
	return RenderHelper.ToScreen(worldPos)
end

GameFuncOverride.SetWorldToScreenFunction = function(func)
	WorldToScreen = func
	MagLib.Events.triggerEvent("WorldToScreenFunctionUpdated")
end

-- DistanceFromCamera. Returns distance to camera from a world pos
DistanceFromCamera = function(worldPos)
	return 0
end

GameFuncOverride.SetDistanceFromCameraFunction = function(func)
	DistanceFromCamera = func
	MagLib.Events.triggerEvent("DistanceToCameraFunctionUpdated")
end

--[[
  GetPlayerPosition. Returns player position in the world.
  All Base Modules are suppose to handle both Vector2 and Vector3 returns from here.
  If there are errors with either Vector2 or Vector3 coming from a vector
  returned from this function it is suppose to be treated as a bug/needed adjustment
]]
GetPlayerPosition = function()
	return Vector3(0, 0, 0)
end

GameFuncOverride.SetGetPlayerPositionFunction = function(func)
	GetPlayerPosition = func
	MagLib.Events.triggerEvent("GetPlayerPositionFunctionUpdated")
end

MagLib.UniversalGameFunctions = GameFuncOverride

--[[
  ShouldRenderEverything. Returns true if everything should be rendered from RenderModules.
  For example on the Worldmap in BDO.
  Should only return true if the current gamestate works properly with the WorldToScreen function
]]
ShouldRenderEverything = function()
	return false
end

GameFuncOverride.SetShouldRenderEverythingFunction = function(func)
	ShouldRenderEverything = func
	MagLib.Events.triggerEvent("ShouldRenderEverythingFunctionUpdated")
end
