SellTask = {}
SellTask.selectedActorData = nil

function SellTask.needToRun()
    --Log.debugLog("SellTask needToRun")
    if Grinder.settings.selling then
        if (Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0)
        or (Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0)
        then
            NPCUtils.getSellItems()

            if #NPCUtils.itemsToSell > 0 then
                return true
            end

            if Grinder.forceSell then
                return true
            end
        end
    end

    Grinder.finishedSell = true
    return false
end

function SellTask.selectActor()
    Log.debugLog("SellTask selectActor")
    local closestPotionActorName, closestPotionActorDistance, closestPotionActorPos = nil
    if Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0 then
        closestPotionActorName, closestPotionActorDistance, closestPotionActorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Potions"])
    end
    local closestRepairActorName, closestRepairActorDistance, closestRepairActorPos = nil
    if Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0 then
        closestRepairActorName, closestRepairActorDistance, closestRepairActorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Repair"])
    end


    --[[if (closestPotionActorName) then
        Log.log("closestPotionActorName: " .. closestPotionActorName .. " | closestPotionActorDistance: " .. closestPotionActorDistance)
    end
    if (closestRepairActorName) then
        Log.log("closestRepairActorName: " .. closestRepairActorName .. " | closestRepairActorDistance: " .. closestRepairActorDistance)
    end]]

    if not closestPotionActorName and closestRepairActorName then
        return closestRepairActorName, closestRepairActorPos
    elseif not closestRepairActorName and closestPotionActorName then
        return closestPotionActorName, closestPotionActorPos
    elseif closestPotionActorDistance <= closestRepairActorDistance then
        return closestPotionActorName, closestPotionActorPos
    else
        return closestRepairActorName, closestRepairActorPos
    end

    Log.log("This should not happen...SellTask.selectActor()")
    return nil
end

function SellTask.work()
    Log.debugLog("SellTask work")
    if not ((Grinder.currentProfile.npcs["Potions"] and #Grinder.currentProfile.npcs["Potions"] > 0)
    or (Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0)) then
        Grinder.forceSell = false
        SellTask.selectedActorData = nil
        return true
    end

    local actorName, actorPos
    if SellTask.selectedActorData == nil then
        actorName, actorPos = SellTask.selectActor()

        SellTask.selectedActorData = {actorName = actorName, actorPos = actorPos}
        SellTask.selectedActorDataTime = Cache.time
    else
        actorName = SellTask.selectedActorData.actorName
        actorPos = SellTask.selectedActorData.actorPos
    end


    --Log.log("actorName: " .. actorName .. " | actorPos: " .. VectorUtils.toString(actorPos))
    local npcActor = MoveToNpcTask.work(actorPos, actorName, 350)
    actorName = nil
    actorPos = nil

    if npcActor then
        Log.debugLog("SellTask at npc")
        local finishedSelling = NPCUtils.sellAllItemsFromSettingsList(npcActor)

        npcActor = nil
        if finishedSelling then
            finishedSelling = nil

            Grinder.forceSell = false
            --Infinity.BDO.Lua.Execute("NpcShop_WindowClose()")
            --NPCUtils.closeNpcDialog()
            SellTask.selectedActorData = nil
            return true
        end

        finishedSelling = nil
    else
        Grinder.navigationPulse()
    end
    return false
end
