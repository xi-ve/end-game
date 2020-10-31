function PaGlobal_BarterInfoSearch_Open()
  if true == Panel_Window_Barter_Search:GetShow() then
    return
  end
  PaGlobal_BarterInfoSearch:open()
end
function PaGlobal_BarterInfoSearch_Close()
  local self = PaGlobal_BarterInfoSearch
  self:close()
end
function PaGlobal_BarterInfoSearch_OpenToggle()
  if true == Panel_Window_Barter_Search:GetShow() then
    PaGlobal_BarterInfoSearch:close()
  else
    PaGlobal_BarterInfoSearch:open()
  end
end
function PaGlobal_BarterInfoSearch_Close_FromWorldMap()
  local self = PaGlobal_BarterInfoSearch
  if true == self._ui._btn_tray:IsCheck() then
    return
  end
  Panel_Window_Barter_Search_Special:SetShow(false)
  Panel_Window_Barter_Refresh:SetShow(false)
  self:close()
end
function Update_BarterInfoSearch_FrameEvent(deltaTime)
  local self = PaGlobal_BarterInfoSearch
  self._updateCurrentTime = self._updateCurrentTime + deltaTime
  if self._updateCurrentTime - self._updatePastTime < 1 then
    return
  end
  self._updatePastTime = self._updateCurrentTime
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTER_CHANGEBARTERSEEDCOUNT", "count", tostring(remainSeedChangeCount), "maxcount", tostring(maxSeedChangeCount))
  self._ui._btnResetBarterSeed:SetText(string)
  self._ui._btnResetBarterSeed:SetMonoTone(not ToClient_isEnableChangeBarterSeed())
end
function PaGlobal_BarterInfoSearch_CreateControlList2(content, key)
  local self = PaGlobal_BarterInfoSearch
  local regionKey = Int64toInt32(key)
  local regionWrapper = getRegionInfoWrapper(regionKey)
  if nil == regionWrapper then
    return
  end
  local barterWrapper = ToClient_barterWrapper(RegionKey(regionKey))
  if nil == barterWrapper then
    return
  end
  local barterInfoSlot = UI.getChildControl(content, "Static_Slot1_BG")
  barterInfoSlot:setNotImpactScrollEvent(true)
  barterInfoSlot:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_WaypointByRegionKey(" .. regionKey .. ")")
  local txt_regionName = UI.getChildControl(barterInfoSlot, "StaticText_RegionName")
  local fromItemBg = UI.getChildControl(barterInfoSlot, "Static_MyItemBG")
  local fromItemIcon = UI.getChildControl(fromItemBg, "Static_MyItemIcon")
  local fromItemCount = UI.getChildControl(fromItemBg, "StaticText_MyItemCount")
  local fromItemName = UI.getChildControl(fromItemBg, "StaticText_MyItemName")
  local fromItemBorder = UI.getChildControl(fromItemBg, "Static_MyItemBorder")
  local fromTicketCount = UI.getChildControl(fromItemBg, "StaticText_NeedTicket")
  fromTicketCount:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch_TicketTooltip_Show(" .. regionKey .. ")")
  fromTicketCount:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch_TicketTooltip_Hide()")
  fromTicketCount:SetIgnore(false)
  local toItemBg = UI.getChildControl(barterInfoSlot, "Static_NpcItemBG")
  local toItemIcon = UI.getChildControl(toItemBg, "Static_MyItemIcon")
  local toItemCount = UI.getChildControl(toItemBg, "StaticText_MyItemCount")
  local toItemName = UI.getChildControl(toItemBg, "StaticText_NPCItemName")
  local toItemBorder = UI.getChildControl(toItemBg, "Static_NPCItemBorder")
  local btn_navi = UI.getChildControl(barterInfoSlot, "Button_Waypoint")
  local txt_remainCount = UI.getChildControl(barterInfoSlot, "StaticText_RemainCount")
  txt_regionName:SetText(regionWrapper:getAreaName())
  local itemEnchantKey = barterWrapper:getFromItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil ~= itemSSW then
    fromItemIcon:ChangeTextureInfoNameDefault("Icon/" .. itemSSW:getIconPath())
    fromItemIcon:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch_ItemTooltip_Show(" .. regionKey .. "," .. itemEnchantKey:get() .. ", false)")
    fromItemIcon:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch_ItemTooltip_Hide()")
    fromItemIcon:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_FindInfo(0," .. itemEnchantKey:get() .. ")")
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      fromItemName:SetFontColor(fontColor)
    else
      fromItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    fromItemName:SetTextMode(__eTextMode_AutoWrap)
    fromItemName:SetText(itemSSW:getName())
    fromItemCount:SetText(tostring(barterWrapper:getFromItemCount()))
    SlotItem:setItemBorder(fromItemBorder, itemSSW:getGradeType())
  end
  local needExchangeCount = ToClient_needExchangeCount(RegionKey(regionKey))
  local needExchangeCount_s64 = toInt64(0, needExchangeCount)
  fromTicketCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTER_TICKET_NEEDCOUNT", "coount", tostring(makeDotMoney(needExchangeCount_s64))))
  fromTicketCount:SetSize(fromTicketCount:GetTextSizeX(), fromTicketCount:GetSizeY())
  itemEnchantKey = barterWrapper:getToItemEnchantKey()
  itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil ~= itemSSW then
    toItemIcon:ChangeTextureInfoNameDefault("Icon/" .. itemSSW:getIconPath())
    toItemIcon:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch_ItemTooltip_Show(" .. regionKey .. "," .. itemEnchantKey:get() .. ", true)")
    toItemIcon:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch_ItemTooltip_Hide()")
    toItemIcon:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_FindInfo(1," .. itemEnchantKey:get() .. ")")
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      toItemName:SetFontColor(fontColor)
    else
      toItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    toItemName:SetTextMode(__eTextMode_AutoWrap)
    toItemName:SetText(itemSSW:getName())
    toItemCount:SetText(tostring(barterWrapper:getToItemCount()))
    SlotItem:setItemBorder(toItemBorder, itemSSW:getGradeType())
  end
  btn_navi:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_WaypointByCharacterKey(" .. barterWrapper:getNpcCharacterKey():get() .. ")")
  local naviPosX = txt_regionName:GetPosX() + txt_regionName:GetTextSizeX()
  naviPosX = math.min(naviPosX, txt_regionName:GetSizeX())
  btn_navi:SetPosX(naviPosX + 10)
  local remainCount = barterWrapper:getExchangeMaxCount() - barterWrapper:getExchangeCurrentCount()
  txt_remainCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TRADEITEM_REMAIN_COUNT", "count", tostring(remainCount)))
  local isCompleteTrade = 0 == remainCount
  barterInfoSlot:SetMonoTone(isCompleteTrade)
  UI.setLimitTextAndAddTooltip(txt_regionName)
  UI.setLimitTextAndAddTooltip(self.btn_Kick_A)
  UI.setLimitTextAndAddTooltip(fromItemName)
end
function PaGlobal_BarterInfoSearch_WaypointByCharacterKey(key)
  local npcInfo = npcByCharacterKey_getNpcInfo(CharacterKey(key), 1)
  if nil == npcInfo then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(npcInfo:getPosition(), NavigationGuideParam(), false, true)
  ToCleint_gotoWorldmapPosition(npcInfo:getPosition())
end
function PaGlobal_BarterInfoSearch_WaypointByRegionKey(regionKey)
  local regionWrapper = getRegionInfoWrapper(regionKey)
  if nil == regionWrapper then
    return
  end
  ToCleint_gotoWorldmapPosition(regionWrapper:getPosition())
end
function PaGlobal_BarterInfoSearch_ItemTooltip_Show(regionKey, itemKey, isToItem)
  local self = PaGlobal_BarterInfoSearch
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemSSW then
    local content = self._ui._list2_barterInfoList:GetContentByKey(regionKey)
    local barterInfoSlot = UI.getChildControl(content, "Static_Slot1_BG")
    local control
    if true == isToItem then
      local toItemBg = UI.getChildControl(barterInfoSlot, "Static_NpcItemBG")
      control = UI.getChildControl(toItemBg, "Static_MyItemIcon")
    else
      local fromItemBg = UI.getChildControl(barterInfoSlot, "Static_MyItemBG")
      control = UI.getChildControl(fromItemBg, "Static_MyItemIcon")
    end
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_BarterInfoSearch_ItemTooltip_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_BarterInfoSearch_TicketTooltip_Show(regionKey)
  local self = PaGlobal_BarterInfoSearch
  if nil == self then
    return
  end
  local content = self._ui._list2_barterInfoList:GetContentByKey(regionKey)
  if nil == content then
    return
  end
  local barterWrapper = ToClient_barterWrapper(RegionKey(regionKey))
  if nil == barterWrapper then
    return
  end
  local baseExchangeCount = barterWrapper:getExchangeCountForTime()
  local baseExchangeCount_s64 = toInt64(0, baseExchangeCount)
  local discountPointByBarterLifeLevel = ToClient_discountPointByBarterLevel() / CppDefine.e1Percent
  local discountPointByPremiumPackage = ToClient_discountPointByPremiumPackage() / CppDefine.e1Percent
  local exchangeCountTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_INFO_POINTCALCULATION_TITLE")
  local exchangeCountDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BARTER_INFO_POINTCALCULATION", "point", makeDotMoney(baseExchangeCount_s64), "value", string.format("%.2f", discountPointByBarterLifeLevel), "buff", string.format("%.2f", discountPointByPremiumPackage))
  TooltipSimple_Show(content, exchangeCountTitle, exchangeCountDesc)
end
function PaGlobal_BarterInfoSearch_TicketTooltip_Hide()
  TooltipSimple_Hide()
end
function HandleEventLUp_BarterInfoSearch_All_requrstChangeBarterList()
  if ToClient_getMaxChangeSeedCountForDay() <= ToClient_getChangeSeedCountForDay() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoBarterSeedChangeCountIsFull"))
    return
  end
  PaGlobal_BarterInfoRefresh:open()
end
function HandleEventMouseOver_BarterInfoSearch_All_ShowTooltip(isShow)
  local control = PaGlobal_BarterInfoSearch._ui._btnResetBarterSeed
  local resetCoolTime = ToClient_changeBarterInfoRemainSec()
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REMAIN_TIME_LIST_RENEWAL") .. " " .. convertStringFromDatetimeAll(resetCoolTime)
  if nil == control or nil == desc then
    return
  end
  if true == isShow and false == ToClient_isEnableChangeBarterSeed() then
    TooltipSimple_Show(control, "", desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_BarterInfoSearch_RefreshBarterList(msgType)
  PaGlobal_BarterInfoSearch:refresh()
  if msgType == 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BARTERINFO_RESETBUTTON_TYPE_3_NOTIFY"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_LIST_RENEWAL"))
  end
end
function FromClient_BarterInfoSearch_RefreshSpecialBarter()
  PaGlobal_BarterInfoSearch:refreshSpecialBarter()
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  if nil ~= specialBarterWrapper then
    local sendMessage = {}
    sendMessage.main = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMSG_SPECIALBARTER")
    sendMessage.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(sendMessage, 5, 123)
  end
end
function FromClient_BarterInfoSearch_AddBarterExchangeCount(addCount)
  PaGlobal_BarterInfoSearch:refresh()
  local addCount_s64 = toInt64(0, addCount)
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERPOINTADD", "count", makeDotMoney(addCount_s64)))
end
function PaGlobalFunc_BarterInfoSearch_Refresh()
  if true == Panel_Window_Barter_Search:GetShow() then
    PaGlobal_BarterInfoSearch:refresh()
  end
end
function PaGlobal_BarterInfoSearch_FindInfo(searchType, itemEnchantKey)
  local self = PaGlobal_BarterInfoSearch
  self._selectFilterIndex = __eItemGradeTypeCount
  self._ui._edit:SetEditText("")
  self._ui._chk_hideComplete:SetCheck(false)
  self._ui._list2_barterInfoList:getElementManager():clearKey()
  self._ui._filter:SetText(self._itemGradeText[self._selectFilterIndex])
  local regionList = ToClient_barterRegionList(self._ui._edit:GetEditText(), self._selectFilterIndex)
  if nil ~= regionList then
    local regionKey
    for ii = 0, #regionList do
      local barterWrapper = ToClient_barterWrapper(regionList[ii])
      if nil ~= barterWrapper then
        self._ui._list2_barterInfoList:getElementManager():pushKey(regionList[ii]:get())
        if 0 == searchType and itemEnchantKey == barterWrapper:getToItemEnchantKey():get() then
          regionKey = regionList[ii]:get()
        else
          if 1 == searchType and itemEnchantKey == barterWrapper:getFromItemEnchantKey():get() then
            regionKey = regionList[ii]:get()
          else
          end
        end
      end
    end
    if nil ~= regionKey then
      local index = self._ui._list2_barterInfoList:getIndexByKey(regionKey)
      self._ui._list2_barterInfoList:moveIndex(index)
    end
    self._ui._list2_barterInfoList:ComputePos()
    self._ui._txt_NotFind:SetShow(false)
  else
    self._ui._txt_NotFind:SetShow(true)
  end
end
