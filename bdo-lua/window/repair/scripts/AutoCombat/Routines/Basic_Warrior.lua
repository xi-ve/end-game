CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Basic Warrior"

setmetatable(CombatRoutine, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CombatRoutine.new()
  	local self = setmetatable({}, CombatRoutine)   
  
  	self.SkillActions = 
  	{
  		-- SkillAction(name, keys, endActions, skillIds, doneActionCallback, attackableRange)
  		-- name = custom name of the skillAction
  		-- keys = keycodes of keys to be pressed to init the skillAction
  		-- endActions = name or partial names of the actions when the skillAction should stop
  		-- skillIds = skillIds of every level of the skill (check K skilltree to get the skillIds, start from highest to lowest)
  		-- doneActionCallback = is handled automatically so just set it to nil
  		-- attackableRange = max attack range of the skillAction
  		--
  		-- :forceReuseCycle(5000) = set forced cooldown to 5000ms

  		Regen =
  		{
  			SkillAction("Slash", {KeyCode_LBUTTON}, {"ATTACK_C2", "WAIT"}, {2831, 113, 112, 111, 110, 109, 108, 1331, 1213, 1212, 1018}, nil, 300),
  		},  		  		

  		AoE =
  		{
  			SkillAction("Ground Roar", {KeyCode_SHIFT, KeyCode_RBUTTON}, {"BT_skill_GroundEcho", "WAIT"}, {2851, 219, 218, 217, 216}, nil, 800):forceReuseCycle(5000),
  			--SkillAction("Spinning Slash", {KeyCode_S, KeyCode_RBUTTON}, {"BT_skill_RotationBash", "WAIT"}, {1129, 1128, 1127, 1021}, nil, 400),
  			QuickslotSkillAction("Spinning Slash", 2, {"BT_skill_RotationBash", "WAIT"}, {1129, 1128, 1127, 1021}, nil, 400)
  		},

  		Movement =
  		{
  			SkillAction("Charging Trust", {KeyCode_W, KeyCode_F}, {"BT_skill_ThrustKick", "WAIT"}, {2835, 1132, 1131, 1130, 1022}, nil, 1000),
  		},

  		Defense =
  		{
  			SkillAction("Guard", {KeyCode_Q}, {"BT_skill_Defence_Hit", "WAIT"}, {1147, 1146, 1019}, nil, 1000):forceReuseCycle(5000),
  		},

  		GuardCombo =
  		{
  			SkillAction("Shield Charge", {KeyCode_SPACE}, {"BT_skill_Defence_Ing", "WAIT"}, {305}, nil, 300),
  		},
	}

	self.Hotkey = KeyCode_F6

	self.Target = nil

	self.TargetRange = 1000

	self.QueuedAction = false
	self.QueuedDefenseAction = false

	self.CurrentAction = nil

	self:init()

  	return self
end

function CombatRoutine:init()
	for kT, saType in pairs(self.SkillActions) do
		for kS,skillAction in pairs(saType) do
			skillAction.DoneActionCallback = function(sA) self:onDoneAction(sA) end
		end		
	end
end

function CombatRoutine:onMonsterAttack(attacker)
	if self.QueuedDefenseAction then
		return
	end

	local nextSkillAction = nil

	if LocalPlayer.getHpPercentage() < 40 then
		nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Defense, attacker)
	end

	if nextSkillAction ~= nil then
		nextSkillAction:use(attacker)

		self.QueuedDefenseAction = true
	end
end

function CombatRoutine:onPlayerAttack(attacker)
	if self.QueuedDefenseAction then
		return
	end

	local nextSkillAction = nil

	if LocalPlayer.getHpPercentage() < 40 then
		nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Defense, attacker)
	end

	if nextSkillAction ~= nil then
		nextSkillAction:use(attacker)

		self.QueuedDefenseAction = true
	end
end

function CombatRoutine:onPulse()
	if self.QueuedAction or self.QueuedDefenseAction then
		return
	end

	local nextSkillAction = nil

	if nextSkillAction == nil and string.find(self.CurrentAction, "BT_skill_Defence_Ing") ~= nil then
		nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.GuardCombo, self.Target)
	end

	if string.find(self.CurrentAction, "WAIT") ~= nil or string.find(self.CurrentAction, "Defence") ~= nil then
		if nextSkillAction == nil and LocalPlayer.getMpPercentage() < 30 then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Regen, self.Target)
		end

		if nextSkillAction == nil and self.Target:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) >= 300 then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Movement, self.Target)
		end

		if nextSkillAction == nil then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.AoE, self.Target)
		end
	end

	if nextSkillAction ~= nil then
		nextSkillAction:use(self.Target)

		self.QueuedAction = true
	end
end

function CombatRoutine:onPlayerPulse()
	if self.QueuedAction or self.QueuedDefenseAction then
		return
	end

	local nextSkillAction = nil

	if nextSkillAction == nil and string.find(self.CurrentAction, "BT_skill_Defence_Ing") ~= nil then
		nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.GuardCombo, self.Target)
	end

	if string.find(self.CurrentAction, "WAIT") ~= nil or string.find(self.CurrentAction, "Defence") ~= nil then
		if nextSkillAction == nil and LocalPlayer.getMpPercentage() < 30 then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Regen, self.Target)
		end

		if nextSkillAction == nil and self.Target:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) >= 300 then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.Movement, self.Target)
		end

		if nextSkillAction == nil then
			nextSkillAction = SkillHelper.getNextUsableSkillAction(self.SkillActions.AoE, self.Target)
		end
	end

	if nextSkillAction ~= nil then
		nextSkillAction:use(self.Target)

		self.QueuedAction = true
	end
end

function CombatRoutine:onDoneAction(skillAction)
	if skillAction.Name == "Shield Charge" then
		Actor.setAction("BT_WAIT")
	end

	if skillAction.Name == "Guard" then
		self.QueuedDefenseAction = false
	else
		self.QueuedAction = false
	end	
end

return CombatRoutine()