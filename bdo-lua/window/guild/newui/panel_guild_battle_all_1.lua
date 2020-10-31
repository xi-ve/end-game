function PaGlobal_Guild_Battle_All:initialize()
  if true == PaGlobal_Guild_Battle_All._initialize or nil == Panel_Guild_Battle_All then
    return
  end
  self._ui.stc_noReservationArea = UI.getChildControl(Panel_Guild_Battle_All, "Static_NoReservationArea")
  self._ui.txt_explain = UI.getChildControl(self._ui.stc_noReservationArea, "StaticText_Explain")
  self._ui.txt_bottomDesc = UI.getChildControl(self._ui.stc_noReservationArea, "StaticText_BottomDesc")
  self._ui.stc_reservationArea = UI.getChildControl(Panel_Guild_Battle_All, "Static_ReservationArea")
  self._ui.stc_waitGuild = UI.getChildControl(self._ui.stc_reservationArea, "Static_WaitGuild")
  self._ui.txt_waitOtherGuild = UI.getChildControl(self._ui.stc_waitGuild, "StaticText_WaitOtherGuild")
  local myGuildInfo = {}
  myGuildInfo.bg = UI.getChildControl(self._ui.stc_reservationArea, "Static_MyGuild")
  myGuildInfo.name = UI.getChildControl(myGuildInfo.bg, "StaticText_GuildName")
  myGuildInfo.master = UI.getChildControl(myGuildInfo.bg, "StaticText_GuildMaster")
  myGuildInfo.rank = UI.getChildControl(myGuildInfo.bg, "StaticText_GuildRank")
  myGuildInfo.rating = UI.getChildControl(myGuildInfo.bg, "StaticText_GuildPoint")
  myGuildInfo.winPoint = UI.getChildControl(myGuildInfo.bg, "StaticText_WinPoint")
  local guildmarkBG = UI.getChildControl(myGuildInfo.bg, "Static_GuildMarkBG")
  myGuildInfo.guildmark = UI.getChildControl(guildmarkBG, "Static_Mark")
  self._ui._myGuildInfo = myGuildInfo
  local otherGuildInfo = {}
  otherGuildInfo.bg = UI.getChildControl(self._ui.stc_reservationArea, "Static_OtherGuild")
  otherGuildInfo.name = UI.getChildControl(otherGuildInfo.bg, "StaticText_GuildName")
  otherGuildInfo.master = UI.getChildControl(otherGuildInfo.bg, "StaticText_GuildMaster")
  otherGuildInfo.rank = UI.getChildControl(otherGuildInfo.bg, "StaticText_GuildRank")
  otherGuildInfo.rating = UI.getChildControl(otherGuildInfo.bg, "StaticText_GuildPoint")
  otherGuildInfo.winPoint = UI.getChildControl(otherGuildInfo.bg, "StaticText_WinPoint")
  local guildmarkBG2 = UI.getChildControl(otherGuildInfo.bg, "Static_GuildMarkBG")
  otherGuildInfo.guildmark = UI.getChildControl(guildmarkBG2, "Static_Mark")
  self._ui._otherGuildInfo = otherGuildInfo
  self._ui.btn_reservation = UI.getChildControl(Panel_Guild_Battle_All, "Button_Reservation")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_reservationArea, "Button_Cancel")
  self._ui.btn_join = UI.getChildControl(self._ui.stc_reservationArea, "Button_Enterance")
  self._ui.btn_start = UI.getChildControl(self._ui.stc_reservationArea, "Button_Start")
  self._ui.btn_quit = UI.getChildControl(self._ui.stc_reservationArea, "Button_Quit")
  self._ui.txt_progress = UI.getChildControl(self._ui.stc_reservationArea, "StaticText_Progress")
  self._ui.txt_waitTimeTitle = UI.getChildControl(self._ui.stc_reservationArea, "StaticText_WaitTimeTitle")
  self._ui.stc_progressBG = UI.getChildControl(self._ui.stc_reservationArea, "Static_TimeProgressBG")
  self._ui.progress_time = UI.getChildControl(self._ui.stc_reservationArea, "Progress2_TimeProgress")
  self._ui.txt_leftTime = UI.getChildControl(self._ui.stc_reservationArea, "StaticText_LeftTime")
  PaGlobal_Guild_Battle_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Guild_Battle_All:setDefaultData()
  PaGlobal_Guild_Battle_All:registEventHandler()
  PaGlobal_Guild_Battle_All:switchPlatform()
  PaGlobal_Guild_Battle_All:validate()
  PaGlobal_Guild_Battle_All:turnOffAllControl()
  ToClient_GuildBattle_UpdateGuildBattleInfo()
  PaGlobal_Guild_Battle_All._initialize = true
end
function PaGlobal_Guild_Battle_All:turnOffAllControl()
  self._ui.stc_noReservationArea:SetShow(false)
  self._ui.txt_explain:SetShow(false)
  self._ui.txt_bottomDesc:SetShow(false)
  self._ui.stc_reservationArea:SetShow(false)
  self._ui.stc_waitGuild:SetShow(false)
  self._ui._myGuildInfo.bg:SetShow(false)
  self._ui._myGuildInfo.winPoint:SetShow(false)
  self._ui._otherGuildInfo.bg:SetShow(false)
  self._ui._otherGuildInfo.winPoint:SetShow(false)
  self._ui.btn_reservation:SetShow(false)
  self._ui.btn_cancel:SetShow(false)
  self._ui.btn_join:SetShow(false)
  self._ui.btn_start:SetShow(false)
  self._ui.btn_quit:SetShow(false)
  self._ui.txt_progress:SetShow(false)
  self._ui.txt_waitTimeTitle:SetShow(false)
  self._ui.stc_progressBG:SetShow(false)
  self._ui.progress_time:SetShow(false)
  self._ui.txt_leftTime:SetShow(false)
end
function PaGlobal_Guild_Battle_All:registEventHandler()
  registerEvent("FromClient_notifyGuildBattleJoin", "FromClient_Guild_Battle_All_NotifyGuildBattleJoin")
  registerEvent("FromClient_responseRequestGuildBattleInfo", "FromClient_Guild_Battle_All_ResponseRequestGuildBattleInfo")
  registerEvent("FromClient_ReserveGuildBattleSuccess", "FromClient_Guild_Battle_All_ReserveGuildBattleSuccess")
  registerEvent("FromClient_cancelAnotherGuild", "FromClient_Guild_Battle_All_CancelAnotherGuild")
  self._ui.btn_reservation:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Battle_All_Reservation()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Battle_All_Reservation_Cancel()")
  self._ui.btn_join:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Battle_All_Join()")
  self._ui.btn_quit:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Battle_All_UnJoin()")
  self._ui.btn_start:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Battle_All_Start()")
end
function PaGlobal_Guild_Battle_All:setDefaultData()
  self._ui.txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BOTTOMDESC"))
  self._ui.txt_waitOtherGuild:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_waitOtherGuild:SetText(self._ui.txt_waitOtherGuild:GetText())
end
function PaGlobal_Guild_Battle_All:switchPlatform()
end
function PaGlobal_Guild_Battle_All:prepareOpen(index)
  if nil == Panel_GuildMain_All then
    return
  end
  ToClient_GuildBattle_UpdateGuildBattleInfo()
  PaGlobal_Guild_Battle_All:open()
end
function PaGlobal_Guild_Battle_All:open()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_Battle_All:SetShow(true)
end
function PaGlobal_Guild_Battle_All:prepareClose()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Battle_All:close()
end
function PaGlobal_Guild_Battle_All:close()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_Battle_All:SetShow(false)
end
function PaGlobal_Guild_Battle_All:notifyJoinGuildBattle()
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_USE_GUILDWINDOW"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_SET_BATTLE"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  ToClient_GuildBattle_UpdateGuildBattleInfo()
end
function PaGlobal_Guild_Battle_All:setGuildMark(guildNo, mark)
  local isSet = setGuildTextureByGuildNo(guildNo, mark)
  if false == isSet then
    mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(mark, 183, 1, 188, 6)
    mark:getBaseTexture():setUV(x1, y1, x2, y2)
    mark:setRenderTexture(mark:getBaseTexture())
  else
    mark:getBaseTexture():setUV(0, 0, 1, 1)
    mark:setRenderTexture(mark:getBaseTexture())
  end
end
function PaGlobal_Guild_Battle_All:SetGuildInfoOneReserved(guildBattleInfo)
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Battle_All:setGuildMark(guildBattleInfo:getNo(), self._ui._myGuildInfo.guildmark)
  self._ui._myGuildInfo.name:SetText(guildBattleInfo:getName())
  self._ui._myGuildInfo.master:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_MASTERNAME") .. " : " .. guildBattleInfo:getMaster())
  self._ui._myGuildInfo.rank:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDRANK") .. " : " .. tostring(guildBattleInfo:getRanking()) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_RANKING"))
  self._ui._myGuildInfo.rating:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDSCORE") .. " : " .. tostring(guildBattleInfo:getRating()) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_POINT"))
end
function PaGlobal_Guild_Battle_All:SetGuildInfoBothReserved(index, guildBattleInfo)
  if nil == Panel_GuildMain_All then
    return
  end
  local guildInfo = self._ui._myGuildInfo
  if 0 == index then
    guildInfo = self._ui._myGuildInfo
  else
    guildInfo = self._ui._otherGuildInfo
  end
  PaGlobal_Guild_Battle_All:setGuildMark(guildBattleInfo:getNo(), guildInfo.guildmark)
  guildInfo.name:SetText(guildBattleInfo:getName())
  guildInfo.master:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_MASTERNAME") .. " : " .. guildBattleInfo:getMaster())
  guildInfo.rank:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDRANK") .. " : " .. tostring(guildBattleInfo:getRanking()) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_RANKING"))
  guildInfo.rating:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDSCORE") .. " : " .. tostring(guildBattleInfo:getRating()) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_POINT"))
  guildInfo.winPoint:SetText(tostring(guildBattleInfo:winPoint()))
end
function PaGlobal_Guild_Battle_All:SetProgressServer(cancel)
  if nil == Panel_GuildMain_All then
    return
  end
  local progressServer = ToClient_GuildBattle_GetMyGuildBattleServer()
  local channelName = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_NOTDOING")
  local isReserve = false
  if 0 ~= progressServer then
    local curChannelData = getCurrentChannelServerData()
    if nil ~= curChannelData then
      channelName = getChannelName(curChannelData._worldNo, progressServer)
      isReserve = true
      if progressServer ~= curChannelData._serverNo then
        return
      end
    end
    if true == cancel then
      return
    end
  end
  self._canCancel = true
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE")
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE"),
    addMsg = ""
  }
  if true == isReserve then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_RESERVE")
  elseif true == cancel then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_CANCEL")
  else
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_END")
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, 78)
  self._ui.txt_progress:SetText(channelName)
end
function PaGlobal_Guild_Battle_All:setProgressText(battleState, battleMode)
  if __eGuildBattleState_Idle == battleState then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_MATCHING"))
  elseif __eGuildBattleState_Join == battleState then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_JOIN"))
  elseif __eGuildBattleState_End == battleState then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLESTATE_END"))
  elseif __eGuildBattleGameMode_Normal == battleMode then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_NORMAL") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_ONGOING"))
  elseif __eGuildBattleGameMode_OneOne == battleMode then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_ONEONE") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_ONGOING"))
  elseif __eGuildBattleGameMode_All == battleMode then
    self._ui.txt_progress:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_BATTLEMODE_ALL") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_ONGOING"))
  end
end
function PaGlobal_Guild_Battle_All:UpdateGuildBattleInfo()
  if nil == Panel_GuildMain_All then
    return
  end
  local guildA = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(0)
  local guildB = ToClient_GuildBattle_GetCurrentServerGuildBattleInfo(1)
  local amIGuildMasterOrSubMaster = getSelfPlayer():get():isGuildMaster() or getSelfPlayer():get():isGuildSubMaster()
  local amIMaster = ToClient_GuildBattle_AmIMasterForThisBattle()
  local MyGuildServer = ToClient_GuildBattle_GetMyGuildBattleServer()
  local curChannelData = getCurrentChannelServerData()
  local isCurrentGuildServer = false
  local guildCount = 2
  local didIJoinGuildBattle = ToClient_getJoinGuildBattle()
  local battleState = ToClient_GuildBattle_GetCurrentState()
  local battleMode = ToClient_GuildBattle_GetCurrentMode()
  self:turnOffAllControl()
  if 0 ~= MyGuildServer and MyGuildServer ~= curChannelData._serverNo then
    self._ui.stc_noReservationArea:SetShow(true)
    self._ui.stc_reservationArea:SetShow(false)
    local channelName = getChannelName(curChannelData._worldNo, MyGuildServer)
    self._ui.txt_explain:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_ANOTHERSERVER", "server", channelName))
    self._ui.txt_explain:SetShow(true)
    self._ui.txt_bottomDesc:SetShow(true)
    return
  elseif MyGuildServer == curChannelData._serverNo then
    isCurrentGuildServer = true
  end
  if nil == guildA then
    guildCount = guildCount - 1
  end
  if nil == guildB then
    guildCount = guildCount - 1
  end
  if 0 == guildCount then
    self._ui.stc_noReservationArea:SetShow(true)
    self._ui.stc_reservationArea:SetShow(false)
    self._ui.txt_explain:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_NOGUILD"))
    self._ui.txt_explain:SetShow(true)
    self._ui.txt_bottomDesc:SetShow(true)
    if true == amIGuildMasterOrSubMaster then
      self._ui.btn_reservation:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_RESERVE_BUTTON"))
      self._ui.btn_reservation:SetShow(true)
      self._ui.btn_reservation:SetSpanSize(0, 370)
    end
  elseif 1 == guildCount then
    self._ui.stc_noReservationArea:SetShow(false)
    self._ui.stc_reservationArea:SetShow(true)
    self._ui.stc_waitGuild:SetShow(true)
    self._ui._myGuildInfo.bg:SetShow(true)
    self._ui._otherGuildInfo.bg:SetShow(false)
    if nil ~= guildA then
      self:SetGuildInfoOneReserved(guildA)
    else
      self:SetGuildInfoOneReserved(guildB)
    end
    if true == amIGuildMasterOrSubMaster then
      if true == isCurrentGuildServer then
        self._ui.btn_cancel:SetShow(true)
        self._ui.btn_cancel:SetSpanSize(0, 590)
      else
        self._ui.btn_reservation:SetShow(true)
        self._ui.btn_reservation:SetSpanSize(0, 590)
      end
    end
  else
    self._ui.stc_noReservationArea:SetShow(false)
    self._ui.stc_reservationArea:SetShow(true)
    self._ui.stc_waitGuild:SetShow(false)
    self._ui._myGuildInfo.bg:SetShow(true)
    self._ui._otherGuildInfo.bg:SetShow(true)
    self._ui._myGuildInfo.winPoint:SetShow(true)
    self._ui._otherGuildInfo.winPoint:SetShow(true)
    self:SetGuildInfoBothReserved(0, guildA)
    self:SetGuildInfoBothReserved(1, guildB)
    self._ui.txt_progress:SetShow(true)
    PaGlobal_Guild_Battle_All:setProgressText(battleState, battleMode)
    if true == isCurrentGuildServer and __eGuildBattleState_Join == battleState then
      self._ui.txt_waitTimeTitle:SetShow(true)
      self._ui.stc_progressBG:SetShow(true)
      self._ui.progress_time:SetShow(true)
      self._ui.txt_leftTime:SetShow(true)
      if true == amIGuildMasterOrSubMaster then
        if true == amIMaster then
          if true == didIJoinGuildBattle then
            self._ui.btn_start:SetShow(true)
            self._ui.btn_quit:SetShow(true)
            self._ui.btn_start:SetSpanSize(-150, 590)
            self._ui.btn_quit:SetSpanSize(150, 590)
          else
            self._ui.btn_join:SetShow(true)
            self._ui.btn_cancel:SetShow(true)
            self._ui.btn_join:SetSpanSize(-150, 590)
            self._ui.btn_cancel:SetSpanSize(150, 590)
          end
        elseif true == didIJoinGuildBattle then
          self._ui.btn_quit:SetShow(true)
          self._ui.btn_quit:SetSpanSize(0, 590)
        else
          self._ui.btn_join:SetShow(true)
          self._ui.btn_cancel:SetShow(true)
          self._ui.btn_join:SetSpanSize(-150, 590)
          self._ui.btn_cancel:SetSpanSize(150, 590)
        end
      elseif true == didIJoinGuildBattle then
        self._ui.btn_quit:SetShow(true)
        self._ui.btn_quit:SetSpanSize(0, 590)
      else
        self._ui.btn_join:SetShow(true)
        self._ui.btn_join:SetSpanSize(0, 590)
      end
    end
    if false == didIJoinGuildBattle and battleState ~= __eGuildBattleState_Idle and battleState ~= __eGuildBattleState_Join then
      local title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE")
      if true == ToClient_isPersonalBattle() then
        title = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALBATTLE")
      else
        title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE")
      end
      self._ui.txt_progress:SetText(title .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_ONGOING"))
    end
  end
  if 2 == guildCount then
    if true == isCurrentGuildServer and __eGuildBattleState_Join == battleState then
      PaGlobal_Guild_Battle_All:UpdateRemainTime()
    end
  else
    PaGlobal_Guild_Battle_All:resetRemainTime()
  end
  if false == self._CanCancel then
    self._ui.btn_cancel:SetShow(false)
  end
end
function PaGlobal_Guild_Battle_All:UpdateRemainTime()
  if nil == Panel_GuildMain_All then
    return
  end
  local remainTime = ToClient_GuildBattle_GetRemainTime()
  local remainTimeOriginal = ToClient_GuildBattle_GetRemainTimeOriginal()
  if remainTime < 0 then
    remainTime = 0
  end
  local min = math.floor(remainTime / 60)
  local sec = math.floor(remainTime % 60)
  self._ui.txt_leftTime:SetText(tostring(min) .. tostring(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")) .. tostring(sec) .. tostring(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")))
  self._ui.progress_time:SetProgressRate(remainTime * 100 / remainTimeOriginal)
end
function PaGlobal_Guild_Battle_All:resetRemainTime()
  if nil == Panel_GuildMain_All then
    return
  end
  local remainTimeOriginal = ToClient_GuildBattle_GetRemainTimeOriginal()
  local min = math.floor(remainTimeOriginal / 60)
  local sec = math.floor(remainTimeOriginal % 60)
  self._ui.txt_leftTime:SetText(tostring(min) .. tostring(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")) .. tostring(sec) .. tostring(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")))
  self._ui.progress_time:SetProgressRate(100)
end
function PaGlobal_Guild_Battle_All:validate()
  self._ui.stc_noReservationArea:isValidate()
  self._ui.txt_explain:isValidate()
  self._ui.txt_bottomDesc:isValidate()
  self._ui.stc_reservationArea:isValidate()
  self._ui.stc_waitGuild:isValidate()
  self._ui._myGuildInfo.bg:isValidate()
  self._ui._otherGuildInfo.bg:isValidate()
  self._ui.btn_reservation:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.btn_join:isValidate()
  self._ui.btn_start:isValidate()
  self._ui.btn_quit:isValidate()
  self._ui.txt_progress:isValidate()
  self._ui.txt_waitTimeTitle:isValidate()
  self._ui.stc_progressBG:isValidate()
  self._ui.progress_time:isValidate()
  self._ui.txt_leftTime:isValidate()
end
