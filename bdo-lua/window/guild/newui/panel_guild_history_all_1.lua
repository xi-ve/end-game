function PaGlobal_Guild_History_All:initialize()
  if true == PaGlobal_Guild_History_All._initialize or nil == Panel_Guild_History_All then
    return
  end
  self._ui.stc_topArea = UI.getChildControl(Panel_Guild_History_All, "Static_TopArea")
  self._ui.btn_left = UI.getChildControl(self._ui.stc_topArea, "Button_Left")
  self._ui.btn_right = UI.getChildControl(self._ui.stc_topArea, "Button_Right")
  self._ui.txt_titleYear = UI.getChildControl(self._ui.stc_topArea, "StaticText_Year")
  self._ui.rdo_titleMonth = UI.getChildControl(self._ui.stc_topArea, "RadioButton_Month")
  self._ui.stc_line = UI.getChildControl(self._ui.stc_topArea, "Static_HorizonLine")
  self._ui.stc_mainArea = UI.getChildControl(Panel_Guild_History_All, "Static_MainArea")
  self._ui.frame_history = UI.getChildControl(self._ui.stc_mainArea, "Frame_History")
  self._ui.frameContent = UI.getChildControl(self._ui.frame_history, "Frame_1_Content")
  self._ui.frameScroll = UI.getChildControl(self._ui.frame_history, "Frame_1_VerticalScroll")
  self._ui.txt_date = UI.getChildControl(self._ui.stc_mainArea, "StaticText_Year")
  self._ui.stc_verticalLine = UI.getChildControl(self._ui.stc_mainArea, "Static_VerticalLine")
  self._ui.stc_leftWing = UI.getChildControl(self._ui.stc_mainArea, "Static_LeftWing")
  self._ui.stc_rightWing = UI.getChildControl(self._ui.stc_mainArea, "Static_RightWing")
  self._ui.txt_leftDay = UI.getChildControl(self._ui.stc_mainArea, "StaticText_LeftDay")
  self._ui.txt_rightDay = UI.getChildControl(self._ui.stc_mainArea, "StaticText_RightDay")
  self._ui.txt_leftHistory = UI.getChildControl(self._ui.stc_mainArea, "StaticText_LeftHistory")
  self._ui.txt_rightHistory = UI.getChildControl(self._ui.stc_mainArea, "StaticText_RightHistory")
  for index = 1, 12 do
    self._ui._monthControl[index] = UI.createControl(__ePAUIControl_RadioButton, self._ui.stc_topArea, "RadioButton_Month_" .. index)
    CopyBaseProperty(self._ui.rdo_titleMonth, self._ui._monthControl[index])
    self._ui._monthControl[index]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_MONTH", "month", index))
    self._ui._monthControl[index]:SetSpanSize(200 + (self._ui._monthControl[index]:GetSizeX() + 10) * index, 0)
    self._ui._monthControl[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_History_All_MonthCheck(" .. index .. ")")
    self._ui._monthControl[index]:SetShow(true)
  end
  PaGlobal_Guild_History_All._isConsole = _ContentsGroup_RenewUI
  PaGlobal_Guild_History_All:setDefaultData()
  PaGlobal_Guild_History_All:registEventHandler()
  PaGlobal_Guild_History_All:switchPlatform()
  PaGlobal_Guild_History_All:validate()
  PaGlobal_Guild_History_All._initialize = true
end
function PaGlobal_Guild_History_All:registEventHandler()
  if nil == Panel_Guild_History_All then
    return
  end
  registerEvent("FromClient_JournalInfo_UpdateText", "FromClient_Guild_History_All_Update")
end
function PaGlobal_Guild_History_All:setDefaultData()
  PaGlobal_Guild_History_All._ui.frameScroll:SetShow(false)
  PaGlobal_Guild_History_All._ui.frame_history:SetIgnore(false)
  PaGlobal_Guild_History_All._noScroll_FrameSize = PaGlobal_Guild_History_All._ui.frame_history:GetSizeY()
  PaGlobal_Guild_History_All._ui.txt_date:SetShow(false)
  PaGlobal_Guild_History_All._ui.stc_verticalLine:SetShow(false)
  PaGlobal_Guild_History_All._ui.stc_leftWing:SetShow(false)
  PaGlobal_Guild_History_All._ui.stc_rightWing:SetShow(false)
  PaGlobal_Guild_History_All._ui.txt_leftDay:SetShow(false)
  PaGlobal_Guild_History_All._ui.txt_rightDay:SetShow(false)
  PaGlobal_Guild_History_All._ui.txt_leftHistory:SetShow(false)
  PaGlobal_Guild_History_All._ui.txt_rightHistory:SetShow(false)
  PaGlobal_Guild_History_All._year = ToClient_GetThisYear()
  PaGlobal_Guild_History_All._month = ToClient_GetThisMonth()
  PaGlobal_Guild_History_All._day = ToClient_GetToday()
  HandleEventLUp_Guild_History_All_YearCheck(PaGlobal_Guild_History_All._year - PaGlobal_Guild_History_All._firstLogYearValue)
  HandleEventLUp_Guild_History_All_MonthCheck(PaGlobal_Guild_History_All._month)
end
function PaGlobal_Guild_History_All:switchPlatform()
end
function PaGlobal_Guild_History_All:prepareOpen()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_History_All:dataUpdate()
  PaGlobal_Guild_History_All:open()
end
function PaGlobal_Guild_History_All:open()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_History_All:SetShow(true)
end
function PaGlobal_Guild_History_All:prepareClose()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_History_All:close()
end
function PaGlobal_Guild_History_All:close()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_History_All:SetShow(false)
end
function PaGlobal_Guild_History_All:dataUpdate()
  if true == PaGlobal_Guild_History_All._firstOpenCheck then
    PaGlobal_Guild_History_All._firstOpenCheck = false
    PaGlobal_Guild_History_All._haveInfoMonth = ToClient_GetThisMonth()
    return
  end
  ToClient_RequestJournalList(PaGlobal_Guild_History_All._year, PaGlobal_Guild_History_All._month, PaGlobal_Guild_History_All._guildHistory)
end
function PaGlobal_Guild_History_All:validate()
  self._ui.stc_topArea:isValidate()
  self._ui.btn_left:isValidate()
  self._ui.btn_right:isValidate()
  self._ui.txt_titleYear:isValidate()
  self._ui.rdo_titleMonth:isValidate()
  self._ui.stc_line:isValidate()
  self._ui.stc_mainArea:isValidate()
  self._ui.frame_history:isValidate()
  self._ui.frameContent:isValidate()
  self._ui.frameScroll:isValidate()
  self._ui.txt_date:isValidate()
  self._ui.stc_verticalLine:isValidate()
  self._ui.stc_leftWing:isValidate()
  self._ui.stc_rightWing:isValidate()
  self._ui.txt_leftDay:isValidate()
  self._ui.txt_rightDay:isValidate()
  self._ui.txt_leftHistory:isValidate()
  self._ui.txt_rightHistory:isValidate()
end
