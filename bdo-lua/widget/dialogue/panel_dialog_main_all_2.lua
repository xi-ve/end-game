function PaGlobalFunc_DialogMain_All_Open()
  PaGlobal_DialogMain_All:prepareOpen()
end
function PaGlobalFunc_DialogMain_All_Close(isSetWait, isTest, isAttacked)
  PaGlobal_DialogMain_All:prepareClose(isSetWait, isTest, isAttacked)
end
function PaGlobalFunc_DialogMain_All_ShowToggle(isShow)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(isShow)
  Panel_Npc_Dialog_All:SetShow(isShow)
end
function PaGlobalFunc_DialogMain_All_SubPanelSetShow(isShow)
  if false == _ContentsGroup_NewUI_Dialog_All and false == _ContentsGroup_NewUI_Integration_All then
    return
  end
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if true == isShow then
    if true == PaGlobal_DialogMain_All._isDialogStarting then
      return
    end
    PaGlobalFunc_DialogIntimacy_All_Open()
    PaGlobalFunc_InterestKnowledge_All_Open()
  else
    PaGlobalFunc_DialogIntimacy_All_Close()
    PaGlobalFunc_InterestKnowledge_All_Close()
  end
end
function PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(ignoreShowDialog)
  PaGlobal_DialogMain_All._ignoreShowDialog = ignoreShowDialog
end
function HandleEventLUp_DialogMain_All_BackClick()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if false == PaGloalFunc_DialogMain_All_PreClosePanel() then
    return
  end
  if check_ShowWindow() then
    close_WindowPanelList()
  end
  if nil ~= Panel_Dialog_Quest_All and true == Panel_Dialog_Quest_All:GetShow() then
    PaGlobalFunc_DialogQuest_All_Close()
  end
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    if Panel_Widget_Dialog_Search_All:IsShow() then
      PaGlobalFunc_DialogSearch_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI_SearchMode then
    if Panel_Dialog_Search:IsShow() then
      searchView_Close()
    end
  elseif true == PaGlobalFunc_SearchMode_IsSearchMode() then
    searchView_Close()
  end
  ToClient_SetFilterType(0, false)
  if false == PaGlobal_DialogMain_All._isConsole then
    BlackSpiritAd_Hide()
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  PaGlobalFunc_DialogList_All_SetContactTalk(false)
  PaGlobal_DialogMain_All._selectDialogFuncIndex = nil
  PaGlobal_DialogMain_All:funcBottomBtnUpdate(dialogData)
  PaGlobal_DialogMain_All._isDialogStarting = false
  if true == dialogData:getContactNpcDialogType() then
    HandleEventLUp_DialogMain_All_ExitClick()
  else
    if true == _ContentsGroup_RenewUI and nil ~= Panel_Window_PowerSave_All and true == PaGlobalFunc_PowerSave_All_GetOpen() then
      HandleEventLUp_DialogMain_All_ExitClick()
      return
    end
    ReqeustDialog_retryTalk()
  end
end
function HandleEventLUp_DialogMain_All_ExitClick()
  PaGlobalFunc_DialogMain_All_Close()
end
function HandleEventLUp_DialogMain_All_FuncButton(index, isType)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if true == MessageBoxGetShow() then
    return
  end
  if nil == index then
    return
  end
  if false == PaGloalFunc_DialogMain_All_PreClosePanel() then
    return
  end
  if nil == isType then
    isType = false
  end
  PaGlobal_DialogMain_All:funcBottomBtnClick(index, isType)
  PaGlobalFunc_InterestKnowledge_All_Close()
end
function PaGlobalFunc_DialogMain_All_BlackSpiritSkillSelectTooltip()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_BLACKSPIRIT_SKINSELECT_TITLE")
  local dese = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NPC_DIALOG_BACK_BLACKSPIRIT_BUTTON_DESE")
  TooltipSimple_Show(PaGlobal_DialogMain_All._ui_pc.btn_blackSpiritSkillSelect, name, dese)
end
function HandleEventLUp_DialogMain_All_ContinueClick()
  PaGlobal_DialogMain_All._curLine = PaGlobal_DialogMain_All._curLine + 1
  PaGlobalFunc_DialogMain_All_UpdateDialogText()
end
function HandleEventLUp_DialogMain_All_NextClick()
  HandleEventLUp_DialogMain_All_BackClick()
end
function HandleEventLUp_DialogMain_All_QuestRefuse()
  local lastSelectIndex = PaGlobal_DialogMain_All._selectDialogFuncIndex
  PaGlobalFunc_DialogQuest_All_Close()
  HandleEventLUp_DialogMain_All_BackClick()
  HandleEventLUp_DialogMain_All_FuncButton(lastSelectIndex)
end
function HandleEventKeyUp_DialogMain_All_HotKeyClick(index)
  if nil == Panel_Npc_Dialog_All or false == Panel_Npc_Dialog_All:GetShow() then
    return
  end
  if true == PaGlobalFunc_DialogKeyManager_All_GetGamePadEnable() then
    return
  end
  if true == PaGlobal_NumberPad_All_GetShow() then
    return
  end
  if nil ~= Panel_Dialog_List_All and true == Panel_Dialog_List_All:GetShow() then
    return
  end
  if nil ~= Panel_Dialog_Exchange_All and true == Panel_Dialog_Exchange_All:GetShow() then
    return
  end
  if nil == PaGlobal_DialogMain_All._HOTKEY[index].idx then
    return
  end
  HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._HOTKEY[index].idx)
end
function HandleEventOnOut_DialogMain_All_BtnTextLimitTooltip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_DialogMain_All._funcBtnList[index] then
    return
  end
  TooltipSimple_Show(PaGlobal_DialogMain_All._funcBtnList[index], PaGlobal_DialogMain_All._funcBtnList[index]:GetText())
end
function HandlePadLBRB_DialogMain_All_MoveOverIdx(value)
  if nil == Panel_Npc_Dialog_All or false == Panel_Npc_Dialog_All:GetShow() then
    return
  end
  if false == PaGlobal_DialogMain_All._isConsole then
    return
  end
  if false == PaGlobal_DialogMain_All._console_snapDialog then
    return
  end
  for index = 0, PaGlobal_DialogMain_All._console_bottomButtonCnt do
    PaGlobal_DialogMain_All._console_bottomButtons[index]:SetCheck(false)
    PaGlobal_DialogMain_All._console_bottomButtons[index]:setRenderTexture(PaGlobal_DialogMain_All._console_bottomButtons[index]:getBaseTexture())
  end
  PaGlobal_DialogMain_All._console_overIdx = PaGlobal_DialogMain_All._console_overIdx + value
  if 0 > PaGlobal_DialogMain_All._console_overIdx then
    PaGlobal_DialogMain_All._console_overIdx = PaGlobal_DialogMain_All._console_bottomButtonCnt
  elseif PaGlobal_DialogMain_All._console_bottomButtonCnt < PaGlobal_DialogMain_All._console_overIdx then
    PaGlobal_DialogMain_All._console_overIdx = 0
  end
  PaGlobal_DialogMain_All._console_bottomButtons[PaGlobal_DialogMain_All._console_overIdx]:setRenderTexture(PaGlobal_DialogMain_All._console_bottomButtons[PaGlobal_DialogMain_All._console_overIdx]:getOnTexture())
  local selectBarPosX = PaGlobal_DialogMain_All._console_bottomButtons[PaGlobal_DialogMain_All._console_overIdx]:GetPosX() + PaGlobal_DialogMain_All._console_bottomButtons[PaGlobal_DialogMain_All._console_overIdx]:GetSizeX() / 2 - PaGlobal_DialogMain_All._ui.stc_selectBar:GetSizeX() / 2
  PaGlobal_DialogMain_All._ui.stc_selectBar:SetPosX(selectBarPosX)
  PaGlobal_DialogMain_All._ui.stc_selectBar:SetShow(true)
  _AudioPostEvent_SystemUiForXBOX(51, 5)
end
function HandlePadUpA_DialogMain_All_SelectOverIdx()
  if false == PaGlobal_DialogMain_All._isConsole then
    return
  end
  local btn_continue = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Continue")
  local btn_next = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Next")
  if true == PaGlobalFunc_DialogMain_All_GetShowNextBtn() then
    HandleEventLUp_DialogMain_All_NextClick()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    return
  elseif true == PaGlobalFunc_DialogMain_All_GetShowContinueBtn() then
    HandleEventLUp_DialogMain_All_ContinueClick()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    return
  end
  if false == PaGlobal_DialogMain_All._ui_console.stc_guideIconA:GetShow() then
    return
  end
  if 0 == PaGlobal_DialogMain_All._console_overIdx then
    HandleEventLUp_DialogMain_All_BackClick()
    return
  end
  if PaGlobal_DialogMain_All._console_bottomButtonCnt == PaGlobal_DialogMain_All._console_overIdx then
    HandleEventLUp_DialogMain_All_ExitClick()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(51, 5)
  HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._console_overIdx - 1)
end
function HandleEventKeyBoard_DialogMain_All_BackSpaceClick()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  if false == Panel_Npc_Dialog_All:GetShow() then
    return false
  end
  return true
end
function FromClient_DialogMain_All_onScreenResize()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  PaGlobal_DialogMain_All:resize()
end
function FromClient_DialogMain_All_ShowDialog()
  PaGlobalFunc_DialogMain_All_Open()
end
function FromClient_DialogMain_All_HideDialog(isSetWait)
  PaGlobalFunc_DialogMain_All_Close(isSetWait)
  PaGlobalFunc_DialogMain_All_RestoreUI(isSetWait)
end
function FromClient_DialogMain_All_CloseNpcTradeMarketTalkForDead()
  PaGlobalFunc_DialogMain_All_CloseWithDialog()
end
function FromClient_DialogMain_All_CloseDialogByAttacked()
  PaGlobal_DialogMain_All._renderMode:reset()
end
function FromClient_DialogMain_All_EventQuestUpdateNotify()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  PaGlobal_DialogMain_All._isDialogStarting = false
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
end
function FromClient_DialogMain_All_PadSnapChangePanel(fromPanel, toPanel)
  if false == PaGlobal_DialogMain_All._initialize then
    return
  end
  if false == PaGlobal_DialogMain_All._isConsole then
    return
  end
  PaGlobal_DialogMain_All._console_snapDialog = false
  if nil ~= toPanel and true == Panel_Npc_Dialog_All:GetShow() then
    if Panel_Npc_Dialog_All:GetKey() ~= toPanel:GetKey() then
      PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(false, false)
    else
      if nil ~= fromPanel and true == fromPanel:GetShow() then
        ToClient_padSnapSetTargetPanel(fromPanel)
        return
      end
      PaGlobal_DialogMain_All._console_snapDialog = true
      PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(false, true)
      if true == PaGlobal_DialogMain_All._isTalkBtnShow then
        return
      end
      PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(true, true)
    end
  end
end
function PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm(index)
  if nil == index then
    index = PaGlobal_DialogMain_All._indexWorkerShopClicked
  end
  npcShop_requestList(CppEnums.ContentsType.Contents_Shop)
end
function PaGlobalFunc_DialogMain_All_BottomFuncBtnUpdate()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  PaGlobal_DialogMain_All:funcBottomBtnUpdate(dialogData)
end
function PaGlobalFunc_DialogMain_All_GetAuctionState()
  return PaGlobal_DialogMain_All._isAuctionDialog
end
function PaGlobalFunc_DialogMain_All_IsDialogNewMainQuest()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  return PaGlobal_DialogMain_All._isDialogNewMainQuest
end
function PaGlobalFunc_DialogMain_All_IsDialogNewQuest()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  return PaGlobal_DialogMain_All._isDialogNewQuest
end
function PaGlobalFunc_DialogMain_All_IsDialogTalk()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  return PaGlobal_DialogMain_All._isDialogNewTalk
end
function PaGlobalFunc_DialogMain_All_IsFuncBtnSpaceShow()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  return PaGlobal_DialogMain_All._isFuncBtnSpaceShow
end
function PaGlobalFunc_DialogMain_IsSearchMode()
  local panel
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    panel = Panel_Widget_Dialog_Search_All
  else
    panel = Panel_Dialog_Search
  end
  if nil == panel then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_DialogMain_All_GetFuncPositionNewQuestButton()
  local Position = {
    _Return = false,
    _PosX = -1,
    _PosY = -1
  }
  local Index = PaGlobalFunc_DialogMain_All_FindFuncButtonIndexByType(CppEnums.ContentsType.Contents_NewQuest)
  if -1 == Index then
    Index = PaGlobalFunc_DialogMain_All_FindFuncButtonIndexByType(CppEnums.ContentsType.Contents_NewMainQuest)
    if -1 == Index then
      return Position
    end
  end
  Position._Return = true
  Position._PosX = PaGlobal_DialogMain_All._funcBtnList[Index]:GetPosX()
  Position._PosY = PaGlobal_DialogMain_All._funcBtnList[Index]:GetPosY()
  return Position
end
function PaGlobalFunc_DialogMain_All_FindFuncButtonIndexByType(targetFuncButtonType)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return -1
  end
  local dialogButtonCount = dialogData:getFuncButtonCount()
  for index = 0, dialogButtonCount - 1 do
    local funcButton = dialogData:getFuncButtonAt(index)
    local funcButtonType = tonumber(funcButton._param)
    if targetFuncButtonType == funcButtonType then
      return index
    end
  end
  return -1
end
function PaGlobalFunc_DialogMain_All_FirstLearnSkill()
  PaGlobal_DialogMain_All._isSkillTutorial = true
  HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_Skill)
  PaGlobal_DialogMain_All._isSkillTutorial = false
end
function PaGlobalFunc_DialogMain_All_IsSkillLearnTutorial()
  return PaGlobal_DialogMain_All._isSkillTutorial
end
function PaGlobalFunc_DialogMain_All_IsAllowTutorialPanelShow()
  return PaGlobal_DialogMain_All._isAllowTutorialPanelShow
end
function PaGlobalFunc_DialogMain_All_SetAllowTutorialPanelShow(isShow)
  PaGlobal_DialogMain_All._isAllowTutorialPanelShow = isShow
end
function PaGlobalFunc_DialogMain_All_MentalGameBtnWpUpdate()
  local selfPlayer = getSelfPlayer()
  local playerWp = 0
  if nil ~= selfPlayer then
    playerWp = selfPlayer:getWp()
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local funcBtnCount = dialogData:getFuncButtonCount()
  for index = 0, funcBtnCount - 1 do
    local functionBtn = dialogData:getFuncButtonAt(index)
    if tonumber(functionBtn._param) == CppEnums.ContentsType.Contents_IntimacyGame then
      PaGlobal_DialogMain_All._funcBtnList[index]:SetText(functionBtn:getText() .. " (" .. functionBtn:getNeedWp() .. "/" .. playerWp .. ")")
    end
  end
end
function PaGlobalFunc_DialogMain_All_GetShowContinueBtn()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  if true == PaGlobal_DialogMain_All._ui_pc.btn_continue:GetShow() then
    return true
  end
  return false
end
function PaGlobalFunc_DialogMain_All_GetShowNextBtn()
  if nil == Panel_Npc_Dialog_All then
    return false
  end
  if true == PaGlobal_DialogMain_All._ui_pc.btn_next:GetShow() then
    return true
  end
  return false
end
function PaGlobalFunc_DialogMain_All_FunctionSizeY()
  if nil == Panel_Npc_Dialog_All then
    return 0
  end
  return Panel_Npc_Dialog_All:GetSizeY()
end
function PaGlobalFunc_DialogMain_All_IsNormalTradeMerchant()
  local talker = dialog_getTalker()
  if nil ~= talker then
    local characterKey = talker:getCharacterKey()
    local npcData = getNpcInfoByCharacterKeyRaw(characterKey, talker:get():getDialogIndex())
    if nil ~= npcData then
      return npcData:hasSpawnType(CppEnums.SpawnType.eSpawnType_TradeMerchant)
    end
  end
  return false
end
function PaGlobalFunc_DialogMain_All_TradeShopOpen()
  if 0 <= PaGlobal_DialogMain_All._tradeIndex then
    HandleEventLUp_DialogMain_All_FuncButton(PaGlobal_DialogMain_All._tradeIndex)
  end
end
function PaGlobalFunc_DialogMain_All_SetDialogStarting(isStarting)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  PaGlobal_DialogMain_All._isDialogStarting = isStarting
end
function PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(isShow, isEvent)
  if false == PaGlobal_DialogMain_All._isConsole then
    isShow = false
    isEvent = false
  end
  if false == PaGlobal_DialogMain_All._console_snapDialog then
    isShow = false
  end
  PaGlobal_DialogMain_All._ui_console.stc_guideIconA:SetShow(isShow)
  PaGlobal_DialogMain_All._ui_console.stc_guideIconLB:SetShow(isShow)
  PaGlobal_DialogMain_All._ui_console.stc_guideIconRB:SetShow(isShow)
end
function PaGlobalFunc_DialogMain_All_UpdateDialogText()
  PaGlobal_DialogMain_All._isTalkBtnShow = false
  local realDialog = ToClient_getReplaceDialog(PaGlobal_DialogMain_All._mainDialog[PaGlobal_DialogMain_All._curLine])
  local dialogData = ToClient_GetCurrentDialogData()
  local funcBtnCount = dialogData:getFuncButtonCount()
  local localizedType = dialogData:getLocalizedTypeForLua()
  local mainDialogLocalizedKey = dialogData:getMainDialogLocalizedKey()
  PaGlobal_DialogMain_All:setTranslationKey(localizedType, mainDialogLocalizedKey)
  PaGlobal_DialogMain_All._ui_pc.btn_continue:SetShow(false)
  PaGlobal_DialogMain_All._ui_pc.btn_next:SetShow(false)
  PaGlobal_DialogMain_All._ui_pc.btn_apply:SetShow(false)
  PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetShow(false)
  PaGlobal_DialogMain_All._ui.txt_contentDesc:SetText(realDialog)
  if PaGlobal_DialogMain_All._curLine < PaGlobal_DialogMain_All._maxLine then
    PaGlobal_DialogMain_All._ui_pc.btn_continue:SetShow(true)
    PaGlobal_DialogMain_All._isTalkBtnShow = true
    if true == PaGlobalFunc_DialogQuest_All_DialogShowCheck() then
      PaGlobalFunc_DialogQuest_All_Close()
      PaGlobalFunc_DialogMain_All_SubPanelSetShow(false)
    end
  else
    PaGlobal_DialogMain_All._ui_pc.btn_continue:SetShow(false)
    if 0 == funcBtnCount and 0 < dialogData:getDialogButtonCount() then
      local dialogButton = dialogData:getDialogButtonAt(0)
      local dialogText = dialogButton:getText()
      local linkType = dialogButton._linkType
      if CppEnums.DialogState.eDialogState_ReContact == tostring(linkType) then
        PaGlobal_DialogMain_All._ui_pc.btn_next:SetShow(true)
        PaGlobal_DialogMain_All._isTalkBtnShow = true
      elseif CppEnums.DialogState.eDialogState_AcceptQuest == tostring(linkType) then
        if false == PaGlobal_DialogMain_All._isConsole then
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_ACCEPT"))
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_DENY"))
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_QuestRefuse()")
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetShow(true)
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetShow(true)
          PaGlobal_DialogMain_All._isTalkBtnShow = true
        else
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetShow(false)
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetShow(false)
        end
        if true == PaGlobalFunc_DialogQuest_All_DialogShowCheck() then
          PaGlobalFunc_DialogQuest_All_Open()
          PaGlobalFunc_DialogMain_All_SubPanelSetShow(false)
        end
      elseif CppEnums.DialogState.eDialogState_QuestComplete == tostring(linkType) then
        if false == PaGlobal_DialogMain_All._isConsole then
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_APPLY"))
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_CANCLE"))
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogQuest_All_QuestCancle()")
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetShow(true)
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetShow(true)
          PaGlobal_DialogMain_All._isTalkBtnShow = true
        else
          PaGlobal_DialogMain_All._ui_pc.btn_apply:SetShow(false)
          PaGlobal_DialogMain_All._ui_pc.btn_cancle:SetShow(false)
        end
        if true == PaGlobalFunc_DialogQuest_All_DialogShowCheck() then
          PaGlobalFunc_DialogQuest_All_Open()
          PaGlobalFunc_DialogMain_All_SubPanelSetShow(false)
        end
      end
    end
    if true == PaGlobalFunc_DialogList_All_IsContactTalk() then
      PaGlobal_DialogMain_All._ui_pc.btn_next:SetShow(true)
      PaGlobal_DialogMain_All._isTalkBtnShow = true
      PaGlobalFunc_DialogList_All_SetContactTalk(false)
    end
    PaGlobal_TutorialManager:handleUpdateMainDialog()
  end
  if false == PaGlobal_DialogMain_All._isConsole then
    Auto_NotifyChangeDialog()
  end
  if true == PaGlobal_DialogMain_All._isTalkBtnShow then
    PaGlobal_DialogMain_All._ui.txt_contentDesc:SetSpanSize(PaGlobal_DialogMain_All._ui.txt_contentDesc:GetSpanSize().x, -120)
    PaGlobal_DialogMain_All:buttonSpaceBarcheck(false)
    PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(false, true)
  else
    PaGlobal_DialogMain_All._ui.txt_contentDesc:SetSpanSize(PaGlobal_DialogMain_All._ui.txt_contentDesc:GetSpanSize().x, -60)
    PaGlobal_DialogMain_All:buttonSpaceBarcheck(true)
    PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(true, true)
  end
  PaGlobal_DialogMain_All._ui.txt_contentDesc:ComputePos()
  return realDialog
end
function PaGlobalFunc_DialogMain_All_GetContentSizeY()
  if nil == Panel_Npc_Dialog_All or nil == PaGlobal_DialogMain_All._ui.txt_contentDesc then
    return 0
  end
  return PaGlobal_DialogMain_All._ui.txt_contentDesc:GetTextSizeY()
end
function PaGlobalFunc_DialogMain_All_SetProposeToNpc()
  local dialog = ToClient_getNpcProposeTalk()
  if "" == dialog then
    return
  end
  PaGlobal_DialogMain_All._mainDialog = {}
  PaGlobal_DialogMain_All._maxLine = 0
  PaGlobal_DialogMain_All._curLine = 0
  local stringList = string.split(dialog, "\n")
  local i = 0
  local strFirst, strSecond
  while true do
    strFirst = stringList[i * 2 + 1]
    strSecond = stringList[i * 2 + 2]
    if strFirst ~= nil and strSecond ~= nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst .. "\n" .. strSecond
    elseif strFirst == nil then
      break
    elseif strSecond == nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst
      break
    end
    i = i + 1
  end
  PaGlobal_DialogMain_All._maxLine = #PaGlobal_DialogMain_All._mainDialog
  PaGlobalFunc_DialogMain_All_UpdateDialogText()
end
function PaGlobalFunc_DialogMain_All_SetExchangeNpcDialog()
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  local mainDialog = dialogData:getMainDialog()
  if mainDialog == "" then
    ToClient_PopDialogueFlush()
    return
  end
  PaGlobal_DialogMain_All._mainDialog = {}
  PaGlobal_DialogMain_All._maxLine = 0
  PaGlobal_DialogMain_All._curLine = 0
  local stringList = string.split(mainDialog, "\n")
  local i = 0
  local strFirst, strSecond
  while true do
    strFirst = stringList[i * 2 + 1]
    strSecond = stringList[i * 2 + 2]
    if strFirst ~= nil and strSecond ~= nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst .. "\n" .. strSecond
    elseif strFirst == nil then
      break
    elseif strSecond == nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst
      break
    end
    i = i + 1
  end
  PaGlobal_DialogMain_All._maxLine = #PaGlobal_DialogMain_All._mainDialog
  PaGlobalFunc_DialogMain_All_UpdateDialogText()
end
function PaGlobalFunc_DialogMain_All_SetNpcDialogReset()
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  dialogData:setDefaultMainDialog()
  local mainDialog = dialogData:getMainDialog()
  if mainDialog == "" then
    ToClient_PopDialogueFlush()
    return
  end
  PaGlobal_DialogMain_All._mainDialog = {}
  PaGlobal_DialogMain_All._maxLine = 0
  PaGlobal_DialogMain_All._curLine = 0
  local stringList = string.split(mainDialog, "\n")
  local i = 0
  local strFirst, strSecond
  while true do
    strFirst = stringList[i * 2 + 1]
    strSecond = stringList[i * 2 + 2]
    if strFirst ~= nil and strSecond ~= nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst .. "\n" .. strSecond
    elseif strFirst == nil then
      break
    elseif strSecond == nil then
      PaGlobal_DialogMain_All._mainDialog[i] = strFirst
      break
    end
    i = i + 1
  end
  PaGlobal_DialogMain_All._maxLine = #PaGlobal_DialogMain_All._mainDialog
  PaGlobalFunc_DialogMain_All_UpdateDialogText()
end
function isVisibleButton(buttonValue)
  local dialogData = ToClient_GetCurrentDialogData()
  if dialogData ~= nil then
    local dialogButtonCount = dialogData:getDialogButtonCount()
    for i = _dialogIndex, dialogButtonCount - 1 do
      local dialogButton = dialogData:getDialogButtonAt(i)
      if dialogButton ~= nil and buttonValue == tostring(dialogButton._linkType) then
        return true
      end
    end
  end
  return false
end
function isVisibleAcceptButton()
  return isVisibleButton(CppEnums.DialogState.eDialogState_AcceptQuest)
end
function PaGlobalFunc_DialogMain_All_RestoreUI(isSetWait)
  if nil ~= Panel_SkillCommand then
    if FGlobal_IsChecked_SkillCommand() == true then
      Panel_SkillCommand:SetShow(true)
      changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, true, true, false)
    else
      Panel_SkillCommand:SetShow(false)
      changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, true, true, false)
    end
  end
  PaGlobalFunc_DialogMain_All_ResetRenderMode()
  local questNo = getTutorialQuestNo()
  if -1 == questNo then
    setTutorialQuestNo(-1)
  elseif 0 ~= questNo then
    Tutorial_Quest(questNo)
    setTutorialQuestNo(0)
  else
    setTutorialQuestNo(-1)
  end
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
  end
  if nil == isSetWait then
    isSetWait = true
  end
  Dialog_clickExitReq(isSetWait)
  checkHpAlertPostEvent()
end
function PaGlobalFunc_DialogMain_All_SetRenderModeList(renderModeList)
  PaGlobal_DialogMain_All._renderMode:setRenderMode(renderModeList)
end
function PaGlobalFunc_DialogMain_All_SetRenderMode()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  PaGlobal_DialogMain_All._renderMode:set()
  local mainCameraName = Dialog_getMainSceneCameraName()
  if nil ~= mainCameraName then
    changeCameraScene(mainCameraName, 0.3)
  end
end
function PaGlobalFunc_DialogMain_All_ResetRenderMode()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  if nil ~= Panel_Npc_Dialog_All then
    PaGlobal_DialogMain_All._renderMode:reset()
    return
  end
end
function PaGlobalFunc_DialogMain_All_renderSetPrefunctor()
  PaGlobal_DialogMain_All._showCheck_Once = true
end
function PaGlobalFunc_DialogMain_All_renderSetClosefunctor()
  PaGlobalFunc_DialogMain_All_CloseWithDialog()
  PaGlobalFunc_DialogMain_All_Close(true)
end
function FromClient_UpdateMainDialogText()
  PaGlobalFunc_DialogMain_All_SetNpcDialogReset()
end
