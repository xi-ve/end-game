function PaGlobalFunc_DialogExchange_All_Open()
  PaGlobal_DialogExchange_All:prepareOpen()
end
function PaGlobalFunc_DialogExchange_All_Close(showAni)
  PaGlobal_DialogExchange_All:prepareClose(showAni)
end
function PaGlobalFunc_DialogExchange_All_ShowAni()
  local moveAni = Panel_Dialog_Exchange_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local uiOffsetX = 0
  if true == PaGlobal_DialogExchange_All._isConsole then
    uiOffsetX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  end
  moveAni:SetStartPosition(getScreenSizeX(), Panel_Dialog_Exchange_All:GetPosY())
  moveAni:SetEndPosition(getScreenSizeX() - Panel_Dialog_Exchange_All:GetSizeX() - 20 + uiOffsetX, Panel_Dialog_Exchange_All:GetPosY())
  moveAni.IsChangeChild = true
  if true == PaGlobal_DialogList_All._isConsole then
    Panel_Dialog_Exchange_All:SetPosX(getScreenSizeX())
  end
end
function PaGlobalFunc_DialogExchange_All_HideAni()
  local moveAni = Panel_Dialog_Exchange_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(Panel_Dialog_Exchange_All:GetPosX(), Panel_Dialog_Exchange_All:GetPosY())
  moveAni:SetEndPosition(getScreenSizeX(), Panel_Dialog_Exchange_All:GetPosY())
  moveAni.IsChangeChild = true
  moveAni:SetHideAtEnd(true)
end
function HandleEventLUp_ExchangeList_All_ClickButton(index)
  if nil ~= Panel_Window_MessageBox_All and true == Panel_Window_MessageBox_All:GetShow() then
    return
  end
  local procMessagePosX = (getOriginScreenSizeX() - Panel_NakMessage:GetSizeX()) * 0.5
  local procMessagePosY = getOriginScreenSizeY() / 4
  local function clickDialogButtonReq()
    audioPostEvent_SystemUi(0, 17)
    local displayData = Dialog_getButtonDisplayData(index)
    local questInfo = questList_isClearQuest(1038, 2)
    if displayData:empty() and false == PaGlobal_DialogExchange_All._isExchange then
      PaGlobal_DialogExchange_All._isExchange = true
      Dialog_clickDialogButtonReq(index)
    else
      PaGlobal_Dialogue_Itemtake_All_SelectedIndex(index)
      PaGlobal_Dialogue_Itemtake_All_Open(displayData)
    end
  end
  PaGlobalFunc_DialogKeyManager_All_SetClear(false, false, false, true)
  PaGlobalFunc_DialogKeyManager_All_MClickExchangelist(index)
  local dialogData = ToClient_GetCurrentDialogData()
  local dialogButton = dialogData:getDialogButtonAt(index)
  if false == dialogButton._enable or false == dialogButton._invenPushable or false == dialogButton:checkConditions() then
    return
  end
  if true == PaGlobal_DialogExchange_All:expirationItemCheck(dialogButton:getNeedItemKey()) then
    local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
    local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_EXPIRATIONCHECK")
    local messageboxData = {
      title = msgTitle,
      content = msgContent,
      functionYes = clickDialogButtonReq,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif true == ToClient_isAnyLockedItem(ItemEnchantKey(dialogButton:getNeedItemKey())) then
    local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
    local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_ITEMLOCKED")
    local messageboxData = {
      title = msgTitle,
      content = msgContent,
      functionYes = clickDialogButtonReq,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif true == PaGlobal_DialogExchange_All:sealedItemCheck(dialogButton:getNeedItemKey()) then
    local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
    local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_SEALEDCHECK")
    local messageboxData = {
      title = msgTitle,
      content = msgContent,
      functionYes = clickDialogButtonReq,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if _ContentsGroup_RenewUI then
      MessageBox.showMessageBox(messageboxData)
    else
      MessageBox.showMessageBox(messageboxData, nil, nil, false)
    end
  else
    do
      local needItemCount = dialogButton:getNeedItemCount()
      local resultItemName = ""
      local beforeItemName = ""
      local applyColorBeforeItemName = ""
      local applyColorAfterItemName = ""
      if (CppEnums.DialogButtonType.eDialogButton_Exchange == dialogButton._dialogButtonType or CppEnums.DialogButtonType.eDialogButton_ExceptExchange == dialogButton._dialogButtonType) and 0 < needItemCount then
        do
          local resultItemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(dialogButton:getResultItemKeyRaw()))
          if nil == resultItemWrapper then
            resultItemName = dialogButton:getText()
            applyColorAfterItemName = "<PAColor0xFF96D4FC>" .. resultItemName .. "<PAOldColor>"
          else
            resultItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(resultItemWrapper:getName(), resultItemWrapper)
            applyColorAfterItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(resultItemName, resultItemWrapper)
          end
          local itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(dialogButton:getNeedItemKey()))
          if nil ~= itemStaticWrapper then
            beforeItemName = itemStaticWrapper:getName()
            applyColorBeforeItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(beforeItemName, itemStaticWrapper)
            local itemCount = PaGlobal_DialogExchange_All:enchangeItemHaveCount(dialogButton:getNeedItemKey())
            local max_exchangeCount = math.floor(itemCount / needItemCount)
            local function ExchangeMessageBox(inputNum)
              local _exchangeCount = Int64toInt32(inputNum)
              local function doExchange()
                dialogData:setExchangeCount(_exchangeCount)
                clickDialogButtonReq()
                if nil == resultItemWrapper then
                  PaGlobalFunc_DialogExchange_All_SetResultItemMessage(_exchangeCount, nil)
                else
                  PaGlobalFunc_DialogExchange_All_SetResultItemMessage(_exchangeCount, resultItemName)
                end
              end
              local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
              local msgContent = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_CONFIRM", "beforeName", applyColorBeforeItemName, "beforeCount", _exchangeCount * needItemCount, "afterName", applyColorAfterItemName, "afterCount", _exchangeCount)
              local messageBoxData = {
                title = msgTitle,
                content = msgContent,
                functionYes = doExchange,
                functionNo = MessageBox_Empty_function,
                priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
              }
              MessageBox.showMessageBox(messageBoxData, "middle")
            end
            if true == dialogButton._isValidMultipleExchange then
              Panel_NumberPad_Show(true, toInt64(0, max_exchangeCount), 0, ExchangeMessageBox)
              return
            end
            if CppEnums.DialogButtonType.eDialogButton_ExceptExchange == dialogButton._dialogButtonType then
              ExchangeMessageBox(1)
              return
            end
          end
        end
      end
      local resultItemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(dialogButton:getResultItemKeyRaw()))
      if nil == resultItemWrapper then
        PaGlobalFunc_DialogExchange_All_SetResultItemMessage(nil, nil)
      else
        PaGlobalFunc_DialogExchange_All_SetResultItemMessage(nil, resultItemName)
      end
      clickDialogButtonReq()
    end
  end
end
function HandleEventOnOut_ExchangeList_All_ItemTooltipNormalNpc(itemKey, isShow)
  if nil == isShow or false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, Panel_Dialog_Exchange_All, true, false, nil)
end
function HandleEventOnOut_ExchangeList_All_SimpleTooltip(isShow, typeNum, index)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local key = toInt64(0, index + 1)
  local content = PaGlobal_DialogExchange_All._ui.list2_exchange:GetContentByKey(key)
  if nil == content then
    return
  end
  local control, name, desc = nil, "", ""
  if 1 == typeNum then
    control = UI.getChildControl(content, "StaticText_BeforeTemplete")
  elseif 2 == typeNum then
    control = UI.getChildControl(content, "StaticText_AfterTemplete")
  elseif 3 == typeNum then
    control = UI.getChildControl(content, "StaticText_CountTemplete")
  end
  if nil == control then
    return
  end
  name = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function FromClient_DialogFunctionExchange_Response()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if false == Panel_Dialog_Exchange_All:GetShow() then
    return
  end
  PaGlobalFunc_DialogExchange_All_ShowResultItemMessage()
  local exchangeIndex
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local exchangeBtnCount = dialogData:getDialogButtonCount()
  if exchangeBtnCount <= 0 then
    return
  end
  local funcBtnCount = dialogData:getFuncButtonCount()
  if funcBtnCount <= 0 then
    return
  end
  local funcButton, funcButtonType
  for index = 0, funcBtnCount - 1 do
    funcButton = dialogData:getFuncButtonAt(index)
    if nil == funcButton then
      return
    end
    funcButtonType = tonumber(funcButton._param)
    if CppEnums.ContentsType.Contents_Exchange == funcButtonType then
      exchangeIndex = index
      break
    end
  end
  if nil == exchangeIndex then
    return
  end
  ToClient_ReFreshDialogByType(tonumber(CppEnums.DialogState.eDialogState_Exchange))
  PaGlobal_DialogExchange_All:update()
end
function FromClient_DialogFunctionExchange_ResponseInventory()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if false == Panel_Dialog_Exchange_All:GetShow() then
    return
  end
  FromClient_DialogFunctionExchange_Response()
end
function PaGlobalFunc_ExchangeList_All_UpdateNormalNPCButtonlist(control, key)
  PaGlobal_DialogExchange_All:dialogNormalNpcControlSet(control, key)
end
function PaGlobalFunc_ExchangeList_All_IsExchangeClick()
  if nil == Panel_Dialog_Exchange_All then
    return false
  end
  return PaGlobal_DialogExchange_All._isExchange
end
function PaGlobalFunc_DialogExchange_All_SetResultItemMessage(exchangeCount, resultItemName)
  PaGlobal_DialogExchange_All._resultItemMsg.count = exchangeCount
  PaGlobal_DialogExchange_All._resultItemMsg.name = resultItemName
end
function PaGlobalFunc_DialogExchange_All_ShowResultItemMessage()
  local procMessagePosX = (getOriginScreenSizeX() - Panel_NakMessage:GetSizeX()) * 0.5
  local procMessagePosY = getOriginScreenSizeY() / 4
  local procMessage = ""
  local count = PaGlobal_DialogExchange_All._resultItemMsg.count
  local name = PaGlobal_DialogExchange_All._resultItemMsg.name
  if nil ~= count then
    if nil ~= name then
      procMessage = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGELIST_MESSAGE_TYPE_2", "resultItemName", name, "exchangeCount", count)
    else
      procMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGELIST_MESSAGE_TYPE_1", "exchangeCount", count)
    end
  elseif nil ~= name then
    procMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGELIST_MESSAGE_TYPE_4", "resultItemName", name)
  else
    procMessage = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGELIST_MESSAGE_TYPE_3")
  end
  if true == PaGlobal_DialogExchange_All._isExchange then
    if PaGlobal_DialogExchange_All._isConsole then
      Proc_ShowMessage_Ack(procMessage)
    else
      Proc_ShowMessage_Ack(procMessage, nil, procMessagePosX, procMessagePosY)
    end
    PaGlobal_DialogExchange_All._isExchange = false
  end
end
