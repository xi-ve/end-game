function PaGlobal_TradeNoLink_All:initialize()
  if true == PaGlobal_TradeNoLink_All._initialize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_Trade_NoLink_All, "StaticText_Title")
  self._ui._btn_Node = UI.getChildControl(Panel_Dialog_Trade_NoLink_All, "Button_Node")
  self._ui._btn_Node:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_TradeNoLink_All:validate()
  PaGlobal_TradeNoLink_All:registerEventHandler(self._isConsole)
end
function PaGlobal_TradeNoLink_All:validate()
  if nil == Panel_Dialog_Trade_NoLink_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._btn_Node:isValidate()
  self._initialize = true
end
function PaGlobal_TradeNoLink_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_Trade_NoLink_All or false == PaGlobal_TradeNoLink_All._initialize then
    return
  end
  registerEvent("onScreenResize", "PaGlobal_TradeNoLink_All_OnScreenResize")
  if false == isConsole then
    self._ui._btn_Node:addInputEvent("Mouse_LUp", "HandleEventLUp_TradeNoLink_All_InvestNode()")
  else
  end
end
function PaGlobal_TradeNoLink_All:prepareOpen()
  if nil == Panel_Dialog_Trade_NoLink_All or true == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  PaGlobal_TradeNoLink_All_OnScreenResize()
  PaGlobal_TradeNoLink_All:open()
end
function PaGlobal_TradeNoLink_All:open()
  if nil == Panel_Dialog_Trade_NoLink_All or true == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_NoLink_All:SetShow(true)
end
function PaGlobal_TradeNoLink_All:prepareClose()
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  PaGlobal_TradeNoLink_All:close()
end
function PaGlobal_TradeNoLink_All:close()
  if nil == Panel_Dialog_Trade_NoLink_All or false == Panel_Dialog_Trade_NoLink_All:GetShow() then
    return
  end
  Panel_Dialog_Trade_NoLink_All:SetShow(false)
end
