function PaGlobal_MiniGame_SniperReload_All_Open()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  PaGlobal_MiniGame_SniperReload_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperReload_All_Close()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperReload_All:prepareClose()
end
function PaGlobal_MiniGame_SniperReload_All_UpdatePerFrame(deltaTime)
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._remainTime = PaGlobal_MiniGame_SniperReload_All._remainTime - deltaTime
  if PaGlobal_MiniGame_SniperReload_All._remainTime < 0 then
    PaGlobal_MiniGame_SniperReload_All._remainTime = 0
  end
  local remainTime = string.format("%.2f", PaGlobal_MiniGame_SniperReload_All._remainTime)
  PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMARKET_CASHITEREMIND_TIME", "Time", remainTime))
  PaGlobal_MiniGame_SniperReload_All._theta = PaGlobal_MiniGame_SniperReload_All._theta + deltaTime * PaGlobal_MiniGame_SniperReload_All._speed
  if PaGlobal_MiniGame_SniperReload_All._theta > PaGlobal_MiniGame_SniperReload_All._piDouble then
    PaGlobal_MiniGame_SniperReload_All._theta = 0
    PaGlobal_MiniGame_SniperReload_All._inputLocked = false
    PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:ResetVertexAni()
    PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
  end
  PaGlobal_MiniGame_SniperReload_All._markPosX = math.cos(PaGlobal_MiniGame_SniperReload_All._theta) * -PaGlobal_MiniGame_SniperReload_All._span + PaGlobal_MiniGame_SniperReload_All._span + PaGlobal_MiniGame_SniperReload_All._leftEndX
  PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:SetPosX(PaGlobal_MiniGame_SniperReload_All._markPosX)
end
function PaGlobal_MiniGame_SniperReload_All_KeyFunc(keyType)
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  if CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType then
    if false == PaGlobal_MiniGame_SniperReload_All._inputLocked and PaGlobal_MiniGame_SniperReload_All._leftSuccessX < PaGlobal_MiniGame_SniperReload_All._markPosX and PaGlobal_MiniGame_SniperReload_All._markPosX < PaGlobal_MiniGame_SniperReload_All._rightSuccessX then
      getSelfPlayer():get():SetMiniGameResult(0)
      PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:ResetVertexAni()
      PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
      PaGlobal_MiniGame_SniperReload_All_Close()
      luaTimer_AddEvent(PaGlobal_MiniGame_SniperGame_All_FadeIn, 500, false, 0)
    else
      audioPostEvent_SystemUi(11, 40)
      PaGlobal_MiniGame_SniperReload_All._inputLocked = true
      PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:ResetVertexAni()
      local aniData = PaGlobal_MiniGame_SniperReload_All._ui.stc_reloadMark:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
      aniData:SetStartColor(Defines.Color.C_FFFF0000)
      aniData:SetEndColor(Defines.Color.C_FFFFAB6D)
    end
  end
end
function FromClient_Minigame_Sniper_All_OnScreenSize()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  Panel_MiniGame_SniperReload_All:ComputePos()
  PaGlobal_MiniGame_SniperReload_All._ui.stc_BG:ComputePos()
end
