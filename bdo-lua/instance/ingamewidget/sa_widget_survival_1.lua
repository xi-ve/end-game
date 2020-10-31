function PaGlobal_SA_Widget_Survival:initialize()
  if true == PaGlobal_SA_Widget_Survival._initialize then
    return
  end
  local survivalBG = UI.getChildControl(Panel_SA_Widget_Survival, "Static_Survival_BG")
  self._ui.txt_survival_title = UI.getChildControl(survivalBG, "StaticText_Survival_Title")
  self._ui.txt_survival_value1 = UI.getChildControl(survivalBG, "StaticText_Survival_Value1")
  self._ui.txt_survival_value2 = UI.getChildControl(survivalBG, "StaticText_Survival_Value2")
  self._ui.txt_survival_value = UI.getChildControl(survivalBG, "StaticText_Survival_Value")
  local killBG = UI.getChildControl(Panel_SA_Widget_Survival, "Static_Kill_BG")
  self._ui.txt_killValue = UI.getChildControl(killBG, "StaticText_Kill")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_Survival:registEventHandler()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Survival_ReSizePanel()")
  registerEvent("FromClient_ChangeBattleRoyalePlayerCount", "FromClient_SA_Widget_Survival_ChangeBattleRoyalePlayerCount")
  registerEvent("FromClient_InstanceFieldSummonCharacterNoti", "FromClient_SA_Widget_Survival_SummonCharacterNoti")
end
function PaGlobal_SA_Widget_Survival:prepareOpen()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  FromClient_SA_Widget_Survival_ChangeBattleRoyalePlayerCount()
  self._killCount = 0
  PaGlobal_SA_Widget_Survival:update()
  PaGlobal_SA_Widget_Survival:open()
end
function PaGlobal_SA_Widget_Survival:open()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  Panel_SA_Widget_Survival:SetShow(true)
end
function PaGlobal_SA_Widget_Survival:prepareClose()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  PaGlobal_SA_Widget_Survival:close()
end
function PaGlobal_SA_Widget_Survival:close()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  Panel_SA_Widget_Survival:SetShow(false)
end
function PaGlobal_SA_Widget_Survival:update()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  self._ui.txt_killValue:SetText(self._killCount)
end
function PaGlobal_SA_Widget_Survival:validate()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  self._ui.txt_survival_value1:isValidate()
  self._ui.txt_survival_value2:isValidate()
  self._ui.txt_survival_value:isValidate()
end
