function PaGlobalFunc_WorkerManagerChangeSkill_All_Open(workerIdx)
  PaGlobal_WorkerManagerChangeSkill_All:prepareOpen(workerIdx)
end
function PaGlobalFunc_WorkerManagerChangeSkill_All_Close()
  PaGlobal_WorkerManagerChangeSkill_All:prepareClose()
end
function PaGlobalFunc_WorkerManagerChangeSkill_All_GetShow()
  if nil == Panel_Window_WorkerManagerChangeSkill_All then
    return false
  end
  return Panel_Window_WorkerManagerChangeSkill_All:GetShow()
end
function HandleEventLup_WorkerManagerChangeSkill_All_SelectSkill(skillKeyRaw)
  PaGlobal_WorkerManagerChangeSkill_All._selectedSkillKeyRaw = skillKeyRaw
end
function HandleEventLup_WorkerManagerChangeSkill_All_ConfirmChange()
  local prevWorkerSkillKeyRaw = PaGlobal_WorkerManagerChangeSkill_All._selectedSkillKeyRaw
  local workerNoRaw = PaGlobal_WorkerManagerChangeSkill_All._selectedWorkerNoRaw
  if nil == prevWorkerSkillKeyRaw or nil == workerNoRaw then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERCHANGESKILL_NOSELECTSKILL"))
    return
  end
  ToClient_requestChangeSkillNoOne(workerNoRaw, prevWorkerSkillKeyRaw)
  PaGlobalFunc_WorkerManagerChangeSkill_All_Close()
end
function FromClient_WorkerManagerChangeSkill_All_ChangeWorkerSkillNoOne(workerNoRaw)
  local workerWrapperLua = getWorkerWrapper(workerNoRaw, true)
  local worker_Lev = workerWrapperLua:getLevel()
  local worker_Name = workerWrapperLua:getName()
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. worker_Lev .. " " .. workerWrapperLua:getGradeToColorString() .. worker_Name .. "<PAOldColor>"
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERCHANGESKILL_WORKERCHANGESKILL", "name", name))
end
function FromClient_WorkerManagerChangeSkill_All_ChangeWorkerSkillNo(workerNoRaw)
  local workerWrapperLua = getWorkerWrapper(workerNoRaw, true)
  local worker_Lev = workerWrapperLua:getLevel()
  local worker_Name = workerWrapperLua:getName()
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. worker_Lev .. " " .. workerWrapperLua:getGradeToColorString() .. worker_Name .. "<PAOldColor>"
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERCHANGESKILL_WORKERCHANGESKILL", "name", name))
end
function PaGlobalFunc_WorkerManagerChangeSkill_All_Resize()
  PaGlobal_WorkerManagerChangeSkill_All:resize()
end
function PaGlobalFunc_WorkerManagerChangeSkill_All_UISubMode()
  if false == Panel_Window_WorkerManagerChangeSkill_All:IsShow() then
    return
  end
  if true == Panel_Window_WorkerManager_All:IsUISubApp() then
    Panel_Window_WorkerManagerChangeSkill_All:OpenUISubApp()
  else
    Panel_Window_WorkerManagerChangeSkill_All:CloseUISubApp()
  end
  PaGlobal_WorkerManagerChangeSkill_All:resize()
end
