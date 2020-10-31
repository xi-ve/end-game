MainWindow = { }
MainWindow.InputItemId = 0

function MainWindow.DrawMainWindow()
    local valueChanged = false

    ImGui.Begin("FishBot")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if FishBot.Running == true then
    	btnText = "Stop"
    end

    if ImGui.Button(btnText) then
    	if FishBot.Running == true then
    		FishBot.StopBot()
    	else
    		FishBot.StartBot()
    	end
    end

    local hUptime = ((FishBot.UpTime / 1000) /(60 * 60))

    ImGui.Text(string.format("UpTime:  %02.f:%02.f:%02.f", math.floor(hUptime), math.floor((FishBot.UpTime / 1000) / 60) % 60, (FishBot.UpTime / 1000) % 60))
    
    ImGui.Text("Next Fishgrade:  " .. Fishing.getFishGradeAsText(Fishing.getFishGrade()))
    ImGui.Text("Next Catch: " .. MainWindow.getNextCatchTime() .. "sec")

    if FishBot.Running then

        if FishBot.FishHookedState.timer ~= nil then

            ImGui.Text("Random Catch Timer: " .. FishBot.FishHookedState.timer:TimeLeft() .. "sec")
        end
    end

    ImGui.Text("Available Durability: " .. FishBot.AvailableDurability)
    ImGui.Text("Durability/Hour: " .. FishBot.DurabilityPerHour)

    ImGui.Spacing()

    valueChanged, FishBot.Settings.Speedhack.Enabled = ImGui.Checkbox("Speedhack##id_speedhack", FishBot.Settings.Speedhack.Enabled)
    valueChanged, FishBot.Settings.Speedhack.Value = ImGui.SliderFloat("##id_speedhack_value", FishBot.Settings.Speedhack.Value, 1.0, 50.0)

    valueChanged, FishBot.Settings.DeleteRods.Enabled = ImGui.Checkbox("Delete NonRepairable Rods##id_deleterods", FishBot.Settings.DeleteRods.Enabled)
    valueChanged, FishBot.Settings.PredictMode.Enabled = ImGui.Checkbox("Predict FishGrades##id_predictmode", FishBot.Settings.PredictMode.Enabled)
    valueChanged, FishBot.Settings.TentRepair = ImGui.Checkbox("Use Tent Repair##id_tentrepair", FishBot.Settings.TentRepair)
    
    if ImGui.CollapsingHeader("Security##id_security") then

        valueChanged, FishBot.Settings.RandomCatchTimer = ImGui.Checkbox("Random Catchtimer##id_rnd_catchtimer", FishBot.Settings.RandomCatchTimer)
        valueChanged, FishBot.Settings.NearbyPlayersRandomCatchTimer = ImGui.Checkbox("Random Catchtimer if nearby players##id_rnd_catchtimer_nearby_players", FishBot.Settings.NearbyPlayersRandomCatchTimer)
        valueChanged, FishBot.Settings.NearbyPlayersFishingStop = ImGui.Checkbox("Stop Fishing if nearby players##id_player_stop_fishing", FishBot.Settings.NearbyPlayersFishingStop)
        valueChanged, FishBot.Settings.NearbyPlayersStop = ImGui.Checkbox("Stop Speed if nearby players##id_player_stop_speed", FishBot.Settings.NearbyPlayersStop)
        valueChanged, FishBot.Settings.NearbyPlayersStopPredict = ImGui.Checkbox("Stop Predict if nearby players##id_player_stop_predict", FishBot.Settings.NearbyPlayersStopPredict)
    end
    
    if ImGui.CollapsingHeader("PredictGrades##id_predictgrades") then
        
        valueChanged, FishBot.Settings.PredictGrades.White.Enabled = ImGui.Checkbox("White##id_predictgrades_white", FishBot.Settings.PredictGrades.White.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.PredictGrades.Green.Enabled = ImGui.Checkbox("Green##id_predictgrades_green", FishBot.Settings.PredictGrades.Green.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.PredictGrades.Blue.Enabled = ImGui.Checkbox("Blue##id_predictgrades_blue", FishBot.Settings.PredictGrades.Blue.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.PredictGrades.Yellow.Enabled = ImGui.Checkbox("Yellow##id_predictgrades_yellow", FishBot.Settings.PredictGrades.Yellow.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.PredictGrades.Orange.Enabled = ImGui.Checkbox("Orange##id_predictgrades_orange", FishBot.Settings.PredictGrades.Orange.Enabled)
    end

    

    if ImGui.CollapsingHeader("Items##id_items") then

        valueChanged, FishBot.Settings.CatchGrades.White.Enabled = ImGui.Checkbox("White##id_fishgrades_white", FishBot.Settings.CatchGrades.White.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.CatchGrades.Green.Enabled = ImGui.Checkbox("Green##id_fishgrades_green", FishBot.Settings.CatchGrades.Green.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.CatchGrades.Blue.Enabled = ImGui.Checkbox("Blue##id_fishgrades_blue", FishBot.Settings.CatchGrades.Blue.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.CatchGrades.Yellow.Enabled = ImGui.Checkbox("Yellow##id_fishgrades_yellow", FishBot.Settings.CatchGrades.Yellow.Enabled)
        ImGui.SameLine()
        valueChanged, FishBot.Settings.CatchGrades.Orange.Enabled = ImGui.Checkbox("Orange##id_fishgrades_orange", FishBot.Settings.CatchGrades.Orange.Enabled)

        ImGui.Spacing()

        valueChanged, FishBot.Settings.AllLoot.Enabled = ImGui.Checkbox("Loot Everything##id_allloot", FishBot.Settings.AllLoot.Enabled)

        ImGui.Spacing()

        --valueChanged, FishBot.Settings.AutoCombineRelics = ImGui.Checkbox("Auto Combine Relics##id_auto_puzzle_relics", FishBot.Settings.AutoCombineRelics)

        --ImGui.Spacing()

        _, MainWindow.InputItemId = ImGui.InputInt("##items_input_itemid", MainWindow.InputItemId, 0, 0, 0)
        ImGui.SameLine()

        if ImGui.Button("Add##items_add_itemid") then             
            if MainWindow.InputItemId > 0 and table.find(FishBot.Settings.Items, MainWindow.InputItemId) == nil then
                table.insert(FishBot.Settings.Items, MainWindow.InputItemId)

                valueChanged = true
            end
        end
        
        ImGui.Spacing()

        ImGui.Columns(3)
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()
        ImGui.Text("Delete")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.Settings.Items) do
            ImGui.Text(tostring(v))
            ImGui.NextColumn()
            ImGui.Text("-")
            ImGui.NextColumn()
            
            if ImGui.Button("Delete##id_items_list_delete_" .. k) then                
                table.remove(FishBot.Settings.Items, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()
        end
    end
    
    if ImGui.CollapsingHeader("Loot Statistics##id_items") then

        if ImGui.Button("Reset Stats") then                
            
            FishBot.StartTick = Infinity.Win32.GetTickCount()
            FishBot.LootStats = {}
        end

        ImGui.Columns(4)
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()
        ImGui.Text("Count")
        ImGui.NextColumn()
        ImGui.Text("/Hour")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.LootStats) do
            ImGui.Text(k)
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
            ImGui.Text(v.Count)
            ImGui.NextColumn()
            ImGui.Text(string.format("%02.f", v.Count / hUptime))
            ImGui.NextColumn()
        end
    end        

    if valueChanged == true then
        FishBot.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.getNextCatchTime()
    if localPlayer == nil then
        return 0
    end

    local nextCatchTick = localPlayer:getNextFishBite()
    local currentTick = Infinity.BDO.getTime()

    local deltaTicks = nextCatchTick - currentTick

    if deltaTicks < 0 then
        deltaTicks = 0
    end

    return tostring(math.floor(deltaTicks/1000))
end