PaGlobal_CharacterInfo = {
  _tabButton = {
    _basic = 0,
    _title = 1,
    _history = 2,
    _challenge = 3,
    _profile = 4,
    _life = 5,
    _familySkill = 6,
    _loopCount = 6
  },
  _panel = {
    [0] = nil,
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
    [6] = nil
  },
  _ui = {
    _staticDefaultBG = {},
    _radioButton = {},
    _txt_tabTitle = {},
    _checkButtonPopUp = nil,
    _buttonQuestion = nil,
    _buttonClose = nil
  },
  _isProfileOpen = ToClient_IsContentsGroupOpen("271"),
  _defaultTabSizeX = 0,
  _defaultTabStartSpanX = 0,
  _tabSizeOffset = 5,
  _savePos = float2(0, 0),
  _isResize = true,
  _radioButtonText = {},
  _isInitialize = false
}
function PaGlobal_CharacterInfo:showAni()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  local aniInfo1 = Panel_Window_CharInfo_Status:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_CharInfo_Status:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_CharInfo_Status:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_CharInfo_Status:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_CharInfo_Status:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_CharInfo_Status:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_CharacterInfo:hideAni()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  UIAni.closeAni(Panel_Window_CharInfo_Status)
end
function PaGlobal_CharacterInfo:initialize()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  PaGlobal_CharacterInfo:repositionTabButton()
  PaGlobal_CharacterInfo._panel[self._tabButton._basic] = Panel_Window_CharInfo_BasicStatus
  PaGlobal_CharacterInfo._panel[self._tabButton._title] = Panel_Window_CharInfo_TitleInfo
  PaGlobal_CharacterInfo._panel[self._tabButton._history] = Panel_Window_CharInfo_HistoryInfo
  PaGlobal_CharacterInfo._panel[self._tabButton._challenge] = Panel_Window_Challenge
  PaGlobal_CharacterInfo._panel[self._tabButton._profile] = Panel_Window_Profile
  PaGlobal_CharacterInfo._panel[self._tabButton._life] = Panel_Window_CharInfo_LifeInfo
  PaGlobal_CharacterInfo._panel[self._tabButton._familySkill] = Panel_Window_FamilySkill_Main
  Panel_Window_CharInfo_Status:SetShow(false)
  Panel_Window_CharInfo_Status:setMaskingChild(true)
  Panel_Window_CharInfo_Status:setGlassBackground(true)
  Panel_Window_CharInfo_Status:SetDragEnable(true)
  Panel_Window_CharInfo_Status:ActiveMouseEventEffect(true)
  self._ui._checkButtonPopUp = UI.getChildControl(Panel_Window_CharInfo_Status, "CheckButton_PopUp")
  self._ui._buttonQuestion = UI.getChildControl(Panel_Window_CharInfo_Status, "Button_Question")
  self._ui._buttonClose = UI.getChildControl(Panel_Window_CharInfo_Status, "Button_Close")
  for key, index in pairs(self._tabButton) do
    self._ui._staticDefaultBG[index] = UI.getChildControl(Panel_Window_CharInfo_Status, "Static_DefaultBG" .. index)
    if true == _ContentsGroup_FamilySkill then
      local beforeTab = UI.getChildControl(Panel_Window_CharInfo_Status, "RadioButton_Tab" .. index)
      beforeTab:SetShow(false)
      beforeTab:SetIgnore(true)
      self._ui._radioButton[index] = UI.getChildControl(Panel_Window_CharInfo_Status, "RadioButton_IconTab" .. index)
      self._ui._txt_tabTitle[index] = UI.getChildControl(self._ui._radioButton[index], "StaticText_TitleName")
      self._ui._txt_tabTitle[index]:SetText(self._radioButtonText[index])
      self._ui._txt_tabTitle[index]:SetSize(self._ui._txt_tabTitle[index]:GetTextSizeX(), self._ui._txt_tabTitle[index]:GetSizeY())
      self._ui._txt_tabTitle[index]:SetShow(false)
      self._ui._radioButton[index]:SetShow(true)
    else
      self._ui._radioButton[index] = UI.getChildControl(Panel_Window_CharInfo_Status, "RadioButton_Tab" .. index)
    end
    self._panel[index]:SetShow(false)
    self._ui._staticDefaultBG[index]:MoveChilds(self._ui._staticDefaultBG[index]:GetID(), self._panel[index])
  end
  self._defaultTabSizeX = self._ui._radioButton[0]:GetSizeX()
  self._defaultTabStartSpanX = self._ui._radioButton[0]:GetSpanSize().x
  self._ui._radioButton[self._tabButton._profile]:SetShow(self._isProfileOpen)
  self._ui._radioButton[self._tabButton._life]:SetShow(_ContentsGroup_EnhanceCollect)
  if false == _ContentsGroup_FamilySkill then
    local familySkillIndex = self._tabButton._familySkill
    self._ui._staticDefaultBG[familySkillIndex]:SetShow(false)
    self._ui._radioButton[familySkillIndex]:SetShow(false)
    self._ui._radioButton[familySkillIndex]:SetIgnore(true)
  end
  PaGlobal_CharacterInfo:registEventHandler()
  PaGlobal_SeasonTexture_SetPanel(Panel_Window_CharInfo_Status)
  if PaGlobal_CharacterInfo._isResize then
    FromClient_UI_CharacterInfo_Basic_ScreenResize()
  else
    Panel_Window_CharInfo_Status:SetPosX(PaGlobal_CharacterInfo._savePos.x)
    Panel_Window_CharInfo_Status:SetPosY(PaGlobal_CharacterInfo._savePos.y)
  end
  self._isInitialize = true
end
function PaGlobal_CharacterInfo:registEventHandler()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  Panel_Window_CharInfo_Status:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "PaGlobal_CharacterInfo:hideWindow()")
  Panel_Window_CharInfo_Status:RegisterShowEventFunc(true, "PaGlobal_CharacterInfo:showAni()")
  Panel_Window_CharInfo_Status:RegisterShowEventFunc(false, "PaGlobal_CharacterInfo:hideAni()")
  for key, index in pairs(self._tabButton) do
    self._ui._radioButton[index]:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:showWindow(" .. index .. ")")
    self._ui._radioButton[index]:addInputEvent("Mouse_On", "PaGlobal_CharacterInfo_TabTooltip(true, " .. index .. ")")
    self._ui._radioButton[index]:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfo_TabTooltip(false" .. index .. ")")
  end
  self._ui._checkButtonPopUp:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:handleClicked_PopUp()")
  self._ui._checkButtonPopUp:addInputEvent("Mouse_On", "PaGlobal_CharacterInfo:popUpToolTip( true )")
  self._ui._checkButtonPopUp:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfo:popUpToolTip( false )")
  self._ui._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SelfCharacterInfo\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui._buttonQuestion, "\"SelfCharacterInfo\"")
  self._ui._buttonClose:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo:hideWindow()")
end
function PaGlobal_CharacterInfo:showWindow(index)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil == index then
    index = 0
  end
  PaGlobal_CharacterInfoPanel_SetShowPanelStatus(true, true)
  for key, tab in pairs(self._tabButton) do
    self._ui._staticDefaultBG[tab]:SetShow(false)
    self._ui._radioButton[tab]:SetCheck(false)
  end
  self._ui._staticDefaultBG[index]:SetShow(true)
  self._ui._radioButton[index]:SetCheck(true)
  if self._tabButton._basic == index then
    PaGlobal_CharacterInfoBasic:showWindow()
  elseif self._tabButton._title == index then
    PaGlobal_CharacterInfoTitle:showWindow()
  elseif self._tabButton._history == index then
    MyHistory_DataUpdate()
  elseif self._tabButton._challenge == index then
    Fglobal_Challenge_UpdateData()
  elseif self._tabButton._profile == index then
    FGlobal_Profile_Update()
  elseif self._tabButton._life == index then
    FromClient_UI_CharacterInfo_Basic_LifeLevelChangeNew()
  elseif self._tabButton._familySkill == index and true == _ContentsGroup_FamilySkill then
    PaGlobal_Window_FamilySkill_Main:showWindow()
  end
  self:updateTabButton()
end
function PaGlobal_CharacterInfo:hideWindow()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  audioPostEvent_SystemUi(1, 1)
  PaGlobal_CharacterInfoPanel_SetShowPanelStatus(false, false)
  PaGlobal_CharacterInfoBasic:hideWindow()
  UI.ClearFocusEdit()
  Panel_Window_CharInfo_Status:CloseUISubApp()
  self._ui._checkButtonPopUp:SetCheck(false)
  HelpMessageQuestion_Out()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_CharacterInfo:handleClicked_PopUp()
  if nil == Panel_Window_CharInfo_Status then
    return
  end
  if self._ui._checkButtonPopUp:IsCheck() then
    Panel_Window_CharInfo_Status:OpenUISubApp()
  else
    Panel_Window_CharInfo_Status:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function PaGlobal_CharacterInfo:popUpToolTip(isShow)
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if self._ui._checkButtonPopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(self._ui._checkButtonPopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_CharacterInfo:updateTabButton()
  if false == _ContentsGroup_FamilySkill then
    return
  end
  local sizeX = 0
  local posX = self._defaultTabStartSpanX
  local radioButton
  for index = 0, self._tabButton._loopCount do
    radioButton = self._ui._radioButton[index]
    if true == radioButton:IsCheck() then
      sizeX = self._defaultTabSizeX + self._ui._txt_tabTitle[index]:GetTextSizeX() + 10
      self._ui._txt_tabTitle[index]:SetShow(true)
    else
      sizeX = self._defaultTabSizeX
      self._ui._txt_tabTitle[index]:SetShow(false)
    end
    radioButton:SetSize(sizeX, radioButton:GetSizeY())
    radioButton:SetSpanSize(posX, radioButton:GetSpanSize().y)
    radioButton:ComputePos()
    self._ui._txt_tabTitle[index]:ComputePos()
    local icon = UI.getChildControl(radioButton, "Static_IconImage")
    icon:ComputePos()
    posX = posX + sizeX + self._tabSizeOffset
  end
end
function PaGlobal_CharacterInfo:repositionTabButton()
  if true == _ContentsGroup_FamilySkill then
    self._tabButton._basic = 0
    self._tabButton._familySkill = 1
    self._tabButton._title = 2
    self._tabButton._history = 3
    self._tabButton._challenge = 4
    self._tabButton._profile = 5
    self._tabButton._life = 6
  end
  self._radioButtonText[self._tabButton._basic] = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_CHARACTERINFO_TAB_INFO")
  self._radioButtonText[self._tabButton._familySkill] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CHARACTERINFO_TAB_EDANA")
  self._radioButtonText[self._tabButton._title] = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_CHARACTERINFO_TAB_TITLE")
  self._radioButtonText[self._tabButton._history] = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_CHARACTERINFO_TAB_HISTORY")
  self._radioButtonText[self._tabButton._challenge] = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_CHARACTERINFO_TAB_CHALLENGE")
  self._radioButtonText[self._tabButton._profile] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERINFO_ACHIVEMENTTITLE")
  self._radioButtonText[self._tabButton._life] = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_SUBTITLE_CRAFT")
end
function FromClient_CharacterInfo_Init()
  PaGlobal_CharacterInfo_Initialize()
end
function PaGlobal_CharacterInfo_Initialize()
  PaGlobal_CharacterInfo:initialize()
end
function PaGlobal_CharacterInfo_SavePos()
  PaGlobal_CharacterInfo._savePos = float2(Panel_Window_CharInfo_Status:GetPosX(), Panel_Window_CharInfo_Status:GetPosY())
end
function PaGlobal_CharacterInfo_GetBasicIdx()
  if false == PaGlobal_CharacterInfo._isInitialize then
    PaGlobal_CharacterInfo:repositionTabButton()
  end
  return PaGlobal_CharacterInfo._tabButton._basic
end
function PaGlobal_CharacterInfo_GetChallengeIdx()
  if false == PaGlobal_CharacterInfo._isInitialize then
    PaGlobal_CharacterInfo:repositionTabButton()
  end
  return PaGlobal_CharacterInfo._tabButton._challenge
end
function PaGlobal_CharacterInfo_GetLifeIdx()
  if false == PaGlobal_CharacterInfo._isInitialize then
    PaGlobal_CharacterInfo:repositionTabButton()
  end
  return PaGlobal_CharacterInfo._tabButton._life
end
function PaGlobal_CharacterInfo_TabTooltip(isShow, tabIndex)
  if true == isShow then
    local content = PaGlobal_CharacterInfo._ui._radioButton[tabIndex]
    local skillName = PaGlobal_CharacterInfo._radioButtonText[tabIndex]
    TooltipSimple_Show(content, skillName, nil)
  else
    TooltipSimple_Hide()
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterInfo_Init")
