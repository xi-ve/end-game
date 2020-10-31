local luaLoadAfterTime = 0
local luaLoadAfterFrameCount = 0
local whaleTimeCheck = 0
function FGlobal_getLuaLoadTime()
  return luaLoadAfterTime
end
function FGlobal_getFrameCount()
  return luaLoadAfterFrameCount
end
function Panel_OnlyPerframeUsedFunction(deltaTime)
  luaLoadAfterTime = luaLoadAfterTime + deltaTime
  luaLoadAfterFrameCount = luaLoadAfterFrameCount + 1
  if nil ~= PaGlobal_ReducedPerframe then
    PaGlobal_ReducedPerframe(deltaTime)
  end
  if nil ~= PaGlobal_BossAlert_NewAlarmShow then
    PaGlobal_BossAlert_NewAlarmShow(deltaTime)
  end
  if nil ~= NewQuickSlot_UpdatePerFrame then
    NewQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame then
    FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= Competition_UpdatePerFrame then
    Competition_UpdatePerFrame(deltaTime)
  end
  if false == _ContentsGroup_RenewUI and nil ~= GameTips_MessageUpdate then
    GameTips_MessageUpdate(deltaTime)
  end
  if nil ~= OnlyPerFrame_ProgressBar_Collect_Update then
    OnlyPerFrame_ProgressBar_Collect_Update(deltaTime)
  end
  if nil ~= WorldMap_ShortcutButton_RePos then
    WorldMap_ShortcutButton_RePos()
  end
  if nil ~= WorldMap_DetectUserButton_RePos then
    WorldMap_DetectUserButton_RePos()
  end
  if nil ~= ChattingViewManager_UpdatePerFrame then
    ChattingViewManager_UpdatePerFrame(deltaTime)
  end
  if Panel_WhereUseItemDirection:GetShow() then
    WhereUseItemDirectionRestore()
  end
  local reUseTime = false
  if true == _ContentsGroup_NewUI_Equipment_All then
    reUseTime = PaGlobalFunc_Equipment_All_IsReuseTime(deltaTime)
  else
    reUseTime = PaGlobalFunc_Equipment_IsReuseTime(deltaTime)
  end
  if true == reUseTime then
    local cooltime = 0
    if true == _ContentsGroup_NewUI_Equipment_All then
      cooltime = PaGlobalFunc_Equipment_All_AlchemyStonCheck()
    else
      cooltime = FGlobal_AlchemyStonCheck()
    end
    if 0 < cooltime then
      if true == ToClient_GetAlchemyStoneReuseNextTick() then
        if true == _ContentsGroup_NewUI_AlchemyStone_All then
          PaGlobalFunc_AlchemyStone_All_Use()
        else
          FGlobal_AlchemyStone_Use()
        end
        ToClient_SetAlchemyStoneReuseNextTick(cooltime)
      end
    else
      ToClient_SetAlchemyStoneReuseNextTick(0)
    end
  end
  if nil ~= FGlobal_AutoQuestManager_UpdatePerFrame then
    FGlobal_AutoQuestManager_UpdatePerFrame(deltaTime)
  end
  if nil ~= AutoFrameCheckManager_UpdatePerFrame then
    AutoFrameCheckManager_UpdatePerFrame()
  end
  if nil ~= QASupport_UpdatePerFrame then
    QASupport_UpdatePerFrame(deltaTime)
  end
  if nil ~= Update_ReconnectHorse then
    Update_ReconnectHorse()
  end
  if nil ~= Auto_FrameMove then
    Auto_FrameMove(deltaTime)
  end
  if nil ~= FGlobal_GuildBattle_UpdatePerFrame then
    FGlobal_GuildBattle_UpdatePerFrame(deltaTime)
  end
  if nil ~= UpdateFunc_FairyRegisterAni then
    UpdateFunc_FairyRegisterAni(deltaTime)
  end
  if false == _ContentsGroup_NewUI_DeadMessage_All then
    if nil ~= PaGlobalFunc_DeadMessage_Update then
      PaGlobalFunc_DeadMessage_Update(deltaTime)
    end
  elseif nil ~= PaGlobalFunc_DeadMessage_All_Update then
    PaGlobalFunc_DeadMessage_All_Update(deltaTime)
  end
  if not ToClient_isCheckRenderModeGame() then
    local lanternIdx = 1
    if true == _ContentsGroup_RenewUI then
      lanternIdx = 2
    end
    PaGlobalFunc_UseTab_Show(lanternIdx, false)
    HideUseTab_Func()
  end
  whaleTimeCheck = whaleTimeCheck + deltaTime
  if 30 < whaleTimeCheck then
    whaleTimeCheck = 0
    if nil ~= FGlobal_WhaleConditionCheck then
      FGlobal_WhaleConditionCheck()
    end
    if nil ~= FGlobal_TerritoryWar_Caution then
      FGlobal_TerritoryWar_Caution()
    end
    if nil ~= FGlobal_SummonPartyCheck then
      FGlobal_SummonPartyCheck()
    end
    if nil ~= FGlobal_ReturnStoneCheck then
      FGlobal_ReturnStoneCheck()
    end
  end
  if nil ~= Panel_Widget_GardenIcon_Renew then
    PaGlobalFunc_GardenIcon_UpdatePerFrameFunc(deltaTime)
  end
  if true == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Fishing_All then
      if nil ~= Panel_Widget_Fishing_All and true == Panel_Widget_Fishing_All:GetShow() and nil ~= PaGlobal_Fishing_All_UpdatePerFrameFunc then
        PaGlobal_Fishing_All_UpdatePerFrameFunc(deltaTime)
      end
    elseif nil ~= Panel_Fishing and true == Panel_Fishing:GetShow() and nil ~= PaGlobalFunc_FishingCheckBox_UpdatePerFrameFunc then
      PaGlobalFunc_FishingCheckBox_UpdatePerFrameFunc(deltaTime)
    end
  end
  if false == isRealServiceMode() then
    if nil ~= PaGlobalFunc_ServantTest_UpdatePerFrameFunc and true == PaGlobal_QAServantSupportOn then
      PaGlobalFunc_ServantTest_UpdatePerFrameFunc(deltaTime)
    end
    if nil ~= PaGlobalFunc_ItemMarketTest_UpdatePerFrameFunc and true == PaGlobal_QAItemMarketSupportOn then
      PaGlobalFunc_ItemMarketTest_UpdatePerFrameFunc(deltaTime)
    end
    if nil ~= PaGlobal_AutoQASupport then
      PaGlobal_AutoQASupport:updatePerFrameFunc()
    end
  end
  if _ContentsGroup_UsePadSnapping then
    FGlobal_KeyGuideTypeCheck(deltaTime)
  end
  if true == _ContentsGroup_FarmingList and nil ~= Panel_Widget_FarmingTimer_All then
    PaGlobalFunc_FarmingTimer_UpdatePerFrame(deltaTime)
  end
  if true == _ContentsGroup_SkillComboGuide then
    PaGlobalFunc_SkillCombo_UpdatePerFrame(deltaTime)
  end
  if true == _ContentsGroup_StackHpBaranimation and nil ~= stackHpBarAnimation then
    stackHpBarAnimation(deltaTime)
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_OnlyPerframeUsed")
function FromClient_luaLoadComplete_OnlyPerframeUsed()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_OnlyPerframeUsed:SetOffsetIgnorePanel(true)
  end
  Panel_OnlyPerframeUsed:SetShow(true)
  Panel_OnlyPerframeUsed:RegisterUpdateFunc("Panel_OnlyPerframeUsedFunction")
end
local ReducedPerframeFunc = {
  AppliedBuffList_Update,
  QuestWidget_ProgressingGuildQuest_UpdateRemainTime,
  PaGlobalFunc_InventoryInfo_SearchCooltime,
  TimeBar_UpdatePerFrame
}
local accumulatedTime = 0
function PaGlobal_ReducedPerframe(deltaTime)
  if false == _ContentsGroup_ReducedLua then
    return
  end
  accumulatedTime = accumulatedTime + deltaTime
  if 1 < accumulatedTime then
    for _, func in pairs(ReducedPerframeFunc) do
      if nil ~= func then
        func(accumulatedTime)
      end
    end
    accumulatedTime = 0
  end
end
