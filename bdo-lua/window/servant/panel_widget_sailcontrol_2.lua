function HandleEventLUp_SetSailControl()
  if true == PaGlobal_SailControl._isFoldable then
    local isSpread = ToClient_GetRideShipSpread()
    ToClient_SetSailSpread(not isSpread)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_CANT_FOLDSAIL"))
  end
end
function HandleEventOn_SetSailControlTooltip(isSpread)
  if nil == isSpread then
    isSpread = ToClient_GetRideShipSpread()
  end
  if true == isSpread then
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_EXPAND_DESC")
    TooltipSimple_Show(PaGlobal_SailControl._ui.btn_SailControl, title, desc)
  else
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILCONTROL_FOLD_DESC")
    TooltipSimple_Show(PaGlobal_SailControl._ui.btn_SailControl, title, desc)
  end
end
function FromClient_SailControl_PlayerRideOn(actorKeyRaw)
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if nil == vehicleActor then
    return
  end
  local servantType = vehicleActor:get():getServantType()
  if CppEnums.ServantType.Type_Ship ~= servantType then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  if 0 ~= seatPosition then
    return
  end
  PaGlobal_SailControl:reposition()
  Panel_Widget_SailControl:SetShow(true)
  PaGlobal_SailControl._isFoldable = vehicleActor:isOceanShip()
  PaGlobal_SailControl:updateCheckSail()
end
function FromClient_SailControl_PlayerRideOff()
  Panel_Widget_SailControl:SetShow(false)
end
function FromClient_SetSailControl(isSpread)
  PaGlobal_SailControl:updateCheckSail()
  if true == Panel_Tooltip_SimpleText:GetShow() then
    HandleEventOn_SetSailControlTooltip(isSpread)
  end
  local sendMsg = {}
  if true == isSpread then
    sendMsg.main = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SAILCONTROL_UNFOLD")
    sendMsg.sub = ""
  else
    sendMsg.main = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SAILCONTROL_FOLD")
    sendMsg.sub = ""
  end
  Proc_ShowMessage_Ack_For_RewardSelect(sendMsg, 3, 122)
  if true == ToClient_isConsole() then
    PaGlobalFunc_ConsoleKeyGuide_SetRideShipKeyGuide()
  end
end
function FromClient_SailControl_OnScreenResize()
  PaGlobal_SailControl:reposition()
end
registerEvent("FromClient_SetSailControl", "FromClient_SetSailControl")
