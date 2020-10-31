function PaGlobal_SkillGroup:init()
  self._isConsole = _ContentsGroup_RenewUI
  self:registEventHandler()
  self:controlInit_All()
  self:createFrameControls()
  if true == ToClient_LearnSkillCameraIsShow() and false == ToClient_LearnSkillCameraHide() then
    return
  end
  self:initTreeTabIcon()
  self:CheckLearnAbleSkillCount()
  self:selectTab(0)
  Panel_Window_SkillGroup:RegisterShowEventFunc(true, "PaGlobal_SkillGroup_ShowAni()")
  Panel_Window_SkillGroup:RegisterShowEventFunc(false, "PaGlobal_SkillGroup_HideAni()")
end
function PaGlobal_SkillGroup:viewControllerToggle()
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return
  end
  self._isWindow = not self._ui._stc_playShow:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSkillGroupWindowViewPlayPanel, self._isWindow, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_SkillGroup:updateViewController(self._isWindow, false)
end
function PaGlobal_SkillGroup:updateViewController(isWindow, isForced)
  if false == isForced then
    isWindow = self._isWindow
  end
  if false == isWindow then
    self:updateEditMode(false)
    PaGlobal_SkillGroup_Controller:open()
    ToClient_LearnSkillCameraShow()
    ToClient_LearnSkillCameraLoadCharcterAndCamera()
    ToClient_LearnSkillCameraSetZoom(200)
    ToClient_LearnSkillCameraSetPosition(70, -10)
    ToClient_LearnSkillCameraSetRotation(-2.5, -0.3)
    SkillGroup_Resize()
  else
    if true == ToClient_LearnSkillCameraIsShow() and false == ToClient_LearnSkillCameraHide() then
      return
    end
    if true == Panel_Window_SkillGroup_Controller:GetShow() then
      PaGlobal_SkillGroup_Controller:close()
    end
  end
  self._ui._stc_playShow:SetCheck(not isWindow)
end
function PaGlobal_SkillGroup:controlInit_All()
  self._panel = Panel_Window_SkillGroup
  local ui = self._ui
  ui._rdo_groupBg = UI.getChildControl(Panel_Window_SkillGroup, "Static_RadioGroup")
  ui._stc_TopFuncBg = UI.getChildControl(Panel_Window_SkillGroup, "Static_TopFunctionArea")
  local skillPointBg = UI.getChildControl(ui._stc_TopFuncBg, "Static_SkillPoint")
  ui._txt_skillPoint = UI.getChildControl(skillPointBg, "StaticText_SkillPointValue")
  local skillPointTitleText = UI.getChildControl(skillPointBg, "StaticText_SkillPointTitle_Text")
  UI.setLimitTextAndAddTooltip(skillPointTitleText)
  self._tab = {
    [0] = UI.getChildControl(ui._rdo_groupBg, "RadioButton_Tab_MainWeapon"),
    [1] = UI.getChildControl(ui._rdo_groupBg, "RadioButton_Tab_SuccesstionSkill"),
    [2] = UI.getChildControl(ui._rdo_groupBg, "RadioButton_Tab_AwakenWeapon"),
    [3] = UI.getChildControl(ui._rdo_groupBg, "RadioButton_Tab_DeepeningSkill")
  }
  ui._rdo_treeBg = UI.getChildControl(Panel_Window_SkillGroup, "Static_SelectTypeArea")
  self._tree = {
    [0] = {
      _panel = UI.getChildControl(ui._rdo_treeBg, "RadioButton_AwakenSkill"),
      _lock = UI.getChildControl(ui._rdo_treeBg, "Static_AwakenLock"),
      _currentStatus = nil,
      _icon = nil
    },
    [1] = {
      _panel = UI.getChildControl(ui._rdo_treeBg, "RadioButton_DeepSkill"),
      _lock = UI.getChildControl(ui._rdo_treeBg, "Static_DeepLock"),
      _currentStatus = nil,
      _icon = nil
    }
  }
  for ii = 0, #self._tab do
    self._tab[ii]:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:selectTab(" .. ii .. ")")
  end
  for ii = 0, #self._tree do
    self._tree[ii]._currentStatus = UI.getChildControl(self._tree[ii]._panel, "StaticText_CurrentStatus")
    self._tree[ii]._panel:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:clickTree(" .. ii + 1 .. ")")
  end
  ui._selectLine = UI.getChildControl(ui._rdo_groupBg, "Static_SelctLine")
  for ii = 0, 3 do
    self._frame[ii] = UI.getChildControl(Panel_Window_SkillGroup, "Frame_" .. tostring(ii))
    self._frame[ii]:GetFrameContent():addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOver_FrameOn()")
    self._frame[ii]:GetFrameContent():addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleMLUp_Frame()")
  end
  for ii = 0, #self._frame do
    self._frameScroll[ii] = UI.getChildControl(self._frame[ii], "Frame_1_VerticalScroll")
  end
  local btn_skillGroup = UI.getChildControl(Panel_Window_SkillGroup, "Static_Skill_Template")
  self._baseSkillGroupControl = UI.getChildControl(btn_skillGroup, "Radiobutton_SkillButton_Template")
  local strLineType = {"A", "C"}
  for key, value in pairs(strLineType) do
    self._baseLineControl[key] = Array.new()
    for ii = 1, 11 do
      self._baseLineControl[key][ii] = UI.getChildControl(Panel_Window_SkillGroup, "Static_" .. tostring(value) .. "_" .. tostring(ii))
    end
  end
  self._subSkillGroupControl = UI.getChildControl(Panel_Window_SkillGroup, "Static_GroupTitleBG")
  ui._stc_bottomArea = UI.getChildControl(Panel_Window_SkillGroup, "Static_BottomArea")
  ui._btn_allReset = UI.getChildControl(ui._stc_TopFuncBg, "Button_AllReset")
  ui._btn_allReset:addInputEvent("Mouse_LUp", "SkillEvent_SkillGroupWindow_ClearSkill(0)")
  ui._stc_playShow = UI.getChildControl(ui._stc_bottomArea, "Checkbox_PlayShow")
  ui._txt_playShow = UI.getChildControl(ui._stc_playShow, "StaticText_PlayShow")
  ui._btn_modify = UI.getChildControl(ui._stc_bottomArea, "Button_Modify")
  ui._btn_modify:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_EditMode()")
  UI.setLimitTextAndAddTooltip(ui._btn_modify)
  local useGuideGroup = UI.getChildControl(ui._stc_bottomArea, "Static_UseGuide")
  local leftClickGuide = UI.getChildControl(useGuideGroup, "StaticText_LeftClickGuide")
  local leftClickGuideText = UI.getChildControl(leftClickGuide, "StaticText_LeftClickGuideText")
  UI.setLimitTextAndAddTooltip(leftClickGuideText)
  local RightClickGuide = UI.getChildControl(useGuideGroup, "StaticText_RightClickGuide")
  local RightClickGuideText = UI.getChildControl(RightClickGuide, "StaticText_RightClickGuideText")
  UI.setLimitTextAndAddTooltip(RightClickGuideText)
  local Shift1 = UI.getChildControl(useGuideGroup, "StaticText_Shift1")
  local Shift1Text = UI.getChildControl(Shift1, "StaticText_Shift1_Text")
  UI.setLimitTextAndAddTooltip(Shift1Text)
  local shift2 = UI.getChildControl(useGuideGroup, "StaticText_Shift2")
  local Shift2Text = UI.getChildControl(shift2, "StaticText_Shift2_Text")
  UI.setLimitTextAndAddTooltip(Shift2Text)
  ui._btn_lockSpirit = UI.getChildControl(ui._stc_bottomArea, "Button_LockSpirit")
  ui._btn_lockSpirit:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_BlackSpiritSkillLock()")
  ui._btn_cooltimeSet = UI.getChildControl(ui._stc_bottomArea, "Button_CooltimeSlot")
  ui._btn_cooltimeSet:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_CooltimeSet()")
  self._deepeningSkill.area = UI.getChildControl(Panel_Window_SkillGroup, "Static_DeepSkillArea")
  self._deepeningSkill.frame = UI.getChildControl(self._deepeningSkill.area, "Frame_DeepSkill")
  self._deepeningSkill.frameScroll = UI.getChildControl(self._deepeningSkill.frame, "Frame_DeepSkill_VerticalScroll")
  local recentSkillControl = UI.getChildControl(Panel_Window_SkillGroup, "Static_RecentSkill3")
  self._recentSkill = {
    step = {},
    arrow = {},
    key = {},
    noSelectSkill = nil,
    maxCount = 3,
    currentCount = 0
  }
  for ii = 0, self._recentSkill.maxCount - 1 do
    self._recentSkill.step[ii] = UI.getChildControl(recentSkillControl, "StaticText_Step" .. tostring(ii + 1))
    if 0 < ii then
      self._recentSkill.arrow[ii] = UI.getChildControl(recentSkillControl, "Static_RightArrow" .. tostring(ii))
    end
    self._recentSkill.key[ii] = nil
  end
  self._recentSkill.noSelectSkill = UI.getChildControl(recentSkillControl, "StaticText_NoSelectSkill")
  self:clearRecentSkill()
  ui._btn_movie = UI.getChildControl(ui._stc_bottomArea, "Button_Movie")
  ui._btn_movie:addInputEvent("Mouse_LUp", "PaGlobal_MovieSkillGuide_Web:Open()")
  ui._btn_movie:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOn_MovieButtonOn()")
  ui._btn_movie:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:HandleMOut_MovieButtonOut()")
  ui._btn_question = UI.getChildControl(ui._stc_TopFuncBg, "Button_SkillSet")
  ui._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowSkill\" )")
  ui._btn_question:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOn_HelpButtonOn()")
  ui._btn_question:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:HandleMOut_HelpButtonOut()")
  ui._edit_search = UI.getChildControl(ui._stc_TopFuncBg, "Edit_Search")
  ui._btn_search = UI.getChildControl(ui._edit_search, "Button_Search")
  ui._edit_search:RegistAllKeyEvent("PaGlobal_SkillGroup:HandleEventLUp_SearchText()")
  ui._edit_search:addInputEvent("Mouse_LDown", "PaGlobal_SkillGroup:HandleEventLUp_SearchText()")
  ui._edit_search:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SearchText()")
  ui._edit_search:RegistReturnKeyEvent("PaGlobal_SkillGroup:HandleEventLUp_SearchButton()")
  ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_SearchButton()")
  ui._btn_search:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOn_SearchButtonOn()")
  ui._btn_search:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:HandleMOut_SearchButtonOut()")
  if true == _ContentsGroup_SkillPreset then
    self._skillPreset.stc_presetBG = UI.getChildControl(Panel_Window_SkillGroup, "Static_PresetBG")
    self._skillPreset.stc_selectTab = UI.getChildControl(self._skillPreset.stc_presetBG, "Static_SelectTab")
    self._presetSlotMaxCount = ToClient_getSkillPresetSlotMaxCount()
    for index = 0, self._presetSlotMaxCount - 1 do
      self._skillPreset.btn_preset[index] = UI.getChildControl(self._skillPreset.stc_presetBG, "RadioButton_Preset" .. tostring(index + 1))
      self._skillPreset.btn_preset[index]:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_applyConfirmSkillPreset(" .. tostring(index) .. ")")
      self._skillPreset.btn_preset[index]:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_SkillPresetToolTipShow(" .. index .. ")")
      self._skillPreset.btn_preset[index]:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_SkillPresetToolTipHide()")
      self._skillPreset.btn_preset[index]:SetShow(true)
      self._skillPreset.btn_presetLock[index] = UI.getChildControl(self._skillPreset.stc_presetBG, "Button_Lock" .. tostring(index + 1))
      self._skillPreset.btn_presetLock[index]:SetShow(false)
      self._skillPreset.btn_presetLock[index]:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_lockPresetBuy()")
      self._skillPreset.btn_presetLock[index]:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_SkillPresetLockToolTip(true, " .. index .. ")")
      self._skillPreset.btn_presetLock[index]:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_SkillPresetLockToolTip(false)")
    end
    self._skillPreset.btn_presetSave = UI.getChildControl(self._skillPreset.stc_presetBG, "Button_PresetSave")
    self._skillPreset.btn_presetSave:addInputEvent("Mouse_LUp", "HandleMLUp_SkillWindow_SkillPresetSaveOpen()")
    self._skillPreset.btn_presetSave:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_SkillPresetToolTipShow(" .. self._presetSlotMaxCount .. ")")
    self._skillPreset.btn_presetSave:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_SkillPresetToolTipHide()")
    self._skillPreset.btn_presetSave:SetShow(true)
    self._skillPreset.stc_selectTab:SetShow(false)
    self._skillPreset.bg_PosY = self._skillPreset.stc_presetBG:GetPosY()
    self._skillPreset.bg_PosX = self._skillPreset.stc_presetBG:GetPosX()
    self._skillPreset.bg_SizeY = self._skillPreset.stc_selectTab:GetSizeY()
    self._skillPreset.btnSizeY = self._skillPreset.btn_preset[0]:GetSizeY()
    self._skillPreset.intervalSizeY = (self._skillPreset.stc_selectTab:GetSizeY() - self._skillPreset.btnSizeY) / 2
    self._skillPreset.startPosY = self._skillPreset.stc_presetBG:GetPosY() - self._skillPreset.stc_presetBG:GetSizeY() * self._presetSlotMaxCount + self._skillPreset.stc_selectTab:GetSizeY() / 2
    self._skillPreset.bg_SizeY = self._skillPreset.stc_selectTab:GetSizeY() * (self._presetSlotMaxCount + 1)
    self._skillPreset.btnPosX = self._skillPreset.stc_selectTab:GetPosX() + self._skillPreset.stc_selectTab:GetSizeX() / 2 - self._skillPreset.btn_preset[0]:GetSizeX() / 2
  else
    self._skillPreset.stc_presetBG:SetShow(false)
  end
end
function PaGlobal_SkillGroup:open()
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    return
  end
  if true == isMoviePlayMode() then
    return false
  end
  if true == isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLOPENALERT_INDEAD"))
  end
  if true == ToClient_getJoinGuildBattle() then
  end
  ToClient_SaveUiInfo(false)
  if true == ToClient_LearnSkillCameraIsShow() then
  end
  if false == ToClient_LearnSkillCameraIsShowable() then
  end
  if false == IsSelfPlayerWaitAction() then
  end
  if true == ToClient_SniperGame_IsPlaying() then
    return false
  end
  if true == MessageBoxGetShow() then
    allClearMessageData()
  end
  if nil ~= Panel_Stamina then
    self._isShowStaminaPanel = Panel_Stamina:GetShow()
  end
  if nil ~= Panel_IngameCashShop_EasyPayment and true == Panel_IngameCashShop_EasyPayment:GetShow() then
    PaGlobal_EasyBuy:Close()
  end
  self:checkIsViewTreeTabIcon()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local classType = selfPlayerWrapper:getClassType()
  local viewTabCount = 4
  if __eClassType_RangerMan == classType or __eClassType_ShyWaman == classType then
    if __eClassType_ShyWaman == classType then
      self._tab[2]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_TALENT"))
    end
    self._tab[1]:SetShow(false)
    viewTabCount = viewTabCount - 1
  elseif true == _ContentsGroup_SkillSubGroup then
    self._tab[1]:SetShow(false)
    viewTabCount = viewTabCount - 1
  else
    self._tab[1]:SetShow(true)
  end
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  if false == isLearnFusionSkill then
    viewTabCount = viewTabCount - 1
    self._tab[3]:SetShow(false)
  else
    self:UpdateDeepeningSkillTopSlot()
    self:updateDeepeningControl()
    self._tab[3]:SetShow(true)
  end
  local jj = 0
  for ii = 0, #self._tab do
    if self._tab[ii]:GetShow() then
      self._tab[ii]:SetSize(self._ui._rdo_groupBg:GetSizeX() / viewTabCount, self._tab[ii]:GetSizeY())
      self._tab[ii]:SetPosX(self._ui._rdo_groupBg:GetSizeX() / viewTabCount * jj)
      self._tab[ii]:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:selectTab(" .. ii .. ")")
      jj = jj + 1
    end
  end
  local awakenRoot = ToClient_getAwakenRootSkillGroupNo(classType)
  local isLearnedAwakenSkill = false
  if 0 ~= awakenRoot then
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
    local skillNo = skillKey:getSkillNo()
    local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
    isLearnedAwakenSkill = ToClient_isLearnedSkill(skillNo)
    if nil ~= skillTypeSSW and false == skillTypeSSW:isValidLocalizing() then
      self._tab[self.eTabIndex.awaken]:addInputEvent("Mouse_LUp", "")
    end
  end
  self._isWindow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSkillGroupWindowViewPlayPanel)
  local cacheValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree)
  local playerType = ToClient_GetCurrentPlayerSkillType()
  if 0 == cacheValue then
    self._selectedTree = playerType
  elseif 0 == playerType and 2 == cacheValue then
    self._selectedTree = cacheValue - 1
  else
    self._selectedTree = playerType
  end
  if true == isLearnedAwakenSkill then
    local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
    local isLearnedSuccessionSkill = false
    if 0 ~= successionRoot then
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
      local skillNo = 0
      if nil ~= skillKey then
        skillNo = skillKey:getSkillNo()
      end
      local skillSSW = getSkillStaticStatus(skillNo, 1)
      local needSkill
      if nil ~= skillSSW then
        needSkill = skillSSW:getAllPreRequiredSkillNoList()
      end
      local needSkillNo = 0
      if nil ~= needSkill then
        needSkillNo = needSkill[0]:getSkillNo()
      end
      isLearnedSuccessionSkill = ToClient_isLearnedSkill(needSkillNo)
      if false == isLearnedSuccessionSkill then
        self._selectedTree = __eSkillTypeParam_Awaken
      end
    end
  end
  self:reset()
  self:resetSlot()
  self:update()
  if true == _ContentsGroup_SkillPreset then
    PaGlobal_SkillGroup:skillpresetSetPosition()
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Control_All:hide()
    PaGlobal_Tooltip_Item_LinkedItem_All:prepareClose()
    PaGlobal_Tooltip_Item_LinkedClickItem_All:prepareClose()
  else
    Panel_Tooltip_Item_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  PaGlobal_SkillGroup_CoolTimeSlot:close()
  self._ui._txt_playShow:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_playShow:SetText(self._ui._txt_playShow:GetText())
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_SKILLGROUP_WINDOW")
  if true == self._isDialog then
    self._ui._stc_playShow:SetIgnore(true)
    self._ui._stc_playShow:SetMonoTone(true)
    self._ui._stc_playShow:addInputEvent("Mouse_LUp", "")
    self._ui._stc_playShow:addInputEvent("Mouse_On", "")
    self._ui._stc_playShow:addInputEvent("Mouse_Out", "")
    PaGlobal_SkillGroup:updateViewController(false, true)
    Panel_Window_SkillGroup:SetShow(true)
  else
    self._ui._stc_playShow:SetIgnore(false)
    self._ui._stc_playShow:SetMonoTone(false)
    self._ui._stc_playShow:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:viewControllerToggle()")
    self._ui._stc_playShow:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:HandleMOn_ControllerToggleButtonOn()")
    self._ui._stc_playShow:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:HandleMOut_ControllerToggleButtonOut()")
    PaGlobal_SkillGroup:updateViewController(self._isWindow, false)
    Panel_Window_SkillGroup:SetShow(true, self._isWindow)
  end
  SkillGroup_Resize()
  self._ui._stc_playShow:SetCheck(not self._isWindow)
  self:selectTab()
  self:selectTree(-1)
end
function PaGlobal_SkillGroup:resetTree()
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  self._selectedTree = playerSkillType
end
function PaGlobal_SkillGroup:close()
  if false == Panel_Window_SkillGroup:GetShow() then
    return
  end
  if true == ToClient_LearnSkillCameraIsShow() and false == ToClient_LearnSkillCameraHide() then
    return
  end
  PaGlobal_SkillGroup:updateEditMode(false)
  self:hideDeepeingSkillSlot()
  Panel_Window_SkillGroup:SetShow(false, not self._isDialog and self._isWindow)
  if true == Panel_Window_SkillGroup_Controller:GetShow() then
    PaGlobal_SkillGroup_Controller:close()
  end
  if true == Panel_Window_SkillGroup_SelectType:GetShow() then
    PaGlobalFunc_SkillGroup_SelectType_Close()
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  PaGlobal_SkillGroup_QuickSlot:close()
  PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  PaGlobal_SkillGroup_CoolTimeSlot:close()
  FGlobal_WebHelper_ForceClose()
  if nil ~= self._focusEffect then
    self._focusEffect:EraseAllEffect()
    self._focusEffect = nil
  end
  self:updateEditMode(false)
  if true == self._isDialog then
    if false == _ContentsGroup_NewUI_Dialog_All then
      PaGlobalFunc_MainDialog_ReOpen()
    else
      PaGlobalFunc_DialogMain_All_SetRenderMode()
      PaGlobalFunc_DialogMain_All_ShowToggle(true)
      HandleEventLUp_DialogMain_All_BackClick()
    end
    self._isDialog = false
  end
  if true == self._isShowStaminaPanel and nil ~= Stamina_Update then
    Stamina_Update()
  end
  if true == _ContentsGroup_SkillPreset then
    for index = 0, self._presetSlotMaxCount - 1 do
      self._skillPreset.btn_preset[index]:SetShow(false)
      self._skillPreset.btn_presetLock[index]:SetShow(false)
    end
    self._skillPreset.stc_presetBG:SetShow(false)
    self._skillPreset.btn_presetSave:SetShow(false)
    PaGlobal_SkillPreset_Close()
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
end
function PaGlobal_SkillGroup:reset()
  for ii = 0, #self._frame do
    self._frameScroll[ii]:SetControlTop()
    self._frame[ii]:UpdateContentPos()
  end
  self._deepeningSkill.frameScroll:SetControlTop()
  self._deepeningSkill.frame:UpdateContentPos()
  for ii = 0, self._subGroupSize - 1 do
    if nil ~= self._subGroupButton[ii] then
      self._subGroupButton[ii]:SetCheck(true)
      self._subSkillGroupTabState[ii] = true
    end
  end
  self:selectTab()
  self._mouseOnSkillGroupNo = -1
  self._selectSkillNo = 0
  self._selectKey = 0
  self._isEditMode = false
  self._ui._edit_search:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_EDIT_SEARCH"), false)
  self._ui._btn_modify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PLAYSKILL_QUICKSLOT_SET"))
  self._filterText = nil
  self._filterIndex = -1
end
function PaGlobal_SkillGroup:updateEditMode(isEditMode)
  self._isEditMode = isEditMode
  local ui = self._ui
  if true == self._isEditMode then
    PaGlobal_SkillGroup_QuickSlot:prepareOpen()
    ui._btn_modify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PLAYSKILL_RETURNSKILL"))
    ui._btn_lockSpirit:SetIgnore(false)
    ui._btn_lockSpirit:SetMonoTone(false)
    ui._btn_cooltimeSet:SetIgnore(false)
    ui._btn_cooltimeSet:SetMonoTone(false)
  else
    DragManager:clearInfo()
    PaGlobal_SkillGroup_QuickSlot:prepareClose()
    ui._btn_modify:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PLAYSKILL_QUICKSLOT_SET"))
    ui._btn_modify:SetCheck(false)
  end
  if true == Panel_Window_SkillGroup_Controller:GetShow() then
    PaGlobal_SkillGroup_Controller:updateEditMode(self._isEditMode)
  end
  self:update()
end
function PaGlobal_SkillGroup:update()
  PaGlobal_SkillGroup:updateStat()
  PaGlobal_SkillGroup:updateSlot()
  PaGlobal_SkillGroup:updateDeepeningSkill()
  PaGlobal_SkillGroup:updateFrameControls()
  Panel_SkillTooltip_Hide()
end
function PaGlobal_SkillGroup:updateSlot()
  if nil == self._skillGroupList then
    return
  end
  for key, skillGroup in pairs(self._skillGroupList) do
    skillGroup:selectLevel(skillGroup._selectLevel)
  end
end
function PaGlobal_SkillGroup:resetSlot()
  if nil == self._skillGroupList then
    return
  end
  for key, skillGroup in pairs(self._skillGroupList) do
    local currentGroupLevel = skillGroup:getCurrentGroupLevel()
    skillGroup:selectLevel(currentGroupLevel)
  end
end
function PaGlobal_SkillGroup:updateStat()
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if nil == skillPointInfo then
    return
  end
  self._remainSkillPoint = skillPointInfo._remainPoint
  local skillPoint = tostring("<PAColor0xfff5ba3a>" .. skillPointInfo._remainPoint) .. " / " .. tostring(skillPointInfo._acquirePoint .. "<PAOldColor>")
  self._ui._txt_skillPoint:SetText(skillPoint)
end
function PaGlobal_SkillGroup:clearRecentSkill()
  for ii = 0, self._recentSkill.maxCount - 1 do
    self._recentSkill.step[ii]:SetShow(false)
    if 0 < ii then
      self._recentSkill.arrow[ii]:SetShow(false)
    end
    self._recentSkill.key[ii] = nil
  end
  self._recentSkill.noSelectSkill:SetShow(true)
  self._recentSkill.currentCount = 0
end
function PaGlobal_SkillGroup:createFrameControls()
  if true == self._isLoading then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  for ii = 0, #self._frame do
    local tableWrapper = ToClient_getSkillGroupCellTableWrapper(ii, selfPlayerWrapper:getClassType())
    if nil ~= tableWrapper then
      self:createSkillGroupControls(tableWrapper, self._frame[ii]:GetFrameContent(), ii)
      self._frame[ii]:UpdateContentScroll()
      UIScroll.SetButtonSize(self._frameScroll[ii], self._frame[ii]:GetSizeY(), self._frame[ii]:GetFrameContent():GetSizeY())
    else
    end
  end
  if true == _ContentsGroup_skillOldandNew then
    self:createDeepeningSkillControls()
  end
  self._isLoading = true
end
function PaGlobal_SkillGroup:createSkillGroupControls(tableWrapper, parent, tab)
  if nil == table or nil == parent then
    return
  end
  local colMaxCount = tableWrapper:sizeX()
  local rowMaxCount = tableWrapper:sizeY()
  local subGroupSize = tableWrapper:getSubGroupSize()
  if self.eTabIndex.weapon == tab then
    self._subGroupSize = subGroupSize
    self:createSubGroup()
  end
  for index = 0, subGroupSize - 1 do
    local strKey = PAGetString(Defines.StringSheet_GAME, tableWrapper:getAtSubGroupStringKey(index))
    self._subGroupList[index] = {_name = strKey, _use = true}
  end
  for row = 0, rowMaxCount - 1 do
    for col = 0, colMaxCount - 1 do
      cellWrapper = tableWrapper:atWrapper(col, row)
      if nil ~= cellWrapper and true == cellWrapper:isDefined() then
        local key = cellWrapper:getSkillGroupNo()
        local cellType = cellWrapper:getType(0)
        if __eSkillGroupCellType_SkillGroup ~= cellType then
          self:createCell(parent, key, cellType, row, col, tab, cellWrapper)
        end
      end
    end
  end
  for row = 0, rowMaxCount - 1 do
    for col = 0, colMaxCount - 1 do
      cellWrapper = tableWrapper:atWrapper(col, row)
      if nil ~= cellWrapper and true == cellWrapper:isDefined() then
        local key = cellWrapper:getSkillGroupNo()
        local cellType = cellWrapper:getType(0)
        if __eSkillGroupCellType_SkillGroup == cellType then
          self:createCell(parent, key, cellType, row, col, tab, cellWrapper)
        end
      end
    end
  end
end
function PaGlobal_SkillGroup:offIndex(index)
  self._subGroupList[index]._use = false
end
function PaGlobal_SkillGroup:onIndex(index)
  self._subGroupList[index]._use = true
end
function PaGlobal_SkillGroup:getSubGroupName(index)
  return self._subGroupList[index]._name
end
function PaGlobal_SkillGroup:getSubGroupCheck(index)
  return self._subGroupList[index]._use
end
function PaGlobal_SkillGroup:setHideTree(value)
  self._hideDontUseTree = value
end
function PaGlobal_SkillGroup:GetBottomPosY(control)
  UI.ASSERT(nil ~= control, "PaGlobal_SkillGroup:GetBottomPosY() control \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  return control:GetPosY() + control:GetSizeY()
end
function PaGlobal_SkillGroup:updateFrameControls()
  if false == self._isLoading then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local tableWrapper = ToClient_getSkillGroupCellTableWrapper(self._currentTab, selfPlayerWrapper:getClassType())
  if nil ~= tableWrapper then
    self:updateSkillGroupControls(tableWrapper, self._frame[self._currentTab]:GetFrameContent())
    if 1 <= self._frame[self._currentTab]:GetVScroll():GetControlPos() then
      self._frame[self._currentTab]:GetVScroll():SetControlBottom()
      self._frame[self._currentTab]:UpdateContentPos()
    end
    self._frame[self._currentTab]:UpdateContentScroll()
    UIScroll.SetButtonSize(self._frameScroll[self._currentTab], self._frame[self._currentTab]:GetSizeY(), self._frame[self._currentTab]:GetFrameContent():GetSizeY())
  end
end
function PaGlobal_SkillGroup:getShowLineTypeIndex(cellWrapper)
  local cellType = cellWrapper:getType(0)
  if __eSkillGroupCellType_SkillGroup ~= cellType then
    local typeSize = cellWrapper:getTypeSize()
    local returnValue = 0
    if typeSize == 1 then
      return 0
    end
    if true == self._hideDontUseTree and __eSkillTypeParam_Awaken == self._selectedTree then
      return 1
    end
    if false == PaGlobal_SuccessionSkill_IsCheckOpenContents() then
      returnValue = returnValue + 1
    end
    if false == PaGlobal_JinSkill_IsCheckOpenContents() then
      if typeSize == 2 then
        return 1
      end
      returnValue = returnValue + 1
    end
    return returnValue
  else
    if false == self._hideDontUseTree then
      return 0
    end
    local key = cellWrapper:getSkillGroupNo()
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, 1)
    if false == skillKey:isDefined() then
      return -1
    end
    local skillNo = skillKey:getSkillNo()
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    local skillBranchType = skillSSW:getSkillAwakenBranchType()
    if currentPlayerSkillType == __eSkillTypeParam_Normal or skillBranchType == __eSkillTypeParam_Normal or currentPlayerSkillType == skillBranchType then
      return 0
    end
  end
  return -1
end
function PaGlobal_SkillGroup:updateSkillGroupControls(tableWrapper, parent)
  if nil == table or nil == parent then
    return
  end
  local colMaxCount = tableWrapper:sizeX()
  local rowMaxCount = tableWrapper:sizeY()
  local posX = 0
  local posY = 10
  local beforsubGroupNo = -1
  local isSubGroupFirstLine = false
  local beforHaveSkillLine = 0
  for row = 0, rowMaxCount - 1 do
    local showThisLine = false
    local thisLineHaveSkill = false
    for col = 0, colMaxCount - 1 do
      cellWrapper = tableWrapper:atWrapper(col, row)
      if nil ~= cellWrapper and true == cellWrapper:isDefined() then
        local showTypeIndex = PaGlobal_SkillGroup:getShowLineTypeIndex(cellWrapper)
        local key = cellWrapper:getSkillGroupNo()
        local cellTypeSize = cellWrapper:getTypeSize()
        local cellType = cellWrapper:getType(0)
        local subGroupNo = cellWrapper:getSubGroupNo()
        if nil == subGroupNo then
          break
        end
        if self.eTabIndex.weapon == self._currentTab then
          if beforsubGroupNo ~= subGroupNo then
            beforsubGroupNo = subGroupNo
            isSubGroupFirstLine = true
          end
          if true == isSubGroupFirstLine then
            self:updateSubGroup(subGroupNo, posY)
            posY = posY + 50
          end
          if 0 == row and 0 == col and true == self._isOpenedSubGroup[0] then
            posY = posY - 80
          else
          end
        end
        if 0 == row and 0 == col and self.eTabIndex.awaken == self._currentTab then
          posY = posY - 80
        end
        local cellShow = true
        if self.eTabIndex.weapon == self._currentTab then
          cellShow = self._isOpenedSubGroup[subGroupNo]
        end
        if __eSkillGroupCellType_SkillGroup ~= cellType then
          key = tostring(self._currentTab) .. ":" .. tostring(col) .. "," .. tostring(row)
          for ii = 0, cellTypeSize - 1 do
            cellShow = 0 <= showTypeIndex
            if self.eTabIndex.weapon == self._currentTab and cellShow then
              cellShow = self._isOpenedSubGroup[subGroupNo]
            end
            if ii ~= showTypeIndex then
              cellShow = false
            end
            if nil ~= self._skillLineList[key] then
              if nil ~= self._skillLineList[key][ii] then
                self._skillLineList[key][ii]:SetShow(cellShow)
                self._skillLineList[key][ii]:SetPosY(posY)
              end
              if nil ~= self._addSkillLineList[key] and nil ~= self._addSkillLineList[key][ii] then
                self._addSkillLineList[key][ii]:SetShow(cellShow)
                self._addSkillLineList[key][ii]:SetPosY(posY - 5)
              end
            end
          end
          if __eSkillGroupCellType_Hori ~= cellType then
            if 1 < beforHaveSkillLine then
              cellShow = false
            end
          else
            thisLineHaveSkill = true
          end
        end
        if __eSkillGroupCellType_SkillGroup == cellType then
          local cellShow = true
          if self.eTabIndex.weapon == self._currentTab then
            cellShow = self._isOpenedSubGroup[subGroupNo]
          end
          cellShow = cellShow and 0 == showTypeIndex
          local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, 1)
          if false == skillKey:isDefined() then
            return false
          end
          local skillNo = skillKey:getSkillNo()
          local skillSSW = getSkillStaticStatus(skillNo, 1)
          local skillBranchType = skillSSW:getSkillAwakenBranchType()
          cellShow = cellShow and self._skillGroupList[key]._isValidLocalizing
          self._skillGroupList[key]:SetShow(cellShow)
          self._skillGroupList[key]:SetPosY(posY)
          thisLineHaveSkill = thisLineHaveSkill or cellShow
        end
        showThisLine = showThisLine or cellShow
        isSubGroupFirstLine = false
      end
    end
    if true == showThisLine then
      posY = posY + 40
    end
    if true == thisLineHaveSkill then
      beforHaveSkillLine = 0
    else
      beforHaveSkillLine = beforHaveSkillLine + 1
    end
    if showThisLine == false then
      for col = 0, colMaxCount - 1 do
        cellWrapper = tableWrapper:atWrapper(col, row)
        if nil ~= cellWrapper and true == cellWrapper:isDefined() then
          local cellTypeSize = cellWrapper:getTypeSize()
          local key = tostring(self._currentTab) .. ":" .. tostring(col) .. "," .. tostring(row)
          for ii = 0, cellTypeSize - 1 do
            if nil ~= self._skillLineList[key] and nil ~= self._skillLineList[key][ii] then
              self._skillLineList[key][ii]:SetShow(false)
            end
            if nil ~= self._addSkillLineList[key] and nil ~= self._addSkillLineList[key][ii] then
              self._addSkillLineList[key][ii]:SetShow(false)
            end
          end
        end
      end
    end
  end
  parent:SetSize(parent:GetSizeX(), posY)
end
function PaGlobal_SkillGroup:createCell(parent, key, cellType, row, col, tab, cellWrapper)
  local gabX = 10
  local posX = col * 125 - 65 * math.floor(col / 3) + gabX
  local posY = row * 40
  if __eSkillGroupCellType_SkillGroup == cellType then
    if nil == self._skillGroupList[key] then
      local subGroupNo = 0
      if nil ~= cellWrapper then
        subGroupNo = cellWrapper:getSubGroupNo()
      end
      local info = SkillGroup.new(key, parent, subGroupNo)
      info:SetPosX(posX)
      info:SetPosY(posY)
      info:SetShow(true)
      self._skillGroupList[key] = info
      if nil == self._filterKeyList[0] then
        self._filterKeyList[#self._filterKeyList] = info
      else
        self._filterKeyList[#self._filterKeyList + 1] = info
      end
    else
      _PA_LOG("\234\185\128\236\167\128\237\152\129", "SkillTree\236\151\144 \236\164\145\235\179\181\235\144\152\235\138\148 SkillGroupNo(" .. tostring(key) .. ") \234\176\128 \236\158\136\236\138\181\235\139\136\235\139\164.")
    end
  else
    if cellType >= __eSkillGroupCellType_LT and cellType <= __eSkillGroupCellType_Vert then
      local cellTypeSize = cellWrapper:getTypeSize()
      key = tostring(tab) .. ":" .. tostring(col) .. "," .. tostring(row)
      self._skillLineList[key] = {}
      self._addSkillLineList[key] = {}
      for ii = 0, cellTypeSize - 1 do
        cellType = cellWrapper:getType(ii)
        if cellType == __eSkillGroupCellType_Blank then
          break
        end
        local control
        local lineType = "A"
        if 2 == col % 3 then
          control = self._baseLineControl[1][cellType - 2]
        else
          lineType = "C"
          control = self._baseLineControl[2][cellType - 2]
        end
        UI.ASSERT(nil ~= control, "PaGlobal_SkillGroup:createCell() LineControl \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
        self._skillLineList[key][ii] = UI.cloneControl(control, parent, "Line_" .. tostring(ii) .. lineType .. "_" .. posX .. "_" .. posY)
        self._skillLineList[key][ii]:SetPosX(posX)
        self._skillLineList[key][ii]:SetPosY(posY)
        self._skillLineList[key][ii]:SetShow(true)
        if __eSkillGroupCellType_LM == cellType or __eSkillGroupCellType_CM == cellType or __eSkillGroupCellType_RM == cellType or __eSkillGroupCellType_LB == cellType or __eSkillGroupCellType_CB == cellType or __eSkillGroupCellType_RB == cellType or __eSkillGroupCellType_Vert == cellType then
          local addControl
          if 2 == col % 3 then
            addControl = self._baseLineControl[1][11]
          else
            addControl = self._baseLineControl[2][11]
          end
          self._addSkillLineList[key][ii] = UI.cloneControl(addControl, parent, "AddLine_" .. ii .. lineType .. "_" .. posX .. "_" .. posY - 10)
          self._addSkillLineList[key][ii]:SetPosX(posX)
          self._addSkillLineList[key][ii]:SetPosY(posY - 5)
          self._addSkillLineList[key][ii]:SetShow(true)
        end
      end
    else
    end
  end
end
function PaGlobal_SkillGroup:selectTab(index)
  PaGlobal_SkillGroup:DragClear()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if nil ~= self._focusEffect then
    self._focusEffect:EraseAllEffect()
  end
  if true == self._isEditMode then
    self:updateEditMode(false)
  end
  if nil == index then
    index = self._currentTab
  end
  local isFusion = index == self.eTabIndex.deepening
  self._ui._stc_bottomArea:SetShow(true)
  local tab = self._tab[index]
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  self._deepeningSkill.area:SetShow(isFusion and isLearnFusionSkill)
  if false == isFusion then
    for ii = 0, #self._frame do
      local isShow = ii == index
      self._frame[ii]:SetShow(isShow)
    end
    self._deepeningSkill.area:SetShow(false)
    self._deepeningSkill.frame:SetShow(false)
  else
    for ii = 0, #self._frame do
      self._frame[ii]:SetShow(false)
    end
    self._deepeningSkill.area:SetShow(true)
    self._deepeningSkill.frame:SetShow(true)
    PaGlobal_SkillGroup:HandleEventLUp_DeepeningSkillSlotClick()
  end
  for ii = 0, #self._tab do
    self._tab[ii]:SetCheck(index == ii)
  end
  self._ui._selectLine:SetPosX(tab:GetPosX() + (tab:GetSizeX() - self._ui._selectLine:GetSizeX()) / 2)
  self._ui._selectLine:SetPosY(tab:GetPosY() + tab:GetSizeY())
  self._currentTab = index
  PaGlobal_SkillGroup:updateFrameControls()
end
function PaGlobal_SkillGroup:getSkillGroupBySkillGroupNo(key)
  return self._skillGroupList[key]
end
function PaGlobal_SkillGroup:selectNextTab(index)
  if nil == index then
    index = self._currentTab + 1
  end
  if index > #self._tab then
    index = index - self.eTabIndex.count
  end
  if false == self._tab[index]:GetShow() then
    PaGlobal_SkillGroup:selectNextTab(index + 1)
  else
    PaGlobal_SkillGroup:selectTab(index)
  end
end
function PaGlobal_SkillGroup:selectPrevTab(index)
  if nil == index then
    index = self._currentTab - 1
  end
  if index < 0 then
    index = index + self.eTabIndex.count
  end
  if false == self._tab[index]:GetShow() then
    PaGlobal_SkillGroup:selectPrevTab(index - 1)
  else
    PaGlobal_SkillGroup:selectTab(index)
  end
end
function PaGlobal_SkillGroup:setDialog(isDialog)
  if nil == isDialog then
    self._isDialog = false
  else
    self._isDialog = isDialog
  end
end
function PaGlobal_SkillGroup:learnSkill(skillNo)
  UI.ASSERT(nil ~= skillNo, "PaGlobal_SkillGroup:learnSkill - skillNo\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
  if false == Panel_Window_SkillGroup:GetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  local currentSkillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  local currentSkillNo = currentSkillKey:getSkillNo()
  if true == currentSkillKey:isDefined() and skillNo == currentSkillNo and self._tree[1] ~= nil and self._tree[1]._panel ~= nil then
    self._tree[1]._panel:AddEffect("fUI_NewSkill_AroUp_Bookmark_01A", false, 0, 0)
    self:selectTree(-1)
    return
  end
  if nil ~= self._mouseOnSkillGroupNo then
    if -1 ~= self._mouseOnSkillGroupNo or self.eTabIndex.deepening ~= self._currentTab then
      audioPostEvent_SystemUi(27, 1)
      self:update()
    else
      self._deepeningSkill._resultSlot[self._selectedDeepeningSlotNo][self._selectedDeepeningSkillIndex].icon:AddEffect("fUI_NewSkill_Intensive_Succes_Slot_01A", false, 0, 0)
      self._deepeningSkill._stc_topArea._stc_skillIcon[self._selectedDeepeningSlotNo].icon:AddEffect("fUI_NewSkill_Intensive_Succes_Slot_02A", false, 0, 0)
    end
  end
  PaGlobal_SkillGroup:ShowLearnableSkill(skillNo, true)
end
function PaGlobal_SkillGroup:learnSkill_UpdatePerFrame_For_Effect(deltaTime)
  if nil == PaGlobal_SkillGroup then
    return
  end
  local self = PaGlobal_SkillGroup
  self._deepeningSkillEffectTime = self._deepeningSkillEffectTime + deltaTime
  if self._deepeningSkillEffectTime > 2 and self._deepenigSkillAddedEffect == true then
    ToClient_requestLearnFusionSkill(self._resultSkillNo, self._mainSkillNo, self._subSkillNo)
    self._deepeningSkillEffectTime = 0
    self._deepenigSkillAddedEffect = false
    self:update()
    self._panel:ClearUpdateLuaFunc()
  end
end
function PaGlobal_SkillGroup:ShowLearnableSkill(skillNo, isLearnSkill)
  PaGlobal_SkillGroup_QuickSlot:update()
  local skillGroup
  if nil == skillNo then
    skillGroup = self._skillGroupList[self._mouseOnSkillGroupNo]
  else
    local needSkill = getSkillStaticStatus(skillNo, 1)
    if nil ~= needSkill then
      skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
    else
      return
    end
  end
  if nil ~= skillGroup then
    self:ShowGroupLearnLastSkillByGroup(skillGroup, isLearnSkill)
  end
end
function PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroupKey(skillGroupKey, isLearnSkill)
  UI.ASSERT(nil ~= self._skillGroupList, "PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroupKey() self._skillGroupList\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
  local skillGroup = self._skillGroupList[skillGroupKey]
  if nil ~= skillGroup then
    PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroup(skillGroup, isLearnSkill)
  end
  PaGlobal_SkillGroup_QuickSlot:update()
end
function PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroup(skillGroup, isLearnSkill)
  if nil ~= skillGroup then
    local currentGroupLevel = skillGroup:getCurrentGroupLevel()
    local currentSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, currentGroupLevel)
    local currentSkillNo = currentSkillKey:getSkillNo()
    local skillInfo = getSkillLevelInfo(currentSkillNo)
    if true ~= isLearnSkill then
      PaGloabl_SkillGroup_ShowDesc(currentSkillNo)
    end
    skillGroup:selectLevel(currentGroupLevel, isLearnSkill)
  else
    UI.ASSERT(nil ~= skillGroup, "PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroup() skillGroup\236\157\180 nil\236\158\133\235\139\136\235\139\164.")
  end
end
function PaGlobal_SkillGroup:SkillWindow_PlayerLearnableSkill()
  for key, skillGroup in pairs(self._skillGroupList) do
    for level = 1, skillGroup._maxLevel do
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, level)
      local skillNo = skillKey:getSkillNo()
      local skillSS = getSkillStaticStatus(skillNo, 1)
      if nil ~= skillSS then
        local skillType = skillSS:getSkillAwakenBranchType()
        if PaGlobal_SkillGroup.eTabIndex.weapon == skillType then
          local skillLevelInfo = getSkillLevelInfo(skillNo)
          if nil ~= skillLevelInfo then
            if skillLevelInfo._learnable and false == skillLevelInfo._isLearnByQuest then
              return true
            end
          else
            return false
          end
        end
      end
    end
  end
  return false
end
function PaGlobal_SkillGroup:isEnableDeepeningSkill()
  if nil == self._deepeningSkill.area then
    return false
  end
  return ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
end
function PaGlobal_SkillGroup:createDeepeningSkillControls()
  if nil == self._deepeningSkill.area then
    return
  end
  local area = self._deepeningSkill.area
  local frame = self._deepeningSkill.frame
  local deepeningSkill = self._deepeningSkill
  deepeningSkill._stc_topArea = UI.getChildControl(area, "Static_SkillTopArea")
  self:initDeepeningSkillCellControl(deepeningSkill._stc_topArea)
  local stc_deepSkillTemp = UI.getChildControl(area, "Static_DeepSkill1")
  stc_deepSkillTemp:SetShow(false)
  deepeningSkill._deepSkillForm = {}
  deepeningSkill._mainSlot = {}
  deepeningSkill._subSlot = {}
  deepeningSkill._resultSlot = {}
  deepeningSkill._btn_learnDeepeningSkill = {}
  deepeningSkill._mainSkillName = {}
  deepeningSkill._subSkillName = {}
  deepeningSkill._resultSkillName = {}
  deepeningSkill._maxCount = {}
  deepeningSkill._result_CC = {}
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    deepeningSkill._deepSkillForm[ii] = {}
    deepeningSkill._mainSlot[ii] = {}
    deepeningSkill._subSlot[ii] = {}
    deepeningSkill._resultSlot[ii] = {}
    deepeningSkill._btn_learnDeepeningSkill[ii] = {}
    deepeningSkill._mainSkillName[ii] = {}
    deepeningSkill._subSkillName[ii] = {}
    deepeningSkill._resultSkillName[ii] = {}
    deepeningSkill._result_CC[ii] = {}
  end
  self:createDeepeningControl(stc_deepSkillTemp)
  local skillSlotTemp = UI.getChildControl(deepeningSkill._stc_topArea, "Static_SkillSlot_Temp")
  skillSlotTemp:SetShow(false)
end
function PaGlobal_SkillGroup:createDeepeningSkillSlot(skillSlotArea, skillSlotBg, skillNo, slotNo, index)
  UI.ASSERT(nil ~= skillSlotBg, "PaGlobal_SkillGroup:createDeepeningSkillSlot() skillSlotBg \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  UI.ASSERT(nil ~= skillNo, "PaGlobal_SkillGroup:createDeepeningSkillSlot() skillNo\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
  local slot = {}
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillTypeStaticWrapper then
    if skillTypeStaticWrapper:isValidLocalizing() then
      local skillTypeStatic = skillTypeStaticWrapper:get()
      local slot = SlotSkill.new(slot, skillNo, skillSlotBg, self._slotConfig)
      slot.icon:SetPosX(slot.icon:GetPosX() + 1)
      if nil ~= slot.icon then
        slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SkillBox\")")
        slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
      end
      slot.areaPanel = skillSlotArea
      slot:setSkillTypeStatic(skillTypeStaticWrapper)
    end
  else
    _PA_ASSERT("\236\138\164\237\130\172\237\138\184\235\166\172", "skillTypeStaticStatus \235\167\164\235\139\136\236\160\184\236\151\144 \236\151\134\235\138\148 \236\138\164\237\130\172\236\157\180 \236\158\136\236\138\181\235\139\136\235\139\164. : " .. tostring(skillNo))
  end
  return slot
end
function PaGlobal_SkillGroup:initDeepeningSkillCellControl(parent)
  if nil == self._deepeningSkill.area then
    return
  end
  parent._stc_skillSlotBg = {}
  parent._stc_skillIcon = {}
  parent._btn_plus = {}
  local skillSlotTemp = UI.getChildControl(parent, "Static_SkillSlot_Temp")
  self._maxDeepeningSkillCount = 0
  local index = 0
  local skillNo = ToClient_getFusionSkillNo(index, 0)
  while 0 ~= skillNo do
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if nil ~= skillTypeStaticWrapper and true == skillTypeStaticWrapper:isValidLocalizing() then
      parent._stc_skillSlotBg[index] = UI.cloneControl(skillSlotTemp, parent, "Static_SkillGroupSlotBg_" .. tostring(index))
      parent._stc_skillSlotBg[index]:SetShow(true)
      parent._btn_plus[index] = UI.getChildControl(parent._stc_skillSlotBg[index], "Button_Learnable")
      local iconBg = UI.getChildControl(parent._stc_skillSlotBg[index], "Static_Slot")
      self._maxDeepeningSkillCount = index + 1
      self:updateDeepeningSlot(index, parent._stc_skillIcon, iconBg)
      index = self._maxDeepeningSkillCount
    end
    skillNo = ToClient_getFusionSkillNo(index, 0)
  end
  local centerPosX = parent:GetPosX() + parent:GetSizeX() / 2
  local startPosX = 0
  local gapX = 20
  local controlSizeX = skillSlotTemp:GetSizeX()
  startPosX = centerPosX + gapX / 2 - (controlSizeX + gapX) * self._maxDeepeningSkillCount / 2
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    parent._stc_skillSlotBg[ii]:SetPosX(startPosX + (controlSizeX + gapX) * ii)
  end
  local leftDeco = UI.getChildControl(parent, "Static_LeftDeco")
  local rightDeco = UI.getChildControl(parent, "Static_RightDeco")
  if 0 == self._maxDeepeningSkillCount then
    leftDeco:SetShow(false)
    rightDeco:SetShow(false)
    return
  end
  leftDeco:SetPosX(parent._stc_skillSlotBg[0]:GetPosX() - leftDeco:GetSizeX())
  rightDeco:SetPosX(parent._stc_skillSlotBg[self._maxDeepeningSkillCount - 1]:GetPosX() + parent._stc_skillSlotBg[self._maxDeepeningSkillCount - 1]:GetSizeX())
end
function PaGlobal_SkillGroup:UpdateSkillMonoTone(slot, skillNo, isFusionAndLearnNeedAll)
  UI.ASSERT(nil ~= slot, "PaGlobal_SkillGroup:UpdateSkillMonoTone() slot\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  UI.ASSERT(nil ~= skillNo, "PaGlobal_SkillGroup:UpdateSkillMonoTone() skillNo\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return false
  end
  local skillStatic = getSkillStaticStatus(skillNo, 1)
  local lv = skillStatic:get()._needCharacterLevelForLearning
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local playerLevel = selfPlayerWrapper:get():getLevel()
  if false == ToClient_isLearnedSkill(skillNo) then
    if nil ~= isFusionAndLearnNeedAll and true == isFusionAndLearnNeedAll and lv <= playerLevel then
      slot.areaPanel:SetMonoTone(false)
      slot.icon:SetMonoTone(true, true)
      return true
    end
    slot.icon:SetMonoTone(true, true)
    slot.areaPanel:SetMonoTone(true, true)
    return true
  else
    slot.icon:SetMonoTone(false)
    slot.areaPanel:SetMonoTone(false)
    return false
  end
end
function PaGlobal_SkillGroup:createDeepeningControl(control)
  local offsetY = 0
  local framePosY = 0
  local deepeningSkill = self._deepeningSkill
  local frame = self._deepeningSkill.frame
  for slotNo = 0, self._maxDeepeningSkillCount - 1 do
    UI.ASSERT(nil ~= control, "PaGlobal_SkillGroup:createDeepeningControl control \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
    deepeningSkill._maxCount[slotNo] = ToClient_getFusionSkillListCount(slotNo)
    local stc_deepSkill = UI.cloneControl(control, frame:GetFrameContent(), "Static_DeepSkill_" .. tostring(slotNo))
    local stc_mainSkillSlotArea = UI.getChildControl(stc_deepSkill, "Static_MainSlot")
    local stc_mainSkillSlotBg = UI.getChildControl(stc_mainSkillSlotArea, "Static_MainIcon")
    local stc_subSkillSlotAreaOrigin = UI.getChildControl(stc_deepSkill, "Static_SubSlot")
    local stc_subSkillSlotBgOrigin = UI.getChildControl(stc_subSkillSlotAreaOrigin, "Static_MainIcon")
    local rdo_resultSkillSlotAreaOrigin = UI.getChildControl(stc_deepSkill, "RadioButton_ResultSlot")
    local stc_resultSkillSlotBgOrigin = UI.getChildControl(rdo_resultSkillSlotAreaOrigin, "Static_MainIcon")
    local txt_skillLevel = UI.getChildControl(stc_mainSkillSlotArea, "StaticText_Level")
    local posY = stc_subSkillSlotAreaOrigin:GetPosY()
    local isLearnThisSlot = false
    local learnIndex = -1
    stc_subSkillSlotAreaOrigin:SetShow(false)
    rdo_resultSkillSlotAreaOrigin:SetShow(false)
    for jj = 0, deepeningSkill._maxCount[slotNo] - 1 do
      local stc_subSkillSlotArea = UI.cloneControl(stc_subSkillSlotAreaOrigin, stc_deepSkill, "Static_SubSlot_" .. tostring(jj))
      local rdo_resultSkillSlotArea = UI.cloneControl(rdo_resultSkillSlotAreaOrigin, stc_deepSkill, "RadioButton_ResultSlot_" .. tostring(jj))
    end
  end
  self:updateDeepeningControl(true)
end
function PaGlobal_SkillGroup:updateDeepeningControl(isInit)
  local offsetY = 0
  local framePosY = 0
  local deepeningSkill = self._deepeningSkill
  local frame = self._deepeningSkill.frame
  local frameContent = frame:GetFrameContent()
  for slotNo = 0, self._maxDeepeningSkillCount - 1 do
    local stc_deepSkill = UI.getChildControl(frameContent, "Static_DeepSkill_" .. tostring(slotNo))
    local stc_mainSkillSlotArea = UI.getChildControl(stc_deepSkill, "Static_MainSlot")
    local stc_mainSkillSlotBg = UI.getChildControl(stc_mainSkillSlotArea, "Static_MainIcon")
    local stc_subSkillSlotAreaOrigin = UI.getChildControl(stc_deepSkill, "Static_SubSlot")
    local txt_skillLevel = UI.getChildControl(stc_mainSkillSlotArea, "StaticText_Level")
    local posY = stc_subSkillSlotAreaOrigin:GetPosY()
    local isLearnThisSlot = false
    local learnIndex = -1
    for jj = 0, deepeningSkill._maxCount[slotNo] - 1 do
      local stc_subSkillSlotArea = UI.getChildControl(stc_deepSkill, "Static_SubSlot_" .. tostring(jj))
      local stc_subSkillSlotBg = UI.getChildControl(stc_subSkillSlotArea, "Static_MainIcon")
      local rdo_resultSkillSlotArea = UI.getChildControl(stc_deepSkill, "RadioButton_ResultSlot_" .. tostring(jj))
      local stc_resultSkillSlotBg = UI.getChildControl(rdo_resultSkillSlotArea, "Static_MainIcon")
      local mainSkillNo = ToClient_getFusionMainSkillNo(slotNo, jj)
      local subSkillNo = ToClient_getFusionSubSkillNo(slotNo, jj)
      local fusionSkillNo = ToClient_getFusionSkillNo(slotNo, jj)
      stc_subSkillSlotArea:SetShow(true)
      rdo_resultSkillSlotArea:SetShow(true)
      rdo_resultSkillSlotArea:SetResetPressControl(false)
      deepeningSkill._deepSkillForm[slotNo] = stc_deepSkill
      if nil ~= isInit and true == isInit then
        if 0 == jj then
          deepeningSkill._mainSlot[slotNo] = self:createDeepeningSkillSlot(stc_mainSkillSlotArea, stc_mainSkillSlotBg, mainSkillNo, slotNo, 0)
        end
        deepeningSkill._subSlot[slotNo][jj] = self:createDeepeningSkillSlot(stc_subSkillSlotArea, stc_subSkillSlotBg, subSkillNo, slotNo, jj)
        deepeningSkill._resultSlot[slotNo][jj] = self:createDeepeningSkillSlot(rdo_resultSkillSlotArea, stc_resultSkillSlotBg, fusionSkillNo, slotNo, jj)
      end
      local mainLearned = not self:UpdateSkillMonoTone(deepeningSkill._mainSlot[slotNo], mainSkillNo)
      mainLearned = mainLearned and not self:UpdateSkillMonoTone(deepeningSkill._subSlot[slotNo][jj], subSkillNo)
      self:UpdateSkillMonoTone(deepeningSkill._resultSlot[slotNo][jj], fusionSkillNo, mainLearned)
      deepeningSkill._resultSlot[slotNo][jj].stc_learnable = UI.getChildControl(rdo_resultSkillSlotArea, "Static_Icon_Skill_Effect")
      deepeningSkill._resultSlot[slotNo][jj].stc_lock = UI.getChildControl(rdo_resultSkillSlotArea, "Static_Lock")
      deepeningSkill._resultSlot[slotNo][jj].stc_lock:SetShow(false)
      deepeningSkill._resultSlot[slotNo][jj].area = rdo_resultSkillSlotArea
      deepeningSkill._mainSkillName[slotNo] = UI.getChildControl(stc_mainSkillSlotArea, "StaticText_MainSkillName")
      deepeningSkill._subSkillName[slotNo][jj] = UI.getChildControl(stc_subSkillSlotArea, "StaticText_SubSkillName")
      deepeningSkill._resultSkillName[slotNo][jj] = UI.getChildControl(rdo_resultSkillSlotArea, "StaticText_ResultSkillName")
      deepeningSkill._result_CC[slotNo][jj] = UI.getChildControl(rdo_resultSkillSlotArea, "Static_CC")
      stc_subSkillSlotArea:SetPosY(posY + jj * 115)
      rdo_resultSkillSlotArea:SetPosY(posY + jj * 115)
      deepeningSkill._mainSkillName[slotNo]:SetTextMode(__eTextMode_Limit_AutoWrap)
      deepeningSkill._subSkillName[slotNo][jj]:SetTextMode(__eTextMode_Limit_AutoWrap)
      deepeningSkill._resultSkillName[slotNo][jj]:SetTextMode(__eTextMode_Limit_AutoWrap)
      local tempMainText = deepeningSkill._mainSkillName[slotNo]
      local tempSubText = deepeningSkill._subSkillName[slotNo][jj]
      local tempResultText = deepeningSkill._resultSkillName[slotNo][jj]
      if nil ~= tempMainText and nil ~= tempSubText and nil ~= tempResultText then
        local mainSkillTypeSSW = getSkillTypeStaticStatus(mainSkillNo)
        if nil ~= mainSkillTypeSSW then
          tempMainText:SetText(mainSkillTypeSSW:getName())
        end
        local subSkillTypeSSW = getSkillTypeStaticStatus(subSkillNo)
        if nil ~= mainSkillTypeSSW then
          tempSubText:SetText(subSkillTypeSSW:getName())
        end
        local resultSkillTypeSSW = getSkillTypeStaticStatus(fusionSkillNo)
        if nil ~= mainSkillTypeSSW then
          tempResultText:SetText(resultSkillTypeSSW:getName())
        end
      end
      local skillLevelInfo = getSkillLevelInfo(fusionSkillNo)
      if nil == skillLevelInfo then
        return
      end
      if true == skillLevelInfo._usable then
        isLearnThisSlot = true
        learnIndex = jj
      end
      local skillSSW = getSkillStaticStatus(fusionSkillNo, 1)
      if nil ~= isInit and true == isInit then
        PaGlobal_SkillGroup:initDeepeningSkillCCType(skillSSW, deepeningSkill._result_CC[slotNo][jj], rdo_resultSkillSlotArea, slotNo, jj)
      end
      local resultSkillStatic = getSkillStaticStatus(fusionSkillNo, 1)
      if nil ~= resultSkillStatic then
        local lv = resultSkillStatic:get()._needCharacterLevelForLearning
        if jj == 1 then
          local txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_DEEPSKILL_LEVEL", "level", lv)
          txt_skillLevel:SetText(txt)
        end
        local selfPlayerWrapper = getSelfPlayer()
        local playerLevel = selfPlayerWrapper:get():getLevel()
        if lv <= playerLevel then
          deepeningSkill._stc_topArea._btn_plus[slotNo]:SetShow(not isLearnThisSlot)
          if true == skillLevelInfo._learnable and false == skillLevelInfo._usable then
            deepeningSkill._resultSlot[slotNo][jj].stc_learnable:SetShow(true)
            deepeningSkill._resultSlot[slotNo][jj].icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_LearnDeepeningSkill(" .. mainSkillNo .. "," .. subSkillNo .. "," .. fusionSkillNo .. "," .. slotNo .. "," .. jj .. ")")
          else
            deepeningSkill._resultSlot[slotNo][jj].stc_learnable:SetShow(false)
            deepeningSkill._resultSlot[slotNo][jj].icon:addInputEvent("Mouse_LUp", "")
          end
        else
          deepeningSkill._resultSlot[slotNo][jj].stc_learnable:SetShow(false)
          deepeningSkill._resultSlot[slotNo][jj].icon:addInputEvent("Mouse_LUp", "")
        end
      end
    end
    for jj = 0, deepeningSkill._maxCount[slotNo] - 1 do
      if true == isLearnThisSlot then
        if jj ~= learnIndex then
          deepeningSkill._resultSlot[slotNo][jj].stc_lock:SetShow(true)
        end
        deepeningSkill._resultSlot[slotNo][jj].icon:addInputEvent("Mouse_LUp", "")
        deepeningSkill._resultSlot[slotNo][jj].stc_learnable:SetShow(false)
      end
    end
    if nil ~= isInit and true == isInit then
      local skillPosY = stc_deepSkill:GetPosY() + offsetY * slotNo + 70
      stc_deepSkill:SetPosY(skillPosY)
      if offsetY == 0 then
        offsetY = stc_deepSkill:GetSizeY() + 70
      end
      framePosY = skillPosY + offsetY
    end
  end
  if nil ~= isInit and true == isInit then
    frameContent:SetSize(frameContent:GetSizeX(), framePosY)
  end
  frame:UpdateContentPos()
  frame:UpdateContentScroll()
  UIScroll.SetButtonSize(deepeningSkill.frameScroll, frame:GetSizeY(), frameContent:GetSizeY())
end
function PaGlobal_SkillGroup:initDeepeningSkillCCType(skillSSW, origin, parent, slotNo, jj)
  local maxSkillCCTypeCount = ToClient_getMaxSkillCCTypeCount()
  local idxOfSkillCCType = 0
  local gapX = origin:GetSizeX() + 2
  local skillCCTypeConfig = PaGlobal_SkillGroup._skillCCTypeConfig
  for ii = 1, maxSkillCCTypeCount - 1 do
    if true == skillSSW:isSetSkillCCType(ii - 1) and nil ~= skillCCTypeConfig.uv[ii] then
      if idxOfSkillCCType < 6 then
        local control = UI.cloneControl(origin, parent, "Static_CC_" .. ii)
        local posX = control:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:ChangeTextureInfoName(skillCCTypeConfig.iconPath)
        local x1, y1, x2, y2 = setTextureUV_Func(control, skillCCTypeConfig.uv[ii].x1, skillCCTypeConfig.uv[ii].y1, skillCCTypeConfig.uv[ii].x2, skillCCTypeConfig.uv[ii].y2)
        control:getBaseTexture():setUV(x1, y1, x2, y2)
        control:setRenderTexture(control:getBaseTexture())
        control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup:ShowSkillGroupDeepengingSkillCCTooltip(" .. ii .. "," .. "true" .. "," .. slotNo .. "," .. jj .. ")")
        control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup:ShowSkillGroupDeepengingSkillCCTooltip(" .. ii .. "," .. "false" .. "," .. slotNo .. "," .. jj .. ")")
        control:SetShow(true)
        idxOfSkillCCType = idxOfSkillCCType + 1
      end
      if idxOfSkillCCType == 6 then
        local control = UI.createControl(__ePAUIControl_StaticText, parent, "Static_CC_limit" .. ii)
        control:SetSize(20, 20)
        control:SetHorizonLeft()
        control:SetVerticalTop()
        control:SetSpanSize(70, 45)
        local posX = control:GetPosX() + gapX * idxOfSkillCCType
        control:SetPosX(posX)
        control:SetText("...")
        control:SetShow(true)
      end
    end
  end
  local lock = UI.getChildControl(parent, "Static_Lock")
  parent:SetChildIndex(lock, parent:GetChildSize())
end
function PaGlobal_SkillGroup:ShowSkillGroupDeepengingSkillCCTooltip(index, isShow, slotNo, jj)
  local control = UI.getChildControl(self._deepeningSkill._resultSlot[slotNo][jj].area, "Static_CC_" .. index)
  if nil == control then
    _PA_LOG("\236\139\160\236\138\185\234\182\140", "control is nil")
    return
  end
  local title = ""
  local desc = ""
  if index == 1 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_INVINCIBILITY")
  elseif index == 2 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SUPERARMOR")
  elseif index == 3 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FRONTGUARD")
  elseif index == 4 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKDOWN")
  elseif index == 5 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_JUMP")
  elseif index == 6 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_BOUND")
  elseif index == 7 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FAINT")
  elseif index == 8 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_STIFFNESS")
  elseif index == 9 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKBACK")
  elseif index == 10 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_CATCH")
  elseif index == 11 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FREEZE")
  elseif index == 12 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNSMASH")
  elseif index == 13 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRSMASH")
  elseif index == 14 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNATTACK")
  elseif index == 15 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRATTACK")
  elseif index == 16 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_COUNTERATTACK")
  elseif index == 17 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SPEEDATTACK")
  else
    UI.ASSERT(false, "SkillCCType \236\149\132\236\157\180\236\189\152\236\157\180 \236\182\148\234\176\128\235\144\160 \234\178\189\236\154\176 \237\136\180\237\140\129 \236\138\164\237\138\184\235\167\129 \236\182\148\234\176\128\235\143\132 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
  end
  if true == isShow then
    TooltipSimple_Show(control, title, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_SkillGroup:updateDeepeningSlot(index, container, parent)
  if nil == self._deepeningSkill.area then
    return
  end
  if index >= self._maxDeepeningSkillCount then
    return
  end
  local skillNo = ToClient_getFusionLearnSkillNo(index)
  if 0 == skillNo or false == isLearn then
    if nil == container[index] then
      local slot = {}
      SlotSkill.new(slot, index, parent, self._slotConfig)
      if nil ~= slot.icon then
        slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_DeepeningSkillSlotClick()")
        slot.icon:addInputEvent("Mouse_On", "")
        slot.icon:addInputEvent("Mouse_Out", "")
        slot.icon:addInputEvent("Mouse_PressMove", "")
        slot.icon:addInputEvent("Mouse_RUp", "")
        slot.icon:SetPosX(slot.icon:GetPosX() + 1)
      end
      container[index] = slot
    end
  else
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if nil ~= skillTypeStaticWrapper then
      if skillTypeStaticWrapper:isValidLocalizing() then
        local skillTypeStatic = skillTypeStaticWrapper:get()
        local slot = {}
        SlotSkill.new(slot, index, parent, self._slotConfig)
        if nil ~= slot.icon then
          slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_DeepeningSkillSlotClick()")
          slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SkillBox\")")
          slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
          slot.icon:addInputEvent("Mouse_RUp", "HandleMRUp_DeepeningSkillGroupWindow_ClearButtonClick(" .. skillNo .. ")")
          slot.icon:SetEnableDragAndDrop(true)
          slot.icon:SetPosX(slot.icon:GetPosX() + 1)
        end
        container[index] = slot
        self:LearnDeepeningSkill(skillNo, index)
      end
    else
      _PA_ASSERT("\236\138\164\237\130\172\237\138\184\235\166\172", "skillTypeStaticStatus \235\167\164\235\139\136\236\160\184\236\151\144 \236\151\134\235\138\148 \236\138\164\237\130\172\236\157\180 \236\158\136\236\138\181\235\139\136\235\139\164.")
    end
  end
end
function PaGlobal_SkillGroup:HandleEventLUp_DeepeningSubManSkillSlotClick(skillNo)
  HandleMOver_SkillWindow_ToolTipHide(skillNo, "SkillBox")
  PaGlobal_SkillGroup:SkillGroup_FocusSkillGroup(skillNo, 0)
  PaGlobal_SkillGroup:ShowLearnableSkill(skillNo)
end
function HandleMRUp_DeepeningSkillGroupWindow_ClearButtonClick(skillNo)
  HandleMRUp_SkillGroupWindow_ClearButtonClick(skillNo)
end
function PaGlobal_SkillGroup:DeepeningSkillAction(skillNo)
  self._selectSkillNo = skillNo
  PaGlobalFunc_SkillGroup_SkillAction(skillNo)
end
function PaGlobal_SkillGroup:updateDeepeningSkill()
  local frame = self._deepeningSkill.frame
  local deepeningSkill = self._deepeningSkill
  if nil == frame then
    return
  end
  local isLearnedFirst_FusionSkill = false
  local isLearnedSecond_FusionSkill = false
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    local isLearndThisSlot = false
    local learnIndex = -1
    for jj = 0, deepeningSkill._maxCount[ii] - 1 do
      local deepSkill = UI.getChildControl(frame:GetFrameContent(), "Static_DeepSkill_" .. tostring(ii))
      deepeningSkill._resultSlot[ii][jj].stc_lock:SetShow(false)
      if nil ~= deepSkill then
        local mainSkillNo = ToClient_getFusionMainSkillNo(ii, 0)
        local subSkillNo = ToClient_getFusionSubSkillNo(ii, jj)
        local fusionSkillNo = ToClient_getFusionSkillNo(ii, jj)
        local isLearnedMainSkill = not self:UpdateSkillMonoTone(deepeningSkill._mainSlot[ii], mainSkillNo)
        local isLearnedSubSkill = not self:UpdateSkillMonoTone(deepeningSkill._subSlot[ii][jj], subSkillNo)
        local isLearnedFusionSkill = not self:UpdateSkillMonoTone(deepeningSkill._resultSlot[ii][jj], fusionSkillNo, isLearnedMainSkill and isLearnedSubSkill)
        if true == isLearnedFusionSkill then
          if 0 == ii and false == isLearnedFirst_FusionSkill then
            isLearnedFirst_FusionSkill = true
          elseif 1 == ii and false == isLearnedSecond_FusionSkill then
            isLearnedSecond_FusionSkill = true
          end
        end
        if false == isLearnedMainSkill then
          deepeningSkill._mainSlot[ii].icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_DeepeningSubManSkillSlotClick(" .. mainSkillNo .. ")")
        else
          deepeningSkill._mainSlot[ii].icon:removeInputEvent("Mouse_LUp")
        end
        if false == isLearnedSubSkill then
          deepeningSkill._subSlot[ii][jj].icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_DeepeningSubManSkillSlotClick(" .. subSkillNo .. ")")
        else
          deepeningSkill._subSlot[ii][jj].icon:removeInputEvent("Mouse_LUp")
        end
        deepeningSkill._resultSlot[ii][jj].areaPanel:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:DeepeningSkillAction(" .. fusionSkillNo .. ")")
        if true == isLearnedFusionSkill then
          deepeningSkill._resultSlot[ii][jj].icon:addInputEvent("Mouse_RUp", "HandleMRUp_DeepeningSkillGroupWindow_ClearButtonClick(" .. fusionSkillNo .. ")")
          deepeningSkill._resultSlot[ii][jj].icon:addInputEvent("Mouse_PressMove", "HandleEventLUp_SkillGroup_StartDrag(" .. fusionSkillNo .. ")")
          deepeningSkill._resultSlot[ii][jj].icon:SetEnableDragAndDrop(true)
          isLearndThisSlot = true
          learnIndex = jj
        else
          deepeningSkill._resultSlot[ii][jj].icon:removeInputEvent("Mouse_RUp")
          deepeningSkill._resultSlot[ii][jj].icon:removeInputEvent("Mouse_PressMove")
        end
        local skillLevelInfo = getSkillLevelInfo(fusionSkillNo)
        if nil == skillLevelInfo then
          return
        end
        if true == skillLevelInfo._learnable and false == skillLevelInfo._usable then
          deepeningSkill._resultSlot[ii][jj].stc_learnable:SetShow(true)
          if false == isLearnedMainSkill or false == isLearnedSubSkill then
            deepeningSkill._resultSlot[ii][jj].icon:addInputEvent("Mouse_LUp", "")
            deepeningSkill._resultSlot[ii][jj].stc_learnable:SetShow(false)
          else
            deepeningSkill._resultSlot[ii][jj].icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:HandleEventLUp_LearnDeepeningSkill(" .. mainSkillNo .. "," .. subSkillNo .. "," .. fusionSkillNo .. "," .. ii .. "," .. jj .. ")")
          end
        else
          deepeningSkill._resultSlot[ii][jj].stc_learnable:SetShow(false)
        end
      end
    end
    for jj = 0, deepeningSkill._maxCount[ii] - 1 do
      if true == isLearndThisSlot then
        if jj ~= learnIndex then
          deepeningSkill._resultSlot[ii][jj].stc_lock:SetShow(true)
        end
        deepeningSkill._resultSlot[ii][jj].icon:addInputEvent("Mouse_LUp", "")
        deepeningSkill._resultSlot[ii][jj].stc_learnable:SetShow(false)
      end
    end
  end
end
function PaGlobal_SkillGroup:hideDeepeingSkillSlot()
  local frame = self._deepeningSkill.area
  local deepeningSkill = self._deepeningSkill
  if nil == frame then
    return
  end
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    if true == isLearnFusionSkill and nil ~= deepeningSkill._deepSkillForm[ii] then
      deepeningSkill._deepSkillForm[ii]:SetShow(false)
    end
  end
end
function PaGlobal_SkillGroup:HandleEventLUp_DeepeningSkillSlotClick()
  local frame = self._deepeningSkill.area
  local deepeningSkill = self._deepeningSkill
  if nil == frame then
    return
  end
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    if true == isLearnFusionSkill and nil ~= deepeningSkill._deepSkillForm[ii] then
      deepeningSkill._deepSkillForm[ii]:SetShow(true)
    end
  end
end
function PaGlobal_SkillGroup:HandleEventLUp_LearnDeepeningSkill(mainSkillNo, subSkillNo, resultSkillNo, slotNo, index)
  if false == self._deepenigSkillAddedEffect then
    self._deepenigSkillAddedEffect = true
    self._deepeningSkillEffectTime = 0
    self._panel:RegisterUpdateFunc("PaGlobal_SkillGroup_learnSkill_UpdatePerFrame_For_Effect")
    audioPostEvent_SystemUi(27, 2)
    if 0 == index then
      self._deepeningSkill._deepSkillForm[slotNo]:AddEffect("fUI_NewSkill_Intensive_01A", false, 0, 0)
    else
      self._deepeningSkill._deepSkillForm[slotNo]:AddEffect("fUI_NewSkill_Intensive_01B", false, 0, 0)
    end
    self._resultSkillNo = resultSkillNo
    self._mainSkillNo = mainSkillNo
    self._subSkillNo = subSkillNo
    self._selectedDeepeningSlotNo = slotNo
    self._selectedDeepeningSkillIndex = index
    self._mouseOnSkillGroupNo = -1
  end
end
function PaGlobal_SkillGroup:LearnDeepeningSkill(skillNo, slotIndex)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  if skillTypeStaticWrapper:isValidLocalizing() then
    local slot = self._deepeningSkill._stc_topArea._stc_skillIcon[slotIndex]
    local btn_plus = self._deepeningSkill._stc_topArea._btn_plus[slotIndex]
    if nil ~= slot then
      local skillTypeStatic = skillTypeStaticWrapper:get()
      slot:setSkillTypeStatic(skillTypeStaticWrapper)
      if nil ~= slot.learnButton then
        slot.learnButton:SetShow(false)
        slot.learnButton:SetIgnore(false)
      end
      btn_plus:SetShow(false)
      if nil ~= slot.icon then
        slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SkillBox\")")
        slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
        slot.icon:addInputEvent("Mouse_RUp", "HandleMRUp_SkillGroupWindow_ClearButtonClick(" .. skillNo .. ")")
        slot.icon:addInputEvent("Mouse_PressMove", "HandleEventLUp_SkillGroup_StartDrag(" .. skillNo .. ")")
        slot.icon:SetEnableDragAndDrop(true)
        slot.icon:SetShow(true)
      end
    end
  end
end
function PaGlobal_SkillGroup:SkillGroup_WindowPosSet(posY, skillType)
  local tabIndex = PaGlobal_SkillGroup:GetConvertTabIndex(skillType)
  PaGlobal_SkillGroup:selectTab(tabIndex)
  local vScroll = self._frame[tabIndex]:GetVScroll()
  local contentUseSize = self._frame[tabIndex]:GetFrameContent():GetSizeY() - self._frame[tabIndex]:GetSizeY()
  local posPercents = (posY - self._frame[tabIndex]:GetSizeY() / 2) / contentUseSize
  vScroll:SetControlPos(math.max(math.min(posPercents, 1), 0))
  self._frame[tabIndex]:UpdateContentPos()
end
function PaGlobal_SkillGroup:SkillGroupWindowEffect(posX, posY, skillGroup, isOn, skillType, effectType)
  if nil == skillGroup then
    return
  end
  if nil ~= self._skillGroupList[skillGroup._key] then
    if nil ~= self._focusEffect then
      self._focusEffect:EraseAllEffect()
    end
    local subGroupNo = self._skillGroupList[skillGroup._key]._subGroupNo
    if false == self._isOpenedSubGroup[subGroupNo] then
      self._subGroupButton[subGroupNo]:SetCheck(true)
      PaGlobal_SkillGroup:updateFrameControls()
    end
    self:SkillGroup_WindowPosSet(skillGroup:getPosY(), skillType)
    self.savedAwaken = skillType
    self._focusEffect = self._skillGroupList[skillGroup._key]._groupBg
    if nil == effectType or 0 == effectType then
      self._focusEffect:AddEffect("fUI_NewSkill_Guide_01B", true, 0, 0)
    elseif 1 == effectType then
      self._focusEffect:AddEffect("fUI_NewSkill_Guide_01A", true, 0, 0)
    end
  end
end
function PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
  for key, skillGroup in pairs(self._skillGroupList) do
    for level = 1, skillGroup._maxLevel do
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, level)
      local skillGroupSkillNo = skillKey:getSkillNo()
      if skillGroupSkillNo == skillNo then
        return skillGroup
      end
    end
  end
  return nil
end
function PaGlobal_SkillGroup:SkillGroup_FocusSkillGroup(skillNo, effectType)
  local skill = getSkillStaticStatus(skillNo, 1)
  if nil == skill then
    return
  end
  local skillType = skill:getSkillAwakenBranchType()
  local getTabIndex = PaGlobal_SkillGroup:GetConvertTabIndex(skillType)
  PaGlobal_SkillGroup:OpenForLearn(getTabIndex)
  if nil ~= self._subGroupButton[getTabIndex] and false == self._subGroupButton[getTabIndex]:IsCheck() then
    PaGlobal_SkillGroup:updateFrameControls()
  end
  PaGlobal_SkillWindow_SkillFocusEffect(skillNo, true, effectType)
end
function PaGlobal_SkillGroup:ClearDeepeningSkill()
  local parent = self._deepeningSkill._stc_topArea
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    if nil ~= parent._stc_skillIcon[ii] then
      local skillNo = ToClient_getFusionLearnSkillNo(ii)
      if 0 == skillNo then
        parent._stc_skillIcon[ii]:clearSkill()
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_On", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_Out", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_PressMove", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_RUp", "")
        parent._stc_skillIcon[ii].icon:SetShow(false)
        local fusionSkillNo = ToClient_getFusionSkillNo(ii, 0)
        if 0 ~= fusionSkillNo then
          local resultSkillStatic = getSkillStaticStatus(fusionSkillNo, 1)
          if nil ~= resultSkillStatic then
            local lv = resultSkillStatic:get()._needCharacterLevelForLearning
            local selfPlayerWrapper = getSelfPlayer()
            if nil ~= selfPlayerWrapper then
              local playerLevel = selfPlayerWrapper:get():getLevel()
              if lv <= playerLevel then
                parent._btn_plus[ii]:SetShow(true)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SkillGroup:GetConvertTabIndex(skillType)
  UI.ASSERT(nil ~= skillType, "PaGlobal_SkillGroup:GetConvertTabIndex() skillType \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  if __eSkillTypeParam_Inherit == skillType then
    if true == _ContentsGroup_SkillSubGroup then
      return PaGlobal_SkillGroup.eTabIndex.weapon
    else
      return PaGlobal_SkillGroup.eTabIndex.succession
    end
  elseif __eSkillTypeParam_Awaken == skillType then
    return PaGlobal_SkillGroup.eTabIndex.awaken
  else
    return PaGlobal_SkillGroup.eTabIndex.weapon
  end
end
function PaGlobal_SkillGroup:OpenForLearn(tabIndex)
  HandleMLUp_SkillWindow_OpenForLearn(tabIndex)
end
function PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(key, nextLevelKey)
  local skillGroup = self._skillGroupList[key]
  if nil ~= nextLevelKey then
    PaGlobal_SkillGroup:HandleEventLUpLearnSkill(nextLevelKey)
    return
  end
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, skillGroup._selectLevel)
  self._selectSkillNo = skillKey:getSkillNo()
  self._selectKey = key
  PaGlobalFunc_SkillGroup_SkillAction(self._selectSkillNo)
  if self._recentSkill.currentCount < self._recentSkill.maxCount then
    self._recentSkill.currentCount = self._recentSkill.currentCount + 1
  end
  for ii = self._recentSkill.currentCount - 1, 1, -1 do
    self._recentSkill.key[ii] = self._recentSkill.key[ii - 1]
  end
  self._recentSkill.key[0] = skillKey
  for ii = 0, self._recentSkill.currentCount - 1 do
    if nil ~= self._recentSkill.key[ii] then
      local skillNo = self._recentSkill.key[ii]:getSkillNo()
      local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
      if nil ~= skillTypeSSW then
        self._recentSkill.step[ii]:SetText(skillTypeSSW:getName())
        self._recentSkill.step[ii]:SetShow(true)
        self._recentSkill.step[ii]:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:SkillGroup_FocusSkillGroup(" .. skillNo .. ", 0)")
        if 0 < ii then
          self._recentSkill.arrow[ii]:SetShow(true)
        end
      end
    end
  end
  if self._recentSkill.currentCount > 0 then
    self._recentSkill.noSelectSkill:SetShow(false)
  end
  PaGlobal_SkillGroup:HandleMLUp_Frame()
end
function PaGlobal_SkillGroup:HandleEventLUp_EditMode()
  self._ui._btn_modify:SetCheck(not self._isEditMode)
  self:updateEditMode(not self._isEditMode)
end
function PaGlobal_SkillGroup:HandleEventLUp_BlackSpiritSkillLock()
  PaGlobalFunc_BlackSpiritSkillLock_All_Toggle(2)
end
function PaGlobal_SkillGroup:HandleEventLUp_CooltimeSet()
  PaGlobal_SkillGroup_CoolTimeSlot_Toggle()
end
local editText = ""
function PaGlobal_SkillGroup:HandleEventLUp_SearchText()
  if true == PaGlobalFunc_SkillGroup_KeyBoardTabEvent() then
    return
  end
  if false == self._ui._edit_search:GetFocusEdit() and (nil ~= GetFocusEdit() or false == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_RETURN)) then
    self._ui._edit_search:SetEditText("")
  end
  SetFocusEdit(self._ui._edit_search)
  if editText ~= self._ui._edit_search:GetEditText() then
    self._filterText = nil
    self._filterIndex = 0
    editText = self._ui._edit_search:GetEditText()
  end
end
function PaGlobal_SkillGroup:HandleEventLUp_SearchButton()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  self = PaGlobal_SkillGroup
  self._filterText = self._ui._edit_search:GetEditText()
  if self._filterText ~= nil and self._filterText:len() ~= 0 then
    if false == self:Search() then
      self._filterText = nil
      self._filterIndex = 0
      if nil ~= self._focusEffect then
        self._focusEffect:EraseAllEffect()
      end
    end
  else
    self._filterText = nil
    self._filterIndex = 0
  end
end
function PaGlobal_SkillGroup:Search()
  self = PaGlobal_SkillGroup
  local skillKeyListSize = #self._filterKeyList
  if skillKeyListSize > self._filterIndex then
    for ii = self._filterIndex, skillKeyListSize do
      if nil ~= self._filterKeyList[ii] then
        local skillKey = ToClient_getSkillKeyBySkillGroupNo(self._filterKeyList[ii]._key, 1)
        local skillNo = skillKey:getSkillNo()
        local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
        if nil ~= skillTypeSSW then
          local skillName = skillTypeSSW:getName()
          if true == stringSearch(skillName, self._filterText) then
            self._filterIndex = ii + 1
            self:SkillGroup_FocusSkillGroup(skillNo, 1)
            return true
          end
        end
      end
    end
    self._filterIndex = skillKeyListSize
  end
  if skillKeyListSize <= self._filterIndex then
    local beforeIndex = self._filterIndex - skillKeyListSize
    local isLearnFusionSkill = true == ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
    if false == isLearnFusionSkill then
      return
    end
    local maxSubFusionSkill = 10
    local beforeii = 0
    if 0 ~= beforeIndex then
      beforeii = math.floor(beforeIndex / maxSubFusionSkill)
    end
    for ii = beforeii, self._maxDeepeningSkillCount - 1 do
      local beforejj = 0
      if 0 ~= beforeIndex then
        beforejj = beforeIndex % maxSubFusionSkill
      end
      for jj = beforejj, self._deepeningSkill._maxCount[ii] - 1 do
        local fusionSkillNo = ToClient_getFusionSkillNo(ii, jj)
        local skillTypeSSW = getSkillTypeStaticStatus(fusionSkillNo)
        if nil ~= skillTypeSSW then
          local skillName = skillTypeSSW:getName()
          if true == stringSearch(skillName, self._filterText) then
            if nil ~= self._focusEffect then
              self._focusEffect:EraseAllEffect()
            end
            self._filterIndex = ii * maxSubFusionSkill + jj + skillKeyListSize + 1
            self:selectTab(self.eTabIndex.deepening)
            self._focusEffect = self._deepeningSkill._resultSlot[ii][jj].area
            local lock = UI.getChildControl(self._focusEffect, "Static_Lock")
            if true == lock:GetShow() then
              self._focusEffect = lock
            end
            self._focusEffect:AddEffect("fUI_NewSkill_Guide_02A", true, 0, 0)
            return true
          end
        end
      end
    end
  end
  return false
end
function PaGlobal_SkillGroup:SkillGroupWindow_LearnButtonClick(skillNo, isGroupLearn)
  if false == self.saved_isLearnMode then
    return false
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return false
  end
  if false == skillLevelInfo._learnable then
    return false
  end
  local skillSS = getSkillStaticStatus(skillNo, 1)
  if nil == skillSS then
    return false
  end
  if skillSS:isAnyPreRequiredSkillBlocked() then
    local blockedPreRequiredSkillKeyList = skillSS:getBlockedPreRequiredSkillNoList()
    local skillNameStr = ""
    for k, v in pairs(blockedPreRequiredSkillKeyList) do
      local skillNo = v:getSkillNo()
      local skillTypeSS = getSkillTypeStaticStatus(skillNo)
      if nil ~= skillTypeSS and nil ~= skillTypeSS:getName() then
        if "" == skillNameStr then
          skillNameStr = skillTypeSS:getName()
        else
          skillNameStr = skillNameStr .. ", " .. skillTypeSS:getName()
        end
      end
    end
    local messageData = {
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_BLOCKED_NOTICE") .. [[


]] .. skillNameStr,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
    return false
  end
  if true == isGroupLearn then
    local skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
    if nil ~= skillGroup then
      ToClient_doLearnSkillGroup(skillGroup._key)
    end
  else
    local isSuccess = skillWindow_DoLearn(skillNo)
    return isSuccess
  end
  return true
end
function PaGlobal_SkillGroup:HandleEventLUp_PrevLevelButton(key)
  self._skillGroupList[key]:HandleEventLUp_PrevLevelButton()
end
function PaGlobal_SkillGroup:HandleEventLUp_NextLevelButton(key)
  self._skillGroupList[key]:HandleEventLUp_NextLevelButton()
end
function PaGlobal_SkillGroup:HandleEventLUpLearnSkill(skillNo, soundPlay)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if nil == skillTypeStaticWrapper then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  if nil ~= self._mouseOnSkillGroupNo or -1 ~= self._mouseOnSkillGroupNo then
    local skillGroup = self._skillGroupList[self._mouseOnSkillGroupNo]
    if nil ~= skillGroup then
      PaGlobal_SkillGroup:HandleEventLUp_SkillGroup(skillGroup._key)
    end
  end
  local isPressShift = false
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isPressShift = true
  end
  local function NeedSkillEffect()
    if true == PaGlobal_SkillWindow_SkillFocusEffect(skillLevelInfo._needSkillNo1) then
      PaGlobal_SkillGroup:ShowLearnableSkill(skillLevelInfo._needSkillNo1)
      return
    end
    PaGlobal_SkillWindow_SkillFocusEffect(skillLevelInfo._needSkillNo2)
    PaGlobal_SkillGroup:ShowLearnableSkill(skillLevelInfo._needSkillNo2)
  end
  skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  skillLevelInfo = getSkillLevelInfo(skillNo)
  local learnedSkillLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
  if false == skillLevelInfo._learnable and 0 == learnedSkillLevel then
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if nil == skillSSW then
      return
    end
    local branchType = skillSSW:getSkillAwakenBranchType()
    local resultString = SkillWindow_GetLearnSkillAlert(skillLevelInfo, branchType)
    if "" ~= resultString then
      local messageBoxMemo = resultString
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = messageBoxMemo,
        functionYes = NeedSkillEffect,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    return
  end
  local function DolearnSkill(isAll)
    PaGlobal_SkillGroup:SkillGroupWindow_LearnButtonClick(skillNo, isAll)
  end
  skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  local skillType = skillTypeStaticWrapper:requiredEquipType()
  if 55 == skillType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO1")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = DolearnSkill,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif 56 == skillType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO2")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = DolearnSkill,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif true == isPressShift then
    DolearnSkill(true)
  else
    DolearnSkill(false)
  end
  PaGlobal_SkillGroup._isLevelupEffect = false
end
function PaGlobal_SkillGroup:HandleEventLUp_BlackSpiritLock(key)
  self._skillGroupList[key]:HandleEventLUp_BlackSpiritLock()
end
function PaGlobal_SkillGroup:HandleEventLUp_SkillCommandLock(key)
  self._skillGroupList[key]:HandleEventLUp_SkillCommandLock()
end
function PaGlobal_SkillGroup:HandleMOver_FrameOn()
  if nil ~= self._mouseOnSkillGroupNo and -1 ~= self._mouseOnSkillGroupNo then
    PaGlobal_SkillGroup:HandleMOver_SkillGroupOut(self._mouseOnSkillGroupNo)
    local skillGroup = self._skillGroupList[self._mouseOnSkillGroupNo]
    if nil ~= skillGroup then
      skillGroup._btn_prev:SetShow(false)
      skillGroup._btn_next:SetShow(false)
    end
  end
  self._mouseOnSkillGroupNo = -1
end
function PaGlobal_SkillGroup:HandleMOut_FrameOut()
  if nil ~= DragManager.groundClickFunc and false == self._isEditMode then
    self:HandleEventLUp_EditMode()
  end
end
function PaGlobal_SkillGroup:HandleMLDown_Frame()
end
function PaGlobal_SkillGroup:HandleMLUp_Frame()
  PaGlobal_SkillGroup:DragClear()
end
function PaGlobal_SkillGroup:DragClear()
  if nil ~= DragManager.groundClickFunc then
    DragManager:clearInfo()
  end
end
function PaGlobal_SkillGroup:HandleMOver_SkillGroupOn(key)
  local skillGroup = self._skillGroupList[key]
  UI.ASSERT_NAME(nil ~= skillGroup, "PaGlobal_SkillGroup:HandleMOver_SkillGroupOn skillGroup nil", "\234\185\128\236\167\128\237\152\129")
  self._mouseOnSkillGroupNo = key
  local level = skillGroup._selectLevel
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, level)
  local skillNo = skillKey:getSkillNo()
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if nil == skillLevelInfo then
    return
  end
  if true == skillLevelInfo._usable then
    skillGroup:showLock(true)
  end
  if 1 ~= skillGroup._maxLevel then
    skillGroup._btn_prev:SetShow(true)
    skillGroup._btn_next:SetShow(true)
  end
end
function PaGlobal_SkillGroup:HandleMOver_SkillGroupOut(key)
  local skillGroup = self._skillGroupList[key]
  UI.ASSERT_NAME(nil ~= skillGroup, "PaGlobal_SkillGroup:HandleMOver_SkillGroupOut skillGroup nil", "\234\185\128\236\167\128\237\152\129")
  skillGroup:showLock(false)
  skillGroup._btn_prev:SetShow(false)
  skillGroup._btn_next:SetShow(false)
end
function PaGlobal_SkillGroup:registEventHandler()
  registerEvent("onScreenResize", "SkillGroup_Resize")
  registerEvent("EventSkillWindowClearSkillAll", "FromClient_SkillGroupWindow_ClearSkills")
  registerEvent("EventSkillWindowClearSkillByPoint", "FromClient_SkillGroupWindow_ClearSkillByPoint")
  registerEvent("EventSkillWindowUpdate", "FromClient_SkillGroupWindow_Update")
  registerEvent("FromClient_SkillWindowClose", "FromClient_SkillGroupWindow_Close")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "FromClient_SkillGroupSkillPointUpdate")
  registerEvent("EventlearnedSkill", "FromClient_SkillGroupLearnedSkill")
  registerEvent("FromClient_responseLearnFusionSkill", "FromClient_responseLearnDeepeningSkill")
  registerEvent("FromClient_responseClearFusionSkill", "FromClient_responseClearDeepeningSkill")
  registerEvent("FromClient_EventSkillWindowAllUpdate", "FromClient_SkillGroupWindow_AllUpdate")
  registerEvent("FromClient_SkillPresetSave", "FromClient_SkillPresetSaveMessage")
  registerEvent("FromClient_responseSkillPresetSlotExpansion", "FromClient_responseSkillPresetSlotExpansion")
  registerEvent("FromClient_SkillAndPresetClearConfirm", "FromClient_SkillAndPresetClearConfirm")
  registerEvent("FromClient_SkillAndPresetClear", "FromClient_SkillAndPresetClear")
end
function PaGlobal_SkillGroup_ShowAni()
  local self = PaGlobal_SkillGroup
  local panel = Panel_Window_SkillGroup
  local ImageMoveAni = panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX(), panel:GetPosY())
  ImageMoveAni:SetEndPosition(getScreenSizeX() - panel:GetSizeX(), panel:GetPosY())
  ImageMoveAni.IsChangeChild = true
  panel:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobal_SkillGroup_HideAni()
  local self = PaGlobal_SkillGroup
  local panel = Panel_Window_SkillGroup
  local ImageMoveAni = panel:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(panel:GetPosX(), panel:GetPosY())
  ImageMoveAni:SetEndPosition(getScreenSizeX(), panel:GetPosY())
  ImageMoveAni.IsChangeChild = true
  panel:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetIgnoreUpdateSnapping(true)
end
function SkillGroup_Resize()
  PaGlobal_SkillGroup:DefaultPanelResize()
  if true == Panel_Window_SkillGroup_Controller:GetShow() then
    PaGlobal_SkillGroup_Controller_Resize()
  end
  PaGlobal_SkillGroup_QuickSlot_Resize()
end
function PaGlobal_SkillGroup:DefaultPanelResize()
  if nil == self._panel then
    return
  end
  local panelSizeX = self._panel:GetSizeX()
  local screenSizeY = getScreenSizeY()
  local bottomUiSizeY = self._ui._stc_bottomArea:GetSizeY()
  self._panel:SetSize(panelSizeX, screenSizeY)
  self._panel:ComputePos()
  self._skillPreset.stc_presetBG:ComputePos()
  local isShowTreeRadio = self._ui._rdo_treeBg:GetShow()
  if false == isShowTreeRadio then
    self._ui._rdo_groupBg:SetPosY(0)
    local jj = 0
    for ii = 0, #self._tab do
      if self._tab[ii]:GetShow() then
        self._tab[ii]:SetPosY(0)
      end
    end
    self._ui._stc_TopFuncBg:SetPosY(self._tab[0]:GetSizeY())
  end
  local variedPosY = 0
  for ii = 0, #self._frame do
    local tempFrame = self._frame[ii]
    local posY = self._ui._stc_TopFuncBg:GetSizeY() + self._ui._stc_TopFuncBg:GetPosY()
    tempFrame:SetPosY(posY)
    local tempFrameSizeX = tempFrame:GetSizeX()
    local tempFrameSizeY = tempFrame:GetSizeY()
    local newSizeY = screenSizeY - posY - bottomUiSizeY
    tempFrame:SetSize(tempFrameSizeX, newSizeY)
    tempFrame:UpdateContentScroll()
    UIScroll.SetButtonSize(self._frameScroll[ii], tempFrame:GetSizeY(), tempFrame:GetFrameContent():GetSizeY())
    variedPosY = newSizeY - tempFrameSizeY
  end
  local tempFrame = self._deepeningSkill.frame
  local posY = tempFrame:GetPosY() + self._deepeningSkill.area:GetPosY()
  local tempFrameSizeX = tempFrame:GetSizeX()
  local tempFrameSizeY = tempFrame:GetSizeY()
  local newSizeY = screenSizeY - posY - bottomUiSizeY
  tempFrame:SetSize(tempFrameSizeX, newSizeY)
  self._ui._stc_bottomArea:SetPosY(screenSizeY - bottomUiSizeY)
  if false == self._ui._rdo_treeBg:GetShow() then
    local moveUpLength = self._ui._rdo_treeBg:GetSizeY()
    if -1 == self._deepeningFramePos then
      self._deepeningFramePos = tempFrame:GetPosY() - moveUpLength
    end
    if -1 < moveUpLength then
      tempFrame:SetPosY(self._deepeningFramePos)
      newSizeY = newSizeY + moveUpLength
      tempFrame:SetSize(tempFrameSizeX, newSizeY)
    end
  end
end
function PaGlobal_SkillGroup:createSubGroup()
  for ii = 0, self._subGroupSize - 1 do
    if nil == self._subGroupButton[ii] then
      self._subGroupButton[ii] = UI.cloneControl(self._subSkillGroupControl, self._frame[self.eTabIndex.weapon]:GetFrameContent(), "SkillSubGroupButton_" .. ii)
      self._subGroupButton[ii]:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup:updateFrameControls()")
      self._subGroupButton[ii]:SetCheck(true)
      self._isOpenedSubGroup[ii] = true
    end
  end
end
function PaGlobal_SkillGroup:updateSubGroup(subGroupNo, posY)
  if nil == subGroupNo or subGroupNo < 0 then
    _PA_ASSERT_NAME(false, "\234\184\176\236\136\160\236\157\132 \234\183\184\235\166\172\235\138\148 \236\164\145 subGroupNo\236\157\180 \235\185\132\236\160\149\236\131\129\236\160\129\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if self.eTabIndex.weapon ~= self._currentTab then
    return
  end
  self._subGroupButton[subGroupNo]:SetShow(true)
  self._subGroupButton[subGroupNo]:SetPosY(posY)
  local txt_subGroupName = UI.getChildControl(self._subGroupButton[subGroupNo], "StaticText_SkillSubName")
  txt_subGroupName:SetText(self:getSubGroupName(subGroupNo))
  self._isOpenedSubGroup[subGroupNo] = self._subGroupButton[subGroupNo]:IsCheck()
end
function PaGlobal_SkillGroup:CheckLearnAbleSkillCount()
  self._learnAbleSkillCount = 0
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local cellTable = {}
  local classType = selfPlayer:getClassType()
  if 0 <= classType then
    cellTable[0] = getCombatSkillTree(classType)
    cellTable[1] = getAwakeningWeaponSkillTree(classType)
    if PaGlobal_SuccessionSkill_IsCheckOpenContents() then
      cellTable[2] = getSuccessionSkillTree(classType)
    end
  else
    return
  end
  for iii = 0, #cellTable do
    if nil == cellTable[iii] then
      return
    end
    local cols = cellTable[iii]:capacityX()
    local rows = cellTable[iii]:capacityY()
    for row = 0, rows - 1 do
      for col = 0, cols - 1 do
        local cell = cellTable[iii]:atPointer(col, row)
        local skillNo = cell._skillNo
        if cell:isSkillType() then
          local skillLevelInfo = getSkillLevelInfo(skillNo)
          if skillLevelInfo._learnable then
            self._learnAbleSkillCount = self._learnAbleSkillCount + 1
          end
        end
      end
    end
  end
end
function PaGlobal_SkillGroup:skillpresetSetPosition()
  self._skillPreset.stc_presetBG:SetShow(true)
  self._skillPreset.btn_presetSave:SetShow(true)
  local currSlotCount = ToClient_getSkillPresetSlotCount()
  local slotCount = self._presetSlotMaxCount
  local btnSizeY = self._skillPreset.btnSizeY
  local intervalSizeY = self._skillPreset.intervalSizeY
  local startPosY = self._skillPreset.startPosY
  local bg_SizeY = self._skillPreset.bg_SizeY
  local btnPosX = self._skillPreset.btnPosX
  self._skillPreset.stc_presetBG:SetPosY(self._skillPreset.bg_PosY)
  self._skillPreset.stc_presetBG:SetPosY(startPosY)
  local tmp = self._skillPreset.stc_selectTab:GetSizeY()
  for index = 0, slotCount - 1 do
    local posY = tmp * (index + 1) + intervalSizeY
    local posX = self._skillPreset.stc_selectTab:GetPosX() + self._skillPreset.stc_selectTab:GetSizeX() / 2 - self._skillPreset.btn_preset[index]:GetSizeX() / 2
    self._skillPreset.btn_preset[index]:SetPosY(posY)
    self._skillPreset.btn_preset[index]:SetPosX(posX)
    if index < currSlotCount then
      self._skillPreset.btn_presetLock[index]:SetShow(false)
      self._skillPreset.btn_preset[index]:SetShow(true)
    else
      self._skillPreset.btn_presetLock[index]:SetShow(true)
      self._skillPreset.btn_preset[index]:SetShow(false)
    end
    self._skillPreset.btn_presetLock[index]:SetPosY(posY)
    self._skillPreset.btn_presetLock[index]:SetPosX(posX)
    PaGlobal_SkillWindow_SelectSkillPresetTextureSetting(index)
  end
  self._skillPreset.stc_presetBG:SetPosX(self._skillPreset.bg_PosX)
  self._skillPreset.stc_presetBG:SetSize(self._skillPreset.stc_selectTab:GetSizeX(), bg_SizeY)
  self._skillPreset.btn_presetSave:SetPosY(intervalSizeY)
  self._skillPreset.btn_presetSave:SetPosX(btnPosX)
  PaGlobal_SkillGroup:skillpresetSelectBtn()
end
function PaGlobal_SkillGroup:skillpresetExpansion(slotCount)
  if nil == slotCount then
    return
  end
  for index = 0, self._presetSlotMaxCount - 1 do
    if index < slotCount then
      self._skillPreset.btn_presetLock[index]:SetShow(false)
      self._skillPreset.btn_preset[index]:SetShow(true)
    else
      self._skillPreset.btn_presetLock[index]:SetShow(true)
      self._skillPreset.btn_preset[index]:SetShow(false)
    end
    PaGlobal_SkillWindow_SelectSkillPresetTextureSetting(index)
  end
end
function PaGlobal_SkillGroup:skillpresetEasyBuy()
  PaGlobal_EasyBuy:Open("81", nil, false)
end
function PaGlobal_SkillGroup:skillpresetToolTipShow(slotNo)
  local title = ""
  local message = ""
  local control
  if self._presetSlotMaxCount == slotNo then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_SAVE_TOOLTIP_NAME")
    message = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_SAVE_TOOLTIP_DESC")
    control = self._skillPreset.btn_presetSave
  else
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_DISK" .. tostring(slotNo + 1))
    message = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_TOOLTIP_DESC")
    control = self._skillPreset.btn_preset[slotNo]
  end
  TooltipSimple_Show(control, title, message)
end
function PaGlobal_SkillGroup:skillpresetToolTipHide()
  TooltipSimple_Hide()
end
function PaGlobal_SkillGroup:skillpresetLockToolTipShow(isShow, index)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_DISK" .. tostring(index + 1))
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_TOOLTIP_DESC")
  control = self._skillPreset.btn_presetLock[index]
  TooltipSimple_Show(control, title, desc)
end
function PaGlobal_SkillGroup:skillpresetSelectBtn()
  local slotNo = ToClient_getSkillPresetApplySlotNo()
  if -1 == slotNo then
    self._skillPreset.stc_selectTab:SetShow(false)
    return
  end
  local interval = (self._skillPreset.stc_selectTab:GetSizeY() - self._skillPreset.btn_presetSave:GetSizeY()) / 2
  self._skillPreset.stc_selectTab:SetShow(true)
  self._skillPreset.stc_selectTab:SetPosY(self._skillPreset.btn_preset[slotNo]:GetPosY() - interval)
end
function PaGlobal_SkillGroup:skillpresetSaveOpen()
  if true == _ContentsGroup_SkillPreset then
    PaGlobal_SkillPreset_Open(ToClient_getSkillPresetSlotCount())
  end
end
function PaGlobal_SkillGroup:SelectAwakenTree()
  self._selectedTree = __eSkillTypeParam_Awaken
  self._tree[0]._panel:AddEffect("fUI_NewSkill_AroUp_Bookmark_01B", false, 0, 0)
  audioPostEvent_SystemUi(27, 3)
end
function PaGlobal_SkillGroup:SelectSuccessionTree()
  self._selectedTree = __eSkillTypeParam_Inherit
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  if false == skillKey:isDefined() then
    return false
  end
  local skillNo = skillKey:getSkillNo()
  PaGlobal_SkillGroup:HandleEventLUpLearnSkill(skillNo, false)
  audioPostEvent_SystemUi(27, 3)
end
function PaGlobal_SkillGroup:clearTree()
  self._selectedTree = __eSkillTypeParam_Normal
  PaGlobal_SkillGroup:selectTree(-1)
end
function PaGlobal_SkillGroup:clickTree(index)
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local skillKey = 0
  if __eSkillTypeParam_Inherit == index then
    local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
    skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  elseif __eSkillTypeParam_Awaken == index then
    local awakenRoot = ToClient_getAwakenRootSkillGroupNo(classType)
    skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
  end
  if false == skillKey:isDefined() then
    return
  end
  local skillNo = skillKey:getSkillNo()
  PaGlobalFunc_SkillGroup_SelectType_Open(classType, index, skillNo)
end
function PaGlobal_SkillGroup:selectTree(index)
  if nil == self._tree then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  if nil ~= self._focusEffect then
    self._focusEffect:EraseAllEffect()
  end
  local classType = selfPlayerWrapper:getClassType()
  if 0 == self._isShowTreeSelectBookmark then
    return
  end
  PaGlobal_SkillGroup:updateTreeButton()
  if nil == index then
    return
  end
  if 0 == index then
    PaGlobal_SkillGroup:SelectAwakenTree()
  elseif 1 == index then
    PaGlobal_SkillGroup:SelectSuccessionTree()
  end
  PaGlobal_SkillGroup:updateTreeButton()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree, self._selectedTree + 1, CppEnums.VariableStorageType.eVariableStorageType_Character)
  PaGlobal_SkillGroup:update()
end
function PaGlobal_SkillGroup:updateTreeButton()
  for ii = 0, #self._tree do
    local isSelect = self._selectedTree - 1 == ii
    if true == isSelect then
      self._tree[ii]._currentStatus:SetShow(true)
    else
      self._tree[ii]._currentStatus:SetShow(false)
    end
    local control = self._tree[ii]._panel
    local normalUV = self._treeBtnTexture[isSelect].normalUV
    local onUV = self._treeBtnTexture[isSelect].onUV
    local clickUV = self._treeBtnTexture[isSelect].clickUV
    if true == isSelect then
      control:SetCheck(true)
    else
      control:SetUnchecked()
    end
  end
end
function PaGlobal_SkillGroup:HandleMRUp_SuccessionTreeButtonClick()
  if __eSkillTypeParam_Inherit ~= self._selectedTree then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  HandleMRUp_SkillGroupWindow_ClearButtonClick(skillKey:getSkillNo())
end
function PaGlobal_SkillGroup:HandleMRUp_AwakenTreeButtonClick()
  if __eSkillTypeParam_Awaken ~= self._selectedTree then
    return
  end
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if __eSkillTypeParam_Normal == playerSkillType then
    self._selectedTree = __eSkillTypeParam_Normal
    PaGlobal_SkillGroup:selectTree(-1)
  else
    Proc_ShowMessage_Ack(PAGetStringSymNo(3724093474))
  end
end
function PaGlobal_SkillGroup:checkIsViewTreeTabIcon()
  if 1 < self._isShowTreeSelectBookmark then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  if 0 == successionRoot then
    self._tree[0]._panel:SetShow(false)
    self._tree[0]._lock:SetShow(false)
    self._tree[1]._panel:SetShow(false)
    self._tree[1]._lock:SetShow(false)
    self._ui._rdo_treeBg:SetShow(false)
    self._isShowTreeSelectBookmark = 0
    return
  end
  local successionSkillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  local successionSkillNo = successionSkillKey:getSkillNo()
  local successionSkillSSW = getSkillStaticStatus(successionSkillNo, 1)
  local successionSkillTypeSSW = getSkillTypeStaticStatus(successionSkillNo)
  if nil == successionSkillSSW or false == successionSkillTypeSSW:isValidLocalizing() then
    self._tree[0]._panel:SetShow(false)
    self._tree[0]._lock:SetShow(false)
    self._tree[1]._panel:SetShow(false)
    self._tree[1]._lock:SetShow(false)
    self._ui._rdo_treeBg:SetShow(false)
    self._isShowTreeSelectBookmark = 0
    return
  end
  local awakenRoot = ToClient_getAwakenRootSkillGroupNo(classType)
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
  local skillNo = skillKey:getSkillNo()
  local isLearnedSkill = ToClient_isLearnedSkill(skillNo)
  if false == isLearnedSkill then
    self._tree[0]._panel:SetShow(false)
    self._tree[0]._lock:SetShow(true)
    self._tree[1]._panel:SetShow(false)
    self._tree[1]._lock:SetShow(true)
    self._isShowTreeSelectBookmark = 0
    return
  end
  skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  skillNo = skillKey:getSkillNo()
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local needSkill = skillSSW:getAllPreRequiredSkillNoList()
  local needSkillNo = needSkill[0]:getSkillNo()
  local isLearnedSkill = ToClient_isLearnedSkill(needSkillNo)
  if false == isLearnedSkill then
    self._tree[0]._panel:SetShow(true)
    self._tree[0]._lock:SetShow(false)
    self._tree[1]._panel:SetShow(false)
    self._tree[1]._lock:SetShow(true)
    self._isShowTreeSelectBookmark = 1
    return
  end
  self._tree[0]._panel:SetShow(true)
  self._tree[0]._lock:SetShow(false)
  self._tree[1]._panel:SetShow(true)
  self._tree[1]._lock:SetShow(false)
  self._isShowTreeSelectBookmark = 2
end
function PaGlobal_SkillGroup:initTreeTabIcon()
  local selfPlayerWrapper = getSelfPlayer()
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  local width = 0
  self._isShowTreeSelectBookmark = 0
  PaGlobal_SkillGroup:checkIsViewTreeTabIcon()
  for index = 0, #self._tree do
    local skillKey
    if 0 == index then
      local awakenRoot = ToClient_getAwakenRootSkillGroupNo(classType)
      skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
    elseif 1 == index then
      skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
    end
    if false == skillKey:isDefined() then
      return
    end
    local skillNo = skillKey:getSkillNo()
    local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
    if nil == skillTypeSSW then
      return
    end
    local panel = self._tree[index]._panel
    if false == skillTypeSSW:isValidLocalizing() then
      panel._isValidLocalizing = false
    else
      panel._isValidLocalizing = true
    end
    if 0 == index then
      self._tree[index]._panel:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup:HandleMRUp_AwakenTreeButtonClick()")
    elseif 1 == index then
      self._tree[index]._panel:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup:HandleMRUp_SuccessionTreeButtonClick()")
    end
    self._tree[index]._icon = UI.getChildControl(panel, "Static_SkillIcon")
    if nil ~= self._tree[index]._icon then
      self._tree[index]._icon:SetAlpha(1)
    end
  end
  self:selectTree()
end
function PaGlobal_SkillGroup:HandleMOn_AwakenTreeButtonOn(skillNo, index)
  HandleMOver_SkillWindow_ToolTipShow(skillNo, false, "SkillBox")
  PaGlobal_SkillGroup:unrollBookmark(index)
end
function PaGlobal_SkillGroup:HandleMOut_AwakenTreeButtonOut(skillNo, index)
  HandleMOver_SkillWindow_ToolTipHide(skillNo, "SkillBox")
  PaGlobal_SkillGroup:rollBookmark(index)
end
function PaGlobal_SkillGroup:HandleMOn_ControllerToggleButtonOn()
  TooltipSimple_Show(self._ui._stc_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_PLSYSKILLSHOW_TOOLTIP_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_PLSYSKILLSHOW_TOOLTIP_DESC"))
end
function PaGlobal_SkillGroup:HandleMOut_ControllerToggleButtonOut()
  TooltipSimple_Hide()
end
function PaGlobal_SkillGroup:HandleMOn_MovieButtonOn()
  TooltipSimple_Show(self._ui._stc_playShow, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_MOVIETOOLTIP"))
end
function PaGlobal_SkillGroup:HandleMOut_MovieButtonOut()
  TooltipSimple_Hide()
end
function PaGlobal_SkillGroup:HandleMOn_HelpButtonOn()
  TooltipSimple_Show(self._ui._stc_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_TOOLTIP_HELP_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_TOOLTIP_HELP_DESC"))
end
function PaGlobal_SkillGroup:HandleMOut_HelpButtonOut()
  TooltipSimple_Hide()
end
function PaGlobal_SkillGroup:HandleMOn_SearchButtonOn()
  TooltipSimple_Show(self._ui._stc_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SEARCH"))
end
function PaGlobal_SkillGroup:HandleMOut_SearchButtonOut()
  TooltipSimple_Hide()
end
function PaGlobal_SkillGroup:UpdateDeepeningSkillTopSlot()
  local isLearnFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCount(0) ~= 0
  if false == isLearnFusionSkill then
    return
  end
  local parent = self._deepeningSkill._stc_topArea
  for ii = 0, self._maxDeepeningSkillCount - 1 do
    if nil ~= parent._stc_skillIcon[ii] then
      local skillNo = ToClient_getFusionLearnSkillNo(ii)
      if 0 == skillNo then
        parent._stc_skillIcon[ii]:clearSkill()
        parent._stc_skillIcon[ii].icon:SetShow(false)
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_On", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_Out", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_PressMove", "")
        parent._stc_skillIcon[ii].icon:addInputEvent("Mouse_RUp", "")
        local fusionSkillNo = ToClient_getFusionSkillNo(ii, 0)
        if 0 ~= fusionSkillNo then
          local resultSkillStatic = getSkillStaticStatus(fusionSkillNo, 1)
          if nil ~= resultSkillStatic then
            local lv = resultSkillStatic:get()._needCharacterLevelForLearning
            local selfPlayerWrapper = getSelfPlayer()
            if nil ~= selfPlayerWrapper then
              local playerLevel = selfPlayerWrapper:get():getLevel()
              if lv <= playerLevel then
                parent._btn_plus[ii]:SetShow(true)
              else
                parent._btn_plus[ii]:SetShow(false)
              end
            end
          end
        end
      else
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        if nil == skillTypeStaticWrapper then
          return
        end
        if skillTypeStaticWrapper:isValidLocalizing() then
          local slot = self._deepeningSkill._stc_topArea._stc_skillIcon[ii]
          local btn_plus = self._deepeningSkill._stc_topArea._btn_plus[ii]
          if nil ~= slot then
            local skillTypeStatic = skillTypeStaticWrapper:get()
            slot:setSkillTypeStatic(skillTypeStaticWrapper)
            if nil ~= slot.learnButton then
              slot.learnButton:SetShow(false)
              slot.learnButton:SetIgnore(false)
            end
            btn_plus:SetShow(false)
            if nil ~= slot.icon then
              slot.icon:SetShow(true)
              slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SkillBox\")")
              slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
              slot.icon:addInputEvent("Mouse_RUp", "HandleMRUp_SkillGroupWindow_ClearButtonClick(" .. skillNo .. ")")
              slot.icon:addInputEvent("Mouse_PressMove", "HandleEventLUp_SkillGroup_StartDrag(" .. skillNo .. ")")
              slot.icon:SetEnableDragAndDrop(true)
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SkillGroup:skillPresetTextureSetting(slotNo)
  local control = self._skillPreset.btn_preset[slotNo]
  local normalUV, onUV, clickUV
  local texturePath = "Combine/Btn/Combine_Btn_01.dds"
  local isEmpty = Toclient_getSkillPresetSlotEmpty(slotNo)
  if true == isEmpty then
    normalUV = {
      x1 = 325,
      y1 = 396,
      x2 = 360,
      y2 = 431
    }
    onUV = {
      x1 = 325,
      y1 = 432,
      x2 = 360,
      y2 = 467
    }
    clickUV = {
      x1 = 325,
      y1 = 468,
      x2 = 360,
      y2 = 503
    }
  elseif 0 == slotNo then
    normalUV = {
      x1 = 325,
      y1 = 288,
      x2 = 360,
      y2 = 323
    }
    onUV = {
      x1 = 325,
      y1 = 324,
      x2 = 360,
      y2 = 359
    }
    clickUV = {
      x1 = 325,
      y1 = 360,
      x2 = 360,
      y2 = 395
    }
  elseif 1 == slotNo then
    normalUV = {
      x1 = 361,
      y1 = 288,
      x2 = 396,
      y2 = 323
    }
    onUV = {
      x1 = 361,
      y1 = 324,
      x2 = 396,
      y2 = 359
    }
    clickUV = {
      x1 = 361,
      y1 = 360,
      x2 = 396,
      y2 = 395
    }
  elseif 2 == slotNo then
    normalUV = {
      x1 = 397,
      y1 = 288,
      x2 = 432,
      y2 = 323
    }
    onUV = {
      x1 = 397,
      y1 = 324,
      x2 = 432,
      y2 = 359
    }
    clickUV = {
      x1 = 397,
      y1 = 360,
      x2 = 432,
      y2 = 395
    }
  elseif 3 == slotNo then
    normalUV = {
      x1 = 433,
      y1 = 288,
      x2 = 468,
      y2 = 323
    }
    onUV = {
      x1 = 433,
      y1 = 324,
      x2 = 468,
      y2 = 359
    }
    clickUV = {
      x1 = 433,
      y1 = 360,
      x2 = 468,
      y2 = 395
    }
  elseif 4 == slotNo then
    normalUV = {
      x1 = 469,
      y1 = 288,
      x2 = 504,
      y2 = 323
    }
    onUV = {
      x1 = 469,
      y1 = 324,
      x2 = 504,
      y2 = 359
    }
    clickUV = {
      x1 = 469,
      y1 = 360,
      x2 = 504,
      y2 = 359
    }
  end
  if nil == control or nil == normalUV or nil == onUV or nil == clickUV then
    return
  end
  control:ChangeTextureInfoName(texturePath)
  control:ChangeOnTextureInfoName(texturePath)
  control:ChangeClickTextureInfoName(texturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(control, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(control, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
  control:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(control, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_SkillGroup:skillpresetSaveNak(slotNo)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET" .. tostring(slotNo + 1) .. "_SAVE_ACK"))
  PaGlobal_SkillGroup:skillPresetTextureSetting(slotNo)
end
