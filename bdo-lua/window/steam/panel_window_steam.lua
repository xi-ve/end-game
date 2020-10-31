local UI_SERVICE_RESOURCE = CppEnums.ServiceResourceType
function PaGlobal_Steam_Redemption()
  local url, langType
  if true == _ContentsGroup_NewUI_GameOption_All then
    PaGlobal_GameOption_All:getWebLangTypeText()
  else
    PaGlobal_Option:getWebLangTypeText()
  end
  if isSteamClient() then
    if not isSteamInGameOverlayEnabled() then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STEAM_ALERT")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      Steam_Redemption(langType)
    end
    return
  end
  if isGameTypeEnglish() then
    url = "https://www.blackdesertonline.com/myinfo/"
    ToClient_OpenChargeWebPage(url, false)
    return
  elseif isGameTypeSA() then
    local ticket = ToClient_GetAuthToken()
    local userID = ToClient_GetUserId()
    url = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_SA", "userID", userID, "ticket", ticket, "langType", langtype)
    ToClient_OpenChargeWebPage(url, false)
    return
  end
end
function Steam_Redemption(langType)
  ToClient_requestRedeemAuthSessionTicket()
  local url
  local userID = ToClient_GetUserId()
  local userNo = getUserNoByLobby()
  local ticket = getSteamAuthSessionTicket()
  if isGameTypeEnglish() then
    url = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_EN", "ticket", ticket, "langType", langtype)
  elseif isGameTypeTR() then
    if CppEnums.CountryType.TR_REAL == getGameServiceType() then
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TR_REAL", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    else
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TR_ALPHA", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    end
  elseif isGameTypeRussia() then
    if CppEnums.CountryType.RUS_REAL == getGameServiceType() then
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_RU_REAL", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    else
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_RU_ALPHA", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    end
  elseif isGameTypeTH() then
    if CppEnums.CountryType.TH_REAL == getGameServiceType() then
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TH_REAL", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    else
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TH_ALPHA", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    end
  elseif isGameTypeID() then
    if CppEnums.CountryType.ID_REAL == getGameServiceType() then
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_ID_REAL", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    else
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_ID_ALPHA", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    end
  elseif isGameTypeTaiwan() then
    if CppEnums.CountryType.TW_REAL == getGameServiceType() then
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TW_REAL", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    else
      url = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_STEAM_REDEMPTION_URL_TW_ALPHA", "userID", userID, "userNo", tostring(userNo), "ticket", ticket, "langType", langtype)
    end
  end
  if nil ~= url then
    steamOverlayToWebPage(url)
  end
end
function FromClient_SteamRedeemAuthTicketReady()
  local url
  local langType = "EN"
  if UI_SERVICE_RESOURCE.eServiceResourceType_EN == getGameServiceResType() then
    langType = "EN"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_FR == getGameServiceResType() then
    langType = "FR"
  elseif UI_SERVICE_RESOURCE.eServiceResourceType_DE == getGameServiceResType() then
    langType = "DE"
  end
  if isGameTypeEnglish() then
    local ticket = getSteamAuthSessionTicket()
    url = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STEAM_REDEEMAUTHTICKET_URL_EN", "ticket", ticket, "langType", langtype)
    steamOverlayToWebPage(url)
  end
end
registerEvent("FromClient_SteamRedeemAuthTicketReady", "FromClient_SteamRedeemAuthTicketReady")
