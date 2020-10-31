function PaGlobalFunc_DialogList_All_Open()
  PaGlobal_DialogList_All:prepareOpen()
end
function PaGlobalFunc_DialogList_All_Close(showAni)
  PaGlobal_DialogList_All:prepareClose(showAni)
end
function HandleEventLUp_DialogList_All_ButtonClick(index)
  if nil == Panel_Dialog_List_All then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if nil == index then
    _PA_ASSERT_NAME(false, "HandleEventLUp_DialogList_All_ButtonClick\236\157\152 index\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  PaGlobalFunc_DialogKeyManager_All_SetClear(true, true, true, true)
  PaGlobalFunc_DialogMain_All_SetDialogStarting(true)
  PaGlobal_DialogList_All:clickList(index)
end
function HandleEventOnOut_DialogList_All_NeedItemTooltip(isShow, needItemKey, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == Panel_Dialog_List_All then
    return
  end
  if nil == needItemKey or nil == index then
    return
  end
  local itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
  Panel_Tooltip_Item_Show(itemStaticWrapper, Panel_Dialog_List_All, true, false, nil)
end
function HandleEventLUp_DialogList_All_SelectTab(index)
  if nil == PaGlobal_DialogList_All._ui.btn_splitRadiolist[index] then
    return
  end
  if true == PaGlobal_DialogList_All._ui.btn_splitRadiolist[index]:IsIgnore() then
    return
  end
  PaGlobal_DialogList_All._isQuestComplete = false
  PaGlobalFunc_DialogList_All_SetFilterOption(index)
end
function HandleEventKeyBoard_DialogList_All_MoveTab(value)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogState = tostring(dialogData:getDialogState())
  local isQuestList = dialogState == CppEnums.DialogState.eDialogState_QuestList
  local talker = dialog_getTalker()
  local isBlackSpirit = nil == talker
  if false == isBlackSpirit or false == isQuestList then
    return
  end
  if true == PaGlobal_DialogList_All._isConsole then
    ToClient_padSnapResetControl()
  end
  local findNextIndex = function(value, baseIndex)
    if -1 == value then
      for ii = baseIndex, 0, -1 do
        if true == PaGlobal_DialogList_All._moveAblelist[ii] then
          return ii
        end
      end
      return baseIndex - value
    else
      for ii = baseIndex, #PaGlobal_DialogList_All._moveAblelist do
        if true == PaGlobal_DialogList_All._moveAblelist[ii] then
          return ii
        end
      end
      return baseIndex + value
    end
  end
  local moveIndex = PaGlobal_DialogList_All._splitIdx + value
  if false == PaGlobal_DialogList_All._moveAblelist[moveIndex] then
    moveIndex = findNextIndex(value, moveIndex)
  end
  if moveIndex < 0 then
    moveIndex = 0
  elseif 3 < moveIndex then
    moveIndex = 3
  end
  HandleEventLUp_DialogList_All_SelectTab(moveIndex)
end
function PaGlobalFunc_DialogList_All_ShowAni()
  local moveAni = Panel_Dialog_List_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local uiOffsetX = 0
  local uiOffsetY = 0
  if true == PaGlobal_DialogExchange_All._isConsole then
    uiOffsetX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  end
  moveAni:SetStartPosition(getScreenSizeX(), Panel_Dialog_List_All:GetPosY())
  moveAni:SetEndPosition(getScreenSizeX() - Panel_Dialog_List_All:GetSizeX() - 20 + uiOffsetX, Panel_Dialog_List_All:GetPosY())
  moveAni.IsChangeChild = true
  if true == PaGlobal_DialogList_All._isConsole then
    Panel_Dialog_List_All:SetPosX(getScreenSizeX())
  end
end
function PaGlobalFunc_DialogList_All_HideAni()
  local moveAni = Panel_Dialog_List_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(Panel_Dialog_List_All:GetPosX(), Panel_Dialog_List_All:GetPosY())
  moveAni:SetEndPosition(getScreenSizeX(), Panel_Dialog_List_All:GetPosY())
  moveAni.IsChangeChild = true
  moveAni:SetHideAtEnd(true)
end
function FromClient_DialogList_All_OnScreenResize()
  if nil == Panel_Dialog_List_All then
    return
  end
  PaGlobal_DialogList_All:resize()
end
function PaGlobalFunc_DialogList_All_IsQuestComplete()
  return PaGlobal_DialogList_All._isQuestComplete
end
function PaGlobalFunc_DialogList_All_IsReContactDialog()
  if nil == Panel_Dialog_List_All then
    return false
  end
  return PaGlobal_DialogList_All._isReContactDialog
end
function PaGlobalFunc_DialogList_All_IsContactTalk()
  return PaGlobal_DialogList_All._isContactTalk
end
function PaGlobalFunc_DialogList_All_SetContactTalk(isContacted)
  PaGlobal_DialogList_All._isContactTalk = isContacted
end
function PaGlobalFunc_DialogList_All_Update()
  if nil == Panel_Dialog_List_All then
    return
  end
  PaGlobal_DialogList_All:updateDialog()
end
function PaGlobalFunc_DialogList_All_SetFilterButtonCount()
  if nil == Panel_Dialog_List_All then
    return
  end
  PaGlobal_DialogList_All._moveAblelist[0] = true
  for ii = 1, 3 do
    ToClient_SetFilterType(ii, true)
    local dialogData = ToClient_GetCurrentDialogData()
    if nil == dialogData then
      return
    end
    local dialogButtonCount = dialogData:getDialogButtonCount()
    PaGlobal_DialogList_All._ui.btn_splitRadiolist[ii]:SetText(PaGlobal_DialogList_All._btnSplitString[ii] .. "(" .. dialogButtonCount .. ")")
    PaGlobal_DialogList_All._ui.btn_splitRadiolist[ii]:SetIgnore(false)
    PaGlobal_DialogList_All._moveAblelist[ii] = true
    if 0 == dialogButtonCount then
      PaGlobal_DialogList_All._moveAblelist[ii] = false
      PaGlobal_DialogList_All._ui.btn_splitRadiolist[ii]:SetIgnore(true)
    end
  end
end
function PaGlobalFunc_DialogList_All_SetFilterOption(index)
  if nil == Panel_Dialog_List_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  if nil == index then
    return
  end
  ToClient_SetFilterType(index, true)
  PaGlobal_DialogList_All:changeFilterRadio(true)
  PaGlobal_DialogList_All:updateDialogList(dialogData)
  PaGlobal_DialogList_All._splitIdx = index
  for ii = 0, 3 do
    PaGlobal_DialogList_All._ui.btn_splitRadiolist[ii]:SetCheck(false)
  end
  local dialogButtonCount = dialogData:getDialogButtonCount()
  if dialogButtonCount <= 0 then
    if index == 0 then
      Proc_ShowMessage_Ack("\236\136\152\236\163\188 \234\176\128\235\138\165\237\149\156 \236\157\152\235\162\176\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
      return
    end
    HandleEventLUp_DialogList_All_SelectTab(PaGlobal_DialogList_All._SPLIT_IDX.ALL)
    return
  end
  PaGlobal_DialogList_All._ui.btn_splitRadiolist[index]:SetCheck(true)
  local selectBarPosX = PaGlobal_DialogList_All._ui.btn_splitRadiolist[index]:GetPosX() + PaGlobal_DialogList_All._ui.btn_splitRadiolist[index]:GetSizeX() / 2 - PaGlobal_DialogList_All._ui.stc_selectBar:GetSizeX() / 2
  PaGlobal_DialogList_All._ui.stc_selectBar:SetPosX(selectBarPosX)
end
function PaGlobalFunc_DialogList_All_SetMainQuest()
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  PaGlobal_DialogList_All:changeFilterRadio(false)
  ToClient_RefreshQuestList(true)
  PaGlobal_DialogList_All:updateDialogList(dialogData)
end
function PaGlobalFunc_DialogList_All_SetProposeToNpc()
  PaGlobalFunc_DialogList_All_Open()
  PaGlobal_DialogList_All:updateDialog(true)
end
function PaGlobalFunc_DialogList_All_IsVisibleButton(buttonValue)
  local dialogData = ToClient_GetCurrentDialogData()
  if dialogData ~= nil then
    local dialogButtonCount = dialogData:getDialogButtonCount()
    for i = 0, dialogButtonCount - 1 do
      local dialogButton = dialogData:getDialogButtonAt(i)
      if dialogButton ~= nil and buttonValue == tostring(dialogButton._linkType) then
        return true
      end
    end
  end
  return false
end
function PaGlobalFunc_DialogList_All_UdpateTalkButtonlist(control, key)
  PaGlobal_DialogList_All:dialogTalkControlSet(control, key)
end
function PaGlobalFunc_DialogList_All_UdpateQuestButtonlist(control, key)
  PaGlobal_DialogList_All:dialogQuestControlSet(control, key)
end
function PaGlobalFunc_DialogList_All_UdpateHelpButtonlist(control, key)
  PaGlobal_DialogList_All:dialogHelpControlSet(control, key)
end
