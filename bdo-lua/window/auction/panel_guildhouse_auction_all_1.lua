function PaGlobal_GuildHouse_Auction_All:initialize()
  if true == PaGlobal_GuildHouse_Auction_All._initialize then
    return
  end
  PaGlobal_GuildHouse_Auction_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildHouse_Auction_All:controlAll_Init()
  PaGlobal_GuildHouse_Auction_All:controlPc_Init()
  PaGlobal_GuildHouse_Auction_All:controlConsole_Init()
  PaGlobal_GuildHouse_Auction_All:SetUiSetting()
  PaGlobal_GuildHouse_Auction_All:registEventHandler()
  PaGlobal_GuildHouse_Auction_All:validate()
  PaGlobal_GuildHouse_Auction_All._initialize = true
end
function PaGlobal_GuildHouse_Auction_All:controlAll_Init()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_GuildHouse_Auction_All, "StaticText_Title")
  self._ui.stc_tapBg = UI.getChildControl(Panel_GuildHouse_Auction_All, "Static_TabTypeBg")
  self._ui.btn_allBid = UI.getChildControl(self._ui.stc_tapBg, "Radiobutton_AllBidList")
  self._ui.btn_myBid = UI.getChildControl(self._ui.stc_tapBg, "Radiobutton_MyBidList")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_tapBg, "Static_SelectBar")
  self._ui.stc_subPage = UI.getChildControl(Panel_GuildHouse_Auction_All, "StaticText_SubPageTitle")
  self._ui.stc_noticeBg = UI.getChildControl(Panel_GuildHouse_Auction_All, "Static_BottomNoticeBG")
  self._ui.stc_autionGuide = UI.getChildControl(self._ui.stc_noticeBg, "StaticText_AutionGuide")
  self._ui.stc_frame = UI.getChildControl(UI.getChildControl(Panel_GuildHouse_Auction_All, "Frame_1_AuctionDesc"), "Frame_1_AuctionDesc_Content")
  self._ui.stc_subPageTitle = UI.getChildControl(Panel_GuildHouse_Auction_All, "StaticText_SubPageTitle")
end
function PaGlobal_GuildHouse_Auction_All:controlPc_Init()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Win_Close_PCUI")
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_title, "Button_Question_PCUI")
  self._ui_pc.btn_listLeft = UI.getChildControl(self._ui.stc_subPage, "Button_List_Left_PCUI")
  self._ui_pc.btn_listRight = UI.getChildControl(self._ui.stc_subPage, "Button_List_Right_PCUI")
end
function PaGlobal_GuildHouse_Auction_All:controlConsole_Init()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  self._ui_console.btn_LT = UI.getChildControl(self._ui.stc_tapBg, "Static_LT_ConsoleUI")
  self._ui_console.btn_RT = UI.getChildControl(self._ui.stc_tapBg, "Static_RT_ConsoleUI")
  self._ui_console.btn_listLeft = UI.getChildControl(self._ui.stc_subPage, "Button_List_Left_ConsoleUI")
  self._ui_console.btn_listRight = UI.getChildControl(self._ui.stc_subPage, "Button_List_Right_ConsoleUI")
  self._ui_console.stc_bottomBg = UI.getChildControl(Panel_GuildHouse_Auction_All, "Static_BottomBg_ConsoleUI")
  self._ui_console.btn_viewInfo = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_ViewInfo")
  self._ui_console.btn_close = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_Close")
  self._ui_console.btn_bid = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_Bid")
end
function PaGlobal_GuildHouse_Auction_All:SetUiSetting()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  local mainBg = UI.getChildControl(Panel_GuildHouse_Auction_All, "Static_MainBG")
  if false == self._isConsole then
    self._ui_console.btn_LT:SetShow(false)
    self._ui_console.btn_RT:SetShow(false)
    self._ui_console.btn_listLeft:SetShow(false)
    self._ui_console.btn_listRight:SetShow(false)
    self._ui_console.stc_bottomBg:SetShow(false)
    self._ui_console.btn_viewInfo:SetShow(false)
    self._ui_console.btn_close:SetShow(false)
    self._ui_console.btn_bid:SetShow(false)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_listLeft:SetShow(true)
    self._ui_pc.btn_listRight:SetShow(true)
    Panel_GuildHouse_Auction_All:SetSize(Panel_GuildHouse_Auction_All:GetSizeX(), self._sizeY.PC_PANEL)
    mainBg:SetSize(mainBg:GetSizeX(), self._sizeY.PC_BIDLISTBG)
  else
    self._ui_console.btn_LT:SetShow(true)
    self._ui_console.btn_RT:SetShow(true)
    self._ui_console.btn_listLeft:SetShow(true)
    self._ui_console.btn_listRight:SetShow(true)
    self._ui_console.stc_bottomBg:SetShow(true)
    self._ui_console.btn_viewInfo:SetShow(true)
    self._ui_console.btn_close:SetShow(true)
    self._ui_console.btn_bid:SetShow(true)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_listLeft:SetShow(false)
    self._ui_pc.btn_listRight:SetShow(false)
    Panel_GuildHouse_Auction_All:SetSize(Panel_GuildHouse_Auction_All:GetSizeX(), self._sizeY.CONSOLE_PANEL)
    mainBg:SetSize(mainBg:GetSizeX(), self._sizeY.CONSOLE_BIDLISTBG)
    self._ui.stc_noticeBg:SetPosY(self._ui.stc_noticeBg:GetPosY() - 30)
    Panel_GuildHouse_Auction_All:ComputePos()
    self._ui_console.stc_bottomBg:ComputePos()
    PaGlobal_GuildHouse_Auction_All:alignKeyPad()
  end
end
function PaGlobal_GuildHouse_Auction_All:alignKeyPad()
  if false == self._isConsole then
    return
  end
  local tempBtnGroup = {
    self._ui_console.btn_viewInfo,
    self._ui_console.btn_bid,
    self._ui_console.btn_close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildHouse_Auction_All:registEventHandler()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildHouse_Auction_All_ReSizePanel()")
  registerEvent("FromClient_ResponseAuction_UpdateAuctionList", "FromClient_GuildHouse_Auction_All_UpdateGuildHouseAuctionList()")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildHouse_Auction_All_Close()")
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"HouseAuction\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"HouseAuction\"")
    self._ui_pc.btn_listLeft:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildHouse_Auction_All_clickedPrevButton()")
    self._ui_pc.btn_listRight:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildHouse_Auction_All_clickedNextButton()")
    self._ui.btn_allBid:addInputEvent("Mouse_LUp", "Input_GuildHouse_Auction_All_ChangeType()")
    self._ui.btn_myBid:addInputEvent("Mouse_LUp", "Input_GuildHouse_Auction_All_ChangeType()")
  else
    Panel_GuildHouse_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_GuildHouse_Auction_All_ToggleTab( -1 )")
    Panel_GuildHouse_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_GuildHouse_Auction_All_ToggleTab( 1 )")
    Panel_GuildHouse_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLUp_GuildHouse_Auction_All_clickedPrevButton()")
    Panel_GuildHouse_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLUp_GuildHouse_Auction_All_clickedNextButton()")
  end
end
function PaGlobal_GuildHouse_Auction_All:prepareOpen()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  if true == self._isConsole and Defines.UIMode.eUIMode_NpcDialog ~= GetUIMode() then
    UI.ASSERT(false, "UIMode \234\176\128 Dialog \234\176\128 \236\149\132\235\139\153\235\139\136\235\139\164.  Current Mode = " .. tostring(GetUIMode()))
    return
  end
  self:setNoticeDesc()
  self._ui.btn_allBid:SetCheck(true)
  self._ui.btn_myBid:SetCheck(false)
  HandleEventLUp_GuildHouse_Auction_All_clickedTypeButton()
  PaGlobal_GuildHouse_Auction_All:open()
end
function PaGlobal_GuildHouse_Auction_All:open()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  Panel_GuildHouse_Auction_All:SetShow(true)
end
function PaGlobal_GuildHouse_Auction_All:prepareClose()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  PaGlobal_GuildHouse_Auction_All:close()
end
function PaGlobal_GuildHouse_Auction_All:close()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  Panel_GuildHouse_Auction_All:SetShow(false)
end
function PaGlobal_GuildHouse_Auction_All:update()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
end
function PaGlobal_GuildHouse_Auction_All:validate()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_GuildHouse_Auction_All:allValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_tapBg:isValidate()
  self._ui.btn_allBid:isValidate()
  self._ui.btn_myBid:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.stc_subPage:isValidate()
  self._ui.stc_subPageTitle:isValidate()
end
function PaGlobal_GuildHouse_Auction_All:pcValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_listLeft:isValidate()
  self._ui_pc.btn_listRight:isValidate()
end
function PaGlobal_GuildHouse_Auction_All:consoleValidate()
  self._ui_console.btn_LT:isValidate()
  self._ui_console.btn_RT:isValidate()
  self._ui_console.btn_listLeft:isValidate()
  self._ui_console.btn_listRight:isValidate()
  self._ui_console.stc_bottomBg:isValidate()
  self._ui_console.btn_viewInfo:isValidate()
  self._ui_console.btn_close:isValidate()
  self._ui_console.btn_bid:isValidate()
end
function PaGlobal_GuildHouse_Auction_All:updateHouseAuctionList()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  local pos = {
    _x = self._ui.stc_frame:GetPosX(),
    _y = self._ui.stc_frame:GetPosY() - 10,
    _moveX = 0,
    _moveY = 0
  }
  local size = {
    _x = self._ui.stc_frame:GetSizeX(),
    _y = self._ui.stc_frame:GetSizeY()
  }
  local myAuctionInfo = RequestGetAuctionInfo()
  local houseCount = myAuctionInfo:getHouseAuctionListCount()
  self._houseAuctionCnt = houseCount
  for index = 0, houseCount - 1 do
    if nil == self._houseAuctionList[index] then
      local control = self:createAuctionListControl(index, 0)
      self._houseAuctionList[index] = control
      local btn_get = UI.getChildControl(self._houseAuctionList[index], "Template_Button_Get")
      local btn_cancelGet = UI.getChildControl(self._houseAuctionList[index], "Template_Button_Get")
      if false == self._isConsole then
        btn_get:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildHouse_Auction_All_BidShowToggle(" .. index .. ")")
      else
        self._houseAuctionList[index]:SetSize(self._sizeY.CONSOLE_BIDLIST)
        btn_get:SetShow(false)
        btn_cancelGet:SetShow(false)
      end
    end
    if 0 == index % 2 then
      pos._moveX = 0
    else
      pos._moveX = pos._x + size._x
    end
    pos._moveY = pos._y + math.floor(index / 2) * size._y
    self._houseAuctionList[index]:SetPosX(pos._moveX)
    self._houseAuctionList[index]:SetPosY(pos._moveY)
    self:updeteAuctionInfo(index)
  end
  HandleEventLUp_GuildHouse_Auction_All_clickedTypeButton()
end
function PaGlobal_GuildHouse_Auction_All:createAuctionListControl(idx, tabType)
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  UI.ASSERT_NAME(nil ~= idx, "PaGlobal_GuildHouse_Auction_All:createAuctionListControl\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= tabType, "PaGlobal_GuildHouse_Auction_All:createAuctionListControl\236\157\152 tabType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local control
  control = UI.cloneControl(self._ui.stc_frame, UI.getChildControl(Panel_GuildHouse_Auction_All, "Frame_1_AuctionDesc"), "Frame_" .. tabType .. "AuctionDesc" .. idx)
  local controlBg = UI.getChildControl(control, "Template_Style_BG")
  ToClient_padSnapRefreshTarget(controlBg)
  local detailButton = UI.getChildControl(control, "Template_Button_Detail")
  if false == self._isConsole then
    detailButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildHouse_Auction_All_DetailShowToggle(" .. idx .. "," .. tabType .. ")")
  else
    controlBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildHouse_Auction_All_clickedListButton(" .. idx .. "," .. tabType .. ")")
    controlBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildHouse_Auction_All_clickedBidButton(" .. idx .. ")")
    detailButton:SetHorizonCenter()
    detailButton:SetSpanSize(0, detailButton:GetSpanSize().y)
  end
  control:SetShow(true)
  return control
end
function PaGlobal_GuildHouse_Auction_All:updeteAuctionInfo(idx)
  local myAuctionInfo = RequestGetAuctionInfo()
  local houseAuctionInfo = myAuctionInfo:getHouseAuctionListAt(idx)
  if nil == myAuctionInfo or nil == houseAuctionInfo then
    return
  end
  local uiControl = {
    _displaytime = UI.getChildControl(self._houseAuctionList[idx], "Template_StaticText_Time"),
    _displaytimeIcon = UI.getChildControl(self._houseAuctionList[idx], "Template_Static_TimeIcon"),
    _btn_get = UI.getChildControl(self._houseAuctionList[idx], "Template_Button_Get"),
    _btn_cancelGet = UI.getChildControl(self._houseAuctionList[idx], "Template_Button_Get"),
    _name = UI.getChildControl(self._houseAuctionList[idx], "Template_StaticText_Name"),
    _area = UI.getChildControl(self._houseAuctionList[idx], "Template_StaticText_Area"),
    _specialService = UI.getChildControl(self._houseAuctionList[idx], "Template_StaticText_SpecialService"),
    _aucPrice = UI.getChildControl(self._houseAuctionList[idx], "Template_StaticText_AucPrice")
  }
  local time = self:auctionDisplayTime(houseAuctionInfo:getExpireTime_u64())
  uiControl._name:SetText(houseAuctionInfo:getGoodsName())
  uiControl._name:SetSize(uiControl._name:GetTextSizeX() + 5, uiControl._name:GetSizeY())
  uiControl._displaytimeIcon:SetSpanSize(uiControl._name:GetSpanSize().x + uiControl._name:GetSizeX() + 10, uiControl._displaytimeIcon:GetSpanSize().y)
  uiControl._displaytime:SetText(time)
  uiControl._displaytime:SetSpanSize(uiControl._displaytimeIcon:GetSpanSize().x + uiControl._displaytimeIcon:GetSizeX() + 5, uiControl._displaytime:GetSpanSize().y)
  uiControl._displaytime:ComputePos()
  uiControl._area:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_AREA") .. " " .. tostring(Uint64toUint32(houseAuctionInfo:getGoodsArea())))
  local featureText = houseAuctionInfo:getGoodsFeature1() .. " " .. houseAuctionInfo:getGoodsFeature2()
  uiControl._specialService:SetTextMode(__eTextMode_AutoWrap)
  uiControl._specialService:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_SPECIAL") .. " " .. featureText)
  if uiControl._specialService:GetTextSizeY() >= uiControl._specialService:GetSizeY() then
    uiControl._specialService:SetTextMode(__eTextMode_Limit_AutoWrap)
    uiControl._specialService:setLineCountByLimitAutoWrap(5)
    uiControl._specialService:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_SPECIAL") .. " " .. featureText)
  end
  uiControl._aucPrice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDHOUSE_AUCTION_LOWPRICE") .. makeDotMoney(houseAuctionInfo:getPrice_s64()))
end
function PaGlobal_GuildHouse_Auction_All:updateHouseBidList()
  if nil == Panel_GuildHouse_Auction_All then
    return
  end
  local pos = {
    _x = self._ui.stc_frame:GetPosX(),
    _y = self._ui.stc_frame:GetPosY() - 10,
    _moveX = 0,
    _moveY = 0
  }
  local size = {
    _x = self._ui.stc_frame:GetSizeX(),
    _y = self._ui.stc_frame:GetSizeY()
  }
  local myAuctionInfo = RequestGetAuctionInfo()
  local bidCount = myAuctionInfo:getMyBidListCount()
  self._houseBidCnt = bidCount
  for index = 0, bidCount - 1 do
    if nil == self._houseMyBidList[index] then
      local control = self:createAuctionListControl(index, 1)
      self._houseMyBidList[index] = control
      local btn_get = UI.getChildControl(self._houseMyBidList[index], "Template_Button_Get")
      local btn_cancelGet = UI.getChildControl(self._houseMyBidList[index], "Template_Button_Get")
      if false == self._isConsole then
        btn_cancelGet:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildHouse_Auction_All_clickedCancelButton(" .. index .. ")")
      else
        self._houseMyBidList[index]:SetSize(self._sizeY.CONSOLE_BIDLIST)
        btn_get:SetShow(false)
        btn_cancelGet:SetShow(false)
      end
    end
    if 0 == index % 2 then
      pos._moveX = 0
    else
      pos._moveX = pos._x + size._x
    end
    pos._moveY = pos._y + math.floor(index / 2) * size._y
    self._houseMyBidList[index]:SetPosX(pos._moveX)
    self._houseMyBidList[index]:SetPosY(pos._moveY)
    self:updeteBidInfo(index)
  end
  HandleEventLUp_GuildHouse_Auction_All_clickedTypeButton()
end
function PaGlobal_GuildHouse_Auction_All:updeteBidInfo(idx)
  local myAuctionInfo = RequestGetAuctionInfo()
  local houseBidInfo = myAuctionInfo:getMyBidListAt(idx)
  if nil == myAuctionInfo or nil == houseBidInfo then
    return
  end
  local upperBidPrice = houseBidInfo:getUpperBidPrice_s64()
  local myBidPrice = houseBidInfo:getMyBidPrice_s64()
  local uiControl = {
    _displaytime = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_Time"),
    _displaytimeIcon = UI.getChildControl(self._houseMyBidList[idx], "Template_Static_TimeIcon"),
    _btn_get = UI.getChildControl(self._houseMyBidList[idx], "Template_Button_Get"),
    _btn_cancelGet = UI.getChildControl(self._houseMyBidList[idx], "Template_Button_Get"),
    _name = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_Name"),
    _area = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_Area"),
    _specialService = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_SpecialService"),
    _aucPrice = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_AucPrice"),
    _remainCount = UI.getChildControl(self._houseMyBidList[idx], "Template_StaticText_RemainCount")
  }
  uiControl._btn_cancelGet:SetShow(false)
  local bidCancelControl = UI.getChildControl(self._houseMyBidList[idx], "Template_Style_BG")
  if houseBidInfo:isAuctionEnd() then
    if false == self._isConsole then
      uiControl._btn_cancelGet:SetShow(true)
      uiControl._btn_cancelGet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_RETURNMONEY"))
    else
      self._ui_console.btn_bid:SetShow(true)
      self._ui_console.btn_bid:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_RETURNMONEY"))
      bidCancelControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildHouse_Auction_All_clickedCancelButton(" .. idx .. ")")
    end
  elseif upperBidPrice <= myBidPrice then
    if false == self._isConsole then
      uiControl._btn_cancelGet:SetShow(false)
    else
      self._ui_console.btn_bid:SetShow(false)
      bidCancelControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  elseif false == self._isConsole then
    uiControl._btn_cancelGet:SetShow(true)
    uiControl._btn_cancelGet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_RETURNMONEY"))
  else
    self._ui_console.btn_bid:SetShow(true)
    self._ui_console.btn_bid:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_RETURNMONEY"))
    bidCancelControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildHouse_Auction_All_clickedCancelButton(" .. idx .. ")")
  end
  PaGlobal_GuildHouse_Auction_All:alignKeyPad()
  local time = self:auctionDisplayTime(houseBidInfo:getExpireTime_u64())
  uiControl._name:SetText(houseBidInfo:getGoodsName())
  uiControl._name:SetSize(uiControl._name:GetTextSizeX() + 5, uiControl._name:GetSizeY())
  uiControl._displaytimeIcon:SetSpanSize(uiControl._name:GetSpanSize().x + uiControl._name:GetSizeX() + 10, uiControl._displaytimeIcon:GetSpanSize().y)
  uiControl._displaytime:SetText(time)
  uiControl._displaytime:SetSpanSize(uiControl._displaytimeIcon:GetSpanSize().x + uiControl._displaytimeIcon:GetSizeX() + 5, uiControl._displaytime:GetSpanSize().y)
  uiControl._displaytime:ComputePos()
  uiControl._area:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_AREA") .. " " .. tostring(Uint64toUint32(houseBidInfo:getGoodsArea())))
  local featureText = houseBidInfo:getGoodsFeature1() .. houseBidInfo:getGoodsFeature2()
  uiControl._specialService:SetTextMode(__eTextMode_AutoWrap)
  uiControl._specialService:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_SPECIAL") .. " " .. featureText)
  if uiControl._specialService:GetTextSizeY() >= uiControl._specialService:GetSizeY() then
    uiControl._specialService:SetTextMode(__eTextMode_Limit_AutoWrap)
    uiControl._specialService:setLineCountByLimitAutoWrap(4)
    uiControl._specialService:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_SPECIAL") .. " " .. featureText)
  end
  uiControl._aucPrice:SetPosY(uiControl._specialService:GetPosY() + uiControl._specialService:GetTextSizeY() + 3)
  uiControl._aucPrice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_BIDPRICE") .. makeDotMoney(houseBidInfo:getMyBidPrice_s64()))
  uiControl._remainCount:SetShow(true)
  uiControl._remainCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDHOUSE_AUCTION_REMAININGCOUNT", "getRemainBidCount", tostring(houseBidInfo:getRemainBidCount())))
end
function PaGlobal_GuildHouse_Auction_All:auctionDisplayTime(timeValue)
  UI.ASSERT_NAME(nil ~= timeValue, "PaGlobal_GuildHouse_Auction_All:auctionDisplayTime\236\157\152 timeValue nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  timeValue = timeValue / toUint64(0, 1000)
  if timeValue > toUint64(0, 3600) then
    timeValue = timeValue / toUint64(0, 3600)
    return tostring(timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif timeValue > toUint64(0, 120) then
    timeValue = timeValue / toUint64(0, 60)
    return tostring(timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif timeValue > toUint64(0, 0) then
    return PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_HOUSE_DEADLINE")
  else
    return PAGetString(Defines.StringSheet_GAME, "LUA_HOUSEAUCTION_CLOSEAUCTION")
  end
end
function PaGlobal_GuildHouse_Auction_All:setNoticeDesc()
  self._ui.stc_autionGuide:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_autionGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDHOUSE_AUCTION_DESC"))
  local descTextSizeY = self._ui.stc_autionGuide:GetTextSizeY()
  if descTextSizeY > self._ui.stc_noticeBg:GetSizeY() then
    local sizeY = descTextSizeY - self._ui.stc_noticeBg:GetSizeY()
    self._ui.stc_noticeBg:SetSize(self._ui.stc_noticeBg:GetSizeX(), self._ui.stc_noticeBg:GetSizeY() + sizeY)
    Panel_GuildHouse_Auction_All:SetSize(Panel_GuildHouse_Auction_All:GetSizeX(), Panel_GuildHouse_Auction_All:GetSizeY() + sizeY)
  end
  FromClient_GuildHouse_Auction_All_ReSizePanel()
end
