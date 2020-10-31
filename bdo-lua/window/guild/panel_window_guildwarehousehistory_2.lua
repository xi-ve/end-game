function FromClient_getGuildWareHouseHistory()
  PaGlobal_GuildWareHouseHistory:open()
end
function PaGlobal_GuildWareHouseHistory_CreateControlList2(content, key)
  local self = PaGlobal_GuildWareHouseHistory
  local index = Int64toInt32(key)
  local wrapper = ToClient_guildWareHouseHistoryWrapper(index)
  if nil == wrapper then
    return
  end
  content:SetIgnore(true)
  local txt_info = UI.getChildControl(content, "StaticText_Content")
  local txt_date = UI.getChildControl(content, "StaticText_Date")
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local itemIcon = UI.getChildControl(slotBg, "Static_ItemIcon")
  local itemCount = UI.getChildControl(slotBg, "StaticText_ItemCount")
  local txt = ""
  local itemSSW = getItemEnchantStaticStatus(wrapper:getItemEnchantKey())
  if nil ~= itemSSW then
    itemIcon:ChangeTextureInfoNameDefault("Icon/" .. itemSSW:getIconPath())
    itemIcon:addInputEvent("Mouse_On", "PaGlobal_GuildWareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
    itemIcon:addInputEvent("Mouse_Out", "PaGlobal_GuildWareHouseHistory:itemTooltipHide()")
    itemCount:SetText(tostring(wrapper:getItemCount()))
    if true == wrapper:isPush() then
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_PUSH", "userNickName", wrapper:getUserNickName())
    else
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_POP", "userNickName", wrapper:getUserNickName())
    end
  end
  txt_info:SetText(txt)
  local paTime = PATime(wrapper:getRegisterDate())
  local registerDate = tostring(paTime:GetYear()) .. "." .. tostring(paTime:GetMonth()) .. "." .. tostring(paTime:GetDay())
  txt_date:SetText(registerDate)
end
