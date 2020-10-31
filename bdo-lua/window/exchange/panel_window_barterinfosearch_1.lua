function PaGlobal_BarterInfoSearch:init()
  self._ui._btn_specialBarterInfo = UI.getChildControl(self._ui._stc_specialInfoBG, "Button_SpecialBarterInfo")
  self._ui._btn_specialBarterInfo:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Special:open()")
  self._ui._txt_specialInfo = UI.getChildControl(self._ui._stc_specialInfoBG, "StaticText_SpecialBarter")
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Close()")
  self._ui._btn_tray = UI.getChildControl(self._ui._titleBar, "CheckButton_TrayBTN")
  self._ui._btn_tray:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch:popUpUITooltip( true )")
  self._ui._btn_tray:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch:popUpUITooltip( false )")
  self._ui._btn_tray:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:popUpUI()")
  self._ui._btn_tray:SetShow(_ContentsGroup_PopUp)
  self._ui._edit = UI.getChildControl(self._ui._searchBar, "Edit_Search")
  self._ui._edit:RegistReturnKeyEvent("PaGlobal_BarterInfoSearch:refresh()")
  self._ui._btn_search = UI.getChildControl(self._ui._edit, "Button_Search")
  self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  self._ui._txt_exchangeCountForTime = UI.getChildControl(self._ui._searchBar, "StaticText_RemainCountValue")
  self._ui._txt_totalExchangeCount = UI.getChildControl(self._ui._searchBar, "StaticText_TotalRemainCountTitle")
  self._ui._btn_refresh = UI.getChildControl(self._ui._searchBar, "Button_Reload")
  self._ui._btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  self._ui._list2_barterInfoList = UI.getChildControl(self._ui._mainBg, "List2_1")
  self._ui._list2_barterInfoList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_BarterInfoSearch_CreateControlList2")
  self._ui._list2_barterInfoList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._txt_noticeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_noticeDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SEARCH_BARTERNOTICE"))
  self._ui._filter = UI.getChildControl(self._ui._searchBar, "Combobox_Gender")
  self._ui._filter:setListTextHorizonCenter()
  self._ui._filter:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:showFilterList()")
  self._ui._filter:GetListControl():addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:setFilter()")
  for ii = __eItemGradeNormal, __eItemGradeTypeCount do
    self._ui._filter:AddItem(self._itemGradeText[ii], ii)
  end
  self._selectFilterIndex = __eItemGradeTypeCount
  self._specailBG_DefaultSizeX = self._ui._btn_specialBarterInfo:GetSizeX()
  self._ui._barterLifeInfoBg = UI.getChildControl(self._ui._searchBar, "Static_BarterLifeLevel")
  self._ui._pg2_barterLifeLevel = UI.getChildControl(self._ui._barterLifeInfoBg, "Progress2_Gauge")
  self._ui._txt_barterLifeLevel = UI.getChildControl(self._ui._barterLifeInfoBg, "StaticText_Level")
  self._ui._txt_barterLifeExp = UI.getChildControl(self._ui._barterLifeInfoBg, "StaticText_Percent")
  self._ui._chk_hideComplete:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch:refresh()")
  self._ui._chk_hideComplete:SetEnableArea(0, 0, self._ui._chk_hideComplete:GetSizeX() + self._ui._chk_hideComplete:GetTextSizeX() + 10, self._ui._chk_hideComplete:GetSizeY())
  self._ui._btnResetBarterSeed = UI.getChildControl(Panel_Window_Barter_Search, "Button_BarterRefresh")
  self._ui._btnResetBarterSeed:addInputEvent("Mouse_LUp", "HandleEventLUp_BarterInfoSearch_All_requrstChangeBarterList()")
  self._ui._btnResetBarterSeed:addInputEvent("Mouse_On", "HandleEventMouseOver_BarterInfoSearch_All_ShowTooltip(true)")
  self._ui._btnResetBarterSeed:addInputEvent("Mouse_Out", "HandleEventMouseOver_BarterInfoSearch_All_ShowTooltip(false)")
  local gapY = 10
  if self._ui._stc_noticeBg:GetSizeY() < self._ui._txt_noticeDesc:GetTextSizeY() + gapY then
    local addSizeY = self._ui._txt_noticeDesc:GetTextSizeY() + gapY - self._ui._stc_noticeBg:GetSizeY()
    self._ui._stc_noticeBg:SetSize(self._ui._stc_noticeBg:GetSizeX(), self._ui._stc_noticeBg:GetSizeY() + addSizeY)
    self._ui._txt_noticeDesc:SetSize(self._ui._stc_noticeBg:GetSizeX(), self._ui._stc_noticeBg:GetSizeY())
    Panel_Window_Barter_Search:SetSize(Panel_Window_Barter_Search:GetSizeX(), Panel_Window_Barter_Search:GetSizeY() + addSizeY)
    self._ui._stc_noticeBg:ComputePos()
    self._ui._txt_noticeDesc:ComputePos()
    Panel_Window_Barter_Search:ComputePos()
  end
  self._ui._timeBar:SetShow(false)
  self._isInit = true
end
function PaGlobal_BarterInfoSearch:clear()
  self._updateCurrentTime = 0
  self._updatePastTime = 0
  self._ui._btn_tray:SetCheck(false)
end
function PaGlobal_BarterInfoSearch:open()
  if false == _ContentsGroup_Barter then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  self:clear()
  self._ui._txt_totalExchangeCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_ACCRUE_COUNT", "count", tostring(ToClient_barterTotalExchangeCount())))
  self:refresh()
  local remainCount = ToClient_barterMaxExchangeCountForTime() - ToClient_barterCurrentExchangeCountForTime()
  local remainCount_s64 = toInt64(0, remainCount)
  self._ui._txt_exchangeCountForTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_TICKET_COUNT", "count", tostring(makeDotMoney(remainCount_s64))))
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  if remainSeedChangeCount < 0 then
    remainSeedChangeCount = 0
  end
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTER_CHANGEBARTERSEEDCOUNT", "count", tostring(remainSeedChangeCount), "maxcount", tostring(maxSeedChangeCount))
  self._ui._btnResetBarterSeed:SetText(string)
  self._ui._btnResetBarterSeed:SetMonoTone(not ToClient_isEnableChangeBarterSeed())
  Panel_Window_Barter_Search:SetShow(true)
end
function PaGlobal_BarterInfoSearch:close()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  end
  Panel_Window_Barter_Search:SetShow(false)
  Panel_Window_Barter_Search:CloseUISubApp()
  PaGlobal_BarterInfoSearch_ItemTooltip_Hide()
  Panel_Window_Barter_Search:ClearUpdateLuaFunc("Update_BarterInfoSearch_FrameEvent")
end
function PaGlobal_BarterInfoSearch:setBarterLifeInfo()
  if nil == getSelfPlayer() then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local lifeType = 11
  local currentLevel = selfPlayer:getLifeExperienceLevel(lifeType)
  local currentExp64 = selfPlayer:getCurrLifeExperiencePoint(lifeType)
  local needExp64 = selfPlayer:getDemandLifeExperiencePoint(lifeType)
  local currentExpRate64 = currentExp64 * toInt64(0, 10000) / needExp64
  local currentExpRate = Int64toInt32(currentExpRate64)
  currentExpRate = currentExpRate / 100
  local currentExpRateString = string.format("%.2f", currentExpRate)
  local colorLifeLevel = PaGlobalFunc_Util_CraftLevelColorReplace(currentLevel)
  self._ui._txt_barterLifeLevel:SetText(colorLifeLevel)
  self._ui._txt_barterLifeExp:SetText(currentExpRateString .. "%")
  self._ui._pg2_barterLifeLevel:SetProgressRate(currentExpRate)
end
function PaGlobal_BarterInfoSearch:refresh()
  if false == self._isInit then
    return
  end
  self:setBarterLifeInfo()
  self._ui._list2_barterInfoList:getElementManager():clearKey()
  self._ui._filter:SetText(self._itemGradeText[self._selectFilterIndex])
  local regionList = ToClient_barterRegionList(self._ui._edit:GetEditText(), self._selectFilterIndex)
  if nil ~= regionList then
    for ii = 0, #regionList do
      local barterWrapper = ToClient_barterWrapper(regionList[ii])
      if nil ~= barterWrapper then
        if true == self._ui._chk_hideComplete:IsCheck() then
          if barterWrapper:getExchangeCurrentCount() < barterWrapper:getExchangeMaxCount() then
            self._ui._list2_barterInfoList:getElementManager():pushKey(regionList[ii]:get())
          end
        else
          self._ui._list2_barterInfoList:getElementManager():pushKey(regionList[ii]:get())
        end
      end
    end
    self._ui._list2_barterInfoList:ComputePos()
    self._ui._txt_NotFind:SetShow(false)
  else
    self._ui._txt_NotFind:SetShow(true)
  end
  local remainCount = ToClient_barterMaxExchangeCountForTime() - ToClient_barterCurrentExchangeCountForTime()
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTER_CHANGEBARTERSEEDCOUNT", "count", tostring(remainSeedChangeCount), "maxcount", tostring(maxSeedChangeCount))
  local remainCount_s64 = toInt64(0, remainCount)
  self._ui._txt_exchangeCountForTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_TICKET_COUNT", "count", tostring(makeDotMoney(remainCount_s64))))
  self._ui._btnResetBarterSeed:SetText(string)
  self._ui._btnResetBarterSeed:SetMonoTone(not ToClient_isEnableChangeBarterSeed())
  PaGlobal_BarterInfoSearch:refreshSpecialBarter()
end
function PaGlobal_BarterInfoSearch:refreshSpecialBarter()
  if false == self._isInit then
    return
  end
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  local str = ""
  if nil ~= specialBarterWrapper then
    local regionWrapper = getRegionInfoWrapper(specialBarterWrapper:getRegionKey():get())
    if nil == regionWrapper then
      str = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_UNKNOWN_ISLAND")
    else
      str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_KNOW_ISLAND", "areaname", regionWrapper:getAreaName())
    end
  else
    str = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_TRADE_NONE_ISLAND")
  end
  self._ui._txt_specialInfo:SetTextMode(__eTextMode_None)
  self._ui._txt_specialInfo:SetText(str)
  local spanX = self._ui._txt_specialInfo:GetTextSpan().x
  local textSizeX = self._ui._txt_specialInfo:GetTextSizeX() + spanX
  local specialBGSizeX = self._specailBG_DefaultSizeX
  local panelSizeX = Panel_Window_Barter_Search:GetSizeX()
  local pointX = 80
  if textSizeX > panelSizeX * 0.5 then
    self._ui._stc_specialInfoBG:SetSize(panelSizeX * 0.5, self._ui._stc_specialInfoBG:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(panelSizeX * 0.5, self._ui._btn_specialBarterInfo:GetSizeY())
    self._ui._txt_specialInfo:SetSize(self._ui._btn_specialBarterInfo:GetSizeX() - pointX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._txt_specialInfo:SetTextMode(__eTextMode_AutoWrap)
  elseif specialBGSizeX > textSizeX + pointX then
    self._ui._stc_specialInfoBG:SetSize(specialBGSizeX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(specialBGSizeX, self._ui._txt_specialInfo:GetSizeY())
  else
    self._ui._stc_specialInfoBG:SetSize(textSizeX + pointX, self._ui._txt_specialInfo:GetSizeY())
    self._ui._btn_specialBarterInfo:SetSize(textSizeX + pointX, self._ui._txt_specialInfo:GetSizeY())
  end
  self._ui._txt_specialInfo:SetText(str)
end
function PaGlobal_BarterInfoSearch:showFilterList()
  self._ui._filter:ToggleListbox()
end
function PaGlobal_BarterInfoSearch:setFilter()
  self._selectFilterIndex = self._ui._filter:GetSelectIndex()
  if self._selectFilterIndex < __eItemGradeNormal or __eItemGradeTypeCount < self._selectFilterIndex then
    self._selectFilterIndex = __eItemGradeTypeCount
  end
  self:refresh()
end
function PaGlobal_BarterInfoSearch:popUpUI()
  if true == self._ui._btn_tray:IsCheck() then
    Panel_Window_Barter_Search:OpenUISubApp()
  else
    Panel_Window_Barter_Search:CloseUISubApp()
  end
end
function PaGlobal_BarterInfoSearch:popUpUITooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = self._ui._btn_tray
  name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  if false == Panel_CharacterInfo_All:IsUISubApp() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  end
  TooltipSimple_Show(control, name, desc)
end
