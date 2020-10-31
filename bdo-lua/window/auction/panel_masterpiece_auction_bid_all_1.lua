function PaGlobal_Masterpiece_Auction_Bid_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Masterpiece_Auction_Bid_All:controlAll_Init()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui.stc_bidBg = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Static_BidBg")
  local bidBg = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Static_BidBg")
  self._ui.edit_bidPrice = UI.getChildControl(bidBg, "Edit_BidPrice")
  self._ui.txt_auctionPrice = UI.getChildControl(self._ui.edit_bidPrice, "StaticText_AucPrice")
  self._ui.stc_wareHouseBg = UI.getChildControl(bidBg, "Static_WareHouseBg")
  self._ui.stc_wareHousetitle = UI.getChildControl(self._ui.stc_wareHouseBg, "Static_WareHouseTitle")
  self._ui.stc_wareHouseMoney = UI.getChildControl(self._ui.stc_wareHouseBg, "Static_TextIcon")
end
function PaGlobal_Masterpiece_Auction_Bid_All:controlPc_Init()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui_pc.btn_cancel = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Button_Cancel_PCUI")
  self._ui_pc.btn_confirm = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Button_Confirm_PCUI")
  self._ui_pc.btn_close = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Button_Close_PCUI")
end
function PaGlobal_Masterpiece_Auction_Bid_All:controlConsole_Init()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui_console.stc_bottomBg = UI.getChildControl(Panel_Masterpiece_Auction_Bid_All, "Static_BottomBg_ConsoleUI")
  self._ui_console.stc_selectA = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_cancelB = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_B_ConsoleUI")
  self._ui_console.stc_keyGuideX = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_X_ConsoleUI")
end
function PaGlobal_Masterpiece_Auction_Bid_All:SetUiSetting()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  if false == PaGlobal_Masterpiece_Auction_Bid_All._isConsole then
    self._ui_console.stc_bottomBg:SetShow(false)
    self._ui_pc.btn_cancel:SetShow(true)
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    Panel_Masterpiece_Auction_Bid_All:SetSize(Panel_Masterpiece_Auction_Bid_All:GetSizeX(), self._sizeY.PC_PANEL)
    self._ui.stc_bidBg:SetSize(self._ui.stc_bidBg:GetSizeX(), self._sizeY.PC_MAINBG)
  else
    self._ui_pc.btn_cancel:SetShow(false)
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_bottomBg:SetShow(true)
    Panel_Masterpiece_Auction_Bid_All:SetSize(Panel_Masterpiece_Auction_Bid_All:GetSizeX(), self._sizeY.CONSOLE_PANEL)
    self._ui.stc_bidBg:SetSize(self._ui.stc_bidBg:GetSizeX(), self._sizeY.CONSOLE_MAINBG)
  end
  FromClient_Masterpiece_Auction_Bid_All_ReSizePanel()
end
function PaGlobal_Masterpiece_Auction_Bid_All:registEventHandler()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Masterpiece_Auction_Bid_All_ReSizePanel()")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_Bid_clickedCancel()")
    self._ui_pc.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_Bid_clickedCancel()")
    self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_Bid_clickedConfirm()")
    self._ui.edit_bidPrice:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_Bid_clickedEdit()")
  else
    Panel_Masterpiece_Auction_Bid_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Masterpiece_Auction_Bid_clickedConfirm()")
    Panel_Masterpiece_Auction_Bid_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Masterpiece_Auction_Bid_clickedEdit()")
  end
end
function PaGlobal_Masterpiece_Auction_Bid_All:prepareOpen()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self:setWareHouseMoney()
  self._auctionPrice = nil
  self._ui.edit_bidPrice:SetEditText("", true)
  PaGlobal_Masterpiece_Auction_Bid_All:open()
end
function PaGlobal_Masterpiece_Auction_Bid_All:open()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  Panel_Masterpiece_Auction_Bid_All:SetShow(true)
end
function PaGlobal_Masterpiece_Auction_Bid_All:prepareClose()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  PaGlobal_Masterpiece_Auction_Bid_All:close()
end
function PaGlobal_Masterpiece_Auction_Bid_All:close()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  Panel_Masterpiece_Auction_Bid_All:SetShow(false)
end
function PaGlobal_Masterpiece_Auction_Bid_All:update()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
end
function PaGlobal_Masterpiece_Auction_Bid_All:validate()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Masterpiece_Auction_Bid_All:allValidate()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui.stc_bidBg:isValidate()
  self._ui.edit_bidPrice:isValidate()
  self._ui.txt_auctionPrice:isValidate()
  self._ui.stc_wareHouseBg:isValidate()
  self._ui.stc_wareHousetitle:isValidate()
  self._ui.stc_wareHouseMoney:isValidate()
end
function PaGlobal_Masterpiece_Auction_Bid_All:pcValidate()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui_pc.btn_cancel:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_pc.btn_close:isValidate()
end
function PaGlobal_Masterpiece_Auction_Bid_All:consoleValidate()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
  self._ui_console.stc_bottomBg:isValidate()
  self._ui_console.stc_keyGuideX:isValidate()
  self._ui_console.stc_selectA:isValidate()
  self._ui_console.stc_cancelB:isValidate()
end
function PaGlobal_Masterpiece_Auction_Bid_All:setWareHouseMoney()
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local goodsInfo = myAuctionInfo:getItemAuctionListAt(PaGlobal_Masterpiece_Auction_Bid_All._bidIndex)
  if nil == goodsInfo then
    return
  end
  self._ui.stc_wareHousetitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECE_WAREHOUSETITLE"))
  local wareHouseMoney = warehouse_moneyFromNpcShop_s64()
  self._ui.stc_wareHouseMoney:SetText(makeDotMoney(wareHouseMoney))
  self._ui.stc_wareHouseMoney:ComputePos()
end
