function PaGlobal_SA_Widget_GuardGauge:initialize()
  if true == PaGlobal_SA_Widget_GuardGauge._initialize then
    return
  end
  self._ui.stc_guardGaugeBg = UI.getChildControl(Panel_SA_Widget_GuardGauge, "GuardGauge_ProgresssBG")
  self._ui.progress_guard = UI.getChildControl(Panel_SA_Widget_GuardGauge, "Progress2_1")
  self._ui.txt_guardGaugeText = UI.getChildControl(Panel_SA_Widget_GuardGauge, "StaticText_GuardGaugeCount")
  Panel_SA_Widget_GuardGauge:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_GuardGauge:registEventHandler()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_GuardGauge_ReSizePanel")
  registerEvent("FromClientGuardUpdate", "PaGlobal_SA_Widget_GuardGauge_Update()")
  Panel_SA_Widget_GuardGauge:RegisterUpdateFunc("PaGlobal_SA_Widget_GuardGauge_Update")
end
function PaGlobal_SA_Widget_GuardGauge:prepareOpen()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  Panel_SA_Widget_GuardGauge:RegisterUpdateFunc("PaGlobal_SA_Widget_GuardGauge_Update")
  PaGlobal_SA_Widget_GuardGauge:open()
end
function PaGlobal_SA_Widget_GuardGauge:open()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  Panel_SA_Widget_GuardGauge:SetShow(true)
end
function PaGlobal_SA_Widget_GuardGauge:prepareClose()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  Panel_SA_Widget_GuardGauge:ClearUpdateLuaFunc()
  PaGlobal_SA_Widget_GuardGauge:close()
end
function PaGlobal_SA_Widget_GuardGauge:close()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  Panel_SA_Widget_GuardGauge:SetShow(false)
end
function PaGlobal_SA_Widget_GuardGauge:validate()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  self._ui.stc_guardGaugeBg:isValidate()
  self._ui.progress_guard:isValidate()
  self._ui.txt_guardGaugeText:isValidate()
end
