function PaGlobal_ProductNote_Search:initialize()
  if true == PaGlobal_ProductNote_Search._initialize then
    return
  end
  self._ui.edit_search = UI.getChildControl(Panel_ProductNote_Search, "Edit_Search_Guild")
  self._ui.stc_keyguideBG = UI.getChildControl(Panel_ProductNote_Search, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_keyguideA = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_A_ConsoleUI")
  self._ui.txt_keyguideB = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_B_ConsoleUI")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ProductNote_Search:registEventHandler()
  if nil == Panel_ProductNote_Search then
    return
  end
  registerEvent("onScreenResize", "FromClient_ProductNote_Search_Resize")
  Panel_ProductNote_Search:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobalFunc_ProductNote_Search_Confirm()")
  Panel_ProductNote_Search:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobalFunc_ProductNote_Search_SetSearchFocus()")
  self._ui.edit_search:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ProductNote_Search_OnVirtualKeyboardEnd")
end
function PaGlobal_ProductNote_Search:resize()
  if nil == Panel_ProductNote_Search then
    return
  end
  Panel_ProductNote_Search:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_ProductNote_Search:ComputePosAllChild()
end
function PaGlobal_ProductNote_Search:prepareOpen()
  if nil == Panel_ProductNote_Search then
    return
  end
  PaGlobal_ProductNote_Search._ui.edit_search:SetEditText("")
  PaGlobal_ProductNote_Search:resize()
  PaGlobal_ProductNote_Search:setAlignKeyGuide()
  PaGlobal_ProductNote_Search:open()
end
function PaGlobal_ProductNote_Search:open()
  if nil == Panel_ProductNote_Search then
    return
  end
  Panel_ProductNote_Search:SetShow(true)
end
function PaGlobal_ProductNote_Search:prepareClose()
  if nil == Panel_ProductNote_Search then
    return
  end
  PaGlobal_ProductNote_Search:close()
end
function PaGlobal_ProductNote_Search:close()
  if nil == Panel_ProductNote_Search then
    return
  end
  Panel_ProductNote_Search:SetShow(false)
end
function PaGlobal_ProductNote_Search:setAlignKeyGuide()
  local keyGuides = {
    self._ui.txt_keyguideA,
    self._ui.txt_keyguideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ProductNote_Search:validate()
  if nil == Panel_ProductNote_Search then
    return
  end
  self._ui.edit_search:isValidate()
  self._ui.stc_keyguideBG:isValidate()
  self._ui.txt_keyguideA:isValidate()
  self._ui.txt_keyguideB:isValidate()
end
