function MessageBoxPanelNilCheck()
  if false == _ContentsGroup_NewUI_MessageBox_All then
    if nil ~= Panel_Win_System then
      return true
    end
  elseif nil ~= Panel_Window_MessageBox_All then
    return true
  end
  return false
end
function MessageBoxGetShow()
  if false == _ContentsGroup_NewUI_MessageBox_All then
    if nil ~= Panel_Win_System then
      return Panel_Win_System:GetShow()
    end
  elseif nil ~= Panel_Window_MessageBox_All then
    return Panel_Window_MessageBox_All:GetShow()
  end
end
function MessageBoxCheckGetShow()
  if false == _ContentsGroup_NewUI_MessageBox_All then
    if nil ~= Panel_Win_Check then
      return Panel_Win_Check:GetShow()
    end
  elseif nil ~= Panel_Window_MessageBox_All then
    return Panel_Window_MessageBox_All:GetShow()
  end
end
