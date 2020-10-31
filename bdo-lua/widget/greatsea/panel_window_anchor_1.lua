function PaGlobal_Anchor:initialize()
  if true == PaGlobal_Anchor._initialize then
    return
  end
  self._ui.btn_anchor = UI.getChildControl(Panel_Widget_Anchorage, "Button_Anchorage")
  self._ui.btn_barter = UI.getChildControl(Panel_Widget_Anchorage, "Button_Barter")
  self._ui.btn_explore = UI.getChildControl(Panel_Widget_Anchorage, "Button_Explore")
  self._ui.btn_supply = UI.getChildControl(Panel_Widget_Anchorage, "Button_Supply")
  self._ui.btn_departure = UI.getChildControl(Panel_Widget_Anchorage, "Button_Departure")
  PaGlobal_Anchor:registEventHandler()
  PaGlobal_Anchor:validate()
  self._initialize = true
end
function PaGlobal_Anchor:registEventHandler()
  if nil == Panel_Widget_Anchorage then
    return
  end
  registerEvent("FromClient_UpdateNearBarterNPC", "FromClient_UpdateNearBarterNPC")
  registerEvent("EventSelfPlayerRideOff", "PaGlobal_Anchor_FromClient_RideOff")
  self._ui.btn_anchor:addInputEvent("Mouse_LUp", "HandleEventLUp_Anchorage_SetAnchorage(true)")
  self._ui.btn_departure:addInputEvent("Mouse_LUp", "HandleEventLUp_Anchorage_SetAnchorage(true)")
  self._ui.btn_barter:addInputEvent("Mouse_LUp", "HandleEventLUp_Anchor_SelectType(" .. PaGlobal_Anchor._eSelectButtonType.barter .. ")")
  self._ui.btn_explore:addInputEvent("Mouse_LUp", "HandleEventLUp_Anchor_SelectType(" .. PaGlobal_Anchor._eSelectButtonType.explore .. ")")
  self._ui.btn_explore:addInputEvent("Mouse_On", "HandleEventOn_ShowTooltip(true, " .. PaGlobal_Anchor._eSelectButtonType.explore .. ")")
  self._ui.btn_explore:addInputEvent("Mouse_Out", "nodeStabelInfo_SimpleTooltips(false)")
  self._ui.btn_supply:addInputEvent("Mouse_LUp", "HandleEventLUp_Anchor_SelectType(" .. PaGlobal_Anchor._eSelectButtonType.supply .. ")")
  self._ui.btn_supply:addInputEvent("Mouse_On", "HandleEventOn_ShowTooltip(true, " .. PaGlobal_Anchor._eSelectButtonType.supply .. ")")
  self._ui.btn_supply:addInputEvent("Mouse_Out", "nodeStabelInfo_SimpleTooltips(false, " .. PaGlobal_Anchor._eSelectButtonType.supply .. ")")
end
function PaGlobal_Anchor:initData()
  if nil == Panel_Widget_Anchorage then
    return
  end
  HandleEventLUp_Anchorage_SetAnchorage(false)
end
function PaGlobal_Anchor:clearData()
  if nil == Panel_Widget_Anchorage then
    return
  end
  PaGlobal_Barter._actorKey = nil
  PaGlobal_Barter._regionKey = RegionKey(0)
  PaGlobal_Anchor._isCloseWidget = true
end
function PaGlobal_Anchor:update()
  if nil == Panel_Widget_Anchorage then
    return
  end
end
function PaGlobal_Anchor:prepareOpen()
  if nil == Panel_Widget_Anchorage then
    return
  end
  PaGlobal_Anchor:initData()
  PaGlobal_Anchor:open()
  if nil ~= PaGlobal_Anchor._ui.btn_anchor then
    PaGlobal_Anchor._ui.btn_anchor:SetShow(true)
  end
end
function PaGlobal_Anchor:open()
  if nil == Panel_Widget_Anchorage then
    return
  end
  Panel_Widget_Anchorage:SetShow(true)
end
function PaGlobal_Anchor:prepareClose()
  if nil == Panel_Widget_Anchorage then
    return
  end
  PaGlobal_Anchor:clearData()
  PaGlobal_Anchor:close()
end
function PaGlobal_Anchor:close()
  if nil == Panel_Widget_Anchorage then
    return
  end
  Panel_Widget_Anchorage:SetShow(false)
end
function PaGlobal_Anchor:validate()
  if nil == Panel_Widget_Anchorage then
    return
  end
  self._ui.btn_anchor:isValidate()
  self._ui.btn_barter:isValidate()
  self._ui.btn_explore:isValidate()
  self._ui.btn_supply:isValidate()
  self._ui.btn_departure:isValidate()
end
