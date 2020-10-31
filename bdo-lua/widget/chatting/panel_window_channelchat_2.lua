function PaGlobalFunc_ChannelChat_Open()
  PaGlobal_ChannelChat:prepareOpen()
end
function PaGlobalFunc_ChannelChat_Close()
  PaGlobal_ChannelChat:prepareClose()
end
function HandleEventLUp_Select_ChannelChat(idx)
  local self = PaGlobal_ChannelChat
  if false == self._ui_pc.btn_confirm:IsEnable() then
    local enable = true
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_exit:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_exit:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
    self._ui_pc.btn_exit:SetEnable(enable)
  end
  self._selectIndex = idx
  self._ui.btn_radio[idx]:SetCheck(true)
  local myChannelChatRoomInfo = ToClient_getMyChannelChatRoom()
  local conevertRoomNo = Uint64toUint32(myChannelChatRoomInfo._chatRoomNo) - 1
  if conevertRoomNo ~= self._selectIndex then
    enable = true
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
    self._ui_pc.btn_exit:SetMonoTone(enable)
    self._ui_pc.btn_exit:SetIgnore(enable)
    self._ui_pc.btn_exit:SetEnable(not enable)
  else
    enable = false
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
    self._ui_pc.btn_exit:SetMonoTone(enable)
    self._ui_pc.btn_exit:SetIgnore(enable)
    self._ui_pc.btn_exit:SetEnable(not enable)
  end
end
function HandleEventLUp_ChannelChat_Confirm()
  local chatRoomInfo = ToClient_getChannelChatingRoomIndex(PaGlobal_ChannelChat._selectIndex)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CHANNELTCHAT_ENTER", "chatRoomName", chatRoomName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_ChannelChat_Confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_ChannelChat_Confirm()
  local chatRoomNo = ToClient_getChannelChatRoomNo(PaGlobal_ChannelChat._selectIndex)
  ToClient_JoinChannelChatRoomReq(chatRoomNo)
end
function HandleEventLUp_ChannelChat_Exit()
  local chatRoomInfo = ToClient_getMyChannelChatRoom()
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CHANNELTCHAT_EXIT", "chatRoomName", chatRoomName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_ChannelChat_Exit,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_ChannelChat_Exit()
  local self = PaGlobal_ChannelChat
  local chatRoomNo = ToClient_getChannelChatRoomNo(self._selectIndex)
  ToClient_LeaveChannelChatRoomReq(chatRoomNo)
end
function FromClient_ChannelChatList(isClear)
  if true == isClear then
  end
  local maxShowCount = 0
  local self = PaGlobal_ChannelChat
  local channelChatRoomCount = ToClient_getChannelChaingtRoomCount()
  if channelChatRoomCount < PaGlobal_ChannelChat._maxListCount then
    self._serverListCount = channelChatRoomCount
  else
    self._serverListCount = PaGlobal_ChannelChat._maxListCount
  end
  for index = 0, self._serverListCount - 1 do
    local ChannelChatRoomInfo = ToClient_getChannelChatingRoomIndex(index)
    if nil ~= ChannelChatRoomInfo then
      local roomName = ChannelChatRoomInfo:getRoomName()
      local description = ChannelChatRoomInfo:getDescription()
      self._ui.stc_title[index]:SetText(roomName)
      self._ui.stc_desc[index]:SetText(description)
      UI.setLimitAutoWrapTextAndAddTooltip(self._ui.stc_desc[index], 3, "", self._ui.stc_desc[index]:GetText())
      if index >= self._startItemIndex and index < self._startItemIndex + self._config._slotCount then
        self._ui.btn_title[index]:SetShow(true)
      else
        self._ui.btn_title[index]:SetShow(false)
      end
      local textureHashKey = ChannelChatRoomInfo:getTextureHashKey()
      PaGlobal_ChannelChat:setTextureControl(self._ui.btn_bg[index], textureHashKey)
    else
      self._ui.btn_title[index]:SetShow(false)
    end
  end
  for index = 0, self._serverListCount - 1 do
    self._ui.btn_title[index]:SetCheck(false)
    self._ui.btn_radio[index]:SetCheck(false)
  end
  self._startItemIndex = 0
  self:Scroll(true)
  self._selectIndex = -1
  self._selectIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eChannelChat) - 1
  local enable = true
  if -1 ~= self._selectIndex then
    self._ui.btn_title[self._selectIndex]:SetCheck(true)
    self._ui.btn_radio[self._selectIndex]:SetCheck(true)
    self._ui_pc.btn_confirm:SetMonoTone(enable)
    self._ui_pc.btn_exit:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(enable)
    self._ui_pc.btn_exit:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(not enable)
    self._ui_pc.btn_exit:SetEnable(enable)
  else
    enable = false
    self._ui_pc.btn_confirm:SetMonoTone(not enable)
    self._ui_pc.btn_exit:SetMonoTone(not enable)
    self._ui_pc.btn_confirm:SetIgnore(not enable)
    self._ui_pc.btn_exit:SetIgnore(not enable)
    self._ui_pc.btn_confirm:SetEnable(enable)
    self._ui_pc.btn_exit:SetEnable(enable)
  end
  local myChannelChatRoomInfo = ToClient_getMyChannelChatRoom()
end
function PaGlobalFunc_GetChannelTextureIndex(idx)
  if idx < 0 or idx >= PaGlobal_ChannelChat._serverListCount then
    return -1
  end
  return PaGlobal_ChannelChat.channelIndexToTextureIndex[idx]
end
function FromClient_JoinChannelChatRoom(chatRoomInfo)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eChannelChat, Uint64toUint32(chatRoomInfo._chatRoomNo), CppEnums.VariableStorageType.eVariableStorageType_User)
  if 0 <= PaGlobal_ChannelChat._selectIndex and PaGlobal_ChannelChat._selectIndex < PaGlobal_ChannelChat._serverListCount then
    PaGlobal_ChannelChat._ui.btn_radio[PaGlobal_ChannelChat._selectIndex]:SetCheck(true)
  end
  ChatInput_UpdatePermission()
  enable = false
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetMonoTone(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetIgnore(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetEnable(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetMonoTone(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetIgnore(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetEnable(not enable)
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENTER_CHANNELCHAT", "chatRoomName", chatRoomName))
end
function FromClient_LeaveChannelChatRoom(chatRoomInfo)
  if nil == chatRoomInfo then
    return
  end
  local chatRoomName = chatRoomInfo:getRoomName()
  local undefinedChatRoomNo = 0
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eChannelChat, undefinedChatRoomNo, CppEnums.VariableStorageType.eVariableStorageType_User)
  ChatInput_UpdatePermission()
  enable = true
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetMonoTone(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetIgnore(not enable)
  PaGlobal_ChannelChat._ui_pc.btn_confirm:SetEnable(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetMonoTone(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetIgnore(enable)
  PaGlobal_ChannelChat._ui_pc.btn_exit:SetEnable(not enable)
  for index = 0, PaGlobal_ChannelChat._serverListCount - 1 do
    PaGlobal_ChannelChat._ui.btn_radio[index]:SetCheck(false)
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXIT_CHANNELCHAT", "chatRoomName", chatRoomName))
end
function FromClient_LogoutVoiceChatServer()
  PaGlobal_ChannelChat:clearAll()
end
function FromClient_LoginVoiceChatServer()
  if true == PaGlobal_ChannelChat._isFirstLogin then
    local temporaryWrapper = getTemporaryInformationWrapper()
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    if 2 == userType or 1 == userType then
      local isExistCacheData = ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eChannelChat)
      if false == isExistCacheData then
        local defaultChatRoomNo = 1
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eChannelChat, defaultChatRoomNo, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
    PaGlobal_ChannelChat._isFirstLogin = false
    ToClient_ChannelChattingRoomList()
    ToClient_JoinChannelChatRoomReq(ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eChannelChat))
  end
  if true == Panel_Widget_ChannelChat_Loading:GetShow() then
    PaGlobalFunc_ChannelChat_Loading_Close()
    PaGlobalFunc_ChannelChat_Open()
  end
end
