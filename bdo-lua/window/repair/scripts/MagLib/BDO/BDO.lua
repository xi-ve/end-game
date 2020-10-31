--- Game related wrappers
-- @module MagLib.BDO
local BDO = {}

local delayAfterEnteringGame = 1500
local lastTimeNotInGame = 0

---Returns if we are in game or in a loading screen
-- @return bool: is true if the game world is loaded and false if we are in a loading screen
BDO.isInGame = function()
	local time = MagLib.getTime()
	local lp = BDO.Actors.LocalPlayer.get()
	local inGame = true
	if not lp then
		inGame = false
	end

	if not Infinity.BDO.Lua.Execute("return isLuaLoadingComplete") then
		inGame = false
	end

	if inGame == false then
		lastTimeNotInGame = time
		return false
	else
		if lastTimeNotInGame + delayAfterEnteringGame > time then
			return false
		else
			return true
		end
	end
end

---Returns game build number
-- @return number: build version
BDO.getGameVersion = function()
	return Infinity.BDO.Lua.Execute("return getVersion()");
end

---Returns current region key
-- @return number: region key
BDO.getCurrentRegionKey = function()
	return Infinity.BDO.Lua.Execute("return getCurrentWaypointKey()")
end

---Returns if you are currently in a safezone
---@return boolean true if you are currently in a safezone
function BDO.inSafezone()
	local code = [[
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  return regionInfo:get():isSafeZone()
]]

	return Infinity.BDO.Lua.Execute(code)
end

MagLib.BDO = BDO

-- Overwritting UniversalGameSpecificFunctions
local distanceToCamera = function(worldPos)
	return MagLib.BDO.Camera.getPos():getDistance(worldPos)
end
MagLib.GameFunctions.setDistanceFromCameraFunction(distanceToCamera)

local getPPos = function()
	return MagLib.BDO.Actors.LocalPlayer.getPos()
end
MagLib.GameFunctions.setGetPlayerPositionFunction(getPPos)

local shouldRenderEverything = function()
	return MagLib.BDO.Worldmap.isOpen()
end
MagLib.GameFunctions.setShouldRenderEverythingFunction(shouldRenderEverything)
