function PaGlobal_GuildWarInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_NoOccupantBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_NoOccupantBg")
  self._ui.stc_LeftGuild_Bg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_LeftGuild")
  self._ui.stc_RightGuild_Bg_2 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_RightGuildx2_Bg")
  self._ui.stc_RightGuild_Bg_4 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_RightGuildx4_Bg")
  self._ui.stc_RightGuild_Bg_list = UI.getChildControl(Panel_GuildWarInfo_All, "List2_RightGuild5OverList")
  self._ui.txt_Title = UI.getChildControl(Panel_GuildWarInfo_All, "StaticText_Title")
  self._ui.btn_Small = UI.getChildControl(self._ui.txt_Title, "Button_Small")
  self._ui.btn_Close = UI.getChildControl(self._ui.txt_Title, "Button_Close")
  self._ui.btn_Reload = UI.getChildControl(Panel_GuildWarInfo_All, "Button_Reload")
  self._ui.stc_TabBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_TabBg")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_TabBg, "Static_SelectLine")
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    self._ui.btn_Territory[index] = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Territory_" .. tostring(index))
  end
  self._ui.stc_FinishBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_FinishBg")
  self._ui.txt_Finish_Desc = UI.getChildControl(self._ui.stc_FinishBg, "StaticText_FinishText")
  self._ui.txt_Result_Desc = UI.getChildControl(self._ui.stc_FinishBg, "StaticText_ResulfText")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_GuildWarInfo_All, "Static_KeyGuideGroup")
  self:initConsole()
  self:initGuild()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildWarInfo_All:initConsole()
  if false == self._isConsole then
    return
  end
  local stc_KeyGuideLB = UI.getChildControl(self._ui.stc_TabBg, "Static_KeyGuideLB")
  local stc_KeyGuideRB = UI.getChildControl(self._ui.stc_TabBg, "Static_KeyGuideRB")
  local txt_IconGuide = UI.getChildControl(Panel_GuildWarInfo_All, "StaticText_BigAndSmallGuide")
  stc_KeyGuideLB:SetShow(self._isConsole)
  stc_KeyGuideRB:SetShow(self._isConsole)
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  txt_IconGuide:SetShow(not self._isConsole)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.btn_Small:SetShow(not self._isConsole)
  self._ui.btn_Reload:SetShow(not self._isConsole)
  self:setKeyGuide()
end
function PaGlobal_GuildWarInfo_All:setKeyGuide()
  local txt_KeyGuideX = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideX")
  local txt_KeyGuideA = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideA")
  local txt_KeyGuideB = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideB")
  local keyGuides = {
    txt_KeyGuideX,
    txt_KeyGuideA,
    txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildWarInfo_All:registEventHandler()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarInfo_All_Close()")
  self._ui.btn_Small:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowSmallWindowTooltip(true)")
  self._ui.btn_Small:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowSmallWindowTooltip(false)")
  self._ui.btn_Small:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenSmallWindow()")
  self._ui.btn_Reload:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowRefreshTooltip(true)")
  self._ui.btn_Reload:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowRefreshTooltip(false)")
  self._ui.btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_Reload()")
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    self._ui.btn_Territory[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_SelectTab(" .. index .. ")")
  end
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_GuildWarInfo_All_ChangeTabConsole(-1)")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_GuildWarInfo_All_ChangeTabConsole(1)")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildWarInfo_All_Reload()")
  registerEvent("Event_SiegeScoreUpdateData", "FromClient_GuildWarInfo_All_UpdateScoreData")
  Panel_GuildWarInfo_All:RegisterUpdateFunc("PaGlobalFunc_GuildWarInfo_All_UpdatePerFrameFunc")
end
function PaGlobal_GuildWarInfo_All:prepareOpen(territoryKey)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  if nil ~= Panel_Window_GuildWarInfoSmall_All and true == PaGlobalFunc_GuildWarInfoSmall_All_GetShow() then
    PaGlobalFunc_GuildWarInfoSmall_All_Close()
  end
  if nil ~= territoryKey then
    self._selectedTerritoryKey = territoryKey
  end
  ToClient_RequestSiegeScore(self._selectedTerritoryKey)
  self:updateBasicInfo()
  self:open()
end
function PaGlobal_GuildWarInfo_All:open()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  Panel_GuildWarInfo_All:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:prepareClose()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(false)
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_GuildWarInfo_All:close()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  Panel_GuildWarInfo_All:SetShow(false)
end
function PaGlobal_GuildWarInfo_All:initGuild()
  self:initDefenceGuild()
  self:initOffenceGuild()
end
function PaGlobal_GuildWarInfo_All:initDefenceGuild()
  self._ui.stc_NoOccupantBg:SetShow(false)
  self._ui.stc_LeftGuild_Bg:SetShow(false)
  local leftProgressBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_ProgressBg")
  local leftBoxBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_Box")
  local guildIconBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_GuildIconBg")
  self._defenceGuildInfo = {
    stc_Bg = self._ui.stc_LeftGuild_Bg,
    stc_GuildIcon = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_GuildIcon"),
    progress_Castle = UI.getChildControl(leftProgressBg, "Progress2_1"),
    txt_GuildName = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_OccupyGuildName"),
    txt_MasterName = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_MasterName"),
    txt_CastleHp = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_Percent"),
    txt_Building = UI.getChildControl(leftBoxBg, "StaticText_DestroyValue"),
    txt_Vehicle = UI.getChildControl(leftBoxBg, "StaticText_ObjectDeathvalue"),
    txt_Member = UI.getChildControl(leftBoxBg, "StaticText_KillValue"),
    txt_Die = UI.getChildControl(leftBoxBg, "StaticText_DeathValue"),
    btn_Record = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Button_Record"),
    stc_Title = {}
  }
  self._defenceGuildInfo.stc_Title[0] = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_Castle")
  self._defenceGuildInfo.stc_Title[1] = UI.getChildControl(leftBoxBg, "StaticText_DestroyTitle")
  self._defenceGuildInfo.stc_Title[2] = UI.getChildControl(leftBoxBg, "StaticText_KillTitle")
  self._defenceGuildInfo.stc_Title[3] = UI.getChildControl(leftBoxBg, "StaticText_ObjectDeathTitle")
  self._defenceGuildInfo.stc_Title[4] = UI.getChildControl(leftBoxBg, "StaticText_DeathTitle")
  self._defenceGuildInfo.btn_Record:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow()")
  local noOccupyTitle = UI.getChildControl(self._ui.stc_NoOccupantBg, "StaticText_NoOccupantInfo_1")
  local noOccupyDesc = UI.getChildControl(self._ui.stc_NoOccupantBg, "StaticText_NoOccupantInfo_Desc")
  noOccupyTitle:SetTextMode(__eTextMode_AutoWrap)
  noOccupyTitle:SetText(noOccupyTitle:GetText())
  noOccupyDesc:SetTextMode(__eTextMode_AutoWrap)
  noOccupyDesc:SetText(noOccupyDesc:GetText())
  noOccupyTitle:SetPosY(noOccupyDesc:GetPosY() - noOccupyTitle:GetTextSizeY() - 20)
  for tIndex = 0, 4 do
    self._defenceGuildInfo.stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
    self._defenceGuildInfo.stc_Title[tIndex]:SetText(self._defenceGuildInfo.stc_Title[tIndex]:GetText())
    self._defenceGuildInfo.stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 0 .. ", " .. tIndex .. ", nil, true)")
    self._defenceGuildInfo.stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false, nil, nil, nil, true)")
  end
end
function PaGlobal_GuildWarInfo_All:initOffenceGuild()
  self._ui.stc_RightGuild_Bg_2:SetShow(false)
  self._ui.stc_RightGuild_Bg_4:SetShow(false)
  self._ui.stc_RightGuild_Bg_list:SetShow(false)
  for index = 0, 1 do
    local rightGuildBg = UI.getChildControl(self._ui.stc_RightGuild_Bg_2, "Static_Guild2_" .. tostring(index + 1) .. "_Bg")
    local rightProgressBg = UI.getChildControl(rightGuildBg, "Static_ProgressBg")
    local rightFlag = UI.getChildControl(rightGuildBg, "Static_RightFlag")
    local guildIconBg = UI.getChildControl(rightFlag, "Static_GuildIconBg")
    self._offenceGuildInfo_2[index] = {
      stc_Bg = rightGuildBg,
      stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
      progress_Castle = UI.getChildControl(rightProgressBg, "Progress2_1"),
      txt_GuildName = UI.getChildControl(rightGuildBg, "StaticText_GuildName"),
      txt_MasterName = UI.getChildControl(rightGuildBg, "StaticText_Name"),
      txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
      txt_Building = UI.getChildControl(rightGuildBg, "StaticText_DestroyValue"),
      txt_Vehicle = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathvalue"),
      txt_Member = UI.getChildControl(rightGuildBg, "StaticText_KillValue"),
      txt_Die = UI.getChildControl(rightGuildBg, "StaticText_DeathValue"),
      stc_Title = {}
    }
    self._offenceGuildInfo_2[index].stc_Title[0] = UI.getChildControl(rightGuildBg, "Static_CatsleIcon")
    self._offenceGuildInfo_2[index].stc_Title[1] = UI.getChildControl(rightGuildBg, "StaticText_DestroyTitle")
    self._offenceGuildInfo_2[index].stc_Title[2] = UI.getChildControl(rightGuildBg, "StaticText_KillTitle")
    self._offenceGuildInfo_2[index].stc_Title[3] = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathTitle")
    self._offenceGuildInfo_2[index].stc_Title[4] = UI.getChildControl(rightGuildBg, "StaticText_DeathTitle")
    self._offenceGuildInfo_2[index].stc_Bg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(index + 1) .. ")")
    for tIndex = 0, 4 do
      if 1 <= tIndex then
        self._offenceGuildInfo_2[index].stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
        self._offenceGuildInfo_2[index].stc_Title[tIndex]:SetText(self._offenceGuildInfo_2[index].stc_Title[tIndex]:GetText())
      end
      self._offenceGuildInfo_2[index].stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 1 .. ", " .. tIndex .. ", " .. index .. ")")
      self._offenceGuildInfo_2[index].stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
    end
    rightGuildBg:SetShow(false)
  end
  for index = 0, 3 do
    local rightGuildBg = UI.getChildControl(self._ui.stc_RightGuild_Bg_4, "Static_Guild4_" .. tostring(index + 1) .. "_Bg")
    local rightProgressBg = UI.getChildControl(rightGuildBg, "Static_ProgressBg")
    local guildIconBg = UI.getChildControl(rightGuildBg, "Static_GuildIconBg")
    self._offenceGuildInfo_4[index] = {
      stc_Bg = rightGuildBg,
      stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
      progress_Castle = UI.getChildControl(rightProgressBg, "Progress2_1"),
      txt_GuildName = UI.getChildControl(rightGuildBg, "StaticText_GuildName"),
      txt_MasterName = UI.getChildControl(rightGuildBg, "StaticText_Name"),
      txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
      txt_Building = UI.getChildControl(rightGuildBg, "StaticText_DestroyValue"),
      txt_Vehicle = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathvalue"),
      txt_Member = UI.getChildControl(rightGuildBg, "StaticText_KillValue"),
      txt_Die = UI.getChildControl(rightGuildBg, "StaticText_DeathValue"),
      stc_Title = {}
    }
    self._offenceGuildInfo_4[index].stc_Title[0] = UI.getChildControl(rightGuildBg, "Static_CatsleIcon")
    self._offenceGuildInfo_4[index].stc_Title[1] = UI.getChildControl(rightGuildBg, "StaticText_DestroyTitle")
    self._offenceGuildInfo_4[index].stc_Title[2] = UI.getChildControl(rightGuildBg, "StaticText_KillTitle")
    self._offenceGuildInfo_4[index].stc_Title[3] = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathTitle")
    self._offenceGuildInfo_4[index].stc_Title[4] = UI.getChildControl(rightGuildBg, "StaticText_DeathTitle")
    self._offenceGuildInfo_4[index].stc_Bg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(index + 1) .. ")")
    for tIndex = 0, 4 do
      if 1 <= tIndex then
        self._offenceGuildInfo_4[index].stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
        self._offenceGuildInfo_4[index].stc_Title[tIndex]:SetText(self._offenceGuildInfo_4[index].stc_Title[tIndex]:GetText())
      end
      self._offenceGuildInfo_4[index].stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 2 .. ", " .. tIndex .. ", " .. index .. ")")
      self._offenceGuildInfo_4[index].stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
    end
    rightGuildBg:SetShow(false)
  end
  self._ui.stc_RightGuild_Bg_list:changeAnimationSpeed(10)
  self._ui.stc_RightGuild_Bg_list:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarInfo_All_UpdateGuildList")
  self._ui.stc_RightGuild_Bg_list:createChildContent(__ePAUIList2ElementManagerType_List)
  self._offenceGuildList = self._ui.stc_RightGuild_Bg_list
end
function PaGlobal_GuildWarInfo_All:updateGuildList(content, index)
  local index_32 = Int64toInt32(index)
  local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, index_32)
  local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, index_32)
  if nil == guildWrapper or nil == siegeBuildingInfo then
    return
  end
  local rightGuildIndex = index_32
  if index_32 > self._defenceGuildIndex then
    rightGuildIndex = rightGuildIndex - 1
  end
  local rightGuildBg = UI.getChildControl(content, "Static_RightGuilListBg")
  local rightInfoBg = UI.getChildControl(rightGuildBg, "Static_RightBG")
  local guildIconBg = UI.getChildControl(rightGuildBg, "Static_GuildIconBg")
  local guildInfo = {
    stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
    txt_GuildName = UI.getChildControl(content, "StaticText_GuildName"),
    txt_MasterName = UI.getChildControl(content, "StaticText_Name"),
    txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
    txt_Building = UI.getChildControl(rightInfoBg, "StaticText_DestroyValue"),
    txt_Vehicle = UI.getChildControl(rightInfoBg, "StaticText_ObjectDeathvalue"),
    txt_Member = UI.getChildControl(rightInfoBg, "StaticText_KillValue"),
    txt_Die = UI.getChildControl(rightInfoBg, "StaticText_DeathValue"),
    stc_Title = {}
  }
  guildInfo.stc_Title[0] = UI.getChildControl(rightInfoBg, "Static_CatsleIcon")
  guildInfo.stc_Title[1] = UI.getChildControl(rightInfoBg, "StaticText_DestroyIcon")
  guildInfo.stc_Title[2] = UI.getChildControl(rightInfoBg, "Static_KillIcon")
  guildInfo.stc_Title[3] = UI.getChildControl(rightInfoBg, "Static_ObjectDeathIcon")
  guildInfo.stc_Title[4] = UI.getChildControl(rightInfoBg, "Static_DeathIcon")
  if false == self._isConsole then
    guildInfo.stc_Title[0]:SetIgnore(false)
  end
  for tIndex = 0, 4 do
    guildInfo.stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 3 .. ", " .. tIndex .. ", " .. rightGuildIndex .. ")")
    guildInfo.stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
  end
  rightGuildBg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(rightGuildIndex + 1) .. ")")
  local guildAllianceName = guildWrapper:getAllianceName()
  if "" == guildAllianceName then
    guildInfo.txt_GuildName:SetText(guildWrapper:getName())
  else
    guildInfo.txt_GuildName:SetText(guildAllianceName)
  end
  guildInfo.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
  local isSet = false
  if true == guildWrapper:isAllianceGuild() then
    isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), guildInfo.stc_GuildIcon)
  else
    isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), guildInfo.stc_GuildIcon)
  end
  if false == isSet then
    guildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(guildInfo.stc_GuildIcon, 183, 1, 188, 6)
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  else
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  end
  guildInfo.txt_Building:SetText(tostring(guildWrapper:getTotalSiegeCount(0)))
  guildInfo.txt_Member:SetText(tostring(guildWrapper:getTotalSiegeCount(1)))
  guildInfo.txt_Die:SetText(tostring(guildWrapper:getTotalSiegeCount(2)))
  guildInfo.txt_Vehicle:SetText(tostring(guildWrapper:getTotalSiegeCount(3)))
  local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
  guildInfo.txt_CastleHp:SetText(math.floor(hpPercent / 100 * 100) .. "%")
  self._offenceGuildListInfo[rightGuildIndex] = guildInfo
  content:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:updateBasicInfo()
  self._ui.stc_LeftGuild_Bg:SetShow(false)
  self._ui.stc_NoOccupantBg:SetShow(false)
  self._ui.stc_RightGuild_Bg_2:SetShow(false)
  self._ui.stc_RightGuild_Bg_4:SetShow(false)
  self._ui.stc_RightGuild_Bg_list:SetShow(false)
  self._ui.stc_FinishBg:SetShow(false)
  for showIndex = 0, 1 do
    self._offenceGuildInfo_2[showIndex].stc_Bg:SetShow(false)
  end
  for showIndex = 0, 3 do
    self._offenceGuildInfo_4[showIndex].stc_Bg:SetShow(false)
  end
  self._isSiegeBeing = isSiegeBeing(self._selectedTerritoryKey)
  local siegeWrapper = ToClient_GetSiegeWrapper(self._selectedTerritoryKey)
  if nil == siegeWrapper then
    return
  end
  if nil ~= self._ui.btn_Territory[self._selectedTerritoryKey] then
    self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(true)
    self._ui.stc_SelectLine:SetPosX(self._ui.btn_Territory[self._selectedTerritoryKey]:GetPosX() + self._ui.btn_Territory[self._selectedTerritoryKey]:GetSizeX() / 2 - self._ui.stc_SelectLine:GetSizeX() / 2)
  end
  if true == self._isSiegeBeing then
    local guildCount = ToClient_SiegeGuildCount(self._selectedTerritoryKey)
    self:updateGuildScore(siegeWrapper, guildCount)
    if siegeWrapper:doOccupantExist() and nil ~= self._defenceGuildNo then
      guildCount = guildCount - 1
      self._ui.stc_LeftGuild_Bg:SetShow(true)
    else
      self._ui.stc_NoOccupantBg:SetShow(true)
    end
    if 5 <= guildCount or self._isConsole then
      self._ui.stc_RightGuild_Bg_list:SetShow(true)
    elseif guildCount <= 2 then
      self._ui.stc_RightGuild_Bg_2:SetShow(true)
    elseif guildCount <= 4 then
      self._ui.stc_RightGuild_Bg_4:SetShow(true)
    end
  else
    if true == siegeWrapper:doOccupantExist() then
      self._ui.txt_Finish_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE_END", "selectTerritoy", siegeWrapper:getTerritoryName()))
      local guildWrapper = ToClient_GetGuildWrapperByGuildNo(siegeWrapper:getGuildNo())
      local allianceName = ""
      if nil ~= guildWrapper then
        allianceName = guildWrapper:getAllianceName()
      end
      if "" == allianceName then
        self._ui.txt_Result_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      else
        self._ui.txt_Result_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_ALLIANCE_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      end
    else
      self._ui.txt_Finish_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE", "selectTerritoy", siegeWrapper:getTerritoryName()))
      self._ui.txt_Result_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC"))
    end
    self._ui.stc_FinishBg:SetShow(true)
  end
end
function PaGlobal_GuildWarInfo_All:updateGuildScore(siegeWrapper, guildCount)
  local isDefenceGuild = false
  local rightGuildIndex = 0
  if nil == siegeWrapper then
    return
  end
  local rightGuildCount = guildCount
  if siegeWrapper:doOccupantExist() then
    rightGuildCount = rightGuildCount - 1
  end
  self._defenceGuildIndex = 999
  self._offenceGuildList:getElementManager():clearKey()
  for index = 0, guildCount - 1 do
    local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, index)
    if nil == guildWrapper then
      return
    end
    if guildWrapper:getGuildNo_s64() == siegeWrapper:getGuildNo() then
      isDefenceGuild = true
      self._defenceGuildNo = guildWrapper:getGuildNo_s64()
      self._defenceGuildIndex = index
    else
      isDefenceGuild = false
      rightGuildIndex = index
      if index > self._defenceGuildIndex then
        rightGuildIndex = rightGuildIndex - 1
      end
      self._offenceGuildNoList[rightGuildIndex] = guildWrapper:getGuildNo_s64()
    end
    if (5 <= rightGuildCount or self._isConsole) and false == isDefenceGuild then
      self._offenceGuildList:getElementManager():pushKey(toInt64(0, index))
    else
      local guildInfo
      if true == isDefenceGuild then
        guildInfo = self._defenceGuildInfo
      elseif rightGuildCount <= 2 then
        guildInfo = self._offenceGuildInfo_2[rightGuildIndex]
      elseif rightGuildCount <= 4 then
        guildInfo = self._offenceGuildInfo_4[rightGuildIndex]
      end
      if nil ~= guildInfo then
        self:setGuildInfo(guildInfo, guildWrapper, index)
      end
    end
  end
end
function PaGlobal_GuildWarInfo_All:setGuildInfo(guildInfo, guildWrapper, index)
  local index_32 = Int64toInt32(index)
  local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, index_32)
  if nil == siegeBuildingInfo then
    return
  end
  if nil == guildInfo then
    return
  end
  local guildAllianceName = guildWrapper:getAllianceName()
  if "" == guildAllianceName then
    guildInfo.txt_GuildName:SetText(guildWrapper:getName())
  else
    guildInfo.txt_GuildName:SetText(guildAllianceName)
  end
  if true == isDefence then
    local _posX = 171 - (guildInfo.txt_GuildName:GetSizeX() + guildInfo.txt_GuildName:GetTextSizeX()) / 2
    guildInfo.txt_GuildName:SetPosX(_posX)
  end
  guildInfo.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
  local isSet = false
  if true == guildWrapper:isAllianceGuild() then
    isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), guildInfo.stc_GuildIcon)
  else
    isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), guildInfo.stc_GuildIcon)
  end
  if false == isSet then
    guildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(guildInfo.stc_GuildIcon, 183, 1, 188, 6)
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  else
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  end
  guildInfo.txt_Building:SetText(tostring(guildWrapper:getTotalSiegeCount(0)))
  guildInfo.txt_Member:SetText(tostring(guildWrapper:getTotalSiegeCount(1)))
  guildInfo.txt_Die:SetText(tostring(guildWrapper:getTotalSiegeCount(2)))
  guildInfo.txt_Vehicle:SetText(tostring(guildWrapper:getTotalSiegeCount(3)))
  local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
  guildInfo.progress_Castle:SetProgressRate(hpPercent / 100 * 100)
  guildInfo.txt_CastleHp:SetText(tostring(hpPercent) .. "%")
  guildInfo.stc_Bg:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:selectTab(index)
  self._selectedTerritoryKey = index
  self:updateBasicInfo()
end
function PaGlobal_GuildWarInfo_All:changeTab(flag)
  local tabIndex = self._selectedTerritoryKey + flag
  if tabIndex >= self._MAXTERRITORYCOUNT then
    tabIndex = 0
  elseif tabIndex < 0 then
    tabIndex = self._MAXTERRITORYCOUNT - 1
  end
  self:selectTab(tabIndex)
end
function PaGlobal_GuildWarInfo_All:reload()
  if 5 < self._guildWarInfoAll_UpdateTimer then
    ToClient_RequestSiegeScore(self._selectedTerritoryKey)
    self._guildWarInfoAll_UpdateTimer = 0
  end
end
function PaGlobal_GuildWarInfo_All:updatePerFrameFunc(deltaTime)
  self._guildWarInfoAll_UpdateTimer = self._guildWarInfoAll_UpdateTimer + deltaTime
  if self._guildWarInfoAll_UpdateTimer > 30 then
    ToClient_RequestSiegeScore(self._selectedTerritoryKey)
    self._guildWarInfoAll_UpdateTimer = 0
  end
end
function PaGlobal_GuildWarInfo_All:validate()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._ui.stc_NoOccupantBg:isValidate()
  self._ui.stc_LeftGuild_Bg:isValidate()
  self._ui.stc_RightGuild_Bg_2:isValidate()
  self._ui.stc_RightGuild_Bg_4:isValidate()
  self._ui.stc_RightGuild_Bg_list:isValidate()
  self._ui.btn_Reload:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Small:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_TabBg:isValidate()
  self._ui.stc_SelectLine:isValidate()
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    self._ui.btn_Territory[index]:isValidate()
  end
  self._ui.stc_FinishBg:isValidate()
  self._ui.txt_Finish_Desc:isValidate()
  self._ui.txt_Result_Desc:isValidate()
  self._ui.stc_KeyGuide:isValidate()
end
