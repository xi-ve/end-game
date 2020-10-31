QuickslotSkillAction = { }
QuickslotSkillAction.__index = QuickslotSkillAction

setmetatable(QuickslotSkillAction, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function QuickslotSkillAction.new(name, quickslot, endActions, skillIds, doneActionCallback, attackableRange)
  local self = setmetatable({}, QuickslotSkillAction)   
  
  self.Name = name
  self.Quickslot = quickslot

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

  self.PI = 3.14159265358979323846

  self:init()

  return self
end

function QuickslotSkillAction:init()
	for k,v in pairs(self.SkillIds) do
		if Skills.isLearned(v) then

			self.CurrentSkillId = v
			break
		end
	end

	if self.CurrentSkillId == nil then
		print("Could not find any learned skill for QuickslotSkillAction " .. self.Name)
		return
	end

	self.RequiredMP, self.RequiredStamina, self.ReuseCycle = Skills.getRequired(self.CurrentSkillId)
	self.IsUsableWhileOnCooldown = Skills.getIsUsableWhileInCoolTime(self.CurrentSkillId)
end

function QuickslotSkillAction:forceReuseCycle(value)
	self.ReuseCycle = value
	self.ForcedResuseCycle = true

	return self
end

function QuickslotSkillAction:canUse(target)
	if self.CurrentSkillId == nil then
		return false
	end

	if self.using then
		return false
	end

	if target:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > self.AttackableRange then
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

function QuickslotSkillAction:use(target, isAlrdyFaced)
	--print("Using " .. self.Name)

	local faceTo = true

	if isAlrdyFaced == nil then
		faceTo = false
	else
		faceTo = isAlrdyFaced == false
	end

	if faceTo then

		local rotFaceTarget = target:getPosition():getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
		local yawFaceTarget = rotFaceTarget - (2*self.PI)
			
		if string.format("%.1f", Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation()) ~= string.format("%.1f", rotFaceTarget) then        
        	Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)  
        	return false
    	end

    	if string.format("%.1f", Infinity.BDO.getCameraManager():getYaw()) ~= string.format("%.1f", yawFaceTarget) then        
        	Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
        	return false
    	end
	end

	Infinity.BDO.getUIManager():setIsCursorActive(false)	

	Infinity.BDO.Lua.Execute("quickSlot_UseSlot(" .. tostring(self.Quickslot) .. ")")

	self.using = true

	self.LastUse = Infinity.Win32.GetTickCount()

	print("Using QuickslotSkillAction " .. self.Name)
	
	return true	
end

function QuickslotSkillAction:isFinalAction(action)
	for k,v in pairs(self.EndActions) do
		if string.find(action, v) ~= nil then
			return true
		end
	end

	return false
end

function QuickslotSkillAction:onDoneAction()
	if self.DoneActionCallback == nil then
		print("No DoneActionCallback found!")
		return
	end
	
	self.DoneActionCallback(self)
end

function QuickslotSkillAction:onSelfActionChange(action)
	if not self.using then
		return
	end

	if not self:isFinalAction(action) then
		return
	end

	--Infinity.BDO.Input.PressKeys_Up(self.Keys)
	self.using = false	

	self:onDoneAction()

	--print("Action " .. self.Name .. " stopped!")
end