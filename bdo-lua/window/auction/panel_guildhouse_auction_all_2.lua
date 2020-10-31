function PaGlobal_GuildHouse_Auction_All_Open()
  PaGlobal_GuildHouse_Auction_All:prepareOpen()
end
function PaGlobal_GuildHouse_Auction_All_Close()
  if nil ~= Panel_GuildHouse_Auction_Detail_All and true == Panel_GuildHouse_Auction_Detail_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Detail_All_Close()
  end
  if nil ~= Panel_GuildHouse_Auction_Bid_All and true == Panel_GuildHouse_Auction_Bid_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Bid_All_Close()
  end
  PaGlobal_GuildHouse_Auction_All:prepareClose()
end
function HandleEventLUp_GuildHouse_Auction_All_clickedTypeButton()
  local movePosX = 0
  for key, value in pairs(PaGlobal_GuildHouse_Auction_All._houseAuctionList) do
    value:SetShow(false)
  end
  for key, value in pairs(PaGlobal_GuildHouse_Auction_All._houseMyBidList) do
    value:SetShow(false)
  end
  if true == PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:IsChecked() then
    movePosX = PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:GetPosX() + PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:GetSizeX() / 3
    PaGlobal_GuildHouse_Auction_All._ui.stc_selectBar:SetPosX(movePosX)
    for index = 0, PaGlobal_GuildHouse_Auction_All._houseAuctionCnt - 1 do
      PaGlobal_GuildHouse_Auction_All._houseAuctionList[index]:SetShow(true)
    end
  else
    movePosX = PaGlobal_GuildHouse_Auction_All._ui.btn_myBid:GetPosX() + PaGlobal_GuildHouse_Auction_All._ui.btn_myBid:GetSizeX() / 3
    PaGlobal_GuildHouse_Auction_All._ui.stc_selectBar:SetPosX(movePosX)
    for index = 0, PaGlobal_GuildHouse_Auction_All._houseBidCnt - 1 do
      PaGlobal_GuildHouse_Auction_All._houseMyBidList[index]:SetShow(true)
    end
  end
end
function HandleEventLUp_GuildHouse_Auction_All_clickedListButton(idx, tabType)
  if nil == Panel_GuildHouse_Auction_Detail_All then
    return
  end
  PaGlobal_GuildHouse_Auction_Detail_All_Open(idx, tabType)
end
function HandleEventLUp_GuildHouse_Auction_All_DetailShowToggle(idx, tabType)
  if nil == Panel_GuildHouse_Auction_Detail_All then
    return
  end
  if nil == idx or nil == tabType then
    return
  end
  if true == Panel_GuildHouse_Auction_Detail_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Detail_All_Close()
  else
    HandleEventLUp_GuildHouse_Auction_All_clickedListButton(idx, tabType)
  end
end
function HandleEventLUp_GuildHouse_Auction_All_BidShowToggle(idx)
  if nil == Panel_GuildHouse_Auction_Bid_All then
    return
  end
  if nil == idx then
    return
  end
  if true == Panel_GuildHouse_Auction_Bid_All:GetShow() then
    PaGlobal_GuildHouse_Auction_Bid_All_Close()
  else
    PaGlobal_GuildHouse_Auction_Bid_All_Open(idx)
  end
end
function HandleEventLUp_GuildHouse_Auction_All_clickedCancelButton(index)
  RequestAuction_CancelGoods(index)
end
function HandleEventLUp_GuildHouse_Auction_All_clickedBidButton(index)
  PaGlobal_GuildHouse_Auction_Bid_All_Open(index)
end
function HandleEventLUp_GuildHouse_Auction_All_clickedPrevButton()
  ClearFocusEdit()
  RequestAuctionPrevPage()
end
function HandleEventLUp_GuildHouse_Auction_All_clickedNextButton()
  local myAuctionInfo = RequestGetAuctionInfo()
  local houseCount = myAuctionInfo:getHouseAuctionListCount()
  local maxPage = myAuctionInfo:getMaxPage()
  local currentPage = myAuctionInfo:getCurrentPage()
  if maxPage > currentPage + 1 then
    ClearFocusEdit()
    RequestAuctionNextPage()
    return true
  else
    return false
  end
end
function Input_GuildHouse_Auction_All_ChangeType()
  if true == PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:IsChecked() then
    PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:SetCheck(true)
    PaGlobal_GuildHouse_Auction_All._ui.btn_myBid:SetCheck(false)
    RequestAuctionListPage()
    PaGlobal_GuildHouse_Auction_All:updateHouseAuctionList()
  else
    PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:SetCheck(false)
    PaGlobal_GuildHouse_Auction_All._ui.btn_myBid:SetCheck(true)
    RequestBiddingPage()
    PaGlobal_GuildHouse_Auction_All:updateHouseBidList()
  end
  HandleEventLUp_GuildHouse_Auction_All_clickedTypeButton()
end
function HandleEventPadPress_GuildHouse_Auction_All_ToggleTab(value)
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  if false == PaGlobal_GuildHouse_Auction_All._isConsole then
    return
  end
  local tabMenuControl = {
    [0] = PaGlobal_GuildHouse_Auction_All._ui.btn_allBid,
    [1] = PaGlobal_GuildHouse_Auction_All._ui.btn_myBid
  }
  if #tabMenuControl ~= PaGlobal_GuildHouse_Auction_All._TABMENU.COUNT + 1 then
    _PA_ASSERT_NAME(false, "\235\169\148\235\137\180\236\151\144 \237\131\173\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 tabMenuControl \236\151\144\235\143\132 \236\182\148\234\176\128\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
  end
  PaGlobal_GuildHouse_Auction_All._currentMenu = PaGlobal_GuildHouse_Auction_All._currentMenu + value
  if 0 > PaGlobal_GuildHouse_Auction_All._currentMenu then
    PaGlobal_GuildHouse_Auction_All._currentMenu = PaGlobal_GuildHouse_Auction_All._TABMENU.COUNT
  elseif PaGlobal_GuildHouse_Auction_All._TABMENU.COUNT < PaGlobal_GuildHouse_Auction_All._currentMenu then
    PaGlobal_GuildHouse_Auction_All._currentMenu = 0
  end
  tabMenuControl[0]:SetCheck(false)
  tabMenuControl[1]:SetCheck(false)
  tabMenuControl[PaGlobal_GuildHouse_Auction_All._currentMenu]:SetCheck(true)
  Input_GuildHouse_Auction_All_ChangeType(PaGlobal_GuildHouse_Auction_All._currentMenu)
  if 0 == PaGlobal_GuildHouse_Auction_All._currentMenu then
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_bid:SetShow(true)
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_bid:SetText(PAGetString(Defines.StringSheet_RESOURCE, "AUCTION_BTN_BID"))
    PaGlobal_GuildHouse_Auction_All:alignKeyPad()
  end
end
function FromClient_GuildHouse_Auction_All_ReSizePanel()
  if false == PaGlobal_GuildHouse_Auction_All._isConsole then
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_close:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_question:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listLeft:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listRight:ComputePos()
  else
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_LT:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_RT:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_listLeft:ComputePos()
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_listRight:ComputePos()
  end
  PaGlobal_GuildHouse_Auction_All._ui.stc_title:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.stc_tapBg:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.btn_myBid:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.stc_selectBar:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.stc_subPage:ComputePos()
  PaGlobal_GuildHouse_Auction_All._ui.stc_subPageTitle:ComputePos()
end
function FromClient_GuildHouse_Auction_All_UpdateGuildHouseAuctionList()
  local myAuctionInfo = RequestGetAuctionInfo()
  local auctionType = myAuctionInfo:getAuctionType()
  local houseListCount = myAuctionInfo:getHouseAuctionListCount()
  local bidListCount = myAuctionInfo:getMyBidListCount()
  local houseMaxCount = houseListCount / 4 + 1
  if tonumber(string.sub(houseMaxCount, 1, 1)) == myAuctionInfo:getCurrentPage() + 1 then
    if false == PaGlobal_GuildHouse_Auction_All._isConsole then
      PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listRight:SetIgnore(true)
    else
      PaGlobal_GuildHouse_Auction_All._ui_console.btn_listRight:SetIgnore(true)
    end
  elseif false == PaGlobal_GuildHouse_Auction_All._isConsole then
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listRight:SetIgnore(false)
  else
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_listRight:SetIgnore(false)
  end
  if myAuctionInfo:getCurrentPage() + 1 == 1 then
    if false == PaGlobal_GuildHouse_Auction_All._isConsole then
      PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listLeft:SetIgnore(true)
    else
      PaGlobal_GuildHouse_Auction_All._ui_console.btn_listLeft:SetIgnore(true)
    end
  elseif false == PaGlobal_GuildHouse_Auction_All._isConsole then
    PaGlobal_GuildHouse_Auction_All._ui_pc.btn_listLeft:SetIgnore(false)
  else
    PaGlobal_GuildHouse_Auction_All._ui_console.btn_listLeft:SetIgnore(false)
  end
  if auctionType == 1 then
    if false == Panel_GuildHouse_Auction_All:GetShow() then
      if true == PaGlobal_GuildHouse_Auction_All._isConsole then
        if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
          PaGlobal_GuildHouse_Auction_All_Open()
        else
          UI.ASSERT(false, "UIMode \234\176\128 Dialog \234\176\128 \236\149\132\235\139\153\235\139\136\235\139\164.  Current Mode = " .. tostring(GetUIMode()))
          return
        end
      else
        PaGlobal_GuildHouse_Auction_All_Open()
      end
    end
    PaGlobal_GuildHouse_Auction_All:updateHouseAuctionList()
    PaGlobal_GuildHouse_Auction_All:updateHouseBidList()
  elseif auctionType == 14 then
    Panel_Villa_Auction:SetShow(true, true)
    FGlobal_VillaAuctionUpdate()
  elseif auctionType == 5 then
    PaGlobal_GuildHouse_Auction_All:updateHouseBidList()
  end
  local subPageTitle = myAuctionInfo:getCurrentPage() + 1 .. " / " .. myAuctionInfo:getMaxPage()
  if true == PaGlobal_GuildHouse_Auction_All._ui.btn_allBid:IsChecked() then
    PaGlobal_GuildHouse_Auction_All._ui.stc_subPageTitle:SetText(subPageTitle)
  else
    PaGlobal_GuildHouse_Auction_All._ui.stc_subPageTitle:SetText("1 / 1")
  end
end
function PaGloabl_GuildHouse_Auction_All_ShowAni()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
end
function PaGloabl_GuildHouse_Auction_All_HideAni()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
end
