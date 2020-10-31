function PaGlobal_AlchemyFigureHead_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:initUiSetting()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AlchemyFigureHead_All:registEventHandler()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_AlchemyFigureHead_All_ReSizePanel()")
  registerEvent("FromClient_ItemUpgrade", "FromClient_AlchemyFigureHead_AllUpgrade")
  registerEvent("FromClient_StoneChange", "FromClient_AlchemyFigureHead_AllChange")
  registerEvent("FromClient_StoneChangeFailedByDown", "FromClient_AlchemyFigureHead_AllChangeFailedByDown")
  registerEvent("FromClient_AlchemyEvolve", "FromClient_AlchemyFigureHead_AllEvolve")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_AlchemyFigureHead_All_Close()")
    self._ui_pc.btn_doit:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyFigureHead_All_Doit()")
    self._ui.stc_totemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_AlchemyFigureHead_All_ClearItem(true)")
    self._ui.stc_blackstoneSlot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_AlchemyFigureHead_All_ClearItem(false)")
  else
    Panel_AlchemyFigureHead_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_AlchemyFigureHead_All_Doit()")
  end
end
function PaGlobal_AlchemyFigureHead_All:prepareOpen()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  local isAlchemyFigureHeadEnble = ToClient_IsContentsGroupOpen("44")
  if false == isAlchemyFigureHeadEnble then
    return
  end
  self:openUiSetting()
  self:open()
end
function PaGlobal_AlchemyFigureHead_All:open()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  ToClient_padSnapChangeToTarget(Panel_AlchemyFigureHead_All)
  Panel_AlchemyFigureHead_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  Panel_AlchemyFigureHead_All:SetShow(true)
end
function PaGlobal_AlchemyFigureHead_All:prepareClose()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self:clearAllData()
  Panel_AlchemyFigureHead_All:ClearUpdateLuaFunc()
  Inventory_SetFunctor(nil, nil, nil, nil)
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == isInvenOpen then
    if false == _ContentsGroup_RenewUI_InventoryEquip then
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(true)
      else
        Equipment_SetShow(true)
      end
    else
      PaGlobalFunc_InventoryInfo_Close()
    end
  end
  self:close()
end
function PaGlobal_AlchemyFigureHead_All:close()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  Panel_AlchemyFigureHead_All:SetShow(false)
end
function PaGlobal_AlchemyFigureHead_All:openUiSetting()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    if nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  elseif nil ~= Panel_AlchemyStone and true == Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if false == _ContentsGroup_RenewUI_Manufacture then
    if true == _ContentsGroup_NewUI_Manufacture_All then
      if true == Panel_Window_Manufacture_All:GetShow() then
        PaGlobalFunc_Manufacture_All_Close()
      end
    elseif true == Panel_Manufacture:GetShow() then
      Manufacture_Close()
    end
  end
  if nil ~= Panel_DyePalette and Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  else
    FGlobal_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  end
  self:clearAllData()
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    PaGlobalFunc_ClothInventory_All_Close()
  elseif nil ~= Panel_Window_ClothInventory then
    ClothInventory_Close()
  end
  InventoryWindow_Show()
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
  if true == self._isConsole then
    self:alignKeyGuide()
  end
end
function PaGlobal_AlchemyFigureHead_All:initUiSetting()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  local padding = 10
  self._ui_console.txt_consoleBG:SetShow(self._isConsole)
  self._ui_pc.btn_close:SetShow(false == self._isConsole)
  self._ui_pc.btn_doit:SetShow(false == self._isConsole)
  if true == self._isConsole then
    self._ui.stc_descBG:SetSpanSize(self._ui.stc_descBG:GetSpanSize().x, padding)
    Panel_AlchemyFigureHead_All:SetSize(Panel_AlchemyFigureHead_All:GetSizeX(), Panel_AlchemyFigureHead_All:GetSizeY() - (self._ui_pc.btn_doit:GetSizeY() + padding))
  end
  SlotItem.new(self._ui.stc_totemSlot, "totemSlot", nil, self._ui.stc_totemSlotBG, self.slotConfig)
  self._ui.stc_totemSlot:createChild()
  self._ui.stc_totemSlot:clearItem()
  SlotItem.new(self._ui.stc_blackstoneSlot, "blackstoneSlot", nil, self._ui.stc_blackstoneSlotBG, self.slotConfig)
  self._ui.stc_blackstoneSlot:createChild()
  self._ui.stc_blackstoneSlot:clearItem()
  self:setNotice()
end
function PaGlobal_AlchemyFigureHead_All:setNotice()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYFIGUREHEAD_DESC"))
  local addSizeY = 0
  if self._ui.txt_desc:GetTextSizeY() > self._ui.txt_desc:GetSizeY() then
    addSizeY = self._ui.txt_desc:GetTextSizeY() - self._ui.txt_desc:GetSizeY()
  end
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.stc_descBG:GetSizeY() + addSizeY)
  Panel_AlchemyFigureHead_All:SetSize(Panel_AlchemyFigureHead_All:GetSizeX(), Panel_AlchemyFigureHead_All:GetSizeY() + addSizeY)
  Panel_AlchemyFigureHead_All:ComputePosAllChild()
end
function PaGlobal_AlchemyFigureHead_All:clearAllData()
  self:clearBlackstoneData()
  self:clearTotemData()
  self:setGuideText()
  self._curTime = 0
  self._effectFlag.startPlay.isCheck = false
  self._effectFlag.contentEffect.isCheck = false
  self._effectFlag.slotEffect.isCheck = false
  self._effectFlag.resultSound.isCheck = false
  self._ui.stc_effect:EraseAllEffect()
end
function PaGlobal_AlchemyFigureHead_All:clearTotemData()
  self._ui.stc_totemSlot:clearItem()
  self._totemData.inventoryType = nil
  self._totemData.slotNo = nil
  self._totemData.selectedType = nil
  self._totemData.itemKey = nil
  self._ui.stc_totemSlot.icon:EraseAllEffect()
  self._ui.stc_totemSlot.empty = true
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_FigureHeadFilter, PaGlobal_AlchemyFigureHead_All_FigureHeadRfunction, nil, nil)
  self._ui.stc_totemSlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "")
end
function PaGlobal_AlchemyFigureHead_All:clearBlackstoneData()
  self._ui.stc_blackstoneSlot:clearItem()
  self._blackstoneData.inventoryType = nil
  self._blackstoneData.slotNo = nil
  self._blackstoneData.count = nil
  self._ui.stc_blackstoneSlot.icon:EraseAllEffect()
  self._ui.stc_blackstoneSlot.empty = true
  Inventory_SetFunctor(PaGlobal_AlchemyFigureHead_All_StuffFilter, PaGlobal_AlchemyFigureHead_All_StuffRfunction, nil, nil)
  self._ui.stc_blackstoneSlotBG:registerPadEvent(__eConsoleUIPadEvent_X, "")
end
function PaGlobal_AlchemyFigureHead_All:setGuideText()
  local doitEnable = false
  if true == self._ui.stc_blackstoneSlot.empty and true == self._ui.stc_totemSlot.empty then
    local guideKeyword = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE")
    self._ui.txt_guide:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYFISHPRINT_SELECT", "guideKeyword", guideKeyword))
  end
  if false == self._ui.stc_blackstoneSlot.empty and false == self._ui.stc_totemSlot.empty then
    self._ui.txt_guide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_UPGRADE"))
    doitEnable = true
  elseif true == self._ui.stc_blackstoneSlot.empty and false == self._ui.stc_totemSlot.empty then
    self._ui.txt_guide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_UPGRADE"))
  end
  self._ui_pc.btn_doit:SetMonoTone(false == doitEnable)
  self._ui_pc.btn_doit:SetEnable(doitEnable)
end
function PaGlobal_AlchemyFigureHead_All:alignKeyGuide()
  local keyGuides = {
    self._ui_console.txt_showDetail,
    self._ui_console.txt_confirm,
    self._ui_console.txt_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.txt_consoleBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_AlchemyFigureHead_All:controlAll_Init()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui.stc_contentBG = UI.getChildControl(Panel_AlchemyFigureHead_All, "Static_ContentTypeBG")
  self._ui.txt_guide = UI.getChildControl(Panel_AlchemyFigureHead_All, "Static_GuideText")
  self._ui.stc_totemSlotBG = UI.getChildControl(self._ui.stc_contentBG, "Static_SlotBG2")
  self._ui.stc_blackstoneSlotBG = UI.getChildControl(self._ui.stc_contentBG, "Static_SlotBG1")
  self._ui.stc_effect = UI.getChildControl(Panel_AlchemyFigureHead_All, "Static_ContentTypeEffect")
  self._ui.stc_descBG = UI.getChildControl(Panel_AlchemyFigureHead_All, "Static_DescBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
end
function PaGlobal_AlchemyFigureHead_All:controlPc_Init()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  local title = UI.getChildControl(Panel_AlchemyFigureHead_All, "StaticText_Title")
  self._ui_pc.btn_close = UI.getChildControl(title, "Button_Win_Close")
  self._ui_pc.btn_doit = UI.getChildControl(Panel_AlchemyFigureHead_All, "Button_Doit")
end
function PaGlobal_AlchemyFigureHead_All:controlConsole_Init()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui_console.txt_consoleBG = UI.getChildControl(Panel_AlchemyFigureHead_All, "StaticText_ConsoleGuide")
  self._ui_console.txt_showDetail = UI.getChildControl(self._ui_console.txt_consoleBG, "StaticText_ShowDetail")
  self._ui_console.txt_confirm = UI.getChildControl(self._ui_console.txt_consoleBG, "StaticText_Confirm")
  self._ui_console.txt_close = UI.getChildControl(self._ui_console.txt_consoleBG, "StaticText_Close")
end
function PaGlobal_AlchemyFigureHead_All:validate()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_AlchemyFigureHead_All:allValidate()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui.stc_contentBG:isValidate()
  self._ui.txt_guide:isValidate()
  self._ui.stc_totemSlotBG:isValidate()
  self._ui.stc_blackstoneSlotBG:isValidate()
  self._ui.stc_effect:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
end
function PaGlobal_AlchemyFigureHead_All:pcValidate()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_doit:isValidate()
end
function PaGlobal_AlchemyFigureHead_All:consoleValidate()
  if nil == Panel_AlchemyFigureHead_All then
    return
  end
  self._ui_console.txt_consoleBG:isValidate()
  self._ui_console.txt_confirm:isValidate()
  self._ui_console.txt_close:isValidate()
end
