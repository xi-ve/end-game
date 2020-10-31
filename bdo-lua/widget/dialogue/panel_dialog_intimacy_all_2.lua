function PaGlobalFunc_DialogIntimacy_All_Open()
  PaGlobal_DialogIntimacy_All:prepareOpen()
end
function PaGlobalFunc_DialogIntimacy_All_Close()
  PaGlobal_DialogIntimacy_All:prepareClose()
end
function HandleEventOnOut_DialogIntimacy_All_CircleTooltip(isShow)
end
function PaGloabl_PaGlobal_DialogIntimacy_All_ShowAni()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
end
function PaGloabl_PaGlobal_DialogIntimacy_All_HideAni()
  if nil == Panel_Npc_Intimacy_All then
    return
  end
end
function FromClient_DialogIntimacy_All_VaryIntimacy()
  PaGlobalFunc_DialogIntimacy_All_VaryIntimacy()
end
function PaGlobalFunc_DialogIntimacy_All_VaryIntimacy()
  if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
    PaGlobal_DialogIntimacy_All:intimacyValueUpdate()
  end
end
function PaGlobalFunc_DialogIntimacy_All_IntimacyHide()
  if false == PaGlobal_DialogIntimacy_All._initialize then
    return
  end
  PaGlobal_DialogIntimacy_All._ui.stc_title:SetShow(false)
  PaGlobal_DialogIntimacy_All._ui.stc_progressBg:SetShow(false)
  PaGlobal_DialogIntimacy_All._ui.stc_progress:SetShow(false)
  for index = 0, PaGlobal_DialogIntimacy_All._maxIntimacyRewardCount - 1 do
    PaGlobal_DialogIntimacy_All._rewardList[index].icon:SetShow(false)
    PaGlobal_DialogIntimacy_All._rewardList[index].reward:SetShow(false)
  end
end
function PaGlobalFunc_DialogIntimacy_All_IntimacyShow()
  if false == PaGlobal_DialogIntimacy_All._initialize then
    return
  end
  PaGlobal_DialogIntimacy_All._ui.stc_title:SetShow(true)
  PaGlobal_DialogIntimacy_All._ui.stc_progressBg:SetShow(true)
  PaGlobal_DialogIntimacy_All._ui.stc_progress:SetShow(true)
end
