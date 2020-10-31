function PaGlobal_ServantExchange_All:initialize()
  if nil == Panel_Dialog_ServantExchange_All or true == self._initailize then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_ServantExchange_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Button_Close")
  self._ui._btn_Question_PC = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Button_Question")
  self._ui._btn_Exchange_PC = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Button_Exchange")
  self._ui._btn_Cancel_PC = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Button_Cancel")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Static_Bg")
  self._ui._stc_Exchange_Bg = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Static_ExchangeBg")
  self._ui._txt_TopDesc = UI.getChildControl(self._ui._stc_Exchange_Bg, "StaticText_TopDesc")
  self._ui._stc_LeftBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_LeftBg")
  self._ui._stc_LeftImage = UI.getChildControl(self._ui._stc_LeftBg, "Static_Image")
  self._ui._stc_LeftGenderIcon = UI.getChildControl(self._ui._stc_LeftBg, "Static_GenderIcon")
  self._ui._stc_LeftSwitftIcon = UI.getChildControl(self._ui._stc_LeftBg, "Static_SwiftIcon")
  self._ui._txt_LeftTier = UI.getChildControl(self._ui._stc_LeftBg, "StaticText_Tier")
  self._ui._txt_LeftName = UI.getChildControl(self._ui._stc_LeftBg, "StaticText_Name")
  self._ui._stc_RightBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_RightBg")
  self._ui._stc_RightImage = UI.getChildControl(self._ui._stc_RightBg, "Static_Image")
  self._ui._stc_RightGenderIcon = UI.getChildControl(self._ui._stc_RightBg, "Static_GenderIcon")
  self._ui._stc_RightSwitftIcon = UI.getChildControl(self._ui._stc_RightBg, "Static_SwiftIcon")
  self._ui._txt_RightTier = UI.getChildControl(self._ui._stc_RightBg, "StaticText_Tier")
  self._ui._txt_RightName = UI.getChildControl(self._ui._stc_RightBg, "StaticText_Name")
  self._ui._stc_ExchangeDeco = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_ExchangeDeco")
  self._ui._rdo_Inven = UI.getChildControl(self._ui._stc_Exchange_Bg, "RadioButton_Inven")
  self._ui._txt_InvenMoney = UI.getChildControl(self._ui._rdo_Inven, "StaticText_InvenMoney")
  self._ui._rdo_Ware = UI.getChildControl(self._ui._stc_Exchange_Bg, "RadioButton_Warehouse")
  self._ui._txt_WareMoney = UI.getChildControl(self._ui._rdo_Ware, "StaticText_WarehouseMoney")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_ServantExchange_All, "List2_Servant")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_Btn_List = UI.getChildControl(self._ui._list2_Content, "Button_List")
  self._ui._list2_Image = UI.getChildControl(self._ui._list2_Content, "Static_Image")
  self._ui._list2_GenderIcon = UI.getChildControl(self._ui._list2_Content, "Static_GenderIcon")
  self._ui._list2_ServantName = UI.getChildControl(self._ui._list2_Content, "StaticText_ServantName")
  self._ui._list2_Tier = UI.getChildControl(self._ui._list2_Content, "StaticText_Tier")
  self._ui._list2_SwiftHorse = UI.getChildControl(self._ui._list2_Content, "Static_SwiftHorseIcon")
  self._ui._list2_Txt_NoHorse = UI.getChildControl(self._ui._list2_Servant, "StaticText_NoHorse")
  self._ui._list2_Verti_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_VerticalScroll")
  self._ui._list2_Verti_Scroll_Up = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Verti_Scroll_Down = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Verti_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_Hori_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_HorizontalScroll")
  self._ui._list2_Hori_Scroll_Up = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_Hori_Scroll_Down = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_Hori_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._edit_Naming = UI.getChildControl(self._ui._stc_Exchange_Bg, "Edit_Naming")
  self._ui._stc_ExchangeBg = UI.getChildControl(self._ui._stc_Exchange_Bg, "Static_ExchangeCost")
  self._ui._txt_ExchangeMoneyTitle = UI.getChildControl(self._ui._stc_ExchangeBg, "StaticText_MoneyTitle")
  self._ui._txt_ExchangeMoneyValue = UI.getChildControl(self._ui._stc_ExchangeBg, "StaticText_MoneyValue")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._edit_Naming, "StaticText_X_ConsoleUI")
  self._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Dialog_ServantExchange_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_Y_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantExchange_All:validate()
  PaGlobal_ServantExchange_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantExchange_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantExchange_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantExchange_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantExchange_All_OnScreenResize")
  registerEvent("FromClient_ServantMix", "FromClient_ServantExchange_All_ServantExchangeFinish")
  self._ui._edit_Naming:SetMaxInput(getGameServiceTypeServantNameLength())
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantExchange_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_Question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableShop\" )")
    self._ui._stc_LeftBg:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantExchange_All_ClearSlot(1)")
    self._ui._stc_LeftImage:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantExchange_All_ClearSlot(1)")
    self._ui._stc_RightBg:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantExchange_All_ClearSlot(2)")
    self._ui._stc_RightImage:addInputEvent("Mouse_RUp", "HandleEventLUp_ServantExchange_All_ClearSlot(2)")
    self._ui._btn_Cancel_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_Exchange_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_All_MixConfirm()")
    self._ui._edit_Naming:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_All_EditClick()")
    self._ui._edit_Naming:RegistReturnKeyEvent("HandleEventLUp_ServantExchange_All_MixConfirm()")
  else
    self._ui._stc_LeftBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantExchange_All_ClearSlot(1)")
    self._ui._stc_RightBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ServantExchange_All_ClearSlot(2)")
    self._ui._btn_Cancel_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
    self._ui._btn_Exchange_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_All_MixConfirm()")
    Panel_Dialog_ServantExchange_All:ignorePadSnapMoveToOtherPanel()
    self._ui._edit_Naming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantExchange_All_CloseVirtualKeyboard()")
    Panel_Dialog_ServantExchange_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantFunction_All_ChangeTab(false)")
    Panel_Dialog_ServantExchange_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantFunction_All_ChangeTab(true)")
    Panel_Dialog_ServantExchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ServantExchange_All_OpenVirtualKeyboard()")
    Panel_Dialog_ServantExchange_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantExchange_All_MixConfirm()")
  end
end
function PaGlobal_ServantExchange_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantExchange_All or false == self._initailize then
    return
  end
  Panel_Dialog_ServantExchange_All:SetDragEnable(not isConsole)
  Panel_Dialog_ServantExchange_All:SetDragAll(not isConsole)
  self._ui._btn_Question_PC:SetShow(not isConsole and false == _ContentsOption_CH_WepHelperControl)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._btn_Exchange_PC:SetShow(not isConsole)
  self._ui._btn_Cancel_PC:SetShow(not isConsole)
  self._ui._stc_KeyGuide_X:SetShow(isConsole)
  self._ui._stc_Bottom_KeyGuide:SetShow(isConsole)
  self._ui._stc_KeyGuide_Y:SetShow(isConsole)
  self._ui._stc_KeyGuide_A:SetShow(isConsole)
  self._ui._stc_KeyGuide_B:SetShow(isConsole)
  if true == isConsole then
    local btnSize = self._ui._btn_Exchange_PC:GetSizeY()
    Panel_Dialog_ServantExchange_All:SetSize(Panel_Dialog_ServantExchange_All:GetSizeX(), Panel_Dialog_ServantExchange_All:GetSizeY() - (btnSize + 10))
    self._ui._stc_Bg:SetSize(self._ui._stc_Bg:GetSizeX(), self._ui._stc_Bg:GetSizeY() - (btnSize + 10))
    self._ui._list2_Servant:SetSize(self._ui._list2_Servant:GetSizeX(), self._ui._stc_Bg:GetSizeY())
    local keyguide = {
      self._ui._stc_KeyGuide_Y,
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_Bottom_KeyGuide:SetSpanSize(self._ui._stc_Bottom_KeyGuide:GetSpanSize().x, self._ui._stc_Bottom_KeyGuide:GetSpanSize().y)
  end
end
function PaGlobal_ServantExchange_All:prepareOpen()
  if nil == Panel_Dialog_ServantExchange_All or true == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  self._ui._rdo_Ware:SetCheck(true)
  self._ui._rdo_Inven:SetCheck(false)
  self._ui._stc_ExchangeBg:SetShow(false)
  self._ui._edit_Naming:SetShow(true)
  self._ui._edit_Naming:SetIgnore(true)
  if false == self._isConsole then
    self._ui._edit_Naming:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTREGIST_EDITDESC"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._edit_Naming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  PaGlobal_ServantExchange_All:open()
  FromClient_ServantExchange_All_OnScreenResize()
  PaGlobal_ServantExchange_All:dataClear()
  PaGlobal_ServantExchange_All:update()
end
function PaGlobal_ServantExchange_All:open()
  if nil == Panel_Dialog_ServantExchange_All or true == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  Panel_Dialog_ServantExchange_All:SetShow(true)
end
function PaGlobal_ServantExchange_All:update()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_All:moneyUpdate()
  PaGlobal_ServantExchange_All:matingUpdate()
  PaGlobal_ServantExchange_All:pushList2()
end
function PaGlobal_ServantExchange_All:pushList2()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  local servantCount = stable_count()
  self._ui._list2_Txt_NoHorse:SetShow(false)
  self._ui._btn_Exchange_PC:SetMonoTone(false)
  self._ui._btn_Exchange_PC:SetIgnore(false)
  if servantCount <= 0 then
    self._ui._list2_Txt_NoHorse:SetText(true)
    self._ui._btn_Exchange_PC:SetMonoTone(true)
    self._ui._btn_Exchange_PC:SetIgnore(true)
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  self._currentRegionName = regionInfo:getAreaName()
  self._servantDataTable = {}
  self._ui._list2_Servant:getElementManager():clearKey()
  for ii = 0, servantCount - 1 do
    local servantInfo = stable_getServant(ii)
    if nil ~= servantInfo then
      local servantRegionName = servantInfo:getRegionName()
      local CurrentState = servantInfo:getStateType()
      if CppEnums.VehicleType.Type_Horse ~= servantInfo:getVehicleType() or servantRegionName ~= self._currentRegionName or servantInfo:isSeized() or CppEnums.ServantStateType.Type_RegisterMarket == CurrentState or CppEnums.ServantStateType.Type_RegisterMating == CurrentState or CppEnums.ServantStateType.Type_Mating == CurrentState or servantInfo:isMatingComplete() or CppEnums.ServantStateType.Type_Coma == CurrentState or CppEnums.ServantStateType.Type_SkillTraining == CurrentState or servantInfo:isLink() or Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo() or CppEnums.ServantStateType.Type_Rent == CurrentState or CppEnums.ServantStateType.Type_Return == CurrentState or 8 < servantInfo:getTier() then
      else
        local servantNo = servantInfo:getServantNo()
        local servantData = {_servantNo = nil, _servantIndex = nil}
        servantData._servantNo = servantNo
        servantData._servantIndex = ii
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, ii))
        self._servantDataTable[ii] = servantData
      end
    end
  end
end
function PaGlobal_ServantExchange_All:list2Update(content, key)
  if nil == Panel_Dialog_ServantExchange_All or nil == key or nil == self._servantDataTable or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local btn_List = UI.getChildControl(content, "Button_List")
  local stc_image = UI.getChildControl(content, "Static_Image")
  local stc_genderIcon = UI.getChildControl(content, "Static_GenderIcon")
  local txt_servantName = UI.getChildControl(content, "StaticText_ServantName")
  local txt_tier = UI.getChildControl(content, "StaticText_Tier")
  local txt_leftCount = UI.getChildControl(content, "StaticText_State")
  local stc_swiftHorse = UI.getChildControl(content, "Static_SwiftHorseIcon")
  content:SetShow(false)
  if nil ~= self._servantDataTable[key32] then
    local servantIndex = self._servantDataTable[key32]._servantIndex
    local servantNo = self._servantDataTable[key32]._servnatNo
    local servantInfo = stable_getServant(servantIndex)
    if nil == servantInfo then
      return
    end
    content:SetShow(true)
    local isMale = servantInfo:isMale()
    local name = servantInfo:getName()
    local tier = servantInfo:getTier()
    local stallion = servantInfo:isStallion()
    local level = servantInfo:getLevel()
    stc_image:ChangeTextureInfoName(servantInfo:getIconPath1())
    if true == isMale then
      stc_genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(stc_genderIcon, 1, 209, 31, 239)
      stc_genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_genderIcon:setRenderTexture(stc_genderIcon:getBaseTexture())
      btn_List:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_All_SelectServant(true ," .. key32 .. ")")
    else
      stc_genderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(stc_genderIcon, 1, 178, 31, 208)
      stc_genderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_genderIcon:setRenderTexture(stc_genderIcon:getBaseTexture())
      btn_List:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantExchange_All_SelectServant(false ," .. key32 .. ")")
    end
    txt_servantName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. level .. " " .. name)
    txt_tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", tier))
    local leftCount = servantInfo:getMatingCount()
    local leftCountString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMATING_MATINGCOUNT")
    txt_leftCount:SetText(leftCountString .. " " .. leftCount)
    if true == self._isConsole then
      stc_swiftHorse:SetShow(false)
    else
      stc_swiftHorse:SetShow(true)
      if true == stallion then
        stc_swiftHorse:SetMonoTone(false, false)
      else
        stc_swiftHorse:SetMonoTone(true, true)
      end
    end
  end
end
function PaGlobal_ServantExchange_All:moneyUpdate()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local invenMoney = selfPlayer:get():getInventory():getMoney_s64()
  local wareMoney = warehouse_moneyFromNpcShop_s64()
  self._ui._txt_InvenMoney:SetText(makeDotMoney(invenMoney))
  self._ui._txt_WareMoney:SetText(makeDotMoney(wareMoney))
  local warehouseMoneyEnabledFlag = wareMoney > Defines.s64_const.s64_0
  self._ui._rdo_Ware:SetEnable(warehouseMoneyEnabledFlag)
  self._ui._rdo_Ware:SetIgnore(not warehouseMoneyEnabledFlag)
  if false == warehouseMoneyEnabledFlag then
    self._ui._rdo_Inven:SetCheck(true)
    self._ui._rdo_Ware:SetCheck(false)
  end
end
function PaGlobal_ServantExchange_All:matingUpdate()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  local matingPrice = getServantSelfMatingPrice()
  local servantInfo_Right, servantInfo_Left
  if nil ~= self._servantNo_Left then
    servantInfo_Left = stable_getServantByServantNo(self._servantNo_Left)
    if nil ~= servantInfo_Left then
      self._ui._stc_LeftImage:ReleaseTexture()
      self._ui._stc_LeftImage:ChangeTextureInfoName(servantInfo_Left:getIconPath1())
      self._ui._stc_LeftSwitftIcon:SetShow(false)
      if true == self._isContentsStallionEnable then
        self._ui._stc_LeftSwitftIcon:SetShow(true)
        local isStallion = servantInfo_Left:isStallion()
        if true == isStallion then
          self._ui._stc_LeftSwitftIcon:SetMonoTone(false, false)
        else
          self._ui._stc_LeftSwitftIcon:SetMonoTone(true, true)
        end
      end
      self._ui._txt_LeftTier:SetShow(false)
      self._ui._txt_LeftTier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo_Left:getTier()))
      self._ui._txt_LeftName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. servantInfo_Left:getLevel() .. " " .. servantInfo_Left:getName())
    end
  end
  if nil ~= self._servantNo_Right then
    servantInfo_Right = stable_getServantByServantNo(self._servantNo_Right)
    if nil ~= servantInfo_Right then
      self._ui._stc_RightImage:ReleaseTexture()
      self._ui._stc_RightImage:ChangeTextureInfoName(servantInfo_Right:getIconPath1())
      self._ui._stc_RightSwitftIcon:SetShow(false)
      if true == self._isContentsStallionEnable then
        self._ui._stc_RightSwitftIcon:SetShow(true)
        local isStallion = servantInfo_Right:isStallion()
        if true == isStallion then
          self._ui._stc_RightSwitftIcon:SetMonoTone(false, false)
        else
          self._ui._stc_RightSwitftIcon:SetMonoTone(true, true)
        end
      end
      self._ui._txt_RightTier:SetShow(false)
      self._ui._txt_RightTier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo_Right:getTier()))
      self._ui._txt_RightName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. servantInfo_Right:getLevel() .. " " .. servantInfo_Right:getName())
    end
  end
  if nil ~= servantInfo_Right and nil ~= servantInfo_Left and true == self._isConsole then
    HandleEventLUp_ServantExchange_All_EditClick()
  end
end
function PaGlobal_ServantExchange_All:dataClear()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  self._currentRegionName = nil
  self._servantNo_Left = nil
  self._ui._stc_LeftImage:ReleaseTexture()
  self._ui._stc_LeftImage:ChangeTextureInfoNameAsync("")
  self._ui._txt_LeftName:SetText("")
  self._ui._stc_LeftSwitftIcon:SetShow(false)
  self._ui._txt_LeftTier:SetShow(false)
  self._servantNo_Right = nil
  self._ui._stc_RightImage:ReleaseTexture()
  self._ui._stc_RightImage:ChangeTextureInfoNameAsync("")
  self._ui._txt_RightName:SetText("")
  self._ui._stc_RightSwitftIcon:SetShow(false)
  self._ui._txt_RightTier:SetShow(false)
end
function PaGlobal_ServantExchange_All:prepareClose()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_All:dataClear()
  PaGlobal_ServantExchange_All:close()
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Dialog_ServantList_All)
  end
end
function PaGlobal_ServantExchange_All:close()
  if nil == Panel_Dialog_ServantExchange_All or false == Panel_Dialog_ServantExchange_All:GetShow() then
    return
  end
  Panel_Dialog_ServantExchange_All:SetShow(false)
end
function PaGlobal_ServantExchange_All:validate()
  if nil == Panel_Dialog_ServantExchange_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_Question_PC:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._stc_Exchange_Bg:isValidate()
  self._ui._txt_TopDesc:isValidate()
  self._ui._stc_LeftBg:isValidate()
  self._ui._stc_LeftImage:isValidate()
  self._ui._stc_LeftGenderIcon:isValidate()
  self._ui._stc_LeftSwitftIcon:isValidate()
  self._ui._txt_LeftTier:isValidate()
  self._ui._txt_LeftName:isValidate()
  self._ui._stc_RightBg:isValidate()
  self._ui._stc_RightImage:isValidate()
  self._ui._stc_RightGenderIcon:isValidate()
  self._ui._stc_RightSwitftIcon:isValidate()
  self._ui._txt_RightTier:isValidate()
  self._ui._txt_RightName:isValidate()
  self._ui._stc_ExchangeDeco:isValidate()
  self._ui._rdo_Inven:isValidate()
  self._ui._txt_InvenMoney:isValidate()
  self._ui._rdo_Ware:isValidate()
  self._ui._txt_WareMoney:isValidate()
  self._ui._btn_Exchange_PC:isValidate()
  self._ui._btn_Cancel_PC:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_Btn_List:isValidate()
  self._ui._list2_Image:isValidate()
  self._ui._list2_GenderIcon:isValidate()
  self._ui._list2_ServantName:isValidate()
  self._ui._list2_Tier:isValidate()
  self._ui._list2_SwiftHorse:isValidate()
  self._ui._list2_Verti_Scroll:isValidate()
  self._ui._list2_Verti_Scroll_Up:isValidate()
  self._ui._list2_Verti_Scroll_Down:isValidate()
  self._ui._list2_Verti_Scroll_Ctrl:isValidate()
  self._ui._list2_Hori_Scroll:isValidate()
  self._ui._list2_Hori_Scroll_Up:isValidate()
  self._ui._list2_Hori_Scroll_Down:isValidate()
  self._ui._list2_Hori_Scroll_Ctrl:isValidate()
  self._ui._list2_Txt_NoHorse:isValidate()
  self._ui._stc_ExchangeBg:isValidate()
  self._ui._txt_ExchangeMoneyTitle:isValidate()
  self._ui._txt_ExchangeMoneyValue:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_Bottom_KeyGuide:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._initailize = true
end
