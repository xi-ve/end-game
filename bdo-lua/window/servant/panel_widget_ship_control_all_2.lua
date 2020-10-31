function PaGlobalFunc_Ship_Control_All_Open()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  PaGlobal_Ship_Control_All:prepareOpen()
end
function PaGlobalFunc_Ship_Control_All_Close()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  PaGlobal_Ship_Control_All:prepareClose()
end
function PaGlobalFunc_Ship_Control_All_Resize()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  PaGlobal_Ship_Control_All:resize()
end
function HandleEventLUp_Ship_Control_All_Interaction()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_Interaction)
end
function HandleEventLUp_Ship_Control_All_AutoRide()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_AutoRide)
end
function HandleEventLUp_Ship_Control_All_Recall()
  if nil == Panel_Widget_Ship_Control then
    return
  end
  ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_Recall)
end
