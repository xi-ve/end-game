function PaGlobal_Quest_Option_All:initialize()
  if true == PaGlobal_Quest_Option_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_Quest_Option_All, "Static_TitleBG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_CloseIcon")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_Quest_Option_All, "Button_Confirm")
  self._ui.btn_cancel = UI.getChildControl(Panel_Window_Quest_Option_All, "Button_Cancle")
  self._ui.stc_mainBG = UI.getChildControl(Panel_Window_Quest_Option_All, "Static_MainBg")
  self._ui.stc_option_displayBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Option_Display")
  self._ui.stc_option_sortBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Option_Sort")
  self._ui.stc_option_recentBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Option_RecentUpdate")
  self._ui.txt_sortTypeDesc = UI.getChildControl(self._ui.stc_option_displayBG, "StaticText_SortTypeDescBg")
  for index = 0, self._favorType.Count - 1 do
    self._ui.favorCheckBoxButton[index] = UI.getChildControl(self._ui.stc_option_displayBG, "Checkbox_" .. tostring(index))
  end
  for index = 0, self._sortState.Count - 1 do
    self._ui.sortButton_Type[index] = UI.getChildControl(self._ui.stc_option_sortBG, "RadioButton_SortType" .. tostring(index + 1))
    self._ui.sortButton_Distance[index] = UI.getChildControl(self._ui.stc_option_sortBG, "RadioButton_SortDistanceNear" .. tostring(index + 1))
    self._ui.sortButton_TimeRecent[index] = UI.getChildControl(self._ui.stc_option_sortBG, "RadioButton_SortTimeRecent" .. tostring(index + 1))
  end
  for index = 0, self._latestQuestCount.Count - 1 do
    self._ui.latestQuestCountButton[index] = UI.getChildControl(self._ui.stc_option_recentBG, "RadioButton_" .. tostring(index))
  end
  for index = 0, self._questWidgetType.Count - 1 do
    self._ui.questWidgetTypeButton[index] = UI.getChildControl(self._ui.stc_option_recentBG, "RadioButton_View_" .. tostring(index))
  end
  self._defaultDescSizeY = self._ui.txt_sortTypeDesc:GetSizeY()
  self._defaultDisplayBGSizeY = self._ui.stc_option_displayBG:GetSizeY()
  self._defaultMainBGSizeY = self._ui.stc_mainBG:GetSizeY()
  self._defaultPanelSizeY = Panel_Window_Quest_Option_All:GetSizeY()
  self._defaultSortBGStartPosY = self._ui.stc_option_sortBG:GetPosY()
  self._defaultRecentBGStartPosY = self._ui.stc_option_recentBG:GetPosY()
  Panel_Window_Quest_Option_All:SetIgnore(true)
  PaGlobal_Quest_Option_All:setCurrentValue()
  PaGlobal_Quest_Option_All:registEventHandler()
  PaGlobal_Quest_Option_All:validate()
  PaGlobal_Quest_Option_All._initialize = true
end
function PaGlobal_Quest_Option_All:registEventHandler()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Quest_Option_All_OnScreenResize")
  for ii = 0, self._favorType.Count - 1 do
    self._ui.favorCheckBoxButton[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_Option_All_SelectQuestFavorType(" .. ii .. ")")
    self._ui.favorCheckBoxButton[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_Option_All_ShowToolTip(true, " .. ii .. ")")
    self._ui.favorCheckBoxButton[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_Option_All_ShowToolTip(false)")
  end
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_Quest_Option_All_Confirm()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Quest_Option_All_Close()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Quest_Option_All_Close()")
end
function PaGlobal_Quest_Option_All:setCurrentValue()
  local QuestListInfo = ToClient_GetQuestList()
  if nil ~= QuestListInfo then
    for ii = 0, self._favorType.Count - 1 do
      self._ui.favorCheckBoxButton[ii]:SetCheck(QuestListInfo:isQuestSelectType(ii))
      self._ui.favorCheckBoxButton[ii]:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui.favorCheckBoxButton[ii]:SetEnableArea(0, 0, self._ui.favorCheckBoxButton[ii]:GetSizeX() + self._ui.favorCheckBoxButton[ii]:GetTextSizeX() + 5, self._ui.favorCheckBoxButton[ii]:GetSizeY())
    end
    PaGlobal_Quest_Option_All:updateFavorButton()
  end
  for ii = 0, self._sortState.Count - 1 do
    self._ui.sortButton_Type[ii]:SetCheck(false)
    self._ui.sortButton_Distance[ii]:SetCheck(false)
    self._ui.sortButton_TimeRecent[ii]:SetCheck(false)
  end
  local favorValue = ToClient_GetCheckedQuestSortType(self._sortType.Favor)
  local distanceValue = ToClient_GetCheckedQuestSortType(self._sortType.Distance)
  local timeRecentValue = ToClient_GetCheckedQuestSortType(self._sortType.TimeRecent)
  local favorIndex = self:getUiIndexFromRealValue(self._sortType.Favor, favorValue)
  local distanceIndex = self:getUiIndexFromRealValue(self._sortType.Distance, distanceValue)
  local timeRecentIndex = self:getUiIndexFromRealValue(self._sortType.TimeRecent, timeRecentValue)
  self._ui.sortButton_Type[favorIndex]:SetCheck(true)
  self._ui.sortButton_Distance[distanceIndex]:SetCheck(true)
  self._ui.sortButton_TimeRecent[timeRecentIndex]:SetCheck(true)
  for ii = 0, self._latestQuestCount.Count - 1 do
    self._ui.latestQuestCountButton[ii]:SetCheck(false)
  end
  local showCount = ToClient_GetLatestQuestShowCount()
  if nil ~= showCount then
    if showCount >= self._latestQuestCount.zero and showCount < self._latestQuestCount.Count then
      self._ui.latestQuestCountButton[showCount]:SetCheck(true)
    else
      UI.ASSERT_NAME(false, "PaGlobal_Quest_Option_All:setCurrentValue - latestQuestShowCount\234\176\128 \235\178\148\236\156\132\235\165\188 \235\178\151\236\150\180\235\130\172\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    end
  end
  for ii = 0, self._questWidgetType.Count - 1 do
    self._ui.questWidgetTypeButton[ii]:SetCheck(false)
  end
  local questWidgetType = ToClient_GetQuestWidgetType()
  if nil ~= questWidgetType then
    if questWidgetType >= self._questWidgetType.simple and questWidgetType < self._questWidgetType.Count then
      self._ui.questWidgetTypeButton[questWidgetType]:SetCheck(true)
    else
      UI.ASSERT_NAME(false, "PaGlobal_Quest_Option_All:setCurrentValue - questWidgetType\236\157\180 \235\178\148\236\156\132\235\165\188 \235\178\151\236\150\180\235\130\172\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    end
  end
end
function PaGlobal_Quest_Option_All:setPosition()
  self._ui.txt_sortTypeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_sortTypeDesc:setPadding(CppEnums.Padding.ePadding_Left, self._descPadding)
  self._ui.txt_sortTypeDesc:setPadding(CppEnums.Padding.ePadding_Right, self._descPadding)
  self._ui.txt_sortTypeDesc:setPadding(CppEnums.Padding.ePadding_Top, self._descPadding)
  self._ui.txt_sortTypeDesc:setPadding(CppEnums.Padding.ePadding_Bottom, self._descPadding)
  local favorDescText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTOPTIONE_DESC")
  self._ui.txt_sortTypeDesc:SetText(favorDescText)
  local descSizeY = self._ui.txt_sortTypeDesc:GetTextSizeY()
  self._ui.txt_sortTypeDesc:SetSize(self._ui.txt_sortTypeDesc:GetSizeX(), descSizeY + self._descPadding * 2)
  local diff = self._ui.txt_sortTypeDesc:GetSizeY() - self._defaultDescSizeY
  self._ui.stc_option_displayBG:SetSize(self._ui.stc_option_displayBG:GetSizeX(), self._defaultDisplayBGSizeY + diff)
  self._ui.stc_mainBG:SetSize(self._ui.stc_mainBG:GetSizeX(), self._defaultMainBGSizeY + diff)
  Panel_Window_Quest_Option_All:SetSize(Panel_Window_Quest_Option_All:GetSizeX(), self._defaultPanelSizeY + diff)
  Panel_Window_Quest_Option_All:ComputePos()
  self._ui.stc_option_sortBG:SetPosY(self._defaultSortBGStartPosY + diff)
  self._ui.stc_option_recentBG:SetPosY(self._defaultRecentBGStartPosY + diff)
  self._ui.btn_confirm:ComputePos()
  self._ui.btn_cancel:ComputePos()
end
function PaGlobal_Quest_Option_All:prepareOpen()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  Panel_Window_Quest_Option_All:SetIgnore(false)
  PaGlobal_Quest_Option_All:setPosition()
  PaGlobal_Quest_Option_All:setCurrentValue()
  PaGlobal_Quest_Option_All:open()
end
function PaGlobal_Quest_Option_All:open()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  Panel_Window_Quest_Option_All:SetShow(true)
end
function PaGlobal_Quest_Option_All:prepareClose()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  Panel_Window_Quest_Option_All:SetIgnore(true)
  PaGlobal_Quest_Option_All:close()
end
function PaGlobal_Quest_Option_All:close()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  Panel_Window_Quest_Option_All:SetShow(false)
end
function PaGlobal_Quest_Option_All:validate()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
end
function PaGlobal_Quest_Option_All:resize()
  if nil == Panel_Window_Quest_Option_All then
    return
  end
  Panel_Window_Quest_Option_All:ComputePosAllChild()
  self:setPosition()
end
function PaGlobal_Quest_Option_All:confirm()
  local QuestListInfo = ToClient_GetQuestList()
  if nil ~= QuestListInfo then
    for index = 0, self._favorType.Count - 1 do
      QuestListInfo:setQuestSelectType(index, self._ui.favorCheckBoxButton[index]:IsCheck())
    end
  end
  local favorIndex = 0
  local distanceIndex = 0
  local timeRecentIndex = 0
  for index = 0, self._sortState.Count - 1 do
    if self._ui.sortButton_Type[index]:IsCheck() then
      favorIndex = index
    end
    if self._ui.sortButton_Distance[index]:IsCheck() then
      distanceIndex = index
    end
    if self._ui.sortButton_TimeRecent[index]:IsCheck() then
      timeRecentIndex = index
    end
  end
  local favorValue = self:getRealValueFromUiIndex(self._sortType.Favor, favorIndex)
  local distanceValue = self:getRealValueFromUiIndex(self._sortType.Distance, distanceIndex)
  local timeRecentValue = self:getRealValueFromUiIndex(self._sortType.TimeRecent, timeRecentIndex)
  ToClient_SetCheckedQuestSort(favorValue, distanceValue, timeRecentValue)
  local showCount = self:getLatestQuestShowCount()
  ToClient_SetLatestQuestShowCount(showCount)
  local questWidgetType = self:getQuestWidgetType()
  ToClient_SetQuestWidgetType(questWidgetType)
  PaGlobal_Quest_Option_All_Close()
end
function PaGlobal_Quest_Option_All:setFavorButtonCheckAll()
  local isCheck = self._ui.favorCheckBoxButton[self._favorType.All]:IsCheck()
  for ii = 0, self._favorType.Count - 1 do
    self._ui.favorCheckBoxButton[ii]:SetCheck(isCheck)
  end
end
function PaGlobal_Quest_Option_All:updateFavorButton()
  local isAllCheck = true
  local isCheck = false
  for ii = 1, self._favorType.Count - 1 do
    isCheck = self._ui.favorCheckBoxButton[ii]:IsCheck()
    if false == isCheck then
      isAllCheck = false
    end
  end
  self._ui.favorCheckBoxButton[self._favorType.All]:SetCheck(isAllCheck)
end
function PaGlobal_Quest_Option_All:getLatestQuestShowCount()
  local showCount = 0
  for index = 0, self._latestQuestCount.Count - 1 do
    if nil ~= self._ui.latestQuestCountButton[index] and self._ui.latestQuestCountButton[index]:IsCheck() then
      showCount = index
      break
    end
  end
  return showCount
end
function PaGlobal_Quest_Option_All:getQuestWidgetType()
  local questWidgetType = CppEnums.QuestWidgetType.eQuestWidgetType_Simple
  for index = 0, self._questWidgetType.Count - 1 do
    if nil ~= self._ui.questWidgetTypeButton[index] and self._ui.questWidgetTypeButton[index]:IsCheck() then
      questWidgetType = index
      break
    end
  end
  return questWidgetType
end
function PaGlobal_Quest_Option_All:getRealValueFromUiIndex(sortType, index)
  if nil == index then
    return self._sortState.none
  end
  local table
  if self._sortType.Distance == sortType then
    table = self._sortTypeRealValue_Distance
  elseif self._sortType.TimeRecent == sortType then
    table = self._sortTypeRealValue_TimeRecent
  elseif self._sortType.Favor == sortType then
    table = self._sortTypeRealValue_Type
  end
  if nil == table then
    return self._sortState.none
  end
  if nil == table[index] then
    UI.ASSERT_NAME(false, "PaGlobal_Quest_Option_All:getRealValueFromUiIndex - index\234\176\128 \235\178\148\236\156\132\235\165\188 \235\178\151\236\150\180\235\130\172\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    return self._sortState.none
  end
  return table[index]
end
function PaGlobal_Quest_Option_All:getUiIndexFromRealValue(sortType, value)
  if nil == value then
    return self._defaultSortUiIndex
  end
  local table
  if self._sortType.Distance == sortType then
    table = self._sortTypeRealValue_Distance
  elseif self._sortType.TimeRecent == sortType then
    table = self._sortTypeRealValue_TimeRecent
  elseif self._sortType.Favor == sortType then
    table = self._sortTypeRealValue_Type
  end
  if nil == table then
    return self._defaultSortUiIndex
  end
  for index = 0, self._sortState.Count - 1 do
    if value == table[index] then
      return index
    end
  end
  UI.ASSERT_NAME(false, "PaGlobal_Quest_Option_All:getUiIndexFromRealValue - value\234\176\146\236\157\180 \235\178\148\236\156\132\235\165\188 \235\178\151\236\150\180\235\130\172\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
  return self._defaultSortUiIndex
end
