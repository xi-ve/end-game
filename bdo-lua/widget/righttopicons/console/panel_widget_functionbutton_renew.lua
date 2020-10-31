Widget_Function_Type_Renew = {
  SiegeWarCall = 1,
  BusterCall = 2,
  SummonPartyCall = 3,
  ReturnTown = 4,
  count = 5
}
local FunctionButton = {
  _ui = {
    _stc_siegeWarCall = UI.getChildControl(Panel_Widget_FunctionButton_Renew, "Button_SiegeWarCall"),
    _stc_busterCall = UI.getChildControl(Panel_Widget_FunctionButton_Renew, "Button_BusterCall"),
    _stc_summonPartyCall = UI.getChildControl(Panel_Widget_FunctionButton_Renew, "Button_PartySummon"),
    _stc_returnTown = UI.getChildControl(Panel_Widget_FunctionButton_Renew, "Button_ReturnTown")
  },
  _button = {
    [Widget_Function_Type_Renew.SiegeWarCall] = nil,
    [Widget_Function_Type_Renew.BusterCall] = nil,
    [Widget_Function_Type_Renew.SummonPartyCall] = nil,
    [Widget_Function_Type_Renew.ReturnTown] = nil
  },
  _buttonShow = {
    [Widget_Function_Type_Renew.SiegeWarCall] = false,
    [Widget_Function_Type_Renew.BusterCall] = false,
    [Widget_Function_Type_Renew.SummonPartyCall] = false,
    [Widget_Function_Type_Renew.ReturnTown] = false
  },
  _isTimeDisplay = {
    [Widget_Function_Type_Renew.SiegeWarCall] = false,
    [Widget_Function_Type_Renew.BusterCall] = false,
    [Widget_Function_Type_Renew.SummonPartyCall] = false,
    [Widget_Function_Type_Renew.ReturnTown] = false
  },
  _buttonIntervalX = 0,
  _panel = Panel_Widget_FunctionButton_Renew
}
function FunctionButton:initControl()
  self._button[Widget_Function_Type_Renew.SiegeWarCall] = self._ui._stc_siegeWarCall
  self._button[Widget_Function_Type_Renew.BusterCall] = self._ui._stc_busterCall
  self._button[Widget_Function_Type_Renew.SummonPartyCall] = self._ui._stc_summonPartyCall
  self._button[Widget_Function_Type_Renew.ReturnTown] = self._ui._stc_returnTown
end
function FunctionButton:registEventHandler()
  registerEvent("FromClient_ResponseBustCall", "FromClient_Widget_FunctionButton_ResponseBustCall")
  registerEvent("FromClient_ResponseTeleportToSiegeTent", "FromClient_Widget_FunctionButton_ResponseTeleportToSiegeTent")
  registerEvent("FromClient_ResponseUseCompass", "FromClient_Widget_FunctionButton_ResponseUseCompass")
  registerEvent("ResponseParty_updatePartyList", "PaGlobalFunc_Widget_FunctionButton_Check_PartySummon")
  registerEvent("FromClient_ResponseUseReturnStone", "FromClient_Widget_FunctionButton_ResponseUseReturnStone")
  registerEvent("onScreenResize", "FromClient_FunctionButton_OnResize")
end
function FunctionButton:initialize()
  self:initControl()
  self:updateAllButton()
  self:registEventHandler()
end
function FromClient_Widget_FunctionButton_ResponseBustCall(sendType)
  local self = FunctionButton
  if 0 == sendType then
    self._isTimeDisplay[Widget_Function_Type_Renew.BusterCall] = true
    luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall, 600000, false, 0)
  else
    self._isTimeDisplay[Widget_Function_Type_Renew.BusterCall] = false
  end
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall()
  local self = FunctionButton
  self._isTimeDisplay[Widget_Function_Type_Renew.BusterCall] = false
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_GuildBusterCall()
  local self = FunctionButton
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetGuildBustCallPos())
  if nil == regionInfoWrapper then
    self._isTimeDisplay[Widget_Function_Type_Renew.BusterCall] = false
    return
  end
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetGuildBustCallTime()))
  self._isTimeDisplay[Widget_Function_Type_Renew.SiegeWarCall] = 0 < leftTime
  luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall, leftTime * 1000, false, 0)
  self:updateAllButton()
end
function FromClient_Widget_FunctionButton_ResponseTeleportToSiegeTent(sendType)
  local self = FunctionButton
  if 0 == sendType then
    self._isTimeDisplay[Widget_Function_Type_Renew.SiegeWarCall] = true
    luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall, 600000, false, 0)
  else
    self._isTimeDisplay[Widget_Function_Type_Renew.SiegeWarCall] = false
  end
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall()
  local self = FunctionButton
  self._isTimeDisplay[Widget_Function_Type_Renew.BusterCall] = false
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()
  local self = FunctionButton
  local minorSiegeWrapper = ToClient_GetCurrentMinorSiegeWrapper()
  if nil == minorSiegeWrapper then
    return
  end
  if false == minorSiegeWrapper:isSiegeBeing() then
    PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall()
    return
  end
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportToSiegeTentPos())
  if nil == regionInfoWrapper then
    PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall()
    return
  end
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetTeleportToSiegeTentTime()))
  self._isTimeDisplay[Widget_Function_Type_Renew.SiegeWarCall] = 0 < leftTime
  luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall, leftTime * 1000, false, 0)
  self:updateAllButton()
end
function FromClient_Widget_FunctionButton_ResponseUseCompass()
  local self = FunctionButton
  self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = false
  PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  self:updateAllButton()
  local partyName = ""
  partyName = ToClient_GetCharacterNameUseCompass()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local msg = ""
  if partyActorKey == playerActorKey then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_COMPASS_MESSAGE_1")
  else
    msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPASS_MESSAGE_2", "partyName", partyName)
  end
  Proc_ShowMessage_Ack(msg)
  luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_PartySummon, 600000, false, 0)
end
function PaGlobalFunc_Widget_FunctionButton_Close_PartySummon()
  local self = FunctionButton
  self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = false
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  local self = FunctionButton
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local remainTime = Int64toInt32(ToClient_GetLeftUsableTeleportCompassTime())
  if 0 < remainTime then
    if partyActorKey ~= playerActorKey then
      if 0 < RequestParty_getPartyMemberCount() then
        self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = true
      else
        self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = false
      end
    else
      self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = false
    end
    luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_PartySummon, remainTime * 1000, false, 0)
  else
    self._isTimeDisplay[Widget_Function_Type_Renew.SummonPartyCall] = false
  end
  self:updateAllButton()
end
function FromClient_Widget_FunctionButton_ResponseUseReturnStone()
  local self = FunctionButton
  local pos3D = ToClient_GetPosUseReturnStone()
  ToClient_DeleteNaviGuideByGroup(0)
  worldmapNavigatorStart(pos3D, NavigationGuideParam(), false, false)
  PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  self:updateAllButton()
  self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown, 1800000, false, 0)
end
function PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown()
  local self = FunctionButton
  self._returnTownTimerKey = nil
  self._isTimeDisplay[Widget_Function_Type_Renew.ReturnTown] = false
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  local self = FunctionButton
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  local regionName = ""
  if nil ~= regionInfo then
    regionName = regionInfo:getAreaName()
  end
  local returnTownRegionKey = ToClient_GetReturnStoneTownRegionKey()
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(usableTime64)
  if 0 < remainTime then
    if nil == self._returnTownTimerKey then
      self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown, remainTime * 1000, false, 0)
    end
    self._isTimeDisplay[Widget_Function_Type_Renew.ReturnTown] = true
  else
    self._isTimeDisplay[Widget_Function_Type_Renew.ReturnTown] = false
  end
  self:updateAllButton()
end
function FunctionButton:updateAllButton()
  local spanPosX = 0
  for index = 1, Widget_Function_Type_Renew.count - 1 do
    if nil ~= self._buttonShow[index] then
      self:checkButtonStatus(index)
      self._button[index]:SetShow(self._buttonShow[index])
      if true == self._buttonShow[index] then
        self._button[index]:SetSpanSize(spanPosX, 0)
        spanPosX = spanPosX + (self._button[index]:GetSizeX() + self._buttonIntervalX)
      end
    end
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  if true == isGuildMaster then
  end
end
function FunctionButton:checkButtonStatus(buttonType)
  if buttonType == Widget_Function_Type_Renew.SiegeWarCall then
    self._buttonShow[buttonType] = self._isTimeDisplay[buttonType]
  elseif buttonType == Widget_Function_Type_Renew.BusterCall then
    self._buttonShow[buttonType] = self._isTimeDisplay[buttonType]
  elseif buttonType == Widget_Function_Type_Renew.SummonPartyCall then
    self._buttonShow[buttonType] = self._isTimeDisplay[buttonType]
  elseif buttonType == Widget_Function_Type_Renew.ReturnTown then
    self._buttonShow[buttonType] = self._isTimeDisplay[buttonType]
  end
end
function FGlobal_GetPersonalIconControl()
end
function PaGlobalFunc_Widget_FunctionButton_Control(buttonType)
  local self = FunctionButton
  if nil ~= self._button[buttonType] then
    return self._button[buttonType]
  end
end
function FGlobal_GetPersonalText(index)
end
function FGlobal_GetPersonalIconPosX()
  return Panel_Widget_FunctionButton_Renew:GetPosX()
end
function FGlobal_GetPersonalIconPosY()
  return Panel_Widget_FunctionButton_Renew:GetPosY()
end
function FGlobal_GetPersonalIconSizeX()
  return Panel_Widget_FunctionButton_Renew:GetSizeX()
end
function FGlobal_GetPersonalIconSizeY()
  return Panel_Widget_FunctionButton_Renew:GetSizeY()
end
function FromClient_Widget_FunctionButtonRenew_Init()
  local self = FunctionButton
  self:initialize()
  self._panel:SetShow(true)
  PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()
  PaGlobalFunc_Widget_FunctionButton_Check_GuildBusterCall()
  PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  FromClient_FunctionButton_OnResize()
end
function FromClient_FunctionButton_OnResize()
  local self = FunctionButton
  local SizeX = Panel_Widget_FunctionButton_Renew:GetSizeX()
  local RadarPosX = FGlobal_Panel_Radar_GetPosX()
  Panel_Widget_FunctionButton_Renew:SetPosX(RadarPosX - SizeX)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_FunctionButtonRenew_Init")
registerEvent("EventLordMenuPayInfoUpdate", "PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()")
