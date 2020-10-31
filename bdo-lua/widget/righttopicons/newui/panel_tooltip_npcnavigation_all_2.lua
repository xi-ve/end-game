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
local IM = CppEnums.EProcessorInputMode
local _math_AddVectorToVector = Util.Math.AddVectorToVector
local _math_MulNumberToVector = Util.Math.MulNumberToVector
function PaGlobal_NpcNaviTooltip_UpdateIntimacyCircle(characterKeyRaw)
  local self = PaGlobal_NpcNavi_Tooltip
  local intimacy = getIntimacyByCharacterKey(characterKeyRaw)
  self._ui.txt_FruitageValue:SetText(tostring(intimacy))
  local valuePercent = intimacy / 1000 * 100
  if 100 < valuePercent then
    valuePercent = 100
  end
  self._ui.CircularProgress:SetProgressRate(valuePercent)
  local count = getIntimacyInformationCount(characterKeyRaw)
  local colorKey = float4(1, 1, 1, 1)
  local startSize = 28
  local endSize = (self._ui.stc_ProgressBG:GetSizeX() + self._ui.stc_GiftIcon:GetSizeX()) / 2
  local centerPosition = float3(self._ui.stc_ProgressBG:GetPosX() + self._ui.stc_ProgressBG:GetSizeX() / 2, self._ui.stc_ProgressBG:GetPosY() + self._ui.stc_ProgressBG:GetSizeY() / 2, 0)
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
        _npcNavi_Target = UI.createControl(__ePAUIControl_Static, Panel_Tooltip_NpcNavigation_All, "GiftIcon_" .. tostring(index))
        giftIcon[index] = _npcNavi_Target
        CopyBaseProperty(self._ui.stc_GiftIcon, _npcNavi_Target)
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
function PaGlobal_NpcNaviTooltip_OverBarUpdate(isShow)
  local self = PaGlobal_NpcNavi_Tooltip
  local index = PaGlobal_NpcNavi_All_GetOverIndex()
  local isUiMode = CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode == getInputMode()
  if -1 == index or false == isUiMode or false == isShow then
    self:prepareClose()
    if false == _ContentsGroup_UsePadSnapping then
      PaGlobal_NpcNavi_All_SetOverIndex(-1)
    end
    return
  end
  local SizeY = 0
  local isUpdateIntimacy = false
  local spawnRegionData = PaGlobal_NpcNavi_All:getOverItemSpawnRegionData()
  self:resetUI()
  if nil ~= spawnRegionData then
    if false == NpcConditionCheck(spawnRegionData:getKeyRaw()) then
      self._ui.txt_NpcName:SetShow(true)
      self._ui.txt_NotFind:SetShow(true)
      self._ui.txt_NpcName:SetText(PaGlobal_NpcNavi_All:getCharacterString(spawnRegionData))
      if _npcNavi_Target ~= nil then
        for _, control in pairs(giftIcon) do
          control:SetShow(false)
        end
      end
      SizeY = self._ui.txt_NotFind:GetPosY() + self._ui.txt_NotFind:GetTextSizeY()
    else
      self._ui.txt_NpcName:SetShow(true)
      self._ui.txt_NpcDesc:SetShow(true)
      self._ui.stc_ProgressBG:SetShow(true)
      self._ui.CircularProgress:SetShow(true)
      self._ui.txt_FruitageValue:SetShow(true)
      if false == IsUseDynamicBSS() then
        self._ui.txt_NpcName:SetText(spawnRegionData:getName())
      else
        self._ui.txt_NpcName:SetText(getNpcName(spawnRegionData:getKeyRaw()))
      end
      if spawnRegionData:hasTimeSpawn() then
        local tooltipStr = ""
        if spawnRegionData:isTimeSpawn(math.floor(getIngameTime_minute() / 60)) then
          tooltipStr = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_OPEN")
        else
          tooltipStr = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_CLOSED")
        end
        local startHour = convertVariableTime(spawnRegionData:getSpawnStartTime() * 3600)
        local startMin = math.floor(startHour % 3600 / 60)
        startHour = math.floor(startHour / 3600)
        local endHour = convertVariableTime(spawnRegionData:getSpawnEndTime() * 3600)
        local endMin = math.floor(endHour % 3600 / 60)
        endHour = math.floor(endHour / 3600)
        self._ui.txt_NpcDesc:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_OPEN_TIME", "opentime", startHour .. ":" .. startMin, "closetime", endHour .. ":" .. endMin) .. tooltipStr)
      else
        self._ui.txt_NpcDesc:SetText(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_EVERYDAYS_OPEN"))
      end
      local executeDialogData = PaGlobal_NpcNavi_All:getCacheDialogData(spawnRegionData:getKeyRaw(), spawnRegionData:getDialogIndex())
      local explorePointInfo
      if nil ~= executeDialogData then
        explorePointInfo = ToClient_getExplorePointByTerritoryRaw(executeDialogData.territoryKey)
      end
      if nil ~= explorePointInfo then
        self._ui.txt_itemName:SetShow(true)
        self._ui.stc_Icon:SetShow(true)
        self._ui.txt_Description:SetShow(true)
        self._ui.txt_NeedExplorePoint:SetShow(true)
        self._ui.txt_Description:SetText(executeDialogData.itemDescription)
        self._ui.txt_itemName:SetText(executeDialogData.itemName)
        self._ui.stc_Icon:ChangeTextureInfoName("Icon/" .. executeDialogData.itemPath)
        if executeDialogData.needAdditionalCondtion then
          local stringData = PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_TOOLTIP_NEEDPOINTANDMINE_ADDCONDITION", "needPoint", executeDialogData.needPoint, "myPoint", explorePointInfo:getRemainedPoint())
          self._ui.txt_NeedExplorePoint:SetText(stringData)
        else
          local stringData = PAGetStringParam2(Defines.StringSheet_GAME, "NPCNAVIGATION_TOOLTIP_NEEDPOINTANDMINE", "needPoint", executeDialogData.needPoint, "myPoint", explorePointInfo:getRemainedPoint())
          self._ui.txt_NeedExplorePoint:SetText(stringData)
        end
        self._ui.txt_Description:SetPosY(self._ui.txt_itemName:GetPosY() + self._ui.txt_itemName:GetTextSizeY() + 5)
        local explorePointPosY = self._ui.txt_Description:GetPosY() + self._ui.txt_Description:GetTextSizeY() + 5
        self._ui.txt_NeedExplorePoint:SetPosY(explorePointPosY)
        local ProgressPosY = self._ui.stc_GiftIcon:GetSizeY() + self._ui.txt_NeedExplorePoint:GetPosY() + self._ui.txt_NeedExplorePoint:GetTextSizeY() + 20
        self._ui.stc_ProgressBG:SetPosY(ProgressPosY)
        self._ui.CircularProgress:SetPosY(ProgressPosY)
        self._ui.txt_FruitageValue:SetPosY(ProgressPosY)
        isUpdateIntimacy = isIntimacyCharacterByKey(spawnRegionData:getKeyRaw())
        if isUpdateIntimacy then
          SizeY = self._ui.CircularProgress:GetPosY() + self._ui.CircularProgress:GetSizeY() + self._ui.stc_GiftIcon:GetSizeY()
        else
          SizeY = self._ui.txt_NeedExplorePoint:GetPosY() + self._ui.txt_NeedExplorePoint:GetTextSizeY()
        end
      else
        local ProgressPosY = self._ui.stc_GiftIcon:GetSizeY() + self._ui.txt_NpcDesc:GetPosY() + self._ui.txt_NpcDesc:GetTextSizeY() + 20
        self._ui.txt_NeedExplorePoint:SetPosY(ProgressPosY)
        self._ui.stc_ProgressBG:SetPosY(ProgressPosY)
        self._ui.CircularProgress:SetPosY(ProgressPosY)
        self._ui.txt_FruitageValue:SetPosY(ProgressPosY)
        isUpdateIntimacy = isIntimacyCharacterByKey(spawnRegionData:getKeyRaw())
        if isUpdateIntimacy then
          SizeY = self._ui.CircularProgress:GetPosY() + self._ui.CircularProgress:GetSizeY() + self._ui.stc_GiftIcon:GetSizeY()
        else
          SizeY = self._ui.txt_NpcDesc:GetPosY() + self._ui.txt_NpcDesc:GetTextSizeY()
        end
      end
    end
    local tooltip_SizeX = 290
    SizeY = SizeY + 10
    Panel_Tooltip_NpcNavigation_All:SetSize(tooltip_SizeX, SizeY)
    Panel_Tooltip_NpcNavigation_All:ComputePos()
    if isUpdateIntimacy then
      self._ui.txt_NeedExplorePoint:ComputePos()
      self._ui.stc_ProgressBG:ComputePos()
      self._ui.CircularProgress:ComputePos()
      self._ui.txt_FruitageValue:ComputePos()
      PaGlobal_NpcNaviTooltip_UpdateIntimacyCircle(spawnRegionData:getKeyRaw())
    end
    self:prepareOpen()
  else
    self:prepareClose()
  end
end
