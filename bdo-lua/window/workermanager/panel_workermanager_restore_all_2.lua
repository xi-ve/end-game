function PaGlobalFunc_WorkerManagerRestore_All_Open(listCount, workerArray)
  PaGlobal_WorkerManagerRestore_All:prepareOpen(listCount, workerArray)
end
function PaGlobalFunc_WorkerManagerRestore_All_Close()
  PaGlobal_WorkerManagerRestore_All:prepareClose()
end
function PaGlobalFunc_WorkerManagerRestore_All_GetShow()
  if nil == Panel_Window_WorkerManagerRestore_All then
    return false
  end
  return Panel_Window_WorkerManagerRestore_All:GetShow()
end
function PaGlobalFunc_WorkerManagerRestore_All_SelectWorkerOpen(workerNoRaw)
  local workerWrapperLua = getWorkerWrapper(workerNoRaw)
  if nil == workerWrapperLua then
    return
  end
  PaGlobal_WorkerManagerRestore_All._workerNoRaw = workerNoRaw
  local listCount = ToClient_getNpcRecoveryItemList()
  local actionPointPer = workerWrapperLua:getActionPointPercents()
  if listCount <= 0 then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_NOITEM"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  elseif 100 == actionPointPer then
    Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_TOWN_WORKER_RESTORE_MAX"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
    return
  end
  PaGlobalFunc_WorkerManagerRestore_All_Open(listCount)
end
function HandleEventLUp_WorkerManagerRestore_All_SelectItem(itemIdx)
  PaGlobal_WorkerManagerRestore_All:selectItem(itemIdx)
end
function HandleEventLUp_WorkerManagerRestore_All_Confirm()
  PaGlobal_WorkerManagerRestore_All:confirm()
  PaGlobalFunc_WorkerManager_All_Update()
end
function HandlePadEventA_WorkerManagerRestore_All_UseItemToWorker()
  PaGlobal_WorkerManagerRestore_All:useItemToWorker()
end
function HandlePadEventX_WorkerManagerRestore_All_UseItemContinueToWorker()
  PaGlobal_WorkerManagerRestore_All._isContinue = true
  PaGlobal_WorkerManagerRestore_All:useItemToWorker()
end
function HandleEventScroll_WorkerManagerRestore_All_SliderScroll(isUp)
  if true == isUp then
    if PaGlobal_WorkerManagerRestore_All._sliderStartIdx <= 0 then
      PaGlobal_WorkerManagerRestore_All._sliderStartIdx = 0
      return
    end
    PaGlobal_WorkerManagerRestore_All._sliderStartIdx = PaGlobal_WorkerManagerRestore_All._sliderStartIdx - 1
  else
    if PaGlobal_WorkerManagerRestore_All._restoreItemHasCount <= PaGlobal_WorkerManagerRestore_All._sliderStartIdx + PaGlobal_WorkerManagerRestore_All._restoreItemMaxCount then
      return
    end
    PaGlobal_WorkerManagerRestore_All._sliderStartIdx = PaGlobal_WorkerManagerRestore_All._sliderStartIdx + 1
  end
  local currentPos = PaGlobal_WorkerManagerRestore_All._sliderStartIdx / (PaGlobal_WorkerManagerRestore_All._restoreItemHasCount - PaGlobal_WorkerManagerRestore_All._restoreItemMaxCount) * 100
  if 100 < currentPos then
    currentPos = 100
  elseif currentPos < 0 then
    currentPos = 0
  end
  PaGlobal_WorkerManagerRestore_All._ui.stc_slider:SetControlPos(currentPos)
  PaGlobal_WorkerManagerRestore_All:update()
end
function HandleEventLPress_WorkerManagerRestore_All_SliderPress()
  local pos = PaGlobal_WorkerManagerRestore_All._ui.stc_slider:GetControlPos()
  local posIdx = math.floor((PaGlobal_WorkerManagerRestore_All._restoreItemHasCount - PaGlobal_WorkerManagerRestore_All._restoreItemMaxCount) * pos)
  if posIdx > PaGlobal_WorkerManagerRestore_All._restoreItemHasCount - PaGlobal_WorkerManagerRestore_All._restoreItemMaxCount then
    return
  end
  PaGlobal_WorkerManagerRestore_All._sliderStartIdx = posIdx
  local currentPos = PaGlobal_WorkerManagerRestore_All._sliderStartIdx / (PaGlobal_WorkerManagerRestore_All._restoreItemHasCount - PaGlobal_WorkerManagerRestore_All._restoreItemMaxCount) * 100
  if 100 < currentPos then
    currentPos = 100
  elseif currentPos < 0 then
    currentPos = 0
  end
  PaGlobal_WorkerManagerRestore_All._ui.stc_slider:SetControlPos(currentPos)
  PaGlobal_WorkerManagerRestore_All:update()
end
function PaGlobalFunc_WorkerManagerRestore_All_Update()
  PaGlobal_WorkerManagerRestore_All:update()
end
function PaGlobalFunc_WorkerManagerRestore_All_UISubMode()
  if false == Panel_Window_WorkerManagerRestore_All:IsShow() then
    return
  end
  if true == Panel_Window_WorkerManager_All:IsUISubApp() then
    Panel_Window_WorkerManagerRestore_All:OpenUISubApp()
  else
    Panel_Window_WorkerManagerRestore_All:CloseUISubApp()
  end
  PaGlobal_WorkerManagerRestore_All:resize()
end
