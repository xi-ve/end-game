local UI = MagLib.UI

DrawCombatTab = function()
	if MagLib.BDO.Actions.Combat.CombatManager.loadedProfile then
		if MagLib.BDO.Actions.Combat.CombatManager.loadedProfile._onGUIDraw then
			MagLib.BDO.Actions.Combat.CombatManager.loadedProfile:onGUIDraw(false)
		else
			UI.Text("Loaded Combatprofile has no user interface")
		end
	else
		UI.Text("No Combatprofile loaded")
	end
end
