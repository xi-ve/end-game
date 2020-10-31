local UI = MagLib.UI
local settings = MagLib.Core.Settings.getSetting("TentBuddy")
local villaBuffSettings = settings.villaBuffs

function VillaBuffsTabDrawFunc()
	if CanBuyVillaBuffs == nil then
		-- Checking if we got villa invite
		CanBuyVillaBuffs = MagLib.BDO.Villa.hasAnyVillaInvite() or MagLib.BDO.Villa.hasMoonBook()
	end

	local checkboxText = "Villa Buff Buying:"
	if not CanBuyVillaBuffs then
		checkboxText = checkboxText .. "(No Villa Invite)"
	end
	checkboxText = checkboxText .. "##villaBuffs_enabled"

	villaBuffSettings.enabled = UI.Checkbox(checkboxText, villaBuffSettings.enabled)
	if villaBuffSettings.enabled then
		UI.Indent(25)
		UI.Columns(4, {300, 100, 100, 50}, {"Name", "Buff Index", "Buff Key", "Enabled"}, "villaBuffColumn")
		for index = 0, 5 do
			local vBuffSetting = villaBuffSettings.buffs[index]
			local buffInfo = MagLib.BDO.Villa.buffs[index]
			local buffName = buffInfo.name

			local color = nil
			if (vBuffSetting.enabled) then
				if CanBuyVillaBuffs then
					color = "FF00FF00"
				else
					color = "FFF542CE"
				end
			else
				color = "FFFF0000"
			end
			UI.Text(buffName, color)
			UI.NextColumn()
			UI.Text(index)
			UI.NextColumn()
			if buffInfo.buffKey ~= nil then
				UI.Text(buffInfo.buffKey)
			end
			UI.NextColumn()
			local changed = false
			vBuffSetting.enabled, changed = UI.Checkbox("##villabuff" .. index .. "_enabled", vBuffSetting.enabled, nil, color)
			if changed then
				for i, s in pairs(villaBuffSettings.buffs) do
					if i ~= index then
						s.enabled = false
					end
				end

				-- Disabled confidence buff since it doesn't stack with villa buffs
				settings.buyConfig.itemBuffs.confidenceBuff_enabled = false

				CanBuyVillaBuffs = nil -- Just to have some updating in there
			end
			UI.NextColumn()
		end
		UI.EndColumns()
		UI.Unindent(25)
	end

end
