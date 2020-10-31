function HandleEventLUp_MenuRemake_HeadMenu(headermenuIndex)
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:headMenu_select(headermenuIndex)
end
function HandleEventLUp_MenuRemake_Menu(menuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:menu_select(menuIndex)
end
function HandleEventLUp_MenuRemake_subMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:submenu_select(submenuIndex)
end
function HandleEventRUp_MenuRemake_setSubMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setToggle(submenuIndex)
end
function HandleEventLUp_Menu_RecentSubMenuFixed()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuFixed()
end
function HandleEventLUp_Menu_RecentSubMenuUnFixed()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuUnFixed()
end
function HandleEventLUp_Menu_RecentSubMenuDeleted()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuDelete(PaGlobal_Menu_Remake._recentSubMenuIdx)
  PaGlobal_Menu_Remake:updateRecentMenu()
end
function HandleEventPadOnOut_Menu_RecentSubMenuOn(isOn)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if true == isOn then
    PaGlobal_Menu_Remake._nowMenuMode = "recentmenu"
  end
end
function HandleEventLUp_MenuRemake_searchText()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:selected_searchText()
end
function HandleEventLUp_MenuRemake_ChangeCustomizeMode()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:menuCustomize_toggle()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake:headMenu_toggle(1)
  end
end
function HandleEventLUp_MenuRemake_ChangeOpenWay()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake._nowMenuMode = "changeWay"
  end
  PaGlobal_Menu_Remake:setMenuOpenWay()
end
function HandleEventLUp_MenuRemake_Commit()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:headmenuCustomize_confirm()
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake:headMenu_toggle(1)
  end
end
function HandleEventLUp_MenuRemake_Cancel()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:headmenuCustomize_cancel()
end
function HandleEventLUp_MenuRemake_SearchingMenu(searchMenuIndex)
  PaGlobal_Menu_Remake:searchMenu_select(searchMenuIndex)
end
function HandleEventOn_MenuRemake_SearchingMenu(searchMenuIndex)
  PaGlobal_Menu_Remake:searchMenu_toggle(searchMenuIndex, true)
end
function HandleEventOn_MenuRemake_ChangeUi()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showChangeUiToolTip()
end
function HandleEventOn_MenuRemake_ChangeOpenWay()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showOpenWayToolTip()
end
function HandleEventOn_MenuRemake_ChangeCustomizeMode()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:showCustomizeToolTip()
end
function HandleEventOn_MenuRemake_HeadMenu(headermenuIndex)
  if nil == headermenuIndex then
    return
  end
  PaGlobal_Menu_Remake:headMenu_toggle(headermenuIndex)
end
function HandleEventOn_MenuRemake_Menu(menuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:menu_toggle(menuIndex, true)
end
function HandleEventOn_MenuRemake_subMenu(submenuIndex)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake:submenu_toggle(submenuIndex, true)
end
function HandleEventOut_MenuRemake_HeadMenu(headermenuIndex)
  if nil == headermenuIndex then
    return
  end
  PaGlobal_Menu_Remake:resetHeadMenuTitle()
end
function HandleEventKeyBoard_MenuRemake_KeyPushCheck()
  if nil == Panel_Widget_Menu_Remake or false == PaGlobal_Menu_Remake_GetShow() then
    return true
  end
  if false == PaGlobal_DialogKeyManager_All._isGamePad and PaGlobal_Menu_Remake:checkPressedHotKey() then
    return false
  end
  return true
end
function HandleEventKeyBoard_MenuRemake_arrowKey(keycode)
  if nil == keycode then
    return
  end
  PaGlobal_Menu_Remake:pressedArrowKey(keycode)
end
function HandleEventKeyBoard_MenuRemake_searchingMenu()
  if nil == Panel_Widget_Menu_Remake then
    return false
  end
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:searchingMenu()
end
function HandleEventLUp_MenuRemake_Escape()
  if ToClient_IsMyselfInArena() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ARSHA_COMMON_ARLERT"))
    return
  elseif true == ToClient_getJoinGuildBattle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAG_CANTDO_GUILDBATTLE"))
    return
  end
  HandleClicked_RescueConfirm()
end
function HandleEventLUp_MenuRemake_BlackDesertLab()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if player:get():getLevel() < 56 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEVEL_LIMITED_GLOBAL_LABS"))
    return
  end
  if true == ToClient_isCompleteTesterSubmit() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALREADY_TESTER_SUBMIT"))
    return
  end
  PaGlobal_BlackDesertLab_Show()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if player:get():getLevel() < 56 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEVEL_LIMITED_GLOBAL_LABS"))
    return
  end
  if true == ToClient_isCompleteTesterSubmit() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALREADY_TESTER_SUBMIT"))
    return
  end
  PaGlobal_BlackDesertLab_Show()
end
function HandleEventLUp_MenuRemake_TradeEvent()
  if _ContentsGroup_isUsedNewTradeEventNotice then
    if true == _ContentsGroup_NewUI_TradeEventNotice_All then
      PaGlobalFunc_TradeEventNotice_Renewal_All_Open()
    else
      FGlobal_TradeEventNotice_Renewal_Show()
    end
  else
    TradeEventInfo_Show()
  end
end
function HandleEventLUp_MenuRemake_Market()
  FGlobal_ItemMarket_Open_ForWorldMap(1, true)
  audioPostEvent_SystemUi(1, 30)
end
function HandleEventLUp_MenuRemake_Localwar()
  if true == _ContentsGroup_InstanceLocalWar then
    PaGlobal_LocalWarInfo_All_New_ESCMenuFunc()
  elseif true == _ContentsGroup_NewUI_LocalWar_All then
    PaGlobal_LocalWarInfo_All_ESCMenuFunc()
  else
    LocalWarInfo_ESCMenuFunc()
  end
end
function HandleEventLUp_MenuRemake_FreeFight()
  FGlobal_FreeFight_ESCMenuFunc()
end
function HandleEventLUp_MenuRemake_Wave()
  FGlobal_SavageDefenceInfo_ESCMenuFunc()
end
function HandleEventLUp_MenuRemake_Competitiongame()
  if true == _ContentsGroup_NewUI_Arsha_All then
    PaGlobaFunc_Arsha_Reservation_All_ESCMenuFunc()
  else
    PaGlobaFunc_CompetitionGameJoinDesc_ESCMenuFunc()
  end
end
function HandleEventLUp_MenuRemake_Siege()
  if true == _ContentsGroup_SeigeSeason5 then
    if true == _ContentsGroup_NewUI_GuildWarInfo_All then
      PaGlobalFunc_GuildWarInfo_All_Open()
    else
      FGlobal_GuildWarInfo_renew_Open()
    end
  else
    FGlobal_GuildWarInfo_Show()
  end
end
function HandleEventLUp_MenuRemake_InfinityDefence()
  PaGlobal_HandleClicked_BloodAltar_Open()
end
function HandleEventLUp_MenuRemake_ArshaApplyWeb()
  if nil ~= Panel_Arsha_ApplyWeb_All and false == Panel_Arsha_ApplyWeb_All:GetShow() then
    PaGlobal_ArshaApplyWeb_All_Open()
  end
end
function HandleEventLUp_MenuRemake_FeedBack()
  local isUrl = "https://account.global-lab.playblackdesert.com/Member/Login?_returnUrl=https%3A%2F%2Fwww.global-lab.playblackdesert.com/CS/SUGGEST/WRITE"
  ToClient_OpenChargeWebPage(isUrl, false)
end
function HandleEventLUp_MenuRemake_Myinfo()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_PlayerInfo)
end
function HandleEventLUp_MenuRemake_Inventory()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
end
function HandleEventLUp_MenuRemake_Skill()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Skill)
end
function HandleEventLUp_MenuRemake_Fairy()
  if true == _ContentsGroup_NewUI_Fairy_All then
    PaGlobal_FairyInfo_Open_All(false)
  else
    PaGlobal_FairyInfo_Open(false)
  end
end
function HandleEventLUp_MenuRemake_CashShop()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
end
function HandleEventLUp_MenuRemake_WorldMap()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_WorldMap)
end
function HandleEventLUp_MenuRemake_BlackSpirit()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
end
function HandleEventLUp_MenuRemake_QuestHistory()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_QuestHistory)
end
function HandleEventLUp_MenuRemake_FarmingList()
  if true == _ContentsGroup_FarmingList then
    PaGloabl_FarmingTimer_Open()
  end
end
function HandleEventLUp_MenuRemake_MentalKnowledge()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_MentalKnowledge)
end
function HandleEventLUp_MenuRemake_Present()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Present)
end
function HandleEventLUp_MenuRemake_Mail()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
end
function HandleEventLUp_MenuRemake_Manufacture()
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Manufacture)
end
function HandleEventLUp_MenuRemake_Personalbattle()
  PaGlobal_PersonalBattle:open()
end
function HandleEventLUp_MenuRemake_Beauty()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_BeautyShop)
end
function HandleEventLUp_MenuRemake_Dyeing()
  PaGlobal_Menu_Remake:close(false)
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Dyeing)
end
function HandleEventLUp_MenuRemake_BeautyAlbum()
  ToClient_setEditableOptionTmp()
  FGlobal_CustomizingAlbum_Show(false, CppEnums.ClientSceneState.eClientSceneStateType_InGame)
end
function HandleEventLUp_MenuRemake_Notice()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    Panel_EventNotify_All_Open(true, true)
  else
    EventNotify_Open(true, true)
  end
end
function HandleEventLUp_MenuRemake_Update()
  Panel_WebHelper_ShowToggle("Update")
end
function HandleEventLUp_MenuRemake_Event()
  if true == _ContentsGroup_NewUI_EventNotify_All then
    Panel_EventNotify_All_Open(true, true)
  else
    EventNotify_Open(true, true)
  end
end
function HandleEventLUp_MenuRemake_KnownIssue()
  Panel_WebHelper_ShowToggle("KnownIssue")
end
function HandleEventLUp_MenuRemake_Camp()
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_Camp_All_Open()
  else
    PaGlobal_Camp:open()
  end
end
function HandleEventLUp_MenuRemake_OthilitaDungeon()
  if true == _ContentsGroup_OthilitaDungeon then
    HandleEventLUp_Widget_ThornCastle_Enter_Open()
  end
end
function HandleEventUp_MenuRemake_Mail()
  if true == _ContentsGroup_NewUI_Mail_All then
    PaGlobal_Window_Mail_All_WithRewardOpen(false)
  end
  GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
end
function HandleEventLUp_MenuRemake_ImmortalHell()
  if true == _ContentsGroup_isOepnImmortalHell or true == _ContentsGroup_isOpenImmortalHellForConsole then
    local selfProxy = getSelfPlayer()
    if nil == selfProxy then
      return true
    end
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    if nil == regionInfo then
      return true
    end
    local isPVEArenaZone = regionInfo:get():isPVEArenaZone()
    if true == isPVEArenaZone then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGOUT"),
        functionYes = ToClient_RequestLeaveImmortalHell,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGTITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_PVE_ARENA_TELEPORT_MSGDESC"),
        functionYes = ToClient_RequestJoinImmortalHell,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function FromClient_Menu_Remake_OnScreenResize()
  PaGlobal_Menu_Remake:resizeMenu()
end
