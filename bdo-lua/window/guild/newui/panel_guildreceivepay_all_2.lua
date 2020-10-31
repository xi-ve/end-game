function PaGlobal_GuildReceivePay_All_Open()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  PaGlobal_GuildReceivePay_All:prepareOpen()
end
function PaGlobal_GuildReceivePay_All_Close()
  if nil == Panel_GuildReceivePay_All then
    return
  end
  PaGlobal_GuildReceivePay_All:prepareClose()
end
function HandleEventLUp_GuildReceivePay_All_PayIntoInventory()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  ToClient_TakeMyGuildBenefit(false)
  PaGlobal_GuildReceivePay_All.paytype = false
  PaGlobal_GuildReceivePay_All:prepareClose()
end
function HandleEventLUp_GuildReceivePay_All_PayIntoWarehouse()
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  ToClient_TakeMyGuildBenefit(true)
  PaGlobal_GuildReceivePay_All.paytype = true
  PaGlobal_GuildReceivePay_All:prepareClose()
end
function PaGlobal_GuildReceivePay_AllShowAni()
  if nil == Panel_GuildReceivePay_All then
    return
  end
end
function PaGlobal_GuildReceivePay_AllHideAni()
  if nil == Panel_GuildReceivePay_All then
    return
  end
end
