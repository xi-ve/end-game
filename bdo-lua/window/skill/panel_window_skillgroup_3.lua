function PaGlobalFunc_SkillGroup_PreRenderMode()
end
function PaGlobalFunc_SkillGroup_CloseRenderMode()
  PaGlobal_SkillGroup:close()
end
function PaGlobalFunc_SkillGroup_Close()
  if true == Panel_Window_SkillGroup_SelectType:GetShow() then
    PaGlobal_SkillGroup_SelectType:close()
    return
  end
  if true == Panel_SkillGroup_CoolTimeSlot:GetShow() then
    PaGlobal_SkillGroup_CoolTimeSlot:close()
    return
  end
  if true == Panel_Window_BlackSpiritSkillLock_All:GetShow() then
    PaGlobal_BlackSpiritSkillLock_All:prepareClose()
    return
  end
  if nil ~= FGlobal_WebHelper_ForceClose and true == Panel_WebControl:GetShow() then
    FGlobal_WebHelper_ForceClose()
    return
  end
  if true == self._isEditMode then
    self:updateEditMode(false)
    return
  end
  audioPostEvent_SystemUi(1, 17)
  PaGlobal_SkillGroup:close()
end
function PaGlobalFunc_SkillGroup_HotKeyToggle()
  if true == Panel_Window_SkillGroup:IsShow() then
    audioPostEvent_SystemUi(1, 17)
    PaGlobal_SkillGroup:close()
  else
    audioPostEvent_SystemUi(1, 18)
    PaGlobal_SkillGroup:open()
  end
end
function HandleMLUp_SkillWindow_Close(isManualClick)
  PaGlobal_SkillGroup:close()
end
function HandleEventLUp_SkillGroup_StartDrag(skillNo)
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  PaGlobal_SkillGroup._isDraggingFromTree = true
  if nil ~= skillLevelInfo and nil ~= skillTypeStaticWrapper then
    DragManager:setDragInfo(Panel_Window_SkillGroup, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), SkillGroup_GroundClick, nil)
    if false == PaGlobal_SkillGroup._isEditMode then
      PaGlobal_SkillGroup:HandleEventLUp_EditMode()
    end
  end
end
function HandleMLUp_SkillWindow_OpenForLearn(tabIndex)
  if false == Panel_Window_SkillGroup:GetShow() then
    PaGlobal_SkillGroup:open()
  end
  PaGlobal_SkillGroup:selectTab(tabIndex)
end
function HandleMRUp_SkillGroupWindow_ClearButtonClick(skillNo)
  local isPressShift = false
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isPressShift = true
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == isPressShift then
    local returnValue = ToClient_RequestClearSkillPartly(skillNo)
    if 0 == returnValue then
      ToClient_clearSkillCoolTimeSlot(skillNo)
      PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
      local skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
      if nil ~= skillGroup then
        PaGlobal_SkillGroup._clearSkillGroupNo = skillGroup._key
      end
    end
  else
    local skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
    if nil ~= skillGroup then
      local returnValue = ToClient_doClearSkillGroup(skillGroup._key)
      if true == returnValue then
        ToClient_clearSkillCoolTimeSlot(skillNo)
        PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
        PaGlobal_SkillGroup._clearSkillGroupNo = skillGroup._key
      end
    else
      local returnValue = ToClient_RequestClearSkillPartly(skillNo)
      if 0 == returnValue then
        ToClient_clearSkillCoolTimeSlot(skillNo)
        PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
        local skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(skillNo)
        if nil ~= skillGroup then
          PaGlobal_SkillGroup._clearSkillGroupNo = skillGroup._key
        end
      end
    end
  end
end
function FromClient_BeforeSelectSkillLevel()
  local self = PaGlobal_SkillGroup
  if self._currentTab == 3 then
    Panel_SkillTooltip_Hide()
    return
  end
  if nil ~= self._mouseOnSkillGroupNo and -1 ~= self._mouseOnSkillGroupNo then
    local skillGroup = self._skillGroupList[self._mouseOnSkillGroupNo]
    local currentGroupLevel = skillGroup:getCurrentGroupLevel()
    local nextSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroup._key, currentGroupLevel)
    if false == nextSkillKey:isDefined() then
      return
    end
    local nextSkillNo = nextSkillKey:getSkillNo()
    PaGloabl_SkillGroup_ShowDesc(nextSkillNo)
    skillGroup:selectLevel(currentGroupLevel)
    Panel_SkillTooltip_Show(nextSkillNo, true, "SkillBox")
    self:HandleMOver_SkillGroupOn(self._mouseOnSkillGroupNo)
  else
    Panel_SkillTooltip_Hide()
  end
end
function SkillGroup_GroundClick(whereType, skillKey)
  if isUseNewQuickSlot() then
    FGlobal_SetNewQuickSlot_BySkillGroundClick(skillKey)
  end
end
function PaGlobalFunc_SkillGroup_KeyBoardMoveLevel()
  if Defines.UIMode.eUIMode_SkillWindow ~= GetUIMode() or false == Panel_Window_SkillGroup:GetShow() then
    return false
  end
  if 0 == PaGlobal_SkillGroup._selectSkillNo or nil == PaGlobal_SkillGroup._selectSkillNo then
    return false
  end
  if 0 == PaGlobal_SkillGroup._selectKey or nil == PaGlobal_SkillGroup._selectKey then
    return false
  end
  if true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_LEFT) then
    PaGlobal_SkillGroup:HandleEventLUp_PrevLevelButton(PaGlobal_SkillGroup._selectKey)
    return true
  elseif true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_RIGHT) then
    PaGlobal_SkillGroup:HandleEventLUp_NextLevelButton(PaGlobal_SkillGroup._selectKey)
    return true
  end
  return false
end
function PaGlobalFunc_SkillGroup_KeyBoardTabEvent()
  if true == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_TAB) then
    if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_CONTROL) then
      PaGlobal_SkillGroup:selectPrevTab()
      return true
    else
      PaGlobal_SkillGroup:selectNextTab()
      return true
    end
  end
  return false
end
function FromClient_SkillGroupWindow_ClearSkills()
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
  PaGlobal_SkillGroup:updateDeepeningControl()
  if __eSkillTypeParam_Normal ~= PaGlobal_SkillGroup._isChangingTree then
    if __eSkillTypeParam_Inherit == PaGlobal_SkillGroup._isChangingTree then
      PaGlobal_SkillGroup:clearTree()
      PaGlobal_SkillGroup:selectTree(0)
      PaGlobal_SkillGroup._isChangingTree = __eSkillTypeParam_Normal
      return
    elseif __eSkillTypeParam_Awaken == PaGlobal_SkillGroup._isChangingTree then
      PaGlobal_SkillGroup:clearTree()
      PaGlobal_SkillGroup:selectTree(1)
      PaGlobal_SkillGroup._isChangingTree = __eSkillTypeParam_Normal
      return
    end
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_RESETSUCCESS"))
  PaGlobal_SkillGroup:clearTree()
  PaGlobal_SkillGroup._isChangingTree = __eSkillTypeParam_Normal
end
function FromClient_SkillGroupWindow_ClearSkillByPoint()
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if __eSkillTypeParam_Awaken ~= PaGlobal_SkillGroup._selectedTree then
    PaGlobal_SkillGroup._selectedTree = playerSkillType
  end
  PaGlobal_SkillGroup:selectTree(-1)
  PaGlobal_SkillGroup:ShowGroupLearnLastSkillByGroupKey(PaGlobal_SkillGroup._clearSkillGroupNo)
end
function FromClient_SkillGroupWindow_Update()
  PaGlobal_SkillGroup:CheckLearnAbleSkillCount()
  PaGlobal_SkillGroup:update()
end
function FromClient_SkillGroupWindow_AllUpdate()
  local beforeTree = PaGlobal_SkillGroup._selectedTree
  PaGlobal_SkillGroup:resetSlot()
  PaGlobal_SkillGroup:CheckLearnAbleSkillCount()
  PaGlobal_SkillGroup:UpdateDeepeningSkillTopSlot()
  PaGlobal_SkillGroup:resetTree()
  PaGlobal_SkillGroup:selectTree(-1)
  if beforeTree ~= PaGlobal_SkillGroup._selectedTree and __eSkillTypeParam_Awaken == PaGlobal_SkillGroup._selectedTree then
    PaGlobal_SkillGroup._tree[0]._panel:AddEffect("fUI_NewSkill_AroUp_Bookmark_01B", false, 0, 0)
    audioPostEvent_SystemUi(27, 3)
  elseif beforeTree ~= PaGlobal_SkillGroup._selectedTree and __eSkillTypeParam_Inherit == PaGlobal_SkillGroup._selectedTree then
    PaGlobal_SkillGroup._tree[1]._panel:AddEffect("fUI_NewSkill_AroUp_Bookmark_01A", false, 0, 0)
    audioPostEvent_SystemUi(27, 3)
  end
  PaGlobal_SkillGroup:update()
  PaGlobal_SkillGroup:skillpresetSelectBtn()
  PaGlobal_SkillGroup_CoolTimeSlot:skillUpdate()
  QuickSlot_UpdateData()
  local slotNo = ToClient_getSkillPresetApplySlotNo() + 1
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILLPRESET_CHANGE_SETTING", "number", tostring(slotNo)))
end
function FromClient_SkillAndPresetClearConfirm()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLANDPRESET_CLEAR_CONFIRM"),
    functionYes = PaGlobalFunc_SkillGroup_RequesetSkillAndPresetClear,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_SkillGroup_RequesetSkillAndPresetClear()
  Toclient_requesetSkillAndPresetClear()
end
function FromClient_SkillAndPresetClear()
  PaGlobal_SkillGroup:resetSlot()
  PaGlobal_SkillGroup:CheckLearnAbleSkillCount()
  PaGlobal_SkillGroup:UpdateDeepeningSkillTopSlot()
  PaGlobal_SkillGroup:resetTree()
  PaGlobal_SkillGroup:selectTree(-1)
  PaGlobal_SkillGroup:update()
  PaGlobal_SkillGroup:skillpresetExpansion(ToClient_getSkillPresetSlotCount())
  PaGlobal_SkillGroup:skillpresetSelectBtn()
  QuickSlot_UpdateData()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLANDPRESET_CLEAR"))
end
function FromClient_SkillGroupWindow_Close()
end
function FromClient_SkillGroupSkillPointUpdate()
  if false == Panel_Window_SkillGroup:GetShow() then
    return
  end
  PaGlobal_SkillGroup:update()
end
function FromClient_SkillGroupLearnedSkill(skillNo)
  UI.ASSERT(nil ~= skillNo, "FromClient_SkillGroupLearnedSkill - skillNo\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
  PaGlobal_SkillGroup:learnSkill(skillNo)
end
function FromClient_responseLearnDeepeningSkill(skillNo, slotIndex)
  PaGlobal_SkillGroup:LearnDeepeningSkill(skillNo, slotIndex)
end
function FromClient_responseClearDeepeningSkill()
  PaGlobal_SkillGroup:ClearDeepeningSkill()
end
function PaGlobalFunc_SkillGroup_GetMouseOnSkillGroupNo()
  local skillGroup = PaGlobal_SkillGroup._skillGroupList[PaGlobal_SkillGroup._mouseOnSkillGroupNo]
  local currentLevel
  if nil ~= skillGroup then
    currentLevel = skillGroup:getSelectSkillLevel()
  end
  return PaGlobal_SkillGroup._mouseOnSkillGroupNo, currentLevel
end
function tempFuncTestDeepeningSkill()
  ToClient_requestLearnFusionSkill(2737, 1093, 1105)
end
function enableSkill_UpdateData(isEdit)
end
function FGlobal_EnableSkillReturn()
  return PaGlobal_SkillGroup._learnAbleSkillCount
end
function PaGlobal_SkillWindow_SkillFocusEffect(SkillNo, isLevelupEffect, effectType)
  if nil == isLevelupEffect then
    isLevelupEffect = false
  end
  PaGlobal_SkillGroup._isLevelupEffect = isLevelupEffect
  local needSkill = getSkillStaticStatus(SkillNo, 1)
  if nil ~= needSkill then
    local skillGroup = PaGlobal_SkillGroup:GetSkillGroupBySkillNo(SkillNo)
    if nil ~= skillGroup then
      local needSkillType = needSkill:getSkillAwakenBranchType()
      PaGlobal_SkillGroup:SkillGroupWindowEffect(skillGroup:getPosX(), skillGroup:getPosY(), skillGroup, true, needSkillType, effectType)
      return true
    end
  end
  return false
end
function SkillWindow_PlayerLearnableSkill()
  PaGlobal_SkillGroup:SkillWindow_PlayerLearnableSkill()
end
function SkillWindow_GetLearnSkillAlert(skillLevelInfo, branchType)
  if nil ~= branchType and __eSkillTypeParam_Inherit == branchType then
    if false == _ContentsGroup_Succession then
      return ""
    end
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return ""
    end
    if false == PaGlobal_SuccessionSkill.classSuccessionSkill[selfPlayer:getClassType()] then
      return ""
    end
  end
  if nil == skillLevelInfo then
    return ""
  end
  local needSkillString = ""
  local forbidSkillString = ""
  local resultString = ""
  local SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo1, 1)
  if nil ~= SkillStaticWrapper and false == ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo()) then
    needSkillString = SkillStaticWrapper:getName()
  end
  SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo2, 1)
  if nil ~= SkillStaticWrapper and false == ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo()) then
    if needSkillString ~= "" then
      needSkillString = needSkillString .. ", "
    end
    needSkillString = needSkillString .. SkillStaticWrapper:getName()
  end
  local index = 0
  local currentForbidSkillString = ""
  while true do
    local skillNo = skillLevelInfo:atValue(index)
    if 0 == skillNo or 10 < index then
      break
    end
    SkillStaticWrapper = getSkillStaticStatus(skillNo, 1)
    if nil ~= SkillStaticWrapper and true == ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo()) then
      currentForbidSkillString = SkillStaticWrapper:getName()
      if "" ~= currentForbidSkillString then
        if "" == forbidSkillString then
          forbidSkillString = currentForbidSkillString
        else
          forbidSkillString = forbidSkillString .. ", " .. currentForbidSkillString
        end
      end
    end
    index = index + 1
  end
  if "" ~= needSkillString then
    resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_01", "SkillName", needSkillString)
  end
  if "" ~= forbidSkillString then
    if "" == resultString then
      resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    else
      resultString = resultString .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    end
  end
  return resultString
end
function PaGlobal_SkillWindow_SelectSkillPresetBtn()
  PaGlobal_SkillGroup:skillpresetSelectBtn()
end
function PaGlobal_SkillWindow_SelectSkillPresetTextureSetting(slotNo)
  PaGlobal_SkillGroup:skillPresetTextureSetting(slotNo)
end
function HandleMLUp_SkillWindow_SkillPresetEasyBuy()
  PaGlobal_SkillGroup:skillpresetEasyBuy()
end
function HandleMOver_SkillWindow_SkillPresetToolTipShow(slotNo)
  PaGlobal_SkillGroup:skillpresetToolTipShow(slotNo)
end
function HandleMOver_SkillWindow_SkillPresetToolTipHide()
  PaGlobal_SkillGroup:skillpresetToolTipHide()
end
function HandleMLUp_SkillWindow_SkillPresetSaveOpen()
  if ToClient_getSkillPresetSlotCount() <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_SAVE_NOPRESET"))
  else
    PaGlobal_SkillGroup:skillpresetSaveOpen()
  end
end
function FromClient_SkillPresetSaveMessage(slotNo)
  PaGlobal_SkillGroup:skillpresetSaveNak(slotNo)
end
local classJinSkill = {
  [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("926"),
  [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("927"),
  [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("928"),
  [__eClassType_Giant] = ToClient_IsContentsGroupOpen("929"),
  [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("930"),
  [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("931"),
  [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("932"),
  [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("933"),
  [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("934"),
  [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("935"),
  [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("936"),
  [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("937"),
  [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("938"),
  [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("939"),
  [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("940"),
  [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("941"),
  [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("944"),
  [__eClassType_ShyWaman] = false,
  [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1320"),
  [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1137")
}
function PaGlobal_JinSkill_IsCheckOpenContents()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  return classJinSkill[selfPlayer:getClassType()]
end
function PaGlobal_SkillGroup_learnSkill_UpdatePerFrame_For_Effect(deltaTime)
  PaGlobal_SkillGroup:learnSkill_UpdatePerFrame_For_Effect(deltaTime)
end
function FromClient_responseSkillPresetSlotExpansion(slotCount)
  PaGlobal_SkillGroup:skillpresetExpansion(slotCount)
end
registerEvent("EventSkillWindowClearSkillByPoint", "FromClient_BeforeSelectSkillLevel")
