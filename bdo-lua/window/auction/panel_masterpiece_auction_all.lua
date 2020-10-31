PaGlobal_Masterpiece_Auction_All = {
  _ui = {
    itemList = {
      list2_lefeContent = nil,
      stc_centerBg = nil,
      stc_auctionItemSlot = nil,
      txt_masterpieceName = nil,
      txt_masterpieceAuthor = nil,
      txt_masterpieceStory = nil,
      txt_currentPrice_title = nil,
      txt_currentPrice_Value = nil,
      txt_leftTime = nil,
      txt_warehouse = nil,
      txt_money = nil,
      txt_masterpieceReady = nil
    },
    bidList = {list2_myBid = nil},
    stc_titleBg = nil,
    rdo_buttons = nil,
    btn_itemList = nil,
    btn_myBidList = nil,
    stc_selectLine = nil,
    txt_bottomDesc = nil,
    btn_Reload = nil
  },
  _ui_pc = {
    btn_close = nil,
    btn_question = nil,
    btn_detach = nil,
    btn_bid = nil
  },
  _ui_console = {
    stc_buttonGuide = nil,
    stc_iconLB = nil,
    stc_iconRB = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _initialize = false,
  _isConsole = false,
  _isOpenEscMenu = false,
  _isItemList = true,
  _selectListIndex = 0,
  _bidTypeIndex = 0,
  _bidType = {
    _bidNone = 0,
    _bidTry = 1,
    _bidFail = 2,
    _bidSuccess = 3
  },
  _PANELSIZEY = 805,
  _DESCSIZEY = 105,
  _LEFTTIMEPOSX = 345,
  _TABMENU = {
    ITEM = 0,
    MY = 1,
    COUNT = 1
  },
  _currentMenu = 0,
  _bidConditionUV = {
    [1] = {
      348,
      1,
      370,
      23
    },
    [2] = {
      394,
      1,
      416,
      23
    },
    [3] = {
      371,
      1,
      393,
      23
    }
  }
}
runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_All_1.lua")
runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Masterpiece_Auction_AllInit")
function FromClient_Masterpiece_Auction_AllInit()
  PaGlobal_Masterpiece_Auction_All:initialize()
end
