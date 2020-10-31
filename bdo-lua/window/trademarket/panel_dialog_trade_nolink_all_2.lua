function PaGlobalFunc_TradeNoLink_All_Open()
  if nil == Panel_Dialog_Trade_MarketItemList_All or nil == Panel_Dialog_Trade_NoLink_All or true == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  PaGlobal_TradeNoLink_All:prepareOpen()
end
function PaGlobalFunc_TradeNoLink_All_Close()
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  PaGlobal_TradeNoLink_All:prepareClose()
end
function PaGlobal_TradeNoLink_All_OnScreenResize()
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_NoLink_All:ComputePos()
end
function HandleEventLUp_TradeNoLink_All_InvestNode()
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() or true == PaGlobal_TradeNoLink_All._isConsole then
    return
  end
  HandleEventLUp_TradeFunction_All_Close()
  local buttonIndex = getDialogButtonIndexByType(CppEnums.ContentsType.Contents_Explore)
  if true == _ContentsGroup_NewUI_Dialog_All then
    HandleEventLUp_DialogMain_All_FuncButton(buttonIndex)
  else
    HandleClickedFuncButton(buttonIndex)
  end
end
function PaGlobal_TradeNoLink_All_UpdatePanel(buttonShow)
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  local talker = dialog_getTalker()
  local npcActorproxy = talker:get()
  local npcPosition = npcActorproxy:getPosition()
  local npcRegionInfo = getRegionInfoByPosition(npcPosition)
  local npcTradeNodeName = npcRegionInfo:getTradeExplorationNodeName()
  PaGlobal_TradeNoLink_All._ui._stc_Title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "Lua_WindowTradeMarket_NeedInvest", "npc_tradenodename", npcTradeNodeName))
  PaGlobal_TradeNoLink_All._ui._btn_Node:SetShow(buttonShow)
end
