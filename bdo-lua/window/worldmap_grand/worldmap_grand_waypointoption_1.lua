function PaGlobal_Worldmap_Grand_WaypointOption:initialize()
  if nil == Panel_Worldmap_WaypointOption then
    return
  end
  if true == self._initialize then
    return
  end
  self._ui._title = UI.getChildControl(Panel_Worldmap_WaypointOption, "StaticText_Title")
  self._ui._mainBG = UI.getChildControl(Panel_Worldmap_WaypointOption, "Static_MainBG")
  local uiTemp = UI.getChildControl(Panel_Worldmap_WaypointOption, "Static_WaypointTypeGroup")
  for idx = 1, self._optionCount do
    self._ui._typeOptionBtn[idx] = UI.getChildControl(uiTemp, "RadioButton_Type" .. tostring(idx))
  end
  uiTemp = UI.getChildControl(Panel_Worldmap_WaypointOption, "Static_WaypointStyleGroup")
  for idx = 1, self._optionCount do
    self._ui._styleOptionBtn[idx] = UI.getChildControl(uiTemp, "RadioButton_Style" .. tostring(idx))
  end
  self._ui._typeOptionBtnDesc = UI.getChildControl(Panel_Worldmap_WaypointOption, "StaticText_TypeDesc")
  self._ui._typeOptionBtnDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._typeOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTTYPEOPTION_TYPE1_DESC"))
  self._ui._styleOptionBtnDesc = UI.getChildControl(Panel_Worldmap_WaypointOption, "StaticText_StyleDesc")
  self._ui._styleOptionBtnDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._styleOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ETC_AUTONAVIMOVETYPE_0_DESC"))
  self._applyBtn = UI.getChildControl(Panel_Worldmap_WaypointOption, "Button_Apply")
  self._deleteBtn = UI.getChildControl(Panel_Worldmap_WaypointOption, "Button_Delete")
  self._closeBtn = UI.getChildControl(Panel_Worldmap_WaypointOption, "Button_Close")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Worldmap_Grand_WaypointOption:registEventHandler()
  if nil == Panel_Worldmap_WaypointOption then
    return
  end
  for idx = 1, self._optionCount do
    self._ui._typeOptionBtn[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointTypeOption_SetOption(" .. tostring(idx - 1) .. ")")
    self._ui._styleOptionBtn[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointStyleOption_SetOption(" .. tostring(idx - 1) .. ")")
  end
  self._applyBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointOption_Apply()")
  self._deleteBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointOption_Close()")
  self._closeBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointOption_Close()")
end
function PaGlobal_Worldmap_Grand_WaypointOption:validate()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  self._ui._title:isValidate()
  self._ui._mainBG:isValidate()
  for idx = 1, self._optionCount do
    self._ui._typeOptionBtn[idx]:isValidate()
    self._ui._styleOptionBtn[idx]:isValidate()
  end
  self._ui._typeOptionBtnDesc:isValidate()
  self._ui._styleOptionBtnDesc:isValidate()
  self._applyBtn:isValidate()
  self._deleteBtn:isValidate()
  self._closeBtn:isValidate()
end
function PaGlobal_Worldmap_Grand_WaypointOption:prepareOpen()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_Worldmap_Grand_WaypointOption:open()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  self._targetTypeOption = ToClient_GetWorldMapNaviGuidePathMode()
  self._targetStyleOption = ToClient_getGameOptionControllerWrapper():getAutomaticGuideSmooth()
  for idx = 1, self._optionCount do
    self._ui._typeOptionBtn[idx]:SetCheck(false)
    self._ui._styleOptionBtn[idx]:SetCheck(false)
  end
  if 0 == self._targetTypeOption then
    self._ui._typeOptionBtn[1]:SetCheck(true)
    self._ui._typeOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTTYPEOPTION_TYPE1_DESC"))
  else
    self._ui._typeOptionBtn[2]:SetCheck(true)
    self._ui._typeOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTTYPEOPTION_TYPE2_DESC"))
  end
  if false == self._targetStyleOption then
    self._ui._styleOptionBtn[1]:SetCheck(true)
    self._ui._styleOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ETC_AUTONAVIMOVETYPE_0_DESC"))
  else
    self._ui._styleOptionBtn[2]:SetCheck(true)
    self._ui._styleOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ETC_AUTONAVIMOVETYPE_1_DESC"))
  end
  Panel_Worldmap_WaypointOption:SetShow(true)
end
function PaGlobal_Worldmap_Grand_WaypointOption:prepareClose()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  self:close()
end
function PaGlobal_Worldmap_Grand_WaypointOption:close()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  WorldMapPopupManager:pop()
  Panel_Worldmap_WaypointOption:SetShow(false)
end
function PaGlobal_Worldmap_Grand_WaypointOption:update()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
end
function PaGlobal_Worldmap_Grand_WaypointOption:apply()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
end
function PaGlobal_Worldmap_Grand_WaypointOption:setTypeOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  if self._targetTypeOption == option then
    return
  end
  self._targetTypeOption = option
  if 0 == self._targetTypeOption then
    self._ui._typeOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTTYPEOPTION_TYPE1_DESC"))
  else
    self._ui._typeOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTTYPEOPTION_TYPE2_DESC"))
  end
  ToClient_SetWorldMapNaviGuidePathMode(self._targetTypeOption)
end
function PaGlobal_Worldmap_Grand_WaypointOption:setStyleOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  if self._targetStyleOption == option then
    return
  end
  self._targetStyleOption = option
  if 0 == self._targetStyleOption then
    self._ui._styleOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ETC_AUTONAVIMOVETYPE_0_DESC"))
  else
    self._ui._styleOptionBtnDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_FUNCTION_ETC_AUTONAVIMOVETYPE_1_DESC"))
  end
  ToClient_SetAutomaticGuideSmooth(self._targetStyleOption)
end
