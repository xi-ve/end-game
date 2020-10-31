RepairTask = {}

RepairTask.lastFinished = 0
RepairTask.selectedActorData = nil
RepairTask.selectedActorDataTime = 0

--This is a lot less strict then the NeedToGoToTown one, as this is only called when we got to town anyways, so it should return true most of the time.
function RepairTask.needToRun()
    --Log.debugLog("RepairTask needToRun")
    if Grinder.settings.doRepairRuns then
        if (Grinder.currentProfile.npcs["Repair"] and #Grinder.currentProfile.npcs["Repair"] > 0) then
            if Grinder.forceRepair then
                return true
            end
            if Inventory.isItemBelowEndurance(80) then
                return true
            end
        end
    end

    Grinder.finishedRepair = true
    return false
end

function RepairTask.work()
    Log.debugLog("RepairTask work")
    if not Grinder.currentProfile.npcs["Repair"] or #Grinder.currentProfile.npcs["Repair"] == 0 then
        Grinder.forceRepair = false
        return true
    end

    local actorName, actorPos = RepairTask.selectActor()
    if actorName == nil then
        -----RESETTING LOCAL VARS ----------
        actorName = nil
        actorPos = nil
        ------------------------------------


        Grinder.forceRepair = false
        return true
    end

    if RepairTask.selectedActorData == nil then
        RepairTask.selectedActorData = {actorName = actorName, actorPos = actorPos}
        RepairTask.selectedActorDataTime = Cache.time
    end

    local npcActor = MoveToNpcTask.work(actorPos, actorName, 350)
    if npcActor then
        if RepairTask.lastFinished + 10020 < Cache.time then
            local finishedRepairing = NPCUtils.repairEquipped(npcActor, false)
            if finishedRepairing then
                Log.log("Finished repairing")
                RepairTask.lastFinished = Cache.time
                Grinder.forceRepair = false



                -----RESETTING LOCAL VARS ----------
                actorName = nil
                actorPos = nil
                finishedRepairing = nil
                ------------------------------------
                return true
            end
        end
    else
        Grinder.navigationPulse()
    end

    return false
end

function RepairTask.selectActor()
    Log.debugLog("RepairTask selectActor")
    local _
    local actorName, _, actorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Repair"])
    return actorName, actorPos
end