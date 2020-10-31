function PaGlobal_SA_Widget_Survival_Open()
  PaGlobal_SA_Widget_Survival:prepareOpen()
end
function PaGlobal_SA_Widget_Survival_Close()
  PaGlobal_SA_Widget_Survival:prepareClose()
end
function PaGlobal_SA_Widget_Survival_ShowAni()
  if nil == Panel_SA_Widget_Survival then
    return
  end
end
function PaGlobal_SA_Widget_Survival_HideAni()
  if nil == Panel_SA_Widget_Survival then
    return
  end
end
function PaGlobal_SA_Widget_Survival_SetPlayerCount()
  PaGlobal_SA_Widget_Survival._curPlayerCnt = ToClient_BattleRoyaleRemainPlayerCount()
  PaGlobal_SA_Widget_Survival._maxPlayerCnt = math.max(PaGlobal_SA_Widget_Survival._maxPlayerCnt, ToClient_BattleRoyaleTotalPlayerCount())
  local survival_value1 = "<PAColor0xFFF6C42D>" .. PaGlobal_SA_Widget_Survival._curPlayerCnt
  local survival_value2 = PaGlobal_SA_Widget_Survival._maxPlayerCnt
  if PaGlobal_SA_Widget_Survival._curPlayerCnt < 1 then
    survival_value1 = "<PAColor0xFFF6C42D>" .. ToClient_BattleRoyaleTotalPlayerCount()
  end
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value:SetText("/")
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value1:SetText(survival_value1)
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value2:SetText(survival_value2)
end
function PaGlobal_SA_Widget_Survival_AddKillPlayerValue()
  if nil == Panel_SA_Widget_Survival then
    return
  end
  PaGlobal_SA_Widget_Survival._killCount = PaGlobal_SA_Widget_Survival._killCount + 1
  PaGlobal_SA_Widget_Survival:update()
end
function FromClient_SA_Widget_Survival_ReSizePanel()
  Panel_SA_Widget_Survival:ComputePos()
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value1:ComputePos()
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value2:ComputePos()
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value:ComputePos()
  PaGlobal_SA_Widget_Survival._ui.txt_survival_title:ComputePos()
  PaGlobal_SA_Widget_Survival._ui.txt_survival_title:SetText("")
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value1:SetText("")
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value2:SetText("")
  PaGlobal_SA_Widget_Survival._ui.txt_survival_value:SetText("")
  PaGlobal_SA_Widget_Survival._ui.txt_survival_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_SUVIVALTITLE"))
  PaGlobal_SA_Widget_Survival_SetPlayerCount()
end
function FromClient_SA_Widget_Survival_ChangeBattleRoyalePlayerCount()
  PaGlobal_SA_Widget_Survival_SetPlayerCount()
  FromClient_SA_Widget_Survival_ReSizePanel()
  if 40 == PaGlobal_SA_Widget_Survival._maxPlayerCnt then
  elseif 40 < PaGlobal_SA_Widget_Survival._maxPlayerCnt then
  end
end
function FromClient_SA_Widget_Survival_SummonCharacterNoti(characterKey)
  if nil == characterKey then
    return
  end
  local characterWarpper = getCharacterStaticStatusWarpper(characterKey)
  if nil == characterWarpper then
    return
  end
  local monsterName = characterWarpper:getName()
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NOTIFY_SHADOWARENA_CHARACTER_SPAWN", "CharName", monsterName)
  Proc_ShowMessage_Ack(msg)
end
