local settings = {
	buyTools = true,
	toolsToBuy = {
		[MagLib.BDO.Gathering.ToolIndex.Axe] = false,
		[MagLib.BDO.Gathering.ToolIndex.Collector] = false,
		[MagLib.BDO.Gathering.ToolIndex.Pickaxe] = false,
		[MagLib.BDO.Gathering.ToolIndex.Hoe] = false,
		[MagLib.BDO.Gathering.ToolIndex.ButcheringKnife] = false,
		[MagLib.BDO.Gathering.ToolIndex.TanningKnife] = false
	}
}
MagLib.Core.Settings.addSettingsToHandler("GatherBuddy_TownrunState", settings)

local work = function(self)

	-- Making sure everything is looted
	LootingModule.run()

	-- Spawn info popup (temporal until townrun gets implemented)
	MagLib.UI.Popups.new("Townrun", function(self)
		MagLib.UI.Text("Hey! We switched into townrun mode!")
		MagLib.UI.Text("Either we have:")
		MagLib.UI.Indent(15)
		MagLib.UI.Text("-no tools left")
		MagLib.UI.Text("-a too full inventory")
		MagLib.UI.Text("-no energy left!")
		MagLib.UI.Unindent(15)
		MagLib.UI.Text("Since this is not implemented yet, the bot got stopped!")
		if MagLib.UI.SimpleButton("Close Popup") then
			self:close()
		end
	end, 1 / 0)

	GatherBuddy.stop()

	return true
end
TownrunState = MagLib.Run.States.State("TownrunState", work)
