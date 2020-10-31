function PaGlobal_ClanList_All:initialize()
  if true == PaGlobal_ClanList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ClanList_All:initControl()
  PaGlobal_ClanList_All:setData()
  PaGlobal_ClanList_All:registEventHandler()
  PaGlobal_ClanList_All:validate()
  PaGlobal_ClanList_All._initialize = true
end
function PaGlobal_ClanList_All:initControl()
  if nil == Panel_Window_ClanList_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_ClanList_All, "Static_TitleArea")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_title, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Win_Close")
  self._ui.frame_clanList = UI.getChildControl(Panel_Window_ClanList_All, "Frame_ClanList")
  self._ui.frameContent = UI.getChildControl(self._ui.frame_clanList, "Frame_1_Content")
  self._ui.stc_menuBG = UI.getChildControl(Panel_Window_ClanList_All, "Static_FunctionBG")
  self._ui.btn_clanDispersal = UI.getChildControl(Panel_Window_ClanList_All, "Button_ClanDispersal")
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_ClanList_All, "Static_List_BG")
  self._ui.txt_nameTitle = UI.getChildControl(self._ui.stc_titleBG, "StaticText_M_CharName")
  self._ui.stc_tooltipBG = UI.getChildControl(Panel_Window_ClanList_All, "Static_TooltipBG")
  self._ui.txt_tooltip = UI.getChildControl(self._ui.stc_tooltipBG, "StaticText_Tooltip")
  self._ui.template_memberBG = UI.getChildControl(self._ui.frameContent, "Static_MemberBG")
  self._ui.template_grade = UI.getChildControl(self._ui.template_memberBG, "StaticText_C_Grade")
  self._ui.template_level = UI.getChildControl(self._ui.template_memberBG, "StaticText_C_Level")
  self._ui.template_class = UI.getChildControl(self._ui.template_memberBG, "StaticText_C_Class")
  self._ui.template_name = UI.getChildControl(self._ui.template_memberBG, "StaticText_C_CharName")
  self._ui.template_platformIcon = UI.getChildControl(self._ui.template_memberBG, "Static_CrossPlay")
  self._ui.template_button = UI.getChildControl(Panel_Window_ClanList_All, "Button_Function")
  self._ui.stc_bottomBG = UI.getChildControl(Panel_Window_ClanList_All, "Static_BottomBg")
  self._ui.btn_keyGuideA = UI.getChildControl(self._ui.stc_bottomBG, "Button_A_ConsoleUI")
  self._ui.btn_keyGuideB = UI.getChildControl(self._ui.stc_bottomBG, "Button_B_ConsoleUI")
  self._ui.btn_keyGuideY = UI.getChildControl(self._ui.stc_bottomBG, "Button_Y_ConsoleUI")
  self._ui.btn_keyGuideX = UI.getChildControl(self._ui.stc_bottomBG, "Button_X_ConsoleUI")
  self._keyGuides = {
    self._ui.btn_keyGuideY,
    self._ui.btn_keyGuideA,
    self._ui.btn_keyGuideX,
    self._ui.btn_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui.stc_bottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.btn_setSubMaster = UI.createControl(__ePAUIControl_Button, self._ui.stc_menuBG, "ClanList_SetSubMaster_BTN")
  CopyBaseProperty(self._ui.template_button, self._ui.btn_setSubMaster)
  self._ui.btn_unsetSubMaster = UI.createControl(__ePAUIControl_Button, self._ui.stc_menuBG, "ClanList_UnsetSubMasterClan_BTN")
  CopyBaseProperty(self._ui.template_button, self._ui.btn_unsetSubMaster)
  self._ui.btn_kickClan = UI.createControl(__ePAUIControl_Button, self._ui.stc_menuBG, "ClanList_KickClan_BTN")
  CopyBaseProperty(self._ui.template_button, self._ui.btn_kickClan)
  if true == self._isConsole then
    self._ui.template_memberBG:ChangeOnTextureInfoName("combine/btn/combine_btn_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.template_memberBG, 42, 1, 82, 41)
    self._ui.template_memberBG:getOnTexture():setUV(x1, y1, x2, y2)
    self._ui.template_memberBG:ChangeClickTextureInfoName("combine/btn/combine_btn_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.template_memberBG, 83, 1, 123, 41)
    self._ui.template_memberBG:getClickTexture():setUV(x1, y1, x2, y2)
  end
  local memberListPosY = 5
  for memberIdx = 0, self._maxMemberCount - 1 do
    local list = {}
    local listBG = UI.createControl(__ePAUIControl_Static, self._ui.frameContent, "ClanList_MemberList_" .. memberIdx)
    CopyBaseProperty(self._ui.template_memberBG, listBG)
    listBG:SetSpanSize(listBG:GetSpanSize().x, memberListPosY)
    listBG:SetShow(false)
    list.memberBG = listBG
    local grade = UI.createControl(__ePAUIControl_StaticText, listBG, "ClanList_MemberGrade_" .. memberIdx)
    CopyBaseProperty(self._ui.template_grade, grade)
    grade:SetText(memberIdx)
    grade:SetShow(true)
    list.memberGrade = grade
    local level = UI.createControl(__ePAUIControl_StaticText, listBG, "ClanList_MemberLevel_" .. memberIdx)
    CopyBaseProperty(self._ui.template_level, level)
    level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. memberIdx)
    level:SetShow(true)
    list.memberLevel = level
    local class = UI.createControl(__ePAUIControl_StaticText, listBG, "ClanList_MemberClass_" .. memberIdx)
    CopyBaseProperty(self._ui.template_class, class)
    class:SetText("")
    class:SetShow(true)
    list.memberClass = class
    local name = UI.createControl(__ePAUIControl_StaticText, listBG, "ClanList_MemberName_" .. memberIdx)
    CopyBaseProperty(self._ui.template_name, name)
    name:SetText("")
    name:SetShow(true)
    list.memberName = name
    local paltformIcon = UI.createControl(__ePAUIControl_Static, listBG, "ClanList_MemberPlatformIcon_" .. memberIdx)
    CopyBaseProperty(self._ui.template_platformIcon, paltformIcon)
    paltformIcon:SetShow(false)
    list.memberPlatformIcon = paltformIcon
    self._listPool[memberIdx] = list
    memberListPosY = memberListPosY + listBG:GetSizeY()
  end
  self._ui.frameContent:SetSize(self._ui.frameContent:GetSizeX(), memberListPosY)
end
function PaGlobal_ClanList_All:setData()
  if nil == Panel_Window_ClanList_All then
    return
  end
  self._ui.btn_setSubMaster:SetPosX(5)
  self._ui.btn_setSubMaster:SetPosY(5)
  self._ui.btn_setSubMaster:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER"))
  self._ui.btn_setSubMaster:SetShow(true)
  self._ui.btn_unsetSubMaster:SetPosX(5)
  self._ui.btn_unsetSubMaster:SetPosY(5)
  self._ui.btn_unsetSubMaster:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_3"))
  self._ui.btn_unsetSubMaster:SetShow(true)
  self._ui.btn_kickClan:SetPosX(5)
  self._ui.btn_kickClan:SetPosY(35)
  self._ui.btn_kickClan:SetText(PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON1"))
  self._ui.btn_kickClan:SetShow(true)
  self._ui.stc_menuBG:SetShow(false)
  self._ui.btn_clanDispersal:SetShow(true)
  self._ui.frame_clanList:UpdateContentPos()
  self._ui.frame_clanList:UpdateContentScroll()
  self._ui.template_memberBG:SetShow(false)
  self._ui.template_grade:SetShow(false)
  self._ui.template_level:SetShow(false)
  self._ui.template_class:SetShow(false)
  self._ui.template_name:SetShow(false)
  if true == self._isConsole then
    self._ui.btn_question:SetShow(false)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_keyGuideX:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
    self._ui.btn_keyGuideY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TOGGLE_SHOW"))
  end
end
function PaGlobal_ClanList_All:registEventHandler()
  if nil == Panel_Window_ClanList_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ClanList_All_OnScreenResize")
  registerEvent("FromClient_ResponseGuildUpdate", "PaGlobal_ClanList_All_Update")
  registerEvent("FromClient_ResponseChangeGuildMemberGrade", "PaGlobal_ClanList_All_Update")
  registerEvent("FromClient_RequestExpelMemberFromGuild", "PaGlobal_ClanList_All_Update")
  Panel_Window_ClanList_All:RegisterShowEventFunc(true, "PaGlobal_ClanList_All_ShowAni()")
  Panel_Window_ClanList_All:RegisterShowEventFunc(false, "PaGlobal_ClanList_All_HideAni()")
  if true == self._isConsole then
    Panel_Window_ClanList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ClanList_All_SwapFamilyOrCharacterName()")
    PaGlobal_ClanList_All._ui.btn_setSubMaster:addInputEvent("Mouse_On", "HandleEventOn_ClanList_All_DefaultKeyGuide()")
    PaGlobal_ClanList_All._ui.btn_kickClan:addInputEvent("Mouse_On", "HandleEventOn_ClanList_All_DefaultKeyGuide()")
    PaGlobal_ClanList_All._ui.btn_unsetSubMaster:addInputEvent("Mouse_On", "HandleEventOn_ClanList_All_DefaultKeyGuide()")
    PaGlobal_ClanList_All._ui.btn_clanDispersal:addInputEvent("Mouse_On", "HandleEventOn_ClanList_All_DefaultKeyGuide()")
  else
    PaGlobal_ClanList_All._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelClan\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_ClanList_All._ui.btn_question, "\"PanelClan\"")
    PaGlobal_ClanList_All._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ClanList_All_Close()")
    PaGlobal_ClanList_All._ui.stc_menuBG:addInputEvent("Mouse_Out", "HandleEventOut_ClanList_All_MouseOutClanMenu()")
    PaGlobal_ClanList_All._ui.btn_setSubMaster:addInputEvent("Mouse_Out", "HandleEventOut_ClanList_All_MouseOutClanMenu()")
    PaGlobal_ClanList_All._ui.btn_kickClan:addInputEvent("Mouse_Out", "HandleEventOut_ClanList_All_MouseOutClanMenu()")
    PaGlobal_ClanList_All._ui.btn_unsetSubMaster:addInputEvent("Mouse_Out", "HandleEventOut_ClanList_All_MouseOutClanMenu()")
  end
  PaGlobal_ClanList_All._ui.btn_setSubMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_SetSubMaster()")
  PaGlobal_ClanList_All._ui.btn_kickClan:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_KickClan()")
  PaGlobal_ClanList_All._ui.btn_unsetSubMaster:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_UnsetSubMaster()")
  PaGlobal_ClanList_All._ui.btn_clanDispersal:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_LeaveClan()")
end
function PaGlobal_ClanList_All:prepareOpen()
  if nil == Panel_Window_ClanList_All then
    return
  end
  if true == _ContentsGroup_RenewUI then
    ToClient_updateXboxGuildUserGamerTag()
  end
  FromClient_ClanList_All_OnScreenResize()
  PaGlobal_ClanList_All:listUpdate()
  PaGlobal_ClanList_All:open()
end
function PaGlobal_ClanList_All:open()
  if nil == Panel_Window_ClanList_All then
    return
  end
  if true == self._isConsole then
    Panel_Window_ClanList_All:SetShow(true, false)
  else
    Panel_Window_ClanList_All:SetShow(true, true)
  end
end
function PaGlobal_ClanList_All:prepareClose()
  if nil == Panel_Window_ClanList_All then
    return
  end
  if true == self._isConsole and true == Panel_Window_ClanList_All:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(50, 3)
    if true == self._ui.stc_menuBG:GetShow() then
      self._ui.stc_menuBG:SetShow(false)
      return
    end
  end
  PaGlobal_ClanList_All:close()
end
function PaGlobal_ClanList_All:close()
  if nil == Panel_Window_ClanList_All then
    return
  end
  Panel_Window_ClanList_All:SetShow(false, false)
end
function PaGlobal_ClanList_All:validate()
  if nil == Panel_Window_ClanList_All then
    return
  end
end
function PaGlobal_ClanList_All:listUpdate()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  if 0 ~= guildGrade then
    return
  end
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  if true == isGuildMaster then
    PaGlobal_ClanList_All._ui.btn_clanDispersal:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN"))
  else
    PaGlobal_ClanList_All._ui.btn_clanDispersal:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_CLAN"))
  end
  PaGlobal_ClanList_All._ui.stc_menuBG:SetShow(false)
  for memberIdx = 0, self._maxMemberCount - 1 do
    self._listPool[memberIdx].memberBG:SetShow(false)
  end
  local memberCount = myGuildInfo:getMemberCount()
  for memberIdx = 0, memberCount - 1 do
    if memberIdx >= self._maxMemberCount then
      return
    end
    local uiPool = self._listPool[memberIdx]
    if nil == uiPool then
      return
    end
    uiPool.memberBG:SetShow(true)
    local memberData = myGuildInfo:getMember(memberIdx)
    local grade = memberData:getGrade()
    local level = memberData:getLevel()
    local classType = memberData:getClassType()
    if __eGuildMemberGradeMaster == grade then
      uiPool.memberGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMASTER"))
    elseif __eGuildMemberGradeSubMaster == grade then
      uiPool.memberGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSUBMASTER"))
    elseif __eGuildMemberGradeNormal == grade then
      uiPool.memberGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER"))
    else
      uiPool.memberGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NEWBIE"))
    end
    if true == memberData:isOnline() then
      uiPool.memberGrade:SetFontColor(Defines.Color.C_FFC4BEBE)
      uiPool.memberLevel:SetFontColor(Defines.Color.C_FFC4BEBE)
      uiPool.memberLevel:SetText(level)
      uiPool.memberClass:SetFontColor(Defines.Color.C_FFC4BEBE)
      uiPool.memberClass:SetText(CppEnums.ClassType2String[classType])
    else
      uiPool.memberGrade:SetFontColor(Defines.Color.C_FF515151)
      uiPool.memberLevel:SetFontColor(Defines.Color.C_FF515151)
      uiPool.memberLevel:SetText("-")
      uiPool.memberClass:SetFontColor(Defines.Color.C_FF515151)
      uiPool.memberClass:SetText("-")
    end
    local selfPlayerPlatformType = ToClient_getGamePlatformType()
    local memberPlatformType = memberData:getPlatformType()
    if false == _ContentsGroup_RenewUI then
      if true == memberData:isOnline() then
        uiPool.memberName:SetFontColor(Defines.Color.C_FFC4BEBE)
        uiPool.memberName:SetText(memberData:getName() .. " (" .. memberData:getCharacterName() .. ")")
      else
        uiPool.memberName:SetFontColor(Defines.Color.C_FF515151)
        uiPool.memberName:SetText(memberData:getName() .. " ( - )")
      end
    else
      local gamerTag = ToClient_getXboxGuildUserGamerTag(memberData:getUserNo())
      if nil == gamerTag or "" == gamerTag or memberPlatformType ~= selfPlayerPlatformType then
        gamerTag = "-"
      end
      local showName = " - "
      if true == self._showFamilyName then
        self._ui.txt_nameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_FAMILYNAME") .. " (" .. ToClient_ConsoleUserNameString() .. ")")
        showName = memberData:getName()
      else
        self._ui.txt_nameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_CHARACTERNAME") .. " (" .. ToClient_ConsoleUserNameString() .. ")")
        if true == memberData:isOnline() then
          showName = memberData:getCharacterName()
        else
          showName = " - "
        end
      end
      uiPool.memberName:SetTextMode(__eTextMode_LimitText)
      uiPool.memberName:SetText(showName .. " (" .. gamerTag .. ")")
      if true == memberData:isOnline() then
        uiPool.memberName:SetFontColor(Defines.Color.C_FFC4BEBE)
      else
        uiPool.memberName:SetFontColor(Defines.Color.C_FF515151)
      end
    end
    if true == _ContentsGroup_RenewUI and true == ToClient_isTotalGameClient() then
      self:setCrossPlayIcon(uiPool.memberPlatformIcon, memberData:getPlatformType())
    end
    if false == _ContentsGroup_RenewUI then
      uiPool.memberName:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_MemberMenu(" .. memberIdx .. ")")
    else
      uiPool.memberBG:SetIgnore(false)
      uiPool.memberBG:addInputEvent("Mouse_LUp", "HandleEventLUp_ClanList_All_MemberMenu(" .. memberIdx .. ")")
      local isSelf = getSelfPlayer():get():getUserNo() == memberData:getUserNo()
      local samePlatform = memberPlatformType == selfPlayerPlatformType
      uiPool.memberBG:addInputEvent("Mouse_On", "HandleEventOn_ClanList_All_ShowTooltipAndKeyGuide(" .. memberIdx .. "," .. tostring(isSelf) .. "," .. tostring(samePlatform) .. "," .. tostring(memberData:isOnline()) .. ")")
      uiPool.memberBG:addInputEvent("Mouse_Out", "HandleEventOut_ClanList_All_HideTooltip()")
      if nil ~= self._currentPadOnIndex and memberIdx == self._currentPadOnIndex then
        PaGlobal_ClanList_All:refreshTooltip(memberIdx)
      end
      if false == ToClient_isPS4() and memberPlatformType == selfPlayerPlatformType then
        uiPool.memberBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventPadX_ClanList_All_ShowXBOXProfile(" .. memberIdx .. ")")
      end
    end
  end
end
function PaGlobal_ClanList_All:setButtonPos(buttonCount)
  local buttonSizeX = PaGlobal_ClanList_All._ui.template_button:GetSizeX()
  local buttonSizeY = PaGlobal_ClanList_All._ui.template_button:GetSizeY()
  local gap = 5
  if 1 == buttonCount then
    PaGlobal_ClanList_All._ui.btn_kickClan:SetPosX(gap)
    PaGlobal_ClanList_All._ui.btn_kickClan:SetPosY(gap)
    PaGlobal_ClanList_All._ui.stc_menuBG:SetSize(buttonSizeX + gap * 2, buttonSizeY + gap * 2)
  elseif 2 == buttonCount then
    PaGlobal_ClanList_All._ui.btn_setSubMaster:SetPosX(gap)
    PaGlobal_ClanList_All._ui.btn_setSubMaster:SetPosY(gap)
    PaGlobal_ClanList_All._ui.btn_unsetSubMaster:SetPosX(gap)
    PaGlobal_ClanList_All._ui.btn_unsetSubMaster:SetPosY(gap)
    PaGlobal_ClanList_All._ui.btn_kickClan:SetPosX(gap)
    PaGlobal_ClanList_All._ui.btn_kickClan:SetPosY(buttonSizeY + gap * 2)
    PaGlobal_ClanList_All._ui.stc_menuBG:SetSize(buttonSizeX + gap * 2, buttonSizeY * 2 + gap * 3)
  end
end
function PaGlobal_ClanList_All:setCrossPlayIcon(targetControl, platformType)
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
function PaGlobal_ClanList_All:refreshTooltip(index)
  local list = self._listPool[index]
  if nil == list then
    return
  end
  if true == list.memberName:IsLimitText() then
    self._ui.txt_tooltip:SetText(list.memberName:GetText())
    self._ui.stc_tooltipBG:SetSize(self._ui.txt_tooltip:GetTextSizeX() + 40, self._ui.stc_tooltipBG:GetSizeY())
    local posX = self._ui.frame_clanList:GetPosX() + list.memberBG:GetPosX() + list.memberName:GetPosX() + list.memberName:GetSizeX() / 2 - self._ui.stc_tooltipBG:GetSizeX() / 2
    local posY = self._ui.frame_clanList:GetPosY() + list.memberBG:GetPosY() + list.memberBG:GetSizeY() + 10
    self._ui.stc_tooltipBG:SetPosXY(posX, posY)
    self._ui.txt_tooltip:ComputePos()
  end
end
