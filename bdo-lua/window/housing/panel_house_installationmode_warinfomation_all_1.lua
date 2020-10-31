function PaGlobal_WarInfomation_All:initialize()
  if true == PaGlobal_WarInfomation_All._initialize then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_House_InstallationMode_WarInfomation_All, "Static_TitleBG")
  self._ui._stc_categoryBg = UI.getChildControl(Panel_House_InstallationMode_WarInfomation_All, "Static_CategoryBG")
  self._ui._txt_objectTitle[self._eCategory.name] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_InnerObjectNameTitle")
  self._ui._txt_objectTitle[self._eCategory.count] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_InnerObjectCountTitle")
  self._ui._txt_objectTitle[self._eCategory.maxCount] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_InnerObjectMaxCountTitle")
  self._ui._txt_objectTitle[self._eCategory.needSpace] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_InnerObjectSizeTitle")
  self._ui._txt_objectTitle[self._eCategory.needMaterial] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_InnerObjectResourceTitle")
  self._ui._stc_detailGroup = UI.getChildControl(self._ui._stc_categoryBg, "Static_DetailGroup")
  self._ui._stc_templeteBg = UI.getChildControl(self._ui._stc_detailGroup, "Static_TempleteBG")
  self._ui._txt_templete[self._eCategory.name] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_Templete_Name")
  self._ui._txt_templete[self._eCategory.count] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_Templete_Count")
  self._ui._txt_templete[self._eCategory.maxCount] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_Templete_Max")
  self._ui._txt_templete[self._eCategory.needSpace] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_Templete_Need")
  self._ui._txt_templete[self._eCategory.needMaterial] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_Templete_Material")
  self._ui._txt_titlePos[self._eCategory.name] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_NameTitlePos")
  self._ui._txt_titlePos[self._eCategory.count] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_CountTitlePos")
  self._ui._txt_titlePos[self._eCategory.maxCount] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_MaxCountTitlePos")
  self._ui._txt_titlePos[self._eCategory.needSpace] = UI.getChildControl(self._ui._stc_categoryBg, "StaticText_SizeTitlePos")
  self._ui._txt_templetePos[self._eCategory.name] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_TempleteNamePos")
  self._ui._txt_templetePos[self._eCategory.count] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_TempleteCountPos")
  self._ui._txt_templetePos[self._eCategory.maxCount] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_TempleteMaxPos")
  self._ui._txt_templetePos[self._eCategory.needSpace] = UI.getChildControl(self._ui._stc_templeteBg, "StaticText_TempleteNeedPos")
  self._ui._stc_bottomBg = UI.getChildControl(Panel_House_InstallationMode_WarInfomation_All, "Static_BottomGroup")
  self._ui._txt_objectCount = UI.getChildControl(self._ui._stc_bottomBg, "StaticText_ObjectCount")
  self._ui._txt_maxInnerSize = UI.getChildControl(self._ui._stc_bottomBg, "StaticText_MaxInnerSize")
  self._defaultPanelSpan = Panel_House_InstallationMode_WarInfomation_All:GetSpanSize()
  self._defualtPanelSizeX = Panel_House_InstallationMode_WarInfomation_All:GetSizeX()
  self._defaultCategoryBgSizeX = self._ui._stc_categoryBg:GetSizeX()
  self._defaultDetailBgSizeX = self._ui._stc_detailGroup:GetSizeX()
  self._defaultTempleteBgSizeX = self._ui._stc_templeteBg:GetSizeX()
  self._defaultBottomBgSizeX = self._ui._stc_bottomBg:GetSizeX()
  self:createInnerObject()
  PaGlobal_WarInfomation_All:registEventHandler()
  PaGlobal_WarInfomation_All:validate()
  PaGlobal_WarInfomation_All._initialize = true
end
function PaGlobal_WarInfomation_All:registEventHandler()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
end
function PaGlobal_WarInfomation_All:prepareOpen(buildingInfo)
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
  if false == self:update(buildingInfo) then
    PaGlobal_WarInfomation_All:prepareClose()
    return
  end
  self:resize()
  self:updateReposBuilding(buildingInfo)
  PaGlobal_WarInfomation_All:open()
end
function PaGlobal_WarInfomation_All:open()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
  Panel_House_InstallationMode_WarInfomation_All:SetShow(true)
end
function PaGlobal_WarInfomation_All:prepareClose()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
  self._addedNameSizeX = 0
  PaGlobal_WarInfomation_All:close()
end
function PaGlobal_WarInfomation_All:close()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
  Panel_House_InstallationMode_WarInfomation_All:SetShow(false)
end
function PaGlobal_WarInfomation_All:validate()
  if nil == Panel_House_InstallationMode_WarInfomation_All then
    return
  end
end
function PaGlobal_WarInfomation_All:createInnerObject()
  self._innerObjectCount = ToClient_getSiegeObjectKindCount()
  self._innerObjectPool = {}
  for index = 0, self._innerObjectCount - 1 do
    local temp = {}
    temp.stc_bg = UI.createControl(__ePAUIControl_Static, self._ui._stc_detailGroup, "Static_TempleteBG_" .. index)
    CopyBaseProperty(self._ui._stc_templeteBg, temp.stc_bg)
    temp.txt_value = {}
    temp.txt_value[self._eCategory.name] = UI.createControl(__ePAUIControl_StaticText, temp.stc_bg, "StaticText_Templete_Name" .. index)
    CopyBaseProperty(self._ui._txt_templete[self._eCategory.name], temp.txt_value[self._eCategory.name])
    temp.txt_value[self._eCategory.count] = UI.createControl(__ePAUIControl_StaticText, temp.stc_bg, "StaticText_Templete_Count" .. index)
    CopyBaseProperty(self._ui._txt_templete[self._eCategory.count], temp.txt_value[self._eCategory.count])
    temp.txt_value[self._eCategory.maxCount] = UI.createControl(__ePAUIControl_StaticText, temp.stc_bg, "StaticText_Templete_Max" .. index)
    CopyBaseProperty(self._ui._txt_templete[self._eCategory.maxCount], temp.txt_value[self._eCategory.maxCount])
    temp.txt_value[self._eCategory.needSpace] = UI.createControl(__ePAUIControl_StaticText, temp.stc_bg, "StaticText_Templete_Need" .. index)
    CopyBaseProperty(self._ui._txt_templete[self._eCategory.needSpace], temp.txt_value[self._eCategory.needSpace])
    temp.txt_value[self._eCategory.needMaterial] = UI.createControl(__ePAUIControl_StaticText, temp.stc_bg, "StaticText_Templete_Material" .. index)
    CopyBaseProperty(self._ui._txt_templete[self._eCategory.needMaterial], temp.txt_value[self._eCategory.needMaterial])
    self._innerObjectPool[index] = temp
  end
  self._ui._stc_templeteBg:SetShow(false)
end
function PaGlobal_WarInfomation_All:resize()
  local titleBgSize = self._ui._stc_titleBg:GetSizeY()
  local categoryGap = self._ui._stc_detailGroup:GetSpanSize().y
  local templeteGap = self._ui._stc_templeteBg:GetSpanSize().y * 2
  local templeteBgSize = self._ui._stc_templeteBg:GetSizeY() + 2
  local bottomBgSize = self._ui._stc_bottomBg:GetSizeY()
  self._ui._stc_detailGroup:SetSize(self._ui._stc_detailGroup:GetSizeX(), templeteBgSize * self._innerObjectCount + templeteGap)
  self._ui._stc_categoryBg:SetSize(self._ui._stc_categoryBg:GetSizeX(), self._ui._stc_detailGroup:GetSizeY() + categoryGap)
  local categorySize = self._ui._stc_categoryBg:GetSizeY()
  Panel_House_InstallationMode_WarInfomation_All:SetSize(self._defualtPanelSizeX, titleBgSize + categorySize + bottomBgSize + 10)
  self._ui._stc_bottomBg:ComputePos()
  if 0 ~= self._addedNameSizeX then
    Panel_House_InstallationMode_WarInfomation_All:SetSize(self._defualtPanelSizeX + self._addedNameSizeX, Panel_House_InstallationMode_WarInfomation_All:GetSizeY())
    self._ui._stc_categoryBg:SetSize(self._defaultCategoryBgSizeX + self._addedNameSizeX, self._ui._stc_categoryBg:GetSizeY())
    self._ui._stc_detailGroup:SetSize(self._defaultDetailBgSizeX + self._addedNameSizeX, self._ui._stc_detailGroup:GetSizeY())
    self._ui._stc_bottomBg:SetSize(self._defaultBottomBgSizeX + self._addedNameSizeX, self._ui._stc_bottomBg:GetSizeY())
    for index = 0, self._innerObjectCount - 1 do
      self._innerObjectPool[index].stc_bg:SetSize(self._defaultTempleteBgSizeX + self._addedNameSizeX, self._innerObjectPool[index].stc_bg:GetSizeY())
    end
    self._ui._txt_objectCount:ComputePos()
    self._ui._txt_maxInnerSize:ComputePos()
  end
  if true == _ContetnsGroup_SiegeResource then
    for i = 0, self._eCategory.loopCount do
      self._ui._txt_objectTitle[i]:SetShow(true)
      self._ui._txt_objectTitle[i]:ComputePos()
    end
    for index = 0, self._innerObjectCount - 1 do
      for i = 0, self._eCategory.loopCount do
        self._innerObjectPool[index].txt_value[i]:SetShow(true)
        self._innerObjectPool[index].txt_value[i]:ComputePos()
      end
      self._innerObjectPool[index].stc_bg:SetShow(true)
      self._innerObjectPool[index].stc_bg:ComputePos()
      self._innerObjectPool[index].stc_bg:SetPosY(self._innerObjectPool[index].stc_bg:GetPosY() + templeteBgSize * index)
    end
  else
    for i = 0, self._eCategory.loopCount do
      if nil ~= self._ui._txt_titlePos[i] then
        self._ui._txt_objectTitle[i]:SetShow(true)
        self._ui._txt_titlePos[i]:ComputePos()
        self._ui._txt_objectTitle[i]:SetSpanSize(self._ui._txt_titlePos[i]:GetSpanSize().x, self._ui._txt_objectTitle[i]:GetSpanSize().y)
        self._ui._txt_objectTitle[i]:ComputePos()
      else
        self._ui._txt_objectTitle[i]:SetShow(false)
      end
    end
    for index = 0, self._innerObjectCount - 1 do
      for i = 0, self._eCategory.loopCount do
        if nil ~= self._ui._txt_templetePos[i] then
          self._innerObjectPool[index].txt_value[i]:SetShow(true)
          self._ui._txt_templetePos[i]:ComputePos()
          self._innerObjectPool[index].txt_value[i]:SetSpanSize(self._ui._txt_templetePos[i]:GetSpanSize().x, self._innerObjectPool[index].txt_value[i]:GetSpanSize().y)
          self._innerObjectPool[index].txt_value[i]:ComputePos()
        else
          self._innerObjectPool[index].txt_value[i]:SetShow(false)
        end
        self._innerObjectPool[index].stc_bg:SetShow(true)
        self._innerObjectPool[index].stc_bg:ComputePos()
        self._innerObjectPool[index].stc_bg:SetPosY(self._innerObjectPool[index].stc_bg:GetPosY() + templeteBgSize * index)
      end
    end
  end
end
function PaGlobal_WarInfomation_All:update(buildingInfo)
  if nil ~= buildingInfo then
    self:updateByBuildingInfo(buildingInfo)
    return true
  else
    return self:updateByHouseHoldActor()
  end
end
function PaGlobal_WarInfomation_All:updateByBuildingInfo(buildingInfo)
  local buildInfo = buildingInfo:ToClient_getBuildingStaticStatus()
  if nil == buildInfo then
    return
  end
  local CSSW = buildInfo:getCharacterStaticStatusWrapper()
  if nil == CSSW then
    return
  end
  local OSSW = CSSW:getObjectStaticStatus()
  local allCount = buildInfo:getAllInstanceObjectCount()
  local usedCount = 0
  local maxNameLength = 0
  for index = 0, self._innerObjectCount - 1 do
    local characterWrapper = ToClient_getObjectStaticStatusByObjectKindbyIndex(index)
    local objectWrapper = characterWrapper:getObjectStaticStatus()
    if nil ~= objectWrapper then
      local objectKind = objectWrapper:getObjectKind()
      local objectCount = buildInfo:getInstanceObjectCount(objectKind)
      self._innerObjectPool[index].txt_value[self._eCategory.name]:SetText(characterWrapper:getName())
      self._innerObjectPool[index].txt_value[self._eCategory.count]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", objectCount))
      self._innerObjectPool[index].txt_value[self._eCategory.maxCount]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getMaxCountByObjectKind(objectKind)))
      self._innerObjectPool[index].txt_value[self._eCategory.needSpace]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", objectWrapper:getInnerObjectSize()))
      self._innerObjectPool[index].txt_value[self._eCategory.needMaterial]:SetText(objectWrapper:getSiegeResource())
      usedCount = usedCount + objectWrapper:getInnerObjectSize() * objectCount
      local textSizeX = self._innerObjectPool[index].txt_value[self._eCategory.name]:GetTextSizeX()
      if maxNameLength < textSizeX and textSizeX > self._ui._txt_templete[self._eCategory.name]:GetSizeX() then
        maxNameLength = self._innerObjectPool[index].txt_value[self._eCategory.name]:GetTextSizeX()
      end
    end
  end
  self._ui._txt_objectCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", allCount))
  self._ui._txt_maxInnerSize:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", OSSW:getInnerObjectSize()) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTLEFTCOUNT", "count", OSSW:getInnerObjectSize() - usedCount))
  if 0 ~= maxNameLength then
    self._addedNameSizeX = maxNameLength - self._ui._txt_templete[self._eCategory.name]:GetSizeX()
  end
end
function PaGlobal_WarInfomation_All:updateByHouseHoldActor()
  Panel_House_InstallationMode_WarInfomation_All:SetSpanSize(self._defaultPanelSpan.x, self._defaultPanelSpan.y)
  Panel_House_InstallationMode_WarInfomation_All:ComputePos()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper then
    return false
  end
  local houseSSW = houseWrapper:getStaticStatusWrapper()
  if nil == houseSSW then
    return false
  end
  local actorKeyRaw = houseWrapper:getActorKey()
  local buildingInfo = ToClient_getBuildingInfo(actorKeyRaw)
  if nil == buildingInfo then
    return false
  end
  local allCount = buildingInfo:getAllInstanceObjectCount()
  local cOSW = houseSSW:getObjectStaticStatus()
  local usedCount = 0
  for index = 0, self._innerObjectCount - 1 do
    local characterWrapper = ToClient_getObjectStaticStatusByObjectKindbyIndex(index)
    local objectWrapper = characterWrapper:getObjectStaticStatus()
    if nil ~= objectWrapper then
      local objectKind = objectWrapper:getObjectKind()
      local objectCount = buildingInfo:getInstanceObjectCount(objectKind)
      self._innerObjectPool[index].txt_value[self._eCategory.name]:SetText(characterWrapper:getName())
      self._innerObjectPool[index].txt_value[self._eCategory.count]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", objectCount))
      self._innerObjectPool[index].txt_value[self._eCategory.maxCount]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getMaxCountByObjectKind(objectKind)))
      self._innerObjectPool[index].txt_value[self._eCategory.needSpace]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", objectWrapper:getInnerObjectSize()))
      self._innerObjectPool[index].txt_value[self._eCategory.needMaterial]:SetText(objectWrapper:getSiegeResource())
      usedCount = usedCount + objectWrapper:getInnerObjectSize() * objectCount
    end
  end
  self._ui._txt_objectCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", allCount))
  self._ui._txt_maxInnerSize:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", cOSW:getInnerObjectSize()) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTLEFTCOUNT", "count", cOSW:getInnerObjectSize() - usedCount))
end
function PaGlobal_WarInfomation_All:updateReposBuilding(buildingInfo)
  if nil == buildingInfo then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local posX = buildingInfo:GetPosX() + 50
  local posY = buildingInfo:GetPosY() + 50
  local sizeX = Panel_House_InstallationMode_WarInfomation_All:GetSizeX()
  local sizeY = Panel_House_InstallationMode_WarInfomation_All:GetSizeY()
  if screenX < posX + sizeX then
    posX = posX - sizeX - 50
  end
  if screenY < posY + sizeY then
    posY = posY - (posY + sizeY - screenY)
  end
  if true == _ContentsGroup_UsePadSnapping and true == ToClient_WorldMapIsShow() and nil ~= Panel_Worldmap_BottomMenu and true == Panel_Worldmap_BottomMenu:GetShow() and Panel_Worldmap_BottomMenu:GetPosY() < posY + sizeY then
    local gap = posY + sizeY - Panel_Worldmap_BottomMenu:GetPosY()
    posY = posY - gap
  end
  Panel_House_InstallationMode_WarInfomation_All:SetPosX(string.format("%d", posX))
  Panel_House_InstallationMode_WarInfomation_All:SetPosY(string.format("%d", posY))
end
