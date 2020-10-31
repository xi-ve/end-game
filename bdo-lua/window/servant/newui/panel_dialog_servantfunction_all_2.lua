function PaGlobalFunc_ServantFunction_All_Open(isGuild, servantType)
  if nil == isGuild or nil == servantType or nil == Panel_Dialog_ServantFunction_All or true == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  PaGlobal_ServantFunction_All._isGuild = isGuild
  PaGlobal_ServantFunction_All:prepareOpen(isGuild, servantType)
end
function HandleEventPadPress_ServantFunction_All_ChangeTab(isUp)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  local tempIdx = PaGlobal_ServantFunction_All._currentTab
  if nil == PaGlobal_ServantFunction_All._tempBtnTable or PaGlobal_ServantFunction_All._currentNpcType == PaGlobal_ServantFunction_All._ENUM_NPC_TYPE._SEA then
    return
  end
  if true == isUp then
    tempIdx = tempIdx + 1
    if tempIdx > PaGlobal_ServantFunction_All._ENUM._COUNT - 2 then
      tempIdx = 0
    end
  else
    tempIdx = tempIdx - 1
    if tempIdx < 0 then
      tempIdx = PaGlobal_ServantFunction_All._ENUM._COUNT - 2
    end
  end
  local changedIdx = PaGlobal_ServantFunction_All._tempBtnTable[tempIdx]
  if nil == PaGlobal_ServantFunction_All._tempBtnTable[tempIdx] then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(changedIdx)
end
function PaGlobalFunc_ServantFunction_All_ChangeTab(idx)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if nil == idx or nil == Panel_Dialog_ServantList_All or nil == Panel_Dialog_ServantExchange_All or nil == Panel_Dialog_ServantMarket_Rental_Mating_All or nil == Panel_Dialog_ServantLookChange_All or nil == Panel_Dialog_ServantCarriageLink_All or nil == Panel_Dialog_ServantMarket_All or nil == Panel_Dialog_ServantSwiftTraining_All or nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  TooltipSimple_Hide()
  PaGlobalFunc_ServantExchange_All_Close()
  PaGlobalFunc_ServantSkillManagement_All_Close()
  PaGlobalFunc_ServantSwiftTraining_All_Close()
  PaGlobalFunc_ServantRegist_All_Close()
  PaGlobalFunc_ServantTransferList_All_Close()
  PaGlobalFunc_ServantMarket_Rental_Mating_All_Close()
  PaGlobalFunc_ServantMarket_All_Close()
  PaGlobalFunc_ServantCarriageLink_All_Close()
  PaGlobalFunc_ServantLookChange_All_Close()
  PaGlobalFunc_ServantNameRegist_All_Close()
  if true == self._isConsole then
    PaGlobalFunc_ServantInfo_All_SetIgnoreSnapToOtherPanel(false)
  end
  if true == _ContentsGroup_Sailor and nil ~= PaGlobal_SailorManager_All then
    PaGlobal_SailorManager_All:prepareCloseForce()
  end
  if false == Panel_Dialog_ServantList_All:GetShow() then
    PaGlobalFunc_ServantList_All_Open()
  end
  if PaGlobal_ServantFunction_All._ENUM._LIST == idx then
    PaGlobalFunc_ServantList_All_Open()
  elseif PaGlobal_ServantFunction_All._ENUM._LINK == idx then
    PaGlobalFunc_ServantCarriageLink_All_Open()
  elseif PaGlobal_ServantFunction_All._ENUM._EXCHANGE == idx then
    PaGlobalFunc_ServantExchange_All_Open()
  elseif PaGlobal_ServantFunction_All._ENUM._MATING == idx then
    PaGlobalFunc_ServantMarket_Rental_Mating_All_Open(true)
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._MARKET == idx then
    PaGlobalFunc_ServantMarket_All_Open()
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  elseif PaGlobal_ServantFunction_All._ENUM._RENTAL == idx then
    PaGlobalFunc_ServantMarket_Rental_Mating_All_Open(false)
    PaGlobalFunc_ServantFunction_All_SidePanelClose()
  else
    return
  end
  PaGlobal_ServantFunction_All._currentTab = idx
  if nil ~= Panel_Dialog_ServantList_All and PaGlobal_ServantFunction_All._ENUM._LIST ~= idx then
    PaGlobalFunc_ServantList_All_SubMenuClose()
  end
  local selectBarPosX = PaGlobal_ServantFunction_All._tabButtonForCategory[idx]:GetSpanSize().x + 50
  PaGlobal_ServantFunction_All._ui._stc_TabButtonBar:SetSpanSize(selectBarPosX, PaGlobal_ServantFunction_All._ui._stc_TabButtonBar:GetSpanSize().y)
  for tabIdx = 0, #PaGlobal_ServantFunction_All._tabButtonForCategory do
    if nil ~= PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx] then
      if tabIdx == idx then
        PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:SetCheck(true)
      else
        PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:SetCheck(false)
      end
    end
  end
end
function PaGlobalFunc_ServantFunction_All_SidePanelClose()
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobalFunc_ServantList_All_Close()
  end
  if nil ~= Panel_Dialog_ServantInfo_All then
    PaGlobalFunc_ServantInfo_All_Close()
  end
end
function PaGlobalFunc_ServantFunction_All_Close()
  if nil == Panel_Dialog_ServantFunction_All and false == Panel_Dialog_ServantFunction_All then
    return
  end
  if true == Panel_Dialog_ServantOnlyList_All:GetShow() then
    PaGlobalFunc_ServantOnlyList_All_Close()
    return
  end
  local panelList = {
    Panel_Dialog_ServantExchange_All,
    Panel_Dialog_ServantSwiftTraining_All,
    Panel_Dialog_ServantSkillManagement_All,
    Panel_Dialog_ServantRegist_All,
    Panel_Dialog_ServantTransferList_All,
    Panel_Dialog_ServantMarket_All,
    Panel_Dialog_ServantMarket_Rental_Mating_All,
    Panel_Dialog_ServantCarriageLink_All,
    Panel_Window_SailorManager_All,
    Panel_Window_ShipEquipManagement_ALL,
    Panel_Dialog_ServantNameRegist_All,
    Panel_Window_CargoLoading_ALL,
    Panel_Window_ServantUpgradeInfo,
    Panel_Window_ServantUpgrade,
    Panel_Dialog_ServantLookChange_All
  }
  local closeFuntion = {
    PaGlobalFunc_ServantExchange_All_Close,
    PaGlobalFunc_ServantSwiftTraining_All_Close,
    PaGlobalFunc_ServantSkillManagement_All_Close,
    PaGlobalFunc_ServantRegist_All_Close,
    PaGlobalFunc_ServantTransferList_All_Close,
    PaGlobalFunc_ServantMarket_All_Close,
    PaGlobalFunc_ServantMarket_Rental_Mating_All_Close,
    PaGlobalFunc_ServantCarriageLink_All_Close,
    PaGlobal_SailorManager_All_CloseForce,
    HandleEventMLUp_ShipEquipManagement_Close,
    PaGlobalFunc_ServantNameRegist_All_Close,
    HandleEventMLUp_CargoLoading_Close,
    PaGlobal_ServantUpgradeInfo_Close,
    HandleEventLUp_ServantUpgrade_Cancel,
    PaGlobalFunc_ServantLookChange_All_Close
  }
  for i = 1, #panelList do
    if nil ~= panelList[i] and true == panelList[i]:GetShow() then
      closeFuntion[i]()
      PaGlobalFunc_ServantFunction_All_ChangeTab(0)
      return
    end
  end
  PaGlobal_ServantFunction_All:prepareClose()
end
function PaGlobalFunc_ServantFunction_All_ForceClose()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  PaGlobal_ServantFunction_All:prepareClose()
end
function PaGlobalFunc_ServantFunction_All_GetIsGuild(isTest)
  if true == isTest then
    return false
  end
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  return PaGlobal_ServantFunction_All._isGuild
end
function FromClient_ServantFunction_All_OnScreenResize()
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  local screenX = getScreenSizeX()
  Panel_Dialog_ServantFunction_All:SetSize(screenX, Panel_Dialog_ServantFunction_All:GetSizeY())
  Panel_Dialog_ServantFunction_All:ComputePos()
  for tabIdx = 0, #PaGlobal_ServantFunction_All._tabButtonForCategory do
    if nil ~= PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx] then
      PaGlobal_ServantFunction_All._tabButtonForCategory[tabIdx]:ComputePos()
    end
  end
end
function PaGlobalFunc_ServantFunction_All_TempOnOff(isOn)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  Panel_Dialog_ServantFunction_All:SetShow(isOn)
end
function PaGlobalFunc_ServantFunction_All_Get_NpcType()
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  if nil == PaGlobal_ServantFunction_All._currentNpcType then
    return
  end
  return PaGlobal_ServantFunction_All._currentNpcType
end
function PaGlobalFunc_ServantFunction_All_EffectFilter_Mapae(slotNo, itemWrapper)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local returnValue = true
  local isMapae = itemSSW:get():isMapae()
  local isGuildMapae = itemSSW:get():isGuildMapae()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  local npcType = ToClient_GetServnatTypeFromNpc()
  if npcType ~= itemSSW:get():getMapaeServantType() then
    return true
  end
  if isGuildStable() then
    if isGuildMapae then
      returnValue = true
    else
      returnValue = false
    end
  elseif isMapae and not isGuildMapae then
    returnValue = true
  else
    returnValue = false
  end
  return not returnValue
end
function PaGlobalFunc_ServantFunction_All_ScenePushObject(servantInfo, beforeSceneIndex)
  if nil == Panel_Dialog_ServantFunction_All then
    return
  end
  if nil == servantInfo then
    return
  end
  local characterKeyRaw = servantInfo:getCharacterKeyRaw()
  local afterSceneIndex = getIndexByCharacterKey(characterKeyRaw)
  if beforeSceneIndex == afterSceneIndex then
    return beforeSceneIndex
  end
  if -1 ~= beforeSceneIndex then
    showSceneCharacter(beforeSceneIndex, false)
  end
  if -1 ~= afterSceneIndex then
    showSceneCharacter(afterSceneIndex, true)
    if not isGuildStable() then
      stable_previewEquipItem(afterSceneIndex)
    end
  end
  return afterSceneIndex
end
function PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(sceneIndex)
  if nil == Panel_Dialog_ServantFunction_All or false == Panel_Dialog_ServantFunction_All:GetShow() then
    return
  end
  if -1 ~= sceneIndex and nil ~= sceneIndex then
    showSceneCharacter(sceneIndex, false)
  end
end
