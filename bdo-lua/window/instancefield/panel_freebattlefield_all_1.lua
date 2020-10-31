function PaGlobal_FreeBaettleField_All:initialize()
  if true == PaGlobal_FreeBaettleField_All._initialize or nil == Panel_FreeBattleField_All then
    return
  end
  local topBg = UI.getChildControl(Panel_FreeBattleField_All, "Static_TitleBG")
  self._ui.btn_close = UI.getChildControl(topBg, "Button_Win_Close")
  self._ui.list2_FieldList = UI.getChildControl(Panel_FreeBattleField_All, "List2_ServerList")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_FreeBattleField_All, "Static_KeyGuide_Console")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.txt_desc = UI.getChildControl(Panel_FreeBattleField_All, "StaticText_Desc")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_FreeBaettleField_All:validate()
  PaGlobal_FreeBaettleField_All:registEventHandler(self._isConsole)
  PaGlobal_FreeBaettleField_All:swichPlatform(self._isConsole)
  PaGlobal_FreeBaettleField_All._initialize = true
end
function PaGlobal_FreeBaettleField_All:registEventHandler(isConsole)
  registerEvent("onScreenResize", "PaGlobalFunc_FreeBaettleField_All_OnScreenResize")
  registerEvent("FromClient_responseInstancePrivateRoomIndexByType", "FromClient_FreeBattleField_ListUpdate")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_FreeBaettleField_All_Close()")
  self._ui.list2_FieldList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_FreeBattleField_List2Update")
  self._ui.list2_FieldList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_FreeBaettleField_All:swichPlatform(isConsole)
  self._ui.btn_close:SetShow(not isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
end
function PaGlobal_FreeBaettleField_All:prepareOpen()
  PaGlobal_FreeBaettleField_All:open()
  ToClient_requestShadowArenaPrivateRoomList()
  PaGlobalFunc_FreeBaettleField_All_OnScreenResize()
end
function PaGlobal_FreeBaettleField_All:open()
  if nil == Panel_FreeBattleField_All then
    return
  end
  Panel_FreeBattleField_All:SetShow(true)
end
function PaGlobal_FreeBaettleField_All:prepareClose()
  if nil == Panel_FreeBattleField_All then
    return
  end
  PaGlobal_FreeBaettleField_All:close()
end
function PaGlobal_FreeBaettleField_All:close()
  if nil == Panel_FreeBattleField_All then
    return
  end
  Panel_FreeBattleField_All:SetShow(false)
end
function PaGlobal_FreeBaettleField_All:validate()
  if nil == Panel_FreeBattleField_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.list2_FieldList:isValidate()
  self._ui.stc_KeyGuide_Bg:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.txt_desc:isValidate()
end
