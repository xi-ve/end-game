MagLib.BDO.Events.ExpChanged = {}
local activated = false
MagLib.BDO.Events.ExpChanged.activate = function()
	if activated then
		return
	else
		activated = true
	end

	-- Dependencies
	MagLib.BDO.Events.CharacterChanged.activate()

	-- Lifeskill exp variables
	local lifeskillExperience = {}
	local setLifeskillExperienceData = function(craftType, level, exp, maxExp, pct)
		lifeskillExperience[craftType] = {level = level, exp = exp, maxExp = maxExp, pct = pct}
	end

	local resetAllLifeskillExperienceData = function(craftType)
		local level = MagLib.BDO.Actors.LocalPlayer.getCraftLevel(craftType)
		local exp = MagLib.BDO.Actors.LocalPlayer.getCraftExp(craftType)
		local maxExp = MagLib.BDO.Actors.LocalPlayer.getCraftMaxExp(craftType)
		local pct = MagLib.BDO.Actors.LocalPlayer.getCraftExpPercent(craftType)
		setLifeskillExperienceData(craftType, level, exp, maxExp, pct)
	end

	-- Player exp variables
	-- TODO:

	-- init
	local init = function()
		for _, craftType in pairs(MagLib.BDO.Enums.CraftType) do
			resetAllLifeskillExperienceData(craftType)
		end
	end
	init()

	-- Event callbacks
	MagLib.Events.addEventHandler("CharacterChanged", init) -- Resetting if we changed char

	-- Module
	local module = MagLib.Run.Modules.RunModule("Exp Observer", 50, 100, MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                            	MagLib.Run.EPulseTimingMode.Beginning)

	module.run = function()
		-- Checking all lifeskill exps
		for _, craftType in pairs(MagLib.BDO.Enums.CraftType) do
			local savedValues = lifeskillExperience[craftType]
			local exp = MagLib.BDO.Actors.LocalPlayer.getCraftExp(craftType)
			if exp ~= savedValues.exp then
				-- Exp changed
				local level = MagLib.BDO.Actors.LocalPlayer.getCraftLevel(craftType)
				local maxExp = MagLib.BDO.Actors.LocalPlayer.getCraftMaxExp(craftType)
				local pct = MagLib.BDO.Actors.LocalPlayer.getCraftExpPercent(craftType)

				-- Checking that we do not have weird exp changed
				if level < savedValues.level or (level == savedValues.level and exp < savedValues.exp) then
					MagLib.logger.warning("Lifeskill Level changed unexpectedly. Resetting...")
					init()
				end

				-- Calculting exp changed
				local levelIncreased = (level > savedValues.level)
				local expChanged
				if levelIncreased then
					local diffToLevelUp = savedValues.maxExp - savedValues.exp
					expChanged = diffToLevelUp + exp
				else
					expChanged = exp - savedValues.exp
				end

				-- Triggering change event
				MagLib.Events.triggerEvent("LifeSkillExpChanged", {
					craftType = craftType,
					oldLevel = savedValues.level,
					newLevel = level,
					oldExp = savedValues.exp,
					newExp = exp,
					oldMaxExp = savedValues.maxExp,
					newMaxExp = maxExp,
					oldPct = savedValues.pct,
					newPct = pct,
					expChanged = expChanged
				})

				-- Updating to new values
				setLifeskillExperienceData(craftType, level, exp, maxExp, pct)
			end
		end

		-- Checking player exp
		-- TODO:
	end

	module.start()
	MagLib.Run.Modules.Handler.addModule(module)
end
