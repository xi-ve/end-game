function PaGlobal_SA_Window_WorldMap:initialize()
  if true == PaGlobal_SA_Window_WorldMap._initialize then
    return
  end
  self._ui.stc_iconPlayer = UI.getChildControl(Panel_SA_Window_WorldMap, "static_icon_selfPlayer")
  self._ui.stc_mapLineCurrent = UI.getChildControl(Panel_SA_Window_WorldMap, "static_mapLine_current")
  self._ui.stc_mapLineNext = UI.getChildControl(Panel_SA_Window_WorldMap, "static_mapLine_next")
  self._ui.stc_backImg = UI.getChildControl(Panel_SA_Window_WorldMap, "static_radar_Background")
  self._minimapSize.x = self._ui.stc_backImg:GetSizeX()
  self._minimapSize.y = self._ui.stc_backImg:GetSizeY()
  self._ui.stc_backMapImagePanel = UI.createControl(__ePAUIControl_Static, self._ui.stc_backImg, "Static_minimap_BackImagePanel")
  self._ui.stc_BackBlackBG = UI.getChildControl(Panel_SA_Window_WorldMap, "Static_BackBlackBg")
  self._ui.stc_backImg:AddChild(self._ui.stc_BackBlackBG)
  Panel_SA_Window_WorldMap:RemoveControl(self._ui.stc_BackBlackBG)
  self._ui.stc_mapImagePanel = UI.createControl(__ePAUIControl_Static, self._ui.stc_backImg, "Static_minimap_ImagePanel")
  self._ui.stc_blackBG = UI.getChildControl(Panel_SA_Window_WorldMap, "Static_BlackBG")
  self:createMinimap()
  self:resizeMinimap(self:getSizeScale())
  self._ui.stc_mapLineCurrent:SetShow(false)
  self._ui.stc_mapLineNext:SetShow(false)
  self._ui.stc_backImg:AddChild(self._ui.stc_mapLineNext)
  self._ui.stc_backImg:AddChild(self._ui.stc_mapLineCurrent)
  self._ui.stc_backImg:AddChild(self._ui.stc_iconPlayer)
  Panel_SA_Window_WorldMap:RemoveControl(self._ui.stc_mapLineNext)
  Panel_SA_Window_WorldMap:RemoveControl(self._ui.stc_mapLineCurrent)
  Panel_SA_Window_WorldMap:RemoveControl(self._ui.stc_iconPlayer)
  for i = 0, self._partyMemberInfo.maxCount do
    local partyMemeber = UI.getChildControl(Panel_SA_Window_WorldMap, "Static_icon_PartyMember_" .. i)
    self._ui.stc_backImg:AddChild(partyMemeber)
    Panel_SA_Window_WorldMap:RemoveControl(partyMemeber)
    partyMemeber:SetShow(false)
    self._ui.stc_iconPartyMember[i] = partyMemeber
    self._ui.stc_textMemberName[i] = UI.getChildControl(partyMemeber, "StaticText_Name_" .. i)
  end
  Panel_SA_Window_WorldMap:SetChildIndex(self._ui.stc_backImg, 10)
  self._ui.stc_backImg:SetRectClipOnArea(float2(0, 0), float2(self._minimapSize.x, self._minimapSize.y))
  self:pingInitialize()
  self:registEventHandler()
end
function PaGlobal_SA_Window_WorldMap:registEventHandler()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Window_WorldMap_ReSizePanel")
  Panel_SA_Window_WorldMap:RegisterShowEventFunc(true, "PaGlobal_SA_Window_WorldMap_ShowAni()")
  Panel_SA_Window_WorldMap:RegisterShowEventFunc(false, "PaGlobal_SA_Window_WorldMap_HideAni()")
  Panel_SA_Window_WorldMap:RegisterUpdateFunc("PaGlobal_SA_Window_WorldMap_UpdatePerFrame")
  registerEvent("FromClinet_LostRegionInfo", "FromClinet_SA_Window_WorldMap_LostRegionInfo")
  registerEvent("FromClient_ResponseSendPositionGuide", "FromClient_SA_Window_WorldMap_ResponseSendPositionGuide")
end
function PaGlobal_SA_Window_WorldMap:prepareOpen()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
  if true == Panel_SA_Window_WorldMap:GetShow() then
    self:prepareClose()
    return
  end
  self:refreshLostRegionInfo()
  self.isShow = true
  audioPostEvent_SystemUi(1, 21)
  _AudioPostEvent_SystemUiForXBOX(1, 21)
  PaGlobal_SA_Window_WorldMap:open()
end
function PaGlobal_SA_Window_WorldMap:open()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
  Panel_SA_Window_WorldMap:SetShow(true)
end
function PaGlobal_SA_Window_WorldMap:prepareClose()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
  self.isShow = false
  audioPostEvent_SystemUi(1, 22)
  _AudioPostEvent_SystemUiForXBOX(1, 22)
  PaGlobal_SA_Window_WorldMap:close()
end
function PaGlobal_SA_Window_WorldMap:close()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
  Panel_SA_Window_WorldMap:SetShow(false)
end
function PaGlobal_SA_Window_WorldMap:update()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
end
function PaGlobal_SA_Window_WorldMap:validate()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
end
function PaGlobal_SA_Window_WorldMap:pingInitialize()
  local Ping_Effect = UI.getChildControl(Panel_SA_Window_WorldMap, "Static_GetthePoint")
  for i = 0, self.ping._listPingMax do
    self.ping._listPing[i] = UI.createControl(__ePAUIControl_Static, Panel_SA_Window_WorldMap, "Ping_Effect" .. i)
    CopyBaseProperty(Ping_Effect, self.ping._listPing[i])
  end
end
function PaGlobal_SA_Window_WorldMap:getPingEffect()
  if self.ping._listPingMax < self.ping._listPingIdx then
    self.ping._listPingIdx = 0
  end
  local control = self.ping._listPing[self.ping._listPingIdx]
  self.ping._listPingIdx = self.ping._listPingIdx + 1
  return control
end
function PaGlobal_SA_Window_WorldMap:setPingPos(pinPosX, pinPosY)
  local controlUI = PaGlobal_SA_Window_WorldMap:getPingEffect()
  controlUI:EraseAllEffect()
  controlUI:AddEffect("UI_WorldMap_Ping02", false, 0, 0)
  controlUI:ResetVertexAni()
  controlUI:SetShow(true)
  controlUI:SetPosX(pinPosX - controlUI:GetSizeX() * 0.5)
  controlUI:SetPosY(pinPosY - controlUI:GetSizeY() * 0.5)
end
function PaGlobal_SA_Window_WorldMap:addPing(worldPos)
  local sector = convertPosToSector(worldPos)
  if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
    return
  end
  local sectorIndex = self._sectorIndex[sector.x][sector.z]
  local inSectorPos = convertPosToInSectorPos(worldPos)
  local pos = self:getMinimapPos(self.eIndexType.mapPanel, sectorIndex, inSectorPos)
  if nil == pos then
    return
  end
  self:setPingPos(pos.x, pos.y)
end
function PaGlobal_SA_Window_WorldMap:createMinimap()
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
        self._ui.stc_mapImage[imageIndex] = UI.createControl(__ePAUIControl_Static, self._ui.stc_mapImagePanel, "Static_minimap_Image_" .. imageIndex)
      end
      if nil == self._ui.stc_backMapImage[imageIndex] then
        self._ui.stc_backMapImage[imageIndex] = UI.createControl(__ePAUIControl_Static, self._ui.stc_backMapImagePanel, "Static_minimap_BackImage" .. imageIndex)
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
function PaGlobal_SA_Window_WorldMap:resizeMinimap(scale)
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
  local halfSizeX = self._ui.stc_iconPlayer:GetSizeX() * 0.5
  local halfSizeY = self._ui.stc_iconPlayer:GetSizeY() * 0.5
  self._playerIconBasePos.x = -halfSizeX
  self._playerIconBasePos.y = self._resizeMinimapSize.y - halfSizeY
  self:reposition()
end
function PaGlobal_SA_Window_WorldMap:reposition()
  local pos = ToClient_GetCurrentRegionCenter()
  local regionCenter = float3(pos.x, 0, pos.y)
  local sector = convertPosToSector(regionCenter)
  if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
    return
  end
  local sectorIndex = self._sectorIndex[sector.x][sector.z]
  local inSectorPos = convertPosToInSectorPos(regionCenter)
  local targetPos = self:getMinimapPos(self.eIndexType.mapPanel, sectorIndex, inSectorPos)
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
function PaGlobal_SA_Window_WorldMap:setImagePos(image, indexX, indexY, startX, startY)
  image:SetPosXY(startX + indexX * self._miniSectorSize.x + self._offsetX, startY + indexY * self._miniSectorSize.y + self._offsetY)
end
function PaGlobal_SA_Window_WorldMap:setSectorStartPos(imageIndex, indexX, indexY, startX, startY)
  if nil == self._sectorStartPos[imageIndex] then
    self._sectorStartPos[imageIndex] = {}
  end
  self._sectorStartPos[imageIndex].x = startX + indexX * self._miniSectorSize.x + self._offsetX
  self._sectorStartPos[imageIndex].y = startY - (self._maxMapHcount - indexY) * self._miniSectorSize.y + self._miniSectorSize.y + self._offsetY
end
function PaGlobal_SA_Window_WorldMap:getStartPos(pos)
  local maxPos = int2(-(self._resizeMinimapSize.x - self._minimapSize.x), -(self._resizeMinimapSize.y - self._minimapSize.y))
  local ratio = float2(pos.x / self._resizeMinimapSize.x, pos.y / self._resizeMinimapSize.y)
  local value = float2(maxPos.x * ratio.x, maxPos.y * ratio.y)
  return value
end
function PaGlobal_SA_Window_WorldMap:getSizeScale()
  local radius = ToClient_GetCurrentRegionRadius()
  local calRadius = self:getCalculateRadius(radius) * 2
  if 0 < calRadius then
    if calRadius < self._minimapSize.x * 0.1 then
      self:setResizeState(self.eResizeState.zone25)
      return 2.3
    elseif calRadius < self._minimapSize.x * 0.25 then
      self:setResizeState(self.eResizeState.zone25)
      return 1.8
    elseif calRadius < self._minimapSize.x * 0.5 then
      self:setResizeState(self.eResizeState.zone50)
      return 1.3
    elseif calRadius < self._minimapSize.x * 0.7 then
      self:setResizeState(self.eResizeState.zone100)
      return 1.1
    end
  end
  self:setResizeState(self.eResizeState.zone100)
  return 1
end
function PaGlobal_SA_Window_WorldMap:setResizeState(eState)
  if eState == self._eResizeState then
    return
  end
  self._eResizeState = eState
  self:updateMapLine()
end
function PaGlobal_SA_Window_WorldMap:updateMapLine()
  if self.eResizeState.non == self._eResizeState then
    return
  end
  self:setChangeMapLineTexture(self._ui.stc_mapLineCurrent, self._config.strCurrentLine[self._eResizeState], self._config.uvLine[self._eResizeState])
  self:setChangeMapLineTexture(self._ui.stc_mapLineNext, self._config.strNextLine[self._eResizeState], self._config.uvLine[self._eResizeState])
end
function PaGlobal_SA_Window_WorldMap:setChangeMapLineTexture(control, texturePath, uvLine)
  if nil == control or nil == texturePath or nil == uvLine then
    return
  end
  control:ChangeTextureInfoName(texturePath)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_SA_Window_WorldMap:getMinimapPos(eIndexType, sectorIndex, inSectorPos)
  if nil == self._sectorStartPos[sectorIndex] then
    return nil
  end
  local pos
  if self.eIndexType.iconPlayer == eIndexType then
    pos = float2(self._sectorStartPos[sectorIndex].x + (self._playerIconBasePos.x + inSectorPos.x * self._sectorRatio * self._ratio.x), self._sectorStartPos[sectorIndex].y + (self._playerIconBasePos.y - inSectorPos.z * self._sectorRatio * self._ratio.y) - self._offsetY * 2)
  elseif self.eIndexType.mapPanel == eIndexType then
    pos = float2(self._sectorStartPos[sectorIndex].x + inSectorPos.x * self._sectorRatio * self._ratio.x, self._sectorStartPos[sectorIndex].y + (self._resizeMinimapSize.y - inSectorPos.z * self._sectorRatio * self._ratio.y) - self._offsetY * 2)
  end
  return pos
end
function PaGlobal_SA_Window_WorldMap:getCalculateRadius(regionRadius)
  local radius = regionRadius * self._sectorRatio * self._miniSectorSize.x / self._calculateSectorSize
  return radius + radius * 0.021
end
function PaGlobal_SA_Window_WorldMap:setDefaultInfo(mapImage, indexX, indexY)
  mapImage:SetIgnore(false)
  mapImage:SetColor(Defines.Color.C_FFFFFFFF)
  mapImage:SetAlpha(0.78)
  mapImage:SetSize(self._miniSectorSize.x, self._miniSectorSize.y)
  self:setImagePos(mapImage, indexX, indexY, 0, 0)
end
function PaGlobal_SA_Window_WorldMap:updatePlayerPos(deltaTime, isUpdateNow)
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
  local pos = self:getMinimapPos(self.eIndexType.iconPlayer, self._beforeSectorIndex, inSectorPos)
  if nil == pos then
    return
  end
  self._ui.stc_iconPlayer:SetPosXY(pos.x, pos.y)
  self._ui.stc_iconPlayer:SetRotate(cameraRot)
end
function PaGlobal_SA_Window_WorldMap:updateCurrentLostRegionInfo(deltaTime, idUpdateNow)
  if nil == self._ui.stc_mapImagePanel or nil == self._ui.stc_mapLineCurrent then
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
  local mapPanelCenter = self:getMinimapPos(self.eIndexType.mapPanel, sectorIndex, inSectorPos)
  local calRadius = self:getCalculateRadius(radius)
  if nil == mapPanelCenter then
    return
  end
  self._ui.stc_mapImagePanel:SetCircularClipOnArea(mapPanelCenter, calRadius)
  local calculate = self:getMinimapPos(self.eIndexType.mapPanel, sectorIndex, inSectorPos)
  if nil == calculate then
    return
  end
  calRadius = calRadius + calRadius * self._config.currentLineOffset
  local mapLinePos = float2(calculate.x - calRadius, calculate.y - calRadius)
  if false == self._lostRegionInfo.isCallNextRegion then
    self._ui.stc_mapLineNext:SetShow(true)
    self._ui.stc_mapLineCurrent:SetShow(false)
    self._ui.stc_mapLineNext:SetPosXY(mapLinePos.x, mapLinePos.y)
    self._ui.stc_mapLineNext:SetSize(calRadius * 2, calRadius * 2)
    return
  end
  self._ui.stc_mapLineCurrent:SetShow(true)
  self._ui.stc_mapLineCurrent:SetPosXY(mapLinePos.x, mapLinePos.y)
  self._ui.stc_mapLineCurrent:SetSize(calRadius * 2, calRadius * 2)
end
function PaGlobal_SA_Window_WorldMap:updateNextLostRegionInfo(idUpdateNow)
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
  local calculate = self:getMinimapPos(self.eIndexType.mapPanel, sectorIndex, inSectorPos)
  local calRadius = self:getCalculateRadius(radius)
  if nil == calculate then
    return
  end
  calRadius = calRadius + calRadius * self._config.nextLineOffset
  self._ui.stc_mapLineNext:SetShow(true)
  self._ui.stc_mapLineNext:SetPosXY(calculate.x - calRadius, calculate.y - calRadius)
  self._ui.stc_mapLineNext:SetSize(calRadius * 2, calRadius * 2)
end
function PaGlobal_SA_Window_WorldMap:updatePartyMember(deltaTime)
  local memberInfo = self._partyMemberInfo
  local count = PaGlobalFunc_SA_Widget_Party_PartyMemberCount() - 1
  if count ~= memberInfo.count then
    for i = 0, self._partyMemberInfo.maxCount do
      self._ui.stc_iconPartyMember[i]:SetShow(false)
    end
    memberInfo.count = count
  end
  for i = 0, count do
    if false == RequestParty_isSelfPlayer(i) then
      local memberData = RequestParty_getPartyMemberAt(i)
      if nil ~= memberData then
        local memberPos = float3(memberData:getPositionX(), memberData:getPositionY(), memberData:getPositionZ())
        local sector = convertPosToSector(memberPos)
        if sector.x ~= memberInfo._beforeSector.x or sector.z ~= memberInfo._beforeSector.z then
          if nil == self._sectorIndex[sector.x] or nil == self._sectorIndex[sector.x][sector.z] then
            return
          end
          memberInfo._beforeSector = sector
          memberInfo._beforeSectorIndex = self._sectorIndex[sector.x][sector.z]
        end
        memberInfo._beforeMemberPos[i] = memberPos
        local inSectorPos = convertPosToInSectorPos(memberPos)
        local pos = self:getMinimapPos(self.eIndexType.iconPlayer, memberInfo._beforeSectorIndex, inSectorPos)
        if nil == pos then
          return
        end
        self._ui.stc_iconPartyMember[i]:SetShow(true)
        self._ui.stc_iconPartyMember[i]:SetPosXY(pos.x, pos.y)
        self._ui.stc_textMemberName[i]:SetText(memberData:name())
      end
    end
  end
end
function PaGlobal_SA_Window_WorldMap:refreshLostRegionInfo()
  self:updateCurrentLostRegionInfo(self._lostRegionRefreshTime, true)
  self:updateNextLostRegionInfo(true)
  self:updatePlayerPos(0, true)
end
