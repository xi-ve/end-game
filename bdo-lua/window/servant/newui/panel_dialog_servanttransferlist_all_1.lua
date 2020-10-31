function PaGlobal_ServantTransferList_All:initialize()
  if nil == Panel_Dialog_ServantTransferList_All or true == self._initailize then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Button_Close")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Static_Bg")
  self._ui._txt_Desc = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Desc")
  self._ui._txt_Count = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Count")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "List2_Servant")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_Btn_List = UI.getChildControl(self._ui._list2_Content, "Button_List")
  self._ui._list2_Verti_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_VerticalScroll")
  self._ui._list2_Verti_Scroll_Up = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Verti_Scroll_Down = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Verti_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_Hori_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_HorizontalScroll")
  self._ui._list2_Hori_Scroll_Up = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_Hori_Scroll_Down = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_Hori_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_Keyguide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_Keyguide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  local textSizeX = self._ui._txt_Desc:GetTextSizeX()
  local sizeX = self._ui._txt_Desc:GetSizeX()
  if textSizeX > sizeX then
    local text = self._ui._txt_Desc:GetText()
    self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_Desc:SetText(text)
    self._ui._txt_Desc:SetTextVerticalTop()
    local textSizeY = self._ui._txt_Desc:GetTextSizeY()
    local value = textSizeY - self._ui._txt_Desc:GetSizeY()
    local txt_Count_OriginPosY = self._ui._txt_Count:GetPosY()
    local list2_Servant_OriginPosY = self._ui._list2_Servant:GetPosY()
    self._ui._txt_Count:SetPosY(txt_Count_OriginPosY + value)
    self._ui._list2_Servant:SetPosY(list2_Servant_OriginPosY + value)
    self._ui._stc_Bg:SetSize(self._ui._stc_Bg:GetSizeX(), self._ui._stc_Bg:GetSizeY() + value)
    Panel_Dialog_ServantTransferList_All:SetSize(Panel_Dialog_ServantTransferList_All:GetSizeX(), Panel_Dialog_ServantTransferList_All:GetSizeY() + value)
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantTransferList_All:validate()
  PaGlobal_ServantTransferList_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantTransferList_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantTransferList_All:validate()
  if nil == Panel_Dialog_ServantTransferList_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._txt_Count:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_Btn_List:isValidate()
  self._ui._list2_Verti_Scroll:isValidate()
  self._ui._list2_Verti_Scroll_Up:isValidate()
  self._ui._list2_Verti_Scroll_Down:isValidate()
  self._ui._list2_Verti_Scroll_Ctrl:isValidate()
  self._ui._list2_Hori_Scroll:isValidate()
  self._ui._list2_Hori_Scroll_Up:isValidate()
  self._ui._list2_Hori_Scroll_Down:isValidate()
  self._ui._list2_Hori_Scroll_Ctrl:isValidate()
  self._ui._stc_Bottom_KeyGuide:isValidate()
  self._ui._stc_Keyguide_A:isValidate()
  self._ui._stc_Keyguide_B:isValidate()
  self._initailize = true
end
function PaGlobal_ServantTransferList_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantTransferList_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantTransferList_All_OnScreenResize")
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantTransferList_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantTransferList_All_Close()")
  else
  end
end
function PaGlobal_ServantTransferList_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantTransferList_All or false == self._initailize then
    return
  end
  Panel_Dialog_ServantTransferList_All:SetDragEnable(not isConsole)
  Panel_Dialog_ServantTransferList_All:SetDragAll(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._stc_Bottom_KeyGuide:SetShow(isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_Keyguide_A,
      self._ui._stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_Bottom_KeyGuide:SetPosY(Panel_Dialog_ServantTransferList_All:GetSizeY())
  end
end
function PaGlobal_ServantTransferList_All:prepareOpen()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  FromClient_ServantTransferList_All_OnScreenResize()
  PaGlobal_ServantTransferList_All:open()
  PaGlobal_ServantTransferList_All:update()
end
function PaGlobal_ServantTransferList_All:open()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantTransferList_All:SetShow(true)
end
function PaGlobal_ServantTransferList_All:update()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer then
    return
  end
  self._ui._list2_Servant:getElementManager():clearKey()
  local currentRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  currentRegionKey = currentRegionInfo:getRegionKey()
  if CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
    local regionKeyCount = ToClient_GetCountOfRegionListWithStableNpc()
    for i = 0, regionKeyCount - 1 do
      local regionKey = ToClient_GetRegionWithStableNpcByIndex(i)
      if regionKey ~= currentRegionKey then
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
      end
    end
    regionKeyCount = regionKeyCount - 1
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_STABLE_CHANGE_REGION_LIST_COUNT", "count", regionKeyCount))
  elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
    local regionKeyCount = ToClient_GetCountOfRegionListWithWharfNpc()
    for i = 0, regionKeyCount - 1 do
      local regionKey = ToClient_GetRegionWithWharfNpcByIndex(i)
      if regionKey ~= currentRegionKey then
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
      end
    end
    regionKeyCount = regionKeyCount - 1
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHARF_VEHICLEMOVETITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_WHARF_CHANGE_REGION_LIST_COUNT", "count", regionKeyCount))
  else
    return
  end
end
function PaGlobal_ServantTransferList_All:list2Update(content, key)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() or nil == key then
    return
  end
  local regionKey = Int64toInt32(key)
  local regionInfo = getRegionInfoWrapper(regionKey)
  if nil == regionInfo then
    return
  end
  local regionControl = UI.getChildControl(content, "Button_List")
  regionControl:setNotImpactScrollEvent(true)
  regionControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantTransferList_All_Transfer(" .. regionKey .. ")")
  regionControl:SetText(regionInfo:getAreaName())
end
function PaGlobal_ServantTransferList_All:prepareClose()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if MessageBoxCheck.isCurrentOpen(self._currentTitle) then
    messageBoxCheck_CancelButtonUp()
  end
  PaGlobal_ServantTransferList_All:close()
end
function PaGlobal_ServantTransferList_All:close()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantTransferList_All:SetShow(false)
end
