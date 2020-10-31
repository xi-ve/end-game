function PaGlobal_NpcNavi_All:initialize()
  if true == PaGlobal_NpcNavi_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_TitleArea = UI.getChildControl(Panel_NpcNavi_All, "Static_TitleArea")
  self._ui_pc.btn_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Win_Close")
  self._ui.stc_TopAreaBG = UI.getChildControl(Panel_NpcNavi_All, "Static_TopInsdieBG")
  self._ui.stc_WareHouseBG = UI.getChildControl(Panel_NpcNavi_All, "Static_Bg3")
  for idx = 1, self._warehouseCount do
    self._warehouseBtns[idx] = UI.getChildControl(self._ui.stc_WareHouseBG, "Button_" .. tostring(idx))
  end
  self._ui.tree_Npc = UI.getChildControl(Panel_NpcNavi_All, "Tree_View")
  self._ui.tree_overStatic = UI.getChildControl(self._ui.tree_Npc, "Tree2_1_OverStatic")
  self._ui.scroll = UI.getChildControl(self._ui.tree_Npc, "Tree_1_Scroll")
  self._ui.stc_SearchBG = UI.getChildControl(Panel_NpcNavi_All, "Static_Bg4")
  self._ui.edit_Serarch = UI.getChildControl(self._ui.stc_SearchBG, "EditSearchText")
  self._ui_pc.btn_Search = UI.getChildControl(self._ui.stc_SearchBG, "BtnSearch")
  self._ui.txt_ErrorText = UI.getChildControl(Panel_NpcNavi_All, "StaticText_ErrorNotice")
  self._ui.txt_Desc = UI.getChildControl(Panel_NpcNavi_All, "StaticText_NpcNavi_Desc")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_NpcNavi_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._ui_console.txt_KeyGuideDPadVer = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_DPadVertical_ConsoleUI")
  self._ui_console.txt_KeyGuideDPadHor = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_DPadHorizon_ConsoleUI")
  PaGlobal_NpcNavi_All:registEventHandler()
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  local panelSizeY = Panel_NpcNavi_All:GetSizeY()
  local endPosY = self._ui.txt_Desc:GetPosY() + self._ui.txt_Desc:GetTextSizeY()
  if panelSizeY < endPosY then
    Panel_NpcNavi_All:SetSize(Panel_NpcNavi_All:GetSizeX(), endPosY)
  end
  if false == self._isConsole then
    self._ui.tree_overStatic:SetShow(false)
  else
    PaGlobal_NpcNavi_All_SetTreeKeyGuide()
    self._ui_pc.btn_Search:SetShow(false)
    self._ui_pc.btn_Close:SetShow(false)
    self._ui.edit_Serarch:SetSize(self._ui.edit_Serarch:GetSizeX() + self._ui_pc.btn_Search:GetSizeX() + 10, self._ui.edit_Serarch:GetSizeY())
    local consoleXKey = UI.getChildControl(self._ui.edit_Serarch, "StaticText_X_ConsoleUI")
    consoleXKey:SetShow(true)
    consoleXKey:ComputePos()
  end
  self:initTexture()
  self:initWarehouseBtn()
  PaGlobal_NpcNavi_All:validate()
  PaGlobal_NpcNavi_All._initialize = true
end
function PaGlobal_NpcNavi_All:registEventHandler()
  if nil == Panel_NpcNavi_All then
    return
  end
  Panel_NpcNavi_All:setMaskingChild(true)
  Panel_Tooltip_NpcNavigation_All:setMaskingChild(true)
  Panel_NpcNavi_All:ActiveMouseEventEffect(true)
  if false == _ContentsGroup_RenewUI_Main then
    Panel_NpcNavi_All:setGlassBackground(true)
  end
  registerEvent("selfPlayer_regionChanged", "FromClient_NpcNavi_All_RregionChanged")
  registerEvent("EventMentalCardUpdate", "FromClient_NpcNavi_All_MentalCardUpdate")
  registerEvent("EventExplorePointUpdate", "FromClient_NpcNavi_All_ExplorePointUpdate")
  registerEvent("onScreenResize", "FromClient_NpcNavi_All_OnScreenResize")
  if self._isConsole then
    self._ui.tree_overStatic:registerPadEvent(__eConsoleUIPadEvent_Up_A, "InputMLUp_NpcNavi_DrawLine()")
    Panel_NpcNavi_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMLUp_NpcNavi_SetFoucsEdit()")
    self._ui.edit_Serarch:setXboxVirtualKeyBoardEndEvent("PaGlobal_NpcNavi_All_SearchNpc")
  else
    self._ui.tree_Npc:addInputEvent("Mouse_LUp", "InputMLUp_NpcNavi_DrawLine()")
    self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_NpcNavi_All_ShowToggle()")
    self._ui_pc.btn_Search:addInputEvent("Mouse_LDown", "InputMLUp_NpcNavi_SearchNpc()")
    self._ui.edit_Serarch:addInputEvent("Mouse_LUp", "InputMLUp_NpcNavi_SetFoucsEdit()")
    self._ui.edit_Serarch:RegistReturnKeyEvent("PaGlobal_NpcNavi_All_ReturnKeyEvent(true)")
  end
end
function PaGlobal_NpcNavi_All:prepareOpen()
  if nil == Panel_NpcNavi_All then
    return
  end
  if true == self._isConsole then
    self._ui.tree_Npc:SetOverIndex(self._ui.tree_Npc:GetToIndex())
  end
  Panel_NpcNavi_All:RegisterUpdateFunc("PaGlobal_NpcNavi_All_OverBarUpdatePerFrame")
  PaGlobal_NpcNavi_All:open()
end
function PaGlobal_NpcNavi_All:panelSizeSetting(iconCount)
  if nil == Panel_NpcNavi_All then
    return
  end
  if iconCount <= 18 then
    return
  end
  local stc_topAreaBG = UI.getChildControl(Panel_NpcNavi_All, "Static_TopInsdieBG")
  local stc_naviText = UI.getChildControl(Panel_NpcNavi_All, "StaticText_npcNaviText")
  local stc_WarehouseTitle = UI.getChildControl(Panel_NpcNavi_All, "StaticText_WarehouseTitle")
  local bg3 = UI.getChildControl(Panel_NpcNavi_All, "Static_Bg3")
  local stc_subject = UI.getChildControl(Panel_NpcNavi_All, "StaticText_Subject")
  local bg = UI.getChildControl(Panel_NpcNavi_All, "Static_BG")
  local treeView = UI.getChildControl(Panel_NpcNavi_All, "Tree_View")
  local bg4 = UI.getChildControl(Panel_NpcNavi_All, "Static_Bg4")
  local stc_npcDesc = UI.getChildControl(Panel_NpcNavi_All, "StaticText_NpcNavi_Desc")
  local stc_Erro = UI.getChildControl(Panel_NpcNavi_All, "StaticText_ErrorNotice")
  Panel_NpcNavi_All:SetSize(Panel_NpcNavi_All:GetSizeX(), 810)
  stc_topAreaBG:SetSize(stc_topAreaBG:GetSizeX(), 280)
  stc_naviText:ComputePos()
  stc_WarehouseTitle:ComputePos()
  bg3:ComputePos()
  stc_subject:ComputePos()
  bg:ComputePos()
  treeView:ComputePos()
  bg4:ComputePos()
  stc_npcDesc:ComputePos()
  stc_Erro:ComputePos()
end
function PaGlobal_NpcNavi_All:open()
  if nil == Panel_NpcNavi_All then
    return
  end
  Panel_NpcNavi_All:SetShow(true)
end
function PaGlobal_NpcNavi_All:prepareClose()
  if nil == Panel_NpcNavi_All then
    return
  end
  Panel_NpcNavi_All:ClearUpdateLuaFunc()
  PaGlobal_NpcNavi_Tooltip:prepareClose()
  PaGlobal_NpcNavi_All:close()
end
function PaGlobal_NpcNavi_All:close()
  if nil == Panel_NpcNavi_All then
    return
  end
  Panel_NpcNavi_All:SetShow(false)
end
function PaGlobal_NpcNavi_All:validate()
  if nil == Panel_NpcNavi_All then
    return
  end
  self._ui.stc_TitleArea:isValidate()
  self._ui_pc.btn_Close:isValidate()
  self._ui.stc_TopAreaBG:isValidate()
  self._ui.stc_WareHouseBG:isValidate()
  for idx = 1, self._warehouseCount do
    self._warehouseBtns[idx]:isValidate()
  end
  self._ui.tree_Npc:isValidate()
  self._ui.tree_overStatic:isValidate()
  self._ui.scroll:isValidate()
  self._ui.edit_Serarch:isValidate()
  self._ui_pc.btn_Search:isValidate()
  self._ui.txt_ErrorText:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui_console.stc_KeyGuideBG:isValidate()
  self._ui_console.txt_KeyGuideA:isValidate()
  self._ui_console.txt_KeyGuideB:isValidate()
  self._ui_console.txt_KeyGuideDPadVer:isValidate()
  self._ui_console.txt_KeyGuideDPadHor:isValidate()
end
function PaGlobal_NpcNavi_All:initTexture()
  self.preLoadTextureKey[0] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_general.dds")
  self.preLoadTextureKey[1] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_skill.dds")
  self.preLoadTextureKey[2] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_artisan.dds")
  self.preLoadTextureKey[3] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_store_liquid.dds")
  self.preLoadTextureKey[4] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_general.dds")
  self.preLoadTextureKey[5] = preLoadTexture("new_ui_common_forlua/widget/minimap/icon/minimap_icon_npc_store_liquid.dds")
  local territoryCount = getTerritoryInfoCount()
  for i = 1, territoryCount do
    local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(i - 1)
    if nil ~= territoryInfoWrapper then
      self.preLoadTextureKey_territory[territoryInfoWrapper:getKeyRaw()] = preLoadTexture(territoryInfoWrapper:getTerritorySmallImage())
    end
  end
end
function PaGlobal_NpcNavi_All:initWarehouseBtn()
  local showCount = 0
  for index, control in ipairs(self._warehouseBtns) do
    control:addInputEvent("Mouse_LUp", "InputMLUp_NpcNavi_SetWarehouseNavi(" .. index .. ")")
    control:addInputEvent("Mouse_On", "InputMOn_NpcNavi_TownWarehouseTooltip(" .. index .. ")")
    control:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    if nil ~= self._territoryTownData[index] and self._territoryTownData[index]._isOpen then
      control:SetShow(true)
      showCount = showCount + 1
    else
      control:SetShow(false)
    end
  end
  if showCount < 7 then
    local bgSizeX = self._ui.stc_WareHouseBG:GetSizeX()
    local btnSizeX = self._warehouseBtns[1]:GetSizeX()
    local totalSizeX = btnSizeX * 6
    local gapSizeX = math.floor((bgSizeX - totalSizeX) / 7)
    local posX = gapSizeX
    for index = 1, self._warehouseCount do
      if nil ~= self._territoryTownData[index] and self._territoryTownData[index]._isOpen then
        self._warehouseBtns[index]:SetPosX(posX)
        posX = posX + gapSizeX + btnSizeX
      end
    end
  end
end
function PaGlobal_NpcNavi_All:clearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
  self._ui.edit_Serarch:SetEditText("")
end
function PaGlobal_NpcNavi_All:getCacheDialogData(characterKeyRaw, dialogIndex)
  if nil == self.cacheExecuteDialogData[characterKeyRaw] then
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
        self.cacheExecuteDialogData[characterKeyRaw] = insertData
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
      self.cacheExecuteDialogData[characterKeyRaw] = insertData
    end
  end
  return self.cacheExecuteDialogData[characterKeyRaw]
end
function PaGlobal_NpcNavi_All:getByKey(key, list)
  for k, v in pairs(list) do
    if v.key == key then
      return v
    end
  end
  return nil
end
function PaGlobal_NpcNavi_All:getByName(name, list)
  for k, v in pairs(list) do
    if v.name == name then
      return v
    end
  end
  return nil
end
function PaGlobal_NpcNavi_All:getOverItemSpawnRegionData()
  local overItem = self._ui.tree_Npc:GetOverItem()
  if nil == overItem then
    return nil
  end
  if true == overItem:isRootItem() then
    return nil
  end
  local regionItem = overItem:getParent()
  if nil == regionItem then
    return nil
  end
  local regionKey = regionItem:GetKey()
  local npcKey = overItem:GetKey()
  return ToClient_getNpcInfoByRegionAndKey(regionKey, npcKey)
end
function PaGlobal_NpcNavi_All:getSelectItemSpawnRegionData()
  local selectItem = self._ui.tree_Npc:GetSelectItem()
  if nil == selectItem then
    return nil
  end
  if true == selectItem:isRootItem() then
    return nil
  end
  local regionItem = selectItem:getParent()
  if nil == regionItem then
    return nil
  end
  local regionKey = regionItem:GetKey()
  local npcKey = selectItem:GetKey()
  return ToClient_getNpcInfoByRegionAndKey(regionKey, npcKey)
end
function PaGlobal_NpcNavi_All:insertData(parentLuaGroup, treeElement, key, name)
  local tempGroup = {
    index = treeIndex,
    element = treeElement,
    child = {},
    key = key,
    name = name
  }
  parentLuaGroup[key] = tempGroup
  return tempGroup
end
function PaGlobal_NpcNavi_All:insertTreeRoot(parentLuaGroup, territoryName, territoryKeyRaw, imageKey, color)
  local childItemGroup = self:getByKey(territoryKeyRaw, self.treeGroupData)
  if nil == childItemGroup or nil == childItemGroup.element then
    local rootItem = self._ui.tree_Npc:AddTopRootItem()
    rootItem:SetText(territoryName)
    rootItem:SetFontColor(color)
    rootItem:SetTextureHash(imageKey)
    rootItem:SetKey(territoryKeyRaw)
    return self:insertData(parentLuaGroup, rootItem, territoryKeyRaw, territoryName)
  else
    return childItemGroup
  end
end
function PaGlobal_NpcNavi_All:insertTreeVertex(parentTreeVertex, parentLuaGroup, areaName, regionKey, imageKey, color)
  local childItemGroup = self:getByName(areaName, parentLuaGroup)
  if nil == childItemGroup or nil == childItemGroup.element then
    local rootItem = self._ui.tree_Npc:AddRootItem(parentTreeVertex)
    rootItem:SetText(areaName)
    rootItem:SetFontColor(color)
    rootItem:SetTextureHash(imageKey)
    rootItem:SetKey(regionKey)
    return self:insertData(parentLuaGroup, rootItem, regionKey, areaName)
  else
    return childItemGroup
  end
end
function PaGlobal_NpcNavi_All:insertTreeLeaf(parentTreeVertex, parentLuaGroup, text, key, imageKey, color)
  local childItemGroup = self:getByKey(key, parentLuaGroup)
  if nil == childItemGroup or nil == childItemGroup.element then
    local childItem = self._ui.tree_Npc:AddItem(parentTreeVertex)
    childItem:SetText(text)
    childItem:SetFontColor(color)
    childItem:SetTextureHash(imageKey)
    childItem:SetKey(key)
    return self:insertData(parentLuaGroup, childItem, key, text)
  else
    return childItemGroup
  end
end
function PaGlobal_NpcNavi_All:getCharacterString(npcData)
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
  local executeDialogData = self:getCacheDialogData(npcData:getKeyRaw(), npcData:getDialogIndex())
  if nil ~= executeDialogData then
    local explorePointInfo = ToClient_getExplorePointByTerritoryRaw(executeDialogData.territoryKey)
    if nil ~= explorePointInfo and executeDialogData.needPoint <= explorePointInfo:getRemainedPoint() then
      inputString = inputString .. "(<PAColor0xffe0d5a7>" .. executeDialogData.itemName .. ":" .. executeDialogData.needPoint .. "<PAOldColor>)"
    else
      inputString = inputString .. "(" .. executeDialogData.itemName .. ":" .. executeDialogData.needPoint .. ")"
    end
  end
  if false == NpcConditionCheck(npcData:getKeyRaw()) then
    inputString = "<PAColor0xffbfbfbf>" .. PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_UNKNOWN_NPC")
    return inputString
  else
    return inputString
  end
end
function PaGlobal_NpcNavi_All:createListElement(npcData, parentTreeVertex, parentLuaGroup, key, colorKey)
  local baseIcon, getSpawnType
  if false == IsUseDynamicBSS() then
    getSpawnType = npcData:getSpawnType()
  else
    getSpawnType = getNpcSpawnType(npcData:getKeyRaw())
  end
  local iconHide = 5 < getSpawnType or getSpawnType < 0
  local iconImageKey = 0
  if false == iconHide then
    iconImageKey = self.preLoadTextureKey[getSpawnType]
  end
  local inputString = self:getCharacterString(npcData)
  local characterGroup = self:insertTreeLeaf(parentTreeVertex, parentLuaGroup, inputString, key, iconImageKey, colorKey)
  characterGroup.data = npcData
  return characterGroup
end
function PaGlobal_NpcNavi_All:treeClear()
  self._ui.tree_Npc:ClearTree()
  self.treeGroupData = {}
end
function PaGlobal_NpcNavi_All:updateTownNavi()
  for index, control in pairs(self._warehouseBtns) do
    local data = self._territoryTownData[index]
    if nil ~= data and data._isOpen then
      local actorKey = data._actorKey
      if NpcConditionCheck(actorKey) then
        control:SetMonoTone(false)
      else
        control:SetMonoTone(true)
      end
    end
  end
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
function PaGlobal_NpcNavi_All:npcListUpdate()
  if true == IsUseDynamicBSS() then
    self:newNpcListUpdate()
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
    local territoryMatch = stringMatching(regionInfo.territoryName, self.filterText)
    local regionMatch = stringMatching(regionInfo.areaName, self.filterText)
    local count = npcList_getNpcCount(regionInfo.regionKey)
    local checkFiltering = self.filterText ~= nil and self.filterText:len() ~= 0 and false == territoryMatch and false == regionMatch
    local filterStrCountOverOne = false
    if checkFiltering then
      for idx = 0, count - 1 do
        local npcData = npcList_getNpcInfo(idx)
        local characeterName = self:getCharacterString(npcData)
        if stringMatching(characeterName, self.filterText) and npcData:isImportantNpc() then
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
        if false == self._isConsole then
          WorldMapWindow_Update_ExplorePoint()
        end
      end
      local territoryGroup = self:insertTreeRoot(self.treeGroupData, territoryName, territoryKeyRaw, self.preLoadTextureKey_territory[regionInfo.territoryKey], Defines.Color.C_FFFFAB6D)
      local regionGroup = self:insertTreeVertex(territoryGroup.element, territoryGroup.child, regionInfo.areaName, regionInfo.regionKey, 0, Defines.Color.C_FFFFFFFF)
      if nil ~= self.filterText and self.filterText:len() ~= 0 then
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          local characeterName = self:getCharacterString(npcData)
          if (stringMatching(characeterName, self.filterText) or not checkFiltering) and npcData:isImportantNpc() then
            local characterGroup = self:createListElement(npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), Defines.Color.C_FFFFFFFF)
            territoryGroup.element:SetOpen(true)
            regionGroup.element:SetOpen(true)
          end
        end
      else
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          local characterGroup = npcData:isImportantNpc() and self:createListElement(npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), Defines.Color.C_FFFFFFFF)
        end
      end
    end
  end
  if 0 < regionInfoCount and isFilterFail then
    errorMessageShow = true
  else
    errorMessageShow = false
  end
  self._ui.txt_ErrorText:SetShow(errorMessageShow)
  self._ui.tree_Npc:SetShow(not errorMessageShow)
  self._ui.tree_Npc:SetFilterString("")
  self._ui.tree_Npc:RefreshOpenList()
  if -1 < self.selectIndex then
    self._ui.tree_Npc:SetSelectItem(self.selectIndex)
  end
  if self.isFirstUpdate then
    self.isFirstUpdate = false
  else
    for key, value in pairs(newList) do
      self._ui.tree_Npc:SetSelectItem(value)
    end
    self._ui.tree_Npc:ResetSelectItem()
  end
  self._ui.scroll:SetControlTop()
end
function PaGlobal_NpcNavi_All:newNpcListUpdate()
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
    local territoryMatch = stringMatching(regionInfo.territoryName, self.filterText)
    local regionMatch = stringMatching(regionInfo.areaName, self.filterText)
    local checkFiltering = self.filterText ~= nil and self.filterText:len() ~= 0 and false == territoryMatch and false == regionMatch
    local filterStrCountOverOne = false
    if checkFiltering then
      for idx = 0, count - 1 do
        local npcData = npcList_getNpcInfo(idx)
        if true == isImportantNpc(npcData:getKeyRaw()) then
          local characeterName = self:getCharacterString(npcData)
          if stringMatching(characeterName, self.filterText) then
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
      end
      local territoryGroup = self:insertTreeRoot(self.treeGroupData, territoryName, territoryKeyRaw, self.preLoadTextureKey_territory[regionInfo.territoryKey], Defines.Color.C_FFFFAB6D)
      local regionGroup = self:insertTreeVertex(territoryGroup.element, territoryGroup.child, regionInfo.areaName, regionInfo.regionKey, 0, Defines.Color.C_FFFFFFFF)
      if nil ~= self.filterText and self.filterText:len() ~= 0 then
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          if true == isImportantNpc(npcData:getKeyRaw()) then
            local characeterName = self:getCharacterString(npcData)
            if stringMatching(characeterName, self.filterText) or not checkFiltering then
              local characterGroup = self:createListElement(npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), Defines.Color.C_FFFFFFFF)
              territoryGroup.element:SetOpen(true)
              regionGroup.element:SetOpen(true)
            end
          end
        end
      else
        for idx = 0, count - 1 do
          local npcData = npcList_getNpcInfo(idx)
          if true == isImportantNpc(npcData:getKeyRaw()) then
            local characterGroup = self:createListElement(npcData, regionGroup.element, regionGroup.child, npcData:getKeyRaw(), Defines.Color.C_FFFFFFFF)
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
  self._ui.txt_ErrorText:SetShow(errorMessageShow)
  self._ui.tree_Npc:SetShow(not errorMessageShow)
  self._ui.tree_Npc:SetFilterString("")
  self._ui.tree_Npc:RefreshOpenList()
  if -1 < self.selectIndex then
    self._ui.tree_Npc:SetSelectItem(self.selectIndex)
  end
  if self.isFirstUpdate then
    self.isFirstUpdate = false
  else
    for key, value in pairs(newList) do
      self._ui.tree_Npc:SetSelectItem(value)
    end
    self._ui.tree_Npc:ResetSelectItem()
  end
  self._ui.scroll:SetControlTop()
end
