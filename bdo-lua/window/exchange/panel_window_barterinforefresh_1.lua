function PaGlobal_BarterInfoRefresh:init()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:close()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:close()")
  self._ui._btn_apply:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:requestRefreshBarterInfo()")
  self._ui._rdo_group = Array.new()
  for ii = 0, 4 do
    local control
    control = UI.getChildControl(Panel_Window_Barter_Refresh, "RadioButton_Refresh_" .. tostring(ii + 1))
    control:SetShow(true == _ContentsGroup_BarterMaterialReset or ii < 3)
    control:SetCheck(false)
    control:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoRefresh:selectIndex(" .. ii .. ")")
    local txtDesc = UI.getChildControl(control, "StaticText_Money")
    txtDesc:SetTextMode(__eTextMode_AutoWrap)
    txtDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_TYPE_" .. tostring(ii + 1) .. "_DESC"))
    if 2 ~= ii then
      local txtPoint = UI.getChildControl(control, "StaticText_PointValue")
      txtPoint:SetSpanSize(control:GetTextSizeX() + 23, 20)
    end
    self._ui._rdo_group[ii] = control
  end
  if false == _ContentsGroup_BarterMaterialReset then
    local diffSize = 260
    self._ui._rdo_group[2]:SetSpanSize(10, 320)
    Panel_Window_Barter_Refresh:SetSize(Panel_Window_Barter_Refresh:GetSizeX(), Panel_Window_Barter_Refresh:GetSizeY() - diffSize)
    Panel_Window_Barter_Refresh:SetPosY(Panel_Window_Barter_Refresh:GetPosY() - diffSize)
    local staticBG = UI.getChildControl(Panel_Window_Barter_Refresh, "Static_Bg")
    staticBG:SetSize(staticBG:GetSizeX(), staticBG:GetSizeY() - diffSize)
    Panel_Window_Barter_Refresh:ComputePosAllChild()
  end
end
function PaGlobal_BarterInfoRefresh:clear()
  self._selectIndex = nil
  for ii = 0, #self._ui._rdo_group do
    self._ui._rdo_group[ii]:SetCheck(false)
    self._ui._rdo_group[ii]:SetMonoTone(false)
  end
end
function PaGlobal_BarterInfoRefresh:open()
  if false == _ContentsGroup_Barter then
    return
  end
  self:clear()
  for ii = 0, 4 do
    self._ui._rdo_group[ii]:SetMonoTone(false == ToClient_isCanChangeBarterList(ii))
    if 2 ~= ii then
      local radioText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_TYPE_" .. tostring(ii + 1))
      local remainCount = 0
      if 0 == ii or 1 == ii then
        remainCount = ToClient_getMaxSeedChangeCountByBarterType(0) - ToClient_getSeedChangeCountByBarterType(0)
      else
        remainCount = ToClient_getMaxSeedChangeCountByBarterType(1) - ToClient_getSeedChangeCountByBarterType(1)
      end
      local needPoint = ToClient_getBarterResetNeedPoint(ii)
      local textValue
      if 0 < remainCount and 0 < needPoint then
        textValue = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_COUNT", "value", needPoint)
      else
        textValue = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_RESETBUTTON_FINISH")
      end
      local txtPointValue = UI.getChildControl(self._ui._rdo_group[ii], "StaticText_PointValue")
      if nil ~= txtPointValue then
        txtPointValue:SetText(textValue)
      end
    end
  end
  self:selectIndex(0)
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:push(Panel_Window_Barter_Refresh, true)
  else
    Panel_Window_Barter_Refresh:SetShow(true)
  end
end
function PaGlobal_BarterInfoRefresh:close()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:popWantPanel(Panel_Window_Barter_Refresh)
  else
    Panel_Window_Barter_Refresh:SetShow(false)
  end
end
function PaGlobal_BarterInfoRefresh:selectIndex(index)
  self._selectIndex = index
  self._ui._rdo_group[index]:SetCheck(true)
end
function PaGlobal_BarterInfoRefresh:requestRefreshBarterInfo()
  if 2 == self._selectIndex then
    PaGlobal_BarterInfoSearch_RequestChangeBarterList()
    return
  end
  local needPoint = ToClient_getBarterResetNeedPoint(self._selectIndex)
  local remainCount = 0
  if 0 == self._selectIndex or 1 == self._selectIndex then
    remainCount = ToClient_getMaxSeedChangeCountByBarterType(0) - ToClient_getSeedChangeCountByBarterType(0)
  else
    remainCount = ToClient_getMaxSeedChangeCountByBarterType(1) - ToClient_getSeedChangeCountByBarterType(1)
  end
  if remainCount <= 0 or needPoint <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoBarterSeedChangeCountIsNull"))
    return
  end
  local maxSeedChangeCount = ToClient_getMaxChangeSeedCountForDay()
  local remainSeedChangeCount = maxSeedChangeCount - ToClient_getChangeSeedCountForDay()
  if needPoint > remainSeedChangeCount then
    remainCount = 0
  end
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERRESET_INFO_00", "point", needPoint, "remaincount", remainCount)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = PaGlobal_BarterInfoSearch_RequestChangeBarterList,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
