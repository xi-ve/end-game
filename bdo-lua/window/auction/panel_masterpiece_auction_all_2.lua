function PaGlobal_Masterpiece_Auction_All_Open()
  PaGlobal_Masterpiece_Auction_All:prepareOpen()
end
function PaGlobal_Masterpiece_Auction_All_Close()
  if nil ~= Panel_Masterpiece_Auction_Bid_All and true == Panel_Masterpiece_Auction_Bid_All:GetShow() then
    PaGlobal_Masterpiece_Auction_Bid_All_Close()
  end
  PaGlobal_Masterpiece_Auction_All:clearSlotItem()
  PaGlobal_Masterpiece_Auction_All:prepareClose()
end
function HandleEventOn_Masterpiece_Auction_All_SimpleTooltip(isShow, index)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOn_Masterpiece_Auction_All_SimpleTooltip\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= index, "HandleEventOn_Masterpiece_Auction_All_SimpleTooltip\236\157\152 index nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local goodsInfo = myAuctionInfo:getItemAuctionListAt(index)
  if nil == goodsInfo then
    return
  end
  local name = tostring(goodsInfo:getExhibitor())
  local desc = tostring(goodsInfo:getDescription())
  local control = PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOn_Masterpiece_Auction_All_ShowTooltip(isShow, index, auctionType)
  UI.ASSERT_NAME(nil ~= isShow, "HandleEventOn_Masterpiece_Auction_All_ShowTooltip\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= index, "HandleEventOn_Masterpiece_Auction_All_ShowTooltip\236\157\152 index nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= auctionType, "HandleEventOn_Masterpiece_Auction_All_ShowTooltip\236\157\152 auctionType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_SetPosition(index, PaGlobal_Masterpiece_Auction_All._ui.itemList._slotItem, "masterpiecdAuction")
  Panel_Tooltip_Item_Show_GeneralStatic(index, "masterpiecdAuction", true, auctionType)
end
function HandleEventLUp_Masterpiece_Auction_All_ItemListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Masterpiece_Auction_All_ItemListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Masterpiece_Auction_All_ItemListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local goodsInfo = myAuctionInfo:getItemAuctionListAt(key_32)
  if nil == goodsInfo then
    return
  end
  local itemWrapper = goodsInfo:getItem()
  local itemSSW = itemWrapper:getStaticStatus()
  control:ComputePos()
  local btn_item = UI.getChildControl(control, "RadioButton_LeftContentBg")
  btn_item:ComputePos()
  btn_item:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_SetInfomation( " .. key_32 .. " )")
  btn_item:SetCheck(false)
  if key_32 == PaGlobal_Masterpiece_Auction_All._selectListIndex then
    btn_item:SetCheck(true)
  end
  local txt_itemName = UI.getChildControl(control, "StaticText_ButtonText")
  txt_itemName:SetTextMode(__eTextMode_AutoWrap)
  txt_itemName:SetText(itemSSW:getName())
end
function HandleEventLUp_Masterpiece_Auction_All_SetInfomation(idx)
  UI.ASSERT_NAME(nil ~= idx, "HandleEventLUp_Masterpiece_Auction_All_SetInfomation\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local goodsInfo = myAuctionInfo:getItemAuctionListAt(idx)
  if nil == goodsInfo then
    return
  end
  local auctionType = myAuctionInfo:getAuctionType()
  local itemWrapper = goodsInfo:getItem()
  local itemSSW = itemWrapper:getStaticStatus()
  local leftTime_u64 = goodsInfo:getExpireTime_u64() / toUint64(0, 1000)
  local highPrice_s64 = goodsInfo:getHighPrice_s64()
  local lowPrice_s64 = goodsInfo:getLowPrice_s64()
  local isBiddable = goodsInfo:isBiddable()
  local isEnd = goodsInfo:isAuctionEnd()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceName:SetText(itemSSW:getName())
  PaGlobal_Masterpiece_Auction_All._ui.itemList._slotItem:setItemByStaticStatus(itemSSW)
  PaGlobal_Masterpiece_Auction_All._ui.itemList._slotItem.icon:addInputEvent("Mouse_On", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(true," .. idx .. "," .. auctionType .. ")")
  PaGlobal_Masterpiece_Auction_All._ui.itemList._slotItem.icon:addInputEvent("Mouse_Out", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(false," .. idx .. "," .. auctionType .. ")")
  local minimumBidPrice = 0
  if false == isEnd then
    PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MASTERPIECE_LEFTTIME", "time", tostring(Util.Time.timeFormatting_Minute(Int64toInt32(leftTime_u64)))))
    PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_leftTime:SetPosX(PaGlobal_Masterpiece_Auction_All._LEFTTIMEPOSX - PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_leftTime:GetTextSizeX() * 0.5)
    if 0 == Int64toInt32(highPrice_s64) then
      PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECE_LOWPRICE"))
      PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_Value:SetText(makeDotMoney(lowPrice_s64))
    else
      PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECE_CURRENTBIDPRICE"))
      PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_Value:SetText(makeDotMoney(highPrice_s64))
    end
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_bid:SetMonoTone(false)
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_bid:SetIgnore(false)
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_bid:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_BidButton(" .. idx .. ")")
  end
  local itemAuthor = goodsInfo:getExhibitor()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceAuthor:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_ITEMAUTHOR", "itemAuthor", itemAuthor))
  local itemDesc = goodsInfo:getDescription()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:SetTextMode(__eTextMode_Limit_AutoWrap)
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:setLineCountByLimitAutoWrap(8)
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:SetText(itemDesc)
  if PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:IsLimitText() then
    PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:SetEnableArea(0, 0, PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:GetPosX(), PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:GetTextSizeY())
    PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:addInputEvent("Mouse_On", "HandleEventOn_Masterpiece_Auction_All_SimpleTooltip( true, " .. idx .. ")")
    PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:addInputEvent("Mouse_Out", "HandleEventOn_Masterpiece_Auction_All_SimpleTooltip( false, " .. idx .. ")")
  end
  PaGlobal_Masterpiece_Auction_All._selectListIndex = idx
end
function HandleEventLUp_Masterpiece_Auction_All_BidButton(key)
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Masterpiece_Auction_All_BidButton\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local key_32 = Int64toInt32(key)
  PaGlobal_Masterpiece_Auction_Bid_All_Open(key_32)
end
function HandleEventLUp_Masterpiece_Auction_All_BidListControlCreate(control, key)
  UI.ASSERT_NAME(nil ~= control, "HandleEventLUp_Masterpiece_Auction_All_BidListControlCreate\236\157\152 control nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= key, "HandleEventLUp_Masterpiece_Auction_All_BidListControlCreate\236\157\152 key nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local key_32 = Int64toInt32(key)
  local auctionType = myAuctionInfo:getAuctionType()
  local goodsInfo = myAuctionInfo:getMyItemBidListAt(key_32)
  if nil == goodsInfo then
    return
  end
  local btn_bidcontent = UI.getChildControl(control, "Static_LeftButton")
  local txt_bidItemName = UI.getChildControl(btn_bidcontent, "StaticText_BidItemName1")
  local stc_bidItemSlot = UI.getChildControl(btn_bidcontent, "Static_ItemSlotBg1")
  local txt_bidLeftTime = UI.getChildControl(btn_bidcontent, "StaticText_LeftTime1")
  local stc_bidItemCondition = UI.getChildControl(btn_bidcontent, "Static_BidCondition1")
  local btn_bidItem = UI.getChildControl(btn_bidcontent, "Button_Auction1")
  local txt_bidPriceTitle = UI.getChildControl(btn_bidcontent, "StaticText_BidPriceTitle1")
  local txt_bidPrice = UI.getChildControl(btn_bidcontent, "StaticText_BidMoney1")
  btn_bidItem:SetMonoTone(true)
  btn_bidItem:SetIgnore(true)
  local leftTime_u64 = goodsInfo:getExpireTime_u64() / toUint64(0, 1000)
  local highPrice_s64 = goodsInfo:getUpperBidPrice_s64()
  local myPrice_s64 = goodsInfo:getMyBidPrice_s64()
  local isBiddable = goodsInfo:isSuccessBid()
  local isEnd = goodsInfo:isAuctionEnd()
  stc_bidItemCondition:ChangeTextureInfoName("combine/etc/combine_etc_imperialauction.dds")
  local texUVKey = 1
  if true == isBiddable or false == isEnd then
    local itemWrapper = goodsInfo:getItem()
    local itemSSW = itemWrapper:getStaticStatus()
    local slot = {}
    SlotItem.reInclude(slot, "MasterpieceAuction_Slot_Icon_", 0, stc_bidItemSlot, PaGlobal_Masterpiece_Auction_All._slotConfig)
    slot:clearItem()
    slot:setItem(itemWrapper)
    slot.icon:addInputEvent("Mouse_On", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(true," .. key_32 .. "," .. auctionType .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(false," .. key_32 .. "," .. auctionType .. ")")
    txt_bidItemName:SetText(itemSSW:getName())
    UI.setLimitTextAndAddTooltip(txt_bidItemName)
    txt_bidLeftTime:SetText(tostring(Util.Time.timeFormatting_Minute(Int64toInt32(leftTime_u64))))
    txt_bidPrice:SetText(makeDotMoney(myPrice_s64))
    if highPrice_s64 > myPrice_s64 then
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEMONEY"))
      btn_bidItem:SetMonoTone(false)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell(" .. key_32 .. ")")
      texUVKey = 2
    elseif isBiddable then
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEITEM"))
      btn_bidItem:SetMonoTone(false)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_GetSuccessItemorMoney(" .. key_32 .. ")")
      texUVKey = 3
    else
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_TOPPRICEITEM"))
      btn_bidItem:SetMonoTone(true)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "")
      texUVKey = 1
    end
  else
    txt_bidPrice:SetText(makeDotMoney(myPrice_s64))
    btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEMONEY"))
    btn_bidItem:SetMonoTone(false)
    btn_bidItem:SetIgnore(false)
    btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell(" .. key_32 .. ")")
  end
  control:ComputePos()
  if 0 == (key_32 + 1) % 2 then
    btn_bidcontent:ComputePos()
    local padding = 10
    btn_bidcontent:SetPosX(btn_bidcontent:GetPosX() + btn_bidcontent:GetSizeX() + padding)
  end
  local x1, y1, x2, y2 = setTextureUV_Func(stc_bidItemCondition, PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][1], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][2], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][3], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][4])
  stc_bidItemCondition:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_bidItemCondition:setRenderTexture(stc_bidItemCondition:getBaseTexture())
end
function HandleEventLUp_Masterpiece_Auction_All_TabSelect()
  if true == PaGlobal_Masterpiece_Auction_All._ui.btn_itemList:IsCheck() then
    PaGlobal_Masterpiece_Auction_All._isItemList = true
    RequestAuctionListPage()
  else
    PaGlobal_Masterpiece_Auction_All._isItemList = false
    PaGlobal_Masterpiece_Auction_All._selectListIndex = 0
    RequestBiddingPage()
  end
  PaGlobal_Masterpiece_Auction_All:setItemListSetting(PaGlobal_Masterpiece_Auction_All._isItemList)
  PaGlobal_Masterpiece_Auction_All:setNotice()
end
function HandleEventLUp_Masterpiece_Auction_All_Reload()
  if false == PaGlobal_Masterpiece_Auction_All._isItemList then
    PaGlobal_Masterpiece_Auction_All:updateBidList()
  else
    PaGlobal_Masterpiece_Auction_All:updateItemList()
    HandleEventLUp_Masterpiece_Auction_All_SetInfomation(PaGlobal_Masterpiece_Auction_All._selectListIndex)
  end
end
function HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell(index)
  UI.ASSERT_NAME(nil ~= index, "HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell\236\157\152 index nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  RequestAuction_CancelGoods(index)
  PaGlobal_Masterpiece_Auction_All._bidTypeIndex = PaGlobal_Masterpiece_Auction_All._bidType._bidFail
end
function HandleEventLUp_Masterpiece_Auction_All_GetSuccessItemorMoney(index)
  UI.ASSERT_NAME(nil ~= index, "HandleEventLUp_Masterpiece_Auction_All_GetSuccessItemorMoney\236\157\152 index nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  RequestAuction_GetGoods(index)
  PaGlobal_Masterpiece_Auction_All._bidTypeIndex = PaGlobal_Masterpiece_Auction_All._bidType._bidSuccess
end
function HandleEventPadRBLB_Masterpiece_Auction_All_ToggleTab(value)
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  if false == PaGlobal_Masterpiece_Auction_All._isConsole then
    return
  end
  local tabMenuControl = {
    [0] = PaGlobal_Masterpiece_Auction_All._ui.btn_itemList,
    [1] = PaGlobal_Masterpiece_Auction_All._ui.btn_myBidList
  }
  PaGlobal_Masterpiece_Auction_All._currentMenu = PaGlobal_Masterpiece_Auction_All._currentMenu + value
  if 0 > PaGlobal_Masterpiece_Auction_All._currentMenu then
    PaGlobal_Masterpiece_Auction_All._currentMenu = PaGlobal_Masterpiece_Auction_All._TABMENU.COUNT
  elseif PaGlobal_Masterpiece_Auction_All._TABMENU.COUNT < PaGlobal_Masterpiece_Auction_All._currentMenu then
    PaGlobal_Masterpiece_Auction_All._currentMenu = 0
  end
  tabMenuControl[0]:SetCheck(false)
  tabMenuControl[1]:SetCheck(false)
  tabMenuControl[PaGlobal_Masterpiece_Auction_All._currentMenu]:SetCheck(true)
  HandleEventLUp_Masterpiece_Auction_All_TabSelect()
end
function FromClient_Masterpiece_Auction_All_ReSizePanel()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  Panel_Masterpiece_Auction_All:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.list2_lefeContent:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.stc_centerBg:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.stc_auctionItemSlot:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceName:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceAuthor:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceStory:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_title:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_currentPrice_Value:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_leftTime:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_warehouse:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_money:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_masterpieceReady:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.bidList.list2_myBid:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.txt_bottomDesc:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.btn_itemList:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.btn_myBidList:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.stc_selectLine:ComputePos()
  PaGlobal_Masterpiece_Auction_All._ui.btn_Reload:ComputePos()
  if false == PaGlobal_Masterpiece_Auction_All._isConsole then
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_question:ComputePos()
    PaGlobal_Masterpiece_Auction_All._ui_pc.btn_bid:ComputePos()
  else
    PaGlobal_Masterpiece_Auction_All._ui_console.stc_buttonGuide:ComputePos()
    local keyGuideReload = UI.getChildControl(PaGlobal_Masterpiece_Auction_All._ui_console.stc_buttonGuide, "Static_GuideY_C")
    local keyGuideClose = UI.getChildControl(PaGlobal_Masterpiece_Auction_All._ui_console.stc_buttonGuide, "Static_GuideB_C")
    local tempBtnGroup = {keyGuideReload, keyGuideClose}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_Masterpiece_Auction_All._ui_console.stc_buttonGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function FromClient_Masterpiece_Auction_All_BidAuctionGoods(goodsType, param1, param2)
  RequestAuctionListPage()
  if 0 ~= goodsType then
    return
  end
  local bidSuccess = param2
  if bidSuccess then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_BIDTYPEMESSAGE_1"))
  end
end
function FromClient_Masterpiece_Auction_All_WarehouseUpdate()
  local wareHouseMoney = warehouse_moneyFromNpcShop_s64()
  PaGlobal_Masterpiece_Auction_All._ui.itemList.txt_money:SetText(makeDotMoney(wareHouseMoney))
end
function FromClient_Masterpiece_Auction_All_UpdateAuctionList()
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local auctionType = myAuctionInfo:getAuctionType()
  warehouse_requestInfoFromNpc()
  if CppEnums.AuctionTabType.AuctionTab_SellItem == auctionType or CppEnums.AuctionTabType.AuctionTab_MySellPage == auctionType or PaGlobal_Masterpiece_Auction_All._isOpenEscMenu == true then
    if false == Panel_Masterpiece_Auction_All:GetShow() then
      if true == ToClient_SelfPlayerIsGM() then
        chatting_sendMessage("", "FromClient_Masterpiece_Auction_All_UpdateAuctionList -> Open", CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
      end
      PaGlobal_Masterpiece_Auction_All_Open()
    end
  elseif true == PaGlobal_Masterpiece_Auction_All._isItemList then
    PaGlobal_Masterpiece_Auction_All:updateItemList()
  else
    PaGlobal_Masterpiece_Auction_All:updateBidList()
    PaGlobal_Masterpiece_Auction_All:bidTypeMessage(PaGlobal_Masterpiece_Auction_All._bidTypeIndex)
  end
end
function PaGlobal_Masterpiece_Auction_All_SetBidTypeIndex(idx)
  UI.ASSERT_NAME(nil ~= idx, "PaGlobal_Masterpiece_Auction_All_SetBidTypeIndex\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_Masterpiece_Auction_All._bidTypeIndex = idx
end
function PaGlobal_Masterpiece_Auction_All_ESCOpen()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local auctionType = myAuctionInfo:getAuctionType()
  ToClient_getAuctionItemFromNoNpc(1001, 0, 0)
  PaGlobal_Masterpiece_Auction_All._TABMENU.COUNT = 0
  PaGlobal_Masterpiece_Auction_All._isOpenEscMenu = true
  PaGlobal_Masterpiece_Auction_All._isItemList = true
  PaGlobal_Masterpiece_Auction_All_Open()
end
function PaGlobal_Masterpiece_Auction_All_IsOpenEscMenu()
  return PaGlobal_Masterpiece_Auction_All._isOpenEscMenu
end
function PaGlobal_Masterpiece_Auction_All_UpdateList()
  PaGlobal_Masterpiece_Auction_All:updateItemList()
  PaGlobal_Masterpiece_Auction_All:updateBidList()
end
function PaGlobal_Masterpiece_Auction_All_ShowAni()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
end
function PaGlobal_Masterpiece_Auction_All_HideAni()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
end
