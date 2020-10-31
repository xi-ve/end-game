---Allows fully automated target choosing and attacking while maintaining prefered end location.
-- @module MagLib.BDO.Actions.Combat.CombatManagerModule
-- @alias CombatManagerModule
CombatManagerModule = {}
local module = MagLib.Run.Modules.RunModule("CombatManagerModule", 1, 1, MagLib.Run.Modules.TimingMode.Exact,
                                            MagLib.Run.EPulseTimingMode.Beginning)
-- Having the module disabled as default
module:stop()
MagLib.Run.Modules.Handler.addModule(module)

-- Settings
local settings = {mobNoDamageTimeout = 2000}
MagLib.Core.Settings.addSettingsToHandler("MagLib_CombatManagerModule", settings)

-- Help functions
local getTime = MagLib.getTime

-- Target variables
CombatManagerModule.currentTarget = nil
local currentTargetHpStat = {actorKey = nil, hp = nil, time = nil}

-- Checks if a target is valid, meaning:
-- The actor is valid 
-- The actor is not dead.
-- The actor's hp changed in mobNoDamageTimeout ms

local isCurrentTargetValid = function()
	local currentTarget = CombatManagerModule.currentTarget
	if currentTarget == nil or not MagLib.BDO.Actors.isValidActor(currentTarget) or currentTarget:getIsDead() or
		currentTarget:getHp() <= 0.1 then
		-- target none existing or dead 
		currentTargetHpStat = {actorKey = nil, hp = nil, time = nil}
		return false
	end

	-- We have a target
	local currentTargetActorKey = currentTarget:getActorKey()
	local currentTargetHp = currentTarget:getHp()
	local currentTime = getTime()
	if currentTarget.actorKey ~= currentTargetActorKey or currentTargetHpStat.hp ~= currentTargetHp then
		-- It is a different target than before or the hp changed, updating data and target is valid
		currentTargetHpStat = {actorKey = currentTargetActorKey, hp = currentTargetHp, time = currentTime}
		return true
	else
		-- It is the same target and hp is the same
		local timeDiff = currentTime - currentTargetHpStat
		if timeDiff >= settings.mobNoDamageTimeout then
			-- Mob has gotten no damage for mobNoDamageTimeout ms
			currentTargetHpStat = {actorKey = nil, hp = nil, time = nil}
			return false
		else
			return true
		end
	end
end

module.run = function()
	-- Checking if old target is existing/dead/despawned/invalid
	if not isCurrentTargetValid() then
		-- None valid or dead target, resetting it
		CombatManagerModule.currentTarget = nil
	end
	-- Selecting a target if no target is set
	if CombatManagerModule.currentTarget == nil then
		CombatManagerModule.currentTarget = MagLib.BDO.Actions.Combat.TargetSelector.selectTarget()
	end
	-- Attack target

	if CombatManagerModule.currentTarget then
		-- Ensure Navigation is paused
		MagLib.BDO.Navigation.pause()
		local fought = MagLib.BDO.Actions.Combat.CombatManager.combat(CombatManagerModule.currentTarget)
		if not fought then
			-- We move closer and call onPulse
			MagLib.BDO.Actors.LocalPlayer.moveTo(CombatManagerModule.currentTarget:getPosition())
			MagLib.BDO.Actions.Combat.CombatManager.onPulse(true)
		else
			-- Stop moving so skills are properly executed
			MagLib.BDO.Actors.LocalPlayer.stopMoving()
		end
	else
		-- No target, unpausing navigation
		MagLib.BDO.Navigation.unpause()
		MagLib.BDO.Actions.Combat.CombatManager.onPulse(false)
	end

end

---Activates the CombatManagerModule, allowing it to take control.
CombatManagerModule.activate = function()
	module:start()
end

---Deactivates the CombatManagerModule
CombatManagerModule.deactivate = function()
	MagLib.BDO.Navigation.unpause()
	module:stop()
end

MagLib.BDO.Actions.Combat.CombatManagerModule = CombatManagerModule
