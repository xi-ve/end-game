function PaGlobal_DialogList_All:initialize()
  if true == PaGlobal_DialogList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  PaGlobal_DialogList_All:registEventHandler()
  PaGlobal_DialogList_All:validate()
  PaGlobal_DialogList_All._initialize = true
end
function PaGlobal_DialogList_All:controlAll_Init()
  if nil == Panel_Dialog_List_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Dialog_List_All, "Static_Title")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_Title")
  self._ui.stc_titleDeco = UI.getChildControl(self._ui.stc_titleBg, "Static_TitleDeco")
  self._ui.stc_splitTabBg = UI.getChildControl(Panel_Dialog_List_All, "Static_BlackSpiritSplit")
  for index = 0, 3 do
    self._ui.btn_splitRadiolist[index] = UI.getChildControl(self._ui.stc_splitTabBg, "RadioButton_" .. index + 1)
    self._btnSplitString[index] = self._ui.btn_splitRadiolist[index]:GetText()
  end
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_splitTabBg, "Static_SelectBar")
  self._ui.list2_button = UI.getChildControl(Panel_Dialog_List_All, "List2_Dialog_ButtonList")
  self._ui.list2_content = UI.getChildControl(self._ui.list2_button, "List2_1_Content")
  self._ui.stc_subBg = UI.getChildControl(Panel_Dialog_List_All, "Static_SubBG")
  self._listShowMaxCount = math.floor(self._ui.list2_button:GetSizeY() / self._ui.list2_content:GetSizeY())
  self._panelOriginSizeY = Panel_Dialog_List_All:GetSizeY()
  self._listOriginSizeY = self._ui.list2_button:GetSizeY()
end
function PaGlobal_DialogList_All:controlPc_Init()
  if nil == Panel_Dialog_List_All then
    return
  end
  self._ui_pc.stc_listKeyGuideBg = UI.getChildControl(Panel_Dialog_List_All, "Static_BottomButton_PCUI")
  self._ui_pc.txt_listKeyGuide = UI.getChildControl(self._ui_pc.stc_listKeyGuideBg, "StaticText_listMoveGuide")
end
function PaGlobal_DialogList_All:controlConsole_Init()
  if nil == Panel_Dialog_List_All then
    return
  end
  self._ui_console.stc_bottomBg = UI.getChildControl(Panel_Dialog_List_All, "Static_BottomButton_ConsoleUI")
  self._ui_console.stc_iconA = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_KeyGuideSelect_ConsoleUI")
  self._ui_console.stc_iconB = UI.getChildControl(self._ui_console.stc_bottomBg, "StaticText_KeyGuideCancel_ConsoleUI")
  self._ui_console.stc_iconLB = UI.getChildControl(self._ui.stc_splitTabBg, "Static_IconLB_ConsoleUI")
  self._ui_console.stc_iconRB = UI.getChildControl(self._ui.stc_splitTabBg, "Static_IconRB_ConsoleUI")
end
function PaGlobal_DialogList_All:controlSetShow()
  if nil == Panel_Dialog_List_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.stc_listKeyGuideBg:SetShow(false)
    self._ui_console.stc_bottomBg:SetShow(true)
    self._ui_console.stc_iconLB:SetShow(true)
    self._ui_console.stc_iconRB:SetShow(true)
  else
    self._ui_pc.txt_listKeyGuide:SetShow(true)
    self._ui_console.stc_bottomBg:SetShow(false)
    self._ui_console.stc_iconLB:SetShow(false)
    self._ui_console.stc_iconRB:SetShow(false)
  end
end
function PaGlobal_DialogList_All:prepareOpen()
  if nil == Panel_Dialog_List_All then
    return
  end
  if false == self._isConsole then
    PaGlobalFunc_DialogKeyManager_All_SetConfirmFunc(HandleEventLUp_DialogList_All_ButtonClick)
    PaGlobalFunc_DialogKeyManager_All_SetTarget(Panel_Dialog_List_All, PaGlobal_DialogList_All._ui.list2_button, "RadioButton_Dialog", "StaticText_Spacebar")
    PaGlobalFunc_DialogKeyManager_All_SetClear(false, true, true, true)
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_DialogMain_All:buttonSpaceBarcheck(false)
  PaGlobal_DialogList_All:update()
  PaGlobal_DialogList_All:resize()
  PaGlobal_DialogList_All:open()
end
function PaGlobal_DialogList_All:open()
  if nil == Panel_Dialog_List_All then
    return
  end
  Panel_Dialog_List_All:SetShow(true, true)
end
function PaGlobal_DialogList_All:prepareClose(showAni)
  if nil == Panel_Dialog_List_All then
    return
  end
  if false == Panel_Dialog_List_All:GetShow() then
    return
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self._ui.list2_button:moveTopIndex()
  self._isQuestComplete = false
  PaGlobalFunc_DialogKeyManager_All_SetClear(false, true, true, true)
  PaGlobal_DialogMain_All:buttonSpaceBarcheck(true)
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  TooltipSimple_Hide()
  PaGlobal_DialogList_All:close(showAni)
end
function PaGlobal_DialogList_All:close(showAni)
  if nil == Panel_Dialog_List_All then
    return
  end
  if false == showAni then
    Panel_Dialog_List_All:SetShow(false)
  else
    Panel_Dialog_List_All:SetShow(false, true)
  end
end
function PaGlobal_DialogList_All:update()
  if nil == Panel_Dialog_List_All then
    return
  end
  PaGlobal_DialogList_All:updateDialog()
end
function PaGlobal_DialogList_All:validate()
  if nil == Panel_Dialog_List_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_titleDeco:isValidate()
  self._ui.stc_splitTabBg:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.list2_button:isValidate()
  self._ui.list2_content:isValidate()
  self._ui.stc_subBg:isValidate()
  self._ui_pc.stc_listKeyGuideBg:isValidate()
  self._ui_pc.txt_listKeyGuide:isValidate()
  self._ui_console.stc_bottomBg:isValidate()
  self._ui_console.stc_iconA:isValidate()
  self._ui_console.stc_iconB:isValidate()
  self._ui_console.stc_iconLB:isValidate()
  self._ui_console.stc_iconRB:isValidate()
end
function PaGlobal_DialogList_All:registEventHandler()
  if nil == Panel_Dialog_List_All then
    return
  end
  Panel_Dialog_List_All:RegisterShowEventFunc(true, "PaGlobalFunc_DialogList_All_ShowAni()")
  Panel_Dialog_List_All:RegisterShowEventFunc(false, "PaGlobalFunc_DialogList_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_DialogList_All_OnScreenResize")
  for index = 0, 3 do
    self._ui.btn_splitRadiolist[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_SelectTab(" .. index .. ")")
  end
  self._ui.list2_button:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == self._isConsole then
    Panel_Dialog_List_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventKeyBoard_DialogList_All_MoveTab(-1)")
    Panel_Dialog_List_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventKeyBoard_DialogList_All_MoveTab(1)")
  end
end
function PaGlobal_DialogList_All:resize()
  if nil == Panel_Dialog_List_All then
    return
  end
  local uiOffsetX = 0
  if true == self._isConsole then
    uiOffsetX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  end
  Panel_Dialog_List_All:SetPosX(getScreenSizeX() - Panel_Dialog_List_All:GetSizeX() - 20 + uiOffsetX)
  Panel_Dialog_List_All:SetPosY(math.max(0, (getScreenSizeY() - Panel_Npc_Dialog_All:GetSizeY()) / 2 - Panel_Dialog_List_All:GetSizeY() / 2))
  local guideIconGroup = {
    self._ui_console.stc_iconA,
    self._ui_console.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui_pc.stc_listKeyGuideBg:ComputePos()
  self._ui_console.stc_bottomBg:ComputePos()
  self:listKeyGuideSetShow(false)
end
function PaGlobal_DialogList_All:listKeyGuideSetShow(isBlackSpirit)
  if false == isBlackSpirit then
    self._ui_pc.txt_listKeyGuide:SetText(self._listKeyGuideString[0])
  else
    self._ui_pc.txt_listKeyGuide:SetText(self._listKeyGuideString[1])
  end
  self._ui_pc.stc_listKeyGuideBg:SetSize(self._ui_pc.txt_listKeyGuide:GetTextSizeX() + 50, self._ui_pc.stc_listKeyGuideBg:GetSizeY())
  self._ui_pc.stc_listKeyGuideBg:ComputePos()
  self._ui_pc.txt_listKeyGuide:ComputePos()
end
function PaGlobal_DialogList_All:updateDialog(isPropose)
  if nil == Panel_Dialog_List_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  local mainDialog = dialogData:getMainDialog()
  if nil == mainDialog or "" == mainDialog then
    ToClient_PopDialogueFlush()
    return
  end
  local dialogState = tostring(dialogData:getDialogState())
  local talker = dialog_getTalker()
  if nil == talker and dialogState == CppEnums.DialogState.eDialogState_QuestList then
    ToClient_SetFilterType(self._SPLIT_IDX.ALL, true)
  end
  self:changeFilterRadio(false)
  if false == self._isConsole then
    Auto_NotifyChangeDialog()
  end
  self:updateDialogList(dialogData)
end
function PaGlobal_DialogList_All:updateDialogList(dialogData)
  if nil == Panel_Dialog_List_All then
    return
  end
  if nil == dialogData then
    return
  end
  PaGlobalFunc_DialogKeyManager_All_SetClear(false, true, true, true)
  self._dialogListCount = dialogData:getDialogButtonCount()
  local dialogState = tostring(dialogData:getDialogState())
  if dialogState == CppEnums.DialogState.eDialogState_Talk then
    self._ui.list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DialogList_All_UdpateTalkButtonlist")
    self:updateDialogListTitleSet(CppEnums.DialogState.eDialogState_Talk)
  elseif dialogState == CppEnums.DialogState.eDialogState_Exchange then
    PaGlobalFunc_DialogList_All_Close()
    PaGlobalFunc_DialogExchange_All_Open()
    return
  elseif dialogState == CppEnums.DialogState.eDialogState_QuestList then
    self._ui.list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DialogList_All_UdpateQuestButtonlist")
    self:updateDialogListTitleSet(CppEnums.DialogState.eDialogState_QuestList)
  elseif dialogState == CppEnums.DialogState.eDialogState_MainQuestList then
    self._ui.list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DialogList_All_UdpateQuestButtonlist")
    self:updateDialogListTitleSet(CppEnums.DialogState.eDialogState_MainQuestList)
  elseif dialogState == CppEnums.DialogState.eDialogState_Help then
    self._ui.list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DialogList_All_UdpateHelpButtonlist")
    self:updateDialogListTitleSet(CppEnums.DialogState.eDialogState_Help)
  else
    return
  end
  self._ui.list2_button:getElementManager():clearKey()
  for index = 1, self._dialogListCount do
    self._ui.list2_button:getElementManager():pushKey(toInt64(0, index))
    if false == self._isConsole then
      local dialogButton = dialogData:getDialogButtonAt(index - 1)
      if true == dialogButton._enable then
        PaGlobalFunc_DialogKeyManager_All_EnableListPush(index - 1)
      end
    end
  end
end
function PaGlobal_DialogList_All:updateDialogListTitleSet(dialogStateType)
  if nil == dialogStateType then
    return
  end
  if nil == Panel_Dialog_List_All then
    return
  end
  self._ui.stc_title:SetText(self._dialogTitleType[dialogStateType].name)
  self._ui.stc_title:ChangeTextureInfoName(self._dialogTitleType[dialogStateType].texture)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_title, self._dialogTitleType[dialogStateType].x1, self._dialogTitleType[dialogStateType].y1, self._dialogTitleType[dialogStateType].x2, self._dialogTitleType[dialogStateType].y2)
  self._ui.stc_title:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_title:setRenderTexture(self._ui.stc_title:getBaseTexture())
  if CppEnums.DialogState.eDialogState_MainQuestList == dialogStateType then
    self._ui.stc_title:SetSize(30, 30)
    self._ui.stc_title:SetPosX(10)
    self._ui.stc_title:SetPosY(10)
    self._ui.stc_title:SetTextSpan(50, 0)
  else
    self._ui.stc_title:SetSize(50, 50)
    self._ui.stc_title:SetPosX(0)
    self._ui.stc_title:SetPosY(0)
    self._ui.stc_title:SetTextSpan(60, 0)
  end
end
function PaGlobal_DialogList_All:dialogTalkControlSet(control, key)
  if nil == key then
    _PA_ASSERT_NAME(false, "PaGlobal_DialogList_All:dialogTalkControlSet key\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local index = Int64toInt32(key) - 1
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogButton = dialogData:getDialogButtonAt(index)
  local dialogText = dialogButton:getText()
  local displayData = Dialog_getButtonDisplayData(index)
  local btn_Dialog = UI.getChildControl(control, "RadioButton_Dialog")
  local stc_typeIcon = UI.getChildControl(btn_Dialog, "Static_TypeIcon")
  local stc_shapeIcon = UI.getChildControl(btn_Dialog, "Static_ShapeIcon")
  local txt_dialog = UI.getChildControl(control, "StaticText_Dialog_Name")
  local txt_needs = UI.getChildControl(control, "StaticText_Dialog_Needs")
  local stc_needItem = UI.getChildControl(control, "Static_NeedItemIcon")
  local txt_needItemText = UI.getChildControl(control, "Static_NeedItemText")
  local stc_needEnergy = UI.getChildControl(control, "Static_NeedEnergyIcon")
  local stc_spacebarIcon = UI.getChildControl(control, "StaticText_Spacebar")
  stc_typeIcon:SetShow(false)
  txt_needs:SetShow(false)
  stc_needItem:SetShow(false)
  txt_needItemText:SetShow(false)
  stc_needEnergy:SetShow(false)
  btn_Dialog:SetEnable(true)
  stc_typeIcon:SetMonoTone(false)
  stc_spacebarIcon:SetShow(false)
  btn_Dialog:SetCheck(false)
  btn_Dialog:setNotImpactScrollEvent(true)
  txt_dialog:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needs:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needItem:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needItemText:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needEnergy:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_dialog:SetText(dialogText)
  UI.setLimitAutoWrapTextAndAddTooltip(txt_dialog, 2, "", txt_dialog:GetText())
  stc_spacebarIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY"))
  if true == dialogButton._enable then
    btn_Dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    txt_dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    btn_Dialog:SetMonoTone(false)
    stc_shapeIcon:SetMonoTone(false)
    stc_typeIcon:SetMonoTone(false)
    txt_dialog:SetMonoTone(false)
    txt_needs:SetMonoTone(false)
    stc_needItem:SetMonoTone(false)
    txt_needItemText:SetMonoTone(false)
    stc_needEnergy:SetMonoTone(false)
    PaGlobalFunc_DialogKeyManager_All_EnableKeyShow()
  else
    btn_Dialog:addInputEvent("Mouse_LUp", "")
    txt_dialog:addInputEvent("Mouse_LUp", "")
    btn_Dialog:SetMonoTone(true, true)
    stc_shapeIcon:SetMonoTone(true, true)
    stc_typeIcon:SetMonoTone(true, true)
    txt_dialog:SetMonoTone(true, true)
    txt_needs:SetMonoTone(true, true)
    stc_needItem:SetMonoTone(true, true)
    txt_needItemText:SetMonoTone(true, true)
    stc_needEnergy:SetMonoTone(true, true)
  end
  local function setChangeDialogIcon(iconType)
    stc_typeIcon:SetShow(true)
    stc_typeIcon:ChangeTextureInfoName(self._dialogButtonIcon[iconType].texture)
    local x1, y1, x2, y2 = setTextureUV_Func(stc_typeIcon, self._dialogButtonIcon[iconType].x1, self._dialogButtonIcon[iconType].y1, self._dialogButtonIcon[iconType].x2, self._dialogButtonIcon[iconType].y2)
    stc_typeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_typeIcon:setRenderTexture(stc_typeIcon:getBaseTexture())
  end
  if 0 < dialogButton._dialogButtonType and dialogButton._dialogButtonType < CppEnums.DialogButtonType.eDialogButton_Count then
    setChangeDialogIcon(dialogButton._dialogButtonType)
  elseif true == dialogButton:isBuyItemByPoint() then
    setChangeDialogIcon(dialogButton._dialogButtonType)
  else
    stc_typeIcon:SetShow(false)
  end
  if true == stc_typeIcon:GetShow() then
    stc_shapeIcon:SetShow(false)
  else
    stc_shapeIcon:SetShow(true)
  end
  if true == displayData:empty() then
    local linkType = dialogButton._linkType
    local Wp = 0
    local playerLevel = 0
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      Wp = selfPlayer:getWp()
      playerLevel = selfPlayer:get():getLevel()
    end
    local needWp = dialogButton:getNeedWp()
    local isNeedThings = false
    local isNeedWp = false
    local isNeedItem = false
    local needItemCount = 0
    local itemStaticWrapper, needItemKey
    if CppEnums.DialogState.eDialogState_Talk == tostring(linkType) and 0 < needWp then
      isNeedThings = true
      isNeedWp = true
      if 0 < dialogButton:getNeedItemCount() then
        needItemKey = dialogButton:getNeedItemKey()
        itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
        if itemStaticWrapper ~= nil then
          isNeedItem = true
          needItemCount = dialogButton:getNeedItemCount()
        end
      end
    elseif 0 < dialogButton:getNeedItemCount() then
      needItemKey = dialogButton:getNeedItemKey()
      itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
      if nil ~= itemStaticWrapper then
        isNeedThings = true
        isNeedItem = true
        needItemCount = dialogButton:getNeedItemCount()
      end
    end
    if true == isNeedThings and true == isNeedItem then
      txt_needItemText:SetShow(true)
      txt_needItemText:SetText("x" .. needItemCount)
      local spanSizeX = stc_needItem:GetSizeX() + txt_needItemText:GetTextSizeX() + stc_spacebarIcon:GetTextSizeX() + 10
      stc_needItem:SetSpanSize(spanSizeX, 3)
      txt_needItemText:SetPosX(stc_needItem:GetPosX() + stc_needItem:GetSizeX() + 5)
      self:setNeedItem(stc_needItem, itemStaticWrapper, needItemKey, index)
    end
    if CppEnums.DialogState.eDialogState_Talk == tostring(linkType) and 0 < needWp then
      self:setNeedEnergy(stc_needEnergy, needWp, Wp, isNeedItem, stc_needItem, stc_spacebarIcon)
    end
  end
end
function PaGlobal_DialogList_All:dialogQuestControlSet(control, key)
  if nil == key then
    _PA_ASSERT_NAME(false, "PaGlobal_DialogList_All:dialogQuestControlSet key\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local index = Int64toInt32(key) - 1
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogButton = dialogData:getDialogButtonAt(index)
  local dialogText = dialogButton:getText()
  local displayData = Dialog_getButtonDisplayData(index)
  local btn_Dialog = UI.getChildControl(control, "RadioButton_Dialog")
  local stc_typeIcon = UI.getChildControl(btn_Dialog, "Static_TypeIcon")
  local stc_shapeIcon = UI.getChildControl(btn_Dialog, "Static_ShapeIcon")
  local txt_dialog = UI.getChildControl(control, "StaticText_Dialog_Name")
  local txt_needs = UI.getChildControl(control, "StaticText_Dialog_Needs")
  local stc_needItem = UI.getChildControl(control, "Static_NeedItemIcon")
  local txt_needItemText = UI.getChildControl(control, "Static_NeedItemText")
  local stc_needEnergy = UI.getChildControl(control, "Static_NeedEnergyIcon")
  local stc_spacebarIcon = UI.getChildControl(control, "StaticText_Spacebar")
  stc_typeIcon:SetShow(false)
  txt_needs:SetShow(false)
  stc_needItem:SetShow(false)
  txt_needItemText:SetShow(false)
  stc_needEnergy:SetShow(false)
  btn_Dialog:SetEnable(true)
  stc_typeIcon:SetMonoTone(false)
  stc_spacebarIcon:SetShow(false)
  btn_Dialog:SetCheck(false)
  btn_Dialog:setNotImpactScrollEvent(true)
  txt_dialog:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needs:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needItem:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needItemText:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needEnergy:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_dialog:SetText(dialogText)
  UI.setLimitAutoWrapTextAndAddTooltip(txt_dialog, 2, "", txt_dialog:GetText())
  stc_spacebarIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_INTERACTION_KEY"))
  if true == dialogButton._enable then
    btn_Dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    txt_dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    btn_Dialog:SetMonoTone(false)
    stc_shapeIcon:SetMonoTone(false)
    stc_typeIcon:SetMonoTone(false)
    txt_dialog:SetMonoTone(false)
    txt_needs:SetMonoTone(false)
    stc_needItem:SetMonoTone(false)
    txt_needItemText:SetMonoTone(false)
    stc_needEnergy:SetMonoTone(false)
    PaGlobalFunc_DialogKeyManager_All_EnableKeyShow()
  else
    btn_Dialog:addInputEvent("Mouse_LUp", "")
    txt_dialog:addInputEvent("Mouse_LUp", "")
    btn_Dialog:SetMonoTone(true, true)
    stc_shapeIcon:SetMonoTone(true, true)
    stc_typeIcon:SetMonoTone(true, true)
    txt_dialog:SetMonoTone(true, true)
    txt_needs:SetMonoTone(true, true)
    stc_needItem:SetMonoTone(true, true)
    txt_needItemText:SetMonoTone(true, true)
    stc_needEnergy:SetMonoTone(true, true)
  end
  local function setChangeQuestIcon(iconType)
    stc_typeIcon:SetShow(true)
    stc_typeIcon:ChangeTextureInfoName(self._dialogQuestButtonIcon[iconType].texture)
    local x1, y1, x2, y2 = setTextureUV_Func(stc_typeIcon, self._dialogQuestButtonIcon[iconType].x1, self._dialogQuestButtonIcon[iconType].y1, self._dialogQuestButtonIcon[iconType].x2, self._dialogQuestButtonIcon[iconType].y2)
    stc_typeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_typeIcon:setRenderTexture(stc_typeIcon:getBaseTexture())
  end
  if CppEnums.DialogState.eDialogState_QuestList == tostring(dialogButton._linkType) or CppEnums.DialogState.eDialogState_DisplayQuest == tostring(dialogButton._linkType) or CppEnums.DialogState.eDialogState_ProgressQuest == tostring(dialogButton._linkType) then
    if 0 <= dialogButton._dialogButtonType and dialogButton._dialogButtonType < CppEnums.DialogQuestButtonType.eDialogButton_QuestCount then
      setChangeQuestIcon(dialogButton._dialogButtonType)
    else
      stc_typeIcon:SetShow(false)
    end
  else
    stc_typeIcon:SetShow(false)
  end
  if true == stc_typeIcon:GetShow() then
    stc_shapeIcon:SetShow(false)
  else
    stc_shapeIcon:SetShow(true)
  end
  if true == displayData:empty() then
    local linkType = dialogButton._linkType
    local Wp = 0
    local playerLevel = 0
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      Wp = selfPlayer:getWp()
      playerLevel = selfPlayer:get():getLevel()
    end
    if CppEnums.DialogState.eDialogState_QuestComplete == tostring(linkType) then
      self._isQuestComplete = true
    else
      self._isQuestComplete = false
    end
    local needWp = dialogButton:getNeedWp()
    local isNeedThings = false
    local isNeedWp = false
    local isNeedItem = false
    local needItemCount = 0
    local itemStaticWrapper, needItemKey
    if CppEnums.DialogState.eDialogState_Talk == tostring(linkType) and 0 < needWp then
      isNeedThings = true
      isNeedWp = true
      if 0 < dialogButton:getNeedItemCount() then
        needItemKey = dialogButton:getNeedItemKey()
        itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
        if itemStaticWrapper ~= nil then
          isNeedItem = true
          needItemCount = dialogButton:getNeedItemCount()
        end
      end
    elseif 0 < dialogButton:getNeedItemCount() then
      needItemKey = dialogButton:getNeedItemKey()
      itemStaticWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
      if nil ~= itemStaticWrapper then
        isNeedThings = true
        isNeedItem = true
        needItemCount = dialogButton:getNeedItemCount()
      end
    end
    if true == isNeedThings then
      if true == isNeedItem then
        txt_needItemText:SetShow(true)
        txt_needItemText:SetText("x" .. needItemCount)
        local spanSizeX = stc_needItem:GetSizeX() + txt_needItemText:GetTextSizeX() + stc_spacebarIcon:GetTextSizeX() + 10
        stc_needItem:SetSpanSize(spanSizeX, 3)
        txt_needItemText:SetPosX(stc_needItem:GetPosX() + stc_needItem:GetSizeX() + 5)
        self:setNeedItem(stc_needItem, itemStaticWrapper, needItemKey, index)
      end
      if true == isNeedWp then
        self:setNeedEnergy(stc_needEnergy, needWp, Wp, isNeedItem, stc_needItem, stc_spacebarIcon)
      end
    end
  end
end
function PaGlobal_DialogList_All:dialogHelpControlSet(control, key)
  if nil == key then
    _PA_ASSERT_NAME(false, "PaGlobal_DialogList_All:dialogTalkControlSet key\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local index = Int64toInt32(key) - 1
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogButton = dialogData:getDialogButtonAt(index)
  local dialogText = dialogButton:getText()
  local displayData = Dialog_getButtonDisplayData(index)
  local btn_Dialog = UI.getChildControl(control, "RadioButton_Dialog")
  local stc_typeIcon = UI.getChildControl(btn_Dialog, "Static_TypeIcon")
  local stc_shapeIcon = UI.getChildControl(btn_Dialog, "Static_ShapeIcon")
  local txt_dialog = UI.getChildControl(control, "StaticText_Dialog_Name")
  local txt_needs = UI.getChildControl(control, "StaticText_Dialog_Needs")
  local stc_needItem = UI.getChildControl(control, "Static_NeedItemIcon")
  local txt_needItemText = UI.getChildControl(control, "Static_NeedItemText")
  local stc_needEnergy = UI.getChildControl(control, "Static_NeedEnergyIcon")
  local stc_spacebarIcon = UI.getChildControl(control, "StaticText_Spacebar")
  if true == dialogButton._enable then
    btn_Dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    txt_dialog:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogList_All_ButtonClick(" .. index .. ")")
    btn_Dialog:SetMonoTone(false)
    stc_shapeIcon:SetMonoTone(false)
    stc_typeIcon:SetMonoTone(false)
    txt_dialog:SetMonoTone(false)
    txt_needs:SetMonoTone(false)
    stc_needItem:SetMonoTone(false)
    txt_needItemText:SetMonoTone(false)
    stc_needEnergy:SetMonoTone(false)
    PaGlobalFunc_DialogKeyManager_All_EnableKeyShow()
  else
    btn_Dialog:addInputEvent("Mouse_LUp", "")
    txt_dialog:addInputEvent("Mouse_LUp", "")
    btn_Dialog:SetMonoTone(true, true)
    stc_shapeIcon:SetMonoTone(true, true)
    stc_typeIcon:SetMonoTone(true, true)
    txt_dialog:SetMonoTone(true, true)
    txt_needs:SetMonoTone(true, true)
    stc_needItem:SetMonoTone(true, true)
    txt_needItemText:SetMonoTone(true, true)
    stc_needEnergy:SetMonoTone(true, true)
  end
  stc_typeIcon:SetShow(false)
  txt_needs:SetShow(false)
  stc_needItem:SetShow(false)
  txt_needItemText:SetShow(false)
  stc_needEnergy:SetShow(false)
  stc_shapeIcon:SetShow(true)
  stc_spacebarIcon:SetShow(false)
  btn_Dialog:SetCheck(false)
  btn_Dialog:setNotImpactScrollEvent(true)
  txt_dialog:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needs:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needItem:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_needItemText:SetFontColor(Defines.Color.C_FFDDC39E)
  stc_needEnergy:SetFontColor(Defines.Color.C_FFDDC39E)
  txt_dialog:SetText(dialogText)
  UI.setLimitAutoWrapTextAndAddTooltip(txt_dialog, 2, "", txt_dialog:GetText())
end
function PaGlobal_DialogList_All:setNeedItem(control, ItemSW, needItemKey, index)
  control:SetShow(true)
  control:SetIgnore(false)
  control:SetText("")
  control:ChangeTextureInfoName("Icon/" .. ItemSW:getIconPath())
  control:setRenderTexture(control:getBaseTexture())
  if false == self._isConsole then
    control:addInputEvent("Mouse_On", "HandleEventOnOut_DialogList_All_NeedItemTooltip(true," .. needItemKey .. "," .. index .. ")")
    control:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogList_All_NeedItemTooltip(false," .. needItemKey .. "," .. index .. ")")
  end
end
function PaGlobal_DialogList_All:setNeedEnergy(control, needWp, Wp, isNeedItem, needItem, spacebarIcon)
  control:SetShow(true)
  control:SetText(needWp .. "/" .. Wp)
  if true == isNeedItem then
    control:SetPosX(needItem:GetPosX() - control:GetSizeX() - control:GetTextSizeX() - 20)
  else
    local spanSizeX = control:GetSizeX() + control:GetTextSizeX() + spacebarIcon:GetTextSizeX() + 10
    control:SetSpanSize(spanSizeX, 3)
  end
end
function PaGlobal_DialogList_All:changeFilterRadio(isSetFilter)
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  self._dialogListCount = dialogData:getDialogButtonCount()
  local splitBgSizeY = 0
  if true == isSetFilter then
    self._ui.stc_splitTabBg:SetShow(true)
    splitBgSizeY = self._ui.stc_splitTabBg:GetSizeY()
  else
    self._ui.stc_splitTabBg:SetShow(false)
    splitBgSizeY = 0
  end
  if self._dialogListCount <= self._listShowMaxCount then
    self._listContentSizeY = self._ui.list2_content:GetSizeY()
    local minusSizeY = self._listContentSizeY * (self._listShowMaxCount - self._dialogListCount)
    self._ui.list2_button:SetSize(self._ui.list2_button:GetSizeX(), self._listOriginSizeY - minusSizeY)
  else
    self._ui.list2_button:SetSize(self._ui.list2_button:GetSizeX(), self._listOriginSizeY)
  end
  Panel_Dialog_List_All:SetSize(Panel_Dialog_List_All:GetSizeX(), splitBgSizeY + self._ui.stc_titleBg:GetSizeY() + self._ui.list2_button:GetSizeY())
  self._ui.stc_subBg:SetSize(self._ui.stc_subBg:GetSizeX(), self._ui.list2_button:GetSizeY())
  self._ui.list2_button:ComputePos()
  self._ui.stc_subBg:ComputePos()
  self._ui_pc.stc_listKeyGuideBg:ComputePos()
  self._ui_console.stc_bottomBg:ComputePos()
  self:listKeyGuideSetShow(true)
end
function PaGlobal_DialogList_All:clickList(index)
  if nil == Panel_Dialog_List_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  local dlgBtnCnt = dialogData:getDialogButtonCount()
  local function clickDialogButtonReq()
    local displayData = Dialog_getButtonDisplayData(index)
    local questInfo = questList_isClearQuest(1038, 2)
    if displayData:empty() then
      Dialog_clickDialogButtonReq(index)
    else
      PaGlobal_Dialogue_Itemtake_All_SelectedIndex(index)
      PaGlobal_Dialogue_Itemtake_All_Open(displayData)
      PaGlobalFunc_DialogList_All_Close(true)
    end
  end
  local dialogButton = dialogData:getDialogButtonAt(index)
  if false == dialogButton._enable and false == dialogButton:isBuyItemByPoint() then
    return
  end
  local dialogState = tostring(dialogData:getDialogState())
  if dialogState == CppEnums.DialogState.eDialogState_Talk then
    self._isContactTalk = true
  end
  if false == dialogButton:isExchange() then
    if CppEnums.DialogButtonType.eDialogButton_CutScene == dialogButton._dialogButtonType and CppEnums.DialogState.eDialogState_Talk == tostring(dialogButton._linkType) then
      FGlobal_SetIsCutScenePlay(true)
    end
    if true == PaGlobal_DialogList_All:expirationItemCheck(dialogButton:getNeedItemKey()) then
      local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
      local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_EXPIRATIONCHECK")
      local messageboxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = clickDialogButtonReq,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif true == ToClient_isAnyLockedItem(ItemEnchantKey(dialogButton:getNeedItemKey())) then
      local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
      local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_ITEMLOCKED")
      local messageboxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = clickDialogButtonReq,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif true == PaGlobal_DialogList_All:sealedItemCheck(dialogButton:getNeedItemKey()) then
      local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_TITLE")
      local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_ITEMEXCHANGE_SEALEDCHECK")
      local messageboxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = clickDialogButtonReq,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if _ContentsGroup_RenewUI then
        MessageBox.showMessageBox(messageboxData)
      else
        MessageBox.showMessageBox(messageboxData, nil, nil, false)
      end
    else
      clickDialogButtonReq()
    end
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    PaGlobalFunc_DialogMain_All_Close()
  end
end
function PaGlobal_DialogList_All:expirationItemCheck(index)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenSize = getSelfPlayer():get():getInventorySlotCount(true)
  for i = 1, invenSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return false
        end
        local _itemKey = itemSSW:get()._key:get()
        if itemKey == _itemKey then
          local itemExpiration = itemWrapper:getExpirationDate()
          if nil ~= itemExpiration and false == itemExpiration:isIndefinite() then
            local remainTime = Int64toInt32(getLeftSecond_s64(itemExpiration))
            if remainTime <= 0 then
              return true
            else
              return false
            end
          end
        end
      end
    end
  end
  return false
end
function PaGlobal_DialogList_All:enchangeItemHaveCount(itemKey)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local itemCount = 0
  local inventory = selfProxy:getInventory()
  local invenUseSize = getSelfPlayer():get():getInventorySlotCount(true)
  local useStartSlot = inventorySlotNoUserStart()
  local invenSize = invenUseSize - useStartSlot
  for i = 1, invenSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper and itemKey == itemWrapper:get():getKey():getItemKey() then
        itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
        return itemCount
      end
    end
  end
  return itemCount
end
function PaGlobal_DialogList_All:sealedItemCheck(itemKey)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenSize = getSelfPlayer():get():getInventorySlotCount(true)
  for i = 1, invenSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return false
        end
        local _itemKey = itemSSW:get()._key:get()
        if itemKey == _itemKey then
          if true == itemWrapper:isSealed() then
            return true
          else
            return false
          end
        end
      end
    end
  end
  return false
end
