MainWindow = { }

MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}

local Selected_InventoryItem_Index = 1

MainWindow.AvailablesProfiles = {}
MainWindow.Profiles_SelectedIndex = 1
MainWindow.NewProfile_Name = ""
MainWindow.NewProfile_Active = false
MainWindow.NewProfile = nil

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoItemDelete")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if AutoItemDelete.Running == true then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if AutoItemDelete.Running == true then
            AutoItemDelete.StopBot()
        else
            AutoItemDelete.StartBot()
        end
    end
        
    if ImGui.CollapsingHeader("BlackList##id_blacklist") then
        
        valueChanged, MainWindow.Profiles_SelectedIndex = ImGui.Combo("Profiles##id_profiles", table.findIndex(MainWindow.AvailablesProfiles, AutoItemDelete.Settings.LastProfile), MainWindow.AvailablesProfiles)

        if valueChanged then

            AutoItemDelete.Settings.LastProfile = MainWindow.AvailablesProfiles[MainWindow.Profiles_SelectedIndex]
            print("Profile selected : " .. AutoItemDelete.Settings.LastProfile)

            local doStart = false

            if AutoItemDelete.Running then
                doStart = true
            end

            if doStart then
                AutoItemDelete.StopBot()
            end

            AutoItemDelete.LoadLastProfile()            

            if doStart then
                AutoItemDelete.StartBot()
            end
        end

        if ImGui.Button("New Profile##new_profile") then

            MainWindow.NewProfile_Active = true
            MainWindow.NewProfile = ProfileSettings()
        end

        if MainWindow.NewProfile_Active then

            _, MainWindow.NewProfile_Name = ImGui.InputText("Name##new_profile_name", MainWindow.NewProfile_Name)

            if ImGui.Button("Save##new_profile_save") then

                if MainWindow.NewProfile_Name ~= "" then

                    MainWindow.NewProfile.Name = MainWindow.NewProfile_Name
                    AutoItemDelete.Settings.LastProfile = MainWindow.NewProfile.Name .. ".json"

                    AutoItemDelete.CurrentProfile = MainWindow.NewProfile

                    AutoItemDelete.SaveCurrentProfile()                    
                    AutoItemDelete.LoadLastProfile()
                    MainWindow.RefreshAvailableProfiles()

                    MainWindow.NewProfile_Name = ""
                    MainWindow.NewProfile = nil
                    MainWindow.NewProfile_Active = false
                    
                    valueChanged = true
                end
            end
        end

        if AutoItemDelete.CurrentProfile.Name ~= "" and not MainWindow.NewProfile_Active then

        if ImGui.Button("Load Inventory Items") then

            MainWindow.getInventoryItemsForFilter()
        end

        if ImGui.Button("Add") then

            if table.length(MainWindow.InventoryItemsNames) ~= 0 then

                local itemId = MainWindow.InventoryItemsItemIds[Selected_InventoryItem_Index]

                local canAdd = true

                for k,v in pairs(AutoItemDelete.CurrentProfile.BlackList) do
                    
                    if v.ItemId == itemId then

                        canAdd = false
                        break
                    end
                end

                if canAdd and not AutoItemDelete.shouldNotLoot(itemId) then

                    table.insert(AutoItemDelete.CurrentProfile.BlackList, {ItemId = itemId, Name = MainWindow.InventoryItemsNames[Selected_InventoryItem_Index]})
                    valueChanged = true

                    AutoItemDelete.SaveCurrentProfile()

                    local doStart = false

            if AutoItemDelete.Running then
                doStart = true
            end

            if doStart then
                AutoItemDelete.StopBot()
                AutoItemDelete.StartBot()
            end
                end
            end
        end

        ImGui.SameLine()

        _, Selected_InventoryItem_Index = ImGui.Combo("Select Inventory Item##id_inventory_items", Selected_InventoryItem_Index, MainWindow.InventoryItemsNames)

        ImGui.Columns(4)
        ImGui.SetColumnWidth(0,30)
        ImGui.SetColumnWidth(1,80)
        ImGui.SetColumnWidth(2,80)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ItemId")
        ImGui.NextColumn()
        ImGui.Text("EnchantLvL")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(AutoItemDelete.CurrentProfile.BlackList) do

            if ImGui.SmallButton("X##id_items_list_delete_" .. k) then                
                table.remove(AutoItemDelete.CurrentProfile.BlackList, k)

                valueChanged = true
                AutoItemDelete.SaveCurrentProfile()
                break
            end

            ImGui.NextColumn()

            ImGui.Text(tostring(Utils.getItemId(v.ItemId)))
            ImGui.NextColumn()
            ImGui.Text(tostring(Utils.getEnchantLevel(v.ItemId)))
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end
        end
    end

    if valueChanged then
        AutoItemDelete.SaveSettings()
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
            local enchantKey

            name, itemId, count, enchantKey = Inventory.getItemData(i)

            if name ~= nil and itemId ~= nil then
                local enchantLevel = Utils.getEnchantLevel(enchantKey)

                if table.find(itemTableIds, enchantKey) == nil then

                    if enchantLevel > 0 then
                        table.insert(itemTableNames, "+" .. tostring(enchantLevel) .. " " .. name)
                    else
                        table.insert(itemTableNames, name)
                    end

                    table.insert(itemTableIds, enchantKey)
                end
            end
        end
    end

    MainWindow.InventoryItemsNames = itemTableNames
    MainWindow.InventoryItemsItemIds = itemTableIds
end

function MainWindow.RefreshAvailableProfiles()
    MainWindow.AvailablesProfiles = { }

    for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.json")) do
        table.insert(MainWindow.AvailablesProfiles, v)

    end
end

MainWindow.RefreshAvailableProfiles()