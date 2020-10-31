function PaGlobal_ReportAll:initialize()
  if true == PaGlobal_ReportAll._initialize then
    return
  end
  PaGlobal_ReportAll._ui._stc_Title = UI.getChildControl(Panel_Window_Report_All, "Static_TitleBg")
  PaGlobal_ReportAll._ui._btn_Close = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Title, "Button_Close")
  PaGlobal_ReportAll._ui._stc_Main = UI.getChildControl(Panel_Window_Report_All, "Static_Main")
  PaGlobal_ReportAll._ui._stc_ContentTitle = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "StaticText_ContentTitle")
  PaGlobal_ReportAll._ui._stc_ContentTitle:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_ReportAll._ui._stc_ContentTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPORT_CONTENTTITLE"))
  PaGlobal_ReportAll._ui._rdo_Classifys[1] = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "RadioButton_1")
  local posY = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosY()
  local posX1 = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosX()
  local posX2 = PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetPosX() + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeX() + 3
  PaGlobal_ReportAll._ui._rdo_Classifys[1]:SetShow(false)
  for recordIndex = 2, self._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex] = UI.cloneControl(PaGlobal_ReportAll._ui._rdo_Classifys[1], PaGlobal_ReportAll._ui._stc_Main, "RadioButton_" .. recordIndex)
    if 1 == recordIndex % 2 then
      posY = posY + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 2
      PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosX(posX1)
    else
      PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosX(posX2)
    end
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetPosY(posY)
    PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex]:SetShow(false)
    ToClient_padSnapRefreshTarget(PaGlobal_ReportAll._ui._rdo_Classifys[recordIndex])
  end
  PaGlobal_ReportAll._ui._btn_Confirm = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Button_Report")
  PaGlobal_ReportAll._ui._btn_Cancle = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Button_Cancel")
  PaGlobal_ReportAll._ui._stc_Line = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "Static_Line")
  PaGlobal_ReportAll._ui._stc_NoTarget = UI.getChildControl(PaGlobal_ReportAll._ui._stc_Main, "StaticText_NoTarget")
  PaGlobal_ReportAll._ui._btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  PaGlobal_ReportAll:registEventHandler()
  PaGlobal_ReportAll._initialize = true
end
function PaGlobal_ReportAll:registEventHandler()
  if nil == Panel_Window_Report_All then
    return
  end
  for i = 1, PaGlobal_ReportAll._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_ReportAll_SelectClassify(" .. i .. ")")
  end
  PaGlobal_ReportAll._ui._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ReportAll_ReportingConfirm()")
  PaGlobal_ReportAll._ui._btn_Cancle:addInputEvent("Mouse_LUp", "PaGloabl_ReportAll_Close()")
  PaGlobal_ReportAll._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_ReportAll_Close()")
  registerEvent("FromClient_NagtiveUserReport", "FromClient_NagtiveUserReport")
  registerEvent("FromClient_OpenReportWindow", "FromClient_OpenReportAllWindow")
end
function PaGlobal_ReportAll:prepareOpen()
  if false == ToClient_IsContentsGroupOpen("1392") then
    return
  end
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll._value.classify = nil
  PaGlobal_ReportAll._value.selcetedHideCharater = ""
  PaGlobal_ReportAll._ui._stc_NoTarget:SetShow(false)
  PaGlobal_ReportAll:open()
end
function PaGlobal_ReportAll:open()
  if false == ToClient_IsContentsGroupOpen("1392") then
    return
  end
  if nil == Panel_Window_Report_All then
    return
  end
  Panel_Window_Report_All:SetShow(true)
  PaGlobal_ReportAll:update()
end
function PaGlobal_ReportAll:update()
  if nil == Panel_Window_Report_All then
    return
  end
  local count = ToClient_GetNearestHackUserForReport()
  local linePosY = 0
  for index = 1, count do
    local userInfo = ToClient_GetNearUserInfoByIndex(index - 1)
    if nil ~= userInfo then
      local name = userInfo:getName()
      local className = CppEnums.ClassType2String[userInfo:getClassType()]
      if "" == name and CppEnums.ClassType2String[userInfo:getClassType()] ~= nil then
        name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_REPORT_HIDEONE", "className", className)
      else
        name = name .. "(" .. className .. ")"
      end
      PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetText(name)
      PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetShow(true)
      linePosY = PaGlobal_ReportAll._ui._rdo_Classifys[index]:GetPosY()
    end
  end
  local buttonAreaSize = (count + 1) / 2 * PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 90
  if count <= 0 then
    PaGlobal_ReportAll._ui._stc_NoTarget:SetShow(true)
  end
  local sizeY = buttonAreaSize + PaGlobal_ReportAll._ui._stc_Title:GetSizeY() + PaGlobal_ReportAll._ui._stc_ContentTitle:GetSizeY() + 90
  PaGlobal_ReportAll._ui._stc_Main:SetSize(650, buttonAreaSize)
  PaGlobal_ReportAll._ui._stc_ContentTitle:SetPosY(buttonAreaSize)
  local buttonPosY = PaGlobal_ReportAll._ui._stc_ContentTitle:GetPosY() + PaGlobal_ReportAll._ui._stc_ContentTitle:GetSizeY() + 15
  PaGlobal_ReportAll._ui._btn_Confirm:SetPosY(buttonPosY)
  PaGlobal_ReportAll._ui._btn_Cancle:SetPosY(buttonPosY)
  PaGlobal_ReportAll._ui._stc_Line:SetPosY(linePosY + PaGlobal_ReportAll._ui._rdo_Classifys[1]:GetSizeY() + 10)
  Panel_Window_Report_All:SetSize(Panel_Window_Report_All:GetSizeX(), sizeY)
end
function PaGlobal_ReportAll:prepareClose()
  if nil == Panel_Window_Report_All then
    return
  end
  for index = 1, self._value.classifyCount do
    PaGlobal_ReportAll._ui._rdo_Classifys[index]:SetShow(false)
  end
  if nil ~= PaGlobal_ReportAll._value.classify then
    PaGlobal_ReportAll._ui._rdo_Classifys[PaGlobal_ReportAll._value.classify]:SetUnchecked()
  end
  PaGlobal_ReportAll:close()
end
function PaGlobal_ReportAll:close()
  if nil == Panel_Window_Report_All then
    return
  end
  Panel_Window_Report_All:SetShow(false)
end
function PaGlobal_ReportAll:ReportingConfirm()
  if nil == Panel_Window_Report_All then
    return
  end
  if nil == PaGlobal_ReportAll._value.classify then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  local reportConfirmYes = function()
    PaGlobal_ReportAll:prepareClose()
    ToClient_HackUserReport(PaGlobal_ReportAll._value.classify - 1, PaGlobal_ReportAll._value.selcetedHideCharater)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REPORT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_MESSAGECONFIRM"),
    functionYes = reportConfirmYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_ReportAll:SetClassify(classify)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll._value.classify = classify
  PaGlobal_ReportAll._value.selcetedHideCharater = PaGlobal_ReportAll._ui._rdo_Classifys[classify]:GetText()
end
function PaGlobal_ReportAll:ReportingFeedBack(currentCount)
  if 0 < 3 - currentCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_RECEIVEREPORT") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEGAME_REMAINCOUNT", "tryCount", 2 - currentCount))
  else
    Proc_ShowMessage_Ack(PAGetStringSymNo(3038419446))
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REPORT_REPORTCOMPLETE_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORT_COMPLETE_WITHNAME", "name", ToClient_GetReportCharacterName()) .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_REPORT_COMPLETE_INFO"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
