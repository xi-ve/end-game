local lifeType = {
  [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GATHERING"),
  [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_FISHING"),
  [2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_HUNTING"),
  [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_COOKING"),
  [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_ALCHEMY"),
  [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_PROCESSING"),
  [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_OBEDIENCE"),
  [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_TRADE"),
  [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_GROWTH"),
  [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_WEALTH"),
  [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_COMBAT")
}
function FromWeb_GuildInfo_All_WebPageError(url, statusCode)
  if nil == Panel_GuildInfo_All then
    return
  end
  if 200 ~= statusCode then
    return
  end
  if _urlCache ~= url then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local startIndex = string.find(url, "?")
  if nil ~= startIndex then
    local _url = string.sub(url, 1, startIndex - 1)
    if PaGlobal_URL_Check(worldNo) == _url then
      PaGlobal_GuildInfo_All._ui.stc_webControl:SetShow(true)
      return
    end
  end
  PaGlobal_GuildInfo_All._ui.stc_webControl:SetShow(false)
end
function FromClient_GuildInfo_All_List2Update(content, key)
  PaGlobal_GuildInfo_All:warInfoUpdateByList2(content, key)
end
function FromClient_GuildInfo_All_ResponseGuildNotice()
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(false, "ToClient_GetguildWrapperWrapper is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  PaGlobal_GuildInfo_All:guildNoticeUpdate(guildWrapper)
end
function FromClient_GuildInfo_All_GuildUpdate()
  if false == Panel_GuildMain_All:GetShow() then
    return
  end
  if true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
    PaGlobal_GuildInfo_All:update()
  elseif true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._QUSET) then
    FromClient_GuildQuest_All_Update()
  elseif true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._SKILL) then
    PaGlobalFunc_Guild_Skill_All_Update()
  elseif true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    PaGlobalFunc_GuildMemberList_All_Update()
  end
  PaGlobal_GuildQuest_UpdateRemainTime()
end
function FromClient_GuildInfo_All_ResonseGuildInvite(s64_guildNo, hostUsername, hostName, guildName, guildGrade, periodDay, benefit, penalty)
  if 0 == guildGrade then
    local luaGuildTextGuildInviteMsg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE_MSG")
    local contentString = hostUsername .. "(" .. hostName .. ")" .. luaGuildTextGuildInviteMsg
    local messageBox_guild_accept = function()
      ToClient_RequestAcceptGuildInvite()
    end
    local messageBox_guild_refuse = function()
      ToClient_RequestRefuseGuildInvite()
    end
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN_INVITE"), contentString, messageBox_guild_accept, messageBox_guild_refuse, nil, nil)
  elseif 1 == guildGrade then
    if nil == Panel_AgreementGuild then
      UI.ASSERT_NAME(false, " Panel_AgreementGuild is nil  ", "\234\185\128\234\183\188\236\154\176")
      return
    end
    if true == PaGlobal_GuildInfo_All._isConsole then
      PaGlobal_AgreementGuild_InviteOpen(true, hostUsername, hostName, guildName, periodDay, benefit, penalty, s64_guildNo)
    else
      FGlobal_AgreementGuild_Open(true, hostUsername, hostName, guildName, periodDay, benefit, penalty, s64_guildNo)
    end
  end
end
function FromClient_GuildInfo_All_ResonseGuildRefuse(questName, s64_joinableTime)
  if s64_joinableTime > toInt64(0, 0) then
    local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(s64_joinableTime))
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_MSGBOX_JOINWAITTIME_CONTENT", "questName", questName, "lefttimeText", lefttimeText)
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"), contentString, nil, nil, MessageBox_Empty_function, nil)
  else
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      _PA_ASSERT(false, "FromClient_ResponseGuild_refuse \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    end
    local textGuild = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD")
    local guildGrade = myGuildInfo:getGuildGrade()
    if 0 == guildGrade then
      textGuild = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN")
    end
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_REFUSE_GUILDINVITE", "name", questName, "guild", textGuild)
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"), contentString, nil, nil, MessageBox_Empty_function, nil)
  end
end
function FromClient_GuildInfo_All_ActorChangeGuildInfo()
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(false, "ToClient_GetguildWrapperWrapper is nil", "\234\185\128\234\183\188\236\154\176")
    return
  end
  PaGlobal_GuildInfo_All:guildInfoUpdate(guildWrapper)
end
function FromClient_GuildInfo_All_ResponseDeclareGuildWarToMyGuild()
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
    return
  end
  PaGlobal_GuildInfo_All:guildWarListUpdate()
end
function FromClient_GuildInfo_All_ReceivedGuildWar(userNo, guildNo, guildName)
  if MessageBox.isPopUp() and PaGlobal_GuildInfo_All._targetGuildNo == guildNo then
    return
  end
  PaGlobal_GuildInfo_All._targetGuildNo = guildNo
  PaGlobal_GuildInfo_All._targetGuildName = guildName
  PaGlobal_GuildInfo_All._targetUserNo = userNo
  if isGameTypeJapan() or isGameTypeKR2() then
    keyUseCheck = false
  end
  local AceeptWar = function()
    if nil == PaGlobal_GuildInfo_All._targetGuildNo and nil == PaGlobal_GuildInfo_All._targetGuildName then
      return
    end
    ToClient_RequestDeclareGuildWar(PaGlobal_GuildInfo_All._targetGuildNo, PaGlobal_GuildInfo_All._targetGuildName, true)
    PaGlobal_GuildInfo_All._targetGuildNo = nil
    PaGlobal_GuildInfo_All._targetGuildName = nil
    PaGlobal_GuildInfo_All._targetUserNo = nil
  end
  local DenyWar = function()
    if nil == PaGlobal_GuildInfo_All._targetUserNo and nil == PaGlobal_GuildInfo_All._targetGuildName then
      return
    end
    ToClient_RequestRefuseGuildWar(PaGlobal_GuildInfo_All._targetUserNo, PaGlobal_GuildInfo_All._targetGuildName)
    PaGlobal_GuildInfo_All._targetGuildNo = nil
    PaGlobal_GuildInfo_All._targetGuildName = nil
    PaGlobal_GuildInfo_All._targetUserNo = nil
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_DECLAREWAR", "guildName", PaGlobal_GuildInfo_All._targetGuildName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = AceeptWar,
    functionNo = DenyWar,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, keyUseCheck)
end
function FromClient_GuildInfo_All_UpdateGuildNotice(guildNo, userNo, result)
  if nil ~= getSelfPlayer() then
    if true == getSelfPlayer():get():isGuildMaster() then
      return
    end
    if getSelfPlayer():get():getUserNo() ~= userNo then
      return
    end
  end
  if true == result then
    PaGlobal_GuildInfo_All._ui.btn_Vaction:SetShow(false)
    PaGlobal_GuildInfo_All._ui.btn_VactionReturn:SetShow(true)
    PaGlobal_GuildInfo_All._isVacation = true
  elseif false == result then
    PaGlobal_GuildInfo_All._ui.btn_Vaction:SetShow(true)
    PaGlobal_GuildInfo_All._ui.btn_VactionReturn:SetShow(false)
    PaGlobal_GuildInfo_All._isVacation = false
  end
end
function FromClient_GuildInfo_All_NotifyGuildMessage(msgType, strParam1, strParam2, s64_param1, s64_param2, s64_param3)
  local param1 = Int64toInt32(s64_param1)
  local param2 = Int64toInt32(s64_param2)
  local param3 = Int64toInt32(s64_param3)
  if 0 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_CLAN_OUT")
    else
      message = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_GUILD_OUT")
    end
    Proc_ShowMessage_Ack(message)
  elseif 1 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "GAME_MESSAGE_CLANMEMBER_OUT", "familyName", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "GAME_MESSAGE_GUILDMEMBER_OUT", "familyName", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 2 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_GUILD", "name", strParam1)
    elseif 1 == param2 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_VOLUNTEER", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_GUILD", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 3 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WHO_JOIN_CLAN", "name", strParam1)
    elseif 1 == param2 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WHO_JOIN_VOLUNTEER", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WHO_JOIN_GUILD", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 4 == msgType then
    local message = ""
    if 0 == param1 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_CLAN_MSG", "name", strParam1)
    else
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD_MSG", "name", strParam1)
    end
    Proc_ShowMessage_Ack(message)
  elseif 5 == msgType then
    local textGrade = ""
    if 0 == param1 then
      textGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLAN")
    else
      textGrade = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD")
    end
    local message = ""
    if 0 == param2 then
      message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_EXPEL_SELF", "guild", strParam2)
    else
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_EXPEL_OTHER", "name", strParam1, "guild", strParam2)
    end
    Proc_ShowMessage_Ack(message)
  elseif 6 == msgType then
  elseif 7 == msgType then
    local message = ""
    local characterName = strParam1
    local userNickName = strParam2
    if true == GameOption_ShowGuildLoginMessage() then
      if 0 == param1 then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_LOGIN_GUILD_MEMBER", "familyName", userNickName, "characterName", characterName)
      elseif 1 == param1 then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_LOGOUT_GUILD_MEMBER", "familyName", userNickName, "characterName", characterName)
      end
      Proc_ShowMessage_Ack(message)
    end
  elseif 8 == msgType then
  elseif 9 == msgType then
    local message = {}
    if 15 < param1 then
      message.main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERLEVELUP_MAIN", "strParam1", strParam1, "param1", param1)
      message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
      message.addMsg = ""
      Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
    end
  elseif 10 == msgType then
    local message = {}
    if param1 <= 8 then
      local lifeLevel
      lifeLevel = PaGlobalFunc_Util_CraftLevelReplace(param2)
      message.main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERLIFELEVELUP_MAIN", "strParam1", strParam1, "param1", lifeType[param1], "lifeLevel", lifeLevel)
      message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
      message.addMsg = ""
      Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
    end
  elseif 11 == msgType then
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if itemSSW == nil then
      return
    end
    local itemName = itemSSW:getName()
    local itemClassify = itemSSW:getItemClassify()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    local enchantLevelHigh = 0
    if true == ToClient_IsSpecialEnchantItem(itemSSW:get()._key) then
      enchantLevel = 0
      enchantLevelHigh = ""
    end
    if nil ~= enchantLevel and 0 ~= enchantLevel then
      if 16 <= enchantLevel then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel)
      elseif CppEnums.ItemClassifyType.eItemClassify_Accessory == itemClassify then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel + 15)
      else
        enchantLevelHigh = "+ " .. enchantLevel
      end
    end
    local message = {}
    message.main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERENCHANTSUCCESS_MAIN1", "strParam1", strParam1, "param1", enchantLevelHigh, "strParam2", itemName)
    message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
    message.addMsg = ""
    Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
  elseif 12 == msgType then
    local message = ""
    message = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDUELWILLBEEND")
    Proc_ShowMessage_Ack(message)
  elseif 13 == msgType then
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(param1))
    if itemSSW == nil then
      return
    end
    local itemName = itemSSW:getName()
    local itemClassify = itemSSW:getItemClassify()
    local enchantLevel = itemSSW:get()._key:getEnchantLevel()
    local enchantLevelHigh = 0
    if true == ToClient_IsSpecialEnchantItem(itemSSW:get()._key) then
      enchantLevel = 0
    end
    if nil ~= enchantLevel and 0 ~= enchantLevel then
      if 16 <= enchantLevel then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel)
      elseif CppEnums.ItemClassifyType.eItemClassify_Accessory == itemClassify then
        enchantLevelHigh = HighEnchantLevel_ReplaceString(enchantLevel + 15)
      else
        enchantLevelHigh = "+ " .. enchantLevel
      end
    end
    local message = {}
    message.main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBERPROMOTION_CAPHRAS", "strParam1", strParam1, "param1", enchantLevelHigh, "strParam2", itemName)
    message.sub = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMEMBER_CHEER")
    message.addMsg = ""
    Proc_ShowMessage_Ack_For_RewardSelect(message, 3.2, 22)
  end
end
function FromClient_GuildInfo_All_ResponseArkMessage(notifyType, userNickName, characterName, strParam1, strParam2, s64_param1, s64_param2, s64_param3)
  local param1 = Int64toInt32(s64_param1)
  local param2 = Int64toInt32(s64_param2)
  local param3 = Int64toInt32(s64_param3)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  if 0 == notifyType then
    local guildGrade = guildWrapper:getGuildGrade()
    if 1 == guildGrade then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PENSION"))
    end
  elseif 1 == notifyType then
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_DEPOSIT", "userNickName", userNickName, "money", tostring(param1)))
  elseif 2 == notifyType then
    if nil == Panel_Guild_GetDailyPay then
      UI.ASSERT_NAME(false, " Panel_Guild_GetDailyPay is nil ", "\234\185\128\234\183\188\236\154\176")
      return
    end
    local isWarehouseGet = PaGlobalFunc_GuildMemberList_All_IsReceivePayWareHouse()
    local tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_COLLECTION_INVEN", "money", makeDotMoney(param1))
    if true == isWarehouseGet then
      tempStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MONEY_COLLECTION_WAREHOUSE", "money", makeDotMoney(param1))
    end
    if 1 == param2 then
      Proc_ShowMessage_Ack(tempStr)
    end
  elseif 3 == notifyType then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HIRE_RENEWAL", "userNickName", userNickName))
  elseif 4 == notifyType then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_EXPIRATION", "userNickName", userNickName))
  elseif 5 == notifyType then
    local periodDay = getTemporaryInformationWrapper():getContractedPeriodDay()
    local benefit = getTemporaryInformationWrapper():getContractedBenefit()
    local penalty = getTemporaryInformationWrapper():getContractedPenalty()
    local guildName = guildWrapper:getName()
    if false == PaGlobal_GuildInfo_All._isConsole then
      FGlobal_AgreementGuild_Open(false, userNickName, characterName, guildName, periodDay, benefit, penalty, guildWrapper:getGuildNo_s64())
    else
      PaGlobal_AgreementGuild_InviteOpen(false, userNickName, characterName, guildName, periodDay, benefit, penalty, guildWrapper:getGuildNo_s64())
    end
  elseif 6 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PAYMENTS", "typeMoney", tostring(param2))
    if 0 ~= param1 then
      tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAID", "typeMoney", tostring(param2))
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INCOMETAX", "type", tempTxt))
  elseif 7 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_LEAVE", "userNickName", userNickName)
    if 0 < param1 then
      tempTxt = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PENALTIES", "tempTxt", tempTxt, "money", tostring(param1))
    end
    Proc_ShowMessage_Ack(tempTxt)
    HandleEventLUp_GuildMain_All_Close()
  elseif 8 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_FIRE", "userNickName", userNickName)
    if 0 < param1 then
      tempTxt = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BONUS", "tempTxt", tempTxt, "money", tostring(param1))
    end
    Proc_ShowMessage_Ack(tempTxt)
  elseif 9 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UPGRADES"))
  elseif 10 == notifyType then
  elseif 11 == notifyType then
    local text = ""
    if 1 == param3 then
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BESTMONEY", "money", makeDotMoney(s64_param1))
    else
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_NOTBESTMONEY", "money", makeDotMoney(s64_param1))
    end
    Proc_ShowMessage_Ack(text)
  elseif 12 == notifyType then
    local text
    if 1 == param1 then
      text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BIDCANCEL")
    else
      text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_BIDSUCCESS")
    end
    Proc_ShowMessage_Ack(text)
  elseif 13 == notifyType then
    if toInt64(0, 0) == s64_param1 then
      Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_USEGUILDSHOP_BUY", "userNickName", tostring(userNickName), "param2", makeDotMoney(s64_param2)))
    end
    if true == _ContentsGroup_NewUI_NpcShop_All and nil ~= PaGlobalFunc_NPCShop_ALL_GetShow then
      if true == PaGlobalFunc_NPCShop_ALL_GetShow() and npcShop_isGuildShopContents() then
        PaGlobalFunc_NPCShop_ALL_UpdateMoney()
        return
      end
    elseif true == _ContentsGroup_RenewUI_NpcShop then
      if PaGlobalFunc_Dialog_NPCShop_IsShow() and npcShop_isGuildShopContents() then
        FromClient_Dialog_NPCShop_UpdateMoneyWarehouse()
        return
      end
    elseif Panel_Window_NpcShop:IsShow() and npcShop_isGuildShopContents() then
      NpcShop_UpdateMoneyWarehouse()
      return
    end
  elseif 14 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INCENTIVE"))
  elseif 15 == notifyType then
    local tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_PAYMENTS", "typeMoney", tostring(param2))
    if 0 ~= param1 then
      tempTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAID", "typeMoney", tostring(param2))
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS", "tempTxt", tempTxt))
  elseif 16 == notifyType then
    local text = ""
    if 0 == param1 then
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CREATE_CLAN", "name", userNickName)
    else
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CREATE_GUILD", "name", userNickName)
    end
    Proc_ShowMessage_Ack(text)
  elseif 17 == notifyType then
    if false == ToClient_GetMessageFilter(9) then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ACCEPT_GUILDQUEST")
      Proc_ShowMessage_Ack(text)
    end
  elseif 18 == notifyType then
    if false == ToClient_GetMessageFilter(9) then
      local text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_COMPLETE_GUILDQUEST")
      Proc_ShowMessage_Ack(text)
    end
  elseif 19 == notifyType then
    local regionInfoWrapper = getRegionInfoWrapper(param2)
    if nil == regionInfoWrapper then
      _PA_ASSERT(false, "\236\132\177\236\163\188\234\176\128 \235\167\136\236\157\132\236\132\184\234\184\136\236\157\132 \236\136\152\234\184\136\237\150\136\235\138\148\235\141\176 \235\167\136\236\157\132 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
      return
    end
    local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_LORD_MOVETAX_TO_GUILDMONEY", "region", regionInfoWrapper:getAreaName(), "silver", makeDotMoney(s64_param1))
    Proc_ShowMessage_Ack(text)
  elseif 20 == notifyType then
  elseif 21 == notifyType then
    if CppEnums.GuildWarType.GuildWarType_Normal == ToClient_GetGuildWarType() then
      if param3 == 1 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ACCEPT_BATTLE_NO_RESOURCE"))
      else
        local tendency = param1
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_DECLARE_WAR_CONSUME", "silver", makeDotMoney(s64_param2)))
      end
    end
  elseif 22 == notifyType then
  elseif 23 == notifyType then
  elseif 24 == notifyType then
  elseif 25 == notifyType then
  elseif 26 == notifyType then
    if true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._QUSET) then
      FromClient_GuildQuest_All_Update()
    end
  elseif 27 == notifyType then
  elseif 28 == notifyType then
    if 0 == param1 then
      Proc_ShowMessage_Ack(userNickName .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMP_DOWN"))
    else
      Proc_ShowMessage_Ack(userNickName .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMP_UP"))
    end
  elseif 29 == notifyType then
    if 0 == param1 then
      Proc_ShowMessage_Ack(userNickName .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CHEER_GUILD"))
    end
    if true == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._WARFARE) then
      FromClient_GuildWarfareInfoUpdate()
    end
  elseif 30 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DONOT_GUILDQUEST"))
  elseif 31 == notifyType then
  elseif 32 == notifyType then
    local regionInfoWrapper = getRegionInfoWrapper(param3)
    local areaName = ""
    if nil ~= regionInfoWrapper then
      areaName = regionInfoWrapper:getAreaName()
    end
    local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(param2)
    local characterName = ""
    if nil ~= characterStaticStatusWarpper then
      characterName = characterStaticStatusWarpper:getName()
    end
    local msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BUILDING_AUTODESTROYBUILD", "areaName", areaName, "characterName", characterName)
    Proc_ShowMessage_Ack(msg)
  elseif 38 == notifyType then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDE_PAYPROPERTYTAX", "typeMoney", makeDotMoney(s64_param1)))
  elseif 39 == notifyType then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_GETWELFARE", "typeMoney", makeDotMoney(s64_param1)))
  elseif 43 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NOTIFYWELFARE"))
  end
  FromClient_GuildInfo_All_GuildUpdate()
end
function FromClient_GuildInfo_All_GuildInviteForGuildGrade(targetActorKeyRaw, targetName, preGuildActivity)
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "ResponseGuildInviteForGuildGrade \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  if nil == targetName then
    _PA_ASSERT(false, "targetName \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  if 0 == guildGrade then
    toClient_RequestInviteGuild(targetName, 0, 0, 0)
  else
    if nil == Panel_AgreementGuild_Master then
      UI.ASSERT_NAME(false, "Panel_AgreementGuild_Master is nil ")
      return
    end
    if true == PaGlobal_GuildInfo_All._isConsole then
      PaGlobalFunc_AgreementGuild_Open_ForJoin(targetActorKeyRaw, targetName, preGuildActivity)
    else
      FGlobal_AgreementGuild_Master_Open_ForJoin(targetActorKeyRaw, targetName, preGuildActivity)
    end
  end
end
function FromClient_GuildInfo_All_UpdateMajorSiegeHpStack(guildNo, hpStack)
end
