function PaGlobal_SA_Widget_Looting:initialize()
  if true == PaGlobal_SA_Widget_Looting._initialize then
    return
  end
  self._ui.stc_lootingBG = UI.getChildControl(Panel_SA_Looting, "Static_LootingBG")
  self:registEventHandler()
  self:validate()
  self:createControl()
  self:prepareOpen()
  self._initialize = true
end
function PaGlobal_SA_Widget_Looting:registEventHandler()
  if nil == Panel_SA_Looting then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Looting_ReSizePanel()")
  registerEvent("EventAddItemToInventory", "FromClient_SA_Widget_Looting_Inventory_AddItem")
end
function PaGlobal_SA_Widget_Looting:prepareOpen()
  if nil == Panel_SA_Looting then
    return
  end
  PaGlobal_SA_Widget_Looting:open()
end
function PaGlobal_SA_Widget_Looting:open()
  if nil == Panel_SA_Looting then
    return
  end
  Panel_SA_Looting:SetShow(true)
end
function PaGlobal_SA_Widget_Looting:prepareClose()
  if nil == Panel_SA_Looting then
    return
  end
  PaGlobal_SA_Widget_Looting:close()
end
function PaGlobal_SA_Widget_Looting:close()
  if nil == Panel_SA_Looting then
    return
  end
  Panel_SA_Looting:SetShow(false)
end
function PaGlobal_SA_Widget_Looting:update()
  if nil == Panel_SA_Looting then
    return
  end
end
function PaGlobal_SA_Widget_Looting:validate()
  if nil == Panel_SA_Looting then
    return
  end
  self._ui.stc_lootingBG:isValidate()
end
function PaGlobal_SA_Widget_Looting:createControl()
  if nil == Panel_SA_Looting then
    return
  end
  for idx = 1, self._maxLootingCnt do
    local item = {
      itemBG = nil,
      itemIcon = nil,
      itemName = nil
    }
    UI.getChildControl(self._ui.stc_lootingBG, "Static_NewItemBG"):SetShow(false)
    local lootingSlot = UI.cloneControl(self._ui.stc_lootingBG, Panel_SA_Looting, "Static_LootingBG_" .. idx)
    item.itemBG = UI.getChildControl(lootingSlot, "Static_NewItemBG")
    item.itemIcon = UI.getChildControl(item.itemBG, "Static_ItemIcon")
    item.itemName = UI.getChildControl(item.itemBG, "StaticText_ItemName")
    self._itemLooting[idx] = item
    local slot = {}
    SlotItem.new(slot, "slotIcon_" .. idx, idx, self._itemLooting[idx].itemIcon, self._slotConfig)
    slot:createChild()
    self._itemLooting[idx].itemIcon = slot
  end
  self._firstSlotPosY = self._itemLooting[1].itemBG:GetPosY()
end
function PaGlobal_SA_Widget_Looting:listUp()
  local setPosYValue
  for i = 1, self._maxLootingCnt do
    setPosYValue = self._itemLooting[i].itemBG:GetPosY() + 55
    self._itemLooting[i].itemBG:SetPosY(setPosYValue)
  end
  self._itemLooting[self._currentIndex].itemBG:SetPosY(self._firstSlotPosY)
  self:fadeOut(self._currentIndex, 3.5, 2.5)
end
function PaGlobal_SA_Widget_Looting:fadeOut(idx, duration, startTime)
  local aniInfo = self._itemLooting[idx].itemBG:addColorAnimation(startTime, duration, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetHideAtEnd(false)
  aniInfo.IsChangeChild = true
  return true
end
function PaGlobal_SA_Widget_Looting:fadeIn(idx, duration, startTime)
  local aniInfo = self._itemLooting[idx].itemBG:addColorAnimation(startTime, duration, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  return true
end
function PaGlobal_SA_Widget_Looting:nameColorbyGrade(idx, item)
  local grade = item:getGradeType()
  local colorValue = 0
  if 0 == grade then
    colorValue = 4293388263
  elseif 1 == grade then
    colorValue = 4288921664
  elseif 2 == grade then
    colorValue = 4283938018
  elseif 3 == grade then
    colorValue = 4293904710
  elseif 4 == grade then
    colorValue = 4294929482
  else
    colorValue = UI_color.C_FFFFFFFF
  end
  self._itemLooting[idx].itemName:SetFontColor(colorValue)
end
function PaGlobal_SA_Widget_Looting:colorSlotBorder(border, item)
  local grade = item:getGradeType()
  border:ChangeTextureInfoName(self._itemGradeTexUV.path)
  local UVData = self._itemGradeTexUV[grade]
  local x1, y1, x2, y2 = setTextureUV_Func(border, UVData.x1, UVData.y1, UVData.x2, UVData.y2)
  border:getBaseTexture():setUV(x1, y1, x2, y2)
  border:setRenderTexture(border:getBaseTexture())
end
