function PaGlobal_ServantMarket_All:initialize()
  if nil == Panel_Dialog_ServantMarket_All or true == self._initailize then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_TitleBg")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close")
  self._ui._btn_Question_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Question")
  self._ui._stc_TabGroup = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_TabGroup")
  self._ui._rdo_Tab_MarketList = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_MarketList")
  self._ui._rdo_Tab_MyRegistList = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_MyRegistList")
  self._ui._stc_SelectedLine = UI.getChildControl(self._ui._stc_TabGroup, "Static_SelectedLine")
  self._ui._stc_KeyGuide_LT = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_LT_ConsoleUI")
  self._ui._stc_KeyGuide_RT = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_RT_ConsoleUI")
  self._ui._stc_PageBg = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_PageBg")
  self._ui._txt_PageValue = UI.getChildControl(self._ui._stc_PageBg, "StaticText_PageValue")
  self._ui._btn_PageLeft_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Left_PCUI")
  self._ui._btn_PageRight_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Right_PCUI")
  self._ui._stc_PageLeft_Console = UI.getChildControl(self._ui._stc_PageBg, "Button_Left_ConsoleUI")
  self._ui._stc_PageRight_Console = UI.getChildControl(self._ui._stc_PageBg, "Button_Right_ConsoleUI")
  self._ui._btn_Reload_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Reload")
  self._ui._stc_DiscountRate = UI.getChildControl(self._ui._stc_PageBg, "StaticText_DiscountRateIcon")
  self._ui._stc_SortBg_PC_UI = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_SortBg_PCUI")
  self._ui._stc_ComboBox_TierTitle = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_TierFilterTitle")
  self._ui._stc_ComboBox_GenderTitle = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_SkillFilterTitle")
  self._ui._stc_ComboBox_SkillTitle = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_SexFilterTitle")
  self._ui._stc_ComboBox_Tier = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "Combobox_Tier")
  self._ui._stc_ComboBox_TierList = UI.getChildControl(self._ui._stc_ComboBox_Tier, "Combobox_1_List")
  self._ui._scroll_ComboBox_Tier = UI.getChildControl(self._ui._stc_ComboBox_TierList, "Combobox_1_List_Scroll")
  self._ui._scrollUp_ComboBox_Tier = UI.getChildControl(self._ui._scroll_ComboBox_Tier, "Combobox_1_List_Scroll_UpButton")
  self._ui._scrollDown_ComboBox_Tier = UI.getChildControl(self._ui._scroll_ComboBox_Tier, "Combobox_1_List_Scroll_DownButton")
  self._ui._scrollCtrl_ComboBox_Tier = UI.getChildControl(self._ui._scroll_ComboBox_Tier, "Combobox_1_List_Scroll_CtrlButton")
  self._ui._stc_ComboBox_Tier_BackStatic = UI.getChildControl(self._ui._stc_ComboBox_TierList, "Combobox_1_List_BackStatic")
  self._ui._stc_ComboBox_Skill = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "Combobox_Skill")
  self._ui._stc_ComboBox_SkillList = UI.getChildControl(self._ui._stc_ComboBox_Skill, "Combobox_1_List")
  self._ui._scroll_ComboBox_Skill = UI.getChildControl(self._ui._stc_ComboBox_SkillList, "Combobox_1_List_Scroll")
  self._ui._scrollUp_ComboBox_SKill = UI.getChildControl(self._ui._scroll_ComboBox_Skill, "Combobox_1_List_Scroll_UpButton")
  self._ui._scrollDown_ComboBox_SKill = UI.getChildControl(self._ui._scroll_ComboBox_Skill, "Combobox_1_List_Scroll_DownButton")
  self._ui._scrollCtrl_ComboBox_SKill = UI.getChildControl(self._ui._scroll_ComboBox_Skill, "Combobox_1_List_Scroll_CtrlButton")
  self._ui._stc_ComboBox_Skill_BackStatic = UI.getChildControl(self._ui._stc_ComboBox_SkillList, "Combobox_1_List_BackStatic")
  self._ui._stc_ComboBox_Gender = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "Combobox_Gender")
  self._ui._stc_ComboBox_GenderList = UI.getChildControl(self._ui._stc_ComboBox_Gender, "Combobox_1_List")
  self._ui._scroll_ComboBox_Gender = UI.getChildControl(self._ui._stc_ComboBox_GenderList, "Combobox_1_List_Scroll")
  self._ui._scrollUp_ComboBox_Gender = UI.getChildControl(self._ui._scroll_ComboBox_Gender, "Combobox_1_List_Scroll_UpButton")
  self._ui._scrollDown_ComboBox_Gender = UI.getChildControl(self._ui._scroll_ComboBox_Gender, "Combobox_1_List_Scroll_DownButton")
  self._ui._scrollCtrl_ComboBox_Gender = UI.getChildControl(self._ui._scroll_ComboBox_Gender, "Combobox_1_List_Scroll_CtrlButton")
  self._ui._stc_ComboBox_Gender_BackStatic = UI.getChildControl(self._ui._stc_ComboBox_GenderList, "Combobox_1_List_BackStatic")
  self._ui._stc_SortBg_ConsoleUI = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_SortBg_ConsoleUI")
  self._ui._txt_FilterTitle = UI.getChildControl(self._ui._stc_SortBg_ConsoleUI, "StaticText_FilterTitle")
  self._ui._txt_FilterValue = UI.getChildControl(self._ui._stc_SortBg_ConsoleUI, "StaticText_FilterValue")
  self._ui._txt_InvenTitle = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_HasBagMoneyTitle")
  self._ui._txt_Inven = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_HasBagMoneyValue")
  self._ui._txt_WareTitle = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_HasWarehouseMoneyTitle")
  self._ui._txt_Ware = UI.getChildControl(self._ui._stc_SortBg_PC_UI, "StaticText_HasWarehouseMoneyValue")
  self._ui._stc_SkillTooltip = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_SkillTooltip")
  self._ui._btn_SkillTooltip_Close_PC = UI.getChildControl(self._ui._stc_SkillTooltip, "Button_Close")
  self._ui._stc_SkillTooltip_KeyGuide_B = UI.getChildControl(self._ui._stc_SkillTooltip, "StaticText_B_ConsoleUI")
  self._ui._stc_Bottom_KeyGuides = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_RS = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_RS_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_Y_ConsoleUI")
  self._ui._stc_KeyGuide_Y_Tooltip = UI.getChildControl(self._ui._stc_KeyGuide_Y, "StaticText_YButtonToolTip")
  self._isConsole = _ContentsGroup_UsePadSnapping
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tempServantSlot = {
      _slot = nil,
      _horseIdx = 0,
      _btn_Console_UI = nil,
      _stc_ImageBg = nil,
      _stc_HorseImage = nil,
      _stc_GenderIcon = nil,
      _stc_SwiftIcon = nil,
      _txt_Tier = nil,
      _txt_Level = nil,
      _txt_HpTitle = nil,
      _txt_HpValue = nil,
      _txt_StaminaTitle = nil,
      _txt_StaminaValue = nil,
      _txt_WeightTitle = nil,
      _txt_WeightValue = nil,
      _txt_SpeedTitle = nil,
      _txt_SpeedValue = nil,
      _txt_AccelTitle = nil,
      _txt_AccelValue = nil,
      _txt_CorneringTitle = nil,
      _txt_CorneringValue = nil,
      _txt_BreakTitle = nil,
      _txt_BreakValue = nil,
      _txt_DeadCountTitle = nil,
      _txt_DeadCountValue = nil,
      _txt_LeftMatingTitle = nil,
      _txt_LeftMatingValue = nil,
      _btn_SkillTooltip = nil,
      _btn_BUY_PC = nil,
      _btn_Cancel_PC = nil,
      _btn_beforeLook = nil,
      _isLookChange = false,
      _txt_learnedSkillCount = nil,
      _list2_Control = nil,
      _tooltipControls = {}
    }
    tempServantSlot._slot = UI.getChildControl(Panel_Dialog_ServantMarket_All, "Static_Slot_" .. tostring(slotIdx + 1))
    tempServantSlot._btn_Console_UI = UI.getChildControl(tempServantSlot._slot, "Button_BG_ConsoleUI")
    tempServantSlot._stc_ImageBg = UI.getChildControl(tempServantSlot._slot, "Static_ImageBg")
    tempServantSlot._stc_HorseImage = UI.getChildControl(tempServantSlot._slot, "Static_HorseImage")
    tempServantSlot._stc_GenderIcon = UI.getChildControl(tempServantSlot._slot, "Static_GenderIcon")
    tempServantSlot._stc_SwiftIcon = UI.getChildControl(tempServantSlot._slot, "Static_SwiftIcon")
    tempServantSlot._txt_Tier = UI.getChildControl(tempServantSlot._slot, "StaticText_Tier")
    tempServantSlot._txt_Level = UI.getChildControl(tempServantSlot._slot, "StaticText_Level")
    tempServantSlot._txt_HpTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_HpTitle")
    tempServantSlot._txt_HpValue = UI.getChildControl(tempServantSlot._slot, "StaticText_HpValue")
    tempServantSlot._txt_StaminaTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_StaminaTitle")
    tempServantSlot._txt_StaminaValue = UI.getChildControl(tempServantSlot._slot, "StaticText_StaminaValue")
    tempServantSlot._txt_WeightTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_WeightTitle")
    tempServantSlot._txt_WeightValue = UI.getChildControl(tempServantSlot._slot, "StaticText_WeightValue")
    tempServantSlot._txt_SpeedTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_SpeedTitle")
    tempServantSlot._txt_SpeedValue = UI.getChildControl(tempServantSlot._slot, "StaticText_SpeedValue")
    tempServantSlot._txt_AccelTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_AccelerationTitle")
    tempServantSlot._txt_AccelValue = UI.getChildControl(tempServantSlot._slot, "StaticText_AccelerationValue")
    tempServantSlot._txt_CorneringTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_CorneringSpeedTitle")
    tempServantSlot._txt_CorneringValue = UI.getChildControl(tempServantSlot._slot, "StaticText_CorneringSpeedValue")
    tempServantSlot._txt_BreakTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_BreakTitle")
    tempServantSlot._txt_BreakValue = UI.getChildControl(tempServantSlot._slot, "StaticText_BreakValue")
    tempServantSlot._txt_DeadCountTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_DeadCountTitle")
    tempServantSlot._txt_DeadCountValue = UI.getChildControl(tempServantSlot._slot, "StaticText_DeadCountValue")
    tempServantSlot._txt_LeftMatingTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_LeftMatingCountTitle")
    tempServantSlot._txt_LeftMatingValue = UI.getChildControl(tempServantSlot._slot, "StaticText_LeftMatingCountValue")
    tempServantSlot._txt_SkillCountTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_SkillCountTitle")
    tempServantSlot._btn_SkillTooltip = UI.getChildControl(tempServantSlot._slot, "Button_SkillTooltip_PCUI")
    tempServantSlot._btn_BUY_PC = UI.getChildControl(tempServantSlot._slot, "Button_Buy_PCUI")
    tempServantSlot._btn_Cancel_PC = UI.getChildControl(tempServantSlot._slot, "Button_Cancel_PCUI")
    tempServantSlot._btn_beforeLook = UI.getChildControl(tempServantSlot._slot, "Button_BeforeLook")
    tempServantSlot._list2_Control = UI.getChildControl(tempServantSlot._slot, "List2_ServantSkill")
    tempServantSlot._txt_learnedSkillCount = UI.getChildControl(tempServantSlot._slot, "StaticText_SkillCountValue")
    tempServantSlot._slot:SetShow(false)
    local tooltipCheckControl = {
      tempServantSlot._txt_SpeedTitle,
      tempServantSlot._txt_AccelTitle,
      tempServantSlot._txt_CorneringTitle,
      tempServantSlot._txt_BreakTitle,
      tempServantSlot._txt_DeadCountTitle,
      tempServantSlot._txt_LeftMatingTitle,
      tempServantSlot._txt_SkillCountTitle,
      tempServantSlot._txt_DeadCountValue,
      tempServantSlot._txt_LeftMatingValue
    }
    tempServantSlot._tooltipControls = tooltipCheckControl
    self._ui._servantSlot[slotIdx] = tempServantSlot
  end
  PaGlobal_ServantMarket_All:validate()
  PaGlobal_ServantMarket_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantMarket_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantMarket_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantMarket_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantMarket_All_OnScreenResize")
  registerEvent("FromClient_AuctionServantList", "FromClient_ServantMarket_All_UpdateSlot")
  registerEvent("FromClient_ServantRegisterToAuction", "HandleEventLUp_ServantMarket_All_Reload")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ServantMarket_All_UpdateMoney")
  registerEvent("EventWarehouseUpdate", "FromClient_ServantMarket_All_UpdateMoney")
  registerEvent("FromClient_ResponseServantBuyItNowFail", "FromClient_ServantMarket_All_ResponseServantBuyItNowFail")
  Panel_Dialog_ServantMarket_All:RegisterShowEventFunc(true, "PaGlobalFunc_ServantMarket_All_ShowAni()")
  Panel_Dialog_ServantMarket_All:RegisterShowEventFunc(false, "PaGlobalFunc_ServantMarket_All_HideAni()")
  for slotIdx = 0, 3 do
    local list2 = self._ui._servantSlot[slotIdx]._list2_Control
    list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantMarket_All_List2UpdateSlot" .. tostring(slotIdx))
    list2:createChildContent(__ePAUIList2ElementManagerType_List)
  end
  self._ui._stc_ComboBox_Tier:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_OpenComboBox( 1 )")
  self._ui._stc_ComboBox_Skill:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_OpenComboBox( 2 )")
  self._ui._stc_ComboBox_Gender:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_OpenComboBox( 3 )")
  self._ui._stc_ComboBox_Tier:GetListControl():AddSelectEvent("HandleEventLUp_ServantMarket_All_SelectComboBox(1)")
  self._ui._stc_ComboBox_Skill:GetListControl():AddSelectEvent("HandleEventLUp_ServantMarket_All_SelectComboBox(2)")
  self._ui._stc_ComboBox_Gender:GetListControl():AddSelectEvent("HandleEventLUp_ServantMarket_All_SelectComboBox(3)")
  self._ui._stc_ComboBox_Tier:setListTextHorizonCenter()
  self._ui._stc_ComboBox_Skill:setListTextHorizonCenter()
  self._ui._stc_ComboBox_Gender:setListTextHorizonCenter()
  if false == isConsole then
    Panel_Dialog_ServantMarket_All:SetDragEnable(true)
    Panel_Dialog_ServantMarket_All:SetDragAll(true)
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_Question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableMarket\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question_PC, "\"PanelWindowStableMarket\"")
    self._ui._rdo_Tab_MarketList:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_TabChange( false )")
    self._ui._rdo_Tab_MyRegistList:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_TabChange( true )")
    self._ui._btn_Reload_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Reload()")
    self._ui._btn_SkillTooltip_Close_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_CloseSkillList()")
    self._ui._btn_PageLeft_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_PageChange(false)")
    self._ui._btn_PageRight_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_PageChange(true)")
    self._ui._txt_WareTitle:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_All_ShowSimpleTooltip( 1, true )")
    self._ui._txt_WareTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_All_ShowSimpleTooltip( false )")
    self._ui._txt_InvenTitle:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_All_ShowSimpleTooltip( 0, true )")
    self._ui._txt_InvenTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_All_ShowSimpleTooltip( false )")
    self._ui._stc_DiscountRate:SetEnableArea(0, 0, self._ui._stc_DiscountRate:GetSizeX() + self._ui._stc_DiscountRate:GetTextSizeX(), self._ui._stc_DiscountRate:GetSizeY())
    self._ui._stc_DiscountRate:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_All_ShowDiscountRateTooltip( 0, true )")
    self._ui._stc_DiscountRate:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_All_ShowDiscountRateTooltip( false)")
  else
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_ServantMarket_All_TabChange_Console()")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_ServantMarket_All_TabChange_Console()")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadLeft, "HandleEventLUp_ServantMarket_All_PageChange(false)")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadRight, "HandleEventLUp_ServantMarket_All_PageChange(true)")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPadDown_ServantMarket_All_YPressTooltipShow()")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_ServantMarket_All_Reload()")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadDown_ServantMarket_All_YPressTooltipHide()")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_ServantMarket_All_ServantSkill(true)")
    Panel_Dialog_ServantMarket_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_ServantMarket_All_ServantSkill(false)")
  end
end
function PaGlobal_ServantMarket_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantMarket_All or false == self._initailize then
    return
  end
  self._ui._stc_SortBg_ConsoleUI:SetShow(false)
  self._ui._stc_KeyGuide_LT:SetShow(isConsole)
  self._ui._stc_KeyGuide_RT:SetShow(isConsole)
  self._ui._stc_PageLeft_Console:SetShow(isConsole)
  self._ui._stc_PageRight_Console:SetShow(isConsole)
  self._ui._stc_SkillTooltip_KeyGuide_B:SetShow(isConsole)
  self._ui._stc_Bottom_KeyGuides:SetShow(isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._btn_Question_PC:SetShow(not isConsole)
  self._ui._btn_Reload_PC:SetShow(not isConsole)
  self._ui._stc_KeyGuide_Y:SetShow(isConsole)
  self._ui._btn_PageLeft_PC:SetShow(not isConsole)
  self._ui._btn_PageRight_PC:SetShow(not isConsole)
  self._ui._stc_DiscountRate:SetShow(not isConsole)
  if true == isConsole then
    self._SKILLCOUNT = vehicleSkillStaticStatus_skillCount()
    local key = {
      self._ui._stc_KeyGuide_RS,
      self._ui._stc_KeyGuide_X,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    self._keyguides = key
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(key, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantMarket_All:prepareOpen()
  if nil == Panel_Dialog_ServantMarket_All or true == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  local sceneIdx = PaGlobalFunc_ServantList_All_GetSceneIndex()
  if nil ~= sceneIdx then
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(PaGlobal_ServantList_All._selectSceneIndex)
  end
  self._isFromNpc = not ToClient_WorldMapIsShow()
  PaGlobal_ServantMarket_All:createFilter()
  if false == self._isFromNpc then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Dialog_ServantMarket_All, true)
    self._ui._txt_Ware:SetShow(false)
    self._ui._txt_InvenTitle:SetShow(false)
    self._ui._txt_Inven:SetPosY(self._ui._txt_Ware:GetPosY())
    self._ui._txt_WareTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SHOP_TXT_MYMONEY"))
    self._ui._txt_WareTitle:SetShow(true)
  else
    self._ui._txt_Ware:SetShow(true)
    self._ui._txt_Inven:SetPosY(self._ui._txt_InvenTitle:GetPosY() + 20)
    self._ui._txt_WareTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY2"))
    self._ui._txt_InvenTitle:SetShow(true)
  end
  warehouse_requestInfoFromNpc()
  self._ui._stc_SkillTooltip:SetShow(false)
  PaGlobal_ServantMarket_All:open()
  FromClient_ServantTransferList_All_OnScreenResize()
  PaGlobal_ServantMarket_All:dataClear()
  HandleEventLUp_ServantMarket_All_TabChange(false)
  Panel_Dialog_ServantMarket_All:RegisterUpdateFunc("PaGlobalFunc_ServantMarket_All_ChangePageByARROWKEY")
end
function PaGlobal_ServantMarket_All:createFilter()
  self._ui._stc_ComboBox_Tier:SetText(self._string_ServantTier[0])
  self._ui._stc_ComboBox_Skill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_FILTER_ALL"))
  self._ui._stc_ComboBox_Gender:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_SEXFILTER_2"))
  local uiCount = 1
  self._ui._stc_ComboBox_Tier:DeleteAllItem()
  local tierlimit = 8
  if true == ToClient_IsContentsGroupOpen("29") then
    tierlimit = 9
  end
  if true == ToClient_IsContentsGroupOpen("469") then
    tierlimit = 10
  end
  for ii = 0, self._TIERCOUNT do
    if true == self._isConsole then
      if ii < tierlimit then
        self._ui._stc_ComboBox_Tier:AddItem(self._string_ServantTier[ii])
        uiCount = uiCount + 1
      end
    else
      self._ui._stc_ComboBox_Tier:AddItem(self._string_ServantTier[ii])
      uiCount = uiCount + 1
    end
  end
  self._ui._stc_ComboBox_Skill:DeleteAllItem()
  self._ui._stc_ComboBox_Skill:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_FILTER_ALL"))
  local skillCount = 0
  for ii = 1, self._SKILLCOUNT do
    local skillWrapper = getVehicleSkillStaticStatus(ii)
    if nil ~= skillWrapper and true == skillWrapper:isMarketFilter() then
      if true == self._isConsole then
        if 64 ~= skillWrapper:getKey() then
          self._skillFilterSelectIndex[skillCount] = ii
          skillCount = skillCount + 1
          self._ui._stc_ComboBox_Skill:AddItem(skillWrapper:getName())
        end
      else
        self._skillFilterSelectIndex[skillCount] = ii
        skillCount = skillCount + 1
        self._ui._stc_ComboBox_Skill:AddItem(skillWrapper:getName())
      end
    end
  end
  comboBoxSizeX = self._ui._stc_ComboBox_Skill:GetSizeX()
  listControlSizeY = self._ui._stc_ComboBox_Skill:GetSizeY()
  self._ui._stc_ComboBox_Gender:DeleteAllItem()
  for index = 1, 3 do
    self._ui._stc_ComboBox_Gender:AddItem(self._sexFilterString[index - 1])
  end
end
function PaGlobal_ServantMarket_All:open()
  if nil == Panel_Dialog_ServantMarket_All or true == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  Panel_Dialog_ServantMarket_All:SetShow(true)
end
function PaGlobal_ServantMarket_All:update()
  if nil == Panel_Dialog_ServantMarket_All then
    return
  end
  PaGlobal_ServantMarket_All:moneyUpdate()
  if nil ~= self._ui._servantSlot then
    for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
      self._ui._servantSlot[slotIdx]._slot:SetShow(false)
      self._ui._servantSlot[slotIdx]._btn_Cancel_PC:SetShow(false)
    end
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  self._auctionInfo = myAuctionInfo
  local startSlotNo = 0
  local endSlotNo = 0
  if true == self._isTabMyRegister then
    startSlotNo = self._selectPage * self._MAXSLOTCOUNT
    endSlotNo = startSlotNo + self._MAXSLOTCOUNT - 1
    local maxCount = myAuctionInfo:getServantAuctionListCount()
    local prevMaxPage = self._selectMaxPage
    self._selectMaxPage = math.floor(maxCount / self._MAXSLOTCOUNT) - 1
    if 0 < maxCount % self._MAXSLOTCOUNT then
      self._selectMaxPage = self._selectMaxPage + 1
    end
    if -1 == self._selectMaxPage then
      self._selectMaxPage = 0
    end
    self._ui._txt_PageValue:SetText(self._selectPage + 1 .. " / " .. self._selectMaxPage + 1)
    if prevMaxPage > self._selectMaxPage then
      HandleEventLUp_ServantMarket_All_PageChange(false)
    end
  else
    startSlotNo = 0
    endSlotNo = myAuctionInfo:getServantAuctionListCount() - 1
    if 3 <= endSlotNo then
      self._selectMaxPage = self._selectPage + 1
    else
      self._selectMaxPage = self._selectPage
    end
    self._ui._txt_PageValue:SetText(myAuctionInfo:getCurrentPage() + 1)
  end
  local slotNo = 0
  for ii = startSlotNo, endSlotNo do
    local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(ii)
    local slot = self._ui._servantSlot[slotNo]
    if nil ~= auctionServantInfo and slotNo < self._MAXSLOTCOUNT then
      slot._horseIdx = ii
      slot._list2_Control:getElementManager():clearKey()
      local servantType = auctionServantInfo:getVehicleType()
      local everyVehicleSkillCount = vehicleSkillStaticStatus_skillCount()
      local learnedSkillCount = 0
      local UnlearnedSkillCount = 0
      for skillIdx = 1, everyVehicleSkillCount - 1 do
        local learnSkillWrapper = auctionServantInfo:getSkill(skillIdx)
        local unLearnSKillWrapper = auctionServantInfo:getSkillXXX(skillIdx)
        if nil ~= learnSkillWrapper then
          learnedSkillCount = learnedSkillCount + 1
          slot._list2_Control:getElementManager():pushKey(toInt64(0, skillIdx))
        end
        if nil ~= unLearnSKillWrapper then
          UnlearnedSkillCount = UnlearnedSkillCount + 1
        end
      end
      slot._txt_learnedSkillCount:SetText(tostring(learnedSkillCount) .. " / " .. tostring(learnedSkillCount + UnlearnedSkillCount))
      slot._slot:SetShow(true)
      slot._stc_HorseImage:ChangeTextureInfoName(auctionServantInfo:getIconPath1())
      local isNineTier = 9 ~= auctionServantInfo:getTier()
      slot._btn_beforeLook:SetShow(false)
      if false == PaGlobal_ServantMarket_All._isConsole and auctionServantInfo:getBaseIconPath1() ~= auctionServantInfo:getIconPath1() then
        slot._btn_beforeLook:SetShow(true)
        slot._btn_beforeLook:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_ShowBeforeLook(" .. ii .. "," .. slotNo .. ")")
        slot._btn_beforeLook:addInputEvent("Mouse_On", "HandleEventLUp_ServantMarket_All_ShowBeforeLook_Tooltip( true" .. "," .. ii .. ")")
        slot._btn_beforeLook:addInputEvent("Mouse_Out", "HandleEventLUp_ServantMarket_All_ShowBeforeLook_Tooltip( false )")
      end
      slot._stc_SwiftIcon:SetShow(false)
      if servantType == CppEnums.VehicleType.Type_Horse then
        slot._txt_LeftMatingTitle:SetShow(isNineTier)
        slot._txt_LeftMatingValue:SetShow(isNineTier)
        if auctionServantInfo:doClearCountByMating() then
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", auctionServantInfo:getMatingCount()))
        else
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", auctionServantInfo:getMatingCount()))
        end
        slot._stc_GenderIcon:SetShow(true)
        slot._stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
        local x1, y1, x2, y2 = 0, 0, 0, 0
        if true == auctionServantInfo:isMale() then
          x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 209, 31, 239)
        else
          x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 178, 31, 208)
        end
        slot._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        slot._stc_GenderIcon:setRenderTexture(slot._stc_GenderIcon:getBaseTexture())
        slot._txt_Tier:SetShow(true)
        if false == isNineTier and self._isContentsStallionEnable then
          slot._txt_Tier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
          slot._stc_SwiftIcon:SetShow(false)
        else
          slot._txt_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", auctionServantInfo:getTier()))
          if self._isContentsStallionEnable then
            local isStallion = auctionServantInfo:isStallion()
            slot._stc_SwiftIcon:SetShow(isStallion)
            slot._stc_SwiftIcon:SetMonoTone(not isStallion)
          end
        end
      else
        slot._txt_Tier:SetShow(false)
        slot._stc_GenderIcon:SetShow(false)
        slot._txt_LeftMatingTitle:SetShow(false)
        slot._txt_LeftMatingValue:SetShow(false)
      end
      slot._txt_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. auctionServantInfo:getLevel())
      slot._txt_HpValue:SetText(auctionServantInfo:getMaxHp())
      slot._txt_StaminaValue:SetText(auctionServantInfo:getMaxMp())
      slot._txt_WeightValue:SetText(tostring(auctionServantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000))
      slot._txt_SpeedValue:SetText(string.format("%.1f", auctionServantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
      slot._txt_AccelValue:SetText(string.format("%.1f", auctionServantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
      slot._txt_CorneringValue:SetText(string.format("%.1f", auctionServantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
      slot._txt_BreakValue:SetText(string.format("%.1f", auctionServantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
      local price = makeDotMoney(auctionServantInfo:getAuctoinPrice_s64())
      slot._btn_BUY_PC:SetText(price)
      local deadCount = auctionServantInfo:getDeadCount()
      if auctionServantInfo:doClearCountByDead() then
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
      else
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
      end
      slot._txt_DeadCountValue:SetText(deadCount)
      slot._btn_BUY_PC:SetIgnore(false)
      if true == self._isTabMyRegister then
        slot._btn_Cancel_PC:SetShow(true)
        local isAuctionEnd = false
        local expireTime = auctionServantInfo:getMarketExpiredTime()
        if expireTime <= toInt64(0, 0) then
          isAuctionEnd = true
        end
        slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "")
        if true == self._isFromNpc then
          local servantInfo = stable_getServantByServantNo(auctionServantInfo:getServantNo())
          if nil ~= servantInfo then
            if CppEnums.ServantStateType.Type_RegisterMarket == servantInfo:getStateType() then
              if isAuctionEnd then
                slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Cancel(" .. ii .. ")")
                if true == self._isConsole then
                  slot._slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Cancel(" .. ii .. ")")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_All_SetKeyGuideText(0, " .. slotNo .. ")")
                else
                  slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_END"))
                end
              else
                slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
                if true == self._isConsole then
                  slot._slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Cancel(" .. ii .. ")")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_All_SetKeyGuideText(0, " .. slotNo .. ")")
                else
                  slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Cancel(" .. ii .. ")")
                end
              end
            else
              slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_BTN_RECEIVE"))
              if true == self._isConsole then
                slot._slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Recieve(" .. ii .. ")")
                slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_All_SetKeyGuideText(1, " .. slotNo .. ")")
              else
                slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Recieve(" .. ii .. ")")
              end
            end
          else
            slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_BTN_RECEIVE"))
            if true == self._isConsole then
              slot._slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Recieve(" .. ii .. ")")
              slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_All_SetKeyGuideText(1, " .. slotNo .. ")")
            else
              slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Recieve(" .. ii .. ")")
            end
          end
        else
          slot._btn_BUY_PC:SetIgnore(true)
          slot._btn_Cancel_PC:SetShow(false)
        end
      elseif true == self._isFromNpc then
        slot._btn_Cancel_PC:SetShow(false)
        if false == self._isConsole then
          slot._btn_BUY_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Buy(" .. ii .. ")")
          slot._btn_BUY_PC:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_All_BuyBtnTextChange(" .. slotNo .. ",true)")
          slot._btn_BUY_PC:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_All_BuyBtnTextChange(" .. slotNo .. ",false," .. ii .. ")")
        else
          slot._slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_All_Buy(" .. ii .. ")")
          slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_All_SetKeyGuideText(2, " .. slotNo .. ")")
        end
      else
        slot._btn_BUY_PC:SetIgnore(true)
      end
      slotNo = slotNo + 1
    end
  end
  PaGlobal_ServantMarket_All:tooltipCheck()
end
function PaGlobal_ServantMarket_All:tooltipCheck()
  if true == self._isConsole then
    return
  end
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tooltipCheckControl = self._ui._servantSlot[slotIdx]._tooltipControls
    for idx = 1, #tooltipCheckControl do
      if nil ~= tooltipCheckControl[idx] then
        tooltipCheckControl[idx]:SetTextMode(__eTextMode_LimitText)
        tooltipCheckControl[idx]:SetText(tooltipCheckControl[idx]:GetText())
        if true == tooltipCheckControl[idx]:IsLimitText() then
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_Dialog_ServantMarket_All_ShowToolTip(" .. slotIdx .. "," .. idx .. " , true)")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_Dialog_ServantMarket_All_ShowToolTip(" .. slotIdx .. "," .. idx .. " , false)")
        else
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "")
        end
      end
    end
  end
end
function PaGlobal_ServantMarket_All:list2Update(content, key, slotIdx)
  if nil == Panel_Dialog_ServantMarket_All or nil == key then
    return
  end
  if nil == self._auctionInfo then
    return
  end
  local myAuctionInfo = self._auctionInfo
  local horseIdx = self._ui._servantSlot[slotIdx]._horseIdx
  local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(horseIdx)
  if nil == auctionServantInfo then
    return
  end
  local key32 = Int64toInt32(key)
  local skillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local skillExpBg = UI.getChildControl(content, "Static_SkillExpBg")
  local prog2_SkillExp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local actorKeyRaw = auctionServantInfo:getActorKeyRaw()
  local skillWrapper = auctionServantInfo:getSkill(key32)
  if nil ~= skillWrapper then
    skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    skillIcon:addInputEvent("Mouse_On", "HandleEventOn_MarketServant_Tooltip_Open(" .. actorKeyRaw .. ", " .. key32 .. ", " .. slotIdx .. ")")
    skillIcon:addInputEvent("Mouse_Out", "HandleEventPadPress_ServantMarket_All_TooltipHide()")
    skillName:SetText(skillWrapper:getName())
    local expPercentTxt = auctionServantInfo:getSkillExp(key32) / (skillWrapper:getMaxExp() / 100)
    prog2_SkillExp:SetShow(true)
    if 100 <= expPercentTxt then
      expPercentTxt = 100
    end
    prog2_SkillExp:SetProgressRate(expPercentTxt)
    prog2_SkillExp:SetAniSpeed(0)
  end
end
function PaGlobal_ServantMarket_All:MarketServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
  if nil == Panel_Dialog_ServantFunction_All or true == self._isConsole then
    return
  end
  local content = PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]._list2_Control:GetContentByKey(toInt64(0, key32))
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local myAuctionInfo = RequestGetAuctionInfo()
  local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(slotIdx)
  local skillWrapper = auctionServantInfo:getSkill(key32)
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
  else
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false)
  end
end
function PaGlobal_ServantMarket_All:moneyUpdate()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local invenMoney = selfPlayer:get():getInventory():getMoney_s64()
  local wareMoney = warehouse_moneyFromNpcShop_s64()
  self._ui._txt_Inven:SetText(makeDotMoney(invenMoney))
  self._ui._txt_Ware:SetText(makeDotMoney(wareMoney))
end
function PaGlobal_ServantMarket_All:dataClear()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  self._selectMaxPage = 0
  self._selectPage = 0
  self._isTabMyRegister = nil
  self._selectSlotNo = nil
  for slotIdx = 0, 3 do
    local list2 = self._ui._servantSlot[slotIdx]._list2_Control
    list2:getElementManager():clearKey()
  end
end
function PaGlobal_ServantMarket_All:prepareClose()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:dataClear()
  Panel_Dialog_ServantMarket_All:ClearUpdateLuaFunc()
  HandleEventPadPress_ServantMarket_All_TooltipHide()
  PaGlobal_ServantMarket_All:close()
end
function PaGlobal_ServantMarket_All:close()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    Panel_Dialog_ServantMarket_All:SetShow(false)
  end
end
function PaGlobal_ServantMarket_All:validate()
  if nil == Panel_Dialog_ServantMarket_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_TabGroup:isValidate()
  self._ui._rdo_Tab_MarketList:isValidate()
  self._ui._rdo_Tab_MyRegistList:isValidate()
  self._ui._stc_SelectedLine:isValidate()
  self._ui._stc_KeyGuide_LT:isValidate()
  self._ui._stc_KeyGuide_RT:isValidate()
  self._ui._stc_PageBg:isValidate()
  self._ui._txt_PageValue:isValidate()
  self._ui._btn_PageLeft_PC:isValidate()
  self._ui._btn_PageRight_PC:isValidate()
  self._ui._stc_PageLeft_Console:isValidate()
  self._ui._stc_PageRight_Console:isValidate()
  self._ui._stc_SortBg_PC_UI:isValidate()
  self._ui._stc_DiscountRate:isValidate()
  self._ui._stc_ComboBox_TierTitle:isValidate()
  self._ui._stc_ComboBox_GenderTitle:isValidate()
  self._ui._stc_ComboBox_SkillTitle:isValidate()
  self._ui._stc_ComboBox_Tier:isValidate()
  self._ui._stc_ComboBox_TierList:isValidate()
  self._ui._scroll_ComboBox_Tier:isValidate()
  self._ui._scrollUp_ComboBox_Tier:isValidate()
  self._ui._scrollDown_ComboBox_Tier:isValidate()
  self._ui._scrollCtrl_ComboBox_Tier:isValidate()
  self._ui._stc_ComboBox_Tier_BackStatic:isValidate()
  self._ui._stc_ComboBox_Skill:isValidate()
  self._ui._stc_ComboBox_SkillList:isValidate()
  self._ui._scroll_ComboBox_Skill:isValidate()
  self._ui._scrollUp_ComboBox_SKill:isValidate()
  self._ui._scrollDown_ComboBox_SKill:isValidate()
  self._ui._scrollCtrl_ComboBox_SKill:isValidate()
  self._ui._stc_ComboBox_Skill_BackStatic:isValidate()
  self._ui._stc_ComboBox_Gender:isValidate()
  self._ui._stc_ComboBox_GenderList:isValidate()
  self._ui._scroll_ComboBox_Gender:isValidate()
  self._ui._scrollUp_ComboBox_Gender:isValidate()
  self._ui._scrollDown_ComboBox_Gender:isValidate()
  self._ui._scrollCtrl_ComboBox_Gender:isValidate()
  self._ui._stc_ComboBox_Gender_BackStatic:isValidate()
  self._ui._btn_Reload_PC:isValidate()
  self._ui._stc_SortBg_ConsoleUI:isValidate()
  self._ui._txt_FilterTitle:isValidate()
  self._ui._txt_FilterValue:isValidate()
  self._ui._txt_InvenTitle:isValidate()
  self._ui._txt_Inven:isValidate()
  self._ui._txt_WareTitle:isValidate()
  self._ui._txt_Ware:isValidate()
  self._ui._stc_SkillTooltip:isValidate()
  self._ui._btn_SkillTooltip_Close_PC:isValidate()
  self._ui._stc_SkillTooltip_KeyGuide_B:isValidate()
  self._ui._stc_Bottom_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_Y_Tooltip:isValidate()
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    self._ui._servantSlot[slotIdx]._slot:isValidate()
    self._ui._servantSlot[slotIdx]._btn_Console_UI:isValidate()
    self._ui._servantSlot[slotIdx]._stc_ImageBg:isValidate()
    self._ui._servantSlot[slotIdx]._stc_HorseImage:isValidate()
    self._ui._servantSlot[slotIdx]._stc_GenderIcon:isValidate()
    self._ui._servantSlot[slotIdx]._stc_SwiftIcon:isValidate()
    self._ui._servantSlot[slotIdx]._txt_Tier:isValidate()
    self._ui._servantSlot[slotIdx]._txt_Level:isValidate()
    self._ui._servantSlot[slotIdx]._txt_HpTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_HpValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_StaminaTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_StaminaValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_WeightTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_WeightValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_SpeedTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_SpeedValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_AccelTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_AccelValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_CorneringTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_CorneringValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_BreakTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_BreakValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_DeadCountTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_DeadCountValue:isValidate()
    self._ui._servantSlot[slotIdx]._txt_LeftMatingTitle:isValidate()
    self._ui._servantSlot[slotIdx]._txt_LeftMatingValue:isValidate()
    self._ui._servantSlot[slotIdx]._btn_SkillTooltip:isValidate()
    self._ui._servantSlot[slotIdx]._btn_BUY_PC:isValidate()
    self._ui._servantSlot[slotIdx]._btn_Cancel_PC:isValidate()
    self._ui._servantSlot[slotIdx]._btn_beforeLook:isValidate()
    self._ui._servantSlot[slotIdx]._list2_Control:isValidate()
    self._ui._servantSlot[slotIdx]._txt_learnedSkillCount:isValidate()
  end
  self._initailize = true
end
