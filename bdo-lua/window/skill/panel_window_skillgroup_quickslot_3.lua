function SkillGroupQuickSlot_DropHandler(slotIndex)
  if false == isUseNewQuickSlot() then
    QuickSlot_DropHandler(slotIndex)
  else
    HandleClicked_NewQuickSlot_Use(slotIndex)
  end
end
function SkillGroupQuickSlot_Click(slotIndex)
  if false == isUseNewQuickSlot() then
    QuickSlot_Click(slotIndex)
  else
    HandleClicked_NewQuickSlot_Use(slotIndex)
  end
end
function SkillGroupQuickSlot_DragStart(slotIndex)
  local quickSlotInfo = getQuickSlotItem(slotIndex)
  if true == PaGlobal_TutorialManager:isDoingTutorial() and 502 == quickSlotInfo._itemKey:get() and 0 == slotIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if CppEnums.QuickSlotType.eItem == quickSlotInfo._type or CppEnums.QuickSlotType.eCashItem == quickSlotInfo._type or CppEnums.QuickSlotType.eInstanceItem == quickSlotInfo._type then
    local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
    DragManager:setDragInfo(Panel_Window_SkillGroup_QuickSlot, nil, slotIndex, "Icon/" .. itemStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  elseif CppEnums.QuickSlotType.eSkill == quickSlotInfo._type then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickSlotInfo._skillKey:getSkillNo())
    DragManager:setDragInfo(Panel_Window_SkillGroup_QuickSlot, nil, slotIndex, "Icon/" .. skillTypeStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  end
end
function PaGlobal_SkillGroup_QuickSlot_Resize()
  self = PaGlobal_SkillGroup_QuickSlot
  panel = Panel_Window_SkillGroup_QuickSlot
  panel:ComputePos()
  local screenSizeY = getScreenSizeY()
  panel:SetPosX(Panel_Window_SkillGroup_Controller:GetPosX() + Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - panel:GetSizeX() / 2)
  panel:SetPosY(screenSizeY - panel:GetSizeY() - 20)
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii].number:SetText((keyCustom_GetString_ActionKey(PaGlobal_SkillGroup_QuickSlot.slotKey[ii])))
  end
  if false == isUseNewQuickSlot() then
    local slotBg = UI.getChildControl(panel, "Static_SlotBG")
    local slotSizeY = slotBg:GetSizeY()
    panel:SetPosY(panel:GetPosY() + slotSizeY)
    local posY = slotBg:GetPosY() + slotSizeY + 10
    self._ui._stc_bottomLine:SetPosY(posY)
    for ii = self._config.oldSlotCount, self._config.slotCount - 1 do
      self._slots[ii].groupBg:SetShow(false)
    end
  else
    local slotBg = UI.getChildControl(panel, "Static_SlotBG")
    local slotSizeY = slotBg:GetSizeY()
    local posY = slotBg:GetPosY() + slotSizeY * 2 + 30
    self._ui._stc_bottomLine:SetPosY(posY)
    for ii = self._config.oldSlotCount, self._config.slotCount - 1 do
      self._slots[ii].groupBg:SetShow(true)
    end
  end
end
