local UI = MagLib.UI
local settings = MagLib.Core.Settings.getSetting("TentBuddy")

function HomeTabDrawFunc()

	if settings.tentIdString == "0" then
		UI.Text("Tent ID not set! Please install your Tent and press ", "FFFF0000")
		UI.SameLine()
		UI.Button("Update Tent ID", UpdateTentId)
	else
		UI.Text("Tent ID: " .. tostring(settings.tentIdString))
		UI.SameLine()
		UI.Button("Update Tent ID", UpdateTentId)
	end

	UI.Button("Force Tent Procedure", TriggerTentProcedure)

	UI.Separator()

	settings.repair.enabled = UI.Checkbox("Repairing:##repairing_checkbox", settings.repair.enabled)
	if settings.repair.enabled then
		settings.repair.triggerDurability = UI.InputInt("Durability Trigger: ##repairing_trigger",
                                                		settings.repair.triggerDurability)
		settings.repair.repairInventoryItems = UI.Checkbox("Repair Inventory Items: ##repair_inventory_items",
                                                   		settings.repair.repairInventoryItems)
	end

	UI.Separator()
	UI.Text("Security: ")
	settings.security.notInSafezone = UI.Checkbox("Do not trigger in safezones:##notInSafezone_checkbox",
                                              	settings.security.notInSafezone)
end
