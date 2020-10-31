function PaGlobal_DialogMain_All:initialize()
  if true == PaGlobal_DialogMain_All._initialize then
    return
  end
  Panel_Npc_Dialog_All:SetSize(getScreenSizeX(), Panel_Npc_Dialog_All:GetSizeY())
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:initValue()
  PaGlobal_DialogMain_All:registEventHandler()
  PaGlobal_DialogMain_All:validate()
  PaGlobal_DialogMain_All._initialize = true
end
function PaGlobal_DialogMain_All:initValue()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  self._showCheck_Once = false
  local btn_template = UI.getChildControl(Panel_Npc_Dialog_All, "RadioButton_Function_Template")
  btn_template:SetShow(false)
  for index = 0, self._maxFuncBtnIndex do
    local btn_slot = {}
    btn_slot = UI.cloneControl(btn_template, Panel_Npc_Dialog_All, "RadioBuntton_Func_" .. index)
    self._funcBtnList[index] = btn_slot
  end
  if true == getGamePadEnable() then
    PaGlobalFunc_DialogKeyManager_All_SetGamePadEnable(true)
  end
end
function PaGlobal_DialogMain_All:controlAll_Init()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  self._ui.txt_contentDesc = UI.getChildControl(Panel_Npc_Dialog_All, "StaticText_DialogText")
  self._ui.btn_template = UI.getChildControl(Panel_Npc_Dialog_All, "RadioButton_Function_Template")
  self._ui.stc_selectBar = UI.getChildControl(Panel_Npc_Dialog_All, "Static_SelectBar")
  self._ui.stc_bg = UI.getChildControl(Panel_Npc_Dialog_All, "Static_FunctionButtonBg")
  if false == isGameTypeKorea() or true == ToClient_IsDevelopment() then
    self._ui.txt_contentDesc:SetIgnore(false)
  end
end
function PaGlobal_DialogMain_All:controlPc_Init()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  self._ui_pc.stc_spaceBar = UI.getChildControl(Panel_Npc_Dialog_All, "Static_SpaceBarIcon")
  self._ui_pc.btn_blackSpiritSkillSelect = UI.getChildControl(Panel_Npc_Dialog_All, "Button_BlackSpirt_SkillSelect")
  self._ui_pc.btn_blackSpiritSkillSelect:SetShow(false)
  self._ui_pc.btn_continue = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Continue")
  self._ui_pc.btn_apply = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Accept")
  self._ui_pc.btn_cancle = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Cancel")
  self._ui_pc.btn_back = UI.getChildControl(Panel_Npc_Dialog_All, "RadioButton_Back")
  self._ui_pc.btn_exit = UI.getChildControl(Panel_Npc_Dialog_All, "RadioButton_Exit")
  self._ui_pc.btn_next = UI.getChildControl(Panel_Npc_Dialog_All, "Button_Next")
end
function PaGlobal_DialogMain_All:controlConsole_Init()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  self._ui_console.stc_guideIconA = UI.getChildControl(Panel_Npc_Dialog_All, "Button_A_ConsoleUI")
  self._ui_console.stc_guideIconLB = UI.getChildControl(Panel_Npc_Dialog_All, "Button_LB_ConsoleUI")
  self._ui_console.stc_guideIconRB = UI.getChildControl(Panel_Npc_Dialog_All, "Button_RB_ConsoleUI")
  self._ui_console.stc_guideIconA:SetSpanSize(self._ui_console.stc_guideIconA:GetTextSizeX() + 20, self._ui_console.stc_guideIconA:GetSpanSize().y)
end
function PaGlobal_DialogMain_All:controlSetShow()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  self._ui_pc.stc_spaceBar:SetShow(false)
  self._ui.stc_selectBar:SetShow(false)
  self._ui_pc.btn_apply:SetShow(false)
  self._ui_pc.btn_cancle:SetShow(false)
  self._ui_pc.btn_continue:SetShow(false)
  self._ui_pc.btn_next:SetShow(false)
  self._ui_console.stc_guideIconA:SetShow(false)
  local continueShotKey_pc = UI.getChildControl(self._ui_pc.btn_continue, "StaticText_ShortKey")
  local continueShotKey_console = UI.getChildControl(self._ui_pc.btn_continue, "Button_ShortKeyA_ConsoleUI")
  continueShotKey_pc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY"))
  local nextShotKey_pc = UI.getChildControl(self._ui_pc.btn_next, "StaticText_ShortKey")
  local nextShotKey_console = UI.getChildControl(self._ui_pc.btn_next, "Button_ShortKeyA_ConsoleUI")
  nextShotKey_pc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY"))
  local applyShortKey_console = UI.getChildControl(self._ui_pc.btn_apply, "Button_ShortKeyA_ConsoleUI")
  local cancleShortKey_console = UI.getChildControl(self._ui_pc.btn_cancle, "Button_ShortKeyB_ConsoleUI")
  if false == self._isConsole then
    nextShotKey_pc:SetShow(true)
    nextShotKey_console:SetShow(false)
    continueShotKey_pc:SetShow(true)
    continueShotKey_console:SetShow(false)
    applyShortKey_console:SetShow(false)
    cancleShortKey_console:SetShow(false)
    PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(false, false)
  else
    self._ui_pc.btn_back:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_DIALOG_MAIN_GOFIRST"))
    self._ui_pc.btn_exit:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_DIALOG_MAIN_LEAVE"))
    nextShotKey_pc:SetShow(false)
    nextShotKey_console:SetShow(true)
    continueShotKey_pc:SetShow(false)
    continueShotKey_console:SetShow(true)
    applyShortKey_console:SetShow(true)
    cancleShortKey_console:SetShow(true)
    PaGlobalFunc_DialogMain_All_ConsoleKeyGuideSet(true, true)
  end
end
function PaGlobal_DialogMain_All:resize()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  Panel_Npc_Dialog_All:SetSize(getScreenSizeX() + 20, Panel_Npc_Dialog_All:GetSizeY())
  self._ui.stc_bg:SetSize(getScreenSizeX(), self._ui.stc_bg:GetSizeY())
  Panel_Npc_Dialog_All:ComputePos()
  self._ui.stc_bg:ComputePos()
  self._ui_pc.btn_continue:ComputePos()
  self._ui_pc.btn_apply:ComputePos()
  self._ui_pc.btn_cancle:ComputePos()
  self._ui_pc.btn_back:ComputePos()
  self._ui_pc.btn_exit:ComputePos()
  self._ui_pc.btn_next:ComputePos()
  self._ui.txt_contentDesc:ComputePos()
  for index = 0, self._maxFuncBtnIndex do
    self._funcBtnList[index]:ComputePos()
  end
  local buttonSize = 150
  self._ui_console.stc_guideIconLB:SetPosX(self._ui_pc.btn_back:GetPosX() - self._ui_pc.btn_back:GetSizeX() / 2 - buttonSize / 2)
  self._ui_console.stc_guideIconRB:SetPosX(self._ui_pc.btn_exit:GetPosX() + self._ui_pc.btn_exit:GetSizeX() / 2 + buttonSize / 2)
  self._ui_console.stc_guideIconA:ComputePos()
  PaGlobalFunc_DialogMain_All_BottomFuncBtnUpdate()
end
function PaGlobal_DialogMain_All:prepareOpen()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if true == PaGlobal_QAServantSupportOn then
    return
  end
  if false == _ContentsGroup_NewUI_Dialog_All then
    return
  end
  if nil ~= PaGlobal_SkillGroup and true == Panel_Window_SkillGroup:GetShow() and false == PaGlobal_SkillGroup._isWindow then
    ToClient_PopDialogueFlush()
    SetUIMode(Defines.UIMode.eUIMode_SkillWindow)
    return
  end
  PaGlobal_TutorialManager:handleBeforeShowDialog()
  FGlobal_WebHelper_ForceClose()
  if CheckTutorialEnd() then
    ToClient_SaveUiInfo(false)
  end
  PaGloalFunc_DialogMain_All_PreClosePanel()
  if false == self._isDialogStarting and nil ~= Panel_Dialog_Exchange_All and false == Panel_Dialog_Exchange_All:GetShow() then
    PaGlobalFunc_InterestKnowledge_All_Open()
  end
  if GetUIMode() ~= Defines.UIMode.eUIMode_Default and GetUIMode() ~= Defines.UIMode.eUIMode_NpcDialog and GetUIMode() ~= Defines.UIMode.eUIMode_NpcDialog_Dummy and GetUIMode() ~= Defines.UIMode.eUIMode_ItemMarket then
    ToClient_PopDialogueFlush()
    return
  end
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
  local localizedType = dialogData:getLocalizedTypeForLua()
  local mainDialogLocalizedKey = dialogData:getMainDialogLocalizedKey()
  self._ui.txt_contentDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_contentDesc:setLocalizedStaticType(localizedType)
  self._ui.txt_contentDesc:setLocalizedKey(mainDialogLocalizedKey)
  self._mainDialog = {}
  self._maxLine = 0
  self._curLine = 0
  local stringList = string.split(mainDialog, "\n")
  local i = 0
  local strFirst, strSecond
  while true do
    strFirst = stringList[i * 2 + 1]
    strSecond = stringList[i * 2 + 2]
    if strFirst ~= nil and strSecond ~= nil then
      self._mainDialog[i] = strFirst .. "\n" .. strSecond
    elseif strFirst == nil then
      break
    elseif strSecond == nil then
      self._mainDialog[i] = strFirst
      break
    end
    i = i + 1
  end
  self._maxLine = #self._mainDialog
  if not isFullSizeModeAble(FullSizeMode.fullSizeModeEnum.Dialog) then
    ToClient_PopDialogueFlush()
    return
  else
    setFullSizeMode(true, FullSizeMode.fullSizeModeEnum.Dialog)
  end
  if _ContentsGroup_NewUI_WareHouse_All then
    FromClient_Warehouse_All_Update()
  else
    FromClient_WarehouseUpdate()
  end
  warehouse_requestInfo(getCurrentWaypointKey())
  setShowLine(false)
  setShowNpcDialog(true)
  PaGlobalFunc_DialogQuest_All_SetRewardList()
  PaGlobal_TutorialManager:handleShowDialog(dialogData)
  audioPostEvent_SystemUi(1, 19)
  _AudioPostEvent_SystemUiForXBOX(1, 19)
  if true == PaGlobal_DialogMain_All._isDialogNewMainQuest or true == PaGlobal_DialogMain_All._isDialogNewQuest then
    audioPostEvent_SystemUi(4, 4)
    _AudioPostEvent_SystemUiForXBOX(4, 4)
  end
  if true == PaGlobal_DialogMain_All._isDialogNewTalk then
    audioPostEvent_SystemUi(4, 4)
    _AudioPostEvent_SystemUiForXBOX(4, 4)
  end
  PaGlobal_DialogMain_All:resize()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_PosSave()
  else
    Inventory_PosSaveMemory()
  end
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  self._renderMode:set()
  self:update(dialogData)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_DIALOG")
  PaGlobal_DialogMain_All:open()
end
function PaGlobal_DialogMain_All:open()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
    return
  end
  Panel_Npc_Dialog_All:SetShow(true)
end
function PaGlobal_DialogMain_All:prepareClose(isSetWait, isTest, isAttacked)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if false == Panel_Npc_Dialog_All:IsShow() then
    return
  end
  if true == MessageBoxPanelNilCheck() and true == MessageBoxGetShow() then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if selfPlayer:getLevel() < 5 and false == _ContentsGroup_RenewUI_Chatting and nil ~= Panel_Chat0 then
    Panel_Chat0:SetShow(false)
  end
  local currentRegionKeyRaw = selfPlayerWrapper:getRegionKeyRaw()
  if 1 == selfPlayer:getLevel() and 10 == currentRegionKeyRaw and nil == dialog_getTalker() and false == questList_isClearQuest(21117, 1) and false == questList_hasProgressQuest(21117, 1) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TUTIRIAL_DIALOGCLOSEALERT"))
    return
  end
  if false == PaGlobalFunc_DialogMain_All_CloseWithDialog() and false == isAttacked then
    return
  end
  if false == self._isConsole then
    Auto_NotifyChangeDialog()
    PaGlobal_LocalQuestAlert_AlertOpen()
  end
  local talker = dialog_getTalker()
  if nil == talker and true == _ContentsGroup_RemasterUI_Main_Alert then
    PaGlobal_Widget_Alert_BlackSpiritIcon_Effect()
  end
  ToClient_PopDialogueFlush()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_FlushRestoreFunc()
  else
    inventory_FlushRestoreFunc()
  end
  FGlobal_NewLocalWar_Show()
  QuickSlot_UpdateData()
  FGlobal_QuestWidget_CalcScrollButtonSize()
  FGlobal_QuestWidget_UpdateList()
  PaGlobalFunc_DialogList_All_SetContactTalk(false)
  self._showCheck_Once = false
  self._isAuctionDialog = false
  self._blackSpiritUiShow = false
  self._selectDialogFuncIndex = nil
  self._isDialogStarting = false
  self._console_overIdx = 1
  self._console_snapDialog = false
  PaGlobal_TutorialManager:handleAfterAndPopFlush()
  PaGlobal_TutorialManager:handleClickedExitButton(dialog_getTalker())
  ToClient_SetFilterType(0, false)
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    FGlobal_Inventory_WeightCheck()
    if false == self._isConsole then
      UIMain_QuestUpdate()
    end
  end
  if nil ~= PaGlobal_EmployeeHireItem_All then
    PaGlobal_EmployeeHireItem_All:prepareClose()
  end
  if nil ~= Panel_Window_SeasonReward_All then
    PaGlobal_SeasonReward_All_Close()
  end
  hide_DialogSceneUIPanel()
  if true == _ContentsGroup_NewUI_Inventory_All then
    PaGlobalFunc_Inventory_All_FindPuzzle()
  else
    Inven_FindPuzzle()
  end
  Panel_Npc_Dialog_All:ResetVertexAni()
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    PaGlobalFunc_DialogSearch_All_Close()
  else
    searchView_Close()
  end
  PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(false)
  setShowLine(true)
  setShowNpcDialog(false)
  setFullSizeMode(false, FullSizeMode.fullSizeModeEnum.Dialog)
  if _ContentsGroup_NewUI_NpcNavi_All then
    PaGlobal_NpcNavi_All_ShowRequestOuter()
  else
    FGlobal_NpcNavi_ShowRequestOuter()
  end
  if ToClient_IsSavedUi() then
    ToClient_SaveUiInfo(false)
    ToClient_SetSavedUi(false)
  end
  if self._isConsole then
    PaGlobal_questBranch_IsQuestBranch()
  end
  self._currentIdx = nil
  self._ui.stc_selectBar:SetShow(false)
  audioPostEvent_SystemUi(1, 20)
  _AudioPostEvent_SystemUiForXBOX(1, 20)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  PaGlobal_DialogMain_All:close()
end
function PaGlobal_DialogMain_All:close()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  Panel_Npc_Dialog_All:SetShow(false)
end
function PaGlobal_DialogMain_All:update(dialogData)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == dialogData then
    return
  end
  local talker = dialog_getTalker()
  if nil ~= talker then
    self._ui_pc.btn_blackSpiritSkillSelect:SetShow(false)
  else
    self._ui_pc.btn_blackSpiritSkillSelect:SetShow(ToClient_isAvailableSelectBlackSpirit())
    self._ui_pc.btn_blackSpiritSkillSelect:ComputePos()
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobal_Inventory_All_CheckBlackStoneAndSocket()
    end
  end
  self:funcBottomBtnUpdate(dialogData)
  local realDialog = PaGlobalFunc_DialogMain_All_UpdateDialogText()
  self._ui.txt_contentDesc:SetText(realDialog)
  PaGlobalFunc_DialogList_All_Close()
  PaGlobalFunc_DialogIntimacy_All_Open()
  if true == PaGlobalFunc_DialogQuest_All_DialogShowCheck() then
  else
    PaGlobalFunc_DialogQuest_All_Close()
  end
  self:executeAfterDialogLoad(dialogData)
end
function PaGlobal_DialogMain_All:validate()
  if nil == Panel_Npc_Dialog_All then
    return
  end
end
function PaGlobal_DialogMain_All:funcBottomBtnUpdate(dialogData)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == dialogData then
    return
  end
  self._isDialogNewMainQuest = false
  self._isDialogNewQuest = false
  self._isDialogNewTalk = false
  self._isMainQuestShow = false
  self._ui_pc.stc_spaceBar:SetShow(false)
  self._ui_pc.btn_next:SetShow(false)
  self._ui_pc.btn_apply:SetShow(false)
  self._ui_pc.btn_cancle:SetShow(false)
  self._tradeIndex = -1
  self._hotKeyIdx = 1
  self._hotKeyAddCount = 0
  self._dialogIndex.MAINQUEST = -1
  self._dialogIndex.QUEST = -1
  self._dialogIndex.TALK = -1
  self._console_bottomButtonCnt = 0
  self._console_bottomButtons = {}
  local consoleArrayIdx = 0
  self._console_bottomButtons[consoleArrayIdx] = self._ui_pc.btn_back
  for index = 0, self._maxFuncBtnIndex do
    self._funcBtnList[index]:SetShow(false)
    if false == self._isConsole then
      self._funcBtnList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_FuncButton(" .. index .. ")")
    end
  end
  for index = 0, #self._HOTKEY do
    self._HOTKEY[index].idx = nil
  end
  local totalBtnCount = 2
  local funcBtnCount = dialogData:getFuncButtonCount()
  totalBtnCount = totalBtnCount + dialogData:getFuncButtonCount()
  if 2 == totalBtnCount then
    self._ui_pc.btn_back:SetSpanSize(-90, 15)
    self._ui_pc.btn_exit:SetSpanSize(90, 15)
    if true == self._isConsole then
      self._console_overIdx = 0
      self._console_bottomButtonCnt = 1
      self._console_bottomButtons[1] = self._ui_pc.btn_exit
      local selectBarPosX = self._console_bottomButtons[0]:GetPosX() + self._console_bottomButtons[0]:GetSizeX() / 2 - self._ui.stc_selectBar:GetSizeX() / 2
      self._ui.stc_selectBar:SetPosX(selectBarPosX)
      self._ui.stc_selectBar:SetShow(true)
    end
    return
  end
  local buttonSize = 150
  local buttonGap = 30
  local startPosX = (getScreenSizeX() - (buttonSize * funcBtnCount + buttonGap * (funcBtnCount - 1))) / 2 + 60
  local posX = 0
  for index = 0, funcBtnCount - 1 do
    local functionBtn = dialogData:getFuncButtonAt(index)
    posX = startPosX + (buttonSize + buttonGap) * index
    self._funcBtnList[index]:SetPosX(posX)
    self._funcBtnList[index]:SetShow(true)
    self:funcBtnAtUpdate(index, functionBtn)
  end
  self._ui_pc.btn_back:SetPosX(startPosX - buttonSize - buttonGap)
  self._ui_pc.btn_exit:SetPosX(posX + buttonSize + buttonGap)
  self._ui_pc.btn_back:SetCheck(false)
  self._ui_pc.btn_exit:SetCheck(false)
  if true == self._isConsole then
    consoleArrayIdx = consoleArrayIdx + 1
    for index = 0, funcBtnCount - 1 do
      self._console_bottomButtons[consoleArrayIdx] = self._funcBtnList[index]
      consoleArrayIdx = consoleArrayIdx + 1
    end
    self._console_bottomButtons[consoleArrayIdx] = self._ui_pc.btn_exit
    self._console_bottomButtonCnt = consoleArrayIdx
    local selectBarPosX = self._console_bottomButtons[self._console_overIdx]:GetPosX() + self._console_bottomButtons[self._console_overIdx]:GetSizeX() / 2 - self._ui.stc_selectBar:GetSizeX() / 2
    self._ui.stc_selectBar:SetPosX(selectBarPosX)
    self._ui.stc_selectBar:SetShow(true)
    self._ui_console.stc_guideIconLB:SetPosX(self._ui_pc.btn_back:GetPosX() - self._ui_pc.btn_back:GetSizeX() / 2 - buttonSize / 2)
    self._ui_console.stc_guideIconRB:SetPosX(self._ui_pc.btn_exit:GetPosX() + self._ui_pc.btn_exit:GetSizeX() / 2 + buttonSize / 2)
  else
    self:buttonSpaceBarcheck(true)
  end
  self:buttonColorSetting(self._selectDialogFuncIndex)
end
function PaGlobal_DialogMain_All:funcBtnAtUpdate(index, functionBtn)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == functionBtn then
    return
  end
  local playerWp = 0
  local playerLevel = 0
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    playerWp = selfPlayer:getWp()
    playerLevel = selfPlayer:get():getLevel()
  end
  local funcButtonType = tonumber(functionBtn._param)
  if funcButtonType == CppEnums.ContentsType.Contents_NewMainQuest or funcButtonType == CppEnums.ContentsType.Contents_MainQuest then
    self._isMainQuestShow = true
  end
  self:funcBtnAtSetText(index, functionBtn:getText())
  for i, v in ipairs(self._iconUpdateType) do
    if funcButtonType == self._iconUpdateType[i] then
      self:funcBtnIconUpdate(index, funcButtonType)
    end
  end
  self:funcBtnHotKeyUpdate(index, funcButtonType)
  if funcButtonType == CppEnums.ContentsType.Contents_IntimacyGame then
    local intimacyBtnText = functionBtn:getText() .. " (" .. functionBtn:getNeedWp() .. "/" .. playerWp .. ")"
    self:funcBtnAtSetText(index, intimacyBtnText)
  elseif funcButtonType == CppEnums.ContentsType.Contents_NewMainQuest then
    local dialogData = ToClient_GetCurrentDialogData()
    if nil ~= dialogData and tostring(dialogData:getDialogState()) ~= CppEnums.DialogState.eDialogState_Help then
      self._isDialogNewMainQuest = true
      self._dialogIndex.MAINQUEST = index
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_NewQuest then
    local dialogData = ToClient_GetCurrentDialogData()
    if nil ~= dialogData and tostring(dialogData:getDialogState()) ~= CppEnums.DialogState.eDialogState_Help then
      self._isDialogNewQuest = true
      self._dialogIndex.QUEST = index
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Auction then
    self._isAuctionDialog = true
  elseif funcButtonType == CppEnums.ContentsType.Contents_Shop then
    if true == PaGlobalFunc_DialogMain_All_IsNormalTradeMerchant() then
      self._tradeIndex = index
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Employee then
    if nil ~= PaGlobal_EmployeeHireItem_All then
      PaGlobal_EmployeeHireItem_All:prepareOpen()
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Stable then
    if true == isGuildStable() then
      if CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
        self:funcBtnIconUpdate(index, funcButtonType)
      elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
        self:funcBtnIconUpdate(index, 9.1)
      end
    elseif CppEnums.ServantType.Type_Vehicle == stable_getServantType() then
      self:funcBtnIconUpdate(index, funcButtonType)
    elseif CppEnums.ServantType.Type_Ship == stable_getServantType() then
      self:funcBtnIconUpdate(index, 9.1)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Talk then
    local dialogData = ToClient_GetCurrentDialogData()
    if nil ~= dialogData and false == self._isDialogNewMainQuest and false == self._isDialogNewQuest and tostring(dialogData:getDialogState()) ~= CppEnums.DialogState.eDialogState_Help then
      self._isDialogNewTalk = true
      self._dialogIndex.TALK = index
    end
  end
  self:funcBtnIconEffetc(index, funcButtonType)
end
function PaGlobal_DialogMain_All:funcBtnAtSetText(index, textStr)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == self._funcBtnList[index] then
    return
  end
  local beforeSizeX = self._funcBtnList[index]:GetSizeX()
  self._funcBtnList[index]:SetSize(self._funcBtnSizeX, self._funcBtnList[index]:GetSizeY())
  if false == self._isConsole then
    self._funcBtnList[index]:SetTextMode(__eTextMode_LimitText)
  else
    self._funcBtnList[index]:SetTextMode(__eTextMode_AutoWrap)
  end
  self._funcBtnList[index]:SetText(textStr)
  self._funcBtnList[index]:SetSize(beforeSizeX, self._funcBtnList[index]:GetSizeY())
  self._funcBtnList[index]:SetEnableArea(self._funcBtnEnable.x1, self._funcBtnEnable.y1, self._funcBtnEnable.x2, self._funcBtnEnable.y2)
  if true == self._funcBtnList[index]:IsLimitText() then
    self._funcBtnList[index]:addInputEvent("Mouse_On", "HandleEventOnOut_DialogMain_All_BtnTextLimitTooltip(true," .. index .. ")")
    self._funcBtnList[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogMain_All_BtnTextLimitTooltip(false," .. index .. ")")
  else
    self._funcBtnList[index]:addInputEvent("Mouse_On", "")
    self._funcBtnList[index]:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_DialogMain_All:funcBtnIconUpdate(index, funcBtnType)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == index or nil == funcBtnType then
    return
  end
  self._funcBtnList[index]:ChangeTextureInfoName(self._funcBtnTexturePath)
  self._funcBtnList[index]:ChangeOnTextureInfoName(self._funcBtnTexturePath)
  self._funcBtnList[index]:ChangeClickTextureInfoName(self._funcBtnTexturePath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._funcBtnList[index], self._funcBtnTextureUV[funcBtnType].base.x1, self._funcBtnTextureUV[funcBtnType].base.y1, self._funcBtnTextureUV[funcBtnType].base.x2, self._funcBtnTextureUV[funcBtnType].base.y2)
  self._funcBtnList[index]:getBaseTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(self._funcBtnList[index], self._funcBtnTextureUV[funcBtnType].on.x1, self._funcBtnTextureUV[funcBtnType].on.y1, self._funcBtnTextureUV[funcBtnType].on.x2, self._funcBtnTextureUV[funcBtnType].on.y2)
  self._funcBtnList[index]:getOnTexture():setUV(x1, y1, x2, y2)
  x1, y1, x2, y2 = setTextureUV_Func(self._funcBtnList[index], self._funcBtnTextureUV[funcBtnType].click.x1, self._funcBtnTextureUV[funcBtnType].click.y1, self._funcBtnTextureUV[funcBtnType].click.x2, self._funcBtnTextureUV[funcBtnType].click.y2)
  self._funcBtnList[index]:getClickTexture():setUV(x1, y1, x2, y2)
  self._funcBtnList[index]:setRenderTexture(self._funcBtnList[index]:getBaseTexture())
end
function PaGlobal_DialogMain_All:funcBtnHotKeyUpdate(index, funcBtnType)
  if true == self._isConsole then
    return
  end
  local hotKey = UI.getChildControl(self._funcBtnList[index], "StaticText_HotKey")
  hotKey:SetShow(false)
  local colorAni1 = hotKey:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  colorAni1:SetStartColor(Defines.Color.C_FFFFFFFF)
  colorAni1:SetEndColor(Defines.Color.C_FFFFFFFF)
  local colorAni2 = hotKey:addColorAnimation(4, 5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  colorAni2:SetStartColor(Defines.Color.C_FFFFFFFF)
  colorAni2:SetEndColor(Defines.Color.C_99FFFFFF)
  if funcBtnType == CppEnums.ContentsType.Contents_NewMainQuest or funcBtnType == CppEnums.ContentsType.Contents_MainQuest then
    self._HOTKEY[0].idx = index
    hotKey:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_HOTKEY_FUNCBTN_QUEST"))
    hotKey:SetShow(true, true)
    self._hotKeyAddCount = self._hotKeyAddCount + 1
    return
  end
  if funcBtnType == CppEnums.ContentsType.Contents_NewQuest or funcBtnType == CppEnums.ContentsType.Contents_Quest then
    if false == self._isMainQuestShow then
      self._HOTKEY[0].idx = index
      hotKey:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_HOTKEY_FUNCBTN_QUEST"))
    else
      self._HOTKEY[9].idx = index
      hotKey:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_HOTKEY_FUNCBTN_QUEST2"))
    end
    hotKey:SetShow(true, true)
    self._hotKeyAddCount = self._hotKeyAddCount + 1
    return
  end
  if funcBtnType == CppEnums.ContentsType.Contents_Talk then
    self._HOTKEY[1].idx = index
    hotKey:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILOG_HOTKEY_FUNCBTN_TALK"))
    hotKey:SetShow(true, true)
    self._hotKeyAddCount = self._hotKeyAddCount + 1
    return
  end
  if funcBtnType == CppEnums.ContentsType.Contents_Exchange then
    self._HOTKEY[2].idx = index
    hotKey:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DAILOG_HOTKEY_FUNCBTN_EXCHANGE"))
    hotKey:SetShow(true, true)
    self._hotKeyAddCount = self._hotKeyAddCount + 1
    return
  end
  local atIdx = 2 + self._hotKeyIdx
  self._HOTKEY[atIdx].idx = index
  hotKey:SetText(self._HOTKEY[atIdx].string)
  hotKey:SetShow(true, true)
  self._hotKeyIdx = self._hotKeyIdx + 1
  return
end
function PaGlobal_DialogMain_All:funcBtnIconEffetc(index, funcButtonType)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if nil == index or nil == funcButtonType then
    return
  end
  self._funcBtnList[index]:EraseAllEffect()
  if funcButtonType == CppEnums.ContentsType.Contents_Enchant then
    local hasBlackStone = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      hasBlackStone = true == PaGlobalFunc_Inventory_All_HasWeaponBlackStone() or true == PaGlobalFunc_Inventory_All_HasArmorBlackStone()
    else
      hasBlackStone = true == Panel_Inventory_isBlackStone_16001 or true == Panel_Inventory_isBlackStone_16002
    end
    if true == hasBlackStone then
      self._funcBtnList[index]:AddEffect("fUI_Dialog_01B", true, 0, 0)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Socket then
    local hasSocketItem = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      hasSocketItem = true == PaGlobalFunc_Inventory_All_HasSocketItem()
    else
      hasSocketItem = true == Panel_Inventory_isSocketItem
    end
    if true == hasSocketItem then
      self._funcBtnList[index]:AddEffect("fUI_Dialog_01C", true, 0, 0)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Awaken then
    local player = getSelfPlayer()
    if nil == player then
      return
    end
    local selfPlayLevel = player:get():getLevel()
    local reinforceableSkillCount = 0
    if selfPlayLevel < 50 then
      reinforceableSkillCount = 0
    elseif selfPlayLevel < 52 then
      reinforceableSkillCount = 1
    elseif selfPlayLevel < 54 then
      reinforceableSkillCount = 2
    elseif selfPlayLevel < 56 then
      reinforceableSkillCount = 3
    elseif selfPlayLevel < 58 then
      reinforceableSkillCount = 4
    elseif selfPlayLevel < 60 then
      reinforceableSkillCount = 5
    else
      reinforceableSkillCount = 6
    end
    local skillAwakeningCount = ToClient_GetSkillAwakeningCount()
    local weaponSkillAwakeningCount = ToClient_GetWeaponSkillAwakeningCount()
    local currentSkillAwakeningCount = skillAwakeningCount + weaponSkillAwakeningCount
    if reinforceableSkillCount > currentSkillAwakeningCount then
      self._funcBtnList[index]:AddEffect("fUI_Dialog_01D", true, 0, 0)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_ReAwaken then
    self._funcBtnList[index]:AddEffect("fUI_Dialog_01D", true, 0, 0)
  elseif funcButtonType == CppEnums.ContentsType.Contents_NewMainQuest then
    if true == self._isDialogNewMainQuest then
      self._funcBtnList[index]:AddEffect("fUI_Dialog_01A", true, 0, 0)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_NewQuest then
    if true == self._isDialogNewQuest then
      self._funcBtnList[index]:AddEffect("fUI_Dialog_01A", true, 0, 0)
    end
  elseif funcButtonType == CppEnums.ContentsType.Contents_Talk then
    self._funcBtnList[index]:AddEffect("fUI_Dialog_01E", true, 0, 0)
  end
end
function PaGlobal_DialogMain_All:funcBottomBtnClick(index, isType)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogFuncCnt = dialogData:getFuncButtonCount()
  if dialogFuncCnt <= 0 then
    return
  end
  PaGlobalFunc_DialogList_All_SetContactTalk(false)
  PaGlobalFunc_DialogMain_All_SetNpcDialogReset()
  self._ui_pc.stc_spaceBar:SetShow(false)
  local funcButtonType
  if true == isType then
    funcButtonType = index
    Dialog_clickFuncButtonByTypeReq(index)
  else
    local funcButton = dialogData:getFuncButtonAt(index)
    if nil == funcButton then
      return
    end
    funcButtonType = tonumber(funcButton._param)
    ToClient_SetFilterType(0, false)
    Dialog_clickFuncButtonReq(index)
  end
  self._selectDialogFuncIndex = index
  self:buttonFuncBranch(funcButtonType)
  self:buttonColorSetting(index)
end
function PaGlobal_DialogMain_All:buttonSpaceBarcheck(isShow)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  if true == self._isConsole then
    return
  end
  local btnText = ""
  if true == isShow then
    self._isFuncBtnSpaceShow = true
    if true == self._isDialogNewMainQuest and -1 ~= self._dialogIndex.MAINQUEST then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.MAINQUEST)
      if nil ~= funcButton then
        btnText = funcButton:getText() .. "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY") .. ")"
        self:funcBtnAtSetText(self._dialogIndex.MAINQUEST, btnText)
      end
    elseif true == self._isDialogNewQuest and -1 ~= self._dialogIndex.QUEST then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.QUEST)
      if nil ~= funcButton then
        btnText = funcButton:getText() .. "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY") .. ")"
        self:funcBtnAtSetText(self._dialogIndex.QUEST, btnText)
      end
    end
    if true == self._isDialogNewTalk and -1 ~= self._dialogIndex.TALK then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.TALK)
      if nil ~= funcButton then
        btnText = funcButton:getText() .. "(" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY") .. ")"
        self:funcBtnAtSetText(self._dialogIndex.TALK, btnText)
      end
    end
  else
    self._isFuncBtnSpaceShow = false
    if true == self._isDialogNewMainQuest and -1 ~= self._dialogIndex.MAINQUEST then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.MAINQUEST)
      if nil ~= funcButton then
        self:funcBtnAtSetText(self._dialogIndex.MAINQUEST, funcButton:getText())
      end
    end
    if true == self._isDialogNewQuest and -1 ~= self._dialogIndex.QUEST then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.QUEST)
      if nil ~= funcButton then
        self:funcBtnAtSetText(self._dialogIndex.QUEST, funcButton:getText())
      end
    end
    if true == self._isDialogNewTalk and -1 ~= self._dialogIndex.TALK then
      local funcButton = dialogData:getFuncButtonAt(self._dialogIndex.TALK)
      if nil ~= funcButton then
        self:funcBtnAtSetText(self._dialogIndex.TALK, funcButton:getText())
      end
    end
  end
end
function PaGlobal_DialogMain_All:buttonColorSetting(clickIndex)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local funcBtnCount = dialogData:getFuncButtonCount()
  for index = 0, funcBtnCount - 1 do
    self._funcBtnList[index]:SetCheck(false)
    self._funcBtnList[index]:setRenderTexture(self._funcBtnList[index]:getBaseTexture())
    self._funcBtnList[index]:SetFontColor(Defines.Color.C_FF988D83)
  end
end
function PaGlobal_DialogMain_All:buttonFuncBranch(funcButtonType)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  if CppEnums.ContentsType.Contents_Exchange == funcButtonType then
    PaGlobalFunc_DialogExchange_All_Open()
  elseif CppEnums.ContentsType.Contents_Quest == funcButtonType or CppEnums.ContentsType.Contents_NewQuest == funcButtonType or CppEnums.ContentsType.Contents_MainQuest == funcButtonType or CppEnums.ContentsType.Contents_NewMainQuest == funcButtonType or CppEnums.ContentsType.Contents_Talk == funcButtonType then
    local dialogBtnCount = dialogData:getDialogButtonCount()
    if false == self._isConsole and dialogBtnCount <= 0 then
      HandleEventLUp_DialogMain_All_BackClick()
      return
    end
    PaGlobalFunc_DialogList_All_Open()
    local talker = dialog_getTalker()
    if nil == talker and CppEnums.ContentsType.Contents_Talk ~= funcButtonType then
      dialogData:setEmptyMainDialog()
      if CppEnums.ContentsType.Contents_Quest == funcButtonType or CppEnums.ContentsType.Contents_NewQuest == funcButtonType then
        PaGlobalFunc_DialogList_All_SetFilterButtonCount()
        PaGlobalFunc_DialogList_All_SetFilterOption(PaGlobal_DialogList_All._SPLIT_IDX.RECOMMENDATION)
      elseif CppEnums.ContentsType.Contents_MainQuest == funcButtonType or CppEnums.ContentsType.Contents_NewMainQuest == funcButtonType then
        PaGlobalFunc_DialogList_All_SetMainQuest()
      end
    end
  end
end
function PaGlobal_DialogMain_All:shopTypeMessage(shopType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myWp = selfPlayer:getWp()
  local myinventory = selfPlayer:get():getInventory()
  local myinvenSize = myinventory:getFreeCount()
  local s64_allWeight = Int64toInt32(selfPlayer:get():getCurrentWeight_s64())
  local s64_maxWeight = Int64toInt32(selfPlayer:get():getPossessableWeight_s64())
  if self._shopType.eShopType_Worker == shopType then
    self._indexWorkerShopClicked = index
    local selfPosition = selfPlayer:get():getPosition()
    local regionInfo = getRegionInfoByPosition(selfPosition)
    local region = regionInfo:get()
    local regionPlantKey = regionInfo:getPlantKeyByWaypointKey()
    local waitWorkerCount = ToClient_getPlantWaitWorkerListCount(regionPlantKey, 0)
    local maxWorkerCount = ToClient_getTownWorkerMaxCapacity(regionPlantKey)
    if s64_allWeight >= s64_maxWeight then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_WEIGHTOVER_ALERTTITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_WEIGHTOVER_ALERTDESC"), nil, nil, MessageBox_Empty_function)
      return true
    end
    if 0 ~= selfPlayer:get():checkWorkerWorkingServerNo() then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ_NotSameServerNo"), nil, nil, MessageBox_Empty_function)
      return true
    end
    if waitWorkerCount == maxWorkerCount then
      local buyCash = function()
        PaGlobal_EasyBuy:Open(16, getCurrentWaypointKey())
      end
      if false == PaGlobal_DialogMain_All._isConsole and _ContentsGroup_EasyBuy then
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"), PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ") .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_WORKERHOUSE_EASYBUY"), buyCash, nil, nil)
      else
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_ReSelect"), PAGetString(Defines.StringSheet_GAME, "Lua_WorkerShop_Cant_Employ"), nil, nil, MessageBox_Empty_function)
      end
      return true
    end
    if 5 <= myWp then
      local backOpen = function()
        PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
      end
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_CONFIRM_WORKER", "MyWp", myWp), PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm, backOpen, nil)
      return true
    end
  end
  if self._shopType.eShopType_RandomShop == shopType then
    if myinvenSize <= 0 then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_SECRETSHOP_FREESLOT"), nil, nil, MessageBox_Empty_function)
      return true
    end
    if s64_allWeight >= s64_maxWeight then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_SECRETSHOP_WEIGHTOVER"), nil, nil, MessageBox_Empty_function)
      return true
    end
    local IsRamdomShopkeepItem = ToClient_IsRandomShopKeepItem()
    if IsRamdomShopkeepItem == false then
      local randomShopConsumeWp = ToClient_getRandomShopConsumWp()
      if myWp < randomShopConsumeWp then
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_LACK_WP", "randomShopConsumeWp", randomShopConsumeWp, "MyWp", myWp), nil, nil, MessageBox_Empty_function)
        return true
      elseif myWp >= randomShopConsumeWp then
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_CONFIRM_RANDOMITEM_WP", "randomShopConsumeWp", randomShopConsumeWp, "MyWp", myWp), PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm, nil, nil)
        return true
      end
    end
  end
  if self._shopType.eShopType_DayRandomShop == shopType then
    if myinvenSize <= 0 then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_SECRETSHOP_FREESLOT"), nil, nil, MessageBox_Empty_function)
      return true
    end
    if s64_allWeight >= s64_maxWeight then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_SECRETSHOP_WEIGHTOVER"), nil, nil, MessageBox_Empty_function)
      return true
    end
    local randomShopConsumeWp = 10
    if myWp < randomShopConsumeWp then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_LACK_WP", "randomShopConsumeWp", randomShopConsumeWp, "MyWp", myWp), nil, nil, MessageBox_Empty_function)
      return true
    elseif myWp >= randomShopConsumeWp then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_CONFIRM_RANDOMITEM_WP", "randomShopConsumeWp", randomShopConsumeWp, "MyWp", myWp), PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm, nil, nil)
      return true
    end
  end
  return false
end
function PaGlobal_DialogMain_All:innerPanelShow(count, targetWindowList)
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if count <= 0 then
    return
  end
  dialog_setPositionSelectList(count)
  local index = 0
  for _, v in pairs(targetWindowList) do
    dialog_setPositionSelectSizeSet(index, v:GetSizeX(), v:GetSizeY())
    index = index + 1
  end
  dialog_calcPositionSelectList()
  index = 0
  for _, v in pairs(targetWindowList) do
    if false == v:GetShow() then
      local pos = dialog_PositionSelect(index)
      if 0 ~= pos.x or 0 ~= pos.y then
        v:ComputePos()
        v:SetPosX(pos.x)
        v:SetPosY(pos.y)
        index = index + 1
      else
        break
      end
    end
  end
end
function PaGlobal_DialogMain_All:executeAfterDialogLoad(dialogData)
  if nil == dialogData then
    return
  end
  local blackSpiritUiType = getBlackSpiritUiType()
  local blackSpiritUiEnum
  if CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_None ~= blackSpiritUiType and false == self._blackSpiritUiShow and true == ToClient_IsGrowStepOpen(__eGrowStep_enchant) then
    if CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemEnchant == blackSpiritUiType then
      HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_Enchant, true)
      self._blackSpiritUiShow = true
      blackSpiritUiEnum = CppEnums.ContentsType.Contents_Enchant
    elseif CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Socket == blackSpiritUiType then
      HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_Socket, true)
      self._blackSpiritUiShow = true
      blackSpiritUiEnum = CppEnums.ContentsType.Contents_Socket
    elseif CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Improve == blackSpiritUiType then
      HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_Improve, true)
      self._blackSpiritUiShow = true
      blackSpiritUiEnum = CppEnums.ContentsType.Contents_Improve
    elseif CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_Blacksmith == blackSpiritUiType then
      if nil ~= PaGlobal_DialogMain_All then
        PaGlobal_DialogMain_All._isOpenForBlacksmith = true
      end
      HandleEventLUp_DialogMain_All_FuncButton(CppEnums.ContentsType.Contents_Enchant, true)
      self._blackSpiritUiShow = true
      blackSpiritUiEnum = CppEnums.ContentsType.Contents_Enchant
    end
  end
  if true == self._isConsole and true == self._blackSpiritUiShow then
    self:consoleOverIdxSet(blackSpiritUiEnum)
  end
end
function PaGlobal_DialogMain_All:consoleOverIdxSet(blackSpiritUiEnum)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData or nil == blackSpiritUiEnum then
    return
  end
  local funcBtnCount = dialogData:getFuncButtonCount()
  for index = 0, funcBtnCount - 1 do
    local functionBtn = dialogData:getFuncButtonAt(index)
    local funcButtonType = tonumber(functionBtn._param)
    if funcButtonType == blackSpiritUiEnum then
      self._console_overIdx = index + 1
      PaGlobalFunc_DialogMain_All_BottomFuncBtnUpdate()
      break
    end
  end
end
function PaGlobalFunc_DialogList_All_IsOpenForBlacksmith()
  return PaGlobal_DialogMain_All._isOpenForBlacksmith
end
function PaGlobalFunc_DialogList_All_ClearIsOpenForBlacksmith()
  PaGlobal_DialogMain_All._isOpenForBlacksmith = false
end
function PaGlobal_DialogMain_All:SetMsgDataAndShow(_title, _content, _funcYes, _funcNo, _funcApply, _priority)
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
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_DialogMain_All:registEventHandler()
  if nil == Panel_Npc_Dialog_All then
    return
  end
  if false == _ContentsGroup_NewUI_Dialog_All then
    return
  end
  registerEvent("FromClient_ShowDialog", "FromClient_DialogMain_All_ShowDialog")
  registerEvent("FromClient_HideDialog", "FromClient_DialogMain_All_HideDialog")
  registerEvent("FromClient_CloseNpcTalkForDead", "PaGlobalFunc_DialogMain_All_Close")
  registerEvent("FromClient_CloseNpcTradeMarketTalkForDead", "FromClient_DialogMain_All_CloseNpcTradeMarketTalkForDead")
  registerEvent("FromClient_CloseAllPanelWhenNpcGoHome", "FromClient_DialogMain_All_CloseAllPanelWhenNpcGoHome")
  registerEvent("FromClient_VaryIntimacy_Dialog", "FromClient_DialogIntimacy_All_VaryIntimacy")
  registerEvent("onScreenResize", "FromClient_DialogMain_All_onScreenResize")
  registerEvent("progressEventCancelByAttacked", "FromClient_DialogMain_All_CloseDialogByAttacked")
  registerEvent("FromClient_UpdateMainDialogText", "FromClient_UpdateMainDialogText")
  registerEvent("FromClient_DialogFunctionClick_Contents_Shop", "FromClient_DialogFunctionClick_Contents_Shop")
  registerEvent("FromClient_DialogFunctionClick_Contents_Skill", "FromClient_DialogFunctionClick_Contents_Skill")
  registerEvent("FromClient_DialogFunctionClick_Contents_Guild", "FromClient_DialogFunctionClick_Contents_Guild")
  registerEvent("FromClient_DialogFunctionClick_Contents_Enchant", "FromClient_DialogFunctionClick_Contents_Enchant")
  registerEvent("FromClient_DialogFunctionClick_Contents_Socket", "FromClient_DialogFunctionClick_Contents_Socket")
  registerEvent("FromClient_DialogFunctionClick_Contents_LordMenu", "FromClient_DialogFunctionClick_Contents_LordMenu")
  registerEvent("FromClient_DialogFunctionClick_Contents_Extract", "FromClient_DialogFunctionClick_Contents_Extract")
  registerEvent("FromClient_DialogFunctionClick_Contents_TerritoryTrade", "FromClient_DialogFunctionClick_Contents_TerritoryTrade")
  registerEvent("FromClient_DialogFunctionClick_Contents_TerritorySupply", "FromClient_DialogFunctionClick_Contents_TerritorySupply")
  registerEvent("FromClient_DialogFunctionClick_Contents_GuildShop", "FromClient_DialogFunctionClick_Contents_GuildShop")
  registerEvent("FromClient_DialogFunctionClick_Contents_SupplyShop", "FromClient_DialogFunctionClick_Contents_SupplyShop")
  registerEvent("FromClient_DialogFunctionClick_Contents_FishSupplyShop", "FromClient_DialogFunctionClick_Contents_FishSupplyShop")
  registerEvent("FromClient_DialogFunctionClick_Contents_GuildSupplyShop", "FromClient_DialogFunctionClick_Contents_GuildSupplyShop")
  registerEvent("FromClient_DialogFunctionClick_Contents_MinorLordMenu", "FromClient_DialogFunctionClick_Contents_MinorLordMenu")
  registerEvent("FromClient_DialogFunctionClick_Contents_Improve", "FromClient_DialogFunctionClick_Contents_Improve")
  registerEvent("FromClient_DialogFunctionClick_Contents_Repair", "FromClient_DialogFunctionClick_Contents_Repair")
  registerEvent("FromClient_DialogFunctionClick_Contents_Warehouse", "FromClient_DialogFunctionClick_Contents_Warehouse")
  registerEvent("FromClient_DialogFunctionClick_Contents_Stable", "FromClient_DialogFunctionClick_Contents_Stable")
  registerEvent("FromClient_DialogFunctionClick_Contents_Transfer", "FromClient_DialogFunctionClick_Contents_Transfer")
  registerEvent("FromClient_DialogFunctionClick_Contents_ItemMarket", "FromClient_DialogFunctionClick_Contents_ItemMarket")
  registerEvent("FromClient_DialogFunctionClick_Contents_NewItemMarket", "FromClient_DialogFunctionClick_Contents_NewItemMarket")
  registerEvent("FromClient_DialogFunctionClick_Contents_KnowledgeManagement", "FromClient_DialogFunctionClick_Contents_Knowledge")
  registerEvent("FromClient_DialogFunctionClick_Contents_Join", "FromClient_DialogFunctionClick_Contents_Join")
  registerEvent("FromClient_DialogFunctionClick_Contents_NpcGift", "FromClient_DialogFunctionClick_Contents_NpcGift")
  registerEvent("FromClient_DialogFunctionClick_Contents_WeakenEnchant", "FromClient_DialogFunctionClick_Contents_WeakenEnchant")
  registerEvent("FromClient_DialogFunctionClick_Contents_Employee", "FromClient_DialogFunctionClick_Contents_Employee")
  registerEvent("FromClient_DialogFunctionClick_Contents_HelpDesk", "FromClient_DialogFunctionClick_Contents_HelpDesk")
  registerEvent("FromClient_DialogFunctionClick_Contents_EdanPass", "FromClient_DialogFunctionClick_Contents_EdanPass")
  registerEvent("FromClient_DialogFunctionClick_Contents_SeasonReward", "FromClient_DialogFunctionClick_Contents_SeasonReward")
  registerEvent("EventQuestUpdateNotify", "FromClient_DialogMain_All_EventQuestUpdateNotify")
  self._ui_pc.btn_back:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_BackClick()")
  self._ui_pc.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_ExitClick()")
  self._ui_pc.btn_continue:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_ContinueClick()")
  self._ui_pc.btn_next:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogMain_All_NextClick()")
  self._ui_pc.btn_apply:addInputEvent("Mouse_LUp", "HandleEventEnter_DialogQuest_All_SelectConfirmReward()")
  self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogQuest_All_QuestRefuse()")
  if true == self._isConsole then
    registerEvent("FromClient_PadSnapChangePanel", "FromClient_DialogMain_All_PadSnapChangePanel")
    Panel_Npc_Dialog_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandlePadLBRB_DialogMain_All_MoveOverIdx(-1)")
    Panel_Npc_Dialog_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandlePadLBRB_DialogMain_All_MoveOverIdx(1)")
    Panel_Npc_Dialog_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadUpA_DialogMain_All_SelectOverIdx()", 0.5)
    Panel_Npc_Dialog_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEventUp_DialogInterestKnowledge_All_MoveScroll(1)")
    Panel_Npc_Dialog_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEventUp_DialogInterestKnowledge_All_MoveScroll(-1)")
  else
    self._ui_pc.btn_blackSpiritSkillSelect:addInputEvent("Mouse_LUp", "PaGloabl_BlackSpiritSkillSelect_Open()")
    self._ui_pc.btn_blackSpiritSkillSelect:addInputEvent("Mouse_On", "PaGlobalFunc_DialogMain_All_BlackSpiritSkillSelectTooltip()")
    self._ui_pc.btn_blackSpiritSkillSelect:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
  self._renderMode:setPrefunctor(nil, PaGlobalFunc_DialogMain_All_renderSetPrefunctor)
  self._renderMode:setClosefunctor(nil, PaGlobalFunc_DialogMain_All_renderSetClosefunctor)
end
function PaGlobal_DialogMain_All:setTranslationKey(localizedType, LocalizedKey)
  if nil == LocalizedKey then
    return
  end
  self._ui.txt_contentDesc:setLocalizedStaticType(localizedType)
  self._ui.txt_contentDesc:setLocalizedKey(LocalizedKey)
end
