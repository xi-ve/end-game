Panel_Equipment_Crystal_Tooltip:SetShow(false, false)
Panel_Equipment_Crystal_Tooltip:ActiveMouseEventEffect(true)
Panel_Equipment_Crystal_Tooltip:setMaskingChild(true)
Panel_Equipment_Crystal_Tooltip:setGlassBackground(true)
local UI_color = Defines.Color
local _panel = Panel_Equipment_Crystal_Tooltip
local CrystalTooltip = {
  _ui = {
    txt_windowTitle = UI.getChildControl(_panel, "StaticText_Title"),
    txt_noCrystal = UI.getChildControl(_panel, "StaticText_NoCrystal"),
    txt_windowDesc = UI.getChildControl(_panel, "StaticText_Desc"),
    txt_equipmentName = UI.getChildControl(_panel, "StaticText_EquipmentName"),
    stc_crystalBG = UI.getChildControl(_panel, "Static_CrystalBG")
  },
  _listEquipmentName = {},
  _listEquipmentSize = 0,
  _listCrystal = {},
  _listCrystalSize = 0,
  _usingEquipmentUICount = 0,
  _usingCrystalUICount = 0,
  _txt_emptySlot = nil,
  _equipNoMin = CppEnums.EquipSlotNo.rightHand,
  _equipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount,
  _socketCount = 0,
  _panelSizeY = 0,
  _isDetail = false
}
function CrystalTooltip:Init()
  self._ui.stc_crystalIcon = UI.getChildControl(self._ui.stc_crystalBG, "Static_CrystalIcon")
  self._ui.txt_crystalName = UI.getChildControl(self._ui.stc_crystalBG, "StaticText_CrystalName")
  self._ui.txt_crystalDesc = UI.getChildControl(self._ui.stc_crystalBG, "StaticText_CrystalDesc")
  self._ui.txt_windowDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_windowDesc:SetText(self._ui.txt_windowDesc:GetText())
  self._classType = getSelfPlayer():getClassType()
  self._txt_emptySlot = " <PAColor0xffc4bebe>(" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT") .. ")<PAOldColor>"
  self._ui.txt_equipmentName:SetShow(false)
  self._ui.stc_crystalIcon:SetShow(false)
  self._ui.txt_crystalName:SetShow(false)
  self._ui.txt_crystalDesc:SetShow(false)
  self:AllSlotIsEmpty(true)
  self:SetPanelPos()
  Panel_Equipment_Crystal_Tooltip:SetShow(false, false)
end
function CrystalTooltip:Update()
  self:UpdateUI()
  self:SetPanelPos()
  _panel:SetShow(true, true)
end
function CrystalTooltip:UpdateSimpleItem()
  if nil == PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo then
    return
  end
  local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
  if nil == characterNo then
    return
  end
  self:UpdateUI(characterNo)
  self:SetPanelPos(true)
  _panel:SetShow(true, true)
end
function CrystalTooltip:UpdateUI(characterNo)
  self._usingEquipmentUICount = 0
  self._usingCrystalUICount = 0
  self._panelSizeY = 60 + self._ui.txt_windowDesc:GetTextSizeY()
  local equipWrapper
  if nil ~= characterNo then
    equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
  end
  for equipNo = self._equipNoMin, self._equipNoMax - 1 do
    local itemWrapper
    if nil == characterNo then
      itemWrapper = ToClient_getEquipmentItem(equipNo)
    else
      local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
      if nil == equipItemWrapper then
        return
      end
      itemWrapper = equipItemWrapper:getItem()
    end
    local socketCount = 0
    if nil ~= itemWrapper then
      socketCount = itemWrapper:get():getUsableItemSocketCount()
    end
    self._socketCount = socketCount
    if 0 ~= socketCount then
      for socketNo = 0, socketCount - 1 do
        local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
        if nil ~= itemEnchantSSW then
          if true == self._isDetail then
            self:CreateDetailCrystalUI(equipNo, socketNo, characterNo)
          else
            self:CreateSimpleCrystalUI(equipNo, socketNo, characterNo)
          end
        else
          self:CreateEmptyCrystalUI()
        end
        self._usingCrystalUICount = self._usingCrystalUICount + 1
      end
      self:SetEquipmentAndCrystalUI(equipNo, characterNo)
    end
    _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
    self:AllSlotIsEmpty(false)
    for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
      self._listEquipmentName[equipmentNo]:SetShow(false)
    end
    for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
      self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
    end
  end
end
function CrystalTooltip:CreateNewSlotUI()
  if self._usingCrystalUICount + 1 > self._listCrystalSize then
    self._listCrystal[self._usingCrystalUICount] = self:GetNewCrystalCopy(self._usingCrystalUICount)
    self._listCrystalSize = self._listCrystalSize + 1
  end
end
function CrystalTooltip:CreateEmptyCrystalUI()
  self:CreateNewSlotUI()
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(self._txt_emptySlot)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoName("renewal/pcremaster/remaster_common_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 179, 104, 225, 150)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
end
function CrystalTooltip:CreateSimpleCrystalUI(equipNo, socketNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  local nameColorGrade = itemEnchantSSW:getGradeType()
  self:ChangeTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, nameColorGrade)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoName("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:CreateDetailCrystalUI(equipNo, socketNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  local nameColorGrade = itemEnchantSSW:getGradeType()
  self:ChangeTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, nameColorGrade)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoName("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
  if nil == skillSSW then
    self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  else
    local buffList = ""
    for buffIdx = 0, skillSSW:getBuffCount() - 1 do
      local desc = skillSSW:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if nil == buffList or "" == buffList then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
    end
    self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(itemEnchantSSW:getName() .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  end
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:SetEquipmentAndCrystalUI(equipNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  if self._usingEquipmentUICount + 1 > self._listEquipmentSize then
    self._listEquipmentName[self._usingEquipmentUICount] = self:GetNewEquipmentCopy(self._usingEquipmentUICount)
    self._listEquipmentSize = self._listEquipmentSize + 1
  end
  if 0 == self._usingEquipmentUICount then
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(self._ui.txt_equipmentName:GetPosY())
  else
    local bottomCrystal = self._listCrystal[self._usingCrystalUICount - self._socketCount - 1]
    local equipmentNamePosY = bottomCrystal.stc_crystalBG:GetPosY() + bottomCrystal.txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(equipmentNamePosY + 5)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local nameColorGrade = itemSSW:getGradeType()
  CrystalTooltip:ChangeTextColor(self._listEquipmentName[self._usingEquipmentUICount], nameColorGrade)
  self._listEquipmentName[self._usingEquipmentUICount]:SetText(tostring(itemWrapper:getStaticStatus():getName()))
  self._listEquipmentName[self._usingEquipmentUICount]:SetShow(true)
  self._panelSizeY = self._panelSizeY + self._ui.txt_equipmentName:GetSizeY() + 5
  local curEquipNamePosY = self._listEquipmentName[self._usingEquipmentUICount]:GetPosY() + self._ui.txt_equipmentName:GetSizeY()
  local crystalPosY = 0
  for crystalIdx = 0, self._socketCount - 1 do
    local curIndex = self._usingCrystalUICount - self._socketCount + crystalIdx
    local crystalSizeY = self._listCrystal[curIndex].txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listCrystal[curIndex].stc_crystalBG:SetPosY(curEquipNamePosY + crystalPosY)
    self._listCrystal[curIndex].stc_crystalBG:SetShow(true)
    crystalPosY = crystalPosY + crystalSizeY + 5
    self._panelSizeY = self._panelSizeY + crystalSizeY
  end
  self._panelSizeY = self._panelSizeY + 5 * (self._socketCount - 1)
  self._usingEquipmentUICount = self._usingEquipmentUICount + 1
end
function CrystalTooltip:ChangeTextColor(control, nameColorGrade)
  if 0 == nameColorGrade then
    control:SetFontColor(UI_color.C_FFFFFFFF)
  elseif 1 == nameColorGrade then
    control:SetFontColor(4284350320)
  elseif 2 == nameColorGrade then
    control:SetFontColor(4283144191)
  elseif 3 == nameColorGrade then
    control:SetFontColor(4294953010)
  elseif 4 == nameColorGrade then
    control:SetFontColor(4294929408)
  else
    control:SetFontColor(UI_color.C_FFFFFFFF)
  end
end
function CrystalTooltip:SetPanelPos(isSimpleItem)
  if true == _ContentsGroup_RenewUI then
    return
  end
  local control
  if true == _ContentsGroup_NewUI_Equipment_All then
    control = Panel_Window_Equipment_All
  else
    control = Panel_Equipment
  end
  if true == isSimpleItem then
    control = Panel_Window_SimpleInventory
  end
  if nil == control then
    return
  end
  local equipPosX = 0
  local equipPosY = 0
  if true == control:IsUISubApp() then
    equipPosX = control:GetScreenParentPosX()
    equipPosY = control:GetScreenParentPosY()
  else
    equipPosX = control:GetPosX()
    equipPosY = control:GetPosY()
  end
  local posX = equipPosX - _panel:GetSizeX()
  if posX < 0 then
    posX = equipPosX + control:GetSizeX()
  end
  local posY = equipPosY + control:GetSizeY() - _panel:GetSizeY() - 10
  if posY < 0 then
    posY = 0
  elseif getScreenSizeY() < posY + _panel:GetSizeY() then
    posY = getScreenSizeY() - _panel:GetSizeY()
  end
  _panel:SetPosX(posX)
  _panel:SetPosY(posY)
  self._ui.txt_windowDesc:ComputePos()
end
function CrystalTooltip:GetNewEquipmentCopy(idx)
  local _equipmentCopy = UI.createAndCopyBasePropertyControl(_panel, "StaticText_EquipmentName", _panel, "StaticText_EquipmentName_No" .. idx)
  return _equipmentCopy
end
function CrystalTooltip:GetNewCrystalCopy(idx)
  local _crystalCopy = {
    stc_crystalBG,
    stc_crystalIcon,
    txt_crystalName,
    txt_crystalDesc
  }
  _crystalCopy.stc_crystalBG = UI.createAndCopyBasePropertyControl(_panel, "Static_CrystalBG", _panel, "Static_CrystalBG_No" .. idx)
  _crystalCopy.stc_crystalIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "Static_CrystalIcon", _crystalCopy.stc_crystalBG, "Static_CrystalIcon_No" .. idx)
  _crystalCopy.txt_crystalName = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "StaticText_CrystalName", _crystalCopy.stc_crystalBG, "StaticText_CrystalName_No" .. idx)
  _crystalCopy.txt_crystalDesc = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "StaticText_CrystalDesc", _crystalCopy.stc_crystalBG, "StaticText_CrystalDesc_No" .. idx)
  _crystalCopy.txt_crystalDesc:SetTextMode(__eTextMode_AutoWrap)
  _crystalCopy.txt_crystalName:SetTextMode(__eTextMode_AutoWrap)
  return _crystalCopy
end
function CrystalTooltip:AllSlotIsEmpty(flag)
  self._ui.txt_noCrystal:SetShow(flag)
end
function PaGlobalFunc_CrystalToolTip_InitWithIcon(icon)
  if not icon then
    return false
  end
  icon:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_Show(true)")
  icon:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_Show(false)")
  icon:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail()")
  return true
end
function PAGlobalFunc_CrystalTooltip_ToggleDetail()
  local self = CrystalTooltip
  self._isDetail = not self._isDetail
  self:Update()
  if true == _panel:IsUISubApp() then
    _panel:CloseUISubApp()
    self:SetPanelPos()
    _panel:OpenUISubApp()
  end
end
function PAGlobalFunc_CrystalTooltip_Show(flag)
  local self = CrystalTooltip
  if _panel:GetShow() == flag then
    return
  end
  if flag then
    self._isDetail = false
    self:Update()
  end
  local equipPanel
  if true == _ContentsGroup_NewUI_Equipment_All then
    equipPanel = Panel_Window_Equipment_All
  else
    equipPanel = Panel_Equipment
  end
  if true == equipPanel:IsUISubApp() then
    if flag then
      _panel:SetShow(true)
      _panel:OpenUISubApp()
    else
      _panel:SetShow(false)
      _panel:CloseUISubApp()
    end
  else
    _panel:SetShow(flag, flag)
  end
end
function PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(flag)
  if _panel:GetShow() == flag then
    return
  end
  if true == flag then
    CrystalTooltip._isDetail = false
    CrystalTooltip:UpdateSimpleItem()
  end
  _panel:SetShow(flag, flag)
end
function PAGlobalFunc_CrystalTooltip_ToggleDetail_ForSimpleItem()
  local self = CrystalTooltip
  self._isDetail = not self._isDetail
  self:UpdateSimpleItem()
end
function FGlobal_CrystalToolTip_Init()
  local self = CrystalTooltip
  self:Init()
end
registerEvent("FromClient_luaLoadComplete", "FGlobal_CrystalToolTip_Init")
