function PaGlobalFunc_Quest_All_Open()
  PaGlobal_Quest_All:prepareOpen()
end
function PaGlobalFunc_Quest_All_Close(isAni)
  PaGlobal_Quest_All:prepareClose(isAni)
end
function PaGlobalFunc_Quest_All_Toggle()
  if nil == Panel_Window_Quest_All then
    return
  end
  if true == Panel_Window_Quest_All:GetShow() then
    PaGlobalFunc_Quest_All_Close()
  else
    PaGlobalFunc_Quest_All_Open()
  end
end
function PaGlobalFunc_Quest_All_GetShow()
  if nil == Panel_Window_Quest_All then
    return false
  end
  return Panel_Window_Quest_All:GetShow()
end
function PaGlobalFunc_Quest_All_ShowAni()
  local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
  local aniInfo1 = Panel_Window_Quest_All:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_Quest_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Quest_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Quest_All:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Quest_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Quest_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_Quest_All_HideAni()
  local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
  Panel_Window_Quest_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Quest_All:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function HandleEvent_Quest_All_ListScroll(isUp)
  PaGlobal_Quest_All._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_Quest_All._ui._listScroll.stc_bg, isUp, PaGlobal_Quest_All._config.slotMaxCount, PaGlobal_Quest_All._listCount + 1, PaGlobal_Quest_All._startSlotIndex, 1)
  if PaGlobal_Quest_All._startSlotIndex < 1 then
    PaGlobal_Quest_All._startSlotIndex = 1
  end
  PaGlobal_Quest_All:update()
end
function HandleEventLUp_Quest_All_SetTabMenu(selectIdx)
  if nil == Panel_Window_Quest_All then
    return
  end
  for index = 1, #PaGlobal_Quest_All._radioTabs do
    PaGlobal_Quest_All._radioTabs[index]:SetCheck(false)
  end
  PaGlobal_Quest_All._radioTabs[selectIdx]:SetCheck(true)
  PaGlobal_Quest_All._currentTab = selectIdx
  local targetControl = PaGlobal_Quest_All._radioTabs[selectIdx]
  local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - PaGlobal_Quest_All._ui.stc_selectBar:GetSizeX() / 2
  PaGlobal_Quest_All._ui.stc_selectBar:SetPosX(selectBarPosX)
  if PaGlobal_Quest_All._currentTab == PaGlobal_Quest_All._TABTYPE.PROGRESS then
    PaGlobal_Quest_All._ui_console.stc_guideHideEmpty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_ALL_EMPTYGROUP_HIDE"))
    PaGlobal_Quest_All._ui_console.stc_guideSortType:SetShow(true)
  else
    PaGlobal_Quest_All._ui_console.stc_guideHideEmpty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_RECOMMAND_HIDE"))
    PaGlobal_Quest_All._ui_console.stc_guideSortType:SetShow(false)
  end
  PaGlobalFunc_Quest_All_Update()
end
function HandleEventLUp_Quest_All_PopUp()
  if true == PaGlobal_Quest_All._ui_pc.chk_popUp:IsCheck() then
    Panel_Window_Quest_All:OpenUISubApp()
    if nil ~= Panel_Window_QuestInfo_All and true == Panel_Window_QuestInfo_All:GetShow() then
      PaGlobalFunc_QuestInfo_All_RePosition()
    end
  else
    Panel_Window_Quest_All:CloseUISubApp()
    if nil ~= Panel_Window_QuestInfo_All and true == Panel_Window_QuestInfo_All:GetShow() then
      Panel_Window_QuestInfo_All:CloseUISubApp()
      PaGlobalFunc_QuestInfo_All_RePosition()
    end
  end
  TooltipSimple_Hide()
end
function HandleEventLUp_Quest_All_SelectQuestFavorType(index)
  if PaGlobal_Quest_All._config.selectAbleFavorTypeLv > getSelfPlayer():get():getLevel() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORITETYPE_ALERT"))
    if nil ~= PaGlobal_Quest_All._ui._favorType and nil ~= PaGlobal_Quest_All._ui._favorType[index] then
      PaGlobal_Quest_All._ui._favorType[index]:SetCheck(not PaGlobal_Quest_All._ui._favorType[index]:IsCheck())
    end
    return
  end
  if PaGlobal_Quest_All._FAVORTYPE.ALL == index then
    PaGlobal_Quest_All:favorCheckAll()
  else
    ToClient_ToggleQuestSelectType(index)
  end
  FGlobal_UpdateQuestFavorType()
end
function HandleEventLUp_Quest_All_QuestBranch(index)
  PaGlobal_questBranch_Open(index)
end
function HandleEventLUp_Quest_All_QuestShowCheck(groupNo, questNo)
  HandleClicked_QuestShowCheck(groupNo, questNo)
end
function HandleEventLUp_Quest_All_ShowDetailInfo(questGroupId, questId, questCondition_Chk, groupIdx, nextChk, isCleared, uiIdx)
  local isProgressingActive = false
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    isProgressingActive = true
  end
  local questListInfo, questGroupInfo, isGroup, groupTitle
  local isNext = false
  local groupCount
  if 0 == nextChk then
    isNext = true
  end
  questListInfo = ToClient_GetQuestList()
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    questGroupInfo = questListInfo:getQuestGroupAt(groupIdx)
    isGroup = questGroupInfo:isGroupQuest()
    groupTitle = "nil"
    groupCount = nil
    if isGroup then
      groupCount = questGroupInfo:getTotalQuestCount()
    end
  elseif PaGlobal_Quest_All._TABTYPE.RECOMMEND == PaGlobal_Quest_All._currentTab then
    questGroupInfo = questListInfo:getRecommendationQuestGroupAt(groupIdx)
    isGroup = false
    groupTitle = "nil"
    groupCount = nil
  elseif PaGlobal_Quest_All._TABTYPE.REPEAT == PaGlobal_Quest_All._currentTab then
    questGroupInfo = questListInfo:getRepetitionQuestGroupAt(groupIdx)
    isGroup = false
    groupTitle = "nil"
    groupCount = nil
  elseif PaGlobal_Quest_All._TABTYPE.NEW == PaGlobal_Quest_All._currentTab then
    questGroupInfo = questListInfo:getNewQuestGroupAt(groupIdx)
    isGroup = false
    groupTitle = "nil"
    groupCount = nil
  else
    questGroupInfo = questListInfo:getMainQuestGroupAt(groupIdx)
    isGroup = false
    groupTitle = "nil"
    groupCount = nil
  end
  if true == isGroup then
    groupTitle = questGroupInfo:getTitle()
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupId, questId, questCondition_Chk, groupTitle, groupCount, false, not isProgressingActive, isNext, isCleared, nil, uiIdx)
end
function HandleEventLUp_Quest_All_FindWayPrepare(gruopNo, questNo, questCondition, isAuto, uiIdx)
  local QuestStatic = questList_getQuestStatic(gruopNo, questNo)
  if nil ~= QuestStatic then
    local selectQuestType = QuestStatic:getSelectType()
    if 0 ~= selectQuestType then
      local QuestListInfo = ToClient_GetQuestList()
      if false == QuestListInfo:isQuestSelectType(selectQuestType) then
        PaGlobalFunc_Quest_All_SetQuestSelectType(gruopNo, questNo, questCondition, isAuto, selectQuestType, uiIdx)
      else
        PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
      end
    else
      PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
    end
  end
end
function HandleEventLUp_Quest_All_GiveUp(groupId, questId)
  if true == PaGlobal_TutorialManager:isBeginnerTutorialQuest(groupId, questId) and true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  local QuestGiveUpConfirm = function()
    PaGlobal_Quest_All._startSlotIndex = math.max(1, PaGlobal_Quest_All._startSlotIndex - 1)
    QuestWidget_QuestGiveUp_Confirm()
  end
  FGlobal_PassGroupIdQuestId(groupId, questId)
  local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "GUILD_MESSAGEBOX_TITLE")
  local messageboxContent = PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_REAL_GIVEUP_QUESTION")
  local messageboxData = {
    title = messageboxTitle,
    content = messageboxContent,
    functionYes = QuestGiveUpConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandlePadEventLBRB_Quest_All_MoveTab(value)
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  local selectTab = PaGlobal_Quest_All._currentTab + value
  if selectTab < PaGlobal_Quest_All._TABTYPE.PROGRESS then
    selectTab = PaGlobal_Quest_All._TABTYPE.NEW
  elseif selectTab > PaGlobal_Quest_All._TABTYPE.NEW then
    selectTab = PaGlobal_Quest_All._TABTYPE.PROGRESS
  end
  TooltipSimple_Hide()
  HandlePadEventUpDown_Quest_All_HideSubMenu()
  HandleEventLUp_Quest_All_SetTabMenu(selectTab)
end
function HandlePadEventA_Quest_All_ShowSubMenu(questGroupId, questId, questCondition_Chk, groupIdx, nextChk, isCleared, uiCount)
  if true == HandlePadEventUpDown_Quest_All_HideSubMenu() then
    return
  end
  local subMenuBg = PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg
  subMenuBg:SetShow(true)
  PaGlobal_Quest_All._selectQuestInfo = {
    _questGroupId = questGroupId,
    _questId = questId,
    _questCondition_Chk = questCondition_Chk,
    _groupIdx = groupIdx,
    _nextChk = nextChk,
    _isCleared = isCleared,
    _uiCount = uiCount
  }
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:SetSpanSize(PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:GetSpanSize().x, 6)
  PaGlobal_Quest_All._ui_console._focusMenu.radio_autoNavi:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnAuto:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_questNavi:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnNavi:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_giveUp:SetShow(PaGlobal_Quest_All._uiPool.listMain[uiCount].btnGiveUp:GetShow())
  PaGlobal_Quest_All._ui_console._focusMenu.radio_detail:SetShow(true)
  PaGlobal_Quest_All._ui_console._focusMenu.radio_blackSpirit:SetShow(false)
  local btnList = {
    [1] = PaGlobal_Quest_All._ui_console._focusMenu.radio_autoNavi,
    [2] = PaGlobal_Quest_All._ui_console._focusMenu.radio_questNavi,
    [3] = PaGlobal_Quest_All._ui_console._focusMenu.radio_giveUp,
    [4] = PaGlobal_Quest_All._ui_console._focusMenu.radio_detail,
    [5] = PaGlobal_Quest_All._ui_console._focusMenu.radio_blackSpirit
  }
  local baseSpanY = 10
  for ii = 1, #btnList do
    if nil ~= btnList[ii] and true == btnList[ii]:GetShow() then
      btnList[ii]:SetSpanSize(btnList[ii]:GetSpanSize().x, baseSpanY)
      baseSpanY = baseSpanY + btnList[ii]:GetSizeY() + 10
      btnList[ii]:ComputePos()
      btnList[ii]:addInputEvent("Mouse_On", "HandleEventOn_Quest_All_SubMenuConfirmIcon(" .. btnList[ii]:GetSpanSize().y .. ")")
    end
  end
  local bgSizeY = baseSpanY
  subMenuBg:SetSize(subMenuBg:GetSizeX(), bgSizeY)
end
function HandlePadEventUpDown_Quest_All_HideSubMenu()
  if false == PaGlobal_Quest_All._isConsole then
    return true
  end
  if nil == PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg then
    return true
  end
  if true == PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg:GetShow() then
    PaGlobal_Quest_All._ui_console._focusMenu.stc_focusBg:SetShow(false)
    return true
  end
end
function HandleEventOn_Quest_All_SubMenuConfirmIcon(spanY)
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:SetSpanSize(PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:GetSpanSize().x, spanY - 4)
  PaGlobal_Quest_All._ui_console._focusMenu.stc_Confirm:ComputePos()
end
function HandlePadEventA_Quest_All_SubMenuClick(menuType)
  if nil == menuType or "" == menuType then
    return
  end
  HandlePadEventUpDown_Quest_All_HideSubMenu()
  local selectInfo = PaGlobal_Quest_All._selectQuestInfo
  if "autoNavi" == menuType then
    HandleEventLUp_Quest_All_FindWayPrepare(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, true, selectInfo._uiCount)
  elseif "questNavi" == menuType then
    HandleEventLUp_Quest_All_FindWayPrepare(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, false, selectInfo._uiCount)
  elseif "giveUp" == menuType then
    HandleEventLUp_Quest_All_GiveUp(selectInfo._questGroupId, selectInfo._questId)
  elseif "detail" == menuType then
    HandleEventLUp_Quest_All_ShowDetailInfo(selectInfo._questGroupId, selectInfo._questId, selectInfo._questCondition_Chk, selectInfo._groupIdx, selectInfo._nextChk, selectInfo._isCleared)
  elseif "blackSpirit" == menuType then
  end
end
function HandlePadEventY_Quest_All_ChangeQuestSortType()
  PaGlobal_Quest_All._ui.radio_questType:SetCheck(not PaGlobal_Quest_All._ui.radio_questType:IsCheck())
  PaGlobal_Quest_All._ui.radio_questTerritory:SetCheck(not PaGlobal_Quest_All._ui.radio_questTerritory:IsCheck())
  PaGlobalFunc_Quest_All_Update()
end
function HandlePadEventX_Quest_All_CheckEmptyHideGroup()
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    PaGlobal_Quest_All._ui.chk_emptyGroupHide:SetCheck(not PaGlobal_Quest_All._ui.chk_emptyGroupHide:IsCheck())
  else
    PaGlobal_Quest_All._ui.chk_complteHide:SetCheck(not PaGlobal_Quest_All._ui.chk_complteHide:IsCheck())
  end
  PaGlobalFunc_Quest_All_Update()
end
function HandleEventOnOut_Quest_All_SelectQuestFavorTypeSimpleTooltip(isShow, index)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_Window_Quest_All then
    return
  end
  local name, desc, control
  local control = PaGlobal_Quest_All._ui._favorType[index]
  if PaGlobal_Quest_All._FAVORTYPE.ALL == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ALL")
  elseif PaGlobal_Quest_All._FAVORTYPE.HUNT == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_COMBAT")
  elseif PaGlobal_Quest_All._FAVORTYPE.LIFE == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_LIFE")
  elseif PaGlobal_Quest_All._FAVORTYPE.FISH == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE4")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_FISHING")
  elseif PaGlobal_Quest_All._FAVORTYPE.TRADE == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE5")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_TRADE")
  elseif PaGlobal_Quest_All._FAVORTYPE.ETC == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE6")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ETC")
  elseif 99 == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_FAVORTYPE")
    control = PaGlobal_Quest_All._ui.txt_favorType
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Quest_All_PopUp(isShow)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc = ""
  if true == PaGlobal_Quest_All._ui_pc.chk_popUp:IsCheck() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(PaGlobal_Quest_All._ui_pc.chk_popUp, name, desc)
end
function HandleEventOnOut_Quest_All_SortTypeSimpleTooltip(isShow, tipType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_QUESTTYPE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GRUOP_ORDER_DESC")
    control = PaGlobal_Quest_All._ui.radio_questType
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FILTER_ZONE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_TERRITORY_ORDER_DESC")
    control = PaGlobal_Quest_All._ui.radio_questTerritory
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_EMPTYGROUP_HIDE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_EMPTYGROUP_DESC")
    control = PaGlobal_Quest_All._ui.chk_emptyGroupHide
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Quest_All_ShowCondition(isShow, arrayIdx, uiIdx, buttonType)
  if true == PaGlobal_Quest_All._isConsole then
    return
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    local name, desc, control = "", "", nil
    if nil ~= buttonType then
      if 0 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_AUTONAVI_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_AUTONAVI_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi
      elseif 1 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_NAVI_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_NAVI_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto
      elseif 2 == buttonType then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GIVEUP_NAME")
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_TOOLTIP_GIVEUP_DESC")
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnGiveUp
      end
      TooltipSimple_Show(control, name, desc)
    end
  else
    local control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].name
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_ACCEPTCONDITION")
    local desc = PaGlobal_Quest_All._useArray[arrayIdx].isShowWidget
    if nil ~= buttonType then
      if 0 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_AUTONPCNAVI_HELP")
      elseif 1 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_NPCNAVI_HELP")
      elseif 2 == buttonType then
        control = PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnGiveUp
        desc = desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_GIVEUP_HELP")
      end
    end
    TooltipSimple_Show(control, name, desc)
  end
  HandlePadEventUpDown_Quest_All_HideSubMenu()
end
function HandleEventOnOut_Quest_All_GroupTitleSimpleTooltip(isShow, idx, uiCount, baseCount)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if not PaGlobal_Quest_All._uiPool.groupTitle[uiCount].name:IsLimitText() then
    return
  end
  if PaGlobal_Quest_All._TABTYPE.PROGRESS == PaGlobal_Quest_All._currentTab then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local title = PaGlobal_Quest_All._useArray[idx].title
  local completeCount = PaGlobal_Quest_All._questArrayGroupCompleteCount[PaGlobal_Quest_All._useArray[idx].groupIdx]
  local totalCount = PaGlobal_Quest_All._questArrayGroupCount[PaGlobal_Quest_All._useArray[idx].groupIdx]
  name = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_GROUPTITLE", "title", title, "count", completeCount .. "/" .. totalCount)
  control = PaGlobal_Quest_All._uiPool.groupTitle[uiCount].bg
  TooltipSimple_Show(control, name, desc)
  HandlePadEventUpDown_Quest_All_HideSubMenu()
end
function FromClient_Quest_All_UpdateQuestList()
  PaGlobal_Quest_All:update()
end
function FromClient_Quest_All_Resize()
  PaGlobal_Quest_All:resize()
end
function PaGlobalFunc_Quest_All_Audio(group, index)
  if PaGlobal_Quest_All._isConsole then
    audioPostEvent_SystemUi(group, index)
  else
    _AudioPostEvent_SystemUiForXBOX(group, index)
  end
end
function PaGlobalFunc_Quest_All_Update()
  PaGlobal_Quest_All._startSlotIndex = 1
  PaGlobal_Quest_All._ui._listScroll.stc_bg:SetControlTop()
  PaGlobal_Quest_All:update()
end
function PaGlobalFunc_Quest_All_SetProgress()
  for key, value in ipairs(PaGlobal_Quest_All._radioTabs) do
    if nil ~= value then
      value:SetCheck(false)
    end
  end
  PaGlobal_Quest_All._radioTabs[PaGlobal_Quest_All._TABTYPE.PROGRESS]:SetCheck(true)
end
function PaGlobalFunc_Quest_All_FavorTypeUpdate()
  PaGlobal_Quest_All:favorTypeUpdate()
end
function PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
  local QuestStatic = questList_getQuestStatic(gruopNo, questNo)
  if nil ~= QuestStatic then
    if QuestConditionCheckType.eQuestConditionCheckType_Complete == questCondition then
      if true == QuestStatic:isCompleteBlackSpirit() then
        PaGlobal_Quest_All._selectWay.groupID = ""
        PaGlobal_Quest_All._selectWay.questID = ""
        HandleClicked_CallBlackSpirit()
      else
        HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
      end
    elseif QuestConditionCheckType.eQuestConditionCheckType_NotAccept == questCondition then
      if 0 == QuestStatic:getAccecptNpc():get() then
        PaGlobal_Quest_All._selectWay.groupID = ""
        PaGlobal_Quest_All._selectWay.questID = ""
        HandleClicked_CallBlackSpirit()
      else
        HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
      end
    else
      HandleClicked_QuestWidget_FindTarget(gruopNo, questNo, questCondition, isAuto)
    end
  end
end
function PaGlobalFunc_Quest_All_UpdateFindWay(groupId, questId, isAuto)
  if PaGlobal_Quest_All._selectWay.groupID == groupId and PaGlobal_Quest_All._selectWay.questID == questId then
    PaGlobal_Quest_All._selectWay.groupID = ""
    PaGlobal_Quest_All._selectWay.questID = ""
    PaGlobal_Quest_All._selectWay.isAuto = false
  else
    PaGlobal_Quest_All._selectWay.groupID = groupId
    PaGlobal_Quest_All._selectWay.questID = questId
    PaGlobal_Quest_All._selectWay.isAuto = isAuto
  end
  if true == Panel_Window_Quest_All:GetShow() then
    PaGlobal_Quest_All:update()
  end
  if true == Panel_Window_QuestInfo_All:GetShow() then
    PaGlobalFunc_QuestInfo_All_Update()
  end
end
function PaGlobalFunc_Quest_All_SetQuestSelectType(gruopNo, questNo, questCondition, isAuto, selectQuestType, uiIdx)
  if selectQuestType < 0 or selectQuestType > PaGlobal_Quest_All._SELECTTYPE.ETC then
    return
  end
  local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "GUILD_MESSAGEBOX_TITLE")
  local messageboxContent = ""
  if true == PaGlobal_Quest_All._isConsole then
    messageboxContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORTYPE_ENABLE_CONSOLE", "favortype", PaGlobal_Quest_All._questSelectTypeString[selectQuestType])
  else
    messageboxContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHECKEDQUEST_FAVORTYPE_ENABLE", "favortype", PaGlobal_Quest_All._questSelectTypeString[selectQuestType])
  end
  local function funcSetQuestSelectType()
    local QuestListInfo = ToClient_GetQuestList()
    QuestListInfo:setQuestSelectType(selectQuestType, true)
    FGlobal_UpdateQuestFavorType()
    PaGlobalFunc_Quest_All_FindWay(gruopNo, questNo, questCondition, isAuto)
  end
  local function funcResetCheckButton()
    PaGlobalFunc_QuestInfo_All_DenySetQuestTypeResetButton(gruopNo, questNo)
    if -1 == uiIdx or nil == PaGlobal_Quest_All._uiPool.listMain[uiIdx] then
      return
    end
    PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnAuto:SetCheck(false)
    PaGlobal_Quest_All._uiPool.listMain[uiIdx].btnNavi:SetCheck(false)
  end
  local messageboxData = {
    title = messageboxTitle,
    content = messageboxContent,
    functionYes = funcSetQuestSelectType,
    functionNo = funcResetCheckButton,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Quest_All_GroupTitleUpdateExpand(isRegion, Idx, uiIdx)
  if 0 == isRegion then
    PaGlobal_Quest_All._regionOpen[Idx] = not PaGlobal_Quest_All._regionOpen[Idx]
  elseif 1 == isRegion then
    PaGlobal_Quest_All._typeOpen[Idx] = not PaGlobal_Quest_All._typeOpen[Idx]
  elseif 2 == isRegion then
    PaGlobal_Quest_All._groupOpen._recommendation[Idx] = not PaGlobal_Quest_All._groupOpen._recommendation[Idx]
  elseif 3 == isRegion then
    PaGlobal_Quest_All._groupOpen._repetitive[Idx] = not PaGlobal_Quest_All._groupOpen._repetitive[Idx]
  elseif 4 == isRegion then
    PaGlobal_Quest_All._groupOpen._main[Idx] = not PaGlobal_Quest_All._groupOpen._main[Idx]
  elseif 5 == isRegion then
    PaGlobal_Quest_All._groupOpen._new[Idx] = not PaGlobal_Quest_All._groupOpen._new[Idx]
  end
  PaGlobal_Quest_All:update()
end
