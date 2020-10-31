local _panel = Panel_Window_MarketPlace_Main
local MarketPlace_ConsoleAssist = {
  _ui = {
    _tabBg = UI.getChildControl(_panel, "Static_TabBg"),
    _walletManageBg = UI.getChildControl(_panel, "Static_ManageMentBg"),
    stc_keyGuideArea = UI.getChildControl(_panel, "Static_KeyGuideArea"),
    _tabList = {}
  },
  _defaultPosX = {
    _marketPlace = 0,
    _wallet = 0,
    _walletManage = 0
  },
  _tabConfig = {
    _marketPlace = 0,
    _wallet = 1,
    _walletManage = 2,
    _count = 3
  },
  _invenConfig = {_my = 0, _wallet = 1},
  _keyGuide = {},
  _currentTab = 0,
  _isOpenByMenu = false,
  _currentListIdx = -1,
  _currentListType = -1
}
function PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide(idx, isShow)
  local self = MarketPlace_ConsoleAssist
  self._ui._keyGuide_X:SetShow(isShow)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuide, self._ui.stc_keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._currentListIdx = idx
end
function PaGlobalFunc_MarketPlace_ItemMarket_ViewDetailToolTip(isShow)
  local self = MarketPlace_ConsoleAssist
  local base = PaGlobalFunc_ItemMarket_Get()
  PaGlobalFunc_TooltipInfo_Close()
  if false == isShow or -1 == self._currentListIdx then
    return
  end
  local itemInfo
  local idx = self._currentListIdx
  if base._itemListType.categoryList == self._currentListType then
    itemInfo = getWorldMarketListByIdx(idx)
  elseif base._itemListType.detailListByKey == self._currentListType then
    itemInfo = getWorldMarketDetailListByIdx(idx)
  elseif base._itemListType.hotListByCategory == self._currentListType then
    itemInfo = getWorldMarketHotListByIdx(idx)
  else
    _PA_ASSERT(false, "\236\157\184\235\141\177\236\138\164\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. : PaGlobalFunc_MarketPlace_ItemMarket_ViewDetailToolTip()")
  end
  if nil == itemInfo then
    _PA_ASSERT(false, "\236\160\149\235\179\180\234\176\128 \236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : PaGlobalFunc_MarketPlace_ItemMarket_ViewDetailToolTip()")
    return
  end
  local itemSSW = itemInfo:getItemEnchantStaticStatusWrapper()
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function PaGlobalFunc_MarketPlace_Wallet_ViewDetailToolTip(slotNo, isShow)
  if true == isShow then
    local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotNo)
    if nil == itemMyWalletInfo then
      return
    end
    local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
    if nil ~= itemWrapper then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      PaGlobalFunc_FloatingTooltip_Close()
    end
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobalFunc_MarketPlace_Wallet_ShowToolTip_Console(slotNo, slotIdx)
  PaGlobalFunc_FloatingTooltip_Close()
  PaGlobalFunc_TooltipInfo_Close()
  local base = PaGlobalFunc_Wallet_Get()
  base._currentSlotIdx = slotIdx
  local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotNo)
  if nil == itemMyWalletInfo then
    return
  end
  local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
  local slot = base._slot[slotIdx]
  if nil == slot then
    return
  end
  if nil == itemWrapper then
    return
  end
  PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, slot.icon)
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_SetMainList(idx)
  local self = MarketPlace_ConsoleAssist
  local base = PaGlobalFunc_ItemMarket_Get()
  local list = base._ui.list_MarketItemList
  local content = list:GetContentByKey(toInt64(0, idx))
  local button = UI.getChildControl(content, "Template_Button_ItemList")
  button:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide(" .. idx .. ", true )")
  button:addInputEvent("Mouse_Out", "PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide(-1, false )")
  self._currentListType = base._itemListType.categoryList
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_SetSubList(listType, idx)
  local self = MarketPlace_ConsoleAssist
  local base = PaGlobalFunc_ItemMarket_Get()
  local list = base._ui.list_MarketItemList_Sub
  local content = list:GetContentByKey(toInt64(0, idx))
  local button = UI.getChildControl(content, "Template_Button_Purchase")
  button:addInputEvent("Mouse_LUp", "InputMLUp_ItemMarket_RequestBiddingList(" .. idx .. ")")
  button:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide(" .. idx .. ", true )")
  button:addInputEvent("Mouse_Out", "PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide( -1,false )")
  self._currentListType = listType
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_Open()
  local self = MarketPlace_ConsoleAssist
  self._currentTab = 0
  if true == self._isOpenByMenu then
    self._tabConfig._count = self._tabConfig._wallet + 1
    self._ui._tabList[self._tabConfig._marketPlace]:SetPosX(self._defaultPosX._marketPlace + 150)
    self._ui._tabList[self._tabConfig._wallet]:SetPosX(self._defaultPosX._wallet + 200)
    self._ui._tabList[self._tabConfig._walletManage]:SetShow(false)
  else
    self._tabConfig._count = self._tabConfig._walletManage + 1
    self._ui._tabList[self._tabConfig._marketPlace]:SetPosX(self._defaultPosX._marketPlace)
    self._ui._tabList[self._tabConfig._wallet]:SetPosX(self._defaultPosX._wallet)
    self._ui._tabList[self._tabConfig._walletManage]:SetShow(true)
  end
  PaGlobalFunc_MarketPlace_ConsoleAssist_SelectTap(0)
  self._isOpenByMenu = false
  self._currentListIdx = -1
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_OpenWalletManage()
  local self = MarketPlace_ConsoleAssist
  local base = PaGlobalFunc_MarketPlace_Get()
  base._ui.stc_MarketPlace:SetShow(false)
  base._ui.stc_Wallet:SetShow(false)
  self._ui._walletManageBg:SetShow(true)
  PaGlobalFunc_MarketPlace_WalletInven_Open()
  PaGlobalFunc_MarketPlace_MyInven_Open()
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_SelectTap(idx)
  local self = MarketPlace_ConsoleAssist
  if nil ~= Panel_Tooltip_SimpleText and Panel_Tooltip_SimpleText:GetShow() then
    TooltipSimple_Hide()
  end
  self._currentTab = self._currentTab + idx
  if self._currentTab < self._tabConfig._marketPlace then
    self._currentTab = self._tabConfig._count - 1
  end
  if self._tabConfig._count - 1 < self._currentTab then
    self._currentTab = self._tabConfig._marketPlace
  end
  self:updateTab()
end
function MarketPlace_ConsoleAssist:updateTab()
  self:uiClear()
  self._ui._tabList[self._currentTab]:SetCheck(true)
  self._ui._keyGuide_A:SetShow(self._tabConfig._walletManage ~= self._currentTab)
  if self._tabConfig._marketPlace == self._currentTab then
    self._ui._tabList[self._currentTab]:SetFontColor(Defines.Color.C_FFFFFFFF)
    self._ui._tabList[self._tabConfig._wallet]:SetFontColor(Defines.Color.C_FF9397A7)
    self._ui._tabList[self._tabConfig._walletManage]:SetFontColor(Defines.Color.C_FF9397A7)
    InputMLUp_MarketPlace_OpenItemMarketTab()
  elseif self._tabConfig._wallet == self._currentTab then
    self._ui._tabList[self._currentTab]:SetFontColor(Defines.Color.C_FFFFFFFF)
    self._ui._tabList[self._tabConfig._marketPlace]:SetFontColor(Defines.Color.C_FF9397A7)
    self._ui._tabList[self._tabConfig._walletManage]:SetFontColor(Defines.Color.C_FF9397A7)
    InputMLUp_MarketPlace_OpenMyWalletTab()
    _panel:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobalFunc_MarketPlace_Wallet_TabToggle()")
    _panel:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_MarketPlace_Wallet_TabToggle()")
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
    local base = PaGlobalFunc_MarketPlace_Get()
    local stc_main = UI.getChildControl(base._ui.stc_Wallet, "Static_Main")
    self._ui.chk_valuePack = UI.getChildControl(stc_main, "CheckButton_ValuePackage")
    self._ui.stc_kamaPackIcon = UI.getChildControl(stc_main, "Static_KamaPack_Icon")
    self._ui.stc_ringBuffIcon = UI.getChildControl(stc_main, "Static_TreasureRing_Icon")
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local player = selfPlayer:get()
    local applyPremium = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
    local chargeTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
    local bool = applyPremium and 0 < chargeTime
    self._ui.chk_valuePack:SetCheck(bool)
    self._ui.chk_valuePack:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_EILEENBUFF_TITLE"))
    if bool then
      self._ui.chk_valuePack:SetFontColor(Defines.Color.C_FFEEEEEE)
    else
      self._ui.chk_valuePack:SetFontColor(Defines.Color.C_FF525B6D)
    end
    local applyKama = player:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
    local kamaRemainTime = player:getUserChargeTime(CppEnums.UserChargeType.eUserChargeType_StarterPackage)
    self._ui.stc_kamaPackIcon:SetShow(_ContentsGroup_Kamasilv_TradeBuff)
    self._ui.stc_kamaPackIcon:SetPosX(self._ui.chk_valuePack:GetPosX() + self._ui.chk_valuePack:GetSizeX() + self._ui.chk_valuePack:GetTextSizeX() + 20)
    self._ui.stc_kamaPackIcon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_YAZBUFF_TITLE"))
    local kamaIconUV = {}
    if true == applyKama and 0 < kamaRemainTime then
      kamaIconUV = {
        103,
        477,
        133,
        507
      }
      self._ui.stc_kamaPackIcon:SetFontColor(Defines.Color.C_FFEEEEEE)
    else
      kamaIconUV = {
        103,
        446,
        133,
        476
      }
      self._ui.stc_kamaPackIcon:SetFontColor(Defines.Color.C_FF525B6D)
    end
    self._ui.stc_kamaPackIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_market_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_kamaPackIcon, kamaIconUV[1], kamaIconUV[2], kamaIconUV[3], kamaIconUV[4])
    self._ui.stc_kamaPackIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_kamaPackIcon:setRenderTexture(self._ui.stc_kamaPackIcon:getBaseTexture())
    local ringCount = getWorldMarketRingBuffCount()
    local isUnlimitedRingBuff = false
    if -1 == ringCount then
      isUnlimitedRingBuff = true
    end
    if true == _ContentsGroup_Kamasilv_TradeBuff then
      self._ui.stc_ringBuffIcon:SetPosX(self._ui.stc_kamaPackIcon:GetPosX() + self._ui.stc_kamaPackIcon:GetSizeX() + self._ui.stc_kamaPackIcon:GetTextSizeX() + 20)
    else
      self._ui.stc_ringBuffIcon:SetPosX(self._ui.chk_valuePack:GetPosX() + self._ui.chk_valuePack:GetSizeX() + self._ui.chk_valuePack:GetTextSizeX() + 20)
    end
    self._ui.stc_ringBuffIcon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MARKETPLACE_RINGBUFF_NAME"))
    self._ui.stc_ringBuffIcon:EraseAllEffect()
    if true == isUnlimitedRingBuff then
      self._ui.stc_ringBuffIcon:SetShow(true)
      self._ui.stc_ringBuffIcon:SetFontColor(Defines.Color.C_FFEEEEEE)
      self._ui.stc_ringBuffIcon:AddEffect("fUI_Ring_buff_01A", true, 0, 0)
    else
      self._ui.stc_ringBuffIcon:SetShow(false)
    end
  elseif self._tabConfig._walletManage == self._currentTab then
    self._ui._tabList[self._currentTab]:SetFontColor(Defines.Color.C_FFFFFFFF)
    self._ui._tabList[self._tabConfig._marketPlace]:SetFontColor(Defines.Color.C_FF9397A7)
    self._ui._tabList[self._tabConfig._wallet]:SetFontColor(Defines.Color.C_FF9397A7)
    PaGlobalFunc_MarketPlace_ConsoleAssist_OpenWalletManage()
    _panel:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobalFunc_MarketPlace_Console_SelectTab()")
    _panel:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_MarketPlace_Console_SelectTab()")
    _panel:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
  end
end
function MarketPlace_ConsoleAssist:uiClear()
  for _, tabControl in pairs(self._ui._tabList) do
    tabControl:SetCheck(false)
  end
  self._ui._walletManageBg:SetShow(false)
  PaGlobalFunc_MarketPlace_ConsoleAssist_SetXKeyGuide(-1, false)
end
function MarketPlace_ConsoleAssist:initControl()
  self._ui._keyGuide_A = UI.getChildControl(self._ui.stc_keyGuideArea, "StaticText_A_ConsoleUI")
  self._ui._keyGuide_X = UI.getChildControl(self._ui.stc_keyGuideArea, "StaticText_X_ConsoleUI")
  self._ui._keyGuide_B = UI.getChildControl(self._ui.stc_keyGuideArea, "Button_B_ConsoleUI")
  self._keyGuide = {
    self._ui._keyGuide_A,
    self._ui._keyGuide_X,
    self._ui._keyGuide_B
  }
  self._ui._tabList[self._tabConfig._marketPlace] = UI.getChildControl(self._ui._tabBg, "RadioButton_MarketPlace")
  self._ui._tabList[self._tabConfig._wallet] = UI.getChildControl(self._ui._tabBg, "RadioButton_Wallet")
  self._ui._tabList[self._tabConfig._walletManage] = UI.getChildControl(self._ui._tabBg, "RadioButton_WalletManagement")
  self._defaultPosX._marketPlace = self._ui._tabList[self._tabConfig._marketPlace]:GetPosX()
  self._defaultPosX._wallet = self._ui._tabList[self._tabConfig._wallet]:GetPosX()
  self._defaultPosX._walletManage = self._ui._tabList[self._tabConfig._walletManage]:GetPosX()
  self._ui.stc_LeftToRightArrow = UI.getChildControl(self._ui._walletManageBg, "Static_LefttoRight")
  self._ui.stc_RightToLeftArrow = UI.getChildControl(self._ui._walletManageBg, "Static_RighttoLeft")
end
function MarketPlace_ConsoleAssist:initEvent()
  _panel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_MarketPlace_ItemMarket_ViewDetailToolTip(true)")
  _panel:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_MarketPlace_ConsoleAssist_SelectTap(-1)")
  _panel:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_MarketPlace_ConsoleAssist_SelectTap(1)")
end
function PaGlobalFunc_MarketPlace_ConsoleAssist_TriggerHandle(idx)
end
function PaGlobalFunc_MarketPlace_ConsoleAssistInit()
  local self = MarketPlace_ConsoleAssist
  self:initControl()
  self:initEvent()
end
function PaGlobalFunc_MarketPlaceConsole_OpenByMenu()
  local self = MarketPlace_ConsoleAssist
  self._isOpenByMenu = true
  PaGlobalFunc_MarketPlace_Open()
end
function PaGlobalFunc_MarketPlaceConsole_SelectManageWalletBG(isInvenBG, isShowGuide)
  local self = MarketPlace_ConsoleAssist
  PaGlobal_MarketPlaceConsole_SetInvenKeyGuide(isInvenBG and isShowGuide)
  self._ui.stc_RightToLeftArrow:SetShow(isInvenBG)
  PaGlobal_MarketPlaceConsole_SetWalletKeyGuide(not isInvenBG and isShowGuide)
  self._ui.stc_LeftToRightArrow:SetShow(not isInvenBG)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MarketPlace_ConsoleAssistInit")
