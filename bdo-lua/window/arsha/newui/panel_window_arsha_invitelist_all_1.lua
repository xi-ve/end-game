function PaGlobal_Arsha_InviteList_All:initialize()
  if true == PaGlobal_Arsha_InviteList_All._initialize or nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Arsha_InviteList_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Arsha_InviteList_All, "Static_MainBG")
  self._ui.stc_listTitleBg = UI.getChildControl(Panel_Window_Arsha_InviteList_All, "Static_SelectedPlayerTitleListBG")
  self._ui.txt_titleLevel = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_Select_Level")
  self._ui.txt_titleClass = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_Select_Class")
  self._ui.txt_titleName = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_Select_Name")
  self._ui.txt_titleKind = UI.getChildControl(self._ui.stc_listTitleBg, "StaticText_Select_KindOf")
  self._ui.list2_invite = UI.getChildControl(Panel_Window_Arsha_InviteList_All, "List2_ArshaInviteList")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_Arsha_InviteList_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_keyGuideX = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui_console.txt_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_InviteList_All:validate()
  PaGlobal_Arsha_InviteList_All:registEventHandler()
  PaGlobal_Arsha_InviteList_All:swichPlatform(self._isConsole)
  PaGlobal_Arsha_InviteList_All._initialize = true
end
function PaGlobal_Arsha_InviteList_All:swichPlatform(isConsole)
  self._ui.btn_close:SetShow(not isConsole)
  self._ui_console.stc_keyGuideBg:SetShow(isConsole)
  if true == isConsole then
    self:setAlignKeyGuide()
  end
end
function PaGlobal_Arsha_InviteList_All:prepareOpen()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  PaGlobal_Arsha_InviteList_All:open()
  PaGlobal_Arsha_InviteList_All:update()
  PaGlobal_Arsha_InviteList_All:resize()
end
function PaGlobal_Arsha_InviteList_All:open()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  Panel_Window_Arsha_InviteList_All:SetShow(true)
end
function PaGlobal_Arsha_InviteList_All:prepareClose()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  PaGlobal_Arsha_InviteList_All:close()
end
function PaGlobal_Arsha_InviteList_All:close()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  Panel_Window_Arsha_InviteList_All:SetShow(false)
end
function PaGlobal_Arsha_InviteList_All:update()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  self:listUpdate()
end
function PaGlobal_Arsha_InviteList_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Arsha_InviteList_All._ui_console.txt_keyGuideY,
    PaGlobal_Arsha_InviteList_All._ui_console.txt_keyGuideX,
    PaGlobal_Arsha_InviteList_All._ui_console.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Arsha_InviteList_All._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_InviteList_All:listUpdate()
  local listCount = ToClient_GetJoinRequesterListCount()
  self._ui.list2_invite:getElementManager():clearKey()
  if 0 < listCount then
    for idx = 0, listCount - 1 do
      self._ui.list2_invite:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  if true == self._isConsole then
    if 0 == listCount then
      self._ui_console.txt_keyGuideY:SetShow(false)
      self._ui_console.txt_keyGuideX:SetShow(false)
    else
      self._ui_console.txt_keyGuideY:SetShow(true)
      self._ui_console.txt_keyGuideX:SetShow(true)
    end
    self:setAlignKeyGuide()
  end
end
function PaGlobal_Arsha_InviteList_All:registEventHandler()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Arsha_InviteList_All_Close()")
  self._ui.list2_invite:changeAnimationSpeed(10)
  self._ui.list2_invite:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ArshaInviteList_All_ListUpdate")
  self._ui.list2_invite:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdateJoinRequesterList", "FromClient_ArshaInviteList_All_UpdateJoinRequesterList")
end
function PaGlobal_Arsha_InviteList_All:validate()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.stc_listTitleBg:isValidate()
  self._ui.txt_titleLevel:isValidate()
  self._ui.txt_titleClass:isValidate()
  self._ui.txt_titleName:isValidate()
  self._ui.txt_titleKind:isValidate()
  self._ui.list2_invite:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.txt_keyGuideY:isValidate()
  self._ui_console.txt_keyGuideX:isValidate()
  self._ui_console.txt_keyGuideB:isValidate()
end
function PaGlobal_Arsha_InviteList_All:resize()
  if nil == Panel_Window_Arsha_InviteList_All then
    return
  end
  Panel_Window_Arsha_InviteList_All:ComputePos()
end
