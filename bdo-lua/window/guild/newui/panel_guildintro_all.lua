PaGlobal_GuildIntro_All = {
  _ui = {
    stc_CenterBG = nil,
    _activityControl = {},
    txt_Salary = nil,
    stc_KeyGuide_Bg = nil,
    stc_keyGuide_A = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_Y = nil
  },
  _maxActivityTypeCount = 6,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildIntro_All_Init")
function FromClient_GuildIntro_All_Init()
  PaGlobal_GuildIntro_All:initialize()
end
function PaGlobal_GuildIntro_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildIntro_All then
    return
  end
  self._ui.stc_CenterBG = UI.getChildControl(Panel_GuildIntro_All, "Static_CenterBg")
  self._ui.txt_Salary = UI.getChildControl(self._ui.stc_CenterBG, "StaticText_SalaryValue")
  for i = 1, self._maxActivityTypeCount do
    self._ui._activityControl[i] = UI.getChildControl(self._ui.stc_CenterBG, "CheckButton_" .. i)
  end
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_GuildIntro_All, "Static_BottomBg")
  self._ui.stc_keyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self.keyguide = {
    self._ui.stc_keyGuide_Y,
    self._ui.stc_keyGuide_A,
    self._ui.stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  PaGlobal_GuildIntro_All:registerEvent()
  PaGlobal_GuildIntro_All:validate()
end
function PaGlobal_GuildIntro_All:registerEvent()
  Panel_GuildIntro_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventYUp_GuildIntro_All_Regist()")
  self._ui.txt_Salary:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildIntro_All_SetSalary()")
end
function PaGlobal_GuildIntro_All:validate()
  self._ui.stc_CenterBG:isValidate()
  self._ui.stc_KeyGuide_Bg:isValidate()
end
function PaGlobal_GuildIntro_All:prepareOpen()
  if nil == Panel_GuildIntro_All then
    return
  end
  for i = 1, self._maxActivityTypeCount do
    self._ui._activityControl[i]:SetCheck(false)
  end
  local maxDailyPay = makeDotMoney(tonumber(CppEnums.GuildBenefit.eMaxContractedBenefit))
  self._ui.txt_Salary:SetText(maxDailyPay)
  PaGlobal_GuildIntro_All:open()
end
function PaGlobal_GuildIntro_All:open()
  if nil == Panel_GuildIntro_All then
    return
  end
  Panel_GuildIntro_All:SetShow(true)
end
function PaGlobal_GuildIntro_All:prepareClose()
  if nil == Panel_GuildIntro_All then
    return
  end
  PaGlobal_GuildIntro_All:close()
end
function PaGlobal_GuildIntro_All:close()
  if nil == Panel_GuildIntro_All then
    return
  end
  Panel_GuildIntro_All:SetShow(false)
end
function PaGlobal_GuildIntro_All:registIntroduction()
  if nil == Panel_GuildIntro_All then
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
  for i = 1, self._maxActivityTypeCount do
    local isCheck = self._ui._activityControl[i]:IsCheck()
    if true == isCheck then
      if isFirst then
        activityString = " " .. self._ui._activityControl[i]:GetText()
        isFirst = false
      else
        activityString = activityString .. ", " .. self._ui._activityControl[i]:GetText()
      end
    end
  end
  local dailyPayString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINTRODUCEREGIST_SALARY") .. " " .. self._ui.txt_Salary:GetText() .. " " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FIXEQUIP_RDOBTN_MONEYRECOVERY")
  local result = guildRankString .. activityString .. " / " .. dailyPayString
  ToClient_RequestSetIntrodution(result)
  self:close()
end
function PaGlobalFunc_GuildIntro_All_Open()
  if nil == Panel_GuildIntro_All then
    return
  end
  PaGlobal_GuildIntro_All:prepareOpen()
end
function PaGlobalFunc_GuildIntro_All_Close()
  if nil == Panel_GuildIntro_All then
    return
  end
  PaGlobal_GuildIntro_All:prepareClose()
end
function HandleEventYUp_GuildIntro_All_Regist()
  if nil == Panel_GuildIntro_All then
    return
  end
  PaGlobal_GuildIntro_All:registIntroduction()
end
function HandleEventLUp_GuildIntro_All_SetSalary()
  if nil == Panel_GuildIntro_All then
    return
  end
  local maxDailyPay = tonumber(CppEnums.GuildBenefit.eMaxContractedBenefit)
  Panel_NumberPad_Show(true, toInt64(0, maxDailyPay), nil, PaGlobalFunc_GuildIntro_All_DailyPayComfirm, nil, nil, nil, nil, toInt64(0, maxDailyPay))
end
function PaGlobalFunc_GuildIntro_All_DailyPayComfirm(inputNumber)
  if nil == Panel_GuildIntro_All then
    return
  end
  PaGlobal_GuildIntro_All._ui.txt_Salary:SetText(makeDotMoney(Int64toInt32(inputNumber)))
end
