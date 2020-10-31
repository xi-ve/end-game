function PaGlobal_GuildReceivePay_All:initialize()
  if true == self._initialize then
    return
  end
  local centerBg = UI.getChildControl(Panel_GuildReceivePay_All, "Static_CenterBg")
  self._ui.txt_pay = UI.getChildControl(centerBg, "StaticText_PayValue")
  self._ui.btn_inven = UI.getChildControl(centerBg, "Button_Inventory")
  self._ui.btn_warehouse = UI.getChildControl(centerBg, "Button_Warehouse")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildReceivePay_All:registEventHandler()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  PaGlobal_registerPanelOnBlackBackground(Panel_GuildReceivePay_Alls)
  self._ui.btn_inven:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildReceivePay_All_PayIntoInventory()")
  self._ui.btn_warehouse:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildReceivePay_All_PayIntoWarehouse()")
end
function PaGlobal_GuildReceivePay_All:prepareOpen()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  warehouse_requestInfo(getCurrentWaypointKey())
  self:update()
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  PaGlobal_GuildReceivePay_All:open()
end
function PaGlobal_GuildReceivePay_All:open()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  Panel_GuildReceivePay_All:SetShow(true)
end
function PaGlobal_GuildReceivePay_All:prepareClose()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  PaGlobal_GuildReceivePay_All:close()
end
function PaGlobal_GuildReceivePay_All:close()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  Panel_GuildReceivePay_All:SetShow(false)
end
function PaGlobal_GuildReceivePay_All:update()
  local memberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == guildInfo then
    self._ui.txt_pay:SetText("0")
    return
  end
  local memberInfo = guildInfo:getMember(memberIdx)
  if nil == memberInfo then
    self._ui.txt_pay:SetText("0")
    return
  end
  local benefit = memberInfo:getContractedBenefit()
  self._ui.txt_pay:SetText(tostring(makeDotMoney(benefit)))
  self._ui.txt_pay:ComputePos()
end
function PaGlobal_GuildReceivePay_All:validate()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  self._ui.txt_pay:isValidate()
  self._ui.btn_inven:isValidate()
  self._ui.btn_warehouse:isValidate()
end
