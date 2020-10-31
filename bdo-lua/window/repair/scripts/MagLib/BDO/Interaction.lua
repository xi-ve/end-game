local InteractionWrapper = {}

InteractionWrapper.getInteractableActorKey = function()
	local code = [[
    local actor = interaction_getInteractable()
    return actor:getActorKey()
  ]]
	return Infinity.BDO.Lua.Execute(code)
end

InteractionWrapper.getInteractionPopup = function(npcActor, funcToCallOnSuccess)
	local npcPos = npcActor:getPosition()
	local taskRun = function()
		-- Looking at the NPC
		local lookingAt = MagLib.BDO.Actors.LocalPlayer.faceTowards(npcPos)
		if not lookingAt then
			return false
		end

		-- Setting camera
		MagLib.BDO.Camera.setCamera(npcPos)

		-- Check if we have the popup
		if InteractionWrapper.getInteractableActorKey() == npcActor:getActorKey() then
			funcToCallOnSuccess()
			return true
		end

		-- TODO: Move closer/wiggle/etc.
		return false
	end
	MagLib.Run.Tasks.new("getInteractionPopup task", 1 / 0, taskRun)
end

MagLib.BDO.Interaction = InteractionWrapper
