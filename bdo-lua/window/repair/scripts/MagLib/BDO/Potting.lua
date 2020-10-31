local Potting = {}

local hpPots = {
	{id = 529, restoreAmount = 275}, {id = 524, restoreAmount = 275}, {id = 530, restoreAmount = 1},
 {id = 525, restoreAmount = 1}, {id = 528, restoreAmount = 200}, {id = 519, restoreAmount = 200},
 {id = 514, restoreAmount = 125}, {id = 518, restoreAmount = 125}, {id = 513, restoreAmount = 75},
 {id = 517, restoreAmount = 75}
}
local mpPots = {
	{id = 532, restoreAmount = 375}, {id = 526, restoreAmount = 375}, {id = 533, restoreAmount = 1},
 {id = 527, restoreAmount = 1}, {id = 531, restoreAmount = 250}, {id = 522, restoreAmount = 250},
 {id = 516, restoreAmount = 1}, {id = 521, restoreAmount = 175}, {id = 515, restoreAmount = 1},
 {id = 520, restoreAmount = 125}
}

local specialPotions = {
	{id = 576, hpRestoreAmount = 750, manaRestoreAmount = 500, wpRestoreAmount = 500, spRestoreAmount = 500},
 {id = 575, hpRestoreAmount = 500, manaRestoreAmount = 300, wpRestoreAmount = 300, spRestoreAmount = 300}
}

local hpSlot = {}
local mpSlot = {}
-- TODO: Pick best potion for current situation
local updatePotionSlots = function()
	hpSlot = nil
	mpSlot = nil

	for _, v in ipairs(hpPots) do
		local count, slot = Inventory.getItemDataByItemId(v.id)
		if count and count > 0 then
			hpSlot = slot
			break
		end
	end

	for _, v in ipairs(mpPots) do
		local count, slot = Inventory.getItemDataByItemId(v.id)
		if count and count > 0 then
			mpSlot = slot
			break
		end
	end
end

Potting.potHp = function()
	updatePotionSlots()
	if hpSlot ~= nil then
		Inventory.useItem(hpSlot)
	end
end

local LocalPlayer = MagLib.BDO.Actors.LocalPlayer
Potting.potHp_Emergency = function()
	local diffToMaxHp = LocalPlayer.getMaxHp() - LocalPlayer.getHp()

	local bestPotionMissing = 1 / 0
	local closestPotionSlot = nil
	local possiblePots = MagLib.Utils.Table.copy(hpPots)
	if diffToMaxHp ~= 0.0 then
		for k, v in pairs(hpPots) do
			local count, slot = Inventory.getItemDataByItemId(v.id)
			if count and count > 0 then
				local healAmount = v.restoreAmount
				local diff = diffToMaxHp - healAmount
				if bestPotionMissing > 0 then
					-- We have not yet found a potion that is enough to get to 100%
					if diff < bestPotionMissing then
						bestPotionMissing = diff
						closestPotionSlot = slot
					end
				else

				end
			end
		end
	end
end

Potting.potMp = function()
	updatePotionSlots()
	if mpSlot ~= nil then
		Inventory.useItem(mpSlot)
	end
end

MagLib.BDO.Potting = Potting
