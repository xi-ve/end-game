function PaGlobal_Jaksal_All:initialize()
  if true == PaGlobal_Jaksal_All._initialize then
    return
  end
  self._ui._stc_fish = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Fish")
  self._ui._stc_water = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Water")
  self._ui._stc_crossHair = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Crosshair")
  self._ui._stc_jaksal = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Jaksal")
  self._ui._progress_fishPower = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Progress2_FishGauge")
  self._ui._progress_jaksalPower = UI.getChildControl(Panel_MiniGame_Jaksal_All, "CircularProgress_JaksalGauge")
  self._ui._stc_resultSuccess = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Result_Success")
  self._ui._stc_resultFailed = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_Result_Failed")
  self._ui._stc_fishGet = UI.getChildControl(Panel_MiniGame_Jaksal_All, "Static_FishGet")
  self._ui._txt_jaksalCount = UI.getChildControl(Panel_MiniGame_Jaksal_All, "StaticText_JaksalCount")
  self._ui._txt_endTimer = UI.getChildControl(Panel_MiniGame_Jaksal_All, "StaticText_EndTimer")
  Panel_MiniGame_Jaksal_All:setMaskingChild(true)
  self._ui._stc_water:setGlassBackground(true)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Jaksal_All:registEventHandler()
  PaGlobal_Jaksal_All:validate()
  PaGlobal_Jaksal_All._initialize = true
end
function PaGlobal_Jaksal_All:registEventHandler()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  if true == self._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "PaGlobal_Jaksal_All_UpdateKeyPressCheck")
  end
end
function PaGlobal_Jaksal_All:prepareOpen()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  self._ui._stc_fish:SetIgnore(false)
  Panel_MiniGame_Jaksal_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  self._ui._stc_crossHair:SetIgnore(true)
  self._ui._stc_fishGet:SetShow(false)
  self._fishMoveData.position.x = self._ui._stc_water:GetPosX() + math.random(0, self._ui._stc_water:GetSizeX())
  self._fishMoveData.position.y = self._ui._stc_water:GetPosY() + math.random(0, self._ui._stc_water:GetSizeY())
  self._ui._stc_fish:SetShow(true)
  self._ui._stc_fish:SetPosX(self._fishMoveData.position.x)
  self._ui._stc_fish:SetPosY(self._fishMoveData.position.y)
  self._ui._stc_fish:SetColor(Defines.Color.C_FF000000)
  self._ui._stc_resultFailed:SetShow(false)
  self._ui._stc_resultFailed:SetAlpha(0)
  self._ui._stc_resultSuccess:SetShow(false)
  self._ui._stc_resultSuccess:ResetVertexAni()
  self._ui._stc_resultSuccess:SetAlpha(0)
  self._ui._txt_endTimer:ResetVertexAni()
  self._jaksalCount = 15
  self._sumTime = 0
  self._fishMoveData.escapePower = 1
  self._endTimer = 60
  self._isStoppedGame = false
  self:updateJaksalCount()
  self._crosshairPosX = getOriginScreenSizeX() / 2
  self._crosshairPosY = getOriginScreenSizeY() / 2
  setForceMoveCamera(true)
  PaGlobal_Jaksal_All:open()
end
function PaGlobal_Jaksal_All:open()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  Panel_MiniGame_Jaksal_All:SetShow(true)
end
function PaGlobal_Jaksal_All:prepareClose()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  Panel_MiniGame_Jaksal_All:ClearUpdateLuaFunc()
  self._ui._stc_water:EraseAllEffect()
  setForceMoveCamera(false)
  PaGlobal_Jaksal_All:close()
end
function PaGlobal_Jaksal_All:close()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  Panel_MiniGame_Jaksal_All:SetShow(false)
end
function PaGlobal_Jaksal_All:update()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
end
function PaGlobal_Jaksal_All:validate()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  self._ui._stc_fish:isValidate()
  self._ui._stc_water:isValidate()
  self._ui._stc_crossHair:isValidate()
  self._ui._stc_jaksal:isValidate()
  self._ui._progress_fishPower:isValidate()
  self._ui._progress_jaksalPower:isValidate()
  self._ui._stc_resultSuccess:isValidate()
  self._ui._stc_resultFailed:isValidate()
  self._ui._stc_fishGet:isValidate()
  self._ui._txt_jaksalCount:isValidate()
  self._ui._txt_endTimer:isValidate()
end
function PaGlobal_Jaksal_All:updateJaksalCount()
  self._ui._txt_jaksalCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAMEJAKSAL_JaksalCount", "JaksalCount", self._jaksalCount))
end
function PaGlobal_Jaksal_All:updatePerFrame(deltaTime)
  self:updateCrossHair()
  self._fishMoveData.fishRePositionTime = self._fishMoveData.fishRePositionTime + deltaTime
  if false == self._isStoppedGame then
    self._endTimer = self._endTimer - deltaTime
    if 50 >= math.floor(self._endTimer) then
      self._ui._txt_endTimer:SetVertexAniRun("Ani_Color_Alert", true)
    else
      self._ui._txt_endTimer:ResetVertexAni()
    end
  end
  local isForceUpdate = false
  if self._fishMoveData.fishRePositionTime > 1 then
    isForceUpdate = true
    self._fishMoveData.fishRePositionTime = self._fishMoveData.fishRePositionTime - 1
  end
  local fishToDestLength = self:changeDestPosition(true, isForceUpdate)
  self:updateEscapePower(fishToDestLength, deltaTime)
  self:rotatePerFrame(self._fishMoveData.position, self._fishMoveData.destPosition, deltaTime, true, fishToDestLength)
  self:updateFillGauge(deltaTime, fishToDestLength)
  local speedValue = 200
  if fishToDestLength then
    speedValue = 300
    self._ui._stc_fish:SetColor(Defines.Color.C_FFD20000)
  else
    self._ui._stc_fish:SetColor(Defines.Color.C_FF7F7F7F)
  end
  local moveValue = self:rotateToDirection(self._fishMoveData.rotate, deltaTime * speedValue * self._fishMoveData.escapePower)
  self._fishMoveData.position.x = self._fishMoveData.position.x + moveValue.x
  self._fishMoveData.position.y = self._fishMoveData.position.y + moveValue.y
  self._ui._stc_fish:SetPosX(self._fishMoveData.position.x - self._ui._stc_fish:GetSizeX() * 0.5)
  self._ui._stc_fish:SetPosY(self._fishMoveData.position.y - self._ui._stc_fish:GetSizeY() * 0.5)
  self._ui._stc_fish:SetRotate(self._fishMoveData.rotate)
  self._ui._txt_endTimer:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_TIMER_SECOND", "sec", math.floor(self._endTimer)))
  if true == self._isStoppedGame then
    return
  end
  if math.floor(self._endTimer) <= 0 or 0 > self._jaksalCount then
    self:failed()
  end
  if true == self._isConsole then
    if isPadPressed(__eJoyPadInputType_LeftStick_Up) then
      self._crosshairPosY = self._crosshairPosY - self._crosshairSpeed * deltaTime
    end
    if isPadPressed(__eJoyPadInputType_LeftStick_Down) then
      self._crosshairPosY = self._crosshairPosY + self._crosshairSpeed * deltaTime
    end
    if isPadPressed(__eJoyPadInputType_LeftStick_Left) then
      self._crosshairPosX = self._crosshairPosX - self._crosshairSpeed * deltaTime
    end
    if isPadPressed(__eJoyPadInputType_LeftStick_Right) then
      self._crosshairPosX = self._crosshairPosX + self._crosshairSpeed * deltaTime
    end
    if self._crosshairPosX < self._ui._stc_water:GetPosX() + Panel_MiniGame_Jaksal_All:GetPosX() then
      self._crosshairPosX = self._ui._stc_water:GetPosX() + Panel_MiniGame_Jaksal_All:GetPosX()
    elseif Panel_MiniGame_Jaksal_All:GetPosX() + self._ui._stc_water:GetPosX() + self._ui._stc_water:GetSizeX() < self._crosshairPosX then
      self._crosshairPosX = self._ui._stc_water:GetPosX() + self._ui._stc_water:GetSizeX() + Panel_MiniGame_Jaksal_All:GetPosX()
    end
    if self._crosshairPosY < self._ui._stc_water:GetPosY() + Panel_MiniGame_Jaksal_All:GetPosY() then
      self._crosshairPosY = self._ui._stc_water:GetPosY() + Panel_MiniGame_Jaksal_All:GetPosY()
    elseif self._ui._stc_water:GetPosY() + self._ui._stc_water:GetSizeY() + Panel_MiniGame_Jaksal_All:GetPosY() < self._crosshairPosY then
      self._crosshairPosY = self._ui._stc_water:GetPosY() + self._ui._stc_water:GetSizeY() + Panel_MiniGame_Jaksal_All:GetPosY()
    end
  end
end
function PaGlobal_Jaksal_All:updateCrossHair()
  if nil == Panel_MiniGame_Jaksal_All then
    return
  end
  local curPosX = 0
  local curPosY = 0
  if true == self._isConsole then
    curPosX = self._crosshairPosX
    curPosY = self._crosshairPosY
  else
    curPosX = getMousePosX()
    curPosY = getMousePosY()
  end
  local posX = curPosX - Panel_MiniGame_Jaksal_All:GetPosX() - self._ui._stc_crossHair:GetSizeX() * 0.5 + 5
  local posY = curPosY - Panel_MiniGame_Jaksal_All:GetPosY() - self._ui._stc_crossHair:GetSizeY() * 0.5 + 5
  if posX < self._ui._stc_water:GetPosX() then
    posX = self._ui._stc_water:GetPosX()
  elseif posX > self._ui._stc_water:GetPosX() + self._ui._stc_water:GetSizeX() - self._ui._stc_crossHair:GetSizeX() then
    posX = self._ui._stc_water:GetPosX() + self._ui._stc_water:GetSizeX() - self._ui._stc_crossHair:GetSizeX()
  end
  if posY < self._ui._stc_water:GetPosY() then
    posY = self._ui._stc_water:GetPosY()
  elseif posY > self._ui._stc_water:GetPosY() + self._ui._stc_water:GetSizeY() - self._ui._stc_crossHair:GetSizeY() then
    posY = self._ui._stc_water:GetPosY() + self._ui._stc_water:GetSizeY() - self._ui._stc_crossHair:GetSizeY()
  end
  self._ui._stc_crossHair:SetPosX(posX)
  self._ui._stc_crossHair:SetPosY(posY)
end
function PaGlobal_Jaksal_All:updateEscapePower(fishToDestLength, deltaTime)
  self._ui._progress_fishPower:SetProgressRate((1 - (1 - self._fishMoveData.escapePower) * 2) * 100)
end
function PaGlobal_Jaksal_All:rotatePerFrame(startPosition, endPosition, deltaTime, useImprovedEscape, fishToDestLength)
  local direction = float2(endPosition.x - startPosition.x, endPosition.y - startPosition.y)
  local rotate = math.atan2(direction.y, direction.x)
  local rotateA = rotate - self._fishMoveData.rotate - math.pi * 2
  local rotateB = rotate - self._fishMoveData.rotate
  local rotateC = rotate - self._fishMoveData.rotate + math.pi * 2
  rotate = rotateA
  if math.abs(rotateB) < math.abs(rotate) then
    rotate = rotateB
  end
  if math.abs(rotateC) < math.abs(rotate) then
    rotate = rotateC
  end
  local rotateSpeed = 1.5
  if useImprovedEscape and fishToDestLength then
    rotateSpeed = 15
  end
  local rotatePercent = deltaTime * rotateSpeed * self._fishMoveData.escapePower
  if 1 < rotatePercent then
    rotatePercent = 1
  end
  self._fishMoveData.rotate = self._fishMoveData.rotate + rotate * rotatePercent
  if math.pi < self._fishMoveData.rotate then
    self._fishMoveData.rotate = self._fishMoveData.rotate - math.pi * 2
  end
  if self._fishMoveData.rotate < -math.pi then
    self._fishMoveData.rotate = self._fishMoveData.rotate + math.pi * 2
  end
end
function PaGlobal_Jaksal_All:updateFillGauge(deltaTime, shotSuccess)
  self._sumTime = self._sumTime + deltaTime
  if self._sumTime > 3 then
    self._sumTime = 3
  end
  self._ui._progress_jaksalPower:SetProgressRate(self._sumTime * 100)
  if self._sumTime >= 1 then
    self._ui._progress_jaksalPower:SetColor(Defines.Color.C_FFFFFFFF)
  else
    self._ui._progress_jaksalPower:SetColor(Defines.Color.C_FFD20000)
  end
end
function PaGlobal_Jaksal_All:updateKeyPressCheck(keyType)
  local curPosX = 0
  local curPosY = 0
  if true == self._isConsole then
    curPosX = self._crosshairPosX
    curPosY = self._crosshairPosY
  else
    curPosX = getMousePosX()
    curPosY = getMousePosY()
  end
  local posX = curPosX - Panel_MiniGame_Jaksal_All:GetPosX() - self._ui._stc_jaksal:GetSizeX() * 0.5
  local posY = curPosY - Panel_MiniGame_Jaksal_All:GetPosY() - self._ui._stc_jaksal:GetSizeY() * 0.5 + 13
  local keyPress = false
  if true == self._isConsole then
    if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Jump) then
      keyPress = true
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType then
    keyPress = true
  end
  if true == keyPress and 2 <= self._sumTime and false == self._isStoppedGame then
    self._jaksalCount = self._jaksalCount - 1
    local jaksalPosX = self._ui._stc_crossHair:GetPosX() + self._ui._stc_crossHair:GetSizeX() * 0.5
    local jaksalPosY = self._ui._stc_crossHair:GetPosY() + self._ui._stc_crossHair:GetSizeY() * 0.5
    local jaksalToFishVector = float2(self._fishMoveData.position.x - jaksalPosX, self._fishMoveData.position.y - jaksalPosY)
    local fishToDestLength = self:getLength(jaksalToFishVector)
    if fishToDestLength < 100 then
      self._fishMoveData.escapePower = self._fishMoveData.escapePower - 0.05
      render_setChromaticBlur(70, 0.15)
      render_setPointBlur(0.025, 0.15)
      render_setColorBypass(0.3, 0.1)
      self._ui._stc_fish:ResetVertexAni()
      self._ui._stc_fish:SetVertexAniRun("Ani_Color_Damage", true)
    end
    if 0.5 >= self._fishMoveData.escapePower then
      self._fishMoveData.escapePower = 0.5
      self:success()
    elseif 0 >= self._jaksalCount then
      self:failed()
    end
    self._sumTime = 0
    self:updateJaksalCount()
    self._ui._stc_jaksal:SetShow(true)
    self._ui._stc_jaksal:ResetVertexAni()
    self._ui._stc_jaksal:SetVertexAniRun("Ani_Color_Show", true)
    self._ui._stc_jaksal:SetVertexAniRun("Ani_Color_Hide", true)
    self._ui._stc_jaksal:ChangeTextureInfoName("new_ui_common_forlua/widget/instance/minigame_jaksal_spear.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_jaksal, 0, 0, 100, 60)
    self._ui._stc_jaksal:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_jaksal:setRenderTexture(self._ui._stc_jaksal:getBaseTexture())
    self._ui._stc_jaksal:SetPosX(posX)
    self._ui._stc_jaksal:SetPosY(posY)
  end
end
function PaGlobal_Jaksal_All:rotateToDirection(rotate, deltaTime)
  return float2(math.cos(rotate) * deltaTime, math.sin(rotate) * deltaTime)
end
function PaGlobal_Jaksal_All:getLength(float2Value)
  return math.pow(float2Value.x * float2Value.x + float2Value.y * float2Value.y, 0.5)
end
function PaGlobal_Jaksal_All:normalize(float2Value)
  local length = self:getLength(float2Value)
  return float2(float2Value.x / length, float2Value.y / length)
end
function PaGlobal_Jaksal_All:changeDestPosition(useImprovedEscape, updateForce)
  local jaksalPosX = self._ui._stc_crossHair:GetPosX() + self._ui._stc_crossHair:GetSizeX() * 0.5
  local jaksalPosY = self._ui._stc_crossHair:GetPosY() + self._ui._stc_crossHair:GetSizeY() * 0.5
  local jaksalToFishVector = float2(self._fishMoveData.position.x - jaksalPosX, self._fishMoveData.position.y - jaksalPosY)
  local fishToDestLength = self:getLength(jaksalToFishVector)
  if fishToDestLength < 100 then
    if useImprovedEscape then
      jaksalToFishVector = self:normalize(jaksalToFishVector)
      self._fishMoveData.destPosition.x = self._fishMoveData.destPosition.x + jaksalToFishVector.x * 100
      self._fishMoveData.destPosition.y = self._fishMoveData.destPosition.y + jaksalToFishVector.y * 100
    else
      self._fishMoveData.destPosition.x = jaksalPosX + math.random(-400, 400)
      self._fishMoveData.destPosition.y = jaksalPosY + math.random(-400, 400)
      if self._fishMoveData.destPosition.x < 0 or self._ui._stc_water:GetSizeX() < self._fishMoveData.destPosition.x then
        self._fishMoveData.destPosition.x = math.random(0, self._ui._stc_water:GetSizeX())
      end
      if self._fishMoveData.destPosition.y < 0 or self._ui._stc_water:GetSizeY() < self._fishMoveData.destPosition.y then
        self._fishMoveData.destPosition.y = math.random(0, self._ui._stc_water:GetSizeY())
      end
    end
    return true
  end
  if updateForce or self._fishMoveData.destPosition.x < 0 or self._ui._stc_water:GetSizeX() < self._fishMoveData.destPosition.x then
    self._fishMoveData.destPosition.x = math.random(0, self._ui._stc_water:GetSizeX())
  end
  if updateForce or self._fishMoveData.destPosition.y < 0 or self._ui._stc_water:GetSizeY() < self._fishMoveData.destPosition.y then
    self._fishMoveData.destPosition.y = math.random(0, self._ui._stc_water:GetSizeY())
  end
  return false
end
function PaGlobal_Jaksal_All:success()
  self._ui._stc_resultSuccess:SetShow(true)
  self._ui._stc_resultSuccess:ResetVertexAni()
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Scale_Result_Success_empty", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Scale_Result_Success", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Color_Result_Success_empty", true)
  self._ui._stc_resultSuccess:SetVertexAniRun("Ani_Color_Result_Success", true)
  self._ui._stc_fish:SetShow(false)
  self._ui._stc_fishGet:SetShow(true)
  getSelfPlayer():get():SetMiniGameResult(0)
  self._isStoppedGame = true
  setForceMoveCamera(false)
end
function PaGlobal_Jaksal_All:failed()
  self._ui._stc_resultFailed:SetShow(true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Scale_Result_Failed_empty", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Scale_Result_Failed", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Color_Result_Failed_empty", true)
  self._ui._stc_resultFailed:SetVertexAniRun("Ani_Color_Result_Failed", true)
  getSelfPlayer():get():SetMiniGameResult(1)
  self._isStoppedGame = true
  setForceMoveCamera(false)
end
