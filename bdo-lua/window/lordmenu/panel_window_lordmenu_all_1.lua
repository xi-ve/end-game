function PaGlobal_LordMenu_All:initialize()
  if nil == Panel_Window_LordMenu_All or true == self._initialize then
    return
  end
  self._ui._titleArea._stc_TitleArea = UI.getChildControl(Panel_Window_LordMenu_All, "Static_TitleArea")
  self._ui._titleArea._txt_Title = UI.getChildControl(self._ui._titleArea._stc_TitleArea, "StaticText_TitleValue")
  self._ui._titleArea._btn_Question_PC = UI.getChildControl(self._ui._titleArea._stc_TitleArea, "Button_Question")
  self._ui._titleArea._btn_Close_PC = UI.getChildControl(self._ui._titleArea._stc_TitleArea, "Button_Close")
  self._ui._titleArea._stc_TopLine = UI.getChildControl(self._ui._titleArea._stc_TitleArea, "Static_TopLine")
  self._ui._titleArea._stc_TabBtnBar = UI.getChildControl(self._ui._titleArea._stc_TitleArea, "Static_TabBtnBar")
  self._ui._console_TopBg._stc_TopBg_ConsoleUI = UI.getChildControl(Panel_Window_LordMenu_All, "Static_TopBG_ConsoleUI")
  self._ui._console_TopBg._btn_Tab_Territory_ConSole = UI.getChildControl(self._ui._console_TopBg._stc_TopBg_ConsoleUI, "RadioButton_Tab_Territory")
  self._ui._console_TopBg._btn_Tab_Collection_Console = UI.getChildControl(self._ui._console_TopBg._stc_TopBg_ConsoleUI, "RadioButton_Tab_Collection")
  self._ui._console_TopBg._btn_Tab_AdjustTaxRate_Console = UI.getChildControl(self._ui._console_TopBg._stc_TopBg_ConsoleUI, "RadioButton_Tab_AdjustRate")
  self._ui._console_TopBg._stc_KeyGuide_RB = UI.getChildControl(self._ui._console_TopBg._stc_TopBg_ConsoleUI, "Static_LB")
  self._ui._console_TopBg._stc_KeyGuide_LB = UI.getChildControl(self._ui._console_TopBg._stc_TopBg_ConsoleUI, "Static_RB")
  self._ui._pc_TopBg._stc_TopBg_PCUI = UI.getChildControl(Panel_Window_LordMenu_All, "Static_TopBG_PCUI")
  self._ui._pc_TopBg._btn_Tab_Territory_PC = UI.getChildControl(self._ui._pc_TopBg._stc_TopBg_PCUI, "RadioButton_Tab_Territory")
  self._ui._pc_TopBg._btn_Tab_Collection_PC = UI.getChildControl(self._ui._pc_TopBg._stc_TopBg_PCUI, "RadioButton_Tab_Collection")
  self._ui._pc_TopBg._btn_Tab_AdjustTaxRate_PC = UI.getChildControl(self._ui._pc_TopBg._stc_TopBg_PCUI, "RadioButton_Tab_AdjustRate")
  self._ui._lordInfoArea._stc_LordInfoArea = UI.getChildControl(Panel_Window_LordMenu_All, "Static_LordInfoArea")
  self._ui._lordInfoArea._stc_LordInfoTopArea = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoArea, "Static_LordInfoTopArea")
  self._ui._lordInfoArea._stc_LordInfoMidLine = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "Static_MiddleLine")
  self._ui._lordInfoArea._txt_LordInfoTitle = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_LordInfoTitle")
  self._ui._lordInfoArea._txt_GuildName = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_GuildName")
  self._ui._lordInfoArea._txt_GuildMasterName = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_GuildMasterName")
  self._ui._lordInfoArea._txt_OccupationDate = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_OccupationDate")
  self._ui._lordInfoArea._txt_CivilStabilty = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_CivilStability")
  self._ui._lordInfoArea._txt_Population = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_Population")
  self._ui._lordInfoArea._stc_SubFrame1 = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "Static_SubFrame1")
  self._ui._lordInfoArea._txt_Desc = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "StaticText_Desc")
  self._ui._lordInfoArea._stc_GuildMarkBg = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoTopArea, "Static_GuildMarkBG")
  self._ui._lordInfoArea._stc_GuildMarkBack = UI.getChildControl(self._ui._lordInfoArea._stc_GuildMarkBg, "Static_GuildMarkBack")
  self._ui._lordInfoArea._stc_GuildMark = UI.getChildControl(self._ui._lordInfoArea._stc_GuildMarkBg, "Static_GuildMark")
  self._ui._lordInfoArea._stc_LordInfoBottomArea = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoArea, "Static_LordInfoBottomArea")
  self._ui._lordInfoArea._txt_LordInfoTitle = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoBottomArea, "StaticText_LordInfoTitle")
  self._ui._lordInfoArea._stc_SubFrame2 = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoBottomArea, "Static_SubFrame2")
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoBottomArea, "StaticText_Desc")
  self._ui._lordInfoArea._stc_LordInfo_ProgressArea = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfoBottomArea, "Static_ProgressArea")
  self._ui._lordInfoArea._stc_LordInfo_ProgressBg = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfo_ProgressArea, "Static_ProgressBG")
  self._ui._lordInfoArea._txt_Happy_Value = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfo_ProgressArea, "StaticText_HappyValue")
  self._ui._lordInfoArea._prog2_Happy = UI.getChildControl(self._ui._lordInfoArea._stc_LordInfo_ProgressArea, "Progress2_Happy")
  self._ui._lordInfoArea._prog2_Happy_Bar_Head = UI.getChildControl(self._ui._lordInfoArea._prog2_Happy, "Progress2_1_Bar_Head")
  self._ui._lordTaxInfo._stc_LordTaxInfoArea = UI.getChildControl(Panel_Window_LordMenu_All, "Static_LordTaxInfoArea")
  self._ui._lordTaxInfo._stc_LordTaxInfoTitle = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "StaticText_SubTitle")
  self._ui._lordTaxInfo._stc_LordTaxHoriLine = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "Static_HorizonLine")
  self._ui._lordTaxInfo._txt_LordTax_Desc = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "StaticText_Desc")
  self._ui._lordTaxInfo._txt_LordTax_RedDesc = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "StaticText_RedDesc")
  self._ui._lordTaxInfo._txt_LordTax_BlueDesc = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "StaticText_BlueDesc")
  self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "Static_GraphArea")
  self._ui._lordTaxInfo._stc_LordTaxInfo_Blue_Bg = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "Static_BlueBG")
  self._ui._lordTaxInfo._stc_LordTaxInfo_Red_Bg = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "Static_RedBG")
  self._ui._lordTaxInfo._txt_Trade_Tax = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "StaticText_TradeTax")
  self._ui._lordTaxInfo._txt_Trade_Tax_Money = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "StaticText_TradeTaxMoney")
  self._ui._lordTaxInfo._prog2_TransferTax_NowBar = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "Progress2_TransferTax_Now")
  self._ui._lordTaxInfo._prog2_TransferTax_NowBar_Head = UI.getChildControl(self._ui._lordTaxInfo._prog2_TransferTax_NowBar, "Progress2_1_Bar_Head")
  self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea, "Progress2_TransferTax_Bef")
  self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar_Head = UI.getChildControl(self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar, "Progress2_2_Bar_Head")
  self._ui._lordTaxInfo._stc_BottomMoneyArea = UI.getChildControl(self._ui._lordTaxInfo._stc_LordTaxInfoArea, "Static_BottomMoneyArea")
  self._ui._lordTaxInfo._txt_BottomMoney_Title = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_BottomSubTitle")
  self._ui._lordTaxInfo._stc_BottomMoney_TopLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_TopHorizonLine")
  self._ui._lordTaxInfo._stc_BottomMoney_Mid_TopLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_MiddleTopHorizonLine")
  self._ui._lordTaxInfo._stc_BottomMoney_Mid_BotLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_MiddleBottomHorizonLine")
  self._ui._lordTaxInfo._stc_BottomMoney_BotLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_BottomHorizonLine")
  self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_LeftVerticalLine")
  self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "Static_RightVerticalLine")
  self._ui._lordTaxInfo._txt_BottomMoney_BalanceTitle = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_Balance")
  self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxTitle = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_LocalTax")
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityBudgetTitle = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_SecurityBudget")
  self._ui._lordTaxInfo._txt_BottomMoney_BalanceMoney = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_BalanceMoney")
  self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_LocalTaxMoney")
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney = UI.getChildControl(self._ui._lordTaxInfo._stc_BottomMoneyArea, "StaticText_SecurityMoney")
  self._ui._lordTaxSet._stc_TaxSetArea = UI.getChildControl(Panel_Window_LordMenu_All, "Static_LordTaxSetArea")
  self._ui._lordTaxSet._stc_TaxSetArea_Title = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "StaticText_SubTitle")
  self._ui._lordTaxSet._stc_TradeTaxArea = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "Static_TradeTaxArea")
  self._ui._lordTaxSet._stc_TradeTaxSubTitle = UI.getChildControl(self._ui._lordTaxSet._stc_TradeTaxArea, "StaticText_TradeTax")
  self._ui._lordTaxSet._stc_TradeTax_LowPercent = UI.getChildControl(self._ui._lordTaxSet._stc_TradeTaxArea, "StaticText_LowPercent")
  self._ui._lordTaxSet._stc_TradeTax_HighPercent = UI.getChildControl(self._ui._lordTaxSet._stc_TradeTaxArea, "StaticText_HighPercent")
  self._ui._lordTaxSet._stc_TradeTax_ProgressBg = UI.getChildControl(self._ui._lordTaxSet._stc_TradeTaxArea, "Static_TradeTaxProgressBG")
  self._ui._lordTaxSet._stc_TradeTax_Desc = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "StaticText_TopDesc")
  self._ui._lordTaxSet._slider_TradeTax = UI.getChildControl(self._ui._lordTaxSet._stc_TradeTaxArea, "Slider_TradeTax")
  self._ui._lordTaxSet._btn_Slider_TradeTax = UI.getChildControl(self._ui._lordTaxSet._slider_TradeTax, "Slider_1_Button")
  self._ui._lordTaxSet._stc_HorizonLine = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "Static_HorizonLine")
  self._ui._lordTaxSet._txt_LocalTaxTitle = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "StaticText_BottomSubTitle")
  self._ui._lordTaxSet._stc_LocalTaxArea = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "Static_LocalTaxArea")
  self._ui._lordTaxSet._txt_LocalTaxSubTitle = UI.getChildControl(self._ui._lordTaxSet._stc_LocalTaxArea, "StaticText_TradeTax")
  self._ui._lordTaxSet._txt_LocalTax_LowPercent = UI.getChildControl(self._ui._lordTaxSet._stc_LocalTaxArea, "StaticText_LowPercent")
  self._ui._lordTaxSet._stc_LocalTax_ProgressBg = UI.getChildControl(self._ui._lordTaxSet._stc_LocalTaxArea, "Static_TradeTaxProgressBG")
  self._ui._lordTaxSet._txt_LocalTax_HighPercent = UI.getChildControl(self._ui._lordTaxSet._stc_LocalTaxArea, "StaticText_HighPercent")
  self._ui._lordTaxSet._slider_LocalTax = UI.getChildControl(self._ui._lordTaxSet._stc_LocalTaxArea, "Slider_TradeTax")
  self._ui._lordTaxSet._btn_Slider_localTaxTitle = UI.getChildControl(self._ui._lordTaxSet._slider_LocalTax, "Slider_1_Button")
  self._ui._lordTaxSet._stc_RSKeyguide = UI.getChildControl(self._ui._lordTaxSet._btn_Slider_localTaxTitle, "StaticText_KeyGuideTemplete")
  self._ui._lordTaxSet._btn_AllTaxRateSet = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "Button_Set")
  self._ui._lordTaxSet._btn_AllReset = UI.getChildControl(self._ui._lordTaxSet._stc_TaxSetArea, "Button_Reset")
  self._ui._lordTaxSet._stc_LocalTaxArea:SetShow(false)
  self._ui._console_BotBg._stc_Bottom_KeyGuides = UI.getChildControl(Panel_Window_LordMenu_All, "Static_BottomConsoleButtons")
  self._ui._console_BotBg._stc_KeyGuide_Reset = UI.getChildControl(self._ui._console_BotBg._stc_Bottom_KeyGuides, "Button_Reset")
  self._ui._console_BotBg._stc_KeyGuide_Apply = UI.getChildControl(self._ui._console_BotBg._stc_Bottom_KeyGuides, "Button_Apply")
  self._ui._console_BotBg._stc_KeyGuide_Cancel = UI.getChildControl(self._ui._console_BotBg._stc_Bottom_KeyGuides, "Button_Cancel")
  self._originLeftLineSize = self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:GetSizeY()
  self._originRightLineSize = self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:GetSizeY()
  self._originSecurityBudgetTextPosY = self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:GetSpanSize().y
  self._originPanelSizeY = Panel_Window_LordMenu_All:GetSizeY()
  self._originTerritoryInfoButtonSpanX = self._ui._pc_TopBg._btn_Tab_Territory_PC:GetSpanSize().x
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_LordMenu_All:validate()
  PaGlobal_LordMenu_All:isConsoleUI(self._isConsole)
  PaGlobal_LordMenu_All:registerEventHandler()
  PaGlobal_LordMenu_All:copyLocalTaxSlider()
end
function PaGlobal_LordMenu_All:isConsoleUI(isConsole)
  if nil == Panel_Window_LordMenu_All or false == self._initialize then
    return
  end
  self._ui._titleArea._btn_Question_PC:SetShow(not isConsole)
  self._ui._titleArea._btn_Close_PC:SetShow(not isConsole)
  self._ui._pc_TopBg._stc_TopBg_PCUI:SetShow(not isConsole)
  self._ui._lordTaxSet._btn_AllTaxRateSet:SetShow(not isConsole)
  self._ui._lordTaxSet._btn_AllReset:SetShow(not isConsole)
  self._ui._lordTaxSet._stc_RSKeyguide:SetShow(isConsole)
  self._ui._console_TopBg._stc_TopBg_ConsoleUI:SetShow(isConsole)
  self._ui._console_BotBg._stc_Bottom_KeyGuides:SetShow(isConsole)
  if false == isConsole then
    self._loadMenuTabs[0] = self._ui._pc_TopBg._btn_Tab_Territory_PC
    self._loadMenuTabs[1] = self._ui._pc_TopBg._btn_Tab_Collection_PC
    self._loadMenuTabs[2] = self._ui._pc_TopBg._btn_Tab_AdjustTaxRate_PC
  else
    self._loadMenuTabs[0] = self._ui._console_TopBg._btn_Tab_Territory_ConSole
    self._loadMenuTabs[1] = self._ui._console_TopBg._btn_Tab_Collection_Console
    self._loadMenuTabs[2] = self._ui._console_TopBg._btn_Tab_AdjustTaxRate_Console
    local keyGuides = {
      self._ui._console_BotBg._stc_KeyGuide_Reset,
      self._ui._console_BotBg._stc_KeyGuide_Apply,
      self._ui._console_BotBg._stc_KeyGuide_Cancel
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._console_BotBg._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_LordMenu_All:registerEventHandler()
  if nil == Panel_Window_LordMenu_All or false == self._initialize then
    return
  end
  Panel_Window_LordMenu_All:RegisterShowEventFunc(true, "PaGlobalFunc_LordMenu_All_ShowAni()")
  Panel_Window_LordMenu_All:RegisterShowEventFunc(false, "PaGlobalFunc_LordMenu_All_HideAni()")
  Panel_Window_LordMenu_All:SetDragEnable(not self._isConsole)
  Panel_Window_LordMenu_All:SetDragAll(not self._isConsole)
  registerEvent("EventLordMenuPayInfoUpdate", "FromClient_LordMenu_All_PayInfoUpdate")
  registerEvent("FromClient_NotifyUpdateSiegeTax", "FromClient_LordMenu_All_TaxInfoUpdate")
  registerEvent("onScreenResize", "FromClient_LordMenu_OnScreenResize")
  if false == self._isConsole then
    self._ui._titleArea._btn_Close_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_LordMenu_All_Close()")
    self._ui._titleArea._btn_Question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelLordMenu\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui._titleArea._btn_Question_PC, "\"PanelLordMenu\"")
    self._ui._pc_TopBg._btn_Tab_Territory_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_LordMenu_All_SelectOtherTab(0)")
    self._ui._pc_TopBg._btn_Tab_Collection_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_LordMenu_All_SelectOtherTab(1)")
    self._ui._pc_TopBg._btn_Tab_AdjustTaxRate_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_LordMenu_All_SelectOtherTab(2)")
    self._ui._lordTaxSet._btn_AllTaxRateSet:addInputEvent("Mouse_LUp", "HandleEventLUp_LordMenu_All_AllTaxSet()")
    self._ui._lordTaxSet._btn_AllReset:addInputEvent("Mouse_LUp", "HandleEventLUp_LordMenu_All_AllTaxReset()")
  else
    Panel_Window_LordMenu_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_LordMenu_All_MoveTab(-1)")
    Panel_Window_LordMenu_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_LordMenu_All_MoveTab(1)")
    Panel_Window_LordMenu_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_LordMenu_All_AllTaxSet()")
    Panel_Window_LordMenu_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_LordMenu_All_AllTaxReset()")
  end
end
function PaGlobal_LordMenu_All:prepareOpen()
  if nil == Panel_Window_LordMenu_All or true == Panel_Window_LordMenu_All:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(selfPlayer:getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local isLord = siegeWrapper:isLord()
  if isLord then
    siegeWrapper:updateTaxAmount(false)
  elseif true == self._isConsole then
    self._ui._console_TopBg._stc_KeyGuide_RB:SetShow(false)
    self._ui._console_TopBg._stc_KeyGuide_LB:SetShow(false)
  end
  PaGlobal_LordMenu_All:open()
  self._currentTab = self._ENUM_TERIINFO
  PaGlobalFunc_LordMenu_All_SelectOtherTab(self._currentTab)
end
function PaGlobal_LordMenu_All:open()
  if nil == Panel_Window_LordMenu_All or true == Panel_Window_LordMenu_All:GetShow() then
    return
  end
  Panel_Window_LordMenu_All:SetShow(true)
end
function PaGlobal_LordMenu_All:update(tabIndex)
  if nil == Panel_Window_LordMenu_All then
    return
  end
  if self._ENUM_TERIINFO == tabIndex then
    PaGlobal_LordMenu_All:updateTerritoryInfoTab()
  elseif self._ENUM_TAXINFO == tabIndex then
    PaGlobal_LordMenu_All:updateTaxInfoTab()
  elseif self._ENUM_TAXSET == tabIndex then
    PaGlobal_LordMenu_All:updateSetTexTab()
  end
  local isShow = self._ENUM_TAXSET == tabIndex
  self._ui._console_BotBg._stc_KeyGuide_Reset:SetShow(isShow)
  self._ui._console_BotBg._stc_KeyGuide_Apply:SetShow(isShow)
end
function PaGlobal_LordMenu_All:prepareClose()
  if nil == Panel_Window_LordMenu_All or false == Panel_Window_LordMenu_All:GetShow() then
    return
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  self._transferTaxRate = 0
  self._currentTab = self._ENUM_TERIINFO
  self._texFirstNotifyCheck = false
  PaGlobal_LordMenu_All:close()
end
function PaGlobal_LordMenu_All:close()
  if nil == Panel_Window_LordMenu_All or false == Panel_Window_LordMenu_All:GetShow() then
    return
  end
  Panel_Window_LordMenu_All:SetShow(false)
end
function PaGlobal_LordMenu_All:copyLocalTaxSlider()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  self._localTaxSliderGroup = {}
  local originPosY = self._ui._lordTaxSet._stc_LocalTaxArea:GetPosY()
  for ii = 0, 4 do
    local localTaxInfo = {
      _slider = nil,
      _txt_tradeTax = nil,
      _txt_LowPercent = nil,
      _txt_HighPercent = nil,
      _stc_Progress = nil,
      _slider_TradeTax = nil,
      _btn_slider = nil,
      _territoryKey = nil,
      _taxRateForSiege = nil
    }
    localTaxInfo._slider = UI.cloneControl(self._ui._lordTaxSet._stc_LocalTaxArea, self._ui._lordTaxSet._stc_TaxSetArea, "Static_LocalTaxArea_" .. tostring(ii))
    localTaxInfo._txt_tradeTax = UI.getChildControl(localTaxInfo._slider, "StaticText_TradeTax")
    localTaxInfo._txt_LowPercent = UI.getChildControl(localTaxInfo._slider, "StaticText_LowPercent")
    localTaxInfo._txt_HighPercent = UI.getChildControl(localTaxInfo._slider, "StaticText_HighPercent")
    localTaxInfo._stc_Progress = UI.getChildControl(localTaxInfo._slider, "Static_TradeTaxProgressBG")
    localTaxInfo._slider_TradeTax = UI.getChildControl(localTaxInfo._slider, "Slider_TradeTax")
    localTaxInfo._btn_slider = UI.getChildControl(localTaxInfo._slider_TradeTax, "Slider_1_Button")
    localTaxInfo._slider:SetPosY(originPosY + localTaxInfo._slider:GetSizeY() * ii + 5)
    localTaxInfo._slider:SetShow(false)
    if false == self._isConsole then
      localTaxInfo._btn_slider:addInputEvent("Mouse_LUp", "HandleEventLPress_LordMenu_All_SliderControl(" .. tostring(ii) .. ")")
      localTaxInfo._btn_slider:addInputEvent("Mouse_LPress", "HandleEventLPress_LordMenu_All_SliderControl(" .. tostring(ii) .. ")")
      localTaxInfo._slider_TradeTax:addInputEvent("Mouse_LPress", "HandleEventLPress_LordMenu_All_SliderControl(" .. tostring(ii) .. ")")
    else
      localTaxInfo._slider_TradeTax:addInputEvent("Mouse_LPress", "HandleEventLPress_LordMenu_All_SliderControl(" .. tostring(ii) .. ")")
      localTaxInfo._btn_slider:SetIgnore(true)
    end
    self._localTaxSliderGroup[ii] = localTaxInfo
    ToClient_padSnapRefreshTarget(self._localTaxSliderGroup[ii]._slider)
    ToClient_padSnapRefreshTarget(self._localTaxSliderGroup[ii]._slider_TradeTax)
  end
end
function PaGlobal_LordMenu_All:updateTerritoryInfoTab()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    Panel_LordMenu:SetShow(false)
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(getSelfPlayer():getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local doOccupantExist = siegeWrapper:doOccupantExist()
  local defineColor = Defines.Color
  local guildName = ""
  local lordName = ""
  if true == doOccupantExist then
    guildName = siegeWrapper:getGuildName()
    lordName = siegeWrapper:getGuildMasterName()
  end
  local occupyingDate = siegeWrapper:getOccupyingDate()
  local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(occupyingDate:GetYear()))
  local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(occupyingDate:GetMonth()))
  local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(occupyingDate:GetDay()))
  local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(occupyingDate:GetHour()))
  occupyingDate = year .. " " .. month .. " " .. day .. " " .. hour
  local affiliatedUserRate = siegeWrapper:getAffiliatedUserRate()
  local affiliatedUserRateStr = ""
  local affiliatedUserRateColor = ""
  local loyalty = siegeWrapper:getLoyalty()
  local loyaltyStr = ""
  local loyaltyColor = ""
  self._ui._lordInfoArea._txt_GuildName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_TER_GUILDNAME") .. " " .. "<PAColor0xFFF5BA3A>" .. guildName .. "<PAOldColor>")
  self._ui._lordInfoArea._txt_GuildMasterName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_TER_LORDNAME") .. " " .. "<PAColor0xFFF5BA3A>" .. lordName .. "<PAOldColor>")
  self._ui._lordInfoArea._txt_OccupationDate:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_TER_OCCUPATION") .. " " .. "<PAColor0xFFF5BA3A>" .. occupyingDate .. "<PAOldColor>")
  if 0 <= affiliatedUserRate and affiliatedUserRate <= 20 then
    affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_LACK") .. "(" .. string.format("%d", affiliatedUserRate) .. "%)"
    affiliatedUserRateColor = "<PAColor0xFFD04D47>"
  elseif 20 < affiliatedUserRate and affiliatedUserRate <= 40 then
    affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_LOW") .. "(" .. string.format("%d", affiliatedUserRate) .. "%)"
    affiliatedUserRateColor = "<PAColor0xFFC78045>"
  elseif 40 < affiliatedUserRate and affiliatedUserRate <= 60 then
    affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_NORMAL") .. "(" .. string.format("%d", affiliatedUserRate) .. "%)"
    affiliatedUserRateColor = "<PAColor0xFF76B24D>"
  elseif 60 < affiliatedUserRate and affiliatedUserRate <= 80 then
    affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_HIGH") .. "(" .. string.format("%d", affiliatedUserRate) .. "%)"
    affiliatedUserRateColor = "<PAColor0xFF3B8BBE>"
  elseif 80 < affiliatedUserRate then
    affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_EXPLOSION") .. "(" .. string.format("%d", affiliatedUserRate) .. "%)"
    affiliatedUserRateColor = "<PAColor0xFFB23BC7>"
  end
  self._ui._lordInfoArea._txt_Population:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_TER_RESIDENCE") .. " " .. affiliatedUserRateColor .. affiliatedUserRateStr .. "<PAOldColor>")
  local selfActorKeyRaw = selfPlayer:getActorKey()
  local guildNo64 = siegeWrapper:getGuildNo()
  if false == self._isConsole then
    local isSet = setGuildTextureByGuildNo(guildNo64, self._ui._lordInfoArea._stc_GuildMark)
    if not isSet then
      self._ui._lordInfoArea._stc_GuildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._lordInfoArea._stc_GuildMark, 183, 1, 188, 6)
      self._ui._lordInfoArea._stc_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._lordInfoArea._stc_GuildMark:setRenderTexture(self._ui._lordInfoArea._stc_GuildMark:getBaseTexture())
    end
  else
    local markData = getGuildMarkIndexByGuildNoForXBox(guildNo64)
    if nil ~= markData then
      local iconIdx = markData:getBackGroundIdx()
      if 0 ~= iconIdx then
        self._ui._lordInfoArea._stc_GuildMarkBack:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
        local bgx1, bgy1, bgx2, bgy2 = self._markBgUV[iconIdx].x1, self._markBgUV[iconIdx].y1, self._markBgUV[iconIdx].x2, self._markBgUV[iconIdx].y2
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._lordInfoArea._stc_GuildMarkBack, bgx1, bgy1, bgx2, bgy2)
        self._ui._lordInfoArea._stc_GuildMarkBack:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._lordInfoArea._stc_GuildMarkBack:setRenderTexture(self._ui._lordInfoArea._stc_GuildMarkBack:getBaseTexture())
      else
        self._ui._lordInfoArea._stc_GuildMarkBack:ReleaseTexture()
      end
      iconIdx = markData:getIconIdx()
      if 0 ~= iconIdx then
        self._ui._lordInfoArea._stc_GuildMark:ChangeTextureInfoName("renewal/commonicon/guildmark/console_icon_guildmark_00.dds")
        local iconx1, icony1, iconx2, icony2 = self._markIconUV[iconIdx].x1, self._markIconUV[iconIdx].y1, self._markIconUV[iconIdx].x2, self._markIconUV[iconIdx].y2
        local x1, y1, x2, y2 = setTextureUV_Func(self._ui._lordInfoArea._stc_GuildMark, iconx1, icony1, iconx2, icony2)
        self._ui._lordInfoArea._stc_GuildMark:getBaseTexture():setUV(x1, y1, x2, y2)
        self._ui._lordInfoArea._stc_GuildMark:setRenderTexture(self._ui._lordInfoArea._stc_GuildMark:getBaseTexture())
      else
        self._ui._lordInfoArea._stc_GuildMark:ReleaseTexture()
      end
    end
  end
  local territoryKeyRaw = regionInfoWrapper:getTerritoryKeyRaw()
  local isOccupationDate = ToClient_GetAccumulatedOccupiedCountByWeek(territoryKeyRaw)
  local isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_NONE")
  if -1 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_NONE")
  elseif 0 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_VERY_UNSTABLE")
  elseif 1 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_UNSTABLE")
  elseif 2 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_NORMAL")
  elseif 3 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_SAFETY")
  elseif 4 == isOccupationDate then
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_VERY_SAFETY")
  else
    isWeekDate = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ISWEEKDATE_NONE")
  end
  self._ui._lordInfoArea._txt_CivilStabilty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_TERRITORY_SAFEAREA_TITLE") .. " " .. isWeekDate)
  if 0 <= loyalty and loyalty <= 15 then
    loyaltyStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_LOYALTY_UPRISING")
    loyaltyColor = defineColor.C_FFD04D47
  elseif 15 < loyalty and loyalty <= 50 then
    loyaltyStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_LOYALTY_COMPLAINT")
    loyaltyColor = defineColor.C_FFC78045
  elseif 50 < loyalty and loyalty <= 70 then
    loyaltyStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_LOYALTY_NORMAL")
    loyaltyColor = defineColor.C_FF76B24D
  elseif 70 < loyalty and loyalty <= 94 then
    loyaltyStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_LOYALTY_SATISFACTION")
    loyaltyColor = defineColor.C_FF3B8BBE
  elseif 94 < loyalty and loyalty <= 100 then
    loyaltyStr = PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_LOYALTY_GREATSATISFACTION")
    loyaltyColor = defineColor.C_FFB23BC7
  end
  self._ui._lordInfoArea._prog2_Happy:SetProgressRate(loyalty)
  self._ui._lordInfoArea._txt_Happy_Value:SetText(loyaltyStr)
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._lordInfoArea._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._lordInfoArea._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_TXT_TERRHELP"))
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_HAPPY_HELP"))
  PaGlobal_LordMenu_All:resizeTerritoryInfoTab()
  local isLord = siegeWrapper:isLord()
  if not isLord then
    self._loadMenuTabs[self._ENUM_TERIINFO]:SetSpanSize(self._loadMenuTabs[self._ENUM_TAXINFO]:GetSpanSize().x, self._loadMenuTabs[self._ENUM_TERIINFO]:GetSpanSize().y)
    self._ui._titleArea._stc_TabBtnBar:SetSpanSize(self._loadMenuTabs[self._ENUM_TAXINFO]:GetSpanSize().x, self._ui._titleArea._stc_TabBtnBar:GetSpanSize().y)
    self._loadMenuTabs[self._ENUM_TAXINFO]:SetShow(false)
    self._loadMenuTabs[self._ENUM_TAXSET]:SetShow(false)
  else
    self._loadMenuTabs[self._ENUM_TERIINFO]:SetSpanSize(self._originTerritoryInfoButtonSpanX, self._loadMenuTabs[self._ENUM_TERIINFO]:GetSpanSize().y)
    self._ui._titleArea._stc_TabBtnBar:SetSpanSize(self._loadMenuTabs[self._ENUM_TERIINFO]:GetSpanSize().x, self._ui._titleArea._stc_TabBtnBar:GetSpanSize().y)
    self._loadMenuTabs[self._ENUM_TAXINFO]:SetShow(true)
    self._loadMenuTabs[self._ENUM_TAXSET]:SetShow(true)
  end
end
function PaGlobal_LordMenu_All:updateTaxInfoTab()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(selfPlayer:getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local doOccupantExist = siegeWrapper:doOccupantExist()
  if not doOccupantExist then
    return
  end
  local isLord = siegeWrapper:isLord()
  if not isLord then
    return
  end
  local maxAmount = toInt64(0, 1)
  local transferTaxProducedAmount = siegeWrapper:getTaxProducedAmount(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  local transferTaxAffiliatedAmount = siegeWrapper:getTaxAffiliatedAmount(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  local transferTaxAmount = transferTaxProducedAmount + transferTaxAffiliatedAmount
  if maxAmount < transferTaxAmount then
    maxAmount = transferTaxAmount
  end
  self._ui._lordTaxInfo._prog2_TransferTax_NowBar:SetProgressRate(math.floor(Int64toInt32(transferTaxProducedAmount / maxAmount * toInt64(0, 100))))
  self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar:SetProgressRate(math.floor(Int64toInt32(transferTaxAffiliatedAmount / maxAmount * toInt64(0, 100))))
  self._ui._lordTaxInfo._txt_Trade_Tax_Money:SetText(makeDotMoney(transferTaxAmount))
  local taxRemainedAmountForFortress = siegeWrapper:getTaxRemainedAmountForFortress()
  local taxRemainedAmountForSiege = siegeWrapper:getTaxRemainedAmountForSiege()
  self._ui._lordTaxInfo._txt_BottomMoney_BalanceMoney:SetText(makeDotMoney(taxRemainedAmountForFortress))
  self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney:SetText(makeDotMoney(taxRemainedAmountForSiege))
  local territorysInNationalCount = siegeWrapper:getTerritorysCountInNational()
  local territoryKeyInNational = 10
  local securityTax = ""
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityBudgetTitle:SetShow(false)
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetShow(false)
  self._ui._lordTaxInfo._txt_LordTax_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._lordTaxInfo._txt_LordTax_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_PAY_TAX_HELP"))
  local localMoneySpanY = self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney:GetSpanSize().y
  for ii = 0, territorysInNationalCount - 1 do
    territoryKeyInNational = siegeWrapper:getTerritoryKeyInNationalByIndex(ii)
    if 3 == territoryKeyInNational or 4 == territoryKeyInNational then
      local gap = self._originLeftLineSize - self._originLeftLineSize / 3
      self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:SetSize(self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:GetSizeX(), gap)
      self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:SetSize(self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:GetSizeX(), gap)
      self._ui._lordTaxInfo._stc_BottomMoney_Mid_BotLine:SetShow(false)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityBudgetTitle:SetShow(false)
      self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney:SetShow(false)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetShow(true)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetPosY(self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxTitle:GetPosY() - 10)
      self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_PAYINFO_POLICING_TITLE"))
    else
      self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LORDMENU_PAY_LOCALTAX"))
      self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:SetSize(self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:GetSizeX(), self._originLeftLineSize)
      self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:SetSize(self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:GetSizeX(), self._originRightLineSize)
      self._ui._lordTaxInfo._stc_BottomMoney_Mid_BotLine:SetShow(true)
      self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney:SetShow(true)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetShow(true)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetSpanSize(self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:GetSpanSize().x, self._originSecurityBudgetTextPosY)
      self._ui._lordTaxInfo._txt_BottomMoney_SecurityBudgetTitle:SetShow(true)
    end
  end
  local territoryKeyValue = regionInfoWrapper:getTerritoryKeyRaw()
  local taxRate = ToClient_GetReceivableTaxRate(territoryKeyValue)
  local taxRateValue = ToClient_CalculatePercent(taxRemainedAmountForFortress, taxRate)
  local policingRate = 1000000 - ToClient_GetReceivableTaxRate(territoryKeyValue)
  local policingRateValue = ToClient_CalculatePercent(taxRemainedAmountForFortress, policingRate)
  local policingResultValue = policingRate / 10000
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LORDMENU_GETMONEY_POLICINGMONEY", "value", policingResultValue))
end
function PaGlobal_LordMenu_All:updateSetTexTab()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(getSelfPlayer():getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local doOccupantExist = siegeWrapper:doOccupantExist()
  if not doOccupantExist then
    return
  end
  local isLord = siegeWrapper:isLord()
  if not isLord then
    return
  end
  local minRate = 0
  local maxRate = 10
  self._transferTaxRate = 0
  local curRate = 0
  minRate = siegeWrapper:getMinTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  maxRate = siegeWrapper:getMaxTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  curRate = siegeWrapper:getTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  self._transferTaxRate = curRate
  self._ui._lordTaxSet._btn_Slider_TradeTax:SetText(tostring(curRate) .. "%")
  self._ui._lordTaxSet._slider_TradeTax:SetControlPos((curRate - minRate) / (maxRate - minRate) * 100)
  self._ui._lordTaxSet._stc_TradeTax_LowPercent:SetText(tostring(minRate) .. "%")
  self._ui._lordTaxSet._stc_TradeTax_HighPercent:SetText(tostring(maxRate) .. "%")
  self._ui._lordTaxSet._slider_TradeTax:SetIgnore(true)
  self._ui._lordTaxSet._btn_Slider_TradeTax:SetIgnore(true)
  self._ui._lordTaxSet._btn_Slider_TradeTax:SetMonoTone(true)
  local isKing = siegeWrapper:isKing()
  local isKingTerritoryOnly = siegeWrapper:isKingTerritoryOnly()
  local isDutyShow = isKing and isKingTerritoryOnly
  if nil == self._localTaxSliderGroup then
    return
  end
  local isSiegeBeing = siegeWrapper:isSiegeBeing()
  local territorysInNationalCount = siegeWrapper:getTerritorysCountInNational()
  for slidersIdx = 0, territorysInNationalCount - 1 do
    if nil ~= self._localTaxSliderGroup[slidersIdx] then
      if 0 == slidersIdx or 1 == slidersIdx then
        self._localTaxSliderGroup[slidersIdx]._slider:SetShow(isDutyShow)
      else
        self._localTaxSliderGroup[slidersIdx]._slider:SetShow(false)
      end
      if true == isSiegeBeing then
        self._localTaxSliderGroup[slidersIdx]._slider_TradeTax:SetIgnore(isSiegeBeing)
      end
    end
  end
  if true == isSiegeBeing then
    self._ui._lordTaxSet._btn_AllTaxRateSet:SetEnable(not isSiegeBeing)
    self._ui._lordTaxSet._btn_AllTaxRateSet:SetMonoTone(isSiegeBeing)
    self._ui._lordTaxSet._btn_AllReset:SetEnable(not isSiegeBeing)
    self._ui._lordTaxSet._btn_AllReset:SetMonoTone(isSiegeBeing)
  end
  local territoryKeyInNational = 10
  local territorySiege
  local territoryTaxRateForSiege = 10
  local indexCount = 0
  for ii = 0, territorysInNationalCount - 1 do
    if nil ~= self._localTaxSliderGroup[ii] then
      territoryKeyInNational = siegeWrapper:getTerritoryKeyInNationalByIndex(ii)
      if (3 == territoryKeyInNational or 4 == territoryKeyInNational) and nil ~= self._localTaxSliderGroup then
        self._localTaxSliderGroup[0]._slider:SetShow(false)
        self._localTaxSliderGroup[1]._slider:SetShow(false)
        self._ui._lordTaxSet._btn_AllTaxRateSet:SetIgnore(true)
        self._ui._lordTaxSet._btn_AllReset:SetIgnore(true)
      end
      if regionInfoWrapper:getTerritoryKeyRaw() ~= territoryKeyInNational then
        territorySiege = ToClient_GetSiegeWrapper(territoryKeyInNational)
        if nil == territorySiege then
          return
        end
        territorySiege:updateTaxRateForSiege()
        territoryName = territorySiege:getTerritoryName()
        territoryTaxRateForSiege = territorySiege:getTaxRateForSiege()
        self._localTaxSliderGroup[indexCount]._territoryKey = territoryKeyInNational
        self._localTaxSliderGroup[indexCount]._taxRateForSiege = territoryTaxRateForSiege
        if nil ~= territorySiege then
          self._localTaxSliderGroup[indexCount]._txt_tradeTax:SetText(territoryName)
          self._localTaxSliderGroup[indexCount]._btn_slider:SetText(tostring(territoryTaxRateForSiege) .. "%")
          self._localTaxSliderGroup[indexCount]._slider_TradeTax:SetControlPos((territoryTaxRateForSiege - 10) / 40 * 100)
          indexCount = indexCount + 1
        end
        self._ui._lordTaxSet._btn_AllTaxRateSet:SetIgnore(false)
        self._ui._lordTaxSet._btn_AllReset:SetIgnore(false)
      end
    end
  end
  if false == isSiegeBeing then
    if true == isDutyShow then
      self._ui._lordTaxSet._btn_AllTaxRateSet:SetEnable(true)
      self._ui._lordTaxSet._btn_AllTaxRateSet:SetMonoTone(false)
      self._ui._lordTaxSet._btn_AllReset:SetEnable(true)
      self._ui._lordTaxSet._btn_AllReset:SetMonoTone(false)
    else
      self._ui._lordTaxSet._btn_AllTaxRateSet:SetEnable(false)
      self._ui._lordTaxSet._btn_AllTaxRateSet:SetMonoTone(true)
      self._ui._lordTaxSet._btn_AllReset:SetEnable(false)
      self._ui._lordTaxSet._btn_AllReset:SetMonoTone(true)
    end
  end
  self._ui._lordTaxSet._stc_TradeTax_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._lordTaxSet._stc_TradeTax_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_ITEMMARKETTAX"))
end
function PaGlobal_LordMenu_All:setAllTax()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  if self._ENUM_TAXSET ~= self._currentTab then
    return
  end
  local selfPlayer = getSelfPlayer()
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(selfPlayer:getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local isKing = siegeWrapper:isKing()
  if true == isKing and nil ~= self._localTaxSliderGroup then
    for slidersIdx = 0, #self._localTaxSliderGroup - 1 do
      if nil ~= self._localTaxSliderGroup[slidersIdx] and true == self._localTaxSliderGroup[slidersIdx]._slider:GetShow() then
        siegeWrapper = ToClient_GetSiegeWrapper(self._localTaxSliderGroup[slidersIdx]._territoryKey)
        if nil == siegeWrapper then
          return
        end
        if nil ~= self._localTaxSliderGroup[slidersIdx] and nil ~= self._localTaxSliderGroup[slidersIdx]._taxRateForSiege then
          local territoryTaxRateForSiege = self._localTaxSliderGroup[slidersIdx]._taxRateForSiege
          if nil ~= siegeWrapper and nil ~= territoryTaxRateForSiege then
            siegeWrapper:changeTaxRateForSiege(territoryTaxRateForSiege)
          end
        end
      end
    end
  end
end
function PaGlobal_LordMenu_All:resetAllTax()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  if self._ENUM_TAXSET ~= self._currentTab then
    return
  end
  local selfPlayer = getSelfPlayer()
  local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if nil == regionInfoWrapper then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(selfPlayer:getRegionKeyRaw())
  if nil == siegeWrapper then
    return
  end
  local isKing = siegeWrapper:isKing()
  if true == isKing and nil ~= self._localTaxSliderGroup then
    for slidersIdx = 0, #self._localTaxSliderGroup - 1 do
      if nil ~= self._localTaxSliderGroup[slidersIdx] and true == self._localTaxSliderGroup[slidersIdx]._slider:GetShow() then
        siegeWrapper = ToClient_GetSiegeWrapper(self._localTaxSliderGroup[slidersIdx]._territoryKey)
        if nil == siegeWrapper then
          return
        end
        local territoryTaxRateForSiege = siegeWrapper:getTaxRateForSiege()
        self._localTaxSliderGroup[slidersIdx]._taxRateForSiege = territoryTaxRateForSiege
        if nil ~= territoryTaxRateForSiege then
          self._localTaxSliderGroup[slidersIdx]._btn_slider:SetText(tostring(territoryTaxRateForSiege) .. "%")
          self._localTaxSliderGroup[slidersIdx]._slider_TradeTax:SetControlPos(math.floor((territoryTaxRateForSiege - 10) / 40 * 100))
        end
      end
    end
  end
end
function PaGlobal_LordMenu_All:resizeTerritoryInfoTab()
  self._ui._lordInfoArea._txt_Desc:SetSize(self._ui._lordInfoArea._txt_Desc:GetSizeX(), self._ui._lordInfoArea._txt_Desc:GetTextSizeY())
  self._ui._lordInfoArea._txt_Desc:SetSpanSize(self._ui._lordInfoArea._txt_Desc:GetSpanSize().x, self._ui._lordInfoArea._stc_SubFrame1:GetSpanSize().y + 10)
  self._ui._lordInfoArea._stc_SubFrame1:SetSize(self._ui._lordInfoArea._stc_SubFrame1:GetSizeX(), self._ui._lordInfoArea._txt_Desc:GetTextSizeY() + 20)
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:SetSize(self._ui._lordInfoArea._txt_LordInfoBottom_Desc:GetSizeX(), self._ui._lordInfoArea._txt_LordInfoBottom_Desc:GetTextSizeY())
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:SetSpanSize(self._ui._lordInfoArea._txt_LordInfoBottom_Desc:GetSpanSize().x, self._ui._lordInfoArea._stc_SubFrame2:GetSpanSize().y + 10)
  self._ui._lordInfoArea._stc_SubFrame2:SetSize(self._ui._lordInfoArea._stc_SubFrame2:GetSizeX(), self._ui._lordInfoArea._txt_LordInfoBottom_Desc:GetTextSizeY() + 20)
  self._ui._lordInfoArea._stc_LordInfoTopArea:SetSize(self._ui._lordInfoArea._stc_LordInfoTopArea:GetSizeX(), self._ui._lordInfoArea._stc_SubFrame1:GetSpanSize().y + self._ui._lordInfoArea._stc_SubFrame1:GetSizeY() + 10)
  self._ui._lordInfoArea._stc_LordInfoBottomArea:SetSize(self._ui._lordInfoArea._stc_LordInfoBottomArea:GetSizeX(), self._originHappyAreaSizeY + self._ui._lordInfoArea._stc_SubFrame2:GetSizeY() + 10)
  self._ui._lordInfoArea._stc_LordInfoArea:SetSize(self._ui._lordInfoArea._stc_LordInfoArea:GetSizeX(), self._ui._lordInfoArea._stc_LordInfoTopArea:GetSizeY() + self._ui._lordInfoArea._stc_LordInfoBottomArea:GetSizeY())
  self._ui._lordInfoArea._stc_LordInfoMidLine:SetSpanSize(self._ui._lordInfoArea._stc_LordInfoMidLine:GetSpanSize().x, self._ui._lordInfoArea._stc_LordInfoTopArea:GetSizeY())
  local PanelSizeY = self._ui._titleArea._stc_TitleArea:GetSizeY() + self._ui._lordInfoArea._stc_LordInfoTopArea:GetSizeY() + self._ui._lordInfoArea._stc_LordInfoBottomArea:GetSizeY()
  if true == self._isConsole then
    PanelSizeY = PanelSizeY + self._ui._console_TopBg._stc_TopBg_ConsoleUI:GetSizeY()
  else
    PanelSizeY = PanelSizeY + self._ui._pc_TopBg._stc_TopBg_PCUI:GetSizeY()
  end
  Panel_Window_LordMenu_All:SetSize(Panel_Window_LordMenu_All:GetSizeX(), PanelSizeY)
  Panel_Window_LordMenu_All:ComputePos()
  self._ui._lordInfoArea._stc_SubFrame1:ComputePos()
  self._ui._lordInfoArea._stc_SubFrame2:ComputePos()
  self._ui._lordInfoArea._txt_Desc:ComputePos()
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:ComputePos()
  self._ui._lordInfoArea._stc_LordInfoTopArea:ComputePos()
  self._ui._lordInfoArea._stc_LordInfoBottomArea:ComputePos()
  self._ui._lordInfoArea._stc_LordInfoArea:ComputePos()
  self._ui._lordInfoArea._stc_LordInfoMidLine:ComputePos()
  if true == self._isConsole then
    self._ui._console_BotBg._stc_Bottom_KeyGuides:SetPosY(Panel_Window_LordMenu_All:GetSizeY())
  end
end
function PaGlobal_LordMenu_All:validate()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  self._ui._titleArea._stc_TitleArea:isValidate()
  self._ui._titleArea._txt_Title:isValidate()
  self._ui._titleArea._btn_Question_PC:isValidate()
  self._ui._titleArea._btn_Close_PC:isValidate()
  self._ui._titleArea._stc_TopLine:isValidate()
  self._ui._titleArea._stc_TabBtnBar:isValidate()
  self._ui._console_TopBg._stc_TopBg_ConsoleUI:isValidate()
  self._ui._console_TopBg._btn_Tab_Territory_ConSole:isValidate()
  self._ui._console_TopBg._btn_Tab_Collection_Console:isValidate()
  self._ui._console_TopBg._btn_Tab_AdjustTaxRate_Console:isValidate()
  self._ui._console_TopBg._stc_KeyGuide_RB:isValidate()
  self._ui._console_TopBg._stc_KeyGuide_LB:isValidate()
  self._ui._pc_TopBg._stc_TopBg_PCUI:isValidate()
  self._ui._pc_TopBg._btn_Tab_Territory_PC:isValidate()
  self._ui._pc_TopBg._btn_Tab_Collection_PC:isValidate()
  self._ui._pc_TopBg._btn_Tab_AdjustTaxRate_PC:isValidate()
  self._ui._lordInfoArea._stc_LordInfoArea:isValidate()
  self._ui._lordInfoArea._stc_LordInfoTopArea:isValidate()
  self._ui._lordInfoArea._stc_LordInfoMidLine:isValidate()
  self._ui._lordInfoArea._txt_LordInfoTitle:isValidate()
  self._ui._lordInfoArea._txt_GuildName:isValidate()
  self._ui._lordInfoArea._txt_GuildMasterName:isValidate()
  self._ui._lordInfoArea._txt_OccupationDate:isValidate()
  self._ui._lordInfoArea._txt_CivilStabilty:isValidate()
  self._ui._lordInfoArea._txt_Population:isValidate()
  self._ui._lordInfoArea._txt_Desc:isValidate()
  self._ui._lordInfoArea._stc_GuildMarkBg:isValidate()
  self._ui._lordInfoArea._stc_GuildMarkBack:isValidate()
  self._ui._lordInfoArea._stc_GuildMark:isValidate()
  self._ui._lordInfoArea._stc_LordInfoBottomArea:isValidate()
  self._ui._lordInfoArea._txt_LordInfoTitle:isValidate()
  self._ui._lordInfoArea._stc_LordInfo_ProgressArea:isValidate()
  self._ui._lordInfoArea._stc_LordInfo_ProgressBg:isValidate()
  self._ui._lordInfoArea._prog2_Happy:isValidate()
  self._ui._lordInfoArea._prog2_Happy_Bar_Head:isValidate()
  self._ui._lordInfoArea._txt_Happy_Value:isValidate()
  self._ui._lordInfoArea._txt_LordInfoBottom_Desc:isValidate()
  self._ui._lordInfoArea._stc_SubFrame1:isValidate()
  self._ui._lordInfoArea._stc_SubFrame2:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxInfoArea:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxInfoTitle:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxInfo_GraphArea:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxInfo_Blue_Bg:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxInfo_Red_Bg:isValidate()
  self._ui._lordTaxInfo._prog2_TransferTax_NowBar:isValidate()
  self._ui._lordTaxInfo._prog2_TransferTax_NowBar_Head:isValidate()
  self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar:isValidate()
  self._ui._lordTaxInfo._prog2_TransferTax_BeforeBar_Head:isValidate()
  self._ui._lordTaxInfo._txt_Trade_Tax:isValidate()
  self._ui._lordTaxInfo._txt_Trade_Tax_Money:isValidate()
  self._ui._lordTaxInfo._stc_LordTaxHoriLine:isValidate()
  self._ui._lordTaxInfo._txt_LordTax_Desc:isValidate()
  self._ui._lordTaxInfo._txt_LordTax_RedDesc:isValidate()
  self._ui._lordTaxInfo._txt_LordTax_BlueDesc:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoneyArea:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_Title:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_TopLine:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_Mid_TopLine:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_Mid_BotLine:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_BotLine:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_Left_VetiLine:isValidate()
  self._ui._lordTaxInfo._stc_BottomMoney_Right_VetiLine:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_BalanceTitle:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxTitle:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityBudgetTitle:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_BalanceMoney:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_LocalTaxMoney:isValidate()
  self._ui._lordTaxInfo._txt_BottomMoney_SecurityMoney:isValidate()
  self._ui._lordTaxSet._stc_TaxSetArea:isValidate()
  self._ui._lordTaxSet._stc_TaxSetArea_Title:isValidate()
  self._ui._lordTaxSet._stc_TradeTaxArea:isValidate()
  self._ui._lordTaxSet._stc_TradeTaxSubTitle:isValidate()
  self._ui._lordTaxSet._stc_TradeTax_LowPercent:isValidate()
  self._ui._lordTaxSet._stc_TradeTax_HighPercent:isValidate()
  self._ui._lordTaxSet._stc_TradeTax_ProgressBg:isValidate()
  self._ui._lordTaxSet._stc_TradeTax_Desc:isValidate()
  self._ui._lordTaxSet._slider_TradeTax:isValidate()
  self._ui._lordTaxSet._btn_Slider_TradeTax:isValidate()
  self._ui._lordTaxSet._stc_HorizonLine:isValidate()
  self._ui._lordTaxSet._txt_LocalTaxTitle:isValidate()
  self._ui._lordTaxSet._stc_LocalTaxArea:isValidate()
  self._ui._lordTaxSet._txt_LocalTaxSubTitle:isValidate()
  self._ui._lordTaxSet._txt_LocalTax_LowPercent:isValidate()
  self._ui._lordTaxSet._stc_LocalTax_ProgressBg:isValidate()
  self._ui._lordTaxSet._txt_LocalTax_HighPercent:isValidate()
  self._ui._lordTaxSet._slider_LocalTax:isValidate()
  self._ui._lordTaxSet._btn_Slider_localTaxTitle:isValidate()
  self._ui._lordTaxSet._stc_RSKeyguide:isValidate()
  self._ui._lordTaxSet._btn_AllTaxRateSet:isValidate()
  self._ui._lordTaxSet._btn_AllReset:isValidate()
  self._ui._console_BotBg._stc_Bottom_KeyGuides:isValidate()
  self._ui._console_BotBg._stc_KeyGuide_Reset:isValidate()
  self._ui._console_BotBg._stc_KeyGuide_Apply:isValidate()
  self._ui._console_BotBg._stc_KeyGuide_Cancel:isValidate()
  self._initialize = true
end
