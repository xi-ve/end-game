StartDialogState = {}
StartDialogState.__index = StartDialogState

StartDialogState.Name = "StartDialogState"

StartDialogState.OpeningDialog = false

setmetatable(StartDialogState, {
    __call = function(cls, ...)
        return cls.new(...)
    end
})

function StartDialogState.new()
    DebugManager.Trace("StartDialogState.new()")

    local self = setmetatable({}, StartDialogState)

    return self
end

function StartDialogState:NeedToRun()
    DebugManager.Trace("StartDialogState:NeedToRun()", DEBUG_VERBOSITY_LOUD)

    local actorFound = false

    for _, actor in ipairs(MagLib.BDO.Actors.getNPCsInRange(500)) do
        if actor and MagLib.BDO.Actors.isValidActor(actor) and actor:getName() == Application.ActiveNPC.npcName then
            actorFound = true
        end
    end

    return (not GameDialog.IsOpen()) and actorFound
end

function StartDialogState:Run()
    DebugManager.Trace("StartDialogState:Run()")

    for _, actor in ipairs(MagLib.BDO.Actors.getActorsInRange(300)) do
        if actor and MagLib.BDO.Actors.isValidActor(actor) and actor:getName() == Application.ActiveNPC.npcName then

            if not StartDialogState.OpeningDialog then
                MagLib.BDO.NPC.openDialog(actor, function() StartDialogState.OpeningDialog = false end)

                StartDialogState.OpeningDialog = true
            end
        end
    end
end