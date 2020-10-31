function Inventory.getItemEnchantment(slot)
    --Log.debugLog("Inventory getItemEnchantment")
    local code = [[
    local item = getInventoryItem(]] .. slot ..[[)
    return ((item:get()):getKey()):getEnchantLevel()
    ]]
    return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getItemGradeBySlot(slot)
    --Log.debugLog("Inventory getItemGradeBySlot")
    local code = [[
    local item = getInventoryItem(]] .. slot ..[[)
    local itemStatus = item:getStaticStatus()
    local itemGrade = itemStatus:getGradeType()
    return itemGrade
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function Inventory.getRepairableItemSlots()
    --Log.debugLog("Inventory getRepairableItemSlots")
    local code = [[
local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)

local repairableSlots = {}

if inventory == nil then
return unpack(repairableSlots)
end

local invenMaxSize = inventory:sizeXXX()

if invenMaxSize > 2 then

for ii = 0, invenMaxSize - 1 do
local itemWrapper = getInventoryItem(ii)

if itemWrapper ~= nil then
    local endurance = (itemWrapper:get()):getEndurance()
    local maxendurance = (itemWrapper:get()):getMaxEndurance()
    local isAble = itemWrapper:checkToRepairItem()
    if isAble then
     table.insert(repairableSlots, ii)
    end
end
end
end

return unpack(repairableSlots)
]]

    local repairableSlots = Infinity.BDO.Lua.Execute(code)

    if repairableSlots ~= nil then
        return {repairableSlots}
    else
        return {}
    end
end

function Inventory.getInventoryMoney()
    --Log.debugLog("Inventory getInventoryMoney")
    return Infinity.BDO.Lua.Execute("return Int64toInt32(getSelfPlayer():get():getInventory():getMoney_s64())")
end

function Inventory.isItemBelowEndurance(endurance)
    --Log.debugLog("Inventory isItemBelowEndurance")
    local code = [[
	if CppEnums.EquipSlotNoClient.eEquipSlotNoCount > 1 then
    for ii = 0, CppEnums.EquipSlotNoClient.eEquipSlotNoCount - 1 do
      if ii ~= CppEnums.EquipSlotNo.alchemyStone then
		      local itemWrapper = ToClient_getEquipmentItem(ii)

		        if itemWrapper ~= nil then

		              local curEndurance = itemWrapper:get():getEndurance()
                  local maxEndurance = itemWrapper:get():getMaxEndurance()
                  local endurancePercent = (curEndurance / maxEndurance) * 100
                  if endurancePercent < ]] .. endurance ..[[ then
        return true
    end
end
end
end
end
return false
]]
return Infinity.BDO.Lua.Execute(code)

end

function Inventory.canRepairEquippedItem(slot)
--Log.debugLog("Inventory canRepairEquippedItem")
local code = [[
local eqItem = ToClient_getEquipmentItem(]]..slot..[[)
if eqItem and eqItem:checkToRepairItem() and eqItem:get() and eqItem:get():getEndurance() < eqItem:get():getMaxEndurance() then
return true
end
return false]]

return Infinity.BDO.Lua.Execute(code)
end
