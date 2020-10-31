function InputMLUp_Palette_All_SelectedCategory(categoryIdx)
  PaGlobal_Palette_All.config.selectedCategoryIdx = categoryIdx
  PaGlobal_Palette_All.config.scrollStartIdx = 0
  PaGlobal_Palette_All.config.selectedColorIdx = nil
  PaGlobal_Palette_All._ui.scroll:SetControlPos(0)
  PaGlobal_Palette_All_SetMaterialName(categoryIdx)
  PaGlobal_Palette_All:update()
end
function InputMLUp_Palette_All_SelectColor(dataIdx)
  PaGlobal_Palette_All.config.selectedColorIdx = dataIdx
  local category = PaGlobal_Palette_All.config.selectedCategoryIdx
  local showType = PaGlobal_Palette_All.config.isShowAll
  local colorIdx = PaGlobal_Palette_All.config.selectedColorIdx
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(category, showType)
  if nil ~= DyeingPaletteCategoryInfo then
    local isDyeUI = false
    PaGlobal_Palette_All.config.selectedAmplurCount_s64 = DyeingPaletteCategoryInfo:getCount(colorIdx, isDyeUI)
    local colorValue = DyeingPaletteCategoryInfo:getColor(colorIdx)
    local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(colorIdx)
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
    local itemEnchantSS = itemEnchantSSW:get()
    local itemName = getItemName(itemEnchantSS)
    PaGlobal_Palette_All._ui.stc_SelectedAmpule:SetColor(colorValue)
    PaGlobal_Palette_All._ui.txt_SelectedAmpuleName:SetText(itemName)
    PaGlobal_Palette_All._ui.edit_AmpuleCount:SetEditText(tostring(PaGlobal_Palette_All.config.selectedAmplurCount_s64))
    if PaGlobal_Palette_All._isConsole then
      InputMLUp_Palette_All_SelectAmplueCount()
    end
  end
end
function InputMouse_Palette_All_CategoryTooltip(isOn, categoryType)
  local control
  local name = ""
  local desc
  if true == isOn then
    control = PaGlobal_Palette_All._rdo_Material[categoryType]
    name = PaGlobal_Palette_All._materialName[categoryType]
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function InputMouse_Palette_All_ColorToolTip(isShow, itemEnchantKey, rowsIdx, colsIdx)
  if true == isShow then
    local uiControl = PaGlobal_Palette_All.slot[rowsIdx][colsIdx].btn
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
    local itemEnchantSS = itemEnchantSSW:get()
    local itemName = getItemName(itemEnchantSS)
    local desc
    TooltipSimple_Show(uiControl, itemName, desc)
  else
    TooltipSimple_Hide()
  end
end
function InputMLUp_Palette_All_Scroll()
  PaGlobal_Palette_All.config.scrollStartIdx = math.ceil((PaGlobal_Palette_All.config.colorTotalRows - PaGlobal_Palette_All.config.maxSlotRowsCount) * PaGlobal_Palette_All._ui.scroll:GetControlPos())
  PaGlobal_Palette_All:update()
end
function InputScroll_Palette_All(isScrollUp)
  local prevIdx = PaGlobal_Palette_All.config.scrollStartIdx
  PaGlobal_Palette_All.config.scrollStartIdx = UIScroll.ScrollEvent(PaGlobal_Palette_All._ui.scroll, isScrollUp, PaGlobal_Palette_All.config.maxSlotRowsCount, PaGlobal_Palette_All.config.colorTotalRows, PaGlobal_Palette_All.config.scrollStartIdx, 1)
  PaGlobal_Palette_All:update()
  if prevIdx ~= PaGlobal_Palette_All.config.scrollStartIdx then
    ToClient_padSnapIgnoreGroupMove()
  end
end
function InputMLUp_Palette_All_Confirm()
  local isShowAll = PaGlobal_Palette_All.config.isShowAll
  local categoryIndex = PaGlobal_Palette_All.config.selectedCategoryIdx
  local dataIndex = PaGlobal_Palette_All.config.selectedColorIdx
  local itemCount = PaGlobal_Palette_All.config.selectedAmplurCount_s64
  if nil == dataIndex then
    return
  end
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(categoryIndex, isShowAll)
  local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(dataIndex)
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local itemEnchantSS = itemEnchantSSW:get()
  local itemName = getItemName(itemEnchantSS)
  local function doExportPalette()
    ToClient_requestChangeDyeingPaletteToItem(categoryIndex, dataIndex, itemCount, isShowAll)
  end
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PALETTE_SURE_GET_THIS_AMPLUE", "itemName", itemName, "itemCount", tostring(itemCount))
  local messageBoxData = {
    title = messageTitle,
    content = messageBoxMemo,
    functionYes = doExportPalette,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function InputMLUp_Palette_All_SelectedType(isShowAll)
  if PaGlobal_Palette_All.config.isShowAll == isShowAll then
    return
  end
  PaGlobal_Palette_All.config.isShowAll = isShowAll
  PaGlobal_Palette_All.config.selectedCategoryIdx = 0
  PaGlobal_Palette_All.config.selectedColorIdx = 0
  PaGlobal_Palette_All.config.scrollStartIdx = 0
  PaGlobal_Palette_All.config.selectedColorIdx = nil
  PaGlobal_Palette_All._ui.scroll:SetControlPos(0)
  local selectedControl
  if isShowAll then
    selectedControl = PaGlobal_Palette_All._ui.rdo_TabAll
  else
    selectedControl = PaGlobal_Palette_All._ui.rdo_TabMine
  end
  PaGlobal_Palette_All._ui.stc_SelectedTabLine:SetPosX(selectedControl:GetPosX() + selectedControl:GetSizeX() / 2 - PaGlobal_Palette_All._ui.stc_SelectedTabLine:GetSizeX() / 2)
  PaGlobal_Palette_All_SetMaterialName(0)
  PaGlobal_Palette_All:update()
end
function InputMLUp_Palette_All_SelectAmplueCount()
  local category = PaGlobal_Palette_All.config.selectedCategoryIdx
  local isShowAll = PaGlobal_Palette_All.config.isShowAll
  local colorIdx = PaGlobal_Palette_All.config.selectedColorIdx
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(category, isShowAll)
  if nil ~= DyeingPaletteCategoryInfo then
    local isDyeUI = false
    local ampuleCount = DyeingPaletteCategoryInfo:getCount(colorIdx, isDyeUI)
    if ampuleCount > toInt64(0, 1) then
      Panel_NumberPad_Show(true, ampuleCount, ampuleCount, PaGlobal_Palette_All_SetSelectAmplueCount)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PALETTE_WRONG_COLORINFO"))
    return
  end
end
function PaGlobal_Palette_All_SetSelectAmplueCount(count_s64)
  PaGlobal_Palette_All.config.selectedAmplurCount_s64 = count_s64
  PaGlobal_Palette_All._ui.edit_AmpuleCount:SetEditText(tostring(PaGlobal_Palette_All.config.selectedAmplurCount_s64))
end
function PaGlobal_Palette_All_SetMaterialName(index)
  local materialString = PaGlobal_Palette_All._materialName[index]
  local materialName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALETTE_MATERIALNAME", "name", materialString)
  PaGlobal_Palette_All._ui.txt_SelectedMaterialName:SetText(materialName)
end
function PaGlobal_Palette_All_ShowAni()
  local aniInfo1 = Panel_Window_Palette_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_Palette_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Palette_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Palette_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Palette_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Palette_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_Palette_All_HideAni()
  local aniInfo1 = Panel_Window_Palette_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobal_Palette_All_SetInvenFilter(slotNo, itemWrapper, count_s64, inventoryType)
  if nil ~= itemWrapper then
    local isDyeAble = itemWrapper:getStaticStatus():get():isDyeingStaticStatus()
    return not isDyeAble
  else
    return true
  end
end
function PaGlobal_Palette_All_SetInvenRclick(slotNo, itemWrapper, count_s64, inventoryType)
  local function doInsertPalette()
    ToClient_requestCreateDyeingPaletteFromItem(inventoryType, slotNo, count_s64)
  end
  local ampuleName = itemWrapper:getStaticStatus():getName()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALETTE_SURE_THIS_AMPLUE", "itemName", ampuleName)
  local messageBoxData = {
    title = messageTitle,
    content = messageBoxMemo,
    functionYes = doInsertPalette,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Palette_All_Close()
  PaGlobal_Palette_All:prepareClose()
end
function PaGlobal_Palette_All_Open()
  PaGlobal_Palette_All:prepareOpen()
end
function FromClient_Palette_All_Update()
  if Panel_Window_Palette_All:GetShow() then
    PaGlobal_Palette_All:update()
  end
  if nil ~= Panel_Window_Inventory_All and Panel_Window_Inventory_All:GetShow() then
    Inventory_updateSlotData(true)
  end
  if nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow() then
    PaGlobal_Dye_All:updateAmpleSlotList()
  end
end
