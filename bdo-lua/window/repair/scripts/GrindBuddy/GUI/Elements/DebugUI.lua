--[[DebugUI = {}

local _ = nil
local _Grinder = nil
local _Cache = nil

function DebugUI.init()
    _Grinder = Grinder
    _Cache = Cache
end


DebugUI.raycastCheckDest = nil
DebugUI.raycastCheckSafe = true

DebugUI.combo1Index = -1
DebugUI.combo2Index = -1

DebugUI.actorName = nil
DebugUI.actorKey = nil
DebugUI.actorType = nil
DebugUI.actorDistance = nil
DebugUI.npcInfo = ""

DebugUI.testNavDest = Vector3(0, 0, 0)
]]


--[[function DebugUI.draw(newWindow)
    if newWindow == nil then
        newWindow = true
    end
    if newWindow then
        ImGui.Begin("[Grinder] Debug")
    end

    if ImGui.SmallButton("Export global variables") then
        exportGlobals()
    end

    if ImGui.Button("Run ChooseIfTownRun once (Won't do anything for u ^^)") then
        ChooseIfTownRunTask.work()
    end

    _, _Grinder.settings.log_debug = ImGui.Checkbox("Debug log (FPS drop)", _Grinder.settings.log_debug)

    ImGui.Separator()
    _, _Grinder.settings.draw_debug_freeMoveTask = ImGui.Checkbox("Render freemoving nodes (FPS drop)", _Grinder.settings.draw_debug_freeMoveTask)
    ImGui.Separator()

    if ImGui.Button("FreeMove Test") then
        local pp = _Cache.playerPos
        local randomPos = Vector3(pp.X + math.random(-1000, 1000), pp.Y, pp.Z + math.random(-1000, 1000))
        local canMoveFree = FreeMoveTask.init(randomPos)
    end

    ImGui.Separator()
    ImGui.Text("Raycast Check:")
    ImGui.SameLine()
    if DebugUI.raycastCheckDest then
        ImGui.InputText("", VectorUtils.toString(DebugUI.raycastCheckDest))
    end

    if ImGui.SmallButton("Set Pos") then
        DebugUI.raycastCheckDest = _Cache.playerPos
    end
    ImGui.SameLine()
    if ImGui.SmallButton("Reset") then
        DebugUI.raycastCheckDest = nil
    end
    _, DebugUI.raycastCheckSafe = ImGui.Checkbox("Raycast Check: Safe raycast (stricter)", DebugUI.raycastCheckSafe)

    ImGui.Separator()

]]

--[[
    ImGui.Separator()

    if DebugUI.actorKey and ActorUtils.getActor(DebugUI.actorKey) then
        DebugUI.npcInfo = tostring(DebugUI.actorName) .. " | Key: " .. tostring(DebugUI.actorKey) .. " | Type: " .. tostring(DebugUI.actorType) .. " | Distance: " .. ActorUtils.getActor(DebugUI.actorKey):getPosition():getDistance(_Cache.playerPos)
    else
        DebugUI.npcInfo = ""
    end
    ImGui.Text("Closest Actor: " .. DebugUI.npcInfo)
    ImGui.SameLine()
    if ImGui.Button("Refresh") then
        DebugUI.actorName, DebugUI.actorKey, DebugUI.actorType, DebugUI.actorDistance = ActorUtils.getClosestActorInfo()
    end
    if DebugUI.actorKey then
        if ImGui.Button("Request Shopitems") then
            Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
        end
        if ImGui.Button("Sell first slot once") then
            Infinity.BDO.Lua.Execute([[getSelfPlayer():get():requestSellItem(2, 1, CppEnums.ItemWhereType.eInventory, CppEnums.ItemWhereType.eWarehouse, false)]] --[[)

end
end

ImGui.Separator()
ImGui.Text("Test navigation (using nodes):")
ImGui.Text("Dest: " .. VectorUtils.toString(DebugUI.testNavDest))
if ImGui.Button("Set Dest") then
DebugUI.testNavDest = _Cache.playerPos
end
ImGui.SameLine()
if ImGui.Button("Start nav") then
_Grinder.currentlyTestingNav = true
_Grinder.currentDest = DebugUI.testNavDest
_Grinder.currentDestIsNode = true
end

if newWindow then
ImGui.End()
end
end

function exportGlobals()
local fileName = "globalsDump.txt"
local content = table.toString(_G)
Infinity.FileSystem.WriteFile(fileName, content)
end
]]
