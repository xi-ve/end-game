function PaGlobal_ServantNameRegist_All:initialize()
  if nil == Panel_Dialog_ServantNameRegist_All or true == self.initialize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Close")
  self._ui._stc_MainBg = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_MainBg")
  self._ui._stc_ContentBg = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_ContentBg")
  self._ui._stc_HorseImage = UI.getChildControl(self._ui._stc_ContentBg, "Static_Image")
  self._ui._stc_GenderIcon = UI.getChildControl(self._ui._stc_HorseImage, "Static_GenderIcon")
  self._ui._txt_HpTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_HpTitle")
  self._ui._txt_HpValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_HpValue")
  self._ui._txt_StaminaTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_StaminaTitle")
  self._ui._txt_StaminaValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_StaminaValue")
  self._ui._txt_WeightTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_WeightTitle")
  self._ui._txt_WeightValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_WeightValue")
  self._ui._txt_LeftLifeTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_LeftLifeTitle")
  self._ui._txt_LeftLifeValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_LeftLifeValue")
  self._ui._txt_SpeedTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_SpeedTitle")
  self._ui._txt_SpeedValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_SpeedValue")
  self._ui._txt_AccelTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_AccelerationTitle")
  self._ui._txt_AccelValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_AccelerationValue")
  self._ui._txt_CorneringTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_CorneringSpeedTitle")
  self._ui._txt_CorneringValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_BreakTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_BreakTitle")
  self._ui._txt_BreakValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_BreakValue")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_X_ConsoleUI")
  self._ui._stc_EditNaming = UI.getChildControl(self._ui._stc_ContentBg, "Edit_Naming")
  self._ui._stc_EditRentalName = UI.getChildControl(self._ui._stc_ContentBg, "Edit_RentalName")
  self._ui._stc_PriceBg = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_PriceBg")
  self._ui._txt_Price = UI.getChildControl(self._ui._stc_PriceBg, "StaticText_PriceValue")
  self._ui._rdo_Mine = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "RadioButton_Mine")
  self._ui._rdo_All = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "RadioButton_All")
  self._ui._btn_Confirm = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Confirm")
  self._ui._btn_Cancel = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Cancel")
  self._ui._stc_Console_KeyGuides = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_B_ConsoleUI")
  self._ORIGIN_PANELSIZE_Y = Panel_Dialog_ServantNameRegist_All:GetSizeY()
  self._ORIGIN_BUTTONPOS_Y = self._ui._btn_Confirm:GetPosY()
  self._ORIGIN_MAINBGSIZE_Y = self._ui._stc_MainBg:GetSizeY()
  self._isConsole = _ContentsGroup_UsePadSnapping
  if true == self._isConsole then
    self._ORIGIN_PANELSIZE_Y = self._ORIGIN_PANELSIZE_Y - self._ui._btn_Confirm:GetSizeY() - 15
    self._ORIGIN_MAINBGSIZE_Y = self._ORIGIN_MAINBGSIZE_Y - self._ui._btn_Confirm:GetSizeY() - 15
  end
  PaGlobal_ServantNameRegist_All:validate()
  PaGlobal_ServantNameRegist_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantNameRegist_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantNameRegist_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantNameRegist_All or false == self._initialize then
    return
  end
  self._ui._stc_EditNaming:SetMaxInput(getGameServiceTypeServantNameLength())
  registerEvent("FromClient_ServantChildInfo", "PaGlobalFunc_ServantNameRegist_All_OpenByMating")
  registerEvent("FromClient_ServantRegisterToAuction", "PaGlobalFunc_ServantNameRegist_All_Close")
  registerEvent("onScreenResize", "FromClient_ServantNameRegist_All_OnScreenResize")
  if false == isConsole then
    Panel_Dialog_ServantNameRegist_All:SetDragEnable(true)
    Panel_Dialog_ServantNameRegist_All:SetDragAll(true)
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_Close()")
    self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_Close()")
    self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_ServantRegister()")
    self._ui._stc_EditNaming:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClearEdit()")
    self._ui._stc_EditNaming:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ServantRegister()")
    self._ui._stc_EditRentalName:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClearEdit()")
    self._ui._stc_EditRentalName:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ServantRegister()")
    self._ui._rdo_All:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 0 )")
    self._ui._rdo_Mine:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 1 )")
  else
    Panel_Dialog_ServantNameRegist_All:ignorePadSnapMoveToOtherPanel()
    self._ui._stc_EditNaming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantNameRegist_All_ServantRegister")
    self._ui._stc_EditRentalName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantNameRegist_All_ServantRegister")
    Panel_Dialog_ServantNameRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ServantNameRegist_All_ServantRegister()")
    Panel_Dialog_ServantNameRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantNameRegist_All_ClearEdit()")
    self._ui._rdo_All:addInputEvent("Mouse_On", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 0 )")
    self._ui._rdo_Mine:addInputEvent("Mouse_On", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 1 )")
  end
end
function PaGlobal_ServantNameRegist_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantNameRegist_All or false == self._initialize then
    return
  end
  self._ui._stc_Console_KeyGuides:SetShow(isConsole)
  self._ui._stc_KeyGuide_X:SetShow(isConsole)
  self._ui._btn_Confirm:SetShow(not isConsole)
  self._ui._btn_Cancel:SetShow(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Console_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_Console_KeyGuides:SetPosY(Panel_Dialog_ServantNameRegist_All:GetSizeY())
  end
end
function PaGlobal_ServantNameRegist_All:prepareOpen()
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantNameRegist_All:open()
  FromClient_ServantNameRegist_All_OnScreenResize()
  PaGlobal_ServantNameRegist_All:update()
end
function PaGlobal_ServantNameRegist_All:open()
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantNameRegist_All:SetShow(true)
end
function PaGlobal_ServantNameRegist_All:update()
  if nil == Panel_Dialog_ServantNameRegist_All then
    return
  end
  local servantInfo
  if self._ENUM_OPENTYPE._TAMING == self._registerType or self._ENUM_OPENTYPE._MATING == self._registerType then
    servantInfo = stable_getServantByCharacterKey(self._characterKey, self._level)
  elseif nil ~= self._currentServantNo then
    servantInfo = stable_getServant(self._currentServantNo)
  end
  if nil == servantInfo then
    return
  end
  local vehicleType = servantInfo:getVehicleType()
  if CppEnums.VehicleType.Type_Horse == vehicleType then
    self._ui._stc_GenderIcon:SetShow(true)
    self._ui._stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_GenderIcon, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_GenderIcon, 1, 178, 31, 208)
    end
    self._ui._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_GenderIcon:setRenderTexture(self._ui._stc_GenderIcon:getBaseTexture())
  else
    self._ui._stc_GenderIcon:SetShow(false)
  end
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    elseif nil ~= shipStaticStatus then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    elseif CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE"))
    elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
    else
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    end
  else
    local isWarterVehicle = ToClient_isVehicleTypeWarter(vehicleType)
    if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE"))
    elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
    elseif true == isWarterVehicle then
      if CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
        self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
        self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
        self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
      else
        self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
        self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
        self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
      end
    else
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    end
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  self._ui._stc_HorseImage:ChangeTextureInfoName(servantInfo:getIconPath1())
  self._ui._txt_HpValue:SetText(makeDotMoney(servantInfo:getMaxHp()))
  self._ui._txt_StaminaValue:SetText(makeDotMoney(getMaxMpToServantInfo(servantInfo)))
  self._ui._txt_WeightValue:SetText(makeDotMoney(servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000))
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._ui._txt_AccelValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  if true == servantInfo:isPeriodLimit() then
    self._ui._txt_LeftLifeValue:SetText(servantInfo:getStaticExpiredTime() / 60 / 60 / 24 .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFETIME"))
  else
    self._ui._txt_LeftLifeValue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
  end
  HandleEventLUp_ServantNameRegist_All_ClickRadioButton(0)
  if nil ~= self._minPrice then
    self._ui._txt_Price:SetText(makeDotMoney(self._minPrice))
  end
end
function PaGlobal_ServantNameRegist_All:prepareClose()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  ClearFocusEdit()
  PaGlobal_ServantNameRegist_All:close()
end
function PaGlobal_ServantNameRegist_All:close()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantNameRegist_All:SetShow(false)
end
function PaGlobal_ServantNameRegist_All:validate()
  if nil == Panel_Dialog_ServantNameRegist_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._stc_ContentBg:isValidate()
  self._ui._stc_HorseImage:isValidate()
  self._ui._stc_GenderIcon:isValidate()
  self._ui._txt_HpTitle:isValidate()
  self._ui._txt_HpValue:isValidate()
  self._ui._txt_StaminaTitle:isValidate()
  self._ui._txt_StaminaValue:isValidate()
  self._ui._txt_WeightTitle:isValidate()
  self._ui._txt_WeightValue:isValidate()
  self._ui._txt_LeftLifeTitle:isValidate()
  self._ui._txt_LeftLifeValue:isValidate()
  self._ui._txt_SpeedTitle:isValidate()
  self._ui._txt_SpeedValue:isValidate()
  self._ui._txt_AccelTitle:isValidate()
  self._ui._txt_AccelValue:isValidate()
  self._ui._txt_CorneringTitle:isValidate()
  self._ui._txt_CorneringValue:isValidate()
  self._ui._txt_BreakTitle:isValidate()
  self._ui._txt_BreakValue:isValidate()
  self._ui._stc_EditNaming:isValidate()
  self._ui._stc_EditRentalName:isValidate()
  self._ui._stc_PriceBg:isValidate()
  self._ui._txt_Price:isValidate()
  self._ui._rdo_Mine:isValidate()
  self._ui._rdo_All:isValidate()
  self._ui._btn_Confirm:isValidate()
  self._ui._btn_Cancel:isValidate()
  self._ui._stc_Console_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._initialize = true
end
