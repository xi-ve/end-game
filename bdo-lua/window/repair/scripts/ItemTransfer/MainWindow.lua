MainWindow = { }

MainWindow.Warehouse_ItemNames = {}
MainWindow.Warehouse_ItemSlots = {}

MainWindow.selectedIndex_WarehouseItem = 1

MainWindow.stepDelay = 250

function MainWindow.DrawMainWindow()  
    local pushedStyleColor = 0

    ImGui.Begin("ItemTransfer (Stackable Items Only)")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    if ImGui.Button("Load Warehouse Items##load_warehouse_items") then
        MainWindow.getWarehouseItems()
    end

    _, MainWindow.selectedIndex_WarehouseItem = ImGui.Combo("Warehouse Item##id_warehouse_items", MainWindow.selectedIndex_WarehouseItem, MainWindow.Warehouse_ItemNames)

    _, MainWindow.stepDelay = ImGui.SliderInt("Step Delay##step_delay", MainWindow.stepDelay, 100, 2000)

    --[[if ImGui.Button("toInventoryFromWarehouse##trasnfer_toinventory_fromwarehouse") then
        ItemTransfer.toInventoryFromWarehouse()
    end

    if ImGui.Button("toMountFromInventory##trasnfer_tomount_frominventory") then
        ItemTransfer.toMountFromInventory()
    end

    if ImGui.Button("toInventoryFromMount##trasnfer_toinventory_frommount") then
        ItemTransfer.toInventoryFromMount()
    end]]--

    if ImGui.Button("All To Inventory via Mount##trasnfer_all_toinventory_viamount") then
        ItemTransfer.allToInventoryViaMountInit()
    end

    if ImGui.CollapsingHeader("Item Deposit/Withdrawal Utils##id_utils") then

        if ItemTransfer.running_depositInventoryToWarehouse then
             ImGui.PushStyleColor2(ImGuiCol_Button, ImVec4(0.2, 1, 0, 1))
             ImGui.PushStyleColor2(ImGuiCol_ButtonHovered, ImVec4(0.2, 1, 0, 1))
             ImGui.PushStyleColor2(ImGuiCol_ButtonActive, ImVec4(0.2, 1, 0, 1))

             pushedStyleColor = 3
        end

        if ImGui.Button("All Inventory to Warehouse##deposit_inventory_to_warehouse") then
            if ItemTransfer.running_depositInventoryToWarehouse then
                ItemTransfer.running_depositInventoryToWarehouse = false
            else
                ItemTransfer.running_depositWarehouseToInventory = false
                ItemTransfer.running_depositInventoryToWarehouse = true
            end
        end

        if pushedStyleColor ~= 0 then
             ImGui.PopStyleColor(pushedStyleColor)
             pushedStyleColor = 0
        end  

        if ItemTransfer.running_depositWarehouseToInventory then
             ImGui.PushStyleColor2(ImGuiCol_Button, ImVec4(0.2, 1, 0, 1))
             ImGui.PushStyleColor2(ImGuiCol_ButtonHovered, ImVec4(0.2, 1, 0, 1))
             ImGui.PushStyleColor2(ImGuiCol_ButtonActive, ImVec4(0.2, 1, 0, 1))

             pushedStyleColor = 3
        end

        if ImGui.Button("All Warehouse to Inventory##deposit_warehouse_to_inventory") then
            if ItemTransfer.running_depositWarehouseToInventory then
                ItemTransfer.running_depositWarehouseToInventory = false
            else
                ItemTransfer.running_depositInventoryToWarehouse = false
                ItemTransfer.running_depositWarehouseToInventory = true
            end
        end

        if pushedStyleColor ~= 0 then
             ImGui.PopStyleColor(pushedStyleColor)
             pushedStyleColor = 0
        end        
    end
    ImGui.End()
end

function MainWindow.getSelectedWarehouseSlot()
    if table.length(MainWindow.Warehouse_ItemSlots) == 0 then
        return -1
    end

    return MainWindow.Warehouse_ItemSlots[MainWindow.selectedIndex_WarehouseItem]
end

function MainWindow.getWarehouseItems()
    local itemNames = {}
    local itemSlots = {}

    for i = 1, 194 do

        local code =
        [[
            local warehouseWrapper = warehouse_get(]] .. Warehouse.getCurrentWaypointKey() .. [[)
                
            if warehouseWrapper ~= nil then            
                local itemWrapper = warehouseWrapper:getItem(]] .. i .. [[)

                if itemWrapper ~= nil then
                    return (itemWrapper:getStaticStatus()):getName()
                end            
            end

            return nil
        ]]

        local itemName = Infinity.BDO.Lua.Execute(code)

        if itemName ~= nil and Warehouse.isStackable(i) then
            table.insert(itemNames, itemName)
            table.insert(itemSlots, i)
        end
    end

    MainWindow.Warehouse_ItemNames = itemNames
    MainWindow.Warehouse_ItemSlots = itemSlots
end