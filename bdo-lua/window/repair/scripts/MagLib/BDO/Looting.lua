local Looting = {}

Looting.isLootingWindowOpen = function()
	return UI.getShow("Panel_Window_Looting_All")
end

Looting.closeLootingWindow = function()
	Infinity.BDO.Lua.Execute("PaGlobal_Looting_All:prepareClose()")
end

Looting.getItemInSlot = function(slot)
	local code = [[
        local itemWrapper =  looting_getItem(]] .. slot .. [[)
        if itemWrapper then 
            return itemWrapper:get():getKey():getItemKey(), Int64toDouble((itemWrapper:get()):getCount_s64()), itemWrapper:getStaticStatus():getName()
        end
        return nil
    ]]
	return Infinity.BDO.Lua.Execute(code)
end

Looting.getLootItems = function()
	local items = {}
	for i = 0, 23 do
		local itemKey, count, name = Looting.getItemInSlot(i)
		if itemKey then
			table.insert(items, {slot = i, itemKey = itemKey, count = count, name = name})
		end
	end

	return items
end

Looting.lootOneSlot = function(slot, count)
	local itemKey, _, name = Looting.getItemInSlot(slot)
	Infinity.BDO.Lua.Execute("PaGlobal_Looting_All_LootSlotClick(" .. count .. ", " .. slot .. ")")
	-- Triggering ItemsLooted with only one item in the table, hence the {{}}
	MagLib.Events.triggerEvent("ItemsLooted", {{slot = slot, itemKey = itemKey, count = count, name = name}})
end

local lootAllWithFilter_currentlyBlocked = false
local lootAllWithFilter_CloseWindowTaskFunction = function()
	Looting.closeLootingWindow()
	lootAllWithFilter_currentlyBlocked = false
end

Looting.lootAllWithFilter = function(filterFunction)
	local items = Looting.getLootItems()
	local toLootItems = {}
	local foundBlacklistedItem = false
	for _, itemData in pairs(items) do
		if filterFunction(itemData) then
			table.insert(toLootItems, itemData)
		else
			foundBlacklistedItem = true
		end
	end

	if not foundBlacklistedItem then
		Looting.lootAll()
	else
		for _, itemData in pairs(toLootItems) do
			Looting.lootOneSlot(itemData.slot, itemData.count)
		end
		lootAllWithFilter_currentlyBlocked = true
		MagLib.Run.Tasks.newDelayed("CloseLootingWindow Task", 200, lootAllWithFilter_CloseWindowTaskFunction)
	end
end

Looting.lootAll = function()
	local items = Looting.getLootItems()
	Infinity.BDO.Lua.Execute("HandleEventLUp_Looting_All_LootAll(true)")
	MagLib.Events.triggerEvent("ItemsLooted", items)
end

MagLib.BDO.Looting = Looting
