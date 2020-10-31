GameRegion = {}

function GameRegion.GetCount()
    return Infinity.BDO.Lua.Execute("return getRegionInfoCount()")
end

function GameRegion.GetAreaNameByIndex(regionInfoIndex)
    local code = [[
        local regionInfo = getRegionInfo(]] .. regionInfoIndex .. [[)

        if regionInfo == nil then
            return nil
        end

        return regionInfo:getAreaName()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetTerritoryKeyRawByIndex(regionInfoIndex)
    local code = [[
        local regionInfo = getRegionInfo(]] .. regionInfoIndex .. [[)

        if regionInfo == nil then
            return nil
        end

        return regionInfo:getTerritoryKeyRaw()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetRegionKeyByIndex(regionInfoIndex)
    local code = [[
        local regionInfo = getRegionInfo(]] .. regionInfoIndex .. [[)

        if regionInfo == nil then
            return nil
        end

        return regionInfo:getRegionKey()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.IsAccessibleAreaByIndex(regionInfoIndex)
    local code = [[
        local regionInfo = getRegionInfo(]] .. regionInfoIndex .. [[)

        if regionInfo == nil then
            return nil
        end

        return regionInfo:isAccessibleArea()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetTerritoryNameByIndex(regionInfoIndex)
    local code = [[
        local regionInfo = getRegionInfo(]] .. regionInfoIndex .. [[)

        if regionInfo == nil then
            return nil
        end

        return regionInfo:getTerritoryName()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetNPCCount(regionKey)
    return Infinity.BDO.Lua.Execute("return npcList_getNpcCount(" .. regionKey .. ")")
end

function GameRegion.GetNPCNameByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return npcInfo:getName()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.IsNPCActiveConditionByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return checkActiveCondition(npcInfo:getKeyRaw())
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.IsNPCImportantByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return npcInfo:isImportantNpc()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetNPCPositionXByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return npcInfo:getPosition().x
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetNPCPositionYByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return npcInfo:getPosition().y
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameRegion.GetNPCPositionZByIndex(index)
    local code = [[
        local npcInfo = npcList_getNpcInfo(]] .. index .. [[)

        if npcInfo == nil then
            return nil
        end

        return npcInfo:getPosition().z
    ]]

    return Infinity.BDO.Lua.Execute(code)
end