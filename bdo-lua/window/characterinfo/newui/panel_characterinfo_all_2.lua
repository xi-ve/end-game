function PaGlobalFunc_ChracterInfo_All_Open(isPresent)
  if true == Panel_CharacterInfo_All:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  audioPostEvent_SystemUi(1, 31)
  _AudioPostEvent_SystemUiForXBOX(1, 31)
  PaGlobal_CharInfo_All:prepareOpen()
  if false == isPresent or nil == isPresent then
    PaGlobal_CharInfo_All:showServantInfo()
  end
end
function HandleEventLUp_ChracterInfo_All_Close()
  if false == Panel_CharacterInfo_All:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_CharInfo_All:prepareClose()
end
function HandleEventLUp_ChracterInfo_All_CloseAll()
  if false == Panel_CharacterInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_ServantInfo_All and nil ~= Panel_Window_VehicleInfo_All and true == PaGlobal_VehicleInfo_All_GetPanelShow() then
    PaGlobal_VehicleInfo_All_Close()
  end
  if true == _ContentsGroup_OceanCurrent and nil ~= Panel_Window_ShipInfo_All and true == PaGlobal_ShipInfo_All_GetShowPanel() then
    PaGlobal_ShipInfo_All_Close()
  end
  if false == _ContentsGroup_NewUI_ServantInfo_All and false == _ContentsGroup_OceanCurrent and nil ~= Panel_Window_ServantInfo and nil ~= Panel_CarriageInfo and nil ~= Panel_ShipInfo and (Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow()) then
    ServantInfo_Close()
    CarriageInfo_Close()
    ShipInfo_Close()
  end
  InventoryWindow_Close()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_CharInfo_All:prepareClose()
end
function PaGlobalFunc_ChracterInfo_All_Close()
  if false == Panel_CharacterInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_NewUI_ServantInfo_All and nil ~= Panel_Window_VehicleInfo_All and true == PaGlobal_VehicleInfo_All_GetPanelShow() then
    PaGlobal_VehicleInfo_All_Close()
    return
  end
  if true == _ContentsGroup_OceanCurrent and nil ~= Panel_Window_ShipInfo_All and true == PaGlobal_ShipInfo_All_GetShowPanel() then
    PaGlobal_ShipInfo_All_Close()
    return
  end
  if false == _ContentsGroup_NewUI_ServantInfo_All and false == _ContentsGroup_OceanCurrent and nil ~= Panel_Window_ServantInfo and nil ~= Panel_CarriageInfo and nil ~= Panel_ShipInfo and (Panel_Window_ServantInfo:GetShow() or Panel_CarriageInfo:GetShow() or Panel_ShipInfo:GetShow()) then
    ServantInfo_Close()
    CarriageInfo_Close()
    ShipInfo_Close()
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_CharInfo_All:prepareClose()
end
function HandleEventPadPress_CharacterInfo_All_ClickOtherTab_Console(isUp)
  local currentIdx = PaGlobal_CharInfo_All._consoleIdx
  local tempIdx = currentIdx
  if true == isUp then
    tempIdx = tempIdx + 1
    if tempIdx > #PaGlobal_CharInfo_All._consoleBtnTable then
      tempIdx = 0
    end
  else
    tempIdx = tempIdx - 1
    if tempIdx < 0 then
      tempIdx = #PaGlobal_CharInfo_All._consoleBtnTable
    end
  end
  TooltipSimple_Hide()
  HandleEventPadPress_CharInfoBasic_All_ShowTooltip()
  if true == PaGlobalFunc_CharInfoChallenge_All_GetConsoleTooltipShow() then
    PaGlobalFunc_CharInfoChallenge_All_HideConsoleTooltipShow()
  end
  HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._consoleBtnTable[tempIdx])
end
function HandleEventLUp_ChracterInfo_All_ClickOtherTab(idx)
  UI.ASSERT_NAME(nil ~= PaGlobal_CharInfo_All._tabData[idx], "Panel_CharacterInfo_All.lua / self._tabData[idx] is nil ", "\234\185\128\234\183\188\236\154\176")
  if nil == idx then
    return
  end
  PaGlobal_CharInfo_All._checkLPress = false
  PaGlobal_CharInfo_All:otherTabOpen(idx)
end
function HandleEventOnOut_ChracterInfo_All_TabBtn_Tooltip(idx)
  if nil == idx or true == PaGlobal_CharInfo_All._isConsole then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfo_All._ui.rdo_tabTable[idx] then
    return
  end
  local control, name, desc
  control = PaGlobal_CharInfo_All._ui.rdo_tabTable[idx]
  name = PAGetString(Defines.StringSheet_RESOURCE, PaGlobal_CharInfo_All._TABSTRING[idx])
  TooltipSimple_Show(control, name, dsec)
end
function PaGlobalFunc_ChracterInfo_All_OnScreenResize()
  if false == Panel_CharacterInfo_All:GetShow() then
    return
  end
  Panel_CharacterInfo_All:ComputePos()
end
function PaGlobalFunc_ChracterInfo_All_MoveTooltipToPanel()
  local _panel = Panel_CharacterInfo_All
  local tooltipPanel = Panel_Tooltip_SimpleText
  local tooltipSizeX = tooltipPanel:GetSizeX()
  local tooltipSizeY = tooltipPanel:GetSizeY()
  local isGapX = getScreenSizeX() - (_panel:GetPosX() + _panel:GetSizeX() + tooltipSizeX) > 0
  local isGapY = getScreenSizeY() - (_panel:GetPosY() + tooltipSizeY)
  local posX = 0
  local posY = 0
  if true == isGapX then
    posX = _panel:GetPosX() + _panel:GetSizeX()
  else
    posX = _panel:GetPosX() - tooltipSizeX
  end
  if 0 < isGapY then
    if 0 > _panel:GetPosY() then
      posY = math.abs(_panel:GetPosY())
    else
      posY = _panel:GetPosY()
    end
  else
    posY = _panel:GetPosY() + isGapY
  end
  TooltipSimple_Common_Pos(posX, posY)
end
function HandleEventLUp_ChracterInfo_All_PopUpUI()
  PaGlobal_CharInfo_All._ui.btn_Resize:SetShow(Panel_CharacterInfo_All:IsUISubApp())
  if false == Panel_CharacterInfo_All:IsUISubApp() then
    Panel_CharacterInfo_All:OpenUISubApp()
  else
    Panel_CharacterInfo_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_ChracterInfo_All_PopUpUI_Tooltip(isShow)
  if false == isShow or nil == type then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  if false == Panel_CharacterInfo_All:IsUISubApp() then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  end
  control = PaGlobal_CharInfo_All._ui.btn_StickerUI
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_ChracterInfo_All_GetBgShow(idx)
  if false == Panel_CharacterInfo_All:GetShow() or nil == PaGlobal_CharInfo_All._tabData[idx] then
    return false
  end
  if nil ~= PaGlobal_CharInfo_All._tabData[idx].bg then
    return PaGlobal_CharInfo_All._tabData[idx].bg:GetShow()
  else
    UI.ASSERT_NAME(nil ~= PaGlobal_CharInfo_All._tabData[idx].bg, "Panel_CharacterInfo_All.lua / PaGlobal_CharInfo_All._tabData[idx].bg[" .. idx .. "] is nil ", "\234\185\128\234\183\188\236\154\176")
  end
end
function HandleEventLUp_ChracterInfo_All_ScaleResizeLDown()
  PaGlobal_CharInfo_All._panelOriPosY = Panel_CharacterInfo_All:GetPosY()
  PaGlobal_CharInfo_All._panelOriPosX = Panel_CharacterInfo_All:GetPosX()
  UI.PanelDynamicSacle_ResizeStart(Panel_CharacterInfo_All)
  PaGlobal_CharInfo_All._checkLPress = true
end
function HandleEventLUp_ChracterInfo_All_ScaleResizeLPress()
  UI.PanelDynamicSacle_ResizePressing(Panel_CharacterInfo_All)
  ClearFocusEdit()
  TooltipSimple_Hide()
  Panel_CharacterInfo_All:SetPosY(PaGlobal_CharInfo_All._panelOriPosY)
  Panel_CharacterInfo_All:SetPosX(PaGlobal_CharInfo_All._panelOriPosX)
  local curBtn = PaGlobal_CharInfo_All._tabData[PaGlobal_CharInfo_All._currentTabIdx].btn
  local selectLinePosX = curBtn:GetSpanSize().x - (curBtn:GetSizeX() * 0.5 + 5 * curBtn:GetScale().x)
  PaGlobal_CharInfo_All._ui.stc_selectLine:SetSpanSize(selectLinePosX, PaGlobal_CharInfo_All._ui.stc_selectLine:GetSpanSize().y)
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._basic) then
    local currentIdx = PaGlobal_CharInfoBasic_All._currentTab
    local selectLine = PaGlobal_CharInfoBasic_All._ui.stc_TabSelectBar
    local currentRdo = PaGlobal_CharInfoBasic_All._ui.rdo_BattleInfo
    if 1 == currentIdx then
      currentRdo = PaGlobal_CharInfoBasic_All._ui.rdo_LifeInfo
    end
    selectLine:SetSpanSize(currentRdo:GetSpanSize().x, selectLine:GetSpanSize().y)
    selectLine:ComputePos()
  end
  if true == _ContentsGroup_FamilySkill and true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._familySkill) then
    PaGlobal_CharInfoFamilySkill_All._ui.stc_Frame_VertiScroll:SetControlTop()
    PaGlobal_CharInfoFamilySkill_All._ui.stc_FrameBg:UpdateContentScroll()
    PaGlobal_CharInfoFamilySkill_All._ui.stc_FrameBg:UpdateContentPos()
  end
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._title) then
    local currentIdx = PaGlobal_CharInfoTitle_All._currentTab
    local selectLine = PaGlobal_CharInfoTitle_All._ui.stc_SelectBar
    selectLine:SetSpanSize(PaGlobal_CharInfoTitle_All._ui.rdo_tabTable[currentIdx]:GetSpanSize().x, selectLine:GetSpanSize().y)
    PaGlobal_CharInfoTitle_All._ui.stc_SelectBar:ComputePos()
    PaGlobal_CharInfoTitle_All:update()
  end
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
    local currentIdx = PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx
    local selectLine = PaGlobal_CharInfoChallenge_All._ui.stc_selectLine
    selectLine:SetSpanSize(PaGlobal_CharInfoChallenge_All._ui.rdo_Table[currentIdx]:GetSpanSize().x, selectLine:GetSpanSize().y)
    selectLine:ComputePos()
    local ctrlpos = PaGlobalFunc_CharInfoChallenge_All_GetCtrlPos()
    if 1 <= ctrlpos then
      ctrlpos = 1
      PaGlobal_CharInfoChallenge_All._ui.stc_Scroll:SetControlPos(ctrlpos)
    end
    PaGlobal_CharInfoChallenge_All:update()
  end
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._history) then
    local currentIdx = PaGlobal_CharInfoHistory_All._currentidx
    local selectLine = PaGlobal_CharInfoHistory_All._ui.stc_SelectLine
    selectLine:SetSpanSize(PaGlobal_CharInfoHistory_All._ui.rdo_MonthTable[currentIdx]:GetSpanSize().x, selectLine:GetSpanSize().y)
    selectLine:ComputePos()
    PaGlobal_CharInfoHistory_All:updateFrame()
  end
  if true == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._footPrint) then
    local currentIdx = PaGlobal_CharInfoFootPrint_All._currentTabIdx
    local selectLine = PaGlobal_CharInfoFootPrint_All._ui.stc_selectLine
    selectLine:SetSpanSize(PaGlobal_CharInfoFootPrint_All._ui.btn_RadioTable[currentIdx]:GetSpanSize().x, PaGlobal_CharInfoFootPrint_All._ui.stc_selectLine:GetSpanSize().y)
    selectLine:ComputePos()
  end
end
function HandleEventLUp_ChracterInfo_All_ScaleResizeLUp()
  UI.PanelDynamicSacle_ResizeEnd(Panel_CharacterInfo_All)
  PaGlobal_CharInfo_All._checkLPress = false
end
function PaGlobal_ChracterInfo_All_GetLPress()
  return PaGlobal_CharInfo_All._checkLPress
end
function PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console(idx)
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobal_CharInfo_All._ui.stc_tooltip:SetShow(false)
  if nil == idx or true == Panel_Widget_Tooltip_Renew:GetShow() then
    return
  end
  PaGlobal_CharInfoChallenge_All._consoleUIIdx = idx
  local name, desc = "", ""
  PaGlobal_CharInfo_All._ui.stc_tooltip:ComputePos()
  if nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable or nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx] then
    return
  end
  if false == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._title:IsLimitText() and false == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._desc:IsLimitText() then
    return
  end
  name = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._title:GetText()
  desc = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._desc:GetText()
  if name == "" and desc == "" then
    return
  end
  local panelY = Panel_CharacterInfo_All:GetPosY() + PaGlobal_CharInfoChallenge_All._ui.stc_challBg:GetPosY()
  local tempY = panelY + PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._bg:GetPosY() + 10
  PaGlobal_CharInfo_All._ui.stc_tooltip:SetShow(true)
  PaGlobal_CharInfo_All._ui.txt_tooltip:SetText(name .. [[


]] .. desc)
  local minX = math.min(PaGlobal_CharInfo_All._ui.txt_tooltip:GetTextSizeX() + 10, 485)
  PaGlobal_CharInfo_All._ui.stc_tooltip:SetSize(minX + 15, PaGlobal_CharInfo_All._ui.txt_tooltip:GetTextSizeY() + 15)
  PaGlobal_CharInfo_All._ui.txt_tooltip:SetSize(minX - 10, PaGlobal_CharInfo_All._ui.stc_tooltip:GetSizeY() - 10)
  PaGlobal_CharInfo_All._ui.txt_tooltip:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_CharInfo_All._ui.txt_tooltip:SetText(PaGlobal_CharInfo_All._ui.txt_tooltip:GetText())
  PaGlobal_CharInfo_All._ui.txt_tooltip:ComputePos()
  local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
  local uiOffsetY = getOriginScreenSizeY() * getConsoleUIOffset
  PaGlobal_CharInfo_All._ui.stc_tooltip:SetPosY(tempY - uiOffsetY)
end
function PaGlobal_CharInfo_All_SetConsoleSimpleTooltip(title, desc)
  if false == PaGlobal_CharInfo_All._isConsole then
    return
  end
  if nil == title and nil == desc then
    return
  end
  PaGlobal_CharInfo_All._ui.txt_SimpleTooltipTitle:SetText(title)
  PaGlobal_CharInfo_All._ui.txt_SimpleTooltipDesc:SetText(desc)
end
function PaGlobal_CharInfo_All_SetConsoleDescShow(show)
  if false == PaGlobal_CharInfo_All._isConsole then
    return
  end
  local sizeY = PaGlobal_CharInfo_All._ui.txt_SimpleTooltipTitle:GetSizeY() + PaGlobal_CharInfo_All._ui.txt_SimpleTooltipDesc:GetTextSizeY() + 20
  PaGlobal_CharInfo_All._ui.stc_SimpleTooltipBg:SetSize(PaGlobal_CharInfo_All._ui.stc_SimpleTooltipBg:GetSizeX(), sizeY)
  PaGlobal_CharInfo_All._ui.stc_SimpleTooltipBg:ComputePos()
  PaGlobal_CharInfo_All._ui.stc_SimpleTooltipBg:SetShow(show)
  if false == show then
    Panel_CharacterInfo_All:SetSpanSize(0, Panel_CharacterInfo_All:GetSpanSize().y)
    Panel_CharacterInfo_All:ComputePos()
  else
    Panel_CharacterInfo_All:SetSpanSize(-200, Panel_CharacterInfo_All:GetSpanSize().y)
  end
end
function PaGlobal_CharInfo_All_GetConsoleDescShow()
  if false == PaGlobal_CharInfo_All._isConsole then
    return false
  end
  return PaGlobal_CharInfo_All._ui.stc_SimpleTooltipBg:GetShow()
end
