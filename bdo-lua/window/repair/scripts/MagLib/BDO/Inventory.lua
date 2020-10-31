local Inventory = {}
local settings = {inventoryForCombobox_updateInterval = 1000}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Inventory", settings)

---Returns an Item object from the item in the given item slot
---@param slot number The slot index
---@return Item Item object or nil if empty slot
Inventory.getItemData = function(slot)
	local item = MagLib.BDO.Item(slot, false)
	if item.valid then
		return item
	else
		return nil
	end
end

---Returns an Item object from the equipped item in the given equipment slot
---@param slot number The slot index
---@return Item Item object or nil if empty slot
Inventory.getEquippedItemData = function(slot)
	local item = MagLib.BDO.Item(slot, true)
	if item.valid then
		return item
	else
		return nil
	end
end

---Iterates over the inventory items (not the empty slots) and gives every item to the func with parameter itemData
---If func returns true, it will stop prematurely
---@param func function the function to give every item to
Inventory.iterator = function(func)
	local invSize = Inventory.getSize()
	for slot = 2, invSize do
		local itemData = Inventory.getItemData(slot)
		if itemData and func(itemData) then
			return
		end
	end
end

Inventory.getSilverCount = function()
	return tonumber(Infinity.BDO.Lua.Execute("return tostring(getSelfPlayer():get():getInventory():getMoney_s64())"))
end

---Returns true if at least one item with any of the given keys is found in the inventory.
Inventory.hasAtLeastOneOf = function(keys)
	local found = false
	local iteratorFunc = function(item)
		if table.find(keys, item.itemKey) then
			found = true
			return true
		end
	end

	Inventory.iterator(iteratorFunc)

	return found
end

Inventory.getAllPlusZeros = function(wantedItemKey)
	local zeroSlots = {}
	local iteratorFunc = function(itemData)
		if itemData.itemKey == wantedItemKey and itemData.enhanceLevel == 0 then
			table.insert(zeroSlots, itemData.slot)
		end
	end
	Inventory.iterator(iteratorFunc)
	return zeroSlots
end

Inventory.getFirstPlusZero = function(wantedItemKey)
	local zeroData = nil
	local iteratorFunc = function(itemData)
		if itemData.itemKey == wantedItemKey and itemData.enhanceLevel == 0 then
			zeroData = itemData
			return true
		end
	end
	Inventory.iterator(iteratorFunc)
	return zeroData
end

Inventory.getItemCount = function(wantedKey)
	local count = 0
	local iteratorFunc = function(itemData)
		if itemData.itemKey == wantedKey then
			count = count + itemData.count
		end
	end
	Inventory.iterator(iteratorFunc)
	return count
end

Inventory.getItemCount_Quick = function(id)
	local code = [[
local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)
local wantedKey = ]] .. id .. [[
  if inventory == nil then
    return - 1
  end

  local invenMaxSize = inventory:sizeXXX()
  local count = 0
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItem(ii)
    if itemWrapper ~= nil then
      if (itemWrapper:get():getKey()):getItemKey() == wantedKey then
        count = count + Int64toDouble((itemWrapper:get()):getCount_s64())
      end
    end
  end

  return count
  ]]
	return Infinity.BDO.Lua.Execute(code)
end
Inventory.countItemCount = Inventory.getItemCount_Quick -- For legacy support since that was was getItemCount was named before

local lastUpdated = 0
local inventoryForCombobox_lastResult = nil
Inventory.getInventoryForCombobox = function()
	local time = MagLib.getTime()
	if lastUpdated + settings.inventoryForCombobox_updateInterval > MagLib.getTime() then
		-- return cached
		return inventoryForCombobox_lastResult.names, inventoryForCombobox_lastResult.itemDatas
	else
		-- Parse new
		local names = {}
		local itemDatas = {}
		local iteratorFunc = function(itemData)
			local fullName = itemData.name
			if itemData.itemKey ~= 0 and not table.find(names, fullName) then
				table.insert(names, fullName)
				itemData.selected = false
				table.insert(itemDatas, itemData)
			end
		end
		Inventory.iterator(iteratorFunc)
		inventoryForCombobox_lastResult = {names = names, itemDatas = itemDatas}
		lastUpdated = time
		return names, itemDatas
	end
end

-- sortType: 0/nil => don't sort, 1 => by id, 2=> by name
Inventory.sortInventoryTable = function(t, sortType) -- TODO
	return t
end

---Low Level funcs
Inventory.getSize = function()
	return Infinity.BDO.Lua.Execute(
       		"return ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory):sizeXXX()")
end

Inventory.EquipmentSlots = {
	RightHand = 0,
	LeftHand = 1,
	SubTool = 2,
	Chest = 3,
	Glove = 4,
	Boots = 5,
	Helm = 6,
	Necklace = 7,
	Ring1 = 8,
	Ring2 = 9,
	Earing1 = 10,
	Earing2 = 11,
	Belt = 12,
	Lantern = 13,
	AvatarChest = 14,
	AvatarGlove = 15,
	AvatarBoots = 16,
	AvatarHelm = 17,
	AvatarWeapon = 18,
	AvatarSubWeapon = 19,
	AvatarUnderwear = 20,
	FaceDecoration1 = 21,
	FaceDecoration2 = 22,
	FaceDecoration3 = 23,
	Installation4 = 24,
	Body = 25,
	AvatarBody = 26,
	AlchemyStone = 27,
	ExplorationBonus0 = 28,
	AwakenWeapon = 29,
	AvatarAwakenWeapon = 30,
	QuestBook = 31
}

Inventory.EquipType = {Tool = 46}

---Iterates over the eqipped items and gives every item to the func with parameter itemData
---If func returns true, it will stop prematurely
---@param func function The function to give every item to
Inventory.equipmentIterator = function(func)
	for _, i in pairs(Inventory.EquipmentSlots) do
		local itemData = MagLib.BDO.Inventory.getEquippedItemData(i)
		if itemData and func(itemData) then
			return
		end
	end
end

local hasDamagedEquippedIteratorResult = false
local hasDamagedEquippedItemIterator = function(itemData)
	if itemData.slot ~= Inventory.EquipmentSlots.AlchemyStone and itemData.isRepairable and itemData.dura <
		itemData.maxDura then
		hasDamagedEquippedIteratorResult = true
		return true
	end
end

---Returns true if there is an equipped item with durability < maxDura. Ignores Alchemy stone
---@return boolean true if there is a damaged equipped item
Inventory.hasDamagedEquippedItem = function()
	hasDamagedEquippedIteratorResult = false
	Inventory.equipmentIterator(hasDamagedEquippedItemIterator)
	return hasDamagedEquippedIteratorResult
end

Inventory.getItemSlotByKey = function(key)
	local code = [[
  local inventory = ((getSelfPlayer()):get()):getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local wantedKey = ]] .. key .. [[
  if inventory == nil then
    return - 1
  end

  local invenMaxSize = inventory:sizeXXX()

  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItem(ii)
    if itemWrapper ~= nil then
      if (itemWrapper:get():getKey()):getItemKey() == wantedKey then
        return ii
      end
    end
  end
  return - 1
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

Inventory.getItemSlotByEnhanceLevel = function(itemKey, enhanceLevel)
	local wantedItemData
	local iteratorFunc = function(itemData)
		if itemData.itemKey == itemKey and itemData.enhanceLevel == enhanceLevel then
			wantedItemData = itemData
			return true
		end

		return false
	end
	Inventory.iterator(iteratorFunc)
	return wantedItemData
end

Inventory.openInventory = function()
	Infinity.BDO.Lua.Execute("InventoryWindow_Show(true, false, false)")
end
Inventory.closeInventory = function()
	Infinity.BDO.Lua.Execute("InventoryWindow_Close()")
end

Inventory.resetFilter = function()
	Infinity.BDO.Lua.Execute("Inventory_SetFunctor(nil, nil, nil, nil)")
end

MagLib.BDO.Inventory = Inventory
