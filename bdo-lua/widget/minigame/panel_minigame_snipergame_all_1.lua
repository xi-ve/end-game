function PaGlobal_MiniGame_SniperGame_All:initialize()
  if nil == Panel_MiniGame_SniperGame_All or true == PaGlobal_MiniGame_SniperGame_All._initialize then
    return
  end
  PaGlobal_MiniGame_SniperGame_All._ui._hole = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_BG_SniperGame")
  PaGlobal_MiniGame_SniperGame_All._ui._crossHair = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_CrossHair")
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMark = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_Deviation")
  PaGlobal_MiniGame_SniperGame_All._ui._blackboxes = {}
  PaGlobal_MiniGame_SniperGame_All._ui._deviationHit = {}
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMiss = {}
  PaGlobal_MiniGame_SniperGame_All._ui._breathContainer = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_BG_BreathContainer")
  PaGlobal_MiniGame_SniperGame_All._ui._breathBlue = UI.getChildControl(PaGlobal_MiniGame_SniperGame_All._ui._breathContainer, "Static_BG_BreathBlue")
  PaGlobal_MiniGame_SniperGame_All._ui._breathYellow = UI.getChildControl(PaGlobal_MiniGame_SniperGame_All._ui._breathContainer, "Static_BG_BreathYellow")
  PaGlobal_MiniGame_SniperGame_All._ui._fade = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_Fade")
  PaGlobal_MiniGame_SniperGame_All._ui._fadeCircle = UI.getChildControl(PaGlobal_MiniGame_SniperGame_All._ui._hole, "Static_FadeCircle")
  PaGlobal_MiniGame_SniperGame_All._ui._debugText = UI.getChildControl(Panel_MiniGame_SniperGame_All, "MultilineText_Debug")
  PaGlobal_MiniGame_SniperGame_All._ui._middlePointDev = UI.getChildControl(Panel_MiniGame_SniperGame_All, "Static_MiddlePoint_ForDev")
  self._ui._blackboxes = {
    UI.getChildControl(self._ui._hole, "Static_BlackBox1"),
    UI.getChildControl(self._ui._hole, "Static_BlackBox2"),
    UI.getChildControl(self._ui._hole, "Static_BlackBox3"),
    UI.getChildControl(self._ui._hole, "Static_BlackBox4")
  }
  self._ui._deviationHit[1] = UI.getChildControl(self._ui._deviationMark, "Static_DeviationHit1")
  self._ui._deviationMiss[1] = UI.getChildControl(self._ui._deviationMark, "Static_DeviationMiss1")
  for ii = 2, 4 do
    self._ui._deviationHit[ii] = UI.cloneControl(self._ui._deviationHit[1], self._ui._deviationMark, "Static_DeviationHitClone" .. ii)
    self._ui._deviationMiss[ii] = UI.cloneControl(self._ui._deviationMiss[1], self._ui._deviationMark, "Static_DeviationMissClone" .. ii)
  end
  PaGlobal_MiniGame_SniperGame_All:basicSetting()
  PaGlobal_MiniGame_SniperGame_All:registerEventHandler()
  PaGlobal_MiniGame_SniperGame_All:validate()
  PaGlobal_MiniGame_SniperGame_All._initialize = true
end
function PaGlobal_MiniGame_SniperGame_All:basicSetting()
  self._breathAndContainerRatio = 1 - self._breathXOffset * 2 / self._ui._breathContainer:GetSizeX()
  self._ui._breathBlue:SetSize(self._ui._breathBlue:GetSizeX(), self._ui._breathContainer:GetSizeY() * 0.5)
  self._ui._breathBlue:ComputePos()
  self._ui._breathYellow:SetSize(self._ui._breathYellow:GetSizeX(), self._ui._breathContainer:GetSizeY() * 0.5)
  self._ui._breathYellow:ComputePos()
  self._ui._deviationMark:SetShow(false)
  self._ui._crossHair:SetShow(false)
  self._ui._breathBlue:SetShow(false)
  self._ui._breathYellow:SetShow(true)
  self._ui._breathContainer:SetShow(true)
  if true == ToClient_IsDevelopment() then
    self._ui._debugText:SetShow(true)
    self._ui._middlePointDev:SetShow(true)
  else
    self._ui._debugText:SetShow(false)
    self._ui._middlePointDev:SetShow(false)
  end
  self._ui._fade:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._fade:SetPosXY(0, 0)
  ToClient_SniperGame_SetMaxRangeForCrossHair(500)
  ToClient_SniperGame_SetCrossHairRadiusParam(self._minRadius, self._maxRadius, self._bestRadius - self._bestRadiusThreshold, self._bestRadius + self._bestRadiusThreshold)
  ToClient_SniperGame_SetRotationSensitivity(2.0E-4)
  self.centerX = getScreenSizeX() * 0.5
  self.centerY = getScreenSizeY() * 0.5
end
function PaGlobal_MiniGame_SniperGame_All:registerEventHandler()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_SniperGame_All_OnScreenSize")
  Panel_MiniGame_SniperGame_All:RegisterUpdateFunc("PaGlobal_MiniGame_SniperGame_All_UpdatePerFrame")
end
function PaGlobal_MiniGame_SniperGame_All:prepareOpen()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All:open()
end
function PaGlobal_MiniGame_SniperGame_All:open()
  if nil == Panel_MiniGame_SniperGame_All or true == Panel_MiniGame_SniperGame_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperGame_All:SetShow(true)
end
function PaGlobal_MiniGame_SniperGame_All:prepareClose()
  if nil == Panel_MiniGame_SniperGame_All or false == Panel_MiniGame_SniperGame_All:GetShow() then
    return
  end
  ToClient_SniperGame_StopLensDistortion()
  PaGlobal_MiniGame_SniperGame_All:close()
end
function PaGlobal_MiniGame_SniperGame_All:close()
  if nil == Panel_MiniGame_SniperGame_All or false == Panel_MiniGame_SniperGame_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperGame_All:SetShow(false)
end
function PaGlobal_MiniGame_SniperGame_All:validate()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  PaGlobal_MiniGame_SniperGame_All._ui._hole:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._crossHair:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._deviationMark:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._breathContainer:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._fade:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._debugText:isValidate()
  PaGlobal_MiniGame_SniperGame_All._ui._middlePointDev:isValidate()
end
function PaGlobal_MiniGame_SniperGame_All:UpdatePerFrame(deltaTime)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  if true == self._startAniIsPlaying then
    self._ui._debugText:SetShow(false)
    self:animateHolePos(deltaTime)
    return
  end
  local gameInfo = ToClient_SniperGame_GetGameInfo()
  local gameState = ToClient_SniperGame_GetGameState()
  local crossHairPosX = self.centerX + gameInfo:getXOffset()
  local crossHairPosY = self.centerY + gameInfo:getYOffset()
  self._ui._crossHair:SetPosXY(crossHairPosX - self._ui._crossHair:GetSizeX() * 0.5, crossHairPosY - self._ui._crossHair:GetSizeY() * 0.5)
  self._ui._deviationMark:SetPosXY(crossHairPosX, crossHairPosY)
  if true == self._ui._crossHair:GetShow() then
    self:setHoleTarget(crossHairPosX, crossHairPosY)
  else
    self:setHoleTarget(self.centerX, self.centerY)
  end
  self:SetCircularPositioning(math.abs(gameInfo:getRadius() - self._bestRadius) * 2 + 16)
  if __eSniperGameState_AimMiniGame == gameState then
    self:animateHolePos(deltaTime)
    if true == gameInfo:isCrossHairOnTarget() then
      if true == self._ui._deviationMiss[1]:GetShow() then
        for ii = 1, #self._ui._deviationHit do
          self._ui._deviationHit[ii]:SetShow(true)
          self._ui._deviationMiss[ii]:SetShow(false)
        end
      end
    elseif true == self._ui._deviationHit[1]:GetShow() then
      for ii = 1, #self._ui._deviationHit do
        self._ui._deviationHit[ii]:SetShow(false)
        self._ui._deviationMiss[ii]:SetShow(true)
      end
    end
  elseif __eSniperGameState_Searching == gameState or __eSniperGameState_RecoverBreath == gameState then
    self:animateHolePos(deltaTime)
  end
  local breathGaugeSize = gameInfo:getRemainedBreathing() / 5
  if breathGaugeSize < 0 then
    breathGaugeSize = 0
  end
  self:UpdateBreathingGauge(gameState, breathGaugeSize, deltaTime)
  PaGlobal_MiniGame_SniperGame_All:refreshDebugText()
end
function PaGlobal_MiniGame_SniperGame_All:refreshDebugText()
  if false == ToClient_IsDevelopment() then
    return
  end
  if false == self._showDebugInfo then
    self._ui._debugText:SetShow(false)
    self._ui._middlePointDev:SetShow(false)
    return
  end
  self._ui._debugText:SetShow(true)
  self._ui._middlePointDev:SetShow(true)
  self._ui._middlePointDev:SetPosXY(self.centerX - self._ui._middlePointDev:GetSizeX() / 2, self.centerY - self._ui._middlePointDev:GetSizeY() / 2)
  local characterWrapper = ToClient_SniperGame_GetHittedCharacterActor()
  local debugMessage = ""
  if nil ~= characterWrapper then
    local selfPlayer = getSelfPlayer()
    local actorKey = characterWrapper:get():getActorKeyRaw()
    local name = characterWrapper:getName()
    local targetPos = characterWrapper:get():getPosition()
    local distance = -1
    if nil ~= selfPlayer then
      local selfPos = selfPlayer:get():getPosition()
      selfPos.x = selfPos.x - targetPos.x
      selfPos.y = selfPos.y - targetPos.y
      selfPos.z = selfPos.z - targetPos.z
      distance = math.sqrt(selfPos.x * selfPos.x + selfPos.y * selfPos.y + selfPos.z * selfPos.z)
    end
    local hitPartName = ToClient_SniperGame_GetHitPartName_DEV()
    if nil == hitPartName then
      hitPartName = "\236\151\134\236\157\140"
    end
    local distanceStr = string.format("%.3f", distance)
    local desiredFOV = string.format("%.3f", ToClient_SniperGame_GetDeisredFOV())
    local currentAccuracy = ToClient_SniperGame_GetShootAccuracy()
    local remainedBreath = string.format("%.3f", gameInfo:getRemainedBreathing())
    debugMessage = [[

ActorKey : ]] .. actorKey .. [[

Name : ]] .. name .. [[

Distance : ]] .. distanceStr .. [[

HitPart : ]] .. hitPartName .. [[

FOV : ]] .. desiredFOV .. "\n\236\160\149\237\153\149\235\143\132 : " .. currentAccuracy .. "\n\237\152\184\237\157\161 : " .. remainedBreath
  else
    debugMessage = "\237\131\128\234\178\159 \236\151\134\236\157\140"
  end
  self._ui._debugText:SetText(debugMessage)
  self._ui._debugText:SetPosXY(self.centerX + 250, self.centerY - 250)
end
function PaGlobal_MiniGame_SniperGame_All:animateHolePos(deltaTime)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local control = self._ui._hole
  if nil == control or nil == PaGlobal_MiniGame_SniperGame_All._holeTargetY or nil == PaGlobal_MiniGame_SniperGame_All._holeTargetX then
    return
  end
  local currentPosX = control:GetPosX()
  local currentPosY = control:GetPosY()
  local distanceX = PaGlobal_MiniGame_SniperGame_All._holeTargetX - currentPosX
  local distanceY = PaGlobal_MiniGame_SniperGame_All._holeTargetY - currentPosY
  local accX = distanceX / 100 * deltaTime * PaGlobal_MiniGame_SniperGame_All._holeAniSpeed
  local accY = distanceY / 100 * deltaTime * PaGlobal_MiniGame_SniperGame_All._holeAniSpeed
  control:SetPosXY(currentPosX + accX, currentPosY + accY)
  self:animateLensEffect(deltaTime)
end
function PaGlobal_MiniGame_SniperGame_All:animateLensEffect(deltaTime)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local control = self._ui._hole
  local screenPosX = control:GetParentPosX() + PaGlobal_MiniGame_SniperGame_All._holeSize * 0.5
  local screenPosY = control:GetParentPosY() + PaGlobal_MiniGame_SniperGame_All._holeSize * 0.5
  local screenRelativePosX = screenPosX / getScreenSizeX()
  local screenRelativePosY = screenPosY / getScreenSizeY()
  local powerNegate = PaGlobal_MiniGame_SniperGame_All._lensDistortionPower - 1
  if PaGlobal_MiniGame_SniperGame_All._lensDistortionPower > 1 then
    local distX = math.abs(getScreenSizeX() * 0.5 - screenPosX) / (getScreenSizeX() * 0.5)
    local distY = math.abs(getScreenSizeY() * 0.5 - screenPosY) / (getScreenSizeY() * 0.5)
    local scale = math.max(distX, distY)
    powerNegate = powerNegate * scale * scale
  end
  ToClient_SniperGame_SetLensDistortion(PaGlobal_MiniGame_SniperGame_All._lensDistortionSize, PaGlobal_MiniGame_SniperGame_All._lensDistortionPower - powerNegate, screenRelativePosX, screenRelativePosY)
end
function PaGlobal_MiniGame_SniperGame_All:setHoleTarget(xx, yy)
  local _targetRestrictX = getScreenSizeX() * 0.2
  local _targetRestrictY = getScreenSizeY() * 0.2
  if xx < _targetRestrictX then
    PaGlobal_MiniGame_SniperGame_All._holeTargetX = _targetRestrictX
  elseif xx > getScreenSizeX() - _targetRestrictX then
    PaGlobal_MiniGame_SniperGame_All._holeTargetX = getScreenSizeX() - _targetRestrictX
  else
    PaGlobal_MiniGame_SniperGame_All._holeTargetX = xx
  end
  if yy < _targetRestrictY then
    PaGlobal_MiniGame_SniperGame_All._holeTargetY = _targetRestrictY
  elseif yy > getScreenSizeY() - _targetRestrictY then
    PaGlobal_MiniGame_SniperGame_All._holeTargetY = getScreenSizeY() - _targetRestrictY
  else
    PaGlobal_MiniGame_SniperGame_All._holeTargetY = yy
  end
  PaGlobal_MiniGame_SniperGame_All._holeTargetX = PaGlobal_MiniGame_SniperGame_All._holeTargetX - PaGlobal_MiniGame_SniperGame_All._holeSize * 0.5
  PaGlobal_MiniGame_SniperGame_All._holeTargetY = PaGlobal_MiniGame_SniperGame_All._holeTargetY - PaGlobal_MiniGame_SniperGame_All._holeSize * 0.5
end
function PaGlobal_MiniGame_SniperGame_All:SetCircularPositioning(radius)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local count = #self._ui._deviationHit
  for ii = 1, count do
    self:SetImageRotateAndPos(ii, count, self._ui._deviationHit[ii], radius)
    self:SetImageRotateAndPos(ii, count, self._ui._deviationMiss[ii], radius)
  end
end
function PaGlobal_MiniGame_SniperGame_All:SetImageRotateAndPos(index, count, control, radius)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  if nil == control or nil == count or count < 1 or nil == index or index < 1 or nil == radius then
    return
  end
  local portion = (index - 1) / count
  control:SetPosXY(math.sin(2 * math.pi * portion) * radius - control:GetSizeX() * 0.5, math.cos(2 * math.pi * portion) * -radius - control:GetSizeY() * 0.5)
  control:SetRotate(2 * math.pi * portion)
end
function PaGlobal_MiniGame_SniperGame_All:UpdateBreathingGauge(gameState, gaugeSize, deltaTime)
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  local container = self._ui._breathContainer
  local containerSizeX = container:GetSizeX()
  local offsetX = containerSizeX * (1 - self._breathAndContainerRatio) / 2
  local maxSizeX = containerSizeX * self._breathAndContainerRatio
  local gauge
  if __eSniperGameState_AimMiniGame == gameState then
    self._ui._breathYellow:SetShow(true)
    self._ui._breathBlue:SetShow(false)
    gauge = self._ui._breathYellow
  else
    self._ui._breathYellow:SetShow(false)
    self._ui._breathBlue:SetShow(true)
    gauge = self._ui._breathBlue
  end
  local maxSizeY = gauge:GetSizeY()
  gauge:SetPosX(offsetX)
  gauge:SetSize(maxSizeX * gaugeSize, maxSizeY)
  if 0.99 < gaugeSize then
    container:SetShow(false)
  else
    container:SetShow(true)
  end
end
function PaGlobal_MiniGame_SniperGame_All:ShowFade()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  self._ui._fade:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._fade:SetPosXY(0, 0)
  self._ui._fade:SetAlpha(1)
  self._ui._fade:ResetVertexAni()
  self._ui._fade:SetShow(true)
end
function PaGlobal_MiniGame_SniperGame_All:FadeIn()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  self._ui._fade:ResetVertexAni()
  local aniData = self._ui._fade:addColorAnimation(0, self._startAniTimeLimit, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniData:SetStartColor(Defines.Color.C_00000000)
  aniData:SetEndColor(Defines.Color.C_FF000000)
  aniData:SetHideAtEnd(false)
end
function PaGlobal_MiniGame_SniperGame_All:FadeOut()
  if nil == Panel_MiniGame_SniperGame_All then
    return
  end
  self._ui._fade:ResetVertexAni()
  local aniData = self._ui._fade:addColorAnimation(self._startAniDelay, self._startAniTimeLimit + self._startAniDelay, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniData:SetStartColor(Defines.Color.C_FF000000)
  aniData:SetEndColor(Defines.Color.C_00000000)
  aniData:SetHideAtEnd(true)
end
