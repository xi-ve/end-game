function PaGlobal_House_InstallationList_All:initialize()
  if true == PaGlobal_House_InstallationList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initCategoryData()
  self._ui._stc_backGround = UI.getChildControl(Panel_House_InstallationMode_List_All, "Static_House_InstallationMode_Right")
  local stc_titleBg = UI.getChildControl(self._ui._stc_backGround, "Static_TitleBg")
  self._ui._txt_titleText = UI.getChildControl(stc_titleBg, "StaticText_Title_Top")
  local stc_tabMenu = UI.getChildControl(self._ui._stc_backGround, "Static_TabMenuBG")
  self._ui._rdo_tabMenu[self._eTabMenu.All] = UI.getChildControl(stc_tabMenu, "RadioButton_AllIcon")
  self._ui._rdo_tabMenu[self._eTabMenu.Goods] = UI.getChildControl(stc_tabMenu, "RadioButton_Place")
  self._ui._rdo_tabMenu[self._eTabMenu.Furniture] = UI.getChildControl(stc_tabMenu, "RadioButton_Funiture")
  self._ui._rdo_tabMenu[self._eTabMenu.BaseMaterial] = UI.getChildControl(stc_tabMenu, "RadioButton_Material")
  self._ui._rdo_tabMenu[self._eTabMenu.Tools] = UI.getChildControl(stc_tabMenu, "RadioButton_ToolIcon")
  self._ui._console._stc_LBKey = UI.getChildControl(stc_tabMenu, "Static_LB_Console")
  self._ui._console._stc_RBKey = UI.getChildControl(stc_tabMenu, "Static_RB_Console")
  self._ui._console._txt_tabTooltip = UI.getChildControl(stc_tabMenu, "StaticText_ToolTip")
  self._ui._console._stc_tooltipArrow = UI.getChildControl(self._ui._console._txt_tabTooltip, "Static_ToolTip_Arrow")
  local stc_categoryBg = UI.getChildControl(self._ui._stc_backGround, "Static_CategoryBG")
  self._ui._combo_categoryType = UI.getChildControl(stc_categoryBg, "Combobox_Type")
  self._ui._edit_searchBox = UI.getChildControl(stc_categoryBg, "Edit_SearchBox")
  self._ui._txt_searchIcon = UI.getChildControl(self._ui._edit_searchBox, "StaticText_SearchIcon")
  self._ui._console._stc_LTXKey = UI.getChildControl(self._ui._edit_searchBox, "StaticText_KeyGuideLTX")
  self._ui._stc_itemListBg = UI.getChildControl(self._ui._stc_backGround, "Static_HousingItemListBG")
  self._ui._stc_itemTemplete = UI.getChildControl(self._ui._stc_itemListBg, "Static_Item_Templete")
  self._ui._scroll_itemList = UI.getChildControl(self._ui._stc_itemListBg, "Scroll_HousingItemList")
  local stc_buttonBg = UI.getChildControl(self._ui._stc_backGround, "Static_ButtonBG_PC")
  self._ui._pc._btn_resetFurniture = UI.getChildControl(stc_buttonBg, "Button_ResetFurniture")
  self._ui._pc._btn_exit = UI.getChildControl(stc_buttonBg, "Button_Exit")
  local stc_wishListBg = UI.getChildControl(self._ui._stc_backGround, "Static_WishListBG")
  self._ui._stc_cartItemListBg = UI.getChildControl(stc_wishListBg, "Static_WishItemListBG")
  self._ui._stc_cartItemTemplete = UI.getChildControl(self._ui._stc_cartItemListBg, "Static_Item_Templete")
  self._ui._scroll_cartItemList = UI.getChildControl(self._ui._stc_cartItemListBg, "Scroll_WishItemList")
  local stc_bottomBg = UI.getChildControl(self._ui._stc_backGround, "Static_BottomBg")
  self._ui._pc._btn_buyAll = UI.getChildControl(stc_bottomBg, "Button_BuyAll")
  self._ui._pc._btn_resetAll = UI.getChildControl(stc_bottomBg, "Button_ReaetAll")
  self._ui._console._txt_closeKey = UI.getChildControl(stc_bottomBg, "StaticText_B_Close_ConsoleUI")
  self._ui._console._txt_selectKey = UI.getChildControl(stc_bottomBg, "StaticText_A_Select_ConsoleUI")
  self._ui._console._txt_buyKey = UI.getChildControl(stc_bottomBg, "StaticText_Y_BuyAll_ConsoleUI")
  self._ui._console._stc_consoleKeyBG = UI.getChildControl(self._ui._stc_backGround, "Static_KeyGuide_ConsoleBG")
  self._ui._keyGuide._txt_RS_click = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_RS_Click_ConsoleUI")
  self._ui._keyGuide._txt_RS_updown = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_RS_UpDown_ConsoleUI")
  self._ui._keyGuide._txt_RS_leftright = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_RS_LeftRight_ConsoleUI")
  self._ui._keyGuide._txt_RS = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_RS_ConsoleUI")
  self._ui._keyGuide._txt_LS = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_LS_ConsoleUI")
  self._ui._keyGuide._txt_LB_RB = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_LB_RB_ConsoleUI")
  self._ui._keyGuide._txt_LT_RT = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_LT_RT_ConsoleUI")
  self._ui._keyGuide._txt_Y = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_Y_ConsoleUI")
  self._ui._keyGuide._txt_X = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_X_ConsoleUI")
  self._ui._keyGuide._txt_A = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_A_ConsoleUI")
  self._ui._keyGuide._txt_B = UI.getChildControl(self._ui._console._stc_consoleKeyBG, "StaticText_B_ConsoleUI")
  local stc_priceInfoBg = UI.getChildControl(self._ui._stc_backGround, "Static_PriceInfoBG")
  self._ui._txt_housingPointValue = UI.getChildControl(stc_priceInfoBg, "StaticText_HousingPointValue")
  self._ui._txt_pearlPointValue = UI.getChildControl(stc_priceInfoBg, "StaticText_PearlPointValue")
  self._ui._txt_priceValue = UI.getChildControl(stc_priceInfoBg, "StaticText_PriceValue")
  self._itemStartPos.x = self._ui._stc_itemTemplete:GetPosX()
  self._itemStartPos.y = self._ui._stc_itemTemplete:GetPosY()
  self._cartItemStartPos.x = self._ui._stc_cartItemTemplete:GetPosX()
  self._cartItemStartPos.y = self._ui._stc_cartItemTemplete:GetPosY()
  local isPc = false == self._isConsole
  for k, value in pairs(self._ui._pc) do
    value:SetShow(isPc)
  end
  for k, value in pairs(self._ui._console) do
    value:SetShow(self._isConsole)
  end
  self._ui._pc._btn_exit:SetShow(false)
  local keyList = {
    self._ui._console._txt_buyKey,
    self._ui._console._txt_selectKey,
    self._ui._console._txt_closeKey
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._keyGuideString.build = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_BUILD")
  self._keyGuideString.install = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_INSTALL")
  self._keyGuideString.moveBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_MOVE")
  self._keyGuideString.changeWidthBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_WIDTH")
  self._keyGuideString.changeHeightBuild = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHT")
  self._keyGuideString.zoomInOut = PAGetString(Defines.StringSheet_RESOURCE, "HOUSING_TXT_HELPZOOM")
  self._keyGuideString.changeCamMode = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_CAMMODE")
  self._keyGuideString.zoomInOutAndHeight = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHTMODE")
  self:createItemSlot()
  self:createCartItemSlot()
  Panel_House_InstallationMode_List_All:SetChildIndex(self._ui._combo_categoryType, 999)
  self._ui._combo_categoryType:setListTextHorizonCenter()
  PaGlobal_House_InstallationList_All:registEventHandler()
  PaGlobal_House_InstallationList_All:validate()
  PaGlobal_House_InstallationList_All._initialize = true
end
function PaGlobal_House_InstallationList_All:registEventHandler()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  for key, value in pairs(self._ui._rdo_tabMenu) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_TabMenu(" .. key .. ")")
    value:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_TabMenuTooltip(" .. key .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  self._ui._pc._btn_resetFurniture:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_ResetFurniture()")
  self._ui._pc._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_Exit()")
  self._ui._combo_categoryType:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_CategoryComboBox()")
  self._ui._combo_categoryType:GetListControl():AddSelectEvent("HandleEventLUp_House_InstallationList_All_SelectCategoryComboBox()")
  if true == self._isConsole then
    Panel_House_InstallationMode_List_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_House_InstallationList_All_SetSearchFocus()")
    self._ui._edit_searchBox:setXboxVirtualKeyBoardEndEvent("HandleEventKey_House_InstallationList_All_FindItemName_ForConsole")
  else
    self._ui._edit_searchBox:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_EditItemNameClear()")
    self._ui._edit_searchBox:RegistReturnKeyEvent("HandleEventKey_House_InstallationList_All_FindItemName()")
  end
  self._ui._pc._btn_buyAll:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_CartBuyAll()")
  self._ui._pc._btn_resetAll:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_CartResetAll()")
  UIScroll.InputEvent(self._ui._scroll_itemList, "HandleEventScroll_House_InstallationList_All_UpdateScroll")
  UIScroll.InputEventByControl(self._ui._stc_itemListBg, "HandleEventScroll_House_InstallationList_All_UpdateScroll")
  UIScroll.InputEvent(self._ui._scroll_cartItemList, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll")
  UIScroll.InputEventByControl(self._ui._stc_cartItemListBg, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll")
  registerEvent("EventHousingUpdateInstallationInven", "FromClient_House_InstallationList_All_UpdateItemInventory")
  registerEvent("EventUpdateInstallationActor", "FromClient_House_InstallationList_All_UpdateInstallationActor")
  registerEvent("EventHousingCancelInstallModeMessageBox", "FromClient_House_InstallationList_All_CancelInstallModeMessageBox")
  Panel_House_InstallationMode_List_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPad_House_InstallationList_All_LBorRB(true)")
  Panel_House_InstallationMode_List_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPad_House_InstallationList_All_LBorRB(false)")
  Panel_House_InstallationMode_List_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_House_InstallationList_All_CartBuyAll()")
end
function PaGlobal_House_InstallationList_All:prepareOpen()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  self:clearEdit()
  self:updateTabMenu(self._eTabMenu.All)
  self:initCartItemSlotScroll()
  self:setKeyGuide(PaGlobal_House_Installation_All._eModeState.none)
  self:updateResetButton()
  ToClient_padSnapRefreshTarget(PaGlobal_House_InstallationList_All._ui._stc_itemTemplete)
  PaGlobal_House_InstallationList_All:open()
end
function PaGlobal_House_InstallationList_All:open()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  Panel_House_InstallationMode_List_All:SetShow(true)
end
function PaGlobal_House_InstallationList_All:prepareClose()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  if true == self._ui._combo_categoryType:isClicked() then
    self._ui._combo_categoryType:ToggleListbox()
  end
  self:clearEdit()
  PaGlobal_House_InstallationList_All:close()
end
function PaGlobal_House_InstallationList_All:close()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  Panel_House_InstallationMode_List_All:SetShow(false)
end
function PaGlobal_House_InstallationList_All:update()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
end
function PaGlobal_House_InstallationList_All:validate()
  if nil == Panel_House_InstallationMode_List_All then
    return
  end
  self._ui._stc_backGround:isValidate()
  self._ui._txt_titleText:isValidate()
  self._ui._console._stc_LBKey:isValidate()
  self._ui._console._stc_RBKey:isValidate()
  self._ui._combo_categoryType:isValidate()
  self._ui._edit_searchBox:isValidate()
  self._ui._stc_itemTemplete:isValidate()
  self._ui._scroll_itemList:isValidate()
  self._ui._pc._btn_resetFurniture:isValidate()
  self._ui._pc._btn_exit:isValidate()
  self._ui._stc_cartItemTemplete:isValidate()
  self._ui._scroll_cartItemList:isValidate()
  self._ui._pc._btn_buyAll:isValidate()
  self._ui._pc._btn_resetAll:isValidate()
  self._ui._console._txt_closeKey:isValidate()
  self._ui._console._txt_selectKey:isValidate()
  self._ui._console._txt_buyKey:isValidate()
  self._ui._console._stc_consoleKeyBG:isValidate()
  self._ui._txt_housingPointValue:isValidate()
  self._ui._txt_pearlPointValue:isValidate()
  self._ui._txt_priceValue:isValidate()
  for key, value in pairs(self._ui._rdo_tabMenu) do
    value:isValidate()
  end
end
function PaGlobal_House_InstallationList_All:initCategoryData()
  self._categoryIndex = {
    [self._eCategory.Dresser] = CppEnums.InstallationType.eType_Carpenter,
    [self._eCategory.Wardrobe] = CppEnums.InstallationType.eType_Founding,
    [self._eCategory.Table] = CppEnums.InstallationType.eType_Treasure,
    [self._eCategory.Chair] = CppEnums.InstallationType.eType_Smithing,
    [self._eCategory.Bookcase] = CppEnums.InstallationType.eType_Bookcase,
    [self._eCategory.Bed] = CppEnums.InstallationType.eType_Bed,
    [self._eCategory.Ceiling] = CppEnums.InstallationType.eType_Chandelier,
    [self._eCategory.WallPaper] = CppEnums.InstallationType.eType_WallPaper,
    [self._eCategory.FloorMaterial] = CppEnums.InstallationType.eType_FloorMaterial,
    [self._eCategory.Cooking] = CppEnums.InstallationType.eType_Cooking,
    [self._eCategory.Alchemy] = CppEnums.InstallationType.eType_Alchemy
  }
  self._categoryText = {
    [self._eCategory.All] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALL"),
    [self._eCategory.AllFurniture] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALL"),
    [self._eCategory.Dresser] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_DRESSER"),
    [self._eCategory.Wardrobe] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_WARDRODE"),
    [self._eCategory.Table] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_TABLE"),
    [self._eCategory.Chair] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_CHAIR"),
    [self._eCategory.Bookcase] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_BOOKCASE"),
    [self._eCategory.Bed] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_BED"),
    [self._eCategory.AllGoods] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALL"),
    [self._eCategory.OntheTable] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ONTHETABLE"),
    [self._eCategory.Floor] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_FLOOR"),
    [self._eCategory.Wall] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_WALL"),
    [self._eCategory.Ceiling] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_CEILING"),
    [self._eCategory.AllBaseMaterial] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALL"),
    [self._eCategory.WallPaper] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_WALLPAPER"),
    [self._eCategory.FloorMaterial] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_FLOORMATERIAL"),
    [self._eCategory.AllTools] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALL"),
    [self._eCategory.Cooking] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_COOKING"),
    [self._eCategory.Alchemy] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_TOOLTIP_CATEGORYICON_ALCHEMY")
  }
end
function PaGlobal_House_InstallationList_All:createItemSlot()
  local maxSlot = self._itemSlotRow * self._itemSlotCol
  local gabSize = self._ui._stc_itemTemplete:GetSizeX() + 5
  for slot_Idx = 0, maxSlot - 1 do
    local tempArray = {}
    local itemBg = UI.cloneControl(self._ui._stc_itemTemplete, self._ui._stc_itemListBg, "Static_House_ItemBG_" .. slot_Idx)
    local checkMark = UI.getChildControl(itemBg, "Static_CheckMarkTemplete")
    local settedPearlBg = UI.getChildControl(itemBg, "Static_SettedPearlItemBG")
    local hotKeyNumber = UI.getChildControl(itemBg, "StaticText_ShortCut")
    local col = math.floor(slot_Idx % self._itemSlotCol)
    local row = math.floor(slot_Idx / self._itemSlotCol)
    itemBg:SetPosX(self._itemStartPos.x + col * gabSize)
    itemBg:SetPosY(self._itemStartPos.y + row * gabSize)
    local slot = {}
    SlotItem.new(slot, "Static_ItemSlot_" .. slot_Idx, slot_Idx, itemBg, self._slotConfig)
    slot:createChild()
    slot.icon:SetShow(false)
    tempArray._itemBg = itemBg
    tempArray._checkMark = checkMark
    tempArray._settedPearlBg = settedPearlBg
    tempArray._hotKeyNumber = hotKeyNumber
    tempArray._slotItem = slot
    tempArray._itemBg:SetChildIndex(tempArray._checkMark, 9999)
    tempArray._itemBg:SetChildIndex(tempArray._hotKeyNumber, 9000)
    tempArray._hotKeyNumber:SetText(tostring(slot_Idx + 1))
    tempArray._hotKeyNumber:SetShow(false)
    UIScroll.InputEventByControl(tempArray._slotItem.icon, "HandleEventScroll_House_InstallationList_All_UpdateScroll")
    UIScroll.InputEventByControl(tempArray._itemBg, "HandleEventScroll_House_InstallationList_All_UpdateScroll")
    tempArray._itemBg:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_FocusSlot(" .. slot_Idx .. ")")
    if 0 == row and col < self._itemSlotCol then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_House_InstallationList_All_UpdateScroll(true)")
    elseif self._itemSlotRow - 1 == row then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_House_InstallationList_All_UpdateScroll(false)")
    end
    tempArray._itemBg:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_FocusSlot(" .. slot_Idx .. ")")
    if 0 == row and col < self._itemSlotCol then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_House_InstallationList_All_UpdateScroll(true)")
    elseif self._itemSlotRow - 1 == row then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_House_InstallationList_All_UpdateScroll(false)")
    end
    self._slotUIPool[slot_Idx] = tempArray
  end
  self._ui._stc_itemTemplete:SetShow(false)
end
function PaGlobal_House_InstallationList_All:updateItemSlot(startSlotIndex)
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return
  end
  local maxSlot = self._itemSlotRow * self._itemSlotCol
  for slot_Idx = 0, maxSlot - 1 do
    local uiSlot = self._slotUIPool[slot_Idx]
    uiSlot._slotItem.icon:addInputEvent("Mouse_On", "")
    uiSlot._slotItem.icon:addInputEvent("Mouse_Out", "")
    uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "")
    uiSlot._slotItem:clearItem()
    uiSlot._itemBg:SetShow(true)
    uiSlot._checkMark:SetShow(false)
    uiSlot._settedPearlBg:SetShow(false)
    uiSlot._hotKeyNumber:SetShow(false)
  end
  if true == self._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  for slot_Idx = 0, maxSlot - 1 do
    local dataIndex = startSlotIndex + slot_Idx
    local uiSlot = self._slotUIPool[slot_Idx]
    local data = ToClient_GetFurniture(dataIndex)
    if nil == data then
      return
    end
    if false == self._isConsole and dataIndex + 1 <= 8 then
      uiSlot._hotKeyNumber:SetShow(true)
    end
    if true == data._isInstalled then
      if true == self._isConsole then
        if slot_Idx == self._currentItemIndex then
          HandleEventOn_House_InstallationList_All_InstalledTooltip(data._invenSlotNo, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_House_InstallationList_All_InstalledTooltip(" .. data._invenSlotNo .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_InstalledTooltip(" .. data._invenSlotNo .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_InstalledDeleteObject(" .. data._invenSlotNo .. ")")
      uiSlot._checkMark:SetShow(true)
      uiSlot._settedPearlBg:SetShow(false)
    elseif not data._isCashProduct then
      if true == self._isConsole then
        if slot_Idx == self._currentItemIndex then
          HandleEventOn_House_InstallationList_All_NormalItemTooltip(data._invenType, data._invenSlotNo, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_House_InstallationList_All_NormalItemTooltip(" .. data._invenType .. ", " .. data._invenSlotNo .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_NormalItemTooltip(" .. data._invenType .. ", " .. data._invenSlotNo .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_InstallFurniture(" .. data._invenType .. ", " .. data._invenSlotNo .. ", false, " .. 0 .. ")")
      uiSlot._checkMark:SetShow(false)
      uiSlot._settedPearlBg:SetShow(false)
    else
      if true == self._isConsole then
        if slot_Idx == self._currentItemIndex then
          HandleEventOn_House_InstallationList_All_CacheItemTooltip(data._productNoRaw, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_House_InstallationList_All_CacheItemTooltip(" .. data._productNoRaw .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_CacheItemTooltip(" .. data._productNoRaw .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_InstallFurniture(" .. data._invenType .. ", " .. data._invenSlotNo .. ", true, " .. data._productNoRaw .. ")")
      uiSlot._checkMark:SetShow(false)
      uiSlot._settedPearlBg:SetShow(true)
    end
    uiSlot._slotItem:setItemByStaticStatus(data:getItemStaticStatusWrapper(), 0)
    uiSlot._slotItem.icon:SetAlpha(1)
    uiSlot._slotItem.icon:SetShow(true)
    uiSlot._slotItem.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  end
end
function PaGlobal_House_InstallationList_All:initItemSlotScroll()
  self._startItemSlotIndex = 0
  self._ui._scroll_itemList:SetControlTop()
  self._ui._scroll_itemList:SetControlPos(0)
  self:updateItemSetData(true)
end
function PaGlobal_House_InstallationList_All:updateItemSetData(initflag)
  ToClient_Furniture_Setdata(initflag)
  self._maxItemDataCount = ToClient_GetFurnitureListSize()
  self:updateScrollSize()
end
function PaGlobal_House_InstallationList_All:updateScrollSize()
  local slotCount = self._itemSlotRow * self._itemSlotCol
  UIScroll.SetButtonSize(self._ui._scroll_itemList, slotCount, self._maxItemDataCount)
end
function PaGlobal_House_InstallationList_All:updateTabTooltip(tabIndex)
  if false == self._isConsole then
    return
  end
  local name = ""
  if PaGlobal_House_InstallationList_All._eTabMenu.All == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "HOUSING_BTN_SEARCH_ALL")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Goods == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_GOODS")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Furniture == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_FURNITURE")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.BaseMaterial == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_BASEMATERIAL")
  elseif PaGlobal_House_InstallationList_All._eTabMenu.Tools == tabIndex then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HOUSE_INSTALLATIONMODE_SEARCH_TOOLS")
  else
    return
  end
  self._ui._console._txt_tabTooltip:SetText(name)
  self._ui._console._txt_tabTooltip:SetSize(self._ui._console._txt_tabTooltip:GetTextSizeX() + 10, self._ui._console._txt_tabTooltip:GetSizeY())
  local posX = self._ui._rdo_tabMenu[tabIndex]:GetPosX() + (self._ui._rdo_tabMenu[tabIndex]:GetSizeX() - self._ui._console._txt_tabTooltip:GetSizeX()) * 0.5
  self._ui._console._txt_tabTooltip:SetPosX(posX)
  self._ui._console._stc_tooltipArrow:ComputePos()
end
function PaGlobal_House_InstallationList_All:updateTabMenu(tabIndex)
  for k, value in pairs(self._ui._rdo_tabMenu) do
    value:SetCheck(false)
  end
  self._currentTabIndex = tabIndex
  self._ui._rdo_tabMenu[tabIndex]:SetCheck(true)
  self:updateTabAll(tabIndex)
  self:updateTabTooltip(tabIndex)
  self:initItemSlotScroll()
  self:updateItemSlot(self._startItemSlotIndex)
  self:updateComboCategory(tabIndex)
  self:clearEdit()
end
function PaGlobal_House_InstallationList_All:updateComboCategory(tabIndex)
  self._ui._combo_categoryType:DeleteAllItem()
  self._categoryList = Array.new()
  if self._eTabMenu.All == tabIndex then
    self._categoryList:push_back(self._eCategory.All)
    self._categoryList:push_back(self._eCategory.Dresser)
    self._categoryList:push_back(self._eCategory.Wardrobe)
    self._categoryList:push_back(self._eCategory.Table)
    self._categoryList:push_back(self._eCategory.Chair)
    self._categoryList:push_back(self._eCategory.Bookcase)
    self._categoryList:push_back(self._eCategory.Bed)
    self._categoryList:push_back(self._eCategory.OntheTable)
    self._categoryList:push_back(self._eCategory.Floor)
    self._categoryList:push_back(self._eCategory.Wall)
    self._categoryList:push_back(self._eCategory.Ceiling)
    self._categoryList:push_back(self._eCategory.WallPaper)
    self._categoryList:push_back(self._eCategory.FloorMaterial)
    self._categoryList:push_back(self._eCategory.Cooking)
    self._categoryList:push_back(self._eCategory.Alchemy)
  elseif self._eTabMenu.Goods == tabIndex then
    self._categoryList:push_back(self._eCategory.AllGoods)
    self._categoryList:push_back(self._eCategory.OntheTable)
    self._categoryList:push_back(self._eCategory.Floor)
    self._categoryList:push_back(self._eCategory.Wall)
    self._categoryList:push_back(self._eCategory.Ceiling)
  elseif self._eTabMenu.Furniture == tabIndex then
    self._categoryList:push_back(self._eCategory.AllFurniture)
    self._categoryList:push_back(self._eCategory.Dresser)
    self._categoryList:push_back(self._eCategory.Wardrobe)
    self._categoryList:push_back(self._eCategory.Table)
    self._categoryList:push_back(self._eCategory.Chair)
    self._categoryList:push_back(self._eCategory.Bookcase)
    self._categoryList:push_back(self._eCategory.Bed)
  elseif self._eTabMenu.BaseMaterial == tabIndex then
    self._categoryList:push_back(self._eCategory.AllBaseMaterial)
    self._categoryList:push_back(self._eCategory.WallPaper)
    self._categoryList:push_back(self._eCategory.FloorMaterial)
  elseif self._eTabMenu.Tools == tabIndex then
    self._categoryList:push_back(self._eCategory.AllTools)
    self._categoryList:push_back(self._eCategory.Cooking)
    self._categoryList:push_back(self._eCategory.Alchemy)
  end
  for k, value in pairs(self._categoryList) do
    self._ui._combo_categoryType:AddItem(self._categoryText[value])
  end
  if 0 < self._categoryList:length() then
    self._ui._combo_categoryType:SetText(self._categoryText[self._categoryList[1]])
  end
end
function PaGlobal_House_InstallationList_All:updateCategoryFilter(categoryType)
  if nil == categoryType then
    return
  end
  ToClient_Housing_List_ClearFilter()
  if self._eCategory.All == categoryType then
    self:updateTabAll(self._eTabMenu.All)
  elseif self._eCategory.AllFurniture == categoryType then
    self:updateTabAll(self._eTabMenu.Furniture)
  elseif self._eCategory.AllGoods == categoryType then
    self:updateTabAll(self._eTabMenu.Goods)
  elseif self._eCategory.AllBaseMaterial == categoryType then
    self:updateTabAll(self._eTabMenu.BaseMaterial)
  elseif self._eCategory.AllTools == categoryType then
    self:updateTabAll(self._eTabMenu.Tools)
  elseif self._eCategory.OntheTable == categoryType then
    ToClient_Housing_List_Filter_Table()
  elseif self._eCategory.Floor == categoryType then
    ToClient_Housing_List_Filter_Floor()
  elseif self._eCategory.Wall == categoryType then
    ToClient_Housing_List_Filter_Wall()
  else
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[categoryType])
    if self._eCategory.Table == categoryType then
      ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_Forging)
    end
  end
  self:initItemSlotScroll()
  self:updateItemSlot(self._startItemSlotIndex)
  self:clearEdit()
end
function PaGlobal_House_InstallationList_All:updateTabAll(tabIndex)
  ToClient_Housing_List_ClearFilter()
  if self._eTabMenu.All == tabIndex then
  elseif self._eTabMenu.Goods == tabIndex then
    ToClient_Housing_List_Filter_Table()
    ToClient_Housing_List_Filter_Floor()
    ToClient_Housing_List_Filter_Wall()
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Ceiling])
  elseif self._eTabMenu.Furniture == tabIndex then
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Dresser])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Wardrobe])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Table])
    ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_Forging)
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Chair])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Bookcase])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Bed])
  elseif self._eTabMenu.BaseMaterial == tabIndex then
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.WallPaper])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.FloorMaterial])
  elseif self._eTabMenu.Tools == tabIndex then
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Cooking])
    ToClient_Housing_List_Filter_InstallType(self._categoryIndex[self._eCategory.Alchemy])
  end
end
function PaGlobal_House_InstallationList_All:updateResetButton()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer or nil == selfPlayer:get() then
    self._ui._pc._btn_resetFurniture:SetIgnore(true)
    self._ui._pc._btn_resetFurniture:SetMonoTone(true)
    return
  end
  local isMyHouse = selfPlayer:get():isMyHouseVisiting()
  self._ui._pc._btn_resetFurniture:SetIgnore(not isMyHouse)
  self._ui._pc._btn_resetFurniture:SetMonoTone(not isMyHouse)
end
function PaGlobal_House_InstallationList_All:clearEdit()
  ClearFocusEdit()
  self._ui._txt_searchIcon:SetShow(true)
  self._ui._edit_searchBox:SetEditText("", true)
end
function PaGlobal_House_InstallationList_All:createCartItemSlot()
  local maxSlot = self._cartItemSlotRow * self._cartItemSlotCol
  local gabSize = self._ui._stc_cartItemTemplete:GetSizeX() + 5
  for slot_Idx = 0, maxSlot - 1 do
    local tempArray = {}
    local itemBg = UI.cloneControl(self._ui._stc_cartItemTemplete, self._ui._stc_cartItemListBg, "Static_House_WishItemBG_" .. slot_Idx)
    local checkMark = UI.getChildControl(itemBg, "Static_CheckMarkTemplete")
    local col = math.floor(slot_Idx % self._cartItemSlotCol)
    local row = math.floor(slot_Idx / self._cartItemSlotCol)
    itemBg:SetPosX(self._cartItemStartPos.x + col * gabSize)
    itemBg:SetPosY(self._cartItemStartPos.y + row * gabSize)
    local slot = {}
    SlotItem.new(slot, "Static_CartItemSlot_" .. slot_Idx, slot_Idx, itemBg, self._slotConfig)
    slot:createChild()
    slot.icon:SetShow(false)
    tempArray._itemBg = itemBg
    tempArray._checkMark = checkMark
    tempArray._slotItem = slot
    tempArray._itemBg:SetChildIndex(tempArray._checkMark, 9999)
    UIScroll.InputEventByControl(tempArray._slotItem.icon, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll")
    UIScroll.InputEventByControl(tempArray._itemBg, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll")
    tempArray._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationList_All_CartItemRemove(" .. slot_Idx .. ")")
    if 0 == row and col < self._cartItemSlotCol then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll(true)")
    elseif self._cartItemSlotRow - 1 == row then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_House_InstallationList_All_UpdateCartScroll(false)")
    end
    self._slotUICartPool[slot_Idx] = tempArray
  end
  self._ui._stc_cartItemTemplete:SetShow(false)
end
function PaGlobal_House_InstallationList_All:updateCartItemSlot()
  local maxSlot = self._cartItemSlotRow * self._cartItemSlotCol
  for slot_Idx = 0, maxSlot - 1 do
    local uiSlot = self._slotUICartPool[slot_Idx]
    uiSlot._itemBg:SetShow(true)
    uiSlot._slotItem:clearItem()
    uiSlot._slotItem.icon:addInputEvent("Mouse_On", "")
    uiSlot._slotItem.icon:addInputEvent("Mouse_Out", "")
  end
  if 0 >= self._maxCartItemDataCount then
    return
  end
  for slot_Idx = 0, maxSlot - 1 do
    local dataIndex = self._startCartItemSlotIndex + slot_Idx
    local uiSlot = self._slotUICartPool[slot_Idx]
    local data = housing_getShoppingBasketItemByIndex_New(dataIndex)
    if nil == data then
      return
    end
    uiSlot._itemBg:SetShow(true)
    uiSlot._slotItem:setItemByStaticStatus(data:getItemByIndex(0), 0)
    uiSlot._slotItem.icon:SetShow(true)
    uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_House_InstallationList_All_CartItemTooltip(" .. dataIndex .. ", " .. slot_Idx .. ")")
    uiSlot._slotItem.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    if true == self._isConsole then
      if slot_Idx == self._currentItemIndex then
        HandleEventOn_House_InstallationList_All_CartItemTooltip(dataIndex, slot_Idx)
      end
      uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_House_InstallationList_All_CartItemTooltip(" .. dataIndex .. ", " .. slot_Idx .. ", true)")
    end
  end
end
function PaGlobal_House_InstallationList_All:initCartItemSlotScroll()
  self._startCartItemSlotIndex = 0
  self._ui._scroll_cartItemList:SetControlTop()
  self._ui._scroll_cartItemList:SetControlPos(0)
  self:updateCartItemSetData()
end
function PaGlobal_House_InstallationList_All:updateCartItemSetData()
  self._maxCartItemDataCount = housing_getShoppingBasketItemCount()
  self:updateCartScrollSize()
  self:updateCartItemSlot()
  self:updateCartPoint()
end
function PaGlobal_House_InstallationList_All:updateCartScrollSize()
  local slotCount = self._cartItemSlotRow * self._cartItemSlotCol
  UIScroll.SetButtonSize(self._ui._scroll_cartItemList, slotCount, self._maxCartItemDataCount)
end
function PaGlobal_House_InstallationList_All:updateCartPoint()
  self:updateBuyPoint()
  self:updateHavePearl()
  self:updatePrice()
end
function PaGlobal_House_InstallationList_All:updateBuyPoint()
  self._ui._txt_housingPointValue:SetText(ToClient_GetVisitingBuyExpectPlusInteriorPoint())
end
function PaGlobal_House_InstallationList_All:updateHavePearl()
  local s64_havePearls = 0
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  if nil ~= pearlItemWrapper then
    s64_havePearls = pearlItemWrapper:get():getCount_s64()
  end
  self._ui._txt_pearlPointValue:SetText(makeDotMoney(s64_havePearls))
end
function PaGlobal_House_InstallationList_All:updatePrice()
  local s64_SumPearls = toInt64(0, 0)
  for idx = 0, self._maxCartItemDataCount - 1 do
    local data = housing_getShoppingBasketItemByIndex_New(idx)
    if nil ~= data then
      local itemSSW = data:getItemByIndex(0)
      s64_SumPearls = s64_SumPearls + data:getPrice()
    end
  end
  self._ui._txt_priceValue:SetText(makeDotMoney(s64_SumPearls))
end
function PaGlobal_House_InstallationList_All:setKeyPosX(parantControl, keyList)
  local space = 44
  local maxLength = 0
  for key, value in ipairs(keyList) do
    if true == value:GetShow() then
      local spaceFromRight = value:GetTextSizeX() + space
      maxLength = math.max(maxLength, spaceFromRight)
    end
  end
  local parantControlSizeX = parantControl:GetSizeX()
  for key, value in ipairs(keyList) do
    if true == value:GetShow() then
      value:SetPosX(parantControlSizeX - maxLength)
    end
  end
end
function PaGlobal_House_InstallationList_All:setKeyGuide(modeState)
  for k, value in pairs(self._ui._keyGuide) do
    value:SetShow(false)
  end
  local isRotatePossible = housing_isAvailableRotateSelectedObject()
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  local isFixed, installationType, isPersonalTent
  if nil ~= houseWrapper then
    isFixed = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() or houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom()
  end
  if nil ~= characterStaticWrapper then
    installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
    local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
    isPersonalTent = objectStaticWrapper:isPersonalTent()
  end
  if PaGlobal_House_Installation_All._eModeState.none == modeState then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_RS_leftright
    }
    self._ui._keyGuide._txt_RS_click:SetText(self._keyGuideString.changeCamMode)
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetText(self._keyGuideString.zoomInOut)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    self:setKeyPosX(self._ui._console._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._console._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  elseif PaGlobal_House_Installation_All._eModeState.translation == modeState then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_LS,
      self._ui._keyGuide._txt_LB_RB,
      self._ui._keyGuide._txt_LT_RT,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetText(self._keyGuideString.changeCamMode)
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetText(self._keyGuideString.zoomInOut)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    if true == isFixed then
      self._ui._keyGuide._txt_LS:SetText(self._keyGuideString.moveBuild)
      self._ui._keyGuide._txt_LS:SetShow(true)
    end
    if true == isRotatePossible then
      self._ui._keyGuide._txt_LB_RB:SetShow(true)
      self._ui._keyGuide._txt_LT_RT:SetShow(true)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.build)
    self._ui._keyGuide._txt_A:SetShow(true)
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._console._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._console._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, 44, 10)
  elseif PaGlobal_House_Installation_All._eModeState.detail == modeState then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_LS,
      self._ui._keyGuide._txt_LB_RB,
      self._ui._keyGuide._txt_LT_RT,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetText(self._keyGuideString.zoomInOutAndHeight)
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
    end
    if CppEnums.InstallationType.eType_Curtain == installationType or CppEnums.InstallationType.eType_Curtain_Tied == installationType then
      self._ui._keyGuide._txt_LS:SetText(self._keyGuideString.changeWidthBuild)
      self._ui._keyGuide._txt_LS:SetShow(true)
    end
    if CppEnums.InstallationType.eType_Chandelier == installationType or CppEnums.InstallationType.eType_Curtain == installationType or CppEnums.InstallationType.eType_Curtain_Tied == installationType then
      if false == ToClient_isCameraControlModeForConsole() then
        self._ui._keyGuide._txt_RS_updown:SetShow(false)
      else
        self._ui._keyGuide._txt_RS_updown:SetText(self._keyGuideString.changeHeightBuild)
        self._ui._keyGuide._txt_RS_updown:SetShow(true)
      end
    end
    if true == isRotatePossible then
      self._ui._keyGuide._txt_LB_RB:SetShow(true)
      self._ui._keyGuide._txt_LT_RT:SetShow(true)
    else
      self._ui._keyGuide._txt_LB_RB:SetShow(false)
      self._ui._keyGuide._txt_LT_RT:SetShow(false)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.build)
    self._ui._keyGuide._txt_A:SetShow(true)
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._console._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._console._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  elseif PaGlobal_House_Installation_All._eModeState.watingConfirm == modeState then
    local keyList = {
      self._ui._keyGuide._txt_RS_click,
      self._ui._keyGuide._txt_RS_updown,
      self._ui._keyGuide._txt_RS_leftright,
      self._ui._keyGuide._txt_RS,
      self._ui._keyGuide._txt_LB_RB,
      self._ui._keyGuide._txt_LT_RT,
      self._ui._keyGuide._txt_A,
      self._ui._keyGuide._txt_Y,
      self._ui._keyGuide._txt_X,
      self._ui._keyGuide._txt_B
    }
    self._ui._keyGuide._txt_RS_click:SetText(self._keyGuideString.changeCamMode)
    self._ui._keyGuide._txt_RS_click:SetShow(true)
    if false == ToClient_isCameraControlModeForConsole() then
      self._ui._keyGuide._txt_RS:SetShow(true)
      self._ui._keyGuide._txt_RS_leftright:SetShow(false)
      self._ui._keyGuide._txt_RS_updown:SetShow(false)
    else
      self._ui._keyGuide._txt_RS:SetShow(false)
      self._ui._keyGuide._txt_RS_leftright:SetShow(true)
      self._ui._keyGuide._txt_RS_updown:SetText(self._keyGuideString.zoomInOut)
      self._ui._keyGuide._txt_RS_updown:SetShow(true)
    end
    if true == isRotatePossible then
      self._ui._keyGuide._txt_LB_RB:SetShow(true)
      self._ui._keyGuide._txt_LT_RT:SetShow(true)
    end
    self._ui._keyGuide._txt_A:SetText(self._keyGuideString.install)
    self._ui._keyGuide._txt_A:SetShow(true)
    if true == PaGlobal_House_Installation_All_IsCanDelete() then
      self._ui._keyGuide._txt_X:SetShow(true)
    end
    if true == PaGlobal_House_Installation_All_IsCanMove() then
      self._ui._keyGuide._txt_Y:SetShow(true)
    end
    self._ui._keyGuide._txt_B:SetShow(true)
    self:setKeyPosX(self._ui._console._stc_consoleKeyBG, keyList)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyList, self._ui._console._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 10)
  end
end
