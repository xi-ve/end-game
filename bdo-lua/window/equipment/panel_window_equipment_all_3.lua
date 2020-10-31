function PaGlobalFunc_Equipment_All_Open()
  if nil == Panel_Window_Equipment_All then
    return
  end
  PaGlobal_Equipment_All:prepareOpen()
end
function PaGlobalFunc_Equipment_All_Close(closeUISubApp)
  if nil == Panel_Window_Equipment_All or false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  if true == closeUISubApp then
    audioPostEvent_SystemUi(1, 1)
    PaGlobal_Equipment_All._ui.check_popup:SetCheck(false)
    Panel_Window_Equipment_All:CloseUISubApp()
    local isCamp = false
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      isCamp = PaGlobalFunc_RepairFunc_All_IsCampingType()
    elseif true == _ContentsGroup_NewUI_Camp_All then
      isCamp = PaGlobalFunc_Camp_All_GetIsCamping()
    else
      isCamp = PaGlobal_Camp:getIsCamping()
    end
    if true == isCamp then
      InventoryWindow_Close()
      if true == _ContentsGroup_NewUI_Camp_All then
        PaGlobalFunc_Camp_All_Open()
      else
        PaGlobal_Camp:open()
      end
    end
  end
  PaGlobal_Equipment_All:prepareClose()
end
function PaGlobalFunc_Equipment_All_SetShow(isShow)
  if true == isShow then
    PaGlobalFunc_Equipment_All_Open()
  else
    PaGlobalFunc_Equipment_All_Close(false)
  end
end
function PaGlobalFunc_Equipment_All_ShowAni()
  Panel_Window_Equipment_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_Equipment_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_Equipment_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Equipment_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_Equipment_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Equipment_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Equipment_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobalFunc_Equipment_All_HideAni()
  Panel_Window_Equipment_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Equipment_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_Equipment_All_OnScreenResize()
  if Defines.UIMode.eUIMode_Extraction ~= GetUIMode() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      if true == Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetScreenParentPosY())
      else
        Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Equipment_All:GetSizeX() - 5)
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
      end
    elseif true == Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetScreenParentPosY())
    else
      Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Equipment_All:GetSizeX())
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetPosY())
    end
  end
end
function PaGlobalFunc_Equipment_All_UpdateSlotData()
  PaGlobal_Equipment_All:updateSlotData()
end
function PaGlobalFunc_Equipment_All_DirectPanelShow(isShow, isAni)
  if true == Panel_Window_Equipment_All:IsUISubApp() then
    return
  end
  if false == isShow then
    Panel_Window_Equipment_All:SetShow(false, isAni)
    return
  end
  Panel_Window_Equipment_All:SetShow(true, isAni)
  PaGlobal_Equipment_All:updateSlotData()
end
function PaGlobalFunc_Equipment_All_SetFunctionButtonHide(isShow)
  PaGlobal_Equipment_All._ui.btn_servantInven:SetShow(isShow)
  if PaGlobal_Equipment_All._isKR2ContentsEnable or true == ToClient_isAdultUser() then
    PaGlobal_Equipment_All._ui.check_underwear:SetShow(isShow)
  else
    PaGlobal_Equipment_All._ui.check_underwear:SetShow(false)
  end
  PaGlobal_Equipment_All._ui.btn_petList:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_camouflage:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_helmInvisual:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_helmOpen:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_cloak:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_alchemyStone:SetShow(isShow)
end
function PaGlobalFunc_Equipment_All_UseAlchemyStoneCheck(flag)
  PaGlobal_Equipment_All._isUsedAlchemyStone = flag
end
function PaGlobalFunc_Equipment_All_AlchemyStonCheck()
  if false == PaGlobal_Equipment_All._ui.check_alchemyStone:IsCheck() then
    return 0
  end
  local coolTime = PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()
  if -1 < coolTime then
    return coolTime + 3
  end
  coolTime = 0
  local equipAlchemyStoneCoolTime = ToClient_GetEquipAlchemyStoneCoolTime()
  if 0 == equipAlchemyStoneCoolTime then
    return coolTime
  end
  coolTime = equipAlchemyStoneCoolTime / 1000 + 2
  return coolTime
end
function PaGlobalFunc_Equipment_All_IsReuseTime(deltaTime)
  if 3 <= PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime then
    PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime = 0
    return true
  end
  PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime = PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime + deltaTime
  return false
end
function PaGlobalFunc_Equipment_All_PosSave()
  PaGlobal_Equipment_All._equipMentPosX = Panel_Window_Equipment_All:GetPosX()
  PaGlobal_Equipment_All._equipMentPosY = Panel_Window_Equipment_All:GetPosY()
end
function PaGlobalFunc_Equipment_All_PosLoad()
  Panel_Window_Equipment_All:SetPosX(PaGlobal_Equipment_All._equipMentPosX)
  Panel_Window_Equipment_All:SetPosY(PaGlobal_Equipment_All._equipMentPosY)
end
function PaGlobalFunc_Equipment_All_BesideInvenPos()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:GetShow() then
      if true == Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetScreenParentPosY())
      else
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
        Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Equipment_All:GetSizeX() - 5)
      end
    end
  elseif Panel_Window_Inventory:GetShow() then
    if true == Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetScreenParentPosY())
    else
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetPosY())
      Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Equipment_All:GetSizeX())
    end
  end
end
function PaGlobalFunc_Equipment_All_AccSlotNo(itemWrapper, isChange)
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  local acc
  local ringSlotNo1 = CppEnums.EquipSlotNo.ring1
  local ringSlotNo2 = CppEnums.EquipSlotNo.ring2
  local earingSlotNo1 = CppEnums.EquipSlotNo.earing1
  local earingSlotNo2 = CppEnums.EquipSlotNo.earing2
  if 16 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(ringSlotNo1)
    equipItemWrapper2 = ToClient_getEquipmentItem(ringSlotNo2)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = ringSlotNo1 + PaGlobal_Equipment_All._slotRingIndex
      if true == isChange then
        if 0 == PaGlobal_Equipment_All._slotRingIndex then
          PaGlobal_Equipment_All._slotRingIndex = 1
        else
          PaGlobal_Equipment_All._slotRingIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo1
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo2
    else
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo1
    end
  elseif 17 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(earingSlotNo1)
    equipItemWrapper2 = ToClient_getEquipmentItem(earingSlotNo2)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = earingSlotNo1 + PaGlobal_Equipment_All._slotEaringIndex
      if true == isChange then
        if 0 == PaGlobal_Equipment_All._slotEaringIndex then
          PaGlobal_Equipment_All._slotEaringIndex = 1
        else
          PaGlobal_Equipment_All._slotEaringIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = earingSlotNo1
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = earingSlotNo2
    else
      acc = earingSlotNo1
    end
  end
  return acc
end
function HandleEventOnOut_Equipment_All_EquipmentTooltip(slotNo, isOn)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "equipment", isOn, false, nil, nil, Panel_Window_Equipment_All, 2, 50)
end
function HandleEventOnOut_Equipment_All_EmptySlotTooltip(slotNo, isOn)
  if nil == getSelfPlayer() then
    return
  end
  local tooltipControl = PaGlobal_Equipment_All._ui.txt_blankSlotTooltip
  local classType = getSelfPlayer():getClassType()
  if true == isOn then
    if classType == __eClassType_ShyWaman and CppEnums.EquipSlotNo.awakenWeapon == slotNo then
      tooltipControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
    elseif classType == __eClassType_ShyWaman and CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
      tooltipControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH"))
    else
      tooltipControl:SetText(PaGlobal_Equipment_All._slotNoIdToString[slotNo])
    end
    tooltipControl:SetSize(tooltipControl:GetTextSizeX() + 30, 20)
    tooltipControl:SetPosX(PaGlobal_Equipment_All._ui.stc_circle:GetPosX() + PaGlobal_Equipment_All.slots[slotNo].icon:GetPosX() - tooltipControl:GetTextSizeX())
    if tooltipControl:GetPosX() < 0 then
      tooltipControl:SetPosX(0)
    end
    tooltipControl:SetPosY(PaGlobal_Equipment_All._ui.stc_circle:GetPosY() + PaGlobal_Equipment_All.slots[slotNo].icon:GetPosY())
    tooltipControl:SetShow(true)
  else
    tooltipControl:SetShow(false)
  end
end
function HandleEventLUp_Equipment_All_EquipSlotLClick(slotNo)
  if true == DragManager:isDragging() and nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALL_CANTEQUIP_ENCHANT_MODE"))
    DragManager:clearInfo()
    return
  end
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if DragManager.dragStartPanel == inventoryPanel then
    local inventoryType = Inventory_GetCurrentInventoryType()
    local dragSlotNo = DragManager.dragSlotInfo
    if nil == dragSlotNo then
      return
    end
    local itemWrapper = getInventoryItemByType(inventoryType, dragSlotNo)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus()
      if itemStatic:isEquipable() then
        if true == _ContentsGroup_NewUI_Inventory_All then
          PaGlobalFunc_Inventory_All_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        else
          Inventory_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        end
        DragManager:clearInfo()
        PaGlobal_Equipment_All._ui.txt_blankSlotTooltip:SetShow(false)
      end
    end
  end
end
function HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    if CppEnums.EquipSlotNoClient.eEquipSlotNoAvatarUnderwear == slotNo then
      PaGlobal_Equipment_All:hideUnderwear()
    end
    local repairPanel, endurancePanel
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      repairPanel = Panel_Dialog_Repair_Function_All
    else
      repairPanel = Panel_Window_Repair
    end
    if true == _ContentsGroup_NewUI_BlackSmith_All then
      endurancePanel = Panel_Window_Endurance_Recovery_All
    else
      endurancePanel = Panel_FixEquip
    end
    if repairPanel:IsShow() and nil ~= endurancePanel and false == endurancePanel:GetShow() then
      if true == _ContentsGroup_NewUI_RepairFunction_All then
        PaGlobalFunc_RepairFunc_All_EquipWindowRClick(slotNo, itemWrapper)
      else
        PaGlobal_Repair:repair_EquipWindowRClick(slotNo, itemWrapper)
      end
    elseif repairPanel:IsShow() and nil ~= endurancePanel and true == endurancePanel:GetShow() then
      equipmentDoUnequip(slotNo)
    else
      equipmentDoUnequip(slotNo)
    end
  end
end
function HandleEventLUp_Equipment_All_AvatarShowToggle(slotNo)
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil and (true == selfPlayer:get():getUnderwearModeInhouse() or true == selfPlayer:get():getSwimmingSuitMode()) then
    local isChecked = PaGlobal_Equipment_All.avataSlots[slotNo]:IsCheck()
    if isChecked then
      isChecked = false
    else
      isChecked = true
    end
    PaGlobal_Equipment_All.avataSlots[slotNo]:SetCheck(isChecked)
    return
  end
  local isChecked = PaGlobal_Equipment_All.avataSlots[slotNo]:IsCheck()
  if true == isChecked then
    ToClient_SetAvatarEquipSlotFlag(slotNo)
  else
    ToClient_ResetAvatarEquipSlotFlag(slotNo)
  end
  Toclient_setShowAvatarEquip()
end
function HandleEventLUp_Equipment_All_QuestBook()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook)
    if nil ~= itemWrapper and true == questList_isClearQuest(21108, 1) or true == questList_isClearQuest(678, 7) then
      PaGlobalFunc_Achievement_Open()
      InventoryWindow_Close()
    end
  end
end
function HandleEventLUp_Equipment_All_CheckPopupUI()
  if true == PaGlobal_Equipment_All._ui.check_popup:IsCheck() then
    Panel_Window_Equipment_All:OpenUISubApp()
  else
    Panel_Window_Equipment_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventLUp_Equipment_All_ServantInventoryOpen()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Repair then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_REPAIRMODENOOPENINVENTORY"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_OPEN_SERVENTINVENTORY"))
    return
  end
  local isFreeBattle = selfPlayer:get():isBattleGroundDefine()
  if true == isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_NOT_USE"))
    return
  end
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_CampWarehouse_All_CloseWareHouseOnly()
  end
  ServantInventory_OpenAll()
  Panel_Window_ServantInventory:SetPosX(Panel_Window_Equipment_All:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 5)
  Panel_Window_ServantInventory:SetPosY(Panel_Window_Equipment_All:GetPosY())
end
function HandleEventLUp_Equipment_All_ShowNameWhenCamouflage()
  Toclient_setShowNameWhenCamouflage(not getSelfPlayer():get():isShowNameWhenCamouflage())
end
function HandleEventLUp_Equipment_All_HelmInvisual()
  selfPlayerShowHelmet(not PaGlobal_Equipment_All._ui.check_helmInvisual:IsCheck())
  PaGlobal_Equipment_All:updateHelmIcon()
end
function HandleEventLUp_Equipment_All_HelmOpen()
  selfPlayerShowBattleHelmet(PaGlobal_Equipment_All._ui.check_helmOpen:IsCheck())
  PaGlobal_Equipment_All:updateHelmIcon()
end
function HandleEventLUp_Equipment_All_ShowCloak()
  selfPlayerShowCloak(not PaGlobal_Equipment_All._ui.check_cloak:IsCheck())
end
function HandleEventLUp_Equipment_All_ShowUnderWear()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:get():isWearingUnderwear() and false == selfPlayer:get():isWearingSwimmingSuit() then
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
    return
  end
  if true == selfPlayer:get():isWearingSwimmingSuit() then
    if false == IsSelfPlayerWaitAction() and false == IsSelfPlayerSwimmingWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SWIMMINGSUIT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if true == isSafeZone or true == IsSelfPlayerSwimmingWaitAction() then
      if true == selfPlayer:get():getSwimmingSuitMode() then
        selfPlayer:get():setSwimmingSuitMode(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setSwimmingSuitMode(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_SWIMMINGSUIT_ALERT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getSwimmingSuitMode()))
    end
  else
    if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_UNDERWEAR"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if isSafeZone then
      if selfPlayer:get():getUnderwearModeInhouse() then
        selfPlayer:get():setUnderwearModeInhouse(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setUnderwearModeInhouse(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_UNDERWARE_ALERT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
    end
  end
end
function HandleEventOnOut_Equipment_All_ToggleButtonToolTip(isShow, btnType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  if btnType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_DESC")
    control = PaGlobal_Equipment_All._ui.btn_servantInven
  elseif btnType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.check_camouflage
  elseif btnType == 2 then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if true == PaGlobal_Equipment_All._isSwimmingSuitContentEnable and true == selfPlayer:get():isWearingSwimmingSuit() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_DESC")
    end
    control = PaGlobal_Equipment_All._ui.check_underwear
  elseif btnType == 3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_DESC")
    control = PaGlobal_Equipment_All._ui.btn_petList
  elseif btnType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_DESC")
    control = PaGlobal_Equipment_All._ui.check_helmInvisual
  elseif btnType == 5 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_DESC")
    control = PaGlobal_Equipment_All._ui.check_helmOpen
  elseif btnType == 6 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_DESC")
    control = PaGlobal_Equipment_All._ui.check_cloak
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Equipment_All_PopupUITooltip(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_Equipment_All._ui.check_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_Equipment_All._ui.check_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Equipment_All_StatTooltip(isShow, tipType)
  FGlobal_EquipmentEffectTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = PaGlobal_Equipment_All._ui.txt_attackText
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_DEFENCE_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_DV") .. " " .. tostring(ToClient_getDv()) .. [[
<PAOldColor>
<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_PV") .. " " .. tostring(ToClient_getPv()) .. "<PAOldColor>"
    control = PaGlobal_Equipment_All._ui.txt_defenceText
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TOOLTIP_AWAKEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AWAKEN_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = PaGlobal_Equipment_All._ui.txt_awakenText
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT1_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = PaGlobal_Equipment_All._ui.txt_shyStatText
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Equipment_All_CostumeAccToolTip(isShow, btnType, slotNo)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  if btnType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DESC")
    control = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_circle, PaGlobal_Equipment_All._avataEquipSlotId[slotNo])
  elseif btnType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_DESC")
    control = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_circle, PaGlobal_Equipment_All._avataEquipSlotId[slotNo])
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONEDESC")
  TooltipSimple_Show(PaGlobal_Equipment_All._ui.check_alchemyStone, name, desc)
end
function HandleEventLUp_Equipment_All_AlchemyStoneCheckEvent(isShow)
  local isCheck = PaGlobal_Equipment_All._ui.check_alchemyStone:IsCheck()
  if nil ~= isShow and isCheck then
    isCheck = isShow
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eAlchemyStone, isCheck, CppEnums.VariableStorageType.eVariableStorageType_Character)
end
function HandleEventOnOut_Equipment_All_BannerTooltip(isShow, bannerType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if PaGlobal_Equipment_All._bannerType.SEASONPASS == bannerType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASON_MAIN_TITLE")
    control = PaGlobal_Equipment_All._ui.stc_seasonBannerPass
  elseif PaGlobal_Equipment_All._bannerType.TOTALREWARD == bannerType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOTALREWARD_TITLE")
    control = PaGlobal_Equipment_All._ui.stc_seasonBannerReward
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_Equipment_All_ChangeUnderwearMode(isUnderwearModeInHouse)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Equipment_All._ui.check_underwear:SetCheck(isUnderwearModeInHouse)
end
function FromClient_Equipment_All_ChangeSwimmingSuitMode(isShowSwimmingSuit)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Equipment_All._ui.check_underwear:SetCheck(isShowSwimmingSuit)
end
function FromClient_Equipment_All_FamilySpeicalInfoChange()
  if false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  PaGlobal_Equipment_All:updateSlotData()
end
function FromClient_Equipment_All_CharacterSpeicalInfoChange()
  if false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  PaGlobal_Equipment_All:updateSlotData()
end
function FromClient_Equipment_All_EventEquipItem(slotNo)
  local slot = PaGlobal_Equipment_All.slots[slotNo]
  if 13 < slotNo and slotNo < 24 then
    slot.icon:AddEffect("UI_ItemInstall_Cash", false, 0, 0)
  else
    slot.icon:AddEffect("UI_ItemInstall", false, 0, 0)
  end
  slot.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
  if slotNo < 14 or 29 == slotNo then
    PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing", false, -0.9, 0)
  else
    PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing02", false, -0.9, 0)
  end
  ToClient_updateAttackStat()
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    if PaGlobal_Equipment_All._offenceValue ~= ToClient_getOffence() then
      PaGlobal_Equipment_All._ui.txt_attackValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_attackValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    if PaGlobal_Equipment_All._awakenOffecnValue ~= ToClient_getAwakenOffence() and PaGlobal_Equipment_All._awakenWeaponContentsOpen then
      PaGlobal_Equipment_All._ui.txt_awakenValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_awakenValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    if PaGlobal_Equipment_All._defenceValue ~= ToClient_getDefence() then
      PaGlobal_Equipment_All._ui.txt_defenceValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_defenceValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    PaGlobal_TutorialManager:handleEquipItem(slotNo)
  end
  PaGlobal_Equipment_All:updateUnderwearSlot(slotNo)
end
