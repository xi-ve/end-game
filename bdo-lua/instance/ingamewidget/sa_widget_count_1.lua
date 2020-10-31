function PaGlobal_SA_Widget_Count:initialize()
  if true == PaGlobal_SA_Widget_Count._initialize then
    return
  end
  for ii = 1, 10 do
    PaGlobal_SA_Widget_Count._ui.stc_count[ii] = UI.getChildControl(Panel_SA_Widget_Count, "Static_Count_" .. ii)
    PaGlobal_SA_Widget_Count._ui.stc_count[ii]:SetShow(false)
  end
  PaGlobal_SA_Widget_Count:registEventHandler()
  PaGlobal_SA_Widget_Count:validate()
  PaGlobal_SA_Widget_Count._initialize = true
end
function PaGlobal_SA_Widget_Count:registEventHandler()
  if nil == Panel_SA_Widget_Count then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Count_ReSizePanel")
  registerEvent("FromClient_BattleRoyaleStateChanged", "FromClient_SA_Widget_Count_BattleRoyaleStateChanged")
end
function PaGlobal_SA_Widget_Count:prepareOpen()
  if nil == Panel_SA_Widget_Count then
    return
  end
  PaGlobal_SA_Widget_Count:open()
end
function PaGlobal_SA_Widget_Count:open()
  if nil == Panel_SA_Widget_Count then
    return
  end
  Panel_SA_Widget_Count:SetShow(true)
end
function PaGlobal_SA_Widget_Count:prepareClose()
  if nil == Panel_SA_Widget_Count then
    return
  end
  PaGlobal_SA_Widget_Count:close()
end
function PaGlobal_SA_Widget_Count:close()
  if nil == Panel_SA_Widget_Count then
    return
  end
  Panel_SA_Widget_Count:SetShow(false)
end
function PaGlobal_SA_Widget_Count:validate()
  if nil == Panel_SA_Widget_Count then
    return
  end
  for ii = 1, 10 do
    PaGlobal_SA_Widget_Count._ui.stc_count[ii]:isValidate()
  end
end
function PaGlobal_SA_Widget_Count:showCount(currentCount)
  if nil == Panel_SA_Widget_Count then
    return
  end
  if false == Panel_SA_Widget_Count:GetShow() then
    return
  end
  for ii = 1, 10 do
    if ii == currentCount then
      PaGlobal_SA_Widget_Count._ui.stc_count[ii]:SetShow(true)
    else
      PaGlobal_SA_Widget_Count._ui.stc_count[ii]:SetShow(false)
    end
  end
end
