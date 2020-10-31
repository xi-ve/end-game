AutoAttack = {}
AutoAttack.PI = 3.14159265358979323846

function AutoAttack.doAutoAttack(target)
	Log.debugLog("Autoattack doAutoAttack")

	if not AutoAttack.faceTarget(target:getPosition()) then
		-- print("Could not face target. Waiting for next pulse!")
		Grinder.wait(50)
		return false
	end

	if Grinder.settings.use_keyflag then
		Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
		Infinity.BDO.Input.setKeyInputFlagValue(0x40000)
		Grinder.onSkillUse(0x40000)
	else
		if not Infinity.BDO.getUIManager():getIsCursorActive() then
			Infinity.BDO.getUIManager():setIsCursorActive(false)
		end
		Input.pressOnce({KeyCode_LBUTTON}, 250)

	end

	Grinder.wait(Grinder.settings.skillUse_delay)
	AutoAttack.lastAttackTime = Cache.time
end

local function round(num, numDecimalPlaces)
	local mult = 10 ^ numDecimalPlaces
	return math.floor(num * mult + 0.5) / mult
end

local function roundUp(num)
	return math.floor(num) + 1
end

local function floatDif(num1, num2, decimalNum)
	decimalNum = decimalNum or 5
	return math.abs(round(num1, decimalNum) - round(num2, decimalNum))
end

local function normalizeYaw(yaw)
	local PI = 3.14159265358979323846
	while (yaw > PI) do
		yaw = -PI + (yaw - PI)
	end

	while (yaw < (-PI)) do
		yaw = PI + (yaw + PI)
	end

	return yaw
end

function AutoAttack.faceTarget(targetPos)
	local rotFaceTarget = targetPos:getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
	local yawFaceTarget = normalizeYaw(rotFaceTarget - (2 * AutoAttack.PI))
	local pitchFaceTarget = -0.8

	if floatDif(Infinity.BDO.getCameraManager():getPitch(), pitchFaceTarget, 3) > 0.2 then
		Infinity.BDO.getCameraManager():setPitch(pitchFaceTarget)
	end
	if floatDif(Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation(), rotFaceTarget, 3) >
		0.2 then
		Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
	end

	if floatDif(Infinity.BDO.getCameraManager():getYaw(), yawFaceTarget, 3) > 0.2 then
		if Player.ignoreCameraUntil < Cache.time then
			Player.setCamera(targetPos, 4)
			if Grinder.settings.camera_real_swing then
				return false
			end
		else
			Infinity.BDO:getCameraManager():setYaw(rotFaceTarget - (2 * AutoAttack.PI))
		end
	end
	return true
end
