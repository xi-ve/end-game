SkillAction = { }
SkillAction.__index = SkillAction

setmetatable(SkillAction, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SkillAction.new(name, keys, endActions, skillIds, doneActionCallback, attackableRange, isQuickSlot)
  local self = setmetatable({}, SkillAction)   
  
  self.Name = name
  self.Keys = keys

  self.isQuickSlot = false
  self.Quickslot = nil

  if isQuickSlot == nil then
  	self.isQuickSlot = false
  else
  	self.isQuickSlot = isQuickSlot
  end

  self.EndActions = endActions

  self.SkillIds = skillIds

  self.CurrentSkillId = nil
  self.RequiredMP = -1
  self.RequiredStamina = -1
  self.ReuseCycle = -1
  self.ForcedResuseCycle = false

  self.IsUsableWhileOnCooldown = false
  self.UseWhileOnCooldown = false

  self.DoneActionCallback = doneActionCallback

  self.AttackableRange = attackableRange

  self.using = false
  self.LastUse = 0

  self.ExpirationTimeMS = 2000

  self.PI = 3.14159265358979323846

  self:init()

  return self
end

function SkillAction:init()
	for k,v in pairs(self.SkillIds) do
		if Skills.isLearned(v) then

			self.CurrentSkillId = v
			break
		end
	end

	if self.CurrentSkillId == nil then
		print("Could not find any learned skill for SkillAction " .. self.Name)
		return
	end

	if self.isQuickSlot then
		self.Quickslot = self.Keys
	end

	self.RequiredMP, self.RequiredStamina, self.ReuseCycle = Skills.getRequired(self.CurrentSkillId)
	self.IsUsableWhileOnCooldown = Skills.getIsUsableWhileInCoolTime(self.CurrentSkillId)
end

function SkillAction:forceReuseCycle(value)
	self.ReuseCycle = value
	self.ForcedResuseCycle = true

	return self
end

function SkillAction:useWhileOnCooldown()
	self.UseWhileOnCooldown = true

	return self
end

function SkillAction:overrideExpirationTime(timeInMS)
	self.ExpirationTimeMS = timeInMS

	return self
end

function SkillAction:canUse(target)
	if self.CurrentSkillId == nil then
		return false
	end

	if self.using then
		return false
	end

	if target ~= nil and target:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > self.AttackableRange then
		return false
	end

	if LocalPlayer.getMp() < self.RequiredMP then
		return false
	end

	if LocalPlayer.getStamina() < self.RequiredStamina then
		return false
	end

	if self.UseWhileOnCooldown and self.IsUsableWhileOnCooldown then

		if self.ForcedResuseCycle then

			if self.LastUse + self.ReuseCycle > Infinity.Win32.GetTickCount() then
				return false
			end
		else
			return true
		end		
	else
		
		if self.LastUse + self.ReuseCycle > Infinity.Win32.GetTickCount() then
			return false
		end
	end	

	return true
end

function SkillAction:faceTarget(targetPos)
	local rotFaceTarget = targetPos:getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
	local yawFaceTarget = rotFaceTarget - (2*self.PI)
	local pitchFaceTarget = -0.8

	if string.format("%.1f", Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()) ~= string.format("%.1f", rotFaceTarget) then 

		Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget) 
    end

    if string.format("%.1f", Infinity.BDO.getCameraManager():getYaw()) ~= string.format("%.1f", yawFaceTarget) then 

    	Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
    end

    if string.format("%.1f", Infinity.BDO.getCameraManager():getPitch()) ~= string.format("%.1f", pitchFaceTarget) then 

    	Infinity.BDO.getCameraManager():setPitch(pitchFaceTarget)
    end

    return true
end

function SkillAction:useNormalInput()
	Infinity.BDO.getUIManager():setIsCursorActive(false)	

	Infinity.BDO.Input.clearQueue()

	Infinity.BDO.Input.PressKeys_Down(self.Keys)
end

function SkillAction:useQuickSlotInput()
	Infinity.BDO.Lua.Execute("quickSlot_UseSlot(" .. tostring(self.Quickslot) .. ")")
end

function SkillAction:use(target, targetPosOverride)
	
	if targetPosOverride ~= nil then

		if not self:faceTarget(targetPosOverride) then
			return false
		end
	else

		if not self:faceTarget(target:getPosition()) then
			return false
		end
	end
	
	if not self.isQuickSlot then
		self:useNormalInput()
	else
		self:useQuickSlotInput()
	end

	self.using = true

	self.LastUse = Infinity.Win32.GetTickCount()
	
	print("Using " .. self.Name)
	
	return true	
end

function SkillAction:isFinalAction(action)
	for k,v in pairs(self.EndActions) do
		if string.find(action, v) ~= nil then
			return true
		end
	end

	return false
end

function SkillAction:isExpired()
	return self.LastUse + self.ExpirationTimeMS <= Infinity.Win32.GetTickCount()
end

function SkillAction:onDoneAction()
	if self.DoneActionCallback == nil then
		print("No DoneActionCallback found!")
		return
	end

	Infinity.BDO.Input.clearQueue()

	self.DoneActionCallback(self)
end

function SkillAction:onSelfActionChange(action)
	if not self.using then
		return
	end
	
	if self:isFinalAction(action) then
		
		self.using = false	
		self:onDoneAction()
	end

	if self:isExpired() then

		self.using = false	
		self:onDoneAction()
	end
end