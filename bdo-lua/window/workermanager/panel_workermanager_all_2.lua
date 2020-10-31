function PaGlobalFunc_WorkerManager_All_Open()
  PaGlobal_WorkerManager_All._plantKey = nil
  PaGlobal_WorkerManager_All:prepareOpen()
end
function PaGlobalFunc_WorkerManager_All_Close()
  PaGlobal_WorkerManager_All:prepareClose()
end
function PaGlobalFunc_WorkerManager_All_ShowToggle()
  if Panel_Window_WorkerManager_All:GetShow() then
    PaGlobalFunc_WorkerManager_All_Close()
    return
  end
  PaGlobalFunc_WorkerManager_All_Open()
end
function HandleEventLUp_WorkerManager_All_Close()
  PaGlobalFunc_WorkerManager_All_Close()
end
function PaGlobalFunc_WorkerManager_All_PreClose()
  if true == PaGlobal_WorkerManager_All._isPadSnap then
    PaGlobalFunc_InventoryInfo_Close()
  else
    InventoryWindow_Close()
  end
end
function PaGlobalFunc_WorkerManager_All_ComboBoxResetAdd()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobal_WorkerManager_All._ui.combo_town:setListTextHorizonCenter()
  PaGlobal_WorkerManager_All._ui.combo_grade:setListTextHorizonCenter()
  PaGlobal_WorkerManager_All._ui.combo_town:DeleteAllItem()
  PaGlobal_WorkerManager_All._ui.combo_town:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_FILTER_ALL"))
  for ii = 1, #PaGlobal_WorkerManager_All._townList do
    PaGlobal_WorkerManager_All._ui.combo_town:AddItem(ToClient_GetNodeNameByWaypointKey(PaGlobal_WorkerManager_All._townList[ii]))
  end
  PaGlobal_WorkerManager_All._ui.combo_grade:DeleteAllItem()
  PaGlobal_WorkerManager_All._ui.combo_grade:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_FILTER_ALL"))
  for ii = 1, #PaGlobal_WorkerManager_All._gradeList do
    PaGlobal_WorkerManager_All._ui.combo_grade:AddItem(PaGlobal_WorkerManager_All._workerGradeStr[PaGlobal_WorkerManager_All._gradeList[ii]])
  end
  if -1 ~= PaGlobal_WorkerManager_All._selectFilterTown and PaGlobal_WorkerManager_All._selectFilterTown > 0 then
    local selectTown = PaGlobal_WorkerManager_All._townList[PaGlobal_WorkerManager_All._selectFilterTown]
    PaGlobal_WorkerManager_All._ui.combo_town:SetText(ToClient_GetNodeNameByWaypointKey(selectTown))
  else
    PaGlobal_WorkerManager_All._ui.combo_town:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_FILTER_TOWN"))
  end
  if -1 ~= PaGlobal_WorkerManager_All._selectFilterGrade then
    local gradeStr = PaGlobal_WorkerManager_All._workerGradeStr[PaGlobal_WorkerManager_All._selectFilterGrade]
    PaGlobal_WorkerManager_All._ui.combo_grade:SetText(gradeStr)
  else
    PaGlobal_WorkerManager_All._ui.combo_grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_FILTER_GRADE"))
  end
end
function HandleEventLUp_WorkerManager_All_ComboTown()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  PaGlobal_WorkerManager_All._ui.combo_town:ToggleListbox()
end
function HandleEventLUp_WorkerManager_All_SetComboTown()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  local selectTownIndex = PaGlobal_WorkerManager_All._ui.combo_town:GetSelectIndex()
  PaGlobal_WorkerManager_All._selectFilterTown = selectTownIndex
  PaGlobal_WorkerManager_All:updateFilterData()
  PaGlobal_WorkerManager_All:updateListData()
end
function HandleEventLUp_WorkerManager_All_ComboGrade()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  PaGlobal_WorkerManager_All._ui.combo_grade:ToggleListbox()
end
function HandleEventLUp_WorkerManager_All_SetComboGrade()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  local selectGradeIndex = PaGlobal_WorkerManager_All._ui.combo_grade:GetSelectIndex()
  if 0 < selectGradeIndex then
    PaGlobal_WorkerManager_All._selectFilterGrade = PaGlobal_WorkerManager_All._gradeList[selectGradeIndex]
  else
    PaGlobal_WorkerManager_All._selectFilterGrade = -1
  end
  PaGlobal_WorkerManager_All:updateFilterData()
  PaGlobal_WorkerManager_All:updateListData()
end
function HandleEventLUp_WorkerManager_All_SelectTabMenu(tabIdx)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  PaGlobalFunc_WorkerManagerChangeSkill_All_Close()
  PaGlobalFunc_WorkerManagerRestore_All_Close()
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
  for ii = 1, #PaGlobal_WorkerManager_All._radioTab do
    PaGlobal_WorkerManager_All._radioTab[ii]:SetCheck(false)
  end
  PaGlobal_WorkerManager_All._selectTabIdx = tabIdx
  PaGlobal_WorkerManager_All._ui.stc_selectBar:SetShow(true)
  local posX = PaGlobal_WorkerManager_All._radioTab[tabIdx]:GetPosX() + PaGlobal_WorkerManager_All._radioTab[tabIdx]:GetSizeX() / 2 - PaGlobal_WorkerManager_All._ui.stc_selectBar:GetSizeX() / 2
  PaGlobal_WorkerManager_All._ui.stc_selectBar:SetPosX(posX)
  PaGlobal_WorkerManager_All._radioTab[tabIdx]:SetCheck(true)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_RestoreWorkerOpen(key)
  PaGlobal_WorkerManager_All:restoreWorkerOpen(key)
end
function HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == PaGlobal_WorkerManager_All._initialize then
    return
  end
  PaGlobal_WorkerManager_All._ui.stc_restoreGroup:SetShow(false)
  PaGlobal_WorkerManager_All._restoreWorkerNo = nil
end
function HandleEventRUp_WorkerManager_RestoreItemUse(itemIdx)
  PaGlobal_WorkerManager_All:restoreItemUse(itemIdx)
end
function HandleEventScroll_WorkerManager_All_RestoreSliderScroll(isUp)
  if true == isUp then
    if PaGlobal_WorkerManager_All._sliderStartIdx <= 0 then
      PaGlobal_WorkerManager_All._sliderStartIdx = 0
      return
    end
    PaGlobal_WorkerManager_All._sliderStartIdx = PaGlobal_WorkerManager_All._sliderStartIdx - 1
  else
    if PaGlobal_WorkerManager_All._restoreItemHasCount <= PaGlobal_WorkerManager_All._sliderStartIdx + PaGlobal_WorkerManager_All._restoreItemMaxCount then
      return
    end
    PaGlobal_WorkerManager_All._sliderStartIdx = PaGlobal_WorkerManager_All._sliderStartIdx + 1
  end
  local currentPos = PaGlobal_WorkerManager_All._sliderStartIdx / (PaGlobal_WorkerManager_All._restoreItemHasCount - PaGlobal_WorkerManager_All._restoreItemMaxCount) * 100
  if 100 < currentPos then
    currentPos = 100
  elseif currentPos < 0 then
    currentPos = 0
  end
  PaGlobal_WorkerManager_All._ui.slider_Bg:SetControlPos(currentPos)
  PaGlobal_WorkerManager_All:restoreItemUpdate()
end
function HandleEventLPress_WorkerManager_All_RrestoreSliderScroll()
  local pos = PaGlobal_WorkerManager_All._ui.slider_Bg:GetControlPos()
  local posIdx = math.floor((PaGlobal_WorkerManager_All._restoreItemHasCount - PaGlobal_WorkerManager_All._restoreItemMaxCount) * pos)
  if posIdx > PaGlobal_WorkerManager_All._restoreItemHasCount - PaGlobal_WorkerManager_All._restoreItemMaxCount then
    return
  end
  PaGlobal_WorkerManager_All._sliderStartIdx = posIdx
  local currentPos = PaGlobal_WorkerManager_All._sliderStartIdx / (PaGlobal_WorkerManager_All._restoreItemHasCount - PaGlobal_WorkerManager_All._restoreItemMaxCount) * 100
  if 100 < currentPos then
    currentPos = 100
  elseif currentPos < 0 then
    currentPos = 0
  end
  PaGlobal_WorkerManager_All._ui.slider_Bg:SetControlPos(currentPos)
  PaGlobal_WorkerManager_All:restoreItemUpdate()
end
function HandleEventLUp_WorkerManager_All_ResetRepeatWork(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  PaGlobal_WorkerManager_All:resetRepeatWork(workerIdx)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_ChangeSkillOpen(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  PaGlobalFunc_WorkerManagerChangeSkill_All_Open(workerIdx)
end
function HandleEventLUp_WorkerManager_All_StopWorking(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  PaGlobal_WorkerManager_All:stopWorking(workerIdx)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_RepeatWorking(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  PaGlobal_WorkerManager_All:repeatWorking(workerIdx)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_FireWorker(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  PaGlobal_WorkerManager_All:fireWorker(workerIdx)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_RestoreAll()
  local restoreItemCount = ToClient_getNpcRecoveryItemList()
  if restoreItemCount <= 0 then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_NOITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false)
  PaGlobalFunc_WorkerManagerRestore_All_Open(PaGlobal_WorkerManager_All._totalWorkerCount, PaGlobal_WorkerManager_All._filteredArray)
end
function HandleEventLUp_WorkerManager_All_RepeatAll()
  for workerIdx = 1, #PaGlobal_WorkerManager_All._filteredArray do
    HandleEventLUp_WorkerManager_All_RepeatWorking(workerIdx)
  end
end
function HandleEventLUp_WorkerManager_All_UpgradeWorker(workerIdx)
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
  PaGlobal_WorkerManager_All:upgradeWorker(workerIdx)
  PaGlobal_WorkerManager_All:update()
end
function HandleEventLUp_WorkerManager_All_UpgradeNow()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
  PaGlobal_WorkerManager_All:upgradeWorkerNow()
  PaGlobal_WorkerManager_All:update()
end
function HandleEventOnOut_WorkerManager_WorkerInfoTooltip(isShow, workerIdx)
  TooltipSimple_Hide()
  if false == isShow then
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
    return
  end
  local workerNoRaw = PaGlobal_WorkerManager_All._filteredArray[workerIdx]
  if nil ~= workerNoRaw then
    PaGlobalFunc_WorkerManagerTooltip_All_OpenByWorkerNoRaw(workerNoRaw, Panel_Window_WorkerManager_All)
  else
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
  end
end
function HandleEventOnOut_WorkerManager_WorkerInfoTooltipByUpgrade(isShow)
  TooltipSimple_Hide()
  if false == isShow then
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
    return
  end
  if nil ~= PaGlobal_WorkerManager_All._upgradingWorkerNoRaw and -1 ~= PaGlobal_WorkerManager_All._upgradingWorkerNoRaw then
    PaGlobalFunc_WorkerManagerTooltip_All_OpenByWorkerNoRaw(PaGlobal_WorkerManager_All._upgradingWorkerNoRaw, Panel_Window_WorkerManager_All)
  else
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
  end
end
function HandleEventOnOut_WorkerManager_ButtonSimpleTooltip(isShow, key, tipType)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local list2 = PaGlobal_WorkerManager_All:getCurrentListControl()
  local name, desc, control
  local content = list2:GetContentByKey(key)
  local stc_btnBg = UI.getChildControl(content, "Static_ListBG")
  if PaGlobal_WorkerManager_All._BUTTON.RESTORE == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_RESTORE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_RESTORE_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_WorkRestore")
  elseif PaGlobal_WorkerManager_All._BUTTON.FIRE == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_FIRE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_FIRE_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_WorkerFire")
  elseif PaGlobal_WorkerManager_All._BUTTON.UPGRADE == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_UPGRADE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_UPGRADE_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_Advence")
  elseif PaGlobal_WorkerManager_All._BUTTON.REPEAT == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_REPEAT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_REPEAT_DESC")
    control = UI.getChildControl(stc_btnBg, "Static_Repeat_Icon")
  elseif PaGlobal_WorkerManager_All._BUTTON.STOP == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_STOP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_STOP_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_WorkStop")
  elseif PaGlobal_WorkerManager_All._BUTTON.SKILL == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_CHANGESKILL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_TOOLTIP_CHANGESKILL_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_ChangeWorkerSkill")
  elseif PaGlobal_WorkerManager_All._BUTTON.CANCLE == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_UNREPEAT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_UNREPEAT_DESC")
    control = UI.getChildControl(stc_btnBg, "Button_CancelWorkerRepeat")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_WorkerManager_PopUpIconTooltip(isShow)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc = ""
  if true == PaGlobal_WorkerManager_All._ui_pc.chk_popUp:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(PaGlobal_WorkerManager_All._ui_pc.chk_popUp, name, desc)
end
function HandleEventLUp_WorkerManager_All_PopUpMode()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == Panel_Window_WorkerManager_All:IsShow() then
    return
  end
  if true == PaGlobal_WorkerManager_All._ui_pc.chk_popUp:IsCheck() then
    Panel_Window_WorkerManager_All:OpenUISubApp()
  else
    Panel_Window_WorkerManager_All:CloseUISubApp()
  end
  PaGlobalFunc_WorkerManagerRestore_All_UISubMode()
  PaGlobalFunc_WorkerManagerChangeSkill_All_UISubMode()
  TooltipSimple_Hide()
end
function HandleEventOnOut_WorkerManager_GuideDesc(isShow)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_ALL_DESC_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_DESCRIPTION")
  TooltipSimple_Show(PaGlobal_WorkerManager_All._ui.stc_desc, name, desc)
end
function HandlePadEventLBRB_WorkerManager_All_ChangeTab(changeVal)
  local tabIndex = PaGlobal_WorkerManager_All._selectTabIdx + changeVal
  if tabIndex < 1 then
    tabIndex = PaGlobal_WorkerManager_All._TAB.UPGRADE
  elseif tabIndex > PaGlobal_WorkerManager_All._TAB.COUNT then
    tabIndex = PaGlobal_WorkerManager_All._TAB.WORKER
  end
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  HandleEventLUp_WorkerManager_All_SelectTabMenu(tabIndex)
end
function HandlePadEventX_WorkerManager_All_RecoverAll()
  HandleEventLUp_WorkerManager_All_RestoreAll()
end
function HandlePadEventY_WorkerManager_All_RepeatAll()
  HandleEventLUp_WorkerManager_All_RepeatAll()
end
function HandlePadEventA_WorkerManager_All_ToggleDetailMenu(workerIdx)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == PaGlobal_WorkerManager_All._ui_console.stc_detailMenu:GetShow() then
    PaGlobal_WorkerManager_All._ui_console.stc_detailMenu:SetShow(false)
    return
  end
  PaGlobal_WorkerManager_All._ui_console.stc_detailMenu:SetShow(true)
  PaGlobal_WorkerManager_All:detailMenuSet(workerIdx)
  HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false)
  ToClient_padSnapSetTargetGroup(PaGlobal_WorkerManager_All._ui_console.stc_detailMenu)
end
function HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true ~= PaGlobal_WorkerManager_All._isPadSnap then
    return
  end
  HandleEventLUp_WorkerManager_All_RestoreGroupClose()
  PaGlobal_WorkerManager_All._ui_console.stc_detailMenu:SetShow(false)
end
function HandlePadEventA_WorkerManager_All_RestoreWorkerOpen(key)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  local workerNoRaw = PaGlobal_WorkerManager_All._filteredArray[key]
  HandlePadEventDpad_WorkerManager_All_CloseDetailMenu()
  HandleEventOnOut_WorkerManager_WorkerInfoTooltip(false)
  PaGlobalFunc_WorkerManagerRestore_All_SelectWorkerOpen(workerNoRaw)
end
function HandleEventOnOut_WorkerManager_All_ShowDetailMenuGuide(isShow)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == isShow then
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(true)
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetText(PaGlobal_WorkerManager_All._keyGuideA.DETAIL)
  else
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(false)
  end
  PaGlobal_WorkerManager_All:consoleKeyAlign()
end
function HandleEventOnOut_WorkerManager_ShowPromoteKeyGuide(isShow, isUpgradable)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == isShow and true == isUpgradable then
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(true)
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetText(PaGlobal_WorkerManager_All._keyGuideA.UPGRADE)
  else
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(false)
  end
  PaGlobal_WorkerManager_All:consoleKeyAlign()
end
function HandleEventOnOut_WorkerManager_All_KeyGuideCompleteNow(isShow)
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if true == isShow then
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(true)
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetText(PaGlobal_WorkerManager_All._keyGuideA.COMPLETENOW)
  else
    PaGlobal_WorkerManager_All._ui_console.stc_normal_detail:SetShow(false)
  end
  PaGlobal_WorkerManager_All:consoleKeyAlign()
end
function FromClient_WorkerManager_All_onScreenResize()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  PaGlobal_WorkerManager_All:resize()
end
function PaGlobalFunc_WorkerManagerRestore_All_FrameUpdate(deltaTime)
  PaGlobal_WorkerManager_All:frameUpdate(deltaTime)
end
function FromClient_WorkerManager_All_AppliedChangeUseType()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  PaGlobal_WorkerManager_All:updateAll()
end
function FromClient_WorkerManager_All_ReceiveReturnHouse()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  PaGlobal_WorkerManager_All:updateAll()
end
function FromClient_WorkerManager_All_RenderModeChangeState()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  if not Panel_WorldMap:GetShow() then
    Panel_Window_WorkerManager_All:ComputePos()
  end
end
function FromClient_WorkerManager_All_StopWorkerWorking(workerNo, isUserRequest, working)
  local npcWorkerWrapper = ToClient_getNpcWorkerByWorkerNo(workerNo)
  local workerName = npcWorkerWrapper:getName()
  local workingArea = working:getWorkingNodeName()
  local workingName = working:getWorkingName()
  if true == isUserRequest then
    Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_FINISHWORK_2", "workerName", workerName, "workingArea", workingArea, "workingName", workingName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
  elseif false == isUserRequest then
    if working:isType(CppEnums.NpcWorkingType.eNpcWorkingType_PlantZone) then
      Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_FINISHWORK_3", "workerName", workerName, "workingArea", workingArea), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
    else
      Proc_ShowMessage_Ack_With_ChatType(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_FINISHWORK_1", "workerName", workerName, "workingArea", workingArea, "workingName", workingName), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Worker)
    end
  end
end
function FromClient_WorkerManager_All_WorkerDataUpdate()
  if nil == Panel_Window_WorkerManager_All or false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  PaGlobal_WorkerManager_All:updateAll()
end
function FromClient_WorkerManager_All_WorkerDataUpdateByPlant(ExplorationNode, workerNo)
  if 0 ~= Int64toInt32(workerNo) and false == ExplorationNode:getStaticStatus():getRegion():isMainOrMinorTown() then
    PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, PaGlobal_WorkerManager_All._WORKTYPE.PlantWork)
  end
  local _plantKey = ExplorationNode:getPlantKey()
  local wayPlant = ToClient_getPlant(_plantKey)
  local plant = getPlant(_plantKey)
  local affiliatedTownKey = ToClinet_getPlantAffiliatedWaypointKey(wayPlant)
  if _plantKey:get() == 151 then
    FGlobal_MiniGame_RequestPlantWorking()
  end
end
function FromClient_WorkerManager_All_WorkerDataUpdateByHouse(rentHouseWrapper, workerNo)
  if 0 ~= Int64toInt32(workerNo) then
    local UseGroupType = rentHouseWrapper:getHouseUseType()
    if CppEnums.eHouseUseType.CannonWorkshop == UseGroupType or CppEnums.eHouseUseType.Shipyard == UseGroupType or CppEnums.eHouseUseType.CarriageWorkshop == UseGroupType then
      PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, PaGlobal_WorkerManager_All._WORKTYPE.LargeCraft)
    else
      PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, PaGlobal_WorkerManager_All._WORKTYPE.HouseCraft)
    end
  end
end
function FromClient_WorkerManager_All_WorkerDataUpdateByBuilding(buildingInfoSS, workerNo)
  if 0 ~= Int64toInt32(workerNo) then
    PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, PaGlobal_WorkerManager_All._WORKTYPE.Building, buildingInfoSS)
  end
end
function FromClient_WorkerManager_All_WorkerDataUpdateByRegionManaging(regionGroupInfo, workerNo)
  if 0 ~= Int64toInt32(workerNo) then
    PaGlobal_WorkerManager_All:pushWorkStartMsg(workerNo, PaGlobal_WorkerManager_All._WORKTYPE.RegionWork)
  end
  PaGlobal_WorkerManager_All:update()
end
function FromClient_WorkerManager_All_UpdateLastestWorkingResult(WorkerNoRaw)
  local result_Count = ToClient_getLastestWorkingResultCount(WorkerNoRaw)
  for idx = 1, result_Count do
    local itemWrapper = ToClient_getLastestWorkingResult(WorkerNoRaw, idx - 1)
    if itemWrapper:isSet() then
      local ItemEnchantSSW = itemWrapper:getStaticStatus()
      local name = ItemEnchantSSW:getName()
      local count = Int64toInt32(itemWrapper:get():getCount_s64())
      Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_GOT_RESULT", "name", name, "count", count), nil)
    end
  end
end
function PaGlobalFunc_WorkerManager_All_ShowAni()
  Panel_Window_WorkerManager_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_WorkerManager_All, 0, 0.3)
end
function PaGlobalFunc_WorkerManager_All_HideAni()
  local ani1 = UIAni.AlphaAnimation(0, Panel_Window_WorkerManager_All, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
function PaGlobalFunc_WorkerManager_All_UpdateNode(plantKey)
  if workerManager_CheckWorkingOtherChannel() then
    return
  end
  PaGlobal_WorkerManager_All._plantKey = plantKey
  PaGlobal_WorkerManager_All:prepareOpen()
end
function PaGlobalFunc_WorkerManager_All_OpenWorldMap()
  PaGlobalFunc_WorkerManager_All_ShowToggle()
end
function PaGlobalFunc_WorkerManager_All_Audio(group, index)
  if PaGlobal_WorkerManager_All._isConsole then
    audioPostEvent_SystemUi(group, index)
  else
    _AudioPostEvent_SystemUiForXBOX(group, index)
  end
end
function PaGlobalFunc_WorkerManager_All_listCreate(content, key)
  PaGlobal_WorkerManager_All:listCreate(content, key)
end
function workerManager_CheckWorkingOtherChannel()
  if nil == getSelfPlayer() then
    return
  end
  if 0 ~= getSelfPlayer():get():checkWorkerWorkingServerNo() then
    return true
  else
    return false
  end
end
function workerManager_getWorkingOtherChannelMsg()
  if workerManager_CheckWorkingOtherChannel() then
    local workingServerNo = getSelfPlayer():get():getWorkerWorkingServerNo()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local worldNo = temporaryWrapper:getSelectedWorldServerNo()
    local channelName = getChannelName(worldNo, workingServerNo)
    return PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERMANAGER_WORKERWORKINGOTHERCHANNEL", "channelName", channelName)
  else
    return ""
  end
end
function workerManager_CheckWorkingOtherChannelAndMsg()
  if workerManager_CheckWorkingOtherChannel() then
    Proc_ShowMessage_Ack(workerManager_getWorkingOtherChannelMsg(), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return true
  else
    return false
  end
end
function PaGlobalFunc_WorkerManager_All_RedoWork(_workType, _houseInfoSS, _selectedWorker, _plantKey, _workKey, _selectedSubwork, _workingCount, _itemNoRaw, _houseHoldNo, _homeWaypoint)
  local plantKey = ToClient_convertWaypointKeyToPlantKey(_homeWaypoint)
  local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
  local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(plantKey)
end
function PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw(workerIdx)
  return PaGlobal_WorkerManager_All._filteredArray[workerIdx]
end
function PaGlobalFunc_WorkerManager_All_Update()
  if nil == Panel_Window_WorkerManager_All then
    return
  end
  if false == Panel_Window_WorkerManager_All:GetShow() then
    return
  end
  PaGlobal_WorkerManager_All:update()
end
