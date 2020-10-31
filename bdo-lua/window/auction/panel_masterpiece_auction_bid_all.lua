PaGlobal_Masterpiece_Auction_Bid_All = {
  _ui = {
    stc_bidBg = nil,
    edit_bidPrice = nil,
    txt_auctionPrice = nil,
    stc_wareHouseBg = nil,
    stc_wareHousetitle = nil,
    stc_wareHouseMoney = nil
  },
  _ui_pc = {
    btn_cancel = nil,
    btn_confirm = nil,
    btn_close = nil
  },
  _ui_console = {
    stc_bottomBg = nil,
    stc_selectA = nil,
    stc_cancelB = nil,
    stc_keyGuideX = nil
  },
  _bidType = {
    _bidNone = 0,
    _bidTry = 1,
    _bidFail = 2,
    _bidSuccess = 3
  },
  _sizeY = {
    CONSOLE_PANEL = 230,
    PC_PANEL = 295,
    CONSOLE_MAINBG = 180,
    PC_MAINBG = 245
  },
  _initialize = false,
  _isConsole = false,
  _bidIndex = nil,
  _auctionPrice = nil,
  _isBiddable = true
}
runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_Bid_All_1.lua")
runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_Bid_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Masterpiece_Auction_Bid_AllInit")
function FromClient_Masterpiece_Auction_Bid_AllInit()
  PaGlobal_Masterpiece_Auction_Bid_All:initialize()
end
