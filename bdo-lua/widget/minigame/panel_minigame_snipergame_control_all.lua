PaGlobal_MiniGame_SniperGame_Control_All = {
  _renderMode = nil,
  _firstShow = true,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperGame_Control_All_Init")
function FromClient_MiniGame_SniperGame_Control_All_Init()
  PaGlobal_MiniGame_SniperGame_Control_All:initialize()
end
function PaGlobal_MiniGame_SniperGame_Control_All:initialize()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_SniperGame
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_SniperGame_All_EndSniperGame)
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_MiniGame_SniperGame_Control_All:registEventHandler()
  ActionChartEventBindFunction(360, PaGlobalFunc_SniperGame_All_StartSniperGame)
  ActionChartEventBindFunction(361, PaGlobalFunc_SniperGame_All_StartSearching)
  ActionChartEventBindFunction(362, PaGlobalFunc_SniperGame_All_StartAimMini)
  ActionChartEventBindFunction(363, PaGlobalFunc_SniperGame_All_StartRecovery)
  ActionChartEventBindFunction(364, PaGlobalFunc_SniperGame_All_StartShoot)
  ActionChartEventBindFunction(365, PaGlobalFunc_SniperGame_All_StartCheckResult)
  ActionChartEventBindFunction(366, PaGlobalFunc_SniperGame_All_StartReloading)
  ActionChartEventBindFunction(367, PaGlobalFunc_SniperGame_All_EndSniperGame)
  registerEvent("FromClient_SniperGame_StateBegin", "FromClient_SniperGame_All_StateBegin_Process")
  registerEvent("FromClient_SniperGame_StateEnd", "FromClient_SniperGame_All_StateEnd_Process")
  registerEvent("FromClient_SniperGame_ImpactResult", "FromClient_SniperGame_All_ImpactResult_Process")
  registerEvent("FromClient_SniperGame_Missed", "FromClient_SniperGame_All_Missed_Process")
end
function PaGlobalFunc_SniperGame_All_StartSniperGame()
  if false == ToClient_SniperGame_StartPlay() then
    return
  end
  PaGlobal_MiniGame_SniperGame_Control_All._renderMode:set()
  PaGlobal_MiniGame_SniperGame_All_Open()
  PaGlobal_MiniGame_SniperGame_All_FadeIn()
  ToClient_SniperGame_ChangeState(__eSniperGameState_None)
end
function PaGlobalFunc_SniperGame_All_EndSniperGame()
  if false == ToClient_SniperGame_IsPlaying() then
    return
  end
  PaGlobal_MiniGame_SniperGame_Control_All._renderMode:reset()
  PaGlobal_MiniGame_SniperGame_All_Close()
  PaGlobal_MiniGame_SniperReload_All_Close()
  PaGlobal_MiniGame_SniperGame_Result_All_Close()
  ToClient_SniperGame_StopPlay()
  ToClient_SniperGame_ChangeState(__eSniperGameState_None)
end
function PaGlobalFunc_SniperGame_All_StartSearching()
  ToClient_SniperGame_ChangeState(__eSniperGameState_Searching)
end
function PaGlobalFunc_SniperGame_All_StartAimMini()
  if false == PaGlobal_MiniGame_SniperGame_All._startAniIsPlaying then
    ToClient_SniperGame_ChangeState(__eSniperGameState_AimMiniGame)
  end
end
function PaGlobalFunc_SniperGame_All_StartRecovery()
  ToClient_SniperGame_ChangeState(__eSniperGameState_RecoverBreath)
end
function PaGlobalFunc_SniperGame_All_StartShoot()
  ToClient_SniperGame_ChangeState(__eSniperGameState_Shoot)
end
function PaGlobalFunc_SniperGame_All_StartCheckResult()
  ToClient_SniperGame_ChangeState(__eSniperGameState_CheckResult)
end
function PaGlobalFunc_SniperGame_All_StartReloading()
  ToClient_SniperGame_ChangeState(__eSniperGameState_Reloading)
end
function FromClient_SniperGame_All_StateBegin_Process(state)
  if state == __eSniperGameState_None then
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = true
  elseif state == __eSniperGameState_Searching then
    PaGlobal_MiniGame_SniperGame_All_StartSearchMode(PaGlobal_MiniGame_SniperGame_Control_All._firstShow)
    PaGlobal_MiniGame_SniperGame_Result_All_Close()
    PaGlobal_MiniGame_SniperReload_All_Close()
  elseif state == __eSniperGameState_RecoverBreath then
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = false
  elseif state == __eSniperGameState_AimMiniGame then
    PaGlobal_MiniGame_SniperGame_All_StartAimMiniGame()
    PaGlobal_MiniGame_SniperGame_Result_All_ClearResult()
    PaGlobal_MiniGame_SniperGame_Result_All_Close()
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = true
  elseif state == __eSniperGameState_Shoot then
    PaGlobal_MiniGame_SniperGame_All_StartShootingAnimation(0.12, 0.06)
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = true
  elseif state == __eSniperGameState_CheckResult then
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = true
    PaGlobal_MiniGame_SniperGame_All_Close()
    PaGlobal_MiniGame_SniperGame_Result_All_Open()
  elseif state == __eSniperGameState_Reloading then
    PaGlobal_MiniGame_SniperGame_Control_All._firstShow = true
    PaGlobal_MiniGame_SniperGame_All_Close()
  end
end
function FromClient_SniperGame_All_StateEnd_Process(state)
  if state == __eSniperGameState_AimMiniGame then
    PaGlobal_MiniGame_SniperGame_All_EndAimMiniGame()
  elseif state == __eSniperGameState_Reloading then
    if false == ToClient_SniperGame_IsPlaying() then
      return
    end
    PaGlobal_MiniGame_SniperReload_All_Close()
    PaGlobal_MiniGame_SniperGame_Result_All_Close()
    PaGlobal_MiniGame_SniperGame_All_Open()
    PaGlobal_MiniGame_SniperGame_All_FadeIn()
  end
end
function FromClient_SniperGame_All_ImpactResult_Process(devitaionRadius, desiredScreenPos, hittedScreenPos, hitPartType)
  PaGlobal_MiniGame_SniperGame_Result_All_UpdateShootResult(devitaionRadius, desiredScreenPos, hittedScreenPos, hitPartType)
end
function FromClient_SniperGame_All_Missed_Process(devitaionRadius, desiredScreenPos, hittedScreenPos)
  PaGlobal_MiniGame_SniperGame_Result_All_UpdateMissResult(devitaionRadius, desiredScreenPos, hittedScreenPos)
end
