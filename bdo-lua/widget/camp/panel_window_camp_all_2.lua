function PaGlobalFunc_Camp_All_Open()
  if nil == Panel_Window_Camp_All then
    return
  end
  if true == PaGlobalFunc_Camp_All_CloseAll() then
    return
  end
  ToClient_openCampingInfo()
end
function PaGlobalFunc_Camp_All_Close()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:prepareClose()
  if nil ~= Panel_Window_Inventory and Panel_Window_Inventory:GetShow() then
    if false == _ContentsGroup_UsePadSnapping then
      Inventory_ShowToggle()
      TooltipSimple_Hide()
    else
      PaGlobalFunc_InventoryInfo_Close()
      PaGlobalFunc_FloatingTooltip_Close()
    end
  elseif nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:GetShow() and false == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_Inventory_All_ShowToggle()
    TooltipSimple_Hide()
  end
end
function PaGlobalFunc_Camp_All_CloseAll()
  local isMenuOpened
  if nil ~= Panel_Window_BuildingBuff_All and Panel_Window_BuildingBuff_All:GetShow() then
    PaGlobalFunc_BuildingBuff_All_Close()
    isMenuOpened = false
  end
  if nil ~= Panel_Window_CampWarehouse_All and Panel_Window_CampWarehouse_All:GetShow() then
    PaGlobalFunc_CampWarehouse_All_Close()
    isMenuOpened = false
  end
  if true == _ContentsGroup_UsePadSnapping then
    if nil ~= Panel_Dialog_NPCShop and Panel_Dialog_NPCShop:GetShow() and PaGlobal_Camp_All._isCamping then
      PaGlobalFunc_Dialog_NPCShop_Close()
      isMenuOpened = false
    end
  else
    if true == _ContentsGroup_NewUI_NpcShop_All then
      if nil ~= PaGlobalFunc_NPCShop_ALL_GetShow and PaGlobalFunc_NPCShop_ALL_GetShow() and PaGlobalFunc_NPCShop_ALL_GetIsCamping() then
        HandleEventLUp_NPCShop_ALL_Close()
        isMenuOpened = false
      end
    elseif nil ~= Panel_Dialog_NPCShop and Panel_Dialog_NPCShop:GetShow() and npcShop_GetIsCamping() then
      PaGlobalFunc_Dialog_NPCShop_Close()
      isMenuOpened = false
    end
    if true == _ContentsGroup_NewUI_RepairFunction_All and nil ~= Panel_Dialog_Repair_Function_All and Panel_Dialog_Repair_Function_All:GetShow() and PaGlobalFunc_RepairFunc_All_IsCampingType() then
      PaGlobalFunc_RepairFunc_All_Close()
      isMenuOpened = false
    end
    if nil ~= Panel_Window_Warehouse and Panel_Window_Warehouse:GetShow() then
      FromClient_Warehouse_All_Close()
    end
    if nil ~= Panel_Window_ServantInventory and Panel_Window_ServantInventory:GetShow() then
      ServantInventory_Close()
    end
  end
  if nil ~= Panel_Window_Camp_All and Panel_Window_Camp_All:GetShow() then
    PaGlobalFunc_Camp_All_Close()
    if nil == isMenuOpened then
      isMenuOpened = true
      Inventory_SetFunctor(nil, nil, nil, nil)
    end
  end
  return isMenuOpened
end
function HandleClickedLUp_Camp_All_UnsealTent()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:unsealTent()
end
function HandleClickedLUp_Camp_All_RemoteTent()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:remoteTent()
end
function HandleClickedLUp_Camp_All_OpenVilla()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:openVilla()
end
function HandleClickedLUp_Camp_All_AddEquipItem(slotNo)
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:addEquipItem(slotNo)
end
function HandleClickedLUp_Camp_All_OpenMenuFuction(menuNo)
  if nil == Panel_Window_Camp_All then
    return
  end
  if true == _ContentsGroup_NewUI_Fairy_All then
    PaGlobal_FairyInfo_Close_All()
  else
    PaGlobal_FairyInfo_Close()
  end
  PaGlobal_Camp_All:openMenuFuction(menuNo)
end
function FromClient_Camp_All_OpenByActorKeyRaw(actorKeyRaw)
  if nil == Panel_Window_Camp_All then
    return
  end
  if nil ~= actorKeyRaw then
    PaGlobal_Camp_All:openByActorKeyRaw(actorKeyRaw)
  end
  if Panel_Window_Camp_All:GetShow() and false == PaGlobal_Camp_All._isOpen then
    if true == _ContentsGroup_UsePadSnapping then
      PaGlobalFunc_Camp_All_Close()
      return
    elseif nil ~= Panel_Window_Inventory and false == Panel_Window_Inventory:GetShow() or nil ~= Panel_Window_Inventory_All and false == Panel_Window_Inventory_All:GetShow() then
      PaGlobalFunc_Camp_All_Close()
      return
    end
  end
  if true == _ContentsGroup_NewUI_Fairy_All then
    PaGlobal_FairyInfo_Close_All()
  else
    PaGlobal_FairyInfo_Close()
  end
  PaGlobal_Camp_All._isOpen = false
  if nil ~= Panel_Window_Inventory and false == Panel_Window_Inventory:GetShow() then
    if true == _ContentsGroup_UsePadSnapping then
      Inventory_SetShow(not Panel_Window_Inventory:GetShow())
    else
      Inventory_ShowToggle()
    end
  elseif nil ~= Panel_Window_Inventory_All and false == Panel_Window_Inventory_All:GetShow() then
    PaGlobalFunc_Inventory_All_ShowToggle()
  end
  PaGlobal_Camp_All:prepareOpen()
  PaGlobal_Camp_All:update()
  PaGlobal_Camp_All._isCamping = true
  if false == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      PaGlobalFunc_RepairFunc_All_SetIsCamping(true)
    else
      PaGlobal_Repair:setIsCamping(true)
    end
    if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= PaGlobalFunc_NPCShop_ALL_SetIsCamping then
      PaGlobalFunc_NPCShop_ALL_SetIsCamping(true)
    else
      npcShop:setIsCamping(true)
    end
  end
end
function FromClient_Camp_All_EventServantEquipItem(slotNo)
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:changeEquipItem(slotNo)
end
function FromClient_Camp_All_OpenCampingRepair()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All._isCamping = true
  PaGlobal_Camp_All:openCampingRepair(true)
end
function FromClient_Camp_All_OpenCampingShop()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All._isCamping = true
  if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= FromClient_NPCShop_ALL_Open then
    FromClient_NPCShop_ALL_Open(true)
  else
    FromClient_Dialog_NPCShop_UpdateContent()
  end
end
function FromClient_Camp_All_CampingUpdate()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All:update()
end
function FromClient_Camp_All_CampingTentSeal()
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobalFunc_Camp_All_Close()
  if nil ~= Panel_Window_BuildingBuff_All and Panel_Window_BuildingBuff_All:GetShow() then
    PaGlobal_BuildingBuff_All:prepareClose()
  end
end
function PaGlobalFunc_Camp_All_GetShow()
  if nil == Panel_Window_Camp_All then
    return
  end
  return Panel_Window_Camp_All:GetShow()
end
function PaGlobalFunc_Camp_All_GetIsCamping()
  if nil == Panel_Window_Camp_All or nil == PaGlobal_Camp_All._isCamping then
    return
  end
  return PaGlobal_Camp_All._isCamping
end
function PaGlobalFunc_Camp_All_SetIsCamping(isCamping)
  if nil == Panel_Window_Camp_All then
    return
  end
  PaGlobal_Camp_All._isCamping = isCamping
end
function PaGlobalFunc_Camp_All_RequestNavi()
  ToClient_requestCampingNavi()
end
function PaGlobalFunc_Camp_All_GetActorKeyRaw()
  if nil == Panel_Window_Camp_All then
    return
  end
  return PaGlobal_Camp_All._actorKeyRaw
end
function PaGlobalFunc_Camp_All_ShowButtonTooltip(buttonType, isShow)
  if nil == Panel_Window_Camp_All or _ContentsGroup_UsePadSnapping then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc = "", nil
  if 0 == buttonType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_CAMP_REMOTEBUTTON_TOOLTIP")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_NPCNAVI_BUTTON_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    TooltipSimple_Show(PaGlobal_Camp_All._ui.btn_RemoteTent, name, desc)
  elseif 1 == buttonType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_SETUP")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_CAMP_INSTALL_BUTTON_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    TooltipSimple_Show(PaGlobal_Camp_All._ui.btn_UnsealTent, name, desc)
  elseif 2 == buttonType then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_GUIDETOOLTIP_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_GUIDETOOLTIP_DESC")
    TooltipSimple_Show(PaGlobal_Camp_All._ui.btn_Guide, name, desc)
  end
end
function PaGlobalFunc_Camp_All_ShowEquipItemTooltip(slotNo, isShow)
  if nil == Panel_Window_Camp_All or _ContentsGroup_UsePadSnapping then
    return
  end
  local slot = PaGlobal_Camp_All._itemSlots[slotNo]
  Panel_Tooltip_Item_SetPosition(slotNo, slot, "CampEquip")
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "CampEquip", isShow)
end
