function PaGlobal_ServantFunction_All:initialize()
  if nil == Panel_Dialog_ServantFunction_All or true == self.initialize then
    return
  end
  self._ui._rdo_FunctionList = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_Function_List")
  self._ui._rdo_LinkCarridge = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_LinkCarridge")
  self._ui._rdo_Exchange = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_Exchange")
  self._ui._rdo_MatingMarket = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_MatingMarket")
  self._ui._rdo_HorseMarket = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_HorseMarket")
  self._ui._rdo_RentalMarket = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_RentalMarket")
  self._ui._rdo_Exit = UI.getChildControl(Panel_Dialog_ServantFunction_All, "RadioButton_Exit")
  self._ui._stc_KeyGuide_LB = UI.getChildControl(Panel_Dialog_ServantFunction_All, "Button_LB_ConsoleUI")
  self._ui._stc_KeyGuide_RB = UI.getChildControl(Panel_Dialog_ServantFunction_All, "Button_RB_ConsoleUI")
  self._ui._stc_TabButtonBar = UI.getChildControl(Panel_Dialog_ServantFunction_All, "Static_SelectBar")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_TabButtonBar, "Button_A_ConsoleUI")
  self._tabButtonForCategory[0] = self._ui._rdo_FunctionList
  self._tabButtonForCategory[1] = self._ui._rdo_LinkCarridge
  self._tabButtonForCategory[2] = self._ui._rdo_Exchange
  self._tabButtonForCategory[3] = self._ui._rdo_MatingMarket
  self._tabButtonForCategory[4] = self._ui._rdo_HorseMarket
  self._tabButtonForCategory[5] = self._ui._rdo_RentalMarket
  self._tabButtonForCategory[6] = self._ui._rdo_Exit
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantFunction_All:validate()
  PaGlobal_ServantFunction_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantFunction_All:registerEventHandler()
end
function PaGlobal_ServantFunction_All:validate()
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  self._ui._rdo_FunctionList:isValidate()
  self._ui._rdo_LinkCarridge:isValidate()
  self._ui._rdo_Exchange:isValidate()
  self._ui._rdo_MatingMarket:isValidate()
  self._ui._rdo_HorseMarket:isValidate()
  self._ui._rdo_RentalMarket:isValidate()
  self._ui._rdo_Exit:isValidate()
  self._ui._stc_KeyGuide_LB:isValidate()
  self._ui._stc_KeyGuide_RB:isValidate()
  self._ui._stc_TabButtonBar:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._initialize = true
end
function PaGlobal_ServantFunction_All:registerEventHandler()
  if nil == Panel_Dialog_ServantFunction_All or false == self._initialize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantFunction_All_OnScreenResize")
  if false == self._isConsole then
    self._ui._rdo_Exit:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ForceClose()")
    self._ui._rdo_FunctionList:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(0)")
    self._ui._rdo_LinkCarridge:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(1)")
    self._ui._rdo_Exchange:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(2)")
    self._ui._rdo_MatingMarket:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(3)")
    self._ui._rdo_HorseMarket:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(4)")
    self._ui._rdo_RentalMarket:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_ChangeTab(5)")
  else
  end
end
function PaGlobal_ServantFunction_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantFunction_All or false == self._initialize then
    return
  end
  self._ui._stc_KeyGuide_A:SetShow(false)
  self._ui._stc_KeyGuide_LB:SetShow(isConsole)
  self._ui._stc_KeyGuide_RB:SetShow(isConsole)
end
function PaGlobal_ServantFunction_All:prepareOpen(isGuild, servantType)
  if nil == Panel_Dialog_ServantFunction_All or true == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if nil == Panel_Dialog_ServantInfo_All or nil == Panel_Dialog_ServantList_All or nil == Panel_Dialog_ServantLookChange_All or nil == Panel_Dialog_ServantRegist_All or nil == Panel_Dialog_ServantSwiftTraining_All or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == Panel_Dialog_ServantMarket_All or nil == Panel_Dialog_ServantCarriageLink_All then
    return
  end
  self._ui._rdo_FunctionList:SetShow(false)
  self._ui._rdo_LinkCarridge:SetShow(false)
  self._ui._rdo_Exchange:SetShow(false)
  self._ui._rdo_MatingMarket:SetShow(false)
  self._ui._rdo_HorseMarket:SetShow(false)
  self._ui._rdo_RentalMarket:SetShow(false)
  self._ui._rdo_Exit:SetShow(false)
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  self._currentTab = self._ENUM._LIST
  PaGlobal_ServantFunction_All:scenceChange(servantType)
  if CppEnums.ServantType.Type_Vehicle == servantType then
    self._currentNpcType = self._ENUM_NPC_TYPE._LAND
    if true == self._isGuild then
      self._currentNpcType = self._ENUM_NPC_TYPE._GUILD_LAND
    end
    PaGlobalFunc_ServantNameRegist_All_SetPreServantCount()
    local effectControl = Paglobal_ServantList_All_GetRegistBtn()
    if nil ~= effectControl then
      effectControl:EraseAllEffect()
    end
    local SetSnapToList = function()
      PaGlobal_ServantList_All:setSnapTarget(0)
    end
    if true == stable_doHaveRegisterItem() and false == isSiegeStable() then
      local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
      local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERITEM_MSG")
      local messageboxData = {
        title = messageboxTitle,
        content = messageboxMemo,
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if self._isConsole then
        messageboxData.functionApply = SetSnapToList
      end
      MessageBox.showMessageBox(messageboxData)
      if nil ~= effectControl and false == self._isConsole then
        effectControl:EraseAllEffect()
        effectControl:AddEffect("fUI_Dialog_Servant_01A", true, 0, 0)
      end
      effectControl:SetMonoTone(false, false)
      effectControl:SetIgnore(false)
    else
      effectControl:SetMonoTone(true, true)
      effectControl:SetIgnore(true)
    end
    self._ui._rdo_FunctionList:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE"))
  elseif CppEnums.ServantType.Type_Ship == servantType then
    self._currentNpcType = self._ENUM_NPC_TYPE._SEA
    if true == self._isGuild then
      self._currentNpcType = self._ENUM_NPC_TYPE._GUILD_SEA
    end
    local effectControl = Paglobal_ServantList_All_GetRegistBtn()
    if nil ~= effectControl then
      effectControl:EraseAllEffect()
    end
    local SetSnapToList = function()
      PaGlobal_ServantList_All:setSnapTarget(0)
    end
    if true == stable_doHaveRegisterItem() then
      local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
      local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_WHARF_REGISTERITEM_MSG")
      local messageboxData = {
        title = messageboxTitle,
        content = messageboxMemo,
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if true == self._isConsole then
        messageboxData.functionApply = SetSnapToList
      end
      MessageBox.showMessageBox(messageboxData)
      if false == self._isConsole and nil ~= effectControl then
        effectControl:EraseAllEffect()
        effectControl:AddEffect("fUI_Dialog_Servant_01A", true, 0, 0)
      end
      effectControl:SetMonoTone(false, false)
      effectControl:SetIgnore(false)
    else
      effectControl:SetMonoTone(true, true)
      effectControl:SetIgnore(true)
    end
    self._ui._rdo_FunctionList:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_TOWNNPCNAVI_NPCTYPETEXT_8"))
  end
  PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_FunctionList)
  if false == self._isGuild and CppEnums.ServantType.Type_Ship ~= servantType then
    if true == stable_isCarriage() and false == isSiegeStable() then
      PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_LinkCarridge)
    end
    if true == stable_isMix() and false == isSiegeStable() then
      PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_Exchange)
    end
    if true == stable_isMating() then
      PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_MatingMarket)
    end
    if true == stable_isMarket() then
      PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_HorseMarket)
      if true == _ContentsGroup_ServantRent then
        PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_RentalMarket)
      end
    end
  end
  if false == self._isConsole then
    PaGlobal_ServantFunction_All:addButtonGroups(self._ui._rdo_Exit)
  end
  PaGlobal_ServantFunction_All:open()
  FromClient_ServantFunction_All_OnScreenResize()
  PaGlobal_ServantFunction_All:repositionFunctionButton(self._functionButtonCount, self._functionButtons)
  if nil ~= Panel_Npc_Intimacy_All and true == Panel_Npc_Intimacy_All:GetShow() then
    PaGlobalFunc_DialogIntimacy_All_Close()
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(self._currentTab)
  if true == self._isConsole then
    local count = 0
    for idx = 0, #self._tabButtonForCategory do
      if nil ~= self._tabButtonForCategory[idx] and true == self._tabButtonForCategory[idx]:GetShow() then
        self._tempBtnTable[count] = idx
        count = count + 1
      end
    end
  end
end
function PaGlobal_ServantFunction_All:scenceChange(servantType)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Stable)
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  elseif true == self._isConsole then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(true)
    PaGlobalFunc_MainDialog_Close()
  else
    setIgnoreShowDialog(true)
    Panel_Npc_Dialog:SetShow(false)
  end
  UIAni.fadeInSCR_Down(Panel_Dialog_ServantFunction_All)
  local npcKey = dialog_getTalkNpcKey()
  if 0 == npcKey then
    return
  end
  openClientChangeScene(npcKey, 1)
  local funcCameraName = Dialog_getFuncSceneCameraName()
  changeCameraScene(funcCameraName, 0.5)
end
function PaGlobal_ServantFunction_All:addButtonGroups(control)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  if nil == control then
    return
  end
  self._functionButtonCount = self._functionButtonCount + 1
  self._functionButtons[self._functionButtonCount] = control
end
function PaGlobal_ServantFunction_All:repositionFunctionButton(count, btnTable)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  local sizeX = getScreenSizeX()
  local funcButtonCount = count
  local buttonSize = btnTable[1]:GetSizeX()
  local buttonGap = 30
  local startPosX = (sizeX - (buttonSize * funcButtonCount - 10 * (funcButtonCount - 1))) / 2 - Panel_Dialog_ServantFunction_All:GetPosX()
  local posX = 0
  local jindex = 0
  if true == self._isConsole then
    local uiOffset = ToClient_GetConsoleUIOffset()
    local resizedRatioX = getScreenSizeX() * uiOffset
    startPosX = startPosX + resizedRatioX
  end
  for index = 1, funcButtonCount do
    posX = startPosX + buttonSize * jindex
    jindex = jindex + 1
    btnTable[index]:SetSpanSize(posX, 0)
    btnTable[index]:SetShow(true)
  end
  local isKeyGuideShow = self._currentNpcType ~= self._ENUM_NPC_TYPE._SEA
  if true == self._isConsole then
    self._ui._stc_KeyGuide_LB:SetShow(isKeyGuideShow)
    self._ui._stc_KeyGuide_RB:SetShow(isKeyGuideShow)
    self._ui._stc_KeyGuide_LB:SetSpanSize(btnTable[1]:GetSpanSize().x - (btnTable[1]:GetSizeX() / 2 - 30), 0)
    self._ui._stc_KeyGuide_RB:SetSpanSize(btnTable[#btnTable]:GetSpanSize().x + btnTable[#btnTable]:GetSizeX() + 40, 0)
  end
end
function PaGlobal_ServantFunction_All:open()
  if nil == Panel_Dialog_ServantFunction_All or true == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  Panel_Dialog_ServantFunction_All:SetShow(true)
end
function PaGlobal_ServantFunction_All:prepareClose()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  PaGlobal_ServantFunction_All:closeOtherTab()
  SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_SetIgnoreShowDialog(false)
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    PaGlobalFunc_DialogIntimacy_All_Open()
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_setIgnoreShowDialog(false)
    PaGlobalFunc_MainDialog_ReOpen()
  else
    setIgnoreShowDialog(false)
    Panel_Npc_Dialog:SetShow(true)
  end
  UIAni.fadeInSCR_Down(Panel_Dialog_ServantFunction_All)
  local npcKey = dialog_getTalkNpcKey()
  if 0 ~= npcKey then
    closeClientChangeScene(npcKey)
  end
  local mainCameraName = Dialog_getMainSceneCameraName()
  changeCameraScene(mainCameraName, 0.5)
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  if true == self._isConsole then
    PaGlobalFunc_ServantInfo_All_SetIgnoreSnapToOtherPanel(false)
  end
  self._functionButtons = {}
  self._functionButtonCount = 0
  self._isGuild = false
  PaGlobal_ServantFunction_All:close()
end
function PaGlobal_ServantFunction_All:closeOtherTab()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobalFunc_ServantExchange_All_Close()
  PaGlobalFunc_ServantSwiftTraining_All_Close()
  PaGlobalFunc_ServantInfo_All_Close()
  PaGlobalFunc_ServantList_All_Close()
  PaGlobalFunc_ServantLookChange_All_Close()
  PaGlobalFunc_ServantRegist_All_Close()
  PaGlobalFunc_ServantTransferList_All_Close()
  PaGlobalFunc_ServantNameRegist_All_Close()
  PaGlobalFunc_ServantMarket_All_Close()
  PaGlobalFunc_ServantMarket_Rental_Mating_All_Close()
  PaGlobalFunc_ServantCarriageLink_All_Close()
  PaGlobalFunc_ServantSkillManagement_All_Close()
  if true == _ContentsGroup_Sailor and nil ~= PaGlobal_SailorManager_All then
    PaGlobal_SailorManager_All:prepareCloseForce()
  end
end
function PaGlobal_ServantFunction_All:close()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  Panel_Dialog_ServantFunction_All:SetShow(false)
end
