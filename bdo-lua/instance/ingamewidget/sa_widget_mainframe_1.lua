function PaGlobal_SA_MainFrame:initialize()
  if true == self._initialize then
    return
  end
  self:equipInit()
  self:mainStatusInit()
  self:symbolInit()
  self:buffInit()
  self:skillInit()
  self:itemInit()
  self:createBuffControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_MainFrame:registEventHandler()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:RegisterShowEventFunc(true, "PaGlobal_SA_MainFrame_ShowAni()")
  Panel_SA_MainFrame:RegisterShowEventFunc(false, "PaGlobal_SA_MainFrame_HideAni()")
  registerEvent("onScreenResize", "FromClient_SA_MainFrame_ResizePanel")
  registerEvent("EventCharacterInfoUpdate", "PaGlobalFunc_SA_MainFrame_CharacterInfoWindowUpdate")
  registerEvent("FromClient_SelfPlayerHpChanged", "PaGlobalFunc_SA_MainFrame_CharacterInfoWindowUpdate")
  registerEvent("FromClient_SelfPlayerMpChanged", "PaGlobalFunc_SA_MainFrame_CharacterInfoWindowUpdate")
  registerEvent("EventSelfPlayerLevelUp", "PaGlobalFunc_SA_MainFrame_RefreshHpAlertForLevelup")
  registerEvent("FromClient_DamageByOtherPlayer", "FromClient_DamageByOtherPlayer")
  registerEvent("EventStaminaUpdate", "PaGlobalFunc_SA_MainFrame_UpdateStamina")
  registerEvent("EventEquipmentUpdate", "FromClient_SA_MainFrame_UpdateEquipmentList")
  registerEvent("FromClient_ChangeBattleRoyalePlayerCount", "PaGlobalFunc_SA_MainFrame_APDPShow")
  registerEvent("ResponseBuff_changeBuffList", "PaGlobalFunc_SA_MainFrame_ChangeBuffList")
  registerEvent("EventlearnedSkill", "PaGlobal_SA_MainFrame_ChangeSkillSlotInfo")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "PaGlobal_SA_MainFrame_ChangeSkillPoint")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_SA_MainFrame_UpdateInventory")
  registerEvent("FromClient_BattleRoyaleWinner", "FromClient_SA_MainFrame_EndGame")
  registerEvent("EventAddItemToInventory", "FromClient_SA_MainFrame_AddSkillItem")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_SA_MainFrame_RenderModeChangeState")
  PaGlobal_SA_MainFrame_ItemSlotAddInputEvent()
end
function PaGlobal_SA_MainFrame:prepareOpen()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:RegisterUpdateFunc("PaGlobalFunc_SA_MainFrame_RegisterUpdateFunc")
  PaGlobal_SA_MainFrame:open()
end
function PaGlobal_SA_MainFrame:open()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:SetShow(true, true)
end
function PaGlobal_SA_MainFrame:prepareClose()
  if nil == Panel_SA_MainFrame then
    return
  end
  PaGlobal_SA_MainFrame:close()
end
function PaGlobal_SA_MainFrame:close()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:SetShow(false, false)
end
function PaGlobalFunc_SA_MainFrame_RegisterUpdateFunc(delta)
  PaGlobalFunc_SA_MainFrame_DamageByOtherPlayer_chkOnEffectTime(delta)
  PaGlobalFunc_SA_MainFrame_UpdateBuff(delta)
  PaGlobal_SA_MainFrame_UpdateSkillCoolTime(delta)
  PaGlobal_SA_MainFrame_UpdateItemCoolTime(delta)
  PaGlobalFunc_SA_MainFrame_UpdateStamina()
  PaGlobal_SA_MainFrame_UpdateEffectTime(delta)
end
function PaGlobal_SA_MainFrame:validate()
  if nil == Panel_SA_MainFrame then
    return
  end
  self:equipValidate()
  self:mainStatusValidate()
  self:buffValidate()
  self:skillValidate()
  self:itemValidate()
end
function FromClient_SA_MainFrame_ResizePanel()
  Panel_SA_MainFrame:ComputePos()
  FromClient_SA_MainFrame_MainStatusResizePanel()
  FromClient_SA_MainFrame_EquipResizePanel()
  FromClient_SA_MainFrame_BuffResizePanel()
  FromClient_SA_MainFrame_ItemResizePanel()
  FromClient_SA_MainFrame_SkillResizePanel()
end
function FromClient_SA_MainFrame_RenderModeChangeState(prevRenderModeList, nextRenderModeList)
  FromClient_BuffRunPostRestoreFunction(prevRenderModeList, nextRenderModeList)
  PaGlobalFunc_SA_MainFrame_RenderModeChange_checkHpAlertPostEvent(prevRenderModeList, nextRenderModeList)
end
function PaGlobal_SA_MainFrame_Time_Formatting_ShowTop(second)
  if 3600 < second then
    local recalc_time = second / 3600
    local strHour = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", strHour)
  elseif 60 < second then
    local recalc_time = second / 60
    local strMinute = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", strMinute)
  else
    local recalc_time = second
    local strSecond = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", strSecond)
  end
end
function PaGlobal_SA_MainFrame_ShowAni()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local MainStatusOpen_Alpha = Panel_SA_MainFrame:addColorAnimation(0, 0.35, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  MainStatusOpen_Alpha:SetStartColor(Defines.Color.C_00FFFFFF)
  MainStatusOpen_Alpha:SetEndColor(Defines.Color.C_FFFFFFFF)
  MainStatusOpen_Alpha.IsChangeChild = true
end
function PaGlobal_SA_MainFrame_HideAni()
  if nil == Panel_SA_MainFrame then
    return
  end
  Panel_SA_MainFrame:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local MainStatusClose_Alpha = Panel_SA_MainFrame:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  MainStatusClose_Alpha:SetStartColor(Defines.Color.C_FFFFFFFF)
  MainStatusClose_Alpha:SetEndColor(Defines.Color.C_00FFFFFF)
  MainStatusClose_Alpha.IsChangeChild = true
  MainStatusClose_Alpha:SetHideAtEnd(true)
  MainStatusClose_Alpha:SetDisableWhileAni(true)
end
