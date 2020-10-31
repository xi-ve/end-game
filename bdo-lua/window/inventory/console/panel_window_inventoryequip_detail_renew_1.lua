function PaGlobal_InventoryEquip_Detail_Renew:initialize()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  if true == self._initialize then
    return
  end
  self._ui.frame_information = UI.getChildControl(Panel_Window_Inventory_Detail, "Frame_Infomation")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_information, "Frame_1_Content")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_information, "Frame_1_VerticalScroll")
  self._ui.chk_crystal = UI.getChildControl(self._ui.frame_content, "CheckButton_Crystal")
  self._ui.chk_equipset = UI.getChildControl(self._ui.frame_content, "CheckButton_EquipSet")
  self._ui.stc_crystal_template = UI.getChildControl(self._ui.frame_content, "Static_CrystalBg_Template")
  self._ui.stc_equipset_template = UI.getChildControl(self._ui.frame_content, "Static_EquipmentSetBg_Template")
  self._ui.stc_crystal_template:SetShow(false)
  self._ui.stc_equipset_template:SetShow(false)
  self._originPanelSizeY = Panel_Window_Inventory_Detail:GetSizeY()
  self:createControls()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_InventoryEquip_Detail_Renew:registEventHandler()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self._ui.chk_crystal:addInputEvent("Mouse_LUp", "HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()")
  self._ui.chk_equipset:addInputEvent("Mouse_LUp", "HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedSet()")
  registerEvent("EventEquipmentUpdate", "FromClient_InventoryEquip_Detail_Renew_EquipmentChanged")
  registerEvent("EventServantEquipmentUpdate", "FromClient_InventoryEquip_Detail_Renew_EquipmentChanged")
end
function PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(isSimpleInventory)
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self._isSimpleInventory = isSimpleInventory
  self:setPanelSize()
  self:openUisetting()
  self:open()
end
function PaGlobal_InventoryEquip_Detail_Renew:open()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  Panel_Window_Inventory_Detail:SetShow(true)
end
function PaGlobal_InventoryEquip_Detail_Renew:prepareClose()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self:close()
end
function PaGlobal_InventoryEquip_Detail_Renew:close()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  Panel_Window_Inventory_Detail:SetShow(false)
end
function PaGlobal_InventoryEquip_Detail_Renew:validate()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self._ui.frame_information:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.chk_crystal:isValidate()
  self._ui.stc_crystal_template:isValidate()
  self._ui.chk_equipset:isValidate()
  self._ui.stc_equipset_template:isValidate()
end
function PaGlobal_InventoryEquip_Detail_Renew:setPanelSize()
  local titleAreaSizeY = 50
  if true == self._isSimpleInventory then
    if nil == Panel_Window_SimpleInventory then
      return
    end
    local simpleInventorySizeY = Panel_Window_SimpleInventory:GetSizeY()
    Panel_Window_Inventory_Detail:SetSize(Panel_Window_Inventory_Detail:GetSizeX(), simpleInventorySizeY)
    self._ui.frame_information:SetSize(self._ui.frame_information:GetSizeX(), simpleInventorySizeY - titleAreaSizeY)
  else
    Panel_Window_Inventory_Detail:SetSize(Panel_Window_Inventory_Detail:GetSizeX(), self._originPanelSizeY)
    self._ui.frame_information:SetSize(self._ui.frame_information:GetSizeX(), self._originPanelSizeY - titleAreaSizeY)
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:openUisetting()
  if nil == Panel_Window_Inventory then
    return
  end
  if true == self._isSimpleInventory then
    if nil == Panel_Window_SimpleInventory then
      return
    end
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_SimpleInventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_SimpleInventory:GetPosY())
  else
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_Inventory:GetPosY())
  end
  self._ui.chk_crystal:SetCheck(true)
  HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()
  if true == self._isSimpleInventory then
    self._ui.chk_equipset:SetShow(false)
  else
    self._ui.chk_equipset:SetShow(true)
    HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedSet()
  end
  self._ui.frame_vScroll:SetControlTop()
  self._ui.frame_information:UpdateContentScroll()
  self._ui.frame_information:UpdateContentPos()
  self._ui.frame_information:UpdateContentPosWithSnap()
end
function PaGlobal_InventoryEquip_Detail_Renew:createControls()
  for crystalGroupIndex = 1, self._equipNoMax + 1 do
    if nil == self._ui.crystalGroup[crystalGroupIndex] then
      self:createCrystalGroup(crystalGroupIndex)
    end
  end
  for index = 1, 20 do
    if nil == self._ui.setEffectGroup[index] then
      self:createSetEffectGroup(index)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:resetEquippedCrystals()
  for index = 1, #self._ui.crystalGroup do
    if nil ~= self._ui.crystalGroup[index] then
      self._ui.crystalGroup[index].crystalBG:SetShow(false)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:resetEquippedSet()
  for index = 1, #self._ui.setEffectGroup do
    if nil ~= self._ui.setEffectGroup[index] then
      self._ui.setEffectGroup[index].setEffectBG:SetShow(false)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
  self:resetEquippedCrystals()
  local padding = 5
  self._ui.chk_equipset:SetPosY(self._ui.chk_crystal:GetPosY() + self._ui.chk_crystal:GetSizeY() + padding)
  if false == self._ui.chk_crystal:IsCheck() then
    local setEffectSizeY = self:updateEquippedSetEffect()
    setEffectSizeY = setEffectSizeY + (self._ui.chk_equipset:GetSizeY() + padding) * 2
    self:changeVerticalScroll(setEffectSizeY)
    return
  end
  local frameSizeY = 0
  local crystalGroupIndex = 1
  local equipSetPosY = self._ui.chk_equipset:GetPosY()
  local equipWrapper
  if true == self._isSimpleInventory then
    if nil == PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo then
      return
    end
    local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
    if nil == characterNo then
      return
    end
    equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
  end
  for equipNo = self._equipNoMin, self._equipNoMax do
    local itemWrapper
    if true == self._isSimpleInventory then
      local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(self._slotEquipNo[equipNo])
      if nil == equipItemWrapper then
        return
      end
      itemWrapper = equipItemWrapper:getItem()
    else
      itemWrapper = ToClient_getEquipmentItem(self._slotEquipNo[equipNo])
    end
    if nil ~= itemWrapper and 0 ~= itemWrapper:get():getUsableItemSocketCount() then
      frameSizeY = frameSizeY + self:changeCrystalGroup(crystalGroupIndex, itemWrapper)
      equipSetPosY = self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetPosY() + self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetSizeY()
      crystalGroupIndex = crystalGroupIndex + 1
    end
  end
  self._ui.chk_equipset:SetPosY(equipSetPosY + padding)
  frameSizeY = frameSizeY + self:updateEquippedSetEffect()
  self:changeVerticalScroll(frameSizeY + (self._ui.chk_equipset:GetSizeY() + padding) * 2)
end
function PaGlobal_InventoryEquip_Detail_Renew:changeVerticalScroll(contentSizeY)
  local padding = 10
  contentSizeY = contentSizeY + padding
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), contentSizeY)
  self._ui.frame_information:UpdateContentScroll()
  self._ui.frame_information:UpdateContentPos()
  self._ui.frame_information:UpdateContentPosWithSnap()
end
function PaGlobal_InventoryEquip_Detail_Renew:updateEquippedSetEffect()
  self:resetEquippedSet()
  if false == self._ui.chk_equipset:IsCheck() then
    return 0
  end
  local setEffectGroupSizeY = 0
  self:updateSetEffectData()
  local dataCount = #self._setEffectData
  for index = 1, dataCount do
    if nil == self._ui.setEffectGroup[index] then
      self:createSetEffectGroup(index)
    end
    setEffectGroupSizeY = setEffectGroupSizeY + self:changeSetEffectGroup(index)
  end
  return setEffectGroupSizeY
end
function PaGlobal_InventoryEquip_Detail_Renew:createCrystalGroup(crystalGroupIndex)
  local padding = 5
  local crystal = {
    crystalBG = nil,
    equipmentName = nil,
    socket = {}
  }
  crystal.crystalBG = UI.cloneControl(self._ui.stc_crystal_template, self._ui.frame_content, "Static_CrystalBg_Template_" .. crystalGroupIndex)
  ToClient_padSnapRefreshTarget(crystal.crystalBG)
  crystal.equipmentName = UI.getChildControl(crystal.crystalBG, "StaticText_EquipmentName")
  crystal.equipmentName:SetTextMode(__eTextMode_AutoWrap)
  local socketBG = UI.getChildControl(crystal.crystalBG, "Static_SocketBG")
  for index = 1, self._maxSocketCount do
    local socketInfo = {
      slotBG = nil,
      iconBG = nil,
      icon = {},
      socketName = nil
    }
    socketInfo.slotBG = UI.cloneControl(socketBG, crystal.crystalBG, "Static_SocketBG_" .. index)
    socketInfo.iconBG = UI.getChildControl(socketInfo.slotBG, "Static_SlotBg_Template")
    socketInfo.icon = SlotItem.new(socketInfo.icon, "socket_iconBG", nil, socketInfo.iconBG, self.slotConfig_Crystal)
    socketInfo.icon:createChild()
    socketInfo.icon:clearItem()
    socketInfo.icon.icon:SetSize(socketInfo.iconBG:GetSizeX(), socketInfo.iconBG:GetSizeY())
    socketInfo.socketName = UI.getChildControl(socketInfo.slotBG, "StaticText_EffectDesc")
    socketInfo.socketName:SetTextMode(__eTextMode_AutoWrap)
    socketInfo.slotBG:SetIgnore(true)
    socketInfo.slotBG:SetPosY(socketInfo.slotBG:GetPosY() + (socketInfo.slotBG:GetSizeY() + padding) * index)
    crystal.socket[index] = socketInfo
  end
  local addSizeY = crystal.socket[1].slotBG:GetSizeY() * (self._maxSocketCount - 1)
  crystal.crystalBG:SetSize(crystal.crystalBG:GetSizeX(), crystal.crystalBG:GetSizeY() + addSizeY)
  self._ui.crystalGroup[crystalGroupIndex] = crystal
end
function PaGlobal_InventoryEquip_Detail_Renew:changeCrystalGroup(crystalGroupIndex, itemWrapper)
  if nil == itemWrapper then
    return 0
  end
  local padding = 5
  local itemSSW = itemWrapper:getStaticStatus()
  local equipmentName = itemSSW:getName()
  self._ui.crystalGroup[crystalGroupIndex].equipmentName:SetText(equipmentName)
  self._ui.crystalGroup[crystalGroupIndex].equipmentName:SetSize(self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetTextSizeY())
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetShow(true)
  local socketCount = itemWrapper:get():getUsableItemSocketCount()
  for index = 1, #self._ui.crystalGroup[crystalGroupIndex].socket do
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(false)
  end
  for index = 1, socketCount do
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(true)
    local itemEnchantSSW = itemWrapper:getPushedItem(index - 1)
    if nil ~= itemEnchantSSW then
      local nameColorGrade = itemEnchantSSW:getGradeType()
      self:changeTextColor(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName, nameColorGrade)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetText(tostring(itemEnchantSSW:getName()))
      local addBgSizeY = 0
      if self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() > self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() then
        addBgSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() - self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY()
      end
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY())
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeY() + addBgSizeY)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(true)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].icon:setItemByStaticStatus(itemEnchantSSW)
    else
      self._ui.crystalGroup[crystalGroupIndex].socket[index].icon:clearItem()
      self:changeTextColor(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
      local addBgSizeY = 0
      if self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() < self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() then
        addBgSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() - self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY()
      end
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeY() - addBgSizeY)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY())
    end
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:ComputePos()
    if 1 ~= index then
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetPosY(self._ui.crystalGroup[crystalGroupIndex].socket[index - 1].slotBG:GetSizeY() + self._ui.crystalGroup[crystalGroupIndex].socket[index - 1].slotBG:GetPosY())
    end
  end
  local crystalBGSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[1].slotBG:GetSizeY() + self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetSizeY() + padding
  if false ~= self._ui.crystalGroup[crystalGroupIndex].socket[self._maxSocketCount].slotBG:GetShow() then
    crystalBGSizeY = crystalBGSizeY + (self._ui.crystalGroup[crystalGroupIndex].socket[1].slotBG:GetSizeY() + padding)
  end
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetSizeX(), crystalBGSizeY)
  local crystalBGPosY = self._ui.chk_crystal:GetSizeY() + padding * 2
  if 1 ~= crystalGroupIndex then
    crystalBGPosY = self._ui.crystalGroup[crystalGroupIndex - 1].crystalBG:GetPosY() + self._ui.crystalGroup[crystalGroupIndex - 1].crystalBG:GetSizeY() + padding
  end
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetPosY(crystalBGPosY)
  return crystalBGSizeY + padding
end
function PaGlobal_InventoryEquip_Detail_Renew:updateSetEffectData()
  local sortedInfoList = ToClient_GetSkillPieceInfo()
  self._setEffectData = {}
  if nil == sortedInfoList then
    return
  end
  local listIndex = 0
  while nil ~= sortedInfoList[listIndex] do
    local groupTitle = sortedInfoList[listIndex]:getGroupTitle()
    local dataIndex = self:getSetEffectData(groupTitle)
    if nil == self._setEffectData[dataIndex] then
      local data = {
        groupTitle = nil,
        desc = {},
        isApplied = {}
      }
      table.insert(self._setEffectData, data)
    end
    local descIndex = #self._setEffectData[dataIndex].desc
    self._setEffectData[dataIndex].groupTitle = groupTitle
    local descText = sortedInfoList[listIndex]:getDescTitle() .. " : " .. sortedInfoList[listIndex]:getDesc()
    table.insert(self._setEffectData[dataIndex].desc, descText)
    table.insert(self._setEffectData[dataIndex].isApplied, sortedInfoList[listIndex]:getApply())
    listIndex = listIndex + 1
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:getSetEffectData(groupTitle)
  for index = 1, #self._setEffectData + 1 do
    if nil ~= self._setEffectData[index] then
      if self._setEffectData[index].groupTitle == groupTitle then
        return index
      end
    else
      return index
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:createSetEffectGroup(setEffectGroupIndex)
  local padding = 5
  local setEffectGroup = {
    setEffectBG = nil,
    equipmentName = nil,
    setEffectDesc = {}
  }
  setEffectGroup.setEffectBG = UI.cloneControl(self._ui.stc_equipset_template, self._ui.frame_content, "Static_EquipmentSetBg_Template_" .. setEffectGroupIndex)
  ToClient_padSnapRefreshTarget(setEffectGroup.setEffectBG)
  setEffectGroup.equipmentName = UI.getChildControl(setEffectGroup.setEffectBG, "StaticText_SetEffectTitle")
  setEffectGroup.equipmentName:SetTextMode(__eTextMode_AutoWrap)
  setEffectGroup.setEffectDesc[1] = UI.getChildControl(setEffectGroup.setEffectBG, "StaticText_SetDesc")
  setEffectGroup.setEffectDesc[1]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.setEffectGroup[setEffectGroupIndex] = setEffectGroup
end
function PaGlobal_InventoryEquip_Detail_Renew:createSetEffectDesc(setEffectGroupIndex, index)
  local padding = 5
  local controlToClone = self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[1]
  local parent = self._ui.setEffectGroup[setEffectGroupIndex].setEffectBG
  local cloneControl = UI.cloneControl(controlToClone, parent, "StaticText_SetDesc_" .. index)
  self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[index] = cloneControl
  self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_InventoryEquip_Detail_Renew:changeSetEffectGroup(setEffectGroupIndex)
  local padding = 5
  local addSizeY = 0
  local currentGroupUI = self._ui.setEffectGroup[setEffectGroupIndex]
  currentGroupUI.setEffectBG:SetShow(true)
  currentGroupUI.equipmentName:SetText(self._setEffectData[setEffectGroupIndex].groupTitle)
  currentGroupUI.equipmentName:SetSize(currentGroupUI.equipmentName:GetSizeX(), currentGroupUI.equipmentName:GetTextSizeY())
  local setEffectBGSizeY = 0
  for index = 1, #currentGroupUI.setEffectDesc do
    currentGroupUI.setEffectDesc[index]:SetShow(false)
  end
  for index = 1, #self._setEffectData[setEffectGroupIndex].desc do
    if nil == currentGroupUI.setEffectDesc[index] then
      self:createSetEffectDesc(setEffectGroupIndex, index)
    end
    currentGroupUI.setEffectDesc[index]:SetShow(true)
    if true == self._setEffectData[setEffectGroupIndex].isApplied[index] then
      currentGroupUI.setEffectDesc[index]:SetFontColor(Defines.Color.C_FF96D4FC)
    else
      currentGroupUI.setEffectDesc[index]:SetFontColor(Defines.Color.C_FFDDC39E)
    end
    currentGroupUI.setEffectDesc[index]:SetText(self._setEffectData[setEffectGroupIndex].desc[index])
    currentGroupUI.setEffectDesc[index]:SetSize(currentGroupUI.setEffectDesc[index]:GetSizeX(), currentGroupUI.setEffectDesc[index]:GetTextSizeY())
    local prevControl
    if 1 == index then
      prevControl = currentGroupUI.equipmentName
      setEffectBGSizeY = currentGroupUI.equipmentName:GetSizeY() + padding + currentGroupUI.setEffectDesc[index]:GetSizeY() + padding
    else
      prevControl = currentGroupUI.setEffectDesc[index - 1]
      setEffectBGSizeY = setEffectBGSizeY + currentGroupUI.setEffectDesc[index]:GetSizeY() + padding
    end
    currentGroupUI.setEffectDesc[index]:SetPosY(prevControl:GetPosY() + prevControl:GetSizeY())
  end
  currentGroupUI.setEffectBG:SetSize(currentGroupUI.setEffectBG:GetSizeX(), setEffectBGSizeY)
  local setEffectGroupPosY = self._ui.chk_equipset:GetPosY() + self._ui.chk_equipset:GetSizeY() + padding
  if 1 ~= setEffectGroupIndex and nil ~= self._ui.setEffectGroup[setEffectGroupIndex - 1] then
    setEffectGroupPosY = self._ui.setEffectGroup[setEffectGroupIndex - 1].setEffectBG:GetPosY() + self._ui.setEffectGroup[setEffectGroupIndex - 1].setEffectBG:GetSizeY() + padding
  end
  currentGroupUI.setEffectBG:SetPosY(setEffectGroupPosY)
  return setEffectBGSizeY + padding
end
function PaGlobal_InventoryEquip_Detail_Renew:changeTextColor(control, nameColorGrade)
  if 0 == nameColorGrade then
    control:SetFontColor(Defines.Color.C_FFDDC39E)
  elseif 1 == nameColorGrade then
    control:SetFontColor(4284350320)
  elseif 2 == nameColorGrade then
    control:SetFontColor(4283144191)
  elseif 3 == nameColorGrade then
    control:SetFontColor(4294953010)
  elseif 4 == nameColorGrade then
    control:SetFontColor(4294929408)
  else
    control:SetFontColor(Defines.Color.C_FFDDC39E)
  end
end
