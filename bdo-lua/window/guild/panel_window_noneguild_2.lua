function PaGlobal_Guild_NoneGuild_CreateControlList2(content, index)
  local self = PaGlobal_Guild_NoneGuild
  local key = Int64toInt32(index)
  local wrapper = ToClient_getGuildPRInfoWrapper(self._selectedIndex, key)
  if nil == wrapper then
    return
  end
  local btn_guildList = UI.getChildControl(content, "Button_GuildList_Temp")
  btn_guildList:SetCheck(key == PaGlobal_Guild_NoneGuild._guildSlotIndex)
  btn_guildList:setNotImpactScrollEvent(true)
  local stc_guildMark = UI.getChildControl(btn_guildList, "Static_GuildMark")
  local txt_guildName = UI.getChildControl(btn_guildList, "StaticText_GuildName")
  local txt_guildMemberCount = UI.getChildControl(btn_guildList, "StaticText_GuildMemberCount")
  local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), stc_guildMark)
  if false == isSet then
    stc_guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_guildMark, 183, 1, 188, 6)
    stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  else
    stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  end
  txt_guildName:SetText(wrapper:getGuildName())
  local guildSizeString = ""
  local guildMemberCount = wrapper:getMemberCount()
  if guildMemberCount < 31 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif guildMemberCount < 51 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif guildMemberCount < 76 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  else
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  txt_guildMemberCount:SetText(tostring(guildSizeString))
  btn_guildList:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:SetRightAreaInfo(" .. key .. ")")
end
function FromClient_loadCompleteGuildPRList()
  PaGlobal_Guild_NoneGuild:update()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USER_REFRESHGUILDLIST"))
end
function FromClient_updateGuildApplicant(guildNo, applicantType)
  if __eGuildApplicantType_Insert == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERJOINCOMPLETE"))
  elseif __eGuildApplicantType_Delete_User == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERDELETECOMPLETE"))
  elseif __eGuildApplicantType_Delete_Guild == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETEUSERCOMPLETE"))
  end
end
