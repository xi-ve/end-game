FinishConversationState = {}
FinishConversationState.__index = FinishConversationState

FinishConversationState.Name = "FinishConversationState"

setmetatable(FinishConversationState, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function FinishConversationState.new()
    DebugManager.Trace("FinishConversationState.new()")

    local self = setmetatable({}, FinishConversationState)

    return self
end

function FinishConversationState:NeedToRun()
    DebugManager.Trace("FinishConversationState:NeedToRun()", DEBUG_VERBOSITY_LOUD)

    return GameMentalGame.IsStarted() and (GameMentalGame.IsContinueButtonVisible() or GameMentalGame.IsLeaveButtonVisible())
end

function FinishConversationState:Run()
    DebugManager.Trace("FinishConversationState:Run()")

    if GameMentalGame.IsContinueButtonVisible() then
        GameMentalGame.ContinueConversation()

        return
    end

    GameMentalGame.LeaveConversation()
end