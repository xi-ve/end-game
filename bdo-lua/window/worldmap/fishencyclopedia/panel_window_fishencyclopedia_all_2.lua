function PaGlobalFunc_FishEncyclopedia_All_Open()
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  PaGlobal_FishEncyclopedia_All:prepareOpen()
end
function PaGlobalFunc_FishEncyclopedia_All_Close()
  if nil == Panel_Window_FishEncyclopedia_All or false == Panel_Window_FishEncyclopedia_All:GetShow() then
    return
  end
  PaGlobal_FishEncyclopedia_All:prepareClose()
end
function PaGlobalFunc_FishEncyclopedia_All_MoveTapByPad(isLeft)
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  if true == isLeft then
    if 1 < PaGlobal_FishEncyclopedia_All._selectedTab then
      PaGlobal_FishEncyclopedia_All._selectedTab = PaGlobal_FishEncyclopedia_All._selectedTab - 1
    end
  elseif PaGlobal_FishEncyclopedia_All._maxTabCount > PaGlobal_FishEncyclopedia_All._selectedTab then
    PaGlobal_FishEncyclopedia_All._selectedTab = PaGlobal_FishEncyclopedia_All._selectedTab + 1
  end
  HandleEventLUp_FishEncyclopedia_All_SelectTab(PaGlobal_FishEncyclopedia_All._selectedTab)
end
function FromClient_FishEncyclopedia_All_OnScreenSize()
  if nil == Panel_Window_FishEncyclopedia_All or false == Panel_Window_FishEncyclopedia_All:GetShow() then
    return
  end
  Panel_Window_FishEncyclopedia_All:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.stc_topBg:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.btn_close:ComputePos()
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_Console:ComputePos()
    PaGlobal_FishEncyclopedia_All._ui.stc_LB_Console:ComputePos()
    PaGlobal_FishEncyclopedia_All._ui.stc_RB_Console:ComputePos()
  else
    PaGlobal_FishEncyclopedia_All._ui.stc_radioButtonBg_PC:ComputePos()
  end
  PaGlobal_FishEncyclopedia_All._ui.stc_midBg:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.stc_pageBtnBg:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.txt_achivementValue:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.progress_achivementRate:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.txt_pageNumber:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.btn_leftPage_PC:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.btn_rightPage_PC:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadLeft_Console:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.stc_DpadRight_Console:ComputePos()
  PaGlobal_FishEncyclopedia_All._ui.stc_bottomBg_Console:ComputePos()
end
function FromClient_FishEncyclopedia_All_ResponseFishTopRankingBody(sizeRankKey)
  PaGlobal_FishEncyclopedia_All:update()
end
function HandleEventLUp_FishEncyclopedia_All_SelectTab(index)
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  if true == PaGlobal_FishEncyclopedia_All._isConsole then
    for ii = 1, #PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console do
      if nil ~= PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console[ii] then
        if ii == index then
          PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console[ii]:SetCheck(true)
          PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_Console:SetSpanSize(PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console[ii]:GetSpanSize().x, PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_Console:GetSpanSize().y)
        else
          PaGlobal_FishEncyclopedia_All._ui.radiobuttons_Console[ii]:SetCheck(false)
        end
      end
    end
  else
    for ii = 1, #PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC do
      if nil ~= PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[ii] then
        if ii == index then
          PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[ii]:SetCheck(true)
          PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_PC:SetSpanSize(PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[ii]:GetSpanSize().x, PaGlobal_FishEncyclopedia_All._ui.stc_selectLine_PC:GetSpanSize().y)
        else
          PaGlobal_FishEncyclopedia_All._ui.radiobuttons_PC[ii]:SetCheck(false)
        end
      end
    end
  end
  PaGlobal_FishEncyclopedia_All._selectedTab = index
  PaGlobal_FishEncyclopedia_All._currentPage = 1
  PaGlobal_FishEncyclopedia_All:update()
end
function HandleEventLUp_FishEncyclopedia_All_PageMove(isLeft)
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  TooltipSimple_Hide()
  if isLeft then
    PaGlobal_FishEncyclopedia_All._currentPage = PaGlobal_FishEncyclopedia_All._currentPage - 1
  else
    PaGlobal_FishEncyclopedia_All._currentPage = PaGlobal_FishEncyclopedia_All._currentPage + 1
  end
  PaGlobal_FishEncyclopedia_All:update()
end
function HandleEventOnOut_FishEncyclopedia_All_DescTooltip(dataIndex, isLeft, isShow)
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local fishInfo = ToClient_GetFishAt(PaGlobal_FishEncyclopedia_All._categoryParamIndex, dataIndex)
  local name = fishInfo:getName()
  local desc = fishInfo:getDesc()
  local control
  if true == isLeft then
    control = PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.txt_fishDesc
  else
    control = PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.txt_fishDesc
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventXUp_FishEncyclopedia_All_ViewDetails()
  if nil == Panel_Window_FishEncyclopedia_All then
    return
  end
  local dataIndex = PaGlobal_FishEncyclopedia_All._currentPage * 2 - 2
  local fishInfoLeft = ToClient_GetFishAt(PaGlobal_FishEncyclopedia_All._categoryParamIndex, dataIndex)
  local fishInfoRight = ToClient_GetFishAt(PaGlobal_FishEncyclopedia_All._categoryParamIndex, dataIndex + 1)
  if nil ~= fishInfoLeft then
    local isLimitLeft = PaGlobal_FishEncyclopedia_All._ui.stc_pageLeft.txt_fishDesc:IsLimitText()
    if true == fishInfoLeft:isAcquire() and true == isLimitLeft then
      PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Show(true, fishInfoLeft:getName(), fishInfoLeft:getDesc())
    else
      PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(true)
    end
  end
  if nil ~= fishInfoRight then
    local isLimitRight = PaGlobal_FishEncyclopedia_All._ui.stc_pageRight.txt_fishDesc:IsLimitText()
    if true == fishInfoRight:isAcquire() and true == isLimitRight then
      PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Show(false, fishInfoRight:getName(), fishInfoRight:getDesc())
    else
      PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(false)
    end
  end
end
function PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Show(isLeft, name, desc)
  local control
  if true == isLeft then
    control = PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left
  else
    control = PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right
  end
  if true == control.bg:GetShow() then
    PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(isLeft)
    return
  end
  control.bg:SetShow(true)
  control.name:SetSize(270, control.name:GetSizeY())
  control.desc:SetSize(270, control.name:GetSizeY())
  control.name:SetText(name)
  control.desc:SetText(desc)
  control.desc:SetPosY(control.name:GetTextSizeY() + 10)
  control.bg:SetSize(290, control.name:GetTextSizeY() + control.desc:GetTextSizeY() + 20)
end
function PaGlobalFunc_FishEncyclopedia_All_TooltipSimple_Hide(isLeft)
  local control
  if true == isLeft then
    control = PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_left
  else
    control = PaGlobal_FishEncyclopedia_All._ui.stc_tooltip_right
  end
  control.bg:SetShow(false)
end
