function PaGlobal_Manufacture_Notify_All:initialize()
  if nil == Panel_Manufacture_Notify then
    return
  end
  if true == PaGlobal_Manufacture_Notify_All._initialize then
    return
  end
  PaGlobal_Manufacture_Notify_All._ui.stc_progressBG = UI.getChildControl(Panel_Manufacture_Notify, "Static_Progress_BG")
  PaGlobal_Manufacture_Notify_All._ui.progress_manufacture = UI.getChildControl(Panel_Manufacture_Notify, "Progress2_Manufacture")
  PaGlobal_Manufacture_Notify_All._ui.txt_progressText = UI.getChildControl(Panel_Manufacture_Notify, "StaticText_Manufacture_Progress")
  PaGlobal_Manufacture_Notify_All._ui.stc_progressEffect = UI.getChildControl(Panel_Manufacture_Notify, "Static_Progress_Effect")
  PaGlobal_Manufacture_Notify_All._ui.txt_typeName = UI.getChildControl(Panel_Manufacture_Notify, "StaticText_Manufacture_Type")
  PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle = UI.getChildControl(Panel_Manufacture_Notify, "StaticText_Result_Title")
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG = UI.getChildControl(Panel_Manufacture_Notify, "Static_ResourceIcon_BG")
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon = UI.getChildControl(Panel_Manufacture_Notify, "Static_ResourceIcon")
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem = UI.getChildControl(Panel_Manufacture_Notify, "StaticText_ResourceItem")
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultBG = UI.getChildControl(Panel_Manufacture_Notify, "Static_ResultIcon_BG")
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultIcon = UI.getChildControl(Panel_Manufacture_Notify, "Static_ResultIcon")
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resultItem = UI.getChildControl(Panel_Manufacture_Notify, "StaticText_ResultItem")
  PaGlobal_Manufacture_Notify_All:setBasicSetting()
  PaGlobal_Manufacture_Notify_All:registEventHandler()
  PaGlobal_Manufacture_Notify_All:validate()
  PaGlobal_Manufacture_Notify_All._initialize = true
end
function PaGlobal_Manufacture_Notify_All:setBasicSetting()
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG:SetShow(false)
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon:SetShow(false)
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem:SetShow(false)
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultBG:SetShow(false)
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultIcon:SetShow(false)
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resultItem:SetShow(false)
  PaGlobal_Manufacture_Notify_All._defalutSpanY = Panel_Manufacture_Notify:GetSpanSize().y
  PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:SetText(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_RESULT"))
  PaGlobal_Manufacture_Notify_All._ui.stc_progressEffect:AddEffect("UI_Quest_Complete_GreenAura", true, 15, 0)
end
function PaGlobal_Manufacture_Notify_All:registEventHandler()
  if nil == Panel_Manufacture_Notify then
    return
  end
  Panel_Manufacture_Notify:RegisterUpdateFunc("PaGlobalFunc_Manufacture_Notify_All_CheckNotify")
  registerEvent("EventChangedSelfPlayerActionVariable", "PaGlobalFunc_Manufacture_Notify_All_IsManufactureChk")
  registerEvent("Event_ManufactureResultList", "PaGlobalFunc_Manufacture_Notify_All_ResponseResultItem")
end
function PaGlobal_Manufacture_Notify_All:validate()
  if nil == Panel_Manufacture_Notify then
    return
  end
  PaGlobal_Manufacture_Notify_All._ui.stc_progressBG:isValidate()
  PaGlobal_Manufacture_Notify_All._ui.progress_manufacture:isValidate()
  PaGlobal_Manufacture_Notify_All._ui.txt_progressText:isValidate()
  PaGlobal_Manufacture_Notify_All._ui.stc_progressEffect:isValidate()
  PaGlobal_Manufacture_Notify_All._ui.txt_typeName:isValidate()
  PaGlobal_Manufacture_Notify_All._ui.txt_resultTitle:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultBG:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.stc_resultIcon:isValidate()
  PaGlobal_Manufacture_Notify_All._ui_template.txt_resultItem:isValidate()
end
function PaGlobal_Manufacture_Notify_All:createResultControl(index)
  if nil == PaGlobal_Manufacture_Notify_All._item_Result[index] or nil == PaGlobal_Manufacture_Notify_All._icon_ResultBG[index] or nil == PaGlobal_Manufacture_Notify_All._icon_Result[index] then
    PaGlobal_Manufacture_Notify_All._item_Result[index] = UI.createControl(__ePAUIControl_StaticText, Panel_Manufacture_Notify, "item_Result_" .. index)
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index] = UI.createControl(__ePAUIControl_Static, Panel_Manufacture_Notify, "icon_ResultBG_" .. index)
    PaGlobal_Manufacture_Notify_All._icon_Result[index] = UI.createControl(__ePAUIControl_Static, Panel_Manufacture_Notify, "icon_Result_" .. index)
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.txt_resultItem, PaGlobal_Manufacture_Notify_All._item_Result[index])
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.stc_resultBG, PaGlobal_Manufacture_Notify_All._icon_ResultBG[index])
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.stc_resultIcon, PaGlobal_Manufacture_Notify_All._icon_Result[index])
    local gap = PaGlobal_Manufacture_Notify_All._gapY
    if true == _ContentsGroup_RenewUI then
      gap = -PaGlobal_Manufacture_Notify_All._consoleGapY
    end
    PaGlobal_Manufacture_Notify_All._item_Result[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._item_Result[index]:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._item_Result[index]:GetSpanSize().y - gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:GetSpanSize().y - gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_Result[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._icon_Result[index]:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._icon_Result[index]:GetSpanSize().y - gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_Notify_All_ShowItemTooltip(true, " .. index .. ", true)")
    PaGlobal_Manufacture_Notify_All._icon_ResultBG[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_Notify_All_ShowItemTooltip(false)")
  end
end
function PaGlobal_Manufacture_Notify_All:createResourceControl(index)
  if nil == PaGlobal_Manufacture_Notify_All._item_Resource[index] or nil == PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index] or nil == PaGlobal_Manufacture_Notify_All._icon_Resource[index] then
    PaGlobal_Manufacture_Notify_All._item_Resource[index] = UI.createControl(__ePAUIControl_StaticText, Panel_Manufacture_Notify, "item_Resource_" .. index)
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index] = UI.createControl(__ePAUIControl_Static, Panel_Manufacture_Notify, "icon_ResourceBG_" .. index)
    PaGlobal_Manufacture_Notify_All._icon_Resource[index] = UI.createControl(__ePAUIControl_Static, Panel_Manufacture_Notify, "icon_Resource_" .. index)
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem, PaGlobal_Manufacture_Notify_All._item_Resource[index])
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG, PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index])
    CopyBaseProperty(PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon, PaGlobal_Manufacture_Notify_All._icon_Resource[index])
    local gap = PaGlobal_Manufacture_Notify_All._gapY
    if true == _ContentsGroup_RenewUI then
      gap = PaGlobal_Manufacture_Notify_All._consoleGapY
    end
    PaGlobal_Manufacture_Notify_All._item_Resource[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._ui_template.txt_resourceItem:GetSpanSize().y + gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceBG:GetSpanSize().y + gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_Resource[index]:SetSpanSize(PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._ui_template.stc_resourceIcon:GetSpanSize().y + gap * (index - 1))
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_Notify_All_ShowItemTooltip(true, " .. index .. ", false)")
    PaGlobal_Manufacture_Notify_All._icon_ResourceBG[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_Notify_All_ShowItemTooltip(false)")
  end
end
function PaGlobal_Manufacture_Notify_All:clear()
  PaGlobal_Manufacture_Notify_All._data_Resource = {}
  PaGlobal_Manufacture_Notify_All._data_Result = {}
  PaGlobal_Manufacture_Notify_All._ui.progress_manufacture:SetSmoothMode(false)
  PaGlobal_Manufacture_Notify_All._ui.progress_manufacture:SetProgressRate(0)
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._item_Resource) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._icon_ResourceBG) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._icon_Resource) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._item_Result) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._icon_ResultBG) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_Manufacture_Notify_All._icon_Result) do
    value:SetShow(false)
  end
end
function PaGlobal_Manufacture_Notify_All:SetPos()
  local gapCnt = #PaGlobal_Manufacture_Notify_All._data_Resource
  Panel_Manufacture_Notify:SetSpanSize(Panel_Manufacture_Notify:GetSpanSize().x, PaGlobal_Manufacture_Notify_All._defalutSpanY + PaGlobal_Manufacture_Notify_All._gapY * gapCnt)
end
