function PaGlobal_House_Installation_All:initialize()
  if true == PaGlobal_House_Installation_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_HouseInstallation
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobal_House_Installation_All_Close)
  self._ui._stc_titleGroup = UI.getChildControl(Panel_House_InstallationMode_All, "Static_TitleGroup")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_titleGroup, "StaticText_Title")
  self._ui._rdo_floors = {
    [self._eRadioType.firstFloor] = UI.getChildControl(self._ui._stc_titleGroup, "RadioButton_FirstFloor"),
    [self._eRadioType.secondFloor] = UI.getChildControl(self._ui._stc_titleGroup, "RadioButton_SecondFloor"),
    [self._eRadioType.thirdFloor] = UI.getChildControl(self._ui._stc_titleGroup, "RadioButton_ThirdFloor"),
    [self._eRadioType.fourFloor] = UI.getChildControl(self._ui._stc_titleGroup, "RadioButton_FourFloor")
  }
  self._ui._txt_pointBaseValue = UI.getChildControl(self._ui._stc_titleGroup, "StaticText_InteriorPointBaseValue")
  self._ui._txt_pointOptionValue = UI.getChildControl(self._ui._stc_titleGroup, "StaticText_InteriorPointOptionValue")
  self._ui._txt_pointBonusValue = UI.getChildControl(self._ui._stc_titleGroup, "StaticText_InteriorPointBonusValue")
  self._ui._txt_pointTotalValue = UI.getChildControl(self._ui._stc_titleGroup, "StaticText_InteriorPointTotalValue")
  self._ui._txt_interiorSensePoint = UI.getChildControl(Panel_House_InstallationMode_All, "StaticText_InteriorSensePoint")
  self._ui._stc_consoleMove = UI.getChildControl(Panel_House_InstallationMode_All, "Static_Move")
  self._ui._stc_bottomGroup = UI.getChildControl(Panel_House_InstallationMode_All, "Static_BottomGroup")
  self._ui._btn_rotation = {
    [self._eButtonType.rotationLeft] = UI.getChildControl(self._ui._stc_bottomGroup, "Button_CameraRotation_Left"),
    [self._eButtonType.rotationRight] = UI.getChildControl(self._ui._stc_bottomGroup, "Button_CameraRotation_Right"),
    [self._eButtonType.rotateAngle] = UI.getChildControl(self._ui._stc_bottomGroup, "CheckButton_ObjectRotateAngle45")
  }
  self._ui._stc_titleGroupFarm = UI.getChildControl(Panel_House_InstallationMode_All, "Static_TitleGroup_Farm")
  self._ui._txt_titleFarm = UI.getChildControl(self._ui._stc_titleGroupFarm, "StaticText_Title")
  self._ui._txt_useFarmInfo = UI.getChildControl(self._ui._stc_titleGroupFarm, "StaticText_2")
  self._ui._stc_consoleKeyBG = UI.getChildControl(Panel_House_InstallationMode_All, "Static_KeyGuide_ConsoleBG")
  self._ui._keyGuide._txt_RS_click = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_Click_ConsoleUI")
  self._ui._keyGuide._txt_RS_updown = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_UpDown_ConsoleUI")
  self._ui._keyGuide._txt_RS_leftright = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_LeftRight_ConsoleUI")
  self._ui._keyGuide._txt_RS = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_ConsoleUI")
  self._ui._keyGuide._txt_LS = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LS_ConsoleUI")
  self._ui._keyGuide._txt_LB_RB = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LB_RB_ConsoleUI")
  self._ui._keyGuide._txt_LT_RT = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LT_RT_ConsoleUI")
  self._ui._keyGuide._txt_Y = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_Y_ConsoleUI")
  self._ui._keyGuide._txt_X = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_X_ConsoleUI")
  self._ui._keyGuide._txt_A = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_A_ConsoleUI")
  self._ui._keyGuide._txt_B = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_B_ConsoleUI")
  local isPc = false == self._isConsole
  for k, value in pairs(self._ui._btn_rotation) do
    value:SetShow(isPc)
  end
  self._keyGuideString.build = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_BUILD")
  self._keyGuideString.install = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_INSTALL")
  self._keyGuideString.moveBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_MOVE")
  self._keyGuideString.changeWidthBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_WIDTH")
  self._keyGuideString.changeHeightBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHT")
  self._keyGuideString.zoomInOut = PAGetString(Defines.StringSheet_RESOURCE, "HOUSING_TXT_HELPZOOM")
  self._keyGuideString.changeCamMode = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_CAMMODE")
  self._keyGuideString.zoomInOutAndHeight = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHTMODE")
  self._ui._stc_consoleKeyBG:SetShow(self._isConsole)
  self._ui._txt_interiorSensePoint:SetFontColor(4293914607)
  self._ui._txt_interiorSensePoint:useGlowFont(true, "RealFont_17_Glow", 4292411606)
  self._ui._txt_interiorSensePoint:SetShow(false)
  self._ui._stc_consoleMove:SetShow(false)
  housing_setRestrictedRatateObject(false)
  PaGlobal_House_Installation_All:registEventHandler()
  PaGlobal_House_Installation_All:validate()
  PaGlobal_House_Installation_All._initialize = true
end
function PaGlobal_House_Installation_All:registEventHandler()
  if nil == Panel_House_InstallationMode_All then
    return
  end
  for k, value in pairs(self._ui._btn_rotation) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_House_Installation_All_RotateButton(" .. k .. ")")
    value:addInputEvent("Mouse_On", "HandleEventMOn_House_Installation_All_RotateTooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  for k, value in pairs(self._ui._rdo_floors) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_House_Installation_All_Floor(" .. k .. ")")
  end
  registerEvent("EventHousingShowHousingModeUI", "FromClient_House_Installation_All_Open")
  registerEvent("EventHousingShowVisitHouse", "FromClient_House_Installation_All_UpdatePoint")
  registerEvent("EventHousingShowInstallationMenu", "FromClient_House_Installation_All_ShowInstallationMenu")
  registerEvent("EventHousingCancelInstallObjectMessageBox", "FromClient_House_Installation_All_InstallCancel")
  registerEvent("EventHousingUpdateInstallationInven", "FromClient_House_Installation_All_UpdateInventory")
  registerEvent("EventUpdateInstallationActor", "FromClient_House_Installation_All_UpdateInventory")
  registerEvent("onScreenResize", "FromClient_House_Installation_All_Resize")
  registerEvent("FromClient_ChangeHousingInstallMode", "FromClient_House_Installation_All_ChangeInstallMode")
  registerEvent("FromClient_changePadCameraControlMode", "FromClient_House_Installation_All_ChangePadCamera")
end
function PaGlobal_House_Installation_All:prepareOpen()
  if nil == Panel_House_InstallationMode_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    return
  end
  if not IsSelfPlayerWaitAction() and not IsSelfPlayerBattleWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_ONLYWAITSTENCE"))
    return
  end
  InventoryWindow_Close()
  local isMyHouse = false
  if housing_isBuildMode() then
    self._isInstallMode = false
    self._eInstallMode = self._eInstallType.seed
  else
    self._isInstallMode = true
    local houseWrapper = housing_getHouseholdActor_CurrentPosition()
    if nil == houseWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_GOTO_NEAR_HOUSEHOLD"))
      return
    end
    if false == houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() and false == houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom() then
      self._eInstallMode = self._eInstallType.seed
      self:updateUseFarm()
    else
      self._eInstallMode = self._eInstallType.housing
      isMyHouse = selfPlayer:get():isMyHouseVisiting()
      local rv = housing_changeHousingMode(true, isMyHouse)
      if 0 ~= rv then
        return
      end
    end
  end
  ToClient_SaveUiInfo(false)
  Panel_Tooltip_Item_hideTooltip()
  audioPostEvent_SystemUi(1, 32)
  SetUIMode(Defines.UIMode.eUIMode_Housing)
  if Panel_Chatting_Input:IsShow() then
    ChatInput_CancelAction()
    ChatInput_CancelMessage()
    ChatInput_Close()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  self._renderMode:set()
  crossHair_SetShow(false)
  setShowLine(false)
  Panel_House_InstallationMode_All:RegisterUpdateFunc("FromClient_House_Installation_All_UpdatePerFrame")
  if false == self._isInstallMode then
    self._ui._stc_consoleKeyBG:SetShow(self._isConsole)
  else
    self._ui._stc_consoleKeyBG:SetShow(false)
  end
  if false == self._isInstallMode then
    PaGlobal_WarInfomation_All_Open()
    self._ui._stc_bottomGroup:SetShow(false)
    self._ui._stc_titleGroup:SetShow(false)
    self._ui._stc_titleGroupFarm:SetShow(true)
    self._ui._txt_useFarmInfo:SetShow(false)
    self._ui._txt_titleFarm:SetShow(true)
    self._ui._txt_titleFarm:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_SETUP"))
    PaGlobal_House_Installation_All:open()
    PaGlobal_InstallationModeWar_All_Open()
    return
  end
  self._ui._stc_bottomGroup:SetShow(true)
  self:updateTitle(isMyHouse)
  self:updateFloorButton()
  self:updateInteriorPoint()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_BUILDMODE")
  PaGlobal_House_Installation_All:open()
  if self._eInstallType.housing == self._eInstallMode then
    PaGlobal_House_InstallationList_All_Open()
    self._ui._stc_titleGroup:SetShow(true)
    self._ui._stc_titleGroupFarm:SetShow(false)
    self._ui._txt_useFarmInfo:SetShow(false)
  elseif self._eInstallType.seed == self._eInstallMode then
    PaGlobal_Farm_InstallationList_All_Open()
    self._ui._stc_titleGroup:SetShow(false)
    self._ui._stc_titleGroupFarm:SetShow(true)
    self._ui._txt_useFarmInfo:SetShow(true)
    self._ui._txt_titleFarm:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TEXT_PANELTITLE2"))
  end
  PaGlobal_InstallationModeWar_All_Open()
end
function PaGlobal_House_Installation_All:open()
  if nil == Panel_House_InstallationMode_All then
    return
  end
  Panel_House_InstallationMode_All:SetShow(true)
end
function PaGlobal_House_Installation_All:prepareClose()
  if nil == Panel_House_InstallationMode_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._renderMode:reset()
  crossHair_SetShow(true)
  setShowLine(true)
  housing_changeHousingMode(false, false)
  InventoryWindow_Close()
  PaGlobal_HouseName_All_PetMaidInit()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  if self._eInstallType.housing == self._eInstallMode then
    PaGlobal_House_InstallationList_All_Close()
  elseif self._eInstallType.seed == self._eInstallMode then
    PaGlobal_Farm_InstallationList_All_Close()
  end
  Panel_House_InstallationMode_All:ClearUpdateLuaFunc()
  PaGlobal_House_InstallationMode_ObjectControl_All_Close()
  PaGlobal_WarInfomation_All_Close()
  PaGlobal_House_Installation_All:close()
end
function PaGlobal_House_Installation_All:close()
  if nil == Panel_House_InstallationMode_All then
    return
  end
  Panel_House_InstallationMode_All:SetShow(false)
end
function PaGlobal_House_Installation_All:update()
  if nil == Panel_House_InstallationMode_All then
    return
  end
end
function PaGlobal_House_Installation_All:validate()
  if nil == Panel_House_InstallationMode_All then
    return
  end
end
function PaGlobal_House_Installation_All:updateTitle(isMyHouse)
  if true == isMyHouse then
    self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TEXT_PANELTITLE1"))
  else
    self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TEXT_PANELTITLE1") .. PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_HAPPYYOU"))
  end
end
function PaGlobal_House_Installation_All:updateInteriorPoint()
  local basePoint = toClient_GetVisitingBaseInteriorPoint()
  local optionPoint = toClient_GetVisitingSetOptionInteriorPoint()
  local bonusPoint = toClient_GetVisitingBonusInteriorPoint()
  local totalPoint = toClient_GetVisitingTotalInteriorPoint()
  basePoint = math.max(0, basePoint)
  optionPoint = math.max(0, optionPoint)
  bonusPoint = math.max(0, bonusPoint)
  totalPoint = math.max(0, totalPoint)
  self._ui._txt_pointBaseValue:SetText(basePoint)
  self._ui._txt_pointOptionValue:SetText(optionPoint)
  self._ui._txt_pointBonusValue:SetText(bonusPoint)
  self._ui._txt_pointTotalValue:SetText(totalPoint)
end
function PaGlobal_House_Installation_All:updateFloorButton()
  local floorCount = housing_getHouseFloorCount()
  for i = 0, self._eRadioType.loopCount do
    self._ui._rdo_floors[i]:SetShow(i < floorCount)
  end
  local currentFloor = housing_getHouseFloorSelfPlayerBeing()
  self:setCheckFloorButton(currentFloor)
end
function PaGlobal_House_Installation_All:setCheckFloorButton(floor)
  for i = 0, self._eRadioType.loopCount do
    self._ui._rdo_floors[i]:SetCheck(i == floor)
  end
end
function PaGlobal_House_Installation_All:updateUseFarm()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  if true == houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() or true == houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom() then
    return
  end
  local css = houseWrapper:getStaticStatusWrapper():get()
  self._ui._txt_useFarmInfo:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TEXT_INSTALLOBJECTCOUNT", "sum", houseWrapper:getInstallationCountSum(), "maxCount", css:getInstallationMaxCount()))
end
function PaGlobal_House_Installation_All:updateInteriorSensePoint()
  if false == self._isInstallMode or self._eInstallType.seed == self._eInstallMode then
    return
  end
  self._ui._txt_interiorSensePoint:SetShow(false)
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  if nil == characterStaticWrapper then
    return
  end
  local interiorSensePoint = housing_getAdditionalInteriorSensePoint()
  if 0 < interiorSensePoint and false == PaGlobal_House_InstallationMode_ObjectControl_All_GetShowPanel() then
    self._ui._txt_interiorSensePoint:SetShow(true)
    self._ui._txt_interiorSensePoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERIORSENSEPOINT", "point", tostring(interiorSensePoint)))
    if true == self._isConsole then
      self._ui._txt_interiorSensePoint:SetPosX(self._ui._stc_consoleMove:GetPosX() - self._ui._txt_interiorSensePoint:GetTextSizeX() * 0.5)
      self._ui._txt_interiorSensePoint:SetPosY(self._ui._stc_consoleMove:GetPosY() - (self._ui._txt_interiorSensePoint:GetSizeY() + 15))
    else
      self._ui._txt_interiorSensePoint:SetPosX(getMousePosX() - self._ui._txt_interiorSensePoint:GetSizeX() * 0.5)
      self._ui._txt_interiorSensePoint:SetPosY(getMousePosY() - (self._ui._txt_interiorSensePoint:GetSizeY() + 15))
    end
  end
end
function PaGlobal_House_Installation_All:updateCurser()
  if false == self._isConsole then
    return
  end
  local x = ToClient_GetVirtualMousePosX()
  local y = ToClient_GetVirtualMousePosY()
  self._ui._stc_consoleMove:SetPosX(x - self._screenGapSize.x)
  self._ui._stc_consoleMove:SetPosY(y - self._screenGapSize.y)
  if self._eModeState.none == self._eState then
    if true == self._ui._stc_consoleMove:GetShow() then
      self._ui._stc_consoleMove:SetShow(false)
    end
  elseif false == self._ui._stc_consoleMove:GetShow() then
    self._ui._stc_consoleMove:SetShow(true)
  end
end
function PaGlobal_House_Installation_All:resize()
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_House_InstallationMode_All:SetSize(sizeX, sizeY)
  Panel_House_InstallationMode_All:ComputePos()
  self._screenGapSize.x = (getOriginScreenSizeX() - sizeX) * 0.5
  self._screenGapSize.y = (getOriginScreenSizeY() - sizeY) * 0.5
end
function PaGlobal_House_Installation_All:setKeyGuide(modeType)
  for key, value in pairs(self._ui._keyGuide) do
    value:SetShow(false)
  end
  local isRotatePossible = housing_isAvailableRotateSelectedObject()
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  local isFixed, installationType, isPersonalTent
  if nil ~= houseWrapper then
    isFixed = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() or houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom()
  end
  if nil ~= characterStaticWrapper then
    installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
    local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
    isPersonalTent = objectStaticWrapper:isPersonalTent()
  end
  if self._eModeState.none == modeType then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    self._ui._keyGuide._txt_RS_updown:SetShow(true)
    self._ui._keyGuide._txt_RS:SetShow(true)
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.build)
    self._ui._keyGuide._txt_A:SetShow(true)
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  elseif self._eModeState.translation == modeType then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_LS,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    if true == isFixed then
      self._ui._keyGuide._txt_LS:SetShow(true)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.build)
    self._ui._keyGuide._txt_A:SetShow(true)
    Panel_House_InstallationMode_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_InstallationMode_House_ClickConfirm()")
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, 44, 10)
  elseif self._eModeState.detail == modeType then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_LS,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.build)
    self._ui._keyGuide._txt_A:SetShow(true)
    Panel_House_InstallationMode_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_InstallationMode_House_ClickConfirm()")
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  elseif self._eModeState.watingConfirm == modeType then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_Y,
      self._ui._keyGuide._txt_X,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.install)
    self._ui._keyGuide._txt_A:SetShow(true)
    if true == self._value.isCanDelete then
      self._ui._keyGuide._txt_X:SetShow(true)
    end
    if true == self._value.isCanMove then
      self._ui._keyGuide._txt_Y:SetShow(true)
    end
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  end
end
function PaGlobal_House_Installation_All:setKeyPosX(parantControl, keyList)
  local space = 44
  local maxLength = 0
  for key, value in ipairs(keyList) do
    if true == value:GetShow() then
      local spaceFromRight = value:GetTextSizeX() + space
      maxLength = math.max(maxLength, spaceFromRight)
    end
  end
  local parantControlSizeX = parantControl:GetSizeX()
  for key, value in ipairs(keyList) do
    if true == value:GetShow() then
      value:SetPosX(parantControlSizeX - maxLength)
    end
  end
end
