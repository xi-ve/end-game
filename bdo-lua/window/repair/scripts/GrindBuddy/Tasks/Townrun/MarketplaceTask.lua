MarketplaceTask = {}

function MarketplaceTask.needToRun()
    if Grinder.settings.doMarketplace then
        if Grinder.currentProfile.npcs["Marketplace"] and #Grinder.currentProfile.npcs["Marketplace"] > 0 then
            if Grinder.forceMarketplace then
                return true
            end
            if MarketplaceTask.getItemCountAutoSellHandles() > 0 then
                return true
            end
        end
    end

    Grinder.finishedMarketplace = true
    return false
end

function MarketplaceTask.getItemCountAutoSellHandles()
    local autoSellScript = Infinity.Scripting.GetScript("AutoSell")
    if autoSellScript.IsRunning == false then
        Log.log("Starting AutoSell as it is not started yet!")
        autoSellScript:Start()
        Grinder.wait(250)
        return 0
    end
    local thisScript = Infinity.Scripting.CurrentScript

    local code = [[
      return AutoSell.Running
    ]]
    local autoSellRunning = thisScript:LuaExec(autoSellScript, code)
    if not autoSellRunning then
        code = [[
        AutoSell.StartBot()
      ]]
        thisScript:LuaExec(autoSellScript, code)
    end

    code = [[
    local items = AutoSell.getMovableItemsFromInventory()
    return #items
    ]]


    local moveableCount = thisScript:LuaExec(autoSellScript, code)


    return moveableCount
end

function MarketplaceTask.unloadAutoSell()
    local autoSellScript = Infinity.Scripting.GetScript("AutoSell")
    autoSellScript:Stop()
end

function MarketplaceTask.work()
    Log.debugLog("MarketplaceTask work")
    if not Grinder.currentProfile.npcs["Marketplace"] or #Grinder.currentProfile.npcs["Marketplace"] == 0 then
        Grinder.forceMarketplace = false
        return true
    end
    local actorName, actorPos = MarketplaceTask.selectActor()

    local npcActor = MoveToNpcTask.work(actorPos, actorName, 350)

    actorName = nil
    actorPos = nil

    if npcActor then
        local finished = MarketplaceTask.waitForAutoSell()
        if finished then
            MarketplaceTask.unloadAutoSell()
            Grinder.forceMarketplace = false
            return true
        end
        finished = nil
    else
        Grinder.navigationPulse()
    end

    return false
end

function MarketplaceTask.selectActor()
    Log.debugLog("MarketplaceTask selectActor")
    local actorName, actorDistance, actorPos = ActorUtils.getClosestActorFromNPCKeylist(Grinder.currentProfile.npcs["Marketplace"])

    actorDistance = nil

    return actorName, actorPos
end

MarketplaceTask.lastArrivedInit = 0
function MarketplaceTask.waitForAutoSell()

    local time = Cache.time

    if MarketplaceTask.lastArrivedInit + 180000 < time then
        MarketplaceTask.lastArrivedInit = time
    end

    if MarketplaceTask.lastArrivedInit + 60000 < time then
        NPCUtils.closeNpcDialog()
        --Unloading AutoSell, so it does not direclty open the dialog again, MarketplaceTask.needToRun() should load it again by calling MarketplaceTask.getItemCountAutoSellHandles()
        return true
    end

    if MarketplaceTask.getItemCountAutoSellHandles() == 0 then
        return true
    end

    Grinder.wait(1000)
    StuckCheckTask.reset()
    return false
end
