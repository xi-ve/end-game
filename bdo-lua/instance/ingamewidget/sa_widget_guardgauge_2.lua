function FromClient_SA_Widget_GuardGauge_ReSizePanel()
  PaGlobal_SA_Widget_GuardGauge._ui.stc_guardGaugeBg:ComputePos()
  PaGlobal_SA_Widget_GuardGauge._ui.progress_guard:ComputePos()
  PaGlobal_SA_Widget_GuardGauge._ui.txt_guardGaugeText:ComputePos()
end
function PaGlobal_SA_Widget_GuardGauge_Update()
  if nil == Panel_SA_Widget_GuardGauge then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil ~= selfPlayerWrapper then
    local sp = selfPlayerWrapper:get():getCurrentGuard()
    local maxSp = selfPlayerWrapper:get():getMaxGuard()
    if sp == maxSp then
      PaGlobal_SA_Widget_GuardGauge._ui.stc_guardGaugeBg:EraseAllEffect()
      PaGlobal_SA_Widget_GuardGauge:prepareClose()
      return
    end
    local spRate = sp / maxSp
    local fullGauge = spRate * 100
    local alpha = (1 - spRate) * 15
    if 1 < alpha then
      alpha = 1
    end
    Panel_SA_Widget_GuardGauge:SetAlphaChild(alpha)
    PaGlobal_SA_Widget_GuardGauge._ui.progress_guard:SetProgressRate(fullGauge)
    PaGlobal_SA_Widget_GuardGauge._ui.txt_guardGaugeText:SetFontAlpha(alpha)
    PaGlobal_SA_Widget_GuardGauge._ui.txt_guardGaugeText:SetText(tostring(math.floor(spRate * 100)))
    if false == Panel_SA_Widget_GuardGauge:GetShow() then
      PaGlobal_SA_Widget_GuardGauge:prepareOpen()
    end
  end
end
function PaGlobal_SA_Widget_GuardGauge_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_SA_Widget_GuardGauge, 0, 0.3)
  aniInfo:SetHideAtEnd(true)
end
