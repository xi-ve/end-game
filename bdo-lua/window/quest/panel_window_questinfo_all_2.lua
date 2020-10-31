function PaGlobalFunc_QuestInfo_All_Open()
  PaGlobal_QuestInfo_All:prepareOpen()
end
function PaGlobalFunc_QuestInfo_All_Close()
  PaGlobal_QuestInfo_All:prepareClose()
end
function PaGlobalFunc_QuestInfo_All_GetShow()
  if nil == Panel_Window_QuestInfo_All then
    return false
  end
  return Panel_Window_QuestInfo_All:GetShow()
end
function PaGlobalFunc_QuestInfo_All_ShowAni()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobalFunc_QuestInfo_All_Audio(1, 0)
  Panel_Window_QuestInfo_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_Window_QuestInfo_All, 0, 0.15)
  local aniInfo1 = Panel_Window_QuestInfo_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.12)
  aniInfo1.AxisX = Panel_Window_QuestInfo_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_QuestInfo_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_QuestInfo_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.12)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_QuestInfo_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_QuestInfo_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_QuestInfo_All_HideAni()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobalFunc_QuestInfo_All_Audio(1, 1)
  Panel_Window_QuestInfo_All:SetAlpha(1)
  local aniInfo1 = UIAni.AlphaAnimation(0, Panel_Window_QuestInfo_All, 0, 0.1)
  aniInfo1:SetHideAtEnd(true)
end
function rewardTooltip_ForQuestWidgetInfo(rewardType, isShow, questtype, index, key, value)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc = "", ""
  local control
  if "main" == questtype then
    control = PaGlobal_QuestInfo_All._uiBackBaseReward[index]
  else
    control = PaGlobal_QuestInfo_All._uiBackSelectReward[index]
  end
  if "Exp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP")
  elseif "SkillExp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP")
  elseif "ExpGrade" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_EXP_GRADE")
  elseif "SkillExpGrade" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_SKILLEXP_GRADE")
  elseif "ProductExp" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_PRODUCTEXP")
  elseif "Intimacy" == rewardType then
    local wrapper = ToClient_GetCharacterStaticStatusWrapper(key)
    local npcName = wrapper:getName()
    desc = npcName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_INTIMACY") .. " " .. value
  elseif "Knowledge" == rewardType then
    local mentalCardSSW = ToClinet_getMentalCardStaticStatus(key)
    local mentalCardName = mentalCardSSW:getName()
    local mentalCardDesc = mentalCardSSW:getDesc()
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARD_TOOLTIP_KNOWLEDGE", "mentalCardName", mentalCardName, "mentalCardName2", mentalCardName)
  elseif "CharacterStat" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_CHARACTERSTAT")
  elseif "FamilyStat" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_FAMILYSTAT")
  elseif "FamilyStatPoint" == rewardType then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_JOIN_COLOSSEUM_REWARD_1")
  elseif "SeasonReward" == rewardType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_QuestInfo_All_CallSpirit()
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  ToClient_AddBlackSpiritFlush()
  return
end
function HandlePadEventX_QuestInfo_All_RewardItemTooltip(index, questType)
  local reward
  if "sub" == questType then
    reward = PaGlobal_QuestInfo_All._selectReward[index + 1]
  elseif "main" == questType then
    reward = PaGlobal_QuestInfo_All._baseReward[index + 1]
  end
  if nil == reward then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function HandleRSticEvent_QuestInfo_All_MoveScroll(flag)
  if false == PaGlobal_QuestInfo_All._ui.frame_questDesc:GetVScroll():GetShow() then
    return
  end
  if 1 == flag then
    PaGlobal_QuestInfo_All._ui.frame_questDesc:GetVScroll():ControlButtonUp()
  elseif -1 == flag then
    PaGlobal_QuestInfo_All._ui.frame_questDesc:GetVScroll():ControlButtonDown()
  end
  PaGlobal_QuestInfo_All._ui.frame_questDesc:UpdateContentScroll()
  PaGlobal_QuestInfo_All._ui.frame_questDesc:UpdateContentPos()
end
function PaGlobalFunc_QuestInfo_All_Detail(groupId, questId, uiCondition, groupTitle, questGroupCount, fromQuestWidget, isRecommand, isNextQuest, isCleared, isAccepted, uiIdx)
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_QuestInfo_All:IsUISubApp() then
    Panel_Window_QuestInfo_All:CloseUISubApp()
  end
  if PaGlobal_QuestInfo_All._OpenInfo._groupId == groupId and PaGlobal_QuestInfo_All._OpenInfo._questId == questId then
    PaGlobalFunc_QuestInfo_All_Close()
    return
  end
  PaGlobal_QuestInfo_All:openInfoSave(groupId, questId, uiCondition, groupTitle, questGroupCount, fromQuestWidget, isRecommand, isNextQuest, isCleared, isAccepted, uiIdx)
  if false == Panel_Window_Quest_All:GetShow() then
    PaGlobalFunc_Quest_All_Open()
  end
  if false == Panel_Window_QuestInfo_All:GetShow() then
    PaGlobalFunc_QuestInfo_All_Open()
  else
    PaGlobalFunc_QuestInfo_All_Update()
  end
end
function PaGlobalFunc_QuestInfo_All_Audio(group, index)
  if PaGlobal_QuestInfo_All._isConsole then
    audioPostEvent_SystemUi(group, index)
  else
    _AudioPostEvent_SystemUiForXBOX(group, index)
  end
end
function PaGlobalFunc_QuestInfo_All_Update()
  PaGlobal_QuestInfo_All:update()
end
function PaGlobalFunc_QuestInfo_All_RePosition()
  PaGlobal_QuestInfo_All:rePosition()
end
function PaGlobalFunc_QuestInfo_All_DenySetQuestTypeResetButton(groupId, questId)
  if nil == Panel_Window_QuestInfo_All or false == Panel_Window_QuestInfo_All:GetShow() then
    return
  end
  if PaGlobal_QuestInfo_All._OpenInfo._groupId ~= groupId or PaGlobal_QuestInfo_All._OpenInfo._questId ~= questId then
    return
  end
  PaGlobal_QuestInfo_All:resetCheckButton()
end
