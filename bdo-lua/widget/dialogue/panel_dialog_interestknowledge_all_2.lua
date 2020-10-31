function PaGlobalFunc_InterestKnowledge_All_Open()
  PaGlobal_InterestKnowledge_All:prepareOpen()
end
function PaGlobalFunc_InterestKnowledge_All_Close()
  PaGlobal_InterestKnowledge_All:prepareClose()
end
function HandleRSticEventUp_DialogInterestKnowledge_All_MoveScroll(flag)
  if nil == Panel_Interest_Knowledge_All or false == Panel_Interest_Knowledge_All:GetShow() then
    return
  end
  if nil == PaGlobal_InterestKnowledge_All._ui.list2 then
    return
  end
  if 1 == flag then
    PaGlobal_InterestKnowledge_All._ui.list2:MouseUpScroll(PaGlobal_InterestKnowledge_All._ui.list2)
  elseif -1 == flag then
    PaGlobal_InterestKnowledge_All._ui.list2:MouseDownScroll(PaGlobal_InterestKnowledge_All._ui.list2)
  end
end
function PaGloabl_InterestKnowledge_All_ShowAni()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
end
function PaGloabl_InterestKnowledge_All_HideAni()
  if nil == Panel_Interest_Knowledge_All then
    return
  end
end
