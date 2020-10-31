local _panel = Panel_Window_Clan_Renew
local ClanRenew = {
  _ui = {
    stc_TopBg = UI.getChildControl(_panel, "Static_TopBg"),
    stc_ListBg = UI.getChildControl(_panel, "Static_GuildListBg"),
    stc_BottomBg = UI.getChildControl(_panel, "Static_BottomBg"),
    stc_TooltipBG = UI.getChildControl(_panel, "Static_TooltipBG")
  },
  _keyguide = {},
  _isShowAButton = false,
  _showFamilyName = true,
  _currentIndex = nil
}
function ClanRenew:init()
  self._ui.stc_ListTitleBg = UI.getChildControl(self._ui.stc_ListBg, "Static_ListTitleBg")
  self._ui.btn_NameTitle = UI.getChildControl(self._ui.stc_ListTitleBg, "Button_NameTitle")
  self._ui.list_ClanMemberList = UI.getChildControl(self._ui.stc_ListBg, "List2_GuildlistBg")
  self._ui.btn_YConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "Button_Y_ConsoleUI")
  self._ui.btn_AConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "Button_A_ConsoleUI")
  self._ui.btn_XConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "Button_X_ConsoleUI")
  self._ui.btn_BConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "Button_B_ConsoleUI")
  self._keyguide = {
    self._ui.btn_YConsoleUI,
    self._ui.btn_AConsoleUI,
    self._ui.btn_XConsoleUI,
    self._ui.btn_BConsoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.btn_XConsoleUI:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
  self._ui.btn_YConsoleUI:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TOGGLE_SHOW"))
  self._ui.txt_Tooltip = UI.getChildControl(self._ui.stc_TooltipBG, "StaticText_Tooltip")
  self:registEventHandler()
end
function ClanRenew:registEventHandler()
  self._ui.list_ClanMemberList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ClanRenew_CreateControl")
  self._ui.list_ClanMemberList:createChildContent(__ePAUIList2ElementManagerType_List)
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_ClanRenew_SwapFamilyOrCharacterName()")
  registerEvent("FromClient_ResponseChangeGuildMemberGrade", "PaGlobalFunc_ClanRenew_Update")
  registerEvent("FromClient_RequestExpelMemberFromGuild", "PaGlobalFunc_ClanRenew_Update")
  registerEvent("FromClient_ResponseGuildUpdate", "PaGlobalFunc_ClanRenew_Update")
end
function ClanRenew:open()
  ToClient_updateXboxGuildUserGamerTag()
  self:update()
  _panel:SetShow(true)
end
function PaGlobalFunc_ClanRenew_Close()
  ClanRenew:close()
end
function ClanRenew:close()
  if _panel:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(50, 3)
  end
  _panel:SetShow(false)
end
function ClanRenew:update()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    self:close()
    return
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  self._isShowAButton = isGuildMaster or isGuildSubMaster
  local memberCount = myGuildInfo:getMemberCount()
  self._ui.list_ClanMemberList:getElementManager():clearKey()
  for memberIdx = 0, memberCount - 1 do
    self._ui.list_ClanMemberList:getElementManager():pushKey(toInt64(0, memberIdx))
  end
end
function ClanRenew:showTooltip(index)
  local content = self._ui.list_ClanMemberList:GetContentByKey(toInt64(0, index))
  local txt_Name
  if nil ~= content then
    txt_Name = UI.getChildControl(content, "StaticText_NameValue")
    if nil ~= txt_Name and true == txt_Name:IsLimitText() then
      self._ui.txt_Tooltip:SetText(txt_Name:GetText())
      local sizeX = self._ui.txt_Tooltip:GetTextSizeX() + 40
      local posX = self._ui.stc_ListBg:GetPosX() + self._ui.list_ClanMemberList:GetPosX() + txt_Name:GetPosX() + txt_Name:GetSizeX() / 2 - sizeX / 2
      local posY = self._ui.stc_ListBg:GetPosY() + self._ui.list_ClanMemberList:GetPosY() + content:GetPosY() + content:GetSizeY() + 10
      self._ui.stc_TooltipBG:SetShow(true)
      self._ui.stc_TooltipBG:SetSize(sizeX, self._ui.stc_TooltipBG:GetSizeY())
      self._ui.txt_Tooltip:ComputePos()
      self._ui.stc_TooltipBG:SetPosXY(posX, posY)
    end
  end
end
function ClanRenew:hideTooltip()
  self._ui.stc_TooltipBG:SetShow(false)
end
function PaGlobalFunc_ClanRenew_Init()
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self:init()
end
function FGlobal_ClanList_Open()
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self:open()
end
function FGlobal_ClanList_Close()
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self:close()
end
function PaGlobalFunc_ClanRenew_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_ClanRenew_SwapFamilyOrCharacterName()
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self._showFamilyName = not self._showFamilyName
  self:update()
end
function PaGlobalFunc_ClanRenew_CreateControl(content, key)
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    self:close()
    return
  end
  local index = Int64toInt32(key)
  local memberInfo = myGuildInfo:getMember(index)
  if nil == memberInfo then
    return
  end
  local stc_Focus = UI.getChildControl(content, "Static_Focus")
  local txt_Grade = UI.getChildControl(content, "StaticText_Grade")
  local txt_Level = UI.getChildControl(content, "StaticText_LevelTitle")
  local txt_Name = UI.getChildControl(content, "StaticText_NameValue")
  local txt_Class = UI.getChildControl(content, "StaticText_ClassValue")
  local stc_PlatformIcon = UI.getChildControl(content, "Static_CrossPlay")
  local memberGrade = memberInfo:getGrade()
  if __eGuildMemberGradeMaster == memberGrade then
    txt_Grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMASTER"))
  elseif __eGuildMemberGradeSubMaster == memberGrade then
    txt_Grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSUBMASTER"))
  elseif __eGuildMemberGradeJunior == memberGrade then
    txt_Grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NEWBIE"))
  else
    txt_Grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER"))
  end
  local selfPlayerPlatformType = ToClient_getGamePlatformType()
  local memberPlatformType = memberInfo:getPlatformType()
  local gamerTag = ToClient_getXboxGuildUserGamerTag(memberInfo:getUserNo())
  if nil == gamerTag or "" == gamerTag or memberPlatformType ~= selfPlayerPlatformType then
    gamerTag = "-"
  end
  local showName = " - "
  local isOnline = memberInfo:isOnline()
  if true == self._showFamilyName then
    self._ui.btn_NameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_FAMILYNAME") .. " (" .. ToClient_ConsoleUserNameString() .. ")")
    showName = memberInfo:getName()
  else
    self._ui.btn_NameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_CHARACTERNAME") .. " (" .. ToClient_ConsoleUserNameString() .. ")")
    if true == isOnline then
      showName = memberInfo:getCharacterName()
    else
      showName = " - "
    end
  end
  txt_Name:SetTextMode(__eTextMode_LimitText)
  txt_Name:SetText(showName .. " (" .. gamerTag .. ")")
  if true == isOnline then
    txt_Level:SetText(memberInfo:getLevel())
    txt_Class:SetText(CppEnums.ClassType2String[memberInfo:getClassType()])
  else
    txt_Level:SetText("-")
    txt_Class:SetText("-")
  end
  if true == ToClient_isTotalGameClient() then
    self:setCrossPlayIcon(stc_PlatformIcon, memberPlatformType)
  end
  local isSelf = getSelfPlayer():get():getUserNo() == memberInfo:getUserNo()
  local samePlatform = memberPlatformType == selfPlayerPlatformType
  stc_Focus:addInputEvent("Mouse_On", "InputMON_ClanRenew_ShowTooltipAndKeyGuide(" .. index .. "," .. tostring(isSelf) .. "," .. tostring(samePlatform) .. "," .. tostring(isOnline) .. ")")
  stc_Focus:addInputEvent("Mouse_Out", "InputMOUT_ClanRenew_HideTooltip()")
  if nil ~= self._currentIndex and index == self._currentIndex then
    InputMON_ClanRenew_ShowTooltipAndKeyGuide(index)
  end
  if false == ToClient_isPS4() and memberPlatformType == selfPlayerPlatformType then
    stc_Focus:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ClanRenew_ShowXBOXProfile(" .. index .. ")")
  end
  stc_Focus:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildMemberFunction_ClanOpen(" .. index .. ")")
end
function PaGlobalFunc_ClanRenew_ShowXBOXProfile(index)
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    self:close()
    return
  end
  local memberInfo = myGuildInfo:getMember(index)
  if nil == memberInfo then
    return
  end
  if false == memberInfo:isOnline() then
    return
  end
  if getSelfPlayer():get():getUserNo() == memberInfo:getUserNo() then
    return
  end
  local isShow = ToClient_showXboxProfile(memberInfo:getUserNo())
  if false == isShow then
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CANNOTSHOWXBOXPROFILE", "GuildMember", guildMemberInfo:getName()),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobalFunc_ClanRenew_Update()
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self:update()
end
function InputMLUp_ClanRenew_LeaveClan()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "\234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!! : InputMLUp_ClanRenew_LeaveClan")
    return
  end
  local messageboxData
  if true == getSelfPlayer():get():isGuildMaster() then
    if myGuildInfo:getMemberCount() <= 1 then
      messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN_ASK"),
        functionYes = _ClanList_LeaveClanContinue,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANT_CLAN_DISPERSE"))
    end
  else
    local tempText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLANLIST_CLANOUT_ASK")
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_CLAN"),
      content = tempText,
      functionYes = _ClanList_DisJoinContinue,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function _ClanList_LeaveClanContinue()
  FGlobal_ClanList_Close()
  ToClient_RequestDestroyGuild()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function _ClanList_DisJoinContinue()
  FGlobal_ClanList_Close()
  ToClient_RequestDisjoinGuild()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
end
function InputMON_ClanRenew_ShowTooltipAndKeyGuide(index, isSelf, samePlatform, isOnline)
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self._currentIndex = index
  local content = self._ui.list_ClanMemberList:GetContentByKey(toInt64(0, index))
  if nil ~= content then
    local txt_Name = UI.getChildControl(content, "StaticText_NameValue")
    if nil ~= txt_Name and true == txt_Name:IsLimitText() then
      self:showTooltip(index)
    end
  end
  if nil ~= isSelf and nil ~= samePlatform then
    if true == isOnline then
      self._ui.btn_XConsoleUI:SetShow(not isSelf and not ToClient_isPS4() and samePlatform)
    else
      self._ui.btn_XConsoleUI:SetShow(false)
    end
    self._ui.btn_AConsoleUI:SetShow(self._isShowAButton or isSelf)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function InputMOUT_ClanRenew_HideTooltip(isShow)
  local self = ClanRenew
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClanRenew")
    return
  end
  self:hideTooltip()
end
function ClanRenew:setCrossPlayIcon(targetControl, platformType)
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
  end
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_ClanRenew_Init")
