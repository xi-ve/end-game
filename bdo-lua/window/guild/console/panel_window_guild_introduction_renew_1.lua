function PaGlobal_GuildIntroduction:initialize()
  if true == PaGlobal_GuildIntroduction._initialize then
    return
  end
  PaGlobal_GuildIntroduction._ui.stc_CenterBG = UI.getChildControl(Panel_Window_Guild_Introduction_Renew, "Static_CenterBg")
  PaGlobal_GuildIntroduction._ui._activityControl = {}
  for i = 1, PaGlobal_GuildIntroduction._maxActivityTypeCount do
    PaGlobal_GuildIntroduction._ui._activityControl[i] = UI.getChildControl(PaGlobal_GuildIntroduction._ui.stc_CenterBG, "CheckButton_" .. i)
  end
  PaGlobal_GuildIntroduction._ui.txt_Salary = UI.getChildControl(PaGlobal_GuildIntroduction._ui.stc_CenterBG, "StaticText_SalaryValue")
  PaGlobal_GuildIntroduction._ui.stc_BottomBG = UI.getChildControl(Panel_Window_Guild_Introduction_Renew, "Static_BottomBg")
  PaGlobal_GuildIntroduction._ui.stc_KeyGuideA = UI.getChildControl(PaGlobal_GuildIntroduction._ui.stc_BottomBG, "StaticText_A_ConsoleUI")
  PaGlobal_GuildIntroduction._ui.stc_KeyGuideB = UI.getChildControl(PaGlobal_GuildIntroduction._ui.stc_BottomBG, "StaticText_B_ConsoleUI")
  PaGlobal_GuildIntroduction._ui.stc_KeyGuideY = UI.getChildControl(PaGlobal_GuildIntroduction._ui.stc_BottomBG, "StaticText_Y_ConsoleUI")
  local keyguides = {
    PaGlobal_GuildIntroduction._ui.stc_KeyGuideY,
    PaGlobal_GuildIntroduction._ui.stc_KeyGuideA,
    PaGlobal_GuildIntroduction._ui.stc_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, PaGlobal_GuildIntroduction._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildIntroduction:registEventHandler()
  PaGlobal_GuildIntroduction._initialize = true
end
function PaGlobal_GuildIntroduction:registEventHandler()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  Panel_Window_Guild_Introduction_Renew:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputYUp_GuildIntroduction_Regist()")
  PaGlobal_GuildIntroduction._ui.txt_Salary:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputAUp_GuildIntroduction_SetSalary()")
end
function PaGlobal_GuildIntroduction:initData()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  for i = 1, PaGlobal_GuildIntroduction._maxActivityTypeCount do
    PaGlobal_GuildIntroduction._ui._activityControl[i]:SetCheck(false)
  end
  local maxDailyPay = makeDotMoney(tonumber(CppEnums.GuildBenefit.eMaxContractedBenefit))
  PaGlobal_GuildIntroduction._ui.txt_Salary:SetText(maxDailyPay)
end
function PaGlobal_GuildIntroduction:prepareOpen()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction:initData()
  PaGlobal_GuildIntroduction:open()
end
function PaGlobal_GuildIntroduction:open()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  Panel_Window_Guild_Introduction_Renew:SetShow(true)
end
function PaGlobal_GuildIntroduction:prepareClose()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  PaGlobal_GuildIntroduction:close()
end
function PaGlobal_GuildIntroduction:close()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  Panel_Window_Guild_Introduction_Renew:SetShow(false)
end
function PaGlobal_GuildIntroduction:registIntroduction()
  if nil == Panel_Window_Guild_Introduction_Renew then
    return
  end
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == guildInfo then
    return
  end
  local guildRank = guildInfo:getMemberCountLevel()
  local guildRankString = ""
  if 1 == guildRank then
    guildRankString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL") .. "]"
  elseif 2 == guildRank then
    guildRankString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE") .. "]"
  elseif 3 == guildRank then
    guildRankString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG") .. "]"
  elseif 4 == guildRank then
    guildRankString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST") .. "]"
  end
  local activityString = ""
  local isFirst = true
  for i = 1, PaGlobal_GuildIntroduction._maxActivityTypeCount do
    local isCheck = PaGlobal_GuildIntroduction._ui._activityControl[i]:IsCheck()
    if true == isCheck then
      if isFirst then
        activityString = " " .. PaGlobal_GuildIntroduction._ui._activityControl[i]:GetText()
        isFirst = false
      else
        activityString = activityString .. ", " .. PaGlobal_GuildIntroduction._ui._activityControl[i]:GetText()
      end
    end
  end
  local dailyPayString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINTRODUCEREGIST_SALARY") .. " " .. PaGlobal_GuildIntroduction._ui.txt_Salary:GetText() .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FIXEQUIP_RDOBTN_MONEYRECOVERY")
  local result = guildRankString .. activityString .. " / " .. dailyPayString
  ToClient_RequestSetIntrodution(result)
  PaGlobal_GuildIntroduction:close()
end
