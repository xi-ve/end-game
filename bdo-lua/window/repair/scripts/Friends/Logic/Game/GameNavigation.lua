GameNavigation = {}

function GameNavigation.MoveTo(x, y, z)
    local code = [[
        ToClient_WorldMapNaviStart(float3(]] .. x .. [[, ]] .. y .. [[, ]] .. z .. [[), NavigationGuideParam(), false, true)
        ToClient_NaviReStart()
    ]]

    Infinity.BDO.Lua.Execute(code)
end