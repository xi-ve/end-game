function PaGlobal_Farm_InstallationList_All:initialize()
  if true == PaGlobal_Farm_InstallationList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_modeRight = UI.getChildControl(Panel_House_InstallationMode_SeedList_All, "Static_House_InstallationMode_Right")
  local stc_tabMenuBg = UI.getChildControl(stc_modeRight, "Static_TabMenuBG")
  local stc_bottomBg = UI.getChildControl(stc_modeRight, "Static_BottomBg")
  self._ui._pc._btn_restoreAll = UI.getChildControl(stc_bottomBg, "Button_RestoreAll")
  self._ui._pc._btn_exit = UI.getChildControl(stc_bottomBg, "Button_Exit")
  self._ui._console._stc_LBKey = UI.getChildControl(stc_tabMenuBg, "Static_LB_Console")
  self._ui._console._stc_RBKey = UI.getChildControl(stc_tabMenuBg, "Static_RB_Console")
  self._ui._console._txt_closeKey = UI.getChildControl(stc_bottomBg, "StaticText_B_Close_ConsoleUI")
  self._ui._console._txt_selectKey = UI.getChildControl(stc_bottomBg, "StaticText_A_Select_ConsoleUI")
  self._ui._console._txt_buyKey = UI.getChildControl(stc_bottomBg, "StaticText_Y_BuyAll_ConsoleUI")
  self._ui._console._stc_consoleKeyBG = UI.getChildControl(stc_modeRight, "Static_KeyGuide_ConsoleBG")
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
  self._ui._rdo_tabMenu = {
    [self._eTabType.all] = UI.getChildControl(stc_tabMenuBg, "RadioButton_AllIcon"),
    [self._eTabType.seed] = UI.getChildControl(stc_tabMenuBg, "RadioButton_Seed"),
    [self._eTabType.material] = UI.getChildControl(stc_tabMenuBg, "RadioButton_Material")
  }
  self._ui._stc_selectLine = UI.getChildControl(stc_tabMenuBg, "Static_SelectLine")
  local stc_categoryBg = UI.getChildControl(stc_modeRight, "Static_CategoryBG")
  self._ui._edit_searchBox = UI.getChildControl(stc_categoryBg, "Edit_SearchBox")
  self._ui._txt_searchIcon = UI.getChildControl(self._ui._edit_searchBox, "StaticText_SearchIcon")
  self._ui._console._stc_LTXKey = UI.getChildControl(self._ui._edit_searchBox, "StaticText_KeyGuideLTX")
  self._ui._stc_itemListBg = UI.getChildControl(stc_modeRight, "Static_HousingItemListBG")
  self._ui._stc_itemTemplete = UI.getChildControl(self._ui._stc_itemListBg, "Static_Item_Templete")
  self._ui._scroll_itemList = UI.getChildControl(self._ui._stc_itemListBg, "Scroll_HousingItemList")
  local stc_farmingGuide = UI.getChildControl(stc_modeRight, "Static_FarmingGuide")
  self._ui._stc_guideBg = UI.getChildControl(stc_farmingGuide, "Static_GuideBG")
  self._ui._rdo_basicButtons = {
    [self._eBasicType.gatherSeed] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_GatherSeed"),
    [self._eBasicType.temperature] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Temp"),
    [self._eBasicType.humidity] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Hum"),
    [self._eBasicType.undergroundWater] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Underground"),
    [self._eBasicType.moisture] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Water"),
    [self._eBasicType.health] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Helth")
  }
  self._ui._rdo_manageButtons = {
    [self._eManageType.scarecrow] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Scare"),
    [self._eManageType.waterway] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_WaterRoad"),
    [self._eManageType.pruning] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Pruning"),
    [self._eManageType.pestControl] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Pest"),
    [self._eManageType.feed] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Feed"),
    [self._eManageType.bugs] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Bugs")
  }
  self._ui._rdo_harvestButtons = {
    [self._eHarvestType.fruitHarvest] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_FruitHarvest"),
    [self._eHarvestType.harvest] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_Harvest"),
    [self._eHarvestType.breedImprovement] = UI.getChildControl(self._ui._stc_guideBg, "RadioButton_BreedImpro")
  }
  self._ui._frame_guideDescBg = UI.getChildControl(stc_modeRight, "Frame_GuideDescBG")
  self._ui._frame_VScroll = self._ui._frame_guideDescBg:GetVScroll()
  self._ui._frame_Content = UI.getChildControl(self._ui._frame_guideDescBg, "Frame_1_Content")
  self._ui._frame_VScroll_Console = UI.getChildControl(self._ui._frame_guideDescBg, "Scroll_CtrlButton")
  self._ui._txt_descTitle = UI.getChildControl(self._ui._frame_Content, "StaticText_DescTitle")
  self._ui._txt_desc = UI.getChildControl(self._ui._frame_Content, "StaticText_Desc")
  self._itemStartPos.x = self._ui._stc_itemTemplete:GetPosX()
  self._itemStartPos.y = self._ui._stc_itemTemplete:GetPosY()
  self._ui._txt_descTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  for k, value in pairs(self._ui._console) do
    value:SetShow(self._isConsole)
  end
  local isPc = false == self._isConsole
  for k, value in pairs(self._ui._pc) do
    value:SetShow(isPc)
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
  self:initGuideText()
  self:createItemSlot()
  PaGlobal_Farm_InstallationList_All:registEventHandler()
  PaGlobal_Farm_InstallationList_All:validate()
  PaGlobal_Farm_InstallationList_All._initialize = true
end
function PaGlobal_Farm_InstallationList_All:registEventHandler()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  for k, value in pairs(self._ui._rdo_tabMenu) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_TabEvent(" .. k .. ")")
  end
  self._ui._pc._btn_restoreAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_ResetFurniture()")
  self._ui._pc._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_Exit()")
  if true == self._isConsole then
    Panel_House_InstallationMode_SeedList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_Farm_InstallationList_All_SetSearchFocus()")
    self._ui._edit_searchBox:setXboxVirtualKeyBoardEndEvent("HandleEventKey_Farm_InstallationList_All_FindItemName_ForConsole")
  else
    self._ui._edit_searchBox:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_EditItemNameClear()")
    self._ui._edit_searchBox:RegistReturnKeyEvent("HandleEventKey_Farm_InstallationList_All_FindItemName()")
  end
  for k, value in pairs(self._ui._rdo_basicButtons) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_BasicGuide(" .. k .. ")")
    value:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_BasicGuideTooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  for k, value in pairs(self._ui._rdo_manageButtons) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_ManageGuide(" .. k .. ")")
    value:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_ManageGuideTooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  for k, value in pairs(self._ui._rdo_harvestButtons) do
    value:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_HarvestGuide(" .. k .. ")")
    value:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_HarverstGuideTooltip(" .. k .. ")")
    value:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  UIScroll.InputEvent(self._ui._scroll_itemList, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll")
  UIScroll.InputEventByControl(self._ui._stc_itemListBg, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll")
  registerEvent("EventHousingUpdateInstallationInven", "FromClient_Farm_InstallationList_All_UpdateItemInventory")
  registerEvent("EventUpdateInstallationActor", "FromClient_Farm_InstallationList_All_UpdateInstallationActor")
  registerEvent("EventHousingCancelInstallModeMessageBox", "FromClient_Farm_InstallationList_All_CancelInstallModeMessageBox")
  Panel_House_InstallationMode_SeedList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPad_Farm_InstallationList_All_LBorRB(true)")
  Panel_House_InstallationMode_SeedList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPad_Farm_InstallationList_All_LBorRB(false)")
  Panel_House_InstallationMode_SeedList_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_Farm_InstallationList_All_ResetFurniture()")
end
function PaGlobal_Farm_InstallationList_All:prepareOpen()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  self:initRadioButton()
  self:updateTabMenu(self._eTabType.all)
  self:setKeyGuide(PaGlobal_House_Installation_All._eModeState.none)
  if true == self._isConsole then
    Panel_House_InstallationMode_SeedList_All:RegisterUpdateFunc("PaGlobal_Farm_InstallationList_All_UpdatePerFrame")
  end
  PaGlobal_Farm_InstallationList_All:open()
end
function PaGlobal_Farm_InstallationList_All:open()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  Panel_House_InstallationMode_SeedList_All:SetShow(true)
end
function PaGlobal_Farm_InstallationList_All:prepareClose()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  if true == self._isConsole then
    Panel_House_InstallationMode_SeedList_All:ClearUpdateLuaFunc()
  end
  PaGlobal_Farm_InstallationList_All:close()
end
function PaGlobal_Farm_InstallationList_All:close()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
  Panel_House_InstallationMode_SeedList_All:SetShow(false)
end
function PaGlobal_Farm_InstallationList_All:update()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
end
function PaGlobal_Farm_InstallationList_All:validate()
  if nil == Panel_House_InstallationMode_SeedList_All then
    return
  end
end
function PaGlobal_Farm_InstallationList_All:initRadioButton()
  for k, value in pairs(self._ui._rdo_basicButtons) do
    value:SetCheck(false)
  end
  for k, value in pairs(self._ui._rdo_manageButtons) do
    value:SetCheck(false)
  end
  for k, value in pairs(self._ui._rdo_harvestButtons) do
    value:SetCheck(false)
  end
  self._ui._rdo_basicButtons[self._eBasicType.gatherSeed]:SetCheck(true)
  HandleEventLUp_Farm_InstallationList_All_BasicGuide(self._eBasicType.gatherSeed)
end
function PaGlobal_Farm_InstallationList_All:createItemSlot()
  local maxSlot = self._itemSlotRow * self._itemSlotCol
  local gabSize = self._ui._stc_itemTemplete:GetSizeX() + 5
  for slot_Idx = 0, maxSlot - 1 do
    local tempArray = {}
    local itemBg = UI.cloneControl(self._ui._stc_itemTemplete, self._ui._stc_itemListBg, "Static_House_ItemBG_" .. slot_Idx)
    local checkMark = UI.getChildControl(itemBg, "Static_CheckMarkTemplete")
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
    tempArray._hotKeyNumber = hotKeyNumber
    tempArray._slotItem = slot
    tempArray._itemBg:SetChildIndex(tempArray._checkMark, 9999)
    tempArray._itemBg:SetChildIndex(tempArray._hotKeyNumber, 9000)
    tempArray._hotKeyNumber:SetText(tostring(slot_Idx + 1))
    tempArray._hotKeyNumber:SetShow(false)
    UIScroll.InputEventByControl(tempArray._slotItem.icon, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll")
    UIScroll.InputEventByControl(tempArray._itemBg, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll")
    tempArray._itemBg:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_FocusSlot(" .. slot_Idx .. ")")
    if 0 == row and col < self._itemSlotCol then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll(true)")
    elseif self._itemSlotRow - 1 == row then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll(false)")
    end
    tempArray._itemBg:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_FocusSlot(" .. slot_Idx .. ")")
    if 0 == row and col < self._itemSlotCol then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll(true)")
    elseif self._itemSlotRow - 1 == row then
      tempArray._itemBg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventScroll_Farm_InstallationList_All_UpdateScroll(false)")
    end
    self._slotUIPool[slot_Idx] = tempArray
  end
  self._ui._stc_itemTemplete:SetShow(false)
end
function PaGlobal_Farm_InstallationList_All:updateItemSlot(startSlotIndex)
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
          HandleEventOn_Farm_InstallationList_All_InstalledTooltip(data._invenSlotNo, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Farm_InstallationList_All_InstalledTooltip(" .. data._invenSlotNo .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_InstalledTooltip(" .. data._invenSlotNo .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_InstalledDeleteObject(" .. data._invenSlotNo .. ")")
      uiSlot._checkMark:SetShow(true)
    elseif not data._isCashProduct then
      if true == self._isConsole then
        if slot_Idx == self._currentItemIndex then
          HandleEventOn_Farm_InstallationList_All_NormalItemTooltip(data._invenType, data._invenSlotNo, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Farm_InstallationList_All_NormalItemTooltip(" .. data._invenType .. ", " .. data._invenSlotNo .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_NormalItemTooltip(" .. data._invenType .. ", " .. data._invenSlotNo .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_InstallFurniture(" .. data._invenType .. ", " .. data._invenSlotNo .. ", false, " .. 0 .. ")")
      uiSlot._checkMark:SetShow(false)
    else
      if true == self._isConsole then
        if slot_Idx == self._currentItemIndex then
          HandleEventOn_Farm_InstallationList_All_CacheItemTooltip(data._productNoRaw, slot_Idx)
        end
        uiSlot._itemBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_Farm_InstallationList_All_CacheItemTooltip(" .. data._productNoRaw .. ", " .. slot_Idx .. ", true)")
      end
      uiSlot._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Farm_InstallationList_All_CacheItemTooltip(" .. data._productNoRaw .. ", " .. slot_Idx .. ")")
      uiSlot._slotItem.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Farm_InstallationList_All_InstallFurniture(" .. data._invenType .. ", " .. data._invenSlotNo .. ", true, " .. data._productNoRaw .. ")")
      uiSlot._checkMark:SetShow(false)
    end
    uiSlot._slotItem:setItemByStaticStatus(data:getItemStaticStatusWrapper(), 0)
    uiSlot._slotItem.icon:SetAlpha(1)
    uiSlot._slotItem.icon:SetShow(true)
    uiSlot._slotItem.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  end
end
function PaGlobal_Farm_InstallationList_All:setKeyPosX(parantControl, keyList)
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
function PaGlobal_Farm_InstallationList_All:setKeyGuide(modeState)
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
function PaGlobal_Farm_InstallationList_All:initItemSlotScroll()
  self._startItemSlotIndex = 0
  self:updateItemSetData(true)
  self._ui._scroll_itemList:SetControlTop()
  self._ui._scroll_itemList:SetControlPos(0)
end
function PaGlobal_Farm_InstallationList_All:updateItemSetData(initflag)
  ToClient_Furniture_Setdata(initflag)
  self._maxItemDataCount = ToClient_GetFurnitureListSize()
  self:updateScrollSize()
end
function PaGlobal_Farm_InstallationList_All:updateScrollSize()
  local slotCount = self._itemSlotRow * self._itemSlotCol
  UIScroll.SetButtonSize(self._ui._scroll_itemList, slotCount, self._maxItemDataCount)
end
function PaGlobal_Farm_InstallationList_All:updateTabMenu(tabIndex)
  for k, value in pairs(self._ui._rdo_tabMenu) do
    value:SetCheck(false)
  end
  self._currentTabIndex = tabIndex
  self._ui._rdo_tabMenu[tabIndex]:SetCheck(true)
  self._ui._stc_selectLine:SetPosX(self._ui._rdo_tabMenu[tabIndex]:GetPosX())
  ToClient_Housing_List_ClearFilter()
  if self._eTabType.all == tabIndex then
  elseif self._eTabType.seed == tabIndex then
    ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_Havest)
    ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_LivestockHarvest)
  elseif self._eTabType.material == tabIndex then
    ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_Scarecrow)
    ToClient_Housing_List_Filter_InstallType(CppEnums.InstallationType.eType_Waterway)
  end
  self:initItemSlotScroll()
  self:updateItemSlot(self._startItemSlotIndex)
  self:clearEdit()
end
function PaGlobal_Farm_InstallationList_All:clearEdit()
  ClearFocusEdit()
  self._ui._txt_searchIcon:SetShow(true)
  self._ui._edit_searchBox:SetEditText("", true)
end
function PaGlobal_Farm_InstallationList_All:initGuideText()
  self._basicTitle = {
    [self._eBasicType.gatherSeed] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_0"),
    [self._eBasicType.temperature] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_1"),
    [self._eBasicType.humidity] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_2"),
    [self._eBasicType.undergroundWater] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_3"),
    [self._eBasicType.moisture] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_4"),
    [self._eBasicType.health] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_5")
  }
  self._basicDesc = {
    [self._eBasicType.gatherSeed] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_10"),
    [self._eBasicType.temperature] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_11"),
    [self._eBasicType.humidity] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_12"),
    [self._eBasicType.undergroundWater] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_13"),
    [self._eBasicType.moisture] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_14"),
    [self._eBasicType.health] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC0_15")
  }
  self._manageTitle = {
    [self._eManageType.scarecrow] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_0"),
    [self._eManageType.waterway] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_1"),
    [self._eManageType.pruning] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_2"),
    [self._eManageType.pestControl] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_3"),
    [self._eManageType.feed] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_4"),
    [self._eManageType.bugs] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_5")
  }
  self._manageDesc = {
    [self._eManageType.scarecrow] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_10"),
    [self._eManageType.waterway] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_11"),
    [self._eManageType.pruning] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_12"),
    [self._eManageType.pestControl] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_13"),
    [self._eManageType.feed] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_15"),
    [self._eManageType.bugs] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_16")
  }
  self._havestTitle = {
    [self._eHarvestType.fruitHarvest] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_0"),
    [self._eHarvestType.harvest] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_2"),
    [self._eHarvestType.breedImprovement] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_1")
  }
  self._havestDesc = {
    [self._eHarvestType.fruitHarvest] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_10"),
    [self._eHarvestType.harvest] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_12"),
    [self._eHarvestType.breedImprovement] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC2_13")
  }
end
function PaGlobal_Farm_InstallationList_All:updateDesc(title, desc)
  if nil == title or nil == desc then
    return
  end
  self._ui._txt_descTitle:SetText(title)
  self._ui._txt_desc:SetText(desc)
  self._ui._txt_desc:SetPosY(self._ui._txt_descTitle:GetPosY() + self._ui._txt_descTitle:GetTextSizeY() + 5)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._ui._txt_desc:GetTextSizeY())
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), self._ui._txt_desc:GetPosY() + self._ui._txt_desc:GetTextSizeY())
  self._ui._frame_VScroll:SetControlTop()
  self._ui._frame_guideDescBg:UpdateContentScroll()
  self._ui._frame_guideDescBg:UpdateContentPos()
  UIScroll.SetButtonSize(self._ui._frame_VScroll, self._ui._frame_guideDescBg:GetSizeY(), self._ui._frame_Content:GetSizeY() - 10)
  if true == self._isConsole then
    local scrollControl = self._ui._frame_VScroll:GetControlButton()
    scrollControl:SetShow(false)
    if true == self._ui._frame_VScroll:GetShow() then
      self._ui._frame_VScroll_Console:SetShow(true)
      self:updateConsoleScrollPos()
    else
      self._ui._frame_VScroll_Console:SetShow(false)
    end
  elseif true == self._ui._frame_VScroll:GetShow() then
    self._ui._frame_Content:SetEnable(true)
  else
    self._ui._frame_Content:SetEnable(false)
  end
end
function PaGlobal_Farm_InstallationList_All:updateConsoleScrollPos()
  local currentY = self._ui._frame_Content:GetPosY()
  local currentYSize = self._ui._frame_Content:GetSizeY()
  local maxPosY = self._ui._frame_guideDescBg:GetSizeY() - currentYSize
  self._ui._frame_VScroll_Console:SetPosY(currentY / maxPosY * (self._ui._frame_guideDescBg:GetSizeY() - 44))
end
