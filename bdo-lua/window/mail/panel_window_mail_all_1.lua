function PaGlobal_Window_Mail_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting(self._isConsole)
  self:registEventHandler()
  self:validate()
  self:createMailControl()
  self._initialize = true
end
function PaGlobal_Window_Mail_All:controlAll_Init()
  if nil == Panel_Window_Mail_All then
    return
  end
  self._ui.stc_topBG = UI.getChildControl(Panel_Window_Mail_All, "Static_TopBg")
  self._ui.txt_pageNumber = UI.getChildControl(self._ui.stc_topBG, "StaticText_PageNumber")
  self._ui.btn_selectAll = UI.getChildControl(Panel_Window_Mail_All, "CheckButton_All")
  if true == self._isConsole then
    self._ui.btn_selectAll:SetShow(false)
  end
  self._ui.btn_selectAll:SetText(self._ui.btn_selectAll:GetText())
  self._ui.btn_selectAll:SetTextSpan((self._ui.btn_selectAll:GetSizeX() + 25) / 2 - self._ui.btn_selectAll:GetTextSizeX() / 2, 0)
  self._ui.txt_mailCount = UI.getChildControl(self._ui.stc_topBG, "StaticText_MailCount")
  self._ui.stc_centerBG = UI.getChildControl(Panel_Window_Mail_All, "Static_CenterBg")
  self._ui.btn_mail = UI.getChildControl(self._ui.stc_centerBG, "RadioButton_MailTemplate")
  self._ui.btn_mail:SetShow(false)
end
function PaGlobal_Window_Mail_All:controlPc_Init()
  if nil == Panel_Window_Mail_All then
    return
  end
  local titleBG = UI.getChildControl(Panel_Window_Mail_All, "Static_TitleBg")
  self._ui_pc.btn_close = UI.getChildControl(titleBG, "Button_Close_PCUI")
  self._ui_pc.btn_question = UI.getChildControl(titleBG, "Button_Question_PCUI")
  self._ui_pc.btn_prePage = UI.getChildControl(self._ui.stc_topBG, "Button_Pre_Page_PCUI")
  self._ui_pc.btn_nextPage = UI.getChildControl(self._ui.stc_topBG, "Button_Next_Page_PCUI")
  self._ui_pc.btn_selectDelect = UI.getChildControl(Panel_Window_Mail_All, "Button_SelectDelete_PCUI")
  self._ui_pc.btn_allRecieve = UI.getChildControl(Panel_Window_Mail_All, "Button_AllRecieve_PCUI")
  self._ui_pc.btn_QNA = UI.getChildControl(Panel_Window_Mail_All, "Button_QNA_PCUI")
end
function PaGlobal_Window_Mail_All:controlConsole_Init()
  if nil == Panel_Window_Mail_All then
    return
  end
  self._ui_console.stc_leftIcon = UI.getChildControl(self._ui.stc_topBG, "Static_LeftIcon_ConsoleUI")
  self._ui_console.stc_rightIcon = UI.getChildControl(self._ui.stc_topBG, "Static_RightIcon_ConsoleUI")
  self._ui_console.stc_bottomBG = UI.getChildControl(Panel_Window_Mail_All, "Static_BottomBg_ConsoleUI")
  self._ui_console.txt_keyGuideA = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideA")
  self._ui_console.txt_keyGuideX = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideX")
  self._ui_console.txt_keyGuideB = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideB")
  self._ui_console.txt_keyGuideY = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideY")
  self._ui_console.txt_keyGuideLTA = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideLTA")
  self._ui_console.txt_keyGuideRS = UI.getChildControl(self._ui_console.stc_bottomBG, "StaticText_KeyGuideSelectDelete")
end
function PaGlobal_Window_Mail_All:SetUiSetting(isConsole)
  if nil == Panel_Window_Mail_All or nil == isConsole then
    return
  end
  self._ui_console.stc_leftIcon:SetShow(isConsole)
  self._ui_console.stc_rightIcon:SetShow(isConsole)
  self._ui_console.stc_bottomBG:SetShow(isConsole)
  self._ui_console.txt_keyGuideA:SetShow(isConsole)
  self._ui_console.txt_keyGuideX:SetShow(isConsole)
  self._ui_console.txt_keyGuideB:SetShow(isConsole)
  self._ui_pc.btn_close:SetShow(false == isConsole)
  self._ui_pc.btn_question:SetShow(false == isConsole)
  self._ui_pc.btn_prePage:SetShow(false == isConsole)
  self._ui_pc.btn_nextPage:SetShow(false == isConsole)
  self._ui_pc.btn_selectDelect:SetShow(false == isConsole)
  self._ui_pc.btn_allRecieve:SetShow(false == isConsole)
  self._ui_pc.btn_QNA:SetShow(false == isConsole)
  FromClient_Window_Mail_All_ReSizePanel()
  self._ui_console.txt_keyGuideY:SetShow(_ContentsGroup_isPS4UI)
  if false == isConsole then
    local isCommercial = FGlobal_IsCommercialService()
    self._ui_pc.btn_QNA:SetShow(isCommercial)
    if isGameTypeKR2() or isGameTypeGT() then
      self._ui_pc.btn_QNA:SetShow(false)
    end
  else
    local keyGuides = {
      self._ui_console.txt_keyGuideLTA,
      self._ui_console.txt_keyGuideRS,
      self._ui_console.txt_keyGuideX,
      self._ui_console.txt_keyGuideY,
      self._ui_console.txt_keyGuideA,
      self._ui_console.txt_keyGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
    local keyGuideBottomSize = self._ui_console.txt_keyGuideB:GetPosY() + self._ui_console.txt_keyGuideB:GetSizeY() + 10
    local panelSizeY = self._ui_console.stc_bottomBG:GetPosY() + keyGuideBottomSize
    Panel_Window_Mail_All:SetSize(Panel_Window_Mail_All:GetSizeX(), panelSizeY)
    self._ui_console.stc_bottomBG:SetSize(self._ui_console.stc_bottomBG:GetSizeX(), keyGuideBottomSize)
    self._ui_console.stc_bottomBG:ComputePos()
  end
end
function PaGlobal_Window_Mail_All:registEventHandler()
  if nil == Panel_Window_Mail_All then
    return
  end
  Panel_Window_Mail_All:RegisterShowEventFunc(true, "PaGlobal_Window_Mail_All_ShowAni()")
  Panel_Window_Mail_All:RegisterShowEventFunc(false, "PaGlobal_Window_Mail_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_Window_Mail_All_ReSizePanel()")
  registerEvent("ResponseMail_showList", "PaGlobal_Window_Mail_UpdateList")
  registerEvent("FromClient_NewMail", "FromClient_Mail_All_NewMail")
  if false == self._isConsole then
    self._ui.btn_selectAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_SelectAll()")
    self._ui_pc.btn_allRecieve:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_allRecieve()")
    self._ui_pc.btn_QNA:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_QNA()")
    self._ui_pc.btn_selectDelect:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_SelectDelect()")
    self._ui_pc.btn_prePage:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_ChangePage(false)")
    self._ui_pc.btn_nextPage:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_ChangePage(true)")
    self._ui.stc_centerBG:addInputEvent("Mouse_DownScroll", "HandleEventLUp_Mail_All_ChangePage(true)")
    self._ui.stc_centerBG:addInputEvent("Mouse_UpScroll", "HandleEventLUp_Mail_All_ChangePage(false)")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Panelmail\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"Panelmail\"")
  else
    Panel_Window_Mail_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_Mail_All_ChangePage(false)")
    Panel_Window_Mail_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventLUp_Mail_All_ChangePage(true)")
    Panel_Window_Mail_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Mail_All_allRecieve()")
    Panel_Window_Mail_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventLUp_Mail_All_SelectDelect()")
  end
  if true == _ContentsGroup_isPS4UI then
    Panel_Window_Mail_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "MailList_RefreshPS4CacheMail()")
  end
end
function PaGlobal_Window_Mail_All:rePosition()
  if nil == Panel_Window_Mail_All then
    return
  end
  Panel_Window_Mail_All:SetPosX(0)
  Panel_Window_Mail_All:SetPosY(0)
  Panel_Window_Mail_All:ComputePos()
end
function PaGlobal_Window_Mail_All:prepareOpen()
  if nil == Panel_Window_Mail_All then
    return
  end
  self:rePosition()
  self._Page_Current = 1
  self._isSelectAll = false
  self._ui.btn_selectAll:SetCheck(self._isSelectAll)
  self._selectedMail = {}
  RequestMail_requestMailList()
  RequestMail_setNewMailFlag(false)
  ToClient_RequestMassMailList()
  self:updateMailData()
  local pageCount = tostring(self._Page_Current) .. "/" .. tostring(self._Page_Total)
  self._ui.txt_pageNumber:SetText(pageCount)
  local mail_num = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_NO") .. "." .. tostring(self._maxMailCount)
  self._ui.txt_mailCount:SetText(mail_num)
  self._ui.txt_mailCount:SetSpanSize(self._ui.txt_mailCount:GetSizeX() + self._ui.txt_mailCount:GetTextSizeX(), self._ui.txt_mailCount:GetSpanSize().y)
  self._ui.txt_mailCount:ComputePos()
  self._ui_pc.btn_prePage:SetShow(false)
  for index = 1, self._rowMax do
    if nil ~= self._ui._mail[index] then
      self._ui._mail[index].btn_radioMail:SetCheck(false)
    end
  end
  PaGlobal_Window_Mail_All:open()
end
function PaGlobal_Window_Mail_All:open()
  if nil == Panel_Window_Mail_All then
    return
  end
  Panel_Window_Mail_All:SetShow(true)
  ToClient_UpdateOpenUICondition(0)
end
function PaGlobal_Window_Mail_All:prepareClose()
  if nil == Panel_Window_Mail_All then
    return
  end
  PaGlobal_Window_MailDetail_All_Close()
  self._isWithReward = true
  PaGlobal_Window_Mail_All:close()
  for index = 1, self._rowMax do
    if nil ~= self._ui._mail[index] then
      self._ui._mail[index].btn_radioMail:SetShow(false)
    end
  end
end
function PaGlobal_Window_Mail_All:close()
  if nil == Panel_Window_Mail_All then
    return
  end
  Panel_Window_Mail_All:SetShow(false)
end
function PaGlobal_Window_Mail_All:updateMailData()
  if nil == Panel_Window_Mail_All then
    return
  end
  local pageNo = 0
  local pageIndex = 1
  self._mailData = {}
  local massMailCount = Int64toInt32(ToClient_GetMassMailCount())
  for massMailIndex = 1, massMailCount do
    if 0 == (pageIndex - 1) % self._rowMax then
      pageNo = pageNo + 1
      pageIndex = 1
    end
    if self._mailData[pageNo] == nil then
      self._mailData[pageNo] = {}
    end
    local massMailInfo = ToClient_GetMassMailInfo(massMailIndex - 1)
    if nil ~= massMailInfo then
      local idx = (pageIndex - 1) % self._rowMax + 1
      pageIndex = pageIndex + 1
      local data = {
        _indx = massMailIndex - 1,
        _sender_Name = massMailInfo:getSenderName(),
        _mail_Title = massMailInfo:getTitle(),
        _mail_No = massMailInfo:getMailNo(),
        _mail_GetItem = massMailInfo:isExistItem(),
        _mail_GetDate = massMailInfo:getMailReceiveDate(),
        _isMassMail = true
      }
      self._mailData[pageNo][idx] = data
    end
  end
  local mailCount = RequestMail_mailCount()
  for index = 1, mailCount do
    if 0 == (pageIndex - 1) % self._rowMax then
      pageNo = pageNo + 1
      pageIndex = 1
    end
    if self._mailData[pageNo] == nil then
      self._mailData[pageNo] = {}
    end
    local mail_Info = RequestMail_getMailAt(index - 1)
    if nil ~= mail_Info then
      local idx = (pageIndex - 1) % self._rowMax + 1
      pageIndex = pageIndex + 1
      local data = {
        _indx = index - 1,
        _sender_Name = mail_Info:getSender(),
        _mail_Title = mail_Info:getTitle(),
        _mail_No = mail_Info:getMailNo(),
        _mail_GetItem = mail_Info:isExistItem(),
        _mail_GetDate = mail_Info:getMailReceiveDate(),
        _isMassMail = false
      }
      self._mailData[pageNo][idx] = data
    end
  end
  local maxCount = massMailCount + mailCount
  self._maxMailCount = maxCount
  self._ui.txt_mailCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_NO") .. "." .. tostring(maxCount))
  if 0 == pageNo then
    pageNo = 1
  end
  self._Page_Total = pageNo
end
function PaGlobal_Window_Mail_All:updateMailControl()
  if self._Page_Total < self._Page_Current then
    self._Page_Current = self._Page_Total
  end
  for index = 1, self._rowMax do
    self._ui._mail[index].btn_radioMail:SetShow(false)
    self._ui._mail[index].btn_check:SetCheck(false)
    self._ui._mail[index].btn_radioMail:SetCheck(false)
    if true == Panel_Window_MailDetail_All:GetShow() and nil ~= self._mailData[self._Page_Current] and nil ~= self._mailData[self._Page_Current][index] and self._mailData[self._Page_Current][index]._mail_No == PaGlobal_Window_MailDetail_All_GetCurrentMailNo() then
      self._ui._mail[index].btn_radioMail:SetCheck(true)
    end
  end
  for index = 1, self._rowMax do
    if nil ~= self._mailData[self._Page_Current] then
      if nil ~= self._mailData[self._Page_Current][index] then
        local _sender_Name = self._mailData[self._Page_Current][index]._sender_Name
        local _mail_Title = self._mailData[self._Page_Current][index]._mail_Title
        local _indx = self._mailData[self._Page_Current][index]._indx
        local _getItem = self._mailData[self._Page_Current][index]._mail_GetItem
        local _getDate = self._mailData[self._Page_Current][index]._mail_GetDate
        local _isMassMail = self._mailData[self._Page_Current][index]._isMassMail
        local _mail_num = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_NO") .. "." .. tostring(_indx + 1)
        local sender = _sender_Name
        if nil ~= _getDate then
          sender = sender .. "(" .. _getDate .. ")"
        end
        self._ui._mail[index].txt_sender:SetText(sender)
        self._ui._mail[index].txt_title:SetTextMode(__eTextMode_LimitText)
        self._ui._mail[index].txt_title:SetText("<PAColor0xFFf3d900>" .. _mail_Title .. "<PAOldColor>")
        if self._selectedMail._indx == _indx and self._selectedMail._sender_Name == _sender_Name and self._selectedMail._mail_Title == _mail_Title and false == self._isConsole then
        else
          self._ui._mail[index].btn_check:SetCheck(false)
        end
        self._ui._mail[index].btn_radioMail:SetShow(true)
        self._ui._mail[index].btn_check:SetShow(false == _isMassMail)
        if true == _getItem then
          self._ui._mail[index].txt_title:SetFontColor(Defines.Color.C_FFFFFFFF)
          self._ui._mail[index].txt_title:SetMonoTone(false)
          self._ui._mail[index].txt_sender:SetMonoTone(false)
          self._ui._mail[index].stc_giftIcon:SetColor(Defines.Color.C_FFFFEDD4)
          self._ui._mail[index].txt_sender:SetFontColor(Defines.Color.C_FFFFFFFF)
        else
          self._ui._mail[index].txt_title:SetFontColor(Defines.Color.C_FFC4BEBE)
          self._ui._mail[index].txt_title:SetMonoTone(true)
          self._ui._mail[index].txt_sender:SetMonoTone(true)
          self._ui._mail[index].stc_giftIcon:SetColor(Defines.Color.C_FF5C5C5C)
          self._ui._mail[index].txt_sender:SetFontColor(Defines.Color.C_FFC4BEBE)
        end
      end
    else
      self._ui._mail[index].btn_radioMail:SetShow(false)
    end
  end
  if self._Page_Total == 1 or self._Page_Total < 1 then
    self._ui_pc.btn_prePage:SetShow(false)
    self._ui_pc.btn_nextPage:SetShow(false)
    self._ui_console.stc_leftIcon:SetShow(false)
    self._ui_console.stc_rightIcon:SetShow(false)
  elseif self._Page_Current == 1 then
    self._ui_pc.btn_prePage:SetShow(false)
    self._ui_pc.btn_nextPage:SetShow(not self._isConsole)
    self._ui_console.stc_leftIcon:SetShow(false)
    self._ui_console.stc_rightIcon:SetShow(self._isConsole)
  elseif self._Page_Current == self._Page_Total then
    self._ui_pc.btn_prePage:SetShow(not self._isConsole)
    self._ui_pc.btn_nextPage:SetShow(false)
    self._ui_console.stc_leftIcon:SetShow(self._isConsole)
    self._ui_console.stc_rightIcon:SetShow(false)
  else
    self._ui_pc.btn_prePage:SetShow(not self._isConsole)
    self._ui_pc.btn_nextPage:SetShow(not self._isConsole)
    self._ui_console.stc_leftIcon:SetShow(self._isConsole)
    self._ui_console.stc_rightIcon:SetShow(self._isConsole)
  end
  local massMailCount = Int64toInt32(ToClient_GetMassMailCount())
  if self._Page_Total > 0 or 0 < massMailCount then
    local pageCount = tostring(self._Page_Current) .. "/" .. tostring(self._Page_Total)
    self._ui.txt_pageNumber:SetText(pageCount)
  end
end
function PaGlobal_Window_Mail_All:clearData()
end
function PaGlobal_Window_Mail_All:createMailControl()
  if nil == Panel_Window_Mail_All then
    return
  end
  for index = 1, self._rowMax do
    if nil == self._ui._mail[index] then
      local mailbutton = UI.cloneControl(self._ui.btn_mail, self._ui.stc_centerBG, "RadioButton_MailTemplate_" .. index)
      local mail = {
        btn_radioMail = mailbutton,
        stc_giftIcon = UI.getChildControl(mailbutton, "Static_GiftIcon"),
        txt_title = UI.getChildControl(mailbutton, "StaticText_Title"),
        txt_sender = UI.getChildControl(mailbutton, "StaticText_Sender"),
        btn_check = UI.getChildControl(mailbutton, "CheckButton_Mail")
      }
      mail.btn_radioMail:addInputEvent("Mouse_LUp", "HandleEventLUp_Mail_All_GetDetail(" .. index .. ")")
      mail.btn_radioMail:addInputEvent("Mouse_DownScroll", "HandleEventLUp_Mail_All_ChangePage(true)")
      mail.btn_radioMail:addInputEvent("Mouse_UpScroll", "HandleEventLUp_Mail_All_ChangePage(false)")
      mail.btn_radioMail:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_Mail_All_CheckMail(" .. index .. ")")
      self._ui._mail[index] = mail
      mail.btn_check:SetShow(false)
      self:setPosMailControl(index)
    end
  end
end
function PaGlobal_Window_Mail_All:setPosMailControl(index)
  local posY = self._ui.btn_mail:GetPosY() + (self._ui.btn_mail:GetSizeY() + self._mailControlPadding) * (index - 1)
  self._ui._mail[index].btn_radioMail:SetPosY(posY)
end
function PaGlobal_Window_Mail_All:validate()
  if nil == Panel_Window_Mail_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Window_Mail_All:allValidate()
  if nil == Panel_Window_Mail_All then
    return
  end
  self._ui.stc_topBG:isValidate()
  self._ui.txt_pageNumber:isValidate()
  self._ui.btn_selectAll:isValidate()
  self._ui.txt_mailCount:isValidate()
  self._ui.btn_mail:isValidate()
end
function PaGlobal_Window_Mail_All:pcValidate()
  if nil == Panel_Window_Mail_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_prePage:isValidate()
  self._ui_pc.btn_nextPage:isValidate()
  self._ui_pc.btn_selectDelect:isValidate()
  self._ui_pc.btn_allRecieve:isValidate()
  self._ui_pc.btn_QNA:isValidate()
end
function PaGlobal_Window_Mail_All:consoleValidate()
  if nil == Panel_Window_Mail_All then
    return
  end
  self._ui_console.stc_leftIcon:isValidate()
  self._ui_console.stc_rightIcon:isValidate()
  self._ui_console.stc_bottomBG:isValidate()
  self._ui_console.txt_keyGuideA:isValidate()
  self._ui_console.txt_keyGuideX:isValidate()
  self._ui_console.txt_keyGuideB:isValidate()
  self._ui_console.txt_keyGuideY:isValidate()
end
