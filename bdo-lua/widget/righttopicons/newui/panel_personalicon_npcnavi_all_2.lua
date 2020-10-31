function InputMLUp_NpcNavi_SetWarehouseNavi(index)
  local actorKey = PaGlobal_NpcNavi_All._territoryTownData[index]._actorKey
  if NpcConditionCheck(actorKey) then
    ToClient_DeleteNaviGuideByGroup(0)
    worldmapNavigatorStart(float3(PaGlobal_NpcNavi_All._territoryTownData[index]._x, PaGlobal_NpcNavi_All._territoryTownData[index]._y, PaGlobal_NpcNavi_All._territoryTownData[index]._z), NavigationGuideParam(), false, false, true)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_NOKNOWLEDGE"))
  end
end
function InputMOn_NpcNavi_TownWarehouseTooltip(index)
  local name = PaGlobal_NpcNavi_All._territoryTownData[index]._desc
  local uiControl = PaGlobal_NpcNavi_All._warehouseBtns[index]
  local desc
  if nil == index then
    TooltipSimple_Hide()
  else
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function InputMLUp_NpcNavi_DrawLine(key)
  ToClient_DeleteNaviGuideByGroup(0)
  local spawnRegionData = PaGlobal_NpcNavi_All:getSelectItemSpawnRegionData()
  if nil == spawnRegionData then
    return
  end
  if NpcConditionCheck(spawnRegionData:getKeyRaw()) then
    if spawnRegionData:hasTimeSpawn() and spawnRegionData:isTimeSpawn(math.floor(getIngameTime_minute() / 60)) == false then
      NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
    end
    worldmapNavigatorStart(spawnRegionData:getPosition(), NavigationGuideParam(), false, false, true)
  else
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOFIND"))
    return
  end
end
function PaGlobal_NpcNavi_All_AutoRun()
  if false == ToClient_WorldMapNaviEmpty() then
    local naviEndPoint = ToClient_getNavigationMoveEndPoint()
    ToClient_DeleteNaviGuideByGroup(0)
    worldmapNavigatorStart(naviEndPoint, NavigationGuideParam(), true, false, true)
  end
end
function InputMLUp_NpcNavi_SearchNpc()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  PaGlobal_NpcNavi_All.filterText = PaGlobal_NpcNavi_All._ui.edit_Serarch:GetEditText()
  local overIndex = PaGlobal_NpcNavi_All._ui.tree_Npc:GetOverIndex()
  PaGlobal_NpcNavi_All:treeClear()
  PaGlobal_NpcNavi_All:npcListUpdate()
  if true == PaGlobal_NpcNavi_All._isConsole then
    local itemQuantity = PaGlobal_NpcNavi_All._ui.tree_Npc:GetItemQuantity()
    local showListSize = PaGlobal_NpcNavi_All._ui.tree_Npc:GetShowItemCount()
    local newOverIndex = math.min(overIndex, math.min(showListSize - 1, itemQuantity - 1))
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetOverIndex(newOverIndex)
  end
end
function InputMLUp_NpcNavi_SetFoucsEdit()
  SetFocusEdit(PaGlobal_NpcNavi_All._ui.edit_Serarch)
  PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText("")
end
function PaGlobal_NpcNavi_All_SetTreeKeyGuide()
  if false == PaGlobal_NpcNavi_All._isConsole then
    return
  end
  PaGlobal_NpcNavi_All._ui_console.stc_KeyGuideBG:SetShow(true)
  local keyGuides = {
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideDPadHor,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideDPadVer,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideA,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_NpcNavi_All._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_NpcNavi_All_OverBarUpdatePerFrame(deltaTime)
  PaGlobal_NpcNaviTooltip_OverBarUpdate(true)
  if true == PaGlobal_NpcNavi_All._isConsole and true == keyCustom_IsUp_Action(__eActionInputType_AutoRun) then
    PaGlobal_NpcNavi_All_AutoRun()
  end
end
function FromClient_NpcNavi_All_RregionChanged()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  elseif PaGlobal_NpcNavi_All.lazyUpdate then
    PaGlobal_NpcNavi_All:npcListUpdate()
  end
end
function FromClient_NpcNavi_All_MentalCardUpdate()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  end
  PaGlobal_NpcNavi_All:npcListUpdate()
end
function FromClient_NpcNavi_All_ExplorePointUpdate()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  end
  PaGlobal_NpcNavi_All:npcListUpdate()
end
function FromClient_NpcNavi_All_OnScreenResize()
  if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetItemQuantity(PaGlobal_NpcNavi_All._ui.tree_Npc:GetSizeY() / 195 * 8)
    PaGlobal_NpcNavi_All._ui.tree_Npc:setAddImagePosY(5)
  else
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetItemQuantity(PaGlobal_NpcNavi_All._ui.tree_Npc:GetSizeY() / 465 * 25)
    PaGlobal_NpcNavi_All._ui.tree_Npc:setAddImagePosY(2)
  end
end
function PaGlobal_NpcNavi_All_ReturnKeyEvent(isOk)
  if true ~= isOk then
    PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText("")
  end
  InputMLUp_NpcNavi_SearchNpc()
  ClearFocusEdit()
end
function PaGlobal_NpcNavi_All_SearchNpc(str)
  if nil ~= str then
    PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText(str)
    InputMLUp_NpcNavi_SearchNpc()
  end
  ClearFocusEdit()
end
function NpcConditionCheck(keyRaw)
  if false == IsUseDynamicBSS() then
    return checkActiveCondition(keyRaw)
  else
    return npcCheckActiveCondition(keyRaw)
  end
end
function IsUseDynamicBSS()
  if true == ToClient_isUseDynamicBSS(__eDynamicBSSType_Character) or true == ToClient_isUseDynamicBSS(__eDynamicBSSType_Dialog) then
    return true
  end
  return false
end
function PaGlobal_NpcNavi_All_SetOverIndex(index)
  PaGlobal_NpcNavi_All._ui.tree_Npc:SetOverIndex(index)
end
function PaGlobal_NpcNavi_All_GetOverIndex()
  return PaGlobal_NpcNavi_All._ui.tree_Npc:GetOverIndex()
end
function PaGlobal_NpcNavi_All_ShowToggle()
  local isShow = not Panel_NpcNavi_All:IsShow()
  if isShow then
    PaGlobal_NpcNavi_All_ResetPosistion()
    PaGlobal_NpcNavi_All:prepareOpen()
  else
    PaGlobal_NpcNavi_All:clearFocusEdit()
    PaGlobal_NpcNavi_All:prepareClose()
  end
  if false == isShow then
    if ToClient_WorldMapIsShow() then
      WorldMapPopupManager:pop()
    end
    PaGlobal_NpcNavi_Tooltip:prepareClose()
  else
    PaGlobal_NpcNavi_All:updateTownNavi()
    if PaGlobal_NpcNavi_All.lazyUpdate then
      PaGlobal_NpcNavi_All:npcListUpdate()
      PaGlobal_NpcNavi_All.lazyUpdate = false
    end
  end
  Panel_NpcNavi_All:EraseAllEffect()
  local rndNo_1 = math.random(0, 30)
  local rndNo_2 = math.random(30, 60)
  if Panel_WorldMap:GetShow() then
    Panel_NpcNavi_All:SetPosX(getScreenSizeX() - Panel_NpcNavi_All:GetSizeX() - 300)
    Panel_NpcNavi_All:SetPosY(30)
  else
    PaGlobal_NpcNavi_All_ResetPosistion()
  end
  Panel_NpcNavi_All:SetPosX(Panel_NpcNavi_All:GetPosX() - rndNo_1)
  Panel_NpcNavi_All:SetPosY(Panel_NpcNavi_All:GetPosY() + rndNo_2)
  PaGlobal_TutorialManager:handleNpcNavi_ShowToggle(isShow)
end
function PaGlobal_NpcNavi_All_ResetPosistion()
  Panel_NpcNavi_All:SetPosX(FGlobal_Panel_Radar_GetPosX() - Panel_NpcNavi_All:GetSizeX())
  Panel_NpcNavi_All:SetPosY(FGlobal_Panel_Radar_GetPosY())
end
function PaGlobal_NpcNavi_All_HideAni()
  Panel_NpcNavi_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_NpcNavi_All, 0, 0.75)
  aniInfo:SetHideAtEnd(true)
end
function FGlobal_NpcNavi_Hide()
  local isShow = Panel_NpcNavi_All:IsShow()
  if isShow then
    PaGlobal_NpcNavi_All:clearFocusEdit()
  end
  PaGlobal_NpcNavi_All:prepareClose()
  PaGlobal_NpcNavi_Tooltip:prepareClose()
end
function FGlobal_NpcNavi_IsShowCheck()
  return Panel_NpcNavi_All:IsShow()
end
function PaGlobal_NpcNavi_All_ShowRequestOuter()
  PaGlobal_NpcNavi_All:clearFocusEdit()
end
function NpcNavi_CheckCurrentUiEdit(_npcNavi_TargetUI)
  return nil ~= _npcNavi_TargetUI and _npcNavi_TargetUI:GetKey() == PaGlobal_NpcNavi_All._ui.edit_Serarch:GetKey()
end
function FGlobal_NpcNavi_PanelSizeSetting(iconCount)
  PaGlobal_NpcNavi_All:panelSizeSetting(iconCount)
end
