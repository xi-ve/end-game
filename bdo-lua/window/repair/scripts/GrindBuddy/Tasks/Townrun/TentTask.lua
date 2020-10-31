--[[
TentTask = {}

function TentTask.needToRun()
    --Log.debugLog("TentTask needToRun")
    TentTask.lastTimeChecked = Cache.time

    if Grinder.settings.tent_pos == nil then
        return false
    end

    local tPos = Grinder.settings.tent_pos

    if (Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0) then
        local actorName, actorDistance, actorPos = RepairTask.selectActor()
        if actorPos:getDistance(Cache.playerPos) < tPos:getDistance(Cache.playerPos) then
            return false
        end
    end

    local inventoryMoney = Inventory.getInventoryMoney()
    if Grinder.finishedRepair or (Inventory.isItemBelowEndurance(50) and inventoryMoney > 50000) then
        return true
    end
end

TentTask.lastTimeChecked = 0
TentTask.currentlyRunning = false

function TentTask.work()
    Log.debugLog("TentTask work")
    if TentTask.lastTimeChecked + 5000 < Cache.time then
        if not TentTask.needToRun() then
            return false
        else
            TentTask.currentlyRunning = true
        end
    end


    if TentTask.currentlyRunning then
        local arrived = MoveToTask.work(Grinder.settings.tent_pos)
        if arrived then
            local finishedRepairing = NPCUtils.repairEquipped(nil, true)
            if finishedRepairing then
                Log.log("Finished repairing")
                TentTask.lastTimeChecked = Cache.time + 60000 --Do not check again for 1min
                TentTask.currentlyRunning = false
                Grinder.forceRepair = false
                Grinder.forceTownRun = false
                return true
            end
        end
    end
end

]]
