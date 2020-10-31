function PaGlobalFunc_ServantTransferList_All_Open()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:prepareOpen()
end
function PaGlobalFunc_ServantTransferList_All_Close()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:prepareClose()
end
function FromClient_ServantTransferList_All_OnScreenResize()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantTransferList_All:ComputePos()
end
function FromClient_ServantTransferList_All_List2Update(content, key)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:list2Update(content, key)
end
function HandleEventLUp_ServantTransferList_All_Transfer(regeionKey)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == regeionKey then
    return
  end
  if nil == getRegionInfoWrapper(regeionKey) then
    return
  end
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobalFunc_ServantList_All_SubMenuClose()
  end
  local sortedNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  if nil == sortedNo then
    return
  end
  local servantInfo = stable_getServant(sortedNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  local function TransferConfirm()
    local moneyWhereType = MessageBoxCheck.isCheck()
    ToClient_ChangeServantRegion(servantNo, regeionKey, moneyWhereType)
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  local cost = ToClient_GetCostToChangeServantRegion()
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE")
  PaGlobal_ServantTransferList_All._currentTitle = title
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_CHANGE_REGION_NOTIFY_DESC", "cost", cost)
  local _confirmFunction = TransferConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
