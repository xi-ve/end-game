local UI = MagLib.UI
local settings = MagLib.Core.Settings.getSetting("TentBuddy")
local buyConfig = settings.buyConfig
local potionSettings = buyConfig.potions
local barSettings = buyConfig.goldBar
local itemBuffSettings = buyConfig.itemBuffs

local resetAllAdventurerBuffsExcept = function(exceptId)
	for _, buff in pairs(itemBuffSettings.dropBuffs) do
		if buff.itemId ~= exceptId then
			buff.enabled = false
		end
	end
end

function ShopTabDrawFunc()

	potionSettings.enabled = UI.Checkbox("Potion Buying:##potions_enabled", potionSettings.enabled)
	if (potionSettings.enabled) then
		UI.Indent(25)
		UI.Columns(5, {200, 100, 150, 150, 50},
           		{"Name##potName", "ID##potID", "Trigger Amount##potTA", "Wanted Amount##potWA", "Enabled##potEnabled"},
           		"potColumn")
		for _, v in pairs(potionSettings.pots) do
			local color = nil
			if (v.enabled) then
				color = "FF00FF00"
			else
				color = "FFFF0000"
			end
			UI.Text(v.name, color)
			UI.NextColumn()
			UI.Text(v.itemId)
			UI.NextColumn()
			if (v.enabled) then
				v.triggerAmount = UI.InputInt("##" .. v.itemId .. "_triggerAmount", v.triggerAmount)
			end
			UI.NextColumn()
			if (v.enabled) then
				v.wantedAmount = UI.InputInt("##" .. v.itemId .. "_wantedAmount", v.wantedAmount)
			end
			UI.NextColumn()
			v.enabled = UI.Checkbox("##" .. v.itemId .. "_enabled", v.enabled, nil, color)
			UI.NextColumn()
		end
		UI.EndColumns()
		UI.Unindent(25)
	end

	itemBuffSettings.enabled = UI.Checkbox("Item Buff Buying##itemBuff_enabled", itemBuffSettings.enabled)
	if itemBuffSettings.enabled then
		UI.Indent(25)
		UI.Columns(4, {200, 100, 100, 50}, {"Name", "Item ID", "Buff Key", "Enabled"}, "itemBuffColumn")
		local cbColor = nil
		if (itemBuffSettings.confidenceBuff_enabled) then
			cbColor = "FF00FF00"
		else
			cbColor = "FFFF0000"
		end
		UI.Text("Confidence Buff", cbColor)
		UI.NextColumn()
		UI.Text(itemBuffSettings.confidenceBuff_itemId)
		UI.NextColumn()
		UI.Text(itemBuffSettings.confidenceBuff_buffKey)
		UI.NextColumn()
		local changed
		itemBuffSettings.confidenceBuff_enabled, changed = UI.Checkbox(
                                                   			"##" .. itemBuffSettings.confidenceBuff_itemId .. "_enabled",
                                                   			itemBuffSettings.confidenceBuff_enabled, nil, cbColor)
		if changed and itemBuffSettings.confidenceBuff_enabled then
			-- Disable villa buffs since they do not stack.
			for i = 0, 5 do
				settings.villaBuffs.buffs[i].enabled = false
			end
		end

		UI.NextColumn()
		for _, v in pairs(itemBuffSettings.dropBuffs) do
			local color = nil
			if (v.enabled) then
				color = "FF00FF00"
			else
				color = "FFFF0000"
			end
			UI.Text(v.name, color)
			UI.NextColumn()
			UI.Text(v.itemId)
			UI.NextColumn()
			if v.buffKey ~= nil then
				UI.Text(v.buffKey)
			end
			UI.NextColumn()
			local changed = false
			v.enabled, changed = UI.Checkbox("##" .. v.itemId .. "_enabled", v.enabled, nil, color)
			if changed then
				resetAllAdventurerBuffsExcept(v.itemId)
			end
			UI.NextColumn()
		end
		UI.EndColumns()
		UI.Unindent(25)
	end

end
