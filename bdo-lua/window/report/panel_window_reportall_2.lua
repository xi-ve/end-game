function HandleEventLUp_ReportAll_SelectClassify(classify)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:SetClassify(classify)
end
function HandleEventLUp_ReportAll_SetFocusEdit()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:SetFocusEdit()
end
function HandleEventLUp_ReportAll_ReportingConfirm()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:ReportingConfirm()
end
function FromClient_NagtiveUserReport(currentCount)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:ReportingFeedBack(currentCount)
end
function FromClient_OpenReportAllWindow()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareOpen()
end
function PaGloabl_ReportAll_CheckUIEdit(targetUI)
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:CheckUIEdit()
end
function PaGloabl_ReportAll_EndFocusEdit()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:EndFocusEdit()
end
function PaGloabl_ReportAll_Open()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareOpen()
end
function PaGloabl_ReportAll_Close()
  if nil == Panel_Window_Report_All then
    return
  end
  PaGlobal_ReportAll:prepareClose()
end
