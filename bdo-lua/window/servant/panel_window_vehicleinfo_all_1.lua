function PaGlobal_VehicleInfo_All:initialize()
  if true == PaGlobal_VehicleInfo_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_titleBg = UI.getChildControl(Panel_Window_VehicleInfo_All, "Static_TitleBg")
  self._ui._pc._btn_close = UI.getChildControl(stc_titleBg, "Button_Win_Close_PCUI")
  self._ui._pc._btn_question = UI.getChildControl(stc_titleBg, "Button_Question")
  self._ui._txt_titleIconServant = UI.getChildControl(stc_titleBg, "StaticText_TitleIcon_Servant")
  self._ui._txt_titleIconCarriage = UI.getChildControl(stc_titleBg, "StaticText_TitleIcon_Carriage")
  self._ui._console._stc_keyGuideBG = UI.getChildControl(Panel_Window_VehicleInfo_All, "Static_ConsoleKeyGuide")
  local stc_baseInfoGroup = UI.getChildControl(Panel_Window_VehicleInfo_All, "Static_BaseInfoGroup")
  local stc_basicInfo_left = UI.getChildControl(stc_baseInfoGroup, "Static_BasicInfo_LeftBG")
  self._ui._txt_expTitle = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleExp")
  self._ui._txt_hpTitle = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleHP")
  self._ui._txt_steminaTitle = UI.getChildControl(stc_basicInfo_left, "StaticText_Stemina")
  self._ui._stc_maleIcon = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleMale")
  self._ui._stc_femaleIcon = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleFemale")
  self._ui._txt_nameValue = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleNameValue")
  self._ui._txt_expValue = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleExp_Value")
  self._ui._txt_hpValue = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleHP_Value")
  self._ui._txt_steminaValue = UI.getChildControl(stc_basicInfo_left, "StaticText_VehicleStemina_Value")
  self._ui._stc_hpBg = UI.getChildControl(stc_basicInfo_left, "Static_HpProgressBg")
  self._ui._progress_hp = UI.getChildControl(self._ui._stc_hpBg, "Progress2_Hp")
  self._ui._txt_hpPercent = UI.getChildControl(self._ui._stc_hpBg, "StaticText_HpPercent")
  self._ui._stc_staminaBg = UI.getChildControl(stc_basicInfo_left, "Static_StaminaProgressBg")
  self._ui._progress_stamina = UI.getChildControl(self._ui._stc_staminaBg, "Progress2_Stamina")
  self._ui._txt_staminaPercent = UI.getChildControl(self._ui._stc_staminaBg, "StaticText_StaminaPercent")
  self._ui._stc_expBg = UI.getChildControl(stc_basicInfo_left, "Static_ExpProgressBg")
  self._ui._progress_exp = UI.getChildControl(self._ui._stc_expBg, "Progress2_Exp")
  self._ui._txt_expPercent = UI.getChildControl(self._ui._stc_expBg, "StaticText_ExpPercent")
  local stc_basicInfo_right = UI.getChildControl(stc_baseInfoGroup, "Static_BasicInfo_RightBG")
  self._ui._txt_speedTitle = UI.getChildControl(stc_basicInfo_right, "StaticText_Speed")
  self._ui._txt_accelerationTitle = UI.getChildControl(stc_basicInfo_right, "StaticText_Acceleration")
  self._ui._txt_corneringTitle = UI.getChildControl(stc_basicInfo_right, "StaticText_CorneringSpeed")
  self._ui._txt_brakeTitle = UI.getChildControl(stc_basicInfo_right, "StaticText_Brake")
  self._ui._txt_tierValue = UI.getChildControl(stc_basicInfo_right, "StaticText_VehicleTypeValue")
  self._ui._stc_goodHorseIcon = UI.getChildControl(stc_basicInfo_right, "StaticText_VehicleTypeGoodHorse")
  self._ui._txt_speedValue = UI.getChildControl(stc_basicInfo_right, "StaticText_Speed_Value")
  self._ui._txt_accelerationValue = UI.getChildControl(stc_basicInfo_right, "StaticText_Acceleration_Value")
  self._ui._txt_corneringValue = UI.getChildControl(stc_basicInfo_right, "StaticText_CorneringSpeed_Value")
  self._ui._txt_brakeValue = UI.getChildControl(stc_basicInfo_right, "StaticText_Brake_Value")
  self._ui._txt_levelValue = UI.getChildControl(stc_basicInfo_right, "StaticText_LevelValue")
  local stc_specialInfo_left = UI.getChildControl(stc_baseInfoGroup, "Static_SpecialInfo_Left_BG")
  self._ui._txt_deadCountTitle = UI.getChildControl(stc_specialInfo_left, "StaticText_VehicleDeadCount")
  self._ui._txt_matingCountTitle = UI.getChildControl(stc_specialInfo_left, "StaticText_VehicleMatingCount")
  self._ui._txt_deadCount = UI.getChildControl(stc_specialInfo_left, "StaticText_VehicleDeadCount_Value")
  self._ui._txt_matingCount = UI.getChildControl(stc_specialInfo_left, "StaticText_VehicleMatingCount_Value")
  local stc_specialInfo_right = UI.getChildControl(stc_baseInfoGroup, "Static_SpecialInfo_Right_BG")
  self._ui._txt_remainPeriodTitle = UI.getChildControl(stc_specialInfo_right, "StaticText_VehicleLeftTime")
  self._ui._txt_remainPeriod = UI.getChildControl(stc_specialInfo_right, "StaticText_VehicleLeftTime_Value")
  self._ui._txt_sealTitle = UI.getChildControl(stc_specialInfo_right, "StaticText_SealTitle")
  self._ui._txt_sealValue = UI.getChildControl(stc_specialInfo_right, "StaticText_Seal_Value")
  self._ui._txt_suspensionTitle = UI.getChildControl(stc_specialInfo_right, "StaticText_SuspensionTitle")
  self._ui._txt_suspensionValue = UI.getChildControl(stc_specialInfo_right, "StaticText_SuspensionValue")
  local stc_vehicleInvenBg = UI.getChildControl(stc_baseInfoGroup, "Static_VehicleInvenBG")
  self._ui._stc_inventoryBG = UI.getChildControl(stc_vehicleInvenBg, "Static_Inventory_BG")
  self._ui._scroll_vertical = UI.getChildControl(self._ui._stc_inventoryBG, "List2_1_VerticalScroll")
  local stc_weight = UI.getChildControl(stc_vehicleInvenBg, "Static_Weight")
  self._ui._progress_weightBar = UI.getChildControl(stc_weight, "Progress2_WeightBar")
  self._ui._txt_weightNotation = UI.getChildControl(stc_weight, "StaticText_WeightValue")
  self._ui._stc_weightGuide = UI.getChildControl(stc_weight, "Static_WeightGuide")
  self._ui._stc_heavyAlert = UI.getChildControl(stc_weight, "Static_HeavyAlert")
  self._ui._chk_autoFeed = UI.getChildControl(stc_vehicleInvenBg, "CheckButton_Eat")
  local chk_Desc = UI.getChildControl(self._ui._chk_autoFeed, "StaticText_1")
  chk_Desc:SetTextMode(__eTextMode_AutoWrap)
  chk_Desc:SetText(chk_Desc:GetText())
  self._ui._chk_autoFeed:SetShow(false)
  self._ui._chk_autoFeed:SetCheck(true)
  self._ui._stc_equipSlotGroup = UI.getChildControl(stc_baseInfoGroup, "Static_EquipSlot")
  for k, v in pairs(self._equipConfig._slotIds) do
    self._ui._stc_equipSlotLib[k] = UI.getChildControl(self._ui._stc_equipSlotGroup, v)
    self._ui._chk_equipShowLib[k] = UI.getChildControl(self._ui._stc_equipSlotLib[k], "CheckButton_EquipSlot_Show" .. k)
    self._ui._stc_equipIconLib[k] = UI.getChildControl(self._ui._stc_equipSlotLib[k], "Static_Icon_EuipType")
    self._ui._stc_equipSlotLib[k]:SetShow(false)
    self._ui._chk_equipShowLib[k]:SetShow(false)
    self._ui._stc_equipIconLib[k]:SetShow(false)
  end
  self._ui._list2_carriageSkillList = UI.getChildControl(stc_baseInfoGroup, "List2_CarriageSkillList")
  self._ui._txt_carriageNoSkill = UI.getChildControl(self._ui._list2_carriageSkillList, "StaticText_NoSkill")
  self._ui._list2_horseSkillList = UI.getChildControl(stc_baseInfoGroup, "List2_HorseSkillList")
  self._ui._stc_horseSkillListBG = UI.getChildControl(stc_baseInfoGroup, "Static_ListBG")
  self._ui._txt_horseNoSkill = UI.getChildControl(self._ui._stc_horseSkillListBG, "StaticText_NoSkill")
  self._ui._list2_horseList = UI.getChildControl(stc_baseInfoGroup, "List2_CarriageHorseList")
  self._ui._txt_noHorse = UI.getChildControl(self._ui._list2_horseList, "StaticText_NoLinkHorse")
  self._ui._txt_skillTitle = UI.getChildControl(stc_baseInfoGroup, "StaticText_SkillTitle")
  self._ui._txt_linkedHorseTitle = UI.getChildControl(stc_baseInfoGroup, "StaticText_LinkedHorseTitle")
  self._ui._txt_linkedHorseValue = UI.getChildControl(stc_baseInfoGroup, "StaticText_LinikedHorseValue")
  self._ui._txt_rentTime = UI.getChildControl(Panel_Window_VehicleInfo_All, "StaticText_RentTime")
  self._ui._txt_dpValue = UI.getChildControl(stc_basicInfo_right, "StaticText_Defence")
  self._ui._console.txt_keyGuideY = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Toggle")
  self._ui._console.txt_keyGuideA = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Select")
  self._ui._console.txt_keyGuideB = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Close")
  self._ui._console.txt_keyGuideLTX = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_KeyGuideLTX")
  self._ui._console.txt_keyGuideLTY = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_KeyGuideLTY")
  self._ui._console.txt_keyGuideY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_KEYGUIDE_VISIBILITYTOGGLE"))
  self._ui._console.txt_keyGuideLTY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_GRADEINFO_TOOLTIP_TITLE"))
  self._keyGuide = {
    self._ui._console.txt_keyGuideLTX,
    self._ui._console.txt_keyGuideLTY,
    self._ui._console.txt_keyGuideY,
    self._ui._console.txt_keyGuideA,
    self._ui._console.txt_keyGuideB
  }
  for k, v in pairs(self._ui._pc) do
    v:SetShow(false == self._isConsole)
  end
  for k, v in pairs(self._ui._console) do
    v:SetShow(self._isConsole)
  end
  self._ui._stc_weightGuide:SetShow(not self._isConsole)
  self._nameStartPosX = self._ui._txt_nameValue:GetPosX()
  self._tierStartPosX = self._ui._txt_tierValue:GetPosX() + self._ui._txt_tierValue:GetSizeX()
  self._isContentsStallion = ToClient_IsContentsGroupOpen("243")
  self._inventory._useStartSlot = inventorySlotNoUserStart()
  self:createInventorySlot()
  self:createEquipSlot()
  self._ui._console.txt_keyGuideY:SetShow(false)
  self:setAlignKeyGuide()
  PaGlobal_VehicleInfo_All:registEventHandler()
  PaGlobal_VehicleInfo_All:validate()
  PaGlobal_VehicleInfo_All._initialize = true
end
function PaGlobal_VehicleInfo_All:registEventHandler()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_VehicleInfo_All_Close()")
  self._ui._pc._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelServantinfo\" )")
  if nil ~= PaGlobal_Util_RegistHelpTooltipEvent then
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._pc._btn_question, "\"PanelServantinfo\"")
  end
  self._ui._stc_goodHorseIcon:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_StallionTooltip()")
  self._ui._stc_goodHorseIcon:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_StallionTooltip()")
  UIScroll.InputEventByControl(self._ui._stc_inventoryBG, "HandlerEventScroll_VehicleInfo_All_InventoryScroll")
  self._ui._list2_carriageSkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_VehicleInfo_All_UpdateSkillList")
  self._ui._list2_carriageSkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_horseSkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_VehicleInfo_All_UpdateSkillList")
  self._ui._list2_horseSkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_horseList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_VehicleInfo_All_UpdateHorseList")
  self._ui._list2_horseList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._txt_tierValue:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_ServantTierTooltip()")
  self._ui._txt_tierValue:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_ServantTierTooltip()")
  self._ui._stc_weightGuide:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_WeightTooltip()")
  self._ui._stc_weightGuide:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_WeightTooltip()")
  self._ui._stc_heavyAlert:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_WeightTooltip()")
  self._ui._stc_heavyAlert:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_WeightTooltip()")
  if true == self._isConsole then
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_VehicleInfo_All_ToggleAutoFeed()")
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_VehicleInfo_All_StallionTooltipForConsole()")
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_VehicleInfo_All_ServantTierTooltipForConsole()")
  end
  registerEvent("FromClient_OpenServantInformation", "FromClient_VehicleInfo_All_OpenSevantInfomation")
  registerEvent("EventSelfServantUpdate", "FromClient_VehicleInfo_All_UpdateAll")
  registerEvent("EventSelfServantUpdateOnlyHp", "FromClient_VehicleInfo_All_UpdateHp")
  registerEvent("EventSelfServantUpdateOnlyMp", "FromClient_VehicleInfo_All_UpdateMp")
  registerEvent("EventServantEquipmentUpdate", "FromClient_VehicleInfo_All_ServantEquipmentUpdate")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_VehicleInfo_All_UpdateAll")
end
function PaGlobal_VehicleInfo_All:prepareOpen(viewType, actorKeyRaw)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  self:initSkillList()
  self._viewType = viewType
  self._actorKeyRaw = actorKeyRaw
  self._inventoryType = 0
  self._inventroySlotNo = 0
  if true == self._isConsole then
    self._stallionTooltipShow = false
    self._tierTooltipShow = false
  end
  self:update(viewType)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local VehicleType = servantWrapper:getVehicleType()
  for index, value in pairs(self._equipConfig._horse) do
    if self._eViewType._normal == viewType and CppEnums.VehicleType.Type_Elephant ~= VehicleType and self._horseShoesIndex ~= value._index then
      self._ui._chk_equipShow[value._index]:SetCheck(false)
      local isCheck = ToClient_IsSetVehicleEquipSlotFlag(servantWrapper:getVehicleType(), value._index)
      self._ui._chk_equipShow[value._index]:SetCheck(isCheck)
    end
  end
  local canFeed = CppEnums.VehicleType.Type_Horse == VehicleType or CppEnums.VehicleType.Type_Donkey == VehicleType or CppEnums.VehicleType.Type_Camel == VehicleType
  if true == self._isConsole then
    self._ui._chk_autoFeed:SetShow(canFeed)
  else
    self._ui._chk_autoFeed:SetShow(false)
  end
  if true == self._isConsole then
    local isStallion = servantWrapper:isStallion()
    self:updateKeyGuideString(isStallion)
  end
  PaGlobal_VehicleInfo_All:open()
end
function PaGlobal_VehicleInfo_All:open()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  Panel_Window_VehicleInfo_All:SetShow(true)
end
function PaGlobal_VehicleInfo_All:prepareClose()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
    TooltipSimple_Hide()
    Panel_SkillTooltip_Hide()
    HelpMessageQuestion_Out()
    PaGlobal_LinkedSkill_All_Close()
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
  PaGlobal_VehicleInfo_All:close()
end
function PaGlobal_VehicleInfo_All:close()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  Panel_Window_VehicleInfo_All:SetShow(false)
end
function PaGlobal_VehicleInfo_All:update(viewType)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  self:updateTitle(viewType)
  self:updateBasicInfo(viewType)
  self:updateSpecialInfo(viewType)
  self:updateInventory()
  self:updateEquipInfo(viewType)
  self:updateSkillInfo(viewType)
end
function PaGlobal_VehicleInfo_All:updateData(viewType)
  self:updateBasicInfo(viewType)
  self:updateSpecialInfo(viewType)
  self:updateInventory()
  self:updateEquipInfo(viewType)
  self:updateSkillInfo(viewType)
end
function PaGlobal_VehicleInfo_All:validate()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  self._ui._txt_expTitle:isValidate()
  self._ui._txt_hpTitle:isValidate()
  self._ui._txt_steminaTitle:isValidate()
  self._ui._txt_speedTitle:isValidate()
  self._ui._txt_accelerationTitle:isValidate()
  self._ui._txt_corneringTitle:isValidate()
  self._ui._txt_brakeTitle:isValidate()
  self._ui._txt_deadCountTitle:isValidate()
  self._ui._txt_matingCountTitle:isValidate()
  self._ui._txt_remainPeriodTitle:isValidate()
  self._ui._pc._btn_close:isValidate()
  self._ui._txt_titleIconServant:isValidate()
  self._ui._txt_titleIconCarriage:isValidate()
  self._ui._txt_nameValue:isValidate()
  self._ui._txt_levelValue:isValidate()
  self._ui._txt_expValue:isValidate()
  self._ui._txt_dpValue:isValidate()
  self._ui._txt_hpValue:isValidate()
  self._ui._txt_steminaValue:isValidate()
  self._ui._txt_tierValue:isValidate()
  self._ui._txt_speedValue:isValidate()
  self._ui._txt_accelerationValue:isValidate()
  self._ui._txt_corneringValue:isValidate()
  self._ui._txt_brakeValue:isValidate()
  self._ui._txt_deadCount:isValidate()
  self._ui._txt_matingCount:isValidate()
  self._ui._txt_remainPeriod:isValidate()
  self._ui._stc_inventoryBG:isValidate()
  self._ui._scroll_vertical:isValidate()
  self._ui._progress_weightBar:isValidate()
  self._ui._txt_weightNotation:isValidate()
  self._ui._stc_weightGuide:isValidate()
  self._ui._stc_heavyAlert:isValidate()
  for k, v in pairs(self._ui._stc_equipSlotLib) do
    self._ui._stc_equipSlotLib[k]:isValidate()
    self._ui._chk_equipShowLib[k]:isValidate()
    self._ui._stc_equipIconLib[k]:isValidate()
  end
  self._ui._list2_carriageSkillList:isValidate()
  self._ui._list2_horseSkillList:isValidate()
  self._ui._list2_horseList:isValidate()
end
function PaGlobal_VehicleInfo_All:updateBasicInfo(viewType)
  PaGlobal_VehicleInfo_All:updateBasicInfo_leftBg(viewType)
  PaGlobal_VehicleInfo_All:updateBasicInfo_rightBg(viewType)
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_leftBg(viewType)
  if self._eViewType._normal == viewType then
    self:updateBasicInfo_leftBg_noraml()
  elseif self._eViewType._carriage == viewType then
    self:updateBasicInfo_leftBg_carriage()
  end
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_leftBg_noraml()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_steminaTitle:SetShow(true)
  self._ui._txt_nameValue:SetShow(true)
  self._ui._txt_steminaValue:SetShow(true)
  self._ui._txt_dpValue:SetShow(true)
  self._ui._txt_hpTitle:SetShow(true)
  self._ui._txt_hpValue:SetShow(true)
  self._ui._stc_hpBg:SetShow(true)
  self._ui._stc_staminaBg:SetShow(true)
  self._ui._txt_expTitle:SetShow(false)
  self._ui._txt_levelValue:SetShow(false)
  self._ui._txt_expValue:SetShow(false)
  self._ui._stc_expBg:SetShow(false)
  if __eVehicleType_Elephant ~= servantWrapper:getVehicleType() then
    self._ui._txt_expTitle:SetShow(true)
    self._ui._txt_expValue:SetShow(true)
    self._ui._txt_levelValue:SetShow(true)
    self._ui._stc_expBg:SetShow(true)
    self._ui._txt_steminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEMP_NAME"))
  else
    self._ui._txt_steminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_ELEPHANT_MP"))
  end
  self._ui._txt_hpTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_HP"))
  self._ui._txt_steminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_STAMINA"))
  self._ui._txt_expTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPEDITION_ARMYUNITSETTING_EXP"))
  self:updateName()
  self:updateHp()
  self:updateStamina()
  self:updateLevel()
  self:updateWeight()
  self:updateDp()
  self._ui._stc_maleIcon:SetShow(false)
  self._ui._stc_femaleIcon:SetShow(false)
  if __eVehicleType_Horse == servantWrapper:getVehicleType() then
    if servantWrapper:isMale() then
      self._ui._stc_maleIcon:SetShow(true)
      self._ui._stc_maleIcon:ComputePos()
      self._ui._stc_maleIcon:SetPosX(self._nameStartPosX + self._ui._txt_nameValue:GetTextSizeX(), self._ui._stc_maleIcon:GetPosY())
    else
      self._ui._stc_femaleIcon:SetShow(true)
      self._ui._stc_femaleIcon:ComputePos()
      self._ui._stc_femaleIcon:SetPosX(self._nameStartPosX + self._ui._txt_nameValue:GetTextSizeX(), self._ui._stc_femaleIcon:GetPosY())
    end
  end
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_leftBg_carriage()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  self._ui._txt_nameValue:SetShow(true)
  self._ui._txt_hpTitle:SetShow(true)
  self._ui._txt_hpValue:SetShow(true)
  self._ui._txt_steminaTitle:SetShow(true)
  self._ui._txt_steminaValue:SetShow(true)
  self._ui._txt_dpValue:SetShow(true)
  self._ui._txt_expTitle:SetShow(false)
  self._ui._txt_expValue:SetShow(false)
  self._ui._stc_hpBg:SetShow(true)
  self._ui._stc_staminaBg:SetShow(true)
  self._ui._stc_expBg:SetShow(false)
  self._ui._txt_levelValue:SetShow(false)
  self._ui._stc_maleIcon:SetShow(false)
  self._ui._stc_femaleIcon:SetShow(false)
  self._ui._txt_hpTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_HP"))
  if __eVehicleType_RepairableCarriage == vehicleType then
    self._ui._txt_steminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
  else
    self._ui._txt_steminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
  end
  self:updateName()
  self:updateHp()
  self:updateStamina()
  self:updateLevel()
  self:updateWeight()
  self:updateDp()
end
function PaGlobal_VehicleInfo_All:updateName()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_nameValue:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_nameValue:SetText(servantWrapper:getName())
  if true == self._ui._txt_nameValue:IsLimitText() then
    self._ui._txt_nameValue:SetIgnore(false)
    self._ui._txt_nameValue:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_TextTooltip(" .. self._eTooltipType._name .. ")")
    self._ui._txt_nameValue:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_TextTooltip()")
  else
    self._ui._txt_nameValue:SetIgnore(true)
  end
end
function PaGlobal_VehicleInfo_All:updateHp()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local hp = servantWrapper:getHp()
  local maxHp = servantWrapper:getMaxHp()
  self._ui._txt_hpValue:SetText(makeDotMoney(hp) .. " / " .. makeDotMoney(maxHp))
  local percent = math.floor(hp / maxHp * 100)
  self._ui._progress_hp:SetProgressRate(percent)
  self._ui._txt_hpPercent:SetText(tostring(percent) .. "%")
end
function PaGlobal_VehicleInfo_All:updateStamina()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local mp = servantWrapper:getMp()
  local maxMp = servantWrapper:getMaxMp()
  self._ui._txt_steminaValue:SetText(makeDotMoney(mp) .. " / " .. makeDotMoney(maxMp))
  local percent = math.floor(mp / maxMp * 100)
  self._ui._progress_stamina:SetProgressRate(percent)
  self._ui._txt_staminaPercent:SetText(tostring(percent) .. "%")
end
function PaGlobal_VehicleInfo_All:updateLevel()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local exp_s64 = servantWrapper:getExp_s64()
  local needExp_s64 = servantWrapper:getNeedExp_s64()
  self._ui._txt_levelValue:SetText("Lv." .. tostring(servantWrapper:getLevel()))
  self._ui._txt_levelValue:SetSize(self._ui._txt_levelValue:GetTextSizeX(), self._ui._txt_levelValue:GetSizeY())
  self._ui._txt_expValue:SetText(makeDotMoney(exp_s64) .. " / " .. makeDotMoney(needExp_s64))
  local percent = math.floor(Int64toInt32(exp_s64) / Int64toInt32(needExp_s64) * 100)
  self._ui._progress_exp:SetProgressRate(percent)
  self._ui._txt_expPercent:SetText(tostring(percent) .. "%")
end
function PaGlobal_VehicleInfo_All:updateWeight()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local max_weight_s64 = servantWrapper:getMaxWeight_s64()
  local total_weight_s64 = servantWrapper:getInventoryWeight_s64() + servantWrapper:getEquipWeight_s64()
  local max_weight_s32 = Int64toInt32(max_weight_s64)
  local total_weight_s32 = Int64toInt32(total_weight_s64)
  local weightValue = ""
  if max_weight_s32 < total_weight_s32 then
    weightValue = "<PAColor0xFFD20000>" .. makeWeightString(total_weight_s64, 0) .. "<PAOldColor> / " .. makeWeightString(max_weight_s64, 0)
  else
    weightValue = makeWeightString(total_weight_s64, 0) .. " / " .. makeWeightString(max_weight_s64, 0)
  end
  weightValue = weightValue .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui._txt_weightNotation:SetText(weightValue)
  local rateValue = total_weight_s32 / max_weight_s32 * 100
  self._ui._progress_weightBar:SetProgressRate(rateValue)
  if false == self._isConsole then
    if rateValue < 100 then
      self._ui._stc_heavyAlert:SetShow(false)
      self._ui._stc_weightGuide:SetShow(true)
    else
      self._ui._stc_heavyAlert:SetShow(true)
      self._ui._stc_weightGuide:SetShow(false)
    end
  end
end
function PaGlobal_VehicleInfo_All:updateDp()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local vehicleInfo = getVehicleActor(self._actorKeyRaw)
  if nil ~= vehicleInfo then
    self._ui._txt_dpValue:SetText(vehicleInfo:get():getDefense())
    self._ui._txt_dpValue:ComputePos()
    self._ui._txt_dpValue:SetPosX(self._ui._txt_dpValue:GetPosX() - self._ui._txt_dpValue:GetTextSizeX() - 10)
  end
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_rightBg(viewType)
  if self._eViewType._normal == viewType then
    self:updateBasicInfo_rightBg_normal()
  elseif self._eViewType._carriage == viewType then
    self:updateBasicInfo_rightBg_carriage()
  end
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_rightBg_normal()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_speedTitle:SetShow(true)
  self._ui._txt_accelerationTitle:SetShow(true)
  self._ui._txt_corneringTitle:SetShow(true)
  self._ui._txt_brakeTitle:SetShow(true)
  self._ui._txt_speedValue:SetShow(true)
  self._ui._txt_accelerationValue:SetShow(true)
  self._ui._txt_corneringValue:SetShow(true)
  self._ui._txt_brakeValue:SetShow(true)
  self._ui._stc_goodHorseIcon:SetShow(false)
  self._ui._txt_rentTime:SetShow(false)
  if true == self._isConsole then
    self._ui._console.txt_keyGuideLTX:SetShow(false)
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
  end
  if __eVehicleType_Horse == servantWrapper:getVehicleType() then
    self._ui._txt_tierValue:SetShow(true)
    if true == self._isConsole then
      self._ui._console.txt_keyGuideLTY:SetShow(true)
      Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_VehicleInfo_All_ServantTierTooltipForConsole()")
    end
    if 9 == servantWrapper:getTier() then
      self._ui._txt_tierValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
    else
      self._ui._txt_tierValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantWrapper:getTier()) .. "(<PAColor0xFF0FBFFF>?<PAOldColor>)")
      if false == servantWrapper:isPcroomOnly() and self._isContentsStallion then
        local isStallion = servantWrapper:isStallion()
        self._ui._stc_goodHorseIcon:SetShow(true)
        if true == self._isConsole then
          self._ui._console.txt_keyGuideLTX:SetShow(true)
          Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_VehicleInfo_All_StallionTooltipForConsole()")
        end
        if true == isStallion then
          self._ui._stc_goodHorseIcon:SetMonoTone(false)
        else
          self._ui._stc_goodHorseIcon:SetMonoTone(true)
        end
      end
    end
    if true == self._isConsole then
      local msgDataLen = string.len(self._ui._txt_tierValue:GetText())
      local targetIdx = string.find(self._ui._txt_tierValue:GetText(), "<PAColor")
      if nil ~= targetIdx then
        local msgData = string.sub(self._ui._txt_tierValue:GetText(), 1, targetIdx - 2)
        self._ui._txt_tierValue:SetText(msgData)
      end
    end
    self._ui._txt_tierValue:SetSize(self._ui._txt_tierValue:GetTextSizeX(), self._ui._txt_tierValue:GetSizeY())
    self._ui._txt_tierValue:SetPosX(self._ui._txt_dpValue:GetPosX() - self._ui._txt_tierValue:GetTextSizeX())
    self._ui._stc_goodHorseIcon:SetPosX(self._ui._txt_tierValue:GetPosX() - self._ui._stc_goodHorseIcon:GetSizeX())
    local levelEndPosX = self._ui._txt_levelValue:GetPosX() + self._ui._txt_levelValue:GetTextSizeX()
    if levelEndPosX > self._ui._stc_goodHorseIcon:GetPosX() then
      self._ui._txt_levelValue:SetPosX(self._ui._stc_goodHorseIcon:GetPosX() - self._ui._txt_levelValue:GetTextSizeX() - 5)
    end
  else
    self._ui._txt_tierValue:SetShow(false)
    if true == self._isConsole then
      self._ui._console.txt_keyGuideLTY:SetShow(false)
      Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    end
  end
  if CppEnums.VehicleType.Type_Horse == servantWrapper:getVehicleType() or CppEnums.VehicleType.Type_Donkey == servantWrapper:getVehicleType() then
    local myservantinfo = stable_getServantByServantNo(servantWrapper:getServantNo())
    local isRentOwnerFlag = false
    local rentEndTime
    if nil ~= myservantinfo then
      isRentOwnerFlag = Defines.s64_const.s64_0 < myservantinfo:getRentOwnerNo()
      rentEndTime = getTimeYearMonthDayHourMinSecByTTime64(myservantinfo:getRentEndDate())
    end
    if true == isRentOwnerFlag then
      self._ui._stc_maleIcon:SetShow(false)
      self._ui._stc_femaleIcon:SetShow(false)
      self._ui._txt_nameValue:SetShow(false)
      self._ui._txt_rentTime:SetText(tostring(rentEndTime))
      self._ui._txt_rentTime:SetShow(true)
      self._ui._txt_rentTime:SetIgnore(false)
      self._ui._txt_rentTime:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_TextTooltip(" .. self._eTooltipType._rentTime .. ")")
      self._ui._txt_rentTime:addInputEvent("Mouse_Out", "HandleEventOn_VehicleInfo_All_TextTooltip()")
    end
  end
  if true == self._isConsole then
    PaGlobal_VehicleInfo_All:setAlignKeyGuide()
  end
  self:updateStat()
end
function PaGlobal_VehicleInfo_All:updateBasicInfo_rightBg_carriage()
  self._ui._txt_speedTitle:SetShow(true)
  self._ui._txt_accelerationTitle:SetShow(true)
  self._ui._txt_corneringTitle:SetShow(true)
  self._ui._txt_brakeTitle:SetShow(true)
  self._ui._txt_speedValue:SetShow(true)
  self._ui._txt_accelerationValue:SetShow(true)
  self._ui._txt_corneringValue:SetShow(true)
  self._ui._txt_brakeValue:SetShow(true)
  self._ui._stc_goodHorseIcon:SetShow(false)
  self._ui._txt_tierValue:SetShow(false)
  self._ui._txt_rentTime:SetShow(false)
  if true == self._isConsole then
    self._ui._console.txt_keyGuideLTX:SetShow(false)
    self._ui._console.txt_keyGuideLTY:SetShow(false)
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    PaGlobal_VehicleInfo_All:setAlignKeyGuide()
  end
  self:updateStat()
end
function PaGlobal_VehicleInfo_All:updateStat()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_speedValue:SetText(string.format("%.1f", servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) * 1.0E-4) .. "%")
  self._ui._txt_accelerationValue:SetText(string.format("%.1f", servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration) * 1.0E-4) .. "%")
  self._ui._txt_corneringValue:SetText(string.format("%.1f", servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) * 1.0E-4) .. "%")
  self._ui._txt_brakeValue:SetText(string.format("%.1f", servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) * 1.0E-4) .. "%")
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo(viewType)
  self:updateSpecialInfo_leftBg(viewType)
  self:updateSpecialInfo_rightBg(viewType)
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_leftBg(viewType)
  if self._eViewType._normal == viewType then
    self:updateSpecialInfo_leftBg_normal()
  elseif self._eViewType._carriage == viewType then
    self:updateSpecialInfo_leftBg_carriage()
  end
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_leftBg_normal()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_deadCountTitle:SetShow(true)
  self._ui._txt_deadCount:SetShow(true)
  local deadCount = servantWrapper:getDeadCount()
  local deadCountText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_DEADCOUNT")
  if __eVehicleType_Elephant == servantWrapper:getVehicleType() then
    deadCountText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDSERVANTINFO_INJURY")
    deadCount = deadCount * 10 .. "%"
  end
  self._ui._txt_deadCountTitle:SetText(deadCountText)
  self._ui._txt_deadCount:SetText(deadCount)
  if __eVehicleType_Elephant == servantWrapper:getVehicleType() then
    self._ui._txt_matingCountTitle:SetShow(false)
    self._ui._txt_matingCount:SetShow(false)
  elseif 9 ~= servantWrapper:getTier() then
    self._ui._txt_matingCountTitle:SetShow(true)
    self._ui._txt_matingCount:SetShow(true)
    self._ui._txt_matingCount:SetText(servantWrapper:getMatingCount())
  else
    self._ui._txt_matingCountTitle:SetShow(false)
    self._ui._txt_matingCount:SetShow(false)
  end
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_leftBg_carriage()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_deadCountTitle:SetShow(true)
  self._ui._txt_deadCount:SetShow(true)
  self._ui._txt_matingCountTitle:SetShow(false)
  self._ui._txt_matingCount:SetShow(false)
  self._ui._txt_deadCountTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CARRIAGEINFO_DEADCOUNT"))
  self._ui._txt_deadCount:SetText(servantWrapper:getDeadCount())
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_rightBg(viewType)
  if self._eViewType._normal == viewType then
    self:updateSpecialInfo_rightBg_normal()
  elseif self._eViewType._carriage == viewType then
    self:updateSpecialInfo_rightBg_carriage()
  end
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_rightBg_normal()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_remainPeriodTitle:SetShow(false)
  self._ui._txt_remainPeriod:SetShow(false)
  self._ui._txt_suspensionTitle:SetShow(false)
  self._ui._txt_suspensionValue:SetShow(false)
  self._ui._txt_sealTitle:SetShow(true)
  self._ui._txt_sealValue:SetShow(true)
  if __eVehicleType_Elephant ~= servantWrapper:getVehicleType() then
    if servantWrapper:isPeriodLimit() then
      self._ui._txt_remainPeriod:SetText(convertStringFromDatetime(servantWrapper:getExpiredTime()))
      self._ui._txt_remainPeriod:SetShow(true)
    else
      self._ui._txt_remainPeriod:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
      self._ui._txt_remainPeriod:SetShow(true)
    end
    if true == self._ui._txt_remainPeriod:GetShow() then
      self._ui._txt_remainPeriodTitle:SetShow(true)
      self._ui._txt_remainPeriodTitle:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui._txt_remainPeriodTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFE"))
      if true == self._ui._txt_remainPeriodTitle:IsLimitText() then
        self._ui._txt_remainPeriodTitle:SetIgnore(false)
        self._ui._txt_remainPeriodTitle:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_TextTooltip(" .. self._eTooltipType._remainTime .. ")")
        self._ui._txt_remainPeriodTitle:addInputEvent("Mouse_Out", "HandleEventOut_VehicleInfo_All_TextTooltip()")
      end
    end
  else
    self._ui._txt_sealTitle:SetShow(false)
    self._ui._txt_sealValue:SetShow(false)
  end
  if true == servantWrapper:isImprint() then
    self._ui._txt_sealValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTING"))
  else
    self._ui._txt_sealValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTPOSSIBLE"))
  end
end
function PaGlobal_VehicleInfo_All:updateSpecialInfo_rightBg_carriage()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_remainPeriodTitle:SetShow(false)
  self._ui._txt_remainPeriod:SetShow(false)
  self._ui._txt_suspensionTitle:SetShow(true)
  self._ui._txt_suspensionValue:SetShow(true)
  self._ui._txt_sealTitle:SetShow(false)
  self._ui._txt_sealValue:SetShow(false)
  self._ui._txt_suspensionValue:SetText(servantWrapper:getSuspension())
end
function PaGlobal_VehicleInfo_All:updateInventory()
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  if nil ~= vehicleActor:getInventory() then
    self._inventory._config.contentsCount = vehicleActor:getInventory():size() - self._inventory._useStartSlot
    self._inventory._config.count = math.min(self._inventory._config.contentsCount, self._inventory._config.CONST_COUNT)
    UIScroll.SetButtonSize(self._ui._scroll_vertical, self._inventory._config.count, self._inventory._config.contentsCount)
    self:updateInventorySlot()
  end
end
function PaGlobal_VehicleInfo_All:updateInventorySlot()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local config = self._inventory._config
  for ii = 0, config.CONST_COUNT - 1 do
    self._inventory._invenSlotBG[ii]:SetShow(false)
  end
  for ii = 0, config.count - 1 do
    local slotIndex = ii + self._inventory._startInvenSlotIndex
    local slotNo = self._inventory._useStartSlot + slotIndex
    if nil ~= self._inventory._invenSlotBG[ii] and slotIndex < config.contentsCount then
      self._inventory._invenSlotBG[ii]:SetShow(true)
      self._inventory._invenItemSlots[ii]:clearItem()
      if self._isConsole then
        self._inventory._invenSlotBG[ii]:addInputEvent("Mouse_On", "HandleEventRUp_VehicleInfo_All_VehicleInvenTooltip_ForConsole( " .. slotNo .. ")")
      end
      local itemWrapper = getServantInventoryItemBySlotNo(self._actorKeyRaw, slotNo)
      if nil ~= itemWrapper then
        self._inventory._invenItemSlots[ii]:setItem(itemWrapper)
        self._inventory._invenItemSlots[ii].icon:SetShow(true)
        if false == self._isConsole then
          self._inventory._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",true, " .. ii .. ")")
          self._inventory._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",false," .. ii .. ")")
          Panel_Tooltip_Item_SetPosition(slotNo, self._inventory._invenItemSlots[ii], "servant_inventoryView")
        end
        self._inventory._invenItemSlots[ii].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_VehicleInfo_All_InvenSlotRClick(" .. slotNo .. ")")
      else
        self._inventory._invenItemSlots[ii].icon:SetShow(false)
      end
    end
  end
end
function PaGlobal_VehicleInfo_All:createInventorySlot()
  local config = self._inventory._config
  config.row = math.floor(config.CONST_COUNT / config.col)
  for ii = 0, config.CONST_COUNT - 1 do
    self._inventory._invenSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui._stc_inventoryBG, "Static_VehicleInventorySlot", self._ui._stc_inventoryBG, "Static_ShipInvenSlot_" .. ii)
    self._inventory._invenSlotBG[ii]:SetPosX(config.startPos + (config.size + config.gap) * (ii % config.col))
    self._inventory._invenSlotBG[ii]:SetPosY(config.startPos + (config.size + config.gap) * math.floor(ii / config.col))
    if false == self._isConsole then
      self._inventory._invenSlotBG[ii]:SetIgnore(true)
    end
    self._inventory._invenSlotBG[ii]:SetShow(false)
    local slot = {}
    SlotItem.new(slot, "slot_Inventory" .. ii, ii, self._inventory._invenSlotBG[ii], self._inventory._SlotConfig)
    slot:createChild()
    UIScroll.InputEventByControl(slot.icon, "HandlerEventScroll_VehicleInfo_All_InventoryScroll")
    self._inventory._invenItemSlots[ii] = slot
  end
end
function PaGlobal_VehicleInfo_All:updateEquipInfo(viewType)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  self:updateEquipSlotDataFromLib(viewType)
  for k, v in pairs(self._equipConfig._equipSlot) do
    v:clearItem()
  end
  if self._eViewType._normal == viewType then
    self:updateEquipInfo_data(viewType, self._equipConfig._horse)
  elseif self._eViewType._carriage == viewType then
    self:updateEquipInfo_data(viewType, self._equipConfig._carriage)
  end
end
function PaGlobal_VehicleInfo_All:updateEquipInfo_data(viewType, slotNoList)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._extendedSlotInfoArray = {}
  local _extendedCount = 0
  local VehicleType = servantWrapper:getVehicleType()
  for index, value in pairs(slotNoList) do
    local slot = self._equipConfig._equipSlot[value._index]
    local itemWrapper = servantWrapper:getEquipItem(value._index)
    if nil ~= itemWrapper then
      _extendedCount = _extendedCount + self:getExtendedSlotCountUpdateInfo(itemWrapper, value._index)
      self:setItemInfoUseWrapper(slot, itemWrapper, false, false, value._index)
      self._ui._stc_equipIcon[value._index]:SetShow(false)
      slot.icon:SetIgnore(false)
    else
      slot:clearItem()
      slot.icon:SetIgnore(true)
      self._ui._stc_equipIcon[value._index]:SetShow(true)
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_equipIcon[value._index], value._iconUV.x1, value._iconUV.y1, value._iconUV.x2, value._iconUV.y2)
      self._ui._stc_equipIcon[value._index]:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._stc_equipIcon[value._index]:setRenderTexture(self._ui._stc_equipIcon[value._index]:getBaseTexture())
    end
    if self._eViewType._normal == viewType and CppEnums.VehicleType.Type_Elephant ~= VehicleType and self._horseShoesIndex ~= value._index then
      self._ui._chk_equipShow[value._index]:SetShow(true)
      if self._isConsole then
        self._ui._stc_equipSlot[value._index]:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_VehicleInfo_All_EquipShow(" .. value._index .. ")")
        self._ui._stc_equipSlot[value._index]:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_SetKeyGuideY( true )")
        self._ui._stc_equipSlot[value._index]:addInputEvent("Mouse_Out", "HandleEventOn_VehicleInfo_All_SetKeyGuideY( false )")
      else
        self._ui._chk_equipShow[value._index]:addInputEvent("Mouse_LUp", "HandleEventLUp_VehicleInfo_All_EquipShow(" .. value._index .. ")")
      end
    end
    self._ui._stc_equipSlot[value._index]:SetShow(true)
  end
  if 0 < _extendedCount then
    for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = servantWrapper:getEquipItem(parentSlotNo)
      slot = self._equipConfig._equipSlot[extendSlotNo]
      self._ui._stc_equipSlot[extendSlotNo]:SetShow(true)
      self:setItemInfoUseWrapper(slot, itemWrapper, true, true)
      slot.icon:SetIgnore(false)
    end
  end
end
function PaGlobal_VehicleInfo_All:createEquipSlot()
  self:createEquipSlot_data(self._equipConfig._horse)
  self:createEquipSlot_data(self._equipConfig._carriage)
  self:checkButtonDepth()
end
function PaGlobal_VehicleInfo_All:createEquipSlot_data(slotNoList)
  for index, value in pairs(slotNoList) do
    if nil == self._equipConfig._equipSlot[value._index] then
      local slot = {}
      SlotItem.new(slot, "ServantInfoEquipment_" .. value._index, value._index, self._ui._stc_equipSlotGroup, self._equipConfig._config)
      slot:createChild()
      if false == self._isConsole then
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_VehicleInfo_All_EquipItemRClick(" .. value._index .. ")")
      end
      slot.icon:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_EquipItemTooltip(" .. value._index .. ", true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_VehicleInfo_All_EquipItemTooltip(" .. value._index .. ", false)")
      Panel_Tooltip_Item_SetPosition(value._index, slot, "ServantEquipment")
      self._equipConfig._equipSlot[value._index] = slot
    end
  end
end
function PaGlobal_VehicleInfo_All:checkButtonDepth()
  for k, v in pairs(self._equipConfig._slotIds) do
    self._ui._stc_equipSlotGroup:AddChild(self._ui._chk_equipShowLib[k])
    self._ui._stc_equipSlotLib[k]:RemoveControl(self._ui._chk_equipShowLib[k])
    self._ui._chk_equipShowLib[k]:SetPosX(self._ui._stc_equipSlotLib[k]:GetPosX() + self._ui._stc_equipSlotLib[k]:GetSizeX() * 0.5 + 2)
    self._ui._chk_equipShowLib[k]:SetPosY(self._ui._stc_equipSlotLib[k]:GetPosY() + self._ui._stc_equipSlotLib[k]:GetSizeY() * 0.5 + 5)
  end
end
function PaGlobal_VehicleInfo_All:updateEquipSlotDataFromLib(viewType)
  if self._eViewType._normal == viewType then
    self:updateEquipSlotDataFromLib_data(self._equipConfig._horse)
  elseif self._eViewType._carriage == viewType then
    self:updateEquipSlotDataFromLib_data(self._equipConfig._carriage)
  end
end
function PaGlobal_VehicleInfo_All:updateEquipSlotDataFromLib_data(slotNoList)
  self._ui._stc_equipSlot = {}
  self._ui._chk_equipShow = {}
  self._ui._stc_equipIcon = {}
  for k, v in pairs(self._ui._stc_equipSlotLib) do
    self._ui._stc_equipSlotLib[k]:SetShow(false)
    self._ui._chk_equipShowLib[k]:SetShow(false)
    self._ui._stc_equipIconLib[k]:SetShow(false)
  end
  for k, value in pairs(self._equipConfig._equipSlot) do
    value.icon:SetShow(false)
  end
  for index, value in pairs(slotNoList) do
    self._ui._stc_equipSlot[value._index] = self._ui._stc_equipSlotLib[value._slotNo]
    self._ui._chk_equipShow[value._index] = self._ui._chk_equipShowLib[value._slotNo]
    self._ui._stc_equipIcon[value._index] = self._ui._stc_equipIconLib[value._slotNo]
    self._equipConfig._equipSlot[value._index].icon:SetPosX(self._ui._stc_equipSlot[value._index]:GetPosX())
    self._equipConfig._equipSlot[value._index].icon:SetPosY(self._ui._stc_equipSlot[value._index]:GetPosY())
    self._equipConfig._equipSlot[value._index].icon:SetShow(true)
  end
end
function PaGlobal_VehicleInfo_All:getExtendedSlotCountUpdateInfo(itemWrapper, SlotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local slotNoMax = itemSSW:getExtendedSlotCount()
  local _extendedCount = 0
  for index = 1, slotNoMax do
    local extendSlotNo = itemSSW:getExtendedSlotIndex(index - 1)
    if slotNoMax ~= extendSlotNo then
      self._extendedSlotInfoArray[extendSlotNo] = SlotNo
      _extendedCount = _extendedCount + 1
    end
  end
  return _extendedCount
end
function PaGlobal_VehicleInfo_All:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  slot.icon:SetEnable(false == isExtended)
  slot.icon:SetMonoTone(isMono)
end
function PaGlobal_VehicleInfo_All:initSkillList()
  self:initSkillListData(self._ui._list2_horseSkillList)
  self:initSkillListData(self._ui._list2_carriageSkillList)
end
function PaGlobal_VehicleInfo_All:initSkillListData(list2Control)
  list2Control:getElementManager():clearKey()
  local vScroll = list2Control:GetVScroll()
  vScroll:SetControlPos(0)
  list2Control:setCurrenttoIndex(0)
end
function PaGlobal_VehicleInfo_All:updateSkillInfo(viewType)
  self._ui._list2_carriageSkillList:SetShow(false)
  self._ui._list2_horseSkillList:SetShow(false)
  self._ui._stc_horseSkillListBG:SetShow(false)
  self._ui._list2_horseList:SetShow(false)
  self._ui._txt_linkedHorseTitle:SetShow(false)
  self._ui._txt_linkedHorseValue:SetShow(false)
  if self._eViewType._normal == viewType then
    self:updateSkillInfo_normal()
    self._ui._stc_horseSkillListBG:SetShow(true)
  elseif self._eViewType._carriage == viewType then
    self:updateSkillInfo_carriage()
  end
end
function PaGlobal_VehicleInfo_All:updateSkillInfo_normal()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_skillTitle:SetShow(true)
  self:updateSkill(self._ui._list2_horseSkillList, self._ui._txt_horseNoSkill, true)
end
function PaGlobal_VehicleInfo_All:updateSkillInfo_carriage()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_skillTitle:SetShow(false)
  self:updateSkill(self._ui._list2_carriageSkillList, self._ui._txt_carriageNoSkill, true)
  self:updateHorse()
end
function PaGlobal_VehicleInfo_All:updateSkill(list2Control, noSkillControl, isNoSkillHide)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  list2Control:SetShow(true)
  local vScroll = list2Control:GetVScroll()
  local vScrollValue = vScroll:GetControlPos()
  local toIndex = list2Control:getCurrenttoIndex()
  local skillCount = servantWrapper:getSkillCount()
  local listCount = 0
  self._skillIndexList = {}
  list2Control:getElementManager():clearKey()
  for ii = 1, skillCount do
    local skillWrapper = servantWrapper:getSkill(ii)
    if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
      listCount = listCount + 1
      self._skillIndexList[listCount] = ii
      list2Control:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  noSkillControl:SetShow(0 == listCount)
  if true == isNoSkillHide and 0 == listCount then
    list2Control:SetShow(false)
  else
    vScroll:SetControlPos(vScrollValue)
    list2Control:setCurrenttoIndex(toIndex)
  end
  self._ui._txt_skillTitle:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SKILLCOUNT", "servantSkillListCnt", listCount))
end
function PaGlobal_VehicleInfo_All:updateHorse()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self._ui._txt_linkedHorseTitle:SetShow(true)
  self._ui._txt_linkedHorseValue:SetShow(true)
  self._ui._list2_horseList:SetShow(true)
  local currentLinkCount = servantWrapper:getCurrentLinkCount()
  local servantCount = servantWrapper:getLinkCount()
  local listCount = 0
  self._ui._list2_horseList:getElementManager():clearKey()
  for ii = 0, servantCount - 1 do
    local sInfo = stable_getServantFromOwnerServant(servantWrapper:getServantNo(), ii)
    if nil ~= sInfo then
      listCount = listCount + 1
      self._horseIndexList[listCount] = ii
      self._ui._list2_horseList:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
  self._ui._txt_noHorse:SetShow(0 == listCount)
  self._ui._txt_linkedHorseValue:SetText("( " .. currentLinkCount .. " / " .. servantCount .. " )")
end
function PaGlobal_VehicleInfo_All:updateSkillList(control, key)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local index = Int64toInt32(key)
  local skillWrapper = servantWrapper:getSkill(self._skillIndexList[index])
  if nil == skillWrapper then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_VehicleSkillBG")
  local chk_skillLockIcon = UI.getChildControl(stc_skillBG, "CheckButton_SkillLockIcon")
  local progress_skillExp = UI.getChildControl(stc_BG, "CircularProgress_SkillExp")
  local txt_skillName = UI.getChildControl(stc_BG, "StaticText_VehicleName")
  local txt_skillDesc = UI.getChildControl(stc_BG, "StaticText_VehicleCost")
  local stc_warning = UI.getChildControl(stc_BG, "Static_Warning")
  local txt_skillPercent = UI.getChildControl(stc_BG, "StaticText_SkillPercent")
  txt_skillName:SetText(skillWrapper:getName())
  txt_skillDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_skillDesc:SetText(skillWrapper:getDescription())
  stc_skillBG:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
  stc_skillBG:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_SkillTooltip(true, " .. index .. ")")
  stc_skillBG:addInputEvent("Mouse_Out", "HandleEventOn_VehicleInfo_All_SkillTooltip(false)")
  local expRate = servantWrapper:getSkillExp(self._skillIndexList[index]) / (skillWrapper:getMaxExp() / 100)
  if 100 <= expRate then
    expRate = 100
  end
  progress_skillExp:SetProgressRate(expRate)
  progress_skillExp:SetAniSpeed(0)
  txt_skillPercent:SetText(tonumber(string.format("%.0f", expRate)) .. "%")
  if "" ~= skillWrapper:getConditionDescription() then
    stc_warning:SetShow(true)
    stc_warning:addInputEvent("Mouse_On", "HandleEventOn_VehicleInfo_All_WarningTooltip(true, " .. index .. ")")
    stc_warning:addInputEvent("Mouse_Out", "HandleEventOn_VehicleInfo_All_WarningTooltip(false)")
  else
    stc_warning:SetShow(false)
  end
  if true == _ContentsGroup_ServantSkill_Lock and false == servantWrapper:isGuildServant() then
    local skillKey = skillWrapper:getKey()
    local servantType = servantWrapper:getServantType()
    if ToClient_checkCanBlockVehicleSkillCommand(skillKey) then
      chk_skillLockIcon:SetShow(true)
      chk_skillLockIcon:SetCheck(ToClient_isBlockVehicleSkillCommand(skillKey, servantType))
      chk_skillLockIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VehicleInfo_All_ServantSkillLock(" .. index .. ")")
    else
      chk_skillLockIcon:SetShow(false)
    end
  else
    chk_skillLockIcon:SetShow(false)
  end
end
function PaGlobal_VehicleInfo_All:updateServantSkillLock(index)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSkill(self._skillIndexList[index])
  if nil == skillWrapper then
    return
  end
  local skillList = self:getSkillList()
  local key = skillList:getKeyByIndex(index - 1)
  if -1 == key then
    index = index + 1
    key = skillList:getKeyByIndex(index - 1)
  end
  local control = skillList:GetContentByKey(key)
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_VehicleSkillBG")
  local chk_skillLockIcon = UI.getChildControl(stc_skillBG, "CheckButton_SkillLockIcon")
  local isCheck = chk_skillLockIcon:IsCheck()
  if true == isCheck then
    ToClient_blockVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  else
    ToClient_enableVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  end
end
function PaGlobal_VehicleInfo_All:updateHorseList(control, key)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local index = Int64toInt32(key)
  local servantInfo = stable_getServantFromOwnerServant(servantWrapper:getServantNo(), self._horseIndexList[index])
  if nil == servantInfo then
    return
  end
  local btn_carriageHorse = UI.getChildControl(control, "Button_CarriageHorse")
  local stc_horseIcon = UI.getChildControl(btn_carriageHorse, "Static_HorseImage")
  local txt_horseName = UI.getChildControl(btn_carriageHorse, "StaticText_HorseName")
  local txt_horseTier = UI.getChildControl(btn_carriageHorse, "StaticText_HorseTier")
  local txt_horseExp = UI.getChildControl(btn_carriageHorse, "StaticText_HorseExp")
  local progress_Exp = UI.getChildControl(btn_carriageHorse, "Progress2_HorseExp")
  stc_horseIcon:ChangeTextureInfoName(servantInfo:getIconPath1())
  txt_horseName:SetText("<PAColor0xFFF5BA3A> Lv." .. servantInfo:getLevel() .. "<PAOldColor> " .. servantInfo:getName())
  if 9 == servantInfo:getTier() then
    txt_horseTier:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
  else
    txt_horseTier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
  end
  local exp = Int64toInt32(servantInfo:getExp_s64())
  local needexp = Int64toInt32(servantInfo:getNeedExp_s64())
  local exp_percent = 0
  if 0 < exp then
    exp_percent = exp / needexp * 100
  end
  txt_horseExp:SetText(makeDotMoney(exp) .. " / " .. makeDotMoney(needexp))
  progress_Exp:SetProgressRate(exp_percent)
  btn_carriageHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_VehicleInfo_All_LinkedServantSkill(" .. self._horseIndexList[index] .. ")")
end
function PaGlobal_VehicleInfo_All:updateTitle(viewType)
  if self._eViewType._normal == viewType then
    self._ui._txt_titleIconServant:SetShow(true)
    self._ui._txt_titleIconCarriage:SetShow(false)
  elseif self._eViewType._carriage == viewType then
    self._ui._txt_titleIconServant:SetShow(false)
    self._ui._txt_titleIconCarriage:SetShow(true)
  end
end
function PaGlobal_VehicleInfo_All:isCheckNormal(vehicleType)
  if __eVehicleType_Horse == vehicleType or __eVehicleType_Camel == vehicleType or __eVehicleType_Donkey == vehicleType or __eVehicleType_Elephant == vehicleType or __eVehicleType_Ridable_BabyElephant == vehicleType or __eVehicleType_RaceHorse == vehicleType then
    return true
  end
  return false
end
function PaGlobal_VehicleInfo_All:isCheckCarriage(vehicleType)
  if __eVehicleType_Carriage == vehicleType or __eVehicleType_CowCarriage == vehicleType or __eVehicleType_Tank == vehicleType or __eVehicleType_RepairableCarriage == vehicleType then
    return true
  end
  return false
end
function PaGlobal_VehicleInfo_All:isCheckShip(vehicleType)
  if __eVehicleType_Boat == vehicleType or __eVehicleType_Raft == vehicleType or __eVehicleType_FishingBoat == vehicleType or __eVehicleType_FastShip == vehicleType then
    return true
  end
  return false
end
function PaGlobal_VehicleInfo_All:isCheckBigShip(vehicleType)
  if __eVehicleType_GalleyShip == vehicleType or __eVehicleType_PersonalBattleShip == vehicleType or __eVehicleType_PersonalTradeShip == vehicleType or __eVehicleType_PersonalBoat == vehicleType or __eVehicleType_CashPersonalTradeShip == vehicleType or __eVehicleType_CashPersonalBattleShip == vehicleType or __eVehicleType_Carrack == vehicleType then
    return true
  end
  return false
end
function PaGlobal_VehicleInfo_All:getSkillList()
  if self._eViewType._normal == self._viewType then
    return self._ui._list2_horseSkillList
  elseif self._eViewType._carriage == self._viewType then
    return self._ui._list2_carriageSkillList
  end
  return nil
end
function PaGlobal_VehicleInfo_All:updateKeyGuideString(isStallion)
  if true == isStallion then
    self._ui._console.txt_keyGuideLTX:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONNAME"))
  else
    self._ui._console.txt_keyGuideLTX:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_NOTSTALLIONICONNAME"))
  end
  PaGlobal_VehicleInfo_All:setAlignKeyGuide()
end
function PaGlobal_VehicleInfo_All:setAlignKeyGuide()
  if false == self._isConsole then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui._console._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
