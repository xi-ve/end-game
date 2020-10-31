Panel_NpcNavi:setMaskingChild(true)
Panel_Tooltip_NpcNavigation:setMaskingChild(true)
Panel_NpcNavi:ActiveMouseEventEffect(true)
if false == _ContentsGroup_RenewUI_Main then
  Panel_NpcNavi:setGlassBackground(true)
end
local npcNaviText = UI.getChildControl(Panel_NpcNavi, "StaticText_npcNaviText")
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local _math_AddVectorToVector = Util.Math.AddVectorToVector
local _math_MulNumberToVector = Util.Math.MulNumberToVector
local UILink = {
  treeView = UI.getChildControl(Panel_NpcNavi, "Tree_View"),
  closeNpcNavi = UI.getChildControl(Panel_NpcNavi, "Button_Win_Close"),
  staticSearchBack = UI.getChildControl(Panel_NpcNavi, "StaticSearchBack"),
  editSearchText = UI.getChildControl(Panel_NpcNavi, "EditSearchText"),
  btnSearch = UI.getChildControl(Panel_NpcNavi, "BtnSearch"),
  textSubject = UI.getChildControl(Panel_NpcNavi, "StaticText_Subject"),
  errorMessage = UI.getChildControl(Panel_NpcNavi, "StaticText_ErrorNotice"),
  tooltip = Panel_Tooltip_NpcNavigation,
  tooltip_NpcName = UI.getChildControl(Panel_Tooltip_NpcNavigation, "Tooltip_NpcName"),
  tooltip_text = UI.getChildControl(Panel_Tooltip_NpcNavigation, "Tooltip_NpcDescription"),
  tooltip_itemName = UI.getChildControl(Panel_Tooltip_NpcNavigation, "StaticText_ItemName"),
  tooltip_Icon = UI.getChildControl(Panel_Tooltip_NpcNavigation, "Static_Icon"),
  tooltip_NeedExplorePoint = UI.getChildControl(Panel_Tooltip_NpcNavigation, "StaticText_NeedExplorePoint"),
  tooltip_Description = UI.getChildControl(Panel_Tooltip_NpcNavigation, "StaticText_Description"),
  tooltip_NotFind = UI.getChildControl(Panel_Tooltip_NpcNavigation, "StaticText_NotFound"),
  tooltip_ProgressBG = UI.getChildControl(Panel_Tooltip_NpcNavigation, "Static_ProgressBG"),
  tooltip_CircularProgress = UI.getChildControl(Panel_Tooltip_NpcNavigation, "CircularProgress_Current"),
  tooltip_FruitageValue = UI.getChildControl(Panel_Tooltip_NpcNavigation, "StaticText_Fruitage_Value"),
  tooltip_GiftIcon = UI.getChildControl(Panel_Tooltip_NpcNavigation, "Static_GiftIcon"),
  initPosX = Panel_NpcNavi:GetPosX(),
  initPosY = Panel_NpcNavi:GetPosY()
}
local _scroll = UI.getChildControl(UILink.treeView, "Tree_1_Scroll")
local townBg = UI.getChildControl(Panel_NpcNavi, "Static_Bg3")
local townNavi = {
  [1] = UI.getChildControl(townBg, "Button_1"),
  [2] = UI.getChildControl(townBg, "Button_2"),
  [3] = UI.getChildControl(townBg, "Button_3"),
  [4] = UI.getChildControl(townBg, "Button_4"),
  [6] = UI.getChildControl(townBg, "Button_6"),
  [7] = UI.getChildControl(townBg, "Button_7"),
  [8] = UI.getChildControl(townBg, "Button_8")
}
local territoryTownData = {
  [1] = {
    _x = 8489.57,
    _y = -7818.83,
    _z = 82973.3,
    _actorKey = 40044,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_1"),
    _isOpen = true
  },
  [2] = {
    _x = 40853.2,
    _y = -3474.33,
    _z = -50928,
    _actorKey = 41013,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_2"),
    _isOpen = true
  },
  [3] = {
    _x = -254083,
    _y = -2754.48,
    _z = -40846.4,
    _actorKey = 42138,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_3"),
    _isOpen = ToClient_IsContentsGroupOpen("2")
  },
  [4] = {
    _x = 364177,
    _y = -4957.73,
    _z = -74140.1,
    _actorKey = 44019,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_4"),
    _isOpen = ToClient_IsContentsGroupOpen("3")
  },
  [6] = {
    _x = -514130,
    _y = 8984.42,
    _z = -455421,
    _actorKey = 45555,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_6"),
    _isOpen = ToClient_IsContentsGroupOpen("5")
  },
  [7] = {
    _x = -46455.86,
    _y = 22008.5,
    _z = -403908.03,
    _actorKey = 46008,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_7"),
    _isOpen = ToClient_IsContentsGroupOpen("6")
  },
  [8] = {
    _x = -172548.02,
    _y = 19582.9,
    _z = -611631,
    _actorKey = 47008,
    _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_WAREHOUSE_8"),
    _isOpen = ToClient_IsContentsGroupOpen("7")
  }
}
local resizingGap = {
  treeGap = Panel_NpcNavi:GetSizeX() - UILink.treeView:GetSizeX(),
  tooltipDescExplorePointGap = UILink.tooltip_NeedExplorePoint:GetPosY() - UILink.tooltip_Description:GetPosY() - UILink.tooltip_Description:GetTextSizeY(),
  tooltipExplorePointPanelGap = Panel_Tooltip_NpcNavigation:GetSizeY() - UILink.tooltip_NeedExplorePoint:GetPosY() - UILink.tooltip_NeedExplorePoint:GetTextSizeY()
}
local naviDesc = UI.getChildControl(Panel_NpcNavi, "StaticText_NpcNavi_Desc")
naviDesc:SetTextMode(__eTextMode_AutoWrap)
naviDesc:SetText(naviDesc:GetText())
local lazyUpdate = false
local overIndex = -1
local selectIndex = -1
local treeGroupData = {}
local preLoadTextureKey = {}
local preLoadTextureKey_territory = {}
local cacheExecuteDialogData = {}
local cachingCharacterData = {}
local filterText = ""
local isMouseOnPanel = false
local isMouseOnTreeView = false
local isFirstUpdate = true
local errorMessageShow = true
local searchGroupShow = function(isShow)
end
local isChecked_AddEffect = 0
local isChecked_EffectReset = 0
local function initialize()
  Panel_NpcNavi:SetShow(false, false)
  Panel_Tooltip_NpcNavigation:SetShow(false, false)
  Panel_NpcNavi:SetAlpha(1)
  Panel_NpcNavi:SetIgnore(false)
  Panel_NpcNavi:addInputEvent("Mouse_On", "NpcNavi_ChangeTexture_On()")
  Panel_NpcNavi:addInputEvent("Mouse_Out", "NpcNavi_ChangeTexture_Off()")
  UILink.treeView:SetShow(true)
  UILink.staticSearchBack:SetShow(true)
  UILink.editSearchText:SetShow(true)
  UILink.btnSearch:SetShow(true)
  UILink.textSubject:SetShow(true)
  UILink.errorMessage:SetShow(false)
  UILink.closeNpcNavi:SetShow(true)
  Panel_NpcNavi:RegisterUpdateFunc("NpcNavi_OverBarUpdatePerFrame")
  registerEvent("selfPlayer_regionChanged", "NpcListUpdate_selfPlayer_regionChanged")
  registerEvent("EventMentalCardUpdate", "NpcListUpdate_EventMentalCardUpdate")
  registerEvent("EventExplorePointUpdate", "NpcListUpdate_EventExplorePointUpdate")
  registerEvent("onScreenResize", "NpcListUpdate_ScreenResize")
  UILink.treeView:addInputEvent("Mouse_LUp", "NpcNavi_DrawLine()")
  UILink.treeView:addInputEvent("Mouse_On", "NpcNavi_TreeViewInOut(true)")
  UILink.treeView:addInputEvent("Mouse_Out", "NpcNavi_TreeViewInOut(false)")
  UILink.closeNpcNavi:addInputEvent("Mouse_LUp", "NpcNavi_ShowToggle()")
  UILink.btnSearch:addInputEvent("Mouse_LDown", "NpcNavi_SearchBtn()")
  UILink.editSearchText:addInputEvent("Mouse_LDown", "NpcNavi_OnInputMode()")
  UILink.editSearchText:addInputEvent("Mouse_LUp", "NpcNavi_OnInputMode()")
  UILink.editSearchText:RegistReturnKeyEvent("NpcNavi_OutInputMode( true )")
  preLoadTextureKey[0] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_general.dds")
  preLoadTextureKey[1] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_skill.dds")
  preLoadTextureKey[2] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_artisan.dds")
  preLoadTextureKey[3] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_store_liquid.dds")
  preLoadTextureKey[4] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_general.dds")
  preLoadTextureKey[5] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_store_liquid.dds")
  local territoryCount = getTerritoryInfoCount()
  for i = 1, territoryCount do
    local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(i - 1)
    if nil ~= territoryInfoWrapper then
      preLoadTextureKey_territory[territoryInfoWrapper:getKeyRaw()] = preLoadTexture(territoryInfoWrapper:getTerritorySmallImage())
    end
  end
  local showCount = 0
  for index, control in pairs(townNavi) do
    control:addInputEvent("Mouse_LUp", "HandleClicked_TownNavi(" .. index .. ")")
    control:addInputEvent("Mouse_On", "TownWarehouse_TooltipSimpleShow(" .. index .. ")")
    control:addInputEvent("Mouse_Out", "TownWarehouse_TooltipSimpleHide()")
    control:SetShow(territoryTownData[index]._isOpen)
    if territoryTownData[index]._isOpen then
      showCount = showCount + 1
    end
  end
  if 7 <= showCount then
    local bgSizeX = townBg:GetSizeX()
    local btnSizeX = townNavi[1]:GetSizeX()
    local totalSizeX = btnSizeX * showCount
    local gapSizeX = math.floor((bgSizeX - totalSizeX) / (showCount + 1))
    local posX = gapSizeX
    for index = 1, 8 do
      if nil ~= territoryTownData[index] and territoryTownData[index]._isOpen then
        townNavi[index]:SetPosX(posX)
        posX = posX + gapSizeX + btnSizeX
      end
    end
  end
end
function HandleClicked_TownNavi(index)
  local actorKey = territoryTownData[index]._actorKey
  if NpcConditionCheck(actorKey) then
    NpcNavi_Clear()
    worldmapNavigatorStart(float3(territoryTownData[index]._x, territoryTownData[index]._y, territoryTownData[index]._z), NavigationGuideParam(), false, false, true)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_NOKNOWLEDGE"))
  end
end
function TownWarehouse_TooltipSimpleShow(index)
  local name = territoryTownData[index]._desc
  local uiControl = townNavi[index]
  local desc
  if nil == index then
    TooltipSimple_Hide()
  else
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function TownWarehouse_TooltipSimpleHide()
  TooltipSimple_Hide()
end
function FGlobal_NpcNavi_HideAni()
  Panel_NpcNavi:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_NpcNavi, 0, 0.75)
  aniInfo:SetHideAtEnd(true)
end
local function AddEffectList(list)
  local itemHeight = UILink.treeView:GetSizeY() / UILink.treeView:GetItemQuantity()
  for keyRaw, index in pairs(list) do
    local pos = UILink.treeView:getViewIndex(index)
    if pos.x ~= -1 or pos.y ~= -1 then
      UILink.treeView:AddEffect("UI_DarkSpiritQuestSubject", false, pos.x - UILink.treeView:GetSizeX() / 5, pos.y - UILink.treeView:GetSizeY() / 2 + itemHeight / 2)
    end
  end
end
local function checkIsNewAdd(index, key)
  if true == cachingCharacterData[key] then
    return false
  else
    cachingCharacterData[key] = true
    return true
  end
end
local function clearFocusEdit()
  if NpcNavi_CheckCurrentUiEdit(GetFocusEdit()) then
    ClearFocusEdit()
    CheckChattingInput()
    searchGroupShow(false)
    UILink.editSearchText:SetEditText("")
  end
end
local function getCacheDialogData(characterKeyRaw, dialogIndex)
  if nil == cacheExecuteDialogData[characterKeyRaw] then
    if false == IsUseDynamicBSS() then
      local executeDisplayData = dialog_getExecuteDisplayDataWithoutActor(characterKeyRaw, dialogIndex)
      if nil ~= executeDisplayData then
        local insertData = {
          itemName = "",
          itemPath = "",
          needPoint = 0
        }
        local itemSSW = getItemEnchantStaticStatus(executeDisplayData:getItemKey())
        if nil ~= itemSSW then
          insertData.itemName = itemSSW:getName()
          insertData.itemPath = itemSSW:getIconPath()
          insertData.itemDescription = itemSSW:getDescription()
          insertData.needAdditionalCondtion = 0 < dialog_getExecuteDisplayDataWithoutActorCount(characterKeyRaw, dialogIndex)
        else
          insertData.needAdditionalCondtion = false
        end
        insertData.needPoint = executeDisplayData._needPoint
        insertData.territoryKey = executeDisplayData._territoryKey:get()
        cacheExecuteDialogData[characterKeyRaw] = insertData
      end
    elseif true == isNpcItemKeyExist(characterKeyRaw) then
      local insertData = {
        itemName = "",
        itemPath = "",
        needPoint = 0
      }
      local itemSSW = getItemEnchantStaticStatus(getNpcItemKey(characterKeyRaw))
      if nil ~= itemSSW then
        insertData.itemName = itemSSW:getName()
        insertData.itemPath = itemSSW:getIconPath()
        insertData.itemDescription = itemSSW:getDescription()
        insertData.needAdditionalCondtion = isNeedAdditionalCondition(characterKeyRaw)
      end
      insertData.needPoint = getNpcNeedPoint(characterKeyRaw)
      insertData.territoryKey = getNpcTerritoryKey(characterKeyRaw)
      cacheExecuteDialogData[characterKeyRaw] = insertData
    end
  end
  return cacheExecuteDialogData[characterKeyRaw]
end
local getByKey = function(key, list)
  for k, v in pairs(list) do
    if v.key == key then
      return v
    end
  end
  return nil
end
local getByName = function(name, list)
  for k, v in pairs(list) do
    if v.name == name then
      return v
    end
  end
  return nil
end
local function getByCharacterGroupByTreeKey(treeKey)
  for _, territoryGroup in pairs(treeGroupData) do
    for _, regionGroup in pairs(territoryGroup.child) do
      if nil ~= regionGroup.child[treeKey] then
        return regionGroup.child[treeKey]
      end
    end
  end
  return nil
end
local insertData = function(treeIndex, parentLuaGroup, treeElement, objectkey, name)
  local tempGroup = {
    index = treeIndex,
    element = treeElement,
    child = {},
    key = objectkey,
    name = name
  }
  parentLuaGroup[treeIndex] = tempGroup
  return tempGroup
end
local function insertTreeRoot(parentLuaGroup, text, key, imageKey, color)
  local childItemGroup = getByKey(key, treeGroupData)
  local rv
  if nil == childItemGroup or nil == childItemGroup.element then
    local childItem = UILink.treeView:createRootItem()
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    UILink.treeView:AddRootItem(childItem)
    return insertData(childItem:GetIndex(), parentLuaGroup, childItem, key, text)
  else
    local childItem = childItemGroup.element
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    return childItemGroup
  end
end
local function insertTreeVertex(parentTreeVertex, parentLuaGroup, text, key, imageKey, color)
  local childItemGroup = getByName(text, parentLuaGroup)
  if nil == childItemGroup or nil == childItemGroup.element then
    local childItem = UILink.treeView:createRootItem()
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    UILink.treeView:AddItem(childItem, parentTreeVertex)
    return insertData(childItem:GetIndex(), parentLuaGroup, childItem, key, text)
  else
    local childItem = childItemGroup.element
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    return childItemGroup
  end
end
local function insertTreeLeaf(parentTreeVertex, parentLuaGroup, text, key, imageKey, color)
  local childItemGroup = getByKey(key, parentLuaGroup)
  if nil == childItemGroup or nil == childItemGroup.element then
    local childItem = UILink.treeView:createChildItem()
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    UILink.treeView:AddItem(childItem, parentTreeVertex)
    return insertData(childItem:GetIndex(), parentLuaGroup, childItem, key, text)
  else
    local childItem = childItemGroup.element
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    return childItemGroup
  end
end
local function getCharacterString(npcData)
  local inputString = ""
  if false == IsUseDynamicBSS() then
    if npcData:getTitle() == "" or npcData:getTitle() == nil then
      inputString = "<PAColor0xffefefef>" .. npcData:getName() .. " "
    else
      inputString = "<PAColor0xffefefef>" .. npcData:getTitle() .. " " .. npcData:getName() .. " "
    end
  else
    local title = getNpcTitle(npcData:getKeyRaw())
    if nil == title then
      title = ""
    end
    local name = getNpcName(npcData:getKeyRaw())
    if nil == name then
      name = ""
    end
    if "" == title then
      inputString = "<PAColor0xffefefef>" .. name .. " "
    else
      inputString = "<PAColor0xffefefef>" .. title .. " " .. name .. " "
    end
  end
  local executeDialogData = getCacheDialogData(npcData:getKeyRaw(), npcData:getDialogIndex())
  if nil ~= executeDialogData then
    local explorePointInfo = ToClient_getExplorePointByTerritoryRaw(executeDialogData.territoryKey)
    if nil ~= explorePointInfo and executeDialogData.needPoint <= explorePointInfo:getRemainedPoint() then
      inputString = inputString .. "(<PAColor0xffe0d5a7>" .. executeDialogData.itemName .. ":" .. executeDialogData.needPoint .. "<PAOldColor>)"
    else
      inputString = inputString .. "(" .. executeDialogData.itemName .. ":" .. executeDialogData.needPoint .. ")"
    end
  end
  if false == NpcConditionCheck(npcData:getKeyRaw()) then
    local len = string.wlen(inputString)
    if 20 < len then
      len = 20
    end
    inputString = "<PAColor0xffbfbfbf>" .. PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_UNKNOWN_NPC")
    return inputString, false
  else
    return inputString, true
  end
end
local function createListElement(index, npcData, parentTreeVertex, parentLuaGroup, key, colorKey)
  local baseIcon, getSpawnType
  if false == IsUseDynamicBSS() then
    getSpawnType = npcData:getSpawnType()
  else
    getSpawnType = getNpcSpawnType(npcData:getKeyRaw())
  end
  local iconHide = 5 < getSpawnType or getSpawnType < 0
  local iconImageKey = 0
  if false == iconHide then
    iconImageKey = preLoadTextureKey[getSpawnType]
  end
  local inputString, isHasView = getCharacterString(npcData)
  local characterGroup = insertTreeLeaf(parentTreeVertex, parentLuaGroup, inputString, key, iconImageKey, colorKey)
  characterGroup.data = npcData
  return characterGroup, isHasView
end
local function naviPathClear()
  ToClient_DeleteNaviGuideByGroup(0)
  UILink.treeView:ResetSelectItem()
  selectIndex = -1
end
local function treeClear()
  UILink.treeView:ClearTree()
  treeGroupData = {}
end
function NpcNavi_TreeViewInOut(isIn)
  NpcNavi_UpdateSize()
  local IsMouseOver = Panel_NpcNavi:GetPosX() < getMousePosX() and getMousePosX() < Panel_NpcNavi:GetPosX() + Panel_NpcNavi:GetSizeX() and Panel_NpcNavi:GetPosY() < getMousePosY() and getMousePosY() < Panel_NpcNavi:GetPosY() + Panel_NpcNavi:GetSizeY()
  if IsMouseOver and false == isIn then
    return
  end
  isMouseOnTreeView = isIn
  searchGroupShow(isIn)
end
function NpcNavi_UpdateSize()
end
function NpcNavi_OverBarUpdatePerFrame(deltaTime)
  NpcNavi_OverBarUpdate(true)
  if nil == getSelfPlayer() then
    return
  end
  local playerLevel = getSelfPlayer():get():getLevel()
  if playerLevel <= 2 and isChecked_AddEffect == 0 and Panel_NpcNavi:GetShow() == true then
    isChecked_AddEffect = 1
    isChecked_EffectReset = 0
  end
  if 3 <= playerLevel and isChecked_AddEffect == 1 and isChecked_EffectReset == 0 then
    isChecked_EffectReset = 1
    isChecked_AddEffect = 2
  end
  if isChecked_EffectReset == 1 and isChecked_AddEffect == 2 then
    isChecked_EffectReset = 2
    isChecked_AddEffect = 3
  end
  if not ToClient_IsShowNaviGuideGroup(0) and -1 ~= selectIndex then
    naviPathClear()
  end
end
local giftIcon = {}
local uv = {
  [0] = {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_00.dds",
    x1 = 1,
    y1 = 1,
    x2 = 61,
    y2 = 61
  },
  {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_00.dds",
    x1 = 62,
    y1 = 1,
    x2 = 122,
    y2 = 61
  },
  {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_00.dds",
    x1 = 62,
    y1 = 62,
    x2 = 122,
    y2 = 122
  },
  {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_00.dds",
    x1 = 1,
    y1 = 62,
    x2 = 61,
    y2 = 122
  },
  {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_00.dds",
    x1 = 62,
    y1 = 62,
    x2 = 122,
    y2 = 122
  },
  {
    _fileName = "New_UI_Common_forLua/Widget/HumanRelations/Compensation_02.dds",
    x1 = 1,
    y1 = 1,
    x2 = 61,
    y2 = 61
  }
}
local _npcNavi_Target
function Panel_NpcNavi_updateIntimacyCircle(characterKeyRaw)
  local intimacy = getIntimacyByCharacterKey(characterKeyRaw)
  UILink.tooltip_FruitageValue:SetText(tostring(intimacy))
  local valuePercent = intimacy / 1000 * 100
  if 100 < valuePercent then
    valuePercent = 100
  end
  UILink.tooltip_CircularProgress:SetProgressRate(valuePercent)
  local count = getIntimacyInformationCount(characterKeyRaw)
  local colorKey = float4(1, 1, 1, 1)
  local startSize = 28
  local endSize = (UILink.tooltip_ProgressBG:GetSizeX() + UILink.tooltip_GiftIcon:GetSizeX()) / 2
  local centerPosition = float3(UILink.tooltip_ProgressBG:GetPosX() + UILink.tooltip_ProgressBG:GetSizeX() / 2, UILink.tooltip_ProgressBG:GetPosY() + UILink.tooltip_ProgressBG:GetSizeY() / 2, 0)
  for index, value in pairs(giftIcon) do
    UI.deleteControl(value)
  end
  _npcNavi_Target = nil
  giftIcon = {}
  for index = 0, count - 1 do
    local intimacyInformationData = getIntimacyInformation(characterKeyRaw, index)
    local percent = intimacyInformationData:getIntimacy() / 1000
    local imageType = intimacyInformationData:getTypeIndex()
    local imageFileName = ""
    if 0 <= percent and percent <= 1 and ToClient_checkIntimacyInformationFixedState(intimacyInformationData) then
      local angle = math.pi * 2 * percent
      local lineStart = float3(math.sin(angle), -math.cos(angle), 0)
      local lineEnd = float3(math.sin(angle), -math.cos(angle), 0)
      lineStart = _math_AddVectorToVector(centerPosition, _math_MulNumberToVector(lineStart, startSize))
      lineEnd = _math_AddVectorToVector(centerPosition, _math_MulNumberToVector(lineEnd, endSize))
      _npcNavi_Target = giftIcon[index]
      if nil == _npcNavi_Target then
        _npcNavi_Target = UI.createControl(__ePAUIControl_Static, UILink.tooltip, "GiftIcon_" .. tostring(index))
        giftIcon[index] = _npcNavi_Target
        CopyBaseProperty(UILink.tooltip_GiftIcon, _npcNavi_Target)
      end
      _npcNavi_Target:SetShow(true)
      _npcNavi_Target:ChangeTextureInfoNameAsync(uv[imageType]._fileName)
      local x1, y1, x2, y2 = setTextureUV_Func(_npcNavi_Target, uv[imageType].x1, uv[imageType].y1, uv[imageType].x2, uv[imageType].y2)
      _npcNavi_Target:getBaseTexture():setUV(x1, y1, x2, y2)
      _npcNavi_Target:setRenderTexture(_npcNavi_Target:getBaseTexture())
      _npcNavi_Target:SetPosX(lineEnd.x - _npcNavi_Target:GetSizeX() / 2)
      _npcNavi_Target:SetPosY(lineEnd.y - _npcNavi_Target:GetSizeY() / 2)
    end
  end
  return true
end
function NpcNavi_OverBarUpdate(isShow)
  local index = UILink.treeView:GetOverItmeIndex()
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode == getInputMode()
  if -1 == index or false == isUiMode or false == isShow then
    UILink.tooltip:SetShow(false)
    overIndex = -1
    return
  end
  local characterGroup = getByCharacterGroupByTreeKey(index)
  if overIndex == index then
    return
  end
  if nil ~= characterGroup then
    local sizeList, SizeY
    local isUpdateIntimacy = false
    if false == NpcConditionCheck(characterGroup.data:getKeyRaw()) then
      UILink.tooltip_NpcName:SetText(getCharacterString(characterGroup.data))
      UILink.tooltip_itemName:SetShow(false)
      UILink.tooltip_Icon:SetShow(false)
      if _npcNavi_Target == nil then
        UILink.tooltip_Description:SetTextMode(__eTextMode_AutoWrap)
        UILink.tooltip_Description:SetShow(false)
        UILink.tooltip_NeedExplorePoint:SetShow(false)
        UILink.tooltip_text:SetShow(false)
        UILink.tooltip_NotFind:SetShow(true)
        UILink.tooltip_NeedExplorePoint:SetShow(false)
        UILink.tooltip_ProgressBG:SetShow(false)
        UILink.tooltip_CircularProgress:SetShow(false)
        UILink.tooltip_FruitageValue:SetShow(false)
      else
        _npcNavi_Target:SetShow(false)
      end
      sizeList = {
        UILink.tooltip_NpcName:GetTextSizeX() + UILink.tooltip_NpcName:GetPosX() * 2,
        UILink.tooltip_NotFind:GetTextSizeX() + UILink.tooltip_NotFind:GetPosX() * 2
      }
      SizeY = UILink.tooltip_NotFind:GetPosY() + UILink.tooltip_NotFind:GetTextSizeY() + resizingGap.tooltipExplorePointPanelGap
    else
      if false == isUseNewUpdate then
        UILink.tooltip_NpcName:SetText(characterGroup.data:getName())
      else
        UILink.tooltip_NpcName:SetText(getNpcName(characterGroup.data:getKeyRaw()))
      end
      if characterGroup.data:hasTimeSpawn() then
        local tooltipStr = ""
        if characterGroup.data:isTimeSpawn(math.floor(getIngameTime_minute() / 60)) then
          tooltipStr = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_OPEN")
        else
          tooltipStr = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_CLOSED")
        end
        local startHour = convertVariableTime(characterGroup.data:getSpawnStartTime() * 3600)
        local startMin = math.floor(startHour % 3600 / 60)
        startHour = math.floor(startHour / 3600)
        local endHour = convertVariableTime(characterGroup.data:getSpawnEndTime() * 3600)
        local endMin = math.floor(endHour % 3600 / 60)
        endHour = math.floor(endHour / 3600)
        UILink.tooltip_text:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_OPEN_TIME", "opentime", startHour .. ":" .. startMin, "closetime", endHour .. ":" .. endMin) .. tooltipStr)
      else
        UILink.tooltip_text:SetText(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_EVERYDAYS_OPEN"))
      end
      local executeDialogData = getCacheDialogData(characterGroup.key)
      local explorePointInfo
      if nil ~= executeDialogData then
        explorePointInfo = ToClient_getExplorePointByTerritoryRaw(executeDialogData.territoryKey)
      end
      UILink.tooltip_NeedExplorePoint:SetShow(true)
      UILink.tooltip_ProgressBG:SetShow(true)
      UILink.tooltip_CircularProgress:SetShow(true)
      UILink.tooltip_FruitageValue:SetShow(true)
      if nil ~= explorePointInfo then
        UILink.tooltip_itemName:SetText(executeDialogData.itemName)
        UILink.tooltip_Icon:ChangeTextureInfoName("Icon/" .. executeDialogData.itemPath)
        if executeDialogData.needAdditionalCondtion then
          local stringData = PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_TOOLTIP_NEEDPOINTANDMINE_ADDCONDITION", "needPoint", executeDialogData.needPoint, "myPoint", explorePointInfo:getRemainedPoint())
          UILink.tooltip_NeedExplorePoint:SetText(stringData)
        else
          local stringData = PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_TOOLTIP_NEEDPOINTANDMINE", "needPoint", executeDialogData.needPoint, "myPoint", explorePointInfo:getRemainedPoint())
          UILink.tooltip_NeedExplorePoint:SetText(stringData)
        end
        UILink.tooltip_itemName:SetShow(true)
        UILink.tooltip_Icon:SetShow(true)
        UILink.tooltip_Description:SetAutoResize(true)
        UILink.tooltip_Description:SetTextMode(__eTextMode_AutoWrap)
        UILink.tooltip_Description:SetText(executeDialogData.itemDescription)
        UILink.tooltip_Description:SetShow(true)
        UILink.tooltip_NeedExplorePoint:SetShow(true)
        UILink.tooltip_text:SetShow(true)
        UILink.tooltip_NotFind:SetShow(false)
        UILink.tooltip_NeedExplorePoint:SetPosY(UILink.tooltip_Description:GetPosY() + UILink.tooltip_Description:GetSizeY() + resizingGap.tooltipDescExplorePointGap + 5)
        local ProgressSizeY = UILink.tooltip_GiftIcon:GetSizeY() * 2 + UILink.tooltip_NeedExplorePoint:GetPosY() + UILink.tooltip_NeedExplorePoint:GetSizeY() + resizingGap.tooltipDescExplorePointGap / 2
        UILink.tooltip_ProgressBG:SetPosY(ProgressSizeY)
        UILink.tooltip_CircularProgress:SetPosY(ProgressSizeY)
        UILink.tooltip_FruitageValue:SetPosY(ProgressSizeY)
        isUpdateIntimacy = isIntimacyCharacterByKey(characterGroup.data:getKeyRaw())
        if isUpdateIntimacy then
          sizeList = {
            UILink.tooltip_NpcName:GetTextSizeX() + UILink.tooltip_NpcName:GetPosX() * 2,
            UILink.tooltip_text:GetTextSizeX() + UILink.tooltip_text:GetPosX() * 2,
            UILink.tooltip_itemName:GetTextSizeX() + UILink.tooltip_itemName:GetPosX() + UILink.tooltip_Icon:GetPosX(),
            UILink.tooltip_NeedExplorePoint:GetTextSizeX() + UILink.tooltip_NeedExplorePoint:GetPosX() * 2,
            UILink.tooltip_Description:GetTextSizeX() + UILink.tooltip_Description:GetPosX() * 2,
            UILink.tooltip_CircularProgress:GetSizeX() + UILink.tooltip_GiftIcon:GetSizeX() * 2 + 20
          }
          SizeY = UILink.tooltip_CircularProgress:GetPosY() + UILink.tooltip_CircularProgress:GetSizeY() + resizingGap.tooltipExplorePointPanelGap + UILink.tooltip_GiftIcon:GetSizeY()
        else
          sizeList = {
            UILink.tooltip_NpcName:GetTextSizeX() + UILink.tooltip_NpcName:GetPosX() * 2,
            UILink.tooltip_text:GetTextSizeX() + UILink.tooltip_text:GetPosX() * 2,
            UILink.tooltip_itemName:GetTextSizeX() + UILink.tooltip_itemName:GetPosX() + UILink.tooltip_Icon:GetPosX(),
            UILink.tooltip_NeedExplorePoint:GetTextSizeX() + UILink.tooltip_NeedExplorePoint:GetPosX() * 2,
            UILink.tooltip_Description:GetTextSizeX() + UILink.tooltip_Description:GetPosX() * 2
          }
          SizeY = UILink.tooltip_NeedExplorePoint:GetPosY() + UILink.tooltip_NeedExplorePoint:GetTextSizeY() + resizingGap.tooltipExplorePointPanelGap
        end
      else
        UILink.tooltip_itemName:SetShow(false)
        UILink.tooltip_Icon:SetShow(false)
        UILink.tooltip_Description:SetShow(false)
        UILink.tooltip_NeedExplorePoint:SetShow(false)
        UILink.tooltip_text:SetShow(true)
        UILink.tooltip_NotFind:SetShow(false)
        local ProgressSizeY = UILink.tooltip_GiftIcon:GetSizeY() + UILink.tooltip_text:GetPosY() + UILink.tooltip_text:GetTextSizeY() + resizingGap.tooltipDescExplorePointGap / 2
        UILink.tooltip_NeedExplorePoint:SetPosY(ProgressSizeY)
        UILink.tooltip_ProgressBG:SetPosY(ProgressSizeY)
        UILink.tooltip_CircularProgress:SetPosY(ProgressSizeY)
        UILink.tooltip_FruitageValue:SetPosY(ProgressSizeY)
        isUpdateIntimacy = isIntimacyCharacterByKey(characterGroup.data:getKeyRaw())
        if isUpdateIntimacy then
          sizeList = {
            UILink.tooltip_NpcName:GetTextSizeX() + UILink.tooltip_NpcName:GetPosX() * 2,
            UILink.tooltip_text:GetTextSizeX() + UILink.tooltip_text:GetPosX() * 2,
            UILink.tooltip_CircularProgress:GetSizeX() + UILink.tooltip_GiftIcon:GetSizeX() * 2 + 20
          }
          SizeY = UILink.tooltip_CircularProgress:GetPosY() + UILink.tooltip_CircularProgress:GetSizeY() + resizingGap.tooltipExplorePointPanelGap + UILink.tooltip_GiftIcon:GetSizeY()
        else
          sizeList = {
            UILink.tooltip_NpcName:GetTextSizeX() + UILink.tooltip_NpcName:GetPosX() * 2,
            UILink.tooltip_text:GetTextSizeX() + UILink.tooltip_text:GetPosX() * 2
          }
          SizeY = UILink.tooltip_text:GetPosY() + UILink.tooltip_text:GetTextSizeY() + resizingGap.tooltipExplorePointPanelGap
        end
      end
    end
    local tooltip_SizeX = 290
    UILink.tooltip:SetSize(tooltip_SizeX, SizeY)
    UILink.tooltip:ComputePos()
    if isUpdateIntimacy then
      UILink.tooltip_NeedExplorePoint:ComputePos()
      UILink.tooltip_ProgressBG:ComputePos()
      UILink.tooltip_CircularProgress:ComputePos()
      UILink.tooltip_FruitageValue:ComputePos()
      Panel_NpcNavi_updateIntimacyCircle(characterGroup.data:getKeyRaw())
    end
    UILink.tooltip:SetShow(true)
    UILink.tooltip:SetPosX(Panel_NpcNavi:GetPosX() - UILink.tooltip:GetSizeX() - 5)
    UILink.tooltip:SetPosY(Panel_NpcNavi:GetPosY())
  else
    UILink.tooltip:SetShow(false)
  end
  overIndex = index
end
function NpcNavi_ShowToggle()
  local isShow = not Panel_NpcNavi:IsShow()
  if isShow then
    NpcNavi_Reset_Posistion()
  else
    clearFocusEdit()
  end
  Panel_NpcNavi:SetShow(isShow, false)
  if false == isShow then
    if ToClient_WorldMapIsShow() then
      WorldMapPopupManager:pop()
    end
    Panel_Tooltip_NpcNavigation:SetShow(false, false)
  else
    PaGlobal_NPCNavi_UpdateTownNavi()
    if lazyUpdate then
      NpcListUpdate()
      lazyUpdate = false
    end
  end
  Panel_NpcNavi:EraseAllEffect()
  local rndNo_1 = math.random(0, 30)
  local rndNo_2 = math.random(30, 60)
  if Panel_WorldMap:GetShow() then
    Panel_NpcNavi:SetPosX(getScreenSizeX() - Panel_NpcNavi:GetSizeX() - 300)
    Panel_NpcNavi:SetPosY(30)
  else
    NpcNavi_Reset_Posistion()
  end
  Panel_NpcNavi:SetPosX(Panel_NpcNavi:GetPosX() - rndNo_1)
  Panel_NpcNavi:SetPosY(Panel_NpcNavi:GetPosY() + rndNo_2)
  PaGlobal_TutorialManager:handleNpcNavi_ShowToggle(isShow)
end
function FGlobal_NpcNavi_Hide()
  local isShow = Panel_NpcNavi:IsShow()
  if isShow then
    clearFocusEdit()
  end
  Panel_NpcNavi:SetShow(false, false)
  Panel_Tooltip_NpcNavigation:SetShow(false, false)
end
function FGlobal_NpcNavi_IsShowCheck()
  return Panel_NpcNavi:IsShow()
end
function FGlobal_NpcNavi_ShowRequestOuter()
  clearFocusEdit()
end
function NpcNavi_Reset_Posistion()
  Panel_NpcNavi:SetPosX(FGlobal_Panel_Radar_GetPosX() - Panel_NpcNavi:GetSizeX())
  Panel_NpcNavi:SetPosY(FGlobal_Panel_Radar_GetPosY())
end
function NpcNavi_ShowRequestOuter(isShow)
  Panel_NpcNavi:SetShow(isShow, false)
  if false == isShow then
    Panel_Tooltip_NpcNavigation:SetShow(false, false)
  elseif lazyUpdate then
    NpcListUpdate()
    lazyUpdate = false
  end
end
function NpcNavi_OnInputMode()
  SetFocusEdit(UILink.editSearchText)
  UILink.editSearchText:SetEditText("")
  searchGroupShow(true)
end
function NpcNavi_CheckCurrentUiEdit(_npcNavi_TargetUI)
  return nil ~= _npcNavi_TargetUI and _npcNavi_TargetUI:GetKey() == UILink.editSearchText:GetKey()
end
function NpcNavi_OutInputMode(isOk)
  if true ~= isOk then
    UILink.editSearchText:SetEditText("")
  end
  NpcNavi_SearchBtn()
  searchGroupShow(false)
  ClearFocusEdit()
end
local stringMatching = function(dstString, filterString)
  return (stringSearch(dstString, filterString))
end
local sortComparer = function(lhs, rhs)
  if lhs.territoryName == rhs.territoryName then
    return stringCompare(lhs.areaName, rhs.areaName) < 0
  else
    return stringCompare(lhs.territoryName, rhs.territoryName) < 0
  end
end
function NpcListUpdate_selfPlayer_regionChanged()
  if false == Panel_NpcNavi:IsShow() then
    lazyUpdate = true
    return
  elseif lazyUpdate then
    NpcListUpdate()
  end
end
function NpcListUpdate_EventMentalCardUpdate()
  if false == Panel_NpcNavi:IsShow() then
    lazyUpdate = true
    return
  end
  NpcListUpdate()
end
function NpcListUpdate_EventExplorePointUpdate()
  if false == Panel_NpcNavi:IsShow() then
    lazyUpdate = true
    return
  end
  NpcListUpdate()
end
function NpcListUpdate()
  if true == IsUseDynamicBSS() then
    NpcListUpdate_New()
    return
  end
  local newList = {}
  local regionInfoCount = getRegionInfoCount()
  local regionInfoList = {}
  for index = 0, regionInfoCount - 1 do
    local regionInfo = getRegionInfo(index)
    regionInfoList[index + 1] = {}
    local _npcNavi_TargetInfo = regionInfoList[index + 1]
    _npcNavi_TargetInfo.areaName = regionInfo:getAreaName()
    _npcNavi_TargetInfo.territoryKey = regionInfo:getTerritoryKeyRaw()
    _npcNavi_TargetInfo.regionKey = regionInfo:getRegionKey()
    _npcNavi_TargetInfo.isAccessible = regionInfo:get():isAccessibleArea()
    _npcNavi_TargetInfo.territoryName = regionInfo:getTerritoryName()
  end
  table.sort(regionInfoList, sortComparer)
  local isFilterFail = true
  for index = 1, regionInfoCount do
    local regionInfo = regionInfoList[index]
    local territoryMatch = stringMatching(regionInfo.territoryName, filterText)
    local regionMatch = stringMatching(regionInfo.areaName, filterText)
    local count = npcList_getNpcCount(regionInfo.regionKey)
    local checkFiltering = filterText ~= nil and filterText:len() ~= 0 and false == territoryMatch and false == regionMatch
    local filterStrCountOverOne = false
    if checkFiltering then
      for idx = 0, count - 1 do
        local npcData = npcList_getNpcInfo(idx)
        local characeterName, isHasView = getCharacterString(npcData)
        if stringMatching(characeterName, filterText) and npcData:isImportantNpc() then
          filterStrCountOverOne = true
          break
        end
      end
    else
      filterStrCountOverOne = 0 ~= count
    end
    if filterStrCountOverOne then
      isFilterFail = false
    end
    local canActive = false
    for index = 0, count - 1 do
      local npcData = npcList_getNpcInfo(index)
      local isActiveCondition = NpcConditionCheck(npcData:getKeyRaw())
      if isActiveCondition and npcData:isImportantNpc() then
        canActive = true
        break
      end
    end
    if filterStrCountOverOne and regionInfo.isAccessible and canActive then
      local territoryKeyRaw = regionInfo.territoryKey
      local explorePointInfo = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
      local territoryName = regionInfo.territoryName
      if nil ~= explorePointInfo then
        territoryName = PAGetStringParam1(Defines.StringSheet_GAME, "NPCNAVIGATION_TERRITORYNAME", "territoryName", territoryName)
        WorldMapWindow_Update_ExplorePoint()
      end
      local territoryGroup = insertTreeRoot(treeGroupData, territoryName, territoryKeyRaw, preLoadTextureKey_territory[regionInfo.territoryKey], UI_color.C_FFFFAB6D)
      local regionGroup = insertTreeVertex(territoryGroup.element, territoryGroup.child, regionInfo.areaName, regionInfo.regionKey, 0, UI_color.C_FFFFFFFF)
      if nil ~= filterText and filterText:len() ~= 0 then
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          local characeterName, isHasView = getCharacterString(npcData)
          if (stringMatching(characeterName, filterText) or not checkFiltering) and npcData:isImportantNpc() then
            local characterGroup, isHasView = createListElement(idx, npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), UI_color.C_FFFFFFFF)
            UILink.treeView:SetSelectItem(characterGroup.index)
            if isHasView then
              local isTrue = checkIsNewAdd(characterGroup.index, npcData:getKeyRaw())
              if isTrue then
                newList[npcData:getKeyRaw()] = characterGroup.index
              end
            end
          end
        end
      else
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          if npcData:isImportantNpc() then
            local characterGroup, isHasView = createListElement(idx, npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), UI_color.C_FFFFFFFF)
            if isHasView then
              local isTrue = checkIsNewAdd(characterGroup.index, npcData:getKeyRaw())
              if isTrue then
                newList[npcData:getKeyRaw()] = characterGroup.index
              end
            end
          end
        end
      end
    end
  end
  if 0 < regionInfoCount and isFilterFail then
    errorMessageShow = true
  else
    errorMessageShow = false
  end
  UILink.errorMessage:SetShow(errorMessageShow)
  UILink.treeView:SetFilterString("")
  UILink.treeView:RefreshOpenList()
  if -1 < selectIndex then
    UILink.treeView:SetSelectItem(selectIndex)
  end
  if isFirstUpdate then
    isFirstUpdate = false
  else
    for key, value in pairs(newList) do
      UILink.treeView:SetSelectItem(value)
    end
    AddEffectList(newList)
    UILink.treeView:ResetSelectItem()
  end
  _scroll:SetControlTop()
end
function NpcListUpdate_New()
  local newList = {}
  local regionInfoCount = getRegionInfoCount()
  local addCount = 0
  local regionInfoList = {}
  for index = 0, regionInfoCount - 1 do
    local regionInfo = getRegionInfo(index)
    if true == regionInfo:get():isAccessibleArea() then
      regionInfoList[addCount + 1] = {}
      regionInfoList[addCount + 1].areaName = regionInfo:getAreaName()
      regionInfoList[addCount + 1].territoryKey = regionInfo:getTerritoryKeyRaw()
      regionInfoList[addCount + 1].regionKey = regionInfo:getRegionKey()
      regionInfoList[addCount + 1].territoryName = regionInfo:getTerritoryName()
      addCount = addCount + 1
    end
  end
  table.sort(regionInfoList, sortComparer)
  local isFilterFail = true
  for index = 1, addCount do
    local regionInfo = regionInfoList[index]
    local count = npcList_getNpcCount(regionInfo.regionKey)
    local territoryMatch = stringMatching(regionInfo.territoryName, filterText)
    local regionMatch = stringMatching(regionInfo.areaName, filterText)
    local checkFiltering = filterText ~= nil and filterText:len() ~= 0 and false == territoryMatch and false == regionMatch
    local filterStrCountOverOne = false
    if checkFiltering then
      for idx = 0, count - 1 do
        local npcData = npcList_getNpcInfo(idx)
        if true == isImportantNpc(npcData:getKeyRaw()) then
          local characeterName, isHasView = getCharacterString(npcData)
          if stringMatching(characeterName, filterText) then
            filterStrCountOverOne = true
            break
          end
        end
      end
    else
      filterStrCountOverOne = 0 ~= count
    end
    if filterStrCountOverOne then
      isFilterFail = false
    end
    local canActive = false
    for index = 0, count - 1 do
      local npcData = npcList_getNpcInfo(index)
      if true == isImportantNpc(npcData:getKeyRaw()) then
        local isActiveCondition = NpcConditionCheck(npcData:getKeyRaw())
        if isActiveCondition then
          canActive = true
          break
        end
      end
    end
    if filterStrCountOverOne and canActive then
      local territoryKeyRaw = regionInfo.territoryKey
      local explorePointInfo = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
      local territoryName = regionInfo.territoryName
      if nil ~= explorePointInfo then
        territoryName = PAGetStringParam1(Defines.StringSheet_GAME, "NPCNAVIGATION_TERRITORYNAME", "territoryName", territoryName)
        WorldMapWindow_Update_ExplorePoint()
      end
      local territoryGroup = insertTreeRoot(treeGroupData, territoryName, territoryKeyRaw, preLoadTextureKey_territory[regionInfo.territoryKey], UI_color.C_FFFFAB6D)
      local regionGroup = insertTreeVertex(territoryGroup.element, territoryGroup.child, regionInfo.areaName, regionInfo.regionKey, 0, UI_color.C_FFFFFFFF)
      if nil ~= filterText and filterText:len() ~= 0 then
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          if true == isImportantNpc(npcData:getKeyRaw()) then
            local characeterName, isHasView = getCharacterString(npcData)
            if stringMatching(characeterName, filterText) or not checkFiltering then
              local characterGroup, isHasView = createListElement(idx, npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), UI_color.C_FFFFFFFF)
              UILink.treeView:SetSelectItem(characterGroup.index)
              if isHasView then
                local isTrue = checkIsNewAdd(characterGroup.index, npcData:getKeyRaw())
                if isTrue then
                  newList[npcData:getKeyRaw()] = characterGroup.index
                end
              end
            end
          end
        end
      else
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          if true == isImportantNpc(npcData:getKeyRaw()) then
            local characterGroup, isHasView = createListElement(idx, npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), UI_color.C_FFFFFFFF)
            if isHasView then
              local isTrue = checkIsNewAdd(characterGroup.index, npcData:getKeyRaw())
              if isTrue then
                newList[npcData:getKeyRaw()] = characterGroup.index
              end
            end
          end
        end
      end
    end
  end
  if 0 < regionInfoCount and isFilterFail then
    errorMessageShow = true
  else
    errorMessageShow = false
  end
  UILink.errorMessage:SetShow(errorMessageShow)
  UILink.treeView:SetFilterString("")
  UILink.treeView:RefreshOpenList()
  if -1 < selectIndex then
    UILink.treeView:SetSelectItem(selectIndex)
  end
  if isFirstUpdate then
    isFirstUpdate = false
  else
    for key, value in pairs(newList) do
      UILink.treeView:SetSelectItem(value)
    end
    AddEffectList(newList)
    UILink.treeView:ResetSelectItem()
  end
  _scroll:SetControlTop()
end
function NpcNavi_SearchBtn()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  filterText = UILink.editSearchText:GetEditText()
  treeClear()
  NpcListUpdate()
  NpcNavi_UpdateSize()
end
function NpcNavi_DrawLine()
  NpcNavi_UpdateSize()
  local selectItem = UILink.treeView:GetSelectItem()
  if nil == selectItem then
    naviPathClear()
    return
  end
  local index = selectItem:GetIndex()
  local chracterGroup = getByCharacterGroupByTreeKey(index)
  if selectIndex == index or nil == chracterGroup then
    naviPathClear()
    return
  elseif NpcConditionCheck(chracterGroup.data:getKeyRaw()) then
    NpcNavi_Clear()
    if chracterGroup.data:hasTimeSpawn() and chracterGroup.data:isTimeSpawn(math.floor(getIngameTime_minute() / 60)) == false then
      NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
    end
    worldmapNavigatorStart(chracterGroup.data:getPosition(), NavigationGuideParam(), false, false, true)
    selectIndex = index
  else
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOFIND"))
    naviPathClear()
    return
  end
end
function NpcNavi_Clear()
  ToClient_DeleteNaviGuideByGroup(0)
end
function NpcNavi_ChangeTexture_On()
  isMouseOnPanel = true
  searchGroupShow(true)
  npcNaviText:SetText(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_DRAGABLE"))
  npcNaviText:SetSize(npcNaviText:GetTextSizeX(), npcNaviText:GetSizeY())
  npcNaviText:ComputePos()
end
function NpcNavi_ChangeTexture_Off()
  local IsMouseOver = Panel_NpcNavi:GetPosX() < getMousePosX() and getMousePosX() < Panel_NpcNavi:GetPosX() + Panel_NpcNavi:GetSizeX() and Panel_NpcNavi:GetPosY() < getMousePosY() and getMousePosY() < Panel_NpcNavi:GetPosY() + Panel_NpcNavi:GetSizeY()
  if IsMouseOver then
    return
  end
  isMouseOnPanel = false
  searchGroupShow(false)
  npcNaviText:SetText(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOTDRAGABLE"))
  npcNaviText:SetSize(npcNaviText:GetTextSizeX(), npcNaviText:GetSizeY())
  npcNaviText:ComputePos()
end
function NpcListUpdate_ScreenResize()
  local self = UILink
  if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    self.treeView:SetItemQuantity(self.treeView:GetSizeY() / 195 * 8)
    self.treeView:setAddImagePosY(5)
  else
    self.treeView:SetItemQuantity(self.treeView:GetSizeY() / 465 * 25)
    self.treeView:setAddImagePosY(2)
  end
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
function PaGlobal_NPCNavi_UpdateTownNavi()
  for index, control in pairs(townNavi) do
    if territoryTownData[index]._isOpen then
      local actorKey = territoryTownData[index]._actorKey
      if NpcConditionCheck(actorKey) then
        control:SetMonoTone(false)
      else
        control:SetMonoTone(true)
      end
    end
  end
end
initialize()
