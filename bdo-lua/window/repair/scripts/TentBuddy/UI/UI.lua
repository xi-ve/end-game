local UI = MagLib.UI
local version = VERSION

local menuBar = MagLib.UI.MenuBar()
menuBar.addTab("Home", HomeTabDrawFunc)
menuBar.addTab("Shop", ShopTabDrawFunc)
menuBar.addTab("Villa Buffs", VillaBuffsTabDrawFunc)

local settings = MagLib.Core.Settings.getSetting("TentBuddy")
local onGUIDraw = function()
	UI.Begin("TentBuddy V" .. version, nil, ImGuiWindowFlags_MenuBar)

	menuBar.drawMenuBar()

	if settings.started == true then
		UI.Button("Stop", Stop)
	else
		UI.Button("Start", Start)
	end

	if IsInTentProcedure() then
		UI.SameLine()
		UI.Text("Currently in Tent Procedure", "FFA7F542")
	end

	UI.Separator()
	menuBar.drawCurrentTab()
	UI.End()
end

local draw = true
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
	if not draw then
		return
	end

	MagLib.Core.Try(onGUIDraw, function()
		draw = false
	end)
end)
