StartMentalGameState = {}
StartMentalGameState.__index = StartMentalGameState

StartMentalGameState.Name = "StartMentalGameState"

setmetatable(StartMentalGameState, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function StartMentalGameState.new()
    DebugManager.Trace("StartMentalGameState.new()")

    local self = setmetatable({}, StartMentalGameState)

    return self
end

function StartMentalGameState:NeedToRun()
    DebugManager.Trace("StartMentalGameState:NeedToRun()", DEBUG_VERBOSITY_LOUD)

    if GameDialog.GetRequiredEnergyForMentalGame() == nil then
        return false
    end

    local code =
    [[
        local talker = dialog_getTalker()
      
        if talker == nil then
            return nil
        end

        return getIntimacyByCharacterKey(talker:getCharacterKey())
    ]]

    local amity = Infinity.BDO.Lua.Execute(code)

    if (amity == nil) or (amity >= Application.AmityTarget) then
        Application.ActiveNPC = nil

        return
    end

    return GameDialog.IsOpen() and (not GameMentalGame.IsStarted()) and (LocalPlayer:getWp() >= GameDialog.GetRequiredEnergyForMentalGame())
end

function StartMentalGameState:Run()
    DebugManager.Trace("StartMentalGameState:Run()")

    GameMentalGame.Start()
end