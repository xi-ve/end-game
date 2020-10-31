function PaGlobal_CharInfoTitle_All:initialize()
  if true == self._initialize then
    return
  end
  local leftBg = UI.getChildControl(Panel_CharacterInfoTitle_All, "Static_LeftBG")
  local stc_Title = UI.getChildControl(leftBg, "Static_Title")
  self._ui.stc_TitleBg = UI.getChildControl(stc_Title, "StaticText_TitleBG")
  self._ui.txt_TitleName = UI.getChildControl(stc_Title, "StaticText_TitleName")
  self._ui.txt_TitleDesc = UI.getChildControl(stc_Title, "StaticText_TitleStory")
  self._ui.txt_Desc_ForGlobal = UI.getChildControl(stc_Title, "StaticText_TitleStory_forGlobal")
  local serviceType = getGameServiceResType()
  if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType or CppEnums.ServiceResourceType.eServiceResourceType_Dev == serviceType then
    self._ui.txt_TitleName:SetShow(true)
    self._ui.txt_TitleDesc:SetShow(true)
    self._ui.txt_Desc_ForGlobal:SetShow(false)
  else
    self._ui.txt_TitleDesc:SetShow(false)
    self._ui.txt_Desc_ForGlobal:SetShow(true)
  end
  self._ui.txt_TitleCondi = UI.getChildControl(stc_Title, "StaticText_SelectedType")
  self._originTitleCondiSpanY = self._ui.txt_TitleCondi:GetSpanSize().y
  self._ui.btn_Apply = UI.getChildControl(stc_Title, "Button_SelectButton")
  local stc_totalProgBg = UI.getChildControl(leftBg, "Static_Total_Progress_BG")
  self._ui.txt_TotalCount = UI.getChildControl(stc_totalProgBg, "StaticText_TotalCount")
  self._ui.txt_TotalRate = UI.getChildControl(stc_totalProgBg, "StaticText_TotalPercent")
  self._ui.prog2_TotalTitle = UI.getChildControl(stc_totalProgBg, "Progress2_TitleTotalGauge")
  self._ui.txt_Reward = UI.getChildControl(stc_totalProgBg, "StaticText_TotalReward")
  self._ui.txt_RewardDesc = UI.getChildControl(stc_totalProgBg, "StaticText_RewardDetail")
  local rightBg = UI.getChildControl(Panel_CharacterInfoTitle_All, "Static_RightBg")
  local stc_TitleTabBg = UI.getChildControl(rightBg, "Static_Title_Tap")
  self._ui.rdo_Tab_World = UI.getChildControl(stc_TitleTabBg, "RadioButton_Top_AllRound")
  self._ui.rdo_Tab_Combat = UI.getChildControl(stc_TitleTabBg, "RadioButton_Top_Combat")
  self._ui.rdo_Tab_Life = UI.getChildControl(stc_TitleTabBg, "RadioButton_Top_Product")
  self._ui.rdo_Tab_Fish = UI.getChildControl(stc_TitleTabBg, "RadioButton_Top_Fish")
  self._ui.stc_KeyGuide_RT = UI.getChildControl(stc_TitleTabBg, "Static_RT_ConsoleUI")
  self._ui.stc_KeyGuide_LT = UI.getChildControl(stc_TitleTabBg, "Static_LT_ConsoleUI")
  self._ui.stc_SelectBar = UI.getChildControl(stc_TitleTabBg, "Static_SelectLine")
  self._ui.stc_prog2Table = {}
  local graphBg = UI.getChildControl(leftBg, "Static_Graph_BG")
  for idx = 0, 3 do
    local titleProg = {
      _title = nil,
      _prog2 = nil,
      _rate = nil
    }
    local UIName = ""
    if idx == self._eTITLETYPE._WORLD then
      UIName = "World"
      self._ui.rdo_tabTable[idx] = self._ui.rdo_Tab_World
    elseif idx == self._eTITLETYPE._COMBAT then
      UIName = "Battle"
      self._ui.rdo_tabTable[idx] = self._ui.rdo_Tab_Combat
    elseif idx == self._eTITLETYPE._LIFE then
      UIName = "Life"
      self._ui.rdo_tabTable[idx] = self._ui.rdo_Tab_Life
    else
      UIName = "Fish"
      self._ui.rdo_tabTable[idx] = self._ui.rdo_Tab_Fish
    end
    titleProg._title = UI.getChildControl(graphBg, "StaticText_" .. tostring(UIName) .. "_Text")
    titleProg._prog2 = UI.getChildControl(graphBg, "Progress2_" .. tostring(UIName) .. "")
    titleProg._rate = UI.getChildControl(graphBg, "StaticText_" .. tostring(UIName) .. "_Percent")
    self._ui.stc_prog2Table[idx] = titleProg
  end
  self._ui.edit_Title = UI.getChildControl(rightBg, "Edit_SearchText_PCUI")
  self._ui.btn_Search = UI.getChildControl(self._ui.edit_Title, "Button_BtnSearch_PCUI")
  self._ui.stc_KeyGuide_Search = UI.getChildControl(rightBg, "StaticText_Filter_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Title, "StaticText_XButton")
  self._ui.stc_Console_FilterBg = UI.getChildControl(rightBg, "Static_FilterBox_ConsoleUI")
  self._ui.rdo_Console_All = UI.getChildControl(self._ui.stc_Console_FilterBg, "RadioButton_All")
  self._ui.rdo_Console_Known = UI.getChildControl(self._ui.stc_Console_FilterBg, "RadioButton_Known")
  self._ui.rdo_Console_Unknown = UI.getChildControl(self._ui.stc_Console_FilterBg, "RadioButton_Unknown")
  self._ui.stc_FilterBg = UI.getChildControl(rightBg, "Combobox_TitleFilter_PCUI")
  self._ui.comb_Filter = UI.getChildControl(self._ui.stc_FilterBg, "Combobox_List")
  self._ui.list2_Title = UI.getChildControl(Panel_CharacterInfoTitle_All, "List2_TitleList")
  self._ui.txt_CoolTime = UI.getChildControl(Panel_CharacterInfoTitle_All, "StaticText_AcceptCooltime")
  self._ui.txt_CoolTime:SetShow(false)
  self._ui.stc_Console_KeyGuides = UI.getChildControl(Panel_CharacterInfoTitle_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_AButton")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_BButton")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_Console_KeyGuides, "StaticText_YButton")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._selfPlayer = getSelfPlayer()
  UI.ASSERT_NAME(nil ~= self._selfPlayer, " Panel_CharacterInfo_Title_All_1.lua / getSelfPlayer() is nil", "\234\185\128\234\183\188\236\154\176")
  if nil == self._selfPlayer then
    return
  end
  self._ui.stc_Console_KeyGuides:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_LT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_RT:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_X:SetShow(self._isConsole)
  self._ui.btn_Apply:SetShow(not self._isConsole)
  if CppEnums.ServiceResourceType.eServiceResourceType_KR ~= serviceType and CppEnums.ServiceResourceType.eServiceResourceType_Dev ~= serviceType then
    self._ui.txt_TitleCondi:SetShow(false)
    self._ui.stc_TitleBg:SetSize(self._ui.stc_TitleBg:GetSizeX(), stc_Title:GetSizeY())
    self._ui.stc_TitleBg:SetSpanSize(self._ui.stc_TitleBg:GetSpanSize().x, 0)
    self._ui.stc_TitleBg:ComputePos()
    self._ui.txt_TitleName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_TitleName:SetSize(self._ui.txt_TitleName:GetSizeX(), self._ui.txt_TitleName:GetSizeY() * 2)
    self._ui.txt_TitleName:SetSpanSize(self._ui.txt_TitleName:GetSpanSize().x, 40)
    self._ui.txt_TitleName:ComputePos()
    self._ui.btn_Apply:SetSpanSize(self._ui.btn_Apply:GetSpanSize().x, self._ui.btn_Apply:GetSpanSize().y + 15)
    self._ui.txt_Desc_ForGlobal:SetSize(self._ui.txt_Desc_ForGlobal:GetSizeX(), self._ui.txt_Desc_ForGlobal:GetSizeY() + 30)
    self._ui.txt_Desc_ForGlobal:SetSpanSize(self._ui.txt_Desc_ForGlobal:GetSpanSize().x, self._ui.txt_Desc_ForGlobal:GetSpanSize().y - 20)
    self._ui.txt_Desc_ForGlobal:ComputePos()
  end
  self._ui.txt_RewardDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_TitleCondi:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_TitleDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc_ForGlobal:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_FilterBg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_FILTER_ALL"))
  PaGlobal_CharInfoTitle_All:validate()
  PaGlobal_CharInfoTitle_All:registEventHandler(self._isConsole)
  PaGlobal_CharInfoTitle_All._initialize = true
end
function PaGlobal_CharInfoTitle_All:registEventHandler(console)
  registerEvent("FromClient_TitleInfo_UpdateText", "FromClient_CharInfoTitle_Update")
  self._ui.list2_Title:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_CharInfoTitle_List2Update")
  self._ui.list2_Title:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Title:setMinScrollBtnSize(float2(5, 50 * self._ui.list2_Title:GetScale().y))
  self._ui.stc_FilterBg:GetListControl():AddSelectEvent("HandleEventLUp_CharInfoTitle_SelectFilter()")
  self._ui.stc_FilterBg:DeleteAllItem(0)
  self._ui.stc_FilterBg:setListTextHorizonCenter()
  for idx = 0, 2 do
    self._ui.stc_FilterBg:AddItem(self._comboText[idx])
  end
  self._ui.stc_FilterBg:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ToggleFilter()")
  if true == console then
    self._ui.edit_Title:setXboxVirtualKeyBoardEndEvent("PaGlobal_CharinfoTitle_CloseVirtualKeyboard")
    self._ui.edit_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ClickEditBox()")
    PaGlobal_CharInfo_All._ui.stc_TitleBg:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventPadPress_CharInfoTitle_SelectCategory( false )")
    PaGlobal_CharInfo_All._ui.stc_TitleBg:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventPadPress_CharInfoTitle_SelectCategory( true )")
    PaGlobal_CharInfo_All._ui.stc_TitleBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_CharinfoTitle_OpenVirtualKeyboard()")
    PaGlobal_CharInfo_All._ui.stc_TitleBg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CharInfoTitle_ToggleFilter()")
  else
    self._ui.btn_Search:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ClickSearchBox()")
    self._ui.edit_Title:RegistReturnKeyEvent("HandleEventLUp_CharInfoTitle_ClickSearchBox()")
    self._ui.edit_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ClickEditBox()")
    self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_ApplyTitle()")
    for idx = 0, 3 do
      self._ui.rdo_tabTable[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_CharInfoTitle_SelectCategory(" .. idx .. ")")
      self._ui.rdo_tabTable[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_CharInfoTitle_TabBtnTooltip(" .. idx .. ")")
      self._ui.rdo_tabTable[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_CharInfoTitle_TabBtnTooltip()")
    end
  end
end
function PaGlobal_CharInfoTitle_All:dataClear()
  if true == self._ui.comb_Filter:GetShow() then
    self._ui.stc_FilterBg:ToggleListbox()
  end
  ToClient_SetCurrentTitleCategory(PaGlobal_CharInfoTitle_All._eTITLETYPE._WORLD)
  HandleEventLUp_CharInfoTitle_SelectCategory(PaGlobal_CharInfoTitle_All._eTITLETYPE._WORLD)
  PaGlobal_CharInfoTitle_All._currentTab = PaGlobal_CharInfoTitle_All._eTITLETYPE._WORLD
  PaGlobal_CharInfoTitle_All._curCategoryCount = ToClient_GetCategoryTitleCount(PaGlobal_CharInfoTitle_All._eTITLETYPE._WORLD)
  self._ui.stc_FilterBg:SetSelectItemIndex(0)
  self._selectedIdx = nil
  self._isFiltered = false
  self._ui.edit_Title:SetEditText("")
  self:setAppliedTitleButton()
  PaGlobal_CharInfoTitle_All._list2ScrollData._list2Idx = 0
  PaGlobal_CharInfoTitle_All._list2ScrollData._ScrollPos = 0
  if true == self._isConsole then
    local keyguide = {
      self._ui.stc_KeyGuide_Y,
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_Console_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_CharInfoTitle_All:update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._title) then
    return
  end
  if false == PaGlobal_ChracterInfo_All_GetLPress() then
    self._ui.txt_TotalCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_SUBTITLEBAR_COUNT", "count", ToClient_GetTotalAcquiredTitleCount()))
    if self._ui.txt_TotalCount:GetTextSizeX() > self._ui.txt_TotalCount:GetSizeX() then
      self._ui.txt_TotalCount:SetIgnore(false)
      UI.setLimitTextAndAddTooltip(self._ui.txt_TotalCount)
    end
    local titleCountByAll = ToClient_GetTotalTitleCount()
    local titleTotalCount = ToClient_GetTotalTitleBuffCount()
    if nil == titleCountByAll then
      return
    end
    local gotTitleCountByAll = ToClient_GetTotalAcquiredTitleCount()
    if nil == gotTitleCountByAll then
      return
    end
    local totalPercent = gotTitleCountByAll / titleCountByAll * 100
    self._ui.prog2_TotalTitle:SetProgressRate(totalPercent)
    self._ui.txt_TotalRate:SetText(string.format("%.1f", totalPercent) .. "%")
    local buffDescription = ""
    for index = 0, titleTotalCount - 1 do
      local titleBuffWrapper = ToClient_GetTitleBuffWrapper(index)
      if nil ~= titleBuffWrapper then
        buffDescription = titleBuffWrapper:getBuffDescription()
      end
    end
    self._ui.txt_RewardDesc:SetTextMode(__eTextMode_None)
    if nil ~= buffDescription and "" ~= buffDescription then
      self._ui.txt_RewardDesc:SetText(buffDescription)
      local textSize = self._ui.txt_RewardDesc:GetTextSizeX() * Panel_CharacterInfo_All:GetScale().x
      local controlSize = self._ui.txt_RewardDesc:GetSizeX()
      if textSize > controlSize then
        self._ui.txt_RewardDesc:SetTextMode(__eTextMode_AutoWrap)
        self._ui.txt_RewardDesc:SetText(buffDescription)
      end
    else
      self._ui.txt_RewardDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_TOTALREWARD_VALUE"))
    end
    if nil == self._ui.stc_prog2Table then
      UI.ASSERT_NAME(nil ~= self._ui.stc_prog2Table, " Panel_CharacterInfo_Title_All_1.lua / stc_prog2Table is nil", "\234\185\128\234\183\188\236\154\176")
      return
    end
  end
  for categoryIdx = 0, 3 do
    if nil == self._ui.stc_prog2Table[categoryIdx] then
      UI.ASSERT_NAME(nil ~= self._ui.stc_prog2Table[categoryIdx], " Panel_CharacterInfo_Title_All_1.lua / self._ui.stc_prog2Table[" .. categoryIdx .. "] is nil", "\234\185\128\234\183\188\236\154\176")
      return
    end
    local graphTable = self._ui.stc_prog2Table[categoryIdx]
    ToClient_GetCategoryTitleCount(categoryIdx)
    local titleCurrentCount = ToClient_GetCategoryTitleCount(categoryIdx)
    local titleCurrentGetCount = ToClient_GetAcquiredTitleCount(categoryIdx)
    local titleCurrentPercent = 0
    if 0 == titleCurrentGetCount then
      titleCurrentPercent = 0
    else
      titleCurrentPercent = titleCurrentGetCount / titleCurrentCount * 100
    end
    graphTable._rate:SetText(string.format("%.1f", titleCurrentPercent) .. "%")
    graphTable._prog2:SetProgressRate(titleCurrentPercent)
  end
  local lastCount = self._curCategoryCount
  if lastCount < 1 then
    return
  end
  if false == self._isFiltered then
    self._ui.list2_Title:getElementManager():clearKey()
    for titleIndex = 0, lastCount - 1 do
      self._ui.list2_Title:getElementManager():pushKey(toInt64(0, titleIndex))
    end
  else
    local listCount = ToClient_GetFilteredTitleCount()
    self._ui.list2_Title:getElementManager():clearKey()
    for index = 0, listCount - 1 do
      local titleIdx = ToClient_GetTitleIndexFromFilteredList(index)
      self._ui.list2_Title:getElementManager():pushKey(toInt64(0, titleIdx))
    end
  end
  self._ui.list2_Title:setMinScrollBtnSize(float2(5, 50 * self._ui.list2_Title:GetScale().y))
  if false == self._isConsole then
    self._ui.btn_Apply:SetShow(self._isApplyBtnShow)
  end
  if true == self._isApplyBtnShow then
    self._ui.txt_TitleCondi:SetHorizonLeft()
    self._ui.txt_TitleCondi:SetSpanSize(20, self._ui.btn_Apply:GetSpanSize().y + 5)
  else
    self._ui.txt_TitleCondi:SetHorizonCenter()
    self._ui.txt_TitleCondi:SetSpanSize(0, self._ui.btn_Apply:GetSpanSize().y + 5)
  end
end
function PaGlobal_CharInfoTitle_All:updateCoolTime()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._title) then
    return
  end
  local coolTime = ToClient_GetUpdateTitleDelay()
  if 0 < coolTime then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_LASTUPDATETIME", "coolTime", coolTime))
  end
end
function PaGlobal_CharInfoTitle_All:updateFilteredList()
  local searchText = self._ui.edit_Title:GetEditText()
  local curFilterIdx = PaGlobal_CharInfoTitle_All._ui.stc_FilterBg:GetSelectIndex()
  ToClient_MakeTitleList(searchText, curFilterIdx)
  local listCount = ToClient_GetFilteredTitleCount()
  self._ui.list2_Title:getElementManager():clearKey()
  for index = 0, listCount - 1 do
    local titleIdx = ToClient_GetTitleIndexFromFilteredList(index)
    self._ui.list2_Title:getElementManager():pushKey(toInt64(0, titleIdx))
  end
  self._isFiltered = true
end
function PaGlobal_CharInfoTitle_All:clearSearchText()
  self._ui.edit_Title:SetEditText("")
  ClearFocusEdit()
end
function PaGlobal_CharInfoTitle_All:getAppliedTitle()
  PaGlobal_CharInfoTitle_All._saveTab = nil
  for idx = 0, 3 do
    ToClient_SetCurrentTitleCategory(idx)
    local titleCount = ToClient_GetCategoryTitleCount(idx)
    for i = 0, titleCount - 1 do
      local wrapper = ToClient_GetTitleStaticStatusWrapper(i)
      if nil ~= wrapper and true == ToClient_IsAppliedTitle(wrapper:getKey()) then
        PaGlobal_CharInfoTitle_All._saveTab = idx
        PaGlobal_CharInfoTitle_All._selectedIdx = i
        return wrapper
      end
    end
  end
  return nil
end
function PaGlobal_CharInfoTitle_All:setAppliedTitleButton()
  self._isApplyBtnShow = false
  if true == self._selfPlayer:checkToTitleKey() then
    local titleWrapper = PaGlobal_CharInfoTitle_All:getAppliedTitle()
    if nil ~= titleWrapper then
      self._isApplyBtnShow = true
      PaGlobal_CharInfoTitle_All:setTitleText(titleWrapper)
      self._ui.btn_Apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_RELEASE"))
    end
  else
    self._ui.txt_Desc_ForGlobal:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_NOAPPLIEDTITLEYET"))
    self._ui.txt_TitleName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_PARTDESC"))
    self._ui.txt_TitleDesc:SetText("")
    local serviceType = getGameServiceResType()
    if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType or CppEnums.ServiceResourceType.eServiceResourceType_Dev == serviceType then
      PaGlobal_CharInfoTitle_All._ui.txt_TitleCondi:SetShow(true)
      self._ui.txt_TitleCondi:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_PARTDESC"))
      self._ui.txt_TitleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_TITLE_NOAPPLIEDTITLEYET"))
    end
  end
  if false == self._isConsole then
    self._ui.btn_Apply:SetShow(self._isApplyBtnShow)
  end
  PaGlobal_CharInfoTitle_All:alignTitleTextForGlobal(self._isApplyBtnShow)
  if true == self._isApplyBtnShow then
    self._ui.txt_TitleCondi:SetHorizonLeft()
    self._ui.txt_TitleCondi:SetSpanSize(20, self._ui.btn_Apply:GetSpanSize().y + 5)
  else
    self._ui.txt_TitleCondi:SetHorizonCenter()
    self._ui.txt_TitleCondi:SetSpanSize(0, self._ui.btn_Apply:GetSpanSize().y + 5)
  end
  if nil ~= PaGlobal_CharInfoTitle_All._currentTab then
    ToClient_SetCurrentTitleCategory(PaGlobal_CharInfoTitle_All._currentTab)
  end
end
function PaGlobal_CharInfoTitle_All:alignTitleTextForGlobal(set)
  local serviceType = getGameServiceResType()
  if CppEnums.ServiceResourceType.eServiceResourceType_KR == serviceType or CppEnums.ServiceResourceType.eServiceResourceType_Dev == serviceType then
    return
  end
  local titleSizeX = 395 * self._ui.txt_TitleName:GetScale().x
  if true == set then
    if true == self._ui.btn_Apply:GetShow() then
      self._ui.txt_TitleName:SetSize(titleSizeX - (self._ui.btn_Apply:GetSizeX() + self._ui.btn_Apply:GetSpanSize().x + 8), self._ui.txt_Desc_ForGlobal:GetSizeY())
    else
      self._ui.txt_TitleName:SetSize(titleSizeX - 5, self._ui.txt_Desc_ForGlobal:GetSizeY())
    end
    self._ui.txt_TitleName:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_TitleName:SetText(self._ui.txt_TitleName:GetText())
    self._ui.txt_TitleName:SetHorizonLeft()
    self._ui.txt_TitleName:SetSpanSize(2, 15)
    self._ui.txt_TitleName:ComputePos()
  else
    self._ui.txt_TitleName:SetSize(titleSizeX - 5, self._ui.txt_Desc_ForGlobal:GetSizeY())
    self._ui.txt_TitleName:SetHorizonCenter()
    self._ui.txt_TitleName:SetSpanSize(0, 15)
    self._ui.txt_TitleName:ComputePos()
  end
end
function PaGlobal_CharInfoTitle_All:setTitleText(wrapper)
  if nil == wrapper then
    return ""
  end
  self._ui.txt_Desc_ForGlobal:SetText(wrapper:getDescription())
  local splitText = string.split(wrapper:getDescription(), "\\n")
  self._ui.txt_TitleName:SetText(wrapper:getName())
  if 1 < #splitText then
    self._ui.txt_TitleDesc:SetText(splitText[2])
    self._ui.txt_TitleCondi:SetText(splitText[1])
    self._ui.txt_TitleCondi:SetShow(true)
  else
    self._ui.txt_TitleCondi:SetShow(false)
    self._ui.txt_TitleDesc:SetText(splitText[1])
  end
  local scaleY = self._ui.txt_TitleDesc:GetScale().y
  if self._ui.txt_TitleDesc:GetTextSizeY() * scaleY > self._ui.txt_TitleDesc:GetSizeY() then
    UI.setLimitTextAndAddTooltip(self._ui.txt_TitleDesc, "", self._ui.txt_TitleDesc:GetText())
  elseif true == self._ui.txt_TitleDesc:IsLimitText() then
    self._ui.txt_TitleDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_TitleDesc:SetText(self._ui.txt_TitleDesc:GetText())
  end
end
function PaGlobal_CharInfoTitle_All:validate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.txt_TitleName:isValidate()
  self._ui.txt_TitleDesc:isValidate()
  self._ui.txt_TitleCondi:isValidate()
  self._ui.btn_Apply:isValidate()
  self._ui.txt_TotalCount:isValidate()
  self._ui.txt_TotalRate:isValidate()
  self._ui.prog2_TotalTitle:isValidate()
  self._ui.txt_Reward:isValidate()
  self._ui.txt_RewardDesc:isValidate()
  for idx = 0, 3 do
    self._ui.stc_prog2Table[idx]._title:isValidate()
    self._ui.stc_prog2Table[idx]._prog2:isValidate()
    self._ui.stc_prog2Table[idx]._rate:isValidate()
  end
  self._ui.rdo_Tab_World:isValidate()
  self._ui.rdo_Tab_Combat:isValidate()
  self._ui.rdo_Tab_Life:isValidate()
  self._ui.rdo_Tab_Fish:isValidate()
  self._ui.stc_KeyGuide_RT:isValidate()
  self._ui.stc_KeyGuide_LT:isValidate()
  self._ui.stc_SelectBar:isValidate()
  self._ui.edit_Title:isValidate()
  self._ui.btn_Search:isValidate()
  self._ui.stc_KeyGuide_Search:isValidate()
  self._ui.stc_Console_FilterBg:isValidate()
  self._ui.rdo_Console_All:isValidate()
  self._ui.rdo_Console_Known:isValidate()
  self._ui.rdo_Console_Unknown:isValidate()
  self._ui.stc_FilterBg:isValidate()
  self._ui.comb_Filter:isValidate()
  self._ui.list2_Title:isValidate()
  self._ui.txt_CoolTime:isValidate()
  self._ui.stc_Console_KeyGuides:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
