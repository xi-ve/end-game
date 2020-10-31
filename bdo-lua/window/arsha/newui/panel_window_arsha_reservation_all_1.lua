function PaGlobal_Arsha_Reservation_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Close")
  self._ui.stc_SubTitleBG = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_SubTitleArea")
  self._ui.stc_RightArea = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_RightArea")
  self._ui.frame_Desc = UI.getChildControl(self._ui.stc_RightArea, "Frame_Desc")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_Desc, "Frame_1_Content")
  self._ui.frame_Scroll = UI.getChildControl(self._ui.frame_Desc, "Frame_1_VerticalScroll")
  self._ui.txt_Desc = UI.getChildControl(self._ui.frame_Content, "StaticText_Desc")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_LeftBottomArea")
  self._ui.btn_Refresh = UI.getChildControl(self._ui.stc_BottomBG, "Button_Refresh")
  self._ui.btn_Join = UI.getChildControl(self._ui.stc_BottomBG, "Button_FighterJoin")
  self._ui.btn_ObserverJoin = UI.getChildControl(self._ui.stc_BottomBG, "Button_GuestJoin")
  self._ui.stc_ButtonBG = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_LeftMain")
  self._reservationSlotTemplate.btn_Template = UI.getChildControl(self._ui.stc_ButtonBG, "Button_Template")
  self._reservationSlotTemplate.txt_DayOfWeek = UI.getChildControl(self._reservationSlotTemplate.btn_Template, "StaticText_Weekday")
  self._reservationSlotTemplate.txt_Date = UI.getChildControl(self._reservationSlotTemplate.btn_Template, "StaticText_Days")
  self._reservationSlotTemplate.txt_GuildName = UI.getChildControl(self._reservationSlotTemplate.btn_Template, "StaticText_ReserveValue")
  self._reservationSlotTemplate.btn_Reserve = UI.getChildControl(self._reservationSlotTemplate.btn_Template, "Button_Func")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_Unavailale = UI.getChildControl(Panel_Window_Arsha_Reservation_All, "StaticText_Unavailable")
  self:initControl()
  self:createSlot()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Arsha_Reservation_All:registEventHandler()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Reservation_All_Close()")
  self._ui.btn_Refresh:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_Reservation_All_Refresh()")
  self._ui.btn_Join:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Reservation_All_Join(false)")
  self._ui.btn_ObserverJoin:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Reservation_All_Join(true)")
  for index = 0, #self._reservationSlot do
    if self._reservationSlot[index] ~= nil then
      self._reservationSlot[index].btn_Reserve:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Reservation_All_Reservation(" .. index .. ")")
    end
  end
  Panel_Window_Arsha_Reservation_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "PaGlobalFunc_Arsha_Reservation_All_Refresh()")
  Panel_Window_Arsha_Reservation_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Arsha_Reservation_All_Join(false)")
  Panel_Window_Arsha_Reservation_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Arsha_Reservation_All_Join(true)")
  Panel_Window_Arsha_Reservation_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEventUp_Arsha_Reservation_All_MoveScroll(true)")
  Panel_Window_Arsha_Reservation_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEventUp_Arsha_Reservation_All_MoveScroll(false)")
  registerEvent("FromClient_ChangeReservationInfo", "FromClient_Arsha_Reservation_All_ChangeReservationInfo")
  registerEvent("FromClient_RequestTransferHost", "FromClient_Arsha_Reservation_All_RequestTransferHost")
  registerEvent("FromClient_ChangedHost", "FromClient_Arsha_Reservation_All_ChangedHost")
  registerEvent("FromClient_ChangeAssistant", "FromClient_Arsha_Reservation_All_ChangedAssistant")
end
function PaGlobal_Arsha_Reservation_All:prepareOpen()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_arsha) then
    return
  end
  audioPostEvent_SystemUi(1, 18)
  _AudioPostEvent_SystemUiForXBOX(1, 18)
  local isCanDoReservation = ToClient_IsCanDoReservationArsha()
  self._isArshaAvailable = true == _ContentsGroup_Arsha and true == isCanDoReservation
  self:setControl(self._isArshaAvailable)
  if self._isArshaAvailable then
    self:refresh()
  end
  self:open()
end
function PaGlobal_Arsha_Reservation_All:open()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  Panel_Window_Arsha_Reservation_All:SetShow(true)
end
function PaGlobal_Arsha_Reservation_All:prepareClose()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  audioPostEvent_SystemUi(1, 17)
  _AudioPostEvent_SystemUiForXBOX(1, 17)
  self:close()
end
function PaGlobal_Arsha_Reservation_All:close()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  Panel_Window_Arsha_Reservation_All:SetShow(false)
end
function PaGlobal_Arsha_Reservation_All:update()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
end
function PaGlobal_Arsha_Reservation_All:validate()
  if nil == Panel_Window_Arsha_Reservation_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_SubTitleBG:isValidate()
  self._ui.stc_RightArea:isValidate()
  self._ui.frame_Desc:isValidate()
  self._ui.frame_Content:isValidate()
  self._ui.frame_Scroll:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_BottomBG:isValidate()
  self._ui.btn_Refresh:isValidate()
  self._ui.btn_Join:isValidate()
  self._ui.btn_ObserverJoin:isValidate()
  self._ui.stc_ButtonBG:isValidate()
  self._reservationSlotTemplate.btn_Template:isValidate()
  self._reservationSlotTemplate.txt_DayOfWeek:isValidate()
  self._reservationSlotTemplate.txt_Date:isValidate()
  self._reservationSlotTemplate.txt_GuildName:isValidate()
  self._reservationSlotTemplate.btn_Reserve:isValidate()
end
function PaGlobal_Arsha_Reservation_All:changeReservationInfo(dayIndex, dayValue, dayOfWeekValue, reservationGuildName, guildNo, isReservation)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local userGuildNo
  local isMyGuild = false
  local btnText = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_RESERVATION")
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local isGuildLeader = isGuildMaster or isGuildSubMaster
  if nil ~= myGuildInfo then
    userGuildNo = myGuildInfo:getGuildNo_s64()
    isMyGuild = userGuildNo == guildNo
  end
  if dayIndex < 0 or 7 <= dayIndex then
    return
  end
  if isMyGuild then
    btnText = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_17")
  end
  self._reservationSlot[dayIndex].txt_Date:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(dayValue)))
  self._reservationSlot[dayIndex].txt_DayOfWeek:SetText(self._dayOfWeekString[dayOfWeekValue])
  self._reservationSlot[dayIndex].btn_Reserve:SetText(btnText)
  self._reservationSlot[dayIndex].btn_Reserve:SetShow(true)
  if nil == myGuildInfo or false == isGuildMaster or false == self._isArshaAvailable then
    self._reservationSlot[dayIndex].btn_Reserve:SetShow(false)
  end
  if true == isReservation then
    self._reservationSlot[dayIndex].txt_GuildName:SetText(reservationGuildName)
  else
    self._reservationSlot[dayIndex].txt_GuildName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CANDORESERVATIONARSHA"))
  end
end
function PaGlobal_Arsha_Reservation_All:refresh()
  ToClient_RequestArshaReservationList()
end
function PaGlobal_Arsha_Reservation_All:join(isObserver)
  local selfProxy = getSelfPlayer():get()
  local inventory = selfProxy:getInventory()
  local hasItem = inventory:getItemCount_s64(ItemEnchantKey(65012, 0))
  if toInt64(0, 0) == hasItem then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_JOINDESC_HASITEM"))
    return
  end
  if ToClient_IsCompetitionHost() then
    ToClient_RequestEnterCompetitionHost()
  else
    if self:checkExpirationItem(ItemEnchantKey(65012, 0)) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_JOINDESC_HASITEM"))
      return
    end
    ToClient_RequestJoinCompetition(isObserver)
  end
end
function PaGlobal_Arsha_Reservation_All:reservation(reservationIndex, isReservation)
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local reservationInfo = ToClient_GetArshaReservationInfoAt(reservationIndex)
  local reservationPrice = Int64toInt32(ToClient_GetReservationPrice())
  local messageBoxMemo = ""
  local reservationGuildNo = reservationInfo:getGuildNo()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  local userGuildNo
  if nil ~= myGuildInfo then
    userGuildNo = myGuildInfo:getGuildNo_s64()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"))
    return
  end
  if toInt64(0, 0) ~= reservationGuildNo and userGuildNo ~= reservationGuildNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAlreadyReservationDay"))
    return
  end
  if false == isGuildMaster then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCanDoOnlyGuildMaster"))
    return
  end
  local function requestReservation()
    ToClient_RequestCompetitionReservation(reservationIndex, isReservation)
  end
  if nil ~= reservationInfo and toInt64(0, 0) == reservationGuildNo then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_DO_RESERVATION", "reservationPrice", reservationPrice)
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_CANCEL_RESERVATION")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = requestReservation,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Arsha_Reservation_All:moveScroll(isUp)
  if true == isUp then
    self._ui.frame_Scroll:ControlButtonUp()
  elseif false == isUp then
    self._ui.frame_Scroll:ControlButtonDown()
  end
  self._ui.frame_Desc:UpdateContentPos()
  self._ui.frame_Desc:UpdateContentScroll()
end
function PaGlobal_Arsha_Reservation_All:initControl()
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITIONGAME_ESCMENUDESC"))
  self._ui.frame_Content:SetSize(self._ui.frame_Content:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.stc_BottomBG:SetShow(not self._isConsole)
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  Panel_Window_Arsha_Reservation_All:ComputePos()
  if true == self._isConsole then
    Panel_Window_Arsha_Reservation_All:SetSize(Panel_Window_Arsha_Reservation_All:GetSizeX(), Panel_Window_Arsha_Reservation_All:GetSizeY() - self._ui.stc_BottomBG:GetSizeY())
    self._ui.stc_RightArea:SetSize(self._ui.stc_RightArea:GetSizeX(), self._ui.stc_RightArea:GetSizeY() - self._ui.stc_BottomBG:GetSizeY())
    self._ui.frame_Desc:SetSize(self._ui.frame_Desc:GetSizeX(), self._ui.frame_Desc:GetSizeY() - self._ui.stc_BottomBG:GetSizeY())
    self._ui.stc_KeyGuide:SetPosY(Panel_Window_Arsha_Reservation_All:GetSizeY())
  end
  self._ui.txt_Unavailale:SetSize(self._ui.txt_Unavailale:GetSizeX(), self._ui.stc_RightArea:GetSizeY())
  self._ui.txt_Unavailale:SetPosX(self._ui.stc_ButtonBG:GetPosX())
  self._ui.txt_Unavailale:SetPosY(self._ui.stc_RightArea:GetPosY())
end
function PaGlobal_Arsha_Reservation_All:setControl(isArshaAvailable)
  self._ui.stc_SubTitleBG:SetShow(isArshaAvailable)
  self._ui.stc_ButtonBG:SetShow(isArshaAvailable)
  self._ui.stc_BottomBG:SetShow(isArshaAvailable and not self._isConsole)
  self._ui.txt_Unavailale:SetShow(not isArshaAvailable)
  self:setKeyGuide(isArshaAvailable and self._isConsole)
end
function PaGlobal_Arsha_Reservation_All:setKeyGuide(isArshaAvailable)
  local txt_KeyGuide_RSV = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_RSV_ConsoleUI")
  local txt_KeyGuide_RSC = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_RSC_ConsoleUI")
  local txt_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_X_ConsoleUI")
  local txt_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI")
  local txt_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A_ConsoleUI")
  local txt_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B_ConsoleUI")
  txt_KeyGuide_RSC:SetShow(isArshaAvailable)
  txt_KeyGuide_X:SetShow(isArshaAvailable)
  txt_KeyGuide_Y:SetShow(isArshaAvailable)
  txt_KeyGuide_A:SetShow(isArshaAvailable)
  local keyGuide = {
    txt_KeyGuide_RSV,
    txt_KeyGuide_RSC,
    txt_KeyGuide_X,
    txt_KeyGuide_Y,
    txt_KeyGuide_A,
    txt_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_Arsha_Reservation_All:createSlot()
  self._reservationSlot = {}
  for Index = 0, 6 do
    self._reservationSlot[Index] = {}
    local tempSlot = {}
    tempSlot.btn_Template = UI.createControl(__ePAUIControl_Button, self._ui.stc_ButtonBG, "ArshaReservation_SlotBg_" .. Index)
    CopyBaseProperty(self._reservationSlotTemplate.btn_Template, tempSlot.btn_Template)
    tempSlot.btn_Template:SetPosY(10 + (self._reservationSlotTemplate.btn_Template:GetSizeY() + 5) * Index)
    tempSlot.txt_DayOfWeek = UI.createControl(__ePAUIControl_StaticText, tempSlot.btn_Template, "ArshaReservation_SlotDayOfWeek_" .. Index)
    CopyBaseProperty(self._reservationSlotTemplate.txt_DayOfWeek, tempSlot.txt_DayOfWeek)
    tempSlot.txt_DayOfWeek:SetText("")
    tempSlot.txt_DayOfWeek:SetPosX(40)
    tempSlot.txt_DayOfWeek:SetPosY(10)
    tempSlot.txt_Date = UI.createControl(__ePAUIControl_StaticText, tempSlot.btn_Template, "ArshaReservation_SlotDate_" .. Index)
    CopyBaseProperty(self._reservationSlotTemplate.txt_Date, tempSlot.txt_Date)
    tempSlot.txt_Date:SetText("")
    tempSlot.txt_Date:SetPosX(130)
    tempSlot.txt_Date:SetPosY(10)
    tempSlot.txt_GuildName = UI.createControl(__ePAUIControl_StaticText, tempSlot.btn_Template, "ArshaReservation_SlotGuildName_" .. Index)
    CopyBaseProperty(self._reservationSlotTemplate.txt_GuildName, tempSlot.txt_GuildName)
    tempSlot.txt_GuildName:SetText("")
    tempSlot.txt_GuildName:SetPosX(340)
    tempSlot.txt_GuildName:SetPosY(10)
    tempSlot.btn_Reserve = UI.createControl(__ePAUIControl_Button, tempSlot.btn_Template, "ArshaReservation_SlotReserveBtn_" .. Index)
    CopyBaseProperty(self._reservationSlotTemplate.btn_Reserve, tempSlot.btn_Reserve)
    tempSlot.btn_Reserve:SetPosY(5)
    tempSlot.btn_Reserve:SetTextMode(__eTextMode_LimitText)
    self._reservationSlot[Index] = tempSlot
  end
  for _, control in pairs(self._reservationSlotTemplate) do
    control:SetShow(false)
  end
end
function PaGlobal_Arsha_Reservation_All:checkExpirationItem(index)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenSize = getSelfPlayer():get():getInventorySlotCount(true)
  for i = 1, invenSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper and itemKey == itemWrapper:get():getKey():getItemKey() then
        local itemExpiration = itemWrapper:getExpirationDate()
        if nil ~= itemExpiration and false == itemExpiration:isIndefinite() then
          local remainTime = Int64toInt32(getLeftSecond_s64(itemExpiration))
          if remainTime <= 0 then
            return true
          end
        end
      end
    end
  end
  return false
end
