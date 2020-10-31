local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
PaGlobal_WebControl = {
  web_control = nil,
  _ui = {
    _txt_Title = nil,
    _btn_Close = nil,
    _btn_Refresh = nil,
    _btn_CloseWin = nil,
    _btn_KeyHelp = nil,
    _btn_ProductNote = nil
  },
  _webSizeX = 960,
  _webSizeY = 600
}
local countryType = ""
local isIME = false
if isGameTypeTaiwan() then
  countryType = "_TW"
  isIME = true
elseif isGameTypeTR() then
  countryType = "_TR"
  isIME = true
elseif isGameTypeTH() then
  countryType = "_TH"
  isIME = true
elseif isGameTypeID() then
  countryType = "_ID"
  isIME = true
elseif isGameTypeSA() then
  if CppEnums.ServiceResourceType.eServiceResourceType_SA == getGameServiceResType() then
    countryType = "_SA"
  elseif CppEnums.ServiceResourceType.eServiceResourceType_PT == getGameServiceResType() then
    countryType = "_PT"
  end
elseif isGameTypeRussia() then
  countryType = "_RU"
elseif isGameTypeJapan() then
  countryType = "_JP"
end
function Panel_WebHelper_ShowToggle(helpType)
  if true == isGameServiceTypeConsole() then
    return
  end
  if isDeadInWatchingMode() then
    return
  end
  if ToClient_IsConferenceMode() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if Panel_WebControl:IsShow() then
    Panel_WebControl:SetShow(false, true)
    PaGlobal_WebControl.web_control:ResetUrl()
    return false
  else
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return false
    end
    if isGameTypeGT() then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return false
    end
    if _ContentsOption_CH_WepHelperControl then
      return
    end
    if nil == Panel_Login then
      if Panel_WorldMap:GetShow() then
        WorldMapPopupManager:push(Panel_WebControl, true)
      else
        Panel_WebControl:SetShow(true, true)
      end
    else
      Panel_WebControl:SetShow(true, true)
    end
    PaGlobal_WebControl:takeAndShow(helpType)
    return true
  end
end
function FGlobal_WebHelper_ForceClose()
  if Panel_WebControl:IsShow() then
    Panel_WebControl:SetShow(false, true)
    PaGlobal_WebControl.web_control:ResetUrl()
    return
  end
end
function FGlobal_Panel_WebHelper_ShowToggle()
  if true == ToClient_SniperGame_IsPlaying() then
    return
  end
  if true == _ContentsOption_CH_WepHelperControl then
    return
  end
  Panel_WebHelper_ShowToggle("GUIDE")
end
function Panel_WebHelper_ShowAni()
  UIAni.fadeInSCR_Down(Panel_WebControl)
  local aniInfo1 = Panel_WebControl:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_WebControl:GetSizeX() / 2
  aniInfo1.AxisY = Panel_WebControl:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_WebControl:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_WebControl:GetSizeX() / 2
  aniInfo2.AxisY = Panel_WebControl:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_WebHelper_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_WebControl:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_WebControl, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_WebControl:initialize()
  if nil == Panel_WebControl then
    return
  end
  Panel_WebControl:SetShow(false, false)
  self._ui._txt_Title = UI.getChildControl(Panel_WebControl, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._txt_Title, "Button_Close")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._txt_Title, "Button_Refresh")
  self._ui._btn_CloseWin = UI.getChildControl(Panel_WebControl, "Button_CloseWindow")
  self._ui._btn_KeyHelp = UI.getChildControl(Panel_WebControl, "Button_KeyboardHelp")
  self._ui._btn_ProductNote = UI.getChildControl(Panel_WebControl, "Button_ProductNote")
  if true == PaGlobalFunc_Util_getIsSelfService() then
    local addSize = 100
    self._webSizeX = self._webSizeX + addSize
    self._webSizeY = self._webSizeY + addSize
    Panel_WebControl:SetSize(Panel_WebControl:GetSizeX() + addSize, Panel_WebControl:GetSizeY() + addSize)
    self._ui._txt_Title:SetSize(Panel_WebControl:GetSizeX(), self._ui._txt_Title:GetSizeY())
  end
  self.web_control = UI.createControl(__ePAUIControl_WebControl, Panel_WebControl, "WebControl_Help_CharInfo")
  self.web_control:SetSize(self._webSizeX, self._webSizeY)
  self.web_control:SetHorizonCenter()
  self.web_control:SetVerticalTop()
  self.web_control:ResetUrl()
  self.web_control:SetSpanSize(0, 60)
  self.web_control:ComputePos()
  self.web_control:SetShow(false)
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  local btnHelpSizeX = self._ui._btn_KeyHelp:GetSizeX() + 23
  local btnHelpTextPosX = btnHelpSizeX - btnHelpSizeX / 2 - self._ui._btn_KeyHelp:GetTextSizeX() / 2
  self._ui._btn_KeyHelp:SetTextSpan(btnHelpTextPosX, 5)
  local btnProductSizeX = self._ui._btn_ProductNote:GetSizeX() + 23
  local btnProductTextPosX = btnProductSizeX - btnProductSizeX / 2 - self._ui._btn_ProductNote:GetTextSizeX() / 2
  self._ui._btn_ProductNote:SetTextSpan(btnProductTextPosX, 5)
  self._ui._btn_ProductNote:SetShow(true)
  self:registerEventHandler()
  self:validate()
end
function PaGlobal_WebControl:registerEventHandler()
  if nil == Panel_WebControl then
    return
  end
  Panel_WebControl:RegisterShowEventFunc(true, "Panel_WebHelper_ShowAni()")
  Panel_WebControl:RegisterShowEventFunc(false, "Panel_WebHelper_HideAni()")
  Panel_WebControl:setGlassBackground(true)
  Panel_WebControl:ActiveMouseEventEffect(true)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle()")
  self._ui._btn_CloseWin:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle()")
  self._ui._btn_KeyHelp:addInputEvent("Mouse_LUp", "FGlobal_KeyboardHelpShow()")
  self._ui._btn_ProductNote:addInputEvent("Mouse_LUp", "Panel_ProductNote_ShowToggle()")
end
function PaGlobal_WebControl:validate()
  if nil == Panel_WebControl then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Refresh:isValidate()
  self._ui._btn_CloseWin:isValidate()
  self._ui._btn_KeyHelp:isValidate()
  self._ui._btn_ProductNote:isValidate()
end
function PaGlobal_WebControl:takeAndShow(helpType)
  if true == isGameServiceTypeConsole() then
    return
  end
  Panel_WebControl:SetShow(true, true)
  Panel_WebControl:ComputePos()
  PaGlobal_WebControl.web_control:SetHorizonCenter()
  PaGlobal_WebControl.web_control:SetVerticalTop()
  PaGlobal_WebControl.web_control:SetSpanSize(0, 60)
  PaGlobal_WebControl.web_control:ComputePos()
  local serviceType = getGameServiceType()
  local eCountryType = CppEnums.CountryType
  if helpType == "GUIDE" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GUIDE" .. countryType))
  elseif helpType == "SelfCharacterInfo" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_SELFCHARACTERINFO" .. countryType))
  elseif helpType == "PanelImportantKnowledge" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_PANELIMPORTANTKNOWLEDGE" .. countryType))
  elseif helpType == "PanelWindowEquipment" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_WINDOWEQUIPMENT" .. countryType))
  elseif helpType == "PanelGameExit" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_GAMEEXIT" .. countryType))
  elseif helpType == "PanelWindowInventory" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_WINDOWINVENTORY" .. countryType))
  elseif helpType == "UIGameOption" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_GAMEOPTION" .. countryType))
  elseif helpType == "PanelQuestHistory" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_QUESTHISTORY" .. countryType))
  elseif helpType == "PanelQuestReward" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_QUESTREWARD" .. countryType))
  elseif helpType == "PanelFixEquip" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_FIXEQUIP" .. countryType))
  elseif helpType == "NodeMenu" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_NODE" .. countryType))
  elseif helpType == "NpcShop" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_NPCSHOP" .. countryType))
  elseif helpType == "PanelBuyDrink" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_BUYDRINK" .. countryType))
  elseif helpType == "Chatting" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_CHATTING" .. countryType))
  elseif helpType == "KnownIssue" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_KNOWNISSUE" .. countryType))
  elseif helpType == "PearlApp" then
    local url = ToClient_getInGamePearlAppWikiURL()
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
  elseif helpType == "PanelAlchemy" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_ALCHEMY" .. countryType))
  elseif helpType == "PanelCook" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_COOK" .. countryType))
  elseif helpType == "PanelManufacture" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_MANUFACTURE" .. countryType))
  elseif helpType == "PanelHouseControl" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_HOUSECONTROL" .. countryType))
  elseif helpType == "PanelTradeMarketGraph" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_TRADEMARKETGRAPH" .. countryType))
  elseif helpType == "TerritoryTrade" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_TERRITORYTRADE" .. countryType))
  elseif helpType == "TerritorySupply" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_TERRITORYSUPPLY" .. countryType))
  elseif helpType == "TerritoryAuth" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_TERRITORYTRADE" .. countryType))
  elseif helpType == "HouseManageWork" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_HOUSEMANAGEWORK" .. countryType))
  elseif helpType == "PanelWorldMapTownWorkerManage" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WORLDMAPTOWNWORKERMANAGE" .. countryType))
  elseif helpType == "FarmManageWork" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_FARMMANAGEWORK" .. countryType))
  elseif helpType == "PanelWindowHouse" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WINDOWHOUSE" .. countryType))
  elseif helpType == "PanelWindowTent" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WINDOWTENT" .. countryType))
  elseif helpType == "Gathering" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_GATHERING" .. countryType))
  elseif helpType == "Pet" then
    if true == _ContentsGroup_ForceShowWidgetIcon then
      local url = ToClient_getInGamePetWikiURL()
      if nil == url or "" == url then
        url = PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_PET" .. countryType)
      end
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
    else
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_PET" .. countryType))
    end
  elseif helpType == "Maid" then
    if true == _ContentsGroup_ForceShowWidgetIcon then
      local url = ToClient_getInGameMaidWikiURL()
      if nil == url or "" == url then
        url = PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEGUIDE")
      end
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
    else
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEGUIDE"))
    end
  elseif helpType == "Dye" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_DYE" .. countryType))
  elseif helpType == "HouseRank" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_HOUSERANK" .. countryType))
  elseif helpType == "Worker" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WORKER" .. countryType))
  elseif helpType == "AlchemyStone" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_ALCHEMYSTONE" .. countryType))
  elseif helpType == "LifeRanking" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFERANKING" .. countryType))
  elseif helpType == "DeliveryPerson" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_DELIVERYPERSON" .. countryType))
  elseif helpType == "PanelServantinfo" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_SERVANTINFO" .. countryType))
  elseif helpType == "PanelServantInventory" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_SERVANTINVENTORY" .. countryType))
  elseif helpType == "PanelWindowStableShop" then
    if eCountryType.NA_ALPHA == serviceType or eCountryType.NA_REAL == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_STABLE_NAEU"))
    elseif eCountryType.SA_REAL == serviceType or eCountryType.SA_ALPHA == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_STABLE_SA"))
    else
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WINDOWSTABLEMARKET" .. countryType))
    end
  elseif helpType == "PanelWindowWharfShop" then
    if eCountryType.NA_ALPHA == serviceType or eCountryType.NA_REAL == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WHARF_NAEU"))
    elseif eCountryType.SA_REAL == serviceType or eCountryType.SA_ALPHA == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_LIFE_WHARF_SA"))
    else
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WINDOWSTABLEMARKET" .. countryType))
    end
  elseif helpType == "PanelWindowStableMarket" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WINDOWSTABLEMARKET" .. countryType))
  elseif helpType == "PanelWindowStableMating" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WINDOWSTABLEMATING" .. countryType))
  elseif helpType == "PanelWindowStableRegister" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WINDOWSTABLEREGISTER" .. countryType))
  elseif helpType == "HousingConsignmentSale" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_HOUSINGCONSIGNMENTSALE" .. countryType))
  elseif helpType == "HosingVendingMachine" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_HOUSINGVENDINGMACHINE" .. countryType))
  elseif helpType == "WareHouse" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_WAREHOUSE" .. countryType))
  elseif helpType == "DeliveryInformation" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_DELIVERYINFORMATION" .. countryType))
  elseif helpType == "DeliveryRequest" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_DELIVERYREQUEST" .. countryType))
  elseif helpType == "MyVendorList" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_MYVENDORLIST" .. countryType))
  elseif helpType == "ProductNote" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_PRODUCTNOTE" .. countryType))
  elseif helpType == "ItemMarket" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CONVENI_ITEMMARKET" .. countryType))
  elseif helpType == "ClothExchange" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_CLOTHEXCHANGE" .. countryType))
  elseif helpType == "QuickSlot" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_QUICKSLOT" .. countryType))
  elseif helpType == "SpiritEnchant" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_SPIRITENCHANT" .. countryType))
  elseif helpType == "PanelWindowExtractionCrystal" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_WINDOWEXTRACTIONCRYSTAL" .. countryType))
  elseif helpType == "PanelWindowExtractionEnchantStone" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_WINDOWEXTRACTIONENCHANTSTONE" .. countryType))
  elseif helpType == "PanelWindowSkill" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_WINDOWSKILL" .. countryType))
  elseif helpType == "PanelEnableSkill" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_ENABLESKILL" .. countryType))
  elseif helpType == "PanelSkillAwaken" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_SKILLAWAKEN" .. countryType))
  elseif helpType == "Socket" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_SOCKET" .. countryType))
  elseif helpType == "WarInfo" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMBAT_WARINFO" .. countryType))
  elseif helpType == "PanelExchangeWithPC" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_EXCHANGEWITHPC" .. countryType))
  elseif helpType == "PanelFriends" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_FRIENDS" .. countryType))
  elseif helpType == "PanelClan" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_CLAN" .. countryType))
  elseif helpType == "PanelGuild" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_GUILD" .. countryType))
  elseif helpType == "PanelLordMenu" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_LORDMENU" .. countryType))
  elseif helpType == "Panelmail" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_MAIL" .. countryType))
  elseif helpType == "PartyOption" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_PARTYOPTION" .. countryType))
  elseif helpType == "HouseAuction" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_HOUSEAUCTION" .. countryType))
  elseif helpType == "PanelMailSend" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_MAILSEND" .. countryType))
  elseif helpType == "Update" then
    if eCountryType.TR_ALPHA == serviceType or eCountryType.TR_REAL == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_UPDATE_TR"))
    else
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_UPDATE" .. countryType))
    end
  elseif helpType == "Fairy" then
    if true == _ContentsGroup_ForceShowWidgetIcon then
      local url = ToClient_getInGameFairyWikiURL()
      if nil == url or "" == url then
        url = PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEGUIDE")
      end
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
    elseif eCountryType.NA_ALPHA == serviceType or eCountryType.NA_REAL == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_FAIRY_NAEU"))
    elseif eCountryType.SA_REAL == serviceType or eCountryType.SA_ALPHA == serviceType then
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_FAIRY_SA"))
    else
      _PA_ASSERT("" == countryType or "_JP" == countryType or "_TW" == countryType or "_TR" == countryType or "_TH" == countryType or "_ID" == countryType or "_RU" == countryType, tostring(countryType) .. "url \236\157\180 \236\132\184\237\140\133\235\144\152\236\150\180\236\158\136\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.")
      PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_COMM_FAIRY" .. countryType))
    end
  elseif helpType == "WorldBoss" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEINFO_WORLDBOSS" .. countryType))
  elseif helpType == "DeliveryCarriageinformation" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/Delivery/WebHelper_Delivery_CarriageInformation.html")
  elseif helpType == "HouseList" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/HouseInfo/WebHelper_HouesList.html")
  elseif helpType == "PanelHouseInfo" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/HouseInfo/WebHelper_Panel_HouseInfo.html")
  elseif helpType == "PanelInn" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/Inn/WebHelper_Inn.html")
  elseif helpType == "PanelMailDetail" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/Mail/WebHelper_Mail_Detail.html")
  elseif helpType == "PanelPetSkill" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/Servant/WebHelper_PetSkill.html")
  elseif helpType == "PanelAuction" then
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, "coui://UI_Data/UI_Html/WebHelper/Window/Auction/WebHelper_Panel_Auction.html")
  else
    PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, PAGetString(Defines.StringSheet_GAME, "WEBHELPER_GAMEGUIDE"))
  end
  if isGameTypeTaiwan() or isGameTypeEnglish() or isGameTypeKorea() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameTypeRussia() or isGameTypeJapan() then
    PaGlobal_WebControl.web_control:SetIME(true)
  end
  PaGlobal_WebControl.web_control:SetSize(self._webSizeX, self._webSizeY)
  PaGlobal_WebControl.web_control:SetHorizonCenter()
  PaGlobal_WebControl.web_control:SetVerticalTop()
  PaGlobal_WebControl.web_control:SetSpanSize(0, 60)
  PaGlobal_WebControl.web_control:ComputePos()
  PaGlobal_WebControl.web_control:SetShow(true)
end
function Panel_WebControl_LevelUpGuide(isString)
  if true == isGameServiceTypeConsole() then
    return
  end
  if nil == isString then
    return
  end
  PaGlobal_WebControl.web_control:SetUrl(PaGlobal_WebControl._webSizeX, PaGlobal_WebControl._webSizeY, PAGetString(Defines.StringSheet_GAME, isString))
  PaGlobal_WebControl.web_control:SetSize(PaGlobal_WebControl._webSizeX, PaGlobal_WebControl._webSizeY)
  PaGlobal_WebControl.web_control:SetHorizonCenter()
  PaGlobal_WebControl.web_control:SetVerticalTop()
  PaGlobal_WebControl.web_control:SetSpanSize(0, 60)
  PaGlobal_WebControl.web_control:ComputePos()
  PaGlobal_WebControl.web_control:SetShow(true)
  Panel_WebControl:SetShow(true, true)
end
function FromClient_resetCoherentUIForWebHelper()
  if Panel_WebControl:GetShow() then
    TooltipSimple_Hide()
    FGlobal_WebHelper_ForceClose()
  end
end
function FromClient_WebContron_Initialize()
  PaGlobal_WebControl:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_WebContron_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForWebHelper")
