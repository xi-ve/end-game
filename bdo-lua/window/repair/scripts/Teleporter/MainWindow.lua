MainWindow = { }

local TP_X = "0"
local TP_Y = "0"
local TP_Z = "0"

MainWindow.offset_vectors = {}
MainWindow.offset_time = 0
MainWindow.opCode = 0

MainWindow.TP_Packet = DoActionTeleport():construct(0,0,0)

MainWindow.CrossHair_AutoPort = false
MainWindow.CrossHair_AutoPort_PlayerDetection = false
MainWindow.CrossHair_AutoPort_Delay = 150
MainWindow.CrossHair_AutoPort_LastTick = 0
MainWindow.CrossHair_AutoPort_AutoDelay = true

local reverse_path = false
local keepSpacePressed = false
local offsetHeight = 50

local gotocharacterselect = true

function MainWindow.DrawMainWindow()
    ImGui.Begin("Teleporter")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
    
    if ImGui.TreeNode("Manual Position##manual_position") then

        _, TP_X = ImGui.InputText("X##x", TP_X)
        _, TP_Y = ImGui.InputText("Y##y", TP_Y)
        _, TP_Z = ImGui.InputText("Z##z", TP_Z)

        if ImGui.Button("Current Pos") then
            local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

            TP_X = tostring(lpPos.X)
            TP_Y = tostring(lpPos.Y)
            TP_Z = tostring(lpPos.Z)
        end

        if ImGui.Button("Teleport to Coords") then        
            MainWindow.teleportToCoords(tonumber(TP_X), tonumber(TP_Y), tonumber(TP_Z), true)
        end
                
        ImGui.TreePop()
    end

    if ImGui.TreeNode("CrossHair Position##crosshair_position") then

        local chPos = Infinity.BDO.getLocalPlayer():getCrossHairPosition()

        ImGui.Text("X: " .. chPos.X)
        ImGui.Text("Y: " .. chPos.Y)
        ImGui.Text("Z: " .. chPos.Z)        
                
        if ImGui.Button("Teleport to Coords") then        
            MainWindow.teleportToCoords(chPos.X, chPos.Y, chPos.Z, true)
        end

        ImGui.SameLine()

        _, MainWindow.CrossHair_AutoPort = ImGui.Checkbox("Auto##autoport_crosshair", MainWindow.CrossHair_AutoPort)
        ImGui.SameLine()
        _, MainWindow.CrossHair_AutoPort_PlayerDetection = ImGui.Checkbox("Player Detection##autoport_crosshair_player_detection", MainWindow.CrossHair_AutoPort_PlayerDetection)
        ImGui.Text("Hold KeyCode_F7 to toggle Auto mode manually via hotkey")

        _, MainWindow.CrossHair_AutoPort_Delay = ImGui.SliderInt("Auto Delay##autoport_crosshair_delay", MainWindow.CrossHair_AutoPort_Delay, 10, 1000)
        _, MainWindow.CrossHair_AutoPort_AutoDelay = ImGui.Checkbox("Auto Delay##autoport_crosshair_auto_delay", MainWindow.CrossHair_AutoPort_AutoDelay)

        ImGui.TreePop()
    end

    if ImGui.TreeNode("Pathing##pathing") then

        if ImGui.Button("Show Navigator") then

            if not Teleporter.Navigator.ShowGui then
                Teleporter.Navigator.ShowGui = true
            end
        end

        _, Teleporter.Delay = ImGui.SliderInt("Delay##delay", Teleporter.Delay, 10, 1000)
        _, Teleporter.AutoDelay = ImGui.Checkbox("Auto Delay##auto_delay", Teleporter.AutoDelay)

        ImGui.Text("~0.3ms per Checkpoint Distance Unit")
        ImGui.Text("(500 Checkpoint Distance requires ~150ms)")
        ImGui.Text("(250 Checkpoint Distance requires ~75ms)")

        ImGui.Spacing()

        _, offsetHeight = ImGui.SliderFloat("[Path] Height Offset##cp_offset_height", offsetHeight, 0, 10000)

        if ImGui.Button("Teleport Path") then        
            MainWindow.teleportPathInit()
        end

        ImGui.SameLine()

        if ImGui.Button("Stop TP##pathing_stop_tp") then        
            Teleporter.StopTeleportPath()
        end

        ImGui.SameLine()

        _, reverse_path = ImGui.Checkbox("Reverse path##reverse_path", reverse_path)

        --_, keepSpacePressed = ImGui.Checkbox("Hold SPACE##hold_space", keepSpacePressed)

        if ImGui.Button("Import NavPath") then
            if NavigatorUtils.hasNavPath() then
            
                Teleporter.Navigator.CurrentProfile.Checkpoints = {}

			    local nPath = NavigatorUtils.getNavPath()
                local nPathCount = table.length(nPath)
                for i=1,nPathCount do
				
				    local previousNode = nil
				    local currentNode = nPath[i]
				    local nextNode = nil

				    if i > 1 then
				    	previousNode = nPath[i - 1]
				    end

                    if i < nPathCount then
                        nextNode = nPath[i + 1]
                    end

                    if nextNode ~= nil then

                        local dstNextNode = currentNode:getDistance(nextNode)

                        if dstNextNode > 1500 then

                            local stepSize = math.floor(dstNextNode / 1500)

                            local currentStepNode = currentNode

                            table.insert(Teleporter.Navigator.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentStepNode))

                            local newStepDist = dstNextNode / stepSize
                            
                            for step=1,stepSize do							
                                
                                local lerpPct =  (newStepDist * step) / dstNextNode

                                currentStepNode = currentNode:Lerp(currentNode, nextNode, lerpPct)

                                table.insert(Teleporter.Navigator.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentStepNode))
                            end
                        else

                            table.insert(Teleporter.Navigator.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentNode))
                        end
                    else

                        table.insert(Teleporter.Navigator.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentNode))
                    end
                end
            end
        end

        ImGui.SameLine()
        if ImGui.Button("Instant TP") then        
            MainWindow.teleportInstantPath()
        end

        ImGui.SameLine()

        _, gotocharacterselect = ImGui.Checkbox("Go to Character Select##gotocharacterselect", gotocharacterselect)
                

        
	    
        ImGui.TreePop()
    end
    
   
    ImGui.End()
end

local startIndex = 1
local stopIndex = 1

MainWindow.teleport_begin = false

function MainWindow.teleportInstantPath()
    local cpLength = table.length(Teleporter.Navigator.CurrentProfile.Checkpoints)

    local closestNode = NavigatorUtils.GetClosestCheckpointByJSONTable(Teleporter.Navigator.CurrentProfile.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition())

    if closestNode == nil then
        print("Cant find closest Node!")
        return
    end

    local start = 0
    local stop = 0
    local step = 1

    if reverse_path then
        start = closestNode.Index
        stop = 1 
        step = -1       
    else
        start = closestNode.Index
        stop = cpLength
    end

    --print("Start: " .. start .. " Stop: " .. stop)

    for i = start, stop, step do        
        local v = Teleporter.Navigator.CurrentProfile.Checkpoints[i]
    
        MainWindow.TP_Packet:update(v.X,v.Y + offsetHeight,v.Z).Packet:send()
    end
    
    if gotocharacterselect then
        Infinity.BDO.Lua.Execute("PaGlobal_GameExit_All_GoToCharacterSelect()")
    end
end

function MainWindow.teleportPathInit()
    if Teleporter.Navigator.CurrentProfile == nil then
        print("No Navigator Profile Loaded!")
        return
    end

    local cpLength = table.length(Teleporter.Navigator.CurrentProfile.Checkpoints)

    local closestNode = NavigatorUtils.GetClosestCheckpointByJSONTable(Teleporter.Navigator.CurrentProfile.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition())

    if closestNode == nil then
        print("Cant find closest Node!")
        return
    end

    if reverse_path then
        startIndex = closestNode.Index
        stopIndex = 1
    else
        startIndex = closestNode.Index
        stopIndex = cpLength
    end

    MainWindow.teleport_begin = true    
end

function MainWindow.processNextNode()
    --local closestNode = NavigatorUtils.GetClosestCheckpointByJSONTable(Teleporter.Navigator.CurrentProfile.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition())

    --if closestNode.Index ~= startIndex then

        --print("set new startIndex - closestNode.Index: " .. closestNode.Index .. " startIndex: " .. startIndex)
        --startIndex = closestNode.Index
    --end

    local curPos = NavigatorUtils.TableToVec3(Teleporter.Navigator.CurrentProfile.Checkpoints[startIndex])

    local stepDist = Infinity.BDO.getLocalPlayer():getPosition():getDistance2D(curPos)

    --print(startIndex)

    if stepDist <= 100 then
        MainWindow.nextPathStep()

        --print(startIndex)

        if Teleporter.AutoDelay then

            curPos = NavigatorUtils.TableToVec3(Teleporter.Navigator.CurrentProfile.Checkpoints[startIndex])
            stepDist = Infinity.BDO.getLocalPlayer():getPosition():getDistance2D(curPos)

            Teleporter.Delay = math.floor(stepDist * 0.3)
        end
    end
end

function MainWindow.nextPathStep()
    if reverse_path then
        startIndex = startIndex - 1

        if startIndex < stopIndex then
            startIndex = 1
            stopIndex = 1
            MainWindow.teleport_begin = false            
            --Infinity.BDO.Input.clearQueue()
        end
    else
        startIndex = startIndex + 1

        if startIndex > stopIndex then
            startIndex = 1
            stopIndex = 1
            MainWindow.teleport_begin = false            
            --Infinity.BDO.Input.clearQueue()
        end
    end
end

function MainWindow.teleportPathStep()    
    local v = Teleporter.Navigator.CurrentProfile.Checkpoints[startIndex]

    MainWindow.teleportToCoords(v.X, v.Y + offsetHeight, v.Z, false)    
end

function MainWindow.teleportToCoords(x, y, z, keysOnce)   
    
    Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(Vector3(x,y,z))

    --[[if keysOnce then

        Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 10)    
    else

        if keepSpacePressed then

            Infinity.BDO.Input.PressKeys_Down({KeyCode_SPACE})    
        end
    end]]--
end