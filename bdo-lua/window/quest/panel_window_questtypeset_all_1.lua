function PaGlobal_QuestTypeSet_All:initialize()
  if true == PaGlobal_QuestTypeSet_All._initialize then
    return
  end
  PaGlobal_QuestTypeSet_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_QuestTypeSet_All:ControlAll_Init()
  PaGlobal_QuestTypeSet_All:registEventHandler()
  PaGlobal_QuestTypeSet_All:validate()
  PaGlobal_QuestTypeSet_All._initialize = true
end
function PaGlobal_QuestTypeSet_All:ControlAll_Init()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self._ui.stc_desc = UI.getChildControl(Panel_Window_QuestTypeSet_All, "StaticText_Desc")
  self._ui.stc_centerBg = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_CenterBg")
  self._ui.stc_deco = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_Deco")
  self._ui.stc_selectedTypeDesc = UI.getChildControl(Panel_Window_QuestTypeSet_All, "StaticText_SelectedTypeDesc")
  self._ui.stc_selectedTypeNameBg = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_SelectedTypeName")
  self._ui.txt_selectedTypeName = UI.getChildControl(self._ui.stc_selectedTypeNameBg, "StaticText_SelectedTypeTitle")
  local selectTypeGroupList = {
    [self._TYPE.STORY] = "Static_Deco_All",
    [self._TYPE.HUNT] = "Static_Battle",
    [self._TYPE.LIFE] = "Static_Life",
    [self._TYPE.FISH] = "Static_Fishing",
    [self._TYPE.ADV] = "Static_Trade",
    [self._TYPE.ETC] = "Static_ETC"
  }
  for ii = 0, self._TYPE.COUNT - 1 do
    self._questTypeGroup[ii] = {}
    self._questTypeGroup[ii].bg = UI.getChildControl(self._ui.stc_deco, selectTypeGroupList[ii])
    self._questTypeGroup[ii].slot = UI.getChildControl(self._questTypeGroup[ii].bg, "Static_SelectSlot")
    self._questTypeGroup[ii].icon = UI.getChildControl(self._questTypeGroup[ii].bg, "CheckButton_Icon")
    self._questTypeGroup[ii].check = UI.getChildControl(self._questTypeGroup[ii].bg, "CheckButton_1")
    self._questTypeGroup[ii].slot:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestTypeSet_All_CheckButton(" .. ii .. ")")
    self._questTypeGroup[ii].slot:addInputEvent("Mouse_On", "HandlePadEventOn_QuestTypeSet_All_ShowDescription(" .. ii .. ")")
  end
  self._ui.stc_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_desc:SetText(self._ui.stc_desc:GetText())
  self._ui.txt_selectedTypeName:SetText(__eTextMode_AutoWrap)
  self._ui.stc_selectedTypeDesc:SetTextMode(__eTextMode_AutoWrap)
  if true == self._isConsole then
    local QuestListInfo = ToClient_GetQuestList()
    local isOn = QuestListInfo:isQuestSelectType(self._TYPE.HUNT)
    if false == isOn then
      ToClient_ToggleQuestSelectType(self._TYPE.HUNT)
    end
  end
end
function PaGlobal_QuestTypeSet_All:prepareOpen()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  PaGlobalFunc_Quest_All_Close(false)
  PaGlobal_QuestTypeSet_All:update()
  PaGlobal_QuestTypeSet_All:open()
  PaGlobal_QuestTypeSet_All:resize()
end
function PaGlobal_QuestTypeSet_All:open()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  Panel_Window_QuestTypeSet_All:SetShow(true)
end
function PaGlobal_QuestTypeSet_All:prepareClose()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  PaGlobal_QuestTypeSet_All:close()
end
function PaGlobal_QuestTypeSet_All:close()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  Panel_Window_QuestTypeSet_All:SetShow(false)
end
function PaGlobal_QuestTypeSet_All:update()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self:favorTypeUpdate()
end
function PaGlobal_QuestTypeSet_All:registEventHandler()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  registerEvent("EventSelfPlayerLevelUp", "FromClient_Quest_All_LevelFifty_SetFavorType")
end
function PaGlobal_QuestTypeSet_All:validate()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self._ui.stc_desc:isValidate()
  self._ui.stc_centerBg:isValidate()
  self._ui.stc_deco:isValidate()
  self._ui.stc_selectedTypeDesc:isValidate()
  self._ui.stc_selectedTypeNameBg:isValidate()
  self._ui.txt_selectedTypeName:isValidate()
end
function PaGlobal_QuestTypeSet_All:resize()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
end
function PaGlobal_QuestTypeSet_All:favorTypeUpdate()
  local allButtonCheck = true
  local QuestListInfo = ToClient_GetQuestList()
  for ii = 1, self._TYPE.COUNT - 1 do
    local bChecked = QuestListInfo:isQuestSelectType(ii)
    self._questTypeGroup[ii].icon:SetCheck(bChecked)
    self._questTypeGroup[ii].check:SetCheck(bChecked)
    if false == bChecked then
      self._questTypeGroup[self._TYPE.STORY].icon:SetCheck(false)
      self._questTypeGroup[self._TYPE.STORY].check:SetCheck(false)
      allButtonCheck = false
    end
    if true == allButtonCheck then
      self._questTypeGroup[ii].icon:SetCheck(true)
      self._questTypeGroup[ii].check:SetCheck(true)
      self._questTypeGroup[self._TYPE.STORY].icon:SetCheck(true)
      self._questTypeGroup[self._TYPE.STORY].check:SetCheck(true)
    elseif true == bChecked then
      self._questTypeGroup[self._TYPE.STORY].icon:SetCheck(true)
      self._questTypeGroup[self._TYPE.STORY].check:SetCheck(true)
    else
      self._questTypeGroup[self._TYPE.STORY].icon:SetCheck(false)
      self._questTypeGroup[self._TYPE.STORY].check:SetCheck(false)
    end
  end
  self._questTypeGroup[self._TYPE.STORY].icon:SetCheck(allButtonCheck)
  self._questTypeGroup[self._TYPE.STORY].check:SetCheck(allButtonCheck)
end
function PaGlobal_QuestTypeSet_All:checkButtonAll()
  local isCheck = not self._questTypeGroup[self._TYPE.STORY].check:IsCheck()
  for ii = 1, self._TYPE.COUNT - 1 do
    if isCheck ~= self._questTypeGroup[ii].check:IsCheck() then
      ToClient_ToggleQuestSelectType(ii)
      self._questTypeGroup[ii].icon:SetCheck(isCheck)
      self._questTypeGroup[ii].check:SetCheck(isCheck)
    end
  end
end
