function PaGlobal_InstallationModeWar_All:initialize()
  if true == PaGlobal_InstallationModeWar_All._initialize then
    return
  end
  self._ui._btn_close = UI.getChildControl(Panel_House_InstallationMode_War_All, "Button_CameraRotation_Left")
  self._ui._btn_close:SetShow(false == _ContentsGroup_UsePadSnapping)
  PaGlobal_InstallationModeWar_All:registEventHandler()
  PaGlobal_InstallationModeWar_All:validate()
  PaGlobal_InstallationModeWar_All._initialize = true
end
function PaGlobal_InstallationModeWar_All:registEventHandler()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_InstallationModeWar_All_Close()")
end
function PaGlobal_InstallationModeWar_All:prepareOpen()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
  PaGlobal_InstallationModeWar_All:open()
end
function PaGlobal_InstallationModeWar_All:open()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
  Panel_House_InstallationMode_War_All:SetShow(true)
end
function PaGlobal_InstallationModeWar_All:prepareClose()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
  PaGlobal_InstallationModeWar_All:close()
end
function PaGlobal_InstallationModeWar_All:close()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
  Panel_House_InstallationMode_War_All:SetShow(false)
end
function PaGlobal_InstallationModeWar_All:update()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
end
function PaGlobal_InstallationModeWar_All:validate()
  if nil == Panel_House_InstallationMode_War_All then
    return
  end
end
