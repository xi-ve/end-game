function PaGlobal_SA_Widget_ESCMenu:initialize()
  if true == PaGlobal_SA_Widget_ESCMenu._initialize then
    return
  end
  PaGlobal_SA_Widget_ESCMenu._ui.btn_close = UI.getChildControl(Panel_SA_Widget_ESCMenu, "Button_CloseButton")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_inventory = UI.getChildControl(Panel_SA_Widget_ESCMenu, "Button_Inventory")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_option = UI.getChildControl(Panel_SA_Widget_ESCMenu, "Button_Option")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_exit = UI.getChildControl(Panel_SA_Widget_ESCMenu, "Button_Exit")
  PaGlobal_SA_Widget_ESCMenu:registEventHandler()
  PaGlobal_SA_Widget_ESCMenu:validate()
  PaGlobal_SA_Widget_ESCMenu._initialize = true
end
function PaGlobal_SA_Widget_ESCMenu:registEventHandler()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  PaGlobal_SA_Widget_ESCMenu._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SA_Widget_ESCMenu_Close()")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_inventory:addInputEvent("Mouse_LUp", "PaGlobal_SA_Widget_Inventory_Open()")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_option:addInputEvent("Mouse_LUp", "FGlobal_Option_TogglePanel()")
  PaGlobal_SA_Widget_ESCMenu._ui.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_ESCMenu_ExitClick()")
  registerEvent("onScreenResize", "FromClient_SA_Widget_ESCMenu_ReSizePanel")
end
function PaGlobal_SA_Widget_ESCMenu:prepareOpen()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  ToClient_ShowMouseCursor()
  PaGlobal_SA_Widget_ESCMenu:open()
end
function PaGlobal_SA_Widget_ESCMenu:open()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  Panel_SA_Widget_ESCMenu:SetShow(true)
end
function PaGlobal_SA_Widget_ESCMenu:prepareClose()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  ToClient_HideMouseCursor()
  PaGlobal_SA_Widget_ESCMenu:close()
end
function PaGlobal_SA_Widget_ESCMenu:close()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  Panel_SA_Widget_ESCMenu:SetShow(false)
end
function PaGlobal_SA_Widget_ESCMenu:validate()
  if nil == Panel_SA_Widget_ESCMenu then
    return
  end
  PaGlobal_SA_Widget_ESCMenu._ui.btn_close:isValidate()
  PaGlobal_SA_Widget_ESCMenu._ui.btn_inventory:isValidate()
  PaGlobal_SA_Widget_ESCMenu._ui.btn_option:isValidate()
  PaGlobal_SA_Widget_ESCMenu._ui.btn_exit:isValidate()
end
