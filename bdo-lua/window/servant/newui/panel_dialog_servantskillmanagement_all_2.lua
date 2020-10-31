function PaGlobalFunc_ServantSkillManagement_All_Open(currentServantNo)
  if nil == Panel_Dialog_ServantSkillManagement_All or true == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  if nil == currentServantNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_STABLE_ALERT"))
    return
  end
  PaGlobal_ServantSkillManagement_All._currentServantNo = currentServantNo
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  PaGlobal_ServantSkillManagement_All._currentServantInfo = servantInfo
  PaGlobal_ServantSkillManagement_All:prepareOpen()
end
function PaGlobalFunc_ServantSkillManagement_All_Close()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  PaGlobal_ServantSkillManagement_All:prepareClose()
end
function FromClient_ServantSkillManagement_All_OnScreenResize()
  PaGlobal_ServantSkillManagement_All:resize()
end
function HandleEventLUp_ServantSkillManagement_All_TabChange(idx)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == idx then
    return
  end
  local selectedTab
  if 0 == idx then
    PaGlobal_ServantSkillManagement_All._tabType = PaGlobal_ServantSkillManagement_All._eType.learn
    selectedTab = PaGlobal_ServantSkillManagement_All._ui._rdo_LearnedSkill
    PaGlobal_ServantSkillManagement_All._ui._stc_LearnSkillBg:SetShow(true)
    PaGlobal_ServantSkillManagement_All._ui._stc_Center_WishSKillBg:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._rdo_WishSkill:SetCheck(false)
    if true == PaGlobal_ServantList_All._isConsole then
      PaGlobal_ServantSkillManagement_All._ui._stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_CHANGESKILL_TRAINALL"))
      Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantSkillManagement_All_TrainingSkillAll()")
      PaGlobal_ServantSkillManagement_All._ui_stc_KeyGuide_Scroll:SetShow(true)
    end
  else
    PaGlobal_ServantSkillManagement_All._tabType = PaGlobal_ServantSkillManagement_All._eType.notLearn
    selectedTab = PaGlobal_ServantSkillManagement_All._ui._rdo_WishSkill
    PaGlobal_ServantSkillManagement_All._ui._stc_LearnSkillBg:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Center_WishSKillBg:SetShow(true)
    PaGlobal_ServantSkillManagement_All._ui._rdo_LearnedSkill:SetCheck(false)
    if true == PaGlobal_ServantList_All._isConsole then
      PaGlobal_ServantSkillManagement_All._ui._stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_CHANGESKILLSELECT_TITLE"))
      Panel_Dialog_ServantSkillManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantSkillManagement_All_SkillChange()")
      PaGlobal_ServantSkillManagement_All._ui_stc_KeyGuide_Scroll:SetShow(false)
    end
  end
  PaGlobal_ServantSkillManagement_All:alignKeyGuide()
  PaGlobal_ServantSkillManagement_All:resize()
  PaGlobal_ServantSkillManagement_All:dataClear()
  PaGlobal_ServantSkillManagement_All:update(idx)
  if nil ~= selectedTab then
    local tabSpanX = selectedTab:GetSpanSize().x
    local selectBar = PaGlobal_ServantSkillManagement_All._ui._stc_SelectedLine
    local selectBarY = selectBar:GetSpanSize().y
    selectBar:SetSpanSize(tabSpanX, selectBarY)
  end
  if true == PaGlobal_ServantList_All._isConsole then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_ServantSkillManagement_All._keyguides, PaGlobal_ServantSkillManagement_All._ui._stc_BottomBg_Console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function FromClient_ServantSkillManagement_All_List2_LeranedSKillUpdate(content, key)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  PaGlobal_ServantSkillManagement_All:updateList2_LearnedSKillTab(content, key)
end
function FromClient_ServantSkillManagement_All_List2_UnLeranedSKillUpdate(content, key)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  PaGlobal_ServantSkillManagement_All:updateList2_UnLearnSKill(content, key)
end
function HandleEventLUp_ServantSkillManagement_All_TrainingSkill(slotIdx)
  if nil == slotIdx or nil == PaGlobal_ServantSkillManagement_All._currentServantInfo or nil == PaGlobal_ServantSkillManagement_All._currentServantNo then
    return
  end
  if isGameTypeKorea() and false == _ContentsGroup_UsePadSnapping then
    local itemCount = 0
    if true == _ContentsGroup_NewUI_Inventory_All then
      itemCount = PaGlobalFunc_Inventory_All_FindItemCountByEventType(33, 0)
    else
      itemCount = PaGlobal_Inventory:findItemCountByEventType(33, 0)
    end
    if 0 == itemCount then
      local EasyBuyOpen = function()
        PaGlobal_EasyBuy:Open(73)
      end
      local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_SKILLTRAININGTITLE")
      local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_NOT_FOUND_ITEM_TRAINING1")
      local _confirmFunction = EasyBuyOpen
      local _cancel = MessageBox_Empty_function
      local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      local messageboxData = {
        title = _title,
        content = _desc,
        functionYes = _confirmFunction,
        functionNo = _cancel,
        priority = _priority
      }
      MessageBox.showMessageBox(messageboxData)
      return
    end
  end
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  if nil == servantInfo then
    return
  end
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CONDITION_STALLIONDESC"))
    return
  end
  local skillWrapper = servantInfo:getSkill(slotIdx)
  local skillName = skillWrapper:getName()
  local skillCount = stable_getStallionTrainingSkillCount()
  for i = 0, skillCount - 1 do
    local stallionSkillWrapper = stable_getStallionTrainingSkillListAt(i)
    local stallionSkillWrapperName = stallionSkillWrapper:getName()
    if skillName == stallionSkillWrapperName then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_STABLE_ALERT"))
      return
    end
  end
  if MessageBoxGetShow() then
    return
  end
  local function trainHorse()
    if nil ~= PaGlobal_ServantSkillManagement_All._currentServantNo then
      stable_startServantSkillExpTraining(PaGlobal_ServantSkillManagement_All._currentServantNo, slotIdx)
      PaGlobalFunc_ServantSkillManagement_All_Close()
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_SKILLTRAININGTITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_SKILLTRAININGCONTENT")
  local _confirmFunction = trainHorse
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantSkillManagement_All_TrainingSkillAll()
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == PaGlobal_ServantSkillManagement_All._currentServantNo then
    return
  end
  if isGameTypeKorea() and false == _ContentsGroup_UsePadSnapping then
    local itemCount = 0
    if true == _ContentsGroup_NewUI_Inventory_All then
      itemCount = PaGlobalFunc_Inventory_All_FindItemCountByEventType(33, 1)
    else
      itemCount = PaGlobal_Inventory:findItemCountByEventType(33, 1)
    end
    if 0 == itemCount then
      local EasyBuyOpen = function()
        PaGlobal_EasyBuy:Open(73)
      end
      local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_SKILLTRAININGTITLE")
      local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_NOT_FOUND_ITEM_TRAINING2")
      local _confirmFunction = EasyBuyOpen
      local _cancel = MessageBox_Empty_function
      local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      local messageboxData = {
        title = _title,
        content = _desc,
        functionYes = _confirmFunction,
        functionNo = _cancel,
        priority = _priority
      }
      MessageBox.showMessageBox(messageboxData)
      return
    end
  end
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  if nil == servantInfo then
    return
  end
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CONDITION_STALLIONDESC"))
    return
  end
  if MessageBoxGetShow() then
    return
  end
  local trainHorseAll = function()
    if nil ~= PaGlobal_ServantSkillManagement_All._currentServantNo then
      stable_startServantSkillExpTraining(PaGlobal_ServantSkillManagement_All._currentServantNo, 0)
      PaGlobalFunc_ServantSkillManagement_All_Close()
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_SKILLTRAININGTITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ALLSKILLTRAININGCONTENT")
  local _confirmFunction = trainHorseAll
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantSkillManagement_All_DeleteSkill(slotIdx)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == PaGlobal_ServantSkillManagement_All._currentServantNo then
    return
  end
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  if nil == servantInfo then
    return
  end
  local currentServantNo = PaGlobal_ServantSkillManagement_All._currentServantNo
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CONDITION_STALLIONDESC"))
    return
  end
  local skillWrapper = servantInfo:getSkill(slotIdx)
  if nil == skillWrapper then
    return
  end
  local skillName = skillWrapper:getName()
  local function deleteServantSkill()
    if nil ~= currentServantNo then
      PaGlobal_ServantSkillManagement_All._deleteSkillName = skillName
      stable_forgetServantSkill(currentServantNo, slotIdx)
      PaGlobalFunc_ServantSkillManagement_All_Close()
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLINFO_1")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLINFO_2", "skillName", skillName)
  local _confirmFunction = deleteServantSkill
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantSkillManagement_All_SkillListClick(slotIdx, isWishSkill)
  if nil == PaGlobal_ServantSkillManagement_All._currentServantNo or nil == slotIdx or nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  local currentServantNo = PaGlobal_ServantSkillManagement_All._currentServantNo
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if true == isWishSkill then
    if not servantInfo:isLearnSkill(slotIdx) then
      return
    end
    PaGlobal_ServantSkillManagement_All._isCheckWishSkill = true
    PaGlobal_ServantSkillManagement_All._currentWishSkillIdx = slotIdx
  else
    PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx = slotIdx
  end
  PaGlobal_ServantSkillManagement_All._ui._stc_SkillListBg:SetShow(false)
  PaGlobal_ServantSkillManagement_All:updateWishskill(isWishSkill)
end
function HandleEventLUp_ServantSkillManagement_All_SkillChangeButtonClick(idx)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  if 0 == idx then
    if nil == PaGlobal_ServantSkillManagement_All._currentWishSkillIdx then
      HandleEventLUp_ServantSkillManagement_All_SkillListOpen(1)
      if true == PaGlobal_ServantSkillManagement_All._isConsole then
      end
      return
    end
    PaGlobal_ServantSkillManagement_All._isCheckWishSkill = false
    PaGlobal_ServantSkillManagement_All._currentWishSkillIdx = nil
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillIcon:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillName:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillCommand:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillExpBg:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_CircularProg2_Exp:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_WishSkill_SkillExpPercent:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_PlusIcon:SetShow(true)
  else
    if nil == PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx then
      HandleEventLUp_ServantSkillManagement_All_SkillListOpen(0)
      if true == PaGlobal_ServantSkillManagement_All._isConsole then
      end
      return
    end
    PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx = nil
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillExpBg:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_CircularProg2_SkillExp:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillIcon:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillExpPercent:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillName:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillCommand:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_SkillExpPercent:SetShow(false)
    PaGlobal_ServantSkillManagement_All._ui._stc_Delete_PlusIcon:SetShow(true)
  end
end
function HandleEventLUp_ServantSkillManagement_All_SkillChange()
  if nil == PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx or nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    return
  end
  if isGameTypeKorea() and false == _ContentsGroup_UsePadSnapping then
    local itemCount = 0
    if true == _ContentsGroup_NewUI_Inventory_All then
      itemCount = PaGlobalFunc_Inventory_All_FindItemCountByEventType(8)
    else
      itemCount = PaGlobal_Inventory:findItemCountByEventType(8)
    end
    if 0 == itemCount then
      local EasyBuyOpen = function()
        PaGlobal_EasyBuy:Open(71)
      end
      local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_MSG_TITLE_CHANGE")
      local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_MSG_CONTENT_CHANGE")
      local _confirmFunction = EasyBuyOpen
      local _cancel = MessageBox_Empty_function
      local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      local messageboxData = {
        title = _title,
        content = _desc,
        functionYes = _confirmFunction,
        functionNo = _cancel,
        priority = _priority
      }
      MessageBox.showMessageBox(messageboxData)
      return
    end
  end
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  if nil == servantInfo then
    return
  end
  local currentServantNo = PaGlobal_ServantSkillManagement_All._currentServantNo
  if MessageBoxGetShow() then
    return
  end
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CONDITION_STALLIONDESC"))
    return
  end
  local wishSKillIdx = PaGlobal_ServantSkillManagement_All._currentWishSkillIdx
  local changingSkillIdx = PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx
  if nil == wishSKillIdx then
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_CHANGESKILL_BTN")
    local _confirmFunction = MessageBox_Empty_function
    local _cancel = MessageBox_Empty_function
    local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    local messageboxData = {
      title = _title,
      content = _desc,
      functionApply = _confirmFunction,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  local skillWrapper = servantInfo:getSkill(changingSkillIdx)
  if nil == skillWrapper then
    return
  end
  local function skillChangeConfirm()
    audioPostEvent_SystemUi(3, 19)
    stable_changeSkill(currentServantNo, changingSkillIdx, wishSKillIdx)
    PaGlobal_ServantSkillManagement_All:dataClear()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SKILLCHANGE_MSG", "skillname", skillWrapper:getName())
  local _confirmFunction = skillChangeConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantSkillManagement_All_SkillListOpen(idx)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or nil == PaGlobal_ServantSkillManagement_All._currentServantNo then
    return
  end
  if nil == PaGlobal_ServantSkillManagement_All._currentServantInfo then
    return
  end
  local servantInfo = PaGlobal_ServantSkillManagement_All._currentServantInfo
  local skillCount = 0
  if false == servantInfo:doHaveVehicleSkill() then
    return
  end
  skillCount = servantInfo:getSkillCount()
  if 0 == skillCount then
    return
  end
  PaGlobal_ServantSkillManagement_All._ui._list2_ServantSkill:getElementManager():clearKey()
  local uiCount = 1
  for skillIdx = 1, skillCount - 1 do
    if 0 == idx then
      PaGlobal_ServantSkillManagement_All._isClickedWishSkill = false
      skillWrapper = servantInfo:getSkill(skillIdx)
      if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
        PaGlobal_ServantSkillManagement_All._ui._list2_ServantSkill:getElementManager():pushKey(toInt64(0, skillIdx))
      end
    else
      PaGlobal_ServantSkillManagement_All._isClickedWishSkill = true
      skillWrapper = servantInfo:getSkillXXX(skillIdx)
      if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
        PaGlobal_ServantSkillManagement_All._ui._list2_ServantSkill:getElementManager():pushKey(toInt64(0, skillIdx))
      end
    end
  end
  PaGlobal_ServantSkillManagement_All._ui._stc_SkillListBg:SetShow(true)
end
function FromClient_ServantSkillManagement_All_SkillChangeFinish(oldSkillKey, newSkillKey)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantSkillManagement_All._currentServantNo)
  local skillWrapper = servantInfo:getSkill(newSkillKey)
  local oldSkillWrapper = servantInfo:getSkillXXX(oldSkillKey)
  local wishSKillIdx = PaGlobal_ServantSkillManagement_All._currentWishSkillIdx
  local changingSkillIdx = PaGlobal_ServantSkillManagement_All._currentChangeSkillIdx
  if nil ~= wishSKillIdx then
    local skillWrapper = servantInfo:getSkill(wishSKillIdx)
    if nil ~= skillWrapper then
      PaGlobal_ServantSkillManagement_All._isClickedWishSkill = false
    else
      PaGlobal_ServantSkillManagement_All._isClickedWishSkill = true
    end
  end
  PaGlobal_ServantSkillManagement_All._ui._txt_Center_PercentValue:SetText("+" .. servantInfo:getSkillFailedCount())
  if nil ~= servantInfo then
    local msg = {
      main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STABLE_CHANGESKILL_MSG_MAIN_CHANGESKILL", "oldSkill", oldSkillWrapper:getName(), "newSkill", skillWrapper:getName()),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_STABLE_CHANGESKILL_MSG_SUB_CONGRATULATION")
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 6, 32)
  end
  PaGlobal_ServantSkillManagement_All:dataClear()
  if nil ~= Panel_Dialog_ServantInfo_All then
    PaGlobalFunc_ServantInfo_All_Update()
  end
end
function FromClient_ServantSkillManagement_All_SkillDeleteFinish(servantNo, skillKey)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  local msg
  if nil ~= PaGlobal_ServantSkillManagement_All._deleteSkillName then
    msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLINFO_3", "deleteSkillName", PaGlobal_ServantSkillManagement_All._deleteSkillName)
  else
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLINFO_4")
  end
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(msg)
  PaGlobal_ServantSkillManagement_All._deleteSkillName = nil
  if nil ~= Panel_Dialog_ServantInfo_All then
    PaGlobalFunc_ServantInfo_All_Update()
  end
end
function HandleEventOnOut_ServantSkillManagement_All_LimitTooltip(show, type)
  if false == show then
    TooltipSimple_Hide()
    return
  end
  local control
  if 0 == type then
    control = PaGlobal_ServantSkillManagement_All._ui._rdo_LearnedSkill
  else
    control = PaGlobal_ServantSkillManagement_All._ui._rdo_WishSkill
  end
  if nil ~= control then
    TooltipSimple_Show(control, "", control:GetText())
  end
end
function HandleEventLOn_ServantSkillManagement_All_Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  PaGlobal_ServantSkillManagement_All:Servant_Tooltip_Open(key32)
end
function HandleEventLOn_ServantSkillManagement_All_SkillChangeButton_Servant_Tooltip_Open(key32, buttonIdx)
  if nil == Panel_Dialog_ServantSkillManagement_All then
    return
  end
  PaGlobal_ServantSkillManagement_All:SkillChangeButton_Servant_Tooltip_Open(key32, buttonIdx)
end
function HandleEventPadPress_ServantSkillManagement_All_TabChange_Console()
  if false == PaGlobal_ServantList_All._isConsole then
    return
  end
  if PaGlobal_ServantSkillManagement_All._tabType == PaGlobal_ServantSkillManagement_All._eType.learn then
    HandleEventLUp_ServantSkillManagement_All_TabChange(1)
  else
    HandleEventLUp_ServantSkillManagement_All_TabChange(0)
  end
end
function HandleEventOut_ServantSkillManagement_All_SkillTooltipClose()
  if true == PaGlobal_ServantSkillManagement_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
end
function HandleEventPadScroll_ServantSkillManagement_All_list2Scroll(flag)
  if nil == Panel_Dialog_ServantSkillManagement_All or false == Panel_Dialog_ServantSkillManagement_All:GetShow() or false == PaGlobal_ServantSkillManagement_All._isConsole then
    return
  end
  if PaGlobal_ServantSkillManagement_All._tabType ~= PaGlobal_ServantSkillManagement_All._eType.learn then
    return
  end
  if 1 == flag then
    PaGlobal_ServantSkillManagement_All._ui._list2_LearnSkill:MouseUpScroll(PaGlobal_ServantSkillManagement_All._ui._list2_LearnSkill)
  elseif -1 == flag then
    PaGlobal_ServantSkillManagement_All._ui._list2_LearnSkill:MouseDownScroll(PaGlobal_ServantSkillManagement_All._ui._list2_LearnSkill)
  end
end
