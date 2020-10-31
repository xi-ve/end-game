function PaGlobal_ShipInfo_All:initialize()
  if true == PaGlobal_ShipInfo_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titieBG = UI.getChildControl(Panel_Window_ShipInfo_All, "Static_TitleBg")
  self._ui.btn_close_PC = UI.getChildControl(self._ui.stc_titieBG, "Button_Win_Close_PCUI")
  self._ui.btn_question_PC = UI.getChildControl(self._ui.stc_titieBG, "Button_Question")
  self._ui.stc_radioGroup = UI.getChildControl(Panel_Window_ShipInfo_All, "Static_RadioGroup")
  self._ui.radio_basicInfo = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_BasicInfo")
  self._ui.radio_sailorInfo = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_SailorInfo")
  self._ui.stc_selcBar = UI.getChildControl(self._ui.stc_radioGroup, "Static_SelctLine")
  self._ui.stc_LB_Console = UI.getChildControl(self._ui.stc_radioGroup, "Static_SelectLB_C")
  self._ui.stc_RB_Console = UI.getChildControl(self._ui.stc_radioGroup, "Static_SelectRB_C")
  self._ui._stc_KeyGuideBG = UI.getChildControl(Panel_Window_ShipInfo_All, "Static_KeyGuide_Console")
  self._ui._txt_KeyGuideA = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_X_Console")
  self._ui._txt_KeyGuideB = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_B_Console")
  self._ui._txt_KeyGuideLTX = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTX_Console")
  self._ui._txt_KeyGuideLTY = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTY_Console")
  self._ui._txt_KeyGuideLTA = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTA_Console")
  self._ui.stc_baseInfoGroup = UI.getChildControl(Panel_Window_ShipInfo_All, "Static_BaseInfoGroup")
  self._ui.stc_basic_LeftBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_BasicInfo_LeftBG")
  self._ui.txt_basic_ShipNameTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipName")
  self._ui.txt_basic_ShipDPTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipDP")
  self._ui.txt_basic_ShipHPTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipHP")
  self._ui.txt_basic_ShipFoodTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipFood")
  self._ui.txt_basic_WeightTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_Weight")
  self._ui.txt_basic_CostTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_Cost")
  self._ui.txt_barterCountTitle = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_BarterCountTitle")
  self._ui.txt_basic_ShipName = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipNameValue")
  self._ui.txt_basic_ShipDP = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipDP_Value")
  self._ui.txt_basic_ShipHP = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipHP_Value")
  self._ui.txt_basic_ShipFood = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipFood_Value")
  self._ui.txt_basic_Weight = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_Weight_Value")
  self._ui.txt_basic_Cost = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_Cost_Value")
  self._ui.txt_barterCount = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_BarterCount_Value")
  self._ui.btn_foodEmergency = UI.getChildControl(self._ui.stc_basic_LeftBG, "Button_ShipFood_Emergency")
  self._ui.stc_basic_RightBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_BasicInfo_RightBG")
  self._ui.txt_basic_SpeedTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Speed")
  self._ui.txt_basic_AccelTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Acceleration")
  self._ui.txt_basic_CorneringTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_CorneringSpeed")
  self._ui.txt_basic_BreakTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Brake")
  self._ui.txt_basic_DamageTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Weight")
  self._ui.txt_cannonCountTitle = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Cannon")
  self._ui.txt_basic_ShipType = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_ShipTypeValue")
  self._ui.txt_basic_Speed = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Speed_Value")
  self._ui.txt_basic_Accel = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Acceleration_Value")
  self._ui.txt_basic_Cornering = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_CorneringSpeed_Value")
  self._ui.txt_basic_Break = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Brake_Value")
  self._ui.txt_basic_Damage = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_Weight_Value")
  self._ui.txt_cannonCount = UI.getChildControl(self._ui.stc_basic_RightBG, "StaticText_CannonValue")
  self._ui.btn_cannonEmergency = UI.getChildControl(self._ui.stc_basic_RightBG, "Button_Cannon_Emergency")
  self._ui.stc_basic_CannonLeftBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_CannonInfo_Left_BG")
  self._ui.txt_basic_CannonCoolTimeTitle = UI.getChildControl(self._ui.stc_basic_CannonLeftBG, "StaticText_NavalgunCooltime")
  self._ui.txt_basic_CannonMaxLengthTitle = UI.getChildControl(self._ui.stc_basic_CannonLeftBG, "StaticText_MaximumRange")
  self._ui.txt_basic_CannonCoolTime = UI.getChildControl(self._ui.stc_basic_CannonLeftBG, "StaticText_NavalgunCooltimeValue")
  self._ui.txt_basic_CannonMaxLength = UI.getChildControl(self._ui.stc_basic_CannonLeftBG, "StaticText_MaximumRangeValue")
  self._ui.stc_basic_SpecialLeftBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_SpecialInfo_Left_BG")
  self._ui.txt_basic_ResistCurrentTitle = UI.getChildControl(self._ui.stc_basic_SpecialLeftBG, "StaticText_ShipDP")
  self._ui.txt_baisc_ResistWindTitle = UI.getChildControl(self._ui.stc_basic_SpecialLeftBG, "StaticText_ShipHP")
  self._ui.txt_basic_ResistCurrent = UI.getChildControl(self._ui.stc_basic_SpecialLeftBG, "StaticText_ShipDP_Value")
  self._ui.txt_baisc_ResistWind = UI.getChildControl(self._ui.stc_basic_SpecialLeftBG, "StaticText_ShipHP_Value")
  self._ui.stc_basic_SpecialRightBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_SpecialInfo_Right_BG")
  self._ui.stc_basic_ResistFoodTitle = UI.getChildControl(self._ui.stc_basic_SpecialRightBG, "StaticText_ShipDP")
  self._ui.stc_basic_ResistRoyalTitle = UI.getChildControl(self._ui.stc_basic_SpecialRightBG, "StaticText_ShipHP")
  self._ui.stc_basic_ResistFood = UI.getChildControl(self._ui.stc_basic_SpecialRightBG, "StaticText_ShipDP_Value")
  self._ui.stc_basic_ResistRoyal = UI.getChildControl(self._ui.stc_basic_SpecialRightBG, "StaticText_ShipHP_Value")
  self._ui.stc_basic_CannonRightBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_CannonInfo_Right_BG")
  self._ui.txt_basic_CannonAccuracyTitle = UI.getChildControl(self._ui.stc_basic_CannonRightBG, "StaticText_Accury")
  self._ui.txt_basic_CannonMaxAngleTitle = UI.getChildControl(self._ui.stc_basic_CannonRightBG, "StaticText_Angle")
  self._ui.txt_basic_CannonAccuracy = UI.getChildControl(self._ui.stc_basic_CannonRightBG, "StaticText_AccuryValue")
  self._ui.txt_basic_CannonMaxAngle = UI.getChildControl(self._ui.stc_basic_CannonRightBG, "StaticText_AngleValue")
  self._ui.stc_basic_ShipInvenBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_ShipInvenBG")
  self._ui.stc_basic_ShipInven = UI.getChildControl(self._ui.stc_basic_ShipInvenBG, "Static_Inventory_BG")
  self._ui.stc_basic_ShipInvenSlot = UI.getChildControl(self._ui.stc_basic_ShipInven, "Static_ShipInventorySlot")
  self._ui.list_basic_ShipInven = UI.getChildControl(self._ui.stc_basic_ShipInven, "List2_1_VerticalScroll")
  self._ui.stc_basic_weightBG = UI.getChildControl(self._ui.stc_basic_ShipInvenBG, "Static_Weight")
  self._ui.progress_basic_weight = UI.getChildControl(self._ui.stc_basic_weightBG, "Progress2_WeightBar")
  self._ui.txt_basic_progressWeight = UI.getChildControl(self._ui.stc_basic_weightBG, "StaticText_WeightValue")
  self._ui.stc_weightGuide = UI.getChildControl(self._ui.stc_basic_weightBG, "Static_WeightGuide")
  self._ui.stc_alert = UI.getChildControl(self._ui.stc_basic_weightBG, "Static_Alert")
  self._ui.stc_basic_EquipSlot = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_EquipSlot")
  self._ui.stc_basic_SkillBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_SkillListBG")
  self._ui.list_basic_SkillList = UI.getChildControl(self._ui.stc_basic_SkillBG, "List2_SkillList")
  self._ui.stc_sailorInfoGroup = UI.getChildControl(Panel_Window_ShipInfo_All, "Static_SailorInfoGroup")
  self._ui.list_sailor_leftList = UI.getChildControl(self._ui.stc_sailorInfoGroup, "List2_Sailor_Left")
  self._ui.stc_sailor_rightBG = UI.getChildControl(self._ui.stc_sailorInfoGroup, "Static_SailorInformation")
  self._ui.stc_sailor_imageBG = UI.getChildControl(self._ui.stc_sailor_rightBG, "Static_SailorBg")
  self._ui.stc_sailor_image = UI.getChildControl(self._ui.stc_sailor_imageBG, "Static_WorkerImage")
  self._ui.txt_sailor_name = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_WorkerTitle")
  self._ui.txt_sailor_State = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SailorState")
  self._ui.progress_sailor_exp = UI.getChildControl(self._ui.stc_sailor_rightBG, "Progress2_EXPProgress")
  self._ui.progress_sailor_loyalty = UI.getChildControl(self._ui.stc_sailor_rightBG, "Progress2_LoyaltyProgress")
  self._ui.txt_sailor_speedTitle = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SpeedTitle")
  self._ui.txt_sailor_turningTitle = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_TurningTitle")
  self._ui.txt_sailor_accelTitle = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_ExcelTitle")
  self._ui.txt_sailor_breakTitle = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_BreakTitle")
  self._ui.txt_sailor_speed = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SpeedValue")
  self._ui.txt_sailor_turning = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_TurningValue")
  self._ui.txt_sailor_feed = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_FeedValue")
  self._ui.txt_sailor_accel = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_ExcelValue")
  self._ui.txt_sailor_break = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_BreakValue")
  self._ui.txt_sailor_cost = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_CostValue")
  self._ui.txt_sailor_cannonCoolTime = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_PatienceTitle")
  self._ui.txt_sailor_cannonCoolTimeValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_PatienceValue")
  self._ui.txt_sailor_cannonMaxLength = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_PowerTitle")
  self._ui.txt_sailor_cannonMaxLengthValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_PowerValue")
  self._ui.txt_sailor_cannonAccuracy = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_FocusTitle")
  self._ui.txt_sailor_cannonAccuracyValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_FocusValue")
  self._ui.txt_sailor_cannonMaxAngle = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SightTitle")
  self._ui.txt_sailor_cannonMaxAngleValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SightValue")
  self._ui.txt_currentValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_CurrentValue")
  self._ui.txt_seaWindValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SeaWindValue")
  self._ui.txt_foodValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_FoodValue")
  self._ui.txt_loyaltyValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_LoyaltyValue")
  self._ui.txt_bodyWeight = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_BodyWeightValue")
  self._ui.txt_displayRoyalty = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_RoyaltyValue")
  self._ui.txt_slotValue = UI.getChildControl(self._ui.stc_sailor_rightBG, "StaticText_SlotCount")
  self:initLimitText()
  self._useStartSlot = inventorySlotNoUserStart()
  PaGlobal_ShipInfo_All:basic_createSlots()
  PaGlobal_ShipInfo_All:registerEventHandler()
  PaGlobal_ShipInfo_All:validate()
  PaGlobal_ShipInfo_All:setControlShow()
  PaGlobal_ShipInfo_All._initialize = true
end
function PaGlobal_ShipInfo_All:registerEventHandler()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  self._ui.list_basic_SkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ShipInfoAll_CreateSkillList")
  self._ui.list_basic_SkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_sailor_leftList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ShipInfoAll_CreateSailorList")
  self._ui.list_sailor_leftList:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    local sailorInfoTitleList = {
      [self._infoType.SPEED] = self._ui.txt_sailor_speedTitle,
      [self._infoType.EXCEL] = self._ui.txt_sailor_accelTitle,
      [self._infoType.TURNING] = self._ui.txt_sailor_turningTitle,
      [self._infoType.BRAKE] = self._ui.txt_sailor_breakTitle,
      [self._infoType.PATIENCE] = self._ui.txt_sailor_cannonCoolTime,
      [self._infoType.POWER] = self._ui.txt_sailor_cannonMaxLength,
      [self._infoType.FOCUS] = self._ui.txt_sailor_cannonAccuracy,
      [self._infoType.SIGHT] = self._ui.txt_sailor_cannonMaxAngle
    }
    for index, control in ipairs(sailorInfoTitleList) do
      control:SetIgnore(false)
      control:SetEnable(true)
      control:addInputEvent("Mouse_On", "HandleEventOnOut_ShipInfoAll_InfoTitleTooltip(true, " .. index .. ")")
      control:addInputEvent("Mouse_Out", "HandleEventOnOut_ShipInfoAll_InfoTitleTooltip(false, " .. index .. ")")
      if control:GetSizeX() < control:GetTextSizeX() then
        control:SetEnableArea(0, 0, control:GetTextSizeX(), control:GetSizeY())
      end
    end
    self._ui.btn_close_PC:addInputEvent("Mouse_LUp", "PaGlobal_ShipInfo_All:prepareClose()")
    self._ui.btn_question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelServantinfo\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question_PC, "\"PanelServantinfo\"")
    self._ui.radio_basicInfo:addInputEvent("Mouse_LUp", "HandlerEventLUp_ShipInfoAll_RadioButtonSelect()")
    self._ui.radio_sailorInfo:addInputEvent("Mouse_LUp", "HandlerEventLUp_ShipInfoAll_RadioButtonSelect()")
    UIScroll.InputEventByControl(self._ui.stc_basic_ShipInven, "HandlerEventScrollDown_ShipInfoAll_ShipInven")
    UIScroll.InputEvent(self._ui.list_basic_ShipInven, "HandlerEventScrollDown_ShipInfoAll_ShipInven")
    self._ui.txt_basic_ShipFood:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_ShipFoodTooltip(true)")
    self._ui.txt_basic_ShipFood:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_ShipFoodTooltip(false)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(true)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(false)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(true)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(false)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
    self._ui.stc_weightGuide:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_weightGuide, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_weightGuide, false)")
    self._ui.stc_alert:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_alert, true)")
    self._ui.stc_alert:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_alert, false)")
  else
    self._ui.btn_foodEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(true)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(false)")
    self._ui.btn_foodEmergency:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(true)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_ShipItemFilterTooltip(false)")
    self._ui.btn_cannonEmergency:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
    Panel_Window_ShipInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.txt_basic_progressWeight, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_weightGuide, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_weightGuide, false)")
    self._ui.stc_alert:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_alert, true)")
    self._ui.stc_alert:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoAll_WeightTooltip(PaGlobal_ShipInfo_All._ui.stc_alert, false)")
  end
  registerEvent("EventServantEquipItem", "FromClient_ShipInfo_ChangeEquipItem")
  registerEvent("EventServantEquipmentUpdate", "FromClient_ShipInfo_ChangeEquipItem")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ShipInfo_UpdateItem")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_ShipInfo_UpdateItem")
  registerEvent("FromClient_updateFood", "FromClient_ShipInfo_UpdateFoodStat")
  registerEvent("FromClient_UpdateCannonStatCount", "FromClient_ShipInfo_UpdateCannonStat")
end
function PaGlobal_ShipInfo_All:basic_createSlots()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  for ii = 1, self._equipSlotMaxCount do
    self._equipSlotBG[ii] = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_ItemSlot" .. ii)
    self._equipSlotBG[ii]:SetShow(true)
    self._equipSlotBG[ii]:SetIgnore(not _ContentsGroup_UsePadSnapping)
    self._equipSlotCashBG[ii] = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_PearlItemSlot" .. ii)
    self._equipSlotCashBG[ii]:SetShow(true)
    self._equipSlotCashBG[ii]:SetIgnore(not _ContentsGroup_UsePadSnapping)
    self._equipSlotBGIcon[ii] = UI.getChildControl(self._equipSlotBG[ii], "Static_Icon_EuipType" .. ii)
    self._equipSlotCashBGIcon[ii] = UI.getChildControl(self._equipSlotCashBG[ii], "Static_Icon_EuipType" .. ii)
    local slot = {}
    SlotItem.new(slot, "Slot_ShipEquip_" .. ii, ii, self._equipSlotBG[ii], self._slotConfig)
    slot:createChild()
    local cashSlot = {}
    SlotItem.new(cashSlot, "Slot_ShipCashEquip_" .. ii, ii, self._equipSlotCashBG[ii], self._slotConfig)
    cashSlot:createChild()
    self._equipItemSlots[ii] = slot
    self._equipItemCashSlots[ii] = cashSlot
  end
  self._config.row = math.floor(self._config.CONST_COUNT / self._config.col)
  for ii = 0, self._config.CONST_COUNT - 1 do
    self._invenSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui.stc_basic_ShipInven, "Static_ShipInventorySlot", self._ui.stc_basic_ShipInven, "Static_ShipInvenSlot_" .. ii)
    self._invenSlotBG[ii]:SetPosX(self._config.startPos + (self._config.size + self._config.gap) * (ii % self._config.col))
    self._invenSlotBG[ii]:SetPosY(self._config.startPos + (self._config.size + self._config.gap) * math.floor(ii / self._config.col))
    self._invenSlotBG[ii]:SetShow(false)
    local slot = {}
    SlotItem.new(slot, "Slot_ShipInven_" .. ii, ii, self._invenSlotBG[ii], self._slotConfig)
    slot:createChild()
    self._invenSlotBG[ii]:addInputEvent("Mouse_UpScroll", "HandlerEventScrollDown_ShipInfoAll_ShipInven(true)")
    self._invenSlotBG[ii]:addInputEvent("Mouse_DownScroll", "HandlerEventScrollDown_ShipInfoAll_ShipInven(false)")
    UIScroll.InputEventByControl(slot.icon, "HandlerEventScrollDown_ShipInfoAll_ShipInven")
    self._invenItemSlots[ii] = slot
  end
  local notuseControl = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_PearlItemSlot5")
  notuseControl:SetShow(false)
end
function PaGlobal_ShipInfo_All:setControlShow()
  if false == _ContentsGroup_OceanCurrent then
    self._ui.txt_cannonCountTitle:SetShow(false)
    self._ui.txt_cannonCount:SetShow(false)
    self._ui.stc_basic_SpecialLeftBG:SetShow(false)
    self._ui.stc_basic_SpecialRightBG:SetShow(false)
    self._ui.stc_basic_ShipInvenBG:SetSpanSize(self._ui.stc_basic_ShipInvenBG:GetSpanSize().x, self._ui.stc_basic_ShipInvenBG:GetSpanSize().y + 145)
    self._ui.list_basic_SkillList:SetSize(self._ui.list_basic_SkillList:GetSizeX(), self._ui.list_basic_SkillList:GetSizeY() - self._ui.list_basic_SkillList:GetSizeY() * 0.5 + 16)
    Panel_Window_ShipInfo_All:SetSize(Panel_Window_ShipInfo_All:GetSizeX(), Panel_Window_ShipInfo_All:GetSizeY() - 141)
    Panel_Window_ShipInfo_All:ComputePos()
  end
  if false == _ContentsGroup_Sailor then
    self._ui.txt_barterCountTitle:SetShow(false)
    self._ui.txt_barterCount:SetShow(false)
    self._ui.txt_basic_CostTitle:SetShow(false)
    self._ui.txt_basic_Cost:SetShow(false)
    self._ui.txt_basic_ShipFoodTitle:SetSpanSize(self._ui.txt_basic_CostTitle:GetSpanSize().x, self._ui.txt_basic_CostTitle:GetSpanSize().y)
    self._ui.txt_basic_ShipFood:SetSpanSize(self._ui.txt_basic_Cost:GetSpanSize().x, self._ui.txt_basic_Cost:GetSpanSize().y + 20)
    self._ui.btn_foodEmergency:SetSpanSize(self._ui.btn_foodEmergency:GetSpanSize().x, self._ui.txt_basic_ShipFood:GetSpanSize().y - 3)
    self._ui.stc_basic_ResistRoyalTitle:SetShow(false)
    self._ui.stc_basic_ResistRoyal:SetShow(false)
    self._ui.radio_sailorInfo:SetShow(false)
    self._ui.radio_basicInfo:SetHorizonCenter()
    self._ui.radio_basicInfo:SetSpanSize(0, self._ui.radio_basicInfo:GetSpanSize().y)
    local decoLine = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_DecoLine")
    decoLine:SetShow(false)
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.btn_close_PC:SetShow(false)
    self._ui.btn_question_PC:SetShow(false)
    self._ui._stc_KeyGuideBG:SetShow(true)
    self:setAlignKeyGuide()
  end
end
function PaGlobal_ShipInfo_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui._txt_KeyGuideLTY,
    self._ui._txt_KeyGuideLTA,
    self._ui._txt_KeyGuideLTX,
    self._ui._txt_KeyGuideA,
    self._ui._txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ShipInfo_All:basic_Update()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == servantWrapper or nil == vehicleActor or nil == vehicleActorWrapper then
    return
  end
  local staticText = UI.getChildControl(self._ui.stc_basic_LeftBG, "StaticText_ShipFood")
  local vehicleType = servantWrapper:getVehicleType()
  local characterKey = vehicleActorWrapper:getCharacterKey()
  local isFood = false
  self._ui.txt_basic_ShipFood:SetIgnore(true)
  if true == _ContentsGroup_OceanCurrent then
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
      self._ui.txt_basic_ShipFood:SetIgnore(false)
      isFood = true
    else
      staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
  elseif CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
    staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
  else
    staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
  end
  self._ui.txt_basic_ShipFood:ComputePos()
  self._ui.txt_cannonCount:ComputePos()
  if false == isFood then
    if true == self._isConsole then
      self._ui._txt_KeyGuideLTY:SetShow(false)
      self._ui._txt_KeyGuideLTA:SetShow(false)
      self:setAlignKeyGuide()
      Panel_Window_ShipInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
      Panel_Window_ShipInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
    else
      self._ui.btn_foodEmergency:SetShow(false)
      self._ui.btn_cannonEmergency:SetShow(false)
    end
  elseif true == self._isConsole then
    self._ui._txt_KeyGuideLTY:SetShow(true)
    self._ui._txt_KeyGuideLTA:SetShow(true)
    self:setAlignKeyGuide()
    Panel_Window_ShipInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    Panel_Window_ShipInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventMLUp_ShipInfoAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
  else
    self._ui.txt_basic_ShipFood:SetPosX(self._ui.txt_basic_ShipFood:GetPosX() - self._ui.btn_foodEmergency:GetSizeX() - 10)
    self._ui.txt_cannonCount:SetPosX(self._ui.txt_cannonCount:GetPosX() - self._ui.btn_cannonEmergency:GetSizeX() - 10)
    self._ui.btn_foodEmergency:SetShow(true)
    self._ui.btn_cannonEmergency:SetShow(true)
  end
  self._ui.txt_basic_ShipName:SetText(servantWrapper:getName())
  self._ui.txt_basic_ShipDP:SetText(vehicleActorWrapper:get():getDefense())
  self._ui.txt_basic_ShipHP:SetText(makeDotMoney(servantWrapper:getHp()) .. " / " .. makeDotMoney(servantWrapper:getMaxHp()))
  self._ui.txt_basic_ShipFood:SetText(makeDotMoney(servantWrapper:getFood()) .. " / " .. makeDotMoney(servantWrapper:getMaxFood()))
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  local weightPercent = Int64toInt32(s64_weightAll / s64_weightMax_div)
  local strWeight = str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui.txt_basic_Weight:SetText(strWeight)
  self._ui.txt_basic_Cost:SetText(vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Employee_Cost) .. " / " .. servantWrapper:getEmployeeMaxCost())
  self._ui.txt_barterCount:SetText(tostring(ToClient_barterTotalExchangeCount()))
  self._ui.txt_cannonCount:SetText(tostring(servantWrapper:getServantStatParam(__eServantStatParamType_Cannon)))
  local speed = servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
  local accel = servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration)
  local cornering = servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
  local braking = servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
  local shipTypeStr = servantWrapper:getDisplayName()
  if nil == shipTypeStr then
    shipTypeStr = ""
  end
  self._ui.txt_basic_ShipType:SetText(shipTypeStr)
  self._ui.txt_basic_Speed:SetText(string.format("%.1f", speed * 1.0E-4) .. "%")
  self._ui.txt_basic_Accel:SetText(string.format("%.1f", accel * 1.0E-4) .. "%")
  self._ui.txt_basic_Cornering:SetText(string.format("%.1f", cornering * 1.0E-4) .. "%")
  self._ui.txt_basic_Break:SetText(string.format("%.1f", braking * 1.0E-4) .. "%")
  local deadCount = servantWrapper:getDeadCount()
  local deadTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT")
  if true == _ContentsGroup_OceanCurrent and true == servantWrapper:getIsDamageShip() then
    deadCount = deadCount / ToClinet_GetServantMaxDeadCount() * 100 .. "%"
    deadTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_WOUNDEDPERCENT")
  end
  self._ui.txt_basic_DamageTitle:SetText(deadTitleStr)
  self._ui.txt_basic_Damage:SetText(deadCount)
  local cannonAccuracyView = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonAccuracy) - 90
  if 100 < cannonAccuracyView then
    cannonAccuracyView = 100
  end
  self._ui.txt_basic_CannonCoolTime:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonCoolTime)) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"))
  self._ui.txt_basic_CannonAccuracy:SetText(string.format("%.2f", cannonAccuracyView) .. "%")
  self._ui.txt_basic_CannonMaxLength:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxLength) * 0.01))
  self._ui.txt_basic_CannonMaxAngle:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxAngle)) .. "\203\154")
  self._ui.txt_basic_ResistCurrent:SetText(string.format("%.1f", vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Resist_OceanCurrent) * 1.0E-4) .. "%")
  self._ui.txt_baisc_ResistWind:SetText(string.format("%.1f", vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Resist_WindDirection) * 1.0E-4) .. "%")
  self._ui.stc_basic_ResistFood:SetText(string.format("%.1f", vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Resist_Food) * 1.0E-4) .. "%")
  self._ui.stc_basic_ResistRoyal:SetText(string.format("%.1f", vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Resist_Loyalty) * 1.0E-4) .. "%")
  self._extendedSlotInfoArray = {}
  PaGlobal_ShipInfo_All:equipSlotUpdate(false)
  PaGlobal_ShipInfo_All:equipSlotUpdate(true)
  local skillCount = servantWrapper:getSortedSkillCountForDisplay()
  local listCount = 0
  self._ui.list_basic_SkillList:getElementManager():clearKey()
  for ii = 0, skillCount - 1 do
    if nil ~= servantWrapper:getSortedSkillForDisplay(ii) then
      listCount = listCount + 1
      self._shipSkillIndex[listCount] = ii
      self._ui.list_basic_SkillList:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  if nil ~= vehicleActor:getInventory() then
    self._config.contentsCount = vehicleActor:getInventory():size() - self._useStartSlot
    self._config.count = math.min(self._config.contentsCount, self._config.CONST_COUNT)
    UIScroll.SetButtonSize(self._ui.list_basic_ShipInven, self._config.count, self._config.contentsCount)
    PaGlobal_ShipInfo_All:basic_invenUpdate()
  end
  self._ui.progress_basic_weight:SetProgressRate(weightPercent)
  self._ui.txt_basic_progressWeight:SetText(strWeight)
end
function PaGlobal_ShipInfo_All:equipSlotUpdate(isCashSlot)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local slot, slotBG, slotBGIcon, slotNoTable
  local hasExtendedSlot = false
  if false == isCashSlot then
    slot = self._equipItemSlots
    slotBG = self._equipSlotBG
    slotBGIcon = self._equipSlotBGIcon
    if false == self._isBigShip then
      slotNoTable = self._equipSlotNoSmall
    else
      slotNoTable = self._equipSlotNoBig
    end
  else
    slot = self._equipItemCashSlots
    slotBG = self._equipSlotCashBG
    slotBGIcon = self._equipSlotCashBGIcon
    if false == self._isBigShip then
      slotNoTable = self._equipCashSlotNoSmall
    else
      slotNoTable = self._equipCashSlotNoBig
    end
  end
  for ii = 1, self._equipSlotMaxCount do
    local slotNo = slotNoTable[ii]
    slot[ii]:clearItem()
    local itemWrapper = servantWrapper:getEquipItem(slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local slotNoMax = itemSSW:getExtendedSlotCount()
      for index = 1, slotNoMax do
        local extendSlotNo = itemSSW:getExtendedSlotIndex(index - 1)
        if slotNoMax ~= extendSlotNo then
          self._extendedSlotInfoArray[extendSlotNo] = ii
          hasExtendedSlot = true
        end
      end
      slot[ii]:setItem(itemWrapper)
      slot[ii].icon:SetShow(true)
      slot[ii].icon:SetMonoTone(false)
      slotBGIcon[ii]:SetShow(false)
      if false == isCashSlot then
        chk_totem = UI.getChildControl(slotBG[ii], "CheckButton_EquipSlot_Totem")
        chk_totem:SetShow(false)
        if slotNo == self._totemSlotNum then
          slotBG[ii]:SetChildIndex(chk_totem, 9999)
          chk_totem:SetShow(true)
          chk_totem:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoAll_ShowEquipToggle()")
          self._totemCheckButton = chk_totem
          PaGlobal_ShipInfo_All:setShowToggleButton()
        end
      end
    else
      slot[ii].icon:SetShow(false)
      slotBGIcon[ii]:SetShow(true)
      if slotNo == self._totemSlotNum and nil ~= self._totemCheckButton then
        self._totemCheckButton:SetShow(false)
        self._totemCheckButton = nil
      end
    end
    if true == _ContentsGroup_UsePadSnapping then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlerEventMouseOn_ShipInfoAll_EquipItem(" .. ii .. ", true, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_Out", "HandlerEventMouseOn_ShipInfoAll_EquipItem(" .. ii .. ", false, " .. tostring(isCashSlot) .. ")")
    else
      slot[ii].icon:addInputEvent("Mouse_On", "HandlerEventMouseOn_ShipInfoAll_EquipItem(" .. ii .. ", true, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_Out", "HandlerEventMouseOn_ShipInfoAll_EquipItem(" .. ii .. ", false, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_RUp", "HandlerEventRUp_ShipInfoAll_EquipItem(" .. slotNo .. ")")
      Panel_Tooltip_Item_SetPosition(slotNo, slot[ii], "ServantShipEquipment")
    end
  end
  if true == hasExtendedSlot then
    for extendSlotNo, slotIndex in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = servantWrapper:getEquipItem(slotNoTable[slotIndex])
      if nil ~= itemWrapper then
        for i = 1, self._equipSlotMaxCount do
          if extendSlotNo == slotNoTable[i] then
            slot[i]:setItem(itemWrapper)
            slot[i].icon:SetMonoTone(true)
            slot[i].icon:SetShow(true)
            slotBGIcon[i]:SetShow(false)
          end
        end
      end
    end
  end
end
function PaGlobal_ShipInfo_All:basic_invenUpdate()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  for ii = 0, self._config.CONST_COUNT - 1 do
    self._invenSlotBG[ii]:SetShow(false)
  end
  for ii = 0, self._config.count - 1 do
    local slotIndex = ii + self._startInvenSlotIndex
    local slotNo = self._useStartSlot + slotIndex
    if nil ~= self._invenSlotBG[ii] and slotIndex < self._config.contentsCount then
      self._invenSlotBG[ii]:SetShow(true)
      self._invenItemSlots[ii]:clearItem()
      local itemWrapper = getServantInventoryItemBySlotNo(self._actorKeyRaw, slotNo)
      if nil ~= itemWrapper then
        self._invenItemSlots[ii]:setItem(itemWrapper)
        self._invenItemSlots[ii].icon:SetShow(true)
        if true == self._isConsole then
          if true == _ContentsGroup_RenewUI_Tooltip then
            self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_X, "HandlerEventMouseOn_ShipInfoAll_EquipItem_Console(" .. slotNo .. ", true)")
          else
            self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",true," .. ii .. ")")
            self._invenSlotBG[ii]:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",false," .. ii .. ")")
            Panel_Tooltip_Item_SetPosition(slotNo, self._invenItemSlots[ii], "servant_inventoryView")
          end
        else
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",true, " .. ii .. ")")
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",false," .. ii .. ")")
          Panel_Tooltip_Item_SetPosition(slotNo, self._invenItemSlots[ii], "servant_inventoryView")
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ShipInfo_All_SlotRClick(" .. slotNo .. ")")
        end
      else
        self._invenItemSlots[ii].icon:SetShow(false)
      end
    end
  end
  self:weight_Update()
end
function PaGlobal_ShipInfo_All:weight_Update()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == servantWrapper or nil == vehicleActor or nil == vehicleActorWrapper then
    return
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  local weightPercent = Int64toInt32(s64_weightAll / s64_weightMax_div)
  local strWeight = str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui.txt_basic_Weight:SetText(strWeight)
  self._ui.progress_basic_weight:SetProgressRate(weightPercent)
  self._ui.txt_basic_progressWeight:SetText(strWeight)
  if 100 <= weightPercent then
    self._ui.stc_alert:SetShow(true)
    if false == self._isConsole then
      self._ui.stc_weightGuide:SetShow(false)
    end
  else
    self._ui.stc_alert:SetShow(false)
    if false == self._isConsole then
      self._ui.stc_weightGuide:SetShow(true)
    end
  end
end
function PaGlobal_ShipInfo_All:sailor_Update()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_Sailor then
    return
  end
  self._currentSailorIndex = 0
  PaGlobal_ShipInfo_All:sailor_sailorList()
  local sailorCount = ToClient_getEmployeeCount()
  if 0 < sailorCount then
    HandleEventLUp_ShipInfoAll_SelectSailor(1)
  end
end
function PaGlobal_ShipInfo_All:sailor_sailorList()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_Sailor then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local servantNo = servantWrapper:getServantNo()
  self._sailorCount = ToClient_getEmployeeCount()
  self._ui.txt_slotValue:SetText(tostring(self._sailorCount) .. "/" .. tostring(ToClient_getEmployeeMaxSlotCount()))
  for index = 1, self._sailorCount do
    local sailorWrapper = ToClient_getEmployeeWrapperByIndex(index - 1)
    if nil ~= sailorWrapper then
      local sailorKey = sailorWrapper:getEmployeeKey()
      if true == sailorKey:isDefined() then
        local sailorInfoTemplate = {
          _index = index,
          _level = sailorKey:getLevel(),
          _name = sailorWrapper:getEmployeeName(),
          _expRate = sailorWrapper:getExperienceRate(),
          _loyalty = sailorWrapper:getLoyalty(),
          _maxLoyalty = sailorWrapper:getMaxLoyalty(),
          _royalRate = sailorWrapper:getLoyaltyRate(),
          _isApply = sailorWrapper:isApply(),
          _state = sailorWrapper:getState(),
          _sailorNo = sailorWrapper:getEmployeeNo(),
          _onServantNo = sailorWrapper:getVariousNo(),
          _resSeaCurrent = sailorWrapper:getValue(__eEmployeeAbility_Resist_OceanCurrent),
          _resSeaWind = sailorWrapper:getValue(__eEmployeeAbility_Resist_WindDirection),
          _resFood = sailorWrapper:getValue(__eEmployeeAbility_Resist_Food),
          _resLoyalty = sailorWrapper:getValue(__eEmployeeAbility_Resist_Loyalty),
          _speed = sailorWrapper:getValue(__eEmployeeAbility_Servant_Speed),
          _accel = sailorWrapper:getValue(__eEmployeeAbility_Servant_Acceleration),
          _turning = sailorWrapper:getValue(__eEmployeeAbility_Servant_Cornering),
          _break = sailorWrapper:getValue(__eEmployeeAbility_Servant_Brake),
          _cannonCoolTime = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonCoolTime),
          _cannonAccuracy = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonAccuracy),
          _cannonMaxLength = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxLength),
          _cannonMaxAngle = sailorWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxAngle),
          _cost = sailorWrapper:getCost(),
          _foodConsume = sailorWrapper:getFoodConsume(),
          _iconPath = sailorWrapper:getIconPath(),
          _bodyWeight = sailorWrapper:getBodyWeight()
        }
        self._sailorList[index] = sailorInfoTemplate
      end
    end
  end
  self._ui.list_sailor_leftList:getElementManager():clearKey()
  for i = 1, self._sailorCount do
    self._ui.list_sailor_leftList:getElementManager():pushKey(toInt64(0, i))
  end
  self._ui.stc_sailor_rightBG:SetShow(self._sailorCount > 0)
end
function PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, isBigShip)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  self._actorKeyRaw = actorKeyRaw
  self._ui.radio_basicInfo:SetCheck(true)
  self._ui.radio_sailorInfo:SetCheck(false)
  HandlerEventLUp_ShipInfoAll_RadioButtonSelect()
  Panel_Window_ShipInfo_All:SetHorizonCenter()
  Panel_Window_ShipInfo_All:SetVerticalMiddle()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  self._isBigShip = isBigShip
  self:changeSlotBGIcon()
  self:setShowToggleButton()
  self._servantNo = servantWrapper:getServantNo()
  self._isGuildShip = servantWrapper:isGuildServant()
  local isShipShow = true
  local isEmployeeShow = true
  if false == ToClient_IsManualCannonFireServant(self._actorKeyRaw) then
    isShipShow = false
    if false == _ContentsGroup_BattleShipFireRenewal then
      isEmployeeShow = false
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    if servantWrapper:getSortedSkillCountForDisplay() <= 0 then
      self._ui.list_basic_SkillList:SetIgnore(true)
      self._ui.list_basic_SkillList:SetShow(false)
    else
      self._ui.list_basic_SkillList:SetIgnore(false)
      self._ui.list_basic_SkillList:SetShow(true)
    end
  end
  if false == isShipShow then
    self._ui.stc_basic_SpecialLeftBG:SetPosY(self._ui.stc_basic_CannonLeftBG:GetPosY())
    self._ui.stc_basic_SpecialRightBG:SetPosY(self._ui.stc_basic_CannonRightBG:GetPosY())
  else
    self._ui.stc_basic_SpecialLeftBG:SetPosY(self._ui.stc_basic_CannonLeftBG:GetPosY() + 60)
    self._ui.stc_basic_SpecialRightBG:SetPosY(self._ui.stc_basic_CannonRightBG:GetPosY() + 60)
  end
  self._ui.txt_basic_CannonCoolTimeTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxLengthTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonCoolTime:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxLength:SetShow(isShipShow)
  self._ui.stc_basic_CannonLeftBG:SetShow(isShipShow)
  self._ui.txt_basic_CannonAccuracyTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxAngleTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonAccuracy:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxAngle:SetShow(isShipShow)
  self._ui.stc_basic_CannonRightBG:SetShow(isShipShow)
  self._ui.txt_sailor_cannonCoolTime:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonCoolTimeValue:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonMaxLength:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonMaxLengthValue:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonAccuracy:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonAccuracyValue:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonMaxAngle:SetShow(isEmployeeShow)
  self._ui.txt_sailor_cannonMaxAngleValue:SetShow(isEmployeeShow)
  self:open()
  if false == _ContentsGroup_UsePadSnapping then
    Inventory_SetFunctor(nil, PaGlobal_ShipInfo_All_Inventory_SetFunctor, nil, nil)
    InventoryWindow_Show()
    if true == _ContentsGroup_NewUI_Inventory_All then
      if Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_ShipInfo_All:ComputePos()
      else
        Panel_Window_ShipInfo_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_ShipInfo_All:GetSizeX() - 10)
        Panel_Window_ShipInfo_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
      end
    elseif Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_ShipInfo_All:ComputePos()
    else
      Panel_Window_ShipInfo_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ShipInfo_All:GetSizeX() - 10)
      Panel_Window_ShipInfo_All:SetPosY(Panel_Window_Inventory:GetPosY())
    end
  end
  ToClient_RequestCannonStatUpdate(self._actorKeyRaw)
end
function PaGlobal_ShipInfo_All:changeSlotBGIcon()
  for ii = 1, self._equipSlotMaxCount do
    local slotBG = self._equipSlotBG[ii]
    local cashSlotBG = self._equipSlotCashBG[ii]
    local slotBGIcon = self._equipSlotBGIcon[ii]
    local cashSlotBGIcon = self._equipSlotCashBGIcon[ii]
    local uvTable = self._equipSlotBigShipUV
    local slotNo = self._equipSlotNoBig[ii]
    local cashSlotNo = self._equipCashSlotNoBig[ii]
    if false == self._isBigShip then
      uvTable = self._equipSlotSmallShipUV
      slotNo = self._equipSlotNoSmall[ii]
      cashSlotNo = self._equipCashSlotNoSmall[ii]
    end
    if 0 == slotNo then
      slotBG:SetShow(false)
    else
      slotBG:SetShow(true)
    end
    if 0 == cashSlotNo then
      cashSlotBG:SetShow(false)
    else
      cashSlotBG:SetShow(true)
    end
    if nil == uvTable[slotNo] then
      return
    end
    slotBGIcon:ChangeTextureInfoNameDefault("renewal/pcremaster/remaster_icon_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBGIcon, uvTable[slotNo].x1, uvTable[slotNo].y1, uvTable[slotNo].x2, uvTable[slotNo].y2)
    slotBGIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBGIcon:setRenderTexture(slotBGIcon:getBaseTexture())
    cashSlotBGIcon:ChangeTextureInfoNameDefault("renewal/pcremaster/remaster_icon_01.dds")
    x1, y1, x2, y2 = setTextureUV_Func(cashSlotBGIcon, uvTable[cashSlotNo].x1, uvTable[cashSlotNo].y1, uvTable[cashSlotNo].x2, uvTable[cashSlotNo].y2)
    cashSlotBGIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    cashSlotBGIcon:setRenderTexture(cashSlotBGIcon:getBaseTexture())
  end
end
function PaGlobal_ShipInfo_All:open()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  Panel_Window_ShipInfo_All:SetShow(true)
end
function PaGlobal_ShipInfo_All:prepareClose()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    HelpMessageQuestion_Out()
    HandleEventMLUp_ItemFilter_Close()
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
  self:close()
end
function PaGlobal_ShipInfo_All:close()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  Panel_Window_ShipInfo_All:SetShow(false)
end
function PaGlobal_ShipInfo_All:validate()
  if nil == Panel_Window_ShipInfo_All then
    return
  end
end
function PaGlobal_ShipInfo_All:showEquipToggle()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
  if nil == seaVehicleWrapper then
    return
  end
  if nil == self._totemCheckButton then
    return
  end
  local isCheck = self._totemCheckButton:IsCheck()
  if isCheck then
    ToClient_SetVehicleEquipSlotFlag(seaVehicleWrapper:getVehicleType(), self._totemSlotNum)
  else
    ToClient_ResetVehicleEquipSlotFlag(seaVehicleWrapper:getVehicleType(), self._totemSlotNum)
  end
  ToClient_setShowVehicleEquip(CppEnums.ServantType.Type_Ship)
end
function PaGlobal_ShipInfo_All:setShowToggleButton()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if nil == self._totemCheckButton then
    return
  end
  if false == self._isBigShip then
    local isCheck = ToClient_IsSetVehicleEquipSlotFlag(servantWrapper:getVehicleType(), self._totemSlotNum)
    self._totemCheckButton:SetShow(true)
    self._totemCheckButton:SetCheck(isCheck)
    return
  end
  self._totemCheckButton:SetShow(false)
end
function PaGlobal_ShipInfo_All:inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local fromItemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == fromItemWrapper then
    return
  end
  local itemSSW = fromItemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local itemSS = itemSSW:get()
  if nil == itemSS then
    return false
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return false
  end
  self._inventoryType = inventoryType
  self._inventorySlotNo = slotNo
  function PaGlobal_ShipInfo_All_InventoryUseItem()
    inventoryUseItem(PaGlobal_ShipInfo_All._inventoryType, PaGlobal_ShipInfo_All._inventorySlotNo, CppEnums.EquipSlotNoClient.eEquipSlotNoCount, false)
  end
  local servantKind = servantWrapper:getServantKind()
  local servantKindSub = servantWrapper:getServantKindSub()
  if true == itemSS:isServantTypeUsable(servantKind, servantKindSub) then
    if 2 == itemSS._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local messageContent
      if itemSSW:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = PaGlobal_ShipInfo_All_InventoryUseItem,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      PaGlobal_ShipInfo_All_InventoryUseItem()
    end
  else
    PaGlobal_ShipInfo_All._moveItemToType = CppEnums.MoveItemToType.Type_Player
    PaGlobal_ShipInfo_All._inventoryType = inventoryType
    FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_NewShip, PaGlobal_ShipInfo_All._actorKeyRaw, true)
  end
end
function PaGlobal_ShipInfo_All:ShipInfo_Tooltip_Open(actorKeyRaw, key32)
  if nil == Panel_Window_ShipInfo_All then
    return
  end
  local content = PaGlobal_ShipInfo_All._ui.list_basic_SkillList:GetContentByKey(toInt64(0, key32))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local skillIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(PaGlobal_ShipInfo_All._shipSkillIndex[key32])
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
  else
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false)
    if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Tooltip_Skill_Servant then
      Panel_Tooltip_Skill_Servant:SetPosY(stc_BG:GetParentPosY())
      Panel_Tooltip_Skill_Servant:SetPosX(Panel_Window_ShipInfo_All:GetPosX() + Panel_Window_ShipInfo_All:GetSizeX())
    end
  end
end
function PaGlobal_ShipInfo_All:initLimitText()
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CostTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_barterCountTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_cannonCountTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_ResistCurrentTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_baisc_ResistWindTitle)
  UI.setLimitTextAndAddTooltip(self._ui.stc_basic_ResistFoodTitle)
  UI.setLimitTextAndAddTooltip(self._ui.stc_basic_ResistRoyalTitle)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.txt_basic_CostTitle:SetIgnore(not self._ui.txt_basic_CostTitle:IsLimitText())
    self._ui.txt_barterCountTitle:SetIgnore(not self._ui.txt_barterCountTitle:IsLimitText())
    self._ui.txt_cannonCountTitle:SetIgnore(not self._ui.txt_cannonCountTitle:IsLimitText())
    self._ui.txt_basic_ResistCurrentTitle:SetIgnore(not self._ui.txt_basic_ResistCurrentTitle:IsLimitText())
    self._ui.txt_baisc_ResistWindTitle:SetIgnore(not self._ui.txt_baisc_ResistWindTitle:IsLimitText())
    self._ui.stc_basic_ResistFoodTitle:SetIgnore(not self._ui.stc_basic_ResistFoodTitle:IsLimitText())
    self._ui.stc_basic_ResistRoyalTitle:SetIgnore(not self._ui.stc_basic_ResistRoyalTitle:IsLimitText())
  end
end
function PaGlobal_ShipInfo_All:updateServantSkillLock(index)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(self._shipSkillIndex[index])
  if nil == skillWrapper then
    return
  end
  local key = self._ui.list_basic_SkillList:getKeyByIndex(index - 1)
  if -1 == key then
    index = index + 1
    key = self._ui.list_basic_SkillList:getKeyByIndex(index - 1)
  end
  local control = self._ui.list_basic_SkillList:GetContentByKey(key)
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skliIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local chk_skillLockIcon = UI.getChildControl(stc_skliIcon, "CheckButton_SkillLockIcon")
  local isCheck = chk_skillLockIcon:IsCheck()
  if true == isCheck then
    ToClient_blockVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  else
    ToClient_enableVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  end
end
