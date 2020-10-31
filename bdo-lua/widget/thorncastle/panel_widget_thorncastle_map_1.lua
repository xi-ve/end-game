function PaGlobal_ThornCastle_Map:initialize()
  if true == PaGlobal_ThornCastle_Map._initialize then
    return
  end
  self._ui._backBG = UI.getChildControl(Panel_Widget_ThornCastle_Map, "Static_BlackBG")
  self._ui._mapTexture = UI.getChildControl(Panel_Widget_ThornCastle_Map, "static_MapTexture")
  self._ui._selfIcon = UI.getChildControl(Panel_Widget_ThornCastle_Map, "static_icon_selfPlayer")
  self._ui._cripIcon = UI.getChildControl(Panel_Widget_ThornCastle_Map, "Static_Icon_Crip")
  self._ui._bossIcon = UI.getChildControl(Panel_Widget_ThornCastle_Map, "Static_Icon_LastBoss")
  self._ui._npcIcon = UI.getChildControl(Panel_Widget_ThornCastle_Map, "Static_Icon_NPC")
  for ii = 0, 3 do
    self._ui._teamIcon[ii] = UI.getChildControl(Panel_Widget_ThornCastle_Map, "Static_icon_PartyMember_" .. tostring(ii))
  end
  self._mapSizeX = Panel_Widget_ThornCastle_Map:GetSizeX()
  self._mapSizeY = Panel_Widget_ThornCastle_Map:GetSizeY()
  PaGlobal_ThornCastle_Map:validate()
  PaGlobal_ThornCastle_Map:registEventHandler()
  self._ui._npcIcon:SetShow(false)
  self._ui._bossIcon:SetShow(false)
  self._ui._cripIcon:SetShow(false)
  for ii = 0, 3 do
    self._ui._teamIcon[ii]:SetShow(false)
  end
  PaGlobal_ThornCastle_Map._initialize = true
end
function PaGlobal_ThornCastle_Map:prepareOpen()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  local teamNo = ToClient_GetOthilitaTeamNo()
  if 0 == teamNo then
    self._ui._mapTexture:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Rader/ThornCastle/Combine_Etc_Map_ThornyTree_Ateam.dds")
  else
    self._ui._mapTexture:ChangeTextureInfoName("New_UI_Common_forLua/Widget/Rader/ThornCastle/Combine_Etc_Map_ThornyTree_Bteam.dds")
  end
  self._ui._mapTexture:setRenderTexture(self._ui._mapTexture:getBaseTexture())
  self._ui._backBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._backBG:ComputePos()
  _PA_LOG("\237\149\156\236\176\189\237\155\136", "X " .. self._mapSizeX .. " Y " .. self._mapSizeY)
  _PA_LOG("\237\149\156\236\176\189\237\155\136", "X " .. Panel_Widget_ThornCastle_Map:GetSizeX() .. " Y " .. Panel_Widget_ThornCastle_Map:GetSizeY())
  Panel_Widget_ThornCastle_Map:SetPosX((getScreenSizeX() - Panel_Widget_ThornCastle_Map:GetSizeX()) / 2)
  Panel_Widget_ThornCastle_Map:SetPosY((getScreenSizeY() - Panel_Widget_ThornCastle_Map:GetSizeY()) / 2)
  self:open()
end
function PaGlobal_ThornCastle_Map:open()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  Panel_Widget_ThornCastle_Map:SetShow(true)
end
function PaGlobal_ThornCastle_Map:prepareClose()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  self:close()
end
function PaGlobal_ThornCastle_Map:close()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  Panel_Widget_ThornCastle_Map:SetShow(false)
end
function PaGlobal_ThornCastle_Map:toggle()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  if true == Panel_Widget_ThornCastle_Map:GetShow() then
    PaGlobal_ThornCastle_Map:prepareClose()
  else
    PaGlobal_ThornCastle_Map:prepareOpen()
  end
end
function PaGlobal_ThornCastle_Map:validate()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  self._ui._backBG:isValidate()
  self._ui._mapTexture:isValidate()
  self._ui._selfIcon:isValidate()
  self._ui._cripIcon:isValidate()
  self._ui._bossIcon:isValidate()
  self._ui._npcIcon:isValidate()
  for ii = 0, 3 do
    self._ui._teamIcon[ii]:isValidate()
  end
end
function PaGlobal_ThornCastle_Map:setIconPos(control, percentX, percentZ)
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  control:SetPosX(self._mapSizeX * percentX - control:GetSizeX() / 2)
  control:SetPosY(self._mapSizeY * percentZ - control:GetSizeY() / 2)
end
function PaGlobal_ThornCastle_Map:updateSelfIcon()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  self._ui._selfIcon:SetRotate(getCameraRotation())
  local selfPositionOnMap = self:CastToPositionOnMap(selfPlayerWrapper:get3DPos())
  self:setIconPos(self._ui._selfIcon, selfPositionOnMap.x, selfPositionOnMap.z)
end
function PaGlobal_ThornCastle_Map:updateNpcIcon()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  self._ui._npcIcon:SetShow(true)
  local npcPositionOnMap = self:CastToPositionOnMap(ToClient_GetOthilitaNpcPosition())
  self:setIconPos(self._ui._npcIcon, npcPositionOnMap.x, npcPositionOnMap.z)
end
function PaGlobal_ThornCastle_Map:updatePartyIcon()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local partyMemberCount = RequestParty_getPartyMemberCount()
  local memberData = RequestParty_getPartyMemberAt(0)
  local iconIndex = 0
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil ~= memberData and selfPlayerWrapper:getActorKey() ~= memberData:getActorKey() then
      local nearMember = getCharacterActor(memberData:getActorKey())
      local memberPos
      if nil ~= nearMember then
        memberPos = nearMember:get():getPosition()
      else
        memberPos = float3(memberData:getPositionX(), 0, memberData:getPositionZ())
      end
      local memberPositionOnMap = self:CastToPositionOnMap(memberPos)
      self:setIconPos(self._ui._teamIcon[iconIndex], memberPositionOnMap.x, memberPositionOnMap.z)
      self._ui._teamIcon[iconIndex]:SetShow(true)
      iconIndex = iconIndex + 1
    end
  end
end
function PaGlobal_ThornCastle_Map:updateBossIcon()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  if false == ToClient_GetOthilitaIsSpawnBoss() then
    self._ui._bossIcon:SetShow(false)
    return
  end
  self._ui._bossIcon:SetShow(true)
  local bossfPositionOnMap = self:CastToPositionOnMap(ToClient_GetOthilitaBossPosition())
  self:setIconPos(self._ui._bossIcon, bossfPositionOnMap.x, bossfPositionOnMap.z)
end
function PaGlobal_ThornCastle_Map:CastToPositionOnMap(pasition)
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  local positionOnMap = float3(0, 0, 0)
  local posMin, posMax
  local teamNo = ToClient_GetOthilitaTeamNo()
  if 0 == teamNo then
    posMin = float3(-435200, 0, -883200)
    posMax = float3(-345600, 0, -793600)
  else
    posMin = float3(-345600, 0, -870400)
    posMax = float3(-256000, 0, -780800)
  end
  local resultX = (pasition.x - posMin.x) / (posMax.x - posMin.x)
  resultX = math.max(resultX, 0)
  resultX = math.min(resultX, 1)
  local resultZ = (posMax.z - pasition.z) / (posMax.z - posMin.z)
  resultZ = math.max(resultZ, 0)
  resultZ = math.min(resultZ, 1)
  positionOnMap.x = resultX
  positionOnMap.y = 0
  positionOnMap.z = resultZ
  return positionOnMap
end
function PaGlobal_ThornCastle_Map:updateCripIcon()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
end
function ThornCastle_Map_UpdatePerFrame(deltaTime)
  PaGlobal_ThornCastle_Map:updateSelfIcon()
  PaGlobal_ThornCastle_Map:updatePartyIcon()
  PaGlobal_ThornCastle_Map:updateBossIcon()
  PaGlobal_ThornCastle_Map:updateCripIcon()
  PaGlobal_ThornCastle_Map:updateNpcIcon()
end
function PaGlobal_ThornCastle_Map:registEventHandler()
  if nil == Panel_Widget_ThornCastle_Map then
    return
  end
  Panel_Widget_ThornCastle_Map:RegisterUpdateFunc("ThornCastle_Map_UpdatePerFrame")
end
