function PaGlobal_AlchemyStone_All:initialize()
  if true == PaGlobal_AlchemyStone_All._initialize then
    return
  end
  PaGlobal_AlchemyStone_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_AlchemyStone_All:ControlAll_Init()
  PaGlobal_AlchemyStone_All:ControlPc_Init()
  PaGlobal_AlchemyStone_All:ControlConsole_Init()
  PaGlobal_AlchemyStone_All:ControlSetShow()
  PaGlobal_AlchemyStone_All:registEventHandler()
  PaGlobal_AlchemyStone_All:validate()
  PaGlobal_AlchemyStone_All._initialize = true
end
function PaGlobal_AlchemyStone_All:ControlAll_Init()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "StaticText_Title")
  self._ui.stc_radioGroup = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RadioGroup")
  self._ui.radio_Charge = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Tab_Charge")
  self._ui.radio_Exp = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Tab_Exp")
  self._ui.radio_Upgrade = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Tab_Upgrade")
  self._ui.radio_RandomOption = UI.getChildControl(self._ui.stc_radioGroup, "RadioButton_Tab_RandomOption")
  self._ui.stc_radioSelectBar = UI.getChildControl(self._ui.stc_radioGroup, "Static_SelectBar")
  self._ui.stc_guideBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_GuideBG")
  self._ui.txt_guideNormal = UI.getChildControl(self._ui.stc_guideBg, "StaticText_NormalText")
  self._ui.txt_guideSuccess = UI.getChildControl(self._ui.stc_guideBg, "StaticText_GrowthSuccess")
  self._ui.txt_guideFail = UI.getChildControl(self._ui.stc_guideBg, "StaticText_GrowthFail")
  self._ui.txt_needMetarial = UI.getChildControl(Panel_Window_AlchemyStone_All, "StaticText_NeedMaterialType")
  self._ui.stc_descDetailBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_DescBG")
  self._ui.txt_descDetail = UI.getChildControl(self._ui.stc_descDetailBg, "StaticText_Desc")
  self._ui.stc_tooltipOptionBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_TooltipOptionList")
  self._ui.txt_tooltipOptionTitle = UI.getChildControl(self._ui.stc_tooltipOptionBg, "StaticText_TooltipTitle")
  self._ui.stc_tooltipOptionListBg = UI.getChildControl(self._ui.stc_tooltipOptionBg, "Static_ListBG")
  self._ui.txt_tooltipOption = UI.getChildControl(self._ui.stc_tooltipOptionListBg, "StaticText_OptionText")
  self._ui.stc_CenterEffect = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_CenterEffect")
  self._ui._recharge.stc_rechargeBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RechargeBG")
  self._ui._recharge.stc_slotLeftBg = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "Static_Slot_Stone_BG")
  self._ui._recharge.stc_slotLeft = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "Static_Slot_Left")
  self._ui._recharge.stc_slotRight = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "Static_Slot_Right")
  self._ui._recharge.txt_chargeDesc = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "StaticText_Charge_Desc")
  self._ui._recharge.txt_needCount = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "StaticText_NeedCountTitle")
  self._ui._recharge.stc_gaugeEnduranceBg = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "Static_GaugeBG_1")
  self._ui._recharge.progress_preEndurance = UI.getChildControl(self._ui._recharge.stc_gaugeEnduranceBg, "Progress2_Endurance_Gauge_1_PreView")
  self._ui._recharge.progress_curEndurance = UI.getChildControl(self._ui._recharge.stc_gaugeEnduranceBg, "Progress2_Endurance_Gauge_1")
  self._ui._recharge.txt_endurance = UI.getChildControl(self._ui._recharge.stc_gaugeEnduranceBg, "StaticText_Endurance")
  self._ui._recharge.stc_gaugeExpBg = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "Static_GaugeBG_2")
  self._ui._recharge.progress_preExp = UI.getChildControl(self._ui._recharge.stc_gaugeExpBg, "Progress2_Exp_Gauge_1_PreView")
  self._ui._recharge.progress_curExp = UI.getChildControl(self._ui._recharge.stc_gaugeExpBg, "Progress2_Exp_Gauge_1")
  self._ui._recharge.txt_expTitle = UI.getChildControl(self._ui._recharge.stc_gaugeExpBg, "StaticText_EXP_Title")
  self._ui._recharge.txt_expValue = UI.getChildControl(self._ui._recharge.stc_gaugeExpBg, "StaticText_EXP_Value")
  self._ui._recharge.txt_materialName = UI.getChildControl(self._ui._recharge.stc_rechargeBg, "StaticText_Material")
  self._ui._growth.stc_growthBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_GrowthBG")
  self._ui._growth.stc_slotBg_1 = UI.getChildControl(self._ui._growth.stc_growthBg, "Static_Slot_1_BG")
  self._ui._growth.stc_slotItemBG = UI.getChildControl(self._ui._growth.stc_growthBg, "Static_Slot_ItemBG")
  self._ui._growth.stc_slot_1 = UI.getChildControl(self._ui._growth.stc_slotItemBG, "Static_Slot_1")
  self._ui._growth.stc_slot_2 = UI.getChildControl(self._ui._growth.stc_slotItemBG, "Static_Slot_2")
  self._ui._growth.stc_slotResultBG = UI.getChildControl(self._ui._growth.stc_growthBg, "Static_Slot_ResultBG")
  self._ui._growth.stc_slotBg_3 = UI.getChildControl(self._ui._growth.stc_slotResultBG, "Static_Slot_3_BG")
  self._ui._growth.stc_slot_3 = UI.getChildControl(self._ui._growth.stc_slotBg_3, "Static_Slot_3")
  self._ui._growth.stc_upgradeSlotBg = UI.getChildControl(self._ui._growth.stc_growthBg, "Static_UpgradeSlotBg")
  self._ui._growth.txt_fail = UI.getChildControl(self._ui._growth.stc_growthBg, "StaticText_Result_Fail")
  self._ui._growth.txt_success = UI.getChildControl(self._ui._growth.stc_growthBg, "StaticText_Result_Success")
  self._ui._growth.stc_upgradeEffect = UI.getChildControl(self._ui._growth.stc_growthBg, "Static_UpgradeEffect")
  self._ui._random.stc_randomBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RandomOption")
  self._ui._random.stc_slotBg_1 = UI.getChildControl(self._ui._random.stc_randomBg, "Static_Slot_1_BG")
  self._ui._random.stc_slotBg_2 = UI.getChildControl(self._ui._random.stc_randomBg, "Static_Slot_2_BG")
  self._ui._random.stc_slot_1 = UI.getChildControl(self._ui._random.stc_randomBg, "Static_Slot_1")
  self._ui._random.stc_slot_2 = UI.getChildControl(self._ui._random.stc_randomBg, "Static_Slot_2")
  self._ui._random.txt_randomOption = UI.getChildControl(self._ui._random.stc_randomBg, "StaticText_RandomOption")
  self._ui._random.stc_randomRadioGroup = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RandomOptionSelect")
  self._ui._random.radio_randomOptionSelect_1 = UI.getChildControl(self._ui._random.stc_randomRadioGroup, "RadioButton_Type1")
  self._ui._random.radio_randomOptionSelect_2 = UI.getChildControl(self._ui._random.stc_randomRadioGroup, "RadioButton_Type2")
  self._ui._random.radio_randomOptionSelect_3 = UI.getChildControl(self._ui._random.stc_randomRadioGroup, "RadioButton_Type3")
  self._ui._random.radio_randomOptionSelect_1:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyStone_RandomSelect(" .. 1 .. ")")
  self._ui._random.radio_randomOptionSelect_2:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyStone_RandomSelect(" .. 2 .. ")")
  self._ui._random.radio_randomOptionSelect_3:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyStone_RandomSelect(" .. 3 .. ")")
  self._ui._random.radio_randomOptionSelect_1:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( true, " .. 1 .. ")")
  self._ui._random.radio_randomOptionSelect_2:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( true, " .. 2 .. ")")
  self._ui._random.radio_randomOptionSelect_3:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( true, " .. 3 .. ")")
  self._ui._random.radio_randomOptionSelect_1:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( false, " .. 1 .. ")")
  self._ui._random.radio_randomOptionSelect_2:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( false, " .. 2 .. ")")
  self._ui._random.radio_randomOptionSelect_3:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_RandomOptionStatTooltip( false, " .. 3 .. ")")
  self._ui._random.stc_randomOptionStatTooltip = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_TooltipOptionList")
  self._ui._random.stc_randomOptionStatTooltipTitle = UI.getChildControl(self._ui._random.stc_randomOptionStatTooltip, "StaticText_TooltipTitle")
  self._ui._random.stc_randomOptionStatTooltipBG = UI.getChildControl(self._ui._random.stc_randomOptionStatTooltip, "Static_ListBG")
  self._ui._random.stc_randomOptionStatTooltipText = UI.getChildControl(self._ui._random.stc_randomOptionStatTooltipBG, "StaticText_OptionText")
  self._ui._random.stc_randomOptionStatTooltipAddBG = UI.getChildControl(self._ui._random.stc_randomOptionStatTooltip, "Static_DescBox")
  self._ui._random.stc_randomOptionStatTooltipAddText = UI.getChildControl(self._ui._random.stc_randomOptionStatTooltipAddBG, "StaticText_1")
  self._ui._random.stc_showOption = UI.getChildControl(self._ui._random.stc_randomBg, "Static_ShowRandomOption")
  local randomOptionRadioButtonEnableAreaSizeX, randomOptionRadioButtonEnableAreaSizeY
  randomOptionRadioButtonEnableAreaSizeX = self._ui._random.radio_randomOptionSelect_1:GetSizeX() + self._ui._random.radio_randomOptionSelect_1:GetTextSizeX()
  randomOptionRadioButtonEnableAreaSizeY = self._ui._random.radio_randomOptionSelect_1:GetSizeY()
  self._ui._random.radio_randomOptionSelect_1:SetEnableArea(0, 0, randomOptionRadioButtonEnableAreaSizeX + 20, randomOptionRadioButtonEnableAreaSizeY)
  randomOptionRadioButtonEnableAreaSizeX = self._ui._random.radio_randomOptionSelect_2:GetSizeX() + self._ui._random.radio_randomOptionSelect_2:GetTextSizeX()
  randomOptionRadioButtonEnableAreaSizeY = self._ui._random.radio_randomOptionSelect_2:GetSizeY()
  self._ui._random.radio_randomOptionSelect_2:SetEnableArea(0, 0, randomOptionRadioButtonEnableAreaSizeX + 20, randomOptionRadioButtonEnableAreaSizeY)
  randomOptionRadioButtonEnableAreaSizeX = self._ui._random.radio_randomOptionSelect_3:GetSizeX() + self._ui._random.radio_randomOptionSelect_3:GetTextSizeX()
  randomOptionRadioButtonEnableAreaSizeY = self._ui._random.radio_randomOptionSelect_3:GetSizeY()
  self._ui._random.radio_randomOptionSelect_3:SetEnableArea(0, 0, randomOptionRadioButtonEnableAreaSizeX + 20, randomOptionRadioButtonEnableAreaSizeY)
  local stc_Slot = {
    [0] = self._ui._recharge.stc_slotRight,
    [1] = self._ui._recharge.stc_slotLeft
  }
  local slotName = {
    [0] = "AlchemyAll_Recharge_Stone",
    [1] = "AlchemyAll_Recharge_Result"
  }
  for slotType = 0, 1 do
    SlotItem.new(self._rechargeSlot[slotType], slotName[slotType], 0, stc_Slot[slotType], self._slotConfig)
    self._rechargeSlot[slotType]:createChild()
    self._rechargeSlot[slotType].Empty = true
    self._rechargeSlot[slotType]:clearItem()
    if false == self._isConsole then
      self._rechargeSlot[slotType].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    else
      self._rechargeSlot[slotType].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    end
  end
  stc_Slot = {
    [0] = self._ui._growth.stc_slot_1,
    [1] = self._ui._growth.stc_slot_2
  }
  slotName = {
    [0] = "AlchemyAll_Growth_Stone",
    [1] = "AlchemyAll_Growth_Material"
  }
  for slotType = 0, 1 do
    SlotItem.new(self._growthSlot[slotType], slotName[slotType], 0, stc_Slot[slotType], self._slotConfig)
    self._growthSlot[slotType]:createChild()
    self._growthSlot[slotType].Empty = true
    self._growthSlot[slotType]:clearItem()
    if false == self._isConsole then
      self._growthSlot[slotType].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    else
      self._growthSlot[slotType].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    end
  end
  local stc_Slot = {
    [0] = self._ui._random.stc_slot_1,
    [1] = self._ui._random.stc_slot_2
  }
  local slotName = {
    [0] = "AlchemyAll_Random_StoneL",
    [1] = "AlchemyAll_Random_StoneR"
  }
  for slotType = 0, 1 do
    SlotItem.new(self._randomSlot[slotType], slotName[slotType], 0, stc_Slot[slotType], self._slotConfig)
    self._randomSlot[slotType]:createChild()
    self._randomSlot[slotType].Empty = true
    self._randomSlot[slotType]:clearItem()
    if false == self._isConsole then
      self._randomSlot[slotType].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    else
      self._randomSlot[slotType].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_AlchemyStone_UnSetSlot(" .. slotType .. ")")
    end
  end
  for index = 1, __eMaxItemOptionCount do
    local control = UI.createControl(__ePAUIControl_StaticText, PaGlobal_AlchemyStone_All._ui._random.stc_randomBg, "Static_RandomOption_" .. tostring(index))
    PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetText("")
    CopyBaseProperty(PaGlobal_AlchemyStone_All._ui._random.txt_randomOption, control)
    PaGlobal_AlchemyStone_All._randomOptionText[index] = control
    PaGlobal_AlchemyStone_All._randomOptionText[index]:SetShow(false)
  end
  local controlForEffect = UI.createControl(__ePAUIControl_StaticText, PaGlobal_AlchemyStone_All._ui._random.stc_randomBg, "Static_RandomOption_Effect")
  PaGlobal_AlchemyStone_All._ui._random.txt_randomOption:SetText("")
  CopyBaseProperty(PaGlobal_AlchemyStone_All._ui._random.txt_randomOption, controlForEffect)
  controlForEffect:SetShow(true)
  controlForEffect:ChangeTextureInfoName("")
  controlForEffect:setRenderTexture(controlForEffect:getBaseTexture())
  PaGlobal_AlchemyStone_All._randomOptionTextForEffect = controlForEffect
  self._radioTabs[self._TAB_TYPE.CHARGE] = self._ui.radio_Charge
  self._radioTabs[self._TAB_TYPE.EXP] = self._ui.radio_Exp
  self._radioTabs[self._TAB_TYPE.UPGRADE] = self._ui.radio_Upgrade
  if true == _ContentsGroup_RenewUI then
    self._ui.radio_RandomOption:SetShow(false)
  else
    self._ui.radio_RandomOption:SetShow(true == _ContentsGroup_ItemRandomOption)
    self._radioTabs[self._TAB_TYPE.RANDOMOPTION] = self._ui.radio_RandomOption
  end
  if false == self._ui.radio_RandomOption:GetShow() then
    for idx = 1, #self._radioTabs do
      self._radioTabs[idx]:SetPosX(self._radioTabs[idx]:GetPosX() + self._ui.radio_RandomOption:GetSizeX() / 2)
    end
  end
  self._ui._random.stc_randomOptionStatTooltip:SetShow(false)
  if true == _ContentsGroup_Kamasilvia and true == _ContentsGroup_AlchemyStone then
    self._DESC_TYPE[self._TAB_TYPE.CHARGE] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_4")
  else
    self._DESC_TYPE[self._TAB_TYPE.CHARGE] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_1")
  end
  local temp = {}
  for index = 0, 2 do
    temp[index] = UI.cloneControl(self._ui._growth.stc_slotBg_3, self._ui._growth.stc_slotResultBG, "AlchemyStone_SuccessResultSlot_" .. index)
    CopyBaseProperty(self._ui._growth.stc_slotBg_3, temp[index])
    self._resultSlotBg[index] = temp[index]
    self._resultSlot[index] = {}
    SlotItem.new(self._resultSlot[index], "AlchemyStone_ResultSlot_" .. index, 0, self._resultSlotBg[index], self._slotConfig)
    self._resultSlot[index].icon:SetPosX(4)
    self._resultSlot[index].icon:SetPosY(4)
    self._resultSlot[index]:createChild()
    self._resultSlot[index].Empty = true
  end
  self._ui.txt_descDetail:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_guideNormal:SetTextMode(__eTextMode_AutoWrap)
  self._panel_OriginSizeY = Panel_Window_AlchemyStone_All:GetSizeY()
  self._panel_OriginPosY = Panel_Window_AlchemyStone_All:GetPosY()
  self._descDetailBg_OriginPosY = self._ui.stc_descDetailBg:GetPosY()
  self._descDetailBg_OriginSizeY = self._ui.stc_descDetailBg:GetSizeY()
  self._descDetail_OriginPosY = self._ui.txt_descDetail:GetPosY()
  self._upgradeSlotBg_OriginSizeY = self._ui._growth.stc_upgradeSlotBg:GetSizeY()
  self._upgradeSlotBg_OriginPosY = self._ui._growth.stc_upgradeSlotBg:GetPosY()
  self._ui._recharge.txt_chargeDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", 0))
end
function PaGlobal_AlchemyStone_All:ControlPc_Init()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui_pc.btn_help = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.stc_doitBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_DoitBG")
  self._ui_pc.btn_apply = UI.getChildControl(self._ui_pc.stc_doitBg, "Button_Doit")
  self._doitBg_OriginSizeY = self._ui_pc.stc_doitBg:GetSizeY()
  self._doitBg_OriginPosY = self._ui_pc.stc_doitBg:GetPosY()
  if true == self._isConsole then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_help:SetShow(false)
  end
end
function PaGlobal_AlchemyStone_All:ControlConsole_Init()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui_console.stc_consoleGuideBg = UI.getChildControl(Panel_Window_AlchemyStone_All, "StaticText_ConsoleGuide")
  self._ui_console.stc_guideIconY = UI.getChildControl(self._ui_console.stc_consoleGuideBg, "StaticText_KeyguideY")
  self._ui_console.stc_guideIconX = UI.getChildControl(self._ui_console.stc_consoleGuideBg, "StaticText_ShowDetail")
  self._ui_console.stc_guideIconA = UI.getChildControl(self._ui_console.stc_consoleGuideBg, "StaticText_Confirm")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_consoleGuideBg, "StaticText_Close")
  self._ui.stc_KeyGuideLB = UI.getChildControl(self._ui.stc_radioGroup, "StaticText_LB_ConsoleUI")
  self._ui.stc_KeyGuideRB = UI.getChildControl(self._ui.stc_radioGroup, "StaticText_RB_ConsoleUI")
  self:setKeyGuideAlign()
  self._gGuideBg_OriginPosY = self._ui_console.stc_consoleGuideBg:GetPosY()
  self._guideIconY_OriginPosX = self._ui_console.stc_guideIconX:GetPosX()
  self._guideIconA_OriginPosX = self._ui_console.stc_guideIconA:GetPosX()
  if true == self._isConsole then
    self._ui.stc_KeyGuideLB:SetShow(true)
    self._ui.stc_KeyGuideRB:SetShow(true)
    self._ui_console.stc_consoleGuideBg:SetShow(true)
    self._ui_pc.stc_doitBg:SetShow(false)
    self._ui.stc_descDetailBg:SetPosY(self._doitBg_OriginPosY)
    self._ui.txt_descDetail:SetTextVerticalTop()
    self._ui_console.stc_consoleGuideBg:SetPosY(self._gGuideBg_OriginPosY - self._doitBg_OriginSizeY)
  end
end
function PaGlobal_AlchemyStone_All:ControlSetShow()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui_pc.btn_help:SetShow(false)
end
function PaGlobal_AlchemyStone_All:setKeyGuideAlign()
  local keyGuides = {
    self._ui_console.stc_guideIconY,
    self._ui_console.stc_guideIconX,
    self._ui_console.stc_guideIconA,
    self._ui_console.stc_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_consoleGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_AlchemyStone_All:prepareOpen()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if false == _ContentsGroup_AlchemyStone or nil == _ContentsGroup_AlchemyStone then
    return
  end
  PaGlobalFunc_AlchemyStone_All_PreCheckOtherUI()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  else
    FGlobal_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  end
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:IsUISubApp() then
      Panel_Window_AlchemyStone_All:OpenUISubApp()
    end
  elseif Panel_Window_Inventory:IsUISubApp() then
    Panel_Window_AlchemyStone_All:OpenUISubApp()
  end
  self._preTabType = 1
  self._selectTabType = 1
  self._ui.radio_Charge:SetCheck(true)
  self:selectTab(self._TAB_TYPE.CHARGE)
  self:open()
  if false == self._isConsole then
    if true == _ContentsGroup_NewUI_Equipment_All then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() then
      EquipmentWindow_Close()
    end
    if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
  end
  InventoryWindow_Show()
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
  if nil ~= PaGlobalFunc_PreOrder_Close then
    PaGlobalFunc_PreOrder_Close(Panel_Window_AlchemyStone_All, false)
  end
end
function PaGlobal_AlchemyStone_All:console_OpenInventory()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local isInvenOpen = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if true == isInvenOpen then
    return
  end
  self._ui_console.stc_guideIconA:SetShow(false)
  self._ui_console.stc_guideIconX:SetPosX(self._guideIconA_OriginPosX - 20)
  InventoryWindow_Show()
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function PaGlobal_AlchemyStone_All:open()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  Panel_Window_AlchemyStone_All:SetShow(true)
end
function PaGlobal_AlchemyStone_All:prepareClose()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui.radio_Charge:SetCheck(false)
  self._ui.radio_Exp:SetCheck(false)
  self._ui.radio_Upgrade:SetCheck(false)
  self._ui.radio_RandomOption:SetCheck(false)
  local isInventoryShow = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    isInventoryShow = Panel_Window_Inventory_All:GetShow()
  else
    isInventoryShow = Panel_Window_Inventory:GetShow()
  end
  if Panel_Window_AlchemyStone_All:GetShow() then
    Inventory_SetFunctor(nil, nil, nil, nil)
    if false == self._isConsole then
      if true == _ContentsGroup_NewUI_Equipment_All then
        PaGlobalFunc_Equipment_All_SetShow(isInventoryShow)
      else
        Equipment_SetShow(isInventoryShow)
      end
    elseif true == isInventoryShow then
      InventoryWindow_Close()
    end
  end
  Panel_AlchemyStone_All_EndRandomOptionTextAnimation()
  PaGlobal_AlchemyStone_All:close()
end
function PaGlobal_AlchemyStone_All:close()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  Panel_Window_AlchemyStone_All:SetShow(false)
  Panel_Window_AlchemyStone_All:CloseUISubApp()
end
function PaGlobal_AlchemyStone_All:registEventHandler()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  registerEvent("onScreenResize", "AlchemyStone_onScreenResize")
  registerEvent("FromClient_ItemUpgrade", "FromClient_ItemUpgrade_All")
  registerEvent("FromClient_StoneChange", "FromClient_StoneChange_All")
  registerEvent("FromClient_StoneChangeFailedByDown", "FromClient_StoneChangeFailedByDown_All")
  registerEvent("FromClient_AlchemyEvolve", "FromClient_AlchemyEvolve_All")
  registerEvent("FromClient_AlchemyRepair", "FromClient_AlchemyRepair_All")
  registerEvent("FromClient_RandomOption", "FromClient_RandomOption")
  registerEvent("FromClient_ResponseRandomOptionFail", "FromClient_ResponseRandomOptionFail")
  Panel_Window_AlchemyStone_All:RegisterUpdateFunc("Panel_AlchemyStone_All_UpdateTime")
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_All_Close()")
  self._ui_pc.btn_help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"AlchemyStone\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_help, "\"AlchemyStone\"")
  self._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyStone_Doit()")
  PaGlobal_AlchemyStone_All:Console_InputEvent()
  for idx = 1, #self._radioTabs do
    self._radioTabs[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_AlchemyStone_All_SelectTab(" .. idx .. ")")
  end
end
function PaGlobal_AlchemyStone_All:Console_InputEvent()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if false == self._isConsole then
    return
  end
  Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandlePadEventLBUp_MoveTab(" .. self._DIRECTION.BUTTON_RB .. ")")
  Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandlePadEventLBUp_MoveTab(" .. self._DIRECTION.BUTTON_LB .. ")")
end
function PaGlobal_AlchemyStone_All:Console_MoveTab(direction)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if self._isPushDoit then
    return
  end
  if PaGlobal_AlchemyStone_All._DIRECTION.BUTTON_RB == direction then
    PaGlobal_AlchemyStone_All._selectTabType = PaGlobal_AlchemyStone_All._selectTabType + 1
    if PaGlobal_AlchemyStone_All._selectTabType > 3 then
      PaGlobal_AlchemyStone_All._selectTabType = 1
    end
  else
    PaGlobal_AlchemyStone_All._selectTabType = PaGlobal_AlchemyStone_All._selectTabType - 1
    if PaGlobal_AlchemyStone_All._selectTabType < 1 then
      PaGlobal_AlchemyStone_All._selectTabType = 3
    end
  end
  PaGlobal_AlchemyStone_All._radioTabs[PaGlobal_AlchemyStone_All._preTabType]:SetCheck(false)
  PaGlobal_AlchemyStone_All._radioTabs[PaGlobal_AlchemyStone_All._selectTabType]:SetCheck(true)
  PaGlobal_AlchemyStone_All._preTabType = PaGlobal_AlchemyStone_All._selectTabType
  PaGlobal_AlchemyStone_All:selectTab(PaGlobal_AlchemyStone_All._selectTabType)
end
function PaGlobal_AlchemyStone_All:validate()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_radioGroup:isValidate()
  self._ui.radio_Charge:isValidate()
  self._ui.radio_Exp:isValidate()
  self._ui.radio_Upgrade:isValidate()
  self._ui.radio_RandomOption:isValidate()
  self._ui.stc_radioSelectBar:isValidate()
  self._ui.stc_guideBg:isValidate()
  self._ui.txt_guideNormal:isValidate()
  self._ui.txt_guideSuccess:isValidate()
  self._ui.txt_guideFail:isValidate()
  self._ui.txt_needMetarial:isValidate()
  self._ui.stc_descDetailBg:isValidate()
  self._ui.txt_descDetail:isValidate()
  self._ui.stc_tooltipOptionBg:isValidate()
  self._ui.txt_tooltipOptionTitle:isValidate()
  self._ui.stc_tooltipOptionListBg:isValidate()
  self._ui.txt_tooltipOption:isValidate()
  self._ui.stc_CenterEffect:isValidate()
  self._ui._recharge.stc_rechargeBg:isValidate()
  self._ui._recharge.stc_slotLeftBg:isValidate()
  self._ui._recharge.stc_slotLeft:isValidate()
  self._ui._recharge.stc_slotRight:isValidate()
  self._ui._recharge.txt_chargeDesc:isValidate()
  self._ui._recharge.txt_needCount:isValidate()
  self._ui._recharge.stc_gaugeEnduranceBg:isValidate()
  self._ui._recharge.progress_preEndurance:isValidate()
  self._ui._recharge.progress_curEndurance:isValidate()
  self._ui._recharge.txt_endurance:isValidate()
  self._ui._recharge.stc_gaugeExpBg:isValidate()
  self._ui._recharge.progress_preExp:isValidate()
  self._ui._recharge.progress_curExp:isValidate()
  self._ui._recharge.txt_expTitle:isValidate()
  self._ui._recharge.txt_expValue:isValidate()
  self._ui._recharge.txt_materialName:isValidate()
  self._ui._growth.stc_growthBg:isValidate()
  self._ui._growth.stc_slotBg_1:isValidate()
  self._ui._growth.stc_slot_1:isValidate()
  self._ui._growth.stc_slot_2:isValidate()
  self._ui._growth.stc_slotBg_3:isValidate()
  self._ui._growth.stc_slot_3:isValidate()
  self._ui._growth.stc_upgradeSlotBg:isValidate()
  self._ui._growth.txt_fail:isValidate()
  self._ui._growth.txt_success:isValidate()
  self._ui._growth.stc_upgradeEffect:isValidate()
  self._ui._random.stc_randomBg:isValidate()
  self._ui._random.stc_slotBg_1:isValidate()
  self._ui._random.stc_slotBg_2:isValidate()
  self._ui._random.stc_slot_1:isValidate()
  self._ui._random.stc_slot_2:isValidate()
  self._ui._random.txt_randomOption:isValidate()
  self._ui._random.stc_randomRadioGroup:isValidate()
  self._ui._random.radio_randomOptionSelect_1:isValidate()
  self._ui._random.radio_randomOptionSelect_2:isValidate()
  self._ui._random.radio_randomOptionSelect_3:isValidate()
  self._ui._random.stc_showOption:isValidate()
  self._ui._random.stc_randomOptionStatTooltip:isValidate()
  self._ui._random.stc_randomOptionStatTooltipTitle:isValidate()
  self._ui._random.stc_randomOptionStatTooltipBG:isValidate()
  self._ui._random.stc_randomOptionStatTooltipText:isValidate()
  self._ui._random.stc_randomOptionStatTooltipAddBG:isValidate()
  self._ui._random.stc_randomOptionStatTooltipAddText:isValidate()
end
function PaGlobal_AlchemyStone_All:resize()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  Panel_Window_AlchemyStone_All:ComputePos()
  if self._isConsole then
    Panel_Window_AlchemyStone_All:SetPosY(self._panel_OriginPosY - self._ui_console.stc_consoleGuideBg:GetSizeY())
  end
end
function PaGlobal_AlchemyStone_All:selectTab(tabType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._selectedTabIdx = tabType
  PaGlobal_AlchemyStone_All:clearSetShow()
  PaGlobal_AlchemyStone_All:clearData(false)
  if self._TAB_TYPE.CHARGE == tabType then
    self._ui._recharge.stc_rechargeBg:SetShow(true)
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_CHARGE"))
  elseif self._TAB_TYPE.EXP == tabType then
    self._ui._recharge.stc_rechargeBg:SetShow(true)
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_EXP"))
  elseif self._TAB_TYPE.UPGRADE == tabType then
    self._ui._growth.stc_slotBg_3:SetShow(true)
    self._ui._growth.stc_growthBg:SetShow(true)
    self._ui._growth.stc_upgradeSlotBg:SetPosY(self._upgradeSlotBg_OriginPosY)
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMYSTONE_BTN_UPGRADE"))
  elseif self._TAB_TYPE.RANDOMOPTION == tabType then
    self._ui._random.stc_randomBg:SetShow(true)
    self._ui_console.stc_guideIconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMISTONE_ALL_RANDOMOPTION"))
  end
  local keyGuides = {
    self._ui_console.stc_guideIconY,
    self._ui_console.stc_guideIconX,
    self._ui_console.stc_guideIconA,
    self._ui_console.stc_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_consoleGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  local tabPosX = self._radioTabs[tabType]:GetPosX()
  local tabSizeX = self._radioTabs[tabType]:GetSizeX()
  local barPosX = tabPosX + tabSizeX / 2 - self._ui.stc_radioSelectBar:GetSizeX() / 2
  self._ui.stc_radioSelectBar:SetPosX(barPosX)
  self._ui.txt_descDetail:SetText(self._DESC_TYPE[tabType])
  self._ui.txt_guideNormal:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", self._guideText[tabType]))
  self._ui_pc.btn_apply:SetText(self._guideText[tabType])
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function PaGlobal_AlchemyStone_All:invenStoneRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if nil == itemWrapper then
    return
  end
  if self._startEffectPlay then
    return
  end
  self._toWhereType = inventoryType
  self._toSlotNo = slotNo
  self._selectedStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
  self._selectedStoneItemKey = itemWrapper:get():getKey()
  self._recoverCount = itemWrapper:getStaticStatus():get():getAlchemyStoneGrade()
  self._ui.txt_guideNormal:SetText(self._GUIDETEXT[self._selectedTabIdx])
  local currentEndurance = itemWrapper:get():getEndurance()
  local maxEndurance = itemWrapper:get():getMaxEndurance()
  local alchemystoneExp = itemWrapper:getExperience() * 1.0E-4
  local itemSSW = itemWrapper:getStaticStatus()
  local itemContentsParam1 = itemSSW:get()._contentsEventParam1
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  local guideText = ""
  self._maxEndurance = maxEndurance
  self._currentEndurance = currentEndurance
  self._toLostEndurance = maxEndurance - currentEndurance
  if self._TAB_TYPE.CHARGE == self._selectedTabIdx then
    local endurancePoint = currentEndurance .. " / " .. maxEndurance
    self._ui._recharge.stc_gaugeEnduranceBg:SetShow(true)
    self._ui._recharge.txt_chargeDesc:SetShow(true)
    self._ui._recharge.progress_preEndurance:SetProgressRate(currentEndurance / maxEndurance * 100)
    self._ui._recharge.progress_curEndurance:SetProgressRate(currentEndurance / maxEndurance * 100)
    self._ui._recharge.txt_endurance:SetText(endurancePoint)
    self._ui._recharge.txt_chargeDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", itemContentsParam2 + 1))
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    self._rechargeSlot[self._SLOT_TYPE.STONE]:setItem(itemWrapper)
    self._rechargeSlot[self._SLOT_TYPE.STONE].Empty = false
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.STONE .. " )")
    elseif true == self._isConsole then
      self._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._ui._recharge.stc_slotRight:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.STONE .. " )")
    else
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.EXP == self._selectedTabIdx then
    local _exp = string.format("%.2f", alchemystoneExp)
    local mateiralName = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MATERIALNAME") .. " : <PAColor0xfff5ba3a>"
    if 0 == itemContentsParam1 then
      mateiralName = mateiralName .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PURESTONE")
      mateiralName = mateiralName .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PURESTONE2")
    elseif 1 == itemContentsParam1 then
      mateiralName = mateiralName .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_HARDWOOD")
      mateiralName = mateiralName .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_HARDWOOD2")
    elseif 2 == itemContentsParam1 then
      mateiralName = mateiralName .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHOICEGOOD")
      mateiralName = mateiralName .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHOICEGOOD2")
    end
    mateiralName = mateiralName .. "<PAOldColor>"
    self._ui._recharge.stc_gaugeExpBg:SetShow(true)
    self._ui.txt_needMetarial:SetShow(true)
    self._ui._recharge.progress_curExp:SetProgressRate(alchemystoneExp)
    self._ui._recharge.txt_expValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
    self._ui.txt_needMetarial:SetText(mateiralName)
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    self._rechargeSlot[self._SLOT_TYPE.STONE]:setItem(itemWrapper)
    self._rechargeSlot[self._SLOT_TYPE.STONE].Empty = false
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.STONE .. " )")
    elseif true == self._isConsole then
      self._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._ui._recharge.stc_slotRight:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.STONE .. " )")
    else
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._rechargeSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.UPGRADE == self._selectedTabIdx then
    local itemGrade = itemSSW:getGradeType()
    local resultCount = getAlchemyEvolveItemSize(itemSSW:get()._key:getItemKey())
    local resultAlchemyStone = {}
    for index = 0, 2 do
      if index < resultCount then
        local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
        self._resultSlot[index]:setItemByStaticStatus(resultItemWrapper, 1, nil, nil, nil)
        if true == _ContentsGroup_RenewUI_Tooltip then
          self._resultSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ResultItemTooltip(" .. index .. " )")
        elseif true == self._isConsole then
          self._resultSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ResultItemTooltip(true, " .. index .. ")")
          self._resultSlotBg[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ResultItemTooltip(false, " .. index .. ")")
        else
          self._resultSlot[index].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ResultItemTooltip(true, " .. index .. ")")
          self._resultSlot[index].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ResultItemTooltip(false, " .. index .. ")")
        end
        self._resultSlotBg[index]:SetShow(true)
        self._resultItemKey[index] = resultItemWrapper:get()._key:getItemKey()
      else
        self._resultSlotBg[index]:SetShow(false)
      end
    end
    local strPenalty = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_PENALTY") .. " : <PAColor0xffd05d48>"
    if itemContentsParam2 <= 2 then
      strPenalty = strPenalty .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN")
    elseif itemContentsParam2 <= 4 then
      strPenalty = strPenalty .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN") .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_GRADEDOWN")
    elseif itemContentsParam2 <= 6 then
      strPenalty = strPenalty .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN") .. ", " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_STONEDESTROY")
    end
    strPenalty = strPenalty .. "<PAOldColor>"
    self._ui.txt_needMetarial:SetText(strPenalty)
    self._ui.txt_needMetarial:SetShow(true)
    local posY = {
      116,
      92,
      70
    }
    local startPosY = 0
    for idx = 0, resultCount - 1 do
      self._resultSlotBg[idx]:SetPosX(self._resultSlotBg[idx]:GetPosX())
      self._resultSlotBg[idx]:SetPosY(startPosY - 23 * (resultCount - 1) + 60 * idx)
      self._ui._growth.stc_upgradeSlotBg:SetSize(self._ui._growth.stc_upgradeSlotBg:GetSizeX(), 87 + 60 * idx)
    end
    if self._ui._growth.stc_upgradeSlotBg:GetSizeY() > self._upgradeSlotBg_OriginSizeY then
      self._ui._growth.stc_upgradeSlotBg:SetPosY(posY[resultCount])
    end
    self._ui._growth.stc_slotBg_3:SetShow(false)
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    self._growthSlot[self._SLOT_TYPE.STONE]:setItem(itemWrapper)
    self._growthSlot[self._SLOT_TYPE.STONE].Empty = false
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        self._ui._growth.stc_slot_1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.STONE .. " )")
      else
        self._ui._growth.stc_slot_1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
        self._ui._growth.stc_slot_1:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      end
      self._growthSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._growthSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.STONE .. " )")
      if nil ~= self._blackStonSlotNo then
        local blackStoneWrapper = getInventoryItemByType(inventoryType, self._blackStonSlotNo)
        self:invenMatRClick(self._blackStonSlotNo, blackStoneWrapper, toInt64(0, 1), inventoryType)
      end
    else
      self._growthSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
      self._growthSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.RANDOMOPTION == self._selectedTabIdx then
    self._ui._random.stc_randomRadioGroup:SetShow(true)
    self._ui._random.radio_randomOptionSelect_1:SetCheck(true)
    self:randomOption_Select(1)
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    self._randomSlot[self._SLOT_TYPE.STONE]:setItem(itemWrapper)
    self._randomSlot[self._SLOT_TYPE.STONE].Empty = false
    self._randomSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.STONE .. " )")
    self._randomSlot[self._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
end
function PaGlobal_AlchemyStone_All:invenMatRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if self._startEffectPlay then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemKey = itemSSW:get()._key
  local guideText = ""
  self._fromWhereType = inventoryType
  self._fromSlotNo = slotNo
  self._fromCount = toInt64(0, 0)
  self._fromMaxCount = count
  self._ui.txt_guideNormal:SetText(self._GUIDETEXT[self._selectedTabIdx])
  if false == PaGlobal_AlchemyStone_All._isConsole then
    self._ui_pc.btn_apply:SetMonoTone(true)
    self._ui_pc.btn_apply:SetEnable(false)
    self:updateProgressBar()
  end
  Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
  if self._TAB_TYPE.CHARGE == self._selectedTabIdx then
    self._rechargeSlot[self._SLOT_TYPE.MAT]:clearItem()
    self._rechargeSlot[self._SLOT_TYPE.MAT].Empty = true
    self._chargePoint = ToClient_GetAlchmeyStoneChargePoint(self._toWhereType, self._toSlotNo, self._fromWhereType, self._fromSlotNo)
    self._maxRecoverCount = math.ceil(self._toLostEndurance / self._chargePoint) * self._recoverCount
    if 0 >= self._maxRecoverCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_WARN_1"))
      return
    end
    local needCount = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDCOUNT") .. " : <PAColor0xfff5ba3a>" .. self._maxRecoverCount .. "<PAOldColor>"
    self._ui._recharge.txt_needCount:SetShow(true)
    self._ui._recharge.txt_needCount:SetText(needCount)
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    elseif true == self._isConsole then
      self._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._ui._recharge.stc_slotLeft:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    else
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.EXP == self._selectedTabIdx then
    self._rechargeSlot[self._SLOT_TYPE.MAT]:clearItem()
    self._rechargeSlot[self._SLOT_TYPE.MAT].Empty = true
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    elseif true == self._isConsole then
      self._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._ui._recharge.stc_slotLeft:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    else
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._rechargeSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.UPGRADE == self._selectedTabIdx then
    self._growthSlot[self._SLOT_TYPE.MAT]:clearItem()
    self._growthSlot[self._SLOT_TYPE.MAT].Empty = true
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._ui._growth.stc_slot_2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventXUp_AlchemyStone_ItemToolTip(" .. self._SLOT_TYPE.BLACKSTONE .. " )")
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    elseif true == self._isConsole then
      self._ui._growth.stc_slot_2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_AlchemyStone_ItemToolTip( true," .. self._SLOT_TYPE.BLACKSTONE .. " )")
      self._ui._growth.stc_slot_2:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_CheckSlotType( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_CheckSlotType( false, " .. self._SLOT_TYPE.MAT .. " )")
    else
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
      self._growthSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
    end
  elseif self._TAB_TYPE.RANDOMOPTION == self._selectedTabIdx then
    self._randomSlot[self._SLOT_TYPE.MAT]:clearItem()
    self._randomSlot[self._SLOT_TYPE.MAT].Empty = true
    self._randomSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "HandleEventOnOut_AlchemyStone_ItemToolTip( true, " .. self._SLOT_TYPE.MAT .. " )")
    self._randomSlot[self._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AlchemyStone_ItemToolTip( false )")
  end
  local function setMatFunc(itemCount)
    PaGlobal_AlchemyStone_All._fromCount = itemCount
    local itemSSW = getItemEnchantStaticStatus(itemKey)
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PaGlobal_AlchemyStone_All._READYTEXT[PaGlobal_AlchemyStone_All._selectedTabIdx])
    if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == PaGlobal_AlchemyStone_All._selectedTabIdx then
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:setItemByStaticStatus(itemSSW, PaGlobal_AlchemyStone_All._fromCount, nil, nil, nil)
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = false
    elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == PaGlobal_AlchemyStone_All._selectedTabIdx then
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:setItemByStaticStatus(itemSSW, PaGlobal_AlchemyStone_All._fromCount, nil, nil, nil)
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = false
    elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == PaGlobal_AlchemyStone_All._selectedTabIdx then
      PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:setItemByStaticStatus(itemSSW, PaGlobal_AlchemyStone_All._fromCount, nil, nil, nil)
      PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = false
    elseif PaGlobal_AlchemyStone_All._TAB_TYPE.RANDOMOPTION == PaGlobal_AlchemyStone_All._selectedTabIdx then
      PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:setItemByStaticStatus(itemSSW, PaGlobal_AlchemyStone_All._fromCount, nil, nil, nil)
      PaGlobal_AlchemyStone_All._randomSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = false
    end
    if false == PaGlobal_AlchemyStone_All._isConsole then
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(PaGlobal_AlchemyStone_All._isPushDoit)
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(not PaGlobal_AlchemyStone_All._isPushDoit)
      PaGlobal_AlchemyStone_All:updateProgressBar()
    else
      ToClient_padSnapSetTargetPanel(Panel_Window_AlchemyStone_All)
      Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_AlchemyStone_Doit()")
    end
  end
  if count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count, nil, setMatFunc, false, nil, nil)
  else
    setMatFunc(toInt64(0, 1))
  end
end
function PaGlobal_AlchemyStone_All:clearSetShow()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._ui._recharge.stc_rechargeBg:SetShow(false)
  self._ui._growth.stc_growthBg:SetShow(false)
  self._ui._random.stc_randomBg:SetShow(false)
  self._ui.txt_needMetarial:SetShow(false)
  self._ui._recharge.txt_materialName:SetShow(false)
  self._ui._recharge.txt_needCount:SetShow(false)
  self._ui._recharge.txt_chargeDesc:SetShow(false)
  self._ui._recharge.stc_gaugeEnduranceBg:SetShow(false)
  self._ui._recharge.stc_gaugeExpBg:SetShow(false)
  self._ui._recharge.txt_materialName:SetShow(false)
end
function PaGlobal_AlchemyStone_All:clearData(isMatOnly)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local tabType = self._selectedTabIdx
  self._isTooltipShow = false
  self._rechargeSlot[self._SLOT_TYPE.MAT].icon:EraseAllEffect()
  self._rechargeSlot[self._SLOT_TYPE.STONE].icon:EraseAllEffect()
  self._ui._growth.txt_fail:EraseAllEffect()
  self._ui._growth.txt_success:EraseAllEffect()
  self._ui.stc_CenterEffect:EraseAllEffect()
  if false == isMatOnly then
    self._toWhereType = -1
    self._toSlotNo = -1
    self._selectedStoneType = 0
    self._selectedStoneItemKey = nil
    self._recoverCount = 0
    self._maxRecoverCount = 0
    self._randomSourceKey = 0
    self._currentEndurance = 0
    self._maxEndurance = 0
    self._toLostEndurance = 0
    self._rechargeSlot[self._SLOT_TYPE.STONE]:clearItem()
    self._rechargeSlot[self._SLOT_TYPE.STONE].Empty = true
    self._ui._recharge.progress_preEndurance:SetProgressRate(0)
    self._ui._recharge.progress_curEndurance:SetProgressRate(0)
    self._ui._recharge.progress_preExp:SetProgressRate(0)
    self._ui._recharge.progress_curExp:SetProgressRate(0)
    self._growthSlot[self._SLOT_TYPE.STONE]:clearItem()
    self._growthSlot[self._SLOT_TYPE.STONE].Empty = true
    self._randomSlot[self._SLOT_TYPE.STONE]:clearItem()
    self._randomSlot[self._SLOT_TYPE.STONE].Empty = true
    self._ui._random.stc_randomRadioGroup:SetShow(false)
    self._ui._random.radio_randomOptionSelect_1:SetCheck(false)
    self._ui._random.radio_randomOptionSelect_2:SetCheck(false)
    self._ui._random.radio_randomOptionSelect_3:SetCheck(false)
  end
  self._ui.txt_descDetail:SetText(self._DESC_TYPE[tabType])
  local tempSizeY = 10
  if self._descDetailBg_OriginSizeY < self._ui.txt_descDetail:GetTextSizeY() then
    tempSizeY = self._ui.txt_descDetail:GetTextSizeY() - self._descDetailBg_OriginSizeY + 5
  end
  if self._TAB_TYPE.UPGRADE == tabType then
    self._ui.stc_descDetailBg:SetSize(self._ui.stc_descDetailBg:GetSizeX(), self._descDetailBg_OriginSizeY + tempSizeY)
    self._ui.txt_descDetail:SetPosY(self._descDetail_OriginPosY)
    if false == self._isConsole then
      Panel_Window_AlchemyStone_All:SetSize(Panel_Window_AlchemyStone_All:GetSizeX(), self._panel_OriginSizeY + 10)
    end
    self._ui._growth.stc_upgradeSlotBg:SetSize(self._ui._growth.stc_upgradeSlotBg:GetSizeX(), self._upgradeSlotBg_OriginSizeY)
    self._ui._growth.txt_fail:SetShow(false)
    self._ui._growth.stc_slotBg_3:SetShow(true)
  else
    self._ui.txt_descDetail:SetPosY(self._descDetail_OriginPosY)
    if false == self._isConsole then
      self._ui.stc_descDetailBg:SetSize(self._ui.stc_descDetailBg:GetSizeX(), self._descDetailBg_OriginSizeY)
      Panel_Window_AlchemyStone_All:SetSize(Panel_Window_AlchemyStone_All:GetSizeX(), self._panel_OriginSizeY)
    else
      self._ui.stc_descDetailBg:SetSize(self._ui.stc_descDetailBg:GetSizeX(), self._descDetailBg_OriginSizeY + tempSizeY)
      Panel_Window_AlchemyStone_All:SetSize(Panel_Window_AlchemyStone_All:GetSizeX(), self._panel_OriginSizeY - self._doitBg_OriginSizeY)
    end
  end
  self._ui.stc_descDetailBg:ComputePos()
  if false == self._isPushDoit then
    if self._TAB_TYPE.UPGRADE ~= tabType then
      self._ui.txt_guideNormal:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", self._guideText[tabType]))
    end
  else
    self._ui.txt_guideNormal:SetText(self._GUIDETEXT[tabType])
  end
  self._fromWhereType = -1
  self._fromSlotNo = -1
  self._fromCount = toInt64(0, -1)
  self._fromMaxCount = toInt64(0, -1)
  self._chargePoint = 0
  self:initEffectPlayState()
  self._rechargeSlot[self._SLOT_TYPE.MAT]:clearItem()
  self._rechargeSlot[self._SLOT_TYPE.MAT].Empty = true
  self._growthSlot[self._SLOT_TYPE.MAT]:clearItem()
  self._growthSlot[self._SLOT_TYPE.MAT].Empty = true
  self._ui.stc_CenterEffect:EraseAllEffect()
  self._ui.stc_CenterEffect:SetShow(false)
  self._ui_pc.btn_apply:SetMonoTone(false == self._isPushDoit)
  self._ui_pc.btn_apply:SetEnable(self._isPushDoit)
  self._ui_pc.btn_apply:SetText(self._guideText[tabType])
  self._randomSlot[self._SLOT_TYPE.MAT]:clearItem()
  self._randomSlot[self._SLOT_TYPE.MAT].Empty = true
  self._ui._random.stc_randomRadioGroup:SetMonoTone(false)
  self._ui._random.radio_randomOptionSelect_1:SetEnable(true)
  self._ui._random.radio_randomOptionSelect_2:SetEnable(true)
  self._ui._random.radio_randomOptionSelect_3:SetEnable(true)
  for index = 0, 2 do
    if nil ~= self._resultSlotBg[index] then
      self._resultSlot[index]:clearItem()
      self._resultSlot[index].Empty = true
      self._resultSlotBg[index]:SetShow(false)
    end
  end
  self.__resultMsg = {}
  self._resultItemKey = {}
  self._resultItemIndex = -1
  Panel_NumberPad_Close()
end
function PaGlobal_AlchemyStone_All:updateProgressBar()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local progressRate = 0
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGradeNum = itemSSW:get()._contentsEventParam2 + 1
  local stuffCount = Int64toInt32(PaGlobal_AlchemyStone_All._fromCount)
  if 0 < PaGlobal_AlchemyStone_All._currentEndurance then
    progressRate = PaGlobal_AlchemyStone_All._currentEndurance / PaGlobal_AlchemyStone_All._maxEndurance * 100
  end
  if stuffCount >= PaGlobal_AlchemyStone_All._maxRecoverCount then
    progressRate = 100
  else
    if 0 ~= stuffCount % itemGradeNum then
      stuffCount = math.floor(stuffCount / itemGradeNum) * itemGradeNum
    end
    progressRate = progressRate + PaGlobal_AlchemyStone_All._toLostEndurance / PaGlobal_AlchemyStone_All._maxEndurance / PaGlobal_AlchemyStone_All._maxRecoverCount * stuffCount * 100
  end
  PaGlobal_AlchemyStone_All._ui._recharge.progress_preEndurance:SetProgressRate(progressRate)
end
function PaGlobal_AlchemyStone_All:UpdateStone(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  self._currentEndurance = itemWrapper:get():getEndurance()
  self._maxEndurance = itemWrapper:get():getMaxEndurance()
  self._toLostEndurance = self._maxEndurance - self._currentEndurance
  local progressRate = self._currentEndurance / self._maxEndurance * 100
  self._ui._recharge.progress_curEndurance:SetProgressRate(progressRate)
  local endurancePoint = self._currentEndurance .. " / " .. self._maxEndurance
  self._ui._recharge.txt_endurance:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_ENDURANCE", "endurance", endurancePoint))
end
function PaGlobal_AlchemyStone_All:initEffectPlayState()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  self._isPushDoit = false
  self._startEffectPlay = false
  self._contentEffectPlay = false
  self._slotEffectPlay = false
  self._effectEnd = false
end
function PaGlobal_AlchemyStone_All:chargeTab_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType]:clearItem()
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].Empty = true
    PaGlobal_AlchemyStone_All._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].icon:addInputEvent("Mouse_On", "")
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].icon:addInputEvent("Mouse_Out", "")
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", PaGlobal_AlchemyStone_All._guideText[tabType]))
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
    PaGlobal_AlchemyStone_All._ui._recharge.stc_gaugeEnduranceBg:SetShow(false)
    PaGlobal_AlchemyStone_All._ui._recharge.txt_chargeDesc:SetShow(false)
    PaGlobal_AlchemyStone_All._ui._recharge.progress_preEndurance:SetProgressRate(0)
    PaGlobal_AlchemyStone_All._ui._recharge.progress_curEndurance:SetProgressRate(0)
    PaGlobal_AlchemyStone_All._ui._recharge.txt_endurance:SetText("")
    PaGlobal_AlchemyStone_All._ui._recharge.txt_chargeDesc:SetText("")
  elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT and false == PaGlobal_AlchemyStone_All._rechargeSlot[slotType].Empty then
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PaGlobal_AlchemyStone_All._GUIDETEXT[tabType])
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
  end
  PaGlobal_AlchemyStone_All._ui._recharge.txt_needCount:SetShow(false)
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
  PaGlobal_AlchemyStone_All._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "")
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "")
  PaGlobal_AlchemyStone_All._ui._recharge.progress_preEndurance:SetProgressRate(0)
end
function PaGlobal_AlchemyStone_All:expTab_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType]:clearItem()
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].Empty = true
    PaGlobal_AlchemyStone_All._ui._recharge.stc_slotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].icon:addInputEvent("Mouse_On", "")
    PaGlobal_AlchemyStone_All._rechargeSlot[slotType].icon:addInputEvent("Mouse_Out", "")
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", PaGlobal_AlchemyStone_All._guideText[tabType]))
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
    PaGlobal_AlchemyStone_All._ui._recharge.stc_gaugeExpBg:SetShow(false)
  elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT and false == PaGlobal_AlchemyStone_All._rechargeSlot[slotType].Empty then
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PaGlobal_AlchemyStone_All._GUIDETEXT[tabType])
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
  end
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
  PaGlobal_AlchemyStone_All._ui._recharge.stc_slotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "")
  PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "")
  PaGlobal_AlchemyStone_All._ui._recharge.progress_preExp:SetProgressRate(0)
  PaGlobal_AlchemyStone_All._ui.txt_needMetarial:SetShow(false)
end
function PaGlobal_AlchemyStone_All:upgradeTab_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  function UnSetStoneSlot()
    local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
    PaGlobal_AlchemyStone_All._ui._growth.stc_slotBg_3:SetShow(true)
    PaGlobal_AlchemyStone_All._ui.txt_needMetarial:SetShow(false)
    PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE]:clearItem()
    PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].Empty = true
    PaGlobal_AlchemyStone_All._ui._growth.stc_slot_1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_On", "")
    PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:addInputEvent("Mouse_Out", "")
    PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT", "guideKeyword", PaGlobal_AlchemyStone_All._guideText[tabType]))
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
    for index = 0, 2 do
      if nil ~= PaGlobal_AlchemyStone_All._resultSlotBg[index] then
        PaGlobal_AlchemyStone_All._resultSlot[index]:clearItem()
        PaGlobal_AlchemyStone_All._resultSlot[index].Empty = true
        PaGlobal_AlchemyStone_All._resultSlotBg[index]:SetShow(false)
        if true == PaGlobal_AlchemyStone_All._isConsole then
          PaGlobal_AlchemyStone_All._resultSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
          PaGlobal_AlchemyStone_All._resultSlot[index].icon:addInputEvent("Mouse_Out", "")
        end
        PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetSize(PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:GetSizeX(), PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginSizeY)
        PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetPosY(PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginPosY)
      end
    end
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
    UnSetStoneSlot()
  elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT then
    if true == PaGlobal_AlchemyStone_All._isConsole then
      UnSetStoneSlot()
    else
      if PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
        return
      end
      PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(PaGlobal_AlchemyStone_All._GUIDETEXT[tabType])
      Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
    end
  end
  PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
  PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
  PaGlobal_AlchemyStone_All._ui._growth.stc_slot_2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_On", "")
  PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:addInputEvent("Mouse_Out", "")
end
function PaGlobal_AlchemyStone_All:randomOption_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
    PaGlobal_AlchemyStone_All:clearData(false)
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
  elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT then
    PaGlobal_AlchemyStone_All:clearData(true)
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
  end
end
function PaGlobal_AlchemyStone_All:randomOption_Select(selectType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == PaGlobal_AlchemyStone_All._isPushDoit then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  local randomKey = itemWrapper:getRandomOptionByIndex(selectType - 1)
  if selectType ~= randomKey then
    return
  end
  local randomWrapper = ToClient_GetRandomOptionByKey(randomKey)
  if nil == randomWrapper then
    return
  end
  if 0 ~= self._randomSourceKey then
    PaGlobal_AlchemyStone_All:clearData(true)
  end
  self._randomSourceKey = selectType
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
end
function PaGlobal_AlchemyStone_All:randomOption_StatTooltip(isMosueUp, selectType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  local randomKey = itemWrapper:getRandomOptionByIndex(selectType - 1)
  if selectType ~= randomKey then
    return
  end
  local randomWrapper = ToClient_GetRandomOptionByKey(randomKey)
  if nil == randomWrapper then
    return
  end
  if isMosueUp then
    self._ui._random.stc_randomOptionStatTooltipTitle:SetText(randomWrapper:getRandomOptionName())
    local optionString = ""
    local optionCount = randomWrapper:getOptionCount()
    local realCheckCount = 0
    for index = 0, optionCount do
      local statType = randomWrapper:getOptionTypeByIndex(index)
      local randomOptionTypeWrapper = ToClient_GetRandomOptionTypeByKey(statType)
      if nil ~= randomOptionTypeWrapper then
        local typeName = randomOptionTypeWrapper:getRandomOptionTypeName()
        local statMax = math.floor(randomWrapper:getOptionMaxValueByIndex(index) * 10 + 0.5) / 10
        local statMin = math.floor(randomWrapper:getOptionMinValueByIndex(index) * 10 + 0.5) / 10
        if 0 == realCheckCount then
          optionString = optionString .. typeName .. " : " .. tostring(statMin) .. " ~ " .. tostring(statMax) .. randomOptionTypeWrapper:getUnitForRandomOption()
        else
          optionString = optionString .. "\n" .. typeName .. " : " .. tostring(statMin) .. " ~ " .. tostring(statMax) .. randomOptionTypeWrapper:getUnitForRandomOption()
        end
        realCheckCount = realCheckCount + 1
      end
    end
    self._ui._random.stc_randomOptionStatTooltipText:SetText(optionString)
    self._ui._random.stc_randomOptionStatTooltipBG:SetSize(self._ui._random.stc_randomOptionStatTooltipBG:GetSizeX(), self._ui._random.stc_randomOptionStatTooltipText:GetTextSizeY() + 110)
    self._ui._random.stc_randomOptionStatTooltip:SetSize(self._ui._random.stc_randomOptionStatTooltip:GetSizeX(), self._ui._random.stc_randomOptionStatTooltipText:GetTextSizeY() + 160)
    self._ui._random.stc_randomOptionStatTooltipAddBG:ComputePos()
    local maxPickCount = randomWrapper:getPickMaxCount()
    local optionAddStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_STAT_INFO", "count", tostring(maxPickCount))
    self._ui._random.stc_randomOptionStatTooltipAddText:SetTextMode(__eTextMode_AutoWrap)
    self._ui._random.stc_randomOptionStatTooltipAddText:SetText(optionAddStr)
  end
  self._ui._random.stc_randomOptionStatTooltip:SetShow(isMosueUp)
end
function getUnitForRandomOption(statType)
  if __eRandomOptionStatType_AllIgnore == statType or __eRandomOptionStatType_KnockbackIgnore == statType or __eRandomOptionStatType_KnockdownIgnore == statType or __eRandomOptionStatType_CatchIgnore == statType or __eRandomOptionStatType_StunIgnore == statType or __eRandomOptionStatType_AllAddDamage == statType or __eRandomOptionStatType_AddBackAttack == statType or __eRandomOptionStatType_AddDownAttack == statType or __eRandomOptionStatType_AddAirAttack == statType or __eRandomOptionStatType_CriticalRate == statType or __eRandomOptionStatType_CriticalDamage == statType or __eRandomOptionStatType_KnockbackResistance == statType or __eRandomOptionStatType_KnockdownResistance == statType or __eRandomOptionStatType_CatchResistance == statType or __eRandomOptionStatType_StunResistance == statType or __eRandomOptionStatType_LifeExp == statType or __eRandomOptionStatType_LifeDropRate == statType then
    return "%"
  end
  return ""
end
