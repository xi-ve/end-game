function HandleEventLUp_House_InstallationMode_ObjectControl_All_ControlEvent(eBtnType)
  if PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.confirm == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventConfirm()
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.move == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventMove()
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.rotateLeft == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventRotate(true)
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.rotateRight == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventRotate(false)
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.delete == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventDelete()
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.exit == eBtnType then
    PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventCancel()
  end
end
function HandleEventOn_House_InstallationMode_ObjectControl_All_ButtonTooltip(eBtnType)
  local control = PaGlobal_House_InstallationMode_ObjectControl_All._ui._btn_control[eBtnType]
  local name = ""
  if PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.confirm == eBtnType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM")
    if true == PaGlobal_House_InstallationMode_ObjectControl_All_IsConfirmStep() then
      name = name .. "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_OBJECTCONTROL_SPACEBAR") .. ")"
    end
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.move == eBtnType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_MOVE")
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.rotateLeft == eBtnType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_LEFTROTATION")
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.rotateRight == eBtnType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_RIGHTROTATION")
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.delete == eBtnType then
    if true == PaGlobal_House_InstallationMode_ObjectControl_All._typeIsHavest then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DELETE")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_RETURN")
    end
  elseif PaGlobal_House_InstallationMode_ObjectControl_All._eButtonType.exit == eBtnType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CANCEL")
  end
  TooltipSimple_Show(control, name)
end
function PaGlobal_House_InstallationMode_ObjectControl_All_ShowAni()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All_HideAni()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return false
  end
  return Panel_House_InstallationMode_ObjectControl_All:GetShow()
end
function PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
  housing_CancelInstallObject()
  if nil ~= VillageTent_Close then
    VillageTent_Close()
  end
  if nil ~= PaGlobalFunc_VillageTent_Close then
    PaGlobalFunc_VillageTent_Close()
  end
  PaGlobal_House_InstallationMode_ObjectControl_All:prepareClose()
end
function PaGlobal_House_InstallationMode_ObjectControl_All_Open(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
  PaGlobal_House_InstallationMode_ObjectControl_All:prepareOpen(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
end
function PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
  PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventMove()
end
function PaGlobal_House_InstallationMode_ObjectControl_All_Confirm()
  PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventConfirm()
end
function PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  PaGlobal_House_InstallationMode_ObjectControl_All:prepareClose()
end
function PaGlobal_House_InstallationMode_ObjectControl_All_IsConfirmStep()
  return PaGlobal_House_InstallationMode_ObjectControl_All._isConfirmStep
end
function PaGlobal_House_InstallationMode_ObjectControl_All_ObjectDelete()
  PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventDelete()
end
