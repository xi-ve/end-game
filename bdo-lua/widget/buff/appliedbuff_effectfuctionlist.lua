function GuardianBuffEffectStart(remainTime)
  if nil == remainTime then
    if nil ~= PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart then
      remainTime = PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart.remainTime
    else
      return
    end
  end
  local remainTime32 = Int64toInt32(remainTime)
  if remainTime32 <= 0 then
    return
  end
  if nil == PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart.functionKey then
    Panel_Widget_GuardianEffect:SetShow(true)
    PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart.functionKey = luaTimer_AddEvent(GuardianBuffEffectEnd, remainTime32, false)
  end
end
function GuardianBuffEffectTempShow()
  local buffFunc = PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart
  if nil ~= buffFunc and nil ~= buffFunc.functionKey and nil ~= buffFunc.remainTime then
    Panel_Widget_GuardianEffect:SetShow(true)
  end
end
function GuardianBuffEffectTempHide()
  local buffFunc = PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart
  if nil ~= buffFunc and nil ~= buffFunc.functionKey and nil ~= buffFunc.remainTime then
    Panel_Widget_GuardianEffect:SetShow(false)
  end
end
function GuardianBuffEffectEnd()
  PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart.functionKey = nil
  PaGlobalAppliedBuffList._buffFuctionList.GuardianBuffEffectStart.remainTime = nil
  Panel_Widget_GuardianEffect:SetShow(false)
end
registerEvent("EventSelfPlayerDead", "GuardianBuffEffectEnd")
