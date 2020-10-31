RestockTask = {}

RestockTask.calculated = false
RestockTask.hpBuyAmount = 0
RestockTask.mpBuyAmount = 0

RestockTask.needToBuyHp = false
RestockTask.needToBuyMp = false
RestockTask.needToBuyUpdatedTime = 0


--This is a lot less strict then the NeedToGoToTown one, as this is only called when we got to town anyways, so it should return true most of the time.
function RestockTask.needToRun()
    --Log.debugLog("RestockTask NeedToRun")

    if Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0 then
        if Grinder.forcePotionBuy then
            return true
        end

        if RestockTask.needToBuyUpdatedTime + 100 < Cache.time then
            RestockTask.needToBuyHp = RestockTask.needToBuy(1)
            RestockTask.needToBuyMp = RestockTask.needToBuy(2)
            RestockTask.needToBuyUpdatedTime = Cache.time
        end

        if Grinder.settings.usePotions and (RestockTask.needToBuyHp or RestockTask.needToBuyMp) then
            return true
        end
    end

    --if (Grinder.settings.buy_hp_potion or Grinder.settings.buy_mp_potion) then
    --    return true
    --end



    Grinder.finishedPotionBuy = true
    return false

end

function RestockTask.needToBuy(type)
    --Log.debugLog("RestockTask needToBuy")

    local hpPotsAmount = RestockTask.getPotionCount(1)
    local mpPotsAmount = RestockTask.getPotionCount(2)

    if type == 1 then
        return (Grinder.settings.buy_hp_potion and hpPotsAmount < Grinder.settings.buy_hp_potion_amount)
    elseif type == 2 then
        return (Grinder.settings.buy_mp_potion and mpPotsAmount < Grinder.settings.buy_mp_potion_amount)
    else
        return false
    end
end

function RestockTask.work()
    --Log.debugLog("RestockTask work")
    if not Grinder.currentProfile.npcs["Potions"] or #Grinder.currentProfile.npcs["Potions"] == 0 then
        Grinder.forcePotionBuy = false
        return true
    end

    local actorName, actorPos = RestockTask.selectActor()

    local npcActor = MoveToNpcTask.work(actorPos, actorName, 350)

    actorName = nil
    actorPos = nil

    if npcActor then
        local finishedBuying = RestockTask.buyPotions(npcActor)

        npcActor = nil

        if finishedBuying then

            finishedBuying = nil
            Grinder.forcePotionBuy = false
            return true
        end
    else
        Grinder.navigationPulse()
    end
    return false
end

function RestockTask.selectActor()
    --Log.debugLog("RestockTask selectActor")
    local actorName, actorDistance, actorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Potions"])
    actorDistance = nil
    return actorName, actorPos
end

function RestockTask.getPotionCount(type)
    --Log.debugLog("RestockTask getPotionCount")

    local potIds = nil
    local customId = -1
    if (type == 1) then
        customId = Grinder.settings.buy_hp_potion_id
        potIds = Grinder.potionData.hp
    elseif (type == 2) then
        customId = Grinder.settings.buy_mp_potion_id
        potIds = Grinder.potionData.mp
    else
        Log.log("Unknown potion type!")

        customId = nil
        return 0
    end

    if customId ~= -1 and customId ~= 0 and not table.find(potIds, customId) then
        table.insert(potIds, customId)
    end

    local potionAmount = 0

    for _, v in ipairs(potIds) do
        local count, slot = Inventory.getItemDataByItemId(v)
        if count and count > 0 then
            potionAmount = potionAmount + count
        end

        count = nil
        slot = nil
    end

    potIds = nil

    return potionAmount
end

function RestockTask.isPotion(id, type)
    --Log.debugLog("RestockTask isPotion")
    local potIds = nil
    local customId = -1
    if (type == 1) then
        customId = Grinder.settings.buy_hp_potion_id
        potIds = Grinder.potionData.hp
    elseif (type == 2) then
        customId = Grinder.settings.buy_mp_potion_id
        potIds = Grinder.potionData.mp
    else
        Log.log("Unknown potion type!")
        potIds = nil
        customId = nil

        return 0
    end

    if customId ~= -1 and customId ~= 0 and not table.find(potIds, customId) then
        table.insert(potIds, customId)
    end

    for _, v in ipairs(potIds) do
        if v == id then
            potIds = nil
            customId = nil
            return true
        end
        --Log.log(v .. " ~= " .. id)
    end


    potIds = nil
    customId = nil

    return false
end

RestockTask.lastBuyPotTime = 0

-- ||TODO: Make local vars == nil ||
function RestockTask.buyPotions(npcActor)
    --Log.debugLog("RestockTask buyPotions")
    --[[if not NPCUtils.openNPCDialog(npcActor) then
        return false
    end]]



    if RestockTask.lastBuyPotTime + 250 > Cache.time then
        return false
    end



    if RestockTask.lastBuyPotTime + 3000 < Cache.time or npcActor:getActorKey() ~= Infinity.BDO.Lua.Execute("return dialog_getTalker():getActorKey()") then
        RestockTask.lastBuyPotTime = Cache.time
        Infinity.BDO.getDialogManager():setTalker(npcActor)
        Infinity.BDO.getShopManager():requestShopData(npcActor:getActorKey())
        Infinity.BDO.Lua.Execute("npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)")
        return false
    end

    RestockTask.lastBuyPotTime = Cache.time

    if RestockTask.getPotionCount(1) > Grinder.settings.buy_hp_potion_amount and RestockTask.getPotionCount(2) > Grinder.settings.buy_mp_potion_amount then
        Log.log("Got enough Potions already!")
        return true
    end

    local _hp_pot_slot = nil
    local _hp_pot_price = nil

    local _mp_pot_slot = nil
    local _mp_pot_price = nil

    --[[
    local _inventory_silver = Inventory.getInventoryMoney()
    local _warehouse_silver = Infinity.BDO.Lua.Execute("return Int64toInt32(warehouse_moneyFromNpcShop_s64())")

    if _inventory_silver < Grinder.settings.keep_silver_amount then
        _inventory_silver = 0
        Log.log("[INFO]: You do not have enough silver in your inventory, checking warehouse amount")
        if _warehouse_silver < 1000 and not Grinder.settings.disable_warehouse_money_usage then
            Log.log("[ERROR]: You do not have enough silver in inventory or warehouse to buy potions")
            return
        end

        if Grinder.settings.disable_warehouse_money_usage then
            log("[STUCK]:\n    You do not have enough silver in inventory and disable warehouse money is enabled.\n Bot has been stopped.")
            Grinder.settings.is_started = false
            return
        end
    end]]

    local shopSlots = Infinity.BDO.Lua.Execute("return npcShop_getBuyCount()") - 1


    if shopSlots > 0 then
        for i = 0, shopSlots do
            local code = [[
        local _shop_item_index = npcShop_getItemBuy("]].. i ..[[")
            local _shop_item = _shop_item_index:get()
            local _shop_item_id = _shop_item_index:getStaticStatus():get()._key:getItemKey()
            local _shop_item_price = Int64toInt32(_shop_item:getItemPriceWithOption())

            return _shop_item_id, _shop_item_price
            ]]

            local _shop_item_id, _shop_item_price = Infinity.BDO.Lua.Execute(code)
            --Log.log(_shop_item_id .. " | " .. _shop_item_price)
            --Log.log("DDD: " .. Grinder.settings.buy_hp_potion_id)
            if Grinder.settings.buy_hp_potion_id ~= 0 and Grinder.settings.buy_hp_potion_id ~= 0.0 then
                --Log.log("this")
                if _shop_item_id == Grinder.settings.buy_hp_potion_id then
                    _hp_pot_slot = i
                    _hp_pot_price = _shop_item_price
                end
            else
                --Log.log("that")
                if RestockTask.isPotion(_shop_item_id, 1) then
                    _hp_pot_slot = i
                    _hp_pot_price = _shop_item_price
                end
            end

            if Grinder.settings.buy_mp_potion_id ~= 0 and Grinder.settings.buy_mp_potion_id ~= 0.0 then
                if _shop_item_id == Grinder.settings.buy_mp_potion_id then
                    _mp_pot_slot = i
                    _mp_pot_price = _shop_item_price
                end
            else
                if RestockTask.isPotion(_shop_item_id, 2) then
                    _mp_pot_slot = i
                    _mp_pot_price = _shop_item_price
                end
            end
        end

        if Grinder.settings.buy_hp_potion and Grinder.settings.buy_mp_potion_id ~= 0 and Grinder.settings.buy_hp_potion_amount > 0 and not _hp_pot_slot then
            Log.log("Could not find hp potions with id as configured in the settings")
        end

        if Grinder.settings.buy_mp_potion and Grinder.settings.buy_mp_potion_id ~= 0 and Grinder.settings.buy_mp_potion_amount > 0 and not _mp_pot_slot then
            Log.log("Could not find mp potions with id as configured in the settings")
        end

        if not RestockTask.calculated then
            if _hp_pot_slot ~= nil and Grinder.settings.buy_hp_potion then
                RestockTask.hpBuyAmount = Grinder.settings.buy_hp_potion_amount - RestockTask.getPotionCount(1)
                if RestockTask.hpBuyAmount < 0 then
                    Log.log("We have " .. math.abs(RestockTask.hpBuyAmount) .. " extra health potions already.")
                    RestockTask.hpBuyAmount = 0
                end
            else
                RestockTask.hpBuyAmount = 0
            end


            if _mp_pot_slot ~= nil and Grinder.settings.buy_mp_potion then
                RestockTask.mpBuyAmount = Grinder.settings.buy_mp_potion_amount - RestockTask.getPotionCount(2)
                if RestockTask.mpBuyAmount < 0 then
                    Log.log("We have " .. math.abs(RestockTask.mpBuyAmount) .. " extra mana potions already.")
                    RestockTask.mpBuyAmount = 0
                end
            else
                RestockTask.mpBuyAmount = 0
            end

            local moneyWhereType = 2
            if Grinder.settings.use_Inventory_Money then
                moneyWhereType = 0
            end

            if RestockTask.hpBuyAmount > 0 then
                Log.log("Buying " .. RestockTask.hpBuyAmount .. " hp potions!")
                Infinity.BDO.Lua.Execute("npcShop_doBuy(" .. _hp_pot_slot .. "," .. RestockTask.hpBuyAmount .. ", " .. moneyWhereType ..", CppEnums.ItemWhereType.eInventory, false)")
                RestockTask.hpBuyAmount = 0
                return false
            end

            if RestockTask.mpBuyAmount > 0 then
                Log.log("Buying " .. RestockTask.mpBuyAmount .. " mp potions!")
                Infinity.BDO.Lua.Execute("npcShop_doBuy(" .. _mp_pot_slot .. "," .. RestockTask.mpBuyAmount .. ", " .. moneyWhereType ..", CppEnums.ItemWhereType.eInventory, false)")
                RestockTask.mpBuyAmount = 0
                return false
            end

            RestockTask.calculated = false
            NPCUtils.closeNpcDialog()
            return true
        end
    else
        Log.log("No shopslots?!")
    end

    return false
end
