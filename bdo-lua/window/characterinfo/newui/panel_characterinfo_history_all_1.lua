function PaGlobal_CharInfoHistory_All:initialize()
  if true == self._initialize then
    return
  end
  local monthTabConsoleBg = UI.getChildControl(Panel_CharacterInfoHistory_All, "Static_Month_TabBg_ConsoleUI")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(monthTabConsoleBg, "Static_LT_ConsoleUI")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(monthTabConsoleBg, "Static_RT_ConsoleUI")
  local stc_MonthTabBg = UI.getChildControl(Panel_CharacterInfoHistory_All, "Static_Month_TabBg")
  self._ui.btn_YearLeft = UI.getChildControl(stc_MonthTabBg, "Button_Year_Left_PCUI")
  self._ui.btn_YearRight = UI.getChildControl(stc_MonthTabBg, "Button_Year_Right_PCUI")
  self._ui.txt_Year = UI.getChildControl(stc_MonthTabBg, "StaticText_YearSticText")
  self._ui.rdo_MonthTable = {}
  for idx = 0, #self._pastMonth_DayCount - 1 do
    local rdo_Month = UI.getChildControl(stc_MonthTabBg, "RadioButton_Month" .. idx + 1)
    self._ui.rdo_MonthTable[idx] = rdo_Month
    self._ui.rdo_MonthTable[idx]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_MONTH", "month", idx + 1))
  end
  self._ui.stc_SelectLine = UI.getChildControl(stc_MonthTabBg, "Static_SelectLine")
  self._ui.stc_SelectLine:SetSize(self._ui.rdo_MonthTable[0]:GetSizeX(), self._ui.stc_SelectLine:GetSizeY())
  self._currentidx = 0
  self._ui.frame_ListTemp = UI.getChildControl(Panel_CharacterInfoHistory_All, "Frame_Title_ListTemplate")
  self._ui.frame_ContentTemp = UI.getChildControl(self._ui.frame_ListTemp, "Frame_ContentTemplate")
  self._ui.frame_VertiCenterLine = UI.getChildControl(self._ui.frame_ContentTemp, "Static_Line_Vertical")
  self._ui.frame_HoriLeftCircle = UI.getChildControl(self._ui.frame_ContentTemp, "Static_Circle_Left")
  self._ui.frame_HoriLeftLine = UI.getChildControl(self._ui.frame_HoriLeftCircle, "Static_Line_Horizon_Left")
  self._ui.frame_HoriRightCircle = UI.getChildControl(self._ui.frame_ContentTemp, "Static_Circle_Right")
  self._ui.frame_HoriRightLine = UI.getChildControl(self._ui.frame_HoriRightCircle, "Static_Line_Horizon_Right")
  self._ui.frame_HistoryLeft = UI.getChildControl(self._ui.frame_ContentTemp, "StaticText_HistoryLine_Left")
  self._ui.frame_HistoryRight = UI.getChildControl(self._ui.frame_ContentTemp, "StaticText_HistoryLine_Right")
  self._ui.frame_DateLeft = UI.getChildControl(self._ui.frame_ContentTemp, "StaticText_Date_Left")
  self._ui.frame_DateRight = UI.getChildControl(self._ui.frame_ContentTemp, "StaticText_Date_Right")
  self._ui.frame_ListTemp:SetShow(false)
  self._ui.frame_ContentTemp:SetShow(false)
  self._ui.frame_List = UI.getChildControl(Panel_CharacterInfoHistory_All, "Frame_Title_List")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_List, "Frame_Content")
  self._ui.frame_VertiScroll = UI.getChildControl(self._ui.frame_List, "Frame_VerticalScroll")
  self._currentValue._year = ToClient_GetThisYear()
  self._currentValue._month = ToClient_GetThisMonth()
  self._currentValue._day = ToClient_GetToday()
  self._oriFrameSizeY = self._ui.frame_ContentTemp:GetSizeY()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  self._ui.stc_KeyGuide_LT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_RT:SetShow(self._isConsole)
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfo_Title_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  PaGlobal_CharInfoHistory_All:validate()
  PaGlobal_CharInfoHistory_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoHistory_All._initialize = true
end
function PaGlobal_CharInfoHistory_All:registEventHandler(console)
  registerEvent("FromClient_JournalInfo_UpdateText", "FromClient_CharInfoHistory_All_FrameUpdate")
  if true == console then
  else
    for idx = 0, #self._pastMonth_DayCount - 1 do
      self._ui.rdo_MonthTable[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoHistory_All_MonthCheck(" .. idx .. ", true)")
    end
  end
end
function PaGlobal_CharInfoHistory_All:dataClear()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  self._haveInfoMonth = nil
end
function PaGlobal_CharInfoHistory_All:updateFrame()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  self._ui.frame_Content:SetSize(self._ui.frame_ContentTemp:GetSizeX(), self._oriFrameSizeY)
  self._ui.frame_Content:DestroyAllChild()
  if nil == self._haveInfoMonth then
    self._haveInfoMonth = ToClient_GetThisMonth()
  end
  local _listCount = ToClient_GetJournalListCount(self._currentValue._year, self._currentValue._month, self._currentValue._myHistory)
  local unableFlag = false
  if 0 == _listCount then
    if self._currentValue._year ~= ToClient_GetThisYear() and self._currentValue._month ~= ToClient_GetThisMonth() then
      unableFlag = true
    end
  elseif 0 == self._currentValue._day then
    unableFlag = true
  end
  self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_MonthTable[self._currentidx]:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  if true == unableFlag then
    for idx = 0, #self._pastMonth_DayCount - 1 do
      if self._haveInfoMonth - 1 == idx then
        self._ui.rdo_MonthTable[idx]:SetCheck(true)
        local selectLineSpanSizeX = self._ui.rdo_MonthTable[idx]:GetSpanSize().x - (self._ui.rdo_MonthTable[idx]:GetSizeX() * 0.5 + 5)
        if _listCount < 0 then
          self._ui.stc_SelectLine:SetSpanSize(selectLineSpanSizeX, self._ui.stc_SelectLine:GetSpanSize().y)
        else
          self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_MonthTable[idx]:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
        end
        self._currentidx = idx
      else
        self._ui.rdo_MonthTable[idx]:SetCheck(false)
      end
    end
    return
  end
  local centerVertiLine = UI.cloneControl(self._ui.frame_VertiCenterLine, self._ui.frame_Content, "Static_CenterVertiLine")
  centerVertiLine:SetScale(1, 1)
  local sizeY = 10
  local lineGap = 50
  local textSizeY = 23
  local _journalInfo = {}
  local _dayValue = {}
  local _dayLine = {}
  local _dayCircle = {}
  local dayLogCount = 1
  local firstDay = 0
  local _dayHistoryValue = {}
  for dayIndex = self._currentValue._day, 1, -1 do
    local checkLog = false
    for i = _listCount - 1, 0, -1 do
      _journalInfo[i] = {}
      _journalInfo[i] = ToClient_GetJournal(self._currentValue._year, self._currentValue._month, self._currentValue._myHistory, i)
      if nil ~= _journalInfo[i] and dayIndex == _journalInfo[i]:getJournalDay() then
        if false == checkLog then
          checkLog = true
        end
        sizeY = sizeY + textSizeY
        function HandleEventOnOut_CharInfoHistory_All_HistoryTooltip(isShow, index)
          if false == isShow or nil == index then
            TooltipSimple_Hide()
            return
          end
          local journalInfo = ToClient_GetJournal(self._currentValue._year, self._currentValue._month, self._currentValue._myHistory, index)
          if nil == journalInfo then
            TooltipSimple_Hide()
            return
          end
          if true == isShow then
            local name = ""
            local helpName = tostring(journalInfo:getName())
            local helpDesc = "<PAColor0xFFFFF3AF>" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_TIME", "hour", journalInfo:getJournalHour(), "minute", journalInfo:getJournalMinute(), "second", journalInfo:getJournalSecond()) .. "<PAOldColor>"
            local desc = helpName .. "\n" .. helpDesc
            TooltipSimple_Show(_dayHistoryValue[i], name, desc)
          end
        end
        if 1 == dayLogCount % 2 then
          local _dayHistoryLeftValue = UI.cloneControl(self._ui.frame_HistoryLeft, self._ui.frame_Content, "StaticText_MyHistory_" .. i)
          _dayHistoryValue[i] = _dayHistoryLeftValue
        else
          local _dayHistoryRightValue = UI.cloneControl(self._ui.frame_HistoryRight, self._ui.frame_Content, "StaticText_MyHistory_" .. i)
          _dayHistoryValue[i] = _dayHistoryRightValue
        end
        _dayHistoryValue[i]:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoHistory_All_HistoryTooltip(true, " .. i .. ")")
        _dayHistoryValue[i]:SetAutoResize(true)
        _dayHistoryValue[i]:SetTextMode(__eTextMode_LimitText)
        _dayHistoryValue[i]:SetText(tostring(_journalInfo[i]:getName()))
        _dayHistoryValue[i]:SetPosY(sizeY + 30)
        _dayHistoryValue[i]:SetShow(true)
        _dayHistoryValue[i]:SetIgnore(false)
      end
    end
    if true == checkLog then
      if 1 == dayLogCount % 2 then
        local _dayLeftValue = UI.cloneControl(self._ui.frame_DateLeft, self._ui.frame_Content, "StaticText_DayLeft_Value_" .. dayIndex)
        local _dayLeftCircle = UI.cloneControl(self._ui.frame_HoriLeftCircle, self._ui.frame_Content, "Static_DayLeftCircle_" .. dayIndex)
        local leftLine = UI.getChildControl(_dayLeftCircle, "Static_Line_Horizon_Left")
        leftLine:SetScale(leftLine:GetScale().x, 1)
        _dayValue[dayIndex] = _dayLeftValue
        _dayCircle[dayIndex] = _dayLeftCircle
      else
        local _dayRightValue = UI.cloneControl(self._ui.frame_DateRight, self._ui.frame_Content, "StaticText_DayRight_Value_" .. dayIndex)
        local _dayRightCircle = UI.cloneControl(self._ui.frame_HoriRightCircle, self._ui.frame_Content, "Static_DayLeftCircle_" .. dayIndex)
        local rightLine = UI.getChildControl(_dayRightCircle, "Static_Line_Horizon_Right")
        rightLine:SetScale(rightLine:GetScale().x, 1)
        _dayValue[dayIndex] = _dayRightValue
        _dayCircle[dayIndex] = _dayRightCircle
      end
      sizeY = sizeY + lineGap
      _dayValue[dayIndex]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_DAY", "day", dayIndex))
      _dayValue[dayIndex]:SetShow(true)
      _dayValue[dayIndex]:SetPosY(sizeY + 15)
      _dayCircle[dayIndex]:SetPosY(sizeY + 16)
      dayLogCount = dayLogCount + 1
      firstDay = dayIndex
    end
  end
  if 0 < firstDay then
    self._ui.frame_Content:SetSize(self._ui.frame_Content:GetSizeX(), _dayCircle[firstDay]:GetPosY() + 50)
    self._ui.frame_Content:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoHistory_All_HistoryTooltip(false)")
    centerVertiLine:SetSize(centerVertiLine:GetSizeX(), _dayCircle[firstDay]:GetPosY() + 50)
    centerVertiLine:SetShow(true)
    if self._oriFrameSizeY < _dayCircle[firstDay]:GetPosY() + 50 then
      self._ui.frame_VertiScroll:SetShow(true)
    else
      self._ui.frame_VertiScroll:SetShow(false)
    end
  else
    centerVertiLine:SetSize(centerVertiLine:GetSizeX(), self._oriFrameSizeY)
    centerVertiLine:SetShow(false)
    self._ui.frame_Content:SetSize(self._ui.frame_Content:GetSizeX(), self._oriFrameSizeY)
    self._ui.frame_VertiScroll:SetShow(false)
  end
  self._ui.frame_VertiScroll:SetInterval(self._ui.frame_Content:GetSizeY() * 0.01 * 1.1)
  self._ui.frame_List:UpdateContentScroll()
  self._ui.frame_VertiScroll:SetControlTop()
  self._ui.frame_List:UpdateContentPos()
  haveInfoMonth = self._currentValue._month
end
function PaGlobal_CharInfoHistory_All:yearUpdate(index, audioFlag)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  self._currentValue._year = self._firstLogYearValue + index
  self._ui.txt_Year:SetText(self._currentValue._year)
  local isLeftShow = self._firstLogYearValue < self._currentValue._year
  local isRightShow = ToClient_GetThisYear() > self._currentValue._year
  self._ui.btn_YearLeft:SetShow(isLeftShow)
  self._ui.btn_YearRight:SetShow(isRightShow)
  if self._currentValue._year == ToClient_GetThisYear() then
    PaGlobal_CharInfoHistory_All:monthUpdate(ToClient_GetThisMonth() - 1)
  else
    PaGlobal_CharInfoHistory_All:monthUpdate(11)
  end
  self._ui.btn_YearLeft:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoHistory_All_YearCheck(" .. self._currentValue._year - self._firstLogYearValue - 1 .. ")")
  self._ui.btn_YearRight:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoHistory_All_YearCheck(" .. self._currentValue._year - self._firstLogYearValue + 1 .. ")")
end
function PaGlobal_CharInfoHistory_All:monthUpdate(index, audioFlag)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    return
  end
  if true == audioFlag then
    audioPostEvent_SystemUi(0, 0)
  end
  for idx = 0, #self._pastMonth_DayCount - 1 do
    if idx == index then
      self._ui.rdo_MonthTable[idx]:SetCheck(true)
      self._currentidx = idx
    else
      self._ui.rdo_MonthTable[idx]:SetCheck(false)
    end
  end
  self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_MonthTable[self._currentidx]:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  self._currentValue._month = index + 1
  if ToClient_GetThisYear() <= self._currentValue._year and ToClient_GetThisMonth() < self._currentValue._month then
    self._currentValue._day = 0
  end
  if ToClient_GetThisMonth() == self._currentValue._month then
    self._currentValue._day = ToClient_GetToday()
  else
    self._currentValue._day = self._pastMonth_DayCount[index + 1]
  end
  ToClient_RequestJournalList(self._currentValue._year, self._currentValue._month, self._currentValue._myHistory)
end
function PaGlobal_CharInfoHistory_All:validate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.btn_YearLeft:isValidate()
  self._ui.btn_YearRight:isValidate()
  self._ui.txt_Year:isValidate()
  for idx = 0, #self._pastMonth_DayCount - 1 do
    self._ui.rdo_MonthTable[idx]:isValidate()
  end
  self._ui.stc_SelectLine:isValidate()
  self._ui.frame_ListTemp:isValidate()
  self._ui.frame_ContentTemp:isValidate()
  self._ui.frame_VertiCenterLine:isValidate()
  self._ui.frame_HoriLeftCircle:isValidate()
  self._ui.frame_HoriLeftLine:isValidate()
  self._ui.frame_HoriRightCircle:isValidate()
  self._ui.frame_HoriRightLine:isValidate()
  self._ui.frame_HistoryLeft:isValidate()
  self._ui.frame_HistoryRight:isValidate()
  self._ui.frame_DateLeft:isValidate()
  self._ui.frame_DateRight:isValidate()
  self._ui.frame_List:isValidate()
  self._ui.frame_Content:isValidate()
  self._ui.frame_VertiScroll:isValidate()
end
