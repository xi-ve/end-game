local CM = {}

local lPlayer = MagLib.BDO.Actors.LocalPlayer
local getPPos = lPlayer.getPos
local getTime = MagLib.getTime
local combatReadjustMaxDistance = 500

CM.noDashWhenTpAllowed = false

CM.availableProfiles = {}
CM.availableProfileNames = {}

CM.refreshProfiles = function()
	local _ = nil
	CM.availableProfiles = {}
	CM.availableProfileNames = {}

	-- First add ones added in the scriptpath
	local paths = Infinity.FileSystem.GetAllFiles("CombatProfiles/")
	for _, path in ipairs(paths) do
		local profile = MagLib.BDO.Actions.Combat.Profile(path)
		table.insert(CM.availableProfiles, profile)
		table.insert(CM.availableProfileNames, profile.name)
	end
	-- Then add ones in DefaultProfiles
	paths = Infinity.FileSystem.GetAllFiles(MagLib.Constants.magLibFolderPath .. "/BDO/Actions/Combat/DefaultProfiles")
	for _, path in ipairs(paths) do
		local profile = MagLib.BDO.Actions.Combat.Profile(path)
		table.insert(CM.availableProfiles, profile)
		table.insert(CM.availableProfileNames, profile.name)
	end
end
MagLib.Events.addEventHandler("AfterInit_BDO", CM.refreshProfiles)

CM.loadProfile = function(index_or_name)
	local index
	if type(index) ~= "number" then
		index = table.find(CM.availableProfileNames, index_or_name)
	else
		index = index_or_name
	end

	if index == nil then
		MagLib.logger.error("Unknown Combatprofile name or nil index")
		return
	end
	local profile = CM.availableProfileNames[index]
	if not profile then
		MagLib.logger.error("No Combatprofile exists with the given index")
		return
	end
	CM.availableProfiles[index].load()
	CM.loadedProfileIndex = index
end

CM.unloadProfile = function()
	print("Unloading CombatProfile")
	CM.reset()
end
CM.loadedProfile = nil
CM.loadedProfileIndex = -1

CM.SkillTypes = {
	ST = 1,
	AOE = 2,
	Dash = 3,
	CombatDash = 4,
	Heal = 5,
	Buff = 6,
	AutoAttack = 7 -- DO NOT USE THIS ONE, it will automatically be used by CM. Don't add actual skills with this type, they will not be used.
}
CM.SkillType = CM.SkillTypes -- For convinience + legacy (since the s is actually not proper convention, but I used it everywhere now, also in combatprofiles etc.)
CM.Skills = {}
CM.lastSkillList = {}
CM.lastUsedSkillEntry = {}
CM.reset = function()
	CM.Skills = {
		[1] = {},
		[2] = {},
		[3] = {},
		[4] = {},
		[5] = {},
		[6] = {},
		autoAttackPriority = 0.4,
		autoAttackRange = 400,
		replenishWPWithBasics = false,
		replenishWPStartValue = 20,
		replenishWPEndValue = 150
	}
	CM.lastSkillList = {}
	CM.lastUsedSkillEntry = {}
	CM.loadedProfile = nil
	CM.loadedProfileIndex = -1
end
CM.reset()

local settings = {
	ST = {modifyPriorityBasedOnDamage = true}, -- Not yet considered
	AOE = {modifyPriorityBasedOnMobsHittable = true},
	wrongStancePrioMult = 0.6
}
MagLib.Core.Settings.addSettingsToHandler("MagLib_CombatManager", settings)

local stances = MagLib.BDO.Actions.Combat.SkillUseStances

--[[
extraData is different for exery skillType
validateExtraData fills it with default values if no value is set

ST => {range = 350}
]]
local defaultExtraData = {}
defaultExtraData.ST = {range = 350}
defaultExtraData.AOE = {range = 350, aoeRadius = 350, considerGroupMobCount = 3}

defaultExtraData.Dash = {dashDistance = 700}
defaultExtraData.CombatDash = {minDistance = 200, maxDistance = 500}
defaultExtraData.Heal = {
	healAmount = -1, -- Not yet considered
	prioMult_inCombat = 0.7,
	prioMult_noCombat = 1.3
}
defaultExtraData.Buff = {
	buffName = "", -- Not yet considered
	prioMult_inCombat = 0.7,
	prioMult_noCombat = 1.3
}

local copyTable = MagLib.Utils.Table.copy
local function validateExtraData(extraData, skillType)
	if skillType == CM.SkillTypes.ST then
		extraData = table.merge(copyTable(defaultExtraData.ST), extraData)
	elseif skillType == CM.SkillTypes.AOE then
		extraData = table.merge(copyTable(defaultExtraData.AOE), extraData)
	elseif skillType == CM.SkillTypes.Dash then
		extraData = table.merge(copyTable(defaultExtraData.Dash), extraData)
	elseif skillType == CM.SkillTypes.CombatDash then
		extraData = table.merge(copyTable(defaultExtraData.CombatDash), extraData)
	elseif skillType == CM.SkillTypes.Heal then
		extraData = table.merge(copyTable(defaultExtraData.Heal), extraData)
	elseif skillType == CM.SkillTypes.Buff then
		extraData = table.merge(copyTable(defaultExtraData.Buff), extraData)
	end

	return extraData
end

function CM.addSkill(skill, skillType, extraData, priority, priorityMultFunc)
	priority = priority or 1
	extraData = validateExtraData(extraData, skillType)
	table.insert(CM.Skills[skillType],
             	{skill = skill, extraData = extraData, priority = priority, priorityMultFunc = priorityMultFunc})
end

---
local pPos
CM.cTarget = nil
local cTargetPos
local distanceToTarget2D
local distanceToTarget
local inCombat
local currentStance

CM.comboTask = nil
CM.skillTask = nil
------------------------------SKILL SPECIFIC FUNCTIONS -----------------------------------------
--[[
  All *_checking functions add Skills with their priority to useableSkills, which in return gets emptied/reset in CM.combat and also handled there.
  All *_handling functions execute a Skill with custom handling for every type.
]]
--[[
  Base multiplier every skill of a type get to the set priority. The priority handling for every skill itself is free for the *_checking functions
  Those are ONLY for combat, onPulse gets an extra *_checking_noCombat function which uses priorityMultipliers_noCombat
]]
local priorityMultipliers = {[1] = 1, [2] = {AOE = 1.3, ST = 0.7}, [3] = 0.8, [4] = 1.0, [5] = 1.2, [6] = 0.7}

local priorityMultipliers_noCombat = {[1] = -1, [2] = -1, [3] = -1, [4] = -1, [5] = 1.3, [6] = 1}

local useableSkills = {}

-------ST----------
local function ST_checking()
	local prioMult = priorityMultipliers[CM.SkillTypes.ST]
	if not inCombat then
		prioMult = priorityMultipliers_noCombat[CM.SkillTypes.ST]
	end

	for _, skill in pairs(CM.Skills[CM.SkillTypes.ST]) do
		if skill.skill.canUse() and distanceToTarget < skill.extraData.range then
			local prio = skill.priority * prioMult

			if skill.priorityMultFunc then
				prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
			end
			local neededStance = skill.skill.neededStance
			if neededStance ~= stances.Both and neededStance ~= currentStance then
				prio = prio * settings.wrongStancePrioMult
			end

			table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.ST})
		end
	end
end

local function ST_handling(skill)
	skill.use(cTargetPos)
end
------AOE----------
local function AOE_checking()
	local prioMultTable = priorityMultipliers[CM.SkillTypes.AOE]
	if not inCombat then
		prioMultTable = priorityMultipliers_noCombat[CM.SkillTypes.AOE]
	end

	for _, skill in pairs(CM.Skills[CM.SkillTypes.AOE]) do
		if skill.skill.canUse() and distanceToTarget < skill.extraData.range then
			local mobsInAOERange = TargetHelper.getMonstersInRangeOfLocation(cTargetPos, skill.extraData.aoeRadius)
			local isAOE = (#mobsInAOERange >= skill.extraData.considerGroupMobCount)
			local prioMult
			if isAOE then
				prioMult = prioMultTable.AOE
				if settings.modifyPriorityBasedOnMobsHittable then
					prioMult = prioMult * (1 + (mobsInAOERange / 10))
				end
			else
				prioMult = prioMultTable.ST
			end

			local prio = skill.priority * prioMult
			if skill.priorityMultFunc then
				prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
			end
			local neededStance = skill.skill.neededStance
			if neededStance ~= stances.Both and neededStance ~= currentStance then
				prio = prio * settings.wrongStancePrioMult
			end
			table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.AOE})
		end
	end
end

local function AOE_handling(skill)
	skill.use(cTargetPos)
end

------Dash----------
local function Dash_checking()
	if not MagLib.BDO.Raycast.safeTwoPos(pPos, cTargetPos) then
		local prioMult = priorityMultipliers[CM.SkillTypes.Dash]
		if not inCombat then
			prioMult = priorityMultipliers_noCombat[CM.SkillTypes.Dash]
		end

		for _, skill in pairs(CM.Skills[CM.SkillTypes.Dash]) do
			if skill.skill.canUse() and distanceToTarget > skill.extraData.dashDistance then
				local prio = skill.priority * prioMult
				if skill.priorityMultFunc then
					prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
				end

				local neededStance = skill.skill.neededStance
				if neededStance ~= stances.Both and neededStance ~= currentStance then
					prio = prio * settings.wrongStancePrioMult
				end
				table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.Dash})
			end
		end
	end
end

local function Dash_handling(skill)
	skill.use(cTargetPos)
end

local function CombatDash_checking()
	if not MagLib.BDO.Raycast.safeTwoPos(pPos, cTargetPos) then
		local prioMult = priorityMultipliers[CM.SkillTypes.CombatDash]
		if not inCombat then
			prioMult = priorityMultipliers_noCombat[CM.SkillTypes.CombatDash]
		end

		for _, skill in pairs(CM.Skills[CM.SkillTypes.CombatDash]) do
			if skill.skill.canUse() and distanceToTarget > skill.extraData.minDistance and distanceToTarget >
				skill.extraData.maxDistance then
				local prio = skill.priority * prioMult
				if skill.priorityMultFunc then
					prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
				end
				local neededStance = skill.skill.neededStance
				if neededStance ~= stances.Both and neededStance ~= currentStance then
					prio = prio * settings.wrongStancePrioMult
				end
				table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.CombatDash})
			end
		end
	end
end

local function CombatDash_handling(skill)
	skill.use(cTargetPos)
end

local function Heal_checking()
	local healthPct = lPlayer.getHpPercentage()
	local prioMult = priorityMultipliers[CM.SkillTypes.Heal]
	if not inCombat then
		prioMult = priorityMultipliers_noCombat[CM.SkillTypes.Heal]
	end
	if healthPct > 65 then
		return
	end

	-- local missingHp = lPlayer.getMaxHp() - lPlayer.getHp()

	local prioMult_healthPct = 2 - (healthPct / 50)

	for _, skill in pairs(CM.Skills[CM.SkillTypes.Heal]) do
		if skill.skill.canUse() then
			local prioMult_extraDataIsCombat = skill.extraData.prioMult_inCombat
			if not inCombat then
				prioMult_extraDataIsCombat = skill.extraData.prioMult_noCombat
			end

			local prio = skill.priority * prioMult * prioMult_healthPct * prioMult_extraDataIsCombat
			if skill.priorityMultFunc then
				prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
			end

			local neededStance = skill.skill.neededStance
			if neededStance ~= stances.Both and neededStance ~= currentStance then
				prio = prio * settings.wrongStancePrioMult
			end
			table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.Heal})
		end
	end
end

local function Heal_handling(skill)
	if cTargetPos == nil then
		cTargetPos = getPPos()
	end
	skill.use(cTargetPos)
end

local function Buff_checking()
	local prioMult = priorityMultipliers[CM.SkillTypes.Buff]
	if not inCombat then
		prioMult = priorityMultipliers_noCombat[CM.SkillTypes.Buff]
	end

	for _, skill in pairs(CM.Skills[CM.SkillTypes.Buff]) do
		if skill.skill.canUse() then
			local prioMult_extraDataIsCombat = skill.extraData.prioMult_inCombat
			if not inCombat then
				prioMult_extraDataIsCombat = skill.extraData.prioMult_noCombat
			end

			local prio = skill.priority * prioMult * prioMult_extraDataIsCombat
			if skill.priorityMultFunc then
				prio = prio * skill.priorityMultFunc(inCombat, CM.cTarget)
			end

			local neededStance = skill.skill.neededStance
			if neededStance ~= stances.Both and neededStance ~= currentStance then
				prio = prio * settings.wrongStancePrioMult
			end
			table.insert(useableSkills, {skill = skill.skill, priority = prio, type = CM.SkillTypes.Buff})
		end
	end
end

local function Buff_handling(skill)
	if cTargetPos == nil then
		cTargetPos = getPPos()
	end
	skill.use(cTargetPos)
end

local function AutoAttack_checking()
	if distanceToTarget < CM.Skills.autoAttackRange then
		local prio = CM.Skills.autoAttackPriority
		table.insert(useableSkills, {skill = nil, priority = prio, type = CM.SkillTypes.AutoAttack})
	end
end

local function AutoAttack_handling()
	MagLib.BDO.Actions.Combat.doAutoAttack(cTargetPos)
end

------------------------------COMBAT HANDLING FUNCTIONS ----------------------------------------
CM.lastTargetSetTime = 0
CM.currentlyReplenishingWP = false

function CM.resetTarget()
	CM.cTarget = nil
end

---Attacks the given target if any skills can reach it.
---@param target The ActorData of the wanted target
---@return bool true if there was any useable skill that is in range and we started using it, false if we were not in range
function CM.combat(target)
	if CM.loadedProfile == nil then
		MagLib.logger.error("ERROR: Please load a CombatProfile before trying to fight!")
		return
	end

	-- Setting those local vars so we do not need to recalculate it every *_handling function
	pPos = getPPos()
	CM.cTarget = target
	cTargetPos = target:getPosition()
	distanceToTarget2D = pPos:getDistance2D(cTargetPos)
	distanceToTarget = pPos:getDistance(cTargetPos)
	inCombat = true
	currentStance = Infinity.BDO.getLocalPlayer():getCombatStance()

	CM.lastTargetSetTime = getTime()

	-- If there is currently still an action queued, we don't need to do anything, however we do want to set the vars like cTarget, cTargetPos etc. on top to ensure onPulse works properly upon a target switch.
	if MagLib.BDO.Actions.ActionSequenceManager.getCurrentActionSequence() ~= nil or
		MagLib.BDO.Actions.ActionSequenceManager.isActionSequenceQueued() then
		-- print("In Action sequence.")
		return true
	end

	if CM.Skills.replenishWPWithBasics and not CM.currentlyReplenishingWP and lPlayer.getMp() <
		CM.Skills.replenishWPStartValue then
		MagLib.logger.info("Recovering WP!")
		CM.currentlyReplenishingWP = true
	end

	if CM.currentlyReplenishingWP and lPlayer.getMp() > CM.Skills.replenishWPEndValue then
		MagLib.logger.info("Done recovering WP!")
		CM.currentlyReplenishingWP = false
	end

	-- Resetting useable Skills
	useableSkills = {}

	-- First we check for HP
	Heal_checking()
	if not CM.currentlyReplenishingWP then -- We only want to check all the other skills if we are not replenishing WP. We still want to consider healing spkills though.
		-- Then we check for buffs
		Buff_checking()
		-- Check if we could use a CombatDash
		CombatDash_checking()
		-- Check for normal Dash
		if not (CM.noDashWhenTpAllowed and MagLib.BDO.Navigation.Graph.Teleport.isTpAllowed()) then
			Dash_checking()
		end
		-- Check for AOE Skill
		AOE_checking()
		-- Check for ST Skills
		ST_checking()
	end
	-- AutoAttack
	AutoAttack_checking()

	local highestPrioSkill = nil
	for _, skill in pairs(useableSkills) do
		if not highestPrioSkill or (skill.priority > highestPrioSkill.priority) then
			highestPrioSkill = skill
		end
	end

	if highestPrioSkill ~= nil and highestPrioSkill.priority > 0 then
		-- print(tostring(highestPrioSkill.skill))
		local type = highestPrioSkill.type
		if type == CM.SkillTypes.ST then
			ST_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.AOE then
			AOE_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.Dash then
			Dash_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.CombatDash then
			CombatDash_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.Heal then
			Heal_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.Buff then
			Buff_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.AutoAttack then
			AutoAttack_handling()
		end

		CM.lastSkillList = useableSkills
		CM.lastUsedSkillEntry = highestPrioSkill
		return true
	end

	return false
end

function CM.onPulse(battleExpected)
	if CM.loadedProfile == nil then
		return
	end

	-- Setting crosshair target
	if CM.cTarget and CM.lastTargetSetTime + 75 > getTime() then
		if not CM.cTarget:isValid() then
			CM.cTarget = nil
		else
			Infinity.BDO.Selection.setNewAttackTarget(CM.cTarget:getActorKey())
		end
	end

	-- Handle current skill. The skill itself should be managed by the ActionSequenceManager queued by the skill, but we can check if the skill is still running here, in which case we don't want to todo anything
	-- TODO: handle current skill

	-- If we are currently in a skill, we do not do anything anymore
	if MagLib.BDO.Actions.ActionSequenceManager.getCurrentActionSequence() ~= nil then
		return
	end

	inCombat = battleExpected

	-- First we check for HP
	Heal_checking()
	-- Then we check for buffs
	Buff_checking()

	local highestPrioSkill = nil
	for _, skill in pairs(useableSkills) do
		if not highestPrioSkill or (skill.priority > highestPrioSkill.priority) then
			highestPrioSkill = skill
		end
	end

	if highestPrioSkill ~= nil and highestPrioSkill.priority > 0 then
		local type = highestPrioSkill.type
		if type == CM.SkillTypes.Heal then
			Heal_handling(highestPrioSkill.skill)
		elseif type == CM.SkillTypes.Buff then
			Buff_handling(highestPrioSkill.skill)
		end

		CM.lastSkillList = useableSkills
		CM.lastUsedSkillEntry = highestPrioSkill
	end

	-- table.print(CM.loadedProfile)
	CM.loadedProfile:onPulse()
end

function CM.onMoveTo(dest, isOverNodes, isEndDest)
	if CM.loadedProfile then
		CM.loadedProfile:onMoveTo(dest, isOverNodes, isEndDest)
	end
end

-- setting MagLib.BDO.Actions.Combat.CombatManager
MagLib.BDO.Actions.Combat.CombatManager = CM
