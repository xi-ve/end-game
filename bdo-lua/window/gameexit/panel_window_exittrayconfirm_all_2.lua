function PaGlobalFunc_ExitTrayConfirm_All_ExitOpen()
  PaGlobal_ExitTrayConfirm_All:prepareOpen(PaGlobal_ExitTrayConfirm_All._openType.EXIT)
end
function PaGlobalFunc_ExitTrayConfirm_All_TrayOpen()
  PaGlobal_ExitTrayConfirm_All:prepareOpen(PaGlobal_ExitTrayConfirm_All._openType.TRAY)
end
function PaGlobalFunc_ExitTrayConfirm_All_Close()
  PaGlobal_ExitTrayConfirm_All:prepareClose()
end
function HandleEventLUp_ExitTrayConfirm_All_Close()
  PaGlobalFunc_ExitTrayConfirm_All_Close()
end
function HandleEventLUp_ExitTrayConfirm_All_Confirm()
  if true == PaGlobal_ExitTrayConfirm_All._ui.chk_tray:IsCheck() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TRAYBLACKDESERT_ACK"))
    ToClient_CheckTrayIcon()
    PaGlobalFunc_ExitTrayConfirm_All_Close()
    PaGlobal_GameExit_All_Close()
  else
    ToClient_UnCheckTrayIcon()
    PaGlobalFunc_ExitTrayConfirm_All_Close()
    if true == isGameTypeKR2() then
      PaGlobal_GameExit_ALL_GameExitSuccess()
    end
  end
end
