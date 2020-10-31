VERSION = "1.1"

local settings = {
	tentIdString = "0",
	tentInstallRetryDelay = 1500,
	tentCollectRetryDelay = 1500,
	security = {notInSafezone = false},
	repair = {enabled = true, triggerDurability = 20, repairInventoryItems = false},
	buyConfig = {
		potions = {
			enabled = false,
			pots = {
				{name = "HP Potion (Extra Large)", itemId = 524, triggerAmount = 10, wantedAmount = 50, enabled = false},
    {name = "Intant HP Potion (Extra Large)", itemId = 529, triggerAmount = 10, wantedAmount = 50, enabled = false},
    {name = "MP Potion (Extra Large)", itemId = 526, triggerAmount = 10, wantedAmount = 50, enabled = false},
    {name = "Instant MP Potion (Extra Large)", itemId = 532, triggerAmount = 10, wantedAmount = 50, enabled = false},
    {name = "WP Potion (Extra Large)", itemId = 594, triggerAmount = 10, wantedAmount = 50, enabled = false},
    {name = "SP Potion (Extra Large)", itemId = 598, triggerAmount = 10, wantedAmount = 50, enabled = false}
			}
		},
		itemBuffs = {
			enabled = false,
			confidenceBuff_enabled = false,
			confidenceBuff_itemId = 43929,
			confidenceBuff_buffKey = 57456,
			dropBuffs = {
				{name = "Adventurer's Luck I", itemId = 43930, buffKey = 57484, enabled = false},
    {name = "Adventurer's Luck II", itemId = 43931, buffKey = 57485, enabled = false},
    {name = "Adventurer's Luck III", itemId = 43932, buffKey = 57486, enabled = false},
    {name = "Adventurer's Luck IV", itemId = 43933, buffKey = 57487, enabled = false},
    {name = "Adventurer's Luck V", itemId = 43934, buffKey = 57488, enabled = false}
			}
		}
	},
	villaBuffs = {
		enabled = false,
		buffs = {
			[0] = {enabled = false},
			[1] = {enabled = false},
			[2] = {enabled = false},
			[3] = {enabled = false},
			[4] = {enabled = false},
			[5] = {enabled = false}
		}
	},
	started = false
}
MagLib.Core.Settings.addSettingsToHandler("TentBuddy", settings)
TentID = LuaInt64(0)
TentID:fromString(settings.tentIdString)

Logger = MagLib.Core.Log.newLogger("TentBuddy")

-- Setting started as last state when AutoLoaded, else false
local originalSettingsState = settings.started
local started = false
settings.started = false
local onAutoScriptStart = function()
	if originalSettingsState == true then
		Start()
	end
end
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", onAutoScriptStart)

-- Start and Stop functions
function Start()
	started = true
	settings.started = true
end

function Stop()
	started = false
	settings.started = false
end

-- OnPulse, State and other stuff
local inTentProcedure = false
function IsInTentProcedure()
	return inTentProcedure
end

local tentProcedureStateManager = MagLib.Run.States.StateManager("Tent Procedure StateManager", false)
tentProcedureStateManager.addState(CollectTentState, 1) -- Collecting it first if it is somehwere
tentProcedureStateManager.addState(InstallTentState, 2) -- Installing the tent
tentProcedureStateManager.addState(RepairState, 3) -- Repairing
tentProcedureStateManager.addState(BuyItemsState, 4) -- Buying items
tentProcedureStateManager.addState(BuyBuffsState, 5) -- Buying Buffs
tentProcedureStateManager.addState(CollectTentState, 6) -- Collecting Tent again

function TriggerTentProcedure()
	inTentProcedure = true
	tentProcedureStateManager.restart()
end

function EndTentProcedure()
	inTentProcedure = false
	MagLib.wait(2000)
end

function IsInTentProcedure()
	return inTentProcedure
end

function UpdateTentId()
	if MagLib.BDO.Tent.isInstalled() then
		TentID = MagLib.BDO.Tent.getId()
		settings.tentIdString = tostring(TentID)
	else
		Logger.error("Please install your Tent first")
	end
end

local onPulse = function()
	if MagLib.onPulse_Beginning() then
		return
	end

	if inTentProcedure then
		if started then
			-- Only do tent stuff when noone around and if wanted if not in city
			local playerAround = Infinity.Whitelist.IsNonWhitelistedPlayerStreamed()
			local canDrop_Safezone = not (settings.security.notInSafezone and MagLib.BDO.inSafezone())
			local playerDead = MagLib.BDO.Actors.LocalPlayer.isDead()
			if not playerDead and not playerAround and canDrop_Safezone then
				-- Do the whole Tent shit and reset flag when finished
				tentProcedureStateManager.run()
				if tentProcedureStateManager.running == false then
					EndTentProcedure()
				end
			end
		else
			EndTentProcedure()
		end
	end

	MagLib.onPulse_End()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", onPulse)
