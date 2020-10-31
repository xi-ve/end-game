function PaGlobal_Guild_NoneGuild:init()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  local titleArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Close")
  local radioGroup = UI.getChildControl(Panel_Guild_NoneGuild, "Static_RadioGroup")
  self._ui._categoryType = Array.new()
  for ii = 0, __eCategoryType_Count - 1 do
    self._ui._categoryType[ii] = UI.getChildControl(radioGroup, "RadioButton_Tab" .. tostring(ii))
  end
  self._ui._stc_LBIcon = UI.getChildControl(radioGroup, "Static_SelectLB_C")
  self._ui._stc_RBIcon = UI.getChildControl(radioGroup, "Static_SelectRB_C")
  self._ui._stc_selectLine = UI.getChildControl(radioGroup, "Static_SelctLine")
  local leftArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_LeftArea")
  self._ui._btn_refresh = UI.getChildControl(leftArea, "Button_Refresh")
  self._ui._edit_Search = UI.getChildControl(leftArea, "Edit_Search")
  self._ui._list2_guildList = UI.getChildControl(leftArea, "List2_GuildListBG")
  local rightArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_RightArea")
  self._ui._stc_edge = UI.getChildControl(rightArea, "Static_Edge")
  self._ui._stc_descBG = UI.getChildControl(self._ui._stc_edge, "Static_DescBG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_Desc")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_INFO"))
  self._ui._btn_applyJoin = UI.getChildControl(rightArea, "Button_ApplyJoin")
  self._ui._btn_guildInfo = UI.getChildControl(rightArea, "Button_GuildInfo")
  self._ui._btn_applyJoinList = UI.getChildControl(rightArea, "Button_ApplyJoinList")
  self._ui._txt_noSelectGuild = UI.getChildControl(rightArea, "StaticText_NoSelectGuild")
  PaGlobal_Guild_NoneGuild:SwitchPlatform()
  self:clear()
  PaGlobal_Guild_NoneGuild:EventHandler()
end
function PaGlobal_Guild_NoneGuild:SwitchPlatform()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_refresh:SetShow(false)
    self._ui._stc_LBIcon:SetShow(true)
    self._ui._stc_RBIcon:SetShow(true)
  else
  end
end
function PaGlobal_Guild_NoneGuild:EventHandler()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:close()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Guild_NoneGuild:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Guild_NoneGuild:changeTabForPad(-1)")
    Panel_Guild_NoneGuild:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Guild_NoneGuild:changeTabForPad(1)")
  else
    for ii = 0, __eCategoryType_Count - 1 do
      self._ui._categoryType[ii]:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:setSelected(" .. ii .. ")")
    end
  end
  self._ui._btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:Refresh()")
  self._ui._list2_guildList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Guild_NoneGuild_CreateControlList2")
  self._ui._list2_guildList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_applyJoinList:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:checkApplyListOpen()")
  registerEvent("FromClient_loadCompleteGuildPRList", "FromClient_loadCompleteGuildPRList")
  registerEvent("FromClient_updateGuildApplicant", "FromClient_updateGuildApplicant")
  Panel_Guild_NoneGuild:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "PaGlobal_Guild_NoneGuild:checkApplyListClose()")
end
function PaGlobal_Guild_NoneGuild:open()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  Panel_Guild_NoneGuild:SetShow(true)
  self:clear()
  PaGlobal_Guild_NoneGuild:setSelected(0)
end
function PaGlobal_Guild_NoneGuild:close()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  PaGlobal_Guild_NoneGuild:clear()
  Panel_Guild_NoneGuild:SetShow(false)
end
function PaGlobal_Guild_NoneGuild:checkApplyListOpen()
  if true == self._isApplyListOpen then
    return
  end
  PaGlobal_GuildApplyJoinList:open()
  self._isApplyListOpen = true
end
function PaGlobal_Guild_NoneGuild:checkApplyListClose()
  if true == self._isApplyListOpen then
    PaGlobal_GuildApplyJoinList:close()
    self._isApplyListOpen = false
    return
  end
  PaGlobal_Guild_NoneGuild:close()
end
function PaGlobal_Guild_NoneGuild:setSelected(index)
  local self = PaGlobal_Guild_NoneGuild
  local isSame = self._selectedIndex == index
  if true == isSame then
    return
  end
  if nil ~= self._selectedIndex and nil ~= self._ui._categoryType[self._selectedIndex] then
    self._ui._categoryType[self._selectedIndex]:SetCheck(false)
  end
  self._ui._categoryType[index]:SetCheck(true)
  self._selectedIndex = index
  PaGlobal_Guild_NoneGuild._guildSlotIndex = -1
  local tabPosX = self._ui._categoryType[index]:GetPosX() + self._ui._categoryType[index]:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
  self._ui._stc_selectLine:SetPosX(tabPosX)
  self._ui._stc_edge:SetShow(false)
  self._ui._stc_descBG:SetShow(false)
  self._ui._btn_applyJoin:SetShow(false)
  self._ui._btn_guildInfo:SetShow(false)
  self._ui._txt_noSelectGuild:SetShow(true)
  ToClient_requestGuildPRList(self._selectedIndex, false)
  self:update()
end
function PaGlobal_Guild_NoneGuild:changeTabForPad(moveDir)
  local nextTab = self._selectedIndex + moveDir
  if nextTab < 0 then
    nextTab = __eCategoryType_Count - 1
  elseif nextTab >= __eCategoryType_Count then
    nextTab = 0
  end
  self:setSelected(nextTab)
end
function PaGlobal_Guild_NoneGuild:update()
  local self = PaGlobal_Guild_NoneGuild
  local guildListSize = ToClient_getGuildPRListSize(self._selectedIndex)
  self._ui._list2_guildList:getElementManager():clearKey()
  if 0 < guildListSize then
    for ii = 0, guildListSize - 1 do
      self._ui._list2_guildList:getElementManager():pushKey(ii)
    end
  end
  self._ui._list2_guildList:ComputePos()
end
function PaGlobal_Guild_NoneGuild_SetShow(isShow)
  if true == isShow then
    PaGlobal_Guild_NoneGuild:open()
  else
    PaGlobal_Guild_NoneGuild:close()
  end
end
function PaGlobal_Guild_NoneGuild:Refresh()
  local self = PaGlobal_Guild_NoneGuild
  ToClient_requestGuildPRList(self._selectedIndex, true)
end
function PaGlobal_Guild_NoneGuild:SetRightAreaInfo(index)
  local self = PaGlobal_Guild_NoneGuild
  local wrapper = ToClient_getGuildPRInfoWrapper(self._selectedIndex, index)
  if nil == wrapper then
    return
  end
  PaGlobal_Guild_NoneGuild._guildSlotIndex = index
  local stc_guildMark = UI.getChildControl(self._ui._stc_edge, "Static_GuildMark")
  local stc_mark = UI.getChildControl(stc_guildMark, "Static_Mark")
  local txt_guildName = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildName")
  local txt_guildMaster = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildMaster")
  local txt_guildSize = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildSize")
  local txt_guildPoint = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildPoint")
  local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), stc_mark)
  if false == isSet then
    stc_mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_mark, 183, 1, 188, 6)
    stc_mark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_mark:setRenderTexture(stc_mark:getBaseTexture())
  else
    stc_mark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_mark:setRenderTexture(stc_mark:getBaseTexture())
  end
  txt_guildName:SetText(tostring(wrapper:getGuildName()))
  txt_guildMaster:SetText(tostring(wrapper:getGuildMasterUserNickName()))
  local guildRankString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDRANK")
  local guildSizeString = ""
  local guildMemberCount = wrapper:getMemberCount()
  if guildMemberCount < 31 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif guildMemberCount < 51 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif guildMemberCount < 76 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  else
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  txt_guildSize:SetText(guildRankString .. " " .. guildSizeString)
  local expString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDSCORE")
  txt_guildPoint:SetText(expString .. " : " .. tostring(wrapper:getAquiredSkillPoint()))
  self._ui._btn_applyJoin:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:requestGuildApplicant(" .. self._selectedIndex .. "," .. index .. ")")
  self._ui._btn_guildInfo:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:requestDetailGuildInfo(" .. self._selectedIndex .. "," .. index .. ")")
  self._ui._stc_edge:SetShow(true)
  self._ui._stc_descBG:SetShow(true)
  self._ui._btn_applyJoin:SetShow(true)
  self._ui._btn_guildInfo:SetShow(true)
  self._ui._txt_noSelectGuild:SetShow(false)
end
function PaGlobal_Guild_NoneGuild:clear()
  local self = PaGlobal_Guild_NoneGuild
  self._selectedIndex = -1
  self._guildSlotIndex = -1
  for ii = 0, __eCategoryType_Count - 1 do
    self._ui._categoryType[ii]:SetCheck(false)
  end
  self._ui._categoryType[0]:SetCheck(true)
  local tabPosX = self._ui._categoryType[0]:GetPosX() + self._ui._categoryType[0]:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
  self._ui._stc_selectLine:SetPosX(tabPosX)
  self._ui._stc_edge:SetShow(false)
  self._ui._stc_descBG:SetShow(false)
  self._ui._btn_applyJoin:SetShow(false)
  self._ui._btn_guildInfo:SetShow(false)
  self._ui._txt_noSelectGuild:SetShow(true)
end
function PaGlobal_Guild_NoneGuild:requestPRList()
  local self = PaGlobal_Guild_NoneGuild
end
function PaGlobal_Guild_NoneGuild:requestGuildApplicant(selectedCategory, index)
  local function requestUpdateGuildApplicant()
    ToClient_requestUpdateGuildApplicant(__eGuildApplicantType_Insert, selectedCategory, index)
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERCONFIRM")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestUpdateGuildApplicant,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Guild_NoneGuild:requestDetailGuildInfo(categoryType, index)
  local info = ToClient_getGuildPRInfoWrapper(categoryType, index)
  if nil == info then
    return
  end
  local strGuildNo = tostring(info:getGuildNo())
  FGlobal_GuildWebInfoForGuildRank_Open(strGuildNo)
end
