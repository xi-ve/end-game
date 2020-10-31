function PaGlobal_SA_Widget_KeyInfo_Open()
  PaGlobal_SA_Widget_KeyInfo:prepareOpen()
end
function PaGlobal_SA_Widget_KeyInfo_Close()
  PaGlobal_SA_Widget_KeyInfo:prepareClose()
end
function FromClient_SA_Widget_KeyInfo_ReSizePanel()
  PaGlobal_SA_Widget_KeyInfo._ui.stc_invenBG:ComputePos()
  PaGlobal_SA_Widget_KeyInfo._ui.txt_inven:ComputePos()
  PaGlobal_SA_Widget_KeyInfo._ui.stc_invenKey:ComputePos()
  PaGlobal_SA_Widget_KeyInfo._ui.stc_EscBG:ComputePos()
  PaGlobal_SA_Widget_KeyInfo._ui.txt_Esc:ComputePos()
  PaGlobal_SA_Widget_KeyInfo._ui.stc_EscKey:ComputePos()
end
function PaGlobal_SA_Widget_KeyInfo_ShowAni()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
end
function PaGlobal_SA_Widget_KeyInfo_HideAni()
  if nil == Panel_SA_Widget_KeyInfo then
    return
  end
end
