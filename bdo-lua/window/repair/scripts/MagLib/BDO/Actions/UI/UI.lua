---ActionSequenceManger Info/Debug UI
-- @module MagLib.UI.ActionSequenceManger
-- @alias ActionSeqUI
local UI = MagLib.UI
local AM = MagLib.BDO.Actions.ActionSequenceManager

local ActionSeqUI = {}
---Draws new window with info about the ActionSequenceManger state
ActionSeqUI.drawDebugUI = function()
	UI.newWindow("MagLib ActionSequenceManager Debug")
	UI.Text("Current ActionSequence: ")
	local curSeq = AM.getCurrentActionSequence()
	if curSeq then
		ImGui.SameLine()
		UI.Text(curSeq.startAnimation)
		ImGui.SameLine()
		local returnIn = 1 / 0
		if curSeq.returnAt then
			returnIn = curSeq.returnAt - MagLib.getTime()
		end
		UI.Text("| finishes in " .. returnIn .. "ms")
	end

	UI.endWindow()
end

MagLib.UI.ActionSequenceManager = ActionSeqUI
