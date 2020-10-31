function PaGlobal_ServantMarket_Rental_Mating_All:initialize()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or true == self._initailize then
    return
  end
  self._ui._stc_TitleBg = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_TitleBg")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleBg, "StaticText_TitleIcon")
  self._ui._btn_Close_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Close")
  self._ui._btn_Question_PC = UI.getChildControl(self._ui._stc_TitleBg, "Button_Question")
  self._ui._stc_TabGroup = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_TabGroup")
  self._ui._rdo_Tab_Left = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_MyList")
  self._ui._rdo_Tab_Center = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_ReturnList")
  self._ui._rdo_Tab_Right = UI.getChildControl(self._ui._stc_TabGroup, "RadioButton_MyReturnList")
  self._ui._stc_SelectedLine = UI.getChildControl(self._ui._stc_TabGroup, "Static_SelectedLine")
  self._ui._stc_KeyGuide_LT = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_LT_ConsoleUI")
  self._ui._stc_KeyGuide_RT = UI.getChildControl(self._ui._stc_TabGroup, "StaticText_RT_ConsoleUI")
  self._ui._stc_PageBg = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_PageBg")
  self._ui._txt_PageValue = UI.getChildControl(self._ui._stc_PageBg, "StaticText_PageValue")
  self._ui._btn_PageLeft_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Left_PCUI")
  self._ui._btn_PageRight_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Right_PCUI")
  self._ui._stc_PageLeft_Console = UI.getChildControl(self._ui._stc_PageBg, "Button_Left_ConsoleUI")
  self._ui._stc_PageRight_Console = UI.getChildControl(self._ui._stc_PageBg, "Button_Right_ConsoleUI")
  self._ui._stc_DescIcon = UI.getChildControl(self._ui._stc_PageBg, "Static_DescIcon")
  self._ui._btn_Reload_PC = UI.getChildControl(self._ui._stc_PageBg, "Button_Reload")
  self._ui._stc_InvenMoneyBG = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_InvenMoneyBG")
  self._ui._txt_InvenTitle = UI.getChildControl(self._ui._stc_InvenMoneyBG, "StaticText_InvenMoney")
  self._ui._txt_Inven = UI.getChildControl(self._ui._stc_InvenMoneyBG, "StaticText_InvenMoneyValue")
  self._ui._stc_WarehouseMoneyBG = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_WarehouseMoneyBG")
  self._ui._txt_WareTitle = UI.getChildControl(self._ui._stc_WarehouseMoneyBG, "StaticText_WarehouseMoney")
  self._ui._txt_Ware = UI.getChildControl(self._ui._stc_WarehouseMoneyBG, "StaticText_WarehouseMoenyValue")
  self._ui._stc_SkillTooltip = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_SkillTooltip")
  self._ui._stc_Bottom_KeyGuides = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_X_ConsoleUI")
  self._ui._stc_KeyGuide_RS = UI.getChildControl(self._ui._stc_Bottom_KeyGuides, "StaticText_RS_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_Y_ConsoleUI")
  self._ui._stc_KeyGuide_Y_Tooltip = UI.getChildControl(self._ui._stc_KeyGuide_Y, "StaticText_YButtonToolTip")
  self._ui._tabButtonList[0] = self._ui._rdo_Tab_Left
  self._ui._tabButtonList[1] = self._ui._rdo_Tab_Center
  self._ui._tabButtonList[2] = self._ui._rdo_Tab_Right
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tempServantSlot = {
      _slot = nil,
      _horseIdx = nil,
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
      _btn_Confirm_PC = nil,
      _btn_Cancel_PC = nil,
      _list2_Control = nil,
      _txt_learnedSkillCount = nil,
      _tooltipControls = {}
    }
    tempServantSlot._slot = UI.getChildControl(Panel_Dialog_ServantMarket_Rental_Mating_All, "Static_Slot_" .. tostring(slotIdx + 1))
    tempServantSlot._slot:SetShow(false)
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
    tempServantSlot._btn_Confirm_PC = UI.getChildControl(tempServantSlot._slot, "Button_RecieveHorse_PCUI")
    tempServantSlot._btn_Cancel_PC = UI.getChildControl(tempServantSlot._slot, "Button_Cancel_PCUI")
    tempServantSlot._list2_Control = UI.getChildControl(tempServantSlot._slot, "List2_ServantSkill")
    tempServantSlot._txt_learnedSkillCount = UI.getChildControl(tempServantSlot._slot, "StaticText_SkillCountValue")
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
    local lookChangeBtn = UI.getChildControl(tempServantSlot._slot, "Button_BeforeLook")
    lookChangeBtn:SetShow(false)
    local btn_ForceReturn = UI.getChildControl(tempServantSlot._slot, "Button_ForcedReturn_PCUI")
    local btn_RecieveMoney = UI.getChildControl(tempServantSlot._slot, "Button_RecieveMoney_PCUI")
    btn_ForceReturn:SetShow(false)
    btn_RecieveMoney:SetShow(false)
    self._ui._servantSlot[slotIdx] = tempServantSlot
  end
  self._ui._stc_SkillTooltip:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantMarket_Rental_Mating_All:validate()
  PaGlobal_ServantMarket_Rental_Mating_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantMarket_Rental_Mating_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantMarket_Rental_Mating_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantMarket_Rental_Mating_All_OnScreenResize")
  registerEvent("FromClient_AuctionServantList", "FromClient_ServantMarket_Rental_Mating_All_UpdateSlot")
  registerEvent("FromClient_ServantRegisterToAuction", "HandleEventLUp_ServantMarket_Rental_Mating_All_Reload")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ServantMarket_Rental_Mating_All_UpdateMoney")
  registerEvent("EventWarehouseUpdate", "FromClient_ServantMarket_Rental_Mating_All_UpdateMoney")
  Panel_Dialog_ServantMarket_Rental_Mating_All:RegisterShowEventFunc(true, "PaGlobalFunc_ServantMarket_Rental_Mating_All_ShowAni()")
  Panel_Dialog_ServantMarket_Rental_Mating_All:RegisterShowEventFunc(false, "PaGlobalFunc_ServantMarket_Rental_Mating_All_HideAni()")
  for slotIdx = 0, 3 do
    local list2 = self._ui._servantSlot[slotIdx]._list2_Control
    list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantMarket_Rental_Mating_All_List2UpdateSlot" .. tostring(slotIdx))
    list2:createChildContent(__ePAUIList2ElementManagerType_List)
  end
  if false == isConsole then
    Panel_Dialog_ServantMarket_Rental_Mating_All:SetDragEnable(true)
    Panel_Dialog_ServantMarket_Rental_Mating_All:SetDragAll(true)
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._tabButtonList[0]:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange( 0 )")
    self._ui._tabButtonList[1]:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange( 1 )")
    self._ui._tabButtonList[2]:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange( 2 )")
    self._ui._stc_DescIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowDiscountRateTooltip( 0, true )")
    self._ui._stc_DescIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowDiscountRateTooltip( false)")
    self._ui._btn_Reload_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_Reload()")
    self._ui._btn_PageLeft_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(false)")
    self._ui._btn_PageRight_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(true)")
    self._ui._txt_WareTitle:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowSimpleTooltip( 1, true )")
    self._ui._txt_WareTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowSimpleTooltip( false)")
    self._ui._txt_InvenTitle:addInputEvent("Mouse_On", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowSimpleTooltip( 0, true )")
    self._ui._txt_InvenTitle:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantMarket_Rental_Mating_All_ShowSimpleTooltip( false)")
  else
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_Rental_Mating_All_MatingBtnTextChange( false )")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_Rental_Mating_All_MatingBtnTextChange( true )")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadLeft, "HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(false)")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadRight, "HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(true)")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPadDown_ServantMarket_Rental_Mating_All_YPressTooltipShow()")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadDown_ServantMarket_Rental_Mating_All_YPressTooltipHide()")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_ServantMarket_Rental_Mating_All_ServantSkill(true)")
    Panel_Dialog_ServantMarket_Rental_Mating_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_ServantMarket_Rental_Mating_All_ServantSkill(false)")
  end
end
function PaGlobal_ServantMarket_Rental_Mating_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == self._initailize then
    return
  end
  self._ui._stc_KeyGuide_LT:SetShow(isConsole)
  self._ui._stc_KeyGuide_RT:SetShow(isConsole)
  self._ui._stc_PageLeft_Console:SetShow(isConsole)
  self._ui._stc_PageRight_Console:SetShow(isConsole)
  self._ui._stc_Bottom_KeyGuides:SetShow(isConsole)
  self._ui._stc_KeyGuide_Y:SetShow(isConsole)
  self._ui._stc_PageLeft_Console:SetShow(isConsole)
  self._ui._stc_PageRight_Console:SetShow(isConsole)
  self._ui._btn_PageLeft_PC:SetShow(not isConsole)
  self._ui._btn_PageRight_PC:SetShow(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._btn_Question_PC:SetShow(not isConsole)
  self._ui._stc_DescIcon:SetShow(not isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_KeyGuide_RS,
      self._ui._stc_KeyGuide_X,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    self._ui._keyguides = keyguide
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyguides, self._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantMarket_Rental_Mating_All:prepareOpen()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or true == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  local sceneIdx = PaGlobalFunc_ServantList_All_GetSceneIndex()
  if nil ~= sceneIdx then
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(PaGlobal_ServantList_All._selectSceneIndex)
  end
  self._isFromNpc = not ToClient_WorldMapIsShow()
  warehouse_requestInfoFromNpc()
  if true == self._isConsole then
    self._ui._stc_KeyGuide_Y_Tooltip:SetShow(false)
    self._ui._stc_KeyGuide_X:SetShow(not self._isMatingMarket)
  else
    Panel_Dialog_ServantMarket_Rental_Mating_All:RegisterUpdateFunc("PaGlobalFunc_ServantMarket_Rental_Mating_All_ChangePageByARROWKEY")
  end
  self._currentTabIdx = nil
  PaGlobal_ServantMarket_Rental_Mating_All:open()
  FromClient_ServantMarket_Rental_Mating_All_OnScreenResize()
  PaGlobal_ServantMarket_Rental_Mating_All:dataClear()
  HandleEventLUp_ServantMarket_Rental_Mating_All_TabChange(self._ENUM_TAB_LEFT)
end
function PaGlobal_ServantMarket_Rental_Mating_All:open()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or true == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  Panel_Dialog_ServantMarket_Rental_Mating_All:SetShow(true)
end
function PaGlobal_ServantMarket_Rental_Mating_All:update()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_Rental_Mating_All:moneyUpdate()
  for idx = 0, self._MAXSLOTCOUNT - 1 do
    if nil ~= self._ui._servantSlot and nil ~= self._ui._servantSlot[idx] then
      self._ui._servantSlot[idx]._slot:SetShow(false)
    end
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  self._auctionInfo = myAuctionInfo
  local startSlotNo = 0
  local endSlotNo = 0
  if (self._currentTabIdx == self._ENUM_TAB_LEFT or self._currentTabIdx == self._ENUM_TAB_RIGHT) and true == PaGlobal_ServantMarket_Rental_Mating_All._isMatingMarket then
    startSlotNo = 0
    endSlotNo = myAuctionInfo:getServantAuctionListCount() - 1
    if 3 <= endSlotNo then
      self._selectMaxPage = self._selectPage + 1
    else
      self._selectMaxPage = self._selectPage
    end
    self._ui._txt_PageValue:SetText(self._selectPage + 1)
  else
    startSlotNo = self._selectPage * self._MAXSLOTCOUNT
    endSlotNo = startSlotNo + self._MAXSLOTCOUNT - 1
    local maxCount = myAuctionInfo:getServantAuctionListCount()
    local prevMaxPage = self._selectMaxPage
    self._selectMaxPage = math.ceil(maxCount / self._MAXSLOTCOUNT) - 1
    if -1 == self._selectMaxPage then
      self._selectMaxPage = 0
    end
    self._ui._txt_PageValue:SetText(self._selectPage + 1 .. " / " .. self._selectMaxPage + 1)
    if prevMaxPage > self._selectMaxPage then
      HandleEventLUp_ServantMarket_Rental_Mating_All_PageChange(false)
    end
  end
  local slotNo = 0
  for ii = startSlotNo, endSlotNo do
    local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(ii)
    local slot = self._ui._servantSlot[slotNo]
    if nil ~= auctionServantInfo and slotNo < self._MAXSLOTCOUNT then
      slot._horseIdx = ii
      slot._list2_Control:getElementManager():clearKey()
      local everyVehicleSkillCount = vehicleSkillStaticStatus_skillCount()
      local learnedSkillCount = 0
      local UnlearnedSkillCount = 0
      for skillIdx = 1, everyVehicleSkillCount - 1 do
        local learnSkillWrapper = auctionServantInfo:getSkill(skillIdx)
        local UnLearnSKillWrapper = auctionServantInfo:getSkillXXX(skillIdx)
        if nil ~= learnSkillWrapper then
          learnedSkillCount = learnedSkillCount + 1
          slot._list2_Control:getElementManager():pushKey(toInt64(0, skillIdx))
        end
        if nil ~= UnLearnSKillWrapper then
          UnlearnedSkillCount = UnlearnedSkillCount + 1
        end
      end
      slot._txt_learnedSkillCount:SetText(tostring(learnedSkillCount) .. " / " .. tostring(learnedSkillCount + UnlearnedSkillCount))
      slot._slot:SetShow(true)
      slot._stc_HorseImage:ChangeTextureInfoName(auctionServantInfo:getIconPath1())
      local isNineTier = 9 ~= auctionServantInfo:getTier()
      if auctionServantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse then
        slot._txt_LeftMatingTitle:SetShow(isNineTier)
        slot._txt_LeftMatingValue:SetShow(isNineTier)
        if auctionServantInfo:doClearCountByMating() then
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", auctionServantInfo:getMatingCount()))
        else
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", auctionServantInfo:getMatingCount()))
        end
        if true == auctionServantInfo:isMale() then
          slot._stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 209, 31, 239)
          slot._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          slot._stc_GenderIcon:setRenderTexture(slot._stc_GenderIcon:getBaseTexture())
        else
          slot._stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 178, 31, 208)
          slot._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          slot._stc_GenderIcon:setRenderTexture(slot._stc_GenderIcon:getBaseTexture())
        end
        slot._stc_SwiftIcon:SetShow(false)
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
      local deadCount = auctionServantInfo:getDeadCount()
      if auctionServantInfo:doClearCountByDead() then
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
      else
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
      end
      slot._txt_DeadCountValue:SetText(deadCount)
      slot._btn_Confirm_PC:SetShow(false)
      slot._btn_Cancel_PC:SetShow(false)
      slot._btn_Cancel_PC:SetIgnore(false)
      slot._btn_Confirm_PC:addInputEvent("Mouse_LUp", "")
      slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "")
      slot._btn_Confirm_PC:addInputEvent("Mouse_On", "")
      slot._btn_Confirm_PC:addInputEvent("Mouse_Out", "")
      if true == self._isConsole then
        slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        slot._slot:addInputEvent("Mouse_On", "")
        self._ui._stc_KeyGuide_A:SetShow(true)
      end
      if true == self._isMatingMarket then
        if self._ENUM_TAB_CENTER == self._currentTabIdx then
          local isAuctionEnd = auctionServantInfo:isAuctionEnd()
          local servantInfo = stable_getServantByServantNo(auctionServantInfo:getServantNo())
          if nil ~= servantInfo then
            slot._btn_Cancel_PC:SetShow(true)
            if CppEnums.ServantStateType.Type_RegisterMating == servantInfo:getStateType() then
              if true == isAuctionEnd then
                slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_BTN_END"))
                if true == self._isConsole then
                  slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",true)")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 0, " .. slotNo .. " )")
                else
                  slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",true)")
                end
              else
                slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
                if true == self._isConsole then
                  slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",true)")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 0, " .. slotNo .. " )")
                else
                  slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",true)")
                end
              end
            elseif CppEnums.ServantStateType.Type_Mating == servantInfo:getStateType() then
              if true == servantInfo:isMatingComplete() then
                slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_BTN_RECEIVE"))
                if true == self._isConsole then
                  slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveMating(" .. ii .. ")")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 1, " .. slotNo .. " )")
                else
                  slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveMating(" .. ii .. ")")
                end
              else
                slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_BTN_MATING"))
                slot._btn_Cancel_PC:SetIgnore(false)
                if true == self._isConsole then
                  slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
                  slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( nil, " .. slotNo .. " )")
                else
                  slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "")
                end
              end
            end
          end
        else
          slot._btn_Confirm_PC:SetShow(true)
          slot._btn_Confirm_PC:SetText(makeDotMoney(auctionServantInfo:getAuctoinPrice_s64()))
          if false == self._isConsole then
            slot._btn_Confirm_PC:addInputEvent("Mouse_On", "HandleEventOnOut_Rental_Mating_All_MatingBtnTextChange(" .. slotNo .. ",true," .. ii .. " )")
            slot._btn_Confirm_PC:addInputEvent("Mouse_Out", "HandleEventOnOut_Rental_Mating_All_MatingBtnTextChange(" .. slotNo .. ",false," .. ii .. " )")
            slot._btn_Confirm_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_Mating(" .. ii .. ")")
          else
            slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_Mating(" .. ii .. ")")
            slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 2, " .. slotNo .. " )")
          end
        end
      else
        local AuctionPrice64 = auctionServantInfo:getAuctoinPrice_s64()
        local isShowForceReturn = AuctionPrice64 == Defines.s64_const.s64_0
        local isMyServant = nil ~= stable_getServantByServantNo(auctionServantInfo:getServantNo())
        local isAuctionEnd = auctionServantInfo:isAuctionEnd()
        local showBuyRentFlag = not isAuctionEnd and not isMyServant
        local showCancelRentFlag = not isAuctionEnd and true == isMyServant
        local showReceiveRentFlag = true == isAuctionEnd
        local showReceiveReturnFlag = not isMyServant
        if self._ENUM_TAB_LEFT == self._currentTabIdx then
          if true == isShowForceReturn then
            slot._btn_Confirm_PC:SetShow(false)
            slot._btn_Cancel_PC:SetShow(true)
            slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_ForceRentReturn(" .. ii .. ")")
            if true == self._isConsole then
              slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_ForceRentReturn(" .. ii .. ")")
              slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 3, " .. slotNo .. " )")
            else
              slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_STABLE_PROMOTEAUTH_FORCEDRETURN"))
            end
          elseif true == showBuyRentFlag then
            slot._btn_Cancel_PC:SetShow(false)
            slot._btn_Confirm_PC:SetShow(true)
            slot._btn_Confirm_PC:SetText(makeDotMoney(auctionServantInfo:getAuctoinPrice_s64()))
            if true == self._isConsole then
              slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_BuyRent(" .. ii .. ",true)")
              slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 4, " .. slotNo .. " )")
            else
              slot._btn_Confirm_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_BuyRent(" .. ii .. ",true)")
            end
          elseif true == showReceiveRentFlag then
            slot._btn_Confirm_PC:SetShow(false)
            slot._btn_Cancel_PC:SetShow(true)
            slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTRENT_RECIEVEMONEYBUTTON"))
            if true == self._isConsole then
              slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveRental(" .. ii .. ",true)")
              slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 5, " .. slotNo .. " )")
            else
              slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveRental(" .. ii .. ",true)")
            end
          elseif true == showCancelRentFlag then
            slot._btn_Confirm_PC:SetShow(false)
            slot._btn_Cancel_PC:SetShow(true)
            slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
            if true == self._isConsole then
              slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",false)")
              slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 0, " .. slotNo .. " )")
            else
              slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_Cancel(" .. ii .. ",false)")
            end
          end
        elseif self._ENUM_TAB_CENTER == self._currentTabIdx then
          slot._btn_Confirm_PC:SetShow(false)
          slot._btn_Cancel_PC:SetShow(true)
          slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_BUTTON1"))
          if true == self._isConsole then
            slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_BuyReturn(" .. ii .. ")")
            self._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PROMOTEMARKET_BUTTON1"))
            slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 4, " .. slotNo .. " )")
          else
            slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_BuyReturn(" .. ii .. ")")
          end
        elseif true == showReceiveReturnFlag then
          slot._btn_Confirm_PC:SetShow(false)
          slot._btn_Cancel_PC:SetShow(true)
          slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTRENT_RECIEVEMONEYBUTTON"))
          if true == self._isConsole then
            slot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantMarket_Rental_Mating_All_BuyReturn(" .. ii .. ")")
            slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( 5, " .. slotNo .. " )")
          else
            slot._btn_Cancel_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantMarket_Rental_Mating_All_RecieveRental(" .. ii .. ", false)")
          end
        else
          slot._btn_Confirm_PC:SetShow(false)
          slot._btn_Cancel_PC:SetShow(true)
          slot._btn_Cancel_PC:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RENTALMATING_ALL_RECEIVE_WAIT"))
          slot._btn_Cancel_PC:SetIgnore(true)
          slot._slot:addInputEvent("Mouse_On", "PaGlobalFunc_ServantMarket_Rental_Mating_All_SetKeyguideText( nil, " .. slotNo .. " )")
        end
      end
      slotNo = slotNo + 1
    end
  end
  if false == self._isConsole then
    PaGlobal_ServantMarket_Rental_Mating_All:tooltipCheck()
  end
end
function PaGlobal_ServantMarket_Rental_Mating_All:tooltipCheck()
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tooltipCheckControl = self._ui._servantSlot[slotIdx]._tooltipControls
    for idx = 1, #tooltipCheckControl do
      if nil ~= tooltipCheckControl[idx] then
        tooltipCheckControl[idx]:SetTextMode(__eTextMode_LimitText)
        tooltipCheckControl[idx]:SetText(tooltipCheckControl[idx]:GetText())
        if true == tooltipCheckControl[idx]:IsLimitText() then
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_Dialog_ServantMarket_RentalMating_All_ShowToolTip(" .. slotIdx .. "," .. idx .. " , true)")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_Dialog_ServantMarket_RentalMating_All_ShowToolTip(" .. slotIdx .. "," .. idx .. " , false)")
        else
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "")
        end
      end
    end
  end
end
function PaGlobal_ServantMarket_Rental_Mating_All:list2Update(content, key, slotIdx)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == key or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
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
  local skillExpPercent = UI.getChildControl(content, "StaticText_SkillExpPercent")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local skillCommand = UI.getChildControl(content, "StaticText_SkillCommandValue")
  local actorKeyRaw = auctionServantInfo:getActorKeyRaw()
  local skillWrapper = auctionServantInfo:getSkill(key32)
  if nil ~= skillWrapper then
    skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    skillIcon:addInputEvent("Mouse_On", "HandleEventOn_AuctionServant_Tooltip_Open(" .. actorKeyRaw .. ", " .. key32 .. ", " .. slotIdx .. ")")
    skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantMarket_Rental_Mating_All_SkillTooltipHide()")
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
function PaGlobal_ServantMarket_Rental_Mating_All:AuctionServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All then
    return
  end
  local content = PaGlobal_ServantMarket_Rental_Mating_All._ui._servantSlot[slotIdx]._list2_Control:GetContentByKey(toInt64(0, key32))
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
function PaGlobal_ServantMarket_Rental_Mating_All:moneyUpdate()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
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
  self._ui._txt_Inven:SetSpanSize(self._ui._txt_Inven:GetTextSizeX() + 10, 0)
  self._ui._txt_Ware:SetSpanSize(self._ui._txt_Ware:GetTextSizeX() + 10, 0)
  self._ui._txt_Inven:ComputePos()
  self._ui._txt_Ware:ComputePos()
  local warehouseMoneyEnabledFlag = wareMoney > Defines.s64_const.s64_0
  self._ui._txt_Ware:SetEnable(warehouseMoneyEnabledFlag)
end
function PaGlobal_ServantMarket_Rental_Mating_All:dataClear()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  self._selectSlotNo = nil
  self._selectPage = 0
  self._selectMaxPage = 0
end
function PaGlobal_ServantMarket_Rental_Mating_All:prepareClose()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_ServantMarket_Rental_Mating_All:dataClear()
  Panel_Dialog_ServantMarket_Rental_Mating_All:ClearUpdateLuaFunc()
  HandleEventOut_ServantMarket_Rental_Mating_All_SkillTooltipHide()
  PaGlobal_ServantMarket_Rental_Mating_All:close()
end
function PaGlobal_ServantMarket_Rental_Mating_All:close()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All or false == Panel_Dialog_ServantMarket_Rental_Mating_All:GetShow() then
    return
  end
  Panel_Dialog_ServantMarket_Rental_Mating_All:SetShow(false)
end
function PaGlobal_ServantMarket_Rental_Mating_All:validate()
  if nil == Panel_Dialog_ServantMarket_Rental_Mating_All then
    return
  end
  self._ui._stc_TitleBg:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_TabGroup:isValidate()
  self._ui._rdo_Tab_Left:isValidate()
  self._ui._rdo_Tab_Center:isValidate()
  self._ui._rdo_Tab_Right:isValidate()
  self._ui._stc_SelectedLine:isValidate()
  self._ui._stc_KeyGuide_LT:isValidate()
  self._ui._stc_KeyGuide_RT:isValidate()
  self._ui._stc_PageBg:isValidate()
  self._ui._txt_PageValue:isValidate()
  self._ui._btn_PageLeft_PC:isValidate()
  self._ui._btn_PageRight_PC:isValidate()
  self._ui._stc_PageLeft_Console:isValidate()
  self._ui._stc_PageRight_Console:isValidate()
  self._ui._btn_Reload_PC:isValidate()
  self._ui._txt_InvenTitle:isValidate()
  self._ui._txt_Inven:isValidate()
  self._ui._txt_WareTitle:isValidate()
  self._ui._txt_Ware:isValidate()
  self._ui._stc_SkillTooltip:isValidate()
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
    self._ui._servantSlot[slotIdx]._btn_Confirm_PC:isValidate()
    self._ui._servantSlot[slotIdx]._btn_Cancel_PC:isValidate()
    self._ui._servantSlot[slotIdx]._list2_Control:isValidate()
    self._ui._servantSlot[slotIdx]._txt_learnedSkillCount:isValidate()
  end
  self._initailize = true
end
