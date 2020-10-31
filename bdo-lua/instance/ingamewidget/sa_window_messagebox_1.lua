function PaGlobal_SA_Window_MessageBox:initialize()
  if true == PaGlobal_SA_Window_MessageBox._initialize then
    return
  end
  PaGlobal_SA_Window_MessageBox._ui.stc_exitBG = UI.getChildControl(Panel_SA_Window_MessageBox, "Static_Exit_BG")
  PaGlobal_SA_Window_MessageBox._ui.txt_content = UI.getChildControl(PaGlobal_SA_Window_MessageBox._ui.stc_exitBG, "StaticText_Info")
  PaGlobal_SA_Window_MessageBox._ui.stc_buttons = UI.getChildControl(PaGlobal_SA_Window_MessageBox._ui.stc_exitBG, "Static_Btn")
  PaGlobal_SA_Window_MessageBox._ui.btn_yes = UI.getChildControl(PaGlobal_SA_Window_MessageBox._ui.stc_buttons, "Button_OK")
  PaGlobal_SA_Window_MessageBox._ui.btn_no = UI.getChildControl(PaGlobal_SA_Window_MessageBox._ui.stc_buttons, "Button_Cancel")
  PaGlobal_SA_Window_MessageBox._ui.btn_close = UI.getChildControl(PaGlobal_SA_Window_MessageBox._ui.stc_exitBG, "Button_Close")
  PaGlobal_SA_Window_MessageBox._originPanelSizeY = Panel_SA_Window_MessageBox:GetSizeY()
  PaGlobal_SA_Window_MessageBox._originContentSizeY = PaGlobal_SA_Window_MessageBox._ui.txt_content:GetSizeY()
  PaGlobal_SA_Window_MessageBox:registEventHandler()
  PaGlobal_SA_Window_MessageBox:validate()
  PaGlobal_SA_Window_MessageBox._initialize = true
end
function PaGlobal_SA_Window_MessageBox:registEventHandler()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  PaGlobal_SA_Window_MessageBox._ui.btn_yes:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Window_MessageBox_YesButtonUp()")
  PaGlobal_SA_Window_MessageBox._ui.btn_no:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Window_MessageBox_NoButtonUp()")
  PaGlobal_SA_Window_MessageBox._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SA_Window_MessageBox_Close()")
  registerEvent("onScreenResize", "FromClient_SA_Window_MessageBox_ReSizePanel")
end
function PaGlobal_SA_Window_MessageBox:prepareOpen()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  PaGlobal_SA_Window_MessageBox:open()
end
function PaGlobal_SA_Window_MessageBox:open()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  Panel_SA_Window_MessageBox:SetShow(true)
end
function PaGlobal_SA_Window_MessageBox:prepareClose()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  Panel_SA_Window_MessageBox:ClearUpdateLuaFunc()
  PaGlobal_SA_Window_MessageBox._elapsedTime = 0
  PaGlobal_SA_Window_MessageBox:close()
end
function PaGlobal_SA_Window_MessageBox:close()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  Panel_SA_Window_MessageBox:SetShow(false)
end
function PaGlobal_SA_Window_MessageBox:validate()
  if nil == Panel_SA_Window_MessageBox then
    return
  end
  PaGlobal_SA_Window_MessageBox._ui.stc_exitBG:isValidate()
  PaGlobal_SA_Window_MessageBox._ui.txt_content:isValidate()
  PaGlobal_SA_Window_MessageBox._ui.stc_buttons:isValidate()
  PaGlobal_SA_Window_MessageBox._ui.btn_yes:isValidate()
  PaGlobal_SA_Window_MessageBox._ui.btn_no:isValidate()
  PaGlobal_SA_Window_MessageBox._ui.btn_close:isValidate()
end
