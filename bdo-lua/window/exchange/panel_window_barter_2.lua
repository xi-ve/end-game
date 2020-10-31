function PaGlobal_Barter_Close()
  PaGlobal_Barter:close()
end
function FromClient_Barter_SuccessDoBarter(regionKey)
  local barterWrapper = ToClient_barterWrapper(regionKey)
  if nil == barterWrapper then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(barterWrapper:getToItemEnchantKey())
  if nil ~= itemSSW then
    local sendMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_GETITEM", "getName", itemSSW:getName())
    Proc_ShowMessage_Ack_With_ChatType(sendMsg, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PrivateItem)
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_BARTER_SUCCESSBARTER"))
  PaGlobal_Barter:refresh()
  PaGlobalFunc_BarterInfoSearch_Refresh()
end
function FromClient_Barter_SuccessDoSpecialBarter(itemKey)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemSSW then
    local sendMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_GETITEM", "getName", itemSSW:getName())
    Proc_ShowMessage_Ack_With_ChatType(sendMsg, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PrivateItem)
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_BARTER_SUCCESSBARTER"))
  PaGlobal_Barter:refresh()
  PaGlobalFunc_BarterInfoSearch_Refresh()
end
function FromClient_Barter_UpdateBarter()
  if nil == Panel_Window_Barter then
    return
  end
  if false == Panel_Window_Barter:GetShow() then
    return
  end
  if false == PaGlobal_Barter:refresh() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoBarterInfoNotExist"))
    PaGlobal_Barter:close()
  end
end
function Update_Barter_FrameEvent(deltaTime)
  local self = PaGlobal_Barter
  if false == self._ui._normalBg:GetShow() then
    return
  end
  self._updateCurrentTime = self._updateCurrentTime + deltaTime
  if self._updateCurrentTime - self._updatePastTime < 1 then
    return
  end
  self._updatePastTime = self._updateCurrentTime
  self._ui._normal_txt_remainTime:SetText(convertStringFromDatetimeAll(ToClient_changeBarterInfoRemainSec()))
end
function FromClient_UseBarterChangeInfoItem(type)
  local str
  if __eBarterChangeInfo_AddNextUpdateTime == type then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_HOUR_EXTENSION")
  elseif __eBarterChangeInfo_ChangeNormalSeed == type then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_ITEM_RENEWAL")
  elseif __eBarterChangeInfo_ChangeAll == type then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_BARTERLIST_INITIAL")
  elseif __eBarterChangeInfo_AddChangeSeedCount == type then
    str = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_RESETCOUNT_INCREASE")
  end
  if nil ~= str then
    Proc_ShowMessage_Ack(str)
  end
end
function FromClient_NotUseBarterChangeInfoItem(remainTime_s64)
  local str = convertStringFromDatetime(remainTime_s64) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_BARTERLIST_REUSE_TEXT")
  Proc_ShowMessage_Ack(str)
end
