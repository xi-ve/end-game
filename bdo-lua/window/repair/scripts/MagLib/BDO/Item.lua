---@class Item
local Item = Class({
	name = "",
	slot = -1,
	itemKey = -1,
	count = -1,
	itemEnchantKeyRaw = -1,
	enhanceLevel = -1,
	dura = -1,
	maxDura = -1,
	equipType = -1,
	grade = -1,
	minCraftLevelType = -1,
	minCraftLevel = -1,
	isRepairable = false,
	isInEquipmentSlot = false,
	isAlchemyStone = false,
	valid = true
})
Item:setClassName("Item")

---Fills the objects variables with data from an item in a given slot
---@param slot number the slot number
---@param isEquipmentSlot boolean true if should be equipped item, else false
function Item:loadFromSlot(slot, isEquipmentSlot)
	if isEquipmentSlot == nil then
		isEquipmentSlot = false
	end

	-- TODO: Add itemWrapper:getStaticStatus():getEquipSlotNo()
	-- together with equipslotno enum over MagLib.BDO.Lua.getEnum("") 
	local code = [[
  local itemWrapper
  if ]] .. tostring(isEquipmentSlot) .. [[ == false then
    itemWrapper = getInventoryItem(]] .. slot .. [[)
  else
    itemWrapper = ToClient_getEquipmentItem(]] .. slot .. [[)
  end
  
  if itemWrapper == nil then
    return nil 
  end

  local itemSSW = itemWrapper:getStaticStatus()
  
  local name = itemSSW:getName()
  local itemId = ((itemWrapper:get()):getKey()):getItemKey()
  local count = Int64toDouble((itemWrapper:get()):getCount_s64())
  local itemEnchantKeyRaw = ((itemSSW:get())._key):get()
  local enhanceLevel = ((itemWrapper:get()):getKey()):getEnchantLevel()
  local dura = (itemWrapper:get()):getEndurance()
  local maxDura = (itemWrapper:get()):getMaxEndurance()
  local itemGrade = itemSSW:getGradeType()
  local equipType = itemSSW:getEquipType()
  local minCraftLevelType = itemSSW:get():getLifeExperienceType()
  local minCraftLevel = itemSSW:get():getLifeMinLevel(minCraftLevelType)
  local isRepairable = itemWrapper:checkToRepairItem()
  local isAlchemyStone = (32 == itemSSW:get():getContentsEventType() or 37 == itemSSW:get():getContentsEventType())

  return name, itemId, count, itemEnchantKeyRaw, enhanceLevel, dura, maxDura, equipType, itemGrade, minCraftLevelType, minCraftLevel, isRepairable, isAlchemyStone
  ]]
	self.name, self.itemKey, self.count, self.itemEnchantKeyRaw, self.enhanceLevel, self.dura, self.maxDura, self.equipType, self.grade, self.minCraftLevelType, self.minCraftLevel, self.isRepairable, self.isAlchemyStone =
		Infinity.BDO.Lua.Execute(code)
	self.slot = slot
	if self.name == nil then
		self.valid = false
	end
end

function Item:init(slot, isEquipmentSlot)
	if isEquipmentSlot then
		self.isInEquipmentSlot = true
	end

	if slot then
		self:loadFromSlot(slot, isEquipmentSlot)
	end
end

-- TODO: should be replaced by variable
function Item:isDamaged()
	return self.dura < self.maxDura
end

-- Static functions
Item.isItemIdPotion = function(itemId)
	return table.find(MagLib.BDO.Enums.PotionIds, itemId) ~= nil
end
MagLib.BDO.Item = Item
