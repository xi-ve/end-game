function PaGlobal_Palette_All:initialize()
  if true == PaGlobal_Palette_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_Palette_All, "StaticText_TitleBg")
  self._ui_pc.btn_Close = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui_pc.btn_Help = UI.getChildControl(self._ui.stc_TitleBG, "Button_Help")
  self._ui.stc_TabGroup = UI.getChildControl(Panel_Window_Palette_All, "Static_TabGroup")
  self._ui.rdo_TabAll = UI.getChildControl(self._ui.stc_TabGroup, "RadioButton_Tab_ALL")
  self._ui.rdo_TabMine = UI.getChildControl(self._ui.stc_TabGroup, "RadioButton_Tab_My")
  self._ui.stc_SelectedTabLine = UI.getChildControl(self._ui.stc_TabGroup, "Static_SelectedLine")
  self._ui_console.stc_KeyGuideLB = UI.getChildControl(self._ui.stc_TabGroup, "Static_LB_ConsoleUI")
  self._ui_console.stc_KeyGuideRB = UI.getChildControl(self._ui.stc_TabGroup, "Static_RB_ConsoleUI")
  self._ui.stc_MaterialTabGroup = UI.getChildControl(Panel_Window_Palette_All, "Static_SubTabGroup")
  self._ui.txt_SelectedMaterialName = UI.getChildControl(self._ui.stc_MaterialTabGroup, "StaticText_SelectedMaterialName")
  for idx = 0, self._materialCount - 1 do
    self._materialName[idx] = PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_TAB_MATERIAL_" .. tostring(idx))
    self._rdo_Material[idx] = UI.getChildControl(self._ui.stc_MaterialTabGroup, "RadioButton_Material_" .. tostring(idx))
    self._rdo_Material[idx]:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_SelectedCategory( " .. tostring(idx) .. " )")
    self._rdo_Material[idx]:addInputEvent("Mouse_On", "InputMouse_Palette_All_CategoryTooltip( true , " .. tostring(idx) .. " )")
    self._rdo_Material[idx]:addInputEvent("Mouse_Out", "InputMouse_Palette_All_CategoryTooltip( false , " .. tostring(idx) .. " )")
  end
  self._ui.stc_slotBG = UI.getChildControl(Panel_Window_Palette_All, "Static_BG")
  for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
    self.slot[slotRowsIdx] = {}
    for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
      self.slot[slotRowsIdx][slotColsIdx] = {}
      local slot = self.slot[slotRowsIdx][slotColsIdx]
      slot.bg = UI.createAndCopyBasePropertyControl(Panel_Window_Palette_All, "Static_SlotBG", self._ui.stc_slotBG, "DyePaletteSlotBG_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.color = UI.createAndCopyBasePropertyControl(Panel_Window_Palette_All, "Static_ColorPart", slot.bg, "DyePaletteSlot_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.count = UI.createAndCopyBasePropertyControl(Panel_Window_Palette_All, "StaticText_Count", slot.bg, "DyePaletteSlot_Count_" .. slotColsIdx .. "_" .. slotRowsIdx)
      slot.btn = UI.createAndCopyBasePropertyControl(Panel_Window_Palette_All, "RadioButton_Slot", slot.bg, "DyePaletteSlot_ColorBtn_" .. slotColsIdx .. "_" .. slotRowsIdx)
      local slotPosX = (slot.bg:GetSizeX() + self.config.cellSpan) * slotColsIdx + self.config.startPosX
      local slotPosY = (slot.bg:GetSizeY() + self.config.cellSpan) * slotRowsIdx + self.config.startPosY
      slot.color:SetAlphaIgnore(true)
      slot.bg:SetPosXY(slotPosX, slotPosY)
      slot.color:SetPosXY(0, 0)
      slot.count:SetPosXY(0, 25)
      slot.btn:SetPosXY(0, 0)
      if 0 == slotRowsIdx then
        slot.bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_Palette_All(true)")
      end
      if self.config.maxSlotRowsCount - 1 == slotRowsIdx then
        slot.bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_Palette_All(false)")
      end
      slot.btn:addInputEvent("Mouse_UpScroll", "InputScroll_Palette_All( true )")
      slot.btn:addInputEvent("Mouse_DownScroll", "InputScroll_Palette_All( false )")
    end
  end
  self._ui.scroll = UI.getChildControl(Panel_Window_Palette_All, "Scroll_Ampule")
  self._ui.scrollBtn = UI.getChildControl(self._ui.scroll, "Scroll_CtrlButton")
  self._ui.stc_BottomGroup = UI.getChildControl(Panel_Window_Palette_All, "Static_BottomSelectedArea")
  self._ui.edit_AmpuleCount = UI.getChildControl(self._ui.stc_BottomGroup, "Edit_SelectAmpuleCount")
  self._ui.txt_SelectedAmpuleName = UI.getChildControl(self._ui.stc_BottomGroup, "StaticText_SelectAmpuleName")
  self._ui.stc_SelectedAmpuleBG = UI.getChildControl(self._ui.stc_BottomGroup, "Static_SelectAmplueSlotBG")
  self._ui.stc_SelectedAmpule = UI.getChildControl(self._ui.stc_SelectedAmpuleBG, "Static_SelectAmplueColorPart")
  self._ui_pc.btn_Withdraw = UI.getChildControl(self._ui.stc_BottomGroup, "Button_Confirm")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_Palette_All, "Static_KeyGuide_Bg")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._keyguides = {
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  self._ui.stc_SelectedAmpule:SetAlphaIgnore(true)
  PaGlobal_Palette_All:switchPlatform()
  PaGlobal_Palette_All:registEventHandler()
  PaGlobal_Palette_All:aliginKeyGuide()
  PaGlobal_Palette_All:validate()
  PaGlobal_Palette_All._initialize = true
end
function PaGlobal_Palette_All:switchPlatform()
  for key, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for key, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_Palette_All:registEventHandler()
  if nil == Panel_Window_Palette_All then
    return
  end
  Panel_Window_Palette_All:ActiveMouseEventEffect(true)
  Panel_Window_Palette_All:setGlassBackground(true)
  Panel_Window_Palette_All:RegisterShowEventFunc(true, "PaGlobal_Palette_All_ShowAni()")
  Panel_Window_Palette_All:RegisterShowEventFunc(false, "PaGlobal_Palette_All_HideAni()")
  registerEvent("FromClient_UpdateDyeingPalette", "FromClient_Palette_All_Update")
  if self._isConsole then
    Panel_Window_Palette_All:ignorePadSnapMoveToOtherPanel()
    Panel_Window_Palette_All:registerPadEvent(__eConsoleUIPadEvent_LB, "InputMLUp_Palette_All_SelectedType( true )")
    Panel_Window_Palette_All:registerPadEvent(__eConsoleUIPadEvent_RB, "InputMLUp_Palette_All_SelectedType( false )")
    Panel_Window_Palette_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_Palette_All_Confirm()")
  else
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Palette_All_Close()")
    self._ui_pc.btn_Help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Dye\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_Help, "\"Dye\"")
    self._ui_pc.btn_Withdraw:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_Confirm()")
    self._ui.rdo_TabAll:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_SelectedType( true )")
    self._ui.rdo_TabMine:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_SelectedType( false )")
    self._ui.edit_AmpuleCount:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_SelectAmplueCount()")
    self._ui.scroll:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_Scroll()")
    self._ui.scrollBtn:addInputEvent("Mouse_LPress", "InputMLUp_Palette_All_Scroll()")
    self._ui.stc_slotBG:addInputEvent("Mouse_UpScroll", "InputScroll_Palette_All( true )")
    self._ui.stc_slotBG:addInputEvent("Mouse_DownScroll", "InputScroll_Palette_All( false )")
  end
end
function PaGlobal_Palette_All:prepareOpen()
  if nil == Panel_Window_Palette_All then
    return
  end
  if false == _ContentsGroup_NewUI_AlchemyFigureHead_All then
    if nil ~= Panel_AlchemyFigureHead and Panel_AlchemyFigureHead:GetShow() then
      FGlobal_AlchemyFigureHead_Close()
    end
  elseif nil ~= Panel_AlchemyFigureHead_All and Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if true == _ContentsGroup_NewUI_AlchemyStone_All then
    if nil ~= Panel_Window_AlchemyStone_All and true == Panel_Window_AlchemyStone_All:GetShow() then
      PaGlobalFunc_AlchemyStone_All_Close()
    end
  elseif nil ~= Panel_AlchemyStone and true == Panel_AlchemyStone:GetShow() then
    FGlobal_AlchemyStone_Close()
  end
  if not _ContentsGroup_RenewUI_Manufacture then
    if false == _ContentsGroup_NewUI_Manufacture_All then
      if true == Panel_Manufacture:GetShow() then
        Manufacture_Close()
      end
    elseif true == Panel_Window_Manufacture_All:GetShow() then
      PaGlobalFunc_Manufacture_All_Close()
    end
  end
  if not _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
  end
  Inventory_SetFunctor(PaGlobal_Palette_All_SetInvenFilter, PaGlobal_Palette_All_SetInvenRclick, nil, nil)
  local invenPosX = 0
  local invenPosY = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    else
      invenPosX = Panel_Window_Inventory_All:GetPosX()
      invenPosY = Panel_Window_Inventory_All:GetPosY()
    end
  elseif true == Panel_Window_Inventory:IsUISubApp() then
    invenPosX = Panel_Window_Inventory:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory:GetScreenParentPosY()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
    invenPosY = Panel_Window_Inventory:GetPosY()
  end
  Panel_Window_Palette_All:SetPosX(invenPosX - Panel_Window_Palette_All:GetSizeX())
  Panel_Window_Palette_All:SetPosY(invenPosY)
  InputMLUp_Palette_All_SelectedType(true)
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:IsUISubApp() then
      Panel_Window_Palette_All:OpenUISubApp()
    end
  elseif Panel_Window_Inventory:IsUISubApp() then
    Panel_Window_Palette_All:OpenUISubApp()
  end
  InputMLUp_Palette_All_SelectedCategory(0)
  PaGlobal_Palette_All:open()
end
function PaGlobal_Palette_All:open()
  if nil == Panel_Window_Palette_All then
    return
  end
  Panel_Window_Palette_All:SetShow(true, true)
end
function PaGlobal_Palette_All:prepareClose()
  if nil == Panel_Window_Palette_All then
    return
  end
  if nil ~= Panel_Widget_CharacterController_All and Panel_Widget_CharacterController_All:GetShow() then
    Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
  else
    Inventory_SetFunctor(nil, nil, nil, nil)
  end
  Panel_Window_Palette_All:CloseUISubApp()
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip and true == isInvenOpen then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if false == Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Open()
      end
    elseif false == Panel_Equipment:GetShow() then
      Panel_Equipment:SetShow(true)
    end
  end
  PaGlobal_Palette_All:close()
end
function PaGlobal_Palette_All:close()
  if nil == Panel_Window_Palette_All then
    return
  end
  Panel_Window_Palette_All:SetShow(false, false)
end
function PaGlobal_Palette_All:validate()
  if nil == Panel_Window_Palette_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close:isValidate()
  self._ui_pc.btn_Help:isValidate()
  self._ui.stc_TabGroup:isValidate()
  self._ui.rdo_TabAll:isValidate()
  self._ui.rdo_TabMine:isValidate()
  self._ui.stc_SelectedTabLine:isValidate()
  self._ui_console.stc_KeyGuideLB:isValidate()
  self._ui_console.stc_KeyGuideRB:isValidate()
  self._ui.stc_MaterialTabGroup:isValidate()
  self._ui.txt_SelectedMaterialName:isValidate()
  for idx = 0, self._materialCount - 1 do
    self._rdo_Material[idx]:isValidate()
  end
  self._ui.scroll:isValidate()
  self._ui.scrollBtn:isValidate()
  self._ui.stc_BottomGroup:isValidate()
  self._ui.edit_AmpuleCount:isValidate()
  self._ui.txt_SelectedAmpuleName:isValidate()
  self._ui.stc_SelectedAmpuleBG:isValidate()
  self._ui.stc_SelectedAmpule:isValidate()
  self._ui_pc.btn_Withdraw:isValidate()
  self._ui_console.stc_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideA:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
end
function PaGlobal_Palette_All:update()
  if nil == Panel_Window_Palette_All then
    return
  end
  local category = self.config.selectedCategoryIdx
  local isShowAll = self.config.isShowAll
  self._ui.rdo_TabAll:SetCheck(isShowAll)
  self._ui.rdo_TabMine:SetCheck(not isShowAll)
  for idx = 0, self._materialCount - 1 do
    self._rdo_Material[idx]:SetCheck(idx == category)
  end
  self:clearSlot()
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(category, isShowAll)
  if nil ~= DyeingPaletteCategoryInfo then
    local colorCount = DyeingPaletteCategoryInfo:getListSize()
    self.config.colorTotalRows = math.ceil(colorCount / self.config.maxSlotColsCount)
    local uiIndex = 0
    for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
      for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
        local slot = self.slot[slotRowsIdx][slotColsIdx]
        local dataIdx = uiIndex + self.config.scrollStartIdx * self.config.maxSlotColsCount
        if colorCount > dataIdx then
          local colorValue = DyeingPaletteCategoryInfo:getColor(dataIdx)
          local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(dataIdx)
          local isDyeUI = false
          local ampuleCount = DyeingPaletteCategoryInfo:getCount(dataIdx, isDyeUI)
          slot.count:SetText(tostring(ampuleCount))
          self:ChangeSlotTexture(true, slotRowsIdx, slotColsIdx)
          slot.color:SetColor(colorValue)
          slot.count:SetShow(true)
          if dataIdx == self.config.selectedColorIdx then
            slot.btn:SetCheck(true)
          end
          slot.bg:SetIgnore(false)
          slot.btn:addInputEvent("Mouse_LUp", "InputMLUp_Palette_All_SelectColor( " .. dataIdx .. " )")
          slot.btn:addInputEvent("Mouse_On", "InputMouse_Palette_All_ColorToolTip( true, " .. itemEnchantKey .. ", " .. slotRowsIdx .. ", " .. slotColsIdx .. " )")
          slot.btn:addInputEvent("Mouse_Out", "InputMouse_Palette_All_ColorToolTip( false, " .. itemEnchantKey .. ", " .. slotRowsIdx .. ", " .. slotColsIdx .. " )")
          uiIndex = uiIndex + 1
        end
      end
    end
    local function setSelectColor_nil()
      self._ui.stc_SelectedAmpule:SetColor(16777215)
      self._ui.txt_SelectedAmpuleName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_PLZ_SELECT_COLOR"))
      self._ui.edit_AmpuleCount:SetEditText("0")
    end
    local selectedColorIdx = self.config.selectedColorIdx
    if nil ~= selectedColorIdx then
      local isDyeUI = false
      self.config.selectedAmplurCount_s64 = DyeingPaletteCategoryInfo:getCount(selectedColorIdx, isDyeUI)
      local colorValue = DyeingPaletteCategoryInfo:getColor(selectedColorIdx)
      local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(selectedColorIdx)
      local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
      if nil ~= itemEnchantSSW then
        local itemEnchantSS = itemEnchantSSW:get()
        local itemName = getItemName(itemEnchantSS)
        self._ui.stc_SelectedAmpule:SetColor(colorValue)
        self._ui.txt_SelectedAmpuleName:SetText(itemName)
        self._ui.edit_AmpuleCount:SetEditText(tostring(self.config.selectedAmplurCount_s64))
      else
        setSelectColor_nil()
      end
    else
      setSelectColor_nil()
    end
    UIScroll.SetButtonSize(self._ui.scroll, self.config.maxSlotRowsCount, self.config.colorTotalRows)
  end
end
function PaGlobal_Palette_All:clearSlot()
  for slotRowsIdx = 0, self.config.maxSlotRowsCount - 1 do
    for slotColsIdx = 0, self.config.maxSlotColsCount - 1 do
      local slot = self.slot[slotRowsIdx][slotColsIdx]
      local clearColor = 16777215
      self:ChangeSlotTexture(false, slotRowsIdx, slotColsIdx)
      slot.color:SetColor(clearColor)
      slot.count:SetText("0")
      slot.count:SetShow(false)
      slot.btn:SetCheck(false)
      slot.bg:SetIgnore(self._isConsole)
      slot.btn:addInputEvent("Mouse_LUp", "")
      slot.btn:addInputEvent("Mouse_On", "")
      slot.btn:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_Palette_All:ChangeSlotTexture(isFill, rowsIdx, colsIdx)
  local slot = self.slot[rowsIdx][colsIdx].color
  local x1, y1, x2, y2
  if true == isFill then
    x1, y1, x2, y2 = 55, 162, 99, 206
  else
    x1, y1, x2, y2 = 55, 209, 99, 253
  end
  slot:ChangeTextureInfoName("new_ui_common_forlua/default/Default_Buttons_02.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(slot, x1, y1, x2, y2)
  slot:getBaseTexture():setUV(x1, y1, x2, y2)
  slot:setRenderTexture(slot:getBaseTexture())
end
function PaGlobal_Palette_All:aliginKeyGuide()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
