SkillQuickSlot = {}
SkillQuickSlot.__index = SkillQuickSlot
function SkillQuickSlot.new(slotNo, control, parent)
  newObj = {}
  setmetatable(newObj, SkillQuickSlot)
  newObj:init(slotNo, control, parent)
  return newObj
end
function SkillQuickSlot:init(slotNo, control, parent)
  self.key = 0
  self.slotNo = slotNo
  self.slotType = CppEnums.QuickSlotType.eEmpty
  self.keyValue = nil
  self.item = nil
  self.skill = nil
  self.groupBg = UI.cloneControl(control, parent, "SkillGroup_QuickSlotBg_" .. slotNo)
  self.slotBg = UI.getChildControl(self.groupBg, "Static_Slot")
  self.number = UI.getChildControl(self.groupBg, "StaticText_Num")
  self.number:SetText((keyCustom_GetString_ActionKey(PaGlobal_SkillGroup_QuickSlot.slotKey[slotNo])))
  self.slotBg:addInputEvent("Mouse_LUp", "SkillGroupQuickSlot_DropHandler(" .. slotNo .. ")")
end
function SkillQuickSlot:setSkill(slotNo, quickSlotInfo)
  if CppEnums.QuickSlotType.eSkill ~= self.slotType then
    if CppEnums.QuickSlotType.eItem == self.slotType or CppEnums.QuickSlotType.eCashItem == self.slotType or CppEnums.QuickSlotType.eInstanceItem == self.slotType then
      UI.ASSERT(nil ~= self.item)
      UI.deleteControl(self.item.icon)
      Panel_Tooltip_Item_hideTooltip()
      self.item = nil
    end
    self.slotType = CppEnums.QuickSlotType.eSkill
    local skillSlot = {}
    SlotSkill.new(skillSlot, slotNo, self.slotBg, PaGlobal_SkillGroup_QuickSlot._slotConfig)
    skillSlot.icon:addInputEvent("Mouse_LUp", "SkillGroupQuickSlot_Click(" .. slotNo .. ")")
    skillSlot.icon:addInputEvent("Mouse_PressMove", "SkillGroupQuickSlot_DragStart(" .. slotNo .. ")")
    skillSlot.icon:SetEnableDragAndDrop(true)
    self.number:AddEffect("UI_SkillButton01", false, 0, 0)
    self.number:AddEffect("fUI_Repair01", false, 0, 0)
    self.slotBg:AddEffect("fUI_Light", false, 0, 0)
    self.skill = skillSlot
    self.slotBg:SetIgnore(true)
  end
  local skillNo = quickSlotInfo._skillKey:getSkillNo()
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  self.skill.skillNo = skillNo
  UI.ASSERT(skillTypeStaticWrapper, "get Fail - Skill Type Static Status ")
  self.keyValue = quickSlotInfo._skillKey
  self.skill:setSkillTypeStatic(skillTypeStaticWrapper)
  self.skill.icon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. slotNo .. ", false, \"QuickSlot\")")
  self.skill.icon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
end
function SkillQuickSlot:setItem(slotNo, quickSlotInfo)
  if CppEnums.QuickSlotType.eItem ~= self.slotType and CppEnums.QuickSlotType.eCashItem ~= self.slotType and CppEnums.QuickSlotType.eInstanceItem ~= self.slotType then
    if CppEnums.QuickSlotType.eSkill == self.slotType then
      self.skill:destroyChild()
      Panel_SkillTooltip_Hide()
      self.skill = nil
    end
    self.slotType = quickSlotInfo._type
    local itemSlot = {}
    SlotItem.new(itemSlot, "QuickSlot_" .. slotNo, slotNo, self.slotBg, PaGlobal_SkillGroup_QuickSlot._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:addInputEvent("Mouse_LUp", "SkillGroupQuickSlot_Click(" .. self.slotNo .. ")")
    itemSlot.icon:addInputEvent("Mouse_PressMove", "SkillGroupQuickSlot_DragStart(" .. self.slotNo .. ")")
    itemSlot.icon:SetEnableDragAndDrop(true)
    self.slotBg:SetIgnore(true)
    self.number:AddEffect("UI_SkillButton01", false, 0, 0)
    self.number:AddEffect("fUI_Repair01", false, 0, 0)
    self.slotBg:AddEffect("fUI_Light", false, 0, 0)
    self.item = itemSlot
  end
  self.slotType = quickSlotInfo._type
  local selfPlayer = getSelfPlayer():get()
  local inventoryType = QuickSlot_GetInventoryTypeFrom(self.slotType)
  local inventory = selfPlayer:getInventoryByType(inventoryType)
  local invenSlotNo = inventory:getSlot(quickSlotInfo._itemKey)
  local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
  local _const = Defines.s64_const
  local s64_stackCount = _const.s64_0
  local targetItemNotFound = false
  if __eTInventorySlotNoUndefined ~= invenSlotNo then
    s64_stackCount = getInventoryItemByType(inventoryType, invenSlotNo):get():getCount_s64()
  else
    targetItemNotFound = true
  end
  if CppEnums.ContentsEventType.ContentsType_InventoryBag == itemStaticWrapper:get():getContentsEventType() then
    invenSlotNo = ToClient_GetItemNoByInventory(inventoryType, quickSlotInfo._itemNo_s64)
    local itemWrapper = getInventoryItemByType(inventoryType, invenSlotNo)
    if nil ~= itemWrapper then
      itemStaticWrapper = itemWrapper:getStaticStatus()
      self.item:setItem(itemWrapper, invenSlotNo)
    else
      targetItemNotFound = true
    end
  else
    self.item:setItemByStaticStatus(itemStaticWrapper, s64_stackCount)
  end
  self.keyValue = invenSlotNo
  self.item.icon:SetMonoTone(targetItemNotFound or _const.s64_0 == s64_stackCount)
  self.item.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"QuickSlot\", true)")
  self.item.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"QuickSlot\", false)")
  Panel_Tooltip_Item_SetPosition(slotNo, self.item, "QuickSlot")
end
function SkillQuickSlot:setEmpty()
  if CppEnums.QuickSlotType.eItem == self.slotType or CppEnums.QuickSlotType.eCashItem == self.slotType or CppEnums.QuickSlotType.eInstanceItem == self.slotType then
    UI.ASSERT(nil ~= self.item)
    UI.deleteControl(self.item.icon)
    self.item = nil
    audioPostEvent_SystemUi(0, 2)
    _AudioPostEvent_SystemUiForXBOX(0, 2)
  elseif CppEnums.QuickSlotType.eSkill == self.slotType then
    UI.ASSERT(nil ~= self.skill)
    self.skill:destroyChild()
    self.skill = nil
    audioPostEvent_SystemUi(0, 15)
    _AudioPostEvent_SystemUiForXBOX(0, 15)
  end
  self.slotBg:SetIgnore(false)
  self.slotBg:addInputEvent("Mouse_LUp", "SkillGroupQuickSlot_DropHandler(" .. self.slotNo .. ")")
  self.slotType = CppEnums.QuickSlotType.eEmpty
  self.keyValue = nil
end
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
