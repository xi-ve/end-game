--- Skill class
-- @module MagLib.BDO.Actions.Combat.Skill
-- @alias Skill
local indexCounter = 0

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
local getTime = MagLib.getTime
local Table = MagLib.Utils.Table

--[[
Test Code:
local actionSeq = MagLib.BDO.Actions.ActionSequence("BT_ARO_Skill_Backstab_Swing_B_1Lv_Start", "BT_ARO_Skill_Backstab_Swing_B_1Lv", 2000, 1250)
actionSeq.onFinishCallback = function()
   print("Finished the action sequence and we could set some shit here to signal whatever we want to signal")
end
local skill = MagLib.BDO.Actions.Combat.Skill("One Step Back", {2023}, MagLib.BDO.Actions.Combat.SkillUseStances.Awakening, actionSeq)
skill.use(MagLib.BDO.Actors.LocalPlayer.getPos())
]]

---Constructor
---@param name Name of the skill for display and log purpose.
---@param skillIds table with all of the skill ids of the respective skill.
---@param neededStance Stance variable of stance in which it is possible to use the skill.
-- @see MagLib.BDO.Actions.Combat.SkillUseStances
---@param actionSequence ActionSequence that executes the Skill.
-- @see MagLib.BDO.Actions.ActionSequence
-- @function this
MagLib.BDO.Actions.Combat.Skill = function(name, skillIds, neededStance, actionSequence)
	indexCounter = indexCounter + 1
	local Skill = {
		index = indexCounter,
		name = name,
		skillIds = skillIds,
		lastUsed = 0,
		neededStance = neededStance,
		actionSequence = actionSequence,
		forcedCooldownMs = nil,
		highestLearnedId = nil,
		requiredMP = -1,
		requiredStamina = -1
	}

	---If set to a function, this function will be called and is expected to return true or false based on if the skill is useable or not.
	-- It replaces the normal .canUse logic. Do NOT override .canUse. .canUse() will call .customCanUse()
	Skill.customCanUse = nil

	---If set to a function, this function will be called and is expected to return true if the skill was successfully used or false if the skill was not executed (but stuff like player rotation, etc. was changed for preparation). It replaces the normal .use logic. Do NOT override .use. .use() calls .customUse().
	Skill.customUse = nil

	-- Determining the highest learned skill id and setting it.
	if skillIds then
		for k, v in ipairs(skillIds) do
			if Skills.isLearned(v) then
				Skill.highestLearnedId = v
			end
		end
	end

	if Skill.highestLearnedId == nil then
		print("You have not learned " .. name .. " yet. It will not be used!")
	end

	if Skill.highestLearnedId then
		Skill.requiredMP, Skill.requiredStamina = Skills.getRequired(Skill.highestLearnedId)
	else
		Skill.requiredMP, Skill.requiredStamina = 0, 0
	end
	-- print("Name: " .. Skill.name)
	-- print("Needed MP: " .. Skill.requiredMP .. " | Stamina: " .. Skill.requiredStamina)

	if Skill.neededStance == nil then
		Skill.neededStance = MagLib.BDO.Actions.Combat.SkillUseStances.Both
	end

	---Forces cooldown to be consideres as a specific ms time, rather than using the ingame cooldown.
	---@param ms Minimum time in ms between skill usages
	Skill.forceCooldown = function(ms)
		Skill.forcedCooldownMs = ms
	end

	---Checks if the skill is on cooldown. Consideres values set by forceCooldown(ms)
	-- @return bool: true if the skill is on cooldown, else false
	-- @see MagLib.BDO.Actions.Combat.Skill.forceCooldown
	Skill.isOnCooldown = function()
		if Skill.forcedCooldownMs then
			if Skill.lastUsed + Skill.forcedCooldownMs > getTime() then
				-- print("Forced CD")
				return true
			else
				return false
			end
		end

		local cooldown = 0
		if Skill.skillIds then
			for _, v in ipairs(Skill.skillIds) do
				local sCD = Infinity.BDO.Lua.Execute("return ToClient_getSkillCooltimebySkillNo(" .. v .. ")")
				if sCD and sCD > cooldown then
					cooldown = sCD
				end
			end
		end

		if cooldown and cooldown > 0 then
			return true
		end

		return false
	end

	---Checks if the skill is useable. Checks cooldown, mp and stamina. Alternatively calls Skill.customCanUse if set.
	-- @return bool: true if useable, else false.
	-- @see MagLib.BDO.Actions.Combat.Skill.customCanUse
	Skill.canUse = function()
		-- print("Skill name: " .. Skill.name)
		if Skill.highestLearnedId == nil then
			-- print("Not learned")
			return false
		end

		if Skill.customCanUse then
			-- print("Custom canUse")
			return Skill.customCanUse()
		end

		if Skill.isOnCooldown() then
			--  print("Is on cd")
			return false
		end

		if MagLib.BDO.Actors.LocalPlayer.getMp() < Skill.requiredMP then
			-- print("Not enough MP")
			return false
		end

		if MagLib.BDO.Actors.LocalPlayer.getStamina() < Skill.requiredStamina then
			-- print("Not enough Staminga")
			return false
		end

		-- print("Useable")
		return true
	end

	local stances = MagLib.BDO.Actions.Combat.SkillUseStances
	---Uses the skill
	-- Adjusts player rotation, camera position, switches in the right stance and then queues the ActionSequence in the ActionSequenceManager.
	-- Needs to be called several times over several pulses to allow fo the needed changes in rotation, position and stance to finish.
	-- Will call Skill.customUse() if set rather than it's own logic.
	-- @see MagLib.BDO.Actions.Combat.Skill.customUse
	---@param position Vector3 of the position towards the skill should be used.
	-- @return bool: false if the skill was not used, but something for the skill use preparation was done. true when the skill was used.
	Skill.use = function(position)

		-- Handle customUse function. If a custom use returns false ls second parameter, that means to continue the normal use function.
		if Skill.customUse then
			local returnValue, shouldReturn = Skill.customUse()
			if shouldReturn then
				return returnValue
			end
		end

		local changedSth = false -- indicates a camera or player rotation change
		-- Facing the target
		if not MagLib.BDO.Actors.LocalPlayer.faceTowards(position) then
			-- print("Rotation was corrected!")
			changedSth = true
		end
		-- Setting camera
		if not MagLib.BDO.Camera.setCamera(position) then
			-- print("Camera was corrected!")
			changedSth = true
		end

		if changedSth then
			return false -- We return since we changed something
		end

		if Skill.neededStance ~= stances.Both and Skill.neededStance ~= Infinity.BDO.getLocalPlayer():getCombatStance() then
			MagLib.logger.info("Switching Stance to use skill " .. Skill.name)
			MagLib.BDO.Actors.LocalPlayer.switchToStance(Skill.neededStance)
			return false -- We have not used the skill yet
		else
			MagLib.logger.info("Using skill " .. Skill.name)
			MagLib.BDO.Actions.ActionSequenceManager.queueActionSequence(Skill.actionSequence)
			Skill.lastUsed = getTime()
		end

		return true -- We used the skill
	end

	return Skill
end
