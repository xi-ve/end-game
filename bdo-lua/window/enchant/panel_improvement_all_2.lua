function PaGlobalFunc_Improvement_All_Open()
  PaGlobal_Improvement_All:prepareOpen()
end
function PaGlobalFunc_Improvement_All_Close()
  PaGlobal_Improvement_All:prepareClose()
  HandleEventLUp_DialogMain_All_BackClick()
end
function HandleEventLUp_Improvement_All_SelectEquipment(slotIdx)
  if nil == Panel_Window_Improvement_All then
    return
  end
  if nil == slotIdx then
    return
  end
  if true == PaGlobal_Improvement_All._doImprove then
    return
  end
  HandleEventRUp_Improvement_All_SlotInit()
  local itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, slotIdx)
  if nil == itemWrapper then
    return
  end
  local improveInfo = getImproveInformation()
  if nil == improveInfo then
    return
  end
  improveInfo:clearData()
  improveInfo:SetImproveSlot(PaGlobal_Improvement_All._whereType, slotIdx)
  PaGlobal_Improvement_All._equipSlot:clearItem()
  PaGlobal_Improvement_All._equipSlot:setItem(itemWrapper)
  PaGlobal_Improvement_All._equipSlotNo = slotIdx
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if false == PaGlobal_Improvement_All._isConsole then
    PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",false)")
    PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Improvement_All_SlotInit()")
  else
    PaGlobal_Improvement_All._ui.stc_equipItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_Improvement_All._ui.stc_equipItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_Improvement_All_SlotInit()")
  end
  PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
  PaGlobal_Improvement_All._equipSlot.icon:AddEffect("UI_ItemJewel", false, 0, 0)
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil ~= itemStatic then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  PaGlobal_Improvement_All:updateInventoryMaterialList()
end
function HandleEventRUp_Improvement_All_SlotInit()
  if nil == Panel_Window_Improvement_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, PaGlobal_Improvement_All._equipSlotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  if true == PaGlobal_Improvement_All._doImprove then
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    ToClient_BlackspiritEnchantCancel()
    PaGlobal_Improvement_All._doImprove = false
  end
  PaGlobal_Improvement_All._equipSlot:clearItem()
  PaGlobal_Improvement_All._equipSlotNo = -1
  PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_On", "")
  PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_Out", "")
  PaGlobal_Improvement_All._equipSlot.icon:addInputEvent("Mouse_RUp", "")
  PaGlobal_Improvement_All._ui.stc_equipItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  PaGlobal_Improvement_All._ui.stc_equipItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  PaGlobal_Improvement_All._materialSlot:clearItem()
  PaGlobal_Improvement_All._materialSlotNo = -1
  PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_On", "")
  PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_Out", "")
  PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_RUp", "")
  PaGlobal_Improvement_All._ui.stc_enchantItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  PaGlobal_Improvement_All._ui.stc_enchantItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  Panel_Tooltip_Item_hideTooltip()
  if true == PaGlobal_Improvement_All._isConsole and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
  end
  getImproveInformation():clearData()
  PaGlobal_Improvement_All:updateEquipList()
  PaGlobal_Improvement_All:updateBaseMaterialList()
end
function HandleEventLUp_Improvement_All_SelectMaterial(slotIdx)
  if nil == Panel_Window_Improvement_All then
    return
  end
  if nil == slotIdx then
    return
  end
  if true == PaGlobal_Improvement_All._doImprove then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, slotIdx)
  if nil == itemWrapper then
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if -1 ~= PaGlobal_Improvement_All._materialSlotNo then
    local equipimproveInfo = getImproveInformation()
    equipimproveInfo:clearData()
    if nil == equipimproveInfo then
      return
    end
    equipimproveInfo:SetImproveSlot(PaGlobal_Improvement_All._whereType, PaGlobal_Improvement_All._equipSlotNo)
  end
  local improveInfo = getImproveInformation()
  if nil == improveInfo then
    return
  end
  improveInfo:SetImproveSlot(PaGlobal_Improvement_All._whereType, slotIdx)
  PaGlobal_Improvement_All._materialSlot:clearItem()
  PaGlobal_Improvement_All._materialSlot:setItem(itemWrapper)
  PaGlobal_Improvement_All._materialSlotNo = slotIdx
  if false == PaGlobal_Improvement_All._isConsole then
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",false)")
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Improvement_All_SlotInit()")
  else
    PaGlobal_Improvement_All._ui.stc_enchantItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_Improvement_All._ui.stc_enchantItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_Improvement_All_SlotInit()")
  end
  PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
  PaGlobal_Improvement_All._materialSlot.icon:AddEffect("UI_ItemJewel", false, 0, 0)
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
end
function HandleEventOnOut_Improvement_All_ShowToolTip(slotIdx, isShow, isEquip)
  if nil == Panel_Window_Improvement_All then
    return
  end
  if nil == slotIdx then
    return
  end
  if false == isShow or nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
  else
    itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, slotIdx)
  end
  if nil == itemWrapper then
    return
  end
  if false == PaGlobal_Improvement_All._isConsole then
    Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), Panel_Window_Improvement_All, true, false)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Improvement_All_ShowToolTipItemKey(itemKey, isShow)
  if nil == Panel_Window_Improvement_All then
    return
  end
  if nil == itemKey then
    return
  end
  if false == isShow or nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    return
  end
  if false == PaGlobal_Improvement_All._isConsole then
    Panel_Tooltip_Item_Show(_itemKey, Panel_Window_Improvement_All, true, false)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Improvement_All_AniSkipToolTip(isShow)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_Window_Improvement_All then
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_SIMPLETOOLTIP_SKIP_NAME")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_SIMPLETOOLTIP_SKIP_DESC")
  control = PaGlobal_Improvement_All._ui.chk_skipAni
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Improvement_All_DoImprove()
  if nil == Panel_Window_Improvement_All then
    return
  end
  if true == PaGlobal_Improvement_All._doImprove then
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    ToClient_BlackspiritEnchantCancel()
    PaGlobal_Improvement_All._doImprove = false
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    PaGlobal_Improvement_All._ui.chk_skipAni:SetIgnore(false)
    return
  end
  local improveInfo = getImproveInformation()
  if 0 ~= improveInfo:IsReadyImprove() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_NEEDITEMALERT"))
    return
  end
  if true == PaGlobal_Improvement_All._ui.chk_skipAni:IsCheck() then
    getImproveInformation():doImprove()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
    ToClient_BlackspiritEnchantClose()
    PaGlobal_Improvement_All._doImprove = false
    PaGlobal_Improvement_All._doAnimation = false
    PaGlobal_Improvement_All._animationTime = 0
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._ui.chk_skipAni:SetIgnore(false)
    return
  else
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._ui.stc_improveBg:AddEffect("fUI_Improvement_01A", true, 20, 0)
    audioPostEvent_SystemUi(5, 6)
    _AudioPostEvent_SystemUiForXBOX(5, 6)
    audioPostEvent_SystemUi(5, 50)
    _AudioPostEvent_SystemUiForXBOX(5, 50)
    PaGlobal_Improvement_All._ui.chk_skipAni:SetIgnore(true)
  end
  PaGlobal_Improvement_All._animationTime = 0
  PaGlobal_Improvement_All._doImprove = true
  ToClient_BlackspiritEnchantStart()
end
function HandleEventPressB_Improvement_All_Back()
  if nil == Panel_Window_Improvement_All then
    return true
  end
  if true == PaGlobal_Improvement_All._doAnimation or true == PaGlobal_Improvement_All._doImprove then
    PaGlobal_Improvement_All._animationTime = 0
    PaGlobal_Improvement_All._doAnimation = false
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    ToClient_BlackspiritEnchantCancel()
    PaGlobal_Improvement_All._doImprove = false
    PaGlobal_Improvement_All._ui.chk_skipAni:SetIgnore(false)
    return false
  elseif -1 ~= PaGlobal_Improvement_All._equipSlotNo or -1 ~= PaGlobal_Improvement_All._materialSlotNo then
    HandleEventRUp_Improvement_All_SlotInit()
    return false
  else
    PaGlobalFunc_Improvement_All_Close()
    return true
  end
end
function HandleEventLUp_Improvement_All_EquipmentRelese(slotNo)
  if nil == slotNo then
    UI.ASSERT_NAME(nil ~= slotNo, "HandleEventLUp_Improvement_All_EquipmentRelese slotNo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
    else
      Equipment_RClick(slotNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(slotNo)
  end
end
function FromeClient_ImprovementAll_UpdateFuncDoingImprove(deltaTime)
  if nil == Panel_Window_Improvement_All then
    return
  end
  PaGlobal_Improvement_All._animationTime = PaGlobal_Improvement_All._animationTime + deltaTime
  if true == PaGlobal_Improvement_All._doImprove then
    PaGlobal_Improvement_All._ui_console.stc_enchantY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_CANCEL"))
    PaGlobal_Improvement_All._ui_pc.btn_enchant:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_CANCEL"))
  else
    PaGlobal_Improvement_All._ui_console.stc_enchantY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_ALL_TITLE"))
    PaGlobal_Improvement_All._ui_pc.btn_enchant:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_ALL_TITLE"))
  end
  if true == PaGlobal_Improvement_All._doAnimation then
    PaGlobal_Improvement_All._ui_pc.btn_enchant:SetIgnore(true)
    PaGlobal_Improvement_All._ui_console.stc_enchantY:SetMonoTone(true)
    Panel_Window_Improvement_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  else
    PaGlobal_Improvement_All._ui_pc.btn_enchant:SetIgnore(false)
    PaGlobal_Improvement_All._ui_console.stc_enchantY:SetMonoTone(false)
    Panel_Window_Improvement_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Improvement_All_DoImprove()")
  end
  if PaGlobal_Improvement_All._animationPlayTime < PaGlobal_Improvement_All._animationTime and true == PaGlobal_Improvement_All._doImprove then
    getImproveInformation():doImprove()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
    ToClient_BlackspiritEnchantClose()
    PaGlobal_Improvement_All._ui.chk_skipAni:SetIgnore(false)
    PaGlobal_Improvement_All._doImprove = false
    PaGlobal_Improvement_All._doAnimation = true
    PaGlobal_Improvement_All._animationTime = 0
  end
  if PaGlobal_Improvement_All._animationTime > 3 and true == PaGlobal_Improvement_All._doAnimation then
    PaGlobal_Improvement_All._animationTime = 0
    PaGlobal_Improvement_All._ui.stc_improveBg:EraseAllEffect()
    PaGlobal_Improvement_All._equipSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_Improvement_All._doAnimation = false
  end
end
function FromClient_Improvement_All_ResponseImprove(itemEnchantKey, index)
  if nil == Panel_Window_Improvement_All then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local isSuccess = false
  local itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, PaGlobal_Improvement_All._equipSlotNo)
  PaGlobal_Improvement_All._ui.txt_result:EraseAllEffect()
  if 0 == index then
    PaGlobal_Improvement_All._ui.txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_SUCCESSMSG_NEW"))
    PaGlobal_Improvement_All._ui.txt_result:AddEffect("UI_QustComplete01", false, 0, 0)
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
    if nil ~= itemWrapper then
      PaGlobal_Improvement_All._equipSlot:setItem(itemWrapper)
    end
    PaGlobal_Improvement_All._materialSlot:clearItem()
    PaGlobal_Improvement_All._materialSlotNo = -1
    PaGlobal_Improvement_All._equipSlotNo = -1
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_On", "")
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_Out", "")
    PaGlobal_Improvement_All._materialSlot.icon:addInputEvent("Mouse_RUp", "")
    getImproveInformation():clearData()
    PaGlobal_Improvement_All:updateEquipList()
    PaGlobal_Improvement_All:updateBaseMaterialList()
    isSuccess = true
  else
    PaGlobal_Improvement_All._ui.txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPROVEMENT_FAILMSG_NEW"))
    PaGlobal_Improvement_All._ui.txt_result:AddEffect("fUI_Enchant_Fail", false, 0, 0)
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
    local itemWrapper = getInventoryItemByType(0, PaGlobal_Improvement_All._materialSlotNo)
    if nil ~= itemWrapper then
      getImproveInformation():clearData()
      HandleEventLUp_Improvement_All_SelectMaterial(PaGlobal_Improvement_All._materialSlotNo)
    else
      PaGlobal_Improvement_All._materialSlot:clearItem()
      PaGlobal_Improvement_All._materialSlotNo = -1
      HandleEventLUp_Improvement_All_SelectEquipment(PaGlobal_Improvement_All._equipSlotNo)
      PaGlobal_Improvement_All:updateEquipList()
      PaGlobal_Improvement_All:updateInventoryMaterialList()
    end
    isSuccess = false
  end
  PaGlobalFunc_Improvement_All_ResultShowAni()
  PaGlobalFunc_Improvement_All_ResultHideAni(isSuccess)
end
function FromClient_Improvement_All_UpdateItemList()
  if false == Panel_Window_Improvement_All:GetShow() then
    return
  end
  PaGlobal_Improvement_All:updateEquipList()
  PaGlobal_Improvement_All:updateInventoryMaterialList()
end
function PaGlobalFunc_Improvement_All_ResultShowAni()
  if nil == Panel_Window_Improvement_All then
    return
  end
  PaGlobal_Improvement_All._ui.txt_result:SetShow(true)
  local showAni = PaGlobal_Improvement_All._ui.txt_result:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  showAni:SetStartColor(Defines.Color.C_00FFFFFF)
  showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  showAni:SetStartIntensity(3)
  showAni:SetEndIntensity(1)
  showAni.IsChangeChild = true
end
function PaGlobalFunc_Improvement_All_ResultHideAni(isSuccess)
  if nil == Panel_Window_Improvement_All then
    return
  end
  local aniTime = 1
  if true == isSuccess then
    aniTime = 1.5
  end
  local closeAni = PaGlobal_Improvement_All._ui.txt_result:addColorAnimation(aniTime, aniTime + 0.22, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  closeAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  closeAni:SetEndColor(Defines.Color.C_00FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = true
  closeAni:SetHideAtEnd(true)
  closeAni:SetDisableWhileAni(true)
end
function PaGlobalFunc_Improvement_All_UpdateEquipList(control, key)
  if nil == Panel_Window_Improvement_All then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_EquipList")
  local stc_slotBg = UI.getChildControl(btn_list, "Static_EquipListSlotBg")
  local stc_slot = UI.getChildControl(btn_list, "Static_EquipListSlot")
  local txt_name = UI.getChildControl(btn_list, "StaticText_EquipName")
  local txt_equiped = UI.getChildControl(btn_list, "StaticText_EquipSlotText")
  local _key = Int64toInt32(key)
  if nil == PaGlobal_Improvement_All._equipList[_key] then
    return
  end
  local slotIdx = PaGlobal_Improvement_All._equipList[_key]
  local itemWrapper
  local slot = {}
  SlotItem.reInclude(slot, "Improve_All_ItemSlot_", 0, stc_slot, PaGlobal_Improvement_All._slotConfig)
  slot:clearItem()
  if _key <= PaGlobal_Improvement_All._indexInvenEnd then
    itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, slotIdx)
    slot:setItem(itemWrapper)
    local itemKey = itemWrapper:get():getKey():getItemKey()
    txt_equiped:SetShow(false)
    txt_equiped:SetIgnore(true)
    txt_equiped:addInputEvent("Mouse_LUp", "")
    if false == _ContentsGroup_UsePadSnapping then
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_SelectEquipment(" .. slotIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",false)")
    else
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Improvement_All_SelectEquipment(" .. slotIdx .. ")")
    end
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_SelectEquipment(" .. slotIdx .. ")")
  else
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
    slot:setItem(itemWrapper)
    local itemKey = itemWrapper:get():getKey():getItemKey()
    txt_equiped:SetShow(true)
    txt_equiped:SetIgnore(false)
    if false == _ContentsGroup_UsePadSnapping then
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_EquipmentRelese(" .. slotIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true, true )")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",false, true)")
    else
      btn_list:SetIgnore(false)
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true, true )")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Improvement_All_EquipmentRelese(" .. slotIdx .. ")")
    end
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_EquipmentRelese(" .. slotIdx .. ")")
  end
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local fontColor = PaGlobal_Improvement_All:convertFromItemGradeColor(itemGrade)
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if 16 <= enchantLevel then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetFontColor(fontColor)
  txt_name:SetText(enchantText .. itemSSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(txt_name, itemSSW)
  btn_list:setNotImpactScrollEvent(true)
  btn_list:SetCheck(false)
end
function PaGlobalFunc_Improvement_All_UpdateMaterialList(control, key)
  if nil == Panel_Window_Improvement_All then
    return
  end
  local btn_list = UI.getChildControl(control, "RadioButton_EnchantItemList")
  local stc_slotBg = UI.getChildControl(btn_list, "Static_EnchantItemSlotBg")
  local stc_slot = UI.getChildControl(btn_list, "Static_EnchantItemSlot")
  local txt_name = UI.getChildControl(btn_list, "StaticText_EnchantItemName")
  local txt_count = UI.getChildControl(btn_list, "StaticText_EnchantItemSlotText")
  local stc_tooltipSlot = UI.getChildControl(control, "Static_TooltipSlot")
  local _key = Int64toInt32(key)
  if nil == PaGlobal_Improvement_All._materialList[_key] then
    return
  end
  local itemSSW, itemKey, slotIdx
  local itemCnt = 0
  local slot = {}
  SlotItem.reInclude(slot, "Improve_All_MaterialSlot_", 0, stc_slot, PaGlobal_Improvement_All._slotConfig)
  slot:clearItem()
  if -1 == PaGlobal_Improvement_All._equipSlotNo then
    btn_list:SetIgnore(true)
    slot.icon:SetIgnore(true)
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(PaGlobal_Improvement_All._materialList[_key]))
    slot:setItemByStaticStatus(itemSSW)
    itemKey = PaGlobal_Improvement_All._materialList[_key]
    if nil ~= PaGlobal_Improvement_All._materialListItemCount[_key] then
      itemCnt = PaGlobal_Improvement_All._materialListItemCount[_key]
    end
    if false == _ContentsGroup_UsePadSnapping then
      stc_tooltipSlot:addInputEvent("Mouse_LUp", "")
      stc_tooltipSlot:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTipItemKey(" .. itemKey .. ",true)")
      stc_tooltipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTipItemKey(" .. itemKey .. ",false)")
    else
      btn_list:SetIgnore(false)
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTipItemKey(" .. itemKey .. ",true)")
    end
  else
    btn_list:SetIgnore(false)
    slotIdx = PaGlobal_Improvement_All._materialList[_key]
    local wrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, slotIdx)
    if nil ~= wrapper then
      itemSSW = wrapper:getStaticStatus()
      slot:setItemByStaticStatus(itemSSW)
      itemKey = wrapper:get():getKey():getItemKey()
      itemCnt = Int64toInt32(wrapper:get():getCount_s64())
      if false == _ContentsGroup_UsePadSnapping then
        stc_tooltipSlot:addInputEvent("Mouse_On", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
        stc_tooltipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",false)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Improvement_All_ShowToolTip(" .. slotIdx .. ",true)")
      end
    end
  end
  if nil == itemSSW then
    return
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(itemSSW:getName())
  if -1 == PaGlobal_Improvement_All._equipSlotNo then
    txt_name:SetFontColor(Defines.Color.C_FF5A5A5A)
  else
    PAGlobalFunc_SetItemTextColorForNewUI(txt_name, itemSSW)
  end
  btn_list:setNotImpactScrollEvent(true)
  btn_list:SetCheck(false)
  if 0 == itemCnt then
    btn_list:SetMonoTone(true)
    slot.icon:SetMonoTone(true)
    txt_name:SetMonoTone(true)
    txt_count:SetShow(false)
    btn_list:addInputEvent("Mouse_LUp", "")
    btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  else
    txt_count:SetShow(true)
    txt_count:SetText(itemCnt)
    if -1 == PaGlobal_Improvement_All._equipSlotNo then
      btn_list:SetMonoTone(true)
      slot.icon:SetMonoTone(true)
      txt_name:SetMonoTone(true)
      txt_count:SetMonoTone(true)
    else
      btn_list:SetMonoTone(false)
      slot.icon:SetMonoTone(false)
      txt_name:SetMonoTone(false)
      txt_count:SetMonoTone(false)
    end
    if -1 ~= PaGlobal_Improvement_All._materialSlotNo and PaGlobal_Improvement_All._materialSlotNo == PaGlobal_Improvement_All._materialList[_key] then
      local itemWrapper = getInventoryItemByType(PaGlobal_Improvement_All._whereType, PaGlobal_Improvement_All._materialSlotNo)
      if nil ~= itemWrapper then
        local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
        txt_count:SetText(itemCount)
        btn_list:SetCheck(true)
      end
    end
    if nil ~= slotIdx then
      if false == _ContentsGroup_UsePadSnapping then
        stc_tooltipSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_SelectMaterial(" .. slotIdx .. ")")
        btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_Improvement_All_SelectMaterial(" .. slotIdx .. ")")
      else
        btn_list:SetIgnore(false)
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Improvement_All_SelectMaterial(" .. slotIdx .. ")")
      end
    end
  end
end
function PaGlobal_Improvement_All_IsImprovementing()
  return PaGlobal_Improvement_All._doImprove
end
