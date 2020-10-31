GameInteraction = {}

function GameInteraction.HasInteractable()
    DebugManager.Trace("GameInteraction.HasInteractable()")

    return Infinity.BDO.Lua.Execute("return (interaction_getInteractable() ~= nil)")
end

function GameInteraction.GetInteractableName()
    DebugManager.Trace("GameInteraction.GetInteractableName()")

    return Infinity.BDO.Lua.Execute("return interaction_getInteractable():getName()")
end

function GameInteraction.Interact()
    DebugManager.Trace("GameInteraction.OpenDialog()")

    if not GameInteraction.HasInteractable() then
        return
    end

    local code = [[
        local interactable = interaction_getInteractable()

        if interactable ~= nil then
            interaction_processInteraction(interactable:getSettedFirstInteractionType())
        end
    ]]

    Infinity.BDO.Lua.Execute(code)
end