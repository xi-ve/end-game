ExecuteConversationState = {}
ExecuteConversationState.__index = ExecuteConversationState

ExecuteConversationState.Name = "ExecuteConversationState"

setmetatable(ExecuteConversationState, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function ExecuteConversationState.new()
    DebugManager.Trace("ExecuteConversationState.new()")

    local self = setmetatable({}, ExecuteConversationState)

    return self
end

function ExecuteConversationState:NeedToRun()
    DebugManager.Trace("ExecuteConversationState:NeedToRun()", DEBUG_VERBOSITY_LOUD)

    return GameMentalGame.IsStarted() and GameMentalGame.IsExecuteConversationButtonVisible() and (GameMentalGame.GetFilledSlotCount() == GameMentalGame.GetTotalSlotCount())
end

function ExecuteConversationState:Run()
    DebugManager.Trace("ExecuteConversationState:Run()")

    GameMentalGame.ExecuteConversation()
end