function PaGlobal_GuildWarInfoSmall_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_GuildWarInfoSmall_All, "StaticText_Title")
  self._ui.btn_Big = UI.getChildControl(self._ui.stc_TitleBg, "Button_Big")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Close")
  self._ui.btn_Reload = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Button_Refresh")
  self._ui.stc_BlackBG = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Static_Bg")
  self._ui.stc_NoWarBg = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Static_NoWarBG")
  self._ui.txt_NowarTitle = UI.getChildControl(self._ui.stc_NoWarBg, "StaticText_FinishTitle")
  self._ui.txt_NowarResult = UI.getChildControl(self._ui.stc_NoWarBg, "StaticText_FinishResult")
  self._ui.stc_NoOccupyBg = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Static_NoOccupyBG")
  self._ui.stc_NoOccupyIcon = UI.getChildControl(self._ui.stc_NoOccupyBg, "StaticText_NoOccupyInfo")
  self._ui.stc_NoOccupyIcon:SetColor(Defines.Color.C_FF888888)
  self._ui.stc_DefenceBg = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Static_DefenceBG")
  self._ui.list_OffenceGuild = UI.getChildControl(Panel_GuildWarInfoSmall_All, "List2_AttackGuildList")
  self._ui.list_OffenceGuild:changeAnimationSpeed(10)
  self._ui.list_OffenceGuild:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarInfoSmall_All_UpdateOffenceGuildList")
  self._ui.list_OffenceGuild:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_Scroll = UI.getChildControl(self._ui.list_OffenceGuild, "List2_1_VerticalScroll")
  self._ui.btn_Ctrl = UI.getChildControl(self._ui.list_Scroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui.list_Scroll:SetControlPos(0)
  self._ui.stc_ComboBox = UI.getChildControl(Panel_GuildWarInfoSmall_All, "Combobox_Region")
  self._ui.stc_ComboBox:setListTextHorizonLeft()
  self._ui.stc_ComboBox:SetSelectItemIndex(0)
  self._originPanelSizeY = Panel_GuildWarInfoSmall_All:GetSizeY()
  self:initGuildInfo()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildWarInfoSmall_All:registEventHandler()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self._ui.btn_Big:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfoSmall_All_OpenBigWindow()")
  self._ui.btn_Big:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfoSmall_All_ShowTooltip(true)")
  self._ui.btn_Big:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfoSmall_All_ShowTooltip(false)")
  self._ui.btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfoSmall_All_Reload()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarInfoSmall_All_Close()")
  self._ui.stc_ComboBox:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfoSmall_All_ShowComboBox()")
  self._ui.stc_ComboBox:GetListControl():addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfoSmall_All_SetComboBox()")
  registerEvent("Event_SiegeScoreUpdateData", "FromClient_GuildWarInfoSmall_All_UpdateScoreData")
  registerEvent("FromClient_NotifyStartSiege", "FromClient_GuildWarInfoSmall_All_NotifyStartSiege")
  Panel_GuildWarInfoSmall_All:RegisterUpdateFunc("PaGlobalFunc_GuildWarInfoSmall_All_UpdatePerFrame")
end
function PaGlobal_GuildWarInfoSmall_All:prepareOpen(selectedTerritoryKey)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self:initComboBox()
  self:update(selectedTerritoryKey)
  self:open()
end
function PaGlobal_GuildWarInfoSmall_All:open()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  Panel_GuildWarInfoSmall_All:SetShow(true)
end
function PaGlobal_GuildWarInfoSmall_All:prepareClose()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self:close()
end
function PaGlobal_GuildWarInfoSmall_All:close()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  Panel_GuildWarInfoSmall_All:SetShow(false)
end
function PaGlobal_GuildWarInfoSmall_All:initGuildInfo()
  local progressBg = UI.getChildControl(self._ui.stc_DefenceBg, "Static_ProgressBG")
  local guildIconBg = UI.getChildControl(self._ui.stc_DefenceBg, "Static_GuildIconBG")
  self._defenceGuildInfo = {
    stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
    txt_GuildName = UI.getChildControl(self._ui.stc_DefenceBg, "StaticText_GuildName"),
    txt_Percent = UI.getChildControl(self._ui.stc_DefenceBg, "StaticText_Percent"),
    progress_Defence = UI.getChildControl(progressBg, "Progress2_1")
  }
end
function PaGlobal_GuildWarInfoSmall_All:update(selectedTerritoryKey)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  if nil == selectedTerritoryKey then
    selectedTerritoryKey = self._ui.stc_ComboBox:GetSelectIndex()
  end
  self._ui.stc_ComboBox:SetSelectItemIndex(selectedTerritoryKey)
  self._selectedTerritoryKey = selectedTerritoryKey
  self._isSeigeBeing = isSiegeBeing(self._selectedTerritoryKey)
  self._ui.stc_NoWarBg:SetShow(false)
  self._ui.stc_NoOccupyBg:SetShow(false)
  self._ui.stc_DefenceBg:SetShow(false)
  self._ui.list_OffenceGuild:SetShow(false)
  if nil == self._selectedTerritoryKey then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapper(self._selectedTerritoryKey)
  if nil == siegeWrapper then
    return
  end
  if true == self._isSeigeBeing then
    if true == siegeWrapper:doOccupantExist() then
      self._ui.stc_DefenceBg:SetShow(true)
      self._ui.list_OffenceGuild:SetShow(true)
    else
      self._ui.stc_NoOccupyBg:SetShow(true)
      self._ui.list_OffenceGuild:SetShow(true)
      if false == isGameTypeKorea() then
        self._ui.stc_NoOccupyIcon:SetHorizonLeft()
        self._ui.stc_NoOccupyIcon:SetSpanSize(15, 10)
      end
    end
    self:updateGuild()
  else
    self._ui.txt_NowarTitle:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_NowarResult:SetTextMode(__eTextMode_AutoWrap)
    if true == siegeWrapper:doOccupantExist() then
      self._ui.txt_NowarTitle:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE_END", "selectTerritoy", siegeWrapper:getTerritoryName()))
      local guildWrapper = ToClient_GetGuildWrapperByGuildNo(siegeWrapper:getGuildNo())
      local allianceName = ""
      if nil ~= guildWrapper then
        allianceName = guildWrapper:getAllianceName()
      end
      if "" == allianceName then
        self._ui.txt_NowarResult:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      else
        self._ui.txt_NowarResult:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_ALLIANCE_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      end
    else
      self._ui.txt_NowarTitle:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE", "selectTerritoy", siegeWrapper:getTerritoryName()))
      self._ui.txt_NowarResult:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC"))
    end
    self._ui.list_Scroll:SetShow(false)
    self._ui.stc_NoWarBg:SetShow(true)
    local paddingY = 10
    self._ui.stc_BlackBG:SetSize(Panel_GuildWarInfoSmall_All:GetSizeX(), self._ui.stc_NoWarBg:GetPosY() + self._ui.stc_NoWarBg:GetSizeY() - self._ui.stc_TitleBg:GetSizeY() + paddingY)
    Panel_GuildWarInfoSmall_All:SetSize(Panel_GuildWarInfoSmall_All:GetSizeX(), self._ui.stc_NoWarBg:GetPosY() + self._ui.stc_NoWarBg:GetSizeY() + paddingY)
  end
end
function PaGlobal_GuildWarInfoSmall_All:updateGuild()
  local siegeWrapper = ToClient_GetSiegeWrapper(self._selectedTerritoryKey)
  if nil == siegeWrapper then
    return
  end
  local guildCount = ToClient_SiegeGuildCount(self._selectedTerritoryKey)
  if nil == guildCount then
    return
  end
  self._ui.list_OffenceGuild:getElementManager():clearKey()
  local offenceGuildCount = guildCount
  if true == siegeWrapper:doOccupantExist() then
    offenceGuildCount = offenceGuildCount - 1
  end
  local listMaxCount = 4
  local buttonSizeY = 55
  if 4 <= offenceGuildCount then
    offenceGuildCount = 4
  end
  self._ui.stc_BlackBG:SetSize(Panel_GuildWarInfoSmall_All:GetSizeX(), self._originPanelSizeY - (listMaxCount - offenceGuildCount) * buttonSizeY - self._ui.stc_TitleBg:GetSizeY() + 10)
  Panel_GuildWarInfoSmall_All:SetSize(Panel_GuildWarInfoSmall_All:GetSizeX(), self._originPanelSizeY - (listMaxCount - offenceGuildCount) * buttonSizeY + 10)
  for ii = 0, guildCount - 1 do
    local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, ii)
    local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, ii)
    if nil == guildWrapper or nil == siegeBuildingInfo then
      return
    end
    if guildWrapper:getGuildNo_s64() == siegeWrapper:getGuildNo() then
      self._defenceGuildNo = guildWrapper:getGuildNo_s64()
      local allianceName = guildWrapper:getAllianceName()
      if "" == allianceName then
        self._defenceGuildInfo.txt_GuildName:SetText(guildWrapper:getName())
      else
        self._defenceGuildInfo.txt_GuildName:SetText(allianceName)
      end
      local isSet = false
      if true == guildWrapper:isAllianceGuild() then
        isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), self._defenceGuildInfo.stc_GuildIcon)
      else
        isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), self._defenceGuildInfo.stc_GuildIcon)
      end
      if false == isSet then
        self._defenceGuildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self._defenceGuildInfo.stc_GuildIcon, 183, 1, 188, 6)
        self._defenceGuildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        self._defenceGuildInfo.stc_GuildIcon:setRenderTexture(self._defenceGuildInfo.stc_GuildIcon:getBaseTexture())
      else
        self._defenceGuildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
        self._defenceGuildInfo.stc_GuildIcon:setRenderTexture(self._defenceGuildInfo.stc_GuildIcon:getBaseTexture())
      end
      local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
      local roundingoffPercent = math.floor(hpPercent / 100 * 100)
      self._defenceGuildInfo.txt_Percent:SetText(tostring(roundingoffPercent) .. "%")
      self._defenceGuildInfo.progress_Defence:SetProgressRate(roundingoffPercent)
    else
      self._ui.list_OffenceGuild:getElementManager():pushKey(toInt64(0, ii))
    end
  end
end
function PaGlobal_GuildWarInfoSmall_All:updateOffenceGuildList(content, index)
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  local offenceBg = UI.getChildControl(content, "Static_OffenceBG")
  local progressBg = UI.getChildControl(offenceBg, "Static_ProgressBG")
  local guildIconBg = UI.getChildControl(offenceBg, "Static_GuildIconBG")
  local offenceGuildInfo = {
    stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
    txt_GuildName = UI.getChildControl(offenceBg, "StaticText_GuildName"),
    txt_Percent = UI.getChildControl(offenceBg, "StaticText_Percent"),
    progress_Offence = UI.getChildControl(progressBg, "Progress2_1")
  }
  local index_32 = Int64toInt32(index)
  local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, index_32)
  local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, index_32)
  if nil == guildWrapper or nil == siegeBuildingInfo then
    return
  end
  local allianceName = guildWrapper:getAllianceName()
  if "" == allianceName then
    offenceGuildInfo.txt_GuildName:SetText(guildWrapper:getName())
  else
    offenceGuildInfo.txt_GuildName:SetText(allianceName)
  end
  local isSet = false
  if true == guildWrapper:isAllianceGuild() then
    isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), offenceGuildInfo.stc_GuildIcon)
  else
    isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), offenceGuildInfo.stc_GuildIcon)
  end
  if false == isSet then
    offenceGuildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(offenceGuildInfo.stc_GuildIcon, 183, 1, 188, 6)
    offenceGuildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    offenceGuildInfo.stc_GuildIcon:setRenderTexture(offenceGuildInfo.stc_GuildIcon:getBaseTexture())
  else
    offenceGuildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    offenceGuildInfo.stc_GuildIcon:setRenderTexture(offenceGuildInfo.stc_GuildIcon:getBaseTexture())
  end
  local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
  local roundingoffPercent = math.floor(hpPercent / 100 * 100)
  offenceGuildInfo.txt_Percent:SetText(tostring(roundingoffPercent) .. "%")
  offenceGuildInfo.progress_Offence:SetProgressRate(roundingoffPercent)
  content:SetShow(true)
end
function PaGlobal_GuildWarInfoSmall_All:initComboBox()
  self._ui.stc_ComboBox:DeleteAllItem(0)
  for index = 0, self._MAXTERRIROTYCOUNT - 1 do
    local siegeWrapper = ToClient_GetSiegeWrapper(index)
    self._ui.stc_ComboBox:AddItem(siegeWrapper:getTerritoryName())
  end
  self._ui.stc_ComboBox:setListTextHorizonCenter()
  self._ui.list_Scroll:SetControlPos(0)
end
function PaGlobal_GuildWarInfoSmall_All:setComboBox()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self._ui.stc_ComboBox:SetSelectItemIndex(self._ui.stc_ComboBox:GetSelectIndex())
  self._ui.stc_ComboBox:ToggleListbox()
  self:update(self._ui.stc_ComboBox:GetSelectIndex())
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(0, 0)
end
function PaGlobal_GuildWarInfoSmall_All:showComboBox()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self._ui.stc_ComboBox:ToggleListbox()
end
function PaGlobal_GuildWarInfoSmall_All:validate()
  if nil == Panel_GuildWarInfoSmall_All then
    return
  end
  self._ui.stc_TitleBg:isValidate()
  self._ui.btn_Big:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Reload:isValidate()
  self._ui.stc_BlackBG:isValidate()
  self._ui.stc_NoWarBg:isValidate()
  self._ui.txt_NowarTitle:isValidate()
  self._ui.txt_NowarResult:isValidate()
  self._ui.stc_NoOccupyBg:isValidate()
  self._ui.stc_NoOccupyIcon:isValidate()
  self._ui.stc_DefenceBg:isValidate()
  self._ui.list_OffenceGuild:isValidate()
  self._ui.list_Scroll:isValidate()
  self._ui.btn_Ctrl:isValidate()
  self._ui.stc_ComboBox:isValidate()
end
