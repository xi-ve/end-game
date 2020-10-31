function PaGlobal_TotalRewardHistory_All_Open()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All:prepareOpen()
end
function PaGlobal_TotalRewardHistory_All_Close()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All:prepareClose()
end
function PaGlobal_TotalRewardHistory_All_Update()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  PaGlobal_TotalRewardHistory_All:update()
end
function PaGlobal_TotalRewardHistory_All_ToggleShow()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return
  end
  if true == PaGlobal_TotalRewardHistory_All._mainControl:GetShow() then
    PaGlobal_TotalRewardHistory_All_Close()
  else
    PaGlobal_TotalRewardHistory_All_Open()
  end
end
function PaGlobal_TotalRewardHistory_All_IsShow()
  if nil == PaGlobal_TotalRewardHistory_All._mainControl then
    return nil
  end
  return PaGlobal_TotalRewardHistory_All._mainControl:GetShow()
end
function FromClient_TotalRewardHistory_All_PendingRewardLogUpdated()
  PaGlobal_TotalRewardHistory_All:update()
end
