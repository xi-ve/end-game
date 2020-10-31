function PaGlobalFunc_CharInfoFootPrint_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._footPrint) then
    return
  end
  ToClient_RequestUserProfileInfo()
  PaGlobal_CharInfoFootPrint_All:dataClear()
  HandleEventLUp_CharInfoFootPrint_RadioButton(0)
  PaGlobal_CharInfoFootPrint_All:update()
end
function FromClient_CharInfoFootPrint_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._footPrint) then
    return
  end
  PaGlobal_CharInfoFootPrint_All:update()
end
function HandleEventLUp_CharInfoFootPrint_RadioButton(idx)
  if nil == idx then
    return
  end
  local self = PaGlobal_CharInfoFootPrint_All
  if nil ~= PaGlobal_CharInfoFootPrint_All._currentTabIdx and idx ~= PaGlobal_CharInfoFootPrint_All._currentTabIdx then
    self._ui.btn_RadioTable[PaGlobal_CharInfoFootPrint_All._currentTabIdx]:SetCheck(false)
  end
  PaGlobal_CharInfoFootPrint_All._currentTabIdx = idx
  self._ui.btn_RadioTable[idx]:SetCheck(true)
  self._ui.stc_selectLine:SetSpanSize(self._ui.btn_RadioTable[idx]:GetSpanSize().x, self._ui.stc_selectLine:GetSpanSize().y)
  PaGlobal_CharInfoFootPrint_All:update()
end
function HandleEventOnOut_CharInfoFootPrint_ShowPlayTime(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local ctrl, name
  ctrl = PaGlobal_CharInfoFootPrint_All._ui.stc_PlayTiemIcon
  name = PaGlobal_CharInfoFootPrint_All._playTimeString
  if nil ~= ctrl then
    PaGlobal_CharInfoFootPrint_All:update()
    TooltipSimple_Show(ctrl, name, nil)
  end
end
