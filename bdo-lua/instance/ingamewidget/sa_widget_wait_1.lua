function PaGlobal_SA_Widget_Wait:initialize()
  if true == PaGlobal_SA_Widget_Wait._initialize then
    return
  end
  local waitBG = UI.getChildControl(Panel_SA_Widget_Wait, "Static_Wait_BG")
  self._ui.txt_wait_title = UI.getChildControl(waitBG, "StaticText_Wait_Title")
  self._ui.txt_wait_value1 = UI.getChildControl(waitBG, "StaticText_Wait_Value1")
  self._ui.txt_wait_value2 = UI.getChildControl(waitBG, "StaticText_Wait_Value2")
  self._ui.txt_wait_value = UI.getChildControl(waitBG, "StaticText_Wait_Value")
  self:registEventHandler()
  self:validate()
  self._initialize = true
  PaGlobal_SA_Widget_Wait:prepareOpen()
  local remainTime = Int64toInt32(ToClient_BattleRoyaleRemainTime())
  if 0 < remainTime then
    PaGlobal_SA_Widget_Wait_ChangeSurvival()
  end
end
function PaGlobal_SA_Widget_Wait:registEventHandler()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Wait_ReSizePanel()")
  registerEvent("FromClient_ChangeBattleRoyalePlayerCount", "FromClient_SA_Widget_Wait_ChangeBattleRoyalePlayerCount")
end
function PaGlobal_SA_Widget_Wait:prepareOpen()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  FromClient_SA_Widget_Wait_ChangeBattleRoyalePlayerCount()
  PaGlobal_SA_Widget_Wait:open()
end
function PaGlobal_SA_Widget_Wait:open()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  Panel_SA_Widget_Wait:SetShow(true)
end
function PaGlobal_SA_Widget_Wait:prepareClose()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  PaGlobal_SA_Widget_Wait:close()
end
function PaGlobal_SA_Widget_Wait:close()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  Panel_SA_Widget_Wait:SetShow(false)
end
function PaGlobal_SA_Widget_Wait:update()
  if nil == Panel_SA_Widget_Wait then
    return
  end
end
function PaGlobal_SA_Widget_Wait:validate()
  if nil == Panel_SA_Widget_Wait then
    return
  end
  self._ui.txt_wait_value1:isValidate()
  self._ui.txt_wait_value2:isValidate()
  self._ui.txt_wait_value:isValidate()
end
