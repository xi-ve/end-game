function PaGlobal_WarInfomation_All_ShowAni()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
end
function PaGlobal_WarInfomation_All_HideAni()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
end
function PaGlobal_WarInfomation_All_Open(buildingInfo)
  if true == ToClient_WorldMapIsShow() then
    PaGlobal_WarInfomation_All:prepareOpen(buildingInfo)
    return
  end
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  if nil == characterStaticWrapper then
    return
  end
  local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
  local isHealingTower = objectStaticWrapper:isHealingTower()
  local isObservatory = objectStaticWrapper:isObservatory()
  local isElephantBarn = objectStaticWrapper:isElephantBarn()
  local isCatapultFactory = objectStaticWrapper:isCatapultFactory()
  local isFlameFactory = objectStaticWrapper:isFlameFactory()
  local isBarricade = objectStaticWrapper:isBarricade()
  local isDistributor = objectStaticWrapper:isDistributor()
  local isBarricadeGate = objectStaticWrapper:isBarricadeGate()
  local isWoodenFence = objectStaticWrapper:isWoodenFenceBase()
  local isDefenceTower = objectStaticWrapper:isDefenceTower()
  local isSiegeTower = objectStaticWrapper:isSiegeTower()
  local isLargeSiegeTower = objectStaticWrapper:isLargeSiegeTower()
  local isAdvanceBaseTower = objectStaticWrapper:isAdvancedBaseTower()
  local isSavageDefenceObject = objectStaticWrapper:isSavageDefenceObject()
  local isBallistaFactory = objectStaticWrapper:isBallistaFactory()
  local isMinorWarOpen = isHealingTower or isObservatory or isElephantBarn or isCatapultFactory or isFlameFactory or isBarricade or isDistributor or isBarricadeGate or isWoodenFence or isDefenceTower or isSiegeTower or isLargeSiegeTower or isAdvanceBaseTower or isBallistaFactory or isSavageDefenceObject
  if false == isMinorWarOpen then
    PaGlobal_WarInfomation_All_Close()
    return
  end
  PaGlobal_WarInfomation_All:prepareOpen(buildingInfo)
end
function PaGlobal_WarInfomation_All_Close()
  PaGlobal_WarInfomation_All:prepareClose()
  PaGlobal_InstallationModeWar_All_Close()
end
