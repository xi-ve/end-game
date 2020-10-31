function PaGlobalFunc_ButtonShorcuts_All_Open(index)
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  PaGlobal_ButtonShortcuts_All:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.ListOnly.index)
  PaGlobal_ButtonShortcuts_All:prepareOpen(index)
end
function PaGlobalFunc_ButtonShorcuts_All_Close()
  if nil == Panel_Window_ButtonShortcuts_All then
    return
  end
  PaGlobal_ButtonShortcuts_All:prepareClose()
end
function HandleEventLUp_ButtonShortcuts_All_ChangeShortcuts(id)
  if nil ~= PaGlobal_ButtonShortcuts_All._curId and PaGlobal_ButtonShortcuts_All._curId >= 0 then
    local tempId = PaGlobal_ButtonShortcuts_All._curId
    PaGlobal_ButtonShortcuts_All._curId = id
    PaGlobal_ButtonShortcuts_All._ui.list2_keySet:requestUpdateByKey(toInt64(0, tempId))
  end
  PaGlobal_ButtonShortcuts_All._curId = id
  PaGlobal_ButtonShortcuts_All._curButtonsShortcuts = ToClent_getButtonShortcutsEventAt(id)
  PaGlobal_ButtonShortcuts_All._ui.list2_keySet:requestUpdateByKey(toInt64(0, PaGlobal_ButtonShortcuts_All._curId))
  ClearFocusEdit()
  PaGlobal_NewShortCut_SetEasyShortCut(id)
end
function HandleEventLUp_ButtonShortcuts_All_DeleteShortcuts(id)
  PaGlobal_ButtonShortcuts_All._curId = id
  PaGlobal_ButtonShortcuts_All._curButtonsShortcuts = ToClent_getButtonShortcutsEventAt(id)
  PaGlobalFunc_ButtonShorcuts_All_RemoveByGlobalKeyBinder()
end
function HandleEventLUp_ButtonShortcuts_All_SetDefault()
  FGlobal_NewShortCut_Close()
  PaGlobal_ButtonShortcuts_All:setDefault()
end
function HandleEventLUp_ButtonShortcuts_All_ClickedChangeShortcuts()
  PaGlobal_ButtonShortcuts_All:clickedChangeShortcuts()
end
function HandleEventLUp_ButtonShortcuts_All_ToggleAllView()
  TooltipSimple_Hide()
  PaGlobal_ButtonShortcuts_All._searchText = ""
  PaGlobal_ButtonShortcuts_All:listRefresh()
  ClearFocusEdit()
end
function HandleEventLUp_ButtonShortcuts_All_ApplySearch()
  PaGlobal_ButtonShortcuts_All._searchText = PaGlobal_ButtonShortcuts_All._ui.edit_search:GetEditText()
  PaGlobal_ButtonShortcuts_All:uiRefresh()
  ClearFocusEdit()
end
function HandleEventLUp_ButtonShortcuts_All_EditSearch()
  PaGlobal_ButtonShortcuts_All._ui.edit_search:SetEditText("")
  PaGlobal_ButtonShortcuts_All._searchText = ""
end
function HandleEventLUp_ButtonShortcuts_All_ChangeAllViewMode()
  PaGlobal_ButtonShortcuts_All:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.List.index)
  PaGlobal_ButtonShortcuts_All:resize()
end
function HandleEventOnOut_ButtonShortcuts_All_SimpleTooltips(isShow, tipType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_LIST")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_LIST_DESC")
    control = PaGlobal_ButtonShortcuts_All._ui.btn_allView
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_RESET")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_RESET_DESC")
    control = PaGlobal_ButtonShortcuts_All._ui.btn_reset
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUTTONSHORTCUT_ALL_VIEW")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUTTONSHORTCUT_ALL_VIEW_DESC")
    control = PaGlobal_ButtonShortcuts_All._ui.chk_all
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_ButtonShortcuts_All_OpenButtonShortcuts(index)
  PaGlobal_ButtonShortcuts_All:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.List.index)
  PaGlobal_ButtonShortcuts_All:changeUI(PaGlobal_ButtonShortcuts_All._UIMODE.Current.index)
  PaGlobal_ButtonShortcuts_All:prepareOpen(index)
end
function PaGlobalFunc_ButtonShorcuts_All_ListControlCreate(content, key)
  PaGlobal_ButtonShortcuts_All:listControlCreate(content, key)
end
function PaGlobalFunc_ButtonShorcuts_All_RegisterOk()
  ToClent_addButtonShortcutsEvent(PaGlobal_ButtonShortcuts_All._curButtonsShortcuts, PaGlobal_ButtonShortcuts_All._registerKey)
  PaGlobal_ButtonShortcuts_All:uiRefresh()
  PaGlobal_ButtonShortcuts_All._curButtonsShortcuts = nil
  FGlobal_NewShortCut_Close()
end
function PaGlobalFunc_ButtonShorcuts_All_Refresh()
  PaGlobal_ButtonShortcuts_All:uiRefresh()
  PaGlobal_ButtonShortcuts_All._curButtonsShortcuts = nil
end
function PaGlobal_ButtonShortcuts_All_CurrentRefresh()
  local saveCurId = PaGlobal_ButtonShortcuts_All._curId
  PaGlobal_ButtonShortcuts_All:uiRefresh(PaGlobal_ButtonShortcuts_All._curId)
  PaGlobal_ButtonShortcuts_All._curId = saveCurId
end
function PaGlobalFunc_ButtonShorcuts_All_SetDefault()
  ToClent_setDefaultButtonShortcuts()
  PaGlobal_ButtonShortcuts_All._curId = -1
  PaGlobal_ButtonShortcuts_All._ui.list2_keySet:requestUpdateVisible()
  ClearFocusEdit()
end
function PaGlobalFunc_ButtonShorcuts_All_UiRefreshByGlobalKeyBinder(index)
  PaGlobal_ButtonShortcuts_All:uiRefresh(index)
end
function PaGlobalFunc_ButtonShorcuts_All_RemoveByGlobalKeyBinder()
  PaGlobal_ButtonShortcuts_All:remove()
end
function PaGlobalFunc_ButtonShorcuts_All_Register(VirtualKeyCode)
  PaGlobal_ButtonShortcuts_All:register(VirtualKeyCode)
end
function PaGlobalFunc_ButtonShortcuts_All_CheckUiEdit(uiEdit)
  if nil == PaGlobal_ButtonShortcuts_All._ui or nil == PaGlobal_ButtonShortcuts_All._ui.edit_search then
    return false
  end
  if false == Panel_Window_ButtonShortcuts_All:GetShow() then
    return false
  end
  if uiEdit:GetKey() == PaGlobal_ButtonShortcuts_All._ui.edit_search:GetKey() then
    return true
  end
  return false
end
