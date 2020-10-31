function PaGlobal_SA_Widget_KeyInfo:initialize()
  if true == PaGlobal_SA_Widget_KeyInfo._initialize then
    return
  end
  self._ui.stc_invenBG = UI.getChildControl(Panel_SA_Widget_KeyInfo, "Static_Inven_BG")
  self._ui.txt_inven = UI.getChildControl(self._ui.stc_invenBG, "StaticText_Inven")
  self._ui.stc_invenKey = UI.getChildControl(self._ui.stc_invenBG, "Static_Inven_Key_I")
  self._ui.stc_EscBG = UI.getChildControl(Panel_SA_Widget_KeyInfo, "Static_Esc_BG")
  self._ui.txt_Esc = UI.getChildControl(self._ui.stc_EscBG, "StaticText_Esc")
  self._ui.stc_EscKey = UI.getChildControl(self._ui.stc_EscBG, "Static_Esc_Key_Esc")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_KeyInfo:registEventHandler()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_KeyInfo_ReSizePanel")
  Panel_SA_Widget_KeyInfo:RegisterShowEventFunc(true, "PaGlobal_SA_Widget_KeyInfo_ShowAni()")
  Panel_SA_Widget_KeyInfo:RegisterShowEventFunc(false, "PaGlobal_SA_Widget_KeyInfo_HideAni()")
end
function PaGlobal_SA_Widget_KeyInfo:prepareOpen()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  PaGlobal_SA_Widget_KeyInfo:open()
end
function PaGlobal_SA_Widget_KeyInfo:open()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  Panel_SA_Widget_KeyInfo:SetShow(true)
end
function PaGlobal_SA_Widget_KeyInfo:prepareClose()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  PaGlobal_SA_Widget_KeyInfo:close()
end
function PaGlobal_SA_Widget_KeyInfo:close()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  Panel_SA_Widget_KeyInfo:SetShow(false)
end
function PaGlobal_SA_Widget_KeyInfo:update()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
end
function PaGlobal_SA_Widget_KeyInfo:validate()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
  self._ui.stc_invenBG:isValidate()
  self._ui.txt_inven:isValidate()
  self._ui.stc_invenKey:isValidate()
  self._ui.stc_EscBG:isValidate()
  self._ui.txt_Esc:isValidate()
  self._ui.stc_EscKey:isValidate()
end
