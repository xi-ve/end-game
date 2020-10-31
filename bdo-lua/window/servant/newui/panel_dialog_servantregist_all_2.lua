function PaGlobalFunc_ServantRegist_All_Open(openType)
  if nil == Panel_Dialog_ServantRegist_All or true == Panel_Dialog_ServantRegist_All:GetShow() or nil == openType then
    return
  end
  if true == Panel_Dialog_ServantSwiftResult_All:GetShow() then
    return
  end
  PaGlobal_ServantRegist_All._registerType = openType
  PaGlobal_ServantRegist_All:prepareOpen()
end
function PaGlobalFunc_ServantRegist_All_Close()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantRegist_All:prepareClose()
end
function FromClient_ServantRegist_All_OnScreenResize()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantRegist_All:ComputePos()
end
function HandleEventLUp_ServantRegist_All_SelectMapae(idx)
  if nil == idx or nil == PaGlobal_ServantRegist_All._itemSlotTable then
    return
  end
  PaGlobalFunc_ServantRegist_All_ClearAllEffect()
  if nil ~= PaGlobal_ServantRegist_All._itemSlotTable[idx]._itemData then
    PaGlobal_ServantRegist_All._selectIdx = idx
    local mapaeData = PaGlobal_ServantRegist_All._itemSlotTable[idx]._itemData
    local itemWrapper = getInventoryItemByType(mapaeData._inventoryType, mapaeData._slotIdx)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    local SelectItemName = itemSSW:getName()
    local characterkey = itemSSW:getObjectKey()
    local isVaild = itemSSW:getCharacterStaticStatus()
    if nil == isVaild then
      return
    end
    local servantInfo = stable_getServantByCharacterKey(characterkey, 1)
    if nil == servantInfo then
      return
    end
    local vehicleType = servantInfo:getVehicleType()
    local weight = makeDotMoney(servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000)
    local hp = makeDotMoney(servantInfo:getMaxHp())
    local stamina = makeDotMoney(getMaxMpToServantInfo(servantInfo))
    local life = 0
    if servantInfo:isPeriodLimit() then
      life = servantInfo:getStaticExpiredTime() / 60 / 60 / 24 .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFETIME")
    else
      life = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE")
    end
    local speed = string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%"
    local accel = string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%"
    local turn = string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%"
    local brake = string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%"
    PaGlobal_ServantRegist_All._ui._txt_RegistItemName:SetText(SelectItemName)
    UI.setLimitTextAndAddTooltip(PaGlobal_ServantRegist_All._ui._txt_RegistItemName)
    PaGlobal_ServantRegist_All._ui._txt_Hp:SetText(hp)
    PaGlobal_ServantRegist_All._ui._txt_Stamina:SetText(stamina)
    PaGlobal_ServantRegist_All._ui._txt_Weight:SetText(weight)
    PaGlobal_ServantRegist_All._ui._txt_LifeSpan:SetText(life)
    PaGlobal_ServantRegist_All._ui._txt_Speed:SetText(speed)
    PaGlobal_ServantRegist_All._ui._txt_Accel:SetText(accel)
    PaGlobal_ServantRegist_All._ui._txt_Turn:SetText(turn)
    PaGlobal_ServantRegist_All._ui._txt_Brake:SetText(brake)
    local hpTitle = ""
    local staminaTitle = ""
    local lifeTitle = ""
    local npcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
    if 0 == npcType or 1 == npcType then
      if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
        hpTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_CARRIAGE_MP")
        staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP")
        lifeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE")
      elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
        hpTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_CARRIAGE_MP")
        staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME")
        lifeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE")
      else
        hpTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_HP")
        staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MP")
        lifeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE")
      end
    else
      hpTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_CARRIAGE_MP")
      lifeTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE")
      if true == _ContentsGroup_OceanCurrent then
        local characterKey = servantInfo:getCharacterKeyRaw()
        local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
        if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
          staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME")
          PaGlobal_ServantRegist_All._ui._txt_Stamina:SetText(makeDotMoney(getMaxMpToServantInfo(servantInfo)))
        else
          staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP")
        end
      elseif CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
        staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME")
      else
        staminaTitle = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP")
      end
    end
    PaGlobal_ServantRegist_All._ui._txt_HpTitle:SetText(hpTitle)
    PaGlobal_ServantRegist_All._ui._txt_StaminaTitle:SetText(staminaTitle)
    PaGlobal_ServantRegist_All._ui._txt_LifeSpanTitle:SetText(lifeTitle)
    PaGlobal_ServantRegist_All._itemSlotTable[idx]._slot.icon:AddEffect("fUI_HorseNameCard01", true, 0, 0)
    PaGlobal_ServantRegist_All._itemSlotTable[idx]._slot.icon:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
    PaGlobal_ServantRegist_All._currentInvenType = mapaeData._inventoryType
    PaGlobal_ServantRegist_All._currentInvenSlotNo = mapaeData._slotIdx
    if true == _ContentsGroup_RenewUI then
      local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
      PaGlobal_ServantRegist_All._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
    end
  else
    PaGlobal_ServantRegist_All._ui._txt_Hp:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Stamina:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Weight:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_LifeSpan:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Speed:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Accel:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Turn:SetText("-")
    PaGlobal_ServantRegist_All._ui._txt_Brake:SetText("-")
  end
end
function HandleEventLUp_ServantRegist_All_RegisterServantConfirm()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  local registerType = PaGlobal_ServantRegist_All._registerType
  PaGlobalFunc_ServantRegist_All_ServantRegister()
end
function HandleEventLUp_ServantRegist_All_ClearEdit()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  PaGlobal_ServantRegist_All._ui._stc_EditNaming:SetEditText("", true)
  PaGlobal_ServantRegist_All._isEditing = true
  SetFocusEdit(PaGlobal_ServantRegist_All._ui._stc_EditNaming)
end
function PaGlobalFunc_ServantRegist_All_ClearAllEffect()
  if nil == Panel_Dialog_ServantRegist_All or nil == PaGlobal_ServantRegist_All._itemSlotTable then
    return
  end
  for idx = 0, PaGlobal_ServantRegist_All._SHOWSLOTCOUNT - 1 do
    PaGlobal_ServantRegist_All._itemSlotTable[idx]._slot.icon:EraseAllEffect()
  end
end
function PaGlobalFunc_ServantRegist_All_ServantRegister()
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local name = PaGlobal_ServantRegist_All._ui._stc_EditNaming:GetEditText()
  local registerType = PaGlobal_ServantRegist_All._registerType
  local function do_regist()
    if CppEnums.ServantRegist.eEventType_Inventory == registerType then
      PaGlobal_ServantRegist_All._isRegister = true
      stable_registerByItem(PaGlobal_ServantRegist_All._currentInvenType, PaGlobal_ServantRegist_All._currentInvenSlotNo, name)
    end
    if false == _ContentsGroup_RenewUI then
      PaGlobal_ServantRegist_All._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_EDITDESC"), true)
    else
      local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
      PaGlobal_ServantRegist_All._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
    end
    PaGlobalFunc_ServantRegist_All_Close()
  end
  ClearFocusEdit()
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_THISNAMEREGISTER", "name", name)
  if false == _ContentsGroup_RenewUI and false == PaGlobal_ServantRegist_All._isEditing or "" == name then
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTREGIST_ALL_CHECK_EMPTY_EDITBOX")
  end
  local _confirmFunction = do_regist
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantRegist_All_PageChange(isNext)
  if nil == Panel_Dialog_ServantRegist_All or false == Panel_Dialog_ServantRegist_All:GetShow() then
    return
  end
  if true == isNext then
    if PaGlobal_ServantRegist_All._maxPage <= PaGlobal_ServantRegist_All._currentSlotPage then
      return
    end
    PaGlobal_ServantRegist_All._currentSlotPage = PaGlobal_ServantRegist_All._currentSlotPage + 1
  else
    PaGlobal_ServantRegist_All._currentSlotPage = PaGlobal_ServantRegist_All._currentSlotPage - 1
    if PaGlobal_ServantRegist_All._currentSlotPage < 0 then
      PaGlobal_ServantRegist_All._currentSlotPage = 0
      return
    end
  end
  PaGlobal_ServantRegist_All._currentInvenSlotNo = 0
  if true == PaGlobal_ServantRegist_All._isConsole then
    ToClient_padSnapResetControl()
  end
  PaGlobal_ServantRegist_All:update()
end
function PaGlobalFunc_ServantRegist_All_IsRegister()
  if true == PaGlobal_ServantRegist_All._isRegister then
    PaGlobal_ServantRegist_All._isRegister = false
    return true
  end
  return false
end
function PaGlobal_ServantRegist_All_RegistServantInputEnter()
  if nil == PaGlobal_ServantRegist_All._selectIdx or nil == PaGlobal_ServantRegist_All._itemSlotTable[PaGlobal_ServantRegist_All._selectIdx] then
    return
  end
  if nil == PaGlobal_ServantRegist_All._itemSlotTable[PaGlobal_ServantRegist_All._selectIdx]._itemData then
    return
  end
  HandleEventLUp_ServantRegist_All_RegisterServantConfirm()
end
function HandleEventPadUp_ServantRegist_All_ConfirmRegist()
  if false == PaGlobal_ServantRegist_All._isConsole then
    return
  end
  local editText = PaGlobal_ServantRegist_All._ui._stc_EditNaming:GetEditText()
  if "" == editText or nil == editText then
    return
  end
  if true == PaGlobal_ServantRegist_All._ui._stc_EditNaming:GetFocusEdit() then
    PaGlobalFunc_ServantRegist_All_ServantRegister()
  end
end
function PaGlobalFunc_ServantRegist_All_ConfirmVirtualKeyBoard(str)
  ClearFocusEdit()
  if nil ~= str then
    PaGlobal_ServantRegist_All._ui._stc_EditNaming:SetEditText(str)
    HandleEventPadUp_ServantRegist_All_ConfirmRegist()
  end
end
