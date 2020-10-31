function PaGlobal_GuildWarScore_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_Title = UI.getChildControl(Panel_GuildWarScore_All, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.txt_Title, "Button_Win_Close")
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.list_GuildWarfare = UI.getChildControl(Panel_GuildWarScore_All, "List2_GuildWarfare")
  self._ui.list_Content = UI.getChildControl(self._ui.list_GuildWarfare, "List2_1_Content")
  self._ui.txt_IconHelper = UI.getChildControl(Panel_GuildWarScore_All, "StaticText_IconHelper")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_GuildWarScore_All, "Static_KeyGuideGroup")
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  self._ui.titleGroup = {
    [0] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_CommandCenter"),
    [1] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_Tower"),
    [2] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_CastleGate"),
    [3] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_Summons"),
    [4] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_Installation"),
    [5] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_Member"),
    [6] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_Death"),
    [7] = UI.getChildControl(Panel_GuildWarScore_All, "Static_M_KillBySiege")
  }
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildWarScore_All:registEventHandler()
  if nil == Panel_GuildWarScore_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarScore_All_Close()")
  for index = 0, self._MAXTITLECOUNT - 1 do
    self._ui.titleGroup[index]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarScore_All_ShowTitleTooltip(true, " .. index .. ")")
    self._ui.titleGroup[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarScore_All_ShowTitleTooltip(false, " .. index .. ")")
  end
  self._ui.list_GuildWarfare:changeAnimationSpeed(10)
  self._ui.list_GuildWarfare:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarInfoScore_All_UpdateScoreList")
  self._ui.list_GuildWarfare:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_GuildWarScore_All:prepareOpen(guildNo)
  if nil == Panel_GuildWarScore_All then
    return
  end
  self:update(guildNo)
  self:open()
  Panel_GuildWarScore_All:ignorePadSnapMoveToOtherPanel()
end
function PaGlobal_GuildWarScore_All:open()
  if nil == Panel_GuildWarScore_All then
    return
  end
  Panel_GuildWarScore_All:SetShow(true)
end
function PaGlobal_GuildWarScore_All:prepareClose()
  if nil == Panel_GuildWarScore_All then
    return
  end
  self:close()
end
function PaGlobal_GuildWarScore_All:close()
  if nil == Panel_GuildWarScore_All then
    return
  end
  Panel_GuildWarScore_All:SetShow(false)
end
function PaGlobal_GuildWarScore_All:update(guildNo)
  if nil == Panel_GuildWarScore_All then
    return
  end
  local guildAlliance = ToClient_GetGuildAllianceWrapperbyNo(guildNo)
  local memberCount = 0
  self._selectedGuildNo = guildNo
  self._ui.list_GuildWarfare:getElementManager():clearKey()
  self._ui.list_GuildWarfare:SetShow(false)
  if nil == guildAlliance then
    local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(guildNo)
    if nil == guildWrapper then
      return
    end
    memberCount = guildWrapper:getTopMemberCount()
    for index = 0, memberCount - 1 do
      self._ui.list_GuildWarfare:getElementManager():pushKey(toInt64(0, index))
    end
  else
    for index = 0, guildAlliance:getMemberCount() - 1 do
      local guildWrapper = guildAlliance:getMemberGuild(index)
      if nil == guildWrapper then
        return
      end
      memberCount = guildWrapper:getTopMemberCount()
      for index = 0, memberCount - 1 do
        self._ui.list_GuildWarfare:getElementManager():pushKey(toInt64(0, index))
      end
    end
  end
end
function PaGlobal_GuildWarScore_All:updateScoreList(content, index)
  local stc_slotBg = UI.getChildControl(content, "Static_SlotBG")
  stc_slotBg:SetShow(false)
  local index_32 = Int64toInt32(index)
  local guildAlliance = ToClient_GetGuildAllianceWrapperbyNo(self._selectedGuildNo)
  local guildWrapper
  if nil == guildAlliance then
    guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(self._selectedGuildNo)
  else
    guildWrapper = guildAlliance:getMemberGuild(index_32)
  end
  if nil == guildWrapper then
    return
  end
  local userNo = guildWrapper:getTopMemberUserNobyIndex(index_32)
  local guildMemberWrapper = guildWrapper:getMemberByUserNo(userNo)
  if nil == guildMemberWrapper then
    return
  end
  stc_slotBg:SetShow(true)
  self._ui.list_GuildWarfare:SetShow(true)
  local guildScoreInfo = {
    txt_CharName = UI.getChildControl(stc_slotBg, "StaticText_C_CharName"),
    txt_Tower = UI.getChildControl(stc_slotBg, "StaticText_C_Tower"),
    txt_Center = UI.getChildControl(stc_slotBg, "StaticText_C_CommandCenter"),
    txt_Castle = UI.getChildControl(stc_slotBg, "StaticText_C_CastleGate"),
    txt_Summon = UI.getChildControl(stc_slotBg, "StaticText_C_Summons"),
    txt_Installation = UI.getChildControl(stc_slotBg, "StaticText_C_Installation"),
    txt_Member = UI.getChildControl(stc_slotBg, "StaticText_C_Member"),
    txt_Death = UI.getChildControl(stc_slotBg, "StaticText_C_Death"),
    txt_Kill = UI.getChildControl(stc_slotBg, "StaticText_C_KillBySiege")
  }
  if guildMemberWrapper:isOnline() then
    guildScoreInfo.txt_CharName:SetText(guildMemberWrapper:getName() .. " (" .. guildMemberWrapper:getCharacterName() .. ")")
    guildScoreInfo.txt_CharName:SetFontColor(Defines.Color.C_FFEFEFEF)
  else
    guildScoreInfo.txt_CharName:SetText(guildMemberWrapper:getName() .. " ( - )")
    guildScoreInfo.txt_CharName:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  guildScoreInfo.txt_Tower:SetText(guildMemberWrapper:towerCount())
  guildScoreInfo.txt_Center:SetText(guildMemberWrapper:commandPostCount())
  guildScoreInfo.txt_Castle:SetText(guildMemberWrapper:gateCount())
  guildScoreInfo.txt_Summon:SetText(guildMemberWrapper:summonedCount())
  guildScoreInfo.txt_Installation:SetText(guildMemberWrapper:obstacleCount())
  guildScoreInfo.txt_Member:SetText(guildMemberWrapper:guildMasterCount() + guildMemberWrapper:squadLeaderCount() + guildMemberWrapper:squadMemberCount())
  guildScoreInfo.txt_Death:SetText(guildMemberWrapper:deathCount())
  guildScoreInfo.txt_Kill:SetText(guildMemberWrapper:killBySiegeWeaponCount())
end
function PaGlobal_GuildWarScore_All:shopTitleTooltip(isShow, index)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = Panel_GuildWarScore_All:GetPosX()
  local panelPosY = Panel_GuildWarScore_All:GetPosY()
  self._ui.txt_IconHelper:SetPosX(mousePosX - panelPosX)
  self._ui.txt_IconHelper:SetPosY(mousePosY - panelPosY + 15)
  if isShow == true then
    self._ui.txt_IconHelper:SetShow(true)
    if index == 0 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_COMMAND"))
    elseif index == 1 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_TOWER"))
    elseif index == 2 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DOOR"))
    elseif index == 3 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_SUMMON"))
    elseif index == 4 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_OBJECT"))
    elseif index == 5 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_MEMBER"))
    elseif index == 6 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DEATH"))
    elseif index == 7 then
      self._ui.txt_IconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFARE_RIDEMACHINE_KILL"))
    end
    self._ui.txt_IconHelper:SetSize(self._ui.txt_IconHelper:GetTextSizeX() + 15, self._ui.txt_IconHelper:GetSizeY())
  else
    self._ui.txt_IconHelper:SetShow(false)
  end
end
function PaGlobal_GuildWarScore_All:validate()
  if nil == Panel_GuildWarScore_All then
    return
  end
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.list_GuildWarfare:isValidate()
  self._ui.list_Content:isValidate()
  self._ui.txt_IconHelper:isValidate()
  self._ui.stc_KeyGuide:isValidate()
  for index = 0, self._MAXTITLECOUNT - 1 do
    self._ui.titleGroup[index]:isValidate()
  end
end
