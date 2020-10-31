InsertCardsState = {}
InsertCardsState.__index = InsertCardsState

InsertCardsState.Name = "InsertCardsState"

setmetatable(InsertCardsState, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function InsertCardsState.new()
    DebugManager.Trace("InsertCardsState.new()")

    local self = setmetatable({}, InsertCardsState)

    return self
end

function InsertCardsState:NeedToRun()
    DebugManager.Trace("InsertCardsState:NeedToRun()", DEBUG_VERBOSITY_LOUD)

    return GameMentalGame.IsStarted() and (not GameMentalGame.IsExecuteConversationButtonVisible()) and ((GameMentalGame.GetTotalSlotCount() - GameMentalGame.GetFilledSlotCount()) > 0)
end

function InsertCardsState:Run()
    DebugManager.Trace("InsertCardsState:Run()")

    local mentalGameGoalType = GameMentalGame.GetGoalType()
    local cardSuccessChances = {}

    for i = 1, GameMentalGame.GetCardCount() do
        cardSuccessChances[i] = { i - 1, GameMentalGame.GetCardSuccessChanceByIndex(i - 1) }
    end

    if
        (mentalGameGoalType == GAME_MENTALGAME_GOAL_TALK) or
        (mentalGameGoalType == GAME_MENTALGAME_GOAL_SPARKS) or
        (mentalGameGoalType == GAME_MENTALGAME_GOAL_CONSECUTIVE_SPARKS) or
        (mentalGameGoalType == GAME_MENTALGAME_GOAL_ACCUMULATED_FAVOR) or
        (mentalGameGoalType == GAME_MENTALGAME_GOAL_MINIMUM_FAVOR)
    then
        table.sort(cardSuccessChances, function(a, b)
            return a[2] > b[2]
        end)
    else
        table.sort(cardSuccessChances, function(a, b)
            return a[2] < b[2]
        end)
    end

    for k, v in ipairs(cardSuccessChances) do
        if (k - 1) >= GameMentalGame.GetFilledSlotCount() then
            GameMentalGame.InsertCardByIndex(v[1])

            return
        end
    end
end