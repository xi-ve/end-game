---Game specific functions that need to be overwritten by the game specific implementations
---
-- worldToScreen. Returns screen position from world position
local GameFunctions = {}

GameFunctions.worldToScreen = function(worldPos)
	-- We assume RenderHelper will have a game specific implementation of ToScreen, hence most likely this will not need further overrides
	return RenderHelper.ToScreen(worldPos)
end

GameFunctions.setWorldToScreenFunction = function(func)
	GameFunctions.worldToScreen = func
	MagLib.Events.triggerEvent("WorldToScreenFunctionUpdated")
end

-- distanceFromCamera. Returns distance to camera from a world pos
GameFunctions.distanceFromCamera = function(worldPos)
	return 0
end

GameFunctions.setDistanceFromCameraFunction = function(func)
	GameFunctions.distanceFromCamera = func
	MagLib.Events.triggerEvent("DistanceToCameraFunctionUpdated")
end

--[[
  getPlayerPosition. Returns player position in the world.
  All Base Modules are suppose to handle both Vector2 and Vector3 returns from here.
  If there are errors with either Vector2 or Vector3 coming from a vector
  returned from this function it is suppose to be treated as a bug/needed adjustment
]]
GameFunctions.getPlayerPosition = function()
	return Vector3(0, 0, 0)
end

GameFunctions.setGetPlayerPositionFunction = function(func)
	GameFunctions.getPlayerPosition = func
	MagLib.Events.triggerEvent("GetPlayerPositionFunctionUpdated")
end

--[[
  shouldRenderEverything. Returns true if everything should be rendered from RenderModules.
  For example on the Worldmap in BDO.
  Should only return true if the current gamestate works properly with the worldToScreen function
]]
GameFunctions.shouldRenderEverything = function()
	return false
end

GameFunctions.setShouldRenderEverythingFunction = function(func)
	GameFunctions.shouldRenderEverything = func
	MagLib.Events.triggerEvent("ShouldRenderEverythingFunctionUpdated")
end

--[[
    IsKeyPressed. Returns true if a given keycode is currently pressed.
]]
GameFunctions.isKeyPressed = function(key)
	return false
end

GameFunctions.setIsKeyPressedFunction = function(func)
	GameFunctions.isKeyPressed = func
	MagLib.Events.triggerEvent("IsKeyPressedFunctionUpdated")
end

GameFunctions.keyDown = function(key)
end

GameFunctions.setKeyDownFunction = function(func)
	GameFunctions.keyDown = func
	MagLib.Events.triggerEvent("KeyDownFunctionUpdated")
end

GameFunctions.keyUp = function(key)
end

GameFunctions.setKeyUpFunction = function(func)
	GameFunctions.keyUp = func
	MagLib.Events.triggerEvent("KeyUpFunctionUpdated")
end

--[[
    Run whenever the InputModule finished it's run.
    @param keysThatAreCurrentlyPressed a list of keys that should currently be pressed by the InputModule.
]]
GameFunctions.inputModuleOnRun = function(keysThatAreCurrentlyPressed)
end

-- Event handler that calls the inputModuleOnRun function
local inputModuleOnRun_EventHandler = function(keysThatAreCurrentlyPressed)
	return GameFunctions.inputModuleOnRun(keysThatAreCurrentlyPressed)
end
MagLib.Events.addEventHandler("InputModuleOnRun", inputModuleOnRun_EventHandler)

GameFunctions.setInputModuleOnRunFunction = function(func)
	GameFunctions.inputModuleOnRun = func
	MagLib.Events.triggerEvent("InputModuleOnRunFunctionUpdated")
end

MagLib.GameFunctions = GameFunctions
