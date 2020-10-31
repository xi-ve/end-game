function HandleEventLUp_House_Installation_All_RotateButton(eButtonType)
  if PaGlobal_House_Installation_All._eButtonType.rotationLeft == eButtonType then
    local xDegree = 0.5
    local yDegree = 0
    housing_rotateCamera(xDegree, yDegree)
  elseif PaGlobal_House_Installation_All._eButtonType.rotationRight == eButtonType then
    local xDegree = -0.5
    local yDegree = 0
    housing_rotateCamera(xDegree, yDegree)
  elseif PaGlobal_House_Installation_All._eButtonType.rotateAngle == eButtonType then
    local isCheck = PaGlobal_House_Installation_All._ui._btn_rotation[eButtonType]:IsCheck()
    housing_setRestrictedRatateObject(isCheck)
  end
end
function HandleEventMOn_House_Installation_All_RotateTooltip(eButtonType)
  local name = ""
  local desc = ""
  if PaGlobal_House_Installation_All._eButtonType.rotationLeft == eButtonType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATELEFT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATELEFT_DESC")
  elseif PaGlobal_House_Installation_All._eButtonType.rotationRight == eButtonType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATERIGHT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATERIGHT_DESC")
  elseif PaGlobal_House_Installation_All._eButtonType.rotateAngle == eButtonType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATEANGLE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_ROTATEANGLE_DESC")
  end
  if "" ~= name then
    local control = PaGlobal_House_Installation_All._ui._btn_rotation[eButtonType]
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventLUp_House_Installation_All_Floor(floor)
  housing_selectHouseFloor(floor)
  PaGlobal_House_Installation_All:setCheckFloorButton(floor)
end
function PaGlobal_House_Installation_All_ShowAni()
  if nil == Panel_House_InstallationMode_All then
    return
  end
end
function PaGlobal_House_Installation_All_HideAni()
  if nil == Panel_House_InstallationMode_All then
    return
  end
end
function FromClient_House_Installation_All_UpdatePoint()
  PaGlobal_House_Installation_All:updateInteriorPoint()
end
function FromClient_House_Installation_All_Open(isShow)
  if true == isShow then
    PaGlobal_House_Installation_All_Open()
  else
    PaGlobal_House_Installation_All_Close()
  end
end
function FromClient_House_Installation_All_ShowInstallationMenu(installMode, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
  local posX = getMousePosX()
  local posY = getMousePosY()
  PaGlobal_House_Installation_All._value.isCanMove = isShowMove
  PaGlobal_House_Installation_All._value.isCanDelete = isShowDelete
  PaGlobal_House_Installation_All._value.isCanCancel = isShowCancel
  if true == PaGlobal_House_Installation_All._isConsole then
    PaGlobal_House_Installation_All_SetKeyGuide(installMode)
  elseif true == isShow then
    PaGlobal_House_InstallationMode_ObjectControl_All_Open(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
  else
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  end
  if true == PaGlobal_House_InstallationList_All_GetShowPanel() then
    PaGlobal_House_InstallationList_All_UpdateCart()
  end
end
function FromClient_House_Installation_All_InstallCancel()
  PaGlobal_House_InstallationMode_ObjectControl_All_Close()
end
function FromClient_House_Installation_All_UpdateInventory()
  PaGlobal_House_Installation_All:updateUseFarm()
end
function FromClient_House_Installation_All_UpdatePerFrame(deltaTime)
  PaGlobal_House_Installation_All:updateCurser()
  PaGlobal_House_Installation_All:updateInteriorSensePoint()
end
function FromClient_House_Installation_All_Resize()
  PaGlobal_House_Installation_All:resize()
end
function FromClient_House_Installation_All_ChangeInstallMode(preMode, nowMode)
  PaGlobal_House_Installation_All._eState = nowMode
  if PaGlobal_House_Installation_All._eModeState.none == PaGlobal_House_Installation_All._eState or PaGlobal_House_Installation_All._eModeState.translation == PaGlobal_House_Installation_All._eState then
    PaGlobal_House_Installation_All_SetKeyGuide(nowMode)
  end
  if PaGlobal_House_Installation_All._eModeState.none == PaGlobal_House_Installation_All._eState then
    Panel_House_InstallationMode_All:ignorePadSnapUpdate(false)
    Panel_House_InstallationMode_List_All:ignorePadSnapUpdate(false)
    Panel_House_InstallationMode_SeedList_All:ignorePadSnapUpdate(false)
  else
    Panel_House_InstallationMode_All:ignorePadSnapUpdate(true)
    Panel_House_InstallationMode_List_All:ignorePadSnapUpdate(true)
    Panel_House_InstallationMode_SeedList_All:ignorePadSnapUpdate(true)
  end
  if false == PaGlobal_House_Installation_All._isInstallMode then
    if PaGlobal_House_Installation_All._eModeState.detail == PaGlobal_House_Installation_All._eState then
      PaGlobal_House_Installation_All._value.isConfirm = true
    else
      PaGlobal_House_Installation_All._value.isConfirm = false
    end
  elseif PaGlobal_House_Installation_All._eModeState.watingConfirm == PaGlobal_House_Installation_All._eState then
    PaGlobal_House_Installation_All._value.isConfirm = true
  else
    PaGlobal_House_Installation_All._value.isConfirm = false
    PaGlobal_House_Installation_All._value.isCanDelete = false
  end
end
function FromClient_House_Installation_All_ChangePadCamera(canZoom)
  PaGlobal_House_Installation_All_SetKeyGuide(PaGlobal_House_Installation_All._eState)
end
function PaGlobal_House_Installation_All_Open()
  PaGlobal_House_Installation_All:prepareOpen()
end
function PaGlobal_House_Installation_All_Close()
  PaGlobal_House_Installation_All:prepareClose()
end
function PaGlobal_House_Installation_All_GetPanelShow()
  if nil == Panel_House_InstallationMode_All then
    return false
  end
  return Panel_House_InstallationMode_All:GetShow()
end
function PaGlobal_House_Installation_All_ByAttackedClose()
  if housing_isBuildMode() or housing_isInstallMode() then
    PaGlobal_House_Installation_All_Close()
  end
end
function PaGlobal_House_Installation_All_MessageBoxCancelDefault()
  if housing_isInstallMode() then
    if housing_isTemporaryObject() then
      PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
    end
  else
    PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
  end
end
function PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
  audioPostEvent_SystemUi(1, 33)
  _AudioPostEvent_SystemUiForXBOX(1, 33)
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "INSTALLATION_MODE_EXIT_MESSAGEBOX_MEMO")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "INSTALLATION_MODE_EXIT_MESSAGEBOX_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobal_House_Installation_All_Close,
    functionCancel = PaGlobal_House_Installation_All_MessageBoxCancelDefault,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  local isExist = MessageBox.doHaveMessageBoxData(messageboxData.title)
  if false == isExist then
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_House_Installation_All_IsCanMove()
  return PaGlobal_House_Installation_All._value.isCanMove
end
function PaGlobal_House_Installation_All_IsCanDelete()
  return PaGlobal_House_Installation_All._value.isCanDelete
end
function PaGlobal_House_Installation_All_IsConfirm()
  return PaGlobal_House_Installation_All._value.isConfirm
end
function PaGlobal_House_Installation_All_CanGetInput()
  if MessageBoxGetShow() then
    return false
  end
  return PaGlobal_House_Installation_All._eModeState.none ~= PaGlobal_House_Installation_All._eState
end
function PaGlobal_House_Installation_All_InitInput()
  PaGlobal_House_Installation_All._value.isCanControl = false
  PaGlobal_House_Installation_All._value.isConfirm = false
  PaGlobal_House_Installation_All._value.isCanMove = false
  PaGlobal_House_Installation_All._value.isCanDelete = false
end
function PaGlobal_House_Installation_All_SetKeyGuide(eState)
  if false == housing_isBuildMode() then
    if PaGlobal_House_Installation_All._eInstallType.housing == PaGlobal_House_Installation_All._eInstallMode then
      PaGlobal_House_InstallationList_All_SetKeyGuide(eState)
    elseif PaGlobal_House_Installation_All._eInstallType.seed == PaGlobal_House_Installation_All._eInstallMode then
      PaGlobal_Farm_InstallationList_All_SetKeyGuide(eState)
    end
  else
    PaGlobal_House_Installation_All:setKeyGuide(eState)
  end
end
