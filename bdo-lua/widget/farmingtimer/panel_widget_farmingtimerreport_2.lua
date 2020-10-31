function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
function PaGloabl_FarmingTimerReport_Open()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:prepareOpen()
end
function PaGloabl_FarmingTimerReport_Close()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:prepareClose()
end
function PaGloabl_FarmingTimerReport_Reset()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:resetReport()
end
function PaGloabl_FarmingTimerReport_ChangeTab(idx)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:changeTab(idx)
end
function PaGloabl_FarmingTimerReport_ItemEnchantLevel(itemSSW)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  return PaGlobal_FarmingTimerReport:itemEnchantLevel(itemSSW)
end
function PaGloabl_FarmingTimerReport_ExperienceIconSetting(control, experienceType)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  return PaGlobal_FarmingTimerReport:experienceIconSetting(control, experienceType)
end
function PaGloabl_FarmingTimerReport_CalculationAllMarketPrice()
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:calculationAllMarketPrice()
end
function FromClient_FarmingListItemCountChange(idx, tab)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:itemCountChange_Slot(idx, tab)
end
function PaGloabl_FarmingTimerReport_FarmingListCreate(control, key64)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:create(control, key64)
end
function PaGloabl_FarmingTimerReport_FarmingListSetShowFalse(control)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:listSetShowFalse(control)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateExperience(control)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createExperience(control)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateRemainedSkillPoint(control)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createRemainedSkillPoint(control)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateWp(control)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createWp(control)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateFarmingItem(control, idx)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createFarmingItem(control, idx)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateConsumeItem(control, idx)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createConsumeItem(control, idx)
end
function PaGloabl_FarmingTimerReport_FarmingListCreateLifeExperience(control, idx)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:createLifeExperience(control, idx)
end
function FromClient_FarmingListAddSlot(idx, tab)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:add_Slot(idx, tab)
end
function FromClient_FarmingListPriceInfoUpdate(price, key)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:priceInfoUpdate(price, key)
end
function FromClient_FarmingLifeExperienceAddSlot(idx, tab)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
function FromClient_FarmingLifeExperienceChange(idx, tab)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
  PaGlobal_FarmingTimerReport:lifeExperienceChange(idx, tab)
end
function FromClient_FarmingExperienceChange(experience)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
function FromClient_FarmingSkillPointChange(skillPoint)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
function FromClient_FarmingWpChange(wp)
  if nil == Panel_Widget_FarmingTimerReport_All then
    return
  end
end
registerEvent("FromClient_FarmingListItemCountChange", "FromClient_FarmingListItemCountChange")
registerEvent("FromClient_FarmingListAddSlot", "FromClient_FarmingListAddSlot")
registerEvent("FromClient_FarmingListPriceInfoUpdate", "FromClient_FarmingListPriceInfoUpdate")
registerEvent("FromClient_FarmingLifeExperienceAddSlot", "FromClient_FarmingLifeExperienceAddSlot")
registerEvent("FromClient_FarmingLifeExperienceChange", "FromClient_FarmingLifeExperienceChange")
registerEvent("FromClient_FarmingExperienceChange", "FromClient_FarmingExperienceChange")
registerEvent("FromClient_FarmingSkillPointChange", "FromClient_FarmingSkillPointChange")
registerEvent("FromClient_FarmingWpChange", "FromClient_FarmingWpChange")
