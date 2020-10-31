PaGlobal_DialogKeyManager_All = {
  _CONFIRM_KEY = CppEnums.ActionInputType.ActionInputType_Interaction,
  _SHORTCUT_KEY = {
    CppEnums.ActionInputType.ActionInputType_MoveFront,
    CppEnums.ActionInputType.ActionInputType_MoveBack,
    CppEnums.ActionInputType.ActionInputType_MoveLeft,
    CppEnums.ActionInputType.ActionInputType_MoveRight
  },
  _hotKeyInfo = {},
  _overIndex = -1,
  _dialogEnableList = {},
  _isShowSpacebarIcon = false,
  _beforeEnableIndex = -1,
  _isGamePad = false,
  _scrollDownOffset = 7,
  _targetPanel = nil,
  _targetList = nil,
  _targetBtnName = nil,
  _targetSpaceName = nil
}
function PaGlobalFunc_DialogKeyManager_All_SetConfirmFunc(confirmfunc)
  PaGlobal_DialogKeyManager_All._hotKeyInfo[PaGlobal_DialogKeyManager_All._CONFIRM_KEY] = {}
  PaGlobal_DialogKeyManager_All._hotKeyInfo[PaGlobal_DialogKeyManager_All._CONFIRM_KEY].func = confirmfunc
  PaGlobal_DialogKeyManager_All._hotKeyInfo[PaGlobal_DialogKeyManager_All._CONFIRM_KEY].type = "confirmKey"
  for index, key in pairs(PaGlobal_DialogKeyManager_All._SHORTCUT_KEY) do
    PaGlobal_DialogKeyManager_All._hotKeyInfo[key] = {}
    PaGlobal_DialogKeyManager_All._hotKeyInfo[key].func = HandleEventKeyBoard_DialogKeyManager_All_ArrowKey
    PaGlobal_DialogKeyManager_All._hotKeyInfo[key].type = "arrowKey"
  end
end
function PaGlobalFunc_DialogKeyManager_All_SetTarget(panel, list, btnName, spaceName)
  PaGlobal_DialogKeyManager_All._targetPanel = panel
  PaGlobal_DialogKeyManager_All._targetList = list
  PaGlobal_DialogKeyManager_All._targetBtnName = btnName
  PaGlobal_DialogKeyManager_All._targetSpaceName = spaceName
end
function PaGlobalFunc_DialogKeyManager_All_EnableListPush(index)
  local isExist = false
  for idx = 1, #PaGlobal_DialogKeyManager_All._dialogEnableList do
    if PaGlobal_DialogKeyManager_All._dialogEnableList[idx] == index then
      isExist = true
    end
  end
  if false == isExist then
    PaGlobal_DialogKeyManager_All._dialogEnableList[#PaGlobal_DialogKeyManager_All._dialogEnableList + 1] = index
  end
  if -1 == PaGlobal_DialogKeyManager_All._overIndex and #PaGlobal_DialogKeyManager_All._dialogEnableList > 0 then
    PaGlobal_DialogKeyManager_All._overIndex = PaGlobal_DialogKeyManager_All._dialogEnableList[1]
    PaGlobal_DialogKeyManager_All._isShowSpacebarIcon = true
  elseif index == PaGlobal_DialogKeyManager_All._overIndex then
    PaGlobal_DialogKeyManager_All._isShowSpacebarIcon = true
  end
end
function PaGlobalFunc_DialogKeyManager_All_EnableKeyShow()
  if -1 == PaGlobal_DialogKeyManager_All._overIndex or nil == PaGlobal_DialogKeyManager_All._overIndex then
    return
  end
  if nil == PaGlobal_DialogKeyManager_All._targetList then
    return
  end
  if true == _ContentsGroup_RenewUI then
    return
  end
  local key = toInt64(0, PaGlobal_DialogKeyManager_All._overIndex + 1)
  local control = PaGlobal_DialogKeyManager_All._targetList:GetContentByKey(key)
  if nil == control then
    return
  end
  local btn_Dialog = UI.getChildControl(control, PaGlobal_DialogKeyManager_All._targetBtnName)
  local stc_spacebarIcon = UI.getChildControl(control, PaGlobal_DialogKeyManager_All._targetSpaceName)
  btn_Dialog:SetCheck(true)
  stc_spacebarIcon:SetShow(true)
end
function PaGlobalFunc_DialogKeyManager_All_SetClear(isPanelClear, isOverClear, isListClear, isSpaceClear)
  if true == isPanelClear then
    PaGlobal_DialogKeyManager_All._targetPanel = nil
    PaGlobal_DialogKeyManager_All._targetList = nil
    PaGlobal_DialogKeyManager_All._targetBtnName = nil
    PaGlobal_DialogKeyManager_All._targetSpaceName = nil
  end
  if true == isOverClear then
    PaGlobal_DialogKeyManager_All._overIndex = -1
  end
  if true == isListClear then
    PaGlobal_DialogKeyManager_All._dialogEnableList = {}
  end
  if true == isSpaceClear then
    PaGlobal_DialogKeyManager_All._isShowSpacebarIcon = false
  end
end
function HandleEventKeyBoard_DialogManager_All_KeyPushCheck()
  if nil == PaGlobal_DialogKeyManager_All._targetPanel then
    return false
  end
  if true == Panel_NumberPad_IsPopUp() then
    return false
  end
  if true == PaGlobalFunc_DialogMain_All_GetShowNextBtn() or true == PaGlobalFunc_DialogMain_All_GetShowContinueBtn() then
    return false
  end
  if true == PaGlobal_DialogKeyManager_All._targetPanel:GetShow() and true == PaGlobal_DialogKeyManager_All:checkPressedHotKey() then
    return true
  end
  return false
end
function PaGlobal_DialogKeyManager_All:checkPressedHotKey()
  local function SaveOverIndex(overIdx)
    for idx = 1, #self._dialogEnableList do
      if self._dialogEnableList[idx] == self._overIndex then
        self._beforeEnableIndex = idx
        break
      end
    end
  end
  for index, funcGroup in pairs(self._hotKeyInfo) do
    if true == keyCustom_IsDownOnce_Action(index) then
      setUiInputProcessed(index)
      if nil ~= funcGroup and nil ~= funcGroup.func and nil ~= funcGroup.type then
        if funcGroup.type == "confirmKey" and -1 ~= self._overIndex then
          SaveOverIndex(self._overIndex)
          funcGroup.func(self._overIndex)
          return true
        elseif funcGroup.type == "arrowKey" and false == PaGlobalFunc_DialogKeyManager_All_GetGamePadEnable() then
          funcGroup.func(index)
          return true
        end
      end
    end
  end
  return false
end
function HandleEventKeyBoard_DialogKeyManager_All_ArrowKey(keycode)
  if nil == keycode then
    return
  end
  PaGlobal_DialogKeyManager_All:pressedArrowKey(keycode)
end
function PaGlobal_DialogKeyManager_All:pressedArrowKey(keycode)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogState = tostring(dialogData:getDialogState())
  local isQuestList = dialogState == CppEnums.DialogState.eDialogState_QuestList
  local talker = dialog_getTalker()
  local isBlackSpirit = nil == talker
  if keycode == CppEnums.ActionInputType.ActionInputType_MoveFront then
    self:listKeyboardMove("up")
  elseif keycode == CppEnums.ActionInputType.ActionInputType_MoveBack then
    self:listKeyboardMove("down")
  elseif keycode == CppEnums.ActionInputType.ActionInputType_MoveLeft then
    HandleEventKeyBoard_DialogList_All_MoveTab(-1)
  elseif keycode == CppEnums.ActionInputType.ActionInputType_MoveRight then
    HandleEventKeyBoard_DialogList_All_MoveTab(1)
  end
end
function PaGlobal_DialogKeyManager_All:listKeyboardMove(moveType)
  if nil == moveType then
    return
  end
  if nil == self._targetPanel or nil == self._targetList or nil == self._targetBtnName or nil == self._targetSpaceName then
    _PA_ASSERT_NAME(false, "DialogKeybinderManager\236\151\144 targer \236\132\164\236\160\149\236\157\180 \235\144\152\236\150\180\236\158\136\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local beforeIdx = self._overIndex
  local function moveEnable()
    local enableIdx = -1
    for idx = 1, #self._dialogEnableList do
      if self._dialogEnableList[idx] == beforeIdx then
        enableIdx = idx
        self._beforeEnableIndex = idx
        break
      end
    end
    if -1 == enableIdx then
      if moveType == "up" and nil ~= self._dialogEnableList[self._beforeEnableIndex - 1] then
        return self._dialogEnableList[self._beforeEnableIndex - 1]
      elseif moveType == "down" and nil ~= self._dialogEnableList[self._beforeEnableIndex] then
        return self._dialogEnableList[self._beforeEnableIndex]
      elseif nil ~= self._dialogEnableList[1] then
        return self._dialogEnableList[1]
      else
        return false
      end
    end
    if moveType == "up" then
      if enableIdx - 1 >= 0 then
        return self._dialogEnableList[enableIdx - 1]
      else
        return false
      end
    elseif moveType == "down" then
      if enableIdx + 1 <= #self._dialogEnableList then
        return self._dialogEnableList[enableIdx + 1]
      else
        return false
      end
    end
    return false
  end
  local function moveControl(moveIdx, setCheck)
    local key = toInt64(0, moveIdx + 1)
    local control = self._targetList:GetContentByKey(key)
    if nil == control then
      return
    end
    local btn_Dialog = UI.getChildControl(control, PaGlobal_DialogKeyManager_All._targetBtnName)
    local stc_spacebarIcon = UI.getChildControl(control, PaGlobal_DialogKeyManager_All._targetSpaceName)
    btn_Dialog:SetCheck(setCheck)
    stc_spacebarIcon:SetShow(setCheck)
  end
  local afterIdx = moveEnable()
  if false == afterIdx or nil == afterIdx or -1 == beforeIdx then
    return
  end
  moveControl(beforeIdx, false)
  moveControl(afterIdx, true)
  self._overIndex = afterIdx
  if moveType == "down" then
    if self._overIndex % self._scrollDownOffset == 0 then
      self._targetList:moveIndex(self._overIndex)
    end
  elseif moveType == "up" then
    self._targetList:moveIndex(self._overIndex)
  end
end
function PaGlobalFunc_DialogKeyManager_All_IsShowSpaceBarIcon()
  return PaGlobal_DialogKeyManager_All._isShowSpacebarIcon
end
function PaGlobalFunc_DialogListManager_All_GetOverIndex()
  return PaGlobal_DialogKeyManager_All._overIndex
end
function PaGlobalFunc_DialogKeyManager_All_SetGamePadEnable(isUsed)
  PaGlobal_DialogKeyManager_All._isGamePad = isUsed
end
function PaGlobalFunc_DialogKeyManager_All_GetGamePadEnable()
  return PaGlobal_DialogKeyManager_All._isGamePad
end
function PaGlobalFunc_DialogKeyManager_All_MClickExchangelist(index)
  PaGlobal_DialogKeyManager_All._beforeEnableIndex = index
  PaGlobal_DialogKeyManager_All._overIndex = index
end
