function PaGlobal_SA_Widget_KillLog_Open()
  PaGlobal_SA_Widget_KillLog:prepareOpen()
end
function PaGlobal_SA_Widget_KillLog_Close()
  PaGlobal_SA_Widget_KillLog:prepareClose()
end
function FromClient_SA_Widget_KillLog_BattleRoyaleKillLog(attackerName, attackeeName, attackerClassType, attackeeClassType, attackerKey, attackeeKey)
  if nil == attackerName or nil == attackeeName or nil == attackerClassType or nil == attackeeClassType or nil == attackerKey or nil == attackeeKey then
    return
  end
  if nil == PaGlobal_SA_Widget_KillLog._killCount[attackerName] then
    PaGlobal_SA_Widget_KillLog._killCount[attackerName] = 1
  else
    PaGlobal_SA_Widget_KillLog._killCount[attackerName] = PaGlobal_SA_Widget_KillLog._killCount[attackerName] + 1
  end
  local data = {
    winnerName = attackerName,
    winnerClassType = attackerClassType,
    winnerKey = attackerKey,
    loserName = attackeeName,
    loserClassType = attackeeClassType,
    loserKey = attackeeKey,
    attackee_killCount = 0,
    attacker_killCount = 0
  }
  if attackerClassType == CppEnums.ClassType.ClassType_Temp1 or attackerClassType == CppEnums.ClassType.ClassType_Count then
    data.attacker_killCount = 0
    data.attackee_killCount = 0
    return
  end
  data.attacker_killCount = PaGlobal_SA_Widget_KillLog._killCount[attackerName]
  if nil ~= PaGlobal_SA_Widget_KillLog._killCount[attackeeName] then
    data.attackee_killCount = PaGlobal_SA_Widget_KillLog._killCount[attackeeName]
  end
  PaGlobal_SA_Widget_KillLog._dataList:push_back(data)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myName = selfPlayer:getUserNickname()
  if attackerName == myName and CppEnums.ClassType.ClassType_Temp1 ~= attackerClassType and CppEnums.ClassType.ClassType_Count ~= attackerClassType then
    PaGlobal_SA_Widget_KillMark_Open(data)
    PaGlobal_SA_Widget_KillMark_AcquireKillRewards()
    PaGlobal_SA_Widget_Survival_AddKillPlayerValue()
  end
end
function PaGlobal_SA_Widget_KillMark_AcquireKillRewards()
  if false == Panel_SA_Widget_Respon_Time:GetShow() then
    return
  end
  local itemKeys = PaGlobal_SA_Widget_KillLog._rewardItemKeys
  if nil == itemKeys or #itemKeys < 1 then
    return
  end
  for index = 1, #itemKeys do
    local itemKey = itemKeys[index]
    if nil ~= itemKey then
      FromClient_SA_Widget_Looting_Inventory_AddItem(itemKey, nil, Defines.s64_const.s64_1)
      FromClient_SA_MainFrame_AddSkillItem(itemKey, nil, Defines.s64_const.s64_1)
    end
  end
end
function FromClient_SA_Widget_KillLog_ReSizePanel()
  Panel_SA_KillLog:ComputePos()
  PaGlobal_SA_Widget_KillLog._ui.stc_killLogBG:ComputePos()
  for index = 0, PaGlobal_SA_Widget_KillLog._maxKillLogCnt do
    if nil ~= PaGlobal_SA_Widget_KillLog._killLog[index] then
      PaGlobal_SA_Widget_KillLog._killLog[index].stc_killLogBG:ComputePos()
      PaGlobal_SA_Widget_KillLog._killLog[index].stc_winnerIcon:ComputePos()
      PaGlobal_SA_Widget_KillLog._killLog[index].txt_verse:ComputePos()
      PaGlobal_SA_Widget_KillLog._killLog[index].stc_loserIcon:ComputePos()
      PaGlobal_SA_Widget_KillLog._killLog[index].txt_killLog:ComputePos()
    end
    PaGlobal_SA_Widget_KillLog:reposition(index)
  end
end
function PaGlobal_SA_Widget_KillLog_Update(deltaTime)
  PaGlobal_SA_Widget_KillLog:updateTime(deltaTime)
  PaGlobal_SA_Widget_KillLog:updateAddLog(deltaTime)
end
function PaGlobal_SA_Widget_KillLog_ShowAni()
  if nil == Panel_SA_Interaction then
    return
  end
end
function PaGlobal_SA_Widget_KillLog_HideAni()
  if nil == Panel_SA_Interaction then
    return
  end
end
