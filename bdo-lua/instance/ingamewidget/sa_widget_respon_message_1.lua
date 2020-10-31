function PaGlobal_SA_Widget_Respon_Message:initialize()
  if true == PaGlobal_SA_Widget_Respon_Message._initialize then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._ui.stc_responMessage = UI.getChildControl(Panel_SA_Widget_Respon_Message, "Static_Respon_Message")
  PaGlobal_SA_Widget_Respon_Message._ui.stc_icon = UI.getChildControl(PaGlobal_SA_Widget_Respon_Message._ui.stc_responMessage, "Static_Icon")
  PaGlobal_SA_Widget_Respon_Message._ui.txt_responMessage = UI.getChildControl(PaGlobal_SA_Widget_Respon_Message._ui.stc_responMessage, "StaticText_Message")
  Panel_SA_Widget_Respon_Message:SetShow(false)
  PaGlobal_SA_Widget_Respon_Message:registEventHandler()
  PaGlobal_SA_Widget_Respon_Message:validate()
  PaGlobal_SA_Widget_Respon_Message._initialize = true
end
function PaGlobal_SA_Widget_Respon_Message:registEventHandler()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Respon_Message_ReSizePanel")
  registerEvent("FromClient_ReviveToInstanceField", "FromClient_SA_Widget_Respon_Message_HideMessage")
  registerEvent("FromClient_BattleRoyaleWinner", "FromClient_SA_Widget_Respon_Message_HideMessage")
end
function PaGlobal_SA_Widget_Respon_Message:prepareOpen()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  PaGlobal_SA_Widget_Respon_Message:open()
end
function PaGlobal_SA_Widget_Respon_Message:open()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  Panel_SA_Widget_Respon_Message:SetShow(true)
end
function PaGlobal_SA_Widget_Respon_Message:prepareClose()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  PaGlobal_SA_Widget_Respon_Message:close()
end
function PaGlobal_SA_Widget_Respon_Message:close()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  Panel_SA_Widget_Respon_Message:SetShow(false)
end
function PaGlobal_SA_Widget_Respon_Message:validate()
  if nil == Panel_SA_Widget_Respon_Message then
    return
  end
  PaGlobal_SA_Widget_Respon_Message._ui.stc_responMessage:isValidate()
  PaGlobal_SA_Widget_Respon_Message._ui.stc_icon:isValidate()
  PaGlobal_SA_Widget_Respon_Message._ui.txt_responMessage:isValidate()
end
