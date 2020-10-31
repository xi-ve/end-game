function PaGlobal_SA_Widget_KillMark_Open(data)
  PaGlobal_SA_Widget_KillMark:prepareOpen(data)
end
function PaGlobal_SA_Widget_KillMark_Close()
  PaGlobal_SA_Widget_KillMark:prepareClose()
end
function FromClient_SA_Widget_KillMark_UpdatePerFrame(deltaTime)
  PaGlobal_SA_Widget_KillMark:updatePerFrame(deltaTime)
end
function FromClient_SA_Widget_KillMark_ReSizePanel()
  Panel_SA_Widget_KillMark:ComputePos()
  PaGlobal_SA_Widget_KillMark._ui.stc_effectSlot:ComputePos()
  PaGlobal_SA_Widget_KillMark._ui.txt_killMessage:ComputePos()
end
function PaGlobal_SA_Widget_KillMark_ShowAni()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
end
function PaGlobal_SA_Widget_KillMark_HideAni()
  if nil == Panel_SA_Widget_KillMark then
    return
  end
end
