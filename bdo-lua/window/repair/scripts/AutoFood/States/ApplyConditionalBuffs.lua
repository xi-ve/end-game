ApplyConditionalBuffs = { }
ApplyConditionalBuffs.__index = ApplyConditionalBuffs
ApplyConditionalBuffs.Name = "Apply Conditional Buffs"

setmetatable(ApplyConditionalBuffs, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ApplyConditionalBuffs.new()
  local self = setmetatable({}, ApplyConditionalBuffs) 

  self.lastValidationTick = 0  
  self.ConditionalBuffs = {}

  self.currentConditionalBuffIndex = 0

  self:load()
  return self
end

function ApplyConditionalBuffs:checkCondition(condition, value, index)
	local valueBuffer = false

	if condition == "HP >=" then

		valueBuffer = LocalPlayer.getHpPercentage() >= tonumber(value[1])
	elseif condition == "HP <=" then
		--print(LocalPlayer.getHpPercentage() .. " <= " .. tonumber(value[1]))
		valueBuffer = LocalPlayer.getHpPercentage() <= tonumber(value[1])
	elseif condition == "MP >=" then
		--print(LocalPlayer.getMpPercentage() .. " <= " .. tonumber(value[1]))
		valueBuffer = LocalPlayer.getMpPercentage() >= tonumber(value[1])
	elseif condition == "MP <=" then

		valueBuffer = LocalPlayer.getMpPercentage() <= tonumber(value[1])
	elseif condition == "hasBuff" then

		valueBuffer = Buffs.hasBuffByName(value[1])
	elseif condition == "not hasBuff" then

		valueBuffer = not Buffs.hasBuffByName(value[1])
	elseif condition == "time" then

		valueBuffer = self.ConditionalBuffs[index].LastUse + (tonumber(value[1]) * 60 * 1000) <= Infinity.Win32.GetTickCount()
	elseif condition == "remain buffTime <=" then

		valueBuffer = (Buffs.getBuffRemainingTimeByName(value[2]) / 60 / 1000) <= tonumber(value[1])
	elseif condition == "remain buffTime >=" then
		
		valueBuffer = (Buffs.getBuffRemainingTimeByName(value[2]) / 60 / 1000) >= tonumber(value[1])
	elseif condition == "Energy >=" then
		
		valueBuffer = LocalPlayer.getWp() >= tonumber(value[1])
	elseif condition == "Energy <=" then
		
		valueBuffer = LocalPlayer.getWp() <= tonumber(value[1])
	end

	return valueBuffer
end

function ApplyConditionalBuffs:getAvailable()
	local bufferIndex = 0

	local isAlchemyStone = false

	--print("ApplyConditionalBuffs:getAvailable()")

	for k,cb in pairs(self.ConditionalBuffs) do
		--print(cb.ItemName)
		if cb.ItemId == 0 then
			isAlchemyStone = true
		else
			isAlchemyStone = false
		end

		local isCash = cb.IsCash ~= nil and cb.IsCash
		--print("IsCash: " .. tostring(cb.IsCash))
		if not isAlchemyStone then
			--print("not isAlchemyStone")
			if not isCash then
				--print("not isCash")
				if Inventory.getItemCountByItemId(cb.ItemId, 0) ~= 0 then -- has item in inventory

					local cooldownMS = Inventory.getItemCooldownMS(Inventory.getItemSlotItemId(cb.ItemId))

					if cooldownMS <= 0.0 then

						if cb.NextUse <= Infinity.Win32.GetTickCount() then

							local globalBool = true

							for kk,c in pairs(cb.Conditions) do
								globalBool = self:checkCondition(c.Condition, c.Value, k)

								if not globalBool then
									break
								end
							end

							if globalBool then
								bufferIndex = k

								break
							end
						end
					else

						cb.NextUse = Infinity.Win32.GetTickCount() + cooldownMS
					end
				end
			else

				if CashInventory.getItemCountByItemId(cb.ItemId, 0) ~= 0 then -- has item in cashinventory

					local cooldownMS = CashInventory.getItemCooldownMS(CashInventory.getItemSlotItemId(cb.ItemId))

					if cooldownMS <= 0.0 then

						if cb.NextUse <= Infinity.Win32.GetTickCount() then

							local globalBool = true

							for kk,c in pairs(cb.Conditions) do
								globalBool = self:checkCondition(c.Condition, c.Value, k)

								if not globalBool then
									break
								end
							end

							if globalBool then
								bufferIndex = k

								break
							end
						end
					else

						cb.NextUse = Infinity.Win32.GetTickCount() + cooldownMS
					end
				end
			end
		else
			--print("isAlchemyStone")
			if Equip.hasAlchemyStoneEquipped() and Equip.getAlchemyStoneDurability() > 0 then

				local cooldownSec = Equip.getAlchemyStoneCooldown()

				if cooldownSec == -1 then

					if cb.NextUse <= Infinity.Win32.GetTickCount() then

						local globalBool = true

						for kk,c in pairs(cb.Conditions) do
							globalBool = self:checkCondition(c.Condition, c.Value, k)

							if not globalBool then
								break
							end
						end

						if globalBool then
							bufferIndex = k

							break
						end
					end
				else

					cb.NextUse = Infinity.Win32.GetTickCount() + (cooldownSec * 1000)
				end
			end
		end
	end

	self.currentConditionalBuffIndex = bufferIndex
end

function ApplyConditionalBuffs:load()
	for k,v in pairs(AutoFood.Settings.ConditionalBuffs) do
		
		if v.Enabled then
			table.insert(self.ConditionalBuffs, {Enabled = v.Enabled, IsCash = v.IsCash, ItemId = v.ItemId, ItemName = v.Name, Conditions = v.Conditions, NextUse = 0, LastUse = 0})
		end
	end
end

function ApplyConditionalBuffs:NeedToRun()
    if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    self.lastValidationTick = Infinity.Win32.GetTickCount()

    if LocalPlayer.isDead() then
        return false
    end

    self:getAvailable()

    return self.currentConditionalBuffIndex ~= 0
end

function ApplyConditionalBuffs:Run() 
	self.ConditionalBuffs[self.currentConditionalBuffIndex].LastUse = Infinity.Win32.GetTickCount()
	self.ConditionalBuffs[self.currentConditionalBuffIndex].NextUse = self.ConditionalBuffs[self.currentConditionalBuffIndex].NextUse + 1000

	local itemName = self.ConditionalBuffs[self.currentConditionalBuffIndex].ItemName
	local itemId = self.ConditionalBuffs[self.currentConditionalBuffIndex].ItemId
	local slot = 0
	local isAlchemyStone = false
	local isCash = self.ConditionalBuffs[self.currentConditionalBuffIndex].IsCash ~= nil and self.ConditionalBuffs[self.currentConditionalBuffIndex].IsCash

	if itemId == 0 then
		slot = -1
		isAlchemyStone = true
	else

		if isCash then
			slot = CashInventory.getItemSlotItemId(itemId)
		else
			slot = Inventory.getItemSlotItemId(itemId)
		end
	end	

	if slot <= 0 and not isAlchemyStone then
		print("Could not find inventory slot of item!")
		return
	end

	if not isAlchemyStone then	

		if isCash then

			CashInventory.useItem(slot)
			print("Used Cash Item " .. itemName .. "(" .. itemId .. ") On CashInventory Slot " .. slot)
		else

			Inventory.useItem(slot)
			print("Used Item " .. itemName .. "(" .. itemId .. ") On Inventory Slot " .. slot)
		end
	else
		Equip.useAlchemyStone()
		print("Used Alchemy Stone")
	end	
end