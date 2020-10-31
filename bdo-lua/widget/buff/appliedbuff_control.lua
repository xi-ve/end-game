local buffTooltipIndex = 0
local typeTooltipbuff = __eBuffDisplayType_Buff
function ShowBuffTooltip(buffIndex, buffType)
  if _ContentsGroup_RenewUI then
    return
  end
  local appliedBuff = getSelfPlayer():getAppliedBuffByIndexByOrder(buffIndex - 1, buffType)
  if nil == appliedBuff then
    return
  end
  buffTooltipIndex = buffIndex
  typeTooltipbuff = buffType
  local icon = PaGlobalAppliedBuffList._uiBuffList[buffType][buffIndex]
  local tooltipIndex = buffIndex + buffType * PaGlobalAppliedBuffList._maxBuffCount
  if appliedBuff ~= nil then
    TooltipCommon_Show(tooltipIndex, icon, appliedBuff:getIconName(), appliedBuff:getBuffDesc(), "")
  end
end
function HideBuffTooltip(buffIndex, buffType)
  local tooltipIndex = buffIndex + buffType * PaGlobalAppliedBuffList._maxBuffCount
  TooltipCommon_Hide(tooltipIndex)
end
function PaGlobalAppliedBuffList:updateBuff(buffType)
  local uiBuffList = self._uiBuffList[buffType]
  local uiBackBuff = self._uiBackBuffList[buffType]
  local selfPlayer = getSelfPlayer()
  local classType = getSelfPlayer():getClassType()
  local buffIndex = 0
  if nil ~= selfPlayer then
    local appliedBuff = selfPlayer:getAppliedBuffBeginByOrder(buffType)
    while appliedBuff ~= nil do
      buffIndex = buffIndex + 1
      if buffIndex > self._maxBuffCount then
        buffIndex = buffIndex - 1
        break
      end
      local u64_calc_time1 = appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000
      if nil ~= uiBuffList and nil ~= uiBuffList[buffIndex] then
        uiBuffList[buffIndex]:ChangeTextureInfoNameAsync("icon/" .. appliedBuff:getIconName())
        uiBuffList[buffIndex]:SetShow(true)
        uiBuffList[buffIndex]:SetText(Util.Time.inGameTimeFormattingTop(u64_calc_time1))
        appliedBuff = selfPlayer:getAppliedBuffNextByOrder(buffType)
      end
    end
  end
  if nil ~= uiBackBuff then
    if 0 < buffIndex then
      uiBackBuff:SetSize(buffIndex * 33 + 4, 52)
      uiBackBuff:SetShow(true)
    else
      uiBackBuff:SetShow(false)
    end
    self._sumCount = self._sumCount + buffIndex
    while buffIndex < self._maxBuffCount do
      buffIndex = buffIndex + 1
      uiBuffList[buffIndex]:SetShow(false)
    end
    if 17 < buffIndex then
      uiBackBuff:SetPosX(self._default_uiBackBuffPosX - (buffIndex - 17) / 2 * 33)
    else
      uiBackBuff:SetPosX(self._default_uiBackBuffPosX)
    end
    for index = 1, buffIndex do
      uiBuffList[index]:SetPosX(uiBackBuff:GetPosX() + 33 * (index - 1) + 2)
      uiBuffList[index]:SetPosX(uiBackBuff:GetPosX() + 33 * (index - 1) + 2)
    end
  end
end
function PaGlobalAppliedBuffList:updateBuffList()
  if false == self._initialized then
    return
  end
  self._sumCount = 0
  for i = __eBuffDisplayType_Buff, __eBuffDisplayType_ShortBuff do
    PaGlobalAppliedBuffList:updateBuff(i)
  end
  if 0 == self._sumCount then
    TooltipCommon_Hide(TooltipCommon_getCurrentIndex())
  end
end
function PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()
  PaGlobalAppliedBuffList:updateBuff(__eBuffDisplayType_DeBuff)
  local BuffKey = getEquipedAlchemyStoneBuffkey()
  if -1 == BuffKey then
    return -1
  end
  local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
  while appliedBuff ~= nil do
    if BuffKey == appliedBuff:getBuffKey() then
      local u64_calc_time1 = appliedBuff:getRemainedTime_u64() / Defines.u64_const.u64_1000
      return Int64toInt32(u64_calc_time1)
    end
    appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
  end
  return -1
end
local _cumulateTime = 0
function AppliedBuffList_Update(fDeltaTime)
  if isFlushedUI() then
    return
  end
  _cumulateTime = _cumulateTime + fDeltaTime
  PaGlobalAppliedBuffList:updateBuffList()
  local cumulateTimeInSecond = math.floor(_cumulateTime)
  local u64_cumulateTime = toUint64(0, cumulateTimeInSecond)
  if 1 < _cumulateTime then
    _cumulateTime = 0
  end
end
function ResponseBuff_changeBuffList()
  if isFlushedUI() then
    return
  end
  PaGlobalAppliedBuffList:updateBuffList()
end
function PaGlobalAppliedBuffList:GetMaehwaBuff_RemainTime()
  local BuffKey = 18634
  local appliedBuff = getSelfPlayer():getAppliedBuffBegin(false)
  while appliedBuff ~= nil do
    if BuffKey == appliedBuff:getBuffKey() then
      return Int64toInt32(appliedBuff:getRemainedTime_u64())
    end
    appliedBuff = getSelfPlayer():getAppliedBuffNext(false)
  end
  return -1
end
function buff_RunPostRestoreFunction(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  ResponseBuff_changeBuffList()
end
registerEvent("FromClient_RenderModeChangeState", "buff_RunPostRestoreFunction")
function FGlobal_BuffTooltipOff()
  HideBuffTooltip(buffTooltipIndex, typeTooltipbuff)
end
registerEvent("ResponseBuff_changeBuffList", "ResponseBuff_changeBuffList")
if false == _ContentsGroup_ReducedLua then
  Panel_AppliedBuffList:RegisterUpdateFunc("AppliedBuffList_Update")
end
