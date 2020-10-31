Equip = {}

function Equip.hasHarpoonEquipped()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(0))
  		  		
    	return (rightHandItemWrapper:getStaticStatus()):getEquipType() == 48 and (rightHandItemWrapper:get()):getEndurance() > 0
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasFishingRodEquipped()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(0))
  		  		
    	return (rightHandItemWrapper:getStaticStatus()):getEquipType() == 44 and (rightHandItemWrapper:get()):getEndurance() > 0
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasFloatEquipped()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(1))
  		  		
    	return (rightHandItemWrapper:getStaticStatus()):getEquipType() == 59 and (rightHandItemWrapper:get()):getEndurance() > 0
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasAnyFishingRodEquipped()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(0))
  		  		
    	return (rightHandItemWrapper:getStaticStatus()):getEquipType() == 44
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasAnyFloatEquipped()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(1))
  		  		
    	return (rightHandItemWrapper:getStaticStatus()):getEquipType() == 59
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.useAlchemyStone()
	local code = 
	[[
		FGlobal_AlchemyStone_Use()
	]]
	
	Infinity.BDO.Lua.Execute(code)
end

function Equip.getAlchemyStoneCooldown()
	local code = 
	[[
		local coolTime = PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()

  		return coolTime
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getAlchemyStoneDurability()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem((CppEnums.EquipSlotNoClient).eEquipSlotNoAlchemyStone)
  		  		
    	if itemWrapper == nil then
    		return 0
    	end

    	return (itemWrapper:get()):getEndurance()
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasAlchemyStoneEquipped()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem((CppEnums.EquipSlotNoClient).eEquipSlotNoAlchemyStone)
  		  		
    	return itemWrapper ~= nil
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasToolEquipped()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem((CppEnums.EquipSlotNoClient).eEquipSlotNoSubTool)
  		  		
    	return itemWrapper ~= nil
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getToolDurability()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem((CppEnums.EquipSlotNoClient).eEquipSlotNoSubTool)
  		  		
		if itemWrapper == nil then
			return 0
		end

    	return itemWrapper:get():getEndurance()
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getMainhandDurabilityPercentage()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem(0)
  		  		
		if itemWrapper == nil then
			return 100.0
		end

		local curEndurance = itemWrapper:get():getEndurance()
        local maxEndurance = itemWrapper:get():getMaxEndurance()

    	return (curEndurance / maxEndurance) * 100
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getToolItemId()
	local code = 
	[[
		local itemWrapper = ToClient_getEquipmentItem((CppEnums.EquipSlotNoClient).eEquipSlotNoSubTool)
  		  		
		if itemWrapper == nil then
			return 0
		end

    	return ((itemWrapper:get()):getKey()):getItemKey()
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getFishingRodDurability()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(0))
  		
  		local durability = 0

    	if (rightHandItemWrapper:getStaticStatus()):getEquipType() == 44 then

    		durability = (rightHandItemWrapper:get()):getEndurance()
    	end

    	return durability
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.getHarpoonDurability()
	local code = 
	[[
		local rightHandItemWrapper = (ToClient_getEquipmentItem(0))
  		
  		local durability = 0

    	if (rightHandItemWrapper:getStaticStatus()):getEquipType() == 48 then

    		durability = (rightHandItemWrapper:get()):getEndurance()
    	end

    	return durability
	]]
	
	return Infinity.BDO.Lua.Execute(code)
end

function Equip.unequip(slotNo)	
	UnEquipItemReq():construct(Infinity.BDO.getLocalPlayer():getActorKey(), slotNo).Packet:send()
end

function Equip.equip(slotNoInv, equipSlot)		
	if equipSlot == nil then
		equipSlot = Inventory.getEquipSlot(slotNoInv)
	end

	EquipItemReq():construct(Infinity.BDO.getLocalPlayer():getActorKey(), 0, slotNoInv, equipSlot).Packet:send()
end

function Equip.equipCash(slotNoInv, equipSlot)
	if equipSlot == nil then
		equipSlot = CashInventory.getEquipSlot(slotNoInv)
	end

	EquipItemReq():construct(Infinity.BDO.getLocalPlayer():getActorKey(), 17, slotNoInv, equipSlot).Packet:send()
end

function Equip.getMaxSize()
  local code =
  [[
	  return CppEnums.EquipSlotNoClient.eEquipSlotNoCount
  ]]
  
  return Infinity.BDO.Lua.Execute(code)
end

function Equip.getItemData(slot)
  local code =
  [[
    local name = ""
    local itemId = 0
    local count = 0
    local itemEnchantKeyRaw = 0

    local itemWrapper = ToClient_getEquipmentItem(]] .. slot .. [[)

    if itemWrapper ~= nil then
      name = (itemWrapper:getStaticStatus()):getName()
      itemId = ((itemWrapper:get()):getKey()):getItemKey()
      itemEnchantKeyRaw = (((itemWrapper:getStaticStatus()):get())._key):get()
      count = Int64toDouble((itemWrapper:get()):getCount_s64())
    end

    return name, itemId, count, itemEnchantKeyRaw
  ]]
  
  return Infinity.BDO.Lua.Execute(code)
end

function Equip.hasItemWrapper(slot)
  local code =
  [[
    return ToClient_getEquipmentItem(]] .. slot .. [[) ~= nil
  ]]
  
  return Infinity.BDO.Lua.Execute(code)
end