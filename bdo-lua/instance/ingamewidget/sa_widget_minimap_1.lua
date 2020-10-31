function PaGlobal_SA_Widget_Minimap:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_miniMap = UI.getChildControl(Panel_SA_Widget_Minimap, "Static_Minimap")
  self._ui.stc_regionCondition = UI.getChildControl(self._ui.stc_miniMap, "StaticText_RegionCondition")
  self._ui.txt_remainTimer = UI.getChildControl(self._ui.stc_miniMap, "StaticText_RemainTimer")
  self._ui.stc_InvenBG = UI.getChildControl(Panel_SA_Widget_Minimap, "Static_Inven_BG")
  self._ui.txt_inven = UI.getChildControl(self._ui.stc_InvenBG, "StaticText_Inven")
  self._ui.stc_keyInven = UI.getChildControl(self._ui.stc_InvenBG, "Static_Inven_Key_I")
  self._ui.stc_EscBG = UI.getChildControl(Panel_SA_Widget_Minimap, "Static_Esc_BG")
  self._ui.stc_keyEsc = UI.getChildControl(self._ui.stc_EscBG, "Static_Esc_Key_Esc")
  self._ui.txt_Esc = UI.getChildControl(self._ui.stc_EscBG, "StaticText_Esc")
  self:registEventHandler()
  self:initializeControl()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_Minimap:registEventHandler()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Minimap_ResizePanel()")
  Panel_SA_Widget_Minimap:RegisterUpdateFunc("PaGloabl_SA_Widget_Minimap_UpdatePerFrame")
  registerEvent("FromClinet_LostRegionInfo", "FromClinet_SA_Widget_Minimap_LostRegionInfo")
  registerEvent("FromClient_ResponseSendPositionGuide", "FromClient_SA_Widget_Minimap_ResponseSendPositionGuide")
  registerEvent("FromClient_ClassChangeBattleRoyale", "FromClient_WatchTimer_ClassChangeBattleRoyale")
  registerEvent("FromClient_BattleRoyaleStateChanged", "FromClient_WatchTimer_BattleRoyaleStateChanged")
  registerEvent("FromClient_BattleRoyaleRecord", "FromClient_WatchTimer_BattleRoyaleRecord")
end
function PaGlobal_SA_Widget_Minimap:prepareOpen()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  PaGlobal_SA_Widget_Minimap:open()
end
function PaGlobal_SA_Widget_Minimap:open()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  Panel_SA_Widget_Minimap:SetShow(true)
end
function PaGlobal_SA_Widget_Minimap:prepareClose()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  PaGlobal_SA_Widget_Minimap:close()
end
function PaGlobal_SA_Widget_Minimap:close()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  Panel_SA_Widget_Minimap:SetShow(false)
end
function PaGlobal_SA_Widget_Minimap:update()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
end
function PaGlobal_SA_Widget_Minimap:validate()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
  self._ui.stc_miniMap:isValidate()
  self._ui.stc_regionCondition:isValidate()
  self._ui.txt_remainTimer:isValidate()
  self._ui.stc_InvenBG:isValidate()
  self._ui.txt_inven:isValidate()
  self._ui.stc_keyInven:isValidate()
  self._ui.stc_EscBG:isValidate()
  self._ui.stc_keyEsc:isValidate()
  self._ui.txt_Esc:isValidate()
end
function PaGlobal_SA_Widget_Minimap:initializeControl()
  self._minimapSize.x = self._ui.stc_miniMap:GetSizeX()
  self._minimapSize.y = self._ui.stc_miniMap:GetSizeY()
  self:createMiniMap()
  self:resizeMinimap(self:getSizeScale())
  self._ui.stc_miniMap:SetRectClipOnArea(float2(0, 0), float2(self._minimapSize.x, self._minimapSize.y))
  self:checkClass()
  PaGloabl_SA_Widget_Minimap_Open()
end
function PaGlobal_SA_Widget_Minimap:createMiniMap()
  local sectorNo_LB = ToClient_GetInstanceSectorNo(0)
  local sectorNo_RT = ToClient_GetInstanceSectorNo(1)
  if self._beforeSector_LB.x == sectorNo_LB.x and self._beforeSector_LB.y == sectorNo_LB.y and self._beforeSector_RT.x == sectorNo_RT.x and self._beforeSector_RT.y == sectorNo_RT.y then
    return
  end
  self._beforeSector_LB = sectorNo_LB
  self._beforeSector_RT = sectorNo_RT
  local startX = sectorNo_LB.x
  local startY = sectorNo_RT.y
  local heightIndex = 0
  local imageIndex = 0
  local widthSize = 0
  local heightSize = 0
  local i = 0
  local j = 0
  local radarPath = ToClient_getRadarPath() .. "Rader_"
  while startX <= sectorNo_RT.x do
    heightIndex = i * heightSize
    heightSize = 0
    startY = sectorNo_RT.y
    j = 0
    self._sectorIndex[startX] = {}
    while startY >= sectorNo_LB.y do
      imageIndex = heightIndex + j
      if nil == self._ui.stc_mapImage[imageIndex] then
        self._ui.stc_mapImage[imageIndex] = UI.createControl(__ePAUIControl_Static, self._ui.stc_miniMap, "Static_minimap_Image_" .. imageIndex)
      end
      if nil == self._ui.stc_backMapImage[imageIndex] then
        self._ui.stc_backMapImage[imageIndex] = UI.createControl(__ePAUIControl_Static, self._ui.stc_miniMap, "Static_minimap_BackImage" .. imageIndex)
      end
      local minimap = radarPath .. startX .. "_" .. startY .. ".dds"
      self._ui.stc_mapImage[imageIndex]:ChangeTextureInfoNameForRadarBackground(minimap)
      self._ui.stc_backMapImage[imageIndex]:ChangeTextureInfoNameForRadarBackground(minimap)
      self._sectorIndex[startX][startY] = imageIndex
      heightSize = heightSize + 1
      j = j + 1
      startY = startY - 1
    end
    widthSize = widthSize + 1
    startX = startX + 1
    i = i + 1
  end
  self._maxMapWcount = widthSize
  self._maxMapHcount = heightSize
end
function PaGlobal_SA_Widget_Minimap:resizeMinimap(scale)
  self._sizeScale = scale
  self._resizeMinimapSize.x = self._minimapSize.x * scale
  self._resizeMinimapSize.y = self._minimapSize.y * scale
  self._miniSectorSize.x = self._resizeMinimapSize.x / self._maxMapWcount
  self._miniSectorSize.y = self._resizeMinimapSize.y / self._maxMapHcount
  local widthCount = self._maxMapWcount - 1
  local heightCount = self._maxMapHcount - 1
  for i = 0, widthCount do
    local widthIndex = i * self._maxMapWcount
    for j = 0, heightCount do
      local imageIndex = widthIndex + j
      self:setDefaultInfo(self._ui.stc_mapImage[imageIndex], i, j)
      self:setDefaultInfo(self._ui.stc_backMapImage[imageIndex], i, j)
      self:setSectorStartPos(imageIndex, i, j, 0, 0)
    end
  end
  self._ratio.x = self._miniSectorSize.x / self._calculateSectorSize
  self._ratio.y = self._miniSectorSize.y / self._calculateSectorSize
  self:reposition()
end
function PaGlobal_SA_Widget_Minimap:setDefaultInfo(mapImage, indexX, indexY)
  mapImage:SetIgnore(false)
  mapImage:SetColor(Defines.Color.C_FFFFFFFF)
  mapImage:SetAlpha(0.78)
  mapImage:SetSize(self._miniSectorSize.x, self._miniSectorSize.y)
  self:setImagePos(mapImage, indexX, indexY, 0, 0)
end
function PaGlobal_SA_Widget_Minimap:setImagePos(image, indexX, indexY, startX, startY)
  image:SetPosXY(startX + indexX * self._miniSectorSize.x + self._offsetX, startY + indexY * self._miniSectorSize.y + self._offsetY)
end
function PaGlobal_SA_Widget_Minimap:setSectorStartPos(imageIndex, indexX, indexY, startX, startY)
  if nil == self._sectorStartPos[imageIndex] then
    self._sectorStartPos[imageIndex] = {}
  end
  self._sectorStartPos[imageIndex].x = startX + indexX * self._miniSectorSize.x + self._offsetX
  self._sectorStartPos[imageIndex].y = startY - (self._maxMapHcount - indexY) * self._miniSectorSize.y + self._miniSectorSize.y + self._offsetY
end
function PaGlobal_SA_Widget_Minimap:reposition()
  local pos = ToClient_GetCurrentRegionCenter()
  local regionCenter = float3(pos.x, 0, pos.y)
  local sector = convertPosToSector(regionCenter)
  if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
    return
  end
  local sectorIndex = self._sectorIndex[sector.x][sector.z]
  local inSectorPos = convertPosToInSectorPos(regionCenter)
  local targetPos = self:getMinimapPos(self._eIndexType.mapPanel, sectorIndex, inSectorPos)
  if nil == targetPos then
    return
  end
  local startPos = self:getStartPos(targetPos)
  local widthCount = self._maxMapWcount - 1
  local heightCount = self._maxMapHcount - 1
  for i = 0, widthCount do
    local widthIndex = i * self._maxMapWcount
    for j = 0, heightCount do
      local imageIndex = widthIndex + j
      self:setImagePos(self._ui.stc_mapImage[imageIndex], i, j, startPos.x, startPos.y)
      self:setImagePos(self._ui.stc_backMapImage[imageIndex], i, j, startPos.x, startPos.y)
      self:setSectorStartPos(imageIndex, i, j, startPos.x, startPos.y)
    end
  end
end
function PaGlobal_SA_Widget_Minimap:getMinimapPos(eIndexType, sectorIndex, inSectorPos)
  if nil == self._sectorStartPos[sectorIndex] then
    return nil
  end
  local pos
  if self._eIndexType.iconPlayer == eIndexType then
    pos = float2(self._sectorStartPos[sectorIndex].x + (self._playerIconBasePos.x + inSectorPos.x * self._sectorRatio * self._ratio.x), self._sectorStartPos[sectorIndex].y + (self._playerIconBasePos.y - inSectorPos.z * self._sectorRatio * self._ratio.y) - self._offsetY * 2)
  elseif self._eIndexType.mapPanel == eIndexType then
    pos = float2(self._sectorStartPos[sectorIndex].x + inSectorPos.x * self._sectorRatio * self._ratio.x, self._sectorStartPos[sectorIndex].y + (self._resizeMinimapSize.y - inSectorPos.z * self._sectorRatio * self._ratio.y) - self._offsetY * 2)
  end
  return pos
end
function PaGlobal_SA_Widget_Minimap:getStartPos(pos)
  local maxPos = int2(-(self._resizeMinimapSize.x - self._minimapSize.x), -(self._resizeMinimapSize.y - self._minimapSize.y))
  local ratio = float2(pos.x / self._resizeMinimapSize.x, pos.y / self._resizeMinimapSize.y)
  local value = float2(maxPos.x * ratio.x, maxPos.y * ratio.y)
  return value
end
function PaGlobal_SA_Widget_Minimap:getSizeScale()
  local radius = ToClient_GetCurrentRegionRadius()
  local calRadius = self:getCalculateRadius(radius) * 2
  if 0 < calRadius then
    if calRadius < self._minimapSize.x * 0.1 then
      self:setResizeState(self._eResizeStateType.zone25)
      return 2.3
    elseif calRadius < self._minimapSize.x * 0.25 then
      self:setResizeState(self._eResizeStateType.zone25)
      return 1.8
    elseif calRadius < self._minimapSize.x * 0.5 then
      self:setResizeState(self._eResizeStateType.zone50)
      return 1.3
    elseif calRadius < self._minimapSize.x * 0.7 then
      self:setResizeState(self._eResizeStateType.zone100)
      return 1.1
    end
  end
  self:setResizeState(self._eResizeStateType.zone100)
  return 1
end
function PaGlobal_SA_Widget_Minimap:setResizeState(eState)
  if eState == self._eResizeState then
    return
  end
  self._eResizeState = eState
end
function PaGlobal_SA_Widget_Minimap:updatePlayerPos(deltaTime, isUpdateNow)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local playerPos = selfPlayer:get():getPosition()
  local cameraRot = getCameraRotation()
  if false == isUpdateNow and playerPos.x == self._beforePlayerPos.x and playerPos.z == self._beforePlayerPos.z and cameraRot == self._beforeRotate then
    return
  end
  local sector = convertPosToSector(playerPos)
  if sector.x ~= self._beforeSector.x or sector.z ~= self._beforeSector.z then
    if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
      return
    end
    self._beforeSector = sector
    self._beforeSectorIndex = self._sectorIndex[sector.x][sector.z]
  end
  self._beforePlayerPos = playerPos
  self._beforeRotate = cameraRot
  local inSectorPos = convertPosToInSectorPos(playerPos)
  local pos = self:getMinimapPos(self._eIndexType.iconPlayer, self._beforeSectorIndex, inSectorPos)
  if nil == pos then
    return
  end
end
function PaGlobal_SA_Widget_Minimap:updateCurrentLostRegionInfo(deltaTime, idUpdateNow)
  if nil == self._ui.stc_miniMap then
    return
  end
  self._lostRegionDeltaTime = self._lostRegionDeltaTime + deltaTime
  if self._lostRegionDeltaTime < self._lostRegionRefreshTime then
    return
  end
  self._lostRegionDeltaTime = 0
  local pos = ToClient_GetCurrentRegionCenter()
  local radius = ToClient_GetCurrentRegionRadius()
  if false == idUpdateNow and pos.x == self._lostRegionInfo.currentPos.x and pos.y == self._lostRegionInfo.currentPos.y and radius == self._lostRegionInfo.currentRadius then
    return
  end
  self._lostRegionInfo.currentPos = pos
  self._lostRegionInfo.currentRadius = radius
  local regionCenter = float3(pos.x, 0, pos.y)
  local sector = convertPosToSector(regionCenter)
  if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
    return
  end
  local sectorIndex = self._sectorIndex[sector.x][sector.z]
  local inSectorPos = convertPosToInSectorPos(regionCenter)
  local mapPanelCenter = self:getMinimapPos(self._eIndexType.mapPanel, sectorIndex, inSectorPos)
  local calRadius = self:getCalculateRadius(radius)
  if nil == mapPanelCenter then
    return
  end
  self._ui.stc_miniMap:SetCircularClipOnArea(mapPanelCenter, calRadius)
  local calculate = self:getMinimapPos(self._eIndexType.mapPanel, sectorIndex, inSectorPos)
  if nil == calculate then
    return
  end
end
function PaGlobal_SA_Widget_Minimap:getCalculateRadius(regionRadius)
  local radius = regionRadius * self._sectorRatio * self._miniSectorSize.x / self._calculateSectorSize
  return radius + radius * 0.021
end
function PaGlobal_SA_Widget_Minimap:updateNextLostRegionInfo(idUpdateNow)
  if false == self._lostRegionInfo.isCallNextRegion then
    return
  end
  local pos = ToClient_GetNextRegionCenter()
  local radius = ToClient_GetNextRegionRadius()
  if false == idUpdateNow and pos.x == self._lostRegionInfo.nextPos.x and pos.y == self._lostRegionInfo.nextPos.y and radius == self._lostRegionInfo.nextRadius then
    return
  end
  self._lostRegionInfo.nextPos = pos
  self._lostRegionInfo.nextRadius = radius
  local regionCenter = float3(pos.x, 0, pos.y)
  local sector = convertPosToSector(regionCenter)
  if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
    return
  end
  local sectorIndex = self._sectorIndex[sector.x][sector.z]
  local inSectorPos = convertPosToInSectorPos(regionCenter)
  local calculate = self:getMinimapPos(self._eIndexType.mapPanel, sectorIndex, inSectorPos)
  local calRadius = self:getCalculateRadius(radius)
  if nil == calculate then
    return
  end
end
function PaGlobal_SA_Widget_Minimap:updateRemainTimer(delta)
  if false == self._isGameStart then
    return
  end
  self._timer = self._timer + delta
  if self._timer < self._lastUpdateTime + 1 then
    return
  end
  if 0 == self._brStartTime then
    local brStartTime = ToClient_BattleRoyaleStartTime()
    if nil == brStartTime then
      return
    end
    self._brStartTime = Int64toInt32(brStartTime)
  end
  self._lastUpdateTime = math.floor(self._timer)
  local brStartTime = self._brStartTime
  local serverUtcTime = getServerUtc64()
  local elapsedTime = 0
  if nil ~= brStartTime and nil ~= serverUtcTime then
    elapsedTime = 0
    serverUtcTime = Int64toInt32(serverUtcTime)
    if brStartTime ~= 0 then
      elapsedTime = serverUtcTime - brStartTime
    else
      return
    end
  end
  if elapsedTime < 0 then
    return
  end
  local clockMinutes = math.floor(elapsedTime / 60)
  local clockSeconds = elapsedTime % 60
  local clockMinutesText = ""
  local clockSecondsText = ""
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockMinutesText = clockMinutesText .. "0" .. tostring(clockMinutes)
  else
    clockMinutesText = clockMinutesText .. tostring(clockMinutes)
  end
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockSecondsText = clockSecondsText .. "0" .. tostring(clockSeconds)
  else
    clockSecondsText = clockSecondsText .. tostring(clockSeconds)
  end
  self._ui.txt_remainTimer:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_RESULT_TIME", "minute", clockMinutesText, "second", clockSecondsText))
end
function PaGlobal_SA_Widget_Minimap:checkClass()
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local classType = playerWrapper:getClassType()
  if 2 == classType then
    self._ui.txt_remainTimer:SetShow(false)
  else
    self._ui.txt_remainTimer:SetShow(true)
  end
end
