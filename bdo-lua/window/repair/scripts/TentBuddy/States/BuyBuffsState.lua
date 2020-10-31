BuyBuffsState = MagLib.Run.States.State("BuyBuffsState")

CanBuyVillaBuffs = nil

function BuyBuffsState:work()
	local villaSettings = MagLib.Core.Settings.getSetting("TentBuddy").villaBuffs

	-- Checking if even enabled
	if not villaSettings.enabled then
		return true
	end

	-- Getting index of wanted buff
	local wantedIndex = nil
	for i, v in pairs(villaSettings.buffs) do
		if v.enabled then
			wantedIndex = i
			break
		end
	end

	if wantedIndex == nil then
		-- No buff enabled
		return true
	end

	-- Check if we have villa invite or moon book
	if not (MagLib.BDO.Villa.hasAnyVillaInvite() or MagLib.BDO.Villa.hasMoonBook()) then
		return true
	end

	-- Check if we have the buff
	local villaBuff = MagLib.BDO.Villa.buffs[wantedIndex]

	-- Check if colliding buff
	if (MagLib.BDO.Buffs.hasCollidingBuff(villaBuff.buffKey)) then
		return true
	end

	-- Buy the buff
	Logger.info("Buying Villa Buff with index " .. wantedIndex .. " from Tent!")
	MagLib.BDO.Tent.buyVillaBuff(wantedIndex)
	return true

end
