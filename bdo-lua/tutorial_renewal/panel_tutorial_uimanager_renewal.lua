registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_TutorialUiManager")
registerEvent("onScreenResize", "FromClient_TutorialScreenReposition")
registerEvent("EventSelfPlayerLevelUp", "FromClient_EventSelfPlayerLevelUp_TutorialUiManager")
PaGlobal_TutorialUiManager = {
  _uiList = {
    _uiBlackSpirit = nil,
    _uiHeadlineMessage = nil,
    _uiMasking = nil,
    _uiSmallSpirit = nil,
    _uiGuideButton = nil
  }
}
PaGlobal_TutorialUiManager._uiPanelInfo = {
  [Panel_SelfPlayerExpGage] = CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage,
  [Panel_UIMain] = CppEnums.PAGameUIType.PAGameUIPanel_UIMenu,
  [Panel_Radar] = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
  [Panel_QuickSlot] = CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot,
  [Panel_MainStatus_User_Bar] = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusBar,
  [Panel_CheckedQuest] = CppEnums.PAGameUIType.PAGameUIPanel_CheckedQuest,
  [Panel_MyHouseNavi] = CppEnums.PAGameUIType.PAGameUIPanel_MyHouseNavi,
  [Panel_Window_Servant] = CppEnums.PAGameUIType.PAGameUIPanel_ServantWindow,
  [Panel_NewEquip] = CppEnums.PAGameUIType.PAGameUIPanel_NewEquipment,
  [Panel_PvpMode] = CppEnums.PAGameUIType.PAGameUIPanel_PvpMode,
  [Panel_Adrenallin] = CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin,
  [Panel_TimeBar] = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
  [Panel_SkillCommand] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand,
  [Panel_ClassResource] = CppEnums.PAGameUIType.PAGameUIPanel_ClassResource,
  [Panel_NewQuickSlot_1] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_1,
  [Panel_NewQuickSlot_2] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_2,
  [Panel_NewQuickSlot_3] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_3,
  [Panel_NewQuickSlot_4] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_4,
  [Panel_NewQuickSlot_5] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_5,
  [Panel_NewQuickSlot_6] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_6,
  [Panel_NewQuickSlot_7] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_7,
  [Panel_NewQuickSlot_8] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_8,
  [Panel_NewQuickSlot_9] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_9,
  [Panel_NewQuickSlot_0] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_0,
  [Panel_NewQuickSlot_11] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_11,
  [Panel_NewQuickSlot_12] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_12,
  [Panel_NewQuickSlot_13] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_13,
  [Panel_NewQuickSlot_14] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_14,
  [Panel_NewQuickSlot_15] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_15,
  [Panel_NewQuickSlot_16] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_16,
  [Panel_NewQuickSlot_17] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_17,
  [Panel_NewQuickSlot_18] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_18,
  [Panel_NewQuickSlot_19] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_19,
  [Panel_NewQuickSlot_10] = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_10,
  [Panel_SkillCooltime] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
  [Panel_Movie_KeyViewer] = CppEnums.PAGameUIType.PAGameUIPanel_KeyViewer,
  [Panel_MainQuest] = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest,
  [Panel_MainStatus_Remaster] = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster,
  [Panel_Widget_ServantIcon] = CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon,
  [Panel_PersonalIcon_Left] = CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon,
  [Panel_Widget_Function] = CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction,
  [Panel_AppliedBuffList] = CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList,
  [Panel_SkillCoolTimeQuickSlot_0] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_0,
  [Panel_SkillCoolTimeQuickSlot_1] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_1,
  [Panel_SkillCoolTimeQuickSlot_2] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_2,
  [Panel_SkillCoolTimeQuickSlot_3] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_3,
  [Panel_SkillCoolTimeQuickSlot_4] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_4,
  [Panel_SkillCoolTimeQuickSlot_5] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_5,
  [Panel_SkillCoolTimeQuickSlot_6] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_6,
  [Panel_SkillCoolTimeQuickSlot_7] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_7,
  [Panel_SkillCoolTimeQuickSlot_8] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_8,
  [Panel_SkillCoolTimeQuickSlot_9] = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_9,
  [Panel_Widget_AreaOfHadum] = CppEnums.PAGameUIType.PAGameUIPanel_AreaOfHadum,
  [Panel_Stamina] = CppEnums.PAGameUIType.PAGameUIPanel_Stamina,
  [Panel_Widget_KillLog] = CppEnums.PAGameUIType.PAGameUIPanel_KillLog
}
function PaGlobal_TutorialUiManager:initialize()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobal_TutorialUiManager._uiPanelInfo[Panel_Widget_Party_All] = CppEnums.PAGameUIType.PAGameUIPanel_Party
    PaGlobal_TutorialUiManager._uiPanelInfo[Panel_Widget_Raid_All] = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty
  else
    PaGlobal_TutorialUiManager._uiPanelInfo[Panel_Widget_Party] = CppEnums.PAGameUIType.PAGameUIPanel_Party
    PaGlobal_TutorialUiManager._uiPanelInfo[Panel_Widget_Raid] = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty
  end
  self._uiList._uiBlackSpirit = PaGlobal_TutorialUiBlackSpirit
  self._uiList._uiBlackSpirit:initialize()
  self._uiList._uiHeadlineMessage = PaGlobal_TutorialUiHeadlineMessage
  self._uiList._uiHeadlineMessage:initialize()
  self._uiList._uiMasking = PaGlobal_TutorialUiMasking
  self._uiList._uiSmallSpirit = PaGlobal_TutorialUiSmallBlackSpirit
  self._uiList._uiGuideButton = PaGlobal_TutorialUiGuideButton
  Panel_Tutorial_Renew:RegisterShowEventFunc(true, "PaGlobalFunc_Tutorial_ShowAni()")
  Panel_Tutorial_Renew:RegisterShowEventFunc(false, "PaGlobalFunc_Tutorial_HideAni()")
  PaGlobal_TutorialManager:handleTutorialUiManagerInitialize()
end
function PaGlobalFunc_Tutorial_ShowAni()
  PaGlobal_TutorialUiManager:showAni()
end
function PaGlobalFunc_Tutorial_HideAni()
  PaGlobal_TutorialUiManager:hideAni()
end
function PaGlobal_TutorialUiManager:showAni()
end
function PaGlobal_TutorialUiManager:hideAni()
end
function PaGlobal_TutorialUiManager:loadAllUiSavedInfo()
  local isChangeRadarUI = false
  for key, value in pairs(self._uiPanelInfo) do
    local isShow = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if -1 ~= isShow then
      if CppEnums.PAGameUIType.PAGameUIPanel_RadarMap == value then
        if 1 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WorldMiniMap, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
          isShow = 1
          isChangeRadarUI = true
        end
        FGlobal_Panel_Radar_Show(isShow)
      elseif CppEnums.PAGameUIType.PAGameUIPanel_UIMenu == value then
        key:SetShow(not _ContentsGroup_RenewUI_Main and isShow)
      elseif CppEnums.PAGameUIType.PAGameUIPanel_Party == value or CppEnums.PAGameUIType.PAGameUIPanel_LargeParty == value or CppEnums.PAGameUIType.PAGameUIPanel_MainQuest == value then
      else
        key:SetShow(isShow)
      end
      local posX = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_PositionX)
      local posY = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_PositionY)
      local relativePosX = -1
      local relativePosY = -1
      relativePosX = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
      relativePosY = ToClient_GetUiInfo(value, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      if -1 ~= posX or -1 ~= posY then
        key:SetPosX(posX)
        key:SetPosY(posY)
        key:SetRelativePosX(relativePosX)
        key:SetRelativePosY(relativePosY)
        PAGlobal_setIsChangePanelState(value, true, false)
        onReSizePanel(key)
      end
      checkAndSetPosInScreen(key)
    end
  end
  if false == _ContentsGroup_RenewUI_Main then
    Panel_ClassResource_SetShow(true)
  end
  if not _ContentsGroup_RenewUI_Chatting then
    local chattingPanelCount = ToClient_getChattingPanelCount()
    for panelIndex = 0, chattingPanelCount - 1 do
      local chatPanel = ToClient_getChattingPanel(panelIndex)
      local chatPanelUI = FGlobal_getChattingPanel(panelIndex)
      chatPanelUI:SetShow(chatPanel:isOpen())
      local posX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_PositionX)
      local posY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_PositionY)
      chatPanelUI:SetPosX(posX)
      chatPanelUI:SetPosY(posY)
      local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
      local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      chatPanelUI:SetRelativePosX(relativePosX)
      chatPanelUI:SetRelativePosY(relativePosY)
      PAGlobal_setIsChangePanelState(panelIndex + chattingPanelCount, true, true)
      local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, panelIndex, CppEnums.PanelSaveType.PanelSaveType_IsShow)
      if -1 ~= isShow then
        chatPanelUI:SetShow(isShow)
      end
    end
    Chatting_OnResize()
  end
  if true == _ContentsGroup_RenewUI_Main then
    Panel_SkillCommand:SetShow(false)
  end
  local gameTipShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_GameTips, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  Panel_GameTipMask:SetShow(gameTipShow)
  Panel_GameTips:SetShow(gameTipShow)
  if true == isChangeRadarUI then
    PaGlobal_changeRadarUI()
  end
end
function onReSizePanel(key)
  if key == Panel_NewEquip then
    if false == _ContentsGroup_RemasterUI_Main_Alert then
      Panel_NewEquip_ScreenResize()
    end
  elseif key == Panel_MainStatus_User_Bar then
    if false == _ContentsGroup_RenewUI_Main then
      Panel_MainStatus_User_Bar_Onresize()
    end
  elseif key == Panel_MainQuest then
    FromClient_MainQuestWidget_ResetPosition()
  elseif key == Panel_SkillCommand then
    FGlobal_SkillCommand_ResetPosition()
  elseif key == Panel_PvpMode then
    if false == _ContentsGroup_RenewUI_Main then
      PvpMode_Resize()
    end
  elseif key == Panel_Party then
    partWidget_OnscreenEvent()
  elseif key == Panel_Movie_KeyViewer then
    Panel_KeyViewer_ScreenRePosition()
  elseif key == Panel_CheckedQuest then
    FromClient_questWidget_ResetPosition()
  elseif key == Panel_Adrenallin then
    if false == _ContentsGroup_RenewUI_Main then
      Panel_Adrenallin_OnSreenResize()
    end
  elseif key == Panel_QuickSlot then
    QuickSlot_OnscreenResize()
  elseif key == Panel_Widget_ServantIcon then
    PaGlobalFunc_ServantIcon_OnResize()
  end
end
function FromClient_TutorialScreenReposition()
  PaGlobal_TutorialUiManager:repositionScreen()
end
function PaGlobal_TutorialUiManager:repositionScreen()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Tutorial_Renew:SetSize(scrX, scrY)
  Panel_Tutorial_Renew:SetPosX(0)
  Panel_Tutorial_Renew:SetPosY(0)
  PaGlobal_TutorialUiBlackSpirit._ui._fadeOutBg:SetSize(scrX, scrY)
  for key, value in pairs(self._uiList) do
    for _, vv in pairs(value._ui) do
      vv:ComputePos()
    end
  end
end
function PaGlobal_TutorialUiManager:closeAllWindow()
  if check_ShowWindow() then
    close_WindowPanelList()
  elseif true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_Close()
  else
    PaGlobalFunc_MainDialog_Hide()
  end
end
function PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  local isTutorialSkip = 1 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eTutorialSkip)
  if CheckTutorialEnd() or isTutorialSkip then
    self:loadAllUiSavedInfo()
  end
  self:setShowAllDefaultUi(true)
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    if nil ~= Panel_WorldMiniMap then
      Panel_WorldMiniMap:SetShow(false, false)
    end
    if nil ~= Panel_TimeBar then
      Panel_TimeBar:SetShow(false, false)
    end
    if nil ~= Panel_Radar then
      Panel_Radar:SetShow(false, false)
    end
    if nil ~= Panel_MainQuest then
      Panel_MainQuest:SetShow(false)
    end
    if nil ~= Panel_CheckedQuest then
      Panel_CheckedQuest:SetShow(false)
    end
    return
  end
end
function PaGlobal_TutorialUiManager:setShowAllDefaultUi(isShow)
  if false == isShow then
  elseif true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ConsoleKeyGuide_On()
    if true == _ContentsGroup_RenewUI_Chatting then
      PaGlobalFunc_ChattingViewer_On()
    end
    PaGlobal_ConsoleQuickMenu:widgetOpen(true)
    PaGlobal_ConsoleQuickMenu:setWidget()
  end
end
function PaGlobal_TutorialUiManager:hideAllTutorialUi()
  for _, v in pairs(self._uiList) do
    for __, control in pairs(v._ui) do
      control:SetShow(false)
    end
  end
end
function FromClient_luaLoadComplete_TutorialUiManager()
  PaGlobal_TutorialUiManager:initialize()
end
function FromClient_EventSelfPlayerLevelUp_TutorialUiManager()
  if CheckTutorialEnd() then
    PaGlobal_TutorialUiManager:restoreAllUiByUserSetting()
  end
end
function PaGlobal_TutorialUiManager:getUiBlackSpirit()
  return self._uiList._uiBlackSpirit
end
function PaGlobal_TutorialUiManager:getUiHeadlineMessage()
  return self._uiList._uiHeadlineMessage
end
function PaGlobal_TutorialUiManager:getUiMasking()
  return self._uiList._uiMasking
end
function PaGlobal_TutorialUiManager:getUiSmallBlackSpirit()
  return self._uiList._uiSmallSpirit
end
function PaGlobal_TutorialUiManager:getUiGuideButton()
  return self._uiList._uiGuideButton
end
