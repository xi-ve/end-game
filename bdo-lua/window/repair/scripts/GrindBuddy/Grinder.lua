Grinder = {}
Grinder.startTime = 0

Grinder.version = {BRANCH = "", BUILD_TYPE = "V.", BUILD = "1.28", BUILD_INFORMATION = ""}

Grinder.version.BUILD_INFORMATION = Grinder.version.BUILD_TYPE .. " " .. Grinder.version.BUILD .. " " ..
                                    	Grinder.version.BRANCH .. ""
Grinder.Contributors = [[
  * Magxm (Developer)
  ]]

Grinder.saved_settings = {}

Grinder.settings = {
	use_townrun_tp_faraway_grindspot = true, -- SecurityUI
	townrun_tp_different_speed = true, -- SecurityUI
	townrun_tp_maxDistance = 250, -- SecurityUI
	townrun_tp_delay = 200, -- SecurityUI
	tp_height_offset = 50, -- SecurityUI
	use_keyflag = true, -- AdvancedUI
	camera_real_swing = false,
	camera_real_swing_speed = 0.075,
	camera_to_movement = false, -- AdvancedUI
	switch_channel = false, -- SecurityUI
	switch_channel_settings = {}, -- SecurityUI
	switch_channel_after_given_time = false, -- SecurityUI
	switch_channel_after_min_minutes = 30, -- SecurityUI
	switch_channel_after_max_minutes = 60, -- SecurityUI
	tp_delay = 100, -- SecurityUI
	tp_maxDistance = 350, -- SecurityUI
	allow_unsafe_tp_for_unstuck = false, -- SecurityUI
	blacklist_mob_ids = {
		{id = 20311, name = "Roaming Black Spirit (Monster in Bree Tree Ruins)"}, {id = 20536, name = "Bandit Warrior"},
  {id = 20537, name = "Bandit Archer"}, {id = 20550, name = "Band of Rogues"},
  {id = 23049, name = "Wizard's Chilling wave monster (Humpback Whale)"}, {id = 25511, name = "Ruins Guard Tower"},
  {id = 60119, name = "Spellbound Heart (Wizard's blue sphere)"},
  {id = 60120, name = "Magic Lighthouse (Wizard's red sphere)"}, {id = 60124, name = "Blade of Darkness I"},
  {id = 60125, name = "Blade of Darkness II"}, {id = 60126, name = "Blade of Darkness III"},
  {id = 60127, name = "Hell's Gate of Cartian's Guardian"}, {id = 60132, name = "Musa Air Waves"},
  {id = 60134, name = "Keeper Tett (Witch light golem)"}, {id = 60135, name = "Keeper Arne (Wizards water golem)"},
  {id = 60136, name = "Keeper Marg (Wizards fire golem)"}, {id = 60137, name = "Keeper Gorr (Witch stone golem)"},
  {id = 60138, name = "Kunoichi Sah Chakram"}, {id = 60139, name = "Witch's Toxic flood monster"},
  {id = 60140, name = "Keeper Tett (Witch light golem)"}, {id = 60141, name = "Keeper Gorr (Witch stone golem)"},
  {id = 60142, name = "Keeper Arne (Wizards water golem)"}, {id = 60143, name = "Keeper Marg (Wizards fire golem)"},
  {id = 60144, name = "Wizard's Lava skill monster (Fire Mat)"}, {id = 60147, name = "Striker Clone"},
  {id = 60148, name = "Female Brawler Summoned Being"}, {id = 60151, name = "Mystic Awakening Collecting"},
  {id = 60154, name = "Wolf Entity"}, {id = 60155, name = "Archer_Foor"}
	}, -- GrinderUI
	no_tp_onTownrun = false, -- SecurityUI
	respondToPvP = false, -- SecurityUI
	runAwayFromPvp = true, -- Not used
	use_tp = true, -- SecurityUI
	pickup_loot = true, -- GrinderUI
	pickup_loot_move = true, -- GrinderUI
	pickup_loot_move_range = 1250, -- GrinderUI
	disable_skip_path_nodes_onTownrun = false, -- SecurityUI
	attack_mobs_on_end_of_townrun = false, -- GrinderUI
	attack_mobs_in_townrun = false, -- GrinderUI
	use_legacy_warehouse = false, -- WarehouseUI
	allow_waiting_for_key_reset = false, -- AdvancedUI
	secureInput = false, -- AdvancedUI
	skillUse_delay = 100, -- TODO: IMPLEMENT
	use_legacy_selling = false, -- SellingUI
	do_not_extract_over_level = 15, -- AdvancedUI
	extract_blackstones = true, -- AdvancedUI
	grindSpot_min_mob_amount = 2, -- GrinderUI
	emulate_human_movement = false, -- SecurityUI
	skip_path_nodes = false, -- SecurityUI
	interpolation_path_smoothness = 2, -- SecurityUI
	interpolation_movement_smoothness = 2, -- SecurityUI
	auto_blacklist_non_group_mobs = false, -- GrinderUI
	auto_blacklist_non_group_mobs_min_count = 2, -- GrinderUI
	auto_blacklist_non_group_mobs_group_distance = 500, -- GrinderUI
	delay_after_battle_by_ms = 50, -- AdvancedUI
	delay_battle_by_ms = 50, -- AdvancedUI
	force_GC_every_x_pulse = 10000,
	work_on_ever_x_pulse = 1, -- AdvancedUI
	use_rage_buff = true, -- GrinderUI
	useSecurityOnTownrun = false, -- SecurityUI
	randomize_nav = false, -- SecurityUI
	randomize_nav_modifier = 20, -- SecurityUI
	disable_storage_on_full = false, -- TODO: IMPLEMENT
	stop_bot_on_full_storage = false, -- TODO: IMPLEMENT
	attack_mob_from_path_range = 500, -- GrinderUI
	attack_mob_from_player_range = 1000, -- GrinderUI
	attack_mob_from_grindSpot_range = 800, -- GrinderUI
	timeoutTimeAttackMobsNoDamage = 1500, -- GrinderUI
	auto_grind_spot = false, -- ProfileEditor
	auto_grind_spot_range = 800, -- ProfileEditor
	buy_hp_potion = true, -- RestockUI
	buy_hp_potion_amount = 40, -- RestockUI
	buy_hp_potion_id = 0, -- RestockUI
	buy_mp_potion = false, -- RestockUI
	buy_mp_potion_amount = 0, -- RestockUI
	buy_mp_potion_id = 0, -- RestockUI
	combat_routine = "", -- Not in UI, just for persistency
	profile_name = "", -- Not in UI, just for persistency
	draw_navigation = true, -- RenderUI
	draw_navigation_numbers = false, -- RenderUI
	draw_grindArea = false, -- RenderUI
	draw_grindSpots = true, -- RenderUI
	draw_destination = true, -- RenderUI
	draw_destination_collision_point = true, -- RenderUI
	draw_destination_path = true, -- RenderUI
	render_navigation_distance = 2000, -- RenderUI
	draw_debug_freeMoveTask = false, -- DebugUI
	draw_freeMove_path = false, -- RenderUI
	renderT1 = true, -- RenderUI
	renderT2 = true, -- RenderUI
	keep_silver_amount = 75000000, -- GUI (Townrun tab)
	log_verbose = true, -- AdvancedUI
	log_debug = false, -- DebugUI
	log_to_file = false, -- AdvancedUI
	log_buffer = true, -- AdvancedUI
	show_bot_ui = true,
	show_debug_ui = false, -- AdvancedUI
	tent_pos = nil, -- GUI
	stop_on_death = true, -- GrinderUI
	respawn_type = 1, -- GrinderUI
	respawn_by_fairy = true, -- GrinderUI
	use_Inventory_Money = true, -- GUI( Townrun tab)
	track_exp = false, -- GUI
	stopDistance = 150, -- not really used, only in specific cases, keep this.
	doRepairRuns = true, -- GUI
	usePotions = true, -- GrinderUI
	useHpPotAt = 75, -- GrinderUI
	useMpPotAt = 35, -- GrinderUI
	doMarketplace = false, -- Townrun tab
	selling = true, -- SellingUI
	sell_green_items = false, -- SellingUI
	sell_white_items = false, -- SellingUI
	sell_items = {},
	doNotSell_items = {},
	takeFromStorage_items = {}, -- WarehouseUI
	doWarehouse = true, -- WarehouseUI
	doTakeOut = true,
	deposit_items = {},
	hotkeys = {startstop = KeyCode_NUMPAD5, stop = KeyCode_NUMPAD4, addGrindspot = KeyCode_NUMPAD3},
	is_started = false,
	securityMode = 1
}
MagLib.Core.Settings.addSettingsToHandler("GrindBuddy", Grinder.settings)

Grinder.waitInitTime = 0
Grinder.toWaitTime = 0

Grinder.arrivedAtMobKey = nil

Grinder.profileEditMode = false

Grinder.notInWarehouseIds = {}

Grinder.potionData = {
	hp = {529, 524, 530, 525, 528, 519, 514, 518, 513, 517},
	mp = {532, 526, 533, 527, 531, 522, 516, 521, 515, 520}
}

Grinder.repairBlacklist = {}

Grinder.is_started = false

Grinder.CombatUtils = {}
Grinder.CombatUtils.doAutoAttack = AutoAttack.doAutoAttack

-- Internal global vars
Grinder.availableCombatScripts = {}
Grinder.availableProfiles = {}

Grinder.currentTargetKey = nil
Grinder.oldTargetKey = nil
Grinder.currentDest = nil
Grinder.currentDestIsNode = nil
Grinder.mobBlacklist = {}

Grinder.currentCombatScript = nil
Grinder.currentProfile = nil
Grinder.currentProfileIndex = -1

Grinder.nextNpcType = nil

Grinder.forceTownRun = false
Grinder.forcePotionBuy = false
Grinder.forceRepair = false
Grinder.forceStorage = false
Grinder.forceSell = false
Grinder.forceMarketplace = true

Grinder.finishedPotionBuy = false
Grinder.finishedRepair = false
Grinder.finishedStorage = false
Grinder.finishedSell = false
Grinder.finishedMarketplace = false

Grinder.currentlyTestingNav = false

Grinder.currentlyDoingTownrun = false
Grinder.currentlyFinishedTownrun = false
Grinder.lastCheckTownRun = 0

InitTime = 0

-- Vars set from combat script
Grinder.forceKeyUp = false
Grinder.forceCrosshair = true

Grinder.tempVars = {buy_hp_potion_amount = 40, buy_hp_potion_id = 0, buy_mp_potion_amount = 40, buy_mp_potion_id = 0}

function InitAll()
	AdvancedUI.init()
	BuyPotionsUI.init()
	DebugUI.init()

	-- Adding to blacklist
end

function Grinder.loadLastProfile()
	if Grinder.settings.profile_name ~= nil and Grinder.settings.profile_name ~= "" then
		for k, v in ipairs(Grinder.availableProfiles) do
			if v == Grinder.settings.profile_name then
				Grinder.currentProfile = Profile.loadProfile(Grinder.settings.profile_name)
				GUI.selectedProfileIndex = k
				return
			end
		end
	end
end

function Grinder.loadLastCombatscript()
	if Grinder.settings.combat_routine ~= nil and Grinder.settings.combat_routine ~= "" then
		Grinder.loadCombatScriptByName(Grinder.settings.combat_routine)
	end
end

MagLib.Events.addEventHandler("SettingsProfileLoaded", Grinder.loadLastProfile)
MagLib.Events.addEventHandler("SettingsProfileLoaded", Grinder.loadLastCombatscript)

function Grinder.start()
	InitTime = os.clock()
	InitAll()

	Log.log("Grinder initialized!")
	Grinder.getPossibleCombatScripts()
	Grinder.getPossibleProfiles()

	Grinder.loadLastCombatscript()

	Grinder.tempVars.buy_hp_potion_amount = tostring(Grinder.settings.buy_hp_potion_amount)
	Grinder.tempVars.buy_hp_potion_id = tostring(Grinder.settings.buy_hp_potion_id)
	Grinder.tempVars.buy_mp_potion_amount = tostring(Grinder.settings.buy_mp_potion_amount)
	Grinder.tempVars.buy_mp_potion_id = tostring(Grinder.settings.buy_mp_potion_id)

	if not Grinder.currentCombatScript then
		Log.log("Unable to preset combat routine! Please select one")
		Grinder.currentCombatScript = nil
	end

	Grinder.loadLastProfile()
end

function Grinder.OnAutoLoginAutoLoad()
	-- Infinity.BDO.getUIManager():setIsCursorActive(false)
	Log.log("GrindBuddy loaded from AutoLogin.")
	if Grinder.settings.is_started then
		Log.log("Starting GrindBuddy as it was started before last closing of BDO!")
		Grinder.startBot()
	end
end

function Grinder.startBot()
	Log.log("GrindBuddy started!")

	if not Grinder.currentCombatScript then
		Log.log("Please select a combatscript first")
		Grinder.stopBot()
		return
	end

	Grinder.is_started = true
	Grinder.settings.is_started = true
	if not Infinity.BDO.Input.isEmptyQueue() then
		Infinity.BDO.Input.clearQueue()
	end
	Grinder.currentProfile.nav.path = nil

	Log.log("Patching CameraCursorLock for camera!")
	Infinity.BDO.FunctionPatchManager.disableCameraCursorLock()

	Cache.resetExpData()
	StuckCheckTask.reset()
	StaySafeTask.reset()
end

function Grinder.stop()
	Grinder.allInputUp(true)
	Player.stopMoving()
	StaySafeTask.reset()

	Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
	Infinity.BDO.Input.setKeyInputFlagValue(0)

	print("Reverting patch of CameraCursorLock for camera!")
	Infinity.BDO.FunctionPatchManager.enableCameraCursorLock()

	print("GrindBuddy unloaded!")
end

function Grinder.stopBot()
	Grinder.allInputUp(true)
	Grinder.is_started = false
	Grinder.settings.is_started = false
	Player.stopMoving()

	Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
	Infinity.BDO.Input.setKeyInputFlagValue(0)

	Log.log("Reverting patch of CameraCursorLock for camera!")
	Infinity.BDO.FunctionPatchManager.enableCameraCursorLock()

	Log.log("GrindBuddy stopped!")
end

function Grinder.onGuiDraw()
	-- Log.debugLog("Drawing Grinder UI")
	GUI.draw()
	-- Log.debugLog("Drawing CombatScript UI")
	if (Grinder.currentCombatScript and Grinder.currentCombatScript.onRenderGUI) then
		Grinder.currentCombatScript:onRenderGUI()
	end
end

function Grinder.OnRenderD2D()
	Render2D2.render()
end

function Grinder.getPossibleCombatScripts()
	Grinder.availableCombatScripts = {}

	for k, v in pairs(Infinity.FileSystem.GetFiles("CombatScripts\\*.lua")) do
		table.insert(Grinder.availableCombatScripts, v:sub(1, v:len() - 4))
	end

	-- table.print(Grinder.availableCombatScripts)
end

function Grinder.addToMobBlacklist(target, time)
	Log.debugLog("Add to blacklist mob " .. target:getActorKey())
	Grinder.mobBlacklist[target:getActorKey()] = Cache.time + time
end

function Grinder.loadCombatScriptByName(name)
	Grinder.getPossibleCombatScripts()
	for k, v in ipairs(Grinder.availableCombatScripts) do
		if v == name then
			Grinder.loadCombatScript(k)
			GUI.selectedCSIndex = k
			break
		end
	end
end

function Grinder.loadCombatScript(index)
	local code = Infinity.FileSystem.ReadFile("CombatScripts/" .. Grinder.availableCombatScripts[index] .. ".lua")
	if (code == nil) then
		Log.log("ERROR: Could not load code of routine")
	end
	local combatFunc, error = load(code)
	if combatFunc == nil then
		Log.log(string.format("Unable to load combat script " .. Grinder.availableCombatScripts[index] .. ": func %s err %s ",
                      		tostring(Grinder.currentCombatScript), tostring(error)))
		code = nil
		return
	end
	Grinder.forceKeyUp = true -- Restting this
	Grinder.currentCombatScript = combatFunc()
	Grinder.settings.combat_routine = Grinder.availableCombatScripts[index]

	code = nil
	combatFunc = nil
end

function Grinder.getPossibleProfiles()
	Grinder.availableProfiles = {}
	Profile.refreshProfiles()
end

function Grinder.OnSelfActionChanged(action)
	if Grinder.currentCombatScript == nil then
		return
	end

	if Grinder.currentCombatScript.CurrentAction then
		Grinder.currentCombatScript.CurrentAction = action
	end

	if Grinder.currentCombatScript.SkillActions then
		for kT, sa in pairs(Grinder.currentCombatScript.SkillActions) do
			if sa.onSelfActionChange then
				sa:onSelfActionChange(action)
			end
		end
	end
end

function Grinder.resetGrindingAndNavVars()
	Log.debugLog("Reset Grinding and nav")
	Grinder.currentTargetKey = nil
	Grinder.currentDest = nil
	Grinder.currentDestIsNode = nil
	Grinder.mobBlacklist = {}

	Grinder.currentlyTestingNav = false
	-- Grinder.currentlyDoingTownrun = false

	FreeMoveTask.reset()
	StuckCheckTask.reset()

	SellTask.selectedActorData = nil

	Grinder.currentProfile.nav.stop()
end

Grinder.VirtualKeyCode = {
	KeyCode_LBUTTON = 1,
	KeyCode_RBUTTON = 2,
	KeyCode_CANCEL = 3,
	KeyCode_MBUTTON = 4,
	KeyCode_BACK = 8,
	KeyCode_TAB = 9,
	KeyCode_CLEAR = 12,
	KeyCode_RETURN = 13,
	KeyCode_SHIFT = 16,
	KeyCode_CONTROL = 17,
	KeyCode_MENU = 18,
	KeyCode_PAUSE = 19,
	KeyCode_CAPITAL = 20,
	KeyCode_ESCAPE = 27,
	KeyCode_SPACE = 32,
	KeyCode_PGUP = 33,
	KeyCode_PGDN = 34,
	KeyCode_END = 35,
	KeyCode_HOME = 36,
	KeyCode_LEFT = 37,
	KeyCode_UP = 38,
	KeyCode_RIGHT = 39,
	KeyCode_DOWN = 40,
	KeyCode_SELECT = 41,
	KeyCode_PRINT = 42,
	KeyCode_EXECUTE = 43,
	KeyCode_SNAPSHOT = 44,
	KeyCode_INSERT = 45,
	KeyCode_DELETE = 46,
	KeyCode_HELP = 47,
	KeyCode_0 = 48,
	KeyCode_1 = 49,
	KeyCode_2 = 50,
	KeyCode_3 = 51,
	KeyCode_4 = 52,
	KeyCode_5 = 53,
	KeyCode_6 = 54,
	KeyCode_7 = 55,
	KeyCode_8 = 56,
	KeyCode_9 = 57,
	KeyCode_A = 65,
	KeyCode_B = 66,
	KeyCode_C = 67,
	KeyCode_D = 68,
	KeyCode_E = 69,
	KeyCode_F = 70,
	KeyCode_G = 71,
	KeyCode_H = 72,
	KeyCode_I = 73,
	KeyCode_J = 74,
	KeyCode_K = 75,
	KeyCode_L = 76,
	KeyCode_M = 77,
	KeyCode_N = 78,
	KeyCode_O = 79,
	KeyCode_P = 80,
	KeyCode_Q = 81,
	KeyCode_R = 82,
	KeyCode_S = 83,
	KeyCode_T = 84,
	KeyCode_U = 85,
	KeyCode_V = 86,
	KeyCode_W = 87,
	KeyCode_X = 88,
	KeyCode_Y = 89,
	KeyCode_Z = 90,
	KeyCode_NUMPAD0 = 96,
	KeyCode_NUMPAD1 = 97,
	KeyCode_NUMPAD2 = 98,
	KeyCode_NUMPAD3 = 99,
	KeyCode_NUMPAD4 = 100,
	KeyCode_NUMPAD5 = 101,
	KeyCode_NUMPAD6 = 102,
	KeyCode_NUMPAD7 = 103,
	KeyCode_NUMPAD8 = 104,
	KeyCode_NUMPAD9 = 105,
	KeyCode_MULTIPLY = 106,
	KeyCode_ADD = 107,
	KeyCode_SEPARATOR = 108,
	KeyCode_SUBTRACT = 109,
	KeyCode_DECIMAL = 110,
	KeyCode_DIVIDE = 111,
	KeyCode_F1 = 112,
	KeyCode_F2 = 113,
	KeyCode_F3 = 114,
	KeyCode_F4 = 115,
	KeyCode_F5 = 116,
	KeyCode_F6 = 117,
	KeyCode_F7 = 118,
	KeyCode_F8 = 119,
	KeyCode_F9 = 120,
	KeyCode_F10 = 121,
	KeyCode_F11 = 122,
	KeyCode_F12 = 123,
	KeyCode_F13 = 124,
	KeyCode_F14 = 125,
	KeyCode_F15 = 126,
	KeyCode_F16 = 127,
	KeyCode_F17 = 128,
	KeyCode_F18 = 129,
	KeyCode_F19 = 130,
	KeyCode_F20 = 131,
	KeyCode_F21 = 132,
	KeyCode_F22 = 133,
	KeyCode_F23 = 134,
	KeyCode_F24 = 135,
	KeyCode_OEM_2 = 191,
	KeyCode_OEM_3 = 192,
	KeyCode_OEM_7 = 222
}

function Grinder.allInputUp(force)
	if Grinder.forceKeyUp or force then
		Log.debugLog("AllInputUp")
		Input.reset()
	end
end

function Grinder.IsAnyInputDown()
	-- Log.debugLog("IsAnyInputDown")
	for _, v in ipairs(Grinder.VirtualKeyCode) do
		if Infinity.BDO.Input.IsKeyPressed(v) then
			return true
		end
	end
	return false
end

Grinder.lastTimeNotInGame = 0
Grinder.lastTimeisLuaLoadingCheck = 0

function Grinder.isInGame()
	-- Log.debugLog("IsInGame Call")
	local isInGame = Infinity.BDO.Lua.Execute("return isLuaLoadingComplete")
	if not isInGame then
		Grinder.lastTimeNotInGame = Cache.time
	end

	return isInGame
end

function Grinder.wait(ms)
	Log.debugLog("wait (ms) " .. ms)

	if Grinder.waitInitTime + Grinder.toWaitTime < Cache.time + ms then
		Grinder.waitInitTime = Cache.time
		Grinder.toWaitTime = ms
	end
	return
end

function Grinder.needToDodge()
	-- TargetHelper.getClosestMonsterAttack(tMonsters)
end

Grinder.pulseCounter = 0
Grinder.arrivedAtMobKey = nil

Grinder.pvpRange_fromNavGraph = 1250
Grinder.ignorePvPUntil = 0
Grinder.currentlyInPvp = false
Grinder.lastPvPCheck = 0

Grinder.pvp_fights = {}

function Grinder.handlePvP()
	if Grinder.ignorePvPUntil > Cache.time then
		return false
	end

	if Grinder.currentProfile and SelectGrindAreaPositionTask._areas and Grinder.settings.respondToPvP and
		(Grinder.currentlyInPvp or Grinder.lastPvPCheck + 500 < Cache.time) then
		local pPos = Cache.playerPos
		local hostilePlayer = nil
		local distToClosestHostilePlayer = 1 / 0
		local currentGrindspot = Grinder.currentProfile.closestGrindSpot(pPos)
		currentGrindspot = Vector3(currentGrindspot.X, currentGrindspot.Y, currentGrindspot.Z)
		local closestNode = Grinder.currentProfile.navGraph.graph_handler.getClosestNode(pPos)
		local closestNodePos = closestNode.pos
		for _, player in pairs(Infinity.BDO.getActorList(EActorType_Player)) do
			if (player:isValid() and TargetHelper.getHp(player) > 0 and player:isPreemptiveStrikeBeing()) then
				local hostilePos = player:getPosition()
				local hostilePlayerKey = player:getActorKey()
				local distToFightStart = 0
				local fightData = Grinder.pvp_fights[hostilePlayerKey]
				if fightData then
					local startPos = fightData.startPos
					local distToStartPos = startPos:getDistance(pPos)
					if fightData.startTime + 60000 > Cache.time and distToStartPos < 4500 then
						distToFightStart = distToStartPos
					else
						Grinder.pvp_fights[hostilePlayerKey] = nil
					end
				end
				local dist = pPos:getDistance(hostilePos)
				local grindspotDistance = currentGrindspot:getDistance(player:getPosition())
				local closestNodeDistance = closestNodePos:getDistance(player:getPosition())
				if distToFightStart < 3000 and
					(grindspotDistance < Grinder.pvpRange_fromNavGraph or dist < Grinder.pvpRange_fromNavGraph) and dist <
					distToClosestHostilePlayer then
					hostilePlayer = player
					distToClosestHostilePlayer = dist
				else
					Grinder.ignorePvPUntil = Cache.time + 6000
				end

				hostilePos = nil
				hostilePlayerKey = nil
				distToFightStart = nil
				fightData = nil
			end
		end

		pPos = nil
		distToClosestHostilePlayer = nil
		currentGrindspot = nil
		closestNode = nil
		closestNodePos = nil

		if hostilePlayer ~= nil then
			local hostilePlayerKey = hostilePlayer:getActorKey()
			if Game.inSafezone() then
				math.randomseed(Cache.time)
				Grinder.wait(math.random(8000, 25000))
				return true
			end

			Grinder.currentlyInPvp = true
			if Grinder.currentCombatScript.combatHostile then
				Grinder.currentCombatScript:combatHostile(hostilePlayerKey)
			else
				Grinder.currentCombatScript:combat(hostilePlayerKey)
			end

			if Grinder.pvp_fights[hostilePlayerKey] == nil then
				local fightData = {startTime = Cache.time, startPos = Cache.playerPos, playerCharName = hostilePlayer:getName()}
				Grinder.pvp_fights[hostilePlayerKey] = fightData
				fightData = nil
			end

			hostilePlayer = nil

			return true
		end
	end

	Grinder.currentlyInPvp = false
	return false
end

Grinder.autoBlacklistNonGroupsLastTime = 0
function Grinder.autoBlacklistNonGroupsPulse()
	Log.debugLog("Auto blacklist pulse")
	if Grinder.settings.auto_blacklist_non_group_mobs then
		if Grinder.autoBlacklistNonGroupsLastTime + 400 < Cache.time then
			Grinder.autoBlacklistNonGroupsLastTime = Cache.time
			local playerPos = Cache.playerPos
			for k, v in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
				if v and ActorUtils.isValidActor(v) and (not v:getIsDead()) then
					-- and v:getPosition():getDistance(playerPos) <= 4000 then
					local mobsAroundMob = table.length(TargetHelper.getMonstersInRangeOfLocation(v:getPosition(), Grinder.settings
                                                                             						.auto_blacklist_non_group_mobs_group_distance))
					if mobsAroundMob < Grinder.settings.auto_blacklist_non_group_mobs_min_count then
						Grinder.addToMobBlacklist(v, 120)
					end
					mobsAroundMob = nil
				end
			end
			playerPos = nil
		end
	end
end

function Grinder.forceCrossHair(targetKey)
	-- Need to set this every pulse

	local actor = ActorUtils.getActor(targetKey)
	if actor and ActorUtils.isValidActor(actor) and TargetHelper.getHp(actor) > 0 then
		Infinity.BDO.Selection.setNewAttackTarget(targetKey)
		Infinity.BDO.Selection.setTarget(targetKey)
	end
end

Grinder.currentLoot = nil
Grinder.currentLootArrived = false
Grinder.currentLootArrivedAtTime = 0
Grinder.lastUpdatedLootActors = 0
Grinder.lootActorBlacklist = {}

function Grinder.pickup()
	Log.debugLog("Pickup check...")

	local loot_range = 280

	local moveToPickup = Grinder.settings.pickup_loot_move
	if moveToPickup then
		loot_range = Grinder.settings.pickup_loot_move_range
	end

	if Grinder.currentLoot and Grinder.currentLootArrived and Grinder.currentLoot.pos:getDistance(Cache.playerPos) <
		loot_range then
		Cache.updateLootActors()

		local stillInLootActorList = false
		for k, v in ipairs(Cache.lootActors) do
			if Grinder.currentLoot.key == v.key then
				stillInLootActorList = true
			end
		end

		if not stillInLootActorList then
			Grinder.currentLoot = nil
			Grinder.currentLootArrived = false
			return false
		end

		if Grinder.currentLootArrivedAtTime + 1000 < Cache.time then
			Log.log("Failed to pickup Loot " .. Grinder.currentLoot.key .. "! Adding to blacklist for 1 minute")
			Grinder.lootActorBlacklist[Grinder.currentLoot.key] = Cache.time + 60000
			Grinder.currentLoot = nil
			Grinder.currentLootArrived = false
			return true
		end

		Grinder.wait(25)
		Player.stopMoving()

		return true
	end

	if Grinder.lastUpdatedLootActors + 250 < Cache.time then
		Cache.updateLootActors()
	end

	local closestLoot = nil
	local closestLootDistance = 1 / 0

	local pPos = Cache.playerPos
	for k, v in pairs(Cache.lootActors) do
		local dist = v.pos:getDistance(pPos)
		if dist <= loot_range and dist < closestLootDistance and
			((not Grinder.lootActorBlacklist[v.key]) or Grinder.lootActorBlacklist[v.key] < Cache.time) then
			if not (moveToPickup and Raycast.safeTwoPos(v.pos, pPos)) then
				closestLoot = v
				closestLootDistance = dist
			end
		end

		dist = nil
	end

	moveToPickup = nil
	loot_range = nil

	if closestLoot ~= nil then
		if (not Grinder.currentLoot) or closestLoot.key ~= Grinder.currentLoot.key then
			Grinder.currentLoot = closestLoot
		end

		closestLoot = nil
		closestLootDistance = nil

		if Grinder.settings.pickup_loot_move then
			if not MoveToTask.work(Grinder.currentLoot.pos, 250, false) then
				Grinder.navigationPulse()
				Player.stopMoving()
				return true
			else
				Grinder.currentLootArrived = true
				Grinder.currentLootArrivedAtTime = Cache.time
				Grinder.wait(25)
				Player.stopMoving()
				return true
			end
		else
			Grinder.currentLootArrived = true
			Grinder.currentLootArrivedAtTime = Cache.time
			Grinder.wait(25)
			Player.stopMoving()
			return true
		end
	end

	Log.debugLog("Nothing to pickup...")
	return false
end

function Grinder.updateTownrunTargets()
	Grinder.finishedRepair = not (RepairTask.needToRun())
	Grinder.finishedSell = not (SellTask.needToRun())
	Grinder.finishedPotionBuy = not (RestockTask.needToRun())
	Grinder.finishedStorage = not (WarehouseTask.needToRun())
	Grinder.finishedMarketplace = not (MarketplaceTask.needToRun())
end

Grinder.beforeFightingRot = nil
Grinder.beforeFightingTime = 0

Grinder.lastTimeExtracted = 0

Grinder.lastTimeCombat = 0
Grinder.lastTimeCombatCheck = 0
Grinder.lastPulseStart = 0
Grinder.lastPulseTime = 0

Grinder.resetFlagInterval = 50
Grinder.lastSkillUsed = 0
Grinder.lastSkillFlag = nil

function Grinder.onSkillUse(flag)
	Grinder.lastSkillUsed = Infinity.Win32:GetTickCount()
	Grinder.lastSkillFlag = flag
end

function Grinder.overrideKeyFlag()
	if (Grinder.settings.use_keyflag) then
		local flag = Grinder.lastSkillFlag
		if flag and Grinder.lastSkillUsed + Grinder.resetFlagInterval > Infinity.Win32:GetTickCount() then
			Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
			Infinity.BDO.Input.setKeyInputFlagValue(flag)
		else
			Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
			Infinity.BDO.Input.setKeyInputFlagValue(0)
			Grinder.lastSkillFlag = nil
		end
	end
end

local returnFromTownrunGrindspotPos = nil

local function hotkeyStartStop()
	Log.debugLog("Started/Stopped through hotkey")
	if Grinder.is_started then
		Grinder.stopBot()
	else
		Grinder.startBot()
	end
end

local function hotkeyStop()
	Log.debugLog("Stopped through Hotkey")
	if Grinder.is_started then
		Grinder.stopBot()
	end
end

local function hotkeyAddGrindspot()
	Log.debugLog("Adding grindspot over hotkey")
	-- Getting closest area through finding closest Grindspot in all areas.
	local closestAreaData = nil
	local closestGrindspotDistance = 1 / 0
	local pPos = Cache.playerPos
	-- Add a area if there is none yet
	if (#Grinder.currentProfile.areas == 0) then
		table.insert(Grinder.currentProfile.areas, {minLevel = 1, maxLevel = 70, spots = {}})
	end

	for areaId, areaData in pairs(Grinder.currentProfile.areas) do
		for spotId, spotData in pairs(areaData.spots) do
			local distance = pPos:getDistance(Vector3(spotData.X, spotData.Y, spotData.Z))
			if distance < closestGrindspotDistance then
				closestGrindspotDistance = distance
				closestAreaData = areaData
			end
		end

		-- We make sure we set the first area if none is set. We earlier guaranteed that a profile exists
		if (closestAreaData == nil) then
			closestAreaData = areaData
			closestGrindspotDistance = 1 / 0
		end
	end
	-- Taking area of closest area and adding new grindspot in there.
	local gX = math.floor(pPos.X + 0.5)
	local gY = math.floor(pPos.Y + 0.5)
	local gZ = math.floor(pPos.Z + 0.5)
	table.insert(closestAreaData.spots, {X = gX, Y = gY, Z = gZ})

	Log.log("Adding Grindspot at X: " .. gX .. ", Y: " .. gY .. ", Z: " .. gZ)

end

-- Hotkey stuff
function Grinder.unregisterHotkeys()
	MagLib.Hotkeys.removeHotkey(nil, hotkeyStartStop, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	MagLib.Hotkeys.removeHotkey(nil, hotkeyStop, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	MagLib.Hotkeys.removeHotkey(nil, hotkeyAddGrindspot, MagLib.Hotkeys.KeyEvents.OnKeyDown)
end

function Grinder.registerHotkeys()
	Grinder.unregisterHotkeys() -- just to be sure
	MagLib.Hotkeys.addHotkey(Grinder.settings.hotkeys.startstop, hotkeyStartStop, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	MagLib.Hotkeys.addHotkey(Grinder.settings.hotkeys.stop, hotkeyStop, MagLib.Hotkeys.KeyEvents.OnKeyDown)
	MagLib.Hotkeys.addHotkey(Grinder.settings.hotkeys.addGrindspot, hotkeyAddGrindspot, MagLib.Hotkeys.KeyEvents.OnKeyDown)
end
-- Initial registering
Grinder.registerHotkeys()

function Grinder.onPulse()
	if MagLib.onPulse_Beginning() then
		return Grinder.returnMessage()
	end

	Log.debugLog("-------------------------" .. "\n" .. "Current Lua usage: " .. (collectgarbage("count")) .. " KB")

	local tick = Infinity.Win32.GetPerformanceCounter()
	local tickDif = tick - Grinder.lastPulseStart
	if tickDif > 0 then
		Grinder.lastPulseTime = tickDif
	end
	Grinder.lastPulseStart = tick
	Grinder.pulseCounter = Grinder.pulseCounter + 1

	-- Log pulse (prints the log from last pulse)
	Log.onPulse()

	-- Key flag resetting
	Grinder.overrideKeyFlag()

	if Grinder.is_started and Grinder.forceCrosshair and Grinder.currentTargetKey ~= nil then
		Grinder.forceCrossHair(Grinder.currentTargetKey)
	end

	-- Handle input (mostly upping keys)
	local didInput = Input.onPulse()
	if didInput then
		didInput = nil
		Log.debugLog("Returning since we did some input stuff")
		return Grinder.returnMessage()
	end
	didInput = nil

	Cache.updateCachePulse()

	if Grinder.is_started == true and Grinder.currentProfile and Grinder.currentCombatScript then
		-- Check for Security Stuff
		if StaySafeTask.work() then
			return Grinder.returnMessage()
		end
	end

	-- Wait check
	if Grinder.waitInitTime + Grinder.toWaitTime > Infinity.Win32.GetTickCount() then
		-- Log.debugLog("Waiting until " ..(Grinder.waitInitTime + Grinder.toWaitTime) .. " (Current time:" .. Infinity.Win32.GetTickCount() .. ")")
		return Grinder.returnMessage()
	end

	if not Grinder.isInGame() then
		Grinder.resetGrindingAndNavVars()
		return Grinder.returnMessage()
	end

	-- Log.debugLog("OnPulse")
	if Grinder.pulseCounter < Grinder.settings.work_on_ever_x_pulse then
		Log.debugLog("Skipping pulse")
		return Grinder.returnMessage()
	else
		Grinder.pulseCounter = 0
	end

	-- UpdatingTemps
	Grinder.settings.buy_hp_potion_amount = tonumber(Grinder.tempVars.buy_hp_potion_amount)
	Grinder.settings.buy_hp_potion_id = tonumber(Grinder.tempVars.buy_hp_potion_id)
	Grinder.settings.buy_mp_potion_amount = tonumber(Grinder.tempVars.buy_mp_potion_amount)
	Grinder.settings.buy_mp_potion_id = tonumber(Grinder.tempVars.buy_mp_potion_id)

	--[[if Grinder.lastTimeNotInGame + 30000 > Infinity.Win32.GetTickCount() then
    Grinder.resetGrindingAndNavVars()
    return Grinder.returnMessage()
  end]]

	-- Log.debugLog("Cache update pulse")

	-- Profile loading
	if GUI.selectedProfileIndex ~= Grinder.currentProfileIndex and Grinder.availableProfiles[GUI.selectedProfileIndex] ~=
		nil and Grinder.availableProfiles[GUI.selectedProfileIndex] ~= "New profile..." then
		Grinder.currentProfile = Profile.loadProfile(Grinder.availableProfiles[GUI.selectedProfileIndex])
		Grinder.currentProfileIndex = GUI.selectedProfileIndex
	end

	-- Unloading profile when "New profile..." is selected
	if GUI.selectedProfileIndex ~= Grinder.currentProfileIndex and Grinder.availableProfiles[GUI.selectedProfileIndex] ~=
		nil and Grinder.availableProfiles[GUI.selectedProfileIndex] == "New profile..." then
		Grinder.currentProfile = nil
		Grinder.currentProfileIndex = GUI.selectedProfileIndex
	end

	if Grinder.currentProfile then
		-- Log.debugLog("Profile on Pulse")
		Grinder.currentProfile.onPulse()
	end

	if Grinder.currentlyTestingNav == true then
		Grinder.navigationPulse()
		if Grinder.currentDest:getDistance(Cache.playerPos) < 100 then
			Grinder.currentlyTestingNav = false
		end
		return Grinder.returnMessage()
	end

	if Grinder.is_started == true and Grinder.currentProfile and Grinder.currentCombatScript then
		-- Grinder.once = true

		Log.debugLog("Started Started Pulse")

		-- Potion using
		PottingTask.work()

		-- If dead Resurrect
		if RespawnTask.needToRun() then
			-- Resetting everything and reviving
			Grinder.resetGrindingAndNavVars()
			RespawnTask.work()
			return Grinder.returnMessage()
		end

		-- Combat script onPulse stuff
		if Grinder.currentCombatScript.onPulse then
			local needToReturn = Grinder.currentCombatScript.onPulse()
			if needToReturn then
				return Grinder.returnMessage()
			end
			needToReturn = nil
		end

		-- If a long distance TP is forced
		if Teleport.forcePulse() then
			return Grinder.returnMessage()
		end

		StuckCheckTask.pulse()

		-- TownRun stuff
		-- TentTask.work()

		-- Blackstone Extraction stuff
		if Grinder.lastTimeExtracted + 2500 < Cache.time then
			if ExtractTask.NeedToRun() then
				if ExtractTask.work() then
					Grinder.lastTimeExtracted = Cache.time
				end
				return Grinder.returnMessage()
			else
				Grinder.lastTimeExtracted = Cache.time
			end
		end

		-- PvP Handling
		if Grinder.handlePvP() then
			return Grinder.returnMessage()
		end

		Log.debugLog("Townrun?")

		if Grinder.lastCheckTownRun + 863 < Cache.time then
			Grinder.lastCheckTownRun = Cache.time
			if (not Grinder.currentlyFinishedTownrun and Grinder.currentlyDoingTownrun == false and ChooseIfTownRunTask.work()) or
				Grinder.forceTownRun then
				Grinder.forceTownRun = false
				Grinder.currentlyDoingTownrun = true
				Grinder.currentlyFinishedTownrun = false
				Grinder.finishedPotionBuy = false
				Grinder.finishedRepair = false
				Grinder.finishedStorage = false
				Grinder.finishedSell = false
				Grinder.finishedMarketplace = false
				Log.log("Starting townrun sequence...")

				Grinder.updateTownrunTargets()

				if Grinder.settings.log_verbose then
					Log.log("Based of the following data:")

					local code = [[
                local inventorySize = getSelfPlayer():get():getInventorySlotCount(false)
                local allWeight = Int64toInt32(getSelfPlayer():get():getCurrentWeight_s64())
                local maxWeight = Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64())
                return inventorySize, allWeight, maxWeight
                ]]

					local inventorySize, allWeight, maxWeight = Infinity.BDO.Lua.Execute(code)
					local weight_pct = allWeight / maxWeight
					local silverCount, silverSlot = Inventory.getItemDataByItemId(1)
					local hpPotsAmount = RestockTask.getPotionCount(1)
					local mpPotsAmount = RestockTask.getPotionCount(2)

					Log.log(" - Weight: " .. tostring(weight_pct * 100) .. "%" .. "\n" .. " - Free Inventory slots: " ..
        						tostring(Inventory.getFreeSlotCount()) .. "\n" .. " - Items to sell: " .. tostring(#NPCUtils.itemsToSell) ..
        						"\n" .. " - Items to take out: " .. tostring(#NPCUtils.itemsToTakeOut) .. "\n" .. " - Items to deposit: " ..
        						tostring(#NPCUtils.itemsToDeposit) .. "\n" .. " - Silver: " .. tostring(silverCount) .. "\n" ..
        						" - HP Potions: " .. tostring(hpPotsAmount) .. "\n" .. " - MP Potions: " .. tostring(mpPotsAmount) .. "\n" ..
        						" - Item below 10 durability: " .. tostring(Inventory.isItemBelowEndurance(10)) .. "\n" ..
        						" - Item below 50 durability: " .. tostring(Inventory.isItemBelowEndurance(50)) .. "\n" ..
        						" it looks like we are going to go to:" .. "\n" .. " - Repair: " .. tostring(not Grinder.finishedRepair) ..
        						"\n" .. " - Selling: " .. tostring(not Grinder.finishedSell) .. "\n" .. " - Restock: " ..
        						tostring(not Grinder.finishedPotionBuy) .. "\n" .. " - Warehouse: " ..
        						tostring(not Grinder.finishedStorage) .. "\n" .. " - Marketplace: .. " ..
        						tostring(not Grinder.finishedMarketplace) .. "\n" .. " \n" .. "This might change during the townrun!")
				end

				Grinder.wait(25)

				collectgarbage()
			end
		end

		if (not Grinder.currentlyFinishedTownrun and Grinder.currentlyDoingTownrun) then
			-- Handle mobs on the way from townrun
			-- Get closest mob
			if Grinder.settings.attack_mobs_in_townrun then
				local fought = Grinder.fightCloseEnemys()
				if fought then
					fought = nil
					return Grinder.returnMessage()
				end

				fought = nil
			end

			if (not Grinder.finishedRepair) then
				local repairedAll = RepairTask.work()
				if repairedAll then
					StuckCheckTask.reset()

					-- Grinder.updateTownrunTargets()
					Grinder.finishedRepair = true
					Grinder.resetGrindingAndNavVars()
				end
				repairedAll = nil
			elseif (not Grinder.finishedSell) then
				local soldAll = SellTask.work()
				if soldAll then
					StuckCheckTask.reset()

					Grinder.updateTownrunTargets()
					Grinder.finishedSell = true
					NPCUtils.closeNpcDialog()
					Grinder.resetGrindingAndNavVars()
				end
				soldAll = nil
			elseif (not Grinder.finishedPotionBuy) then
				local finishedBuying = RestockTask.work()
				if finishedBuying then
					StuckCheckTask.reset()

					-- Grinder.updateTownrunTargets()
					Grinder.finishedPotionBuy = true
					NPCUtils.closeNpcDialog()
					Grinder.resetGrindingAndNavVars()
				end
				finishedBuying = nil
			elseif (not Grinder.finishedStorage) then
				local finishedDeposit = WarehouseTask.work()
				if finishedDeposit then
					StuckCheckTask.reset()

					-- Grinder.updateTownrunTargets() --No need to update townrun targets here.
					Grinder.finishedStorage = true
					NPCUtils.closeNpcDialog()
					Grinder.resetGrindingAndNavVars()
				end
				finishedDeposit = nil
			elseif (not Grinder.finishedMarketplace) then
				local finishedMarketplace = MarketplaceTask.work()
				if finishedMarketplace then
					StuckCheckTask.reset()
					NPCUtils.closeNpcDialog()
					Grinder.finishedMarketplace = true
					Grinder.resetGrindingAndNavVars()
				end
				finishedMarketplace = nil
			else
				Log.log("Finished Townrun, returning to Grind spot")
				NPCUtils.closeNpcDialog()
				-- Resetting finished vars
				Grinder.finishedPotionBuy = false
				Grinder.finishedRepair = false
				Grinder.finishedStorage = false
				Grinder.finishedSell = false

				Grinder.forceTownRun = false
				Grinder.currentlyDoingTownrun = false
				Grinder.currentlyFinishedTownrun = true

				SelectGrindAreaPositionTask._currentSpotId = nil

				StuckCheckTask.reset()

				Grinder.wait(50)

				return Grinder.returnMessage()
			end
			-- Log.log("navPulse in TownRun")
			--[[if Grinder.currentDest then
                NPCUtils.closeNpcDialog()
                return
            else
                return
            end]]
			return
		end

		if Grinder.currentlyFinishedTownrun == true then
			if Grinder.currentDest == nil or returnFromTownrunGrindspotPos == nil then
				SelectGrindAreaPositionTask._currentSpotId = nil
				SelectGrindAreaPositionTask.work()
				returnFromTownrunGrindspotPos = Vector3(Grinder.currentDest.X, Grinder.currentDest.Y, Grinder.currentDest.Z)
			end

			if Grinder.settings.attack_mobs_on_end_of_townrun then
				local fought = Grinder.fightCloseEnemys()
				if fought then
					return Grinder.returnMessage()
				end
				fought = nil
			end

			local arrived = returnFromTownrunGrindspotPos:getDistance(Cache.playerPos) <
                				Grinder.settings.attack_mob_from_grindSpot_range + 600
			if not arrived then
				SelectGrindAreaPositionTask.work()
				Grinder.navigationPulse()
				return Grinder.returnMessage()
			end

			arrived = nil

			Grinder.currentlyFinishedTownrun = false
			returnFromTownrunGrindspotPos = nil
		end

		if Grinder.lastTimeCombatCheck + 25 < Cache.time then
			Grinder.lastTimeCombatCheck = Cache.time

			Grinder.autoBlacklistNonGroupsPulse()
			Log.debugLog("Fighting...")
			-- Fight until there is no enemy in range anymore
			-- Log.debugLog("Selecting enemy to attack")
			local gotEnemy = SelectAttackActorTask.work()
			if not Grinder.settings.delay_after_battle_by_ms == 0 and Grinder.oldTargetKey ~= Grinder.currentTargetKey then
				Grinder.oldTargetKey = Grinder.currentTargetKey
				Grinder.wait(Grinder.settings.delay_after_battle_by_ms)
				Log.debugLog("Wait for " .. Grinder.settings.delay_battle_by_ms .. "ms because we killed a mob!")
				return Grinder.returnMessage()
			end

			if gotEnemy then
				-- Log.debugLog("Moving to enemy")
				local alreadyInRange = MoveToAttackActorTask.work()
				if alreadyInRange then
					alreadyInRange = nil
					if not Grinder.settings.delay_battle_by_ms == 0 and Grinder.arrivedAtMobKey ~= Grinder.currentTargetKey then
						Grinder.arrivedAtMobKey = Grinder.currentTargetKey
						Grinder.wait(Grinder.settings.delay_battle_by_ms)
						Log.debugLog("Wait for " .. Grinder.settings.delay_battle_by_ms .. "ms because we arrived at the mob!")
						return Grinder.returnMessage()
					end

					-- Grinder.resetNav()
					Grinder.allInputUp()

					Grinder.lastTimeCombat = Cache.time

					local fighting = AttackActorTask.work()
					Log.debugLog("Finished attacking!")
					return Grinder.returnMessage()
				end
			else
				-- Check if we are already at the right Grindspot, if not we will move there.
				-- Log.debugLog("Setting new grindspot")
				-- Pickup
				if Grinder.settings.pickup_loot then
					local didSth = Grinder.pickup()
					if didSth then
						return Grinder.returnMessage()
					end
				end

				if not StaySafeTask.enterBANextPulse and not StaySafeTask.inBA then
					-- local movingToGrindSpot =
					SelectGrindAreaPositionTask.work()
				end
			end
		end

		if Grinder.lastTimeCombat + 150 < Cache.time then
			local completlyReturn = Grinder.navigationPulse()
			if completlyReturn then
				completlyReturn = nil
				return Grinder.returnMessage()
			end
			completlyReturn = nil
		end

		-- Dodge when attacked
		--[[if Grinder.currentCombatScript and Grinder.currentCombatScript.onGetAttacked then
            local attackingMobs = TargetHelper.getClosestAttackingMonsters(Cache.mobsInRange)
            if attackingMobs and #attackingMobs > 0 then
                Grinder.currentCombatScript:onGetAttacked(attackingMobs)
            end
        end]]
	end

	return Grinder.returnMessage()
end

Grinder.lastJumpTime = 0

Grinder.jump = function()
	if not Grinder.isActionQueued() then
		Grinder.lastJumpTime = Cache.time
		Input.pressOnce({KeyCode_SPACE}, 75)
		Grinder.wait(160)
	end
end

Grinder.isActionQueued = function()
	if Player.me():getCharacterControler():getNextAction() ~= nil then
		return true
	else
		return false
	end
end

Grinder.lastJumpCheck = 0
Grinder.lastTimeUpdatedNav = 0

function Grinder.navigationPulse()
	-- Navigators onPulse
	Log.debugLog("navigationPulse")

	if Grinder.currentDest == nil then
		return
	end

	Grinder.lastTimeUpdatedNav = Cache.time

	if not Grinder.isActionQueued() and not Grinder.IsAnyInputDown() then
		local jumpOverTime = Grinder.lastJumpTime + 998
		if jumpOverTime > Cache.time then
			jumpOverTime = nil
			return true
		elseif jumpOverTime + 100 > Cache.time then
			-- TODO: Maybe force a recalculation of the current path here?
			Grinder.lastJumpTime = 0 -- To make it not recalc every pulse
		end
		jumpOverTime = nil

		local stuck = StuckCheckTask.work()
		if stuck then -- StuckCheckTask tries to unstuck as well, meaning we just return and let it work
			stuck = nil
			return true
		end
		stuck = nil

		-- Grinder.resetNav()
		-- Log.log("isNav: " .. tostring(Grinder.currentDestIsNode))

		if (not Teleport.isTpAllowed()) and Grinder.lastJumpTime + 1988 < Cache.time and Grinder.lastJumpCheck + 159 <
			Cache.time then
			Grinder.lastJumpCheck = Cache.time

			if Grinder.currentProfile and Grinder.currentProfile.nav.path and Grinder.currentProfile.nav.path.waypoints and
				#Grinder.currentProfile.nav.path.waypoints > 0 then
				if Raycast.hasJumpable(Cache.playerPos, VectorUtils.tableToVector3(Grinder.currentProfile.nav.path.waypoints[1])) then
					Grinder.jump()
					return true
				end
			elseif Grinder.currentDest then
				if Raycast.hasJumpable(Cache.playerPos, VectorUtils.tableToVector3(Grinder.currentDest)) then
					Grinder.jump()
					return true
				end
			end

			if FreeMoveTask.needTo then
				if FreeMoveTask.nextDest and FreeMoveTask.nextDest.X == 0 and FreeMoveTask.nextDest.Y == 0 and
					FreeMoveTask.nextDest.Z == 0 and
					Raycast.hasJumpable(Cache.playerPos, VectorUtils.tableToVector3(FreeMoveTask.nextDest)) then
					Grinder.jump()
					return true
				end

				if FreeMoveTask.endDest and FreeMoveTask.endDest.X == 0 and FreeMoveTask.endDest.Y == 0 and FreeMoveTask.endDest.Z ==
					0 and Raycast.hasJumpable(Cache.playerPos, VectorUtils.tableToVector3(FreeMoveTask.endDest)) then
					Grinder.jump()
					return true
				end
			end
		end

		if (Grinder.currentDest ~= nil) and FreeMoveTask.needTo == false then
			local dest = VectorUtils.tableToVector3(Grinder.currentDest)
			-- We need to move somewhere
			Grinder.currentProfile.nav.moveTo(dest, Grinder.currentDestIsNode)
			Grinder.currentProfile.nav.navigate()
			dest = nil
		end

		if FreeMoveTask.needTo then
			-- Log.debugLog("Using FreeMoveTask")
			FreeMoveTask.work()
			return true
		end
	end

	return false
end

function Grinder.fightCloseEnemys()
	local closestMob, closestMobDistance = Cache.getClosestMonster()
	if closestMob ~= nil and closestMobDistance < 350 then
		Grinder.currentTargetKey = closestMob:getActorKey()
		local alreadyInRange = MoveToAttackActorTask.work()

		-----RESETTING LOCAL VARS ---------

		if alreadyInRange then
			alreadyInRange = nil
			if not Grinder.settings.delay_battle_by_ms == 0 and Grinder.arrivedAtMobKey ~= Grinder.currentTargetKey then
				Grinder.arrivedAtMobKey = Grinder.currentTargetKey
				Grinder.wait(Grinder.settings.delay_battle_by_ms)
				Log.debugLog("Wait for " .. Grinder.settings.delay_battle_by_ms .. "ms because we arrived at the mob!")
				return true
			end

			-- Grinder.resetNav()
			-- Grinder.allInputUp()

			Grinder.lastTimeCombat = Cache.time

			local fighting = AttackActorTask.work()
			Log.debugLog("Finished attacking!")
		end
		alreadyInRange = nil
		return true
	end

	return false
end

function Grinder.returnMessage()
	Log.debugLog("Ending pulse!")
	MagLib.onPulse_End()
	return nil
end

function Grinder.resetNav()
	Log.debugLog("Resetings navs")
	Grinder.currentProfile.nav.stop()
	Player.stopMoving()
end

function Grinder.OnPacketReceive(byteBuffer)
	byteBuffer:skip(3)
	local opCode = byteBuffer:getShort()

	if OpCodes.getAckName(opCode) == "GetTradeShopItems" then
		NPCUtils:onGetTradeShopItems(GetTradeShopItems(byteBuffer))
	end
end
