WarehouseTask = {}


--This is a lot less strict then the NeedToGoToTown one, as this is only called when we got to town anyways, so it should return true most of the time.
function WarehouseTask.needToRun()
    --Log.debugLog("WarehouseTask needToRun")

    if Grinder.currentProfile.npcs["Storage"] and #Grinder.currentProfile.npcs["Storage"] > 0 then
        if Grinder.forceStorage then
            return true
        end

        if Grinder.settings.doWarehouse then

            local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
            if silverSlot ~= -1 and silverCount > 0 then
                local moneyToDeposit = silverCount - Grinder.settings.keep_silver_amount
                if moneyToDeposit > 250000 then
                    moneyToDeposit = nil
                    return true
                end

                moneyToDeposit = nil
            end

            silverCount = nil
            silverSlot = nil

            NPCUtils.getDepositItems()
            if NPCUtils.itemsToDeposit and #NPCUtils.itemsToDeposit > 0 then
                return true
            end

        end

        if Grinder.settings.doTakeOut then
            NPCUtils.getTakeOutItems()
            if NPCUtils.itemsToTakeOut and #NPCUtils.itemsToTakeOut > 0 then
                return true
            end
        end


    end

    Grinder.finishedStorage = true
    return false
end

WarehouseTask.openedNPCPanel = false
WarehouseTask.openedWarehousePanel = false

function WarehouseTask.work()
    Log.debugLog("WarehouseTask work")
    if not Grinder.currentProfile.npcs["Storage"] or #Grinder.currentProfile.npcs["Storage"] == 0 then
        Grinder.forceStorage = false
        return true
    end

    local actorName, actorPos = WarehouseTask.selectActor()

    local npcActor = MoveToNpcTask.work(actorPos, actorName, 350)

    actorName = nil
    actorPos = nil

    if npcActor then
        local finishedDeposit = WarehouseTask.depositItems(npcActor)
        if finishedDeposit then
            local finishedTakeOut = WarehouseTask.takeOutItems(npcActor)
            if finishedTakeOut then
                NPCUtils.closeNpcDialog()
                Grinder.forceStorage = false
                return true
            end

            finishedTakeOut = nil
        end

        finishedDeposit = nil
    else
        Grinder.navigationPulse()
    end


    return false
end

function WarehouseTask.selectActor()
    Log.debugLog("WarehouseTask selectActor")
    local actorName, actorDistance, actorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Storage"])

    actorDistance = nil

    return actorName, actorPos
end

function WarehouseTask.depositItems(npcActor)

    if not Grinder.settings.doWarehouse then
        return true
    end

    if Grinder.settings.use_legacy_warehouse then
        return WarehouseTask.depositItems_legacy(npcActor)
    end

    if npcActor ~= nil then

        NPCUtils.getDepositItems(true)

        local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
        if silverSlot ~= -1 and silverCount > 0 then
            local moneyToDeposit = silverCount - Grinder.settings.keep_silver_amount
            if moneyToDeposit > 0 then
                Log.log("Deposit " .. moneyToDeposit .." Silver!")
                PushInventoryItemToWarehouse():construct(false, 0, 0, silverSlot, moneyToDeposit, Infinity.BDO.getLocalPlayer():getActorKey(), npcActor:getActorKey()).Packet:send()
                Grinder.wait(550)

                moneyToDeposit = nil
                silverSlot = nil
                silverCount = nil
                return false
            end

            moneyToDeposit = nil
        end

        silverSlot = nil
        silverCount = nil

        if Warehouse.getFreeSlots() > 0 then
            for k, v in pairs(Grinder.settings.deposit_items) do
                local iCount, iSlot = Inventory.getItemDataByItemId(v.itemId)
                if iSlot ~= -1 and iCount > 0 then
                    Log.log("Putting item in slot " .. iSlot .. " " .. iCount .. "x into warehouse!")
                    PushInventoryItemToWarehouse():construct(false, 0, v.itemId, iSlot, iCount, Infinity.BDO.getLocalPlayer():getActorKey(), npcActor:getActorKey()).Packet:send()
                    Grinder.wait(550)

                    iCount = nil
                    iSlot = nil

                    return false
                end

                iCount = nil
                iSlot = nil
            end
        end
    else
        Log.log("[ERROR] No Warehouse Actor found")
    end

    NPCUtils.getDepositItems(true)
    return true
end

WarehouseTask.lastTimeRequestedWarehouseInfo = 0

function WarehouseTask.takeOutItems(npcActor)
    Log.debugLog("WarehouseTask takeOutItems")

    if not Grinder.settings.doTakeOut then
        return true
    end

    if Grinder.settings.use_legacy_warehouse then
        --print("finished: " .. tostring(finished))
        return WarehouseTask.takeOutItems_legacy(npcActor)
    end

    if npcActor ~= nil then


        if WarehouseTask.lastTimeRequestedWarehouseInfo + 30000 < Cache.time then
            Warehouse.RequestCurrentRegionWarehouseInfo()
            WarehouseTask.lastTimeRequestedWarehouseInfo = Cache.time
        end

        NPCUtils.getTakeOutItems(true)

        if Inventory.getFreeSlotCount() > 0 then
            for k, v in pairs(Grinder.settings.takeFromStorage_items) do
                if not table.find(Grinder.notInWarehouseIds, v.itemId) then
                    local iCount, iSlot = Inventory.getItemDataByItemId(v.itemId)
                    if iCount < v.amount then --Less than wanted
                        local wCount, wSlot = Warehouse.getItemDataByItemId(v.itemId, Warehouse.getCurrentWaypointKey())

                        if not wCount or not wSlot or wSlot == -1 or wCount == 0 then
                            table.insert(Grinder.notInWarehouseIds, v.itemId)

                            wCount = nil
                            wSlot = nil
                            iCount = nil
                            iSlot = nil
                            return false
                        end

                        if wCount > 0 and wSlot and wSlot ~= -1 then
                            local transportCount = (v.amount - iCount)
                            if transportCount > wCount then
                                transportCount = wCount
                            end

                            if transportCount > 0 then
                                Log.log("Putting item from warhouse slot  " .. wSlot .. " " .. transportCount .. "x into inventory!")
                                PopWarehouseItemToInventory():construct(false, Warehouse.getItemId(wSlot), wSlot, transportCount, Infinity.BDO.getLocalPlayer():getActorKey(), npcActor:getActorKey()).Packet:send()
                                Grinder.wait(250)
                            end
                        end

                        return false
                    end
                end
            end
        end
    else
        Log.log("[ERROR] No Warehouse Actor found")
    end

    return true

end



function WarehouseTask.takeOutItems_legacy(npcActor)
    Log.debugLog("WarehouseTask takeOutItems_legacy")
    if not Grinder.settings.doTakeOut then
        return true
    end

    local warehouseActor = npcActor

    if warehouseActor ~= nil then
        local dialogOpen = WarehouseTask.openNPC(npcActor)

        if not dialogOpen then
            return false
        end

        NPCUtils.getTakeOutItems(true)
        if Inventory.getFreeSlotCount() > 0 then
            for k, v in pairs(Grinder.settings.takeFromStorage_items) do
                if not table.find(Grinder.notInWarehouseIds, v.itemId) then
                    local iCount, iSlot = Inventory.getItemDataByItemId(v.itemId)
                    if iCount < v.amount then --Less than wanted
                        local wCount, wSlot = Warehouse.getItemDataByItemId(v.itemId, Warehouse.getCurrentWaypointKey())

                        if not wCount or not wSlot or wSlot == -1 or wCount == 0 then
                            table.insert(Grinder.notInWarehouseIds, v.itemId)
                            return false
                        end

                        if wCount > 0 and wSlot and wSlot ~= -1 then
                            local transportCount = (v.amount - iCount)
                            if transportCount > wCount then
                                transportCount = wCount
                            end
                            Log.log("Putting item from warhouse slot  " .. wSlot .. " " .. transportCount .. "x into inventory!")
                            Warehouse.moveToInventory(wSlot, transportCount)
                            Grinder.wait(250)
                        end
                        return false
                    end
                end
            end
        end
    else
        Log.log("[ERROR] No Warehouse Actor found")
    end

    NPCUtils.getTakeOutItems(true)
    return true
end

function WarehouseTask.depositItems_legacy(npcActor)
    Log.debugLog("WarehouseTask depositItems")
    if not Grinder.settings.doWarehouse then
        return true
    end

    local warehouseActor = npcActor

    if warehouseActor ~= nil then

        local dialogOpen = WarehouseTask.openNPC(npcActor)

        if not dialogOpen then
            return false
        end


        NPCUtils.getDepositItems(true)

        local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
        if silverSlot ~= -1 and silverCount > 0 then
            local moneyToDeposit = silverCount - Grinder.settings.keep_silver_amount
            if moneyToDeposit > 0 then
                Log.log("Deposit " .. moneyToDeposit .." Silver!")
                Warehouse.moveFromInventory(silverSlot, moneyToDeposit, warehouseActor:getActorKey())
                Grinder.wait(750)
                return false
            end
        end

        if Warehouse.getFreeSlots() > 0 then
            for k, v in pairs(Grinder.settings.deposit_items) do
                local iCount, iSlot = Inventory.getItemDataByItemId(v.itemId)
                if iSlot ~= -1 and iCount > 0 then
                    Log.log("Putting item in slot " .. iSlot .. " " .. iCount .. "x into warehouse!")
                    Warehouse.moveFromInventory(iSlot, iCount, warehouseActor:getActorKey())
                    Grinder.wait(750)
                    return false
                end
            end
        end
    else
        Log.log("[ERROR] No Warehouse Actor found")
    end

    NPCUtils.getDepositItems(true)
    return true
end

function WarehouseTask.openNPC(npcActor)
    --[[local talkerKey = Infinity.BDO.Lua.Execute("return dialog_getTalker():getActorKey()")
    if talkerKey ~= npcActor:getActorKey() then
        Infinity.BDO.getDialogManager():setTalker(npcActor)
        Grinder.wait(20)
        return false
    end]]

    if UI.getShow("Panel_Npc_Dialog") then
        if not Infinity.BDO.Lua.Execute("return Panel_Window_Warehouse:GetShow()") then
            Infinity.BDO.Lua.Execute("Warehouse_OpenPanelFromDialog()")
            Grinder.wait(1000)
            return false
        else
            return true
        end
    else
        --Open Dialog
        local rightActorNpc = Infinity.BDO.Lua.Execute("return interaction_getInteractable():getActorKey() == " .. npcActor:getActorKey())
        if rightActorNpc then
            if Grinder.settings.log_verbose then
                Log.log("Interacting with NPC")
            end
            Interaction.interact(4)
            Grinder.wait(1000)
            return false
        else
            if Grinder.settings.log_verbose then
                Log.log("Getting closer to NPC")
            end
            --Looking at npc
            local npcPos = npcActor:getPosition()
            NPCUtils.lookAt(npcPos)

            --TPing closer
            local rVec = Vector3(Cache.playerPos.X - npcPos.X, Cache.playerPos.Y - npcPos.Y, Cache.playerPos.Z - npcPos.Z)
            local destVec = Vector3(rVec.X / 5 + Cache.playerPos.X, rVec.Y / 5 + Cache.playerPos.Y, rVec.Z / 5 + Cache.playerPos.Z)
            Teleport.tpTo(destVec)
            Input.pressOnce({KeyCode_SPACE}, 100)
            Grinder.wait(700)
            return false
        end
    end
end
