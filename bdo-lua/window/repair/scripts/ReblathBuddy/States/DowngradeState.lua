local currentlyDowngrading = false
local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

local work = function(self)
	local settings = MagLib.Core.Settings.getSetting("ReblathBuddy")
	local npcData = MagLib.BDO.Navigation.Graph.Profiles.currentProfile.npcs["Downgrade"][1]

	local stackItems = ReblathBuddy.getToEnhanceItems()

	-- Check if enough of them are +15, if not just continue (return true)
	if not currentlyDowngrading then
		local distanceToNpc = Vector3(npcData.posX, npcData.posY, npcData.posZ):getDistance(getPPos())
		local neededAmountOfPlus15ToDowngrade = #stackItems
		if distanceToNpc < 500 then
			neededAmountOfPlus15ToDowngrade = 1
		end

		local downgradeableAmount = 0
		for k, v in pairs(stackItems) do
			local enhanceLevel = v.enhanceLevel
			if enhanceLevel == 15 then
				downgradeableAmount = downgradeableAmount + 1
			end
		end

		if downgradeableAmount < neededAmountOfPlus15ToDowngrade then
			return true
		end
	end

	-- All of them are +15 or we are currently downgrading already
	currentlyDowngrading = true

	--[[
  if not isSupportedGameVersion then
    --We would now go downgrading, but we cannot due to old version. stopping the bot and opening a popup.
    ReblathBuddy.logger.info("Unsupported game version. Please downgrade manually.")
    ReblathBuddy.running = false
    AddStoppedDueToVersionPopup() --is in UI.lua and a global function draw the info popup
    MagLib.BDO.Navigation.stop() --Just to be safe
    return false --stay in state so we can go to next one once we start and all are repaired.
  end
  ]]

	-- Iterate over all and downgrade first that is +15, if none are +15, then we can set currentlyDowngrading to false again
	local atNPC = MagLib.BDO.Navigation.activeMoveToNpc(npcData, 150)
	if atNPC then
		for k, v in pairs(stackItems) do
			local enhanceLevel = v.enhanceLevel
			if enhanceLevel == 15 and v.dura > 20 then
				local actorId = 40016
				local npcActor = MagLib.BDO.Actors.getActorWithId(actorId, EActorType_Npc)
				ReblathBuddy.logger.info("Trying to downgrade the item in slot " .. v.slot)
				MagLib.BDO.NPC.Downgrade.downgrade(npcActor, v.slot, false)
				self.wait(250)
				return false
			end
		end

		-- Downgraded all
		ReblathBuddy.logger.info("Finished downgrading all items!")
		currentlyDowngrading = false
	end

	return false
end

DowngradeState = MagLib.Run.States.State("DowngradeState", work)
