MainWindow = { }

MainWindow.InventoryItemsNames = {}
MainWindow.InventoryItemsItemIds = {}

local Selected_InventoryItem_Index = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("AutoLoot")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    if valueChanged then
        AutoLoot.SaveSettings()
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