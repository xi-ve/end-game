MagLib.UI.Combat.CombatManager = {}
local CM = MagLib.BDO.Actions.Combat.CombatManager
local UI = MagLib.UI
MagLib.UI.Combat.CombatManager.drawCombatProfileSelector = function()
	UI.Combo("Select CombatProfile", CM.loadedProfileIndex, CM.availableProfileNames, false, function(newIndex)
		CM.loadProfile(newIndex)
	end)
	ImGui.SameLine()
	UI.Button("Unload", function()
		CM.unloadProfile()
	end)
end

MagLib.UI.Combat.CombatManager.drawDebugWindow = function()
	UI.newWindow("MagLib CombatManager Debug")
	ImGui.Text("Last used Skill list:")
	ImGui.Columns(2)
	ImGui.SetColumnWidth(0, 200)
	ImGui.SetColumnWidth(1, 100)
	ImGui.Text("Skill Name")
	ImGui.NextColumn()
	ImGui.Text("Priority")
	ImGui.NextColumn()
	ImGui.Separator()

	table.sort(CM.lastSkillList, function(a, b)
		return a.priority > b.priority
	end)

	local _ = nil
	for _, v in ipairs(CM.lastSkillList) do
		if v.type == CM.SkillTypes.AutoAttack then
			ImGui.Text("Auto Attack")
		else
			ImGui.Text(tostring(v.skill.name))
		end
		ImGui.NextColumn()
		ImGui.Text(tostring(v.priority))
		ImGui.NextColumn()

	end

	ImGui.Columns(1)
	UI.endWindow()
end
