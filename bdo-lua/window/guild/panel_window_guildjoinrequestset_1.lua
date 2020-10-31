function PaGlobal_GuildJoinRequestSet:init()
  self._ui._btn_close = UI.getChildControl(PaGlobal_GuildJoinRequestSet._ui._stc_title, "Button_Close")
  self._ui._txt_time = UI.getChildControl(PaGlobal_GuildJoinRequestSet._ui._stc_selectBg, "StaticText_Time")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestSet:close()")
  self._rdo_type = Array.new()
  for ii = 0, __eCategoryType_Count - 1 do
    self._rdo_type[ii] = UI.getChildControl(self._ui._stc_selectBg, "RadioButton_" .. tostring(ii))
    self._rdo_type[ii]:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestSet:selectGuildPRType(" .. ii .. ")")
  end
  self._ui._btn_update:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestSet:requestUpdateGuildPR()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestSet:requestCloseGuildPR()")
  self._ui._btn_showList:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild_SetShow(true)")
  self._ui._txt_time:SetText("")
  self._originPanelSize = Panel_Guild_JoinRequestSet:GetSizeY()
  self._originDescSize = self._ui._stc_selectBg:GetSizeY()
  registerEvent("FromClient_updateGuildPRInfo", "FromClient_updateGuildPRInfo")
end
function PaGlobal_GuildJoinRequestSet:clear()
  self._selectType = nil
  for ii = 0, __eCategoryType_Count - 1 do
    self._rdo_type[ii]:SetCheck(false)
  end
  self:updateText()
end
function PaGlobal_GuildJoinRequestSet:open()
  if false == _ContentsGroup_Guild_JoinRequest then
    return
  end
  self:clear()
  PaGlobal_GuildJoinRequestSet:resizeByLeftTime()
  Panel_Guild_JoinRequestSet:RegisterUpdateFunc("Update_GuildJoinRequestSet_FrameEvent")
  Panel_Guild_JoinRequestSet:SetShow(true)
end
function PaGlobal_GuildJoinRequestSet:close()
  Panel_Guild_JoinRequestSet:ClearUpdateLuaFunc("Update_GuildJoinRequestSet_FrameEvent")
  Panel_Guild_JoinRequestSet:SetShow(false)
end
function PaGlobal_GuildJoinRequestSet:selectGuildPRType(type)
  self._selectType = type
end
function PaGlobal_GuildJoinRequestSet:requestUpdateGuildPR()
  if nil == self._selectType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_NOTSELECT"))
    return
  end
  local function requestUpdateGuildPR()
    local isOpen = ToClient_isOpenMyGuildPR()
    if true == isOpen then
      ToClient_requestUpdateGuildPR(__eGuildPRType_Update, self._selectType)
    else
      ToClient_requestUpdateGuildPR(__eGuildPRType_Insert, self._selectType)
    end
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDCONFIRM")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestUpdateGuildPR,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GuildJoinRequestSet:requestCloseGuildPR()
  local requestCloseGuildPR = function()
    ToClient_requestUpdateGuildPR(__eGuildPRType_Delete, __eCategoryType_Count)
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETE")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestCloseGuildPR,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GuildJoinRequestSet:updateText()
  local isOpen = ToClient_isOpenMyGuildPR()
  if true == isOpen then
    self._ui._btn_update:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_NEW_BTN_REFRESHCASH"))
  else
    self._ui._btn_update:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_FILTER_REGIST_BTN"))
  end
end
function PaGlobal_GuildJoinRequestSet:resizeByLeftTime()
  local leftTime = ToClient_getRefreshGuildPRTime()
  local isOpen = ToClient_isOpenMyGuildPR()
  if 0 < leftTime then
    Panel_Guild_JoinRequestSet:SetSize(Panel_Guild_JoinRequestSet:GetSizeX(), self._originPanelSize + 20)
    self._ui._stc_selectBg:SetSize(self._ui._stc_selectBg:GetSizeX(), self._originDescSize + 25)
    local remainTimeText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDUPDATETIME", "time", convertStringFromDatetime(toInt64(0, leftTime)))
    self._ui._txt_time:SetText(remainTimeText)
  else
    Panel_Guild_JoinRequestSet:SetSize(Panel_Guild_JoinRequestSet:GetSizeX(), self._originPanelSize)
    self._ui._stc_selectBg:SetSize(self._ui._stc_selectBg:GetSizeX(), self._originDescSize)
    self._ui._txt_time:SetText("")
  end
  Panel_Guild_JoinRequestSet:ComputePos()
  self._ui._btn_update:ComputePos()
  self._ui._btn_cancel:ComputePos()
  self._ui._btn_showList:ComputePos()
end
