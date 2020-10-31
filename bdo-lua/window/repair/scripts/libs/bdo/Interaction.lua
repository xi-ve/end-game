Interaction = {}

function Interaction.hasInteractable()
	local code =
	[[
		return interaction_getInteractable() ~= nil
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Interaction.canCollect(actorKey)
	local code =
	[[
		local actorKey = ]] .. actorKey .. [[

		local actor = getCollectActor(actorKey)

		if actor == nil then
			actor = getMonsterActor(actorKey)
		end

		if actor == nil then
			actor = getDeadBodyActor(actorKey)
		end

		if actor == nil then
			return false
		end

		return actor:isCollectable() and actor:isCollectableUsingMyCollectTool()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Interaction.interact(interactionType)
	local code =
	[[
		interaction_processInteraction(]] .. interactionType .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Interaction.hideDialog()
	local code =
	[[
		close_WindowPanelList()
		FGlobal_HideDialog()
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Interaction.getTalkNpcKey()
	local code =
	[[
		return dialog_getTalkNpcKey()
	]]

	return Infinity.BDO.Lua.Execute(code)
end