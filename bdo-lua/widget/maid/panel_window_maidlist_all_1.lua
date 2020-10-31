local TAB_TYPE = {
  ALL = 1,
  STORAGE = 2,
  MARKETPLACE = 3,
  MARKET = 4
}
function PaGlobal_MaidList_All:initialize()
  if true == PaGlobal_MaidList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self._ui.list2_maid:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_MaidList_All_ListControlCreate")
  self._ui.list2_maid:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    Panel_MyHouseNavi_Update(true)
    self:LogInMaidShow()
  end
  self:resize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MaidList_All:controlAll_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._panelOriginSizeY = Panel_Window_MaidList_All:GetSizeY()
  self._ui.stc_title = UI.getChildControl(Panel_Window_MaidList_All, "Static_MainTitleBar")
  self._ui.txt_noMaidFound = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_NoMaidFound")
  self._ui.txt_maidCount = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_LeftMaidCount")
  self._ui.txt_maidCountValue = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_LeftMaidCountValue")
  self._ui.list2_maid = UI.getChildControl(Panel_Window_MaidList_All, "List2_Maid")
  self._ui.stc_tabBar = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBtmBar")
  self._ui.stc_tabBar:SetShow(true)
end
function PaGlobal_MaidList_All:controlPc_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close_PCUI")
  self._ui_pc.stc_tabBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBg_PCUI")
  self._ui_pc.btn_radios[TAB_TYPE.ALL] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_All")
  self._ui_pc.btn_radios[TAB_TYPE.STORAGE] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Warehouse")
  if true == _ContentsGroup_ItemMarketKor2 then
    self._ui_pc.btn_radios[TAB_TYPE.MARKETPLACE] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Itemmarket")
  end
  UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Itemmarket"):SetShow(_ContentsGroup_ItemMarketKor2)
  self._ui_pc.btn_warehouse = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_Warehouse_PCUI")
  self._ui_pc.btn_market = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_Market_PCUI")
  self._ui_pc.btn_marketPlace = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_MarketPlace_PCUI")
  self._ui_pc.btn_pcRoom = UI.getChildControl(Panel_Window_MaidList_All, "Button_PCRoomRegist_PCUI")
  self._ui_pc.btn_ScaleResize = UI.getChildControl(Panel_Window_MaidList_All, "Button_ScaleResize")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LDown", "HandleEventLDown_MaidList_All_ScaleResizeStart()")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LPress", "HandleEventLPress_MaidList_All_ScaleResizing()")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ScaleResizeEnd()")
  self._ui_pc.btn_ScaleResize:SetShow(true)
  self._ui_pc.btn_ScaleResize:SetChildIndex(Panel_Window_MaidList_All, 9999)
  self._ui_pc.btn_warehouse:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_warehouse:SetText(self._ui_pc.btn_warehouse:GetText())
  self._ui_pc.btn_market:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_market:SetText(self._ui_pc.btn_market:GetText())
  self._ui_pc.btn_marketPlace:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_marketPlace:SetText(self._ui_pc.btn_marketPlace:GetText())
  self._ui_pc.btn_pcRoom:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_pcRoom:SetText(self._ui_pc.btn_pcRoom:GetText())
end
Panel_Window_MaidList_All:setDynamicScalePanelIndex(__eDynamicScalePanel_MaidList)
function PaGlobal_MaidList_All:controlConsole_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui_console.stc_tabBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBg_ConsoleUI")
  self._ui_console.rdo_tabs[TAB_TYPE.ALL] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_All")
  self._ui_console.rdo_tabs[TAB_TYPE.STORAGE] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_Warehouse")
  self._ui_console.rdo_tabs[TAB_TYPE.MARKETPLACE] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_Itemmarket")
  self._ui_console.stc_keyGuideLB = UI.getChildControl(self._ui_console.stc_tabBg, "StaticText_KeyGuideLB")
  self._ui_console.stc_keyGuideRB = UI.getChildControl(self._ui_console.stc_tabBg, "StaticText_KeyGuideRB")
  self._ui_console.stc_keyGuideAreaBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_KeyGuideArea_ConsoleUI")
  self._ui_console.stc_guideIconA = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_Market_ConsoleUI")
  self._ui_console.stc_guideIconY = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_Warehouse_ConsoleUI")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_Close_ConsoleUI")
  self._ui_console.stc_guideIconRS = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "Button_Scroll")
  self._ui_console.rdo_tabs[TAB_TYPE.ALL]:SetTextMode(__eTextMode_AutoWrap)
  self._ui_console.rdo_tabs[TAB_TYPE.STORAGE]:SetTextMode(__eTextMode_AutoWrap)
  self._ui_console.rdo_tabs[TAB_TYPE.MARKETPLACE]:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_MaidList_All:controlSetShow()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.stc_tabBg:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_warehouse:SetShow(true)
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      self._ui_pc.btn_market:SetShow(false)
      self._ui_pc.btn_marketPlace:SetShow(true)
    else
      self._ui_pc.btn_market:SetShow(true)
      self._ui_pc.btn_marketPlace:SetShow(false)
    end
    self._ui_pc.btn_marketPlace:SetShow(_ContentsGroup_ItemMarketKor2)
    if true == _ContentsGroup_KR_Transfer and true == ToClient_isShowRegistPcRoomMaidButton() then
      self._ui_pc.btn_pcRoom:SetShow(true)
    else
      self._ui_pc.btn_pcRoom:SetShow(false)
    end
    self._ui_console.stc_tabBg:SetShow(false)
    self._ui_console.stc_keyGuideAreaBg:SetShow(false)
  else
    self._ui_pc.stc_tabBg:SetShow(false)
    self._ui_console.stc_tabBg:SetShow(true)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(false)
    self._ui_pc.btn_pcRoom:SetShow(false)
    self._ui_pc.btn_ScaleResize:SetShow(false)
    self._ui_console.stc_keyGuideAreaBg:SetShow(true)
  end
end
function PaGlobal_MaidList_All:resize()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil ~= self._panelOpenPosX and nil ~= self._panelOpenPosY then
    Panel_Window_MaidList_All:SetPosXY(self._panelOpenPosX, self._panelOpenPosY)
  end
  self._ui_pc.btn_warehouse:ComputePos()
  self._ui_pc.btn_market:ComputePos()
  self._ui_pc.btn_marketPlace:ComputePos()
  self._ui_pc.btn_pcRoom:ComputePos()
  self._ui.txt_maidCountValue:ComputePos()
  Panel_Window_MaidList_All:ComputePos()
  if false == self._isConsole then
    local panelPosX = Panel_Widget_ServantIcon:GetPosX() + 250
    local panelPosY = Panel_Widget_ServantIcon:GetPosY() + Panel_Widget_ServantIcon:GetSizeY() + 10
    if getScreenSizeX() < panelPosX + Panel_Window_MaidList_All:GetSizeX() then
      panelPosX = getScreenSizeX() - Panel_Window_MaidList_All:GetSizeX() - 10
    end
    if getScreenSizeY() < panelPosY + Panel_Window_MaidList_All:GetSizeY() then
      panelPosY = Panel_Widget_ServantIcon:GetPosY() - Panel_Window_MaidList_All:GetSizeY() - 10
    end
    Panel_Window_MaidList_All:SetPosXY(panelPosX, panelPosY)
  else
    Panel_Window_MaidList_All:SetSize(Panel_Window_MaidList_All:GetSizeX(), self._panelOriginSizeY - self._ui_pc.btn_warehouse:GetSizeY() - 10)
    self:consoleKeyGuideSet(true, true)
    local gapX = (getOriginScreenSizeX() - getScreenSizeX()) * 0.5
    local gapY = (getOriginScreenSizeY() - getScreenSizeY()) * 0.5
    Panel_Window_MaidList_All:SetPosX(Panel_Window_MaidList_All:GetPosX() + gapX)
    Panel_Window_MaidList_All:SetPosY(Panel_Window_MaidList_All:GetPosY() + gapY)
  end
end
function PaGlobal_MaidList_All:consoleKeyGuideSet(showMarket, showStorage)
  if false == self._isConsole then
    return
  end
  self._ui_console.stc_guideIconA:SetShow(showMarket)
  self._ui_console.stc_guideIconY:SetShow(showStorage)
  self._ui_console.stc_guideIconB:SetShow(true)
  if true == showMarket then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.MARKETPLACE .. ")")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  if true == showStorage then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.STORAGE .. ")")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  local tempBtnGroup = {
    self._ui_console.stc_guideIconRS,
    self._ui_console.stc_guideIconA,
    self._ui_console.stc_guideIconY,
    self._ui_console.stc_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_keyGuideAreaBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui_console.stc_keyGuideAreaBg:ComputePos()
end
function PaGlobal_MaidList_All:registEventHandler()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_Close()")
    self._ui_pc.btn_radios[TAB_TYPE.ALL]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. TAB_TYPE.ALL .. ")")
    self._ui_pc.btn_radios[TAB_TYPE.STORAGE]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. TAB_TYPE.STORAGE .. ")")
    if nil ~= self._ui_pc.btn_radios[TAB_TYPE.MARKETPLACE] then
      self._ui_pc.btn_radios[TAB_TYPE.MARKETPLACE]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. TAB_TYPE.MARKETPLACE .. ")")
    end
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.STORAGE .. ")")
    self._ui_pc.btn_market:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.MARKET .. ")")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.MARKETPLACE .. ")")
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 0 .. " )")
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 0 .. " )")
    self._ui_pc.btn_market:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 1 .. " )")
    self._ui_pc.btn_market:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 1 .. " )")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 2 .. " )")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 2 .. " )")
    if true == _ContentsGroup_Maid then
      self._ui_pc.btn_warehouse:setButtonShortcuts("PANEL_MAIDLIST_OPEN_WAREHOUSE")
      if true == _ContentsGroup_RenewUI_ItemMarketPlace then
        self._ui_pc.btn_marketPlace:setButtonShortcuts("PANEL_MAIDLIST_OPEN_MARKETPLACE")
      else
        self._ui_pc.btn_market:setButtonShortcuts("PANEL_MAIDLIST_OPEN_ITEMMARKET")
      end
    end
    if true == _ContentsGroup_KR_Transfer then
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ClickPcRoomBtn()")
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 3 .. " )")
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 3 .. " )")
    end
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PadEventRBLB_PaGlobal_MaidList_All_NextTab(-1)")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PadEventRBLB_PaGlobal_MaidList_All_NextTab(1)")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.MARKETPLACE .. ")")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MaidList_All_SelectMaid(" .. TAB_TYPE.STORAGE .. ")")
  end
  Panel_Window_MaidList_All:RegisterUpdateFunc("PaGlobalFunc_MaidList_All_UpdatePerFrame")
  registerEvent("onScreenResize", "onScreenResize_MaidList_All_Resize")
  registerEvent("FromClient_RefreshMaidList", "FromClient_RefreshMaidList_MaidList_All")
  registerEvent("FromClient_RefreshPcRoomState", "FromClient_MaidList_All_RefreshPcRoomState")
end
function PaGlobal_MaidList_All:prepareOpen()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if false == _ContentsGroup_NewUI_Maid_All then
    return
  end
  if true == _ContentsGroup_ForceShowWidgetIcon then
    local maidCount = getTotalMaidList()
    if (false == getTemporaryInformationWrapper():isPremiumPcRoom() or false == _ContentsGroup_KR_Transfer) and maidCount <= 0 then
      Panel_WebHelper_ShowToggle("Maid")
      return
    end
  end
  self:setTabTo(self._currentTab)
  self:open()
end
function PaGlobal_MaidList_All:open()
  if nil == Panel_Window_MaidList_All then
    return
  end
  Panel_Window_MaidList_All:SetShow(true)
end
function PaGlobal_MaidList_All:prepareClose()
  if nil == Panel_Window_MaidList_All then
    return
  end
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_MaidList_All:close()
  if nil == Panel_Window_MaidList_All then
    return
  end
  Panel_Window_MaidList_All:ClearUpdateLuaFunc()
  Panel_Window_MaidList_All:SetShow(false)
end
function PaGlobal_MaidList_All:validate()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.txt_noMaidFound:isValidate()
  self._ui.txt_maidCount:isValidate()
  self._ui.txt_maidCountValue:isValidate()
  self._ui.list2_maid:isValidate()
  if false == self._isConsole then
    self._ui_pc.btn_close:isValidate()
    self._ui_pc.stc_tabBg:isValidate()
    self._ui_pc.btn_radios[TAB_TYPE.ALL]:isValidate()
    self._ui_pc.btn_radios[TAB_TYPE.STORAGE]:isValidate()
    if nil ~= self._ui_pc.btn_radios[TAB_TYPE.MARKETPLACE] then
      self._ui_pc.btn_radios[TAB_TYPE.MARKETPLACE]:isValidate()
    end
    self._ui_pc.btn_warehouse:isValidate()
    self._ui_pc.btn_market:isValidate()
    self._ui_pc.btn_marketPlace:isValidate()
    self._ui_pc.btn_pcRoom:isValidate()
  else
    self._ui_console.stc_tabBg:isValidate()
    self._ui_console.rdo_tabs[TAB_TYPE.ALL]:isValidate()
    self._ui_console.rdo_tabs[TAB_TYPE.STORAGE]:isValidate()
    self._ui_console.rdo_tabs[TAB_TYPE.MARKETPLACE]:isValidate()
    self._ui_console.stc_keyGuideLB:isValidate()
    self._ui_console.stc_keyGuideRB:isValidate()
    self._ui_console.stc_keyGuideAreaBg:isValidate()
    self._ui_console.stc_guideIconA:isValidate()
    self._ui_console.stc_guideIconY:isValidate()
    self._ui_console.stc_guideIconB:isValidate()
    self._ui_console.stc_guideIconRS:isValidate()
  end
end
function PaGlobalFunc_MaidList_All_ListControlCreate(control, key)
  if nil == Panel_Window_MaidList_All then
    return
  end
  local btn = UI.getChildControl(control, "Button_ListObject")
  local txt_name = UI.getChildControl(btn, "StaticText_Name")
  local txt_type = UI.getChildControl(btn, "StaticText_Func")
  local txt_cool = UI.getChildControl(btn, "StaticText_Cooltime")
  local key32 = Int64toInt32(key)
  local functionText = {
    [TAB_TYPE.STORAGE] = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_WAREHOUSE"),
    [TAB_TYPE.MARKETPLACE] = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_MARKET")
  }
  btn:SetIgnore(true)
  txt_name:SetText(PaGlobal_MaidList_All._maidData[key32].name)
  txt_type:SetText(functionText[PaGlobal_MaidList_All._maidData[key32].func])
  local oneMinute = 60
  local coolTime = PaGlobal_MaidList_All._maidData[key32].cool
  if 0 == coolTime then
    txt_cool:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_POSSIBLE"))
    txt_cool:SetFontColor(Defines.Color.C_FFDDC39E)
    txt_name:SetFontColor(Defines.Color.C_FFDDC39E)
    txt_type:SetFontColor(Defines.Color.C_FFDDC39E)
  elseif oneMinute > coolTime then
    txt_cool:SetFontColor(Defines.Color.C_FF9397A7)
    txt_name:SetFontColor(Defines.Color.C_FF9397A7)
    txt_type:SetFontColor(Defines.Color.C_FF9397A7)
    txt_cool:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_ONEMINUTELEFT"))
  else
    txt_cool:SetFontColor(Defines.Color.C_FF585453)
    txt_name:SetFontColor(Defines.Color.C_FF585453)
    txt_type:SetFontColor(Defines.Color.C_FF585453)
    txt_cool:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIDLIST_LEFTTIME", "minute", coolTime / oneMinute - coolTime / oneMinute % 1))
  end
end
function PaGlobal_MaidList_All:LogInMaidShow()
  if 6 < getSelfPlayer():get():getLevel() and 0 < getTotalMaidList() then
    ToClient_CallHandlerMaid("_StrAllmaidLogOut")
    local randomMaidIndex = math.random(getTotalMaidList()) - 1
    local maidInfoWrapper = getMaidDataByIndex(randomMaidIndex)
    if nil ~= maidInfoWrapper then
      local aiVariable = 2
      local maidNo = maidInfoWrapper:getMaidNo()
      ToClient_SummonMaid(maidNo, aiVariable)
    end
  end
end
function PaGlobal_MaidList_All:setTabTo(tabIndex)
  if nil == Panel_Window_MaidList_All then
    return
  end
  local radios
  if false == self._isConsole then
    radios = self._ui_pc.btn_radios
  else
    radios = self._ui_console.rdo_tabs
  end
  for ii = 1, #radios do
    radios[ii]:SetCheck(false)
    radios[ii]:SetFontColor(Defines.Color.C_FF585453)
    radios[ii]:SetPosX(self._ui_pc.stc_tabBg:GetPosX() + self._ui_pc.stc_tabBg:GetSizeX() / (#radios + 1) * ii - radios[ii]:GetSizeX() / 2)
  end
  radios[tabIndex]:SetCheck(true)
  radios[tabIndex]:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.stc_tabBar:SetPosX(radios[tabIndex]:GetPosX() + radios[tabIndex]:GetSizeX() / 2 - self._ui.stc_tabBar:GetSizeX() / 2)
  self._currentTab = tabIndex
  self:updateData(self._currentTab)
  self:pushDataToList()
  if true == self._isConsole then
    local scroll = self._ui.list2_maid:GetVScroll()
    if nil ~= scroll and true == scroll:GetShow() then
      self._ui_console.stc_guideIconRS:SetShow(true)
    else
      self._ui_console.stc_guideIconRS:SetShow(false)
    end
  end
  if TAB_TYPE.STORAGE == self._currentTab then
    self:consoleKeyGuideSet(false, true)
  elseif TAB_TYPE.MARKETPLACE == self._currentTab then
    self:consoleKeyGuideSet(true, false)
  else
    self:consoleKeyGuideSet(true, true)
  end
end
function PaGlobal_MaidList_All:updateData(tab)
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._maidData = {}
  local maidCount = getTotalMaidList()
  if maidCount < 1 then
    self._ui.txt_maidCountValue:SetText("0")
    self._ui.txt_noMaidFound:SetShow(true)
    return
  else
    self._ui.txt_noMaidFound:SetShow(false)
  end
  local availableMaidCount = 0
  for ii = 1, maidCount do
    local maidInfoWrapper = getMaidDataByIndex(ii - 1)
    if nil ~= maidInfoWrapper then
      local data = {
        name = maidInfoWrapper:getName(),
        cool = maidInfoWrapper:getCoolTime()
      }
      if maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse() then
        data.func = TAB_TYPE.STORAGE
      elseif maidInfoWrapper:isAbleSubmitMarket() then
        data.func = TAB_TYPE.MARKETPLACE
      end
      local index = #self._maidData + 1
      if tab == TAB_TYPE.STORAGE and data.func == TAB_TYPE.STORAGE then
        self._maidData[index] = data
      elseif tab == TAB_TYPE.MARKETPLACE and data.func == TAB_TYPE.MARKETPLACE then
        self._maidData[index] = data
      elseif tab == TAB_TYPE.MARKET and data.func == TAB_TYPE.MARKET then
        self._maidData[index] = data
      elseif tab == TAB_TYPE.ALL then
        self._maidData[index] = data
      end
      if nil ~= self._maidData[index] and 0 == self._maidData[index].cool then
        availableMaidCount = availableMaidCount + 1
      end
      self:updateBtnPosition(tab)
    end
  end
  self._ui.txt_maidCountValue:SetText(availableMaidCount)
end
function PaGlobal_MaidList_All:updateBtnPosition(tab)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if true == self._isConsole then
    return
  end
  local btn_warehouseSpanX = 1
  if tab == TAB_TYPE.ALL then
    self._ui_pc.btn_market:SetSpanSize(15, 15)
    self._ui_pc.btn_warehouse:SetShow(true)
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      self._ui_pc.btn_market:SetShow(false)
      self._ui_pc.btn_marketPlace:SetShow(true)
    else
      self._ui_pc.btn_market:SetShow(true)
      self._ui_pc.btn_marketPlace:SetShow(false)
    end
    self._ui_pc.btn_marketPlace:SetShow(_ContentsGroup_ItemMarketKor2)
  elseif tab == TAB_TYPE.STORAGE then
    self._ui_pc.btn_warehouse:SetShow(true)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(false)
  elseif tab == TAB_TYPE.MARKETPLACE then
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(true)
  elseif tab == TAB_TYPE.MARKET then
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_market:SetSpanSize(15, 15)
    self._ui_pc.btn_market:SetShow(true)
    self._ui_pc.btn_marketPlace:SetShow(false)
  end
end
function PaGlobal_MaidList_All:pushDataToList()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui.list2_maid:getElementManager():clearKey()
  for ii = 1, #self._maidData do
    self._ui.list2_maid:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobalFunc_MaidList_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_MaidList_All then
    return
  end
  local elapsedTime = 0
  local updateInterval = 1
  elapsedTime = elapsedTime + deltaTime
  if updateInterval < elapsedTime then
    elapsedTime = 0
    PaGlobal_MaidList_All:updateData(PaGlobal_MaidList_All._currentTab)
    PaGlobal_MaidList_All._ui.list2_maid:requestUpdateVisible()
  end
end
function PaGlobalFunc_MaidList_All_SelectMaid(key32)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == key32 then
    _PA_ASSERT_NAME(false, "PaGlobalFunc_MaidList_All_SelectMaid: key32\236\157\180 nil\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    _PA_ASSERT_NAME(false, "PaGlobalFunc_MaidList_All_SelectMaid: selfProxy nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local dontGoMaid = -1
  local maidType = -1
  local isFreeBattle = selfProxy:get():isBattleGroundDefine()
  local isArshaJoin = ToClient_IsMyselfInArena()
  local localWarTeam = ToClient_GetMyTeamNoLocalWar()
  local isSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
  local isSavageDefence = ToClient_getPlayNowSavageDefence()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  if 0 ~= localWarTeam then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_LOCALWAR"))
    return
  end
  if isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_FREEBATTLE"))
    return
  end
  if isArshaJoin then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_ARSHA"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_HORSERACE"))
    return
  end
  if isSpecialCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  if isSavageDefence then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayingSavageDefence"))
    return
  end
  if isGuildBattle then
    if true == ToClient_isPersonalBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_PERSONALBATTLE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_GUILDBATTLE"))
    end
    return
  end
  local warehouseInMaid = checkMaid_WarehouseIn(true)
  local marketMaid = checkMaid_SubmitMarket(true)
  local enableWarehouseMaid = checkMaid_WarehouseIn(false)
  local enableMarketMaid = checkMaid_SubmitMarket(false)
  if TAB_TYPE.MARKETPLACE == key32 then
    if marketMaid then
      PaGlobalFunc_MarketPlace_OpenByMaid()
      if ToClient_CheckExistSummonMaid() and -1 ~= dontGoMaid then
        if 0 == maidType then
          ToClient_CallHandlerMaid("_marketMaid")
        else
          for mIndex = 0, getTotalMaidList() - 1 do
            local maidInfoWrapper = getMaidDataByIndex(mIndex)
            if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
              ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
              ToClient_CallHandlerMaid("_warehouseMaidLogOut")
              ToClient_CallHandlerMaid("_marketMaid")
              dontGoMaid = mIndex
              PaGlobal_MaidList_All:prepareClose()
              maidType = 0
              break
            end
          end
        end
        PaGlobal_MaidList_All:prepareClose()
      else
        for mIndex = 0, getTotalMaidList() - 1 do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            ToClient_CallHandlerMaid("_marketMaid")
            dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            maidType = 0
            break
          end
        end
      end
    else
      if false == enableMarketMaid then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_MARKETMAID_NONE"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_MARKETMAID_COOLTIME"))
      end
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  elseif TAB_TYPE.STORAGE == key32 then
    if warehouseInMaid then
      if nil ~= Panel_Window_CampWarehouse_All and Panel_Window_CampWarehouse_All:GetShow() then
        PaGlobalFunc_CampWarehouse_All_Close()
      end
      if _ContentsGroup_NewUI_WareHouse_All then
        PaGlobal_Warehouse_All_OpenPanelFromMaid()
      else
        Warehouse_OpenPanelFromMaid()
      end
      if ToClient_CheckExistSummonMaid() and -1 ~= dontGoMaid then
        if 1 == maidType then
          ToClient_CallHandlerMaid("_warehouseMaid")
        else
          for mIndex = 0, getTotalMaidList() - 1 do
            local maidInfoWrapper = getMaidDataByIndex(mIndex)
            if (maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse()) and 0 == maidInfoWrapper:getCoolTime() then
              ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
              ToClient_CallHandlerMaid("_marketMaidLogOut")
              ToClient_CallHandlerMaid("_warehouseMaid")
              dontGoMaid = mIndex
              PaGlobal_MaidList_All:prepareClose()
              maidType = 1
              break
            end
          end
        end
        PaGlobal_MaidList_All:prepareClose()
      else
        for mIndex = 0, getTotalMaidList() - 1 do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if (maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse()) and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            ToClient_CallHandlerMaid("_warehouseMaid")
            dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            maidType = 1
            break
          end
        end
      end
    else
      if false == enableWarehouseMaid then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_WAREHOUSEMAID_NONE"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_WAREHOUSEMAID_COOLTIME"))
      end
      SetUIMode(Defines.UIMode.eUIMode_Default)
    end
  elseif TAB_TYPE.MARKET == key32 then
    FGlobal_ItemMarket_OpenByMaid()
    if ToClient_CheckExistSummonMaid() and -1 ~= dontGoMaid then
      if 0 == maidType then
        ToClient_CallHandlerMaid("_marketMaid")
      else
        for mIndex = 0, getTotalMaidList() - 1 do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            ToClient_CallHandlerMaid("_warehouseMaidLogOut")
            ToClient_CallHandlerMaid("_marketMaid")
            dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            maidType = 0
            break
          end
        end
      end
      PaGlobal_MaidList_All:prepareClose()
    else
      for mIndex = 0, getTotalMaidList() - 1 do
        local maidInfoWrapper = getMaidDataByIndex(mIndex)
        if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
          ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
          ToClient_CallHandlerMaid("_marketMaid")
          dontGoMaid = mIndex
          PaGlobal_MaidList_All:prepareClose()
          maidType = 0
          break
        end
      end
    end
  end
end
