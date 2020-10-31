-- ReblathBuddy
-- Settings
local settings = {
	enhanceSpeed = 1,
	amountOfItemsToStackOn = 5,
	extractAt = 20,
	extractionBookAmount = 10,
	stonesToKeep = 1000,
	minStonesBeforeCheckingStorage = 250,
	stopAtExtractedAmount = 0,

	-- itemConfig
	itemConfigSelectedIndex = 1
}
MagLib.Core.Settings.addSettingsToHandler("ReblathBuddy", settings)

-- Forcing specific navigation settings
local navSettings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph")
navSettings.skip_path_nodes = false
navSettings.use_tp = false
navSettings.emulate_human_movement = false
navSettings.allow_unsafe_tp_for_unstuck = false
navSettings.stop_distance_nodes = 50

local navRenderSettings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph_RenderD2D")
navRenderSettings.draw_T1 = false
navRenderSettings.draw_T2 = false
-- navRenderSettings.draw_navigation = true --should be editeable in the settings file
navRenderSettings.draw_navigation_numbers = false
navRenderSettings.renderDistance = 0
-- navRenderSettings.draw_destination = true --should be editeable in the settings file
-- navRenderSettings.draw_navigation = true --should be editeable in the settings file

-- ReblathBuddy global table
ReblathBuddy = {}

-- Item configuration (set by combo box)
ReblathBuddy.stackItemKey = 10807
ReblathBuddy.stoneKey = 16002
ReblathBuddy.repairNPCId = 1 -- 1 is Blacksmith, 2 is Weaponsmith

ReblathBuddy.running = false

ReblathBuddy.FSExtractedCount = 0

-- Initing logger
ReblathBuddy.logger = MagLib.Core.Log.newLogger("ReblathBuddy")

-- Item Configurations
ReblathBuddy.possibleConfigurationNames = {}

-- Adding possible configs
local configFilePaths = Infinity.FileSystem.GetFiles("\\Items\\*.ItemConfig")
for k, filePath in pairs(configFilePaths) do
	local name = filePath:sub(1, filePath:len() - 11)
	table.insert(ReblathBuddy.possibleConfigurationNames, name)
end

ReblathBuddy.loadItemConfiguration = function(index)
	local fileName = ReblathBuddy.possibleConfigurationNames[index]
	ReblathBuddy.logger.info("Loading Configuration " .. fileName)
	local config = MagLib.Utils.Json.loadTableFromJsonFile("\\Items\\" .. fileName .. ".ItemConfig")
	ReblathBuddy.stackItemKey = config.stackItemKey
	ReblathBuddy.stoneKey = config.stoneKey
	ReblathBuddy.repairNPCId = config.repairNPCId
end
-- Loading previous values
ReblathBuddy.loadItemConfiguration(settings.itemConfigSelectedIndex)

-- Initing stateManager
local stateManager = MagLib.Run.States.StateManager("ReblathBuddy States", true)
ReblathBuddy.mainStateManager = stateManager
-- First we want to Repair our items
stateManager.addState(RepairState)
-- Then we want to fill up items so we are at the wanted amount
stateManager.addState(BuyStackItemState)
-- Next we check if have enough extraction thingies and if not buy them from the NPC.
stateManager.addState(BuyExtractionBookState)
-- Then we want to check if we have enough stones and get them from the warehouse
stateManager.addState(GetArmorStonesState)
-- Do we need to downgrade an item --> Downgrade
stateManager.addState(DowngradeState)
-- Enhance
stateManager.addState(UpgradeState)

-- Initing Navigation and ReblathProfile
MagLib.BDO.Navigation.Graph.Profiles.loadProfile(MagLib.BDO.Navigation.Graph.Profiles.availableProfiles[1])

local function onPulse()
	if MagLib.onPulse_Beginning() then
		return
	end

	if ReblathBuddy.running then
		local wantedFSExtractions = settings.stopAtExtractedAmount
		if wantedFSExtractions ~= 0 and wantedFSExtractions <= ReblathBuddy.FSExtractedCount then
			ReblathBuddy.logger.info(
				"Reached wanted amount of extractions. If you want to continue reset the count and start the bot again!")
			ReblathBuddy.running = false
			return
		end

		stateManager.run()
	end

	MagLib.onPulse_End()
end

ReblathBuddy.getToEnhanceItems = function()
	local stackItemKey = ReblathBuddy.stackItemKey
	local amountOfItemsToStackOn = settings.amountOfItemsToStackOn
	local toStackOnItems = {} -- All entries should be {slot = x, enchantLevel = y}
	-- Get the settings.amountOfItemsToStackOn highest + items to stack on

	-- this function gets values from Inventory.iterator and updates toStackOnItems to always have the highest item to stack on in it. Those will be the ones to enhance, hence also the onces to repair
	local enhanceOnItemCheckInventoryIterator = function(itemData)
		local itemKey = itemData.itemKey
		local enhanceLevel = itemData.enhanceLevel
		if itemKey ~= stackItemKey then
			return false
		end

		if #toStackOnItems < amountOfItemsToStackOn then
			table.insert(toStackOnItems, itemData)
			return false
		end
		-- table.print(toStackOnItems)
		local lowestStackItem_Data, lowestStackItem_Level, lowestStackItem_Index =
			MagLib.Utils.Math.minTableToFuncReturnValue(toStackOnItems, function(t)
				return t.enhanceLevel
			end)

		if enhanceLevel > lowestStackItem_Level then
			toStackOnItems[lowestStackItem_Index] = itemData
		end

		return false
	end

	MagLib.BDO.Inventory.iterator(enhanceOnItemCheckInventoryIterator)

	return toStackOnItems
end

local books_UpwardByFailstackNumber = {
	{key = 17644, failstackNumber = 20}, {key = 17734, failstackNumber = 30}, {key = 17735, failstackNumber = 40},
 {key = 17736, failstackNumber = 50}
}
MagLib.Core.Settings.addSettingsToHandler("Extraction Books", books_UpwardByFailstackNumber) -- So it is in theory editable

ReblathBuddy.getWantedExtractionBookKey = function()
	local wantedFS = settings.extractAt
	for k, v in ipairs(books_UpwardByFailstackNumber) do
		if v.failstackNumber >= wantedFS then
			return v.key, v.failstackNumber
		end
	end
end

ReblathBuddy.getCurrentlyNeededExtractionBookKey = function()
	local wantedFS = MagLib.BDO.Enhance.getFailstackCount()
	for k, v in ipairs(books_UpwardByFailstackNumber) do
		if v.failstackNumber >= wantedFS then
			return v.key, v.failstackNumber
		end
	end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
	onPulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", MagLib.onRenderD2D)
