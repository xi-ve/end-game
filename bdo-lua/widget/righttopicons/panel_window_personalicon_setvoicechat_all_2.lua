function PaGlobalFunc_SetVoiceChat_All_Open()
  PaGlobal_SetVoiceChat_All:prepareOpen()
end
function PaGlobalFunc_SetVoiceChat_All_Close()
  PaGlobal_SetVoiceChat_All:prepareClose()
end
function PaGlobalFunc_SetVoiceChat_All_Toggle()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if true == Panel_Window_SetVoiceChat_All:GetShow() then
    PaGlobalFunc_SetVoiceChat_All_Close()
  else
    PaGlobalFunc_SetVoiceChat_All_Open()
  end
end
function HandleEventLUp_SetVoiceChat_All_Confirm()
  PaGlobal_SetVoiceChat_All:setSavingInfo()
end
function HandleMove_SetVoiceChat_All_Volume(sliderIdx)
  PaGlobal_SetVoiceChat_All:setVolume(sliderIdx)
end
function HandleEventLUp_SetVoiceChat_All_SetOnOff()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_SetVoiceChat_All:setChkOnOff()
end
function HandleEventLUp_SetVoiceChat_All_Volume(sliderIdx)
  if false == ToClient_IsConnectedMic() and 1 ~= sliderIdx then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_NOTCONNECTMIC"))
  end
  PaGlobal_SetVoiceChat_All:setVolume(sliderIdx)
end
function HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(isShow)
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if false == PaGlobal_SetVoiceChat_All._isConsole then
    return
  end
  if nil == PaGlobal_SetVoiceChat_All._ui_console.stc_guideA then
    return
  end
  PaGlobal_SetVoiceChat_All._ui_console.stc_guideA:SetShow(isShow)
  local keyGuideList = {
    PaGlobal_SetVoiceChat_All._ui_console.stc_guideY,
    PaGlobal_SetVoiceChat_All._ui_console.stc_guideA,
    PaGlobal_SetVoiceChat_All._ui_console.stc_guideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_SetVoiceChat_All._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function FromClient_SetVoiceChat_All_OnScreenResize()
  PaGlobal_SetVoiceChat_All:resize()
end
