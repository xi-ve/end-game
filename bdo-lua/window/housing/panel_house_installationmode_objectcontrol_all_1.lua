function PaGlobal_House_InstallationMode_ObjectControl_All:initialize()
  if true == PaGlobal_House_InstallationMode_ObjectControl_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_background = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Static_Background")
  self._ui._btn_control = {
    [self._eButtonType.confirm] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Confirm"),
    [self._eButtonType.move] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Move"),
    [self._eButtonType.rotateLeft] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Rotate_Left"),
    [self._eButtonType.rotateRight] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Rotate_Right"),
    [self._eButtonType.delete] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Delete"),
    [self._eButtonType.exit] = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Button_Exit")
  }
  self._ui._txt_detailGuide = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "StaticText_DetailGuide")
  self._ui._btn_closeDesc = UI.getChildControl(Panel_House_InstallationMode_ObjectControl_All, "Static_ButtonText")
  self._startPosX = self._ui._btn_control[self._eButtonType.confirm]:GetPosX()
  self._defaultGuideSizeX = self._ui._txt_detailGuide:GetSizeX()
  self._defaultGuideSizeY = self._ui._txt_detailGuide:GetSizeY()
  PaGlobal_House_InstallationMode_ObjectControl_All:registEventHandler()
  PaGlobal_House_InstallationMode_ObjectControl_All:validate()
  PaGlobal_House_InstallationMode_ObjectControl_All._initialize = true
end
function PaGlobal_House_InstallationMode_ObjectControl_All:registEventHandler()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
  for k, value in pairs(self._ui._btn_control) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationMode_ObjectControl_All_ControlEvent(" .. k .. ")")
    value:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationMode_ObjectControl_All_ButtonTooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:prepareOpen(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if true == self._isConsole then
    return
  end
  self:initButtonSetting(installMode, isShow, isShowMove, isShowDelete, isShowCancel)
  Panel_House_InstallationMode_ObjectControl_All:SetPosX(posX)
  Panel_House_InstallationMode_ObjectControl_All:SetPosY(posY)
  PaGlobal_House_InstallationMode_ObjectControl_All:open()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:open()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
  Panel_House_InstallationMode_ObjectControl_All:SetShow(true)
end
function PaGlobal_House_InstallationMode_ObjectControl_All:prepareClose()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
  self._isConfirmStep = false
  TooltipSimple_Hide()
  PaGlobal_House_InstallationMode_ObjectControl_All:close()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:close()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
  Panel_House_InstallationMode_ObjectControl_All:SetShow(false)
end
function PaGlobal_House_InstallationMode_ObjectControl_All:update()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:validate()
  if nil == Panel_House_InstallationMode_ObjectControl_All then
    return
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:initButtonSetting(installMode, isShow, isShowMove, isShowDelete, isShowCancel)
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  local installationType
  if nil ~= characterStaticWrapper then
    installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
  end
  local tempShow = isShow
  local houseBuildMode = housing_isBuildMode()
  if 2 == installMode and false == houseBuildMode then
    tempShow = false
  end
  self._ui._btn_control[self._eButtonType.confirm]:SetShow(tempShow)
  self._ui._btn_control[self._eButtonType.rotateRight]:SetShow(tempShow)
  self._ui._btn_control[self._eButtonType.rotateLeft]:SetShow(tempShow)
  self._ui._btn_control[self._eButtonType.delete]:SetShow(isShowDelete)
  self._ui._btn_control[self._eButtonType.move]:SetShow(isShowMove)
  self._ui._btn_control[self._eButtonType.exit]:SetShow(isShowCancel)
  self._isConfirmStep = true
  self._ui._stc_background:SetIgnore(false)
  if 0 < installMode and not housing_isBuildMode() then
    self._ui._txt_detailGuide:SetShow(true)
    self._ui._txt_detailGuide:SetSize(self._defaultGuideSizeX, self._defaultGuideSizeY)
  else
    self._ui._txt_detailGuide:SetShow(false)
  end
  self._ui._txt_detailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DESC"))
  if CppEnums.InstallationType.eType_Chandelier == installationType and 2 == installMode then
    self._ui._stc_background:SetIgnore(true)
    self._ui._txt_detailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DETAILGUIDE1"))
    self._typeIsHavest = false
  elseif (CppEnums.InstallationType.eType_Curtain == installationType or CppEnums.InstallationType.eType_Curtain_Tied == installationType) and 2 == installMode then
    self._ui._stc_background:SetIgnore(true)
    self._ui._txt_detailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DETAILGUIDE2"))
    self._ui._txt_detailGuide:SetSize(self._ui._txt_detailGuide:GetSizeX(), self._ui._txt_detailGuide:GetTextSizeY() + 8)
    self._typeIsHavest = false
  elseif CppEnums.InstallationType.eType_WallPaper == installationType and 3 == installMode then
    self._ui._btn_control[self._eButtonType.rotateRight]:SetShow(false)
    self._ui._btn_control[self._eButtonType.rotateLeft]:SetShow(false)
    self._typeIsHavest = false
  elseif CppEnums.InstallationType.eType_FloorMaterial == installationType and 3 == installMode then
    self._ui._btn_control[self._eButtonType.rotateRight]:SetShow(false)
    self._ui._btn_control[self._eButtonType.rotateLeft]:SetShow(false)
    self._typeIsHavest = false
  elseif (CppEnums.InstallationType.eType_Havest == installationType or CppEnums.InstallationType.eType_LivestockHarvest == installationType) and false == isFixed then
    self._typeIsHavest = true
    self._ui._btn_control[self._eButtonType.rotateRight]:SetShow(false)
    self._ui._btn_control[self._eButtonType.rotateLeft]:SetShow(false)
  else
    self._typeIsHavest = false
  end
  if self._ui._txt_detailGuide:GetTextSizeX() > self._defaultGuideSizeX then
    self._ui._txt_detailGuide:SetSize(self._ui._txt_detailGuide:GetTextSizeX() + 40, self._ui._txt_detailGuide:GetSizeY())
  end
  if nil ~= characterStaticWrapper then
    local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
    local isPersonalTent = objectStaticWrapper:isPersonalTent()
    if isPersonalTent then
      self._ui._btn_control[self._eButtonType.rotateRight]:SetShow(false)
      self._ui._btn_control[self._eButtonType.rotateLeft]:SetShow(false)
    end
  end
  if houseBuildMode then
    self._ui._btn_control[self._eButtonType.exit]:SetShow(false)
  end
  self:updateButtonPos()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventConfirm()
  if housing_isInstallMode() then
    local function doit()
      housing_InstallObject()
      PaGlobal_House_InstallationList_All_UpdateCart()
      PaGlobal_House_Installation_All_InitInput()
      self:prepareClose()
    end
    local doCancel = function()
      PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
      return
    end
    local installationType = CppEnums.InstallationType.TypeCount
    local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
    if nil ~= characterStaticWrapper then
      installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
      if installationType == CppEnums.InstallationType.eType_WallPaper or installationType == CppEnums.InstallationType.eType_FloorMaterial then
        local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_TITLE_WALLPAPERDONTCANCLE")
        local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_MEMO_WALLPAPERDONTCANCLE")
        local messageboxData = {
          title = titleString,
          content = contentString,
          functionYes = doit,
          functionCancel = doCancel,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
        return
      end
    end
    doit()
  elseif housing_isBuildMode() then
    local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
    if nil ~= characterStaticWrapper then
      local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
      local isVillageTent = objectStaticWrapper:isVillageTent()
      if isVillageTent then
        if true == self._isConsole then
          PaGlobalFunc_VillageTentPopup_Open()
        else
          FGlobal_VillageTent_SelectPopup()
        end
        return
      end
    end
    local regionKeyRaw = 0
    if nil ~= characterStaticWrapper then
      local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
      if objectStaticWrapper:isAdvancedBase() then
        local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
        if nil ~= myGuildInfo then
          local guildNo = myGuildInfo:getGuildNo_s64()
          if ToClient_IsInSiegeBattle(guildNo) then
            regionKeyRaw = self:getRegionRaw()
          end
        end
      end
    end
    housing_InstallObject(regionKeyRaw)
    PaGlobal_House_InstallationMode_ObjectControl_All_Close()
    PaGlobal_House_Installation_All_Close()
  else
    PaGlobal_House_Installation_All_Close()
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventMove()
  housing_moveObject()
  self:prepareClose()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventRotate(isLeft)
  if true == isLeft then
    housing_rotateObject(1)
  else
    housing_rotateObject(2)
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventDelete()
  housing_deleteObject()
  self:prepareClose()
  PaGlobal_House_InstallationList_All_UpdateCart()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:buttonEventCancel()
  if true == housing_isBuildMode() then
    PaGlobal_House_InstallationMode_ObjectControl_All_ObjectMove()
    return
  end
  housing_CancelInstallObject()
  self:prepareClose()
  PaGlobal_FarmInfo_All_Close()
  PaGlobal_House_InstallationList_All_UpdateCart()
end
function PaGlobal_House_InstallationMode_ObjectControl_All:updateButtonPos()
  local posX = 0
  local size = 0
  for i = self._eButtonType.confirm, self._eButtonType.loopCount do
    if true == self._ui._btn_control[i]:GetShow() then
      self._ui._btn_control[i]:SetPosX(self._startPosX + posX)
      posX = posX + self._ui._btn_control[i]:GetSizeX() + 5
    end
  end
  if 0 < posX then
    self._ui._stc_background:SetShow(true)
    self._ui._stc_background:SetSize(self._startPosX + posX, self._ui._stc_background:GetSizeY())
    Panel_House_InstallationMode_ObjectControl_All:SetSize(self._startPosX + posX, self._ui._stc_background:GetSizeY())
    self._ui._btn_closeDesc:SetPosX(self._ui._btn_control[self._eButtonType.exit]:GetPosX())
    self._ui._btn_closeDesc:SetShow(self._ui._btn_control[self._eButtonType.exit]:GetShow())
    self._ui._txt_detailGuide:ComputePos()
    self._ui._btn_closeDesc:ComputePos()
  else
    self._ui._stc_background:SetShow(false)
  end
end
function PaGlobal_House_InstallationMode_ObjectControl_All:getRegionRaw()
  local tempregionKeyRaw = 0
  local position = housing_getInstallationPos()
  local currentDay = ToClient_GetCurrentInstallableTentDayOfWeek(position)
  local dayCount = housing_getInstallableSiegeKeyList(position)
  for ii = 0, dayCount - 1 do
    local regionInfoWrapper = housing_getInstallableSiegeRegionInfo(ii)
    local day = regionInfoWrapper:getVillageSiegeType()
    if currentDay == day then
      tempregionKeyRaw = regionInfoWrapper:get()._regionKey:get()
      return tempregionKeyRaw
    end
  end
  return tempregionKeyRaw
end
