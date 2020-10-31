function PaGlobal_GuildWareHouseHistory:init()
  self._ui._topBg = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_TopBg")
  self._ui._mainBg = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_MainBg")
  self._ui._btn_close = UI.getChildControl(self._ui._topBg, "Button_Close_PCUI")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildWareHouseHistory:close()")
  self._ui._stc_descBg = UI.getChildControl(self._ui._mainBg, "Static_DescBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  local basicSizeY = self._ui._stc_descBg:GetSizeY()
  local textSizeY = self._ui._txt_desc:GetTextSizeY()
  local gapSizeY = math.max(basicSizeY, textSizeY) - basicSizeY
  if 0 < gapSizeY then
    gapSizeY = gapSizeY + 15
  end
  Panel_Window_GuildWareHouseHistory:SetSize(Panel_Window_GuildWareHouseHistory:GetSizeX(), Panel_Window_GuildWareHouseHistory:GetSizeY() + gapSizeY)
  self._ui._mainBg:SetSize(self._ui._mainBg:GetSizeX(), self._ui._mainBg:GetSizeY() + gapSizeY)
  self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), basicSizeY + gapSizeY)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), basicSizeY + gapSizeY)
  self._ui._stc_descBg:ComputePos()
  self._ui._list2_logList = UI.getChildControl(self._ui._mainBg, "List2_WareHouse")
  self._ui._list2_logList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWareHouseHistory_CreateControlList2")
  self._ui._list2_logList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_getGuildWareHouseHistory", "FromClient_getGuildWareHouseHistory")
end
function PaGlobal_GuildWareHouseHistory:open()
  self._ui._list2_logList:getElementManager():clearKey()
  for ii = 0, ToClient_guildWareHouseHistoryCount() - 1 do
    self._ui._list2_logList:getElementManager():pushKey(ii)
  end
  self._ui._list2_logList:ComputePos()
  Panel_Window_GuildWareHouseHistory:SetShow(true)
end
function PaGlobal_GuildWareHouseHistory:close()
  Panel_Window_GuildWareHouseHistory:SetShow(false)
end
function PaGlobal_GuildWareHouseHistory:itemTooltipShow(index, itemEnchantKey)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_GuildWareHouseHistory, true)
  end
end
function PaGlobal_GuildWareHouseHistory:itemTooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
