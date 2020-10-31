function HandleEventLUp_Widget_ThornCastle_Enter_Join_Othilita()
  if nil == PaGlobal_ThornCastle_Member then
    return
  end
  PaGlobal_ThornCastle_Enter:prepareCloseJoinMessageBox()
  PaGlobal_ThornCastle_Enter:requestJoinRandomMatching()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Cancel()
  PaGlobal_ThornCastle_Enter:prepareCloseJoinMessageBox()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Matching_Cancel()
  PaGlobal_ThornCastle_Enter:prepareCloseMatchingBox()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Open()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return
  end
  PaGlobal_ThornCastle_Enter:prepareOpenJoinMessageBox()
end
