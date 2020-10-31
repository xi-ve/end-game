function PaGlobal_EdanPass:initialize()
  if true == PaGlobal_EdanPass._initialize then
    return
  end
  self:controlInit()
  self:controlSetShow()
  PaGlobal_EdanPass:registEventHandler()
  PaGlobal_EdanPass:validate()
  PaGlobal_EdanPass._initialize = true
end
function PaGlobal_EdanPass:controlInit()
  if nil == Panel_UndertheSea then
    return
  end
  self._ui.stc_titlebg = UI.getChildControl(Panel_UndertheSea, "Static_TitleBg")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_titlebg, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titlebg, "Button_Close")
  self._ui.btn_ok = UI.getChildControl(Panel_UndertheSea, "Button_1")
  self._ui.list2_list = UI.getChildControl(Panel_UndertheSea, "List2_List")
end
function PaGlobal_EdanPass:prepareOpen()
  if nil == Panel_UndertheSea then
    return
  end
  local edanPassListSize = ToClient_GetEdanPassListSize()
  self._ui.list2_list:getElementManager():clearKey()
  for index = 0, edanPassListSize - 1 do
    self._ui.list2_list:getElementManager():pushKey(toInt64(0, index))
  end
  PaGlobal_EdanPass:open()
end
function PaGlobal_EdanPass:controlSetShow()
  if nil == Panel_UndertheSea then
    return
  end
  self._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_LIST"))
  self._ui.btn_ok:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_OK_BUTTON_TEXT"))
  self._ui.stc_title:SetShow(true)
  self._ui.btn_close:SetShow(true)
  self._ui.btn_ok:SetShow(true)
end
function PaGlobal_EdanPass:open()
  if nil == Panel_UndertheSea then
    return
  end
  Panel_UndertheSea:SetShow(true)
end
function PaGlobal_EdanPass:prepareClose()
  if nil == Panel_UndertheSea then
    return
  end
  PaGlobal_EdanPass:close()
end
function PaGlobal_EdanPass:close()
  if nil == Panel_UndertheSea then
    return
  end
  Panel_UndertheSea:SetShow(false)
end
function PaGlobal_EdanPass:registEventHandler()
  if nil == Panel_UndertheSea then
    return
  end
  registerEvent("onScreenResize", "FromClient_EdanPass_ReSizePanel()")
  self._ui.btn_ok:addInputEvent("Mouse_LUp", "HandleEventEnter_EdanPass_ClickOK()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventEnter_EdanPass_ClickClose()")
  self._ui.list2_list:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SA_Widget_EdanPass_CreateListControl")
  self._ui.list2_list:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_EdanPass:validate()
  if nil == Panel_UndertheSea then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_ok:isValidate()
end
function PaGlobal_EdanPass:edanPassListUpdate(control, index)
  local itemIconPath = ToClient_getEdanPassIconPath()
  local listIdx = Int64toInt32(index)
  if nil == control then
    return
  end
  local edanPassName = ToClient_GetEdanPassListElementString(listIdx)
  local contentButton = UI.getChildControl(control, "RadioButton_1")
  local contentText = UI.getChildControl(contentButton, "StaticText_Title")
  local countText = UI.getChildControl(contentButton, "StaticText_count")
  local speedText = UI.getChildControl(contentButton, "StaticText_Speed")
  local minCost = ToClient_CaculateEdanPassMinCostByIndex(listIdx)
  contentButton:addInputEvent("Mouse_LUp", "HandleEventEnter_EdanPass_ClickEdanPass(" .. tostring(listIdx) .. ")")
  contentText:SetText(edanPassName)
  countText:SetText(minCost)
  if nil ~= itemIconPath then
    countText:ChangeTextureInfoName("icon/" .. itemIconPath)
  end
  speedText:SetText(minCost)
end
function PaGlobal_EdanPass:RegisterCloseLuaFunc()
  PaGlobal_EdanPass:prepareClose()
end
