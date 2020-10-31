function PaGlobal_Arsha_Func_All:initialize()
  if true == PaGlobal_Arsha_Func_All._initialize or nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:commonInitControl()
  self:gameSetInitControl()
  self:attenderSetInitControl()
  self:consoleInitControl()
  self:subMenuInitControl()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_Func_All:validate()
  PaGlobal_Arsha_Func_All:registEventHandler()
  self._mainRadioMenu[self._menuType.GAME] = self._ui.rdo_gameSetting
  self._mainRadioMenu[self._menuType.ATTENDER] = self._ui.rdo_teamSetting
  self._waitRadioMenu[self._waitListType.WAITER] = self._ui._attenderSet.rdo_waiter
  self._waitRadioMenu[self._waitListType.WATCHER] = self._ui._attenderSet.rdo_watcher
  self._notHostHideControl:push_back(self._ui.btn_gameStart)
  self._notHostHideControl:push_back(self._ui.btn_allResurrection)
  self._notHostHideControl:push_back(self._ui._attenderSet.rdo_inviteWaiter)
  self._notHostHideControl:push_back(self._ui._attenderSet.rdo_inviteWatcher)
  self._notHostHideControl:push_back(self._ui._attenderSet.edit_inviteName)
  self._notHostHideControl:push_back(self._ui._attenderSet.btn_invite)
  self._notHostHideControl:push_back(self._ui._attenderSet.btn_inviteList)
  self._notHostHideControl:push_back(self._ui._attenderSet.chk_lock)
  self._notHostHideControl:push_back(self._ui._attenderSet.btn_teamAEditName)
  self._notHostHideControl:push_back(self._ui._attenderSet.btn_teamBEditName)
  self._subHostShowControl:push_back(self._ui._attenderSet.rdo_inviteWaiter)
  self._subHostShowControl:push_back(self._ui._attenderSet.rdo_inviteWatcher)
  self._subHostShowControl:push_back(self._ui._attenderSet.edit_inviteName)
  self._subHostShowControl:push_back(self._ui._attenderSet.btn_invite)
  self._subHostShowControl:push_back(self._ui._attenderSet.btn_inviteList)
  self._subHostShowControl:push_back(self._ui._attenderSet.chk_lock)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameTypeBg)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameLevelBg)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameRoundBg)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameLifeTeamBg)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameTimeBg)
  self._gameSetMenuControl:push_back(self._ui._gameSet.stc_gameMemberBg)
  self._timeLimit = 5
  PaGlobal_Arsha_Func_All._initialize = true
end
function PaGlobal_Arsha_Func_All:commonInitControl()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Arsha_Func_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_Title")
  self._ui.stc_decoImg = UI.getChildControl(self._ui.stc_titleArea, "Static_BackImage")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_radioMenu = UI.getChildControl(Panel_Window_Arsha_Func_All, "Static_RadioButtonBg")
  self._ui.rdo_gameSetting = UI.getChildControl(self._ui.stc_radioMenu, "RadioButton_GameSettings")
  self._ui.rdo_teamSetting = UI.getChildControl(self._ui.stc_radioMenu, "RadioButton_TeamSettings")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_radioMenu, "Static_SelectBar")
  self._ui.btn_gameStart = UI.getChildControl(Panel_Window_Arsha_Func_All, "Button_GameStart")
  self._ui.btn_gameStop = UI.getChildControl(Panel_Window_Arsha_Func_All, "Button_GameStop")
  self._ui.btn_allResurrection = UI.getChildControl(Panel_Window_Arsha_Func_All, "Button_AllResurrection")
  self._basePos.mainRadio.gameSet = self._ui.rdo_gameSetting:GetSpanSize().x
  self._basePos.mainRadio.teamSet = self._ui.rdo_teamSetting:GetSpanSize().x
end
function PaGlobal_Arsha_Func_All:gameSetInitControl()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui._gameSet.stc_mainBg = UI.getChildControl(Panel_Window_Arsha_Func_All, "Static_GameSettingArea")
  self._ui._gameSet.stc_gameTypeBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_GameTypeArea")
  self._ui._gameSet.txt_gameTypeTitle = UI.getChildControl(self._ui._gameSet.stc_gameTypeBg, "StaticText_GameTypeTitle")
  self._ui._gameSet.rdo_gameType = {}
  self._ui._gameSet.rdo_gameType[1] = UI.getChildControl(self._ui._gameSet.stc_gameTypeBg, "RadioButton_Team")
  self._ui._gameSet.rdo_gameType[2] = UI.getChildControl(self._ui._gameSet.stc_gameTypeBg, "RadioButton_Life")
  self._ui._gameSet.rdo_gameType[3] = UI.getChildControl(self._ui._gameSet.stc_gameTypeBg, "RadioButton_Person")
  self._ui._gameSet.stc_gameLevelBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_LevelLimitArea")
  self._ui._gameSet.txt_gameLevelTitle = UI.getChildControl(self._ui._gameSet.stc_gameLevelBg, "StaticText_LevelLimitTitle")
  self._ui._gameSet.rdo_gameLevel = {}
  self._ui._gameSet.rdo_gameLevel[1] = UI.getChildControl(self._ui._gameSet.stc_gameLevelBg, "RadioButton_55Lv")
  self._ui._gameSet.rdo_gameLevel[2] = UI.getChildControl(self._ui._gameSet.stc_gameLevelBg, "RadioButton_60Lv")
  self._ui._gameSet.rdo_gameLevel[3] = UI.getChildControl(self._ui._gameSet.stc_gameLevelBg, "RadioButton_Unlimit")
  self._ui._gameSet.stc_gameRoundBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_RoundArea")
  self._ui._gameSet.txt_gameRoundTitle = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "StaticText_RoundTitle")
  self._ui._gameSet.rdo_gameRound = {}
  self._ui._gameSet.rdo_gameRound[1] = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "RadioButton_1")
  self._ui._gameSet.rdo_gameRound[2] = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "RadioButton_3")
  self._ui._gameSet.rdo_gameRound[3] = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "RadioButton_5")
  self._ui._gameSet.rdo_gameRound[4] = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "RadioButton_7")
  self._ui._gameSet.rdo_gameRound[5] = UI.getChildControl(self._ui._gameSet.stc_gameRoundBg, "RadioButton_Etc")
  self._ui._gameSet.stc_gameLifeTeamBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_LifeTeamArea")
  self._ui._gameSet.txt_gameLifeTitle = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "StaticText_RoundTitle")
  self._ui._gameSet.rdo_gameLife = {}
  self._ui._gameSet.rdo_gameLife[1] = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "RadioButton_1")
  self._ui._gameSet.rdo_gameLife[2] = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "RadioButton_3")
  self._ui._gameSet.rdo_gameLife[3] = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "RadioButton_5")
  self._ui._gameSet.rdo_gameLife[4] = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "RadioButton_7")
  self._ui._gameSet.rdo_gameLife[5] = UI.getChildControl(self._ui._gameSet.stc_gameLifeTeamBg, "RadioButton_Etc")
  self._ui._gameSet.stc_gameTimeBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_TimelimitArea")
  self._ui._gameSet.txt_gameTimeTitle = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "StaticText_TimelimitTitle")
  self._ui._gameSet.rdo_gameTime = {}
  self._ui._gameSet.rdo_gameTime[1] = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "RadioButton_1")
  self._ui._gameSet.rdo_gameTime[2] = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "RadioButton_3")
  self._ui._gameSet.rdo_gameTime[3] = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "RadioButton_5")
  self._ui._gameSet.rdo_gameTime[4] = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "RadioButton_7")
  self._ui._gameSet.rdo_gameTime[5] = UI.getChildControl(self._ui._gameSet.stc_gameTimeBg, "RadioButton_Etc")
  self._ui._gameSet.stc_gameMemberBg = UI.getChildControl(self._ui._gameSet.stc_mainBg, "Static_PartymemberArea")
  self._ui._gameSet.txt_gameMemberTitle = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "StaticText_RoundTitle")
  self._ui._gameSet.rdo_gameMember = {}
  self._ui._gameSet.rdo_gameMember[1] = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "RadioButton_1")
  self._ui._gameSet.rdo_gameMember[2] = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "RadioButton_2")
  self._ui._gameSet.rdo_gameMember[3] = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "RadioButton_3")
  self._ui._gameSet.rdo_gameMember[4] = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "RadioButton_4")
  self._ui._gameSet.rdo_gameMember[5] = UI.getChildControl(self._ui._gameSet.stc_gameMemberBg, "RadioButton_Etc")
end
function PaGlobal_Arsha_Func_All:attenderSetInitControl()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui._attenderSet.stc_mainBg = UI.getChildControl(Panel_Window_Arsha_Func_All, "Static_TeamSettingArea")
  self._ui._attenderSet.stc_leftAreaBg = UI.getChildControl(self._ui._attenderSet.stc_mainBg, "Static_LeftPartTeam")
  self._ui._attenderSet.chk_lock = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "CheckButton_Lock")
  self._ui._attenderSet.txt_gameTypeName = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_LeftTeamName")
  self._ui._attenderSet.txt_limitTimeTitle = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_LimitTime")
  self._ui._attenderSet.txt_limitLevelTitle = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_LImitLevel")
  self._ui._attenderSet.txt_roundTitle = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_Round")
  self._ui._attenderSet.txt_roundValue = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_RoundValue")
  self._ui._attenderSet.txt_limitTimeValue = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_TimeValue")
  self._ui._attenderSet.txt_limitLevelValue = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "StaticText_LevelValue")
  self._ui._attenderSet.stc_noAdminImg = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Static_BackImage")
  self._ui._attenderSet.rdo_inviteWaiter = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "RadioButton_InviteWaiter")
  self._ui._attenderSet.rdo_inviteWatcher = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "RadioButton_InviteWatcher")
  self._ui._attenderSet.edit_inviteName = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Edit_InviteCharacterName")
  self._ui._attenderSet.btn_invite = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Button_Invite")
  self._ui._attenderSet.btn_inviteList = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Button_InviteList")
  self._ui._attenderSet.rdo_inviteWaiter:SetTextSpan((self._ui._attenderSet.rdo_inviteWaiter:GetSizeX() + 25) / 2 - self._ui._attenderSet.rdo_inviteWaiter:GetTextSizeX() / 2, 0)
  self._ui._attenderSet.rdo_inviteWatcher:SetTextSpan((self._ui._attenderSet.rdo_inviteWatcher:GetSizeX() + 25) / 2 - self._ui._attenderSet.rdo_inviteWatcher:GetTextSizeX() / 2, 0)
  self._ui._attenderSet.stc_waitTeamBg = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Static_WaitTeam")
  self._ui._attenderSet.stc_radioSubMenu = UI.getChildControl(self._ui._attenderSet.stc_waitTeamBg, "Static_SubRadioButtonBg")
  self._ui._attenderSet.rdo_waiter = UI.getChildControl(self._ui._attenderSet.stc_radioSubMenu, "RadioButton_GameSettings")
  self._ui._attenderSet.rdo_watcher = UI.getChildControl(self._ui._attenderSet.stc_radioSubMenu, "RadioButton_TeamSettings")
  self._ui._attenderSet.stc_selectBar = UI.getChildControl(self._ui._attenderSet.stc_radioSubMenu, "Static_SelectBar")
  self._ui._attenderSet.list2_waitList = UI.getChildControl(self._ui._attenderSet.stc_waitTeamBg, "List2_WaitList")
  self._ui._attenderSet.txt_waitLevelTitle = UI.getChildControl(self._ui._attenderSet.stc_waitTeamBg, "StaticText_LevelTitle")
  self._ui._attenderSet.txt_waitClassTitle = UI.getChildControl(self._ui._attenderSet.stc_waitTeamBg, "StaticText_ClassTitle")
  self._ui._attenderSet.txt_waitNameTitle = UI.getChildControl(self._ui._attenderSet.stc_waitTeamBg, "StaticText_Charname")
  self._ui._attenderSet.btn_exit = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Button_ArshaExit")
  self._ui._attenderSet.btn_GoWait = UI.getChildControl(self._ui._attenderSet.stc_leftAreaBg, "Button_WaitTeamGo")
  self._ui._attenderSet.stc_rightAreaBg = UI.getChildControl(self._ui._attenderSet.stc_mainBg, "Static_RightPartTeam")
  self._ui._attenderSet.list2_teamAList = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "List2_LeftList")
  self._ui._attenderSet.list2_teamBList = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "List2_RightList")
  self._ui._attenderSet.stc_frameBgBlue = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Static_BlueBG")
  self._ui._attenderSet.stc_frameBgRed = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Static_RedBG")
  self._ui._attenderSet.stc_frameBgYellow = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Static_AloneBg")
  self._ui._attenderSet.btn_GoTeamA = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Button_GoA")
  self._ui._attenderSet.btn_GoTeamB = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Button_GoB")
  self._ui._attenderSet.btn_teamATitleBg = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Button_LeftTitle")
  self._ui._attenderSet.txt_levelATitle = UI.getChildControl(self._ui._attenderSet.btn_teamATitleBg, "StaticText_Level")
  self._ui._attenderSet.txt_classATitle = UI.getChildControl(self._ui._attenderSet.btn_teamATitleBg, "StaticText_Class")
  self._ui._attenderSet.txt_nameATitle = UI.getChildControl(self._ui._attenderSet.btn_teamATitleBg, "StaticText_CharName")
  self._ui._attenderSet.btn_teamBTitleBg = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Button_RightTitle")
  self._ui._attenderSet.txt_levelBTitle = UI.getChildControl(self._ui._attenderSet.btn_teamBTitleBg, "StaticText_Level")
  self._ui._attenderSet.txt_classBTitle = UI.getChildControl(self._ui._attenderSet.btn_teamBTitleBg, "StaticText_Class")
  self._ui._attenderSet.txt_nameBTitle = UI.getChildControl(self._ui._attenderSet.btn_teamBTitleBg, "StaticText_CharName")
  self._ui._attenderSet.stc_teamAreaBg = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Static_TeamTitleArea")
  self._ui._attenderSet.stc_teamAArea = UI.getChildControl(self._ui._attenderSet.stc_teamAreaBg, "Static_LeftTeamTitleArea")
  self._ui._attenderSet.stc_teamAName = UI.getChildControl(self._ui._attenderSet.stc_teamAArea, "StaticText_LeftTeamName")
  self._ui._attenderSet.btn_teamAEditName = UI.getChildControl(self._ui._attenderSet.stc_teamAArea, "Button_EditLeftName")
  self._ui._attenderSet.stc_teamBArea = UI.getChildControl(self._ui._attenderSet.stc_teamAreaBg, "Static_RightTeamTitleArea")
  self._ui._attenderSet.stc_teamBName = UI.getChildControl(self._ui._attenderSet.stc_teamBArea, "StaticText_RightTeamName")
  self._ui._attenderSet.btn_teamBEditName = UI.getChildControl(self._ui._attenderSet.stc_teamBArea, "Button_EditRightName")
  self._ui._attenderSet.stc_teamVSicon = UI.getChildControl(self._ui._attenderSet.stc_teamAreaBg, "Static_VSIcon")
  self._ui._attenderSet.stc_teamCenterLine = UI.getChildControl(self._ui._attenderSet.stc_teamAreaBg, "Static_CenterLine")
  self._ui._attenderSet.stc_aloneAreaBg = UI.getChildControl(self._ui._attenderSet.stc_rightAreaBg, "Static_AloneTitleArea")
  self._ui._attenderSet.stc_aloneTeamA = UI.getChildControl(self._ui._attenderSet.stc_aloneAreaBg, "Static_LeftTeamTitleArea")
  self._ui._attenderSet.stc_aloneTeamB = UI.getChildControl(self._ui._attenderSet.stc_aloneAreaBg, "Static_RightTeamTitleArea")
  self._ui._attenderSet.stc_aloneCenterLine = UI.getChildControl(self._ui._attenderSet.stc_aloneAreaBg, "Static_CenterLine")
  self._ui._attenderSet.txt_aloneLifeTeam = UI.getChildControl(self._ui._attenderSet.stc_aloneAreaBg, "StaticText_LifeTeamCount")
  self._ui._attenderSet.txt_aloneLifeTeamValue = UI.getChildControl(self._ui._attenderSet.stc_aloneAreaBg, "StaticText_LifeTeamValue")
  self._baseSize.rightArea.y = self._ui._attenderSet.stc_rightAreaBg:GetSizeY()
  self._baseSize.leftList.y = self._ui._attenderSet.list2_teamAList:GetSizeY()
  self._baseSize.rightList.y = self._ui._attenderSet.list2_teamBList:GetSizeY()
  self._baseSize.edit_invite.x = self._ui._attenderSet.edit_inviteName:GetSizeX()
  self._baseSize.panel.y = Panel_Window_Arsha_Func_All:GetSizeY()
  self._baseSize.leftBg.y = self._ui._attenderSet.stc_leftAreaBg:GetSizeY()
  self._baseSize.leftListBg.y = self._ui._attenderSet.stc_frameBgRed:GetSizeY()
  self._baseSize.rightListBg.y = self._ui._attenderSet.stc_frameBgBlue:GetSizeY()
  self._baseSize.aloneListBg.y = self._ui._attenderSet.stc_frameBgYellow:GetSizeY()
  self._baseSize.exitBtn.x = self._ui._attenderSet.btn_exit:GetSizeX()
  self._basePos.leftTitle.y = self._ui._attenderSet.btn_teamATitleBg:GetSpanSize().y
  self._basePos.rightTitle.y = self._ui._attenderSet.btn_teamBTitleBg:GetSpanSize().y
  self._aloneViewDiffSize.y = self._ui._attenderSet.stc_teamAreaBg:GetSizeY() - self._ui._attenderSet.stc_aloneAreaBg:GetSizeY()
end
function PaGlobal_Arsha_Func_All:consoleInitControl()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui_console.stc_mainRadioLB = UI.getChildControl(self._ui.stc_radioMenu, "Static_LB_ConsoleUI")
  self._ui_console.stc_mainRadioRB = UI.getChildControl(self._ui.stc_radioMenu, "Static_RB_ConsoleUI")
  self._ui_console.stc_subRadioLB = UI.getChildControl(self._ui._attenderSet.stc_radioSubMenu, "Static_LB_ConsoleUI")
  self._ui_console.stc_subRadioRB = UI.getChildControl(self._ui._attenderSet.stc_radioSubMenu, "Static_RB_ConsoleUI")
  self._ui_console.stc_editGuideX = UI.getChildControl(self._ui._attenderSet.edit_inviteName, "StaticText_X_ConsoleUI")
  self._ui_console.stc_bottomKeyGuideBg = UI.getChildControl(Panel_Window_Arsha_Func_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_keyGuideY = UI.getChildControl(self._ui_console.stc_bottomKeyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui_console.stc_keyGuideA = UI.getChildControl(self._ui_console.stc_bottomKeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_keyGuideB = UI.getChildControl(self._ui_console.stc_bottomKeyGuideBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_Arsha_Func_All:subMenuInitControl()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui_subMenu.btn_kick = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Button_Kick")
  self._ui_subMenu.btn_kickAll = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Button_KickAll")
  self._ui_subMenu.btn_teamChange = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Button_TeamChange")
  self._ui_subMenu.btn_subMaster = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Button_SubMaster")
  self._ui_subMenu.btn_teamMaster = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Button_TeamMaster")
  self._ui_subMenu.stc_keyGuideBg = UI.getChildControl(Panel_Window_ArshaPvPSubMenu_All, "Static_KeyGuide_ConsoleUI")
  self._ui_subMenu.txt_keyGuideA = UI.getChildControl(self._ui_subMenu.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_subMenu.txt_keyGuideB = UI.getChildControl(self._ui_subMenu.stc_keyGuideBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_Arsha_Func_All:switchPlatform(isConsole)
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  local matchMode = ToClient_CompetitionMatchType()
  local gabY = 10
  local gabX = 10
  self._ui_console.stc_mainRadioLB:SetShow(isConsole and isHost)
  self._ui_console.stc_mainRadioRB:SetShow(isConsole and isHost)
  self._ui_console.stc_subRadioLB:SetShow(isConsole)
  self._ui_console.stc_subRadioRB:SetShow(isConsole)
  self._ui_console.stc_editGuideX:SetShow(isConsole)
  self._ui_console.stc_bottomKeyGuideBg:SetShow(isConsole)
  self._ui_subMenu.stc_keyGuideBg:SetShow(isConsole)
  self._ui._attenderSet.btn_invite:SetShow(not isConsole and (isHost or isSubHost))
  self._ui._attenderSet.btn_inviteList:SetShow(not isConsole and (isHost or isSubHost))
  self._ui._attenderSet.btn_exit:SetShow(not isConsole)
  self._ui._attenderSet.btn_GoWait:SetShow(not isConsole and not self._isWatcher)
  local isTeamChangeAble = CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode or CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode
  self._ui._attenderSet.btn_GoTeamA:SetShow(not isConsole and isTeamChangeAble and not self._isWatcher)
  self._ui._attenderSet.btn_GoTeamB:SetShow(not isConsole and isTeamChangeAble and not self._isWatcher)
  self._ui._attenderSet.btn_teamAEditName:SetShow(not isConsole and isHost)
  self._ui._attenderSet.btn_teamBEditName:SetShow(not isConsole and isHost)
  self._ui.btn_gameStart:SetShow(not isConsole and isHost)
  self._ui.btn_gameStop:SetShow(not isConsole and isHost)
  self._ui.btn_allResurrection:SetShow(not isConsole and isHost)
  if true == self._isConsole then
    local editAddSizeX = self._ui._attenderSet.btn_invite:GetSizeX() + self._ui._attenderSet.btn_inviteList:GetSizeX()
    self._ui._attenderSet.edit_inviteName:SetSize(self._baseSize.edit_invite.x + editAddSizeX, self._ui._attenderSet.edit_inviteName:GetSizeY())
    self._ui._attenderSet.edit_inviteName:ComputePos()
    self._ui_console.stc_editGuideX:ComputePos()
    local btnMinusSizeY = self._ui.btn_allResurrection:GetSizeY() + gabY * 2
    self._ui._attenderSet.stc_leftAreaBg:SetSize(self._ui._attenderSet.stc_leftAreaBg:GetSizeX(), self._baseSize.leftBg.y - btnMinusSizeY)
    Panel_Window_Arsha_Func_All:SetSize(Panel_Window_Arsha_Func_All:GetSizeX(), self._baseSize.panel.y - btnMinusSizeY)
    self._ui_console.stc_bottomKeyGuideBg:ComputePos()
    Panel_Window_ArshaPvPSubMenu_All:ignorePadSnapMoveToOtherPanel()
    self:setSubMenuAlignKeyGuide()
  end
  if true == self._isWatcher then
    self._ui._attenderSet.btn_exit:SetSize(self._baseSize.exitBtn.x + gabX + self._ui._attenderSet.btn_GoWait:GetSizeX(), self._ui._attenderSet.btn_exit:GetSizeY())
  end
end
function PaGlobal_Arsha_Func_All:switchAdmin()
  local isHost = ToClient_IsCompetitionHost()
  local isSubHost = ToClient_IsCompetitionAssistant()
  for ii = 1, self._notHostHideControl:length() do
    self._notHostHideControl[ii]:SetShow(false)
  end
  if true == isHost then
    for ii = 1, self._notHostHideControl:length() do
      self._notHostHideControl[ii]:SetShow(true)
    end
  elseif true == isSubHost then
    for ii = 1, self._subHostShowControl:length() do
      self._subHostShowControl[ii]:SetShow(true)
    end
  end
  if true == isHost then
    self._ui.rdo_gameSetting:SetShow(true)
    self._ui.rdo_teamSetting:SetShow(true)
    self._ui.rdo_gameSetting:SetSpanSize(self._basePos.mainRadio.gameSet, self._ui.rdo_gameSetting:GetSpanSize().y)
    self._ui.rdo_teamSetting:SetSpanSize(self._basePos.mainRadio.teamSet, self._ui.rdo_teamSetting:GetSpanSize().y)
    self._ui.rdo_gameSetting:ComputePos()
    self._ui.rdo_teamSetting:ComputePos()
    self._ui._attenderSet.stc_noAdminImg:SetShow(false)
    if true == self._isConsole then
      Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandlePadEventLBRB_Arsha_Func_All_MainTabChange(-1)")
      Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandlePadEventLBRB_Arsha_Func_All_MainTabChange(1)")
      Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Arsha_Func_All_SetFocusInviteName()")
    end
  else
    self._ui.rdo_gameSetting:SetShow(false)
    self._ui.rdo_teamSetting:SetShow(true)
    self._ui.rdo_teamSetting:SetSpanSize(0, self._ui.rdo_teamSetting:GetSpanSize().y)
    self._ui.rdo_gameSetting:ComputePos()
    self._ui.rdo_teamSetting:ComputePos()
    if true == isSubHost then
      self._ui._attenderSet.stc_noAdminImg:SetShow(false)
      Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Arsha_Func_All_SetFocusInviteName()")
    else
      self._ui._attenderSet.stc_noAdminImg:SetShow(true)
    end
  end
  self:setAlignKeyGuide()
end
function PaGlobal_Arsha_Func_All:prepareOpen()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  if false == ToClient_IsGrowStepOpen(__eGrowStep_arsha) then
    return
  end
  local myTeamNo = ToClient_GetMyTeamNo()
  if myTeamNo < 0 then
    self._isWatcher = true
  end
  self._ui._attenderSet.rdo_inviteWaiter:SetCheck(true)
  self._ui._attenderSet.rdo_inviteWatcher:SetCheck(false)
  self._ui._attenderSet.list2_waitList:moveTopIndex()
  self._ui._attenderSet.list2_teamAList:moveTopIndex()
  self._ui._attenderSet.list2_teamBList:moveTopIndex()
  PaGlobal_Arsha_Func_All:open()
  PaGlobal_Arsha_Func_All:update()
  PaGlobal_Arsha_Func_All:resize()
end
function PaGlobal_Arsha_Func_All:open()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  Panel_Window_Arsha_Func_All:SetShow(true)
end
function PaGlobal_Arsha_Func_All:prepareClose()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:dataclear()
  PaGlobalFunc_Arsha_Func_All_SubMenuPowerClose()
  PaGlobal_Arsha_Func_All:close()
end
function PaGlobal_Arsha_Func_All:close()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  Panel_Window_Arsha_Func_All:SetShow(false)
end
function PaGlobal_Arsha_Func_All:dataclear()
  self._curMenu = self._menuType.ATTENDER
  self._curWaitList = self._waitListType.WAITER
  self._curCompetitionMatchType = nil
  PaGlobalFunc_Arsha_Func_All_ClearFocusEdit()
  Panel_NumberPad_Close()
end
function PaGlobal_Arsha_Func_All:update()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:switchAdmin()
  self:switchPlatform(self._isConsole)
  self:selectMainMenu(self._curMenu)
  if self._menuType.ATTENDER == self._curMenu then
    self:selectWaitList(self._curWaitList)
    self:updateModeDesc()
    self:updateList()
  elseif self._menuType.GAME == self._curMenu then
    self:updateGameSetMenuShow()
    self:updateGameSetMenuValue()
  end
end
function PaGlobal_Arsha_Func_All:setAlignKeyGuide()
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui_console.stc_keyGuideY,
    self._ui_console.stc_keyGuideA,
    self._ui_console.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottomKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_Func_All:setSubMenuAlignKeyGuide()
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui_subMenu.txt_keyGuideA,
    self._ui_subMenu.txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_subMenu.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_Func_All:selectMainMenu(menuIdx)
  if nil == self._mainRadioMenu[menuIdx] then
    _PA_ASSERT_NAME(false, "ArshaFuncWindow main menu\236\157\152 menuIdx\234\176\128 \236\157\180\236\131\129\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  for ii = 1, #self._mainRadioMenu do
    self._mainRadioMenu[ii]:SetCheck(false)
  end
  self._mainRadioMenu[menuIdx]:SetCheck(true)
  self._curMenu = menuIdx
  local selectBarControl = self._mainRadioMenu[menuIdx]
  self._ui.stc_selectBar:SetPosX(selectBarControl:GetPosX() + selectBarControl:GetSizeX() / 2 - self._ui.stc_selectBar:GetSizeX() / 2)
  if self._menuType.GAME == menuIdx then
    self._ui._gameSet.stc_mainBg:SetShow(true)
    self._ui._attenderSet.stc_mainBg:SetShow(false)
  else
    self._ui._gameSet.stc_mainBg:SetShow(false)
    self._ui._attenderSet.stc_mainBg:SetShow(true)
  end
end
function PaGlobal_Arsha_Func_All:selectWaitList(menuIdx)
  if nil == self._waitRadioMenu[menuIdx] then
    _PA_ASSERT_NAME(false, "ArshaFuncWindow waitList menu\236\157\152 menuIdx\234\176\128 \236\157\180\236\131\129\237\149\169\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  for ii = 1, #self._waitRadioMenu do
    self._waitRadioMenu[ii]:SetCheck(false)
  end
  self._waitRadioMenu[menuIdx]:SetCheck(true)
  self._curWaitList = menuIdx
  local selectBarControl = self._waitRadioMenu[menuIdx]
  self._ui._attenderSet.stc_selectBar:SetPosX(selectBarControl:GetPosX() + selectBarControl:GetSizeX() / 2 - self._ui._attenderSet.stc_selectBar:GetSizeX() / 2)
end
function PaGlobal_Arsha_Func_All:updateModeDesc()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local isSubHost = ToClient_IsCompetitionAssistant()
  local matchMode = ToClient_CompetitionMatchType()
  local isLimitSecondTime = ToClient_CompetitionMatchTimeLimit()
  local levelLimit = ToClient_GetLevelLimit()
  local targetScore = ToClient_GetTargetScore()
  local isOpen = ToClient_IsCompetitionOpen_HostOnly()
  self._isOpen = isOpen
  self._targetScore = targetScore
  self._levelLimit = levelLimit
  if nil ~= self._gameTypeStr[matchMode] then
    self._ui._attenderSet.txt_gameTypeName:SetText(self._gameTypeStr[matchMode])
  else
    self._ui._attenderSet.txt_gameTypeName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARSHA_TEAMMODE_TITLE"))
  end
  self._ui._attenderSet.stc_teamAreaBg:SetShow(false)
  self._ui._attenderSet.stc_aloneAreaBg:SetShow(false)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
    self._ui._attenderSet.stc_teamAreaBg:SetShow(true)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchMode then
    self._ui._attenderSet.stc_aloneAreaBg:SetShow(true)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
    self._ui._attenderSet.stc_teamAreaBg:SetShow(true)
  else
    self._ui._attenderSet.stc_teamAreaBg:SetShow(true)
  end
  if true == isOpen then
    self._ui._attenderSet.chk_lock:SetCheck(false)
  else
    self._ui._attenderSet.chk_lock:SetCheck(true)
  end
  local limitMinuteTime = 0
  local limitSecondTime = 0
  if 60 <= isLimitSecondTime then
    limitMinuteTime = math.floor(isLimitSecondTime / 60)
    limitSecondTime = math.ceil(isLimitSecondTime % 60)
    self._ui._attenderSet.txt_limitTimeValue:SetText(limitMinuteTime .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE"))
    if 0 < limitSecondTime then
      self._ui._attenderSet.txt_limitTimeValue:SetText(self._ui._attenderSet.txt_limitTimeValue:GetText() .. limitSecondTime .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"))
    end
  else
    limitSecondTime = isLimitSecondTime
    self._ui._attenderSet.txt_limitTimeValue:SetText(limitMinuteTime .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"))
  end
  self._timeLimit = limitMinuteTime
  self._ui._attenderSet.txt_limitLevelValue:SetText(levelLimit)
  self._ui._attenderSet.txt_roundValue:SetTextMode(__eTextMode_AutoWrap)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
    local roundCount = targetScore * 2 - 1
    self._ui._attenderSet.txt_roundValue:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_ARSHA_FUNC_ROUNDVALUE_ROUND", "roundCount", roundCount, "targetScore", targetScore))
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchMode then
    self._ui._attenderSet.txt_roundValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_ARSHA_FUNC_ROUNDVALUE_FREEFORALL"))
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
    self._ui._attenderSet.txt_roundValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_ARSHA_FUNC_ROUNDVALUE_PERSONAL"))
  end
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchMode then
    local roundCount = targetScore * 2 - 1
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchMode then
    self._ui._attenderSet.txt_aloneLifeTeamValue:SetText(targetScore)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchMode then
    local currentRound = ToClient_GetCurrentRound()
    if currentRound <= 0 then
      currentRound = 1
    end
  end
end
function PaGlobal_Arsha_Func_All:updateList()
  local matchType = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    self:roundUpdate()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    self:freeForAllUpdate()
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    self:personalUpdate()
  end
end
function PaGlobal_Arsha_Func_All:saveScrollValue(listControl)
  local toIndex = listControl:getCurrenttoIndex()
  local scrollvalue = 0
  local lastTopIndex = 0
  if 0 ~= toIndex then
    lastTopIndex = toIndex
    scrollvalue = listControl:GetVScroll():GetControlPos()
  end
  return lastTopIndex, scrollvalue
end
function PaGlobal_Arsha_Func_All:setScrollValue(listControl, topIndex, scrollValue)
  if 0 ~= _lastTopIndex then
    listControl:setCurrenttoIndex(_lastTopIndex)
    listControl:GetVScroll():SetControlPos(_scrollValue)
    _lastTopIndex = nil
    _scrollValue = nil
  end
end
function PaGlobal_Arsha_Func_All:roundUpdate()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:teamView()
  local ListTeamACount = ToClient_GetTeamUserInfoCount(1)
  self._ui._attenderSet.list2_teamAList:getElementManager():clearKey()
  if 0 < ListTeamACount then
    for idx = 0, ListTeamACount - 1 do
      self._ui._attenderSet.list2_teamAList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListTeamBCount = ToClient_GetTeamUserInfoCount(2)
  self._ui._attenderSet.list2_teamBList:getElementManager():clearKey()
  if 0 < ListTeamBCount then
    for idx = 0, ListTeamBCount - 1 do
      self._ui._attenderSet.list2_teamBList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListWaitCount = 0
  if true == self._ui._attenderSet.rdo_waiter:IsCheck() then
    ListWaitCount = ToClient_GetTeamUserInfoCount(0)
  else
    ListWaitCount = ToClient_GetObserverListCount()
  end
  self._ui._attenderSet.list2_waitList:getElementManager():clearKey()
  if 0 < ListWaitCount then
    for idx = 0, ListWaitCount - 1 do
      self._ui._attenderSet.list2_waitList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  self:setTeamName()
end
function PaGlobal_Arsha_Func_All:freeForAllUpdate()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:freeView()
  local ListPartyMasterCount = ToClient_GetTeamListCountWithOutZero()
  self._ui._attenderSet.list2_teamAList:getElementManager():clearKey()
  if 0 < ListPartyMasterCount then
    for idx = 0, ListPartyMasterCount - 1 do
      self._ui._attenderSet.list2_teamAList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListAllUserCount = ToClient_GetEntryListCount()
  self._ui._attenderSet.list2_teamBList:getElementManager():clearKey()
  if 0 < ListAllUserCount then
    for idx = 0, ListAllUserCount - 1 do
      self._ui._attenderSet.list2_teamBList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListWaitCount = 0
  if true == self._ui._attenderSet.rdo_waiter:IsCheck() then
    ListWaitCount = ToClient_GetTeamUserInfoCount(0)
  else
    ListWaitCount = ToClient_GetObserverListCount()
  end
  self._ui._attenderSet.list2_waitList:getElementManager():clearKey()
  if 0 < ListWaitCount then
    for idx = 0, ListWaitCount - 1 do
      self._ui._attenderSet.list2_waitList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
end
function PaGlobal_Arsha_Func_All:personalUpdate()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self:teamView()
  local ListTeamACount = ToClient_GetTeamUserInfoCount(1)
  self._ui._attenderSet.list2_teamAList:getElementManager():clearKey()
  if 0 < ListTeamACount then
    for idx = 0, ListTeamACount - 1 do
      self._ui._attenderSet.list2_teamAList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListTeamBCount = ToClient_GetTeamUserInfoCount(2)
  self._ui._attenderSet.list2_teamBList:getElementManager():clearKey()
  if 0 < ListTeamBCount then
    for idx = 0, ListTeamBCount - 1 do
      self._ui._attenderSet.list2_teamBList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  local ListWaitCount = 0
  if true == self._ui._attenderSet.rdo_waiter:IsCheck() then
    ListWaitCount = ToClient_GetTeamUserInfoCount(0)
  else
    ListWaitCount = ToClient_GetObserverListCount()
  end
  self._ui._attenderSet.list2_waitList:getElementManager():clearKey()
  if 0 < ListWaitCount then
    for idx = 0, ListWaitCount - 1 do
      self._ui._attenderSet.list2_waitList:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  self:setTeamName()
end
function PaGlobal_Arsha_Func_All:setTeamName()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local teamA_Info = ToClient_GetArshaTeamInfo(1)
  local teamB_Info = ToClient_GetArshaTeamInfo(2)
  local teamA_Name = ""
  local teamB_Name = ""
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
  end
  self._ui._attenderSet.stc_teamAName:SetText(teamA_Name)
  self._ui._attenderSet.stc_teamBName:SetText(teamB_Name)
end
function PaGlobal_Arsha_Func_All:updateGameSetMenuShow()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local matchType = ToClient_CompetitionMatchType()
  if self._curCompetitionMatchType == matchType then
    return
  end
  self._curCompetitionMatchType = matchType
  for ii = 1, self._gameSetMenuControl:length() do
    self._gameSetMenuControl[ii]:SetShow(false)
  end
  local startPosY = self._gameSetMenuControl[1]:GetPosY()
  local menuBgSizeY = self._gameSetMenuControl[1]:GetSizeY()
  local gabSizeY = 10
  self._gameSetShowcontrol = Array.new()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == matchType then
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTypeBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameLevelBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameRoundBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTimeBg)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == matchType then
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTypeBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameLevelBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameLifeTeamBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTimeBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameMemberBg)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == matchType then
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTypeBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameTimeBg)
    self._gameSetShowcontrol:push_back(self._ui._gameSet.stc_gameLevelBg)
  end
  for ii = 1, self._gameSetShowcontrol:length() do
    self._gameSetShowcontrol[ii]:SetShow(true)
    self._gameSetShowcontrol[ii]:SetPosY(startPosY)
    startPosY = startPosY + menuBgSizeY + gabSizeY
  end
end
function PaGlobal_Arsha_Func_All:updateGameSetMenuValue()
  local checkInit = function(radioList)
    for ii = 1, #radioList do
      radioList[ii]:SetCheck(false)
    end
  end
  if true == self._ui._gameSet.stc_gameTypeBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameType)
    local matchType = ToClient_CompetitionMatchType()
    self._ui._gameSet.rdo_gameType[matchType + 1]:SetCheck(true)
  end
  if true == self._ui._gameSet.stc_gameLevelBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameLevel)
    local levelLimit = ToClient_GetLevelLimit()
    if 55 == levelLimit then
      self._ui._gameSet.rdo_gameLevel[1]:SetCheck(true)
    elseif 60 == levelLimit then
      self._ui._gameSet.rdo_gameLevel[2]:SetCheck(true)
    else
      self._ui._gameSet.rdo_gameLevel[3]:SetText(tostring(levelLimit))
      self._ui._gameSet.rdo_gameLevel[3]:SetCheck(true)
    end
  end
  if true == self._ui._gameSet.stc_gameRoundBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameRound)
    local targetCount = ToClient_GetTargetScore()
    if 1 == targetCount then
      self._ui._gameSet.rdo_gameRound[1]:SetCheck(true)
    elseif 3 == targetCount then
      self._ui._gameSet.rdo_gameRound[2]:SetCheck(true)
    elseif 5 == targetCount then
      self._ui._gameSet.rdo_gameRound[3]:SetCheck(true)
    elseif 7 == targetCount then
      self._ui._gameSet.rdo_gameRound[4]:SetCheck(true)
    else
      self._ui._gameSet.rdo_gameRound[5]:SetText(tostring(targetCount))
      self._ui._gameSet.rdo_gameRound[5]:SetCheck(true)
    end
  end
  if true == self._ui._gameSet.stc_gameLifeTeamBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameLife)
    local lifePartyCount = ToClient_GetTargetScore()
    if 1 == lifePartyCount then
      self._ui._gameSet.rdo_gameLife[1]:SetCheck(true)
    elseif 3 == lifePartyCount then
      self._ui._gameSet.rdo_gameLife[2]:SetCheck(true)
    elseif 5 == lifePartyCount then
      self._ui._gameSet.rdo_gameLife[3]:SetCheck(true)
    elseif 7 == lifePartyCount then
      self._ui._gameSet.rdo_gameLife[4]:SetCheck(true)
    else
      self._ui._gameSet.rdo_gameLife[5]:SetText(tostring(lifePartyCount))
      self._ui._gameSet.rdo_gameLife[5]:SetCheck(true)
    end
  end
  if true == self._ui._gameSet.stc_gameTimeBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameTime)
    local limitTimeSecond = ToClient_CompetitionMatchTimeLimit()
    local limitTimeMinute = 0
    if 60 <= limitTimeSecond then
      limitTimeMinute = math.floor(limitTimeSecond / 60)
      limitTimeSecond = math.ceil(limitTimeSecond % 60)
    end
    if 1 == limitTimeMinute then
      self._ui._gameSet.rdo_gameTime[1]:SetCheck(true)
    elseif 3 == limitTimeMinute then
      self._ui._gameSet.rdo_gameTime[2]:SetCheck(true)
    elseif 5 == limitTimeMinute then
      self._ui._gameSet.rdo_gameTime[3]:SetCheck(true)
    elseif 7 == limitTimeMinute then
      self._ui._gameSet.rdo_gameTime[4]:SetCheck(true)
    else
      self._ui._gameSet.rdo_gameTime[5]:SetText(tostring(limitTimeMinute))
      self._ui._gameSet.rdo_gameTime[5]:SetCheck(true)
    end
  end
  if true == self._ui._gameSet.stc_gameMemberBg:GetShow() then
    checkInit(self._ui._gameSet.rdo_gameMember)
    local maxParyMemberCount = ToClient_GetMaxPartyMemberCount()
    if 1 == maxParyMemberCount then
      self._ui._gameSet.rdo_gameMember[1]:SetCheck(true)
    elseif 2 == maxParyMemberCount then
      self._ui._gameSet.rdo_gameMember[2]:SetCheck(true)
    elseif 3 == maxParyMemberCount then
      self._ui._gameSet.rdo_gameMember[3]:SetCheck(true)
    elseif 4 == maxParyMemberCount then
      self._ui._gameSet.rdo_gameMember[4]:SetCheck(true)
    else
      self._ui._gameSet.rdo_gameMember[5]:SetText(tostring(maxParyMemberCount))
      self._ui._gameSet.rdo_gameMember[5]:SetCheck(true)
    end
  end
end
function PaGlobal_Arsha_Func_All:registEventHandler()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_Close()")
  self._ui.btn_allResurrection:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_AllPlayerResurrection()")
  self._ui.btn_gameStart:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameStart()")
  self._ui.btn_gameStop:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameStop()")
  self._ui.rdo_gameSetting:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_SelectMainMenu(" .. self._menuType.GAME .. ")")
  self._ui.rdo_teamSetting:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_SelectMainMenu(" .. self._menuType.ATTENDER .. ")")
  for ii = 1, #self._ui._gameSet.rdo_gameType do
    self._ui._gameSet.rdo_gameType[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetModeChange(" .. ii - 1 .. ")")
    if ii ~= #self._ui._gameSet.rdo_gameType then
      self._ui._gameSet.rdo_gameType[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_Arsha_Func_All_GameSetModeTooltip(true," .. ii - 1 .. ")")
      self._ui._gameSet.rdo_gameType[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_Arsha_Func_All_GameSetModeTooltip(false," .. ii - 1 .. ")")
    end
  end
  for ii = 1, #self._ui._gameSet.rdo_gameLevel do
    self._ui._gameSet.rdo_gameLevel[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetLevelChange(" .. ii .. ")")
  end
  for ii = 1, #self._ui._gameSet.rdo_gameRound do
    self._ui._gameSet.rdo_gameRound[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetRoundChange(" .. ii .. ")")
  end
  for ii = 1, #self._ui._gameSet.rdo_gameLife do
    self._ui._gameSet.rdo_gameLife[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetLifePartyChange(" .. ii .. ")")
  end
  for ii = 1, #self._ui._gameSet.rdo_gameTime do
    self._ui._gameSet.rdo_gameTime[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetTimeLimitChange(" .. ii .. ")")
  end
  for ii = 1, #self._ui._gameSet.rdo_gameMember do
    self._ui._gameSet.rdo_gameMember[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_GameSetMaxMemberChange(" .. ii .. ")")
  end
  local gameSetTooltipList = {
    [1] = self._ui._gameSet.txt_gameLevelTitle,
    [2] = self._ui._gameSet.txt_gameRoundTitle,
    [3] = self._ui._gameSet.txt_gameLifeTitle,
    [4] = self._ui._gameSet.txt_gameTimeTitle,
    [5] = self._ui._gameSet.txt_gameMemberTitle
  }
  for ii = 1, #gameSetTooltipList do
    gameSetTooltipList[ii]:SetIgnore(false)
    gameSetTooltipList[ii]:SetEnableArea(0, 0, gameSetTooltipList[ii]:GetTextSizeX(), gameSetTooltipList[ii]:GetSizeY())
    gameSetTooltipList[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_Arsha_Func_All_GameSetTooltip(true," .. ii .. ")")
    gameSetTooltipList[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_Arsha_Func_All_GameSetTooltip(false," .. ii .. ")")
  end
  self._ui._attenderSet.rdo_waiter:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_SelectWaitMenu(" .. self._waitListType.WAITER .. ")")
  self._ui._attenderSet.rdo_watcher:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_SelectWaitMenu(" .. self._waitListType.WATCHER .. ")")
  self._ui._attenderSet.edit_inviteName:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_SetFocusInviteName()")
  self._ui._attenderSet.edit_inviteName:RegistReturnKeyEvent("HandleEventLUp_Arsha_Func_All_InviteConfirm()")
  self._ui._attenderSet.btn_invite:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_InviteConfirm()")
  self._ui._attenderSet.btn_inviteList:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_InviteListOpen()")
  self._ui._attenderSet.chk_lock:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_OpenOrClose()")
  self._ui._attenderSet.btn_teamAEditName:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_ChangeTeamNameOpen(" .. 1 .. ")")
  self._ui._attenderSet.btn_teamBEditName:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_ChangeTeamNameOpen(" .. 2 .. ")")
  self._ui._attenderSet.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_Exit()")
  self._ui._attenderSet.btn_GoWait:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamChange(" .. 0 .. ")")
  self._ui._attenderSet.btn_GoTeamA:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamChange(" .. 1 .. ")")
  self._ui._attenderSet.btn_GoTeamB:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_Func_All_TeamChange(" .. 2 .. ")")
  self._ui._attenderSet.list2_waitList:changeAnimationSpeed(10)
  self._ui._attenderSet.list2_waitList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Arsha_Func_All_WaitUpdate")
  self._ui._attenderSet.list2_waitList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._attenderSet.list2_teamAList:changeAnimationSpeed(10)
  self._ui._attenderSet.list2_teamAList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Arsha_Func_All_TeamAListUpdate")
  self._ui._attenderSet.list2_teamAList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._attenderSet.list2_teamBList:changeAnimationSpeed(10)
  self._ui._attenderSet.list2_teamBList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Arsha_Func_All_TeamBListUpdate")
  self._ui._attenderSet.list2_teamBList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui_subMenu.btn_kick:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  self._ui_subMenu.btn_kickAll:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  self._ui_subMenu.btn_teamChange:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  self._ui_subMenu.btn_subMaster:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  self._ui_subMenu.btn_teamMaster:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  Panel_Window_ArshaPvPSubMenu_All:addInputEvent("Mouse_Out", "HandleEventOut_Arsha_Func_All_SubMenuOff()")
  local commonTooltipList = {
    [1] = self._ui.btn_allResurrection,
    [2] = self._ui.btn_gameStop,
    [3] = self._ui.btn_gameStart,
    [4] = self._ui._attenderSet.chk_lock,
    [5] = self._ui._attenderSet.btn_inviteList,
    [6] = self._ui._attenderSet.btn_exit,
    [7] = self._ui._attenderSet.rdo_waiter,
    [8] = self._ui._attenderSet.rdo_watcher
  }
  for ii = 1, #commonTooltipList do
    commonTooltipList[ii]:SetIgnore(false)
    commonTooltipList[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_Arsha_Func_All_CommonTooltip(true," .. ii .. ")")
    commonTooltipList[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_Arsha_Func_All_CommonTooltip(false," .. ii .. ")")
  end
  if true == self._isConsole then
    Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandlePadEventLTRT_Arsha_Func_All_SubTabChange(-1)")
    Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandlePadEventLTRT_Arsha_Func_All_SubTabChange(1)")
    Panel_Window_Arsha_Func_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandlePadEventY_Arsha_Func_All_FuncListOpen()")
    self._ui._attenderSet.edit_inviteName:setXboxVirtualKeyBoardEndEvent("HandleVirtualKeyEndEvent_Arsha_Func_All_InviteName")
  end
  registerEvent("FromClient_UpdateObserverList", "FromClient_Arsha_Func_All_UpdateTeamUserList")
  registerEvent("FromClient_UpdateEntryList", "FromClient_Arsha_Func_All_UpdateTeamUserList")
  registerEvent("FromClient_ChangeMatchType", "FromClient_Arsha_Func_All_ChangeMatchType")
  registerEvent("FromClient_UpdateTeamScore", "FromClient_Arsha_Func_All_UpdateTeamScore")
  registerEvent("FromClient_CompetitionMatchDone", "FromClient_Arsha_Func_All_CompetitionMatchDone")
  registerEvent("FromClient_CompetitionOptionChanged", "FromClient_Arsha_Func_All_CompetitionOptionChange")
  registerEvent("FromClient_CompetitionUseItemModeChanged", "FromClient_Arsha_Func_All_CompetitionUseItemModeChange")
  registerEvent("FromClient_JoinNewPlayer", "FromClient_Arsha_Func_All_JoinNewPlayer")
  registerEvent("FromClient_KillHistory", "FromClient_Arsha_Func_All_KillHistory")
  registerEvent("FromClient_EntryUserChangeTeam", "FromClient_Arsha_Func_All_EntryUserChangeTeam")
  registerEvent("FromClient_GetOutUserFromCompetition", "FromClient_Arsha_Func_All_GetOutUserFromCompetition")
  registerEvent("FromClient_ChangeAssistant", "FromClient_Arsha_Func_All_ChangeAssistant")
  registerEvent("FromClient_NotifyUseSkill", "FromClient_Arsha_Func_All_NotifyUseSkill")
  registerEvent("FromClient_NotifyUseSkillCoolTime", "FromClient_Arsha_Func_All_NotifyUseSkillCoolTime")
  registerEvent("FromClient_ChangeTeamName", "FromClient_Arsha_Func_All_ChangeTeamName")
  registerEvent("FromClient_CompetitionMatchDoneToObserver", "FromClient_Arsha_Func_All_CompetitionMatchDoneToObserver")
  Panel_Window_Arsha_Func_All:RegisterUpdateFunc("SkillCooltime_UpdatePerFrame")
end
function PaGlobal_Arsha_Func_All:validate()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_decoImg:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_radioMenu:isValidate()
  self._ui.rdo_gameSetting:isValidate()
  self._ui.rdo_teamSetting:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.btn_gameStart:isValidate()
  self._ui.btn_gameStop:isValidate()
  self._ui.btn_allResurrection:isValidate()
  self._ui._gameSet.stc_mainBg:isValidate()
  self._ui._gameSet.stc_gameTypeBg:isValidate()
  self._ui._gameSet.txt_gameTypeTitle:isValidate()
  self._ui._gameSet.stc_gameLevelBg:isValidate()
  self._ui._gameSet.txt_gameLevelTitle:isValidate()
  self._ui._gameSet.stc_gameRoundBg:isValidate()
  self._ui._gameSet.txt_gameRoundTitle:isValidate()
  self._ui._gameSet.stc_gameTimeBg:isValidate()
  self._ui._gameSet.txt_gameTimeTitle:isValidate()
  self._ui._gameSet.stc_gameMemberBg:isValidate()
  self._ui._gameSet.txt_gameMemberTitle:isValidate()
  self._ui._attenderSet.stc_mainBg:isValidate()
  self._ui._attenderSet.stc_leftAreaBg:isValidate()
  self._ui._attenderSet.chk_lock:isValidate()
  self._ui._attenderSet.txt_gameTypeName:isValidate()
  self._ui._attenderSet.txt_limitTimeTitle:isValidate()
  self._ui._attenderSet.txt_limitLevelTitle:isValidate()
  self._ui._attenderSet.txt_roundTitle:isValidate()
  self._ui._attenderSet.txt_limitTimeValue:isValidate()
  self._ui._attenderSet.txt_limitLevelValue:isValidate()
  self._ui._attenderSet.txt_roundValue:isValidate()
  self._ui._attenderSet.stc_noAdminImg:isValidate()
  self._ui._attenderSet.rdo_inviteWaiter:isValidate()
  self._ui._attenderSet.rdo_inviteWatcher:isValidate()
  self._ui._attenderSet.edit_inviteName:isValidate()
  self._ui._attenderSet.btn_invite:isValidate()
  self._ui._attenderSet.btn_inviteList:isValidate()
  self._ui._attenderSet.stc_waitTeamBg:isValidate()
  self._ui._attenderSet.stc_radioSubMenu:isValidate()
  self._ui._attenderSet.rdo_waiter:isValidate()
  self._ui._attenderSet.rdo_watcher:isValidate()
  self._ui._attenderSet.stc_selectBar:isValidate()
  self._ui._attenderSet.list2_waitList:isValidate()
  self._ui._attenderSet.txt_waitLevelTitle:isValidate()
  self._ui._attenderSet.txt_waitClassTitle:isValidate()
  self._ui._attenderSet.txt_waitNameTitle:isValidate()
  self._ui._attenderSet.btn_exit:isValidate()
  self._ui._attenderSet.btn_GoWait:isValidate()
  self._ui._attenderSet.stc_rightAreaBg:isValidate()
  self._ui._attenderSet.list2_teamAList:isValidate()
  self._ui._attenderSet.list2_teamBList:isValidate()
  self._ui._attenderSet.stc_frameBgBlue:isValidate()
  self._ui._attenderSet.stc_frameBgRed:isValidate()
  self._ui._attenderSet.stc_frameBgYellow:isValidate()
  self._ui._attenderSet.btn_GoTeamA:isValidate()
  self._ui._attenderSet.btn_GoTeamB:isValidate()
  self._ui._attenderSet.btn_teamATitleBg:isValidate()
  self._ui._attenderSet.txt_levelATitle:isValidate()
  self._ui._attenderSet.txt_classATitle:isValidate()
  self._ui._attenderSet.txt_nameATitle:isValidate()
  self._ui._attenderSet.btn_teamBTitleBg:isValidate()
  self._ui._attenderSet.txt_levelBTitle:isValidate()
  self._ui._attenderSet.txt_classBTitle:isValidate()
  self._ui._attenderSet.txt_nameBTitle:isValidate()
  self._ui._attenderSet.stc_teamAreaBg:isValidate()
  self._ui._attenderSet.stc_teamAArea:isValidate()
  self._ui._attenderSet.stc_teamAName:isValidate()
  self._ui._attenderSet.btn_teamAEditName:isValidate()
  self._ui._attenderSet.stc_teamBArea:isValidate()
  self._ui._attenderSet.stc_teamBName:isValidate()
  self._ui._attenderSet.btn_teamBEditName:isValidate()
  self._ui._attenderSet.stc_teamVSicon:isValidate()
  self._ui._attenderSet.stc_teamCenterLine:isValidate()
  self._ui._attenderSet.stc_aloneAreaBg:isValidate()
  self._ui._attenderSet.stc_aloneTeamA:isValidate()
  self._ui._attenderSet.stc_aloneTeamB:isValidate()
  self._ui._attenderSet.stc_aloneCenterLine:isValidate()
  self._ui._attenderSet.txt_aloneLifeTeam:isValidate()
  self._ui._attenderSet.txt_aloneLifeTeamValue:isValidate()
  self._ui_console.stc_mainRadioLB:isValidate()
  self._ui_console.stc_mainRadioRB:isValidate()
  self._ui_console.stc_subRadioLB:isValidate()
  self._ui_console.stc_subRadioRB:isValidate()
end
function PaGlobal_Arsha_Func_All:resize()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  Panel_Window_Arsha_Func_All:ComputePos()
end
function PaGlobal_Arsha_Func_All:teamView()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local gabY = 10
  local addBottomSizeY = 0
  if false == self._isConsole then
    addBottomSizeY = self._ui.btn_gameStart:GetSizeY() + 2 * gabY
  end
  self._ui._attenderSet.stc_frameBgBlue:SetShow(true)
  self._ui._attenderSet.stc_frameBgRed:SetShow(true)
  self._ui._attenderSet.stc_frameBgYellow:SetShow(false)
  self._ui._attenderSet.btn_teamATitleBg:SetSpanSize(self._ui._attenderSet.btn_teamATitleBg:GetSpanSize().x, self._basePos.leftTitle.y)
  self._ui._attenderSet.btn_teamBTitleBg:SetSpanSize(self._ui._attenderSet.btn_teamBTitleBg:GetSpanSize().x, self._basePos.rightTitle.y)
  if true == isHost then
    self._ui._attenderSet.stc_rightAreaBg:SetSize(self._ui._attenderSet.stc_rightAreaBg:GetSizeX(), self._baseSize.rightArea.y)
    self._ui._attenderSet.list2_teamAList:SetSize(self._ui._attenderSet.list2_teamAList:GetSizeX(), self._baseSize.leftList.y)
    self._ui._attenderSet.list2_teamBList:SetSize(self._ui._attenderSet.list2_teamBList:GetSizeX(), self._baseSize.rightList.y)
    self._ui._attenderSet.list2_teamAList:SetSpanSize(0, 50)
    self._ui._attenderSet.list2_teamBList:SetSpanSize(0, 50)
  elseif true == self._isWatcher then
    self._ui._attenderSet.stc_rightAreaBg:SetSize(self._ui._attenderSet.stc_rightAreaBg:GetSizeX(), self._ui._attenderSet.stc_leftAreaBg:GetSizeY())
    self._ui._attenderSet.stc_frameBgBlue:SetSize(self._ui._attenderSet.stc_frameBgBlue:GetSizeX(), self._baseSize.leftListBg.y + addBottomSizeY)
    self._ui._attenderSet.stc_frameBgRed:SetSize(self._ui._attenderSet.stc_frameBgRed:GetSizeX(), self._baseSize.rightListBg.y + addBottomSizeY)
    self._ui._attenderSet.list2_teamAList:SetSize(self._ui._attenderSet.list2_teamAList:GetSizeX(), self._baseSize.leftList.y + addBottomSizeY + self._ui._attenderSet.btn_GoTeamA:GetSizeY())
    self._ui._attenderSet.list2_teamBList:SetSize(self._ui._attenderSet.list2_teamBList:GetSizeX(), self._baseSize.rightList.y + addBottomSizeY + self._ui._attenderSet.btn_GoTeamB:GetSizeY())
    self._ui._attenderSet.list2_teamAList:SetSpanSize(0, 10)
    self._ui._attenderSet.list2_teamBList:SetSpanSize(0, 10)
  else
    self._ui._attenderSet.stc_rightAreaBg:SetSize(self._ui._attenderSet.stc_rightAreaBg:GetSizeX(), self._ui._attenderSet.stc_leftAreaBg:GetSizeY())
    self._ui._attenderSet.stc_frameBgBlue:SetSize(self._ui._attenderSet.stc_frameBgBlue:GetSizeX(), self._baseSize.leftListBg.y + addBottomSizeY)
    self._ui._attenderSet.stc_frameBgRed:SetSize(self._ui._attenderSet.stc_frameBgRed:GetSizeX(), self._baseSize.rightListBg.y + addBottomSizeY)
    self._ui._attenderSet.list2_teamAList:SetSize(self._ui._attenderSet.list2_teamAList:GetSizeX(), self._baseSize.leftList.y + addBottomSizeY)
    self._ui._attenderSet.list2_teamBList:SetSize(self._ui._attenderSet.list2_teamBList:GetSizeX(), self._baseSize.rightList.y + addBottomSizeY)
    self._ui._attenderSet.list2_teamAList:SetSpanSize(0, 50)
    self._ui._attenderSet.list2_teamBList:SetSpanSize(0, 50)
  end
  self._ui._attenderSet.stc_rightAreaBg:ComputePos()
  self._ui._attenderSet.stc_frameBgBlue:ComputePos()
  self._ui._attenderSet.stc_frameBgRed:ComputePos()
  self._ui._attenderSet.btn_GoTeamA:ComputePos()
  self._ui._attenderSet.btn_GoTeamB:ComputePos()
  self._ui._attenderSet.btn_teamATitleBg:ComputePos()
  self._ui._attenderSet.btn_teamBTitleBg:ComputePos()
  self._ui._attenderSet.list2_teamAList:ComputePos()
  self._ui._attenderSet.list2_teamBList:ComputePos()
end
function PaGlobal_Arsha_Func_All:freeView()
  if nil == Panel_Window_Arsha_Func_All then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local gabY = 10
  local addBottomSizeY = 0
  if false == self._isConsole then
    addBottomSizeY = self._ui.btn_gameStart:GetSizeY() + 2 * gabY
  end
  self._ui._attenderSet.stc_frameBgBlue:SetShow(false)
  self._ui._attenderSet.stc_frameBgRed:SetShow(false)
  self._ui._attenderSet.stc_frameBgYellow:SetShow(true)
  self._ui._attenderSet.btn_teamATitleBg:SetSpanSize(self._ui._attenderSet.btn_teamATitleBg:GetSpanSize().x, self._basePos.leftTitle.y - self._aloneViewDiffSize.y)
  self._ui._attenderSet.btn_teamBTitleBg:SetSpanSize(self._ui._attenderSet.btn_teamBTitleBg:GetSpanSize().x, self._basePos.rightTitle.y - self._aloneViewDiffSize.y)
  if true == isHost then
    self._ui._attenderSet.stc_rightAreaBg:SetSize(self._ui._attenderSet.stc_rightAreaBg:GetSizeX(), self._baseSize.rightArea.y)
    self._ui._attenderSet.list2_teamAList:SetSize(self._ui._attenderSet.list2_teamAList:GetSizeX(), self._baseSize.leftList.y + self._ui._attenderSet.btn_GoTeamA:GetSizeY() + self._aloneViewDiffSize.y)
    self._ui._attenderSet.list2_teamBList:SetSize(self._ui._attenderSet.list2_teamBList:GetSizeX(), self._baseSize.rightList.y + self._ui._attenderSet.btn_GoTeamB:GetSizeY() + self._aloneViewDiffSize.y)
    self._ui._attenderSet.list2_teamAList:SetSpanSize(0, 10)
    self._ui._attenderSet.list2_teamBList:SetSpanSize(0, 10)
  else
    self._ui._attenderSet.stc_rightAreaBg:SetSize(self._ui._attenderSet.stc_rightAreaBg:GetSizeX(), self._ui._attenderSet.stc_leftAreaBg:GetSizeY())
    self._ui._attenderSet.stc_frameBgYellow:SetSize(self._ui._attenderSet.stc_frameBgYellow:GetSizeX(), self._baseSize.aloneListBg.y + addBottomSizeY)
    self._ui._attenderSet.list2_teamAList:SetSize(self._ui._attenderSet.list2_teamAList:GetSizeX(), self._baseSize.leftList.y + addBottomSizeY + self._ui._attenderSet.btn_GoTeamA:GetSizeY() + self._aloneViewDiffSize.y)
    self._ui._attenderSet.list2_teamBList:SetSize(self._ui._attenderSet.list2_teamBList:GetSizeX(), self._baseSize.rightList.y + addBottomSizeY + self._ui._attenderSet.btn_GoTeamB:GetSizeY() + self._aloneViewDiffSize.y)
    self._ui._attenderSet.list2_teamAList:SetSpanSize(0, 10)
    self._ui._attenderSet.list2_teamBList:SetSpanSize(0, 10)
  end
  self._ui._attenderSet.btn_teamATitleBg:ComputePos()
  self._ui._attenderSet.btn_teamBTitleBg:ComputePos()
  self._ui._attenderSet.list2_teamAList:ComputePos()
  self._ui._attenderSet.list2_teamBList:ComputePos()
end
