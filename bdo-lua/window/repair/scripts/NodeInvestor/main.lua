Bot = {}

function Bot.OnAutoLoginAutoLoad()
    Bot.Start = true
end

function Bot.GetEnergy()
    return tonumber(Infinity.BDO.Lua.Execute([[return getSelfPlayer():getWp()]])) or 0
end

function Bot.IsMaxLevel()
    --return Infinity.BDO.Lua.Execute([[return XGlobal_Node:isMaxLevel()]]) == "true"
    return Bot.GetNodeLevel(Bot.Settings.NodeKey) >= 10
end

function Bot.GetNodeName()
    return Infinity.BDO.Lua.Execute([[ return getExploreNodeName(XGlobal_Node:getStaticStatus()) ]])
end

function Bot.GetNodeKey()
    local result = Infinity.BDO.Lua.Execute([[ return XGlobal_Node:getPlantKey():getWaypointKey() ]])
    if result == nil then
        return 0
    end
    return result
end

function Bot.GetNodeLevel(node)
    return tonumber(Infinity.BDO.Lua.Execute([[return ToClient_GetNodeLevel(]] .. node .. [[)]]))
end

function Bot.GetNodeExp(node)
    local result = Infinity.BDO.Lua.Execute(string.format("return tostring(ToClient_GetNodeExperience_s64(%i))", node))
    if result == nil then
        return 0
    end
    return tonumber(result)
end

function Bot.GetNodeExpNeeded(node)
    local result = Infinity.BDO.Lua.Execute(string.format("return tostring(ToClient_GetNeedExperienceToNextNodeLevel_s64(%i))", node))
    if result == nil then
        return 0
    end
    return tonumber(result)
end

function Bot.Invest(key, energy)
    local code = [[
        ToClient_RequestIncreaseExperienceNode(]] .. key .. [[, ]] .. energy .. [[)
    ]]
    Infinity.BDO.Lua.Execute(code)
end

function Bot.InstallHook()
    if Infinity.BDO.Lua.Execute([[return Original_FGlobal_ShowInfoNodeMenuPanel == nil]]) == false then
        return
    end

    local code = [[
        Original_FGlobal_ShowInfoNodeMenuPanel = FGlobal_ShowInfoNodeMenuPanel
        FGlobal_ShowInfoNodeMenuPanel = function(node)
            XGlobal_Node = node
            return Original_FGlobal_ShowInfoNodeMenuPanel(node)
        end
    ]]
    Infinity.BDO.Lua.Execute(code)
end

function Bot.Pulse()    
    if Bot.PulseTimer == nil or Bot.PulseTimer:Expired() then
        Bot.PulseTimer = Timer(1)
        Bot.PulseTimer:Start()
    else
        return
    end

    if Infinity.BDO.getLocalPlayer() == nil then
        Bot.Energy = 0
        return
    end

    if Infinity.BDO.Lua.Execute("return isLuaLoadingComplete") ~= true then
        Bot.Energy = 0
        return
    end
    
    Bot.InstallHook()

    local nodeName = Bot.GetNodeName()
    if nodeName ~= nil then
        nodeName = nodeName:gsub("’", "'")
    end
    Bot.LastNode = nodeName
    Bot.LastNodeKey = Bot.GetNodeKey()

    Bot.Energy = Bot.GetEnergy()

    if Bot.Settings.NodeKey == nil then
        print("No Saved Info")
        return
    end

    Bot.MaxLevel = Bot.IsMaxLevel()

    if Bot.MaxLevel then
        Bot.Start = false
        print("Node is Max Level")
        return
    end
    
    -- if we don't have info saved then quit
    if Bot.Settings.NodeName == nil then
        print("No Saved Info")
        return
    end

    -- extra node info
    Bot.CurrentNodeLevel = Bot.GetNodeLevel(Bot.Settings.NodeKey)
    Bot.CurrentNodeNeededEnergy = (Bot.GetNodeExpNeeded(Bot.Settings.NodeKey) - Bot.GetNodeExp(Bot.Settings.NodeKey)) / 100

    if Bot.Start ~= true then
        return
    end

    local min_energy = Bot.Settings.MinimumEnergy
    if min_energy < 0 then
        min_energy = 0
    end

    -- pause the bot for a bit if minimum energy was lowered to prevent accidents
    if Bot.MinimumEnergyLoweredTime ~= nil and os.clock() - Bot.MinimumEnergyLoweredTime < 3 then
        --print("pause the bot for a bit")
        return
    end

    if Bot.Settings.InvestTen == false then
        if Bot.Energy > min_energy then
            local amount = Bot.Energy - min_energy
            print(string.format("Investing %i in %s", amount, Bot.Settings.NodeName))
            Bot.Invest(Bot.Settings.NodeKey, amount)
        else
            --print("Bot.Energy <= min_energy")
        end
    else
        local chunks_of_ten = math.floor((Bot.Energy - min_energy) / 10)
        --print("Bot.Energy: " .. Bot.Energy .. " min_energy: " .. min_energy)
        if chunks_of_ten > 0 then
            --print(string.format("Investing 10x%i in %s", chunks_of_ten, Bot.Settings.NodeName))
            for i=1,chunks_of_ten do
                Bot.Invest(Bot.Settings.NodeKey, 10)
            end
        else
            --print("chunks_of_ten <= 0")
        end
    end
end

function Bot.OnDrawGui()
    ImGui.Begin("Node Investor")
    ImGui.SetWindowSize(ImVec2(340,182), ImGuiCond_FirstUseEver)

        if Bot.LastNode ~= nil then
            if ImGui.Button("Set Node##btn_choose", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
                Bot.Settings.NodeName = Bot.LastNode
                Bot.Settings.NodeKey = Bot.LastNodeKey
                Bot.SaveSettings()
            end
            ImGui.SameLine()
            ImGui.Text(string.format("%s (%s)", Bot.LastNode, Bot.LastNodeKey))
        end

        if Bot.Settings.NodeName ~= nil then
            ImGui.Text(string.format("Node: %s (%s)", Bot.Settings.NodeName, Bot.Settings.NodeKey))
            if Bot.CurrentNodeLevel ~= nil and Bot.CurrentNodeNeededEnergy ~= nil then
                ImGui.Text("Level " .. Bot.CurrentNodeLevel .. " Energy Needed " .. Bot.CurrentNodeNeededEnergy)
            end
        else
            ImGui.Text("No node selected")
        end
        
        ImGui.Text(string.format("Energy: %i", Bot.Energy or 0))

        changed, min_energy = ImGui.InputText("Energy to Keep##energy_to_keep", Bot.Settings.MinimumEnergy)
        if changed then
            min_energy = tonumber(min_energy) or 200
            -- if energy was made lower, wait a few seconds before we start investing
            if min_energy < Bot.Settings.MinimumEnergy then
                Bot.MinimumEnergyLoweredTime = os.clock()
            end

            Bot.Settings.MinimumEnergy = min_energy
            Bot.SaveSettings()
        end
        _, Bot.Settings.InvestTen = ImGui.Checkbox("Invest 10 energy at a time##invest_ten", Bot.Settings.InvestTen)
        
        if Bot.Start then
            if ImGui.Button("Stop##btn_stop", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
                Bot.Start = false
            end
        else
            if ImGui.Button("Start##btn_start", ImVec2(ImGui.GetContentRegionAvailWidth() / 2, 20)) then
                Bot.Start = true
            end
        end
        ImGui.End()
    
end

function Bot.OnScriptStart()
    Bot.Start = false
    Bot.LoadSettings()
end

function Bot.OnScriptStop()
    Bot.Start = false
    Bot.SaveSettings()
end

function Bot.LoadSettings()
    local json = JSON:new()
    Bot.Settings = {
        MinimumEnergy = 200,
        InvestTen = true,
    }
    local raw = Infinity.FileSystem.ReadFile("settings.json")
    if raw ~= "" then
        table.merge(Bot.Settings, json:decode(raw))
    end
end

function Bot.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("settings.json", json:encode_pretty(Bot.Settings))
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", Bot.Pulse)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", Bot.OnScriptStart)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", Bot.OnScriptStop)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", Bot.OnDrawGui)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", Bot.OnAutoLoginAutoLoad)