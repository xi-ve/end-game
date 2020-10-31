local LP = {}

function LP.get()
	return Infinity.BDO.getLocalPlayer()
end
local me = LP.get
LP.me = LP.get

function LP.getPosition()
	return LP.get():getPosition()
end
local getPPos = LP.getPosition
LP.getPos = LP.getPosition

function LP.stopMoving()
	me():getMovementControler():setIsMoving(false)
end

function LP.moveTo(dest)
	local movementControler = me():getMovementControler()
	movementControler:setDestination(dest)
	movementControler:setOrigin(getPPos())
	movementControler:setIsMoving(true)
end

LP.getHp = LocalPlayer.getHp
LP.getMaxHp = function()
	local code = [[
  		local selfPlayer = (getSelfPlayer()):get()
  		return selfPlayer:getMaxHp()
	]]

	return Infinity.BDO.Lua.Execute(code)
end
LP.getHpPercentage = LocalPlayer.getHpPercentage
LP.getMp = LocalPlayer.getMp
LP.getStamina = LocalPlayer.getStamina

function LP.isDead()
	return LP.get():getIsDead() or LP.getHp() <= 0
end

function LP.faceTowards(position)
	local rotFaceTarget = position:getRotationToFace(getPPos())
	local curRot = Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()
	if not MagLib.Utils.Math.compareFloats(rotFaceTarget, curRot, 1) then
		Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
		return false
	end
	return true
end

function LP.getLevel()
	return me():getLevel()
end

function LP.getAnimation()
	return Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()
end

function LP.switchToStance(wantedStance)
	local currentStance = Infinity.BDO.getLocalPlayer():getCombatStance()

	-- print("wanted stance: " .. tostring(wantedStance))
	if currentStance ~= wantedStance then
		local buttonToPress
		if wantedStance == 2 then
			-- Wanting Awakening and currently not in awakening
			buttonToPress = KeyCode_C
		elseif wantedStance == 1 then
			if currentStance == 0 then
				buttonToPress = KeyCode_TAB
			else
				buttonToPress = KeyCode_C
			end
		elseif wantedStance == 0 then
			buttonToPress = KeyCode_TAB
		end
		-- print("Stance change key " .. tostring(buttonToPress))
		-- ActionSeq that uses key input to switch
		local swapActionSeq = MagLib.BDO.Actions.ActionSequence("StanceSwap", {
			"STANCE_CHANGE_ARO2", "STANCE_CHANGE_MAINWEAPON2", "STANCE_CHANGE_BASIC", "STANCE_CHANGE_ARO_BASIC"
		}, 1000, 150)
		swapActionSeq.keys = {KeyCode_W, buttonToPress}
		MagLib.BDO.Actions.ActionSequenceManager.queueActionSequence(swapActionSeq)

		-- returning false since we are not in the right stance
		return false
	end

	return true
end

function LP.isMagicServantSummoned()
	local code = [[
  local summonCount = getSelfPlayer():getSummonListCount()
  local keys = {}
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    if characterKey == 60135 or characterKey == 60136 then
      return true
    end
  end

  return false

]]

	return Infinity.BDO.Lua.Execute(code)
end

function LP.isFireServantSummoned()
	local code = [[
  local summonCount = getSelfPlayer():getSummonListCount()
  local keys = {}
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    if characterKey == 60136 then
      return true
    end
  end

  return false

]]

	return Infinity.BDO.Lua.Execute(code)
end

function LP.isWaterServantSummoned()
	local code = [[
  local summonCount = getSelfPlayer():getSummonListCount()
  local keys = {}
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    if characterKey == 60135 then
      return true
    end
  end

  return false

]]

	return Infinity.BDO.Lua.Execute(code)
end

function LP.getCraftLevel(craftType)
	return Infinity.BDO.Lua.Execute("return getSelfPlayer():get():getLifeExperienceLevel(" .. craftType .. ")")
end

function LP.getCraftExp(craftType)
	local code = "return Int64toInt32(getSelfPlayer():get():getCurrLifeExperiencePoint(" .. craftType .. "))"

	return Infinity.BDO.Lua.Execute(code)
end

function LP.getCraftMaxExp(craftType)
	local code = "return Int64toInt32(getSelfPlayer():get():getDemandLifeExperiencePoint(" .. craftType .. "))"

	return Infinity.BDO.Lua.Execute(code)
end

function LP.getCraftExpPercent(craftType)
	local exp = LP.getCraftExp(craftType)
	local maxExp = LP.getCraftMaxExp(craftType)
	if maxExp == nil then
		MagLib.logger.error("LocalPlayer.getCraftExpPercent -> maxExp is nil")
		return 0
	elseif exp == nil then
		MagLib.logger.error("LocalPlayer.getCraftExpPercent -> exp is nil")
		return 0
	end
	return exp / maxExp * 100
end

function LP.getEnergy()
	return tonumber(Infinity.BDO.Lua.Execute([[return getSelfPlayer():getWp()]])) or 0
end

function LP.getMaxEnergy()
	return tonumber(Infinity.BDO.Lua.Execute([[return getSelfPlayer():getMaxWp()]])) or 0
end

MagLib.BDO.Actors.LocalPlayer = LP
