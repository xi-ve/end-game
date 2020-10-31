Game = {}

function Game.isWorldmapOpen()
    --Log.debugLog("Game isWorldmapOpen")
    local isWorldmapOpen = Infinity.BDO.Lua.Execute("return ToClient_WorldMapIsShow()")
    return isWorldmapOpen
end

function Game.inSafezone()
    local code = [[
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    return regionInfo:get():isSafeZone()
  ]]

    return Infinity.BDO.Lua.Execute(code)
end
