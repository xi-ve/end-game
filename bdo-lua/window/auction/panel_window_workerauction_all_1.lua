function PaGlobal_WorkerAuction_All:initialize()
  if true == PaGlobal_WorkerAuction_All._initialize then
    return
  end
  PaGlobal_WorkerAuction_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerAuction_All._ui._stc_TitleBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_TitleBG")
  PaGlobal_WorkerAuction_All._ui._stc_MainBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_MainBg")
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_TitleBg, "Button_Question")
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_TitleBg, "Button_Win_Close")
  PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_RadioButtonGroupBg")
  PaGlobal_WorkerAuction_All._ui._rdo_MarketList = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_List")
  PaGlobal_WorkerAuction_All._ui._rdo_Register = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_Regist")
  PaGlobal_WorkerAuction_All._ui._rdo_MyRegister = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_MyList")
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Button_LB_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Button_RB_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Static_SelectBar")
  PaGlobal_WorkerAuction_All._ui._stc_PageBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_PageBg")
  PaGlobal_WorkerAuction_All._ui._txt_PageValue = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "StaticText_PageValue")
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Left_PCUI")
  PaGlobal_WorkerAuction_All._ui._btn_RightPage = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Right_PCUI")
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Left_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Right_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_BottomBG_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_X_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney = UI.getChildControl(Panel_Window_WorkerAuction_All, "RadioButton_InvenMoney")
  PaGlobal_WorkerAuction_All._ui._txt_InvenMoney = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney, "StaticText_InvenMoneyValue")
  PaGlobal_WorkerAuction_All._ui._rdo_WareMoney = UI.getChildControl(Panel_Window_WorkerAuction_All, "RadioButton_WarehouseMoney")
  PaGlobal_WorkerAuction_All._ui._txt_WareMoney = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._rdo_WareMoney, "StaticText_WarehouseMoenyValue")
  if false == PaGlobal_WorkerAuction_All._isConsole then
    PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_ListSlotTemplate_PCUI")
  else
    PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_ListSlotTemplate_ConsoleUI")
    PaGlobal_WorkerAuction_All._keyGuides = {
      PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide,
      PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide,
      PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerAuction_All._keyGuides, PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  local slotStartPosY = PaGlobal_WorkerAuction_All._ui._stc_PageBg:GetSizeY() + PaGlobal_WorkerAuction_All._ui._stc_PageBg:GetPosY() + 5
  PaGlobal_WorkerAuction_All._config._startY = slotStartPosY
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST] = PaGlobal_WorkerAuction_All._ui._rdo_MarketList
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_REGISTER] = PaGlobal_WorkerAuction_All._ui._rdo_Register
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_MYREGISTER] = PaGlobal_WorkerAuction_All._ui._rdo_MyRegister
  PaGlobal_WorkerAuction_All._selectedTab = PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:SetCheck(true)
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_SELECTED)
  local selectBarSapnX = PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:GetSpanSize().x
  local selectBarSapnY = PaGlobal_WorkerAuction_All._ui._stc_SelectBar:GetSpanSize().y
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
  PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney:SetCheck(true)
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_RightPage:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All:validate()
  PaGlobal_WorkerAuction_All:registEventHandler()
  PaGlobal_WorkerAuction_All:createControl()
end
function PaGlobal_WorkerAuction_All:validate()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._ui._stc_TitleBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_MainBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_MarketList:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_Register:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_MyRegister:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_PageBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._txt_PageValue:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_RightPage:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney:isValidate()
  PaGlobal_WorkerAuction_All._ui._txt_InvenMoney:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_WareMoney:isValidate()
  PaGlobal_WorkerAuction_All._ui._txt_WareMoney:isValidate()
  PaGlobal_WorkerAuction_All._initialize = true
end
function PaGlobal_WorkerAuction_All:registEventHandler()
  if nil == Panel_Window_WorkerAuction_All or false == PaGlobal_WorkerAuction_All._initialize then
    return
  end
  registerEvent("FromClient_ResponseWorkerAuction", "FromClient_WorkerAuction_All_ResponseWorkerAuction()")
  registerEvent("FromClient_ResponseMyWorkerAuction", "FromClient_WorkerAuction_All_ResponseMyWorkerAuction()")
  registerEvent("EventWarehouseUpdate", "FromClient_WorkerAuction_All_UpdateMoney()")
  registerEvent("FromClient_RegistAuction", "FromClient_WorkerAuction_All_RegisterDone()")
  registerEvent("FromClient_BuyWorkerAuction", "FromClient_WorkerAuction_All_BuyWorkerDone()")
  registerEvent("FromClient_PopWorkerPriceAuction", "FromClient_WorkerAuction_All_ReceiveMoneyDone()")
  registerEvent("FromClient_CancelRegistAuction", "FromClient_WorkerAuction_All_CancelRegistDone()")
  registerEvent("onScreenResize", "FromClient_WorkerAuction_All_OnScreenResize()")
  if false == PaGlobal_WorkerAuction_All._isConsole then
    PaGlobal_WorkerAuction_All._ui._btn_ClosePC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_Close()")
    PaGlobal_WorkerAuction_All._ui._rdo_MarketList:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(0)")
    PaGlobal_WorkerAuction_All._ui._rdo_Register:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(1)")
    PaGlobal_WorkerAuction_All._ui._rdo_MyRegister:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(2)")
    PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Worker\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_WorkerAuction_All._ui._btn_QuestionPC, "\"Worker\"")
    PaGlobal_WorkerAuction_All._ui._btn_LeftPage:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    PaGlobal_WorkerAuction_All._ui._btn_RightPage:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
  else
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_WorkerAuction_All_ChangeTabByPad( -1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_WorkerAuction_All_ChangeTabByPad( 1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
  end
end
function PaGlobal_WorkerAuction_All:onScreenResize()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  Panel_Window_WorkerAuction_All:ComputePos()
  local screenY = getScreenSizeY()
  local panelSizeY = Panel_Window_WorkerAuction_All:GetSizeY()
  local DialogSizeY = Panel_Npc_Dialog_All:GetSizeY()
  local availableSize = screenY - DialogSizeY
  local adjustSpanY = availableSize / 2 - panelSizeY / 2
  if panelSizeY > availableSize then
    Panel_Window_WorkerAuction_All:SetPosY(0)
  else
    Panel_Window_WorkerAuction_All:SetPosY(adjustSpanY)
  end
  if true == self._isConsole then
    Panel_Window_WorkerAuction_All:SetPosY(self._originPanelYConsole - self._adjustPanelYConsole)
  end
end
function PaGlobal_WorkerAuction_All:createControl()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  for index = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    local info = {}
    info.slot = UI.cloneControl(PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete, Panel_Window_WorkerAuction_All, "WokerSlotList_" .. index)
    info.slotImage = UI.getChildControl(info.slot, "Static_Image")
    info.txt_SlotName = UI.getChildControl(info.slot, "StaticText_Name")
    info.txt_WorkSpeedTitle = UI.getChildControl(info.slot, "StaticText_WorkSpeedTitle")
    info.txt_WorkSpeedValue = UI.getChildControl(info.slot, "StaticText_WorkSpeedValue")
    info.txt_MoveSpeedTitle = UI.getChildControl(info.slot, "StaticText_MoveSpeedTitle")
    info.txt_MoveSpeedValue = UI.getChildControl(info.slot, "StaticText_MoveSpeedValue")
    info.txt_LuckValue = UI.getChildControl(info.slot, "StaticText_LuckValue")
    info.txt_ActionValue = UI.getChildControl(info.slot, "StaticText_ActionPointValue")
    info.txt_UpgradeChangeValue = UI.getChildControl(info.slot, "StaticText_UpgradeChanceCountValue")
    info.txt_MoneyValue = UI.getChildControl(info.slot, "StaticText_MoneyValue")
    info.btn_Buy = UI.getChildControl(info.slot, "Button_Base")
    info.txt_State = UI.getChildControl(info.slot, "StaticText_State")
    info.txt_State:SetTextMode(__eTextMode_AutoWrap)
    info.txt_levelValue = UI.getChildControl(info.slot, "StaticText_WorkerLevelValue")
    info.txt_WorkSpeedTitle:SetTextMode(__eTextMode_LimitText)
    info.txt_WorkSpeedTitle:SetText(info.txt_WorkSpeedTitle:GetText())
    info.txt_MoveSpeedTitle:SetTextMode(__eTextMode_LimitText)
    info.txt_MoveSpeedTitle:SetText(info.txt_MoveSpeedTitle:GetText())
    info.icon = {}
    for skillIdx = 1, PaGlobal_WorkerAuction_All._config._maxSkillCount do
      info.iconBg = UI.getChildControl(info.slot, "Static_SkillIconBg_" .. skillIdx)
      info.icon[skillIdx] = UI.getChildControl(info.iconBg, "Static_SkillIcon_" .. skillIdx)
    end
    info.slot:SetPosX(PaGlobal_WorkerAuction_All._config._startX)
    info.slot:SetPosY(PaGlobal_WorkerAuction_All._config._startY + (info.slot:GetSizeY() + PaGlobal_WorkerAuction_All._config._gapY) * index)
    info.slot:SetShow(false)
    PaGlobal_WorkerAuction_All._slotList[index] = info
  end
end
function PaGlobal_WorkerAuction_All:checkRandomWorkerOpen()
  if true == _ContentsGroup_NewUI_WorkerRandomSelect_All then
    if nil ~= Panel_Window_WorkerRandomSelect_All and true == Panel_Window_WorkerRandomSelect_All:GetShow() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_COMPLETE_WORKERCONTRACT"))
      return false
    end
  elseif true == PaGlobal_WorkerAuction_All._isConsole then
    if (nil ~= Panel_Dialog_RandomWorker or nil ~= Panel_Dialog_RandomWorker) and (Panel_Dialog_RandomWorker:GetShow() or Panel_Dialog_WorkerContract:GetShow()) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_COMPLETE_WORKERCONTRACT"))
      return false
    end
  elseif nil ~= Panel_Window_WorkerRandomSelect and true == Panel_Window_WorkerRandomSelect:IsShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_COMPLETE_WORKERCONTRACT"))
    return false
  end
  return true
end
function PaGlobal_WorkerAuction_All:prepareOpen()
  if nil == Panel_Window_WorkerAuction_All or true == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  local curWaypointKey = getCurrentWaypointKey()
  if nil ~= curWaypointKey then
    PaGlobal_WorkerAuction_All._plantKey = ToClient_convertWaypointKeyToPlantKey(getCurrentWaypointKey())
    PaGlobal_WorkerAuction_All._workerAuctionInfo = RequestGetAuctionInfo()
  end
  if nil ~= getSelfPlayer() and nil ~= warehouse_moneyFromNpcShop_s64() then
    local invenMoney64 = getSelfPlayer():get():getInventory():getMoney_s64()
    local wareMoney64 = warehouse_moneyFromNpcShop_s64()
    if invenMoney64 > wareMoney64 then
      PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney:SetCheck(true)
      PaGlobal_WorkerAuction_All._ui._rdo_WareMoney:SetCheck(false)
    else
      PaGlobal_WorkerAuction_All._ui._rdo_WareMoney:SetCheck(true)
      PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney:SetCheck(false)
    end
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
  PaGlobal_WorkerAuction_All:open()
  PaGlobal_WorkerAuction_All:onScreenResize()
end
function PaGlobal_WorkerAuction_All:open()
  if nil == Panel_Window_WorkerAuction_All or true == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Panel_Window_WorkerAuction_All:SetShow(true)
end
function PaGlobal_WorkerAuction_All:update(tabIndex)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All:resetSlot()
  PaGlobal_WorkerSkillTooltip_All_Hide()
  if PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST == tabIndex then
    PaGlobal_WorkerAuction_All:updateWorkerMarketList()
  elseif PaGlobal_WorkerAuction_All._ENUMTABINDEX_REGISTER == tabIndex then
    PaGlobal_WorkerAuction_All:updateMyWorkerList(false)
  else
    PaGlobal_WorkerAuction_All:updateMyWorkerList(true)
  end
  PaGlobal_WorkerAuction_All:updateMoney()
end
function PaGlobal_WorkerAuction_All:prepareClose()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_WorkerSkillTooltip_All_Hide()
  PaGlobal_WorkerAuction_All:resetSlot()
  PaGlobal_WorkerAuction_All:resetData()
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_WorkerAuction_All:close()
  if false == _ContentsGroup_NewUI_Dialog_All and true == _ContentsGroup_RenewUI then
    PaGlobalFunc_MainDialog_ReOpen()
  end
end
function PaGlobal_WorkerAuction_All:close()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Panel_Window_WorkerAuction_All:SetShow(false)
end
function PaGlobal_WorkerAuction_All:resetData()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._plantKey = -1
  PaGlobal_WorkerAuction_All._workerAuctionInfo = -1
  PaGlobal_WorkerAuction_All._selectedWorker = -1
  PaGlobal_WorkerAuction_All._currentPage = 1
  PaGlobal_WorkerAuction_All._maxPage = 1
  PaGlobal_WorkerAuction_All._ui._rdo_InvenMoney:SetCheck(true)
  PaGlobal_WorkerAuction_All._ui._rdo_WareMoney:SetCheck(false)
  PaGlobal_WorkerAuction_All._selectedTab = PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST
  for ii = 0, #PaGlobal_WorkerAuction_All._radioTabList do
    if ii == PaGlobal_WorkerAuction_All._selectedTab then
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(true)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_SELECTED)
      local selectBarSapnX = PaGlobal_WorkerAuction_All._radioTabList[ii]:GetSpanSize().x
      local selectBarSapnY = PaGlobal_WorkerAuction_All._ui._stc_SelectBar:GetSpanSize().y
      PaGlobal_WorkerAuction_All._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
    else
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(false)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_BASE)
    end
  end
end
function PaGlobal_WorkerAuction_All:updateWorkerMarketList()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  local listCount = auctionInfo:getWorkerAuctionCount()
  local uiIndex = 0
  local contents = PaGlobal_WorkerAuction_All._slotList
  PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if listCount <= 0 then
    if true == self._isConsole then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_NOWORKER"))
    end
    for index = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
      contents[index].slot:SetShow(false)
    end
    return
  end
  for index = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    if listCount <= index then
      break
    end
    if uiIndex >= PaGlobal_WorkerAuction_All._config._maxSlotCount then
      break
    end
    local info = contents[uiIndex]
    local workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(index, true)
    if nil == workerInfo then
      info.slot:SetShow(false)
      break
    end
    info.slotImage:ChangeTextureInfoName(workerInfo.icon)
    info.txt_SlotName:SetText(workerInfo.name .. "<PAColor0xFF5A5A5A> (" .. workerInfo.town .. ")<PAOldColor>")
    info.txt_UpgradeChangeValue:SetTextHorizonRight()
    if 4 <= workerInfo.grade then
      info.txt_UpgradeChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOTUPGRADE"))
      if info.txt_UpgradeChangeValue:GetSizeX() + 10 < info.txt_UpgradeChangeValue:GetTextSizeX() then
        info.txt_UpgradeChangeValue:SetTextHorizonCenter()
      end
      info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_DISABLED)
    else
      info.txt_UpgradeChangeValue:SetText(workerInfo.upgradeCount)
      info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_ACTIVE)
    end
    info.txt_WorkSpeedValue:SetText(string.format("%.2f", tostring(workerInfo.workSpeed / 1000000)))
    info.txt_LuckValue:SetText(string.format("%.2f", workerInfo.luck / 10000))
    info.txt_MoveSpeedValue:SetText(string.format("%.2f", workerInfo.moveSpeed / 100))
    info.txt_ActionValue:SetText(workerInfo.maxActionPoint)
    info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.maxPrice))
    info.txt_State:SetShow(false)
    info.btn_Buy:SetShow(true)
    info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERTRADEHIRE_BUYBUTTON"))
    info.txt_levelValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. workerInfo.level)
    workerInfo.workerWrapperLua:foreachSkillList(function(skillIdx, skillStaticStatusWrapper)
      local iconIdx = skillIdx + 1
      if nil == info.icon[iconIdx] then
        info.icon[iconIdx]:addInputEvent("Mouse_On", "")
        info.icon[iconIdx]:addInputEvent("Mouse_Out", "")
        return true
      end
      info.icon[iconIdx]:ChangeTextureInfoName(skillStaticStatusWrapper:getIconPath())
      local x1, y1, x2, y2 = setTextureUV_Func(info.icon[iconIdx], 0, 0, 44, 44)
      info.icon[iconIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
      info.icon[iconIdx]:setRenderTexture(info.icon[iconIdx]:getBaseTexture())
      if false == PaGlobal_WorkerAuction_All._isConsole then
        info.icon[iconIdx]:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_ChangePage( true," .. uiIndex .. "," .. iconIdx .. "," .. index .. ",true)")
        info.icon[iconIdx]:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_ChangePage()")
      end
      return false
    end)
    if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
      PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
      info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. "," .. "true" .. ")")
      info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
    end
    if true == workerInfo.isMine then
      info.txt_State:SetShow(true)
      info.btn_Buy:SetShow(false)
      info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_REGISTINGNOW"))
    elseif false == PaGlobal_WorkerAuction_All._isConsole then
      info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_BuyWorker(" .. index .. ")")
    else
      info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_BuyWorker(" .. index .. ")")
    end
    info.slot:SetShow(true)
    uiIndex = uiIndex + 1
  end
end
function PaGlobal_WorkerAuction_All:updateMyWorkerList(isRegisteredMyWorkerList)
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  local listCount
  local uiIndex = 0
  if true == isRegisteredMyWorkerList then
    listCount = auctionInfo:getWorkerAuctionCount()
  else
    local plantKey = PaGlobal_WorkerAuction_All._plantKey
    if nil == plantKey then
      return
    end
    listCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
  end
  PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if listCount <= 0 and false == isRegisteredMyWorkerList then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_NOWORKER"))
    return
  end
  local startWorkerDataIndex = (PaGlobal_WorkerAuction_All._currentPage - 1) * PaGlobal_WorkerAuction_All._config._maxSlotCount
  if listCount <= startWorkerDataIndex then
    PaGlobal_WorkerAuction_All._currentPage = 1
    startWorkerDataIndex = 0
  end
  local uiIndex = 0
  local contents = PaGlobal_WorkerAuction_All._slotList
  for index = startWorkerDataIndex, startWorkerDataIndex + PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    if listCount <= index then
      break
    end
    local info = contents[uiIndex]
    local workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(index, isRegisteredMyWorkerList)
    if nil == workerInfo then
      info.slot:SetShow(false)
      break
    end
    info.txt_UpgradeChangeValue:SetTextHorizonRight()
    if 4 <= workerInfo.grade then
      info.txt_UpgradeChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOTUPGRADE"))
      if info.txt_UpgradeChangeValue:GetSizeX() + 10 < info.txt_UpgradeChangeValue:GetTextSizeX() then
        info.txt_UpgradeChangeValue:SetTextHorizonCenter()
      end
      info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_DISABLED)
    else
      info.txt_UpgradeChangeValue:SetText(workerInfo.upgradeCount)
      info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_ACTIVE)
    end
    info.slotImage:ChangeTextureInfoName(workerInfo.icon)
    info.txt_SlotName:SetText(workerInfo.name .. "<PAColor0xFF5A5A5A> (" .. workerInfo.town .. ")<PAOldColor>")
    info.txt_WorkSpeedValue:SetText(string.format("%.2f", tostring(workerInfo.workSpeed / 1000000)))
    info.txt_LuckValue:SetText(string.format("%.2f", workerInfo.luck / 10000))
    info.txt_MoveSpeedValue:SetText(string.format("%.2f", workerInfo.moveSpeed / 100))
    info.txt_ActionValue:SetText(workerInfo.actionPoint)
    info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.maxPrice))
    info.txt_levelValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. workerInfo.level)
    workerInfo.workerWrapperLua:foreachSkillList(function(skillIdx, skillStaticStatusWrapper)
      local iconIdx = skillIdx + 1
      if nil == info.icon[iconIdx] then
        info.icon[iconIdx]:addInputEvent("Mouse_On", "")
        info.icon[iconIdx]:addInputEvent("Mouse_Out", "")
        return true
      end
      info.icon[iconIdx]:ChangeTextureInfoName(skillStaticStatusWrapper:getIconPath())
      local x1, y1, x2, y2 = setTextureUV_Func(info.icon[iconIdx], 0, 0, 44, 44)
      info.icon[iconIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
      info.icon[iconIdx]:setRenderTexture(info.icon[iconIdx]:getBaseTexture())
      if false == PaGlobal_WorkerAuction_All._isConsole then
        info.icon[iconIdx]:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_ChangePage( true," .. uiIndex .. "," .. iconIdx .. "," .. index .. "," .. tostring(isRegisteredMyWorkerList) .. ")")
        info.icon[iconIdx]:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_ChangePage()")
      end
      return false
    end)
    if true == isRegisteredMyWorkerList then
      info.txt_State:SetShow(false)
      info.btn_Buy:SetShow(true)
      _PA_LOG("\236\157\180\235\139\164\237\152\156", Int64toInt32(workerInfo.workerPrice))
      if nil ~= workerInfo.workerPrice and 0 < Int64toInt32(workerInfo.workerPrice) then
        info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.workerPrice))
      end
      if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
        PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
        info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. "," .. "true" .. ")")
        info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
      end
      local isEndAuction = auctionInfo:getWorkerAuctionEnd(workerInfo.workerNo)
      if true == isEndAuction then
        info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERAUCTION_WORKERGETPRICE"))
        if false == PaGlobal_WorkerAuction_All._isConsole then
          info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ReceiveMoney(" .. index .. ")")
        else
          info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_ReceiveMoney(" .. index .. ")")
        end
      else
        info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKETSET_REGISTCANCLE_BTN"))
        if false == PaGlobal_WorkerAuction_All._isConsole then
          info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_CancelRegistWorker(" .. index .. ")")
        else
          info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_CancelRegistWorker(" .. index .. ")")
        end
      end
    else
      if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
        PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
        info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. ",false)")
        info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
      end
      info.txt_State:SetShow(true)
      info.btn_Buy:SetShow(false)
      if true == workerInfo.isAuctionRegister then
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_REGISTINGNOW"))
      elseif true == workerInfo.isWorking then
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKINGNOW"))
      elseif workerInfo.actionPoint ~= workerInfo.maxActionPoint then
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WORKERTRADE_RENEW_WORKER_LACK"))
      elseif workerInfo.grade < 2 then
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WORKERTRADE_RENEW_GRADE_LACK"))
      elseif workerInfo.defaultSkillStatus then
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOT_REGIST"))
      else
        info.txt_State:SetShow(false)
        info.btn_Buy:SetShow(true)
        info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERAUCTION_WORKERRESIST_BTN"))
        if false == PaGlobal_WorkerAuction_All._isConsole then
          info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_RegistWorker(" .. index .. ")")
        else
          info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_RegistWorker(" .. index .. ")")
        end
      end
    end
    info.btn_Buy:SetTextMode(__eTextMode_AutoWrap)
    info.btn_Buy:SetText(info.btn_Buy:GetText())
    if info.btn_Buy:GetTextSizeX() < info.btn_Buy:GetSizeX() or info.btn_Buy:GetTextSizeY() < info.btn_Buy:GetSizeY() then
      UI.setLimitTextAndAddTooltip(info.btn_Buy)
    end
    info.slot:SetShow(true)
    uiIndex = uiIndex + 1
  end
end
function PaGlobal_WorkerAuction_All:getWorkEfficiency(workerWrapperLua)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if nil == workerWrapperLua then
    return
  end
  local _tempWorkEfficiency = 0
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(2) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(2)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(5) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(5)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(6) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(6)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(8) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(8)
  end
  return _tempWorkEfficiency
end
function PaGlobal_WorkerAuction_All:getWorkerInfo(index, isAuction)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local workerWrapperLua, workerNoRaw, workerPrice
  if true == isAuction then
    local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
    workerNoRaw = auctionInfo:getWorkerAuction(index)
    workerWrapperLua = getWorkerWrapperByAuction(workerNoRaw, true)
    workerPrice = auctionInfo:getWorkerAuctionPrice(workerNoRaw)
  else
    local plantKey = PaGlobal_WorkerAuction_All._plantKey
    if nil ~= plantKey then
      workerNoRaw = ToClient_getPlantWaitWorkerNoRawByIndex(plantKey, index)
      workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
    end
  end
  if nil == workerWrapperLua then
    return nil
  end
  local function getGradeToColorString()
    local auctionAll = PaGlobal_WorkerAuction_All
    local grade = workerWrapperLua:getGradeXXX()
    if CppEnums.CharacterGradeType.CharacterGradeType_Normal == grade then
      return "<PAColor0xFFB9C2DC>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Elite == grade then
      return "<PAColor0xFF83A543>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Hero == grade then
      return "<PAColor0xFF438DCC>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Legend == grade then
      return "<PAColor0xFFF5BA3A>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Boss == grade then
      return "<PAColor0xFFD05D48>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Assistant == grade then
      return "<PAColor0xFFB9C2DC>"
    end
    return "<PAColor0xFFB9C2DC>"
  end
  local getWorkEfficiency = function(workerWrapperLua)
    local _tempWorkEfficiency = 0
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(2) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(2)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(5) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(5)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(6) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(6)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(8) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(8)
    end
    return _tempWorkEfficiency
  end
  local workerInfo = {
    workerWrapperLua = nil,
    workerNo = nil,
    icon = nil,
    defaultSkillStatus = nil,
    name = nil,
    town = nil,
    level = nil,
    luck = nil,
    moveSpeed = nil,
    minPrice = nil,
    maxPrice = nil,
    auctionPrice = nil,
    actionPoint = nil,
    maxActionPoint = nil,
    workSpeed = nil,
    isAuctionRegister = false,
    isWorking = false,
    grade = nil,
    upgradeCount = nil,
    isMine = false
  }
  workerInfo.workerWrapperLua = workerWrapperLua
  workerInfo.workerNo = workerNoRaw
  workerInfo.icon = workerWrapperLua:getWorkerIcon()
  workerInfo.defaultSkillStatus = workerWrapperLua:getWorkerDefaultSkillStaticStatus()
  workerInfo.town = ToClient_GetNodeNameByWaypointKey(workerWrapperLua:getHomeWaypoint())
  workerInfo.name = getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  workerInfo.level = workerWrapperLua:getLevel()
  workerInfo.luck = workerWrapperLua:getLuck()
  workerInfo.moveSpeed = workerWrapperLua:getMoveSpeed()
  workerInfo.isMine = workerWrapperLua:isMine()
  workerInfo.minPrice = workerWrapperLua:getWorkerMinPrice()
  workerInfo.maxPrice = workerWrapperLua:getWorkerMaxPrice()
  workerInfo.actionPoint = workerWrapperLua:getActionPoint()
  workerInfo.maxActionPoint = workerWrapperLua:getMaxActionPoint()
  workerInfo.workSpeed = getWorkEfficiency(workerWrapperLua)
  workerInfo.isAuctionRegister = workerWrapperLua:getIsAuctionInsert()
  workerInfo.isWorking = workerWrapperLua:isWorking()
  workerInfo.grade = workerWrapperLua:getGrade()
  workerInfo.upgradeCount = workerWrapperLua:getUpgradePoint()
  workerInfo.workerPrice = workerPrice
  return workerInfo
end
function PaGlobal_WorkerAuction_All:updateMoney()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if nil ~= getSelfPlayer() and nil ~= warehouse_moneyFromNpcShop_s64() then
    PaGlobal_WorkerAuction_All._ui._txt_InvenMoney:SetText(makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64()))
    PaGlobal_WorkerAuction_All._ui._txt_WareMoney:SetText(makeDotMoney(warehouse_moneyFromNpcShop_s64()))
  end
end
function PaGlobal_WorkerAuction_All:resetSlot()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local info = PaGlobal_WorkerAuction_All._slotList
  for ii = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    info[ii].slot:SetShow(false)
    if false == PaGlobal_WorkerAuction_All._isConsole then
      info[ii].btn_Buy:addInputEvent("Mouse_LUp", "")
      info[ii].slot:addInputEvent("Mouse_On", "")
      info[ii].slot:addInputEvent("Mouse_Out", "")
    else
      info[ii].slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      info[ii].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    end
    for jj = 1, PaGlobal_WorkerAuction_All._config._maxSkillCount do
      info[ii].icon[jj]:ChangeTextureInfoName("")
      info[ii].icon[jj]:SetSpanSize(1, 2)
      info[ii].icon[jj]:addInputEvent("Mouse_On", "")
      info[ii].icon[jj]:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._maxPage = math.floor(listCount / PaGlobal_WorkerAuction_All._config._maxSlotCount)
  if 0 ~= listCount % PaGlobal_WorkerAuction_All._config._maxSlotCount then
    PaGlobal_WorkerAuction_All._maxPage = PaGlobal_WorkerAuction_All._maxPage + 1
  end
  if PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST == PaGlobal_WorkerAuction_All._selectedTab then
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage))
  elseif 0 == PaGlobal_WorkerAuction_All._maxPage then
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage) .. " / " .. tostring(PaGlobal_WorkerAuction_All._maxPage + 1))
  else
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage) .. " / " .. tostring(PaGlobal_WorkerAuction_All._maxPage))
  end
end
function PaGlobal_WorkerAuction_All:AudioPostEvent(idx, value)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if true == PaGlobal_WorkerAuction_All._isConsole then
    _AudioPostEvent_SystemUiForXBOX(idx, value)
  else
    audioPostEvent_SystemUi(idx, value)
  end
end
