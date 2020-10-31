GameMentalGame = {}

function GameMentalGame.IsStarted()
    DebugManager.Trace("GameMentalGame.IsStarted()")

    return Infinity.BDO.Lua.Execute("return Panel_MentalGameLeft_All:GetShow()")
end

function GameMentalGame.Start()
    DebugManager.Trace("GameMentalGame.Start()")

    if (not GameDialog.IsOpen()) or GameMentalGame.IsStarted() then
        return
    end

    Infinity.BDO.Lua.Execute("HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_IntimacyGame, true)")
end

function GameMentalGame.GetGoalType()
    DebugManager.Trace("GameMentalGame.GetGoalType()")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return 0
        end

        return mentalGame:getGoalType()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetCardCount()
    DebugManager.Trace("GameMentalGame.GetCardCount()")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return 0
        end

        return mentalGame:getCardCount()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetTotalSlotCount()
    DebugManager.Trace("GameMentalGame.GetTotalSlotCount()")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return 0
        end

        return mentalGame:getMinCardSlotCount()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetFilledSlotCount()
    DebugManager.Trace("GameMentalGame.GetFilledSlotCount()")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return 0
        end

        return mentalGame:getFilledSlotCount()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetCardSuccessChanceByIndex(cardIndex)
    DebugManager.Trace("GameMentalGame.GetCardSuccessChanceByIndex(" .. CommonUtil.ParameterValue(cardIndex) .. ")")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return 0
        end

        local mentalGameCard = mentalGame:getCard(]] .. cardIndex .. [[)

        if mentalGameCard == nil then
            return 0
        end

        return (mentalGameCard:getHit() / mentalGame:getCurrentDV()) * 100
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetCardNameByIndex(cardIndex)
    DebugManager.Trace("GameMentalGame.GetCardNameByIndex(" .. CommonUtil.ParameterValue(cardIndex) .. ")")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return nil
        end

        local mentalGameCard = mentalGame:getCard(]] .. cardIndex .. [[)

        if mentalGameCard == nil then
            return nil
        end

        return mentalGameCard:getName()
    ]]

    return Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.GetAvailableCardNames()
    DebugManager.Trace("GameMentalGame.GetAvailableCardNames()")

    local availableCardNames = {}

    for i = 1, GameMentalGame.GetCardCount() do
        local availableCardName = GameMentalGame.GetCardNameByIndex(i - 1)

        if availableCardName == nil then
            return nil
        end

        availableCardNames[i] = availableCardName
    end

    return availableCardNames
end

function GameMentalGame.InsertCardByIndex(cardIndex)
    DebugManager.Trace("GameMentalGame.InsertCardByIndex(" .. CommonUtil.ParameterValue(cardIndex) .. ")")

    local code = [[
        local mentalGame = getMentalgameObject()

        if mentalGame == nil then
            return
        end

        local mentalGameCard = mentalGame:getCard(]] .. cardIndex .. [[)

        if mentalGameCard == nil then
            return
        end

        local mentalGameCardStaticStatus = mentalGameCard:getStaticStatus()

        if mentalGameCardStaticStatus == nil then
            return
        end
        
        local mentalGameCardStaticStatusKey = mentalGameCardStaticStatus:getKey()

        if mentalGameCardStaticStatusKey ~= nil then
            RequestMentalGame_selectCardByKey(mentalGameCardStaticStatusKey, 99)
        end
    ]]

    Infinity.BDO.Lua.Execute(code)
end

function GameMentalGame.IsExecuteConversationButtonVisible()
    DebugManager.Trace("GameMentalGame.IsExecuteConversationButtonVisible()")

    return Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGameRight_All, \"Button_Try_PCUI\"):GetShow()")
end

function GameMentalGame.IsContinueButtonVisible()
    DebugManager.Trace("GameMentalGame.IsContinueButtonVisible()")

    return Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGameRight_All, \"Button_Continue\"):GetShow()")
end

function GameMentalGame.IsLeaveButtonVisible()
    DebugManager.Trace("GameMentalGame.IsLeaveButtonVisible()")

    return Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGameRight_All, \"Button_Leave\"):GetShow()")
end

function GameMentalGame.ExecuteConversation()
    DebugManager.Trace("GameMentalGame.ExecuteConversation()")

    Infinity.BDO.Lua.Execute("HandleEventLDown_MentalGame_All_Try()")
end

function GameMentalGame.ContinueConversation()
    DebugManager.Trace("GameMentalGame.ContinueConversation()")

    Infinity.BDO.Lua.Execute("HandleEventLDown_MentalGame_All_Continue()")
end

function GameMentalGame.LeaveConversation()
    DebugManager.Trace("GameMentalGame.LeaveConversation()")

    local code = [[
        HandleEventLDown_MentalGame_All_Leave()
        PaGlobalFunc_MentealGame_All_EndUIProcess()
    ]]

    Infinity.BDO.Lua.Execute(code)
end