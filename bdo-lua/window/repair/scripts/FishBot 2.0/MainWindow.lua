MainWindow = { }
MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}

MainWindow.InputItemId = 0

local Selected_InventoryItem_Index = 1

local ProfileNames = {}
local ProfileSelectedIndex = 1
local Profiles = {}

function MainWindow.DrawMainWindow()
    local valueChanged = false

    ImGui.Begin("FishBot 2.0")
    
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
    ImGui.SameLine()
    ImGui.Text("-> in " .. MainWindow.getNextCatchTime() .. "sec")

    if FishBot.StartFishingState == nil then
        ImGui.Text("Total Casts: 0")
        ImGui.SameLine()
        ImGui.Text("-> /H: 0")
    else
        ImGui.Text("Total Casts: " .. FishBot.StartFishingState.totalCasts)
        ImGui.SameLine()
        ImGui.Text("-> /H: " .. math.floor(FishBot.StartFishingState.totalCasts/hUptime))
    end

    ImGui.Text("Available Durability: " .. FishBot.AvailableDurability)
    --ImGui.Text("Durability/Hour: " .. FishBot.DurabilityPerHour)
    ImGui.Text("Free Slots: " .. FishBot.FreeInventorySlots)

    valueChanged, FishBot.Settings.RenderSpot = ImGui.Checkbox("Render Spot##id_render_spot", FishBot.Settings.RenderSpot)

    if ImGui.CollapsingHeader("Security##id_security") then
        
        valueChanged, FishBot.Settings.Security.NearbyPlayers_Crouch = ImGui.Checkbox("Crouch if nearby Players##id_security_crouch", FishBot.Settings.Security.NearbyPlayers_Crouch)
        --valueChanged, FishBot.Settings.Security.EquipCamo_Teleport = ImGui.Checkbox("Equip Camo when teleporting##id_security_tp_camo", FishBot.Settings.Security.EquipCamo_Teleport)
        valueChanged, FishBot.Settings.Security.EquipCamo_NearbyPlayers = ImGui.Checkbox("Equip Camo if nearby Players##id_security_players_camo", FishBot.Settings.Security.EquipCamo_NearbyPlayers)
    end

    if ImGui.CollapsingHeader("FishingState##id_fishingstate") then
        
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

    if ImGui.CollapsingHeader("LootState##id_lootstate") then

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

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("RepairState##id_repairstate") then

        valueChanged, FishBot.Settings.VendorWhileRepair = ImGui.Checkbox("Vendor while at repair##id_vendor_while_repair", FishBot.Settings.VendorWhileRepair)
        valueChanged, FishBot.Settings.UseInventorySilverToRepair = ImGui.Checkbox("Use Inventory Silver to repair##id_use_inventory_silver_to_repair", FishBot.Settings.UseInventorySilverToRepair)
        valueChanged, FishBot.Settings.InstallTent = ImGui.Checkbox("Install Tent##id_install_tent", FishBot.Settings.InstallTent)

        ImGui.Text("TentSpot X: " .. FishBot.Settings.TentSpot.X .. " Y: " .. FishBot.Settings.TentSpot.Y .. " Z: " .. FishBot.Settings.TentSpot.Z)    
        ImGui.Text("Distance: " .. FishBot.TentSpot:getDistance(Infinity.BDO.getLocalPlayer():getPosition()))

        if ImGui.SmallButton("Set Spot##set_spot_tent") then
                
            local plPos = Infinity.BDO.getLocalPlayer():getPosition()

            FishBot.Settings.TentSpot.X = plPos.X
            FishBot.Settings.TentSpot.Y = plPos.Y
            FishBot.Settings.TentSpot.Z = plPos.Z

            FishBot.TentSpot = Vector3(FishBot.Settings.TentSpot.X, FishBot.Settings.TentSpot.Y, FishBot.Settings.TentSpot.Z)

            valueChanged = true
        end
    end

    if ImGui.CollapsingHeader("TradeState##id_trade_state") then
        
        valueChanged, FishBot.Settings.MinTradeItemCount = ImGui.SliderInt("Min Item Count##id_min_trade_item_count", FishBot.Settings.MinTradeItemCount, 1, 192)

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForTradeFilter()
        end

        if ImGui.Button("Add") then

            if table.length(MainWindow.InventoryItemsNames) ~= 0 then

                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]

                local canAdd = true

                for k,v in pairs(FishBot.Settings.TradeList) do
                    
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd then

                    table.insert(FishBot.Settings.TradeList, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true
                    
                    MainWindow.getInventoryItemsForTradeFilter() 
                end
            end
        end

        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items_fortrade", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0,25)
        ImGui.SetColumnWidth(1,100)
        ImGui.SetColumnWidth(2,375)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.Settings.TradeList) do

            if ImGui.SmallButton("X##id_items_list_delete_fortrade_" .. k) then                
                table.remove(FishBot.Settings.TradeList, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(v.ItemId))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("VendorState##id_vendor_state") then
        
        valueChanged, FishBot.Settings.MinVendorItemCount = ImGui.SliderInt("Min Item Count##id_min_trade_item_count", FishBot.Settings.MinVendorItemCount, 1, 500)

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForVendorFilter()
        end

        if ImGui.Button("Add") then

            if table.length(MainWindow.InventoryItemsNames) ~= 0 then

                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]

                local canAdd = true

                for k,v in pairs(FishBot.Settings.VendorList) do
                    
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd then

                    table.insert(FishBot.Settings.VendorList, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true
                    
                    MainWindow.getInventoryItemsForVendorFilter() 
                end
            end
        end

        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items_forvendor", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0,25)
        ImGui.SetColumnWidth(1,100)
        ImGui.SetColumnWidth(2,375)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.Settings.VendorList) do

            if ImGui.SmallButton("X##id_items_list_delete_forvendor_" .. k) then                
                table.remove(FishBot.Settings.VendorList, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(v.ItemId))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("ItemMarketState##id_itemmarket_state") then
        valueChanged, FishBot.Settings.MinMarketItemCount = ImGui.SliderInt("Min Item Count##id_min_market_items_count", FishBot.Settings.MinMarketItemCount, 1, 192)
        valueChanged, FishBot.Settings.OnlyMaids = ImGui.Checkbox("Only via Maids##only_maids", FishBot.Settings.OnlyMaids)

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForMarketFilter()
        end

        if ImGui.Button("Add") then

            if table.length(MainWindow.InventoryItemsNames) ~= 0 then

                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]

                local canAdd = true

                for k,v in pairs(FishBot.Settings.MarketList) do
                    
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd then

                    table.insert(FishBot.Settings.MarketList, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true

                    MainWindow.getInventoryItemsForMarketFilter()
                end
            end
        end

        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items_market_list", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0,25)
        ImGui.SetColumnWidth(1,100)
        ImGui.SetColumnWidth(2,375)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.Settings.MarketList) do

            if ImGui.SmallButton("X##id_items_list_delete_" .. k) then                
                table.remove(FishBot.Settings.MarketList, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(v.ItemId))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("TransferToContainerState##id_transfer_container") then
        
        valueChanged, FishBot.Settings.TransferContainerMinCount = ImGui.SliderInt("MinCount to Move##id_transfer_container_mincount", FishBot.Settings.TransferContainerMinCount, 50, 1000)

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForFilter()
        end

        if ImGui.Button("Add") then

            if table.length(MainWindow.InventoryItemsNames) ~= 0 then

                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]

                local canAdd = true

                for k,v in pairs(FishBot.Settings.TransferContainer) do
                    
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd then

                    table.insert(FishBot.Settings.TransferContainer, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true
                end
            end
        end

        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0,25)
        ImGui.SetColumnWidth(1,100)
        ImGui.SetColumnWidth(2,375)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(FishBot.Settings.TransferContainer) do

            if ImGui.SmallButton("X##id_items_list_delete_" .. k) then                
                table.remove(FishBot.Settings.TransferContainer, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(v.ItemId))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("Pathing##id_pathing") then

        valueChanged, FishBot.Settings.TeleportDelay = ImGui.SliderInt("TP Delay (msec)##id_teleport_delay_msec", FishBot.Settings.TeleportDelay, 0, 1000)
        valueChanged, FishBot.Settings.AutoDelay = ImGui.Checkbox("Auto Delay##id_auto_delay", FishBot.Settings.AutoDelay)
        valueChanged, FishBot.Settings.UseCrouchWhileTeleport = ImGui.Checkbox("Use Crouch While Teleport##id_use_crouch_while_teleport", FishBot.Settings.UseCrouchWhileTeleport)
        valueChanged, FishBot.Settings.VerticalOffset = ImGui.SliderInt("[Path] Height Offset##cp_offset_height", FishBot.Settings.VerticalOffset, 0, 2000)

        if ImGui.Button("Show Navigator") then

            if not FishBot.Navigator.ShowGui then

                FishBot.Navigator.ShowGui = true
            end
        end

        ImGui.SameLine()

        if ImGui.Button("Reload Profiles") then
            ProfileNames = {}
            Profiles = {}

            MainWindow.LoadProfiles()
        end

        _, ProfileSelectedIndex = ImGui.Combo("Profiles##profiles", ProfileSelectedIndex, ProfileNames)

        ImGui.Text("Spot->Repair: " .. FishBot.Settings.Paths.Repair)
        ImGui.SameLine()
        if ImGui.SmallButton("X##repair_delete") then
            FishBot.Settings.Paths.Repair = ""

            valueChanged = true
        end

        if table.length(ProfileNames) > 0 then
            ImGui.SameLine()

            if ImGui.SmallButton("Set##repair") then
                FishBot.Settings.Paths.Repair = ProfileNames[ProfileSelectedIndex]

                valueChanged = true
            end
        end

        ImGui.Text("Spot->Market: " .. FishBot.Settings.Paths.Market)
        ImGui.SameLine()
        if ImGui.SmallButton("X##market_delete") then
            FishBot.Settings.Paths.Market = ""

            valueChanged = true
        end

        if table.length(ProfileNames) > 0 then
            ImGui.SameLine()

            if ImGui.SmallButton("Set##market") then
                FishBot.Settings.Paths.Market = ProfileNames[ProfileSelectedIndex]

                valueChanged = true
            end
        end

        ImGui.Text("Spot->Storage: " .. FishBot.Settings.Paths.Storage)
        ImGui.SameLine()
        if ImGui.SmallButton("X##storage_delete") then
            FishBot.Settings.Paths.Storage = ""

            valueChanged = true
        end

        if table.length(ProfileNames) > 0 then
            ImGui.SameLine()

            if ImGui.SmallButton("Set##storage") then
                FishBot.Settings.Paths.Storage = ProfileNames[ProfileSelectedIndex]

                valueChanged = true
            end
        end

        ImGui.Text("Spot->Trade: " .. FishBot.Settings.Paths.Trade)
        ImGui.SameLine()
        if ImGui.SmallButton("X##trade_delete") then
            FishBot.Settings.Paths.Trade = ""

            valueChanged = true
        end

        if table.length(ProfileNames) > 0 then
            ImGui.SameLine()

            if ImGui.SmallButton("Set##trade") then
                FishBot.Settings.Paths.Trade = ProfileNames[ProfileSelectedIndex]

                valueChanged = true
            end
        end

        ImGui.Text("Spot->Vendor: " .. FishBot.Settings.Paths.Vendor)
        ImGui.SameLine()
        if ImGui.SmallButton("X##vendor_delete") then
            FishBot.Settings.Paths.Vendor = ""

            valueChanged = true
        end

        if table.length(ProfileNames) > 0 then
            ImGui.SameLine()

            if ImGui.SmallButton("Set##vendor") then
                FishBot.Settings.Paths.Vendor = ProfileNames[ProfileSelectedIndex]

                valueChanged = true
            end
        end

        ImGui.Text("FishingSpot X: " .. FishBot.Settings.FishingSpot.X .. " Y: " .. FishBot.Settings.FishingSpot.Y .. " Z: " .. FishBot.Settings.FishingSpot.Z)    
        ImGui.Text("Distance: " .. FishBot.FishingSpot:getDistance(Infinity.BDO.getLocalPlayer():getPosition()))
        ImGui.Text(string.format("FishingSpot Direction: %0.2f", FishBot.Settings.FishingSpotDirection))

        if ImGui.SmallButton("Set Spot##set_spot") then
                
            local plPos = Infinity.BDO.getLocalPlayer():getPosition()

            FishBot.Settings.FishingSpot.X = plPos.X
            FishBot.Settings.FishingSpot.Y = plPos.Y
            FishBot.Settings.FishingSpot.Z = plPos.Z

            FishBot.FishingSpot = Vector3(FishBot.Settings.FishingSpot.X, FishBot.Settings.FishingSpot.Y, FishBot.Settings.FishingSpot.Z)
            FishBot.Settings.FishingSpotDirection = Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()

            valueChanged = true
        end
    end

    if ImGui.CollapsingHeader("Loot Statistics##id_items") then

        if ImGui.Button("Reset Stats") then                
            
            FishBot.ResetStats()
        end

        ImGui.Text("White: " .. FishBot.GradeStats[0])
        ImGui.SameLine()
        ImGui.Text(" -> /Hour: " .. math.floor(FishBot.GradeStats[0]/hUptime))

        ImGui.Text("Green: " .. FishBot.GradeStats[1])
        ImGui.SameLine()
        ImGui.Text(" -> /Hour: " .. math.floor(FishBot.GradeStats[1]/hUptime))

        ImGui.Text("Blue: " .. FishBot.GradeStats[2])
        ImGui.SameLine()
        ImGui.Text(" -> /Hour: " .. math.floor(FishBot.GradeStats[2]/hUptime))

        ImGui.Text("Yellow: " .. FishBot.GradeStats[3])
        ImGui.SameLine()
        ImGui.Text(" -> /Hour: " .. math.floor(FishBot.GradeStats[3]/hUptime))

        ImGui.Text("Orange: " .. FishBot.GradeStats[4])
        ImGui.SameLine()
        ImGui.Text(" -> /Hour: " .. math.floor(FishBot.GradeStats[4]/hUptime))

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

    if valueChanged then
        FishBot.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.getInventoryItemsForFilter()
    local invenMaxSize = Inventory.getMaxSize()

    if invenMaxSize == 0 then
        return
    end

    local itemTableNames = {}
    local itemTableIds = {}

    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) then
            local name
            local itemId
            local count

            name, itemId, count = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                if table.find(itemTableIds, itemId) == nil then
                    table.insert(itemTableNames, name)
                    table.insert(itemTableIds, itemId)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end

function MainWindow.getInventoryItemsForTradeFilter()
    local invenMaxSize = Inventory.getMaxSize()

    if invenMaxSize == 0 then
        return
    end

    local itemTableNames = {}
    local itemTableIds = {}

    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) and Inventory.isTradeable(i) then
            local name
            local itemId
            local count

            name, itemId, count = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                if table.find(itemTableIds, itemId) == nil and not FishBot.TradeState:shouldTrade(itemId) then
                    table.insert(itemTableNames, name)
                    table.insert(itemTableIds, itemId)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end

function MainWindow.getInventoryItemsForVendorFilter()
    local invenMaxSize = Inventory.getMaxSize()

    if invenMaxSize == 0 then
        return
    end

    local itemTableNames = {}
    local itemTableIds = {}

    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) and not Inventory.isTradeable(i) then
            local name
            local itemId
            local count

            name, itemId, count = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                if table.find(itemTableIds, itemId) == nil and not FishBot.VendorState:shouldTrade(itemId) then
                    table.insert(itemTableNames, name)
                    table.insert(itemTableIds, itemId)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end

function MainWindow.getInventoryItemsForMarketFilter()
    local invenMaxSize = Inventory.getMaxSize()

    if invenMaxSize == 0 then
        return
    end

    local itemTableNames = {}
    local itemTableIds = {}

    for i = 2, invenMaxSize - 1 do
        if Inventory.hasItemWrapper(i) then
            local name
            local itemId
            local count

            name, itemId, count = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                if table.find(itemTableIds, itemId) == nil and not FishBot.ItemMarketState:shouldSell(itemId) then
                    table.insert(itemTableNames, name)
                    table.insert(itemTableIds, itemId)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end

function MainWindow.LoadProfiles()
    local files = Infinity.FileSystem.GetFiles("\\NavigatorProfiles\\*.json")

    for k,v in pairs(files) do
        
        local json = JSON:new()
        local t = {}    

        table.merge(t, json:decode(Infinity.FileSystem.ReadFile("NavigatorProfiles\\" .. v)))
        
        table.insert(ProfileNames, t.Name)
        table.insert(Profiles, t)
    end

    print("Navigator Profiles Loaded!")
end

function MainWindow.getNextCatchTime()
    if Infinity.BDO.getLocalPlayer() == nil then
        return 0
    end

    local nextCatchTick = Infinity.BDO.getLocalPlayer():getNextFishBite():getUnsafe()
    local currentTick = Infinity.BDO.getTime():getUnsafe()

    local deltaTicks = nextCatchTick - currentTick

    if deltaTicks < 0 then
        deltaTicks = 0
    end

    return tostring(math.floor(deltaTicks/1000))
end