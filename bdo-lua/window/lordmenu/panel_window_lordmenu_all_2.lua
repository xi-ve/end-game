function PaGlobalFunc_LordMenu_All_ShowAni()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  Panel_Window_LordMenu_All:SetAlpha(0)
  UIAni.fadeInSCR_Down(Panel_LordMenu)
end
function PaGlobalFunc_LordMenu_All_HideAni()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_LordMenu_All, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
function HandleEventLUp_LordMenu_All_Close()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  PaGlobal_LordMenu_All:prepareClose()
end
function PaGlobalFunc_LordMenu_All_Open()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  PaGlobal_LordMenu_All:prepareOpen()
end
function FromClient_LordMenu_All_PayInfoUpdate()
  if nil == Panel_Window_LordMenu_All or self._ENUM_TAXINFO ~= PaGlobal_LordMenu_All._currentTab then
    return
  end
  PaGlobal_LordMenu_All:update(1)
end
function FromClient_LordMenu_All_TaxInfoUpdate()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  PaGlobal_LordMenu_All:update(2)
end
function FromClient_LordMenu_NotifyUpdateTownTax(regionKeyRow)
  if nil == Panel_TerritoryTex_Message or nil == Panel_Window_LordMenu_All then
    return
  end
  local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKeyRow)
  if nil == siegeWrapper then
    return
  end
  local territoryName = siegeWrapper:getTerritoryName()
  local transferTaxRate = siegeWrapper:getTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  local _texMessage = ""
  if PaGlobal_LordMenu_All._texFirstNotifyCheck == true then
    PaGlobal_LordMenu_All._transferTaxRate = transferTaxRate
    texFirstNotifyCheck = false
    _texMessage = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LORDMENU_NOTIFYUPDATETOWNTAX_APPLY", "territoryName", territoryName, "transferTaxRate", tostring(transferTaxRate))
  elseif PaGlobal_LordMenu_All._transferTaxRate == transferTaxRate then
    return
  else
    PaGlobal_LordMenu_All._transferTaxRate = transferTaxRate
    _texMessage = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LORDMENU_NOTIFYUPDATETOWNTAX_CHANGE", "territoryName", territoryName, "transferTaxRate", tostring(transferTaxRate))
  end
end
function FromClient_LordMenu_OnScreenResize()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  Panel_Window_LordMenu_All:ComputePos()
end
function PaGlobalFunc_LordMenu_All_SelectOtherTab(idx)
  if nil == Panel_Window_LordMenu_All then
    return
  end
  for ii = 0, #PaGlobal_LordMenu_All._loadMenuTabs do
    if nil ~= PaGlobal_LordMenu_All._loadMenuTabs[ii] then
      if ii == idx then
        PaGlobal_LordMenu_All._loadMenuTabs[ii]:SetCheck(true)
        local tabSpanSizeX = PaGlobal_LordMenu_All._loadMenuTabs[ii]:GetSpanSize().x
        local tabBtnBarSpanY = PaGlobal_LordMenu_All._ui._titleArea._stc_TabBtnBar:GetSpanSize().y
        PaGlobal_LordMenu_All._ui._titleArea._stc_TabBtnBar:SetSpanSize(tabSpanSizeX, tabBtnBarSpanY)
        PaGlobal_LordMenu_All:update(idx)
      else
        PaGlobal_LordMenu_All._loadMenuTabs[ii]:SetCheck(false)
      end
    end
  end
  if 0 == idx then
    PaGlobal_LordMenu_All._ui._lordInfoArea._stc_LordInfoArea:SetShow(true)
    PaGlobal_LordMenu_All._ui._lordTaxInfo._stc_LordTaxInfoArea:SetShow(false)
    PaGlobal_LordMenu_All._ui._lordTaxSet._stc_TaxSetArea:SetShow(false)
  elseif 1 == idx then
    PaGlobal_LordMenu_All._ui._lordInfoArea._stc_LordInfoArea:SetShow(false)
    PaGlobal_LordMenu_All._ui._lordTaxInfo._stc_LordTaxInfoArea:SetShow(true)
    PaGlobal_LordMenu_All._ui._lordTaxSet._stc_TaxSetArea:SetShow(false)
    Panel_Window_LordMenu_All:SetSize(Panel_Window_LordMenu_All:GetSizeX(), PaGlobal_LordMenu_All._originPanelSizeY)
    PaGlobal_LordMenu_All._ui._console_BotBg._stc_Bottom_KeyGuides:SetPosY(Panel_Window_LordMenu_All:GetSizeY())
  elseif 2 == idx then
    PaGlobal_LordMenu_All._ui._lordInfoArea._stc_LordInfoArea:SetShow(false)
    PaGlobal_LordMenu_All._ui._lordTaxInfo._stc_LordTaxInfoArea:SetShow(false)
    PaGlobal_LordMenu_All._ui._lordTaxSet._stc_TaxSetArea:SetShow(true)
    Panel_Window_LordMenu_All:SetSize(Panel_Window_LordMenu_All:GetSizeX(), PaGlobal_LordMenu_All._originPanelSizeY)
    PaGlobal_LordMenu_All._ui._console_BotBg._stc_Bottom_KeyGuides:SetPosY(Panel_Window_LordMenu_All:GetSizeY())
  end
  if true == PaGlobal_LordMenu_All._isConsole then
    Panel_Window_LordMenu_All:ComputePos()
    Panel_Window_LordMenu_All:SetPosY((getOriginScreenSizeY() - Panel_Window_LordMenu_All:GetSizeY()) / 2 - PaGlobal_LordMenu_All._ui._console_BotBg._stc_Bottom_KeyGuides:GetSizeY() * 2)
  end
  PaGlobal_LordMenu_All._currentTab = idx
end
function HandleEventLPress_LordMenu_All_SliderControl(idx)
  if nil == Panel_Window_LordMenu_All then
    return
  end
  if -1 == idx then
    local selfPlayer = getSelfPlayer()
    local regionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
    if nil == regionInfoWrapper then
      return
    end
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(selfPlayer:getRegionKeyRaw())
    if nil == siegeWrapper then
      return
    end
    local minRate = siegeWrapper:getMinTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
    local maxRate = siegeWrapper:getMaxTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
    transferTaxRate = math.floor(PaGlobal_LordMenu_All._ui._lordTaxSet._slider_TradeTax:GetControlPos() * (maxRate - minRate) + minRate)
    PaGlobal_LordMenu_All._ui._lordTaxSet._btn_Slider_TradeTax:SetText(tostring(transferTaxRate) .. "%")
  else
    if nil == PaGlobal_LordMenu_All._localTaxSliderGroup[idx] then
      return
    end
    local taxForSiege = math.floor(10 + (PaGlobal_LordMenu_All._localTaxSliderGroup[idx]._slider_TradeTax:GetControlPos() + 0.01) * 40)
    PaGlobal_LordMenu_All._localTaxSliderGroup[idx]._btn_slider:SetText(tostring(taxForSiege) .. "%")
    PaGlobal_LordMenu_All._localTaxSliderGroup[idx]._taxRateForSiege = taxForSiege
  end
end
function HandleEventLUp_LordMenu_All_AllTaxReset()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  PaGlobal_LordMenu_All:resetAllTax()
end
function HandleEventLUp_LordMenu_All_AllTaxSet()
  if nil == Panel_Window_LordMenu_All then
    return
  end
  PaGlobal_LordMenu_All:setAllTax()
end
function HandleEventLBRB_LordMenu_All_MoveTab(value)
  if nil == Panel_Window_LordMenu_All then
    return
  end
  local currentTab = PaGlobal_LordMenu_All._currentTab + value
  if currentTab < 0 then
    currentTab = PaGlobal_LordMenu_All._ENUM_TAXSET
  elseif 2 < currentTab then
    currentTab = PaGlobal_LordMenu_All._ENUM_TERIINFO
  end
  if false == PaGlobal_LordMenu_All._loadMenuTabs[currentTab]:GetShow() then
    return
  end
  PaGlobal_LordMenu_All._currentTab = currentTab
  PaGlobalFunc_LordMenu_All_SelectOtherTab(PaGlobal_LordMenu_All._currentTab)
end
