function PaGlobal_GuildMain_All:initialize()
  if true == PaGlobal_GuildMain_All._initialize or nil == Panel_GuildMain_All then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_GuildMain_All, "Static_TitleArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_Title, "StaticText_TItle")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_Title, "Button_Question")
  self._ui.btn_PopUp = UI.getChildControl(self._ui.stc_Title, "CheckButton_TrayBTN")
  self._ui.btn_Refresh = UI.getChildControl(self._ui.stc_Title, "Button_Refresh")
  self._ui.btn_PearlApp = UI.getChildControl(self._ui.stc_Title, "Button_PearlApp")
  self._ui.stc_TabBG = UI.getChildControl(Panel_GuildMain_All, "Static_TabArea")
  self._ui.stc_RdoBtnBg = UI.getChildControl(self._ui.stc_TabBG, "Static_RadioButtonBg")
  self._ui.rdo_BasicInfo = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Info")
  self._ui.rdo_MemberList = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_MemberList")
  self._ui.rdo_Quest = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Quest")
  self._ui.rdo_Skill = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Skill")
  self._ui.rdo_Warfare = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Warfare")
  self._ui.rdo_History = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_History")
  self._ui.rdo_Recruit = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Recruit")
  self._ui.rdo_GuildBattle = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_PvP")
  self._ui.rdo_ManuFacture = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Manufacture")
  self._ui.rdo_Alliance = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Alliance")
  self._ui.rdo_AllianceList = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_AllianceList")
  self._ui.rdo_Marcenary = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_Mercenary")
  self._ui.rdo_BossSummon = UI.getChildControl(self._ui.stc_RdoBtnBg, "RadioButton_BossSummon")
  self._ui.stc_KeyGuide_LB = UI.getChildControl(self._ui.stc_RdoBtnBg, "Static_LB_ConsoleUI")
  self._ui.stc_KeyGuide_RB = UI.getChildControl(self._ui.stc_RdoBtnBg, "Static_RB_ConsoleUI")
  self._ui.stc_SelectBar = UI.getChildControl(self._ui.stc_RdoBtnBg, "Static_SelectBar")
  self._ui.stc_BasicInfo_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_MainInfoBg")
  self._ui.stc_MemberList_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_MemberListBg")
  self._ui.stc_Quest_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_QuestListBg")
  self._ui.stc_Skill_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_SkillBg")
  self._ui.stc_Warfare_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_WarfareBg")
  self._ui.stc_History_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_HistoryBg")
  self._ui.stc_Recruit_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_RecruitBg")
  self._ui.stc_GuildBattle_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_GuildBattleBg")
  self._ui.stc_ManuFacture_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_ManuFactureBg")
  self._ui.stc_Alliance_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_AllienceBg")
  self._ui.stc_AllianceList_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_AllienceListBg")
  self._ui.stc_Mercenary_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_VoulenteerBg")
  self._ui.stc_BossSummon_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_BossSummonBg")
  self._ui.stc_AllianceInvite_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_AllianceInviteBg")
  self._ui.stc_Keyguide_Bg = UI.getChildControl(Panel_GuildMain_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_Keyguide_A = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_Keyguide_B = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_Keyguide_X = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_X_ConsoleUI")
  self._ui.stc_Keyguide_Y = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_Y_ConsoleUI")
  self._ui.stc_Keyguide_LT = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_LT_ConsoleUI")
  self._ui.stc_Keyguide_VertiDpad = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_DPadVertical_ConsoleUI")
  self._ui.stc_Keyguide_HoriDpad = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_DPadHorizon_ConsoleUI")
  self._ui.stc_Keyguide_RS = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_RS_ConsoleUI")
  self._ui.stc_Keyguide_LC = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_LC_ConsoleUI")
  self._ui.stc_Keyguide_RC = UI.getChildControl(self._ui.stc_Keyguide_Bg, "StaticText_RC_ConsoleUI")
  self._ui.rdo_btnTable[self._eTABINDEX._BASIC] = self._ui.rdo_BasicInfo
  self._ui.rdo_btnTable[self._eTABINDEX._MEMBERLIST] = self._ui.rdo_MemberList
  self._ui.rdo_btnTable[self._eTABINDEX._QUSET] = self._ui.rdo_Quest
  self._ui.rdo_btnTable[self._eTABINDEX._SKILL] = self._ui.rdo_Skill
  self._ui.rdo_btnTable[self._eTABINDEX._WARFARE] = self._ui.rdo_Warfare
  self._ui.rdo_btnTable[self._eTABINDEX._HISTORY] = self._ui.rdo_History
  self._ui.rdo_btnTable[self._eTABINDEX._RECRUIT] = self._ui.rdo_Recruit
  self._ui.rdo_btnTable[self._eTABINDEX._GUILDBATTLE] = self._ui.rdo_GuildBattle
  self._ui.rdo_btnTable[self._eTABINDEX._MANUFACTURE] = self._ui.rdo_ManuFacture
  self._ui.rdo_btnTable[self._eTABINDEX._ALLIANCE] = self._ui.rdo_Alliance
  self._ui.rdo_btnTable[self._eTABINDEX._ALLIANCELIST] = self._ui.rdo_AllianceList
  self._ui.rdo_btnTable[self._eTABINDEX._MARCENARY] = self._ui.rdo_Marcenary
  self._ui.rdo_btnTable[self._eTABINDEX._BOSSSUMMON] = self._ui.rdo_BossSummon
  self._keyGuideTable[__eConsoleUIPadEvent_A] = self._ui.stc_Keyguide_A
  self._keyGuideTable[__eConsoleUIPadEvent_X] = self._ui.stc_Keyguide_X
  self._keyGuideTable[__eConsoleUIPadEvent_Y] = self._ui.stc_Keyguide_Y
  self._keyGuideTable[__eConsoleUIPadEvent_LB] = self._ui.stc_KeyGuide_LB
  self._keyGuideTable[__eConsoleUIPadEvent_RB] = self._ui.stc_KeyGuide_RB
  self._keyGuideTable[__eConsoleUIPadEvent_LSClick] = self._ui.stc_Keyguide_LC
  self._keyGuideTable[__eConsoleUIPadEvent_RSClick] = self._ui.stc_Keyguide_RC
  self._keyGuideTable[__eConsoleUIPadEvent_DpadUp] = self._ui.stc_Keyguide_VertiDpad
  self._keyGuideTable[__eConsoleUIPadEvent_DpadLeft] = self._ui.stc_Keyguide_HoriDpad
  self._keyGuideTable[__eConsoleUIPadEvent_RStickUp] = self._ui.stc_Keyguide_RS
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildMain_All:validate()
  PaGlobal_GuildMain_All:swichPlatform(self._isConsole)
  PaGlobal_GuildMain_All:alignTabButton()
  PaGlobal_GuildMain_All:registEventHandler(self._isConsole)
  self._ui.btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self._originSizeY = Panel_GuildMain_All:GetSizeY()
end
function PaGlobal_GuildMain_All:registEventHandler(isConsole)
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_GuildMain_All:RegisterShowEventFunc(true, "PaGlobalFunc_GuildMain_All_ShowAni()")
  Panel_GuildMain_All:RegisterShowEventFunc(false, "PaGlobalFunc_GuildMain_All_HideAni()")
  if false == isConsole then
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMain_All_Close()")
    self._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelGuild\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_Question, "\"PanelGuild\"")
    self._ui.btn_PopUp:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMain_All_PopUp()")
    self._ui.btn_PopUp:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMain_All_ShowTooltip(true)")
    self._ui.btn_PopUp:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMain_All_ShowTooltip()")
    self._ui.btn_PearlApp:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PearlApp\" )")
    self._ui.btn_PearlApp:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMain_All_PearlAppTooltip(true)")
    self._ui.btn_PearlApp:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMain_All_PearlAppTooltip(false)")
    Panel_GuildMain_All:SetDragAll(true)
    PaGlobal_Util_RegistWebResetControl(self._ui.btn_Refresh)
    registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForGuild")
    for idx = 0, self._eTABINDEX._COUNT - 1 do
      if nil ~= self._ui.rdo_btnTable[idx] then
        self._ui.rdo_btnTable[idx]:addInputEvent("Mouse_On", "HandleEventLUp_GuildMain_All_RadioBtnTooltip(" .. idx .. ")")
        self._ui.rdo_btnTable[idx]:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMain_All_RadioBtnTooltip()")
      end
    end
  else
    Panel_GuildMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventPadUp_GuildMain_All_PressOtherTab(false)")
    Panel_GuildMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventPadUp_GuildMain_All_PressOtherTab(true)")
  end
  registerEvent("onScreenResize", "PaGlobalFunc_GuildMain_All_OnScreenResize")
end
function PaGlobal_GuildMain_All:swichPlatform(isConsole)
  self._ui.stc_KeyGuide_RB:SetShow(isConsole)
  self._ui.stc_KeyGuide_LB:SetShow(isConsole)
  self._ui.stc_Keyguide_Bg:SetShow(isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.btn_PopUp:SetShow(_ContentsGroup_PopUp and not isConsole)
  self._ui.btn_Question:SetShow(not isConsole)
  self._ui.btn_Refresh:SetShow(not isConsole)
  self._ui.btn_PearlApp:SetShow(not isConsole and _ContentsGroup_PearlApp)
end
function PaGlobal_GuildMain_All:alignTabButton()
  if nil == Panel_GuildMain_All then
    return
  end
  local isAllianceMemeber = false
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  isAllianceMemeber = selfPlayer:get():isGuildAllianceMember()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
  local isRecruitAble = (true == isGuildMaster or true == isGuildSubMaster) and _ContentsGroup_Guild_JoinRequest
  self._ui.rdo_ManuFacture:SetShow(_ContentsGroup_GuildManufacture)
  self._ui.rdo_Alliance:SetShow(_ContentsGroup_guildAlliance)
  self._ui.rdo_AllianceList:SetShow(_ContentsGroup_guildAlliance)
  self._ui.rdo_BossSummon:SetShow(_ContentsGroup_BossSpawn)
  self._ui.rdo_Marcenary:SetShow(_ContentsGroup_BattleFieldVolunteer)
  self._ui.rdo_GuildBattle:SetShow(_ContentsGroup_GuldBattle)
  self._ui.rdo_History:SetShow(not _ContentsGroup_RenewUI)
  self._ui.rdo_Recruit:SetShow(isRecruitAble and not _ContentsGroup_RenewUI)
  self._ui.rdo_Warfare:SetShow(_ContentsGroup_Siege)
  if true == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    self._ui.rdo_Quest:SetShow(false)
    self._ui.rdo_History:SetShow(false)
    self._ui.rdo_Recruit:SetShow(false)
    self._ui.rdo_GuildBattle:SetShow(false)
    self._ui.rdo_ManuFacture:SetShow(false)
    self._ui.rdo_BossSummon:SetShow(false)
  end
  local btnTable = Array.new()
  local idxTable_Console = Array.new()
  if true == isAllianceMemeber and true == _ContentsGroup_guildAlliance then
    btnTable:push_back(self._ui.rdo_btnTable[self._eTABINDEX._ALLIANCE])
    btnTable:push_back(self._ui.rdo_btnTable[self._eTABINDEX._ALLIANCELIST])
    idxTable_Console:push_back(self._eTABINDEX._ALLIANCE)
    idxTable_Console:push_back(self._eTABINDEX._ALLIANCELIST)
  end
  local padding = 30
  local btnSize = self._ui.rdo_BasicInfo:GetSizeX()
  for idx = 0, self._eTABINDEX._COUNT - 1 do
    if true == self._ui.rdo_btnTable[idx]:GetShow() then
      if true == isAllianceMemeber and true == _ContentsGroup_guildAlliance then
        if idx == self._eTABINDEX._ALLIANCE then
          if true == self._ui.rdo_btnTable[self._eTABINDEX._MARCENARY]:GetShow() then
            btnTable:push_back(self._ui.rdo_btnTable[self._eTABINDEX._MARCENARY])
            idxTable_Console:push_back(self._eTABINDEX._MARCENARY)
          end
        elseif idx == self._eTABINDEX._ALLIANCELIST then
          if true == self._ui.rdo_btnTable[self._eTABINDEX._BOSSSUMMON]:GetShow() then
            btnTable:push_back(self._ui.rdo_btnTable[self._eTABINDEX._BOSSSUMMON])
            idxTable_Console:push_back(self._eTABINDEX._BOSSSUMMON)
            break
          end
        elseif idx ~= self._eTABINDEX._MARCENARY and idx ~= self._eTABINDEX._BOSSSUMMON then
          btnTable:push_back(self._ui.rdo_btnTable[idx])
          idxTable_Console:push_back(idx)
          self._ui.rdo_btnTable[idx]:SetIgnore(false)
          self._ui.rdo_btnTable[idx]:SetMonoTone(false)
        end
      else
        btnTable:push_back(self._ui.rdo_btnTable[idx])
        idxTable_Console:push_back(idx)
        self._ui.rdo_btnTable[idx]:SetIgnore(false)
        self._ui.rdo_btnTable[idx]:SetMonoTone(false)
      end
    end
  end
  local btnCount = #btnTable - 1
  local adjust = 25
  local startPosX = (Panel_GuildMain_All:GetSizeX() - (btnSize * btnCount + padding * btnCount)) * 0.5 - adjust
  local posX = 0
  for index = 1, #btnTable do
    posX = startPosX + (btnSize + padding) * (index - 1)
    btnTable[index]:SetSpanSize(posX, btnTable[index]:GetSpanSize().y)
  end
  local uiCount = 0
  if true == self._isConsole then
    for idx = 1, #idxTable_Console do
      self._tabBtnConsole[uiCount] = idxTable_Console[idx]
      uiCount = uiCount + 1
    end
  end
  if true == self._isConsole then
    self._ui.stc_KeyGuide_LB:SetSpanSize(startPosX - (self._ui.rdo_btnTable[0]:GetSizeX() + self._ui.stc_KeyGuide_LB:GetSizeX() + 10), self._ui.stc_KeyGuide_LB:GetSpanSize().y)
    self._ui.stc_KeyGuide_RB:SetSpanSize(posX + self._ui.rdo_btnTable[0]:GetSizeX() + self._ui.stc_KeyGuide_RB:GetSizeX() + 10, self._ui.stc_KeyGuide_RB:GetSpanSize().y)
  end
end
function PaGlobal_GuildMain_All:prepareOpen()
  if nil == Panel_GuildMain_All then
    return
  end
  if false == PaGlobal_GuildMain_All._initialize then
    local function setTabData(index, btn, panel, bg, updateFunc)
      UI.ASSERT_NAME(nil ~= index, "GuildMain_All_1.lua / index is nil " .. tostring(index), "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= btn, "GuildMain_All_1.lua / btn is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= panel, "GuildMain_All_1.lua / panel is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= bg, "GuildMain_All_1.lua / bg is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= self._tabData, "GuildMain_All_1.lua / table is nil", "\234\185\128\234\183\188\236\154\176")
      UI.ASSERT_NAME(nil ~= updateFunc, "GuildMain_All_1.lua / updateFunc is nil", "\234\185\128\234\183\188\236\154\176")
      if nil == index or nil == btn or nil == panel or nil == bg then
        return
      end
      local data = {
        btn = nil,
        panel = nil,
        bg = nil,
        updateFunc = nil,
        originSizeY = nil
      }
      data.btn = btn
      data.panel = panel
      data.bg = bg
      data.updateFunc = updateFunc
      data.bg:MoveChilds(data.bg:GetID(), data.panel)
      deletePanel(data.panel:GetID())
      data.bg:ComputePos()
      data.bg:SetShow(false)
      data.originSizeY = bg:GetSizeY()
      data.btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMain_All_ClickOtherTab(" .. index .. ")")
      self._tabData[index] = data
    end
    setTabData(self._eTABINDEX._BASIC, self._ui.rdo_BasicInfo, Panel_GuildInfo_All, self._ui.stc_BasicInfo_Bg, PaGlobalFunc_GuildInfo_All_Open)
    setTabData(self._eTABINDEX._WARFARE, self._ui.rdo_Warfare, Panel_GuildWarfare_All, self._ui.stc_Warfare_Bg, PaGlobalFunc_GuildWarfare_All_Update)
    setTabData(self._eTABINDEX._HISTORY, self._ui.rdo_History, Panel_Guild_History_All, self._ui.stc_History_Bg, PaGlobalFunc_Guild_History_All_DataUpdate)
    setTabData(self._eTABINDEX._BOSSSUMMON, self._ui.rdo_BossSummon, Panel_Guild_BossSummon_All, self._ui.stc_BossSummon_Bg, PaGlobalFunc_Guild_BossSummon_All_Update)
    setTabData(self._eTABINDEX._QUSET, self._ui.rdo_Quest, Panel_GuildQuest_All, self._ui.stc_Quest_Bg, PaGlobalFunc_Guild_Quest_All_FirstUpdate)
    setTabData(self._eTABINDEX._MANUFACTURE, self._ui.rdo_ManuFacture, Panel_Guild_Manufacture_All, self._ui.stc_ManuFacture_Bg, PaGlobalFunc_Guild_Manufacture_All_Update)
    setTabData(self._eTABINDEX._ALLIANCE, self._ui.rdo_Alliance, Panel_GuildAllianceInvite_All, self._ui.stc_AllianceInvite_Bg, PaGlobalFunc_GuildMain_All_AllianceOpen)
    setTabData(self._eTABINDEX._ALLIANCE, self._ui.rdo_Alliance, Panel_GuildAlliance_All, self._ui.stc_Alliance_Bg, PaGlobalFunc_GuildMain_All_AllianceOpen)
    setTabData(self._eTABINDEX._ALLIANCELIST, self._ui.rdo_AllianceList, Panel_GuildAllianceList_All, self._ui.stc_AllianceList_Bg, PaGlobalFunc_GuildAllianceList_All_Open)
    setTabData(self._eTABINDEX._SKILL, self._ui.rdo_Skill, Panel_GuildSkill_All, self._ui.stc_Skill_Bg, PaGlobalFunc_Guild_Skill_All_UpdateTab)
    setTabData(self._eTABINDEX._MEMBERLIST, self._ui.rdo_MemberList, Panel_GuildMemeberList_All, self._ui.stc_MemberList_Bg, PaGlobalFunc_GuildMemberList_All_Open)
    if true == _ContentsGroup_Guild_JoinRequest then
      setTabData(self._eTABINDEX._RECRUIT, self._ui.rdo_Recruit, Panel_GuildJoinRequestList_All, self._ui.stc_Recruit_Bg, PaGlobalFunc_GuildJoinRequestList_All_Open)
    end
    setTabData(self._eTABINDEX._GUILDBATTLE, self._ui.rdo_GuildBattle, Panel_Guild_Battle_All, self._ui.stc_GuildBattle_Bg, PaGlobal_Guild_Battle_All_UpdateGuildBattleInfo)
    setTabData(self._eTABINDEX._MARCENARY, self._ui.rdo_Marcenary, Panel_GuildVolunteerList_All, self._ui.stc_Mercenary_Bg, PaGlobalFunc_GuildVolunteerList_All_Open)
    PaGlobal_GuildMain_All._initialize = true
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_GuildMain_All:open()
  PaGlobal_GuildMain_All:alignTabButton()
  local isAllianceMemeber = selfPlayer:get():isGuildAllianceMember()
  local isDeadMessageOpen = false
  if false == _ContentsGroup_NewUI_DeadMessage_All then
    if false == _ContentsGroup_RenewUI then
      isDeadMessageOpen = Panel_DeadMessage:GetShow()
    else
      isDeadMessageOpen = Panel_DeadMessage_Renew:GetShow()
    end
  else
    isDeadMessageOpen = Panel_Window_DeadMessage_All:GetShow()
  end
  if isDeadInWatchingMode() and false == isDeadMessageOpen then
    PaGlobal_GuildMain_All:otherTabOpen(self._eTABINDEX._WARFARE)
    for idx = 0, self._eTABINDEX._COUNT - 1 do
      if true == self._ui.rdo_btnTable[idx]:GetShow() and idx ~= self._eTABINDEX._WARFARE then
        self._ui.rdo_btnTable[idx]:SetIgnore(true)
        self._ui.rdo_btnTable[idx]:SetMonoTone(false)
      end
    end
  elseif true == isAllianceMemeber and true == _ContentsGroup_guildAlliance then
    PaGlobal_GuildMain_All:otherTabOpen(self._eTABINDEX._ALLIANCE)
  else
    PaGlobal_GuildMain_All:otherTabOpen(self._eTABINDEX._BASIC)
  end
  PaGlobalFunc_GuildMain_All_OnScreenResize()
end
function PaGlobal_GuildMain_All:open()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_GuildMain_All:SetShow(true)
end
function PaGlobal_GuildMain_All:checkCurTabOpen(idx)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local isAlly = selfPlayer:get():isGuildAllianceMember()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
  if idx == self._eTABINDEX._ALLIANCELIST or idx == self._eTABINDEX._ALLIANCE then
    if false == isAlly then
      if idx == self._eTABINDEX._ALLIANCE then
        if false == isGuildMaster then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_CAUTION_MESSAGE_TEXT"))
          if false == self._isConsole then
            self._tabData[idx].btn:SetCheck(false)
            self._tabData[self._currentTabIdx].btn:SetCheck(true)
            return false
          end
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_CAUTION_MESSAGE_TEXT"))
        if false == self._isConsole then
          self._tabData[idx].btn:SetCheck(false)
          self._tabData[self._currentTabIdx].btn:SetCheck(true)
          return false
        end
      end
    end
  elseif idx == self._eTABINDEX._RECRUIT then
    if false == isGuildMaster and false == isGuildSubMaster then
      self._tabData[idx].btn:SetCheck(false)
      self._tabData[self._currentTabIdx].btn:SetCheck(true)
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ONLYMASTER"))
      return false
    end
  elseif idx == self._eTABINDEX._GUILDBATTLE and false == ToClient_isGuildBattle() then
    self._tabData[idx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].btn:SetCheck(true)
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDBATTLE_CANNOT_GUILDBATTLE_SERVER"))
    return false
  end
  return true
end
function PaGlobal_GuildMain_All:otherTabOpen(idx)
  UI.ASSERT_NAME(nil ~= self._tabData[idx], "Panel_GuildMain_All.lua / self._tabData[idx] is nil ", "\234\185\128\234\183\188\236\154\176")
  local isAvailable = PaGlobal_GuildMain_All:checkCurTabOpen(idx)
  if false == isAvailable then
    return
  end
  PaGlobalFunc_Guild_ManufactureSelect_All_Close()
  PaGlobal_Warehouse_All_Close()
  if idx == self._eTABINDEX._ALLIANCE then
    if true == self:hasAlliance() then
      self._tabData[self._eTABINDEX._ALLIANCE].panel = Panel_GuildAlliance_All
      self._tabData[self._eTABINDEX._ALLIANCE].bg = self._ui.stc_Alliance_Bg
    else
      self._tabData[self._eTABINDEX._ALLIANCE].panel = Panel_GuildAllianceInvite_All
      self._tabData[self._eTABINDEX._ALLIANCE].bg = self._ui.stc_AllianceInvite_Bg
    end
  end
  if nil ~= self._currentTabIdx then
    self._tabData[self._currentTabIdx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].bg:SetShow(false)
  end
  if self._currentTabIdx == self._eTABINDEX._BASIC then
    PaGlobalFunc_GuildInfo_All_ResetUrl()
  elseif self._currentTabIdx == self._eTABINDEX._ALLIANCELIST then
    PaGlobalFunc_GuildAllianceList_All_ResetUrl()
  end
  if true == _ContentsGroup_SiegeCost and idx == self._eTABINDEX._MEMBERLIST then
    ToClient_getSiegeMercenaryCost()
  end
  local updateFunc = self._tabData[idx].updateFunc
  self._tabData[idx].btn:SetCheck(true)
  self._tabData[idx].bg:SetShow(true)
  PaGlobal_GuildMain_All_ChangePanelSize()
  PaGlobal_GuildMain_All:resetKeyGuide()
  PaGlobal_GuildMain_All:keyGuideShowByTab(idx)
  updateFunc()
  PaGlobal_GuildQuest_UpdateRemainTime()
  self._currentTabIdx = idx
  if true == self._isConsole then
    for index = 0, #self._tabBtnConsole - 1 do
      if self._tabBtnConsole[index] == idx then
        self._currentTabIdxConsole = index
      end
    end
  end
  self._ui.stc_SelectBar:SetPosX(self._tabData[self._currentTabIdx].btn:GetPosX() - 23)
  ClearFocusEdit()
  Panel_SkillTooltip_Hide()
end
function PaGlobal_GuildMain_All:hasAlliance()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  return selfPlayer:get():isGuildAllianceMember()
end
function PaGlobal_GuildMain_All:setKeyGuideText(table, control, text)
  if nil == control or nil == table or false == self._isConsole then
    return
  end
  if nil == text then
    control:SetText(control:GetText())
  else
    control:SetText(text)
  end
  table:push_back(control)
end
function PaGlobal_GuildMain_All:resetKeyGuide()
  if false == self._isConsole then
    return
  end
  self._alignedKeyguide = Array.new()
  self._ui.stc_Keyguide_Y:SetShow(false)
  self._ui.stc_Keyguide_A:SetShow(false)
  self._ui.stc_Keyguide_B:SetShow(true)
  self._ui.stc_Keyguide_LT:SetShow(false)
  self._ui.stc_Keyguide_X:SetShow(false)
  self._ui.stc_Keyguide_VertiDpad:SetShow(false)
  self._ui.stc_Keyguide_HoriDpad:SetShow(false)
  self._ui.stc_Keyguide_RS:SetShow(false)
  self._ui.stc_Keyguide_LC:SetShow(false)
  self._ui.stc_Keyguide_RC:SetShow(false)
end
function PaGlobal_GuildMain_All:keyGuideShowByTab(idx)
  if nil == idx or false == self._isConsole or nil == self._tabData or nil == self._tabData[idx] then
    return
  end
  local baseTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_TITLE_ALL")
  self._ui.stc_Keyguide_Bg:ComputePos()
  if idx == self._eTABINDEX._BASIC then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_Y, PAGetString(Defines.StringSheet_RESOURCE, "GUILD_MANAGER_TEXT_TITLE"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INFOTITLE"))
  elseif idx == self._eTABINDEX._MEMBERLIST then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_LT, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_SIEGEGRADE_JOIN_BTN"))
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_MEMBERLISTTITLE"))
  elseif idx == self._eTABINDEX._QUSET then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_HoriDpad, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOGLIST_ALL_UNDO") .. " / " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOGLIST_ALL_NEXT"))
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GETGUILDMEMBERBONUS_TITLE"))
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUESTINFO_TITLE"))
  elseif idx == self._eTABINDEX._SKILL then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_DETAIL"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SKILLTITLE"))
  elseif idx == self._eTABINDEX._WARFARE then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_TAB_WARFARE"))
  elseif idx == self._eTABINDEX._HISTORY then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_RS)
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_HISTORY_TITLE"))
  elseif idx == self._eTABINDEX._GUILDBATTLE then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDDUEL_TITLE"))
  elseif idx == self._eTABINDEX._MANUFACTURE then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_DETAIL"))
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_MANUFACTURE_TITLE"))
  elseif idx == self._eTABINDEX._BOSSSUMMON then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_DETAIL"))
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHENCYCLOPEDIA_BTN_FISHLOCATION"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_BOSS_SUMMON_TITLE"))
  elseif idx == self._eTABINDEX._ALLIANCE then
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_FEDERATION_TITLE"))
    if true == PaGlobal_GuildMain_All:hasAlliance() then
      PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_Y, PAGetString(Defines.StringSheet_RESOURCE, "GUILD_MANAGER_TEXT_TITLE"))
    else
      PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_LC, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_ADD_ALLIANCE"))
      PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_RC, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDALLIANCEINFO_DELETE_ALLIANCE"))
      PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
    end
  elseif idx == self._eTABINDEX._ALLIANCELIST then
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TAB_ALLIANCELISTITLE"))
  elseif idx == self._eTABINDEX._MARCENARY then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_DETAIL"))
    if nil ~= getSelfPlayer() then
      self._isGuildMaster = getSelfPlayer():get():isGuildMaster()
      self._isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
      if true == self._isGuildMaster or true == self._isGuildSubMaster then
        PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_A, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDVOLUNTEER_HIREBUTTON"))
      end
    end
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_VOLUNTEER_LIST_TAB_BUTTON_TOOLTIP"))
  elseif idx == self._eTABINDEX._RECRUIT then
    PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_Y, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_JOIN_REFRESHLIST"))
    self._ui.txt_Title:SetText(baseTitle .. " - " .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENTGUILD"))
  end
  PaGlobal_GuildMain_All:setKeyGuideText(self._alignedKeyguide, self._ui.stc_Keyguide_B)
  PaGlobal_GuildMain_All:keyGuideAlign(self._alignedKeyguide)
end
function PaGlobal_GuildMain_All:keyGuideAlign(keyTables)
  if false == self._isConsole or nil == keyTables then
    return
  end
  for idx = 1, #keyTables do
    if nil ~= keyTables[idx] then
      keyTables[idx]:SetShow(true)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyTables, self._ui.stc_Keyguide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildMain_All:setKeyguideTextWithShow(isShow, eKeyType, text)
  if nil == eKeyType or nil == isShow or false == self._isConsole then
    return
  end
  if nil == self._keyGuideTable or nil == self._keyGuideTable[eKeyType] then
    return
  end
  self._keyGuideTable[eKeyType]:SetShow(isShow)
  if nil == text then
    self._keyGuideTable[eKeyType]:SetText(self._keyGuideTable[eKeyType]:GetText())
  else
    self._keyGuideTable[eKeyType]:SetText(text)
  end
  local tempTable = Array.new()
  local targetControl
  if true == isShow then
    local isExist = false
    for i = 1, #self._alignedKeyguide do
      if self._keyGuideTable[eKeyType]:GetID() == self._alignedKeyguide[i]:GetID() then
        isExist = true
      end
    end
    if false == isExist then
      tempTable:push_back(self._keyGuideTable[eKeyType])
    end
  else
    for i = 1, #self._alignedKeyguide do
      if self._keyGuideTable[eKeyType]:GetID() == self._alignedKeyguide[i]:GetID() then
        targetControl = self._alignedKeyguide[i]
      end
    end
  end
  for i = 1, #self._alignedKeyguide do
    if false == isShow and nil ~= targetControl then
      if targetControl ~= self._alignedKeyguide[i] then
        tempTable:push_back(self._alignedKeyguide[i])
      end
    else
      tempTable:push_back(self._alignedKeyguide[i])
    end
  end
  self._alignedKeyguide = Array.new()
  self._alignedKeyguide = tempTable
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._alignedKeyguide, self._ui.stc_Keyguide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildMain_All:dataClear()
  if nil ~= self._currentTabIdx then
    self._tabData[self._currentTabIdx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].bg:SetShow(false)
  end
  self._currentTabIdx = nil
  if false == self._isConsole then
    Panel_Tooltip_Item_hideTooltip()
    Panel_SkillTooltip_Hide()
    self._alignedKeyguide = Array.new()
  end
  self._ui.btn_PopUp:SetCheck(false)
  PaGlobalFunc_GuildInfo_All_ResetUrl()
  PaGlobalFunc_GuildAllianceList_All_ResetUrl()
end
function PaGlobal_GuildMain_All:prepareClose()
  if nil == Panel_GuildMain_All then
    return
  end
  local isOtherPanelOff = PaGlobal_GuildMain_All:closeOtherPanel()
  if true == isOtherPanelOff then
    PaGlobal_GuildMain_All:dataClear()
    Panel_GuildMain_All:CloseUISubApp()
    PaGlobal_GuildMain_All:close()
  end
end
function PaGlobal_GuildMain_All:closeOtherPanel()
  PaGlobalFunc_GuildIntroduce_Close()
  PaGlobal_GuildQuestInfo_Close_All()
  TooltipSimple_Hide()
  if nil ~= Panel_GuildWebInfo_All then
    PaGlobalFunc_GuildWebInfo_All_Close()
  else
  end
  if nil ~= Panel_GuildDeclareWar_All and Panel_GuildDeclareWar_All:GetShow() then
    PaGlobalFunc_GuildDeclareWar_Close()
    return false
  elseif nil ~= Panel_GuildChangeMark_All and Panel_GuildChangeMark_All:GetShow() then
    PaGlobalFunc_GuildChangeMark_All_Close()
    return false
  elseif nil ~= Panel_GuildFunctionPanel_All and Panel_GuildFunctionPanel_All:GetShow() then
    PaGlobalFunc_GuildFunctionPanel_All_Close()
    return false
  elseif nil ~= Panel_Guild_ManufactureSelect and Panel_Guild_ManufactureSelect:GetShow() then
    PaGlobal_Guild_ManufactureSelect:close()
    return false
  elseif nil ~= Panel_Guild_ManufactureSelect_All and Panel_Guild_ManufactureSelect_All:GetShow() then
    PaGlobalFunc_Guild_ManufactureSelect_All_Close()
    return false
  elseif nil ~= Panel_Window_GuildWareHouseHistory and true == Panel_Window_GuildWareHouseHistory:GetShow() then
    PaGlobal_GuildWareHouseHistory:close()
    return false
  elseif nil ~= Panel_Window_Warehouse and true == Panel_Window_Warehouse:GetShow() then
    PaGlobal_Warehouse_All_Close()
    return false
  elseif nil ~= Panel_Guild_JoinRequestSet and true == Panel_Guild_JoinRequestSet:GetShow() then
    PaGlobal_GuildJoinRequestSet:close()
    return false
  elseif nil ~= Panel_GuildIncentive_All and true == Panel_GuildIncentive_All:GetShow() then
    PaGlobalFunc_GuildIncentive_All_Close()
    return false
  elseif nil ~= Panel_GuildIncentiveOption_All and true == Panel_GuildIncentiveOption_All:GetShow() then
    PaGlobalFunc_GuildIncentiveOption_All_Close()
    return false
  else
    return true
  end
end
function PaGlobal_GuildMain_All:close()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_GuildMain_All:SetShow(false)
end
function PaGlobal_GuildMain_All:SetMsgDataAndShow(_title, _content, _funcYes, _funcNo, _funcApply, _priority, _hotkeyUse)
  local messageboxData = {}
  messageboxData.title = ""
  messageboxData.content = ""
  messageboxData.priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData.functionYes = MessageBox_Empty_function
  messageboxData.functionNo = MessageBox_Empty_function
  messageboxData.functionApply = MessageBox_Empty_function
  if nil ~= _title then
    messageboxData.title = _title
  end
  if nil ~= _content then
    messageboxData.content = _content
  end
  if nil ~= _priority then
    messageboxData.priority = _priority
  end
  if nil ~= _funcYes or nil ~= _funcNo then
    if nil ~= _funcYes then
      messageboxData.functionYes = _funcYes
    end
    if nil ~= _funcNo then
      messageboxData.functionNo = _funcNo
    end
    messageboxData.functionApply = nil
  else
    if nil ~= _funcApply then
      messageboxData.functionApply = _funcApply
    end
    messageboxData.functionYes = nil
    messageboxData.functionNo = nil
  end
  if true == self._isConsole then
    _hotkeyUse = true
  end
  MessageBox.showMessageBox(messageboxData, nil, nil, _hotkeyUse)
end
function PaGlobal_GuildMain_All:validate()
  if nil == Panel_GuildMain_All then
    return
  end
  self._ui.stc_Title:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.btn_PopUp:isValidate()
  self._ui.btn_Refresh:isValidate()
  self._ui.stc_TabBG:isValidate()
  self._ui.stc_RdoBtnBg:isValidate()
  self._ui.rdo_BasicInfo:isValidate()
  self._ui.rdo_MemberList:isValidate()
  self._ui.rdo_Quest:isValidate()
  self._ui.rdo_Skill:isValidate()
  self._ui.rdo_Warfare:isValidate()
  self._ui.rdo_History:isValidate()
  self._ui.rdo_Recruit:isValidate()
  self._ui.rdo_GuildBattle:isValidate()
  self._ui.rdo_ManuFacture:isValidate()
  self._ui.rdo_Alliance:isValidate()
  self._ui.rdo_AllianceList:isValidate()
  self._ui.rdo_Marcenary:isValidate()
  self._ui.rdo_BossSummon:isValidate()
  self._ui.stc_KeyGuide_LB:isValidate()
  self._ui.stc_KeyGuide_RB:isValidate()
  self._ui.stc_SelectBar:isValidate()
  self._ui.stc_BasicInfo_Bg:isValidate()
  self._ui.stc_MemberList_Bg:isValidate()
  self._ui.stc_Quest_Bg:isValidate()
  self._ui.stc_Skill_Bg:isValidate()
  self._ui.stc_Warfare_Bg:isValidate()
  self._ui.stc_History_Bg:isValidate()
  self._ui.stc_Recruit_Bg:isValidate()
  self._ui.stc_GuildBattle_Bg:isValidate()
  self._ui.stc_ManuFacture_Bg:isValidate()
  self._ui.stc_Alliance_Bg:isValidate()
  self._ui.stc_AllianceList_Bg:isValidate()
  self._ui.stc_Mercenary_Bg:isValidate()
  self._ui.stc_BossSummon_Bg:isValidate()
  self._ui.stc_AllianceInvite_Bg:isValidate()
  self._ui.stc_Keyguide_Bg:isValidate()
  self._ui.stc_Keyguide_A:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
  self._ui.stc_Keyguide_X:isValidate()
  self._ui.stc_Keyguide_Y:isValidate()
  self._ui.stc_Keyguide_LT:isValidate()
  self._ui.stc_Keyguide_VertiDpad:isValidate()
  self._ui.stc_Keyguide_HoriDpad:isValidate()
  self._ui.stc_Keyguide_RS:isValidate()
  self._ui.stc_Keyguide_LC:isValidate()
  self._ui.stc_Keyguide_RC:isValidate()
end
