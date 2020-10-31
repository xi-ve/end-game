function PaGlobalFunc_Alchemy_All_Open(isCook, installationType)
  if nil == Panel_Window_Alchemy_All then
    return
  end
  PaGlobal_Alchemy_All:prepareOpen(isCook, installationType)
end
function PaGlobalFunc_Alchemy_All_Close()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  PaGlobal_Alchemy_All:prepareClose()
end
function PaGlobal_Alchemy_All_AlchemyBack()
  local countSlotPushed = ToClient_AlchemyGetCountSlotWithMaterial()
  if 0 < countSlotPushed then
    HandleEventRUp_Alchemy_All_PopMaterial(countSlotPushed)
    return
  end
  if PaGlobalFunc_InventoryInfo_GetShow() then
    InventoryWindow_Close()
    if true == PaGlobal_Alchemy_All._isConsole then
      PaGlobal_Alchemy_All._ui.stc_iconA:SetShow(true)
      PaGlobal_Alchemy_All:setAlignKeyGuide()
    end
    return
  end
  PaGlobalFunc_Alchemy_All_Close()
end
function PaGlobalFunc_Alchemy_All_ShowAni()
  UIAni.showAniScaleElastic(Panel_Window_Alchemy_All, {})
end
function PaGlobalFunc_Alchemy_All_HideAni()
  UIAni.closeAni(Panel_Window_Alchemy_All)
end
function PaGlobal_Alchemy_All_CreateKnowledgeListContent(content, key)
  local knowledgeIndex = Int64toInt32(key)
  local button = UI.getChildControl(content, "RadioButton_KnowledgeList")
  button:setNotImpactScrollEvent(true)
  if knowledgeIndex == PaGlobal_Alchemy_All._selectedKnowledge then
    button:SetCheck(true)
  else
    button:SetCheck(false)
  end
  local mentalCardStaticWrapper = ToClient_AlchemyGetKnowledge(knowledgeIndex)
  if nil ~= mentalCardStaticWrapper then
    local isLearn = ToClient_AlchemyIsLearntMentalCard(mentalCardStaticWrapper:getKey())
    button:SetTextMode(__eTextMode_LimitText)
    if true == isLearn then
      button:SetFontColor(Defines.Color.C_FFF5BA3A)
      button:SetClickFontColor(Defines.Color.C_FFF5BA3A)
    else
      button:SetFontColor(Defines.Color.C_FF988D83)
      button:SetClickFontColor(Defines.Color.C_FF988D83)
    end
    button:SetText(mentalCardStaticWrapper:getName())
    if false == PaGlobal_Alchemy_All._isConsole then
      button:addInputEvent("Mouse_On", "HandleEventOnOut_Alchemy_All_KnowledgeListTooltip(true," .. knowledgeIndex .. ")")
      button:addInputEvent("Mouse_Out", "HandleEventOnOut_Alchemy_All_KnowledgeListTooltip(false)")
      button:addInputEvent("Mouse_LUp", "PaGlobal_Alchemy_All_SelectKnowledge( " .. knowledgeIndex .. " )")
    else
      button:addInputEvent("Mouse_On", "HandleEventLUp_Alchemy_All_SelectKnowledgeAndTooltip(" .. tostring(button:IsLimitText()) .. "," .. knowledgeIndex .. ")")
      button:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Alchemy_All_ViewKnowledge(" .. knowledgeIndex .. ")")
      PaGlobal_Alchemy_All._ui.stc_iconX:SetShow(true)
    end
    button:SetShow(true)
  else
    button:SetShow(false)
  end
end
function PaGlobal_Alchemy_All_SelectKnowledge(knowledgeIndex)
  local mentalCardStaticWrapper = ToClient_AlchemyGetKnowledge(knowledgeIndex)
  if nil ~= mentalCardStaticWrapper then
    if false == PaGlobal_Alchemy_All._isConsole then
      PaGlobal_RecentCook:closePanel()
      local isLearn = ToClient_AlchemyIsLearntMentalCard(mentalCardStaticWrapper:getKey())
      if true == isLearn then
        PaGlobal_RecentCook:showPanel(knowledgeIndex, PaGlobal_Alchemy_All._isCook, Panel_Window_Alchemy_All:GetPosX() + Panel_Window_Alchemy_All:GetSizeX() + 5, Panel_Window_Alchemy_All:GetPosY() + 50)
      end
    end
    PaGlobal_Alchemy_All:setKnowledgeDescriptionText(mentalCardStaticWrapper:getDesc())
  end
  local prevKnowledge = PaGlobal_Alchemy_All._selectedKnowledge
  PaGlobal_Alchemy_All._selectedKnowledge = knowledgeIndex
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:requestUpdateByKey(toInt64(0, prevKnowledge))
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:requestUpdateByKey(toInt64(0, knowledgeIndex))
end
function PaGlobal_Alchemy_All_ViewKnowledge(index)
  local knowledge = ToClient_AlchemyGetKnowledge(index)
  if knowledge then
    PaGlobalFunc_AlchemyKnowledgeOpen(knowledge)
  end
end
function PaGlobal_Alchemy_All_DoAlchemy()
  if false == checkAlchemyAction() then
    return
  end
  ToClient_AlchemyDo()
end
function PaGlobal_Alchemy_All_StartAlchemyForConsole()
  if ToClient_AlchemyGetCountSlotWithMaterial() <= 0 then
    return
  end
  if ToClient_AlchemyGetMaxMassProductionCount() < Defines.s64_const.s64_1 then
    return
  end
  local repeatSelect = function(selectedButtonIndex)
    if 1 == selectedButtonIndex then
      PaGlobal_Alchemy_All_StartAlchemy(Defines.s64_const.s64_1)
    elseif 2 == selectedButtonIndex then
      PaGlobal_Alchemy_All_StartMassProduction()
    end
  end
  local msgBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, PaGlobal_Alchemy_All._isCook and "LUA_ALCHEMY_COOKING" or "LUA_ALCHEMY_ALCHEMY"),
    content = PAGetString(Defines.StringSheet_GAME, PaGlobal_Alchemy_All._isCook and "LUA_ALCHEMY_ASK_MULTIPLE_TIMES_COOK" or "LUA_ALCHEMY_ASK_MULTIPLE_TIMES"),
    functionYes = repeatSelect,
    functionNo = MessageBox_Empty_function,
    buttonStrings = {
      PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_BUTTON_TEXT_ONE_TIME"),
      PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_BUTTON_TEXT_MULTIPLE_TIMES")
    },
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBox(msgBoxData, "middle")
end
function PaGlobal_Alchemy_All_StartAlchemy(countProduction)
  if ToClient_AlchemyGetCountSlotWithMaterial() <= 0 then
    return
  end
  if countProduction > Defines.s64_const.s64_1 and false == ToClient_AlchemySetupMaterialsForMassProduction(countProduction) then
    _PA_ASSERT(false, "setupMaterialsForMassProduction\236\157\180 \236\139\164\237\140\168\237\150\136\236\138\181\235\139\136\235\139\164. countProduction\236\157\180 ToClient_AlchemyGetMaxMassProductionCount()\235\179\180\235\139\164 \237\129\176 \234\178\131\236\157\128 \236\149\132\235\139\140\236\167\128 \237\153\149\236\157\184\237\149\180\235\179\180\236\139\156\234\184\176 \235\176\148\235\158\141\235\139\136\235\139\164.")
  end
  ToClient_AlchemyStart(PaGlobal_Alchemy_All._isCook, countProduction)
  local progressBarTimeSec = ToClient_AlchemyGetAlchemyTime(PaGlobal_Alchemy_All._isCook) / 1000
  if 0 == progressBarTimeSec then
    return
  end
  EventProgressBarShow(true, progressBarTimeSec, true == PaGlobal_Alchemy_All._isCook and 7 or 9)
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  PaGlobalFunc_Alchemy_All_Close()
end
function PaGlobal_Alchemy_All_StartMassProduction()
  local msgBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local msgBoxContentStrID = "LUA_ALCHEMY_MSGBOX_COOK_SEQUENCE_MSG"
  if false == PaGlobal_Alchemy_All._isCook then
    msgBoxContentStrID = "LUA_ALCHEMY_MSGBOX_ALCHEMY_SEQUENCE_MSG"
  end
  local msgBoxData = {
    title = msgBoxTitle,
    content = PAGetString(Defines.StringSheet_GAME, msgBoxContentStrID),
    functionYes = PaGlobal_Alchemy_All_AskMassProductionQuantity,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(msgBoxData, "middle")
end
function PaGlobal_Alchemy_All_AskMassProductionQuantity()
  local countSlotPushed = ToClient_AlchemyGetCountSlotWithMaterial()
  if countSlotPushed <= 0 then
    return
  end
  local maxCount = ToClient_AlchemyGetMaxMassProductionCount()
  if maxCount >= Defines.s64_const.s64_1 then
    local funcConfirmClicked = function(inputNumber)
      PaGlobal_Alchemy_All_StartAlchemy(inputNumber)
    end
    Panel_NumberPad_Show(true, maxCount, nil, funcConfirmClicked)
    if true == PaGlobal_Alchemy_All._isConsole then
      Panel_Window_NumberPad_All:SetPosX((getOriginScreenSizeX() - Panel_Window_NumberPad_All:GetSizeX()) / 2)
      Panel_Window_NumberPad_All:SetPosY((getOriginScreenSizeY() - Panel_Window_NumberPad_All:GetSizeY()) / 2)
    end
  end
end
function PaGlobal_Alchemy_All_ResumeMassProduction()
  local countDoingAlchemy = ToClient_AlchemyGetDoingAlchemyCount()
  PaGlobal_Alchemy_All_StartAlchemy(countDoingAlchemy)
end
function PaGlobal_Alchemy_All_UpdateMaterialSlot()
  PaGlobal_Alchemy_All:updateMaterialSlot()
end
function PaGlobal_Alchemy_All_InventoryFilterFunction(slotNo, itemWrapper, whereType)
  if CppEnums.ItemWhereType.eInventory ~= whereType then
    return true
  end
  local isTradable = itemWrapper:getStaticStatus():isPersonalTrade()
  local isVested = itemWrapper:get():isVested()
  if isTradable and isVested then
    return true
  end
  if true == itemWrapper:get():isSeized() then
    return true
  end
  local itemType = itemWrapper:getStaticStatus():getItemType()
  if nil ~= PaGlobal_Alchemy_All._invenFilterItemTypes[itemType] then
    return true
  end
  local isCash = itemWrapper:getStaticStatus():get():isCash()
  if isCash then
    return true
  end
  return false
end
function PaGlobal_Alchemy_All_InventoryRClickFunction(slotIdx, itemWrapper, count)
  PaGlobal_Alchemy_All:showInventoryNumpad(slotIdx, count)
end
function PaGlobal_Alchemy_All_InventoryYFunc()
  if PaGlobalFunc_InventoryInfo_GetShow() then
    InventoryWindow_Close()
    if true == PaGlobal_Alchemy_All._isConsole then
      PaGlobal_Alchemy_All._ui.stc_iconA:SetShow(true)
      PaGlobal_Alchemy_All:setAlignKeyGuide()
    end
    return true
  end
end
function PaGlobal_Alchemy_All_NumberPadConfirmClicked(count, slotIdx)
  PaGlobal_Alchemy_All:pushItemFromInventory(count, slotIdx)
end
function PaGlobal_Alchemy_All_ClearEditBoxSearchText()
  PaGlobal_Alchemy_All._ui.edit_searchBox:SetEditText("", false)
end
function PaGlobal_Alchemy_All_ClearEditFocus()
  PaGlobal_Alchemy_All:clearFocusEdit()
  PaGlobal_Alchemy_All_ClearEditBoxSearchText()
end
function PaGlobal_Alchemy_All_SetSearchFocus()
  PaGlobal_Alchemy_All_ClearEditFocus()
  SetFocusEdit(PaGlobal_Alchemy_All._ui.edit_searchBox)
end
function PaGlobal_Alchemy_All_CheckEditBox(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Alchemy_All._ui.edit_searchBox:GetKey()
end
function PaGlobal_Alchemy_All_InventoryOpen()
  Inventory_SetFunctor(PaGlobal_Alchemy_All_InventoryFilterFunction, PaGlobal_Alchemy_All_InventoryRClickFunction, nil, nil, {func = PaGlobal_Alchemy_All_InventoryYFunc})
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
  else
    FGlobal_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
  end
  InventoryWindow_Show()
  Inventory_updateSlotData()
  if true == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.stc_iconA:SetShow(false)
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  end
end
function PaGlobal_Alchemy_All_ChangeMaterialCount(materialIndex, count)
  local countSlotPushed = ToClient_AlchemyGetCountSlotWithMaterial()
  if materialIndex > countSlotPushed then
    return
  end
  local slotNo = ToClient_AlchemyGetMaterialSlotNoByIndex(materialIndex - 1)
  ToClient_AlchemyPushItemFromInventory(slotNo, count)
  PaGlobal_Alchemy_All:updateMaterialSlot()
end
function PaGlobal_Alchemy_All_SearchKnowledge(str)
  PaGlobal_Alchemy_All._ui.edit_searchBox:SetEditText(str)
  ClearFocusEdit()
  HandleEventLUp_Alchemy_All_SearchButton()
end
function FromClient_Alchemy_All_ResponseShowAlchemy(isCook, installationType)
  PaGlobalFunc_Alchemy_All_Open(isCook, installationType)
end
function FromClient_Alchemy_All_AlchemyFailAck(isSuccess, hint, alchemyType, strErr, bDoingMassProduction)
  local isCook = 1 == alchemyType
  if true == isSuccess then
    Proc_ShowMessage_Ack(strErr)
  elseif 1 == hint or 2 == hint or 3 == hint then
    local msg = {
      main = PAGetString(Defines.StringSheet_GAME, "ALCHEMYFAIL_REASON_" .. hint),
      sub = ""
    }
    local msgType = isCook and 27 or 26
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, msgType)
    if true == bDoingMassProduction then
      local failMsg = ""
      if isCook then
        failMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_COOKING")
      else
        failMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ALCHEMY")
      end
      local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMY_MSGBOX_FAIL_MEMO", "failMsg", failMsg)
      local funcYesButtonClicked = function()
        PaGlobal_Alchemy_All_ResumeMassProduction()
      end
      local funcNoButtonClicked = function()
        PaGlobal_Alchemy_All:cancelAlchemy()
      end
      local messageBoxData = {
        title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMY_MSGBOX_FAIL_TITLE", "failMsg", failMsg),
        content = messageBoxMemo,
        functionYes = funcYesButtonClicked,
        functionNo = funcNoButtonClicked,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  else
    Proc_ShowMessage_Ack(strErr)
    PaGlobal_Alchemy_All:cancelAlchemy()
  end
end
function HandleEventOnOut_Alchemy_All_ShowMaterialTooltip(isShow, slotIndex)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemStatic = ToClient_AlchemyGetItemStaticAtMaterialSlot(slotIndex - 1)
  if nil == itemStatic then
    return
  end
  local uiBase = PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex].icon
  Panel_Tooltip_Item_Show(itemStatic, uiBase, true, false)
end
function HandleEventOnOut_Alchemy_All_KnowledgeListTooltip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local mentalCardStaticWrapper = ToClient_AlchemyGetKnowledge(index)
  if nil ~= mentalCardStaticWrapper then
    local name = mentalCardStaticWrapper:getName()
    local desc = mentalCardStaticWrapper:getKeyword()
    TooltipSimple_Show(Panel_Window_Manufacture_All, name, desc)
  end
end
function HandleEventOnOut_Alchemy_All_MaterialSlotFocus(focused, index)
  if true == focused then
    PaGlobal_Alchemy_All._focusedMaterialSlotIndex = index
  else
    PaGlobal_Alchemy_All._focusedMaterialSlotIndex = 0
  end
  PaGlobal_Alchemy_All:updateMaterialSlot()
  if true == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.stc_iconX:SetShow(false)
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  end
end
function HandleEventRUp_Alchemy_All_PopMaterial(slotIndex)
  ToClient_AlchemyPopMaterial(slotIndex - 1)
  PaGlobal_Alchemy_All:updateMaterialSlot()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_Alchemy_All_CheckKnownRecipeOnly()
  PaGlobal_Alchemy_All:updateKnowledgeList()
end
function HandleEventLUp_Alchemy_All_CheckKnownRecipeOnlyForPad()
  local checked = PaGlobal_Alchemy_All._ui.chk_knownRecipe:IsCheck()
  PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(not checked)
  PaGlobal_Alchemy_All:updateKnowledgeList()
end
function HandleEventLUp_Alchemy_All_SearchButton()
  PaGlobal_Alchemy_All:clearFocusEdit()
  local filterText = PaGlobal_Alchemy_All._ui.edit_searchBox:GetEditText()
  if filterText == PaGlobal_Alchemy_All._filterText then
    return
  end
  PaGlobal_Alchemy_All._filterText = filterText
  if nil ~= PaGlobal_Alchemy_All._filterText and 0 == string.len(PaGlobal_Alchemy_All._filterText) then
    PaGlobal_Alchemy_All._filterText = nil
  end
  local isOnlyName = true
  ToClient_AlchemySetKnowledgeFilter(true, isOnlyName, PaGlobal_Alchemy_All._filterText)
  PaGlobal_Alchemy_All:updateKnowledgeList()
end
function HandleEventLUp_Alchemy_All_SelectKnowledgeAndTooltip(isShow, index)
  PaGlobal_Alchemy_All_SelectKnowledge(index)
  HandleEventOnOut_Alchemy_All_KnowledgeListTooltip(isShow, index)
  if true == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.stc_iconX:SetShow(true)
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  end
end
