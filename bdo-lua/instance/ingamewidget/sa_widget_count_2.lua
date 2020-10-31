function FromClient_SA_Widget_Count_ReSizePanel()
  Panel_SA_Widget_Count:ComputePos()
  for ii = 1, 10 do
    PaGlobal_SA_Widget_Count._ui.stc_count[ii]:ComputePos()
  end
end
function FromClient_SA_Widget_Count_BattleRoyaleStateChanged(state)
  if 2 == state then
    PaGlobal_SA_Widget_Count_StartCount(10)
  end
end
function PaGlobal_SA_Widget_Count_StartCount(countTime)
  if nil == Panel_SA_Widget_Count then
    return
  end
  if nil == countTime then
    return
  end
  PaGlobal_SA_Widget_Count._currentCount = countTime
  Panel_SA_Widget_Count:RegisterUpdateFunc("PaGlobal_SA_Widget_Count_Update")
  PaGlobal_SA_Widget_Count:prepareOpen()
end
function PaGlobal_SA_Widget_Count_Update(deltaTime)
  if nil == Panel_SA_Widget_Count then
    return
  end
  if false == Panel_SA_Widget_Count:GetShow() then
    return
  end
  PaGlobal_SA_Widget_Count._currentCount = PaGlobal_SA_Widget_Count._currentCount - deltaTime
  if PaGlobal_SA_Widget_Count._currentCount <= 0 then
    Panel_SA_Widget_Count:ClearUpdateLuaFunc()
    PaGlobal_SA_Widget_Count:prepareClose()
    PaGlobal_SA_Widget_Wait_ChangeSurvival()
    return
  end
  PaGlobal_SA_Widget_Count._updateCurrentTime = PaGlobal_SA_Widget_Count._updateCurrentTime + deltaTime
  if PaGlobal_SA_Widget_Count._updateCurrentTime >= 1 then
    local ceilCurrentCount = math.ceil(PaGlobal_SA_Widget_Count._currentCount)
    PaGlobal_SA_Widget_Count:showCount(ceilCurrentCount)
    PaGlobal_SA_Widget_Count._updateCurrentTime = 0
    return
  end
end
