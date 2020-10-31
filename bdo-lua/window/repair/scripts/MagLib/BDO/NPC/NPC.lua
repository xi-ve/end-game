MagLib.BDO.NPC = {}
MagLib.BDO.NPC.closeDialog = function()
	local code = [[
  FromClient_CancelByAttacked()
  close_WindowPanelList()
  FromClient_hideDialog(false)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

MagLib.BDO.NPC.openDialog = function(npcActor, finishedFunc)
	local openDialogFunc = function()
		Interaction.interact(4)
		finishedFunc()
	end
	MagLib.BDO.Interaction.getInteractionPopup(npcActor, openDialogFunc)
end
