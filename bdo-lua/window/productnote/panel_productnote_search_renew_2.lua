function PaGlobalFunc_ProductNote_Search_Open()
  PaGlobal_ProductNote_Search:prepareOpen()
end
function PaGlobalFunc_ProductNote_Search_Close()
  PaGlobal_ProductNote_Search:prepareClose()
end
function FromClient_ProductNote_Search_Resize()
  if nil == Panel_ProductNote_Search then
    return
  end
  PaGlobal_ProductNote_Search:resize()
end
function PaGlobalFunc_ProductNote_Search_Confirm()
  local keyword = PaGlobal_ProductNote_Search._ui.edit_search:GetEditText()
  Panel_ProductNote_SearchEvent(keyword)
  PaGlobalFunc_ProductNote_Search_Close()
end
function PaGlobalFunc_ProductNote_Search_SetSearchFocus()
  if nil == Panel_ProductNote_Search then
    return
  end
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_ProductNote_Search._ui.edit_search)
end
function PaGlobalFunc_ProductNote_Search_OnVirtualKeyboardEnd(str)
  if nil == Panel_ProductNote_Search then
    return
  end
  PaGlobal_ProductNote_Search._ui.edit_search:SetEditText(str)
  ClearFocusEdit()
end
