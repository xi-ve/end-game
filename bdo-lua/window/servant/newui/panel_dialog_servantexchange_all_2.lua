function PaGlobalFunc_ServantExchange_All_Open()
  if nil == Panel_Dialog_ServantExchange_All or true == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_All:prepareOpen()
end
function PaGlobalFunc_ServantExchange_All_Close()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_All:prepareClose()
end
function FromClient_ServantExchange_All_OnScreenResize()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  Panel_Dialog_ServantExchange_All:ComputePos()
end
function FromClient_ServantExchange_All_List2Update(content, key)
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_All:list2Update(content, key)
end
function HandleEventLUp_ServantExchange_All_EditClick()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  if false == PaGlobal_ServantExchange_All._isConsole then
    PaGlobal_ServantExchange_All._ui._edit_Naming:SetEditText("")
  end
end
function HandleEventLUp_ServantExchange_All_MixConfirm()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  ClearFocusEdit()
  local name = PaGlobal_ServantExchange_All._ui._edit_Naming:GetEditText()
  if nil == PaGlobal_ServantExchange_All._servantNo_Left or nil == PaGlobal_ServantExchange_All._servantNo_Right or nil == name then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local function servantMix()
    if true == PaGlobal_ServantExchange_All._ui._rdo_Inven:IsCheck() then
      whereType = CppEnums.ItemWhereType.eInventory
    else
      whereType = CppEnums.ItemWhereType.eWarehouse
    end
    stable_mix(PaGlobal_ServantExchange_All._servantNo_Left, PaGlobal_ServantExchange_All._servantNo_Right, whereType, name)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local _desc = ""
  local _confirmFunction = servantMix
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  if PaGlobal_ServantExchange_All._isContentsStallionEnable then
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMIX_TEXT_MIXHELPMSG")
  else
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMIX_TEXT_MIXHELPMSG2")
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
function HandleEventLUp_ServantExchange_All_SelectServant(isMale, dataIdx)
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  if nil == isMale or nil == dataIdx or nil == PaGlobal_ServantExchange_All._servantDataTable then
    return
  end
  if nil == PaGlobal_ServantExchange_All._servantDataTable[dataIdx] then
    return
  end
  local servantData = PaGlobal_ServantExchange_All._servantDataTable[dataIdx]
  local servantNo = servantData._servantNo
  if true == isMale then
    PaGlobal_ServantExchange_All._servantNo_Left = servantNo
  else
    PaGlobal_ServantExchange_All._servantNo_Right = servantNo
  end
  if nil ~= PaGlobal_ServantExchange_All._servantNo_Left and nil ~= PaGlobal_ServantExchange_All._servantNo_Right then
    PaGlobal_ServantExchange_All._ui._edit_Naming:SetIgnore(false)
    PaGlobal_ServantExchange_All._ui._stc_ExchangeBg:SetShow(true)
    PaGlobal_ServantExchange_All._ui._txt_ExchangeMoneyValue:SetText(makeDotMoney(getServantSelfMatingPrice()))
  end
  PaGlobal_ServantExchange_All:matingUpdate()
end
function HandleEventLUp_ServantExchange_All_ClearSlot(slotType)
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  if 1 == slotType then
    PaGlobal_ServantExchange_All._servantNo_Left = nil
    PaGlobal_ServantExchange_All._ui._stc_LeftImage:ReleaseTexture()
    PaGlobal_ServantExchange_All._ui._stc_LeftImage:ChangeTextureInfoNameAsync("")
    PaGlobal_ServantExchange_All._ui._txt_LeftName:SetText("")
    PaGlobal_ServantExchange_All._ui._stc_LeftSwitftIcon:SetShow(false)
    PaGlobal_ServantExchange_All._ui._txt_LeftTier:SetShow(false)
  else
    PaGlobal_ServantExchange_All._servantNo_Right = nil
    PaGlobal_ServantExchange_All._ui._stc_RightImage:ReleaseTexture()
    PaGlobal_ServantExchange_All._ui._stc_RightImage:ChangeTextureInfoNameAsync("")
    PaGlobal_ServantExchange_All._ui._txt_RightName:SetText("")
    PaGlobal_ServantExchange_All._ui._stc_RightSwitftIcon:SetShow(false)
    PaGlobal_ServantExchange_All._ui._txt_RightTier:SetShow(false)
  end
  PaGlobal_ServantExchange_All._ui._edit_Naming:SetIgnore(true)
  PaGlobal_ServantExchange_All._ui._stc_ExchangeBg:SetShow(false)
  if false == PaGlobal_ServantExchange_All._isConsole then
    PaGlobal_ServantExchange_All._ui._edit_Naming:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_EDITDESC"), true)
  end
  PaGlobal_ServantExchange_All:matingUpdate()
end
function FromClient_ServantExchange_All_ServantExchangeFinish()
  if nil == Panel_Dialog_ServantExchange_All then
    return
  end
  if true == PaGlobal_QAServantSupportOn then
    return
  end
  local servantInfo1 = stable_getServantByServantNo(PaGlobal_ServantExchange_All._servantNo_Left)
  if nil == servantInfo1 then
    return
  end
  local servantName1 = servantInfo1:getName()
  local servantInfo2 = stable_getServantByServantNo(PaGlobal_ServantExchange_All._servantNo_Right)
  if nil == servantInfo2 then
    return
  end
  local servantName2 = servantInfo2:getName()
  Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STABLEMIX_MIX_ACK", "servantName1", servantName1, "servantName2", servantName2))
  if false == PaGlobal_ServantExchange_All._isConsole then
    PaGlobal_ServantExchange_All._ui._edit_Naming:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_EDITDESC"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    PaGlobal_ServantExchange_All._ui._edit_Naming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  PaGlobalFunc_ServantExchange_All_Close()
  PaGlobalFunc_ServantFunction_All_ChangeTab(0)
  PaGlobal_ServantFunction_All._ui._rdo_FunctionList:SetCheck(true)
end
function PaGlobalFunc_ServantExchange_All_OpenVirtualKeyboard()
  SetFocusEdit(PaGlobal_ServantExchange_All._ui._edit_Naming)
end
function PaGlobalFunc_ServantExchange_All_CloseVirtualKeyboard(str)
  if "" == str or nil == str or false == PaGlobal_ServantExchange_All._isConsole then
    return
  end
  PaGlobal_ServantExchange_All._ui._edit_Naming:SetEditText(str)
  ClearFocusEdit()
  HandleEventLUp_ServantExchange_All_MixConfirm()
end
