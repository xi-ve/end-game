function PaGlobal_ChannelSelect_All:initialize()
  if true == PaGlobal_ChannelSelect_All._initialize or nil == Panel_ChannelSelect_All then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Close")
  self._ui.btn_Qusetion = UI.getChildControl(self._ui.stc_Title, "Button_Question")
  self._ui.stc_decoBg = UI.getChildControl(self._ui.stc_Title, "Static_DECOBG")
  self._ui.stc_descBg = UI.getChildControl(Panel_ChannelSelect_All, "Static_DescBg")
  self._ui.stc_subFrame = UI.getChildControl(Panel_ChannelSelect_All, "Static_SubFrame")
  self._ui.stc_AllBG = UI.getChildControl(Panel_ChannelSelect_All, "Static_AllBG")
  self._ui.stc_blockBG = UI.getChildControl(Panel_ChannelSelect_All, "Static_BlockBG")
  self._ui.stc_Icon_War = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_WarIcon")
  self._ui.stc_Icon_NoEnterance = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_NoEnterance")
  self._ui.stc_Icon_Maintenance = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_Maintenance")
  self._ui.stc_Icon_PrepareToStop = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_PrepareToStop")
  self._ui.stc_Icon_ExpEvent = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_ExpEvent")
  self._ui.stc_Icon_Premium = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_Preminum")
  self._ui.stc_Icon_PK = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_PK")
  self._ui.stc_Icon_CrossPlay = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_NoAccessForCrossplay")
  self._ui.stc_Icon_FriendsInvite = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_FriendInvite")
  self._ui.txt_Icon_Time = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_TimeIcon")
  self._ui.stc_Icon_SeasonChannel = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_SeasonChannel")
  self._ui.txt_Status = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_Desc")
  self._ui.chk_ShowDesc = UI.getChildControl(Panel_ChannelSelect_All, "CheckButton_Desc")
  self._ui.stc_ShowDesc_PadUI = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_ShowDesc_padSnapUI")
  self._ui.stc_ShowDescText_PadUI = UI.getChildControl(self._ui.stc_ShowDesc_PadUI, "StaticText_ShowDescTxt_padSnapUI")
  self._ui.rdo_Templeate = UI.getChildControl(Panel_ChannelSelect_All, "RadioButton_Channel_BG")
  self._ui.stc_DescPanel = UI.getChildControl(Panel_ChannelSelect_All, "Static_ChannelSelectDescBG")
  self._ui.txt_ChannelSelectTitle = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_ChannelSelectTitle")
  self._ui.txt_ChannelSelectDesc = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_ChannelSelectDesc")
  self._ui.txt_SeasonTitle = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Season")
  self._ui.txt_SeasonDesc = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Season_Desc")
  self._ui.txt_SpeedTitle = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_SpeedTitle")
  self._ui.txt_SpeedDesc = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_SpeedDesc")
  self._ui.txt_PkTitle = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_PKTitle")
  self._ui.txt_PkDesc = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_PKDesc")
  self._ui.txt_SiegeTitle = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Channel")
  self._ui.txt_SiegeBalenos = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Siege_Balenos")
  self._ui.txt_SiegeSerendia = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Siege_Serendia")
  self._ui.txt_SiegeCalpheon = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Siege_Calpheon")
  self._ui.txt_SiegeMedia = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Siege_Media")
  self._ui.txt_SiegeValencia = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Siege_Valencia")
  self._ui.txt_Schedule = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Schedule")
  self._ui.txt_Schedule_Siege = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Schedule_Siege")
  self._ui.txt_Schedule_NodeWar = UI.getChildControl(self._ui.stc_DescPanel, "StaticText_Schedule_Nodewar")
  self._ui.stc_KeyguideBg = UI.getChildControl(Panel_ChannelSelect_All, "Static_KeyGuideBg_Console")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyguideBg, "StaticText_KeyGuide_A")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyguideBg, "StaticText_KeyGuide_B")
  self._ui.txt_Icon_SeasonCoolTime = UI.getChildControl(Panel_ChannelSelect_All, "StaticText_SeasonCoolTime")
  if self._useFrameDesc then
    self._ui.frame_Desc = UI.getChildControl(Panel_ChannelSelect_All, "Frame_Description")
    self._ui.frameContent = self._ui.frame_Desc:GetFrameContent()
    self._ui.frameScroll = self._ui.frame_Desc:GetVScroll()
  else
    UI.getChildControl(Panel_ChannelSelect_All, "Frame_Description"):SetShow(false)
  end
  self._ui.stc_Icon_War:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECTE_WARICON"))
  self._ui.stc_Icon_NoEnterance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECTE_NOENTERANCEICON"))
  self._ui.stc_Icon_Maintenance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECTE_MAINTENANCEICON"))
  self._ui.stc_Icon_PrepareToStop:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECT_BOTTOM_MAINTANANCE"))
  self._ui.stc_Icon_ExpEvent:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHANNELSELECTE_EXPEVENTICON"))
  self._ui.stc_Icon_Premium:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PCROOMSERVER"))
  self._ui.stc_Icon_PK:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PK"))
  self._ui.stc_Icon_SeasonChannel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_SEASONSERVER"))
  self._ui.stc_Icon_SeasonChannel:SetShow(false)
  self._ui.txt_ChannelSelectTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SpeedTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_PkTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SiegeTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Schedule:SetTextMode(__eTextMode_AutoWrap)
  self._ui.chk_ShowDesc:SetEnableArea(0, 0, self._ui.chk_ShowDesc:GetSizeX() + self._ui.chk_ShowDesc:GetTextSizeX() + 10, self._ui.chk_ShowDesc:GetSizeY())
  self._ui.chk_ShowDesc:SetCheck(true)
  self._ui.txt_SeasonTitle:SetShow(false)
  self._ui.txt_SeasonDesc:SetShow(false)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    if 0 == userType then
      if self._useFrameDesc then
        self._ui.frame_Desc:SetShow(false)
      else
        self._ui.stc_DescPanel:SetShow(false)
      end
      self._ui.chk_ShowDesc:SetCheck(false)
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.chk_ShowDesc, 117, 434, 89, 462)
      self._ui.chk_ShowDesc:getBaseTexture():setUV(x1, y1, x2, y2)
      local onX1, onY1, onX2, onY2 = setTextureUV_Func(self._ui.chk_ShowDesc, 146, 434, 118, 462)
      self._ui.chk_ShowDesc:getOnTexture():setUV(onX1, onY1, onX2, onY2)
      local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(self._ui.chk_ShowDesc, 175, 434, 147, 462)
      self._ui.chk_ShowDesc:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
      self._ui.chk_ShowDesc:setRenderTexture(self._ui.chk_ShowDesc:getBaseTexture())
    end
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:validate()
  self:registEventHandler()
  self:swichPlatform()
  self:createChannelUI()
  self:initServerDesc()
  self:alignBottomIcon()
  self._initialize = true
end
function PaGlobal_ChannelSelect_All:registEventHandler()
  if nil == Panel_ChannelSelect_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelSelect_All_Close()")
  self._ui.chk_ShowDesc:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelSelect_All_ToggleDesc()")
  self._ui.txt_Icon_Time:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelSelect_All_CoolTimeIconToolTip(true,true)")
  self._ui.txt_Icon_Time:addInputEvent("Mouse_Out", "HandleEventOnOut_ChannelSelect_All_CoolTimeIconToolTip(false,true)")
  self._ui.txt_Icon_SeasonCoolTime:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelSelect_All_CoolTimeIconToolTip(true,false)")
  self._ui.txt_Icon_SeasonCoolTime:addInputEvent("Mouse_Out", "HandleEventOnOut_ChannelSelect_All_CoolTimeIconToolTip(false,false)")
  registerEvent("onScreenResize", "PaGlobalFunc_ChannelSelect_All_OnScreenResize")
  Panel_ChannelSelect_All:RegisterShowEventFunc(true, "PaGlobalFunc_ChannelSelect_All_ShowAni()")
  Panel_ChannelSelect_All:RegisterShowEventFunc(false, "PaGlobalFunc_ChannelSelect_All_HideAni()")
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    Panel_ChannelSelect_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_ChannelSelect_All_ToggleDesc()")
  end
  if true == self._isConsole then
    Panel_ChannelSelect_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  if true == _ContentsGroup_RenewUI then
    registerEvent("FromClient_ShowXboxInviteMessage", "FromClient_ChannelSelect_All_ShowXboxInviteMessage")
  end
end
function PaGlobal_ChannelSelect_All:swichPlatform()
  self._ui.stc_KeyguideBg:SetShow(self._isConsole)
  self._ui.stc_Icon_FriendsInvite:SetShow(_ContentsGroup_RenewUI)
  self._ui.stc_Icon_FriendsInvite:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_INVITEFRIENDSSERVER"))
  if false == _ContentsGroup_RenewUI then
    local descSize = 70
    local panelSize = 70
    self._ui.stc_DescPanel:SetSize(self._ui.stc_DescPanel:GetSizeX() + panelSize, self._ui.stc_DescPanel:GetSizeY())
    self._ui.stc_DescPanel:SetSpanSize(self._ui.stc_DescPanel:GetSpanSize().x - 70, self._ui.stc_DescPanel:GetSpanSize().y - 30)
    self._ui.txt_ChannelSelectTitle:SetSize(self._ui.txt_ChannelSelectTitle:GetSizeX() + descSize, self._ui.txt_ChannelSelectTitle:GetSizeY())
    self._ui.txt_ChannelSelectDesc:SetSize(self._ui.txt_ChannelSelectDesc:GetSizeX() + descSize, self._ui.txt_ChannelSelectDesc:GetSizeY())
    self._ui.txt_SpeedTitle:SetSize(self._ui.txt_SpeedTitle:GetSizeX() + descSize, self._ui.txt_SpeedTitle:GetSizeY())
    self._ui.txt_SpeedDesc:SetSize(self._ui.txt_SpeedDesc:GetSizeX() + descSize, self._ui.txt_SpeedDesc:GetSizeY())
    self._ui.txt_PkTitle:SetSize(self._ui.txt_PkTitle:GetSizeX() + descSize, self._ui.txt_PkTitle:GetSizeY())
    self._ui.txt_PkDesc:SetSize(self._ui.txt_PkDesc:GetSizeX() + descSize, self._ui.txt_PkDesc:GetSizeY())
    self._ui.txt_SiegeTitle:SetSize(self._ui.txt_SiegeTitle:GetSizeX() + descSize, self._ui.txt_SiegeTitle:GetSizeY())
    self._ui.txt_SiegeBalenos:SetSize(self._ui.txt_SiegeBalenos:GetSizeX() + descSize, self._ui.txt_SiegeBalenos:GetSizeY())
    self._ui.txt_SiegeSerendia:SetSize(self._ui.txt_SiegeSerendia:GetSizeX() + descSize, self._ui.txt_SiegeSerendia:GetSizeY())
    self._ui.txt_SiegeCalpheon:SetSize(self._ui.txt_SiegeCalpheon:GetSizeX() + descSize, self._ui.txt_SiegeCalpheon:GetSizeY())
    self._ui.txt_SiegeMedia:SetSize(self._ui.txt_SiegeMedia:GetSizeX() + descSize, self._ui.txt_SiegeMedia:GetSizeY())
    self._ui.txt_SiegeValencia:SetSize(self._ui.txt_SiegeValencia:GetSizeX() + descSize, self._ui.txt_SiegeValencia:GetSizeY())
    self._ui.txt_Schedule:SetSize(self._ui.txt_Schedule:GetSizeX() + descSize, self._ui.txt_Schedule:GetSizeY())
    self._ui.txt_Schedule_Siege:SetSize(self._ui.txt_Schedule_Siege:GetSizeX() + descSize, self._ui.txt_Schedule_Siege:GetSizeY())
    self._ui.txt_Schedule_NodeWar:SetSize(self._ui.txt_Schedule_NodeWar:GetSizeX() + descSize, self._ui.txt_Schedule_NodeWar:GetSizeY())
    self._ui.txt_SeasonDesc:SetSize(self._ui.txt_SeasonDesc:GetSizeX() + descSize, self._ui.txt_SeasonDesc:GetSizeY())
    if true == _ContentsGroup_UsePadSnapping then
      self._ui.chk_ShowDesc:SetShow(false)
      self._ui.stc_ShowDesc_PadUI:SetShow(true)
      self._ui.btn_Close:SetShow(false)
    end
  else
    self._ui.btn_Close:SetShow(false)
    self._ui.chk_ShowDesc:SetShow(false)
    self._ui.stc_DescPanel:SetShow(false)
    if self._useFrameDesc then
      self._ui.frame_Desc:SetShow(false)
    end
    Panel_ChannelSelect_All:SetSpanSize(0, 0)
    Panel_ChannelSelect_All:ComputePos()
    self._ui.stc_DescPanel:ComputePos()
    self._ui.stc_blockBG:ChangeTextureInfoName("renewal/etc/console_etc_fullscreenbg.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_blockBG, 0, 0, 1920, 1080)
    self._ui.stc_blockBG:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_blockBG:setRenderTexture(self._ui.stc_blockBG:getBaseTexture())
    self._ui.stc_Icon_Maintenance:ChangeTextureInfoName("renewal/ui_icon/console_icon_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Icon_Maintenance, 134, 227, 162, 255)
    self._ui.stc_Icon_Maintenance:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Icon_Maintenance:setRenderTexture(self._ui.stc_Icon_Maintenance:getBaseTexture())
    self._ui.stc_Icon_Maintenance:SetSize(24, 24)
    local stc_slotIcon_Maintenance = UI.getChildControl(self._ui.rdo_Templeate, "Static_Maintenance")
    stc_slotIcon_Maintenance:ChangeTextureInfoName("renewal/ui_icon/console_icon_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_slotIcon_Maintenance, 134, 227, 162, 255)
    stc_slotIcon_Maintenance:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_slotIcon_Maintenance:setRenderTexture(stc_slotIcon_Maintenance:getBaseTexture())
    stc_slotIcon_Maintenance:SetSize(24, 24)
  end
end
function PaGlobal_ChannelSelect_All:createChannelUI()
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    UI.ASSERT(false, " \237\152\132\236\158\172 \236\177\132\235\132\144 \235\141\176\236\157\180\237\132\176\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. ")
    return
  end
  self._self._channelGroupCount = {}
  if isGameTypeKorea() then
    self._channelGroupCount = {
      [0] = 5,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      1
    }
  elseif isGameTypeJapan() then
    self._channelGroupCount = {
      [0] = 4,
      4,
      4,
      4,
      4,
      4,
      2
    }
  elseif isGameTypeRussia() then
    self._channelGroupCount = {
      [0] = 3,
      4,
      4,
      4,
      4,
      4
    }
  elseif isGameTypeEnglish() then
    self._channelGroupCount = {
      [0] = 2,
      6,
      6,
      6,
      6,
      6,
      6
    }
  elseif isGameTypeTaiwan() then
    self._channelGroupCount = {
      [0] = 3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3
    }
  else
    self._channelGroupCount = {
      [0] = 5,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3
    }
  end
  self._self._isChannelCountLow = false
  local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local totalChannelCount = getGameChannelServerDataCount(curChannelData._worldNo)
  local instanceChannelCount = ToClient_InstanceChannelCount(curChannelData._worldNo)
  if totalChannelCount >= instanceChannelCount and false == ToClient_SelfPlayerIsGM() then
    totalChannelCount = totalChannelCount - instanceChannelCount
  end
  if totalChannelCount < 20 then
    self._isChannelCountLow = true
  end
  local halfChannelCount = math.ceil(totalChannelCount * 0.5)
  local channelGroupIdx = 0
  while not (halfChannelCount <= self._channeUIMaxCount) do
    self._channeUIMaxCount = self._channeUIMaxCount + self._channelGroupCount[channelGroupIdx]
    channelGroupIdx = channelGroupIdx + 1
  end
  self._bgCount = math.floor(totalChannelCount - 1) / self._channeUIMaxCount
  if true == self._isChannelCountLow then
    self._bgCount = 0
    self._channeUIMaxCount = 20
  end
  if true == _ContentsGroup_RenewUI then
    self._channeUIMaxCount = totalChannelCount
  end
  local padding = 15
  for idx = 0, self._bgCount do
    if nil == self._groupBg[idx] then
      local slotBg = UI.cloneControl(self._ui.stc_AllBG, Panel_ChannelSelect_All, "Cloned_Static_ChannelGroupBg" .. idx)
      slotBg:SetPosX(padding + (self._ui.stc_AllBG:GetSizeX() + 5) * idx)
      slotBg:SetShow(true)
      slotBg:SetSize(self._ui.stc_AllBG:GetSizeX(), self._channeUIMaxCount * (self._ui.rdo_Templeate:GetSizeY() + 6))
      self._groupBg[idx] = slotBg
    end
  end
  self._ui.stc_AllBG:SetShow(false)
  for idx = 0, totalChannelCount - 1 do
    local cloned_ChannelSlot = {}
    local rdo_Channel
    if true == self._isChannelCountLow then
      rdo_Channel = UI.cloneControl(self._ui.rdo_Templeate, self._groupBg[0], "Cloned_Channel_RadioButton" .. idx)
    else
      local parentBgIdx = math.floor(idx / self._channeUIMaxCount)
      rdo_Channel = UI.cloneControl(self._ui.rdo_Templeate, self._groupBg[parentBgIdx], "Cloned_Channel_RadioButton" .. idx)
    end
    if nil == rdo_Channel then
      UI.ASSERT(false, "failed to Clone Control")
      return
    end
    cloned_ChannelSlot._bg = rdo_Channel
    cloned_ChannelSlot._txt_Title = UI.getChildControl(rdo_Channel, "StaticText_ChannelName")
    cloned_ChannelSlot._txt_Status = UI.getChildControl(rdo_Channel, "StaticText_Status")
    cloned_ChannelSlot._IconTable = Array.new()
    cloned_ChannelSlot._stc_WarIcon = UI.getChildControl(rdo_Channel, "Static_WarIcon")
    cloned_ChannelSlot._stc_NoEnterance = UI.getChildControl(rdo_Channel, "Static_NoEnterance")
    cloned_ChannelSlot._stc_Maintenance = UI.getChildControl(rdo_Channel, "Static_Maintenance")
    cloned_ChannelSlot._stc_PrepareToStop = UI.getChildControl(rdo_Channel, "Static_PrepareToStop")
    cloned_ChannelSlot._stc_ExpEvent = UI.getChildControl(rdo_Channel, "Static_ExpEvent")
    cloned_ChannelSlot._stc_Premium = UI.getChildControl(rdo_Channel, "Static_Premium")
    cloned_ChannelSlot._stc_PK = UI.getChildControl(rdo_Channel, "Static_PK")
    cloned_ChannelSlot._stc_FriendInvite = UI.getChildControl(rdo_Channel, "Static_FriendInvite")
    cloned_ChannelSlot._stc_CrossPlay = UI.getChildControl(rdo_Channel, "Static_CrossPlay")
    cloned_ChannelSlot._stc_CurrentChannelBg = UI.getChildControl(rdo_Channel, "Static_CurrentChannel_BG")
    cloned_ChannelSlot._stc_SeasonChannel = UI.getChildControl(rdo_Channel, "Static_SeasonIcon")
    cloned_ChannelSlot._stc_SeasonCoolTime = UI.getChildControl(rdo_Channel, "Static_SeasonCool")
    cloned_ChannelSlot._stc_NormalCoolTime = UI.getChildControl(rdo_Channel, "Static_NormalCool")
    if true == self._isChannelCountLow then
      cloned_ChannelSlot._bg:SetPosY(6 + (cloned_ChannelSlot._bg:GetSizeY() + 5) * idx)
    else
      cloned_ChannelSlot._bg:SetPosY(5 + (cloned_ChannelSlot._bg:GetSizeY() + 5) * (idx % self._channeUIMaxCount))
    end
    local function localFunc_PushTableWithSetShow(control)
      if nil == control then
        UI.ASSERT(false, " control is nil")
        return
      end
      control:SetShow(false)
      cloned_ChannelSlot._IconTable:push_back(control)
    end
    cloned_ChannelSlot._bg:SetShow(false)
    cloned_ChannelSlot._stc_FriendInvite:SetShow(false)
    cloned_ChannelSlot._stc_CurrentChannelBg:SetShow(false)
    cloned_ChannelSlot._stc_CrossPlay:SetShow(false)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_WarIcon)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_NoEnterance)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_SeasonCoolTime)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_NormalCoolTime)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_Maintenance)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_ExpEvent)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_Premium)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_PrepareToStop)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_CrossPlay)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_SeasonChannel)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_PK)
    localFunc_PushTableWithSetShow(cloned_ChannelSlot._stc_FriendInvite)
    cloned_ChannelSlot._stc_SeasonChannel:SetShow(false)
    self._channelSelectUIPool[idx] = cloned_ChannelSlot
  end
  self._ui.rdo_Templeate:SetShow(false)
end
function PaGlobal_ChannelSelect_All:pushTableAndAutowrap(table, control)
  if nil == control or nil == table then
    UI.ASSERT(false, "control or table is nil")
    return
  end
  if true == control:GetShow() then
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetText(control:GetText())
    table:push_back(control)
  end
end
function PaGlobal_ChannelSelect_All:alignDesc()
  local descTable = Array.new()
  if true == _ContentsGroup_SeasonContents then
    descTable:push_back(self._ui.txt_SeasonTitle)
    descTable:push_back(self._ui.txt_SeasonDesc)
    self._ui.txt_SeasonTitle:SetShow(true)
    self._ui.txt_SeasonDesc:SetShow(true)
  else
    self._ui.txt_SeasonTitle:SetShow(false)
    self._ui.txt_SeasonDesc:SetShow(false)
  end
  descTable:push_back(self._ui.txt_SpeedTitle)
  descTable:push_back(self._ui.txt_SpeedDesc)
  descTable:push_back(self._ui.txt_PkTitle)
  descTable:push_back(self._ui.txt_PkDesc)
  descTable:push_back(self._ui.txt_SiegeTitle)
  descTable:push_back(self._ui.txt_SiegeBalenos)
  descTable:push_back(self._ui.txt_Schedule)
  descTable:push_back(self._ui.txt_Schedule_Siege)
  descTable:push_back(self._ui.txt_Schedule_NodeWar)
  self._ui.txt_ChannelSelectTitle:SetPosY(20)
  self._ui.txt_ChannelSelectDesc:SetPosY(self._ui.txt_ChannelSelectTitle:GetTextSizeY() + 20)
  self._ui.txt_ChannelSelectDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_ChannelSelectDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC"))
  self._ui.txt_PkTitle:SetShow(false)
  self._ui.txt_PkDesc:SetShow(false)
  self._ui.txt_SiegeCalpheon:SetShow(false)
  self._ui.txt_SiegeMedia:SetShow(false)
  self._ui.txt_SiegeValencia:SetShow(false)
  local isAdlut = ToClient_isAdultUser()
  local isTawan = isGameTypeTaiwan()
  local isKorea = isGameTypeKorea()
  local isKorea2 = isGameTypeKR2()
  local isTest = isGameTypeGT()
  if true == isKorea and false == isAdlut then
    for idx = 1, #descTable do
      descTable[idx]:SetShow(false)
    end
    self._ui.txt_ChannelSelectDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC_15"))
    self._ui.stc_DescPanel:SetSize(self._ui.stc_DescPanel:GetSizeX(), self._ui.txt_ChannelSelectDesc:GetPosY() + self._ui.txt_ChannelSelectDesc:GetTextSizeY() + 15)
    return
  end
  if isGameTypeTH() or isGameTypeID() then
    self._ui.txt_PkTitle:SetShow(true)
    self._ui.txt_PkDesc:SetShow(true)
    self._ui.txt_SpeedTitle:SetShow(true)
    self._ui.txt_SpeedDesc:SetShow(true)
  elseif true == isKorea2 or true == isTest then
    for idx = 1, #descTable do
      descTable[idx]:SetShow(false)
    end
  elseif isGameTypeRussia() or isGameTypeEnglish() or isGameTypeJapan() or isGameTypeTR() or isGameTypeSA() or true == isTawan or true == isKorea then
    self._ui.txt_PkTitle:SetShow(true)
    self._ui.txt_PkDesc:SetShow(true)
  end
  self._ui.txt_SpeedTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_TITLE"))
  self._ui.txt_SpeedDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SpeedDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_DESC"))
  self._ui.txt_PkTitle:SetPosY(self._ui.txt_SpeedDesc:GetPosY() + self._ui.txt_SpeedDesc:GetTextSizeY() + 20)
  self._ui.txt_PkTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PK"))
  self._ui.txt_PkDesc:SetTextMode(__eTextMode_AutoWrap)
  if true == isKorea then
    self._ui.txt_PkDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC_ARSHASERVER"))
  else
    self._ui.txt_PkDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC"))
  end
  for idx = 1, #descTable do
    if true == descTable[idx]:GetShow() and "" ~= descTable[idx]:GetText() then
      if descTable[idx]:GetTextSizeX() > descTable[idx]:GetSizeX() then
        descTable[idx]:SetTextMode(__eTextMode_AutoWrap)
        descTable[idx]:SetText(descTable[idx]:GetText())
      end
      if 1 == idx then
        descTable[idx]:SetPosY(self._ui.txt_ChannelSelectDesc:GetTextSizeY() + self._ui.txt_ChannelSelectDesc:GetPosY() + 10)
      elseif nil ~= descTable[idx - 1] then
        local adjust = 0
        if 0 < descTable[idx]:getChildControlCount() then
          if descTable[idx]:IsAutoWrapText() then
            adjust = 13
          else
            adjust = 10
          end
        elseif 0 < descTable[idx - 1]:getChildControlCount() then
          adjust = 3
        end
        descTable[idx]:SetPosY(descTable[idx - 1]:GetPosY() + descTable[idx - 1]:GetTextSizeY() + adjust)
      else
        UI.ASSERT(false, "descTable[idx - 1] is nil ")
      end
    end
  end
  self._ui.stc_DescPanel:SetSize(self._ui.stc_DescPanel:GetSizeX(), descTable[#descTable]:GetPosY() + descTable[#descTable]:GetTextSizeY() + 15)
  self._ui.stc_DescPanel:SetPosY(0)
  local getScreenSizeY = getScreenSizeY()
  if getScreenSizeY < self._ui.stc_DescPanel:GetPosY() + self._ui.stc_DescPanel:GetSizeY() + Panel_ChannelSelect_All:GetPosY() then
    local gap = getScreenSizeY - (self._ui.stc_DescPanel:GetPosY() + self._ui.stc_DescPanel:GetSizeY() + Panel_ChannelSelect_All:GetPosY() + 30)
    self._ui.stc_DescPanel:SetPosY(gap)
  end
end
function PaGlobal_ChannelSelect_All:createServerDesc()
  self._descButtonCount = 0
  self._serverDescControls = {}
  local rdo_Desc = UI.getChildControl(self._ui.frameContent, "Radiobutton_DescTitle_Templete")
  local stc_DescBG = UI.getChildControl(self._ui.frameContent, "Static_DescBg_Templete")
  local txt_Desc = UI.getChildControl(stc_DescBG, "StaticText_Description")
  stc_DescBG:SetShow(false)
  stc_DescBG:SetSize(stc_DescBG:GetSizeX(), 10)
  txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._descButtonSizeY = rdo_Desc:GetSizeY()
  self._descBGSizeX = stc_DescBG:GetSizeX()
  self._descSpanSize = txt_Desc:GetSpanSize().y * 2
  local function CloneAndGetControls(desc)
    local descControls = {}
    local pattern = "\\n"
    local descTable = string.split(desc, pattern)
    descControls.descCount = #descTable
    descControls.rdo = UI.cloneControl(rdo_Desc, self._ui.frameContent, "Cloned_Radiobutton_DescTitle_" .. tostring(self._descButtonCount))
    descControls.bg = UI.cloneControl(stc_DescBG, self._ui.frameContent, "Cloned_Radiobutton_DescBg_" .. tostring(self._descButtonCount))
    local textDesc = UI.getChildControl(descControls.bg, "StaticText_Description")
    descControls.text = {}
    for i = 1, descControls.descCount do
      descControls.text[i] = UI.cloneControl(textDesc, descControls.bg, "Cloned_StaticText_Description_" .. tostring(i))
      descControls.text[i]:SetText(descTable[i])
      if nil ~= descControls.text[i - 1] then
        descControls.text[i]:SetPosY(descControls.text[i - 1]:GetPosY() + descControls.text[i - 1]:GetTextSizeY())
      end
    end
    self._descButtonCount = self._descButtonCount + 1
    self._serverDescControls[self._descButtonCount] = descControls
    return descControls
  end
  local isAdlut = ToClient_isAdultUser()
  local isTawan = isGameTypeTaiwan()
  local isKorea = isGameTypeKorea()
  local isKorea2 = isGameTypeKR2()
  local isTest = isGameTypeGT()
  local isKoreaTeenager = false == isAdlut and isKorea
  local descData = {
    [1] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTTITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_CHANNELSELECTDESC"),
      contentsOption = true
    },
    [2] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_TITLE_A"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SEASON_DESC"),
      contentsOption = _ContentsGroup_SeasonContents and false == isKoreaTeenager
    },
    [3] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_TITLE"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVERSELECT_SPEEDCHANNEL_DESC"),
      contentsOption = false == isKoreaTeenager
    },
    [4] = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_SEVERSELECT_PK"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC"),
      contentsOption = false
    },
    [5] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_TERRITORY_SUB_TITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DESC"),
      contentsOption = false == isKoreaTeenager
    },
    [6] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_TITLE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_DESC_TERRITORYWAR") .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_WARCHANNEL_DATE_SUB_DESC_NODEWAR"),
      contentsOption = false == isKoreaTeenager
    }
  }
  if isGameTypeTH() or isGameTypeID() then
    descData[3].contentsOption = descData[3].contentsOption
    descData[4].contentsOption = true
  elseif true == isKorea2 or true == isTest then
    for idx = 1, #descData do
      descData[idx].contentsOption = false
    end
    descData[1].contentsOption = true
  elseif isGameTypeRussia() or isGameTypeEnglish() or isGameTypeJapan() or isGameTypeTR() or isGameTypeSA() or true == isTawan or true == isKorea then
    descData[4].contentsOption = false == isKoreaTeenager
  end
  if true == isKorea then
    descData[4].desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_PVPDESC_ARSHASERVER")
  end
  local posY = 0
  for idx = 1, #descData do
    if descData[idx].contentsOption then
      local UIControls = CloneAndGetControls(descData[idx].desc)
      if nil ~= UIControls then
        UIControls.rdo:SetCheck(1 == idx)
        UIControls.rdo:SetText(descData[idx].title)
        UIControls.rdo:SetShow(true)
        UIControls.rdo:SetPosY(posY)
        posY = posY + UIControls.rdo:GetSizeY()
        UIControls.bg:SetPosY(posY)
      end
    end
  end
  if 0 == self._descButtonCount then
    self._ui.chk_ShowDesc:SetShow(false)
  else
    self._ui.frameContent:SetSize(self._ui.frameContent:GetSizeX(), posY + 10)
    self._ui.frame_Desc:UpdateContentPos()
    self._ui.frame_Desc:UpdateContentScroll()
  end
end
function PaGlobal_ChannelSelect_All:initServerDesc()
  if self._useFrameDesc then
    self:createServerDesc()
  else
    self:alignDesc()
  end
end
function PaGlobal_ChannelSelect_All:alignBottomIcon()
  local bottomIconList = Array.new()
  bottomIconList:push_back(self._ui.stc_Icon_War)
  bottomIconList:push_back(self._ui.stc_Icon_NoEnterance)
  bottomIconList:push_back(self._ui.stc_Icon_Maintenance)
  bottomIconList:push_back(self._ui.stc_Icon_PrepareToStop)
  bottomIconList:push_back(self._ui.stc_Icon_ExpEvent)
  bottomIconList:push_back(self._ui.stc_Icon_Premium)
  bottomIconList:push_back(self._ui.stc_Icon_PK)
  if true == _ContentsGroup_RenewUI then
    local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if true == ToClient_isTotalGameClient() and true == isCrossplayMode then
      bottomIconList:push_back(self._ui.stc_Icon_CrossPlay)
    end
    bottomIconList:push_back(self._ui.stc_Icon_FriendsInvite)
  else
    self._ui.stc_Icon_CrossPlay:SetShow(false)
  end
  if true == _ContentsGroup_SeasonContents then
    bottomIconList:push_back(self._ui.stc_Icon_SeasonChannel)
    self._ui.stc_Icon_SeasonChannel:SetShow(true)
  else
    self._ui.stc_Icon_SeasonChannel:SetShow(false)
  end
  local gabX = 20
  local gabY = 10
  local startPosX = 15
  local startPosY = self._groupBg[0]:GetPosY() + self._groupBg[0]:GetSizeY() + gabX
  local panelSizeX = Panel_ChannelSelect_All:GetSizeX()
  local lastPosX = startPosX
  local lastPosY = startPosY
  Panel_ChannelSelect_All:SetSize(self._groupBg[0]:GetSizeX() * (#self._groupBg + 1) + 15, Panel_ChannelSelect_All:GetSizeY())
  self._ui.stc_Icon_Premium:SetShow(isGameTypeKorea())
  self._ui.stc_Icon_PK:SetShow(true)
  if true == isGameTypeKR2() or true == isGameTypeGT() then
    for idx = 1, #bottomIconList do
      bottomIconList[idx]:SetShow(false)
    end
  end
  local panelStartPosX = Panel_ChannelSelect_All:GetPosX()
  local panelEndPosY = panelStartPosX + self._groupBg[0]:GetSizeX()
  local subFrameEndPosY = self._ui.stc_subFrame:GetPosY() + self._ui.stc_subFrame:GetSizeY()
  local lastIndex = 1
  for idx = 1, #bottomIconList do
    if true == bottomIconList[idx]:GetShow() then
      local iconEndPosX = panelStartPosX + lastPosX + bottomIconList[idx]:GetSizeX() + bottomIconList[idx]:GetTextSizeX() + gabX
      if panelEndPosY > iconEndPosX + 10 then
        bottomIconList[idx]:SetPosX(lastPosX)
        bottomIconList[idx]:SetPosY(lastPosY)
        lastPosX = lastPosX + bottomIconList[idx]:GetSizeX() + bottomIconList[idx]:GetTextSizeX() + gabX
      else
        lastPosX = startPosX
        lastPosY = lastPosY + bottomIconList[idx]:GetSizeY() + gabY
        bottomIconList[idx]:SetPosX(lastPosX)
        bottomIconList[idx]:SetPosY(lastPosY)
        lastPosX = lastPosX + bottomIconList[idx]:GetSizeX() + bottomIconList[idx]:GetTextSizeX() + gabX
      end
      lastIndex = idx
    end
  end
  if subFrameEndPosY < lastPosY + bottomIconList[lastIndex]:GetSizeY() + gabY then
    local addSize = math.abs(lastPosY + bottomIconList[lastIndex]:GetSizeY() - subFrameEndPosY)
    Panel_ChannelSelect_All:SetSize(Panel_ChannelSelect_All:GetSizeX(), Panel_ChannelSelect_All:GetSizeY() + addSize)
  else
    Panel_ChannelSelect_All:SetSize(Panel_ChannelSelect_All:GetSizeX(), lastPosY + bottomIconList[lastIndex]:GetTextSizeY() + 5)
  end
  self._ui.stc_subFrame:SetSize(Panel_ChannelSelect_All:GetSizeX() - 5, Panel_ChannelSelect_All:GetSizeY() - (self._ui.stc_Title:GetSizeY() + self._ui.txt_Status:GetTextSizeY() + self._ui.txt_Icon_Time:GetSizeY()))
  self._ui.stc_Title:SetSize(Panel_ChannelSelect_All:GetSizeX(), self._ui.stc_Title:GetSizeY())
  self._ui.stc_descBg:SetSize(Panel_ChannelSelect_All:GetSizeX(), Panel_ChannelSelect_All:GetSizeY())
  Panel_ChannelSelect_All:ComputePos()
  self._ui.stc_descBg:ComputePos()
  self._ui.stc_decoBg:ComputePos()
  self._ui.btn_Close:ComputePos()
  self._ui.btn_Qusetion:ComputePos()
  self._ui.txt_Icon_Time:ComputePos()
  self._ui.txt_Status:ComputePos()
  self._ui.txt_Icon_SeasonCoolTime:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.stc_KeyguideBg:SetSize(Panel_ChannelSelect_All:GetSizeX(), self._ui.stc_KeyguideBg:GetSizeY())
    self._ui.stc_KeyguideBg:ComputePos()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }, self._ui.stc_KeyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_ChannelSelect_All:prepareOpen()
  if nil == Panel_ChannelSelect_All then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    UI.ASSERT(false, "curChannelData is nil ")
    return
  end
  if false == self._isAppliedSeasonTexture then
    self._isAppliedSeasonTexture = true
    FGlobal_SeasonTexture_ChannelSelectPanelSizeCahnge(Panel_ChannelSelect_All:GetSizeX())
  end
  self._elapsedTime = 0
  Panel_ChannelSelect_All:RegisterUpdateFunc("PaGlobalFunc_ChannelSelect_All_UpdatePerFrame")
  PaGlobal_ChannelSelect_All:open()
  PaGlobal_ChannelSelect_All:update()
  PaGlobalFunc_ChannelSelect_All_OnScreenResize()
end
function PaGlobal_ChannelSelect_All:update()
  local curChannelData = getCurrentChannelServerData()
  local curWorldData = getGameWorldServerDataByWorldNo(curChannelData._worldNo)
  local channelCount = getGameChannelServerDataCount(curChannelData._worldNo)
  local restrictedServerNo = curWorldData._restrictedServerNo
  local curServerNo = curChannelData._serverNo
  local channelMoveableGlobalTime = getChannelMoveableTime(curChannelData._worldNo)
  local channelMoveableRemainTime = getChannelMoveableRemainTime(curWorldData._worldNo)
  local specialChannelMoveableGlobalTime = getSpecialChannelMoveableTime(curChannelData._worldNo)
  local specialChannelMoveableRemainTime = getSpecialChannelMoveableRemainTime(curWorldData._worldNo)
  local _worldServerCount = getGameWorldServerDataCount()
  self._ui.txt_Icon_Time:SetShow(false)
  self._ui.txt_Icon_SeasonCoolTime:SetShow(false)
  self._ui.txt_Status:SetShow(false)
  self._serverIndexTable = Array.new()
  if true == _ContentsGroup_SeasonContents then
    local arshaCh_Index = -1
    for ch_Index = 0, channelCount - 1 do
      local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ch_Index)
      if nil ~= serverData and true == serverData._isSeasonChannel then
        if false == serverData._isDontPvPTendencyDecrease then
          self._serverIndexTable:push_back(ch_Index)
        else
          arshaCh_Index = ch_Index
        end
      end
    end
    if -1 ~= arshaCh_Index then
      self._serverIndexTable:push_back(arshaCh_Index)
    end
  end
  for ch_Index = 0, channelCount - 1 do
    local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ch_Index)
    if nil ~= serverData and true == serverData._isSpeedChannel then
      self._serverIndexTable:push_back(ch_Index)
    end
  end
  if false == _ContentsGroup_RenewUI then
    for ch_Index = 0, channelCount - 1 do
      local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ch_Index)
      if nil ~= serverData then
        if true == _ContentsGroup_SeasonContents then
          if (false == serverData._isInstanceChannel or true == ToClient_SelfPlayerIsGM()) and false == serverData._isSpeedChannel and false == serverData._isSeasonChannel then
            self._serverIndexTable:push_back(ch_Index)
          end
        elseif (false == serverData._isInstanceChannel or true == ToClient_SelfPlayerIsGM()) and false == serverData._isSpeedChannel then
          self._serverIndexTable:push_back(ch_Index)
        end
      end
    end
  else
    local crossPlayServer = Array.new()
    local basicServer = Array.new()
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    for ch_Index = 0, channelCount - 1 do
      local serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, ch_Index)
      if nil ~= serverData and false == serverData._isSpeedChannel then
        if __ePlatformType_COUNT == serverData._servicePlatformType then
          if false == serverData._isInstanceChannel or true == ToClient_SelfPlayerIsGM() then
            crossPlayServer:push_back(ch_Index)
          end
        elseif false == serverData._isInstanceChannel then
          if true == _ContentsGroup_ConsoleIntegration then
            if selfPlayerPlatform == serverData._servicePlatformType then
              basicServer:push_back(ch_Index)
            end
          else
            basicServer:push_back(ch_Index)
          end
        end
      end
    end
    local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
    if true == ToClient_isTotalGameClient() and true == isCrossplayMode then
      for cpServer_Idx = 1, #crossPlayServer do
        self._serverIndexTable:push_back(crossPlayServer[cpServer_Idx])
      end
      for basicServer_Idx = 1, #basicServer do
        self._serverIndexTable:push_back(basicServer[basicServer_Idx])
      end
    else
      for basicServer_Idx = 1, #basicServer do
        self._serverIndexTable:push_back(basicServer[basicServer_Idx])
      end
      for cpServer_Idx = 1, #crossPlayServer do
        self._serverIndexTable:push_back(crossPlayServer[cpServer_Idx])
      end
    end
  end
  local channelSizeX = 0
  local tempWrapper = getTemporaryInformationWrapper()
  local _serverData
  channelCount = #self._serverIndexTable
  for ch_Index = 1, #self._serverIndexTable do
    local channelSlot = self._channelSelectUIPool[ch_Index - 1]
    _serverData = getGameChannelServerDataByWorldNo(curChannelData._worldNo, self._serverIndexTable[ch_Index])
    if nil == channelSlot then
      UI.ASSERT(false, "channelSlot is nil idx = " .. tostring(ch_Index - 1))
      break
    end
    if nil == _serverData then
      channelSlot._bg:SetShow(false)
    else
      channelSlot._bg:SetShow(true)
      local stateString = ""
      local tempWarName = ""
      local busyState = _serverData._busyState
      local isPrepereToStop = _serverData:isPrepareToStop()
      local isMaintanance = false
      channelSlot._txt_Status:SetText("")
      if true == isPrepereToStop then
        stateString = PAGetString(Defines.StringSheet_GAME, "LUA_PREPARE_TO_STOP_SERVER")
      elseif 0 == busyState or _serverData:isClosed() then
        stateString = self._string_BusyState[0]
        isMaintanance = true
      else
        stateString = self._string_BusyState[busyState]
      end
      channelSlot._txt_Status:SetText(stateString)
      local warTerritoryKey = ToClient_GetStartSiegeTerritoryKey()
      if nil ~= self._string_WarName[warTerritoryKey] then
        tempWarName = self._string_WarName[warTerritoryKey]
      else
        _PA_ASSERT(false, "\237\153\149\236\157\184\235\144\152\236\167\128 \236\149\138\236\157\128 \236\160\132\236\159\129 \234\176\128\235\138\165/\235\182\136\234\176\128\235\138\165 \236\167\128\236\151\173\234\176\146\236\157\180 \235\147\164\236\150\180\236\153\148\235\139\164. \237\153\149\236\157\184\237\149\152\234\177\176\235\130\152 \236\131\136\235\161\156\236\154\180 \236\160\132\236\159\129\236\167\128\236\151\173\236\157\180 \236\182\148\234\176\128\235\144\172\235\139\164\235\169\180 \236\182\148\234\176\128\237\149\180\236\163\188\236\150\180\236\149\188\237\149\156\235\139\164!!!!")
      end
      local isBeingWar = _serverData._isSiegeBeing
      local isVillage = _serverData._isVillageSiege
      channelSlot._stc_Maintenance:SetShow(isMaintanance)
      channelSlot._stc_PrepareToStop:SetShow(isPrepereToStop)
      channelSlot._stc_WarIcon:SetShow(isBeingWar)
      channelSlot._stc_ExpEvent:SetShow(_serverData._isSpeedChannel)
      channelSlot._stc_Premium:SetShow(_serverData._isPcroomChannel)
      channelSlot._stc_PK:SetShow(_serverData._isDontPvPTendencyDecrease)
      channelSlot._stc_CrossPlay:SetShow(false)
      if true == _ContentsGroup_RenewUI then
        if nil ~= self._friendInviteServerIdx and nil ~= self._friendInviteWorldIdx then
          local inviteServerData = getGameChannelServerDataByIndex(self._friendInviteWorldIdx, self._friendInviteServerIdx)
          if nil ~= inviteServerData and inviteServerData._serverNo == _serverData._serverNo then
            channelSlot._stc_FriendInvite:SetShow(true)
          end
        else
          channelSlot._stc_FriendInvite:SetShow(false)
        end
        if true == ToClient_isTotalGameClient() then
          local isCrossplayMode = ToClient_getGameOptionControllerWrapper():getSamePlatformOnly()
          if __ePlatformType_COUNT == _serverData._servicePlatformType and false == isCrossplayMode then
            channelSlot._stc_Maintenance:SetShow(false)
            channelSlot._stc_CrossPlay:SetShow(true)
          end
        end
      end
      if true == _ContentsGroup_SeasonContents and true == _serverData._isSeasonChannel then
        channelSlot._stc_SeasonChannel:SetShow(true)
      else
        channelSlot._stc_SeasonChannel:SetShow(false)
      end
      channelSlot._bg:addInputEvent("Mouse_LUp", "")
      channelSlot._bg:addInputEvent("Mouse_On", "")
      channelSlot._bg:addInputEvent("Mouse_Out", "")
      channelSlot._bg:SetIgnore(false)
      if _serverData._isSteamChannel then
        channelSlot._bg:SetIgnore(not isSteamClient())
      elseif _serverData._isPremiumChannel then
        if false == tempWrapper:isPremiumChannelPermission() then
          channelSlot._bg:SetIgnore(true)
        end
      elseif _serverData._isSpeedChannel then
        if 0 ~= tempWrapper:getMyAdmissionToSpeedServer() then
          if false == _ContentsGroup_isConsolePadControl then
            channelSlot._bg:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelSelect_All_NewbieServerJoinDateDesc(true, " .. ch_Index - 1 .. ")")
            channelSlot._bg:addInputEvent("Mouse_Out", "HandleEventOnOut_ChannelSelect_All_NewbieServerJoinDateDesc(false, " .. ch_Index - 1 .. ")")
          end
        elseif false == ToClient_SelfPlayerIsGM() then
          channelSlot._bg:SetIgnore(true)
        end
      elseif _serverData._isBalanceChannel then
        if false == ToClient_isAccessableBalanceChannel() then
          channelSlot._bg:SetIgnore(true)
        end
      elseif _serverData._isPcroomChannel and false == ToClient_isAccessablePcRoomChannel() then
        channelSlot._bg:SetIgnore(true)
      end
      local isAdmission = true
      local isSiegeBeing = deadMessage_isSiegeBeingMyChannel()
      local isInSiegeBattle = deadMessage_isInSiegeBattle()
      if true == isSiegeBeing and false == isInSiegeBattle then
        isAdmission = true
      elseif 0 ~= restrictedServerNo and toInt64(0, 0) ~= channelMoveableGlobalTime and false == _serverData._isSeasonChannel or 0 ~= restrictedServerNo and toInt64(0, 0) ~= specialChannelMoveableGlobalTime and true == _serverData._isSeasonChannel then
        if restrictedServerNo == _serverData._serverNo then
          isAdmission = true
        elseif channelMoveableRemainTime > toInt64(0, 0) and false == _serverData._isSeasonChannel then
          isAdmission = false
          if false == self._ui.txt_Icon_Time:GetShow() then
            local changeRealChannelTime = convertStringFromDatetime(channelMoveableRemainTime)
            self._ui.txt_Status:SetShow(true)
            self._ui.txt_Icon_Time:SetShow(true)
            self._ui.txt_Icon_Time:SetText(changeRealChannelTime)
          end
        elseif specialChannelMoveableRemainTime > toInt64(0, 0) and true == _serverData._isSeasonChannel then
          isAdmission = false
          if false == self._ui.txt_Icon_SeasonCoolTime:GetShow() then
            local changeRealSpecialChannelTime = convertStringFromDatetime(specialChannelMoveableRemainTime)
            self._ui.txt_Status:SetShow(true)
            self._ui.txt_Icon_SeasonCoolTime:SetShow(true)
            self._ui.txt_Icon_SeasonCoolTime:SetText(changeRealSpecialChannelTime)
          end
        else
          isAdmission = true
        end
      end
      channelSlot._stc_SeasonCoolTime:SetShow(false)
      channelSlot._stc_NormalCoolTime:SetShow(false)
      if true == _serverData._isSeasonChannel then
        channelSlot._stc_SeasonCoolTime:SetShow(not isAdmission)
      else
        channelSlot._stc_NormalCoolTime:SetShow(not isAdmission)
      end
      local channelName = getChannelName(_serverData._worldNo, _serverData._serverNo)
      if nil == channelName then
        channelName = ""
      end
      if true == isGameServiceTypeDev() then
        channelSlot._txt_Title:SetText(channelName .. "(" .. tempWarName .. ")")
      else
        channelSlot._txt_Title:SetText(channelName)
      end
      if curChannelData._worldNo == _serverData._worldNo and curChannelData._serverNo == _serverData._serverNo then
        channelSlot._bg:addInputEvent("Mouse_LUp", "")
        channelSlot._stc_CurrentChannelBg:SetShow(true)
        channelSlot._bg:SetIgnore(true)
      else
        channelSlot._bg:addInputEvent("Mouse_LUp", "HandleEventLUp_ChannelSelect_All_SelectChannel(" .. ch_Index .. ")")
        channelSlot._stc_CurrentChannelBg:SetShow(false)
      end
      local iconTable = channelSlot._IconTable
      local setCount = 1
      local startPosX = 0
      local prevIdx = 1
      for idx = 1, #iconTable do
        if nil ~= iconTable[idx] and true == iconTable[idx]:GetShow() then
          if 1 == setCount then
            iconTable[idx]:SetPosX(channelSlot._txt_Title:GetPosX() + channelSlot._txt_Title:GetTextSizeX() + 20)
            startPosX = iconTable[idx]:GetPosX()
            prevIdx = idx
          elseif nil ~= iconTable[prevIdx] then
            startPosX = startPosX + iconTable[prevIdx]:GetSizeX() + 2
            iconTable[idx]:SetPosX(startPosX)
            prevIdx = idx
          end
          setCount = setCount + 1
          if false == self._isConsole then
            iconTable[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_ChannelSelect_All_ServerSlotIcon_Tooltip(" .. idx .. "," .. ch_Index - 1 .. ")")
            iconTable[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_ChannelSelect_All_ServerSlotIcon_Tooltip()")
          end
        end
      end
    end
  end
  PaGlobal_ChannelSelect_All:computeServerCoolTimePosition()
end
function PaGlobal_ChannelSelect_All:open()
  if nil == Panel_ChannelSelect_All then
    return
  end
  Panel_ChannelSelect_All:SetShow(true, true)
end
function PaGlobal_ChannelSelect_All:prepareClose()
  if nil == Panel_ChannelSelect_All then
    return
  end
  self._friendInviteWorldIdx = nil
  self._friendInviteServerIdx = nil
  TooltipSimple_Hide()
  Panel_ChannelSelect_All:ClearUpdateLuaFunc()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_ChannelSelect_All:close()
end
function PaGlobal_ChannelSelect_All:close()
  if nil == Panel_ChannelSelect_All then
    return
  end
  Panel_ChannelSelect_All:SetShow(false, false)
end
function PaGlobal_ChannelSelect_All:SetMsgDataAndShow(_title, _content, _funcYes, _funcNo, _funcApply, _priority)
  local messageboxData = {}
  messageboxData.title = ""
  messageboxData.content = ""
  messageboxData.priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData.functionYes = MessageBox_Empty_function
  messageboxData.functionNo = MessageBox_Empty_function
  messageboxData.functionApply = MessageBox_Empty_function
  if nil ~= _title then
    messageboxData.title = _title
  end
  if nil ~= _content then
    messageboxData.content = _content
  end
  if nil ~= _priority then
    messageboxData.priority = _priority
  end
  if nil ~= _funcYes or nil ~= _funcNo then
    if nil ~= _funcYes then
      messageboxData.functionYes = _funcYes
    end
    if nil ~= _funcNo then
      messageboxData.functionNo = _funcNo
    end
    messageboxData.functionApply = nil
  else
    if nil ~= _funcApply then
      messageboxData.functionApply = _funcApply
    end
    messageboxData.functionYes = nil
    messageboxData.functionNo = nil
  end
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_ChannelSelect_All:validate()
  if nil == Panel_ChannelSelect_All then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.btn_Qusetion:isValidate()
  self._ui.stc_subFrame:isValidate()
  self._ui.stc_AllBG:isValidate()
  self._ui.stc_Icon_War:isValidate()
  self._ui.stc_Icon_NoEnterance:isValidate()
  self._ui.stc_Icon_Maintenance:isValidate()
  self._ui.stc_Icon_PrepareToStop:isValidate()
  self._ui.stc_Icon_ExpEvent:isValidate()
  self._ui.stc_Icon_Premium:isValidate()
  self._ui.stc_Icon_PK:isValidate()
  self._ui.stc_Icon_CrossPlay:isValidate()
  self._ui.txt_Icon_Time:isValidate()
  self._ui.txt_Status:isValidate()
  self._ui.chk_ShowDesc:isValidate()
  self._ui.stc_ShowDesc_PadUI:isValidate()
  self._ui.stc_ShowDescText_PadUI:isValidate()
  self._ui.rdo_Templeate:isValidate()
  self._ui.stc_DescPanel:isValidate()
  self._ui.txt_ChannelSelectTitle:isValidate()
  self._ui.txt_ChannelSelectDesc:isValidate()
  self._ui.txt_SpeedTitle:isValidate()
  self._ui.txt_SpeedDesc:isValidate()
  self._ui.txt_PkTitle:isValidate()
  self._ui.txt_PkDesc:isValidate()
  self._ui.txt_SiegeTitle:isValidate()
  self._ui.txt_SiegeBalenos:isValidate()
  self._ui.txt_SiegeSerendia:isValidate()
  self._ui.txt_SiegeCalpheon:isValidate()
  self._ui.txt_SiegeMedia:isValidate()
  self._ui.txt_SiegeValencia:isValidate()
  self._ui.txt_Schedule:isValidate()
  self._ui.txt_Schedule_Siege:isValidate()
  self._ui.txt_Schedule_NodeWar:isValidate()
  self._ui.stc_blockBG:isValidate()
  self._ui.stc_decoBg:isValidate()
  self._ui.stc_descBg:isValidate()
  self._ui.txt_SeasonTitle:isValidate()
  self._ui.txt_SeasonDesc:isValidate()
  self._ui.stc_KeyguideBg:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_Icon_SeasonChannel:isValidate()
  self._ui.txt_Icon_SeasonCoolTime:isValidate()
end
function PaGlobal_ChannelSelect_All:checkDescUpdateCondition()
  if 0 >= self._descButtonCount then
    return false
  end
  if false == self._ui.frame_Desc:GetShow() then
    return false
  end
  if nil == self._serverDescControls then
    return false
  end
  return true
end
function PaGlobal_ChannelSelect_All:updateServerDescFrame(deltaT)
  if false == self:checkDescUpdateCondition() then
    return
  end
  local posY = 0
  for idx = 1, self._descButtonCount do
    if nil ~= self._serverDescControls[idx] then
      local radioButton = self._serverDescControls[idx].rdo
      local descBG = self._serverDescControls[idx].bg
      local descCount = self._serverDescControls[idx].descCount
      local desc = self._serverDescControls[idx].text
      local maxDescBGSizeY = self._descSpanSize + desc[descCount]:GetTextSizeY() + desc[descCount]:GetPosY()
      local sizeY = self._minDescBGSizeY
      descBG:SetShow(descBG:GetSizeY() > self._minDescBGSizeY)
      if radioButton:IsCheck() then
        sizeY = descBG:GetSizeY() + deltaT * self._showDescAniSpeed
        sizeY = math.min(sizeY, maxDescBGSizeY)
      else
        sizeY = descBG:GetSizeY() - deltaT * self._hideDescAniSpeed
        sizeY = math.max(sizeY, self._minDescBGSizeY)
      end
      descBG:SetSize(self._descBGSizeX, sizeY)
      for i = 1, descCount do
        if sizeY >= desc[i]:GetPosY() + desc[i]:GetTextSizeY() then
          desc[i]:SetShow(true)
        else
          desc[i]:SetShow(false)
        end
      end
      radioButton:SetPosY(posY + 10)
      posY = posY + self._descButtonSizeY
      if idx <= self._descButtonCount then
        posY = posY + 10
      end
      descBG:SetPosY(posY + 10)
      if descBG:GetShow() then
        posY = posY + descBG:GetSizeY() + 10
      end
    end
  end
  self._ui.frameContent:SetSize(self._ui.frameContent:GetSizeX(), posY + 10)
  self._ui.frame_Desc:SetSize(self._ui.frameContent:GetSizeX(), posY + 10)
  self._ui.frame_Desc:UpdateContentPos()
  self._ui.frame_Desc:UpdateContentScroll()
end
function PaGlobal_ChannelSelect_All:computeServerCoolTimePosition()
  local self = PaGlobal_ChannelSelect_All
  if true == self._ui.txt_Icon_Time:GetShow() and false == self._ui.txt_Icon_SeasonCoolTime:GetShow() then
    local spanX = self._ui.txt_Icon_Time:GetTextSizeX() + self._ui.txt_Icon_Time:GetSizeX()
    self._ui.txt_Icon_Time:SetSpanSize(spanX, 75)
    self._ui.txt_Icon_Time:ComputePos()
  elseif false == self._ui.txt_Icon_Time:GetShow() and true == self._ui.txt_Icon_SeasonCoolTime:GetShow() then
    local spanX = self._ui.txt_Icon_SeasonCoolTime:GetTextSizeX() + self._ui.txt_Icon_SeasonCoolTime:GetSizeX()
    self._ui.txt_Icon_SeasonCoolTime:SetSpanSize(spanX, 75)
    self._ui.txt_Icon_SeasonCoolTime:ComputePos()
  elseif true == self._ui.txt_Icon_Time:GetShow() and true == self._ui.txt_Icon_SeasonCoolTime:GetShow() then
    local spanX = self._ui.txt_Icon_Time:GetTextSizeX() + self._ui.txt_Icon_Time:GetSizeX()
    self._ui.txt_Icon_Time:SetSpanSize(spanX, 75)
    self._ui.txt_Icon_Time:ComputePos()
    spanX = self._ui.txt_Icon_SeasonCoolTime:GetTextSizeX() + self._ui.txt_Icon_SeasonCoolTime:GetSizeX() + 20 + self._ui.txt_Icon_Time:GetSpanSize().x
    self._ui.txt_Icon_SeasonCoolTime:SetSpanSize(spanX, 75)
    self._ui.txt_Icon_SeasonCoolTime:ComputePos()
  end
end
