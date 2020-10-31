function PaGlobalFunc_Guild_History_All_ShowToggle(isShow)
  if nil == Panel_GuildMain_All then
    return
  end
  if true == isShow then
    PaGlobal_Guild_History_All:prepareOpen()
  else
    PaGlobal_Guild_History_All:prepareClose()
  end
end
function PaGlobalFunc_Guild_History_All_DataUpdate()
  PaGlobal_Guild_History_All:dataUpdate()
end
function HandleEventOnOut_Guild_History_All_ShowTooltip(isShow, index, isLeft)
  if nil == index or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local journalInfo = ToClient_GetJournal(PaGlobal_Guild_History_All._year, PaGlobal_Guild_History_All._month, PaGlobal_Guild_History_All._guildHistory, index)
  if nil == journalInfo then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local helpName = tostring(journalInfo:getName())
  local helpDesc = "<PAColor0xFFFFF3AF>" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_TIME", "hour", journalInfo:getJournalHour(), "minute", journalInfo:getJournalMinute(), "second", journalInfo:getJournalSecond()) .. "<PAOldColor>"
  local desc = helpName .. "\n" .. helpDesc
  TooltipSimple_Show(PaGlobal_Guild_History_All._ui._dayHistoryValue[index], name, desc)
end
function HandleEventLUp_Guild_History_All_YearCheck(index)
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_History_All._year = PaGlobal_Guild_History_All._firstLogYearValue + index
  PaGlobal_Guild_History_All._ui.txt_titleYear:SetText(tostring(PaGlobal_Guild_History_All._year))
  if PaGlobal_Guild_History_All._firstLogYearValue < PaGlobal_Guild_History_All._year then
    PaGlobal_Guild_History_All._ui.btn_left:SetShow(true)
  else
    PaGlobal_Guild_History_All._ui.btn_left:SetShow(false)
  end
  if ToClient_GetThisYear() > PaGlobal_Guild_History_All._year then
    PaGlobal_Guild_History_All._ui.btn_right:SetShow(true)
  else
    PaGlobal_Guild_History_All._ui.btn_right:SetShow(false)
  end
  PaGlobal_Guild_History_All._ui.btn_left:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_History_All_YearCheck(" .. PaGlobal_Guild_History_All._year - PaGlobal_Guild_History_All._firstLogYearValue - 1 .. ")")
  PaGlobal_Guild_History_All._ui.btn_right:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_History_All_YearCheck(" .. PaGlobal_Guild_History_All._year - PaGlobal_Guild_History_All._firstLogYearValue + 1 .. ")")
end
function HandleEventLUp_Guild_History_All_MonthCheck(index)
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_History_All._month = index
  PaGlobal_Guild_History_All._ui._monthControl[index]:SetCheck(true)
  if ToClient_GetThisYear() <= PaGlobal_Guild_History_All._year and ToClient_GetThisMonth() < PaGlobal_Guild_History_All._month then
    PaGlobal_Guild_History_All._day = 0
  end
  if ToClient_GetThisMonth() == PaGlobal_Guild_History_All._month then
    PaGlobal_Guild_History_All._day = ToClient_GetToday()
  else
    PaGlobal_Guild_History_All._day = PaGlobal_Guild_History_All._dayCount[index]
  end
  PaGlobal_Guild_History_All:dataUpdate()
end
function FromClient_Guild_History_All_Update()
  if nil == Panel_GuildMain_All then
    return
  end
  if nil == PaGlobal_Guild_History_All._haveInfoMonth then
    return
  end
  PaGlobal_Guild_History_All._listCount = ToClient_GetJournalListCount(PaGlobal_Guild_History_All._year, PaGlobal_Guild_History_All._month, PaGlobal_Guild_History_All._guildHistory)
  if 0 ~= PaGlobal_Guild_History_All._listCount or ToClient_GetThisYear() ~= PaGlobal_Guild_History_All._year or ToClient_GetThisMonth() == PaGlobal_Guild_History_All._month then
  else
  end
  PaGlobal_Guild_History_All._ui.frameContent:DestroyAllChild()
  PaGlobal_Guild_History_All._ui.frameContent:SetIgnore(true)
  if 0 == PaGlobal_Guild_History_All._day then
    return
  end
  local newContent = {
    _dateValue = UI.createControl(__ePAUIControl_StaticText, PaGlobal_Guild_History_All._ui.frameContent, "StaticText_Month_Value"),
    _verticalLine = UI.createControl(__ePAUIControl_Static, PaGlobal_Guild_History_All._ui.frameContent, "Static_VerticalLine")
  }
  CopyBaseProperty(PaGlobal_Guild_History_All._ui.txt_date, newContent._dateValue)
  CopyBaseProperty(PaGlobal_Guild_History_All._ui.stc_verticalLine, newContent._verticalLine)
  newContent._dateValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", PaGlobal_Guild_History_All._year) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_MONTH", "month", PaGlobal_Guild_History_All._month))
  newContent._dateValue:SetShow(true)
  newContent._verticalLine:SetShow(true)
  local sizeY = 20
  local lineGap = 30
  local textSizeY = 25
  local emptyDay = 0
  local _dayValue = {}
  local _dayLine = {}
  local dayLogCount = 1
  local _journalInfo = {}
  local firstDay = 0
  for dayIndex = PaGlobal_Guild_History_All._day, 1, -1 do
    _dayValue[dayIndex] = {}
    _dayLine[dayIndex] = {}
    if 1 == dayLogCount % 2 then
      local _dayLeftValue = UI.createControl(__ePAUIControl_StaticText, PaGlobal_Guild_History_All._ui.frameContent, "StaticText_DayLeft_Value_" .. dayIndex)
      local _dayLeftLine = UI.createControl(__ePAUIControl_Static, PaGlobal_Guild_History_All._ui.frameContent, "Static_DayLeftLine_" .. dayIndex)
      CopyBaseProperty(PaGlobal_Guild_History_All._ui.txt_leftDay, _dayLeftValue)
      CopyBaseProperty(PaGlobal_Guild_History_All._ui.stc_leftWing, _dayLeftLine)
      _dayValue[dayIndex] = _dayLeftValue
      _dayLine[dayIndex] = _dayLeftLine
    else
      local _dayRightValue = UI.createControl(__ePAUIControl_StaticText, PaGlobal_Guild_History_All._ui.frameContent, "StaticText_DayRight_Value_" .. dayIndex)
      local _dayRightLine = UI.createControl(__ePAUIControl_Static, PaGlobal_Guild_History_All._ui.frameContent, "Static_DayRightLine" .. dayIndex)
      CopyBaseProperty(PaGlobal_Guild_History_All._ui.txt_rightDay, _dayRightValue)
      CopyBaseProperty(PaGlobal_Guild_History_All._ui.stc_rightWing, _dayRightLine)
      _dayValue[dayIndex] = _dayRightValue
      _dayLine[dayIndex] = _dayRightLine
    end
    local checkLog = false
    for i = PaGlobal_Guild_History_All._listCount - 1, 0, -1 do
      _journalInfo[i] = ToClient_GetJournal(PaGlobal_Guild_History_All._year, PaGlobal_Guild_History_All._month, PaGlobal_Guild_History_All._guildHistory, i)
      if nil ~= _journalInfo[i] and dayIndex == _journalInfo[i]:getJournalDay() then
        if false == checkLog then
          checkLog = true
        end
        sizeY = sizeY + textSizeY
        if 1 == dayLogCount % 2 then
          local _dayHistoryLeftValue = UI.createControl(__ePAUIControl_StaticText, PaGlobal_Guild_History_All._ui.frameContent, "StaticText_GuildHistory_" .. i)
          CopyBaseProperty(PaGlobal_Guild_History_All._ui.txt_leftHistory, _dayHistoryLeftValue)
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i] = _dayHistoryLeftValue
        else
          local _dayHistoryRightValue = UI.createControl(__ePAUIControl_StaticText, PaGlobal_Guild_History_All._ui.frameContent, "StaticText_GuildHistory_" .. i)
          CopyBaseProperty(PaGlobal_Guild_History_All._ui.txt_rightHistory, _dayHistoryRightValue)
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i] = _dayHistoryRightValue
        end
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_History_All_ShowTooltip(true," .. i .. ", false)")
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_History_All_ShowTooltip(false)")
        if true == PaGlobal_Guild_History_All._isConsole then
          local helpName = tostring(_journalInfo[i]:getName())
          local helpDesc = "<PAColor0xFFFFF3AF>" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_TIME", "hour", _journalInfo[i]:getJournalHour(), "minute", _journalInfo[i]:getJournalMinute(), "second", _journalInfo[i]:getJournalSecond()) .. "<PAOldColor>"
          local desc = helpName .. "\n" .. helpDesc
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetText(desc)
        else
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetText(tostring(_journalInfo[i]:getName()))
        end
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetAutoResize(true)
        if 1 == dayLogCount % 2 then
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetEnableArea(-PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetTextSizeX() + PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetSizeX(), 0, PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetSizeX(), PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetSizeY())
        else
          PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetEnableArea(0, 0, PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetTextSizeX(), PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:GetSizeY())
        end
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetPosY(sizeY + 20)
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetShow(true)
        PaGlobal_Guild_History_All._ui._dayHistoryValue[i]:SetIgnore(false)
      end
    end
    if true == checkLog then
      sizeY = sizeY + lineGap
      _dayValue[dayIndex]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_HISTORY_DAY", "day", dayIndex))
      _dayValue[dayIndex]:SetShow(true)
      _dayValue[dayIndex]:SetPosY(sizeY + 15)
      _dayLine[dayIndex]:SetShow(true)
      _dayLine[dayIndex]:SetPosY(sizeY + 20)
      dayLogCount = dayLogCount + 1
      firstDay = dayIndex
    end
  end
  if 0 < firstDay then
    PaGlobal_Guild_History_All._ui.frameContent:SetSize(PaGlobal_Guild_History_All._ui.frameContent:GetSizeX(), _dayLine[firstDay]:GetPosY() + 50)
    newContent._verticalLine:SetSize(newContent._verticalLine:GetSizeX(), _dayLine[firstDay]:GetPosY())
    newContent._verticalLine:SetShow(true)
    if PaGlobal_Guild_History_All._noScroll_FrameSize < PaGlobal_Guild_History_All._ui.frameContent:GetSizeY() then
      PaGlobal_Guild_History_All._ui.frameScroll:SetShow(true)
    else
      PaGlobal_Guild_History_All._ui.frameScroll:SetShow(false)
    end
  else
    newContent._verticalLine:SetSize(newContent._verticalLine:GetSizeX(), PaGlobal_Guild_History_All._noScroll_FrameSize)
    newContent._verticalLine:SetShow(false)
    PaGlobal_Guild_History_All._ui.frameContent:SetSize(PaGlobal_Guild_History_All._ui.frameContent:GetSizeX(), PaGlobal_Guild_History_All._noScroll_FrameSize)
    PaGlobal_Guild_History_All._ui.frameScroll:SetShow(false)
  end
  PaGlobal_Guild_History_All._ui.frameScroll:SetInterval(PaGlobal_Guild_History_All._ui.frameContent:GetSizeY() / 100 * 1.1)
  PaGlobal_Guild_History_All._haveInfoMonth = PaGlobal_Guild_History_All._month
  PaGlobal_Guild_History_All._ui.frame_history:UpdateContentScroll()
  PaGlobal_Guild_History_All._ui.frameScroll:SetControlTop()
  PaGlobal_Guild_History_All._ui.frame_history:UpdateContentPos()
end
