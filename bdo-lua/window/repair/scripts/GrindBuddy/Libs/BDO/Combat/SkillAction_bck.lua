Grinder_SkillAction = {}
Grinder_SkillAction.__index = Grinder_SkillAction

Grinder_SkillAction.KeyFlags = {}
Grinder_SkillAction.KeyFlags["9"] = 0x4000 --KeyCode_TAB
Grinder_SkillAction.KeyFlags["81"] = 0x1 -- KeyCode_Q
Grinder_SkillAction.KeyFlags["87"] = 0x2 -- KeyCode_W
Grinder_SkillAction.KeyFlags["69"] = 0x4 -- KeyCode_E
Grinder_SkillAction.KeyFlags["84"] = 0x10 -- KeyCode_T
Grinder_SkillAction.KeyFlags["83"] = 0x40 -- KeyCode_S
Grinder_SkillAction.KeyFlags["65"] = 0x20 -- KeyCode_A
Grinder_SkillAction.KeyFlags["68"] = 0x80 -- KeyCode_D
Grinder_SkillAction.KeyFlags["70"] = 0x100 -- KeyCode_F
Grinder_SkillAction.KeyFlags["16"] = 0x8000 -- KeyCode_SHIFT
Grinder_SkillAction.KeyFlags["90"] = 0x200 -- KeyCode_Z
Grinder_SkillAction.KeyFlags["88"] = 0x400 -- KeyCode_X
Grinder_SkillAction.KeyFlags["86"] = 0x1000 --KeyCode_V
Grinder_SkillAction.KeyFlags["67"] = 0x800 --KeyCode_C
Grinder_SkillAction.KeyFlags["32"] = 0x20000 -- KeyCode_SPACE
Grinder_SkillAction.KeyFlags["1"] = 0x40000 -- KeyCode_LBUTTON
Grinder_SkillAction.KeyFlags["2"] = 0x80000 --KeyCode_RBUTTON

local function bit_xor(x, y)
  local z = 0
  for i = 0, 31 do
    if (x % 2 == 0) then -- x had a '0' in bit i
      if (y % 2 == 1) then -- y had a '1' in bit i
        y = y - 1
        z = z + 2 ^ i -- set bit i of z to '1'
      end
    else -- x had a '1' in bit i
      x = x - 1
      if (y % 2 == 0) then -- y had a '0' in bit i
        z = z + 2 ^ i -- set bit i of z to '1'
      else
        y = y - 1
      end
    end
    y = y / 2
    x = x / 2
  end
  return z
end

local PI = 3.14159265358979323846

function Grinder_SkillAction.new(name, keys, skillIds, doneActionCallback, attackableRange, isQuickslot)
  local self = setmetatable({}, Grinder_SkillAction)

  self.Name = name
  self.Keys = keys

  self.SkillIds = skillIds

  self.isQuickslot = false
  self.Quickslot = nil

  if isQuickslot == nil then
    self.isQuickslot = false
  else
    self.isQuickslot = isQuickslot
  end

  self.CurrentSkillId = nil
  self.RequiredMP = -1
  self.RequiredStamina = -1
  self.ReuseCycle = -1
  self.forceReuseCyle = false

  self.DoneActionCallback = doneActionCallback

  self.AttackableRange = attackableRange

  self.LastUse = 0

  self:init()

  return self
end

function Grinder_SkillAction:init()
  for k, v in pairs(self.SkillIds) do
    if Skills.isLearned(v) then
      self.CurrentSkillId = v
      break
    end
  end

  if self.isQuickslot then
    self.Quickslot = self.Keys
  end

  if self.CurrentSkillId == nil then
    Log.log("Could not find any learned skill for Skill " .. self.Name)
    return
  end

  self.RequiredMP, self.RequiredStamina, self.ReuseCycle = Skills.getRequired(self.CurrentSkillId)
end

function Grinder_SkillAction:forceReuseCycle(value)
  self.ReuseCycle = value
  self.forceReuseCyle = true
end

function Grinder_SkillAction:resetForceReuseCycle()
  self.ReuseCycle = -1
  self.forceReuseCyle = false
end

function Grinder_SkillAction:canUse(target)
  if self.CurrentSkillId == nil then
    return false
  end

  if target and target:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) > self.AttackableRange then
    return false
  end

  local cooldown = 0
  for _, v in ipairs(self.SkillIds) do
    local sCD = Infinity.BDO.Lua.Execute("return ToClient_getSkillCooltimebySkillNo(" .. v .. ")")
    if sCD and sCD > 0 then
      if sCD > cooldown then
        cooldown = sCD
      end
    end
  end

  if self.forceReuseCyle then
    if self.LastUse + self.ReuseCycle > Cache.time then
      return false
    end
  else
    if cooldown and cooldown ~= 0 then
      cooldown = nil
      return false
    end
  end

  cooldown = nil

  if LocalPlayer.getMp() < self.RequiredMP then
    return false
  end

  if LocalPlayer.getStamina() < self.RequiredStamina then
    return false
  end

  return true
end

local function round(num, numDecimalPlaces)
  local mult = 10 ^ numDecimalPlaces
  return math.floor(num * mult + 0.5) / mult
end

local function roundUp(num)
  return math.floor(num) + 1
end

local function normalizeYaw(yaw)
  while (yaw > PI) do
    yaw = -PI + (yaw - PI)
  end

  while (yaw < (-PI)) do
    yaw = PI + (yaw + PI)
  end

  return yaw
end

local function yawToRot(yaw)
  if yaw > 0 then
    return yaw
  else
    return PI + (PI - math.abs(yaw))
  end
end

local function floatDif(num1, num2, decimalNum)
  decimalNum = decimalNum or 5
  return math.abs(round(num1, decimalNum) - round(num2, decimalNum))
end

function Grinder_SkillAction:faceTarget(targetPos)
  local rotFaceTarget = targetPos:getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
  local yawFaceTarget = normalizeYaw(rotFaceTarget - (2 * PI))
  local pitchFaceTarget = -0.8

  if floatDif(Infinity.BDO.getCameraManager():getPitch(), pitchFaceTarget, 3) > 0.2 then
    Infinity.BDO.getCameraManager():setPitch(pitchFaceTarget)
  end
  if
    floatDif(Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation(), rotFaceTarget, 3) >
      0.2
   then
    Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
  end

  --if not Grinder.settings.use_keyflag then
  if floatDif(Infinity.BDO.getCameraManager():getYaw(), yawFaceTarget, 3) > 0.2 then
    if Player.ignoreCameraUntil < Cache.time then
      Player.setCamera(targetPos, 4)
      if Grinder.settings.camera_to_movement and Grinder.settings.camera_real_swing then
        return false
      end
    else
      Infinity.BDO:getCameraManager():setYaw(rotFaceTarget - (2 * PI))
    end
  end
  --end

  rotFaceTarget = nil
  yawFaceTarget = nil
  pitchFaceTarget = nil

  return true
end

function Grinder_SkillAction:useToPos(pos)
  local keyFlag = nil
  if Grinder.settings.use_keyflag and not self.isQuickslot then
    local newKeyFlag = 0
    for _, keyInt in pairs(self.Keys) do
      local flag = Grinder_SkillAction.KeyFlags[tostring(keyInt)]
      if flag ~= nil then
        newKeyFlag = bit_xor(newKeyFlag, flag)
      end
    end
    --print(newKeyFlag)
    if newKeyFlag ~= 0 then
      keyFlag = newKeyFlag
    end
  end

  if keyFlag == nil and not self.isQuickslot then --Using normal keys
    Infinity.BDO.getUIManager():setIsCursorActive(false)
  end

  if Grinder.settings.log_verbose then
    if self.LastUse + 300 < Cache.time then
      Log.log("Using " .. self.Name .. " to pos " .. VectorUtils.toString(pos))
    end
  end

  if not self:faceTarget(pos) then
    --print("Could not face target. Waiting for next pulse!")
    Player.blockMovement(150)
    return false
  end

  if self.IsQuickslot then
    Infinity.BDO.Lua.Execute("quickSlot_UseSlot(" .. tostring(self.Quickslot) .. ")")
  else
    if keyFlag == nil then --Using normal keys
      Input.pressOnce(self.Keys, Grinder.settings.skillUse_delay - (Grinder.settings.skillUse_delay / 4))
    else
      Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
      Infinity.BDO.Input.setKeyInputFlagValue(keyFlag)
    end
  end

  Player.ignoreCameraUntil = Player.ignoreCameraUntil + Grinder.settings.skillUse_delay
  self.LastUse = Cache.time
  Grinder.wait(Grinder.settings.skillUse_delay)
  Grinder.onSkillUse(keyFlag)

  return true
end

function Grinder_SkillAction:use(target)
  --print("Using " .. self.Name)

  local keyFlag = nil
  if Grinder.settings.use_keyflag and not self.isQuickslot then
    local newKeyFlag = 0
    for _, keyInt in pairs(self.Keys) do
      local flag = Grinder_SkillAction.KeyFlags[tostring(keyInt)]
      if flag ~= nil then
        newKeyFlag = bit_xor(newKeyFlag, flag)
      end
    end
    if newKeyFlag ~= 0 then
      keyFlag = newKeyFlag
    end
  end

  if keyFlag == nil and not self.isQuickslot then --Using normal keys
    Infinity.BDO.getUIManager():setIsCursorActive(false)
  end

  if Grinder.settings.log_verbose then
    if self.LastUse + 150 < Cache.time then
      Log.log("Using " .. self.Name .. " on enemy " .. target:getActorKey())
    end
  end

  if not self:faceTarget(target:getPosition()) then
    Player.blockMovement(150)
    return false
  end

  if self.isQuickslot then
    Infinity.BDO.Lua.Execute("quickSlot_UseSlot(" .. tostring(self.Quickslot) .. ")")
  else
    if keyFlag == nil then --Using normal keys
      Input.pressOnce(self.Keys, Grinder.settings.skillUse_delay - (Grinder.settings.skillUse_delay / 4))
    else
      Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
      Infinity.BDO.Input.setKeyInputFlagValue(keyFlag)
    end
  end

  Player.ignoreCameraUntil = Player.ignoreCameraUntil + Grinder.settings.skillUse_delay
  self.LastUse = Cache.time
  Grinder.wait(Grinder.settings.skillUse_delay)
  Grinder.onSkillUse(keyFlag)
  return true
end

setmetatable(
  Grinder_SkillAction,
  {
    __call = function(cls, ...)
      return cls.new(...)
    end
  }
)
