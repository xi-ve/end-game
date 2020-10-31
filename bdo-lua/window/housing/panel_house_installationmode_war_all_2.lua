function HandleEventLUp_InstallationModeWar_All_Close()
  PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
end
function PaGlobal_InstallationModeWar_All_ShowAni()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
end
function PaGlobal_InstallationModeWar_All_HideAni()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
end
function PaGlobal_InstallationModeWar_All_Open()
  PaGlobal_InstallationModeWar_All:prepareOpen()
end
function PaGlobal_InstallationModeWar_All_Close()
  PaGlobal_InstallationModeWar_All:prepareClose()
end
