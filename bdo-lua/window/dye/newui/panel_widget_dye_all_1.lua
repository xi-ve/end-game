function PaGlobal_Dye_All:initialize()
  if true == PaGlobal_Dye_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_TabAreaBG = UI.getChildControl(Panel_Widget_Dye_All, "Static_TabGroup")
  self._ui.stc_SelectedTabLine = UI.getChildControl(self._ui.stc_TabAreaBG, "Static_SelectedLine")
  self._ui_console.stc_KeyGuideLB = UI.getChildControl(self._ui.stc_TabAreaBG, "Static_LB_ConsoleUI")
  self._ui_console.stc_KeyGuideRB = UI.getChildControl(self._ui.stc_TabAreaBG, "Static_RB_ConsoleUI")
  local enableTargetList = {}
  local enableCount = 0
  for idx = 0, self._maxTargetType - 1 do
    self._rdo_characterType[idx] = UI.getChildControl(self._ui.stc_TabAreaBG, "RadioButton_" .. tostring(idx))
    if 3 == idx then
      self._rdo_characterType[idx]:SetShow(self._enableCamel)
    elseif 4 == idx then
      self._rdo_characterType[idx]:SetShow(self._enableShip)
    elseif 6 == idx then
      self._rdo_characterType[idx]:SetShow(self._enableTent)
    end
    if self._rdo_characterType[idx]:GetShow() then
      enableCount = enableCount + 1
      enableTargetList[enableCount] = self._rdo_characterType[idx]
    end
  end
  self:targetIconReposition(self._ui.stc_TabAreaBG, enableTargetList)
  self._ui.stc_CurrentStepArea = UI.getChildControl(Panel_Widget_Dye_All, "Static_CurrnetStepGroup")
  self._ui.txt_CurrentStep = UI.getChildControl(self._ui.stc_CurrentStepArea, "StaticText_CurrentStep")
  self._ui.stc_EquipmentArea = UI.getChildControl(Panel_Widget_Dye_All, "Static_EquipmentGroup")
  self._ui.rdo_EquipSlot_Templete = UI.getChildControl(self._ui.stc_EquipmentArea, "RadioButton_SlotBg_Template")
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnchant = true
  }
  local maxColumn = 8
  local slotStartX = self._ui.rdo_EquipSlot_Templete:GetPosX()
  local slotStartY = self._ui.rdo_EquipSlot_Templete:GetPosY()
  local slotGap = self._ui.rdo_EquipSlot_Templete:GetSizeX() + 6
  for idx = 0, self._maxEquipSlotCount - 1 do
    local slot = {}
    local slotBG = UI.cloneControl(self._ui.rdo_EquipSlot_Templete, self._ui.stc_EquipmentArea, "RadioButton_SlotBg_" .. tostring(idx))
    SlotItem.new(slot, "Statoc_Icon_" .. tostring(idx), 0, slotBG, slotConfig)
    slot:createChild()
    slotBG:SetPosX(slotStartX + idx % maxColumn * slotGap)
    slotBG:SetPosY(slotStartY + math.floor(idx / maxColumn) * slotGap)
    slotBG:SetIgnore(not self._isConsole)
    slot.bg = slotBG
    slot.icon:SetVerticalMiddle()
    slot.icon:SetHorizonCenter()
    self._equipSlot[idx] = slot
  end
  local idx = self._maxEquipSlotCount
  self._ui.btn_Tring = UI.getChildControl(self._ui.stc_EquipmentArea, "Button_Shy_Tring")
  self._ui.btn_Tring:SetPosX(slotStartX + idx % maxColumn * slotGap)
  self._ui.btn_Tring:SetPosY(slotStartY + math.floor(idx / maxColumn) * slotGap)
  idx = idx + 1
  self._ui.btn_Tutu = UI.getChildControl(self._ui.stc_EquipmentArea, "Button_Shy_Tutu")
  self._ui.btn_Tutu:SetPosX(slotStartX + idx % maxColumn * slotGap)
  self._ui.btn_Tutu:SetPosY(slotStartY + math.floor(idx / maxColumn) * slotGap)
  idx = idx + 1
  self._ui.btn_Tokong = UI.getChildControl(self._ui.stc_EquipmentArea, "Button_Shy_Tokong")
  self._ui.btn_Tokong:SetPosX(slotStartX + idx % maxColumn * slotGap)
  self._ui.btn_Tokong:SetPosY(slotStartY + math.floor(idx / maxColumn) * slotGap)
  self._ui.stc_PartArea = UI.getChildControl(Panel_Widget_Dye_All, "Static_PartGroup")
  self._ui.chk_SelectAllPart = UI.getChildControl(self._ui.stc_PartArea, "CheckButton_All")
  self._ui.txt_SelectedAmple = UI.getChildControl(self._ui.stc_PartArea, "StaticText_SelectedAmple")
  for idx = 0, self._maxPartCount - 1 do
    self._rdo_PartSelect[idx] = UI.getChildControl(self._ui.stc_PartArea, "RadioButton_Part_" .. tostring(idx))
    self._btn_PartReset[idx] = UI.getChildControl(self._rdo_PartSelect[idx], "Button_Delete_PCUI")
  end
  local enableAreaSizeX = self._ui.chk_SelectAllPart:GetTextSpan().x + self._ui.chk_SelectAllPart:GetTextSizeX()
  self._ui.chk_SelectAllPart:SetEnableArea(0, 0, enableAreaSizeX, self._ui.chk_SelectAllPart:GetSizeY())
  self._ui.stc_AmpleArea = UI.getChildControl(Panel_Widget_Dye_All, "Static_AmpleGroup")
  self._ui.stc_AmpleTabArea = UI.getChildControl(self._ui.stc_AmpleArea, "Static_SubTabGroup")
  self._rdo_AmpleCategory = {
    [0] = UI.getChildControl(self._ui.stc_AmpleTabArea, "RadioButton_All"),
    [1] = UI.getChildControl(self._ui.stc_AmpleTabArea, "RadioButton_Mine"),
    [2] = UI.getChildControl(self._ui.stc_AmpleTabArea, "RadioButton_Merv")
  }
  self._ui.stc_SelectedCategoryLine = UI.getChildControl(self._ui.stc_AmpleTabArea, "Static_SelectedLine")
  self._ui_console.stc_KeyGuideLT = UI.getChildControl(self._ui.stc_AmpleTabArea, "Static_LT_ConsoleUI")
  self._ui_console.stc_KeyGuideRT = UI.getChildControl(self._ui.stc_AmpleTabArea, "Static_RT_ConsoleUI")
  self._ui.stc_MaterialArea = UI.getChildControl(self._ui.stc_AmpleArea, "Static_AmpleTabGroup")
  for idx = 0, self._maxMaterialCount - 1 do
    self._rdo_Material[idx] = UI.getChildControl(self._ui.stc_MaterialArea, "RadioButton_" .. tostring(idx))
  end
  self._ui.stc_AmpleSlotArea = UI.getChildControl(self._ui.stc_AmpleArea, "Static_SlotListGroup")
  self._ui.stc_AmpleSlotBG = UI.getChildControl(self._ui.stc_AmpleSlotArea, "Static_SlotListBG")
  self._ui.scroll_Ample = UI.getChildControl(self._ui.stc_AmpleSlotArea, "Scroll_Ampule")
  self._ui.scrollBtn = UI.getChildControl(self._ui.scroll_Ample, "Scroll_CtrlButton")
  self._ui.stc_AmpleTemplete = UI.getChildControl(self._ui.stc_AmpleSlotBG, "Static_AmpleSlot_Template")
  local startPosX = self._ui.stc_AmpleTemplete:GetPosX()
  local startPosY = self._ui.stc_AmpleTemplete:GetPosY()
  local gapX = self._ui.stc_AmpleTemplete:GetSizeX() + 2
  local gapY = self._ui.stc_AmpleTemplete:GetSizeY() + 2
  local ampleIdx = 0
  for row = 0, self._maxAmpuleRowsCount - 1 do
    for col = 0, self._maxAmpuleColsCount - 1 do
      local ampleSlot = {}
      local color = UI.createAndCopyBasePropertyControl(self._ui.stc_AmpleSlotBG, "Static_AmpleSlot_Template", self._ui.stc_AmpleSlotBG, "Static_AmpleSlot_" .. tostring(ampleIdx))
      local btn = UI.createAndCopyBasePropertyControl(self._ui.stc_AmpleSlotBG, "RadioButton_Slot_Template", self._ui.stc_AmpleSlotBG, "RadioButton_Slot_" .. tostring(ampleIdx))
      local count = UI.createAndCopyBasePropertyControl(self._ui.stc_AmpleSlotBG, "StaticText_Count_Template", self._ui.stc_AmpleSlotBG, "StaticText_Count_" .. tostring(ampleIdx))
      btn:addInputEvent("Mouse_UpScroll", "InputScroll_Dye_All_Ample_ScrollUpdate( true )")
      btn:addInputEvent("Mouse_DownScroll", "InputScroll_Dye_All_Ample_ScrollUpdate( false )")
      local slotPosX = startPosX + col * gapX
      local slotPosY = startPosY + row * gapY
      color:SetPosXY(slotPosX, slotPosY)
      btn:SetPosXY(slotPosX, slotPosY)
      count:SetPosXY(slotPosX, slotPosY + 25)
      ampleSlot.color = color
      ampleSlot.btn = btn
      ampleSlot.count = count
      if 0 == row then
        ampleSlot.btn:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "InputScroll_Dye_All_Ample_ScrollUpdate( true )")
      elseif self._maxAmpuleRowsCount - 1 == row then
        ampleSlot.btn:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "InputScroll_Dye_All_Ample_ScrollUpdate( false )")
      end
      self._ampleSlot[ampleIdx] = ampleSlot
      ampleIdx = ampleIdx + 1
    end
  end
  self._ui.stc_BottomArea = UI.getChildControl(Panel_Widget_Dye_All, "Static_BottomGroup")
  self._ui.txt_Endurance = UI.getChildControl(self._ui.stc_BottomArea, "StaticText_EnduranceTitle")
  self._ui.slider_Enduarance = UI.getChildControl(self._ui.stc_BottomArea, "Slider_Endurance")
  self._ui.sliderBtn = UI.getChildControl(self._ui.slider_Enduarance, "Slider_1_Button")
  for idx = 0, self._maxToggleCount - 1 do
    self._chk_ShowToggle[idx] = UI.getChildControl(self._ui.stc_BottomArea, "CheckButton_" .. tostring(idx))
    self._stc_ShowToggleIcon[idx] = UI.getChildControl(self._chk_ShowToggle[idx], "Static_Icon")
    self._toggleCheckValue[idx] = false
  end
  self._ui_pc.btn_Dye = UI.getChildControl(self._ui.stc_BottomArea, "Button_Dye_PCUI")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Widget_Dye_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Y_ConsoleUI")
  self._keyguides = {
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideA
  }
  self._classType = getSelfPlayer():getClassType()
  self._enableAwaken = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(self._classType)
  if __eClassType_ShyWaman == self._classType then
    self.dyePartString[0][29] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON")
    self.dyePartString[0][30] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH")
  end
  self._ui.scroll_Ample:SetInterval(10)
  self:registEventHandler()
  self:switchPlatform()
  self:alignKeyGuide()
  self:validate()
  self._ui_console.txt_KeyGuideX:SetShow(false)
  self._ui_console.txt_KeyGuideB:SetShow(false)
  self._initialize = true
end
function PaGlobal_Dye_All:registEventHandler()
  if nil == Panel_Widget_Dye_All then
    return
  end
  self._renderMode:setClosefunctor(renderMode, PaGlobal_Dye_All_CloseFunction)
  registerEvent("FromClient_updateDyeingTargetList", "FromClient_Dye_UpdateEquipList")
  registerEvent("FromClient_NotifyPearlCount", "FromClient_Dye_NotifyPearlCount")
  registerEvent("FromClient_updateDyeingPartList", "FromClient_Dye_UpdateDyeingPartList")
  if self._isConsole then
    self._ui.slider_Enduarance:addInputEvent("Mouse_LPress", "InputMLUp_Dye_SetEndurance()")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_Palette_All_Open()")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_Dye_DoDye()")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_LB, "InputLBRB_Dye_ChangeTarget(-1)")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_RB, "InputLBRB_Dye_ChangeTarget(1)")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_LT, "InputLTRT_Dye_ChangeAmpleType(-1)")
    Panel_Widget_Dye_All:registerPadEvent(__eConsoleUIPadEvent_RT, "InputLTRT_Dye_ChangeAmpleType(1)")
    for ii = 0, self._maxPartCount - 1 do
      self._rdo_PartSelect[ii]:addInputEvent("Mouse_On", "InputMOn_Dye_SetShowKeyGuideX(true)")
      self._rdo_PartSelect[ii]:addInputEvent("Mouse_Out", "InputMOn_Dye_SetShowKeyGuideX(false)")
    end
  end
  self._ui.scrollBtn:addInputEvent("Mouse_LPress", "InputClicked_Dye_All_PressAmpleScroll()")
  self._ui.scrollBtn:addInputEvent("Mouse_UpScroll", "InputClicked_Dye_All_PressAmpleScroll()")
  self._ui.scrollBtn:addInputEvent("Mouse_DownScroll", "InputClicked_Dye_All_PressAmpleScroll()")
  self._ui.scroll_Ample:addInputEvent("Mouse_UpScroll", "InputClicked_Dye_All_PressAmpleScroll()")
  self._ui.scroll_Ample:addInputEvent("Mouse_DownScroll", "InputClicked_Dye_All_PressAmpleScroll()")
  self._ui.scroll_Ample:addInputEvent("Mouse_LUp", "InputClicked_Dye_All_PressAmpleScroll()")
  for idx = 0, self._maxTargetType - 1 do
    self._rdo_characterType[idx]:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SelectCharacterType( " .. idx .. " )")
  end
  self._ui_pc.btn_Dye:addInputEvent("Mouse_LUp", "InputMLUp_Dye_DoDye()")
  self._ui.stc_AmpleSlotBG:SetIgnore(false)
  self._ui.stc_AmpleSlotBG:addInputEvent("Mouse_UpScroll", "InputScroll_Dye_All_Ample_ScrollUpdate( true )")
  self._ui.stc_AmpleSlotBG:addInputEvent("Mouse_DownScroll", "InputScroll_Dye_All_Ample_ScrollUpdate( false )")
  self._ui.slider_Enduarance:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetEndurance()")
  self._ui.sliderBtn:addInputEvent("Mouse_LPress", "InputMLUp_Dye_SetEndurance()")
  for idx = 0, self._maxToggleCount - 1 do
    self._chk_ShowToggle[idx]:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetToggle(" .. idx .. ")")
    self._chk_ShowToggle[idx]:addInputEvent("Mouse_On", "InputMOnOut_Dye_SimpleTooltipCheckbutton( true ," .. idx .. ")")
    self._chk_ShowToggle[idx]:addInputEvent("Mouse_Out", "InputMOnOut_Dye_SimpleTooltipCheckbutton( false ," .. idx .. ")")
  end
  self._rdo_AmpleCategory[0]:addInputEvent("Mouse_LUp", "InputMLUp_Ample_SelectType( 0 )")
  self._rdo_AmpleCategory[0]:addInputEvent("Mouse_On", "InputMOnOut_Dye_CategoryTooltip( true, " .. 8 .. ")")
  self._rdo_AmpleCategory[0]:addInputEvent("Mouse_Out", "InputMOnOut_Dye_CategoryTooltip( false, " .. 8 .. ")")
  self._rdo_AmpleCategory[1]:addInputEvent("Mouse_LUp", "InputMLUp_Ample_SelectType( 1 )")
  self._rdo_AmpleCategory[1]:addInputEvent("Mouse_On", "InputMOnOut_Dye_CategoryTooltip( true, " .. 9 .. ")")
  self._rdo_AmpleCategory[1]:addInputEvent("Mouse_Out", "InputMOnOut_Dye_CategoryTooltip( false, " .. 9 .. ")")
  self._rdo_AmpleCategory[2]:addInputEvent("Mouse_LUp", "InputMLUp_Ample_SelectType( 2 )")
  self._rdo_AmpleCategory[2]:addInputEvent("Mouse_On", "InputMOnOut_Dye_CategoryTooltip( true, " .. 10 .. ")")
  self._rdo_AmpleCategory[2]:addInputEvent("Mouse_Out", "InputMOnOut_Dye_CategoryTooltip( false, " .. 10 .. ")")
  for idx = 0, self._maxMaterialCount - 1 do
    self._rdo_Material[idx]:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SelectMaterial( " .. idx .. ")")
    self._rdo_Material[idx]:addInputEvent("Mouse_On", "InputMOnOut_Dye_CategoryTooltip( true, " .. idx .. ")")
    self._rdo_Material[idx]:addInputEvent("Mouse_Out", "InputMOnOut_Dye_CategoryTooltip( false, " .. idx .. ")")
  end
  self._ui.btn_Tring:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Lute .. ")")
  self._ui.btn_Tring:addInputEvent("Mouse_On", "InputMOnOut_Dye_ShyWeaponTooltip(" .. __eDyeingAwakenBattleActionIndex_Lute .. ")")
  self._ui.btn_Tring:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.btn_Tutu:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Flute .. ")")
  self._ui.btn_Tutu:addInputEvent("Mouse_On", "InputMOnOut_Dye_ShyWeaponTooltip(" .. __eDyeingAwakenBattleActionIndex_Flute .. ")")
  self._ui.btn_Tutu:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.btn_Tokong:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SetAwakeWeaponAction(" .. __eDyeingAwakenBattleActionIndex_Djembe .. ")")
  self._ui.btn_Tokong:addInputEvent("Mouse_On", "InputMOnOut_Dye_ShyWeaponTooltip(" .. __eDyeingAwakenBattleActionIndex_Djembe .. ")")
  self._ui.btn_Tokong:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
end
function PaGlobal_Dye_All:switchPlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_Dye_All:prepareOpen()
  if nil == Panel_Widget_Dye_All then
    return
  end
  PaGlobalFunc_FullScreenFade_FadeOut()
  ToClient_SaveUiInfo(false)
  if MessageBoxGetShow() then
    allClearMessageData()
  end
  SetUIMode(Defines.UIMode.eUIMode_DyeNew)
  self._renderMode:set()
  if Panel_IngameCashShop_EasyPayment:IsShow() then
    Panel_IngameCashShop_EasyPayment:SetShow(false, false)
  end
  if nil ~= Panel_Window_Palette_All and Panel_Window_Palette_All:GetShow() then
    PaGlobal_Palette_All_Close()
  end
  if nil ~= InGameShopBuy_Close then
    InGameShopBuy_Close()
  end
  if true == _ContentsGroup_NewUI_Manufacture_All then
    PaGlobalFunc_Manufacture_All_Close()
  else
    Manufacture_Close()
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Dye_CharacterController_Open()
  Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
  ToClient_DyeingManagerShow()
  self:openDataSetting()
  PaGlobal_Dye_All:open()
  if false == self._isConsole then
    InventoryWindow_Show()
  end
end
function PaGlobal_Dye_All:open()
  if nil == Panel_Widget_Dye_All then
    return
  end
  Panel_Widget_Dye_All:SetShow(true)
end
function PaGlobal_Dye_All:prepareClose()
  if nil == Panel_Widget_Dye_All then
    return
  end
  local isShow = ToClient_DyeingManagerHide()
  if false == isShow then
    return
  end
  PaGlobalFunc_FullScreenFade_FadeOut()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._renderMode:reset()
  if self._isConsole then
  else
    if PaGlobalFunc_InventoryInfo_GetShow() then
      if nil ~= Panel_Window_Inventory_All and false == Panel_Window_Inventory_All:IsUISubApp() then
        InventoryWindow_Close()
      end
      if _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(false)
      else
        FGlobal_Equipment_SetHide(false)
      end
    end
    if Panel_IngameCashShop_EasyPayment:GetShow() then
      if Panel_IngameCashShop_BuyOrGift:GetShow() then
        local couponOpen = Panel_IngameCashShop_Coupon:GetShow()
        InGameShopBuy_Close(couponOpen)
      end
      PaGlobal_EasyBuy_Close()
    end
    if true == _ContentsGroup_NewUI_ChangeItem_All then
      if Panel_Window_ChangeItem_All:GetShow() then
        PaGlobalFunc_ChangeItem_All_Close()
      end
    elseif Panel_ChangeWeapon:GetShow() then
      WeaponChange_Close()
    end
  end
  ToClient_DyeingManagerHide()
  PaGlobal_Dye_CharacterController_Close()
  audioPostEvent_SystemUi(1, 23)
  _AudioPostEvent_SystemUiForXBOX(1, 23)
  Panel_Tooltip_Item_hideTooltip()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  PaGlobal_Dye_All:close()
end
function PaGlobal_Dye_All:close()
  if nil == Panel_Widget_Dye_All then
    return
  end
  Panel_Widget_Dye_All:SetShow(false)
end
function PaGlobal_Dye_All:validate()
  if nil == Panel_Widget_Dye_All then
    return
  end
  self._ui.stc_TabAreaBG:isValidate()
  self._ui.stc_SelectedTabLine:isValidate()
  self._ui_console.stc_KeyGuideLB:isValidate()
  self._ui_console.stc_KeyGuideRB:isValidate()
  for idx = 0, self._maxTargetType - 1 do
    self._rdo_characterType[idx]:isValidate()
  end
  self._ui.stc_CurrentStepArea:isValidate()
  self._ui.txt_CurrentStep:isValidate()
  self._ui.stc_EquipmentArea:isValidate()
  self._ui.rdo_EquipSlot_Templete:isValidate()
  self._ui.stc_PartArea:isValidate()
  self._ui.chk_SelectAllPart:isValidate()
  self._ui.txt_SelectedAmple:isValidate()
  for idx = 0, self._maxPartCount - 1 do
    self._rdo_PartSelect[idx]:isValidate()
    self._btn_PartReset[idx]:isValidate()
  end
  self._ui.stc_AmpleArea:isValidate()
  self._ui.stc_AmpleTabArea:isValidate()
  self._ui_console.stc_KeyGuideLT:isValidate()
  self._ui_console.stc_KeyGuideRT:isValidate()
  self._ui.stc_MaterialArea:isValidate()
  for idx = 0, self._maxMaterialCount - 1 do
    self._rdo_Material[idx]:isValidate()
  end
  self._ui.stc_AmpleSlotArea:isValidate()
  self._ui.stc_AmpleSlotBG:isValidate()
  self._ui.scroll_Ample:isValidate()
  self._ui.scrollBtn:isValidate()
  self._ui.stc_AmpleTemplete:isValidate()
  self._ui.stc_BottomArea:isValidate()
  self._ui.slider_Enduarance:isValidate()
  for idx = 0, self._maxToggleCount - 1 do
    self._chk_ShowToggle[idx]:isValidate()
  end
  self._ui_pc.btn_Dye:isValidate()
  self._ui_console.stc_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideA:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
  self._ui_console.txt_KeyGuideX:isValidate()
  self._ui_console.txt_KeyGuideY:isValidate()
end
function PaGlobal_Dye_All:openDataSetting()
  self:setShowShyAwakenWeaponBtn(false)
  self._selected_CharacterTarget = -1
  self._selected_EquipSlotNo = -1
  InputMLUp_Dye_SelectMaterial(self._nowPaletteCategoryIndex)
  self:resetToggle()
  InputMLUp_Dye_SelectCharacterType(self._enumCharacterType.Character)
  self._ui.slider_Enduarance:SetControlPos(100)
  self:resetAmpleSlotList()
  self:updatePart()
  self._ui.txt_SelectedAmple:SetShow(false)
  for ii = 0, self._maxEquipSlotCount - 1 do
    self._equipSlot[ii].bg:SetColor(4286019447)
  end
  self:changeEquipIcon()
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  InputMLUp_Ample_SelectType(1, false, false)
  self._selectedDyePart = {}
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_DYEING")
end
function PaGlobal_Dye_All:resetToggle()
  for idx = 0, self._maxToggleCount - 1 do
    local isOn = idx == self._enumToggleType.Cloak or idx == self._enumToggleType.WarStance
    self._chk_ShowToggle[idx]:SetCheck(isOn)
    self._toggleCheckValue[idx] = isOn
  end
end
function PaGlobal_Dye_All:resetSelectedAmple()
  self._ui.txt_SelectedAmple:SetShow(false)
  self._ui.txt_SelectedAmple:SetText("")
end
function PaGlobal_Dye_All:resetAmpleSlotList()
  self._ui.stc_AmpleSlotBG:SetShow(false)
  for ii = 0, self._maxPaletteSlotCount - 1 do
    local slot = self._ampleSlot[ii]
    slot.btn:addInputEvent("Mouse_LUp", "")
    slot.btn:addInputEvent("Mouse_On", "")
    slot.btn:addInputEvent("Mouse_Out", "")
    slot.count:SetText("")
    slot.color:SetShow(false)
    slot.btn:SetShow(false)
    slot.count:SetShow(false)
  end
end
function PaGlobal_Dye_All:updateAmpleSlotList(currentSelectIndex)
  self:resetAmpleSlotList()
  TooltipSimple_Hide()
  local DyeingPaletteCategoryInfo = ToClient_requestGetPaletteCategoryInfo(self._nowPaletteCategoryIndex, self._paletteShowAll)
  if nil ~= DyeingPaletteCategoryInfo then
    local UISlotIndex = 0
    local arrCount = DyeingPaletteCategoryInfo:getListSize()
    local nowScroll = self._scrollStartIndex
    self._scrollMaxRow = math.ceil(arrCount / self._maxAmpuleColsCount)
    local dataIndex = self._scrollStartIndex * self._maxAmpuleColsCount
    for ii = 0, self._maxPaletteSlotCount - 1 do
      if arrCount > dataIndex then
        local colorValue = DyeingPaletteCategoryInfo:getColor(dataIndex)
        local itemEnchantKey = DyeingPaletteCategoryInfo:getItemEnchantKey(dataIndex)
        local isDyeUI = true
        local ampuleCount = DyeingPaletteCategoryInfo:getCount(dataIndex, isDyeUI)
        local ampleSlot = self._ampleSlot[UISlotIndex]
        local count = ampleSlot.count
        local btn = ampleSlot.btn
        local color = ampleSlot.color
        color:SetShow(true)
        btn:SetShow(true)
        count:SetShow(false == self._isPearlPalette)
        color:ChangeTextureInfoName("DyeSlot_n.dds")
        color:getBaseTexture():setUV(0, 0, 1, 1)
        color:setRenderTexture(color:getBaseTexture())
        color:SetAlphaIgnore(true)
        color:SetColor(colorValue)
        count:SetText(tostring(ampuleCount))
        if nil ~= currentSelectIndex then
          btn:SetCheck(currentSelectIndex == dataIndex)
        else
          btn:SetCheck(false)
        end
        btn:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SelectColor( " .. dataIndex .. " )")
        btn:addInputEvent("Mouse_On", "InputMOnOut_Dye_AmpleColorTooltip( true, " .. itemEnchantKey .. "," .. UISlotIndex .. ")")
        btn:addInputEvent("Mouse_Out", "InputMOnOut_Dye_AmpleColorTooltip( false, " .. itemEnchantKey .. "," .. UISlotIndex .. ")")
        UISlotIndex = UISlotIndex + 1
      end
      dataIndex = dataIndex + 1
    end
    self._ui.stc_AmpleSlotBG:SetShow(0 < UISlotIndex)
  end
  UIScroll.SetButtonSize(self._ui.scroll_Ample, self._maxPaletteSlotCount / self._maxAmpuleColsCount, self._scrollMaxRow)
end
function PaGlobal_Dye_All:resetPart(isClearCheck)
  for ii = 0, self._maxPartCount - 1 do
    self._rdo_PartSelect[ii]:SetShow(false)
    self._btn_PartReset[ii]:SetShow(false)
    if isClearCheck then
      self._rdo_PartSelect[ii]:SetCheck(false)
    end
  end
end
function PaGlobal_Dye_All:updatePart()
  self:resetPart()
  local equipSlotNo = self._selected_EquipSlotNo
  if -1 == equipSlotNo then
    return
  end
  ToClient_SetDyeingTargetInformationByEquipNo(equipSlotNo)
  local infoCount = ToClient_getDyeingTargetInformationCount()
  self._partDyeInfo = {}
  for infoIdx = 0, infoCount - 1 do
    local partIdx = ToClient_getDyeingTargetPartIdxByIndex(infoIdx)
    local slotIdx = ToClient_getDyeingTartSlotIndexByIndex(infoIdx)
    local DyeSlotIdx = ToClient_getDyeingTargetDyeSlotIndexByIndex(infoIdx)
    local PartSlot = self._rdo_PartSelect[DyeSlotIdx]
    local PartReset = self._btn_PartReset[DyeSlotIdx]
    PartSlot:SetText(DyeSlotIdx)
    local getColorInfo = ToClient_RequestGetUsedPartColor(equipSlotNo, partIdx, slotIdx)
    PartSlot:addInputEvent("Mouse_LUp", "InputMLUp_Dye_SelectEquipPart( " .. partIdx .. ", " .. slotIdx .. ", " .. DyeSlotIdx .. " )")
    local isReset = ToClient_RequestIsResetDyeingPartSlot(equipSlotNo, partIdx, slotIdx)
    if isReset then
      if self._isConsole then
        PartSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMLUp_Dye_EquipPartReset( " .. equipSlotNo .. ", " .. partIdx .. ", " .. slotIdx .. ", " .. DyeSlotIdx .. " )")
      else
        PartReset:SetShow(true)
        PartReset:addInputEvent("Mouse_LUp", "InputMLUp_Dye_EquipPartReset( " .. equipSlotNo .. ", " .. partIdx .. ", " .. slotIdx .. ", " .. DyeSlotIdx .. " )")
      end
    else
      PartReset:SetShow(false)
    end
    PartSlot:SetAlphaIgnore(true)
    PartSlot:SetColor(getColorInfo)
    PartSlot:SetShow(true)
    self._partDyeInfo[infoIdx] = {
      partIdx,
      slotIdx,
      DyeSlotIdx
    }
  end
end
function PaGlobal_Dye_All:resetEquipIcon()
  for ii = 0, self._maxEquipSlotCount - 1 do
    if nil ~= self._equipSlot[ii] then
      self._equipSlot[ii]:clearItem()
      self._equipSlot[ii].icon:ReleaseTexture()
      self._equipSlot[ii].icon:ChangeTextureInfoNameAsync("")
      self._equipSlot[ii].icon:SetAlpha(1)
      self._equipSlot[ii].bg:setRenderTexture(self._equipSlot[ii].bg:getBaseTexture())
    end
  end
end
function PaGlobal_Dye_All:changeEquipIcon()
  self:resetEquipIcon()
  local textureInfoName = ""
  local classType = self._classType
  local characterType = self._selected_CharacterTarget
  local targetSlot
  if self._enumCharacterType.Character == characterType or self._enumCharacterType.Tent == characterType then
    textureInfoName = "New_UI_Common_forLua/Window/Dye/Dye_New_00.dds"
  elseif self._enumCharacterType.Horse == characterType or self._enumCharacterType.Camel == characterType then
    textureInfoName = "New_UI_Common_forLua/Window/Dye/Dye_New_01.dds"
  elseif self._enumCharacterType.Car == characterType then
    textureInfoName = "combine/icon/combine_equip_icon_00.dds"
  elseif self._enumCharacterType.Ship == characterType then
    textureInfoName = "New_UI_Common_forLua/Window/Dye/Dye_New_02.dds"
  end
  targetSlot = self._equipSlotIcon[characterType]
  for idx, equipSlotIdx in pairs(targetSlot) do
    local UIEquipIcon = self._equipSlot[idx - 1].icon
    if nil ~= UIEquipIcon then
      UIEquipIcon:ChangeTextureInfoName(textureInfoName)
      local x1, y1, x2, y2 = setTextureUV_Func(UIEquipIcon, equipSlotIdx[2], equipSlotIdx[3], equipSlotIdx[4], equipSlotIdx[5])
      if self._enumCharacterType.Character == characterType and classType == __eClassType_ShyWaman then
        if 3 == idx then
          x1, y1, x2, y2 = setTextureUV_Func(UIEquipIcon, 422, 35, 450, 63)
        end
        if 10 == idx then
          x1, y1, x2, y2 = setTextureUV_Func(UIEquipIcon, 422, 6, 450, 34)
        end
      end
      UIEquipIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      UIEquipIcon:setRenderTexture(UIEquipIcon:getBaseTexture())
    end
  end
  FromClient_Dye_UpdateEquipList()
end
function PaGlobal_Dye_All:selectAmpleCategory(index)
  for i = 0, 2 do
    self._rdo_AmpleCategory[i]:SetCheck(i == index)
  end
  local selectedCategory = self._rdo_AmpleCategory[index]
  local posX = selectedCategory:GetPosX() + selectedCategory:GetSizeX() / 2 - self._ui.stc_SelectedCategoryLine:GetSizeX() / 2
  self._ui.stc_SelectedCategoryLine:SetPosX(posX)
end
function PaGlobal_Dye_All:targetIconReposition(parent, enableTargetList)
  local parentSizeX = parent:GetSizeX()
  local gapSizeX = 25
  local totalSizeX = 0
  for _, control in pairs(enableTargetList) do
    totalSizeX = totalSizeX + control:GetSizeX()
  end
  totalSizeX = totalSizeX + gapSizeX * (#enableTargetList - 1)
  local startPosX = (parentSizeX - totalSizeX) / 2
  for _, control in pairs(enableTargetList) do
    control:SetPosX(startPosX)
    startPosX = startPosX + control:GetSizeX() + gapSizeX
  end
end
function PaGlobal_Dye_All:updateTargetIcon()
  for idx = 0, self._maxTargetType - 1 do
    self._rdo_characterType[idx]:SetCheck(idx == self._selected_CharacterTarget)
  end
  local currentTargetIcon = self._rdo_characterType[self._selected_CharacterTarget]
  if nil ~= currentTargetIcon then
    local posX = currentTargetIcon:GetPosX() + currentTargetIcon:GetSizeX() / 2 - self._ui.stc_SelectedTabLine:GetSizeX() / 2
    self._ui.stc_SelectedTabLine:SetPosX(posX)
  end
  if self._dyeTargetString[self._selected_CharacterTarget] then
    self._ui.txt_CurrentStep:SetText(self._dyeTargetString[self._selected_CharacterTarget])
  else
    self._ui.txt_CurrentStep:SetText("")
  end
end
function PaGlobal_Dye_All:setShowShyAwakenWeaponBtn(isShow)
  self._ui.btn_Tring:SetShow(isShow)
  self._ui.btn_Tutu:SetShow(isShow)
  self._ui.btn_Tokong:SetShow(isShow)
end
function PaGlobal_Dye_All:alignKeyGuide()
  if false == self._isConsole then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_Dye_All:setShowEnduaranceSlider()
  local isShow = self._enumCharacterType.Character == self._selected_CharacterTarget
  self._ui.txt_Endurance:SetShow(isShow)
  self._ui.slider_Enduarance:SetShow(isShow)
end
