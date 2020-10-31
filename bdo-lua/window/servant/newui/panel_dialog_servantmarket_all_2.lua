function PaGlobalFunc_ServantMarket_All_Open()
  if nil == Panel_Dialog_ServantMarket_All or true == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:prepareOpen()
end
function PaGlobalFunc_ServantMarket_All_Close()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:prepareClose()
end
function FromClient_ServantMarket_All_OnScreenResize()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  Panel_Dialog_ServantMarket_All:ComputePos()
end
function PaGlobalFunc_ServantMarket_All_ShowAni()
  if nil == Panel_Dialog_ServantMarket_All then
    return
  end
  if true == Panel_Dialog_ServantMarket_All:GetShow() then
    Panel_Dialog_ServantMarket_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo1 = Panel_Dialog_ServantMarket_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo1:SetStartIntensity(3)
    aniInfo1:SetEndIntensity(1)
    aniInfo1.IsChangeChild = true
    aniInfo1:SetHideAtEnd(true)
    aniInfo1:SetDisableWhileAni(true)
  else
    UIAni.fadeInSCR_Down(Panel_Dialog_ServantMarket_All)
    Panel_Dialog_ServantMarket_All:SetShow(true, false)
  end
end
function PaGlobalFunc_ServantMarket_All_HideAni()
  if nil == Panel_Dialog_ServantMarket_All then
    return
  end
  Panel_Dialog_ServantMarket_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantMarket_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function HandleEventLUp_ServantMarket_All_OpenComboBox(idx)
  if nil == Panel_Dialog_ServantMarket_All or nil == idx then
    return
  end
  if 1 == idx then
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Tier:ToggleListbox()
  elseif 2 == idx then
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Skill:ToggleListbox()
  elseif 3 == idx then
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Gender:ToggleListbox()
  end
end
function HandleEventLUp_ServantMarket_All_SelectComboBox(idx)
  if nil == Panel_Dialog_ServantMarket_All or nil == idx then
    return
  end
  if 1 == idx then
    local tierIndex = PaGlobal_ServantMarket_All._ui._stc_ComboBox_Tier:GetSelectIndex()
    if nil ~= tierIndex then
      if tierIndex <= 0 then
        tierIndex = 0
      end
      SetAuctionServantTierFilter(tierIndex, PaGlobal_ServantMarket_All._isFromNpc)
    end
  elseif 2 == idx then
    local skillIndex = PaGlobal_ServantMarket_All._ui._stc_ComboBox_Skill:GetSelectIndex()
    if nil ~= skillIndex and nil ~= PaGlobal_ServantMarket_All._skillFilterSelectIndex then
      if 0 < skillIndex and 1 < #PaGlobal_ServantMarket_All._skillFilterSelectIndex then
        skillIndex = PaGlobal_ServantMarket_All._skillFilterSelectIndex[skillIndex - 1]
        local skillWrapper = getVehicleSkillStaticStatus(skillIndex)
        if nil == skillWrapper then
          return
        end
        local skillName = skillWrapper:getName()
      else
        skillIndex = 0
      end
      setAuctionServantSkillFilter(skillIndex, PaGlobal_ServantMarket_All._isFromNpc)
    end
  elseif 3 == idx then
    local genderIndex = PaGlobal_ServantMarket_All._ui._stc_ComboBox_Gender:GetSelectIndex()
    if nil ~= genderIndex then
      if genderIndex <= 0 then
        genderIndex = 0
      end
      setAuctionServantSexFilter(genderIndex, PaGlobal_ServantMarket_All._isFromNpc)
    end
  else
    return
  end
end
function FromClient_ServantMarket_All_UpdateMoney()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:moneyUpdate()
end
function HandleEventOn_MarketServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  PaGlobal_ServantMarket_All:MarketServant_Tooltip_Open(actorKeyRaw, key32, slotIdx)
end
function HandleEventOnOut_ServantMarket_All_ShowSimpleTooltip(tipType, isShow)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() or false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_DESC")
    control = PaGlobal_ServantMarket_All._ui._txt_InvenTitle
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_WAREHOUSE_DESC")
    control = PaGlobal_ServantMarket_All._ui._txt_WareTitle
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantMarket_All_PageChange(isNext)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() or nil == isNext then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  if true == isNext then
    if PaGlobal_ServantMarket_All._selectMaxPage <= PaGlobal_ServantMarket_All._selectPage then
      return
    end
    PaGlobal_ServantMarket_All._selectPage = PaGlobal_ServantMarket_All._selectPage + 1
    if true == PaGlobal_ServantMarket_All._isTabMyRegister then
      PaGlobal_ServantMarket_All:update()
    else
      RequestAuctionNextPage(0, PaGlobal_ServantMarket_All._isFromNpc)
    end
  else
    if 0 >= PaGlobal_ServantMarket_All._selectPage then
      return
    end
    PaGlobal_ServantMarket_All._selectPage = PaGlobal_ServantMarket_All._selectPage - 1
    if true == PaGlobal_ServantMarket_All._isTabMyRegister then
      PaGlobal_ServantMarket_All:update()
    else
      RequestAuctionPrevPage(0, PaGlobal_ServantMarket_All._isFromNpc)
    end
  end
end
function HandleEventLUp_ServantMarket_All_Buy(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All._selectSlotNo = slotNo
  local BuyConfirm = function()
    local fromWhereType = MessageBoxCheck.isCheck()
    stable_requestBuyItNowServant(PaGlobal_ServantMarket_All._selectSlotNo, fromWhereType)
    PaGlobal_ServantMarket_All._selectSlotNo = nil
    HandleEventLUp_ServantMarket_All_Reload()
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  local servantInfo = myAuctionInfo:getServantAuctionListAt(slotNo)
  if nil == servantInfo then
    return
  end
  local price = makeDotMoney(servantInfo:getAuctoinPrice_s64())
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTMARKET_ALL_CONFIRMPRICE", "price", price)
  local _confirmFunction = BuyConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_All_Cancel(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  local function CancelConfirm()
    stable_cancelServantFromSomeWhereElse(slotNo, CppEnums.AuctionType.AuctionGoods_ServantMarket)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ITEMSET_REGISTCANCEL_DO")
  local _confirmFunction = CancelConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_All_Recieve(slotNo)
  if nil == slotNo or nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  local toWhereType = 0
  local function receiveMoney()
    local toWhereType = MessageBoxCheck.isCheck()
    stable_popServantPrice(slotNo, CppEnums.AuctionType.AuctionGoods_ServantMarket, toWhereType)
  end
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTMARKET_ALL_RECEIVE_MONEY")
  local _confirmFunction = receiveMoney
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  local messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBoxCheck.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantMarket_All_Reload()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  RequestActionReloadPage(0, PaGlobal_ServantMarket_All._isFromNpc)
end
function FromClient_ServantMarket_All_ResponseServantBuyItNowFail()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Default then
    return
  end
  RequestActionReloadPage(0, PaGlobal_ServantMarket_All._isFromNpc)
  PaGlobal_ServantMarket_All:update()
end
function FromClient_ServantMarket_All_UpdateSlot()
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:update()
end
function HandleEventPadPress_ServantMarket_All_TabChange_Console()
  if true == PaGlobal_ServantMarket_All._isTabMyRegister then
    HandleEventLUp_ServantMarket_All_TabChange(false)
  else
    HandleEventLUp_ServantMarket_All_TabChange(true)
  end
end
function HandleEventLUp_ServantMarket_All_TabChange(isTabMyRegister)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if isTabMyRegister == PaGlobal_ServantMarket_All._isTabMyRegister then
    return
  end
  PaGlobal_ServantMarket_All._isTabMyRegister = isTabMyRegister
  local selectBarY = PaGlobal_ServantMarket_All._ui._stc_SelectedLine:GetSpanSize().y
  if true == isTabMyRegister then
    PaGlobalFunc_ServantMarket_All_SetFilterShow(false)
    local tabSpanX = PaGlobal_ServantMarket_All._ui._rdo_Tab_MyRegistList:GetSpanSize().x
    PaGlobal_ServantMarket_All._ui._rdo_Tab_MarketList:SetCheck(false)
    PaGlobal_ServantMarket_All._ui._rdo_Tab_MyRegistList:SetCheck(true)
    PaGlobal_ServantMarket_All._ui._stc_SelectedLine:SetSpanSize(tabSpanX, selectBarY)
    requestMyServantMarketList(PaGlobal_ServantMarket_All._isFromNpc)
  else
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Tier:SetText(PaGlobal_ServantMarket_All._string_ServantTier[0])
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Skill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_FILTER_ALL"))
    PaGlobal_ServantMarket_All._ui._stc_ComboBox_Gender:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_SEXFILTER_2"))
    PaGlobalFunc_ServantMarket_All_SetFilterShow(true)
    local tabSpanX = PaGlobal_ServantMarket_All._ui._rdo_Tab_MarketList:GetSpanSize().x
    PaGlobal_ServantMarket_All._ui._rdo_Tab_MarketList:SetCheck(true)
    PaGlobal_ServantMarket_All._ui._rdo_Tab_MyRegistList:SetCheck(false)
    PaGlobal_ServantMarket_All._ui._stc_SelectedLine:SetSpanSize(tabSpanX, selectBarY)
    setAuctionServantSkillFilter(0, PaGlobal_ServantMarket_All._isFromNpc)
    SetAuctionServantTierFilter(0, PaGlobal_ServantMarket_All._isFromNpc)
    setAuctionServantSexFilter(2, PaGlobal_ServantMarket_All._isFromNpc)
  end
  PaGlobal_ServantMarket_All._selectMaxPage = 0
  PaGlobal_ServantMarket_All._selectPage = 0
end
function PaGlobalFunc_ServantMarket_All_SetFilterShow(isShow)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_TierTitle:SetShow(isShow)
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_GenderTitle:SetShow(isShow)
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_SkillTitle:SetShow(isShow)
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_Tier:SetShow(isShow)
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_Skill:SetShow(isShow)
  PaGlobal_ServantMarket_All._ui._stc_ComboBox_Gender:SetShow(isShow)
end
function FromClient_ServantMarket_All_List2UpdateSlot0(content, key)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:list2Update(content, key, 0)
end
function FromClient_ServantMarket_All_List2UpdateSlot1(content, key)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:list2Update(content, key, 1)
end
function FromClient_ServantMarket_All_List2UpdateSlot2(content, key)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:list2Update(content, key, 2)
end
function FromClient_ServantMarket_All_List2UpdateSlot3(content, key)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  PaGlobal_ServantMarket_All:list2Update(content, key, 3)
end
function HandleEventOnOut_ServantMarket_All_ShowDiscountRateTooltip(isShow)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == ToClient_GetServantMarketTaxPercent() then
    return
  end
  local disCountRate = ToClient_GetServantMarketTaxPercent() / 10000
  local control = PaGlobal_ServantMarket_All._ui._stc_DiscountRate
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_DISCOUNT_TOOLTIP_NAME")
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEMARKET_DISCOUNT_BTN_TOOLTIP_DESC", "rate", disCountRate)
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantMarket_All_ShowBeforeLook(servantIdx, slotIdx)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if nil == servantIdx or nil == slotIdx or nil == PaGlobal_ServantMarket_All._ui._servantSlot or nil == PaGlobal_ServantMarket_All._auctionInfo then
    return
  end
  local slot = PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]
  local myAuctionInfo = PaGlobal_ServantMarket_All._auctionInfo
  local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(servantIdx)
  if true == slot._isLookChange then
    slot._stc_HorseImage:ChangeTextureInfoName(auctionServantInfo:getIconPath1())
  else
    slot._stc_HorseImage:ChangeTextureInfoName(auctionServantInfo:getBaseIconPath1())
  end
  slot._isLookChange = not slot._isLookChange
end
function HandleEventLUp_ServantMarket_All_ShowBeforeLook_Tooltip(isShow, slotIdx)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() then
    return
  end
  if false == isShow or nil == slotIdx then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx] then
    return
  end
  local uiControl = PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]._btn_beforeLook
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_LOOKCHANGETOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_LOOKCHANGETOOLTIP_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventOnOut_ServantMarket_All_BuyBtnTextChange(slotIdx, isShow, horseIdx)
  if nil == Panel_Dialog_ServantMarket_All or false == Panel_Dialog_ServantMarket_All:GetShow() or nil == slotIdx then
    return
  end
  if nil == PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx] then
    return
  end
  if false == isShow then
    local myAuctionInfo = RequestGetAuctionInfo()
    local auctionServantInfo = myAuctionInfo:getServantAuctionListAt(horseIdx)
    if nil ~= auctionServantInfo then
      PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]._btn_BUY_PC:SetText(makeDotMoney(auctionServantInfo:getAuctoinPrice_s64()))
    end
  else
    PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]._btn_BUY_PC:SetText(PAGetString(Defines.StringSheet_RESOURCE, "NPCSHOP_BUY"))
  end
end
function PaGlobalFunc_ServantMarket_All_ChangePageByARROWKEY(deltaTime)
  if nil == Panel_Dialog_ServantFunction_All and false == Panel_Dialog_ServantFunction_All:GetShow() then
    Panel_Dialog_ServantMarket_All:ClearUpdateLuaFunc()
    return
  end
  if isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_LEFT) then
    HandleEventLUp_ServantMarket_All_PageChange(false)
  elseif isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_RIGHT) then
    HandleEventLUp_ServantMarket_All_PageChange(true)
  end
end
function HandleEventOnOut_Dialog_ServantMarket_All_ShowToolTip(slotIdx, idx, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_ServantMarket_All._ui._servantSlot[slotIdx]._tooltipControls[idx]
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_ServantMarket_All_SetKeyGuideText(type, slotIndex)
  if nil == type then
    return
  end
  if 0 == type then
    PaGlobal_ServantMarket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif 1 == type then
    PaGlobal_ServantMarket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLEMARKET_BTN_RECEIVE"))
  elseif 2 == type then
    PaGlobal_ServantMarket_All._ui._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "NPCSHOP_BUY"))
  end
  local servantSlot = PaGlobal_ServantMarket_All._ui._servantSlot[slotIndex]
  PaGlobal_ServantMarket_All._ui._stc_KeyGuide_RS:SetShow(servantSlot._list2_Control:GetVScroll():GetShow())
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_ServantMarket_All._keyguides, PaGlobal_ServantMarket_All._ui._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  PaGlobal_ServantMarket_All._selectIndex = slotIndex
end
function HandleEventPadDown_ServantMarket_All_YPressTooltipShow()
  if true == PaGlobal_ServantMarket_All._ui._stc_KeyGuide_Y_Tooltip:GetShow() then
    PaGlobal_ServantMarket_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(false)
  else
    PaGlobal_ServantMarket_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(true)
  end
end
function HandleEventPadDown_ServantMarket_All_YPressTooltipHide()
  PaGlobal_ServantMarket_All._ui._stc_KeyGuide_Y_Tooltip:SetShow(false)
end
function HandleEventPadPress_ServantMarket_All_TooltipHide()
  if true == PaGlobal_ServantMarket_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
end
function HandleEventScroll_ServantMarket_All_ServantSkill(isUp)
  if nil == Panel_Dialog_ServantMarket_All then
    return
  end
  local servantSlot = PaGlobal_ServantMarket_All._ui._servantSlot[PaGlobal_ServantMarket_All._selectIndex]
  if nil == servantSlot then
    return
  end
  local list2 = servantSlot._list2_Control
  if true == isUp then
    list2:MouseUpScroll(list2)
  else
    list2:MouseDownScroll(list2)
  end
end
