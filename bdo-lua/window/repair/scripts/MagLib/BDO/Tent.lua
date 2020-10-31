---@Module MagLib.BDO.Tent
---@alias Tent
local Tent = {}

---Sends the Tent installation packet to install the tent at the current position
---@param tentId LuaInt64 
function Tent.install(tentId)
	if Tent.isInstalled() then
		Tent.collect()
	end

	local pPos = MagLib.BDO.Actors.LocalPlayer.getPos()
	InstallTentReq():construct(tentId, pPos.X, pPos.Y, pPos.Z).Packet:send()
end

---Collects the tent if it is installed
function Tent.collect()
	if Tent.isInstalled() then
		CollectTentReq():construct(Tent.getId()).Packet:send()
	end
end

---Grabs your tentId
---@return LuaInt64 the tent id
function Tent.getId()
	return Infinity.BDO.getLocalPlayer():getMyTentObjectId()
end

local isActorTent = function(actor)
	return actor:getActorId() == 9999
end

function Tent.getActorKey()
	local actor = MagLib.BDO.Actors.getClosestFilteredActor(EActorType_Vehicle, isActorTent)
	if actor ~= nil then
		return actor:getActorKey()
	else
		return nil
	end
end

---Checks if your tent is installed
---@return boolean true if tent is installed, else false
local LongZero = LuaInt64(0)
function Tent.isInstalled()
	return Tent.getId() ~= LongZero and Tent.getActorKey() ~= nil
end

---Repairs a given equipped item over tent
---@param equippedSlotNo number The slot of the equipment that should be repaired
---@param shouldLog boolean If the function should print "Repairing equipment in slot x over Tent!". Default true
function Tent.repairEquipped(equippedSlotNo, shouldLog)
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.repairEquipped()")
		return
	end

	if shouldLog == nil then
		shouldLog = true
	end

	local me = Infinity.BDO.getLocalPlayer()
	RepairItemReq():construct(Tent.getId(), equippedSlotNo, 0, 1, me:getActorKey(), -1024, me:getInventoryMoneyNo()).Packet:send()
	if shouldLog then
		MagLib.logger.info("Repairing equipment in slot " .. tostring(equippedSlotNo) .. " over Tent!")
	end
end

---Helper iterator
local repairAllEquippedIterator = function(item)
	if item.slot ~= MagLib.BDO.Inventory.EquipmentSlots.AlchemyStone and item.isRepairable and item:isDamaged() then
		Tent.repairEquipped(item.slot)
	end
end

---Repairs all equipped items over tent
function Tent.repairAllEquipped()
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.repairAllEquipped()")
		return
	end

	MagLib.BDO.Inventory.equipmentIterator(repairAllEquippedIterator)
end

-- Repairs a given inventory item over tent
---@param slotNo number The slot of the equipment that should be repaired
---@param shouldLog boolean If the function should print "Repairing equipment in slot x over Tent!". Default true
function Tent.repairInventoryItem(slotNo, shouldLog)
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.repairInventoryItem()")
		return
	end

	if shouldLog == nil then
		shouldLog = true
	end

	local lp = Infinity.BDO.getLocalPlayer()
	RepairItemReq():construct(Tent.getId(), slotNo, 0, 0, lp:getActorKey(), -1024, lp:getInventoryMoneyNo()).Packet:send()
	if shouldLog then
		MagLib.logger.info("Repairing inventory item in slot " .. tostring(slotNo) .. " over Tent!")
	end
end

---Helper iterator
local repairAllInventoryItemsIterator = function(item)
	if not item.isAlchemyStone and item.isRepairable and item:isDamaged() then
		Tent.repairInventoryItem(item.slot)
	end
end
function Tent.repairAllInventoryItems()
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.repairAllInventoryItems()")
		return
	end

	MagLib.BDO.Inventory.iterator(repairAllInventoryItemsIterator)
end

---Returns true if tent shop is open
---@return boolean true if tent shop is open
function Tent.isShopOpen()
	local code = [[
    return Panel_Dialog_NPCShop_All:GetShow() and PaGlobalFunc_NPCShop_ALL_GetIsCamping()
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

---Opens the Tent shop
function Tent.openShop()
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.openShop()")
		return
	end

	local code = [[
    ToClient_requestCampingShopOpen()
  ]]
	Infinity.BDO.Lua.Execute(code)
end

---Closes all tent related UIs
function Tent.closeUI()
	Infinity.BDO.Lua.Execute("PaGlobalFunc_Camp_All_CloseAll()")
end

Tent.shopSlots = {
	[43929] = 0,
	[43930] = 1,
	[43931] = 2,
	[43932] = 3,
	[43933] = 4,
	[43934] = 5,
	[2] = 6,
	[3] = 7,
	[4] = 8,
	[524] = 0,
	[526] = 1,
	[594] = 2,
	[598] = 3,
	[529] = 4,
	[532] = 5
}

---Buys a specific item from the tent
---@param itemId number the itemId of the item you want to buy
---@param amount number amount you want to buy
---@return boolean true if packet to buy was sent (doesn't mean buy will succeed)
function Tent.buyItem(itemId, amount)
	if itemId == nil then
		MagLib.logger.error("Tent.buyItem() provided itemID is nil")
		return false
	end

	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.buyItem()")
		return false
	end

	local isPotion
	if MagLib.BDO.Item.isItemIdPotion(itemId) then
		isPotion = 1
	else
		isPotion = 0
	end

	local shopSlot = Tent.shopSlots[itemId]
	if shopSlot == nil then
		MagLib.logger.error("Buying unknown item from Tent. Please contact Magxm for fixing the issue")
		return false
	end

	local packet =
		PurchaseFromTentReq():construct(Tent.getId(), Tent.getActorKey(), itemId, amount, isPotion, shopSlot).Packet
	-- MagLib.BDO.Net.packetToFile(packet, "TentBuyItemPacket_ItemId" .. tostring(itemId) .. "_amount" .. tostring(amount) .. ".bin")
	packet:send()
	MagLib.logger.info("Buying item with id " .. tostring(itemId) .. " " .. tostring(amount) .. " times over your Tent!")
	return true
end

---Checks if you have the moon book active
---@return boolean true if moon book is active
function Tent.hasMoonBook()
	-- Copied from Code's maintained version of J-'s TentTool
	local code = [[
        local moonBookDuration = getSelfPlayer():get():getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_BookOfCombat)
	    if moonBookDuration > 0.0 then
            return true
        end
    ]]
	return Infinity.BDO.Lua.Execute(code)
end

---Buys a given villa buff by index over tent
---@param index number index of the villabuff to buy (0-5)
function Tent.buyVillaBuff(index)
	if not Tent.isInstalled() then
		MagLib.logger.error("Please install your Tent first before calling Tent.buyVillaBuff()")
		return false
	end

	local buff = MagLib.BDO.Villa.buffs[index]
	if buff == nil then
		MagLib.logger.error("Requested to buy villa buff " .. tostring(index) .. " but it is not a valid villa buff index")
		return false
	end

	if not MagLib.BDO.Villa.hasAnyVillaInvite() and not Tent.hasMoonBook() then
		MagLib.logger.error("Requested to buy villa buff " .. tostring(index) .. " but we do not have a villa invite")
		return false
	end

	local packet = PurchaseVillaBuffFromTentReq():construct(index).Packet
	-- MagLib.BDO.Net.packetToFile(packet, "TentBuyVillaBuffPacket_BuffIndex" .. tostring(index) .. ".bin")
	packet:send()
	MagLib.logger.info("Buying Buff with index " .. index .. " over Tent!")
	return true
end

MagLib.BDO.Tent = Tent
