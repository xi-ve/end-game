function PaGlobal_SkillGroup_QuickSlot:initialize()
  if true == PaGlobal_SkillGroup_QuickSlot._initialize then
    return
  end
  PaGlobal_SkillGroup_QuickSlot:registEventHandler()
  PaGlobal_SkillGroup_QuickSlot:controlInit_All()
  PaGlobal_SkillGroup_QuickSlot:validate()
  PaGlobal_SkillGroup_QuickSlot_Resize()
  PaGlobal_SkillGroup_QuickSlot._initialize = true
end
function PaGlobal_SkillGroup_QuickSlot:controlInit_All()
  local cloneControl = UI.getChildControl(Panel_Window_SkillGroup_QuickSlot, "Static_SlotBG")
  local ui = PaGlobal_SkillGroup_QuickSlot._ui
  ui._stc_topLine = UI.getChildControl(Panel_Window_SkillGroup_QuickSlot, "Static_Top")
  ui._stc_bottomLine = UI.getChildControl(Panel_Window_SkillGroup_QuickSlot, "Static_Bottom")
  PaGlobal_SkillGroup_QuickSlot:createQuickSlot(cloneControl, Panel_Window_SkillGroup_QuickSlot)
  cloneControl:SetShow(false)
end
function PaGlobal_SkillGroup_QuickSlot:createQuickSlot(cloneControl, parent)
  UI.ASSERT(nil ~= cloneControl, "PaGlobal_SkillGroup_QuickSlot:createQuickSlot() cloneControl \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  UI.ASSERT(nil ~= parent, "PaGlobal_SkillGroup_QuickSlot:createQuickSlot() parent \236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  local sizeX = cloneControl:GetSizeX()
  local sizeY = cloneControl:GetSizeY()
  local startPosX = cloneControl:GetPosX()
  local startPosY = cloneControl:GetPosY()
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii] = SkillQuickSlot.new(ii, cloneControl, parent)
    if 0 < ii then
      local numX = ii % math.floor(self._config.slotCount / 2)
      local numY = math.floor(ii / math.floor(self._config.slotCount / 2))
      local posX = startPosX + numX * (self._config.slotGapX + sizeX)
      local posY = startPosY + numY * (self._config.slotGapY + sizeY)
      self._slots[ii].groupBg:SetPosX(posX)
      self._slots[ii].groupBg:SetPosY(posY)
    end
  end
end
function PaGlobal_SkillGroup_QuickSlot:prepareOpen()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
  PaGlobal_SkillGroup_QuickSlot_Resize()
  PaGlobal_SkillGroup_QuickSlot:open()
end
function PaGlobal_SkillGroup_QuickSlot:open()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
  Panel_Window_SkillGroup_QuickSlot:SetShow(true)
end
function PaGlobal_SkillGroup_QuickSlot:prepareClose()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
  PaGlobal_SkillGroup_QuickSlot:close()
end
function PaGlobal_SkillGroup_QuickSlot:close()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
  Panel_Window_SkillGroup_QuickSlot:SetShow(false)
end
function PaGlobal_SkillGroup_QuickSlot:update()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
  for idx = 0, self._config.slotCount - 1 do
    local slot = self._slots[idx]
    if nil ~= slot then
      local quickSlotKey = idx
      local quickSlotInfo = getQuickSlotItem(quickSlotKey)
      if CppEnums.QuickSlotType.eItem == quickSlotInfo._type or CppEnums.QuickSlotType.eCashItem == quickSlotInfo._type or CppEnums.QuickSlotType.eInstanceItem == quickSlotInfo._type then
        slot:setItem(quickSlotKey, quickSlotInfo)
      elseif CppEnums.QuickSlotType.eSkill == quickSlotInfo._type then
        slot:setSkill(quickSlotKey, quickSlotInfo)
      else
        slot:setEmpty()
      end
    end
  end
  PaGlobal_SkillGroup._isDraggingFromTree = false
end
function PaGlobal_SkillGroup_QuickSlot:registEventHandler()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
end
function PaGlobal_SkillGroup_QuickSlot:validate()
  if nil == Panel_Window_SkillGroup_QuickSlot then
    return
  end
end
