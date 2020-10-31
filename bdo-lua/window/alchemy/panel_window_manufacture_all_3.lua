function PaGlobalFunc_Manufacture_All_Open(installationType, materialWhereType, isClear, showType, waypointKey)
  if nil == Panel_Window_Manufacture_All then
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_manufacture) then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  end
  if selfPlayerIsInCompetitionArea() then
    return
  end
  PaGlobal_Manufacture_All:checkOpenPanel()
  PaGlobal_Manufacture_All._invenShow = showType
  StopManufactureAction()
  PaGlobal_Manufacture_All:resetGrindJewelSetting()
  if nil == materialWhereType then
    return
  end
  if materialWhereType ~= CppEnums.ItemWhereType.eInventory and materialWhereType ~= CppEnums.ItemWhereType.eCashInventory and materialWhereType ~= CppEnums.ItemWhereType.eWarehouse then
    return
  end
  PaGlobal_Manufacture_All._materialItemWhereType = materialWhereType
  if materialWhereType == CppEnums.ItemWhereType.eWarehouse and nil == waypointKey then
    return
  end
  if CppEnums.ItemWhereType.eInventory == materialWhereType or CppEnums.ItemWhereType.eCashInventory == materialWhereType then
    if false == PaGlobal_Manufacture_All._isConsole then
      InventoryWindow_Show()
      Inventory_SetFunctor(PaGlobal_Manufacture_All_InventoryFilterFunc, PaGlobal_Manufacture_All_InventoryRClickFunc, PaGlobalFunc_Manufacture_All_Close, nil)
    end
  else
    PaGlobal_Manufacture_All._waypointKey_ByWareHouse = waypointKey
    InventoryWindow_Close()
    if _ContentsGroup_NewUI_WareHouse_All then
      FromClient_Manufacture_All_OnScreenResize()
      PaGlobal_Warehouse_All_OpenPanelFromManufacture()
      PaGlobal_Warehouse_All_SetFunctor(nil, nil)
    else
      Warehouse_OpenPanelFromManufacture()
      Warehouse_SetFunctor(nil, nil)
    end
  end
  ReconstructionAlchemyKnowledge()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:IsUISubApp() then
      Panel_Window_Manufacture_All:OpenUISubApp()
    end
  elseif Panel_Window_Inventory:IsUISubApp() then
    Panel_Window_Manufacture_All:OpenUISubApp()
  end
  if true == isClear then
    PaGlobal_Manufacture_All:clearMaterial()
  end
  PaGlobal_Manufacture_All_UpdateVisibleRadioButton(installationType)
  if nil ~= installationType then
    local isEnable = false
    if installationType == CppEnums.InstallationType.eType_Mortar then
      isEnable = isEnableManufactureAction(PaGlobal_Manufacture_All._listAction[1]._actionName)
      PaGlobal_Manufacture_All._listAction[1]._radioBtn:SetCheck(true)
      PaGlobal_Manufacture_All_SelectManufactureAction(1, false)
      if false == isEnable then
        PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NEED_KNOWLEDGE_MORTAR"))
      end
      PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(not isEnable)
    elseif installationType == CppEnums.InstallationType.eType_Anvil then
      isEnable = isEnableManufactureAction(PaGlobal_Manufacture_All._listAction[7]._actionName)
      PaGlobal_Manufacture_All._listAction[7]._radioBtn:SetCheck(true)
      PaGlobal_Manufacture_All_SelectManufactureAction(7, true)
      if false == isEnable then
        PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NEED_KNOWLEDGE_ANVIL"))
      end
      PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(not isEnable)
    elseif installationType == CppEnums.InstallationType.eType_Stump then
      isEnable = isEnableManufactureAction(PaGlobal_Manufacture_All._listAction[2]._actionName)
      PaGlobal_Manufacture_All._listAction[2]._radioBtn:SetCheck(true)
      PaGlobal_Manufacture_All_SelectManufactureAction(2, false)
      if false == isEnable then
        PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NEED_KNOWLEDGE_STUMP"))
      end
      PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(not isEnable)
    elseif installationType == CppEnums.InstallationType.eType_FireBowl then
      isEnable = isEnableManufactureAction(PaGlobal_Manufacture_All._listAction[5]._actionName)
      PaGlobal_Manufacture_All._listAction[5]._radioBtn:SetCheck(true)
      PaGlobal_Manufacture_All_SelectManufactureAction(5, false)
      if false == isEnable then
        PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NEED_KNOWLEDGE_FIREBOWL"))
      end
      PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(not isEnable)
    else
      PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(false)
    end
    PaGlobal_Manufacture_All:updateCheckRadioButton()
    if false == PaGlobal_Manufacture_All._isConsole then
      PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(isEnable)
    end
  else
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(false)
    PaGlobal_Manufacture_All._ui.txt_needKnowledge:SetShow(false)
    if nil == PaGlobal_Manufacture_All._actionIndex or -1 == PaGlobal_Manufacture_All._actionIndex then
      PaGlobal_Manufacture_All_SelectManufactureAction(0, true, true)
    elseif PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == PaGlobal_Manufacture_All._actionIndex then
      PaGlobal_Manufacture_All_SelectManufactureAction(0, true, true)
    else
      PaGlobal_Manufacture_All_SelectManufactureAction(PaGlobal_Manufacture_All._actionIndex, true, true)
    end
  end
  PaGlobal_Manufacture_All:setGuildManufactureButton()
  PaGlobal_Manufacture_All:setAlignKeyGuide()
  Panel_Window_Manufacture_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Manufacture_All_SelectManufactureActionByPad(true)")
  Panel_Window_Manufacture_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Manufacture_All_SelectManufactureActionByPad(false)")
  PaGlobal_Manufacture_All:prepareOpen()
end
function PaGlobalFunc_Manufacture_All_Close()
  if nil == Panel_Window_Manufacture_All then
    return
  end
  PaGlobal_Manufacture_All:prepareClose()
end
function PaGlobalFunc_Manufacture_All_ToggleWindow(installationType, isClear)
  if true == Panel_Window_Manufacture_All:GetShow() then
    PaGlobalFunc_Manufacture_All_Close()
  else
    if false == PaGlobal_Manufacture_All._isConsole then
      InventoryWindow_Show()
    end
    local curentInventoryType = Inventory_GetCurrentInventoryType()
    PaGlobalFunc_Manufacture_All_Open(installationType, curentInventoryType, isClear)
  end
end
function PaGlobalFunc_Manufacture_All_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_Manufacture_All)
  PaGlobal_Manufacture_All._ui.stc_circle:SetShow(true)
  PaGlobal_Manufacture_All._ui.stc_circle:SetAlpha(0)
  UIAni.AlphaAnimation(1, PaGlobal_Manufacture_All._ui.stc_circle, 0, 0.2)
  local aniInfo1 = Panel_Window_Manufacture_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_Manufacture_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Manufacture_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Manufacture_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Manufacture_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Manufacture_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_Manufacture_All_HideAni()
  Panel_Window_Manufacture_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Manufacture_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
  local alphaAni = UIAni.AlphaAnimation(0, PaGlobal_Manufacture_All._ui.stc_circle, 0, 0.12)
  alphaAni:SetHideAtEnd(true)
end
function PaGlobal_Manufacture_All_SelectManufactureActionByPad(isLeft)
  local selectIndex = PaGlobal_Manufacture_All._actionIndex
  if true == isLeft then
    if PaGlobal_Manufacture_All._actionIndex > 0 then
      for ii = selectIndex - 1, 0, -1 do
        if true == PaGlobal_Manufacture_All._listAction[ii]._radioBtn:GetShow() and true == PaGlobal_Manufacture_All._listAction[ii]._enable then
          selectIndex = ii
          break
        end
      end
    else
      selectIndex = PaGlobal_Manufacture_All._manufactureMaxCount - 1
    end
  elseif PaGlobal_Manufacture_All._actionIndex < PaGlobal_Manufacture_All._manufactureMaxCount - 1 then
    for ii = selectIndex + 1, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
      if true == PaGlobal_Manufacture_All._listAction[ii]._radioBtn:GetShow() and true == PaGlobal_Manufacture_All._listAction[ii]._enable then
        selectIndex = ii
        break
      end
    end
  else
    selectIndex = 0
  end
  PaGlobal_Manufacture_All_SelectManufactureAction(selectIndex, true)
end
function PaGlobal_Manufacture_All_SelectManufactureAction(index, isClear, ignoreAction, isRepeat)
  if MessageBoxGetShow() then
    return
  end
  if true ~= ignoreAction and not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
    return
  end
  if index < 0 then
    return
  end
  for i = 0, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
    if i ~= index then
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetCheck(false)
    else
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetCheck(true)
      local linePos = PaGlobal_Manufacture_All._listAction[i]._radioBtn:GetPosX() + PaGlobal_Manufacture_All._listAction[i]._radioBtn:GetSizeX() * 0.5 - PaGlobal_Manufacture_All._ui.stc_selectLine:GetSizeX() * 0.5
      PaGlobal_Manufacture_All._ui.stc_selectLine:SetSpanSize(linePos, PaGlobal_Manufacture_All._ui.stc_selectLine:GetSpanSize().y)
    end
  end
  if true == isClear then
    PaGlobal_Manufacture_All:clearMaterial()
  end
  if true ~= isRepeat then
    PaGlobal_Manufacture_All:resetGrindJewelSetting()
  end
  StopManufactureAction()
  TooltipSimple_Hide()
  audioPostEvent_SystemUi(13, 10)
  PaGlobal_Manufacture_All._actionIndex = index
  PaGlobal_Manufacture_All:updateUsingSlotCount(index)
  PaGlobal_Manufacture_All:updateSlotPos()
  PaGlobal_Manufacture_All:showPointEffect()
  PaGlobal_Manufacture_All:setManufactureText(index)
  PaGlobal_Manufacture_All:updateCheckRadioButton()
  PaGlobal_Manufacture_All:updateLifePoint()
  if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == index then
    PaGlobal_Manufacture_All._usingInstallationType = CppEnums.InstallationType.eType_Anvil
    PaGlobal_Manufacture_All._ui.txt_knowledgeCount:SetShow(false)
    PaGlobal_Manufacture_All:clearList()
  else
    PaGlobal_Manufacture_All._usingInstallationType = CppEnums.InstallationType.TypeCount
    PaGlobal_Manufacture_All._startKnowledgeIndex = 0
    ReconstructionAlchemyKnowledge(PaGlobal_Manufacture_All.MANUFACTURE_INFO[index].mentalThemeKey)
    PaGlobal_Manufacture_All:updateKnowledgeCount()
    PaGlobal_Manufacture_All:updateList()
    if false == PaGlobal_Manufacture_All._isConsole then
      PaGlobal_Manufacture_All:setKnowledgeDesc(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_WARNING_DEFAULT_DESC"))
    end
  end
  PaGlobal_Manufacture_All._ui.txt_noList:SetShow(false)
  PaGlobal_Manufacture_All:updateMaterial()
  if CppEnums.ItemWhereType.eInventory == PaGlobal_Manufacture_All._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == PaGlobal_Manufacture_All._materialItemWhereType then
    if false == PaGlobal_Manufacture_All._isConsole then
      Inventory_SetFunctor(PaGlobal_Manufacture_All_InvenFiler, PaGlobal_Manufacture_All_PushItemFromInventory, PaGlobalFunc_Manufacture_All_Close, nil)
    else
      Inventory_SetFunctor(PaGlobal_Manufacture_All_InvenFiler, PaGlobal_Manufacture_All_PushItemFromInventory, nil, nil, {func = PaGlobal_Manufacture_All_InventoryYFunc})
    end
    Inventory_updateSlotData()
  elseif true == _ContentsGroup_NewUI_WareHouse_All then
    PaGlobal_Warehouse_All_SetFunctor(PaGlobal_Manufacture_All_WarehouseFilter, PaGlobal_Manufacture_All_PushItemFromWarehouse)
    PaGlobal_Warehouse_All_UpdateSlotData()
  else
    Warehouse_SetFunctor(PaGlobal_Manufacture_All_WarehouseFilter, PaGlobal_Manufacture_All_PushItemFromWarehouse)
    Warehouse_updateSlotData()
  end
  PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG:addInputEvent("Mouse_On", "")
  PaGlobal_Manufacture_All._ui.stc_knowledgeDetailBG:addInputEvent("Mouse_Out", "")
  PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(false)
  PaGlobal_Manufacture_All._canRepeat = false
  if true == PaGlobal_Manufacture_All._isConsole and true == Panel_Window_Manufacture_All:GetShow() then
    ToClient_padSnapResetControl()
  end
  PaGlobal_Manufacture_All:refreshIsMassCheckButton(index)
  PaGlobal_Manufacture_All_UpdateManufactureButton()
end
function PaGlobal_Manufacture_All_UpdateManufactureButton()
  if nil == PaGlobal_Manufacture_All._actionIndex or -1 == PaGlobal_Manufacture_All._actionIndex then
    return
  end
  local actionName = PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex]._actionName
  local isEnable = isEnableManufactureAction(actionName)
  if true == PaGlobal_Manufacture_All._isConsole then
    if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == PaGlobal_Manufacture_All._actionIndex then
      PaGlobal_Manufacture_All._ui.stc_iconX:SetShow(false)
    else
      PaGlobal_Manufacture_All._ui.stc_iconX:SetShow(isEnable)
    end
    PaGlobal_Manufacture_All._ui.stc_iconA:SetShow(isEnable)
    if true == isEnable then
      Panel_Window_Manufacture_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Manufacture_All_InventoryOpen()")
    else
      Panel_Window_Manufacture_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
    PaGlobal_Manufacture_All:setAlignKeyGuide()
  else
    PaGlobal_Manufacture_All._ui.btn_manufacture:SetShow(isEnable)
  end
end
function PaGlobal_Manufacture_All_SelectDisableManufactureAction(index)
  if nil ~= PaGlobal_Manufacture_All._listAction[index] then
    PaGlobal_Manufacture_All._listAction[index]._radioBtn:SetCheck(false)
  end
  if nil ~= PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex] then
    PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex]._radioBtn:SetCheck(true)
  end
end
function PaGlobal_Manufacture_All_InventoryFilterFunc()
  return true
end
function PaGlobal_Manufacture_All_InventoryRClickFunc()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_SELECTCHECK2"))
end
function PaGlobal_Manufacture_All_InvenFiler(slotNo, itemWrapper, inventoryType)
  if -1 == PaGlobal_Manufacture_All._actionIndex then
    return false
  end
  if true == PaGlobal_Manufacture_All:slotFullCheck() then
    return true
  end
  if isUsePcExchangeInLocalizingValue() then
    local isVested = itemWrapper:get():isVested()
    local isPersonalTrade = itemWrapper:getStaticStatus():isPersonalTrade()
    if isVested and isPersonalTrade then
      return true
    end
  end
  local actionName = PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex]._actionName
  if false == isEnableManufactureAction(actionName) then
    return true
  end
  local isEnable
  if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == PaGlobal_Manufacture_All._actionIndex then
    isEnable = itemWrapper:checkToRepairItem()
  else
    isEnable = isManufactureItem(inventoryType, slotNo, actionName)
  end
  if ToClient_Inventory_CheckItemLock(slotNo, inventoryType) then
    isEnable = false
  end
  return not isEnable
end
function PaGlobal_Manufacture_All_WarehouseFilter(slotNo, itemWrapper, stackCount)
  if -1 == PaGlobal_Manufacture_All._actionIndex then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  if true == PaGlobal_Manufacture_All:slotFullCheck() then
    return true
  end
  if isUsePcExchangeInLocalizingValue() then
    local isVested = itemWrapper:get():isVested()
    local isPersonalTrade = itemWrapper:getStaticStatus():isPersonalTrade()
    if isVested and isPersonalTrade then
      return true
    end
  end
  local regionKey = selfPlayer:getRegionKey()
  local actionName = PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex]._actionName
  local isEnable
  if PaGlobal_Manufacture_All.MANUFACTURE_TYPE.REPAIRITEM == PaGlobal_Manufacture_All._actionIndex then
    isEnable = itemWrapper:checkToRepairItem()
  else
    isEnable = isManufactureItemInWareHouse(regionKey, slotNo, actionName)
  end
  return not isEnable
end
function PaGlobal_Manufacture_All_PushItemFromInventory(slotNo, itemWrapper, count, inventoryType)
  if isManufactureAction() and (0 == #PaGlobal_Manufacture_All._noneStackItemList or nil == #PaGlobal_Manufacture_All._noneStackItemList) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_DONT_CHANGE_ACTION"))
    return
  end
  local inventory = getSelfPlayer():get():getInventory()
  local invenSize = inventory:size()
  if PaGlobal_Manufacture_All._materialItemWhereType ~= Inventory_GetCurrentInventoryType() then
    PaGlobal_Manufacture_All._materialSlotNoList = {
      [0] = 255,
      255,
      255,
      255,
      255
    }
    PaGlobal_Manufacture_All._materialSlotNoListItemIn = {
      [0] = false,
      false,
      false,
      false,
      false
    }
  end
  for ii = 0, PaGlobal_Manufacture_All._usingSlotCount - 1 do
    if slotNo == PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      if true == PaGlobal_Manufacture_All._isConsole then
        HandleEventRUp_Manufacture_All_ClearMaterial(ii)
      end
      break
    end
    if PaGlobal_Manufacture_All._defaultSlotNo == PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      PaGlobal_Manufacture_All._materialSlotNoList[ii] = slotNo
      audioPostEvent_SystemUi(13, 8)
      break
    end
  end
  PaGlobal_Manufacture_All._materialItemWhereType = inventoryType
  if (0 == #PaGlobal_Manufacture_All._noneStackItemList or nil == #PaGlobal_Manufacture_All._noneStackItemList) and (true ~= PaGlobal_Manufacture_All._materialSlotNoListItemIn[0] or true ~= PaGlobal_Manufacture_All._materialSlotNoListItemIn[1] or true ~= PaGlobal_Manufacture_All._materialSlotNoListItemIn[2] or true ~= PaGlobal_Manufacture_All._materialSlotNoListItemIn[3]) then
    PaGlobal_Manufacture_All._noneStackItemList = Array.new()
    local selectedItemWrapper = getInventoryItemByType(inventoryType, slotNo)
    local selectedItemKey = selectedItemWrapper:get():getKey():getItemKey()
    local inventory = Inventory_GetCurrentInventory()
    local invenMaxSize = inventory:sizeXXX()
    for ii = 2, invenMaxSize - 1 do
      local itemWrapper = getInventoryItemByType(inventoryType, ii)
      if nil ~= itemWrapper then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        if selectedItemKey == itemKey and not selectedItemWrapper:getStaticStatus():isStackable() and not itemWrapper:isEnchanted() and slotNo ~= ii and false == ToClient_Inventory_CheckItemLock(ii, inventoryType) and false == PaGlobal_Manufacture_All:checkCrystal(itemWrapper) then
          PaGlobal_Manufacture_All._noneStackItemList:push_back(ii)
        end
      end
    end
    if 0 < #PaGlobal_Manufacture_All._noneStackItemList then
      if false == PaGlobal_Manufacture_All._isConsole then
        PaGlobal_Manufacture_All._ui.chk_identicalItem:SetCheck(false)
        PaGlobal_Manufacture_All._ui.chk_identicalItem:SetShow(true)
      else
        PaGlobal_Manufacture_All._canRepeat = true
      end
    end
  end
  PaGlobal_Manufacture_All:updateSlot()
end
function PaGlobal_Manufacture_All_PushItemFromWarehouse(slotNo, itemWrapper, count)
  if nil == slotNo then
    return
  end
  if isManufactureAction() and (0 == #PaGlobal_Manufacture_All._noneStackItemList or nil == #PaGlobal_Manufacture_All._noneStackItemList) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_DONT_CHANGE_ACTION"))
    return
  end
  for ii = 0, PaGlobal_Manufacture_All._usingSlotCount - 1 do
    if slotNo == PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      break
    end
    if PaGlobal_Manufacture_All._defaultSlotNo == PaGlobal_Manufacture_All._materialSlotNoList[ii] then
      PaGlobal_Manufacture_All._materialSlotNoList[ii] = slotNo
      audioPostEvent_SystemUi(13, 8)
      break
    end
  end
  PaGlobal_Manufacture_All:updateSlotWarehouse()
  PaGlobal_Manufacture_All:hasNoneStackItem(slotNo)
end
function PaGlobal_Manufacture_All_KnowledgeList_ControlCreate(content, key)
  local index = Int64toInt32(key)
  local button = UI.getChildControl(content, "RadioButton_KnowledgeList")
  button:setNotImpactScrollEvent(true)
  if index == PaGlobal_Manufacture_All._selectIndex then
    button:SetCheck(true)
  else
    button:SetCheck(false)
  end
  local mentalCardStaticWrapper = getAlchemyKnowledge(index)
  if nil ~= mentalCardStaticWrapper then
    local isLearn = isLearnMentalCardForAlchemy(mentalCardStaticWrapper:getKey())
    button:SetTextMode(__eTextMode_LimitText)
    if true == isLearn then
      button:SetFontColor(Defines.Color.C_FFF5BA3A)
      button:SetClickFontColor(Defines.Color.C_FFF5BA3A)
    else
      button:SetFontColor(Defines.Color.C_FF988D83)
      button:SetClickFontColor(Defines.Color.C_FF988D83)
    end
    button:SetText(mentalCardStaticWrapper:getName())
    if false == PaGlobal_Manufacture_All._isConsole then
      button:addInputEvent("Mouse_On", "HandleEventOnOut_Manufacture_All_KnowledgeListTooltip( true, " .. index .. " )")
      button:addInputEvent("Mouse_Out", "HandleEventOnOut_Manufacture_All_KnowledgeListTooltip( false )")
      button:addInputEvent("Mouse_LUp", "HandleEventLUp_Manufacture_All_SelectKnowledge(" .. index .. ")")
    else
      button:addInputEvent("Mouse_On", "HandleEventLUp_Manufacture_All_SelectKnowledgeAndTooltip(" .. tostring(button:IsLimitText()) .. "," .. index .. ")")
      button:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Manufacture_All_ViewKnowledge(" .. index .. ")")
      PaGlobal_Manufacture_All._ui.stc_iconX:SetShow(true)
    end
    button:SetShow(true)
  else
    button:SetShow(false)
  end
end
function PaGlobal_Manufacture_All_SetButtonEnable(control, isEnable, index)
  control:SetIgnore(false)
  control:SetEnable(true)
  if true == isEnable then
    control:addInputEvent("Mouse_LUp", "PaGlobal_Manufacture_All_SelectManufactureAction(" .. index .. ", true)")
    control:SetMonoTone(false)
    PaGlobal_Manufacture_All._listAction[index]._enable = true
  else
    control:addInputEvent("Mouse_LUp", "PaGlobal_Manufacture_All_SelectDisableManufactureAction(" .. index .. ")")
    control:SetMonoTone(true)
    PaGlobal_Manufacture_All._listAction[index]._enable = false
  end
end
function PaGlobal_Manufacture_All_UpdateVisibleRadioButton(installationType)
  if nil ~= installationType and CppEnums.InstallationType.TypeCount ~= installationType then
    local tempActionName = PaGlobal_Manufacture_All.INSTALLATIONTYPE_ACTIONNAME[installationType]
    for i = 0, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
      if tempActionName == PaGlobal_Manufacture_All._listAction[i]._actionName then
        local isVisible = isVisibleManufactureAction(PaGlobal_Manufacture_All._listAction[i]._actionName)
        PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetShow(isVisible)
      else
        PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetShow(false)
      end
    end
  else
    for i = 0, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
      local isVisible = isVisibleManufactureAction(PaGlobal_Manufacture_All._listAction[i]._actionName)
      PaGlobal_Manufacture_All._listAction[i]._radioBtn:SetShow(isVisible)
    end
  end
  local territorySupply = ToClient_IsContentsGroupOpen("22")
  if false == territorySupply then
    PaGlobal_Manufacture_All._listAction[10]._radioBtn:SetShow(false)
    PaGlobal_Manufacture_All._listAction[11]._radioBtn:SetShow(false)
  end
  if false == _ContentsGroup_GuildManufacture then
    PaGlobal_Manufacture_All._listAction[12]._radioBtn:SetShow(false)
  end
  local enableCraft = ToClient_IsContentsGroupOpen("285")
  if false == enableCraft then
    PaGlobal_Manufacture_All._listAction[13]._radioBtn:SetShow(false)
  end
  PaGlobal_Manufacture_All:updateTabButtonPos()
  local isNearAnvil = isNearInstallation(CppEnums.InstallationType.eType_Anvil)
  local isNearMortar = true
  local isNearStump = true
  local isNearFireBowl = true
  for i = 0, PaGlobal_Manufacture_All._manufactureMaxCount - 1 do
    if true == PaGlobal_Manufacture_All._listAction[i]._radioBtn:GetShow() then
      local isEnable = isEnableManufactureAction(PaGlobal_Manufacture_All._listAction[i]._actionName)
      if "MANUFACTURE_GRIND" == PaGlobal_Manufacture_All._listAction[i]._actionName then
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[i]._radioBtn, isEnable and isNearMortar, i)
        PaGlobal_Manufacture_All._isEnableBtn[i] = isEnable and isNearMortar and true or false
      elseif "MANUFACTURE_FIREWOOD" == PaGlobal_Manufacture_All._listAction[i]._actionName then
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[i]._radioBtn, isEnable and isNearStump, i)
        PaGlobal_Manufacture_All._isEnableBtn[i] = isEnable and isNearStump and true or false
      elseif "MANUFACTURE_HEAT" == PaGlobal_Manufacture_All._listAction[i]._actionName then
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[i]._radioBtn, isEnable and isNearFireBowl, i)
        PaGlobal_Manufacture_All._isEnableBtn[i] = isEnable and isNearFireBowl and true or false
      elseif "REPAIR_ITEM" == PaGlobal_Manufacture_All._listAction[i]._actionName then
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[i]._radioBtn, isEnable and isNearAnvil, i)
        PaGlobal_Manufacture_All._isEnableBtn[i] = isEnable and isNearAnvil and true or false
      else
        PaGlobal_Manufacture_All_SetButtonEnable(PaGlobal_Manufacture_All._listAction[i]._radioBtn, isEnable, i)
        PaGlobal_Manufacture_All._isEnableBtn[i] = true
      end
    end
  end
end
function PaGlobal_Manufacture_All_ManufactureReOpen()
  if _ContentsGroup_RenewUI_Manufacture then
    return
  end
  local _uiMode = GetUIMode()
  if nil ~= #PaGlobal_Manufacture_All._noneStackItemList and #PaGlobal_Manufacture_All._noneStackItemList > 0 and true == PaGlobal_Manufacture_All._noneStackItemCheck then
    return
  end
  if _uiMode == Defines.UIMode.eUIMode_Default then
    PaGlobalFunc_Manufacture_All_Open(nil, PaGlobal_Manufacture_All._materialItemWhereType, true)
  end
end
function PaGlobal_Manufacture_All_UpdateRepairTime()
  local repairTime = repair_getRepairTime(PaGlobal_Manufacture_All._materialSlotNoList[0])
  if repairTime > toUint64(0, 0) then
    local tempString = PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_REPAIR_TOTAL_TIME") .. " : " .. convertStringFromMillisecondtime(repairTime)
    PaGlobal_Manufacture_All._ui.txt_manufactureName:SetText(tempString)
  end
end
function PaGlobal_Manufacture_All_GetNextNoneStackItemSlotNo_ByWarehouse()
  local warehouseWrapper = warehouse_get(PaGlobal_Manufacture_All._waypointKey_ByWareHouse)
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  for ii = 1, useMaxCount - 1 do
    local itemWrapper = warehouseWrapper:getItem(ii)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      if PaGlobal_Manufacture_All._selectedWarehouseItemKey == itemKey then
        PaGlobal_Manufacture_All._targetWarehouseSlotNo = ii
        PaGlobal_Manufacture_All._hasNoneStackItem = true
        break
      end
    end
  end
  return PaGlobal_Manufacture_All._hasNoneStackItem
end
function PaGlobal_Manufacture_All_GetCurrentManufactureName()
  if nil == PaGlobal_Manufacture_All._actionIndex then
    return nil
  end
  return PaGlobal_Manufacture_All.MANUFACTURE_INFO[PaGlobal_Manufacture_All._actionIndex].name
end
function PaGlobal_Manufacture_All_GetCurrentMaterialWhereType()
  return PaGlobal_Manufacture_All._materialItemWhereType
end
function PaGlobal_Manufacture_All_GetCurrentWayPointKey()
  return PaGlobal_Manufacture_All._waypointKey_ByWareHouse
end
function PaGlobal_Manufacture_All_CheckManufactureFailCount(currentFailCount)
  local defaultFailCount = 30
  if false == PaGlobal_Manufacture_All._isMassManufacture or PaGlobal_Manufacture_All._actionIndex < 0 then
    if currentFailCount > defaultFailCount then
      return true
    else
      return false
    end
  else
    return ToClient_CheckIsManufactureFail(PaGlobal_Manufacture_All._actionIndex + 1, defaultFailCount, currentFailCount)
  end
end
function PaGlobal_Manufacture_All_RepeatManufacture()
  if -1 == PaGlobal_Manufacture_All._actionIndex then
    return
  end
  PaGlobal_Manufacture_All_SelectManufactureAction(PaGlobal_Manufacture_All._actionIndex, true, nil, true)
end
function PaGlobal_Manufacture_All_ContinueGrindJewel()
  if CppEnums.ItemWhereType.eInventory == PaGlobal_Manufacture_All._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == PaGlobal_Manufacture_All._materialItemWhereType then
    if nil ~= #PaGlobal_Manufacture_All._noneStackItemList and #PaGlobal_Manufacture_All._noneStackItemList > 0 and true == PaGlobal_Manufacture_All._noneStackItemCheck then
      PaGlobal_Manufacture_All_RepeatManufacture()
      local nextSlotNo = PaGlobal_Manufacture_All._noneStackItemList[1]
      local itemWrapper = getInventoryItemByType(PaGlobal_Manufacture_All._materialItemWhereType, nextSlotNo)
      if nil == itemWrapper then
        return
      end
      local selectedItemKey = itemWrapper:get():getKey():getItemKey()
      if nil ~= PaGlobal_Manufacture_All._currentRepeatItemKey and PaGlobal_Manufacture_All._currentRepeatItemKey ~= selectedItemKey then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NOMATERIAL"))
        PaGlobal_Manufacture_All._currentRepeatItemKey = nil
        return
      end
      local itemCount = itemWrapper:get():getCount_s64()
      PaGlobal_Manufacture_All_PushItemFromInventory(nextSlotNo, itemWrapper, itemCount, PaGlobal_Manufacture_All._materialItemWhereType)
      HandleEventLUp_Manufacture_All_StartManufacture()
      PaGlobal_Manufacture_All._noneStackItemList:pop_front()
    end
  else
    local hasNext = PaGlobal_Manufacture_All_GetNextNoneStackItemSlotNo_ByWarehouse()
    if true == hasNext and true == PaGlobal_Manufacture_All._hasNoneStackItem and true == PaGlobal_Manufacture_All._noneStackItemCheck then
      local warehouseWrapper = warehouse_get(PaGlobal_Manufacture_All._waypointKey_ByWareHouse)
      if nil == warehouseWrapper then
        return
      end
      local itemWrapper = warehouseWrapper:getItem(PaGlobal_Manufacture_All._targetWarehouseSlotNo)
      if nil == itemWrapper then
        return
      end
      local selectedItemKey = itemWrapper:get():getKey():getItemKey()
      if nil ~= PaGlobal_Manufacture_All._currentRepeatItemKey and PaGlobal_Manufacture_All._currentRepeatItemKey ~= selectedItemKey then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NOMATERIAL"))
        PaGlobal_Manufacture_All._currentRepeatItemKey = nil
        return
      end
      PaGlobal_Manufacture_All_RepeatManufacture()
      PaGlobal_Manufacture_All_PushItemFromWarehouse(PaGlobal_Manufacture_All._targetWarehouseSlotNo, itemWrapper, 1)
      HandleEventLUp_Manufacture_All_StartManufacture()
    end
  end
end
function PaGlobal_Manufacture_All_ResultGrindJewel()
  if CppEnums.ItemWhereType.eInventory == PaGlobal_Manufacture_All._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == PaGlobal_Manufacture_All._materialItemWhereType then
    if nil ~= #PaGlobal_Manufacture_All._noneStackItemList and #PaGlobal_Manufacture_All._noneStackItemList > 0 and true == PaGlobal_Manufacture_All._noneStackItemCheck then
      StopManufactureAction()
      luaTimer_AddEvent(PaGlobal_Manufacture_All_ContinueGrindJewel, 500, false, 0)
    else
      if PaGlobal_Manufacture_All._noneStackItemCheck then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_COMPLETE_REPEAT"))
      end
      PaGlobal_Manufacture_All:resetGrindJewelSetting()
      PaGlobal_Manufacture_All._currentRepeatItemKey = nil
    end
    PaGlobalFunc_Manufacture_Notify_All_Progress_Update(PaGlobal_Manufacture_All._materialItemWhereType)
  else
    if true == PaGlobal_Manufacture_All._hasNoneStackItem then
      StopManufactureAction()
      luaTimer_AddEvent(PaGlobal_Manufacture_All_ContinueGrindJewel, 500, false, 0)
    else
      if PaGlobal_Manufacture_All._noneStackItemCheck then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_COMPLETE_REPEAT"))
      end
      PaGlobal_Manufacture_All:resetGrindJewelSetting()
      PaGlobal_Manufacture_All._currentRepeatItemKey = nil
    end
    PaGlobalFunc_Manufacture_Notify_All_Progress_Update(PaGlobal_Manufacture_All._materialItemWhereType)
  end
end
function PaGlobal_Manufacture_All_OpenFromWareHouseSetPos()
  Panel_Window_Manufacture_All:SetPosX((getOriginScreenSizeX() - Panel_Window_Manufacture_All:GetSizeX()) * 0.5)
  Panel_Window_Manufacture_All:SetPosY(Panel_Window_Warehouse:GetPosY())
end
function PaGlobal_Manufacture_All_ViewKnowledge(index)
  local knowledge = getAlchemyKnowledge(index)
  if knowledge then
    PaGlobalFunc_AlchemyKnowledgeOpen(knowledge)
  end
end
function PaGlobalFunc_Manufacture_All_SetFromWareHouse()
  PaGlobal_Manufacture_All._isFromWarehouse = true
end
function PaGlobal_Manufacture_All_InventoryYFunc()
  if PaGlobalFunc_InventoryInfo_GetShow() then
    Inventory_SetFunctor(nil, nil, nil, nil)
    InventoryWindow_Close()
    HandleEventLUp_Manufacture_All_RepeatAction(false)
  end
end
function PaGlobal_Manufacture_All_InventoryOpen()
  if true == PaGlobal_Manufacture_All._isFromWarehouse then
    if true == _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_SetFunctor(PaGlobal_Manufacture_All_WarehouseFilter, PaGlobal_Manufacture_All_PushItemFromWarehouse)
      PaGlobal_Warehouse_All_UpdateSlotData()
      PaGlobal_Warehouse_All_OpenPanelFromManufacture()
    else
      Warehouse_SetFunctor(PaGlobal_Manufacture_All_WarehouseFilter, PaGlobal_Manufacture_All_PushItemFromWarehouse)
      Warehouse_updateSlotData()
      Warehouse_OpenPanelFromManufacture()
    end
  else
    InventoryWindow_Show()
    Inventory_SetFunctor(PaGlobal_Manufacture_All_InvenFiler, PaGlobal_Manufacture_All_PushItemFromInventory, nil, nil, {func = PaGlobal_Manufacture_All_InventoryYFunc})
    Inventory_updateSlotData()
  end
end
function PaGlobal_Manufacture_All_ManufactureBack()
  local useSlotCount = PaGlobal_Manufacture_All:getInsertedMaterialCount()
  if 0 < useSlotCount then
    HandleEventRUp_Manufacture_All_ClearMaterial(useSlotCount - 1)
    return
  end
  if PaGlobalFunc_InventoryInfo_GetShow() then
    InventoryWindow_Close()
    return
  end
  if true == _ContentsGroup_NewUI_WareHouse_All then
    if true == PaGlobal_WareHouse_All_GetShow() then
      PaGlobal_Warehouse_All_Close()
      return
    end
  elseif true == PaGlobalFunc_Warehouse_GetShow() then
    Warehouse_Close()
    return
  end
  PaGlobalFunc_Manufacture_All_Close()
end
