function PaGlobalFunc_CharInfoChallenge_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
    return
  end
  PaGlobal_CharInfoChallenge_All:dataClear()
  if nil == PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx then
    PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx = 0
  end
  HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx)
  PaGlobal_CharInfoChallenge_All:update()
end
function FromClient_CharInfoChallenge_All_Update()
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
    return
  end
  PaGlobal_CharInfoChallenge_All:update()
end
function HandleEventPadPress_CharInfoChallenge_All_TabChange(isUp)
  if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
    return
  end
  local curTab = PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx
  if true == isUp then
    curTab = curTab + 1
    if PaGlobal_CharInfoChallenge_All._eTAB.PCROOM == curTab then
      curTab = curTab + 1
    end
    if curTab > #PaGlobal_CharInfoChallenge_All._ui.rdo_Table then
      curTab = 0
    end
  else
    curTab = curTab - 1
    if PaGlobal_CharInfoChallenge_All._eTAB.PCROOM == curTab then
      curTab = curTab - 1
    end
    if curTab < 0 then
      curTab = #PaGlobal_CharInfoChallenge_All._ui.rdo_Table
    end
  end
  PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console()
  HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(curTab)
end
function HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(idx)
  if nil == idx or nil == PaGlobal_CharInfoChallenge_All._ui.rdo_Table then
    return
  end
  local curIdx = PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx
  if nil ~= curIdx and idx ~= curIdx then
    PaGlobal_CharInfoChallenge_All._ui.rdo_Table[curIdx]:SetCheck(false)
  end
  PaGlobal_CharInfoChallenge_All._currentSelected._challengeIdx = nil
  PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = nil
  PaGlobal_CharInfoChallenge_All._scrollIdx = 0
  PaGlobal_CharInfoChallenge_All._currentTaskCount = 0
  PaGlobal_CharInfoChallenge_All._currentSelected._tabIdx = idx
  PaGlobal_CharInfoChallenge_All._ui.rdo_Table[idx]:SetCheck(true)
  local selectLine = PaGlobal_CharInfoChallenge_All._ui.stc_selectLine
  selectLine:SetSpanSize(PaGlobal_CharInfoChallenge_All._ui.rdo_Table[idx]:GetSpanSize().x, selectLine:GetSpanSize().y)
  PaGlobal_CharInfoChallenge_All._ui.stc_Scroll:SetControlTop()
  PaGlobal_CharInfoChallenge_All:update()
end
function HandleEventLUp_CharInfoChallenge_All_SelectItemClick(challengeIdx, uiIdx, slotIdx)
  if nil ~= PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx]._selectItem[slotIdx]._bg then
    local effectSpanPos = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx]._selectItem[slotIdx]._bg
    for idx = 0, PaGlobal_CharInfoChallenge_All._MAXBGCOUNT - 1 do
      if nil ~= PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx] then
        if idx ~= uiIdx then
          PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._selectEffect:SetShow(false)
        else
          PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._selectEffect:SetShow(true)
          PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._selectEffect:SetSpanSize(effectSpanPos:GetSpanSize().x, effectSpanPos:GetSpanSize().y)
        end
      end
    end
  end
  PaGlobal_CharInfoChallenge_All._currentSelected._challengeIdx = challengeIdx
  PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = slotIdx
  local challengeWrapper = ToClient_GetChallengeRewardInfoWrapper(challengeIdx)
  local selectRewardCount = challengeWrapper:getSelectRewardCount()
  if 0 == selectRewardCount then
    PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = 0
  end
end
function HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip(type, show, questtype, index, uiIdx)
  if nil == slotNo or nil == uiIdx or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx] then
    TooltipSimple_Hide()
    return
  end
  local _slot = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx]._selectItem[index]._slot.icon
  local name = ""
  if "Exp" == type then
    name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP"))
  elseif "SkillExp" == type then
    name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP"))
  elseif "ProductExp" == type then
    name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP"))
  elseif "Intimacy" == type then
    name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_INTIMACY"))
  end
  TooltipSimple_Show(_slot, name, "")
end
function HandleEventLUp_CharInfoChallenge_All_SlotItemTooltip(isShow, uiIdx, slotNo, rewardType)
  if nil == slotNo or nil == uiIdx or false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx] then
    return
  end
  local _slot = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[uiIdx]
  local passTooltipType, uiSlot
  if "main" == rewardType then
    passTooltipType = "Dialog_ChallengeReward_Base"
    uiSlot = _slot._basicItem[slotNo]._slot
  else
    passTooltipType = "Dialog_ChallengeReward_Select"
    uiSlot = _slot._selectItem[slotNo]._slot
  end
  Panel_Tooltip_Item_SetPosition(slotNo, uiSlot, passTooltipType)
  Panel_Tooltip_Item_Show_GeneralStatic(slotNo, passTooltipType, true)
end
function HandleEventScroll_CharInfoChallenge_All_ScrollUpdate(isUp, challengeIdx, idx)
  local self = PaGlobal_CharInfoChallenge_All
  self._scrollIdx = UIScroll.ScrollEvent(self._ui.stc_Scroll, isUp, self._MAXBGCOUNT, self._currentTaskCount, self._scrollIdx, 1)
  PaGlobal_CharInfoChallenge_All:update()
  if nil ~= PaGlobal_CharInfoChallenge_All._consoleUIIdx then
    PaGlobalFunc_ChracterInfo_All_ShowTooltip_Console(PaGlobal_CharInfoChallenge_All._consoleUIIdx)
  end
end
function PaGlobalFunc_CharInfoChallenge_All_GetCtrlPos()
  return PaGlobal_CharInfoChallenge_All._ui.stc_Scroll:GetControlPos()
end
function HandleEventLUp_CharInfoChallenge_All_PcRoomTimeRefresh()
  local pcRoomTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLANGE_ACCUMULATEPCROOMPLAYTIME", "time", convertStringFromDatetimeAll(ToClient_GetUserPcRoomPlayTime()))
  PaGlobal_CharInfoChallenge_All._ui.txt_PcroomTime:SetText(pcRoomTime)
end
function HandleEventOnOut_CharInfoChallenge_All_PcRoomTimeTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_PCROOMACCUMULATETIME_TITLE")
  desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHALLENGE_PCROOMACCUMULATETIME_DESCBYHOUR", "time", convertStringFromDatetimeAllByHour(ToClient_GetUserPcRoomPlayTime()))
  control = PaGlobal_CharInfoChallenge_All._ui.txt_PcroomTime
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_CharInfoChallenge_All_ChallengeTitleTooltip(idx)
  if nil == idx or nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx] then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._title:GetText()
  desc = nil
  control = PaGlobal_CharInfoChallenge_All._ui.stc_RewardTable[idx]._title
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_CharInfoChallenge_All_ReciveAllReward_Complete(inputNumber, challengeKey)
  if false == _ContentsGroup_ChallengeReward then
    return
  end
  local receiveCount = Int64toInt32(inputNumber)
  if 1 < receiveCount then
    ToClient_requestChallengeReward(challengeKey, 0, receiveCount)
    PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = nil
  elseif 1 == receiveCount then
    ToClient_requestChallengeReward(challengeKey, PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx, receiveCount)
    PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = nil
  end
  local remainRewardCount = ToClient_GetChallengeRewardInfoCount() - PaGlobal_CharInfoChallenge_All._scrollIdx
  if 1 == remainRewardCount - PaGlobal_CharInfoChallenge_All._scrollIdx then
    PaGlobal_CharInfoChallenge_All._ui.stc_Scroll:SetControlTop()
    PaGlobal_CharInfoChallenge_All._scrollIdx = 0
  end
end
function PaGlobalFunc_CharInfoChallenge_All_ReciveAllReward_Try(challengeIdx, maxRewardCount)
  if false == _ContentsGroup_ChallengeReward then
    return
  end
  local currentSelectItemIdx = PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx
  local currentChallengeIdx = PaGlobal_CharInfoChallenge_All._currentSelected._challengeIdx
  local challengeWrapper = ToClient_GetChallengeRewardInfoWrapper(challengeIdx)
  if nil == challengeWrapper then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_WRONGINFOCHALLENGE"))
    return
  end
  if false == challengeWrapper:isAcceptAbleReward() then
    return
  end
  local selectRewardCount = challengeWrapper:getSelectRewardCount()
  if 0 ~= selectRewardCount and nil == currentSelectItemIdx then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_YOUCANSELECTITEM"))
    return
  end
  if 0 ~= selectRewardCount and currentSelectItemIdx > selectRewardCount - 1 then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_WRONGSELECTVALUE"))
    return
  end
  if currentChallengeIdx ~= challengeIdx and 0 ~= selectRewardCount then
    Proc_ShowMessage_Ack_WithOut_ChattingMessage(PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGE_WRONGSELECTVALUE"))
    return
  end
  if 0 == selectRewardCount or nil == currentSelectItemIdx then
    PaGlobal_CharInfoChallenge_All._currentSelected._subItemIdx = 0
  end
  local challengeKey = challengeWrapper:getKey()
  local maxRewardCount_edit = maxRewardCount
  for idx = 0, challengeWrapper:getBaseRewardCount() - 1 do
    if false == challengeWrapper:getBaseRewardAt(idx):_itemStatic():isStackable() then
      maxRewardCount_edit = 1
      break
    end
  end
  if 0 == selectRewardCount and 1 < maxRewardCount_edit then
    Panel_NumberPad_Show(true, toInt64(0, maxRewardCount_edit), challengeKey, PaGlobalFunc_CharInfoChallenge_All_ReciveAllReward_Complete)
  else
    Panel_NumberPad_Show(true, toInt64(0, 1), challengeKey, PaGlobalFunc_CharInfoChallenge_All_ReciveAllReward_Complete)
  end
end
function HandleEventPadPress_CharInfoChallenge_All_ShowItemTooltip(uiIdx, itemIdx)
  if nil == uiIdx or nil == itemIdx then
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil ~= PaGlobal_CharInfo_All._ui.stc_tooltip and true == PaGlobal_CharInfo_All._ui.stc_tooltip:GetShow() then
    PaGlobal_CharInfo_All._ui.stc_tooltip:SetShow(false)
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemIdx))
  if nil == itemSSW then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
end
function PaGlobalFunc_CharInfoChallenge_All_GetConsoleTooltipShow()
  if nil == PaGlobal_CharInfo_All._ui.stc_tooltip then
    return false
  end
  return PaGlobal_CharInfo_All._ui.stc_tooltip:GetShow()
end
function PaGlobalFunc_CharInfoChallenge_All_HideConsoleTooltipShow()
  if nil == PaGlobal_CharInfo_All._ui.stc_tooltip then
    return
  end
  PaGlobal_CharInfo_All._ui.stc_tooltip:SetShow(false)
end
