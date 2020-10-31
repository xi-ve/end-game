function PaGlobal_Masterpiece_Auction_Bid_All_Open(idx)
  UI.ASSERT_NAME(nil ~= idx, "PaGlobal_Masterpiece_Auction_Bid_All_Open\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  PaGlobal_Masterpiece_Auction_Bid_All._bidIndex = idx
  PaGlobal_Masterpiece_Auction_Bid_All:prepareOpen()
end
function PaGlobal_Masterpiece_Auction_Bid_All_Close()
  PaGlobal_Masterpiece_Auction_Bid_All:prepareClose()
end
function HandleEventLUp_Masterpiece_Auction_Bid_clickedConfirm()
  if nil == PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDHOUSE_AUCTION_WRONGPRICE"))
    return
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local goodsInfo = myAuctionInfo:getItemAuctionListAt(PaGlobal_Masterpiece_Auction_Bid_All._bidIndex)
  if nil == goodsInfo then
    return
  end
  local bidItemAuction = function()
    RequestBidAuction(PaGlobal_Masterpiece_Auction_Bid_All._bidIndex, PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice)
    PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice = nil
    PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:SetEditText("", true)
    PaGlobal_Masterpiece_Auction_All_UpdateList()
    PaGlobal_Masterpiece_Auction_Bid_All_Close()
  end
  local highPrice = goodsInfo:getHighPrice_s64()
  if highPrice <= PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_DESC")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_NAME"),
      content = messageBoxMemo,
      functionYes = bidItemAuction,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    PaGlobal_Masterpiece_Auction_All_SetBidTypeIndex(PaGlobal_Masterpiece_Auction_Bid_All._bidType._bidTry)
    ClearFocusEdit()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_PRICEALERT"))
    PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:SetEditText("")
    PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice = nil
    ClearFocusEdit()
  end
end
function HandleEventLUp_Masterpiece_Auction_Bid_clickedCancel()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:SetEditText("", true)
  PaGlobal_Masterpiece_Auction_Bid_All_Close()
end
function HandleEventLUp_Masterpiece_Auction_Bid_clickedEdit()
  local wareHouseMoney = warehouse_moneyFromNpcShop_s64()
  Panel_NumberPad_Show(true, wareHouseMoney, nil, PaGlobal_Masterpiece_Auction_Bid_All_AuctionConfirmFunction, false, nil, false)
end
function PaGlobal_Masterpiece_Auction_Bid_All_AuctionConfirmFunction(param0)
  PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:SetEditText(makeDotMoney(param0))
  PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._auctionPrice = param0
end
function FromClient_Masterpiece_Auction_Bid_All_ReSizePanel()
  if false == PaGlobal_Masterpiece_Auction_Bid_All._isConsole then
    PaGlobal_Masterpiece_Auction_Bid_All._ui_pc.btn_cancel:ComputePos()
    PaGlobal_Masterpiece_Auction_Bid_All._ui_pc.btn_confirm:ComputePos()
    PaGlobal_Masterpiece_Auction_Bid_All._ui_pc.btn_close:ComputePos()
  else
    local keyguide = {
      PaGlobal_Masterpiece_Auction_Bid_All._ui_console.stc_keyGuideX,
      PaGlobal_Masterpiece_Auction_Bid_All._ui_console.stc_selectA,
      PaGlobal_Masterpiece_Auction_Bid_All._ui_console.stc_cancelB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, PaGlobal_Masterpiece_Auction_Bid_All._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  PaGlobal_Masterpiece_Auction_Bid_All._ui.stc_bidBg:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.edit_bidPrice:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.txt_auctionPrice:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.stc_wareHouseBg:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.stc_wareHousetitle:ComputePos()
  PaGlobal_Masterpiece_Auction_Bid_All._ui.stc_wareHouseMoney:ComputePos()
end
function PaGlobal_Masterpiece_Auction_Bid_All_ShowAni()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
end
function PaGlobal_Masterpiece_Auction_Bid_All_HideAni()
  if nil == Panel_Masterpiece_Auction_Bid_All then
    return
  end
end
