AttackActorTask = {}
AttackActorTask.targetActorDamagedTime = nil
AttackActorTask.currentTargetActor = nil
AttackActorTask.currentTargetHealth = 1 / 0
AttackActorTask.lastFoughtTime = 0
AttackActorTask.useRageTime = 0

function AttackActorTask.work()
	Log.debugLog("AttackActorTask work")
	if AttackActorTask.lastFoughtTime + 48 < Cache.time then
		if Grinder.currentTargetKey == nil then
			return false
		end

		local targetActor = ActorUtils.getActor(Grinder.currentTargetKey)
		if targetActor == nil or not ActorUtils.isValidActor(targetActor) then
			return false
		end

		local currentTargetActor = ActorUtils.getActor(Grinder.currentTargetKey)
		if (not currentTargetActor) or (not ActorUtils.isValidActor(currentTargetActor)) then
			Grinder.currentTargetKey = nil

			currentTargetActor = nil
			targetActor = nil
			return false
		end

		if Grinder.currentTargetKey ~= AttackActorTask.currentTargetActor then
			Grinder.allInputUp()
			AttackActorTask.currentTargetActor = Grinder.currentTargetKey
			AttackActorTask.targetActorDamagedTime = Cache.time
			AttackActorTask.currentTargetHealth = TargetHelper.getHp(currentTargetActor)
			-- Log.log("Attacking mob with Grinder.currentTargetKey: ".. AttackActorTask.currentTargetActor)
		end

		if TargetHelper.getHp(currentTargetActor) < AttackActorTask.currentTargetHealth then
			-- Log.log("Damaged actor!")
			AttackActorTask.targetActorDamagedTime = Cache.time
			AttackActorTask.currentTargetHealth = TargetHelper.getHp(currentTargetActor)
		end

		local timeoutTime = Grinder.settings.timeoutTimeAttackMobsNoDamage
		local actorId = targetActor:getActorId()
		if actorId == 27175 or actorId == 25108 then
			timeoutTime = 10000
		end

		if AttackActorTask.targetActorDamagedTime + timeoutTime < Cache.time then
			if Grinder.settings.log_verbose then
				Log.log(string.format("%d took no damage for ~ " .. timeoutTime .. "ms ... Ignoring for ~15s",
                      				Grinder.currentTargetKey))
			end
			if not Grinder.mobBlacklist then
				Grinder.mobBlacklist = {}
			end
			Grinder.mobBlacklist[Grinder.currentTargetKey] = Cache.time + timeoutTime
			Grinder.currentTargetKey = nil
			Grinder.currentDest = nil

			targetActor = nil
			currentTargetActor = nil
			return false
		end

		if Grinder.currentCombatScript and type(Grinder.currentCombatScript.combat) == "function" then
			-- Log.log("Doing combat")
			if AttackActorTask.useRageTime + 1500 > Cache.time then
				return true
			end

			if Grinder.settings.use_rage_buff and AttackActorTask.useRageTime + 5289 < Cache.time and Infinity.BDO.Lua.Execute(
				"return (getSelfPlayer():getAdrenalin() > 9999.00000 and getSelfPlayer():isUseableBlackSpritSkill())") then
				if Grinder.settings.log_verbose then
					Log.log("Using rage buff!")
				end
				AttackActorTask.useRageTime = Cache.time
				if Grinder.settings.use_keyflag then
					Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
					Infinity.BDO.Input.setKeyInputFlagValue(0x200)
					Grinder.onSkillUse(0x200)
				else
					Input.pressOnce({KeyCode_Z}, 150)
				end
				Grinder.wait(1500)

				targetActor = nil
				currentTargetActor = nil
				return true
			end

			-- targetActor = ActorUtils.getActor(Grinder.currentTargetKey) ?? Not needed I think
			if (not targetActor) or (not ActorUtils.isValidActor(targetActor)) then
				targetActor = nil
				currentTargetActor = nil
				return true
			end

			Log.debugLog("Combat script :combat calling")
			Grinder.currentCombatScript:combat(Grinder.currentTargetKey)
			AttackActorTask.lastFoughtTime = Cache.time
			-- Input.waitForReset() --Unsure why we do this

			targetActor = nil
			currentTargetActor = nil

			return true
		else
			Log.log("ERROR: No combat script usable!")

			targetActor = nil
			currentTargetActor = nil

			return false
		end
	end
end
