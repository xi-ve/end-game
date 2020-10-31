function PaGlobal_WareHouse_Search_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.frame_Result = UI.getChildControl(Panel_Window_WareHouse_Search, "Frame_Result")
  self._ui.edit_Search = UI.getChildControl(Panel_Window_WareHouse_Search, "Edit_Search")
  self._ui.btn_Search = UI.getChildControl(Panel_Window_WareHouse_Search, "Button_Search")
  self._ui.btn_Reset = UI.getChildControl(Panel_Window_WareHouse_Search, "Button_Reset")
  self._ui.frameContent = UI.getChildControl(self._ui.frame_Result, "Frame_1_Content")
  self._ui.stc_RegionName = UI.getChildControl(self._ui.frameContent, "StaticText_RegionName_Template")
  self._ui.stc_ItemSlotBg = UI.getChildControl(self._ui.frameContent, "Static_ItemSlotBg_Template")
  self._ui.txt_NoResult = UI.getChildControl(self._ui.frameContent, "StaticText_NoResult")
  local topBG = UI.getChildControl(Panel_Window_WareHouse_Search, "Static_TopBg")
  self._ui.btn_close = UI.getChildControl(topBG, "Button_Close_PCUI")
  self._ui.verticalScroll = UI.getChildControl(self._ui.frame_Result, "Frame_1_VerticalScroll")
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_WareHouse_Search, "Static_Keyguide_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_KeyGuide_Y_ConsoleUI")
  if true == _ContentsGroup_UsePadSnapping then
    local searchKeyGuide = UI.getChildControl(self._ui.edit_Search, "Static_KeyGuide_X_ConsoleUI")
    searchKeyGuide:SetShow(true)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_Reset:SetShow(false)
    local keyGuide = {
      self._ui.stc_keyGuideB,
      self._ui.stc_keyGuideY
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_WareHouse_Search_All:registEventHandler()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  self._ui.edit_Search:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_Search_All_ClickEdit()")
  self._ui.btn_Search:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_Search_All_RunSearch()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_WareHouse_Search:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_WareHouse_Search_All_RunReset()")
    Panel_Window_WareHouse_Search:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_WareHouse_Search_All_ClickEdit()")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Warehouse_Search_All_Close()")
    self._ui.btn_Reset:addInputEvent("Mouse_LUp", "HandleEventLUp_WareHouse_Search_All_RunReset()")
  end
  if true == ToClient_isConsole() then
    self._ui.edit_Search:setXboxVirtualKeyBoardEndEvent("HandleEventLUp_WareHouse_Search_All_RunSearch()")
  else
    self._ui.edit_Search:RegistReturnKeyEvent("HandleEventLUp_WareHouse_Search_All_RunSearch()")
  end
  registerEvent("FromClient_WarehouseUpdate", "FromClient_WareHouse_Search_All_Update")
  registerEvent("EventGuildWarehouseUpdate", "FromClient_WareHouse_Search_All_Update")
  registerEvent("EventWarehouseUpdate", "FromClient_WareHouse_Search_All_Update")
  self._ui.frame_Result:UpdateContentScroll()
  self._ui.frame_Result:UpdateContentPos()
  self._ui.verticalScroll:SetControlPos(0)
end
function PaGlobal_WareHouse_Search_All:prepareOpen()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  Panel_Window_WareHouse_Search:ignorePadSnapMoveToOtherPanelUpdate(true)
  HandleEventLUp_WareHouse_Search_All_RunReset()
  PaGlobal_WareHouse_Search_All:open()
end
function PaGlobal_WareHouse_Search_All:open()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  Panel_Window_WareHouse_Search:SetShow(true, true)
end
function PaGlobal_WareHouse_Search_All:prepareClose()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  Panel_Window_WareHouse_Search:ignorePadSnapMoveToOtherPanelUpdate(false)
  self:close()
end
function PaGlobal_WareHouse_Search_All:close()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  Panel_Window_WareHouse_Search:SetShow(false, false)
end
function PaGlobal_WareHouse_Search_All:update()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
end
function PaGlobal_WareHouse_Search_All:validate()
  if nil == Panel_Window_WareHouse_Search then
    return
  end
  local self = PaGlobal_WareHouse_Search_All
  self._ui.edit_Search:isValidate()
  self._ui.btn_Search:isValidate()
  self._ui.btn_Reset:isValidate()
end
function PaGlobal_WareHouse_Search_All:clearSearch()
  self._ui.txt_NoResult:SetShow(false)
  self._ui.edit_Search:SetEditText("", true)
  self._ui.stc_RegionName:SetShow(false)
  for index = 1, self._slotCount do
    self._itemSlot[index].slot:clearItem()
    self._itemSlot[index].slotBG:SetShow(false)
  end
  self._startSlotIndex = 0
  FromClient_Warehouse_All_Update()
end
