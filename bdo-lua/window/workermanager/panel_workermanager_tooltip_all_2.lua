function PaGlobalFunc_WorkerManagerTooltip_All_OpenByWorkerNoRaw(workerNoRaw, panel, isRight, isPlant)
  PaGlobal_WorkerManagerTooltip_All:prepareOpen(workerNoRaw, panel, isRight, isPlant)
end
function PaGlobalFunc_WorkerManagerTooltip_All_Close()
  PaGlobal_WorkerManagerTooltip_All:prepareClose()
end
function FromClient_WorkerManagerTooltip_All_WorkerInfoChanged(workerNoRaw, worker, isLevelup)
  if true == isLevelup then
    local name = getWorkerName(worker:getWorkerStaticStatus())
    local lev = worker:getLevel()
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORKER_TOOLTIP_LVUP", "workName", name, "level", lev))
  end
end
function PaGlobalFunc_WorkerManagerTooltip_All_Audio(group, index)
  if PaGlobal_WorkerManagerTooltip_All._isConsole then
    audioPostEvent_SystemUi(group, index)
  else
    _AudioPostEvent_SystemUiForXBOX(group, index)
  end
end
function HandleEventOn_WorkerManagerTooltip_All_Show(workerData, uiBase)
  if nil == workerData then
    PaGlobalFunc_WorkerManagerTooltip_All_Clear()
    return
  end
  PaGlobal_WorkerManagerTooltip_All._worekrInfoTooltip = uiBase
  local workerStaticStatus = workerData:getWorkerStaticStatus()
  PaGlobalFunc_WorkerManagerTooltip_All_OpenByWorkerNoRaw(workerData, uiBase)
end
function HandleEventOut_WorkerManagerTooltip_All_Hide(uiBase)
  if uiBase == workerInfoTooltip then
    PaGlobal_WorkerManagerTooltip_All._worekrInfoTooltip = nil
  end
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
end
function PaGlobalFunc_WorkerManagerTooltip_All_Clear()
  PaGlobal_WorkerManagerTooltip_All._worekrInfoTooltip = nil
  PaGlobalFunc_WorkerManagerTooltip_All_Close()
end
