function PaGlobal_ChangeItem_All:initialize()
  if true == PaGlobal_ChangeItem_All._initialize then
    return
  end
  PaGlobal_ChangeItem_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ChangeItem_All:controlAll_Init()
  PaGlobal_ChangeItem_All:controlPc_Init()
  PaGlobal_ChangeItem_All:controlConsole_Init()
  PaGlobal_ChangeItem_All:resize()
  PaGlobal_ChangeItem_All:controlSetShow()
  PaGlobal_ChangeItem_All:registEventHandler()
  PaGlobal_ChangeItem_All:validate()
  PaGlobal_ChangeItem_All._initialize = true
end
function PaGlobal_ChangeItem_All:controlAll_Init()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  PaGlobal_ChangeItem_All._ui.stc_titleBg = UI.getChildControl(Panel_Window_ChangeItem_All, "Static_TitleBg")
  PaGlobal_ChangeItem_All._ui.stc_subBg = UI.getChildControl(Panel_Window_ChangeItem_All, "Static_SubBG")
  PaGlobal_ChangeItem_All._ui.stc_backPanel = UI.getChildControl(Panel_Window_ChangeItem_All, "Static_BackPanel")
  PaGlobal_ChangeItem_All._ui.stc_backEffect = UI.getChildControl(Panel_Window_ChangeItem_All, "Static_BackEffect")
  PaGlobal_ChangeItem_All._ui.txt_target = UI.getChildControl(Panel_Window_ChangeItem_All, "StaticText_Slot1")
  PaGlobal_ChangeItem_All._ui.txt_result = UI.getChildControl(Panel_Window_ChangeItem_All, "StaticText_Slot2")
  PaGlobal_ChangeItem_All._ui.stc_targetSlot = UI.getChildControl(Panel_Window_ChangeItem_All, "equipIcon_1")
  PaGlobal_ChangeItem_All._ui.stc_resultSlot = UI.getChildControl(Panel_Window_ChangeItem_All, "equipIcon_2")
  PaGlobal_ChangeItem_All._ui.stc_backEffect:SetShow(false)
  SlotItem.new(PaGlobal_ChangeItem_All._equipSlot, "ChangeWeapon_equipSlot", 0, PaGlobal_ChangeItem_All._ui.stc_targetSlot, PaGlobal_ChangeItem_All._slotConfig)
  PaGlobal_ChangeItem_All._equipSlot:createChild()
  PaGlobal_ChangeItem_All._equipSlot.icon:SetPosX(0)
  PaGlobal_ChangeItem_All._equipSlot.icon:SetPosY(0)
  SlotItem.new(PaGlobal_ChangeItem_All._resultSlot, "ChangeWeapon_avatarSlot", 0, PaGlobal_ChangeItem_All._ui.stc_resultSlot, PaGlobal_ChangeItem_All._slotConfig)
  PaGlobal_ChangeItem_All._resultSlot:createChild()
  PaGlobal_ChangeItem_All._resultSlot.icon:SetPosX(0)
  PaGlobal_ChangeItem_All._resultSlot.icon:SetPosY(0)
  if false == self._isConsole then
    PaGlobal_ChangeItem_All._equipSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ChangeItem_All_IconOver( true, " .. 0 .. " )")
    PaGlobal_ChangeItem_All._equipSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ChangeItem_All_IconOver( false, " .. 0 .. " )")
    PaGlobal_ChangeItem_All._equipSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ChangeItem_All_EquipSlotClear()")
    PaGlobal_ChangeItem_All._resultSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ChangeItem_All_IconOver( true, " .. 1 .. " )")
    PaGlobal_ChangeItem_All._resultSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ChangeItem_All_IconOver( false, " .. 1 .. " )")
  else
    PaGlobal_ChangeItem_All._ui.stc_targetSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PadEventXUp_ChangeItem_All_ItemToolTip(" .. 0 .. ")")
    PaGlobal_ChangeItem_All._ui.stc_resultSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PadEventXUp_ChangeItem_All_ItemToolTip(" .. 1 .. " )")
  end
end
function PaGlobal_ChangeItem_All:controlPc_Init()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  PaGlobal_ChangeItem_All._ui_pc.btn_close = UI.getChildControl(PaGlobal_ChangeItem_All._ui.stc_titleBg, "Button_CloseIcon")
  PaGlobal_ChangeItem_All._ui_pc.btn_apply = UI.getChildControl(Panel_Window_ChangeItem_All, "Button_Apply_PCUI")
end
function PaGlobal_ChangeItem_All:controlConsole_Init()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_ChangeItem_All, "Static_BottomBg_ConsoleUI")
  PaGlobal_ChangeItem_All._ui_console.stc_guideX = UI.getChildControl(PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg, "StaticText_X_ConsoleUI")
  PaGlobal_ChangeItem_All._ui_console.stc_guideY = UI.getChildControl(PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg, "StaticText_Y_ConsoleUI")
  PaGlobal_ChangeItem_All._ui_console.stc_guideB = UI.getChildControl(PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_ChangeItem_All:controlSetShow()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  if false == PaGlobal_ChangeItem_All._isConsole then
    PaGlobal_ChangeItem_All._ui_pc.btn_close:SetShow(true)
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetShow(true)
    PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    PaGlobal_ChangeItem_All._ui_pc.btn_close:SetShow(false)
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetShow(false)
    PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg:SetShow(true)
  end
end
function PaGlobal_ChangeItem_All:prepareOpen(whereType, SlotNo)
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  Panel_Window_ChangeItem_All:RegisterUpdateFunc("PaGlobalFunc_ChangeItem_All_updateTime")
  PaGlobal_ChangeItem_All:clearAllSlot()
  PaGlobal_ChangeItem_All._materialItemSlotNo = SlotNo
  PaGlobal_ChangeItem_All._materialItemWhereType = whereType
  Inventory_SetFunctor(PaGlobalFunc_ChangeItem_All_SetFilter, HandleEventRUp_ChangeItem_All_InvenRClick, nil, nil)
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_SetShow(true)
  else
    Inventory_SetShow(true)
  end
  Panel_Window_ChangeItem_All:ignorePadSnapUpdate(false)
  PaGlobal_ChangeItem_All:open()
end
function PaGlobal_ChangeItem_All:open()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  Panel_Window_ChangeItem_All:SetShow(true, true)
end
function PaGlobal_ChangeItem_All:prepareClose()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  if true == PaGlobal_ChangeItem_All._doChange then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEITEM_DONOT_CLOSE"))
    return
  end
  Panel_Window_ChangeItem_All:ClearUpdateLuaFunc()
  PaGlobal_ChangeItem_All:clearAllSlot()
  PaGlobal_ChangeItem_All._materialItemSlotNo = nil
  PaGlobal_ChangeItem_All._materialItemWhereType = nil
  Inventory_SetFunctor(nil, nil, nil, nil)
  PaGlobal_ChangeItem_All:close()
end
function PaGlobal_ChangeItem_All:close()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  Panel_Window_ChangeItem_All:SetShow(false, false)
end
function PaGlobal_ChangeItem_All:registEventHandler()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  registerEvent("FromClient_UseItemExchangeToClass", "FromClient_UseItemExchangeToClass_ChangeItem_All")
  registerEvent("FromClient_UseItemExchangeToClassNotify", "FromClient_UseItemExchangeToClassNotify_ChangeItem_All")
  if false == PaGlobal_ChangeItem_All._isConsole then
    PaGlobal_ChangeItem_All._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChangeItem_All_Close()")
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_ChangeItem_All_Apply()")
  else
    Panel_Window_ChangeItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ChangeItem_All_Apply()")
    Panel_Window_ChangeItem_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_ChangeItem_All_Close()")
  end
  Panel_Window_ChangeItem_All:RegisterShowEventFunc(true, "PaGlobalFunc_ChangeItem_All_ShowAni()")
  Panel_Window_ChangeItem_All:RegisterShowEventFunc(false, "PaGlobalFunc_ChangeItem_All_HideAni()")
end
function PaGlobal_ChangeItem_All:validate()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  PaGlobal_ChangeItem_All._ui.stc_titleBg:isValidate()
  PaGlobal_ChangeItem_All._ui.stc_subBg:isValidate()
  PaGlobal_ChangeItem_All._ui.stc_backPanel:isValidate()
  PaGlobal_ChangeItem_All._ui.stc_backEffect:isValidate()
  PaGlobal_ChangeItem_All._ui.txt_target:isValidate()
  PaGlobal_ChangeItem_All._ui.txt_result:isValidate()
  PaGlobal_ChangeItem_All._ui.stc_targetSlot:isValidate()
  PaGlobal_ChangeItem_All._ui.stc_resultSlot:isValidate()
  PaGlobal_ChangeItem_All._ui_pc.btn_close:isValidate()
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:isValidate()
  PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg:isValidate()
  PaGlobal_ChangeItem_All._ui_console.stc_guideY:isValidate()
  PaGlobal_ChangeItem_All._ui_console.stc_guideB:isValidate()
end
function PaGlobal_ChangeItem_All:resize()
  if nil == Panel_Window_ChangeItem_All then
    return
  end
  if true == PaGlobal_ChangeItem_All._isConsole then
    Panel_Window_ChangeItem_All:SetSize(Panel_Window_ChangeItem_All:GetSizeX(), PaGlobal_ChangeItem_All._resize.console.panelY)
    PaGlobal_ChangeItem_All._ui.stc_subBg:SetSize(PaGlobal_ChangeItem_All._ui.stc_subBg:GetSizeX(), PaGlobal_ChangeItem_All._resize.console.subBgY)
    PaGlobal_ChangeItem_All._ui.txt_result:SetSpanSize(PaGlobal_ChangeItem_All._ui.txt_result:GetSpanSize().x, PaGlobal_ChangeItem_All._resize.console.resultTxtSpanY)
    PaGlobal_ChangeItem_All._ui.txt_result:ComputePos()
    PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg:ComputePos()
    local keyGuideList = {
      PaGlobal_ChangeItem_All._ui_console.stc_guideX,
      PaGlobal_ChangeItem_All._ui_console.stc_guideY,
      PaGlobal_ChangeItem_All._ui_console.stc_guideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, PaGlobal_ChangeItem_All._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_AUTO_WRAP_LEFT)
  else
    Panel_Window_ChangeItem_All:SetSize(Panel_Window_ChangeItem_All:GetSizeX(), PaGlobal_ChangeItem_All._resize.pc.panelY)
    PaGlobal_ChangeItem_All._ui.stc_subBg:SetSize(PaGlobal_ChangeItem_All._ui.stc_subBg:GetSizeX(), PaGlobal_ChangeItem_All._resize.pc.subBgY)
    PaGlobal_ChangeItem_All._ui.txt_result:SetSpanSize(PaGlobal_ChangeItem_All._ui.txt_result:GetSpanSize().x, PaGlobal_ChangeItem_All._resize.pc.resultTxtSpanY)
    PaGlobal_ChangeItem_All._ui.txt_result:ComputePos()
  end
end
function PaGlobal_ChangeItem_All:clearAllSlot()
  PaGlobal_ChangeItem_All._selectedItemSlotNo = nil
  PaGlobal_ChangeItem_All._selectedItemWhereType = nil
  PaGlobal_ChangeItem_All._elapsTime = 0
  PaGlobal_ChangeItem_All._doChange = false
  PaGlobal_ChangeItem_All._isChangeDoing = false
  PaGlobal_ChangeItem_All._sound_ani_flag = false
  PaGlobal_ChangeItem_All._equipSlot:clearItem(true)
  PaGlobal_ChangeItem_All._resultSlot:clearItem(true)
  PaGlobal_ChangeItem_All._resultSlot.icon:EraseAllEffect()
  PaGlobal_ChangeItem_All._ui.stc_backPanel:EraseAllEffect()
  audioPostEvent_SystemUi(5, 99)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetMonoTone(true, true)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetEnable(false)
  PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetIgnore(true)
end
function PaGlobal_ChangeItem_All:applyChangeItem()
  if nil == PaGlobal_ChangeItem_All._selectedItemWhereType or nil == PaGlobal_ChangeItem_All._selectedItemSlotNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGEWEAPON_SELECTITEM"))
    return
  end
  local changeGo = function()
    PaGlobal_ChangeItem_All._elapsTime = 0
    PaGlobal_ChangeItem_All._doChange = true
    PaGlobal_ChangeItem_All._isChangeDoing = true
    PaGlobal_ChangeItem_All._sound_ani_flag = true
    audioPostEvent_SystemUi(5, 78)
    _AudioPostEvent_SystemUiForXBOX(13, 15)
    PaGlobal_ChangeItem_All._ui.stc_backPanel:AddEffect("fUI_ChangeWeapon_01A", true, 0, 0)
    Panel_Window_ChangeItem_All:ignorePadSnapUpdate(true)
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetMonoTone(true, true)
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetEnable(false)
    PaGlobal_ChangeItem_All._ui_pc.btn_apply:SetIgnore(true)
    Inventory_SetFunctor(PaGlobalFunc_ChangeItem_All_SetFilterIgnore, nil, nil, nil)
  end
  local meterialItemWrapper = getInventoryItemByType(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo)
  local materialItemName = meterialItemWrapper:getStaticStatus():getName()
  local itemKey = meterialItemWrapper:get():getKey()
  local toItemWrapper = getExchangeItem(PaGlobal_ChangeItem_All._selectedItemWhereType, PaGlobal_ChangeItem_All._selectedItemSlotNo, PaGlobal_ChangeItem_All._materialItemWhereType, PaGlobal_ChangeItem_All._materialItemSlotNo)
  local resultItemName = toItemWrapper:getStaticStatus():getName()
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHANGEWEAPON_TITLE")
  local _contenet = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CHANGEITEM_MESSAGEDESC", "materialItem", materialItemName, "resultItem", resultItemName)
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = changeGo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
