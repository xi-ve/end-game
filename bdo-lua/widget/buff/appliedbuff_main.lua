basicLoadUI("UI_Data/Widget/Buff/UI_BuffPanel.xml", "Panel_AppliedBuffList", Defines.UIGroup.PAGameUIGroup_MainUI)
PaGlobalAppliedBuffList = {
  _uiBackBuffList = {},
  _backListName = {
    [0] = "Static_Buff_BG",
    "Static_DeBuff_BG",
    "Static_TotalBuff_BG"
  },
  _styleListName = {
    [0] = "StaticText_Buff",
    "StaticText_deBuff",
    "StaticText_TotalBuff"
  },
  _iconListName = {
    [0] = "AppliedBuff_",
    "AppliedDeBuff_",
    "AppliedTotalBuff_"
  },
  _buffText = UI.getChildControl(Panel_AppliedBuffList, "StaticText_buffText"),
  _maxBuffCount = 20,
  _uiBuffList = {},
  _isShow = false,
  _initialized = false,
  _default_uiBackBuffPosX = 0,
  _sumCount = 0,
  _buffFuctionList = {}
}
local UI_TIMETOP = Util.Time.inGameTimeFormattingTop
function PaGlobalFunc_AppliedBuffList_ResetPosition()
  local scrX = getOriginScreenSizeX()
  local scrY = getOriginScreenSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  if relativePosX == -1 and relativePosY == -1 then
    local initPosX = scrX * 0.35
    local initPosY = scrY * 0.75
    local haveServerPosotion = 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
    if not haveServerPosotion then
      Panel_AppliedBuffList:SetPosX(initPosX)
      Panel_AppliedBuffList:SetPosY(initPosY)
    end
    changePositionBySever(Panel_AppliedBuffList, CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, true, true, false)
    FGlobal_InitPanelRelativePos(Panel_AppliedBuffList, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_AppliedBuffList:SetPosX(scrX * 0.35)
    Panel_AppliedBuffList:SetPosY(scrY * 0.75)
  else
    Panel_AppliedBuffList:SetRelativePosX(relativePosX)
    Panel_AppliedBuffList:SetRelativePosY(relativePosY)
    Panel_AppliedBuffList:SetPosX(getOriginScreenSizeX() * relativePosX - Panel_AppliedBuffList:GetSizeX() / 2)
    Panel_AppliedBuffList:SetPosY(getOriginScreenSizeY() * relativePosY - Panel_AppliedBuffList:GetSizeY() / 2)
  end
  if true == _ContentsGroup_RenewUI then
    local screenGapSizeY = (scrY - getScreenSizeY()) / 2
    Panel_AppliedBuffList:SetPosY(getScreenSizeY() * 0.82 + screenGapSizeY - 54)
  end
  if false == ToClient_isConsole() then
    local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if isShow < 0 then
      Panel_AppliedBuffList:SetShow(true)
    else
      _PA_SVC_LOG("\236\160\128\236\158\165\235\144\156 UI \237\142\184\236\167\145\236\160\149\235\179\180\235\161\156 \235\178\132\237\148\132\236\176\189 \235\133\184\236\182\156\236\157\132 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.")
      ToClient_LuaDebugCallStack()
      Panel_AppliedBuffList:SetShow(isShow)
    end
  else
    Panel_AppliedBuffList:SetShow(true)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_AppliedBuffList)
end
function PaGlobalAppliedBuffList:initialize()
  for i = __eBuffDisplayType_Buff, __eBuffDisplayType_ShortBuff do
    if nil == self._uiBackBuffList[i] then
      self._uiBackBuffList[i] = UI.getChildControl(Panel_AppliedBuffList, self._backListName[i])
      self._uiBackBuffList[i]:SetShow(false)
      self._uiBackBuffList[i]:SetIgnore(true)
    end
    local styleBuffIcon = UI.getChildControl(Panel_AppliedBuffList, self._styleListName[i])
    local iconSpan = styleBuffIcon:GetSizeX() + 1
    styleBuffIcon:SetShow(false)
    if nil == self._uiBuffList[i] then
      self._uiBuffList[i] = {}
    end
    for index = 1, self._maxBuffCount do
      local buffIcon = UI.createControl(__ePAUIControl_StaticText, Panel_AppliedBuffList, self._iconListName[i] .. index)
      CopyBaseProperty(styleBuffIcon, buffIcon)
      buffIcon:SetPosX(self._uiBackBuffList[i]:GetPosX() + iconSpan * (index - 1) + 2)
      buffIcon:SetPosY(self._uiBackBuffList[i]:GetPosY() + 2)
      buffIcon:SetShow(false)
      buffIcon:SetIgnore(false)
      buffIcon:addInputEvent("Mouse_On", "HandleMOnAppliedBuff(" .. index .. ", " .. i .. ")")
      buffIcon:addInputEvent("Mouse_Out", "HandleMOffAppliedBuff(" .. index .. ", " .. i .. ")")
      self._uiBuffList[i][index] = buffIcon
    end
  end
  self._default_uiBackBuffPosX = self._uiBackBuffList[__eBuffDisplayType_Buff]:GetPosX() + 50
  Panel_AppliedBuffList:addInputEvent("Mouse_On", "HandleMOnAppliedBuffPenel()")
  Panel_AppliedBuffList:addInputEvent("Mouse_Out", "HandleMOutAppliedBuffPenel()")
  Panel_AppliedBuffList:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
  self._initialized = true
  ResponseBuff_changeBuffList()
  self:buffEffectListInit()
end
function PaGlobalAppliedBuffList:buffEffectListInit()
  PaGlobalAppliedBuffList._buffFuctionList = {
    GuardianBuffEffectStart = {
      excuteFunction = GuardianBuffEffectStart,
      remainTime = toInt64(0, 0),
      functionKey = nil
    }
  }
end
function PaGlobalAppliedBuffList:setMovableUIForControlMode()
  self._buffText:SetShow(false)
  Panel_AppliedBuffList:SetIgnore(false)
  Panel_AppliedBuffList:SetDragEnable(true)
  Panel_AppliedBuffList:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/window_sample_isWidget.dds")
end
function PaGlobalAppliedBuffList:cancelMovableUIForControlMode()
  self._buffText:SetShow(false)
  Panel_AppliedBuffList:SetDragEnable(false)
  Panel_AppliedBuffList:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/window_sample_empty.dds")
end
function PaGlobalAppliedBuffList:changeOnOffTexture(isOn)
  if true == isOn then
    if Panel_UIControl:IsShow() then
      Panel_AppliedBuffList:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_drag.dds")
      self._buffText:SetText(PAGetString(Defines.StringSheet_GAME, "BUFF_LIST_MOVE"))
    end
  elseif Panel_UIControl:IsShow() then
    Panel_AppliedBuffList:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_isWidget.dds")
    self._buffText:SetText(PAGetString(Defines.StringSheet_GAME, "BUFF_LIST"))
  else
    Panel_AppliedBuffList:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function PaGlobalAppliedBuffList:show()
  PaGlobalFunc_AppliedBuffList_ResetPosition()
end
function PaGlobalAppliedBuffList:hide()
  _PA_SVC_LOG("\235\178\132\237\148\132\236\176\189\236\157\180 \236\130\172\235\157\188\236\167\145\235\139\136\235\139\164")
  ToClient_LuaDebugCallStack()
  Panel_AppliedBuffList:SetShow(false, false)
end
function HandleMOnAppliedBuffPenel()
  AppliedBuffList:changeOnOffTexture(true)
end
function HandleMOutAppliedBuffPenel()
  AppliedBuffList:changeOnOffTexture(false)
end
function HandleMOnAppliedBuff(buffIndex, isDebuff)
  ShowBuffTooltip(buffIndex, isDebuff)
end
function HandleMOffAppliedBuff(buffIndex, isDebuff)
  HideBuffTooltip(buffIndex, isDebuff)
end
function renderModeChange_FromClient_AppliedBuffList_ResetPosition(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  PaGlobalFunc_AppliedBuffList_ResetPosition()
end
function FromClient_AppliedBuffList_luaLoadComplete()
  PaGlobalAppliedBuffList:initialize()
end
registerEvent("onScreenResize", "PaGlobalFunc_AppliedBuffList_ResetPosition")
registerEvent("FromClient_ApplyUISettingPanelInfo", "PaGlobalFunc_AppliedBuffList_ResetPosition")
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_FromClient_AppliedBuffList_ResetPosition")
registerEvent("FromClient_luaLoadComplete", "FromClient_AppliedBuffList_luaLoadComplete")
