function PaGlobal_ShipCannon:initialize()
  if true == PaGlobal_ShipCannon._initialize then
    return
  end
  local panels = {
    [self._eCannon.left] = Panel_Widget_ShipCannon_Left,
    [self._eCannon.right] = Panel_Widget_ShipCannon_Right
  }
  self._ui._progress_powerGauge = {}
  self._ui._stc_cooltimes = {}
  self._ui._stc_cannonReady = {}
  self._ui._txt_bulletCount = {}
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._progress_powerGauge[i] = UI.getChildControl(panels[i], "CircularProgress_Press")
    self._ui._stc_cooltimes[i] = {}
    self._ui._stc_cooltimes[i][self._eCooltime.one] = UI.getChildControl(panels[i], "Static_CoolTime_1")
    self._ui._stc_cooltimes[i][self._eCooltime.two] = UI.getChildControl(panels[i], "Static_CoolTime_2")
    self._ui._stc_cooltimes[i][self._eCooltime.three] = UI.getChildControl(panels[i], "Static_CoolTime_3")
    self._ui._stc_cooltimes[i][self._eCooltime.ready] = UI.getChildControl(panels[i], "Static_CoolTime_Ready")
    self._ui._stc_cannonReady[i] = UI.getChildControl(panels[i], "Static_CannonReady")
    self._ui._txt_bulletCount[i] = UI.getChildControl(panels[i], "StaticText_BulletCount")
  end
  PaGlobal_ShipCannon:repositionAll()
  PaGlobal_ShipCannon:registEventHandler()
  PaGlobal_ShipCannon:validate()
  PaGlobal_ShipCannon._initialize = true
end
function PaGlobal_ShipCannon:registEventHandler()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  registerEvent("EventSelfPlayerRideOn", "FromClient_ShipCannon_PlayerRideOn")
  registerEvent("EventSelfPlayerRideOff", "FromClient_ShipCannon_PlayerRideOff")
  registerEvent("FromClient_UpdateCannonStatCount", "FromClient_UpdateCannonStatCount")
  registerEvent("onScreenResize", "FromClient_ShipCannon_OnScreenResize")
  registerEvent("FromClient_UpdateCannonCoolTime_Left", "FromClient_UpdateCannonCoolTime_Left")
  registerEvent("FromClient_UpdateCannonCoolTime_Right", "FromClient_UpdateCannonCoolTime_Right")
  ActionChartEventBindFunction(420, PaGloabl_ShipCannon_ActionEventGaugeFull_Left)
  ActionChartEventBindFunction(421, PaGloabl_ShipCannon_ActionEventAfterFire_Left)
  ActionChartEventBindFunction(422, PaGloabl_ShipCannon_ActionEventGaugeOne_Left)
  ActionChartEventBindFunction(423, PaGloabl_ShipCannon_ActionEventGaugeTwo_Left)
  ActionChartEventBindFunction(424, PaGloabl_ShipCannon_ActionEventHideGauge_Left)
  ActionChartEventBindFunction(425, PaGloabl_ShipCannon_ActionEventGaugeFull_Right)
  ActionChartEventBindFunction(426, PaGloabl_ShipCannon_ActionEventAfterFire_Right)
  ActionChartEventBindFunction(427, PaGloabl_ShipCannon_ActionEventGaugeOne_Right)
  ActionChartEventBindFunction(428, PaGloabl_ShipCannon_ActionEventGaugeTwo_Right)
  ActionChartEventBindFunction(429, PaGloabl_ShipCannon_ActionEventHideGauge_Right)
end
function PaGlobal_ShipCannon:prepareOpen(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    if true == Panel_Widget_ShipCannon_Left:GetShow() then
      return
    end
  elseif self._eCannon.right == eCannon and true == Panel_Widget_ShipCannon_Right:GetShow() then
    return
  end
  Panel_Widget_ShipCannon_Left:RegisterUpdateFunc("HandleEventUpdate_ShipCannon_GuageUpdateFrame")
  PaGlobal_ShipCannon:open(eCannon)
end
function PaGlobal_ShipCannon:open(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    Panel_Widget_ShipCannon_Left:SetShow(true)
  elseif self._eCannon.right == eCannon then
    Panel_Widget_ShipCannon_Right:SetShow(true)
  else
    Panel_Widget_ShipCannon_Left:SetShow(true)
    Panel_Widget_ShipCannon_Right:SetShow(true)
    PaGlobal_ShipCannon:repositionAll()
    return
  end
  PaGlobal_ShipCannon:reposition(eCannon)
end
function PaGlobal_ShipCannon:prepareClose(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    if false == Panel_Widget_ShipCannon_Left:GetShow() then
      return
    end
  elseif self._eCannon.right == eCannon and false == Panel_Widget_ShipCannon_Right:GetShow() then
    return
  end
  Panel_Widget_ShipCannon_Left:ClearUpdateLuaFunc("HandleEventUpdate_ShipCannon_GuageUpdateFrame")
  PaGlobal_ShipCannon:close(eCannon)
end
function PaGlobal_ShipCannon:close(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    Panel_Widget_ShipCannon_Left:SetShow(false)
  elseif self._eCannon.right == eCannon then
    Panel_Widget_ShipCannon_Right:SetShow(false)
  end
end
function PaGlobal_ShipCannon:update()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function PaGlobal_ShipCannon:validate()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._progress_powerGauge[i]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.one]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.two]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.three]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.ready]:isValidate()
    self._ui._stc_cannonReady[i]:isValidate()
    self._ui._txt_bulletCount[i]:isValidate()
  end
end
function PaGlobal_ShipCannon:updateCooltime(eCannon, eCooltime)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  PaGlobal_ShipCannon:hideCooltime(eCannon)
  self._ui._stc_cooltimes[eCannon][eCooltime]:SetShow(true)
  if self._eCooltime.ready == eCooltime then
    self._ui._stc_cannonReady[eCannon]:SetShow(true)
  end
end
function PaGlobal_ShipCannon:hideCooltime(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  for i = self._eCooltime.one, self._eCooltime.loopCount do
    self._ui._stc_cooltimes[eCannon][i]:SetShow(false)
  end
  self._ui._stc_cannonReady[eCannon]:SetShow(false)
end
function PaGlobal_ShipCannon:reposition(eCannon)
  if self._eCannon.left == eCannon then
    if nil ~= Panel_Widget_ShipCannon_Left and nil ~= Panel_Widget_OceanCurrent then
      Panel_Widget_ShipCannon_Left:SetPosX(Panel_Widget_OceanCurrent:GetPosX() - Panel_Widget_ShipCannon_Left:GetSizeX())
      Panel_Widget_ShipCannon_Left:SetPosY(Panel_Widget_OceanCurrent:GetPosY() + Panel_Widget_ShipCannon_Left:GetSizeY() * 0.5)
    end
  elseif self._eCannon.right == eCannon and nil ~= Panel_Widget_ShipCannon_Right and nil ~= Panel_Widget_OceanWind then
    Panel_Widget_ShipCannon_Right:SetPosX(Panel_Widget_OceanWind:GetPosX() + Panel_Widget_ShipCannon_Right:GetSizeX())
    Panel_Widget_ShipCannon_Right:SetPosY(Panel_Widget_OceanWind:GetPosY() + Panel_Widget_ShipCannon_Right:GetSizeY() * 0.5)
  end
end
function PaGlobal_ShipCannon:repositionAll()
  for i = self._eCannon.left, self._eCannon.loopCount do
    self:reposition(i)
  end
end
function PaGlobal_ShipCannon:updateBulletCount(count)
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._txt_bulletCount[i]:SetText(count)
  end
end
function PaGlobal_ShipCannon:updateGaugeAll(percent)
  self:updateGauge(self._eCannon.left, percent)
  self:updateGauge(self._eCannon.right, percent)
end
function PaGlobal_ShipCannon:updateGauge(eCannon, percent)
  self._ui._progress_powerGauge[eCannon]:SetProgressRate(percent)
end
function PaGlobal_ShipCannon:SetShowGuageAll(isShow)
  self:SetShowGuage(self._eCannon.left, isShow)
  self:SetShowGuage(self._eCannon.right, isShow)
end
function PaGlobal_ShipCannon:SetShowGuage(eCannon, isShow)
  self._ui._progress_powerGauge[eCannon]:SetShow(isShow)
end
function PaGlobal_ShipCannon:hideGuageAndCache()
  self:SetShowGuageAll(false)
  self.currentPower = ToClient_getCommonGauge()
  self:updateGaugeAll(0)
end
