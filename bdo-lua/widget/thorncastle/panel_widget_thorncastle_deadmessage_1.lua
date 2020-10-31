function PaGlobal_ThornCastle_DeadMessage:initialize()
  if true == PaGlobal_ThornCastle_DeadMessage._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._deadBG = UI.getChildControl(Panel_Widget_ThornCastle_DeadMessage, "Static_DeadBG")
  self._ui._dangerBG = UI.getChildControl(Panel_Widget_ThornCastle_DeadMessage, "Static_DangerBG")
  self._ui._centerBG = UI.getChildControl(Panel_Widget_ThornCastle_DeadMessage, "Static_CenterBG")
  self._ui._deadText = UI.getChildControl(self._ui._centerBG, "StaticText_DeathTitle")
  self._ui._remainTimeText = UI.getChildControl(self._ui._centerBG, "StaticText_CountDown")
  self._ui._noticeText = UI.getChildControl(self._ui._centerBG, "StaticText_Notice")
  self._ui._tipText = UI.getChildControl(self._ui._centerBG, "StaticText_GameTip")
  self._ui._btnBG = UI.getChildControl(Panel_Widget_ThornCastle_DeadMessage, "Static_ResurrectionBG")
  self._ui._reviveBtn[1] = UI.getChildControl(self._ui._btnBG, "Button_LargeButton")
  self._ui._reviveBtn[2] = UI.getChildControl(self._ui._btnBG, "Button_SmallButton")
  self._ui._btnSelectButtonCconsole = UI.getChildControl(self._ui._btnBG, "Static_SelectButton_Console")
  self._reviveCoolTime = 0
  self._reviveReqTime = 0
  PaGlobal_ThornCastle_DeadMessage:registEventHandler()
  PaGlobal_ThornCastle_DeadMessage:validate()
  self:setConsole()
  PaGlobal_ThornCastle_DeadMessage._initialize = true
end
function ThornCastle_Dead_Time_Update(upadateTime)
  local self = PaGlobal_ThornCastle_DeadMessage
  if nil == self then
    return
  end
  self._reviveCoolTime = self._reviveCoolTime - upadateTime
  if self._reviveCoolTime <= 0 then
    self._reviveCoolTime = 0
  end
  self._ui._remainTimeText:SetText(math.ceil(self._reviveCoolTime))
  self._reviveReqTime = self._reviveReqTime - upadateTime
  if self._reviveCoolTime <= 0 and 0 >= self._reviveReqTime then
    self._reviveReqTime = 1
    deadMessage_Revival(PaGlobal_DeadMessage_All._eRespawnType.respawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false)
  end
end
function PaGlobal_ThornCastle_DeadMessage:prepareOpen(killerActorKey, reviveCoolTime)
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  self._reviveCoolTime = reviveCoolTime / 1000
  self._reviveReqTime = 0
  local attacker = getCharacterActor(killerActorKey)
  local killerName = "Killer"
  if nil ~= attacker then
    killerName = attacker:getName()
  end
  self._ui._deadText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", killerName))
  self._ui._remainTimeText:SetText(tostring(self._reviveCoolTime))
  local tipIndex = math.random(1, 6)
  self._ui._tipText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_THORNCASTLE_GAMETIP_0" .. tostring(tipIndex)))
  Panel_Widget_ThornCastle_DeadMessage:RegisterUpdateFunc("ThornCastle_Dead_Time_Update")
  PaGlobal_ThornCastle_DeadMessage:setDeadMessageAni()
  ThornCastle_DeadMessage_Resize()
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  self._ui._btnBG:SetShow(true)
  self._ui._reviveBtn[2]:SetShow(true)
  PaGlobal_ThornCastle_DeadMessage:open()
end
function PaGlobal_ThornCastle_DeadMessage:open()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  Panel_Widget_ThornCastle_DeadMessage:SetShow(true)
end
function PaGlobal_ThornCastle_DeadMessage:prepareClose()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  self._reviveCoolTime = 0
  PaGlobal_ThornCastle_DeadMessage:close()
end
function PaGlobal_ThornCastle_DeadMessage:close()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  Panel_Widget_ThornCastle_DeadMessage:SetShow(false)
end
function PaGlobal_ThornCastle_DeadMessage:validate()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  self._ui._deadText:isValidate()
  self._ui._remainTimeText:isValidate()
  self._ui._tipText:isValidate()
  self._ui._noticeText:isValidate()
  self._ui._btnBG:isValidate()
  self._ui._reviveBtn[1]:isValidate()
  self._ui._reviveBtn[2]:isValidate()
  self._ui._btnSelectButtonCconsole:isValidate()
end
function PaGlobal_ThornCastle_DeadMessage:setConsole()
  if true == PaGlobal_ThornCastle_DeadMessage._isConsole then
    self._ui._btnSelectButtonCconsole:SetShow(true)
  else
    self._ui._btnSelectButtonCconsole:SetShow(false)
  end
end
function ThornCastle_DeadMessage_Resize()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  local self = PaGlobal_ThornCastle_DeadMessage
  Panel_Widget_ThornCastle_DeadMessage:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._deadBG:SetPosX((getScreenSizeX() - self._ui._deadBG:GetSizeX()) / 2)
  self._ui._deadBG:SetPosY((getScreenSizeY() - self._ui._deadBG:GetSizeY()) / 2)
  self._ui._dangerBG:SetPosX((getScreenSizeX() - self._ui._dangerBG:GetSizeX()) / 2)
  self._ui._dangerBG:SetPosY((getScreenSizeY() - self._ui._dangerBG:GetSizeY()) / 2)
  self._ui._centerBG:SetPosX((getScreenSizeX() - self._ui._centerBG:GetSizeX()) / 2)
  self._ui._centerBG:SetPosY((getScreenSizeY() - self._ui._centerBG:GetSizeY()) / 2)
  self._ui._btnBG:SetPosX((getScreenSizeX() - self._ui._btnBG:GetSizeX()) / 2)
  self._ui._btnBG:SetPosY((getScreenSizeY() - self._ui._btnBG:GetSizeY()) / 2)
  Panel_Widget_ThornCastle_DeadMessage:ComputePos()
  self._ui._deadText:ComputePos()
  self._ui._remainTimeText:ComputePos()
  self._ui._tipText:ComputePos()
  self._ui._reviveBtn[1]:SetPosY(getScreenSizeY() / 2 - 150)
  self._ui._reviveBtn[1]:SetShow(false)
  self._ui._reviveBtn[2]:SetPosY(getScreenSizeY() / 2 - 60)
  PaGlobal_ThornCastle_DeadMessage_ScreenOutCheck()
end
function PaGlobal_ThornCastle_DeadMessage_ScreenOutCheck()
  local self = PaGlobal_ThornCastle_DeadMessage
  if nil == self then
    return
  end
  local buttonArray = self._ui._reviveBtn
  if 0 < #buttonArray then
    local buttonSizeY = self._ui._reviveBtn[2]:GetSizeY()
    self._ui._btnBG:SetSize(self._ui._btnBG:GetSizeX(), (buttonSizeY + 10) * #buttonArray + 20)
    local screenGap = self._ui._btnBG:GetPosY() + self._ui._btnBG:GetSizeY() - getScreenSizeY()
    if 0 < screenGap then
      self._ui._btnBG:SetPosY(self._ui._btnBG:GetPosY() - screenGap)
    end
  end
end
function PaGlobal_ThornCastle_DeadMessage:setDeadMessageAni()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._deadText, self._aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._deadText, self._aniType._changeColor, 1.5, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._deadText, self._aniType._changeScale, 0.7, 2.5, 0.5, 1)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._remainTimeText, self._aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._remainTimeText, self._aniType._changeColor, 2, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._remainTimeText, self._aniType._changeScale, 0.7, 2.3, 0.5, 1)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._noticeText, self._aniType._changeColor, 0, 0.5, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._noticeText, self._aniType._changeColor, 2, 2.3, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._noticeText, self._aniType._changeScale, 0.7, 2.3, 0.5, 1)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._tipText, self._aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._tipText, self._aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._reviveBtn[2], self._aniType._changeColor, 0, 3, Defines.Color.C_00FFFFFF, Defines.Color.C_00FFFFFF, true)
  PaGlobal_ThornCastle_DeadMessage:setAniToControl(self._ui._reviveBtn[2], self._aniType._changeColor, 3, 4, Defines.Color.C_00FFFFFF, Defines.Color.C_FFFFFFFF, true)
end
function PaGlobal_ThornCastle_DeadMessage:setAniToControl(control, aniType, startTime, endTime, startValue, endValue, isDisable)
  if nil == control then
    return
  end
  local aniInfo
  if aniType == self._aniType._changeColor then
    aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartColor(startValue)
    aniInfo:SetEndColor(endValue)
  elseif aniType == self._aniType._changeScale then
    aniInfo = control:addScaleAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo:SetStartScale(startValue)
    aniInfo:SetEndScale(endValue)
  else
    return
  end
  aniInfo.IsChangeChild = true
  aniInfo:SetDisableWhileAni(true)
  control:SetDisableWhileAnimationChild(true)
  if true == isDisable then
    aniInfo:SetIgnoreUpdateSnapping(true)
  end
end
function PaGlobal_ThornCastle_DeadMessage:registEventHandler()
  if nil == Panel_Widget_ThornCastle_DeadMessage then
    return
  end
  registerEvent("FromClient_ThornCastleDead", "PaGlobal_FromClient_Widget_ThornCastle_SetDead")
  registerEvent("EventSelfPlayerRevive", "PaGlobal_FromClient_Widget_ThornCastle_SetRevive")
  self._ui._reviveBtn[2]:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_ThornCastle_Reqest_Revive()")
end
