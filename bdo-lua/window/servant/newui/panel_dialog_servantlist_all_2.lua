function PaGlobalFunc_ServantList_All_Open()
  if nil == Panel_Dialog_ServantList_All or true == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:prepareOpen()
end
function PaGlobalFunc_ServantList_All_ShowAni()
  if nil == Panel_Dialog_ServantList_All or true == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local isShow = Panel_Dialog_ServantList_All:IsShow()
  if isShow then
    Panel_Dialog_ServantList_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo1 = Panel_Dialog_ServantList_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo1:SetStartIntensity(3)
    aniInfo1:SetEndIntensity(1)
    aniInfo1.IsChangeChild = true
    aniInfo1:SetHideAtEnd(true)
    aniInfo1:SetDisableWhileAni(true)
  else
    UIAni.fadeInSCR_Down(Panel_Dialog_ServantList_All)
    Panel_Dialog_ServantList_All:SetShow(true, false)
  end
end
function PaGlobalFunc_ServantList_All_Update()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:update()
end
function PaGlobalFunc_ServantList_All_HideAni()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantList_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantList_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_ServantList_All_Close()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:prepareClose()
end
function FromClient_ServantList_All_List2ServantUpdate(content, key)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:setDataList2MYServant(content, key)
end
function HandleEventOn_ServantList_All_ShowCountTooltip(iconType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local uiControl, name, desc
  if 2 ~= PaGlobalFunc_ServantFunction_All_Get_NpcType() and 3 ~= PaGlobalFunc_ServantFunction_All_Get_NpcType() then
    if 0 == iconType then
      uiControl = PaGlobal_ServantList_All._ui._txt_SealServant_CountValue
      name = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SEALCOUNT_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SEALCOUNT_DESC")
    elseif 1 == iconType then
      uiControl = PaGlobal_ServantList_All._ui._txt_UnSealServant_CountValue
      name = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_UNSEALCOUNT_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_UNSEALCOUNT_DESC")
    elseif 2 == iconType then
      uiControl = PaGlobal_ServantList_All._ui._txt_ServantListValue
      name = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MAXCOUNT_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MAXCOUNT_DESC")
    end
  elseif 0 == iconType then
    uiControl = PaGlobal_ServantList_All._ui._txt_SealServant_CountValue
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_SEALCOUNT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_SEALCOUNT_DESC")
  elseif 1 == iconType then
    uiControl = PaGlobal_ServantList_All._ui._txt_UnSealServant_CountValue
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_UNSEALCOUNT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_UNSEALCOUNT_DESC")
  elseif 2 == iconType then
    uiControl = PaGlobal_ServantList_All._ui._txt_ServantListValue
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_MAXCOUNT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WHARFLIST_MAXCOUNT_DESC")
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventOut_ServantList_All_HideCountTooltip()
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  TooltipSimple_Hide()
end
function PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  if nil == Panel_Dialog_ServantList_All or nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return -1
  end
  return PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
end
function PaGlobalFunc_ServantList_All_Get_CurrentSlotType()
  if nil == Panel_Dialog_ServantList_All or nil == PaGlobal_ServantList_All._currentSealType then
    return -1
  end
  return PaGlobal_ServantList_All._currentSealType
end
function PaGlobalFunc_ServantList_All_GetSceneIndex()
  if nil == Panel_Dialog_ServantList_All or nil == PaGlobal_ServantList_All._selectSceneIndex then
    return
  end
  return PaGlobal_ServantList_All._selectSceneIndex
end
function PaGlobalFunc_ServantList_All_CharacterSceneResetServantNo(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  PaGlobal_ServantList_All._selectSceneIndex = PaGlobalFunc_ServantFunction_All_ScenePushObject(servantInfo, PaGlobal_ServantList_All._selectSceneIndex)
  if nil ~= servantInfo:getActionIndex() then
    showSceneCharacter(PaGlobal_ServantList_All._selectSceneIndex, false)
    showSceneCharacter(PaGlobal_ServantList_All._selectSceneIndex, true, servantInfo:getActionIndex())
  end
end
function PaGlobalFunc_SeravntInfo_All_ResetScrollPos()
  PaGlobal_ServantList_All._currentScrollData._pos = nil
  PaGlobal_ServantList_All._currentScrollData._idx = nil
end
function PaGlobalFunc_SeravntInfo_All_SaveScrollPos()
  PaGlobal_ServantList_All._currentScrollData._pos = PaGlobal_ServantList_All._ui._list2_Servant:GetVScroll():GetControlPos()
  PaGlobal_ServantList_All._currentScrollData._idx = PaGlobal_ServantList_All._ui._list2_Servant:getCurrenttoIndex()
  PaGlobalFunc_ServantList_All_SubMenuClose()
end
function PaGlobalFunc_SeravntInfo_All_LoadScrollPos()
  if nil == PaGlobal_ServantList_All._currentScrollData._pos or nil == PaGlobal_ServantList_All._currentScrollData._idx then
    return
  end
  PaGlobal_ServantList_All._ui._list2_Servant:setCurrenttoIndex(PaGlobal_ServantList_All._currentScrollData._idx)
  PaGlobal_ServantList_All._ui._list2_Servant:GetVScroll():SetControlPos(PaGlobal_ServantList_All._currentScrollData._pos)
end
function PaGlobalFunc_ServantList_All_SubMenuClose()
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
end
function HandleEventOn_ServantList_All_SelectSevant(eType, slotNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if true == Panel_Dialog_ServantSwiftResult_All:GetShow() then
    return
  end
  if true == Panel_Dialog_ServantSwiftTraining_All:GetShow() then
    return
  end
  if nil == slotNo or nil == eType then
    return
  end
  if true == Panel_Dialog_ServantSkillManagement_All:GetShow() then
    PaGlobalFunc_ServantSkillManagement_All_Close()
  end
  if true == Panel_Dialog_ServantTransferList_All:GetShow() then
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  audioPostEvent_SystemUi(0, 0)
  local sortedSlotNo = 0
  if eType == PaGlobal_ServantList_All._ENUM_TYPESEALED then
    PaGlobal_ServantList_All._currentSealType = PaGlobal_ServantList_All._ENUM_TYPESEALED
    PaGlobal_ServantList_All._selectSlotNo = slotNo
    sortedSlotNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(slotNo)
    if nil == sortedSlotNo then
      return
    end
    local servantInfo
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = stable_getServant(sortedSlotNo)
      if nil == servantInfo then
        return
      end
    else
      servantInfo = guildStable_getServant(sortedSlotNo)
      if nil == servantInfo then
        return
      end
    end
    getServantNo = servantInfo:getServantNo()
    PaGlobal_ServantList_All._selectSceneIndex = PaGlobalFunc_ServantFunction_All_ScenePushObject(servantInfo, PaGlobal_ServantList_All._selectSceneIndex)
    if nil ~= servantInfo:getActionIndex() then
      showSceneCharacter(PaGlobal_ServantList_All._selectSceneIndex, false)
      showSceneCharacter(PaGlobal_ServantList_All._selectSceneIndex, true, servantInfo:getActionIndex())
    end
  elseif eType == PaGlobal_ServantList_All._ENUM_TYPEUNSEALED then
    PaGlobal_ServantList_All._currentSealType = PaGlobal_ServantList_All._ENUM_TYPEUNSEALED
  elseif eType == PaGlobal_ServantList_All._ENUM_TYPETRAIN then
    PaGlobal_ServantList_All._currentSealType = PaGlobal_ServantList_All._ENUM_TYPETRAIN
  end
  PaGlobalFunc_ServantInfo_All_Open(sortedSlotNo)
  PaGlobalFunc_ServantInfo_All_SetIgnoreSnapToOtherPanel(false)
  local currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    if 0 == currentNPCType then
      if true ~= Panel_Dialog_ServantExchange_All:GetShow() and true ~= Panel_Dialog_ServantCarriageLink_All:GetShow() and true ~= Panel_Dialog_ServantSkillManagement_All:GetShow() then
        PaGlobal_ServantList_All:subMenuOpen(eType)
      end
    elseif 2 == currentNPCType then
      PaGlobal_ServantList_All:shipSubMenuOpen(eType)
    end
  elseif 1 == currentNPCType then
    PaGlobal_ServantList_All:guildSubMenuOpen(eType)
  elseif 3 == currentNPCType then
    PaGlobal_ServantList_All:guildShipSubMenuOpen(eType)
  end
  if true == PaGlobal_ServantList_All._isConsole then
    PaGlobal_ServantList_All:setSnapTarget(1)
  end
end
function HandleEventOn_ServantList_All_CheckSameSlot_Console(idx)
  if idx ~= PaGlobal_ServantList_All._selectSlotNo then
    PaGlobalFunc_ServantList_All_SubMenuClose()
  end
end
function HandleEventLUp_ServantList_All_UnSealBy_CurrentServantNo()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local sortedSlotNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == sortedSlotNo then
    return
  end
  local currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    local servantInfo = stable_getServant(sortedSlotNo)
    if nil == servantInfo then
      return
    end
    local getSevantNo = servantInfo:getServantNo()
    if 0 == currentNPCType or 1 == currentNPCType then
      stable_unsealByServantNo(getSevantNo)
      if nil ~= Panel_Widget_ServantIcon then
        reset_ServantHP(servantInfo:getHp())
      end
    elseif 2 == currentNPCType then
      stable_unseal(sortedSlotNo)
    end
    PaGlobal_ServantList_All._selectSlotNo = -1
  else
    local servantInfo = guildStable_getServant(sortedSlotNo)
    if nil == servantInfo then
      return
    end
    local getSevantNo = servantInfo:getServantNo()
    guildStable_unseal(getSevantNo)
    FGlobal_Window_Servant_Update()
  end
end
function HandleEventLUp_ServantList_All_SealMyServant(isCompulsion)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  local function seal_Go()
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      stable_seal(isCompulsion)
    else
      if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
        return
      end
      local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
      if nil == currentServantNo then
        return
      end
      servantInfo = guildStable_getServant(currentServantNo)
      if nil == servantInfo then
        return
      end
      guildStable_seal(servantInfo:getServantNo(), isCompulsion)
      PaGlobal_ServantList_All.sealMyServantNo = servantInfo:getServantNo()
      FGlobal_Window_Servant_Update()
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc
  local _confirmFunction = seal_Go
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local servantInfo
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  else
    servantInfo = guildStable_getServant(currentServantNo)
  end
  if nil == servantInfo then
    return
  end
  local isGuild = PaGlobalFunc_ServantFunction_All_GetIsGuild()
  local needMoney = tostring(getServantCompulsionSealPrice())
  PaGlobal_ServantList_All.sealMyServantNo = servantInfo:getServantNo()
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      if true == isGuild then
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWHAFT_COMPULSIONSEALDESC", "needMoney", needMoney)
      elseif true == _ContentsGroup_Barter then
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WHAFT_COMPULSIONSEALDESC_2", "needMoney", needMoney)
      else
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WHAFT_COMPULSIONSEALDESC_CS", "needMoney", needMoney)
      end
    elseif nil ~= shipStaticStatus then
      if true == _ContentsGroup_Barter then
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WHAFT_COMPULSIONSEALDESC", "needMoney", needMoney)
      else
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WHAFT_COMPULSIONSEALDESC_CS_2", "needMoney", needMoney)
      end
    else
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_ISCOMPULSION_MESSAGEBOX")
    end
  else
    local vehicleType = servantInfo:getVehicleType()
    local isWarterVehicle = ToClient_isVehicleTypeWarter(vehicleType)
    if true == isWarterVehicle then
      if true == isGuild then
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWHAFT_COMPULSIONSEALDESC", "needMoney", needMoney)
      else
        _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WHAFT_COMPULSIONSEALDESC", "needMoney", needMoney)
      end
    else
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_ISCOMPULSION_MESSAGEBOX")
    end
  end
  if isCompulsion then
    messageboxData = {
      title = _title,
      content = _desc,
      functionYes = _confirmFunction,
      functionNo = _cancel,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData, nil, nil, PaGlobal_ServantList_All._isConsole)
  else
    seal_Go()
    if nil ~= Panel_Dialog_ServantInfo_All then
      if false == PaGlobal_ServantList_All._isConsole then
        PaGlobalFunc_ServantInfo_All_Close()
      else
        HandleEventOn_ServantList_All_SelectSevant(0, 0)
      end
    end
  end
  PaGlobal_ServantList_All._currentSealType = 0
end
function HandleEventLUp_ServantList_All_Recovery_Sealed_Servant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local servantInfo
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantInfo = stable_getServant(currentServantNo)
  else
    servantInfo = guildStable_getServant(currentServantNo)
  end
  if nil == servantInfo then
    return
  end
  local function revive_servant()
    audioPostEvent_SystemUi(5, 7)
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      stable_revive(currentServantNo, MessageBoxCheck.isCheck())
    else
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil == guildWrapper then
        return
      end
      local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
      local guildNeedMoney64 = servantInfo:getReviveCost_s64()
      if guildMoney64 < guildNeedMoney64 and guildNeedMoney64 > Defines.s64_const.s64_0 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
        return
      end
      guildStable_revive(servantInfo:getServantNo())
      PaGlobalFunc_ServantInfo_All_Open(currentServantNo)
    end
  end
  local function recovery_servant()
    audioPostEvent_SystemUi(5, 7)
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      stable_recovery(currentServantNo, MessageBoxCheck.isCheck())
    else
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil == guildWrapper then
        return
      end
      local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
      local guildNeedMoney64 = servantInfo:getRecoveryCost_s64()
      if guildMoney64 < guildNeedMoney64 and guildNeedMoney64 > Defines.s64_const.s64_0 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
        return
      end
      guildStable_recovery(servantInfo:getServantNo())
      PaGlobalFunc_ServantInfo_All_Open(currentServantNo)
    end
  end
  local needMoney = 0
  local confirmFunction
  local vehicleType = servantInfo:getVehicleType()
  local servantHp = servantInfo:getHp()
  if 0 == servantHp then
    imprintMoney = makeDotMoney(servantInfo:getReviveOriginalCost_s64())
    needMoney = makeDotMoney(servantInfo:getReviveCost_s64())
    confirmFunction = revive_servant
  else
    imprintMoney = makeDotMoney(servantInfo:getRecoveryOriginalCost_s64())
    needMoney = makeDotMoney(servantInfo:getRecoveryCost_s64())
    confirmFunction = recovery_servant
  end
  local _contents = ""
  if servantInfo:isImprint() then
    if vehicleType == CppEnums.VehicleType.Type_RepairableCarriage then
      _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG2", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    else
      _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    end
  elseif vehicleType == CppEnums.VehicleType.Type_Horse or vehicleType == CppEnums.VehicleType.Type_Camel or vehicleType == CppEnums.VehicleType.Type_Donkey or vehicleType == CppEnums.VehicleType.Type_Elephant or vehicleType == CppEnums.VehicleType.Type_RidableBabyElephant then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_NOT")
  elseif CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_CARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", needMoney)
  elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG3", "needMoney", needMoney)
  else
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG2", "needMoney", imprintMoney)
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", needMoney)
    msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_TITLE")
  end
  local messageBoxData = {
    title = msgTitle,
    content = _contents,
    functionApply = confirmFunction,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBoxCheck.showMessageBox(messageBoxData)
  end
end
function HandleEventLUp_ServantList_All_Recovery_UnSealed_Servant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  local currentNPCType
  if nil ~= Panel_Dialog_ServantFunction_All then
    currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  end
  if nil == currentNPCType then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantWrapper
  if 0 == currentNPCType or 2 == currentNPCType then
    servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
  end
  if nil == servantWrapper then
    return
  end
  local imprintMoney = makeDotMoney(servantWrapper:getRecoveryOriginalCost_s64())
  local needMoney = makeDotMoney(servantWrapper:getRecoveryCost_s64())
  if servantWrapper:getRecoveryOriginalCost_s64() <= Defines.s64_const.s64_1 then
    return
  end
  local recovery_Unseal = function()
    audioPostEvent_SystemUi(5, 7)
    stable_recoveryUnseal(MessageBoxCheck.isCheck())
  end
  local _contents = ""
  if servantWrapper:isImprint() then
    if servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
      _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG2", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    else
      _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    end
  elseif servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_NOT")
  elseif servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG3", "needMoney", imprintMoney)
  else
    _contents = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_CARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney)
  end
  local vehicleType = servantWrapper:getVehicleType()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_TITLE"),
    content = _contents,
    functionApply = recovery_Unseal,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBox(messageBoxData)
end
function HandleEventLUp_ServantList_All_SellServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE")
  local _desc = ""
  local _confirmFunction = PaGlobalFunc_ServantList_All_SellConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local servantInfo
  local resultMoney = 0
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantInfo = stable_getServant(currentServantNo)
    resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
    _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_MSG", "resultMoney", resultMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
  else
    servantInfo = guildStable_getServant(currentServantNo)
    resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RETURN_NOTIFY_MSG") .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
  end
  if nil == servantInfo then
    return
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData, nil, nil, PaGlobal_ServantList_All._isConsole)
end
function PaGlobalFunc_ServantList_All_SellConfirm()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() or nil == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    stable_changeToReward(currentServantNo, CppEnums.ServantToRewardType.Type_Experience)
    PaGlobal_ServantList_All._SellCheck = true
  else
    local servantNo = servantInfo:getServantNo()
    guildStable_changeToReward(servantNo, CppEnums.ServantToRewardType.Type_Experience)
    PaGlobal_ServantList_All._SellCheck = false
  end
end
function HandleEventLUp_ServantList_All_SupplyServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function supplyHorse()
    stable_changeToReward(currentServantNo, CppEnums.ServantToRewardType.Type_Money)
    PaGlobal_ServantList_All._SellCheck = true
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_SUPPLY")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABLE_SUPPLY", "resultMoney", resultMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
  local _confirmFunction = supplyHorse
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if true == ToClient_IsContentsGroupOpen("1067") then
    _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABLE_SUPPLYEVENT", "resultMoney", resultMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_SupplyForQueset()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  ToClient_RequestSupplyServant(currentServantNo)
end
function HandleEventLUp_ServantList_All_SevantRelease()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function ReleaseConfirm()
    stable_changeToReward(currentServantNo, CppEnums.ServantToRewardType.Type_Experience)
    FGlobal_Window_Servant_Update()
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  if true == servantInfo:isPcroomOnly() then
    resultMoney = 0
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_MSG", "resultMoney", resultMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
  local _confirmFunction = ReleaseConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_ChangeName()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local nameChange_Confirm = function()
    PaGlobalFunc_ServantNameRegist_All_OpenByEventType(CppEnums.ServantRegist.eEventType_ChangeName)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_POPMSGBOX_CHANGENAME_MEMO")
  local _confirmFunction = nameChange_Confirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_Regiset_To_Mating()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function registerMating()
    PaGlobalFunc_ServantNameRegist_All_OpenByEventType(CppEnums.ServantRegist.eEventType_RegisterMating, currentServantNo)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMATING_NOTIFY_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMATING_NOTIFY_MSG")
  local _confirmFunction = registerMating
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_Regist_To_ServantMarket()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local registerMarket = function()
    PaGlobalFunc_ServantNameRegist_All_OpenByEventType(CppEnums.ServantRegist.eEventType_RegisterMarket)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMARKET_NOTIFY_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMARKET_NOTIFY_MSG")
  local _confirmFunction = registerMarket
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_Register_To_Taming()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil ~= Panel_Dialog_ServantNameRegist_All then
    PaGlobalFunc_ServantNameRegist_All_OpenByTaming()
  end
  if nil ~= Panel_FrameLoop_Widget then
    Panel_FrameLoop_Widget:SetShow(false)
  end
end
function HandleEventLUp_ServantList_All_TransferServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() or nil == Panel_Dialog_ServantTransferList_All then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if CppEnums.ServantStateType.Type_Coma == servantInfo:getStateType() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoServantNeedToRecovery"))
    return
  end
  PaGlobalFunc_ServantTransferList_All_Open()
end
function HandleEventLUp_ServantList_All_ResetServant()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function resetServant()
    ToClient_requestSetBeginningLevelServant(currentServantNo)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SETBEGINNINGLEVEL_INFO")
  local _confirmFunction = resetServant
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_ResetDeadCount()
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local currentNPCType
  if nil ~= Panel_Dialog_ServantFunction_All then
    currentNPCType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  end
  if nil == currentNPCType then
    return
  end
  local function clearDeadCount()
    stable_clearDeadCount(currentServantNo)
  end
  local function guildClearDeadCount()
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    local needMoney = guildStable_getClearGuildServantDeadCountCost_s64(servantInfo:getServantNo())
    local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
    if needMoney > guildMoney64 and needMoney > Defines.s64_const.s64_0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
      return
    end
    local servantNo = servantInfo:getServantNo()
    guildStable_clearDeadCount(servantNo)
  end
  local function oceanShipClearDeadCount()
    stable_clearOceanShipDeadCount(currentServantNo, MessageBoxCheck.isCheck())
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET_ALLRECOVERY")
  local _confirmFunction = clearDeadCount
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local isCheckMoney = false
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET_ALLRECOVERY")
    if servantInfo:getIsDamageShip() then
      local needMoney = stable_getClearOceanShipDeadCountCost(servantInfo:getServantNo())
      _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE_INFO", "money", tostring(makeDotMoney(needMoney)))
      _confirmFunction = oceanShipClearDeadCount
      isCheckMoney = true
    end
  elseif 3 == currentNPCType then
    local needMoney = guildStable_getClearGuildServantDeadCountCost_s64(servantInfo:getServantNo())
    _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWHARF_REPAIRWOUND")
    _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSERVANTINFO_WOUND", "money", tostring(makeDotMoney(needMoney)))
    _confirmFunction = guildClearDeadCount
  end
  if false == isCheckMoney then
    messageboxData = {
      title = _title,
      content = _desc,
      functionYes = _confirmFunction,
      functionNo = _cancel,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData)
  else
    messageboxData = {
      title = _title,
      content = _desc,
      functionApply = _confirmFunction,
      functionCancel = _cancel,
      priority = _priority
    }
    MessageBoxCheck.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_ServantList_All_ResetMatingCount()
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function clearMatingCount()
    stable_clearMatingCount(currentServantNo)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MATINGCOUNTRESET")
  local _confirmFunction = clearMatingCount
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_Imprint(isImprint)
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local function imprint()
    stable_imprint(currentServantNo, isImprint)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = ""
  local _confirmFunction = imprint
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if false == isImprint then
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_ISIMPRINT_RECOVERY")
  else
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_IS_DISCOUNT")
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_StableSlotBuy()
  local easyBuySlot = function()
    if nil ~= Panel_IngameCashShop_EasyPayment then
      PaGlobal_EasyBuy:Open(15, getCurrentWaypointKey())
    end
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_EASYBUY")
  local _confirmFunction = easyBuySlot
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
function HandleEventLUp_ServantList_All_ServantLookChange()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo or nil == Panel_Dialog_ServantLookChange_All then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  PaGlobalFunc_ServantLookChange_All_Open()
end
function HandleEventLUp_ServantList_All_RegisterServantByMapae()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(0)
  PaGlobalFunc_ServantList_All_CloseAllShipPanel()
  PaGlobalFunc_ServantRegist_All_Open(CppEnums.ServantRegist.eEventType_Inventory)
end
function HandleEventLUp_ServantList_All_Servant_UnLink()
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_STABLE_ALERT"))
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local currentCarriageIndex = -1
  local function releaseCarriage()
    if -1 == currentCarriageIndex then
      return
    end
    stable_link(currentServantNo, currentCarriageIndex, false)
    if nil ~= Panel_Dialog_ServantCarriageLink_All then
      PaGlobalFunc_ServantCarriageLink_All_UpdateCarriage()
    end
  end
  local carriageNo = servantInfo:getOwnerServantNo_s64()
  local carriageCheck = false
  for index = 0, stable_count() - 1 do
    local sInfo = stable_getServant(index)
    local sNo = sInfo:getServantNo()
    if carriageNo == sNo then
      currentCarriageIndex = index
      local _title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_CARRIAGE_UNLINK")
      local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_CARRIAGE_UNLINK_ALERT")
      local _confirmFunction = releaseCarriage
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
      carriageCheck = true
    end
  end
  if false == carriageCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CARRIAGE_CANCEL"))
  end
end
function HandleEventLUp_ServantList_All_RecieveChild()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil ~= currentServantNo then
    stable_getServantMatingChildInfo(currentServantNo)
  end
end
function HandleEventLUp_ServantList_All_Register_To_RentMarket()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil ~= currentServantNo then
    PaGlobalFunc_ServantNameRegist_All_OpenByEventType(6)
  end
end
function HandleEventLUp_ServantList_All_TrainingFinish(isSwift)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_STABLE_ALERT"))
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if false == isSwift then
    stable_endServantSkillExpTraining(currentServantNo)
  else
    stable_endStallionSkillExpTraining(currentServantNo)
  end
end
function HandleEventLUp_ServantList_All_StartStallionTraining()
  if not isContentsStallionEnable and not isContentsNineTierEnable and isContentsNineTierTraining then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if true == Panel_Dialog_ServantRegist_All:GetShow() then
    PaGlobalFunc_ServantRegist_All_Close()
  end
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    PaGlobalFunc_ServantSwiftTraining_All_Open(servantNo)
    return
  end
  ToClient_startStallionSkillExpTraining(servantNo)
end
function HandleEventLUp_ServantList_All_RecoverInjury()
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  local needMoney = guildStable_getClearGuildServantDeadCountCost_s64(servantNo)
  local function recoverInjury()
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
    if guildMoney64 < needMoney and Defines.s64_const.s64_0 < needMoney then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
      return
    end
    guildStable_clearDeadCount(servantNo)
  end
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDSTABLE_RECOVERYINJURY")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDSTABLE_MSG_INJURYRECOVERY", "money", tostring(needMoney))
  local _confirmFunction = recoverInjury
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantList_All_ReleaseServant()
  PaGlobal_ServantList_All:subMenuClose()
  audioPostEvent_SystemUi(0, 0)
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = guildStable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  local function releaseGuildServant()
    guildStable_changeToReward(servantNo, CppEnums.ServantToRewardType.Type_Experience)
    PaGlobal_ServantList_All._SellCheck = false
    FGlobal_Window_Servant_Update()
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RELEASE_NOTIFY_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RELEASE_NOTIFY_MSG") .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG") .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_LETOUT_MSG")
  local _confirmFunction = releaseGuildServant
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData, nil, nil, PaGlobal_ServantList_All._isConsole)
end
function HandleEventLUp_ServantList_All_RepairShip()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local servantType = servantInfo:getServantType()
  if CppEnums.ServantType.Type_Ship ~= servantType then
    return
  end
  local function do_Repair()
    audioPostEvent_SystemUi(5, 7)
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      stable_recovery(currentServantNo, MessageBoxCheck.isCheck())
    else
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil == guildWrapper then
        return
      end
      local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
      local guildNeedMoney64 = servantInfo:getRecoveryCost_s64()
      if guildMoney64 < guildNeedMoney64 and guildNeedMoney64 > Defines.s64_const.s64_0 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
        return
      end
      guildStable_recovery(servantInfo:getServantNo())
      PaGlobalFunc_ServantInfo_All_Open(currentServantNo)
    end
  end
  local function do_Revive()
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      stable_revive(currentServantNo, MessageBoxCheck.isCheck())
    else
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil == guildWrapper then
        return
      end
      local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
      local guildNeedMoney64 = servantInfo:getReviveCost_s64()
      if guildMoney64 < guildNeedMoney64 and guildNeedMoney64 > Defines.s64_const.s64_0 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
        return
      end
      guildStable_revive(servantInfo:getServantNo())
    end
  end
  local needMoney = 0
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local _confirmFunction = MessageBox_Empty_function
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if 0 == servantInfo:getHp() then
    needMoney = makeDotMoney(servantInfo:getReviveCost_s64())
    _confirmFunction = do_Revive
  else
    needMoney = makeDotMoney(servantInfo:getRecoveryCost_s64())
    _confirmFunction = do_Repair
  end
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SHIP_RECOVERY_NOTIFY_MSG", "needMoney", needMoney)
  messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    MessageBox.showMessageBox(messageboxData)
  else
    MessageBoxCheck.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_ServantList_All_ReturnRent()
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    return
  end
  PaGlobal_ServantList_All:subMenuClose()
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = stable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  function returnRentConfirm()
    ToClient_RegisterServantForReturn(servantNo)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_PRPOMOTEMARKET_RETURN_ALERT1")
  local _confirmFunction = returnRentConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionNo = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_ServantNameRegist_All_SetIgnoreBtn(set)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All._ui._btn_IncreaseSlot:SetIgnore(set)
  PaGlobal_ServantList_All._ui._btn_Regist:SetIgnore(set)
end
function PaGlobalFunc_ServantList_All_GetSealedTypeServantInfo()
  if PaGlobal_ServantList_All._ENUM_TYPESEALED ~= PaGlobal_ServantList_All._currentSealType then
    return nil
  end
  local slotNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == slotNo then
    return nil
  end
  local servantInfo
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    servantInfo = stable_getServant(slotNo)
  else
    servantInfo = guildStable_getServant(slotNo)
  end
  return servantInfo
end
function PaGlobalFunc_ServantList_All_GetCurrentServantInfo()
  local servantInfo
  local npcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if 2 == npcType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return nil
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  elseif 3 == npcType then
    local index = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == index then
      return nil
    end
    servantInfo = guildStable_getServant(index)
  end
  return servantInfo
end
function HandleEventLUp_ServantList_All_CargoLoadingOpen()
  PaGlobal_ServantList_All:subMenuClose()
  if nil ~= Panel_Window_SailorManager_All then
    PaGlobal_SailorManager_All_CloseForce()
  end
  if nil ~= Panel_Window_ShipEquipManagement_ALL then
    HandleEventMLUp_ShipEquipManagement_Close()
  end
  local servantInfo = PaGlobalFunc_ServantList_All_GetCurrentServantInfo()
  if nil ~= servantInfo then
    local selfPlayer = getSelfPlayer():get()
    local rv = 0
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      rv = selfPlayer:checkShipManagementAbleNpcForLua()
    else
      ToClient_RequestInventoryFromServant(servantInfo:getServantNo())
    end
    if nil ~= rv and 0 ~= rv then
      local rvString = PAGetStringSymNo(rv)
      Proc_ShowMessage_Ack(rvString)
      return
    end
    PaGlobal_CargoLoading:prepareOpen(servantInfo:getActorKeyRaw())
  end
end
function HandleEventLUp_ServantList_All_ShipEquipManagementOpen()
  PaGlobal_ServantList_All:subMenuClose()
  local servantInfo = PaGlobalFunc_ServantList_All_GetCurrentServantInfo()
  if nil ~= servantInfo then
    local selfPlayer = getSelfPlayer():get()
    local rv = 0
    if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      rv = selfPlayer:checkShipManagementAbleNpcForLua()
    end
    if nil ~= rv and 0 ~= rv then
      local rvString = PAGetStringSymNo(rv)
      Proc_ShowMessage_Ack(rvString)
      return
    end
    PaGlobal_ShipEquipManagement:prepareOpen(servantInfo:getActorKeyRaw())
  end
end
function HandleEventLUp_ServantList_All_SailorManagerOpen()
  PaGlobal_ServantList_All:subMenuClose()
  local servantInfo = PaGlobalFunc_ServantList_All_GetCurrentServantInfo()
  if nil ~= servantInfo then
    local selfPlayer = getSelfPlayer():get()
    local rv = selfPlayer:checkShipManagementAbleNpcForLua()
    if nil ~= rv and 0 ~= rv then
      local rvString = PAGetStringSymNo(rv)
      Proc_ShowMessage_Ack(rvString)
      return
    end
    PaGlobal_SailorManager_All:prepareOpen()
  end
end
function HandleEventLUp_ServantList_All_Upgrade()
  PaGlobal_ServantList_All:subMenuClose()
  local servantInfo = PaGlobalFunc_ServantList_All_GetSealedTypeServantInfo()
  if nil ~= servantInfo then
    PaGlobal_ServantUpgrade:open(servantInfo:getServantNo(), servantInfo:getCharacterKeyRaw(), servantInfo:getName())
  end
end
function HandlerEventLUp_ServantList_All_ShipFoodFeed()
  PaGlobal_ServantList_All:subMenuClose()
  local servantInfo
  local selfPlayer = getSelfPlayer():get()
  if false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    local selfPlayer = getSelfPlayer():get()
    local rv = selfPlayer:checkShipManagementAbleNpcForLua()
    if nil ~= rv and 0 ~= rv then
      local rvString = PAGetStringSymNo(rv)
      Proc_ShowMessage_Ack(rvString)
      return
    end
  else
    if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
      return
    end
    local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    if nil == currentServantNo then
      return
    end
    servantInfo = guildStable_getServant(currentServantNo)
  end
  if nil == servantInfo then
    return
  end
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(servantInfo:getCharacterKeyRaw())
  if nil == shipStaticStatus then
    return
  end
  local isGuild = PaGlobalFunc_ServantFunction_All_GetIsGuild()
  local foodPerMoney = shipStaticStatus:getRecoveryFoodCount()
  local cannonPerMoney = shipStaticStatus:getRecoveryCannonCount()
  local needFood = servantInfo:getMaxFood() - servantInfo:getFood()
  local needCannon = servantInfo:getMaxServantStatParam(__eServantStatParamType_Cannon) - servantInfo:getServantStatParam(__eServantStatParamType_Cannon)
  local servantNo = servantInfo:getServantNo()
  local foodNeedMoney = toInt64(0, 0)
  if 0 < foodPerMoney and 1 < needFood then
    foodNeedMoney = toInt64(0, needFood * foodPerMoney)
  end
  local cannonNeedMoney = toInt64(0, 0)
  if 0 < cannonPerMoney then
    cannonNeedMoney = toInt64(0, needCannon * cannonPerMoney)
  end
  if foodNeedMoney <= toInt64(0, 0) and cannonNeedMoney <= toInt64(0, 0) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_FOODMAX"))
    return
  end
  function shipFoodFeedConfirm()
    local moneyWhereType = CppEnums.ItemWhereType.eGuildWarehouse
    if false == isGuild then
      moneyWhereType = MessageBoxCheck.isCheck()
    else
      local guildWrapper = ToClient_GetMyGuildInfoWrapper()
      if nil == guildWrapper then
        return
      end
      local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
      if guildMoney64 < foodNeedMoney + cannonNeedMoney and Defines.s64_const.s64_0 < foodNeedMoney + cannonNeedMoney then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
        return
      end
    end
    ToClient_requestRecoveryServantSupply(servantNo, moneyWhereType, foodNeedMoney, cannonNeedMoney)
  end
  local memoStrId = ""
  local memoMoney = ""
  if isGuild then
    memoStrId = "LUA_EMPLOYEE_GUILDSHIP_FOODCHARGE"
    memoMoney = "money"
  elseif true == shipStaticStatus:getIsSummonFull() then
    memoStrId = "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG2"
    memoMoney = "needMoney"
  else
    memoStrId = "LUA_SAILORMANAGER_FOODCHARGE_GOLD"
    memoMoney = "money"
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, memoStrId, memoMoney, makeDotMoney(foodNeedMoney + cannonNeedMoney))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_FOODFEED"),
    content = messageBoxMemo,
    functionApply = shipFoodFeedConfirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if isGuild then
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBoxCheck.showMessageBox(messageBoxData)
  end
end
function Paglobal_ServantList_All_GetRegistBtn()
  if nil == Panel_Dialog_ServantList_All or nil == PaGlobal_ServantList_All._ui._btn_Regist then
    return
  end
  return PaGlobal_ServantList_All._ui._btn_Regist
end
function PaGlobalFunc_ServantList_All_CloseAllShipPanel()
  if nil ~= PaGlobal_ServantUpgrade_Close then
    PaGlobal_ServantUpgrade_Close()
  end
  if nil ~= HandleEventMLUp_CargoLoading_Close then
    HandleEventMLUp_CargoLoading_Close()
  end
  if nil ~= PaGlobal_SailorManager_All_CloseForce then
    PaGlobal_SailorManager_All_CloseForce()
  end
  if nil ~= HandleEventMLUp_ShipEquipManagement_Close then
    HandleEventMLUp_ShipEquipManagement_Close()
  end
end
function PaGlobalFunc_ServantList_All_CheckMapaeExist()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local slotCount = 0
  for invenType = 1, 2 do
    local currentWhereType = CppEnums.ItemWhereType.eInventory
    if 2 == invenType then
      currentWhereType = CppEnums.ItemWhereType.eCashInventory
    end
    for slotIdx = inventorySlotNoUserStart(), self._maxInvenCount - 1 do
      local itemWrapper = getInventoryItemByType(currentWhereType, slotIdx)
      if nil ~= itemWrapper and GetUIMode() == Defines.UIMode.eUIMode_Stable and not PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper) then
        self._mapaeInfoTable[slotCount] = mapaeInfo
        slotCount = slotCount + 1
      end
    end
  end
  return slotCount
end
function PaGlobalFunc_ServantInfo_All_BlockSnap()
end
function PaGlobalFunc_ServantInfo_All_CheckBlockTo_UnSealedServant()
end
function PaGlobalFunc_ServantInfo_All_SetIgnoreSnapToOtherPanel(set)
  if false == PaGlobal_ServantList_All._isConsole then
    return
  end
  Panel_Dialog_ServantList_All:ignorePadSnapMoveToOtherPanelUpdate(set)
end
