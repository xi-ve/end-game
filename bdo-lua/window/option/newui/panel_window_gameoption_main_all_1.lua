function PaGlobal_GameOption_All:ClickedMainCategory(key, category)
  local tree2 = self._ui.list2_category
  for k, value in pairs(self._list2._tree2IndexMap) do
    if true == value._isMain then
      local keyElement = tree2:getElementManager():getByKey(toInt64(0, k), false)
      keyElement:setIsOpen(false)
    end
  end
  tree2:getElementManager():toggle(toInt64(0, key))
  self._list2._selectedKey = key
  tree2:getElementManager():refillKeyList()
  local heightIndex = tree2:getIndexByKey(toInt64(0, key))
  tree2:moveIndex(heightIndex)
  if true == _ContentsGroup_UsePadSnapping then
    local mainCategoryContent = tree2:GetContentByKey(toInt64(0, key))
    local mainCategoryButton = UI.getChildControl(mainCategoryContent, "RadioButton_MenuName")
    ToClient_padSnapChangeToTarget(mainCategoryButton)
  end
end
function PaGlobal_GameOption_All:ClickedSubCategory(key, category, detail, moveElement)
  self._list2._selectedSubKey = key
  self:SelectOptionFrame(category, detail, moveElement)
end
function PaGlobal_GameOption_All:ClickedHomeButton()
  self:movePage(self.PAGE.Main)
  TooltipSimple_Hide()
  self._ui.btn_home:setRenderTexture(self._ui.btn_home:getBaseTexture())
end
function PaGlobal_GameOption_All:ClickedResetAllOption()
  ClearFocusEdit()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_ALLRESETCONFIRMMESSAGE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = FGlobal_Option_ResetAllOption,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_Option_ResetAllOption()
  PaGlobal_GameOption_All._resetCheck = true
  PaGlobal_GameOption_All:ResetAlert()
  PaGlobal_GameOption_All:setOptionValue("UseNewQuickSlot", PaGlobal_GameOption_All._elements.UseNewQuickSlot._defaultValue)
  resetAllOption()
  keyCustom_SetDefaultAction()
  keyCustom_SetDefaultUI()
  if true == ToClient_isUsePadSnapping() then
    setConsoleKeyType(2)
  end
  PaGlobal_GameOption_All:ResetKeyCustomString()
  saveGameOption(false)
end
function PaGlobal_GameOption_All:ResetAlert()
  for _, index in pairs(self.ALERT) do
    ToClient_SetMessageFilter(index, false)
  end
end
function PaGlobal_GameOption_All:ClickedCacheDeleteOption()
  ClearFocusEdit()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_CACHEDELETECONFIRMMESSAGE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = FGlobal_Option_CacheDeleteOption,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_Option_CacheDeleteOption()
  ToClient_removeCacheFolder()
  if true == ToClient_removeCacheFolder() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_CACHEDELETE_ACK"))
  end
end
function PaGlobal_GameOption_All:ClickedResetFrame()
  if nil == self._list2._curCategory or nil == self._list2._curDetail then
    _PA_LOG("\237\155\132\236\167\132", "[GameOption][ClickedResetFrame] \237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \237\148\132\235\160\136\236\158\132\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164. \236\150\180\235\148\148\236\132\156 \237\149\168\236\136\152\235\165\188 \235\182\136\235\160\128\235\138\148\236\167\128 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.")
    return
  end
  ClearFocusEdit()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NEWGAMEOPTION_CAUTION_RESET")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = FGlobal_Option_ResetFrame,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_Option_ResetFrame()
  local self = PaGlobal_GameOption_All
  local resetElements = self._frames[self._list2._curCategory][self._list2._curDetail]
  local isKeyCustomReset = false
  local rv
  for index, option in ipairs(resetElements) do
    if nil ~= option._element then
      local curOption = option._element
      if nil ~= curOption.actionInputType or nil ~= curOption.uiInputType then
        self:KeyCustomResetFrame(curOption)
        isKeyCustomReset = true
      elseif nil ~= curOption._defaultValue then
        local elementName = curOption._name
        local beforeOption = self:getOptionValue(elementName)
        self:ResetControlSetting(curOption)
        rv = self:setOptionValue(elementName, curOption._defaultValue)
        if false == rv then
          self:SetControlSetting(elementName, beforeOption)
          curOption._initValue = beforeOption
        else
          curOption._initValue = curOption._defaultValue
        end
        curOption._applyValue = nil
        curOption._curValue = nil
      end
    end
  end
  if true == isKeyCustomReset then
    PaGlobal_GameOption_All:ResetKeyCustomString()
    self:ApplyButtonEnable(true)
  else
    self:ApplyButtonEnable(false)
  end
end
function PaGlobal_GameOption_All:KeyCustomResetFrame(option)
  if nil == option then
    return
  end
  if nil ~= option.actionInputType then
    if "PadFunction1" == option.actionInputType then
      keyCustom_SetDefaultPadFunc1()
    elseif "PadFunction2" == option.actionInputType then
      keyCustom_SetDefaultPadFunc2()
    else
      keyCustom_SetDefaultActionData(option.actionInputType)
    end
    return
  elseif nil ~= option.uiInputType then
    keyCustom_SetDefaultUIData(option.uiInputType)
    return
  end
end
function PaGlobal_GameOption_All:SaveCutsomOption(index)
  self._curCustomOption = index - 1
  local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MESSAGEBOX_CUSTOM_SAVE_DESC" .. tostring(index - 1))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MESSAGEBOX_CUSTOM_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameOption_All_SaveCustom,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
end
function PaGlobal_GameOption_All_SaveCustom()
  ToClient_saveCustimizeOption(PaGlobal_GameOption_All._curCustomOption)
end
function PaGlobal_GameOption_All:ClickedCancelOption()
  for elementName, option in pairs(self._elements) do
    local check = false
    if nil ~= option._curValue then
      if true == option._settingRightNow then
        check = true
      else
        self:ResetControlSetting(option)
        self:SetControlSetting(option, option._initValue)
        option._curValue = nil
      end
    end
    if nil ~= option._applyValue then
      check = true
    end
    if true == check then
      self:ResetControlSetting(option)
      self:setOptionValue(option._name, option._initValue)
    end
  end
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  setAudioOptionByConfig()
  keyCustom_RollBack()
  self:CompleteKeyCustomMode()
  self:ApplyButtonEnable(false)
  ClearFocusEdit()
end
function PaGlobal_GameOption_All:ClickedApplyOption()
  local displayChange = false
  self:setOptionValue("GraphicOption", self._elements.GraphicOption._curValue)
  for elementName, option in pairs(self._elements) do
    if nil ~= option.actionInputType or nil ~= option.uiInputType then
      option._curValue = nil
    elseif nil ~= option._curValue then
      self:setOptionValue(option._name, option._curValue)
      if true == option._isChangeDisplay then
        displayChange = true
      end
    end
  end
  if nil ~= Panel_MainStatus_Remaster and Panel_MainStatus_Remaster:GetShow() then
    PaGlobalFunc_MainStatus_SetMPBarTexture()
  elseif nil ~= Panel_MainStatus_User_Bar and Panel_MainStatus_User_Bar:GetShow() then
    PaGlobalFunc_UserBar_CharacterInfoWindowUpdate(true)
  end
  if true == displayChange then
    self:DisplayChanged()
    self:Close()
    return
  end
  keyCustom_applyChange()
  keyCustom_StartEdit()
  saveGameOption(false)
  ToClient_saveUserCache()
  self:ApplyButtonEnable(false)
  ClearFocusEdit()
end
function PaGlobal_GameOption_All:ClickedConfirmOption()
  if isNeedGameOptionFromServer() == true then
    FGlobal_QuestWindowRateSetting()
    _AudioPostEvent_SystemUiForXBOX(50, 1)
    if nil ~= Panel_UIControl_SetShow then
      Panel_UIControl_SetShow(false)
    end
  end
  audioPostEvent_SystemUi(1, 0)
  self:ClickedApplyOption()
  self:Close()
end
function PaGlobal_GameOption_All:ClickedSearchOption()
  local edit = GetFocusEdit()
  local list = self._ui.list2_search
  local findString
  if nil == edit then
    findString = self._ui.edit_search:GetEditText()
  else
    findString = edit:GetEditText()
    edit:SetText(findString)
  end
  self._ui.edit_search:SetEditText("")
  self._ui.edit_search:SetText("")
  self._findStrings = self:SearchOption(findString)
  local sortFindStringFunc = function(lhs, rhs)
    local lhsMergeString = lhs._category._string .. " " .. lhs._detail._string .. " " .. lhs._elementString
    local rhsMergeString = rhs._category._string .. " " .. rhs._detail._string .. " " .. rhs._elementString
    return stringCompare(lhsMergeString, rhsMergeString) < 0
  end
  table.sort(self._findStrings, sortFindStringFunc)
  if nil == self._findStrings then
    list:getElementManager():clearKey()
    return
  end
  local count = #self._findStrings
  if 0 == count then
    self._ui.txt_noResult:SetShow(true)
  else
    self._ui.txt_noResult:SetShow(false)
  end
  self:movePage(self.PAGE.Search)
  list:getElementManager():clearKey()
  for index = 1, count do
    list:getElementManager():pushKey(toInt64(0, index))
    list:requestUpdateByKey(toInt64(0, index))
  end
  self:ResetListToggleState()
end
function PaGlobal_GameOption_All:ClickedSearchEditControl()
  self._ui.edit_search:SetEditText("")
end
function PaGlobal_GameOption_All_SetSearchFocus()
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_GameOption_All._ui.edit_search)
end
function PaGlobal_GameOption_All:SearchOption(inputString)
  local findTable = {}
  for index, option in pairs(self._elements) do
    local rv, elementName
    if nil == option._title then
    else
      elementName = PAGetString(Defines.StringSheet_RESOURCE, option._title)
      rv = string.find(string.lower(elementName), string.lower(inputString), nil, true)
    end
    if nil == elementName and nil ~= option._searchTitle then
      elementName = PAGetString(Defines.StringSheet_RESOURCE, option._searchTitle)
      rv = string.find(string.lower(elementName), string.lower(inputString), nil, true)
    end
    if nil == option._category or nil == option._detail then
      rv = nil
    end
    if false == option._isShow then
      rv = nil
    end
    if nil ~= rv then
      local isblocked = false
      isblocked = PaGlobal_GameOption_All:CheckBlockedSearching(elementName)
      if false == isblocked then
        for order, v in pairs(option._category) do
          findTable[#findTable + 1] = {
            _elementString = elementName,
            _elementName = option._name,
            _category = option._category[order],
            _detail = option._detail[order]
          }
        end
      end
    end
  end
  return findTable
end
function PaGlobal_GameOption_All:CheckBlockedSearching(inputString)
  if nil == inputString then
    return false
  end
  local isblocked = false
  if isGameTypeKR2() then
    for idx = 1, #self._tempKR2BlockString do
      if nil ~= self._tempKR2BlockString[idx] and self._tempKR2BlockString[idx] == inputString then
        isblocked = true
      end
    end
  elseif isGameTypeKorea() then
    for idx = 1, #self._tempKRBlockString do
      if nil ~= self._tempKRBlockString[idx] and self._tempKRBlockString[idx] == inputString then
        isblocked = true
      end
    end
  elseif isGameTypeRussia() then
    for idx = 1, #self._tempRUBlockString do
      if nil ~= self._tempRUBlockString[idx] and self._tempRUBlockString[idx] == inputString then
        isblocked = true
      end
    end
  end
  return isblocked
end
function PaGlobal_GameOption_All:ClickedFindElement(category, detail, searchElement)
  self:movePage(self.PAGE.Category)
  if nil == category or nil == detail then
    _PA_LOG("\237\155\132\236\167\132", "[GameOption][ClickedFindElement] \236\152\181\236\133\152 \236\132\184\237\140\133\236\157\180 \236\158\152\235\170\187\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. CreateEventControl\236\157\132 \235\179\180\236\132\184\236\154\148.  category : " .. category .. " detail : " .. detail)
  end
  self:GoCategory(category, detail, searchElement)
end
function PaGlobal_GameOption_All:ResetListToggleState()
  local tree2 = self._ui.list2_category
  for k, value in pairs(self._list2._tree2IndexMap) do
    if true == value._isMain then
      local keyint64 = toInt64(0, k)
      local keyElement = tree2:getElementManager():getByKey(keyint64, false)
      if true == keyElement:getIsOpen() then
        tree2:getElementManager():toggle(keyint64)
        self._list2._selectedKey = -1
        tree2:requestUpdateByKey(keyint64)
      end
      keyElement:setIsOpen(false)
    end
  end
end
function FGlobal_Option_CheckUiEdit(targetUI)
  if nil == PaGlobal_GameOption_All._ui.edit_search then
    return false
  end
  if false == PaGlobal_GameOption_All:isOpen() then
    return false
  end
  if targetUI:GetKey() == PaGlobal_GameOption_All._ui.edit_search:GetKey() and targetUI:GetID() == PaGlobal_GameOption_All._ui.edit_search:GetID() then
    return true
  end
  return false
end
function PaGlobal_GameOption_All:ClickedSpecSetting(value)
  local messageBoxMemo = ""
  if value <= 4 then
    messageBoxMemo = self._homeTooltip["Spec" .. tostring(value)].name
  elseif value <= 8 then
    messageBoxMemo = self._homeTooltip["War" .. tostring(value - 4)].name
  end
  messageBoxMemo = messageBoxMemo .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMEOPTION_CONFIRM_MESSAGE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_SPECTITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameOption_All_SetSpec,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  self._curSpecValue = value
  ClearFocusEdit()
end
function PaGlobal_GameOption_All_SetSpec()
  PaGlobal_GameOption_All:SetSpecSetting(PaGlobal_GameOption_All._curSpecValue)
end
function PaGlobal_GameOption_All:LoadCutsomOption(index)
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
    return
  end
  self._curCustomOption = index - 1
  local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MESSAGEBOX_CUSTOM_LOAD_DESC" .. tostring(index - 1))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MESSAGEBOX_CUSTOM_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobal_GameOption_All_LoadCustom,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
end
function PaGlobal_GameOption_All_LoadCustom()
  local fontsize = PaGlobal_GameOption_All:getOptionValue("UIFontSizeType")
  local index = PaGlobal_GameOption_All._curCustomOption
  local result = ToClient_loadCustimizeOption(index)
  if true == result then
    if nil ~= PaGlobal_GameOption_All._elements.UIFontSizeType and fontsize ~= PaGlobal_GameOption_All._elements.UIFontSizeType._initValue then
      PaGlobal_GameOption_All:setOptionValue("UIFontSizeType", PaGlobal_GameOption_All._elements.UIFontSizeType._initValue)
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWGAMEOPTION_MESSAGEBOX_CUSTOM_NOLOAD"))
  end
end
