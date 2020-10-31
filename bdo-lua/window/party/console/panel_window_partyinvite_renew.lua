Panel_Window_PartyInvite:ignorePadSnapMoveToOtherPanel()
local Panel_Window_PartyInvite_info = {
  _ui = {
    static_TabBg = nil,
    txt_Title = nil,
    radioButton_Guild = nil,
    radioButton_Friend = nil,
    tabRadionButton = {},
    list2_Worker = nil,
    stc_Tooltip = nil
  },
  _value = {
    currentIndex = nil,
    currentTabIndex = nil,
    _partyType = CppEnums.PartyType.ePartyType_Normal
  },
  _config = {},
  _enum = {
    eTAB_GUILD = 0,
    eTAB_FRIEND = 1,
    eTAB_XBOXFRIEND = 2,
    eTAB_COUNT = 3
  },
  _color = {
    unSelected = Defines.Color.C_FF525B6D,
    selected = Defines.Color.C_FFEEEEEE
  },
  _guildOnlineMemberListInfo = {},
  _friendOnlineMemberListInfo = {},
  _xboxOnlineMemberListInfo = {}
}
function Panel_Window_PartyInvite_info:registEventHandler()
  Panel_Window_PartyInvite:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobalFunc_PartyInvite_SelectTab(-1)")
  Panel_Window_PartyInvite:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_PartyInvite_SelectTab(1)")
  registerEvent("onScreenResize", "FromClient_PartyInvite_Resize")
  registerEvent("ResponseParty_invite", "FromClient_PartyInvite_Update")
  registerEvent("ResponseParty_updatePartyList", "FromClient_PartyInvite_Update")
  registerEvent("ResponseParty_refuse", "FromClient_PartyInvite_Update")
  registerEvent("ResponseParty_changeLeader", "FromClient_PartyInvite_Update")
  registerEvent("ResponseParty_withdraw", "FromClient_PartyInvite_Update")
end
function Panel_Window_PartyInvite_info:initialize()
  self:childControl()
  self:initValue()
  self:registEventHandler()
end
function Panel_Window_PartyInvite_info:initValue()
  self._value.currentIndex = nil
  self._value.currentTabIndex = nil
end
function Panel_Window_PartyInvite_info:childControl()
  self._ui.static_TabBg = UI.getChildControl(Panel_Window_PartyInvite, "Static_TabBg")
  self._ui.txt_Title = UI.getChildControl(Panel_Window_PartyInvite, "StaticText_Title")
  self._ui.radioButton_Guild = UI.getChildControl(self._ui.static_TabBg, "RadioButton_Guild")
  self._ui.radioButton_Friend = UI.getChildControl(self._ui.static_TabBg, "RadioButton_Friend")
  self._ui.static_BottomBg = UI.getChildControl(Panel_Window_PartyInvite, "Static_BottomBg")
  self._ui.staticText_Close_btn = UI.getChildControl(self._ui.static_BottomBg, "StaticText_Close_ConsoleUI")
  self._ui.staticText_Invite_btn = UI.getChildControl(self._ui.static_BottomBg, "StaticText_Invite_ConsoleUI")
  self._ui.tabRadionButton[self._enum.eTAB_GUILD] = self._ui.radioButton_Guild
  self._ui.tabRadionButton[self._enum.eTAB_FRIEND] = self._ui.radioButton_Friend
  self._ui.tabRadionButton[self._enum.eTAB_XBOXFRIEND] = UI.getChildControl(self._ui.static_TabBg, "RadioButton_XBOXFRIEND")
  local tempBtnGroup = {
    self._ui.tabRadionButton[self._enum.eTAB_GUILD],
    self._ui.tabRadionButton[self._enum.eTAB_FRIEND],
    self._ui.tabRadionButton[self._enum.eTAB_XBOXFRIEND]
  }
  local tempBtnGroup2 = {
    self._ui.staticText_Invite_btn,
    self._ui.staticText_Close_btn
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.static_TabBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER, 0, 30)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup2, self._ui.static_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.list2_Worker = UI.getChildControl(Panel_Window_PartyInvite, "List2_Worker")
  if true == ToClient_isPS4() or false == _ContentsGroup_RenewUI then
    self._ui.tabRadionButton[self._enum.eTAB_XBOXFRIEND]:SetShow(false)
    self._enum.eTAB_COUNT = self._enum.eTAB_COUNT - 1
    local contents = UI.getChildControl(self._ui.list2_Worker, "List2_1_Content")
    local listBtn = UI.getChildControl(contents, "Button_Charater")
    contents:SetSize(contents:GetSizeX(), 90)
    listBtn:SetSize(listBtn:GetSizeX(), 80)
    local static_ClassIcon = UI.getChildControl(contents, "Static_ClassIcon")
    local staticText_Level = UI.getChildControl(contents, "StaticText_Level")
    static_ClassIcon:ComputePos()
    staticText_Level:ComputePos()
  end
  self._ui.list2_Worker:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PartyInvite_ListSetting")
  self._ui.list2_Worker:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.stc_TooltipBG = UI.getChildControl(Panel_Window_PartyInvite, "Static_NameTooltipBG")
  self._ui.txt_Tooltip = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Name")
end
function Panel_Window_PartyInvite_info:clearTab()
  for key, value in pairs(self._ui.tabRadionButton) do
    value:SetFontColor(self._color.unSelected)
  end
end
function Panel_Window_PartyInvite_info:setTab()
  self:clearTab()
  if nil ~= self._ui.tabRadionButton[self._value.currentTabIndex] then
    self._ui.tabRadionButton[self._value.currentTabIndex]:SetFontColor(self._color.selected)
  end
end
function Panel_Window_PartyInvite_info:setList()
  if self._value.currentTabIndex == self._enum.eTAB_GUILD then
    self:setGuildList()
  elseif self._value.currentTabIndex == self._enum.eTAB_FRIEND then
    self:setFriendList()
  elseif self._value.currentTabIndex == self._enum.eTAB_XBOXFRIEND then
    self:setXboxFriendList()
  end
end
function Panel_Window_PartyInvite_info:setGuildList()
  self._ui.list2_Worker:getElementManager():clearKey()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local onlineIndex = 0
  local memberCount = myGuildListInfo:getMemberCount()
  local checkFunc
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    checkFunc = PaGlobalFunc_Widget_Party_All_CheckInParty
  else
    checkFunc = PaGlobalFunc_Party_CheckInParty
  end
  for index = 0, memberCount - 1 do
    local myGuildMemberInfo = myGuildListInfo:getMember(index)
    if nil ~= myGuildMemberInfo then
      local online = myGuildMemberInfo:isOnline()
      local userNo = myGuildMemberInfo:getUserNo()
      local userName = myGuildMemberInfo:getCharacterName()
      local myNo = getSelfPlayer():get():getUserNo()
      if true == online and userNo ~= myNo and false == checkFunc(userName) then
        local memberInfo = {
          index = onlineIndex,
          level = myGuildMemberInfo:getLevel(),
          class = myGuildMemberInfo:getClassType(),
          name = userName,
          userNo = userNo,
          isSameChannel = myGuildMemberInfo:isOnlineSameChannel(),
          platformType = myGuildMemberInfo:getPlatformType()
        }
        self._guildOnlineMemberListInfo[onlineIndex] = memberInfo
        onlineIndex = onlineIndex + 1
      end
    end
  end
  for index = 0, onlineIndex - 1 do
    self._ui.list2_Worker:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_Worker:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_PartyInvite_info:setFriendList()
  self._ui.list2_Worker:getElementManager():clearKey()
  local pcFriendGroup = RequestFriends_getFriendGroupAt(0)
  if nil == pcFriendGroup then
    return
  end
  local onlineIndex = 0
  local friendCount = pcFriendGroup:getFriendCount()
  local checkFunc
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    checkFunc = PaGlobalFunc_Widget_Party_All_CheckInParty
  else
    checkFunc = PaGlobalFunc_Party_CheckInParty
  end
  for friendIndex = 0, friendCount - 1 do
    local friendInfo = pcFriendGroup:getFriendAt(friendIndex)
    if nil ~= friendInfo then
      local isLogin = friendInfo:isOnline()
      local userNo = friendInfo:getUserNo()
      local userName = friendInfo:getCharacterName()
      local isSameChannel = false
      if -1 < friendInfo:getWp() and -1 < friendInfo:getExplorationPoint() then
        isSameChannel = true
      end
      if true == isLogin and false == checkFunc(userName) then
        local memberInfo = {
          index = onlineIndex,
          level = friendInfo:getLevel(),
          class = nil,
          name = userName,
          userNo = userNo,
          isSameChannel = isSameChannel,
          familyName = friendInfo:getName(),
          platformType = friendInfo:getPlatformType()
        }
        self._friendOnlineMemberListInfo[onlineIndex] = memberInfo
        onlineIndex = onlineIndex + 1
      end
    end
  end
  for index = 0, onlineIndex - 1 do
    self._ui.list2_Worker:getElementManager():pushKey(toInt64(0, index))
    self._ui.list2_Worker:requestUpdateByKey(toInt64(0, index))
  end
end
function Panel_Window_PartyInvite_info:setXboxFriendList()
  local listCount = ToClient_InitializeXboxFriendForLua()
  local friendCount = 0
  for friendIdx = 0, listCount - 1 do
    local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(Int64toInt32(friendIdx))
    if true == xboxFriendInfo:isOnline() then
      local memberInfo = {}
      memberInfo.index = friendIdx
      memberInfo.gamerTag = xboxFriendInfo:getGamerTag()
      memberInfo.platformType = xboxFriendInfo:getPlatformType()
      self._xboxOnlineMemberListInfo[friendCount] = memberInfo
      friendCount = friendCount + 1
    end
  end
  self._ui.list2_Worker:getElementManager():clearKey()
  for index = 0, friendCount - 1 do
    self._ui.list2_Worker:getElementManager():pushKey(toInt64(0, index))
  end
end
function Panel_Window_PartyInvite_info:setContent()
  self:setTab()
  self:setList()
end
function Panel_Window_PartyInvite_info:setIcon(control, classType)
  local classSymbolInfo = CppEnums.ClassType_Symbol[classType]
  if nil ~= classSymbolInfo then
    control:ChangeTextureInfoName(classSymbolInfo[1])
    local x1, y1, x2, y2 = setTextureUV_Func(control, classSymbolInfo[2], classSymbolInfo[3], classSymbolInfo[4], classSymbolInfo[5])
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  else
    UI.ASSERT_NAME(false, "classSymbolInfo\234\176\128 nil\236\157\180\235\169\180 \236\149\136 \235\144\169\235\139\136\235\139\164. \236\139\160\234\183\156 \237\129\180\235\158\152\236\138\164\236\157\184\236\167\128 \237\153\149\236\157\184 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\132\156\234\184\176\236\155\144")
  end
end
function Panel_Window_PartyInvite_info:open()
  if false == Panel_Window_PartyInvite:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(50, 1)
  end
  Panel_Window_PartyInvite:SetShow(true)
end
function Panel_Window_PartyInvite_info:close()
  if Panel_Window_PartyInvite:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(50, 3)
  end
  Panel_Window_PartyInvite:SetShow(false)
end
function PaGlobalFunc_PartyInvite_GetShow()
  return Panel_Window_PartyInvite:GetShow()
end
function PaGlobalFunc_PartyInvite_Open()
  local self = Panel_Window_PartyInvite_info
  self:open()
end
function PaGlobalFunc_PartyInvite_Close()
  local self = Panel_Window_PartyInvite_info
  self:close()
end
function PaGlobalFunc_PartyInvite_Show(partyType)
  if false == ToClient_isCommunicationAllowed() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    ToClient_showPrivilegeError()
    return
  end
  local self = Panel_Window_PartyInvite_info
  if partyType == CppEnums.PartyType.ePartyType_Large and true == _ContentsGroup_LargeParty then
    self._value._partyType = CppEnums.PartyType.ePartyType_Large
    self._ui.staticText_Invite_btn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_LARGEPARTY"))
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_LARGEPARTY"))
  else
    self._value._partyType = CppEnums.PartyType.ePartyType_Normal
    self._ui.staticText_Invite_btn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_PARTY"))
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYINVITE_TITLE"))
  end
  local tempBtnGroup = {
    self._ui.staticText_Invite_btn,
    self._ui.staticText_Close_btn
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.static_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._value.currentTabIndex = self._enum.eTAB_GUILD
  self:setContent()
  self:open()
end
function PaGlobalFunc_PartyInvite_Exit()
  local self = Panel_Window_PartyInvite_info
  self:close()
end
function PaGlobalFunc_PartyInvite_SelectTab(value)
  local self = Panel_Window_PartyInvite_info
  self._value.currentTabIndex = (self._value.currentTabIndex + value + self._enum.eTAB_COUNT) % self._enum.eTAB_COUNT
  self:setContent()
  _AudioPostEvent_SystemUiForXBOX(51, 7)
end
function PaGlobalFunc_PartyInvite_ListSetting(list_content, key)
  local self = Panel_Window_PartyInvite_info
  local id = Int64toInt32(key)
  local button_CharaterName = UI.getChildControl(list_content, "Button_Charater")
  local static_ClassIcon = UI.getChildControl(list_content, "Static_ClassIcon")
  local staticText_Level = UI.getChildControl(list_content, "StaticText_Level")
  local stc_PlatformIcon = UI.getChildControl(list_content, "Static_CrossPlay")
  local txt_OnlinId = UI.getChildControl(list_content, "StaticText_OnlineID")
  local txt_Name = UI.getChildControl(list_content, "StaticText_Name")
  local platformType, nameControl
  local selfPlayerPlatformType = ToClient_getGamePlatformType()
  stc_PlatformIcon:SetShow(true)
  stc_PlatformIcon:ComputePos()
  txt_Name:ComputePos()
  stc_PlatformIcon:SetPosX(txt_Name:GetPosX())
  button_CharaterName:SetText("")
  txt_OnlinId:SetText("")
  txt_Name:SetText("")
  if self._value.currentTabIndex == self._enum.eTAB_GUILD then
    local guildMemberData = self._guildOnlineMemberListInfo[id]
    button_CharaterName:SetText(guildMemberData.name)
    platformType = guildMemberData.platformType
    if true == ToClient_isPS4() then
      local psOnlineId = ToClient_getOnlineId(guildMemberData.userNo)
      if nil ~= psOnlineId and "" ~= psOnlineId and platformType == selfPlayerPlatformType then
        button_CharaterName:SetText("")
        txt_OnlinId:SetText("<" .. ToClient_ConsoleUserNameString() .. " : " .. psOnlineId .. ">")
        txt_Name:SetText(guildMemberData.name)
        txt_Name:ComputePos()
        nameControl = txt_Name
      end
    end
    self:setIcon(static_ClassIcon, guildMemberData.class)
    staticText_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. guildMemberData.level)
    static_ClassIcon:SetShow(true)
    staticText_Level:SetShow(true)
    if true == guildMemberData.isSameChannel then
      if self._value._partyType == CppEnums.PartyType.ePartyType_Large then
        button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_LargePartyInvite_ClickInvite(" .. id .. ")")
      else
        button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyInvite_ClickInvite(" .. id .. ")")
      end
    else
      button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyInvite_ShowCannotInviteOtherChannel()")
    end
  elseif self._value.currentTabIndex == self._enum.eTAB_FRIEND then
    local friendMemberData = self._friendOnlineMemberListInfo[id]
    static_ClassIcon:SetShow(false)
    staticText_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. friendMemberData.level)
    platformType = friendMemberData.platformType
    local nameString = friendMemberData.familyName
    if true == friendMemberData.isSameChannel then
      nameString = nameString .. "(" .. friendMemberData.name .. ")"
      button_CharaterName:SetText(nameString)
      if self._value._partyType == CppEnums.PartyType.ePartyType_Large then
        button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_LargePartyInvite_ClickInvite(" .. id .. ")")
      else
        button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyInvite_ClickInvite(" .. id .. ")")
      end
      staticText_Level:SetShow(true)
    else
      button_CharaterName:SetText(nameString)
      button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyInvite_ShowCannotInviteOtherChannel()")
      staticText_Level:SetShow(false)
    end
    if true == ToClient_isPS4() then
      local psOnlineId = ToClient_getOnlineId(friendMemberData.userNo)
      if nil ~= psOnlineId and "" ~= psOnlineId and platformType == selfPlayerPlatformType then
        button_CharaterName:SetText("")
        txt_OnlinId:SetText("<" .. ToClient_ConsoleUserNameString() .. " : " .. psOnlineId .. ">")
        txt_Name:SetText(nameString)
        txt_Name:ComputePos()
        button_CharaterName:addInputEvent("Mouse_On", "PaGlobalFunc_PartyInvite_ShowTooltip(" .. id .. ")")
        button_CharaterName:addInputEvent("Mouse_Out", "PaGlobalFunc_PartyInvite_HideTooltip()")
        nameControl = txt_Name
      end
    end
  elseif self._value.currentTabIndex == self._enum.eTAB_XBOXFRIEND then
    local xboxFriendInfo = self._xboxOnlineMemberListInfo[id]
    button_CharaterName:SetText(xboxFriendInfo.gamerTag)
    static_ClassIcon:SetShow(false)
    staticText_Level:SetShow(false)
    local xboxIndex = xboxFriendInfo.index
    if self._value._partyType == CppEnums.PartyType.ePartyType_Large then
      button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_LargePartyInvite_ClickInvite(" .. xboxIndex .. ")")
    else
      button_CharaterName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PartyInvite_ClickInvite(" .. xboxIndex .. ")")
    end
    platformType = xboxFriendInfo.platformType
  end
  if true == ToClient_isTotalGameClient() then
    PaGlobalFunc_PartyInvite_SetCrossPlayIcon(stc_PlatformIcon, platformType, nameControl)
    txt_OnlinId:SetPosX(txt_Name:GetPosX())
  end
end
function PaGlobalFunc_PartyInvite_ClickInvite(index)
  local self = Panel_Window_PartyInvite_info
  self._value.currentIndex = index
  if self._value.currentTabIndex == self._enum.eTAB_GUILD then
    local name = self._guildOnlineMemberListInfo[index].name
    RequestParty_inviteCharacter(name)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", name))
  elseif self._value.currentTabIndex == self._enum.eTAB_FRIEND then
    local name = self._friendOnlineMemberListInfo[index].name
    RequestParty_inviteCharacter(name)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", name))
  elseif self._value.currentTabIndex == self._enum.eTAB_XBOXFRIEND then
    local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(Int64toInt32(index))
    ToClient_sendXboxInvite(xboxFriendInfo:getXuid(), "Hello!")
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function PaGlobalFunc_LargePartyInvite_ClickInvite(index)
  local self = Panel_Window_PartyInvite_info
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
    return
  end
  self._value.currentIndex = index
  if self._value.currentTabIndex == self._enum.eTAB_GUILD then
    local name = self._guildOnlineMemberListInfo[index].name
    ToClient_InviteLargePartyByCharacterName(name)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_LARGEPARTYINVITE", "targetName", name))
  elseif self._value.currentTabIndex == self._enum.eTAB_FRIEND then
    local name = self._friendOnlineMemberListInfo[index].name
    ToClient_InviteLargePartyByCharacterName(name)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_LARGEPARTYINVITE", "targetName", name))
  elseif self._value.currentTabIndex == self._enum.eTAB_XBOXFRIEND then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYINVITE_XBOXFRIEND_WARNING")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = PaGlobalFunc_PartyInvite_InvitePartyXboxFriend,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function PaGlobalFunc_PartyInvite_InvitePartyXboxFriend()
  if nil == Panel_Window_PartyInvite_info._value.currentIndex then
    return
  end
  local xboxFriendInfo = ToClient_getXboxFriendInfoByIndex(Int64toInt32(Panel_Window_PartyInvite_info._value.currentIndex))
  if nil == xboxFriendInfo then
    return
  end
  ToClient_sendXboxInvite(xboxFriendInfo:getXuid(), "Hello!")
end
function PaGlobalFunc_PartyInvite_ShowTooltip(index)
  local self = Panel_Window_PartyInvite_info
  local contents = self._ui.list2_Worker:GetContentByKey(toInt64(0, index))
  local txt_Name = UI.getChildControl(contents, "StaticText_Name")
  if true == txt_Name:IsLimitText() then
    self._ui.stc_TooltipBG:SetShow(true)
    self._ui.txt_Tooltip:SetText(txt_Name:GetText())
    self._ui.txt_Tooltip:SetSize(self._ui.txt_Tooltip:GetTextSizeX(), self._ui.txt_Tooltip:GetSizeY())
    self._ui.stc_TooltipBG:SetSize(self._ui.txt_Tooltip:GetSizeX() + 20, self._ui.stc_TooltipBG:GetSizeY())
    self._ui.txt_Tooltip:ComputePos()
    local posX = self._ui.list2_Worker:GetPosX() + contents:GetPosX() + txt_Name:GetPosX() + txt_Name:GetSizeX() / 2 - self._ui.stc_TooltipBG:GetSizeX() / 2
    local posY = self._ui.list2_Worker:GetPosY() + contents:GetPosY() + contents:GetSizeY()
    self._ui.stc_TooltipBG:SetPosXY(posX, posY)
  else
    self._ui.stc_TooltipBG:SetShow(false)
  end
end
function PaGlobalFunc_PartyInvite_HideTooltip()
  local self = Panel_Window_PartyInvite_info
  self._ui.stc_TooltipBG:SetShow(false)
end
function PaGlobalFunc_PartyInvite_ShowCannotInviteOtherChannel()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTYINVITE_CANNOTINVITEOTHERCHANNEL"))
end
function PaGlobalFunc_PartyInvite_SetCrossPlayIcon(targetControl, platformType, nameControl)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
    if nil ~= nameControl then
      targetControl:SetPosX(nameControl:GetPosX())
      nameControl:SetPosX(targetControl:GetPosX() + targetControl:GetSizeX() + 5)
    end
  end
end
function FromClient_PartyInvite_Init()
  local self = Panel_Window_PartyInvite_info
  self:initialize()
end
function FromClient_PartyInvite_Resize()
  Panel_Window_PartyInvite:ComputePos()
end
function FromClient_PartyInvite_Update()
  local self = Panel_Window_PartyInvite_info
  if true == PaGlobalFunc_PartyInvite_GetShow() then
    self:setContent()
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PartyInvite_Init")
