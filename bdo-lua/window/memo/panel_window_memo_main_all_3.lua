function PaGlobalFunc_Memo_Main_All_CheckUiEdit(targetUI)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if nil == PaGlobal_Memo_All._currentFocusId then
    return false
  end
  local currentMemo = PaGlobal_Memo_All._stickyMemoList[PaGlobal_Memo_All._currentFocusId]
  if nil == currentMemo then
    return false
  end
  local currentEdit = PaGlobal_Memo_All._stickyMemoList[PaGlobal_Memo_All._currentFocusId]._ui._MultiLineText
  if nil ~= targetUI and targetUI:GetKey() == currentEdit:GetKey() then
    return true
  end
  return false
end
function PaGlobalFunc_Memo_Main_All_Open()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:prepareOpen()
end
function PaGlobalFunc_Memo_Main_All_Close()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:prepareClose()
end
function PaGlobalFunc_Memo_Main_All_Save(saveMode, inputId)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Save(saveMode, inputId)
end
function PaGlobalFunc_Memo_Main_All_ShowAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:memo_List_ShowAni()
end
function PaGlobalFunc_Memo_Main_All_HideAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:memo_List_HideAni()
end
function HandleEventLUp_Memo_Main_All_AddMemo()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:AddMemo()
end
function HandleEventLUp_Memo_Main_All_MemoRemoveAll()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:MemoRemoveAll()
end
function HandleEventLUp_Memo_Main_All_ListClose()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:ListClose()
end
function HandleEventLUp_Memo_Main_All_StickyClose(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyClose(id)
end
function HandleEventLPress_Memo_Main_All_StickyAlpahSlider(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyAlphaSlider(id)
end
function HandleEventLUp_Memo_Main_All_StickyAlpahSlider(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyAlphaSlider(id)
end
function HandleEventLDown_Memo_Main_All_StickyResizeStartPos(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResizeStartPos(id)
end
function HandleEventLPress_Memo_Main_All_StickyResize(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResize(id)
end
function HandleEventLUp_Memo_Main_All_StickyEnd(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResizeEnd(id)
end
function HandleEventLUp_Memo_Main_All_StickyClickedContent(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyClickedContent(id)
end
function HandleEventLUp_Memo_Main_All_MemoSave(saveMode, inputId)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Save(saveMode, inputId)
end
function HandleEventLUp_Memo_Main_All_Check_PopUI(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Check_PopUI(id)
end
function HandleEventLUp_Memo_Main_All_StickyToggleChangeColor(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleChangeColor(id)
end
function HandleEventLUp_Memo_Main_All_StickyChangeColorEnd(id, color)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyChangeColorEnd(id, color)
end
function HandleEventScrollUp_Memo_Main_All_OnMouseWheel(stickyMemoId, isUp)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:OnMouseWheel(stickyMemoId, isUp)
end
function HandleEventScrollDown_Memo_Main_All_OnMouseWheel(stickyMemoId, isUp)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:OnMouseWheel(stickyMemoId, isUp)
end
function HandleEventLDClick_Memo_Main_All_StickyToggleShow(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleShow(id)
end
function HandleEventLUp_Memo_Main_All_StickyToggleShow(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleShow(id)
end
function HandleEventLUp_Memo_Main_All_RemoveConfirmPopUp(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:RemoveConfirmPopUp(id)
end
function HandleEventMOn_Memo_Main_All_Tooltip_Show(uiType)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Tooltip_Show(uiType)
end
function HandleEventMOut_Memo_Main_All_Tooltip_Hide()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Tooltip_Hide()
end
