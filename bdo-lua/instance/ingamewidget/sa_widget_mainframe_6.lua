function PaGlobal_SA_MainFrame:createBuffControl()
  self._ui_buff.stc_buffBG:SetShow(false)
  self._ui_buff.stc_debuffBG:SetShow(false)
  self._ui_buff.stc_buffIcon:SetShow(false)
  self._ui_buff.stc_debuffIcon:SetShow(false)
  local iconSpan = self._ui_buff.stc_buffIcon:GetSizeY() + 1
  for index = 1, self._value_buff._maxBuffCnt do
    local buff = {buffBG = nil, buffIcon = nil}
    buff.buffBG = UI.cloneControl(self._ui_buff.stc_buffBG, self._ui_buff.stc_buffLeftSide, "Static_BuffBG_" .. index)
    buff.buffIcon = UI.getChildControl(buff.buffBG, "Static_BuffIcon")
    buff.buffBG:SetPosX(self._ui_buff.stc_buffBG:GetPosX() + 2)
    buff.buffBG:SetPosY(iconSpan * (index - 1) + 2)
    buff.buffIcon:ComputePos()
    buff.buffBG:SetShow(false)
    buff.buffBG:SetIgnore(false)
    self._ui_buff.stc_buffList[index] = buff
    local debuff = {buffBG = nil, buffIcon = nil}
    debuff.buffBG = UI.cloneControl(self._ui_buff.stc_debuffBG, self._ui_buff.stc_debuffRightSide, "Static_DeBuffBG_" .. index)
    debuff.buffIcon = UI.getChildControl(debuff.buffBG, "Static_DebuffIcon")
    debuff.buffBG:SetPosX(self._ui_buff.stc_debuffBG:GetPosX() + 2)
    debuff.buffBG:SetPosY(iconSpan * (index - 1) + 2)
    debuff.buffIcon:ComputePos()
    debuff.buffBG:SetShow(false)
    debuff.buffBG:SetIgnore(false)
    self._ui_buff.stc_deBuffList[index] = debuff
    buff.buffIcon:addInputEvent("Mouse_On", "HandleEventOn_SA_MainFrame_ShowBuffTooltip(true, false, " .. tostring(index) .. ")")
    buff.buffIcon:addInputEvent("Mouse_Out", "HandleEventOn_SA_MainFrame_ShowBuffTooltip(false, false, " .. tostring(index) .. ")")
    debuff.buffIcon:addInputEvent("Mouse_On", "HandleEventOn_SA_MainFrame_ShowBuffTooltip(true, true, " .. tostring(index) .. ")")
    debuff.buffIcon:addInputEvent("Mouse_Out", "HandleEventOn_SA_MainFrame_ShowBuffTooltip(false, true, " .. tostring(index) .. ")")
  end
  self._ui_buff.stc_buffIcon:SetIgnore(true)
  self._ui_buff.stc_debuffIcon:SetIgnore(true)
  PaGlobalFunc_SA_MainFrame_ChangeBuffList()
end
function PaGlobal_SA_MainFrame:updateBuffList()
  if nil == Panel_SA_MainFrame then
    return
  end
  self._value_buff._sumCount = 0
  self:updateBuff(true)
  self:updateBuff(false)
  self:setRepositionBuffIcon()
  if 0 == self._value_buff._sumCount then
    TooltipCommon_Hide(TooltipCommon_getCurrentIndex())
  end
end
function PaGlobal_SA_MainFrame:updateBuff(isDebuff)
  local uiBuffList = self._ui_buff.stc_deBuffList
  if false == isDebuff then
    uiBuffList = self._ui_buff.stc_buffList
  end
  local buffIndex = 0
  local appliedBuff = getSelfPlayer():getAppliedBuffBegin(isDebuff)
  while appliedBuff ~= nil do
    buffIndex = buffIndex + 1
    if buffIndex > self._value_buff._maxBuffCnt then
      buffIndex = buffIndex - 1
      break
    end
    local u64_calc_time1 = appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000
    uiBuffList[buffIndex].buffIcon:ChangeTextureInfoNameAsync("icon/" .. appliedBuff:getIconName())
    local sizeX = uiBuffList[buffIndex].buffIcon:GetSizeX()
    local sizeY = uiBuffList[buffIndex].buffIcon:GetSizeY()
    local x1, y1, x2, y2 = setTextureUV_Func(uiBuffList[buffIndex].buffIcon, 0, 0, sizeX, sizeY)
    uiBuffList[buffIndex].buffIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    uiBuffList[buffIndex].buffIcon:setRenderTexture(uiBuffList[buffIndex].buffIcon:getBaseTexture())
    uiBuffList[buffIndex].buffIcon:SetShow(true)
    uiBuffList[buffIndex].buffBG:SetShow(true)
    uiBuffList[buffIndex].buffBG:SetText(Util.Time.inGameTimeFormattingTop(u64_calc_time1))
    appliedBuff = getSelfPlayer():getAppliedBuffNext(isDebuff)
  end
  self._value_buff._sumCount = self._value_buff._sumCount + buffIndex
  while buffIndex < self._value_buff._maxBuffCnt do
    buffIndex = buffIndex + 1
    if nil == uiBuffList[buffIndex] then
      return
    end
    uiBuffList[buffIndex].buffBG:SetShow(false)
  end
end
function PaGlobal_SA_MainFrame:setRepositionBuffIcon()
  local showBuffCount = 0
  for index = 1, PaGlobal_SA_MainFrame._value_buff._maxBuffCnt do
    if true == PaGlobal_SA_MainFrame._ui_buff.stc_buffList[index].buffBG:GetShow() then
      showBuffCount = showBuffCount + 1
    end
  end
  local padding = 10
  local buffBGSizeY = showBuffCount * PaGlobal_SA_MainFrame._ui_buff.stc_buffIcon:GetSizeY() + padding
  PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetSize(PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetSizeX(), buffBGSizeY)
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffRightSide:SetSpanSize(0, buffBGSizeY)
end
function PaGlobal_SA_MainFrame:changeOnOffTexture(isOn)
  if true == isOn then
    if Panel_UIControl:IsShow() then
      Panel_SA_MainFrame:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_drag.dds")
    end
  elseif Panel_UIControl:IsShow() then
    Panel_SA_MainFrame:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_isWidget.dds")
  else
    Panel_SA_MainFrame:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function PaGlobal_SA_MainFrame:getAlchemyStoneBuff_RemainTime()
  self:updateBuff(false)
  local BuffKey = getEquipedAlchemyStoneBuffkey()
  if -1 == BuffKey then
    return -1
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local appliedBuff = selfPlayer:getAppliedBuffBegin(false)
  while appliedBuff ~= nil do
    if BuffKey == appliedBuff:getBuffKey() then
      local u64_calc_time1 = appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000
      return Int64toInt32(u64_calc_time1)
    end
    appliedBuff = selfPlayer:getAppliedBuffNext(false)
  end
  return -1
end
function HandleEventOn_SA_MainFrame_BuffPenel()
  PaGlobal_SA_MainFrame:changeOnOffTexture(true)
end
function HandleEventOut_SA_MainFrame_BuffPenel()
  PaGlobal_SA_MainFrame:changeOnOffTexture(false)
end
function HandleEventOn_SA_MainFrame_Buff(buffIndex, isDebuff)
end
function HandleEventOut_SA_MainFrame_Buff(buffIndex, isDebuff)
end
function HandleEventOn_SA_MainFrame_ShowBuffTooltip(isShow, isDebuff, buffIndex)
  local msg
  local appliedBuff = getSelfPlayer():getAppliedBuffByIndex(buffIndex - 1, isDebuff)
  if nil == appliedBuff then
    return
  end
  if false == isShow then
    local tooltipIndex = 0
    if true == isDebuff then
    end
    tooltipIndex = buffIndex
    TooltipCommon_Hide(tooltipIndex)
    return
  end
  local icon
  if isDebuff then
    icon = PaGlobal_SA_MainFrame._ui_buff.stc_buffList[buffIndex].buffIcon
  else
    icon = PaGlobal_SA_MainFrame._ui_buff.stc_deBuffList[buffIndex].buffIcon
  end
  local tooltipIndex = buffIndex
  if isDebuff then
  end
  TooltipCommon_Show(tooltipIndex, icon, appliedBuff:getIconName(), appliedBuff:getBuffDesc(), "")
end
function FromClient_BuffRunPostRestoreFunction(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  PaGlobalFunc_SA_MainFrame_ChangeBuffList()
end
function PaGlobalFunc_SA_MainFrame_ShowBuffToolTip(buffIndex, isDebuff)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local appliedBuff = selfPlayer:getAppliedBuffByIndex(buffIndex - 1, isDebuff)
  if nil == appliedBuff then
    return
  end
  PaGlobal_SA_MainFrame._value_buff._buffTooltipIndex = buffIndex
  PaGlobal_SA_MainFrame._value_buff._isTooltipDebuff = isDebuff
  local icon
  local tooltipIndex = buffIndex
  if true == isDebuff then
    icon = PaGlobal_SA_MainFrame._ui_buff.stc_deBuffList[buffIndex].buffIcon
    tooltipIndex = tooltipIndex + PaGlobal_SA_MainFrame._value_buff._maxBuffCnt
  else
    icon = PaGlobal_SA_MainFrame._ui_buff.stc_buffList[buffIndex].buffIcon
  end
  if nil ~= appliedBuff then
  end
end
function PaGlobalFunc_SA_MainFrame_HideBuffToolTip(buffIndex, isDebuff)
  local tooltipIndex = buffIndex
  if true == isDebuff then
    tooltipIndex = tooltipIndex + PaGlobal_SA_MainFrame._value_buff._maxBuffCnt
  end
  TooltipCommon_Hide(tooltipIndex)
end
function PaGlobalFunc_SA_MainFrame_ChangeBuffList()
  if true == isFlushedUI() then
    return
  end
  PaGlobal_SA_MainFrame:updateBuffList()
end
function PaGlobalFunc_SA_MainFrame_ResetPosition()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  if PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosX() == -1 and PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosY() == -1 then
    local initPosX = screenX * 0.35
    local initPosY = screenY * 0.75
    local haveServerPosotion = 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
    if false == haveServerPosotion then
      PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosX(initPosX)
      PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosY(initPosY)
    end
    changePositionBySever(PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide, CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, true, true, false)
    FGlobal_InitPanelRelativePos(PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide, initPosX, initPosY)
  elseif PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosX() == 0 and PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosY() == 0 then
    PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosX(screenX * 0.35)
    PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosY(screenY * 0.75)
  else
    PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosX(screenX * PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosX() - PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetSizeX() / 2)
    PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetPosY(screenY * PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetRelativePosY() - PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:GetSizeY() / 2)
  end
  local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  if isShow < 0 then
    PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:SetShow(true)
  else
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_SA_MainFrame)
end
function PaGlobalFunc_SA_MainFrame_UpdateBuff(fDeltaTime)
  if isFlushedUI() then
    return
  end
  PaGlobal_SA_MainFrame._value_buff._cumulateTime = PaGlobal_SA_MainFrame._value_buff._cumulateTime + fDeltaTime
  PaGlobal_SA_MainFrame:updateBuffList()
  if PaGlobal_SA_MainFrame._value_buff._cumulateTime > 1 then
    PaGlobal_SA_MainFrame._value_buff._cumulateTime = 0
  end
end
function FromClient_SA_MainFrame_BuffResizePanel()
  PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:ComputePos()
  PaGlobal_SA_MainFrame._ui_buff.stc_buffBG:ComputePos()
  PaGlobal_SA_MainFrame._ui_buff.stc_buffIcon:ComputePos()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffRightSide:ComputePos()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffBG:ComputePos()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffIcon:ComputePos()
end
function PaGlobal_SA_MainFrame:buffValidate()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide:isValidate()
  PaGlobal_SA_MainFrame._ui_buff.stc_buffBG:isValidate()
  PaGlobal_SA_MainFrame._ui_buff.stc_buffIcon:isValidate()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffRightSide:isValidate()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffBG:isValidate()
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffIcon:isValidate()
end
function PaGlobal_SA_MainFrame:buffInit()
  if nil == Panel_SA_MainFrame then
    return
  end
  local stc_buff = UI.getChildControl(Panel_SA_MainFrame, "Static_Buff")
  PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide = UI.getChildControl(stc_buff, "Static_Buff_LeftSide")
  PaGlobal_SA_MainFrame._ui_buff.stc_buffBG = UI.getChildControl(PaGlobal_SA_MainFrame._ui_buff.stc_buffLeftSide, "Static_BuffBG")
  PaGlobal_SA_MainFrame._ui_buff.stc_buffIcon = UI.getChildControl(PaGlobal_SA_MainFrame._ui_buff.stc_buffBG, "Static_BuffIcon")
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffRightSide = UI.getChildControl(stc_buff, "Static_Debuff_RightSide")
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffBG = UI.getChildControl(PaGlobal_SA_MainFrame._ui_buff.stc_debuffRightSide, "Static_DeBuffBG")
  PaGlobal_SA_MainFrame._ui_buff.stc_debuffIcon = UI.getChildControl(PaGlobal_SA_MainFrame._ui_buff.stc_debuffBG, "Static_DebuffIcon")
end
