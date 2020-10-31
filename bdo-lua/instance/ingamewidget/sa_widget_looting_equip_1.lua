function PaGlobal_SA_Widget_Looting_Equip:initialize()
  if true == PaGlobal_SA_Widget_Looting_Equip._initialize then
    return
  end
  self._ui.stc_lootingBG = UI.getChildControl(Panel_SA_Looting_Equip, "Static_BottomBG")
  self:registEventHandler()
  self:validate()
  self:createControl()
  self._initialize = true
end
function PaGlobal_SA_Widget_Looting_Equip:registEventHandler()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  registerEvent("FromClient_InventoryUpdate", "FromClient_InventoryUpdate_BetterEquipment")
end
function PaGlobal_SA_Widget_Looting_Equip:prepareOpen()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  PaGlobal_SA_Widget_Looting_Equip:open()
end
function PaGlobal_SA_Widget_Looting_Equip:open()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  Panel_SA_Looting_Equip:SetShow(true)
end
function PaGlobal_SA_Widget_Looting_Equip:prepareClose()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  PaGlobal_SA_Widget_Looting_Equip:close()
end
function PaGlobal_SA_Widget_Looting_Equip:close()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  Panel_SA_Looting_Equip:SetShow(false)
end
function PaGlobal_SA_Widget_Looting_Equip:update()
  if nil == Panel_SA_Looting_Equip then
    return
  end
end
function PaGlobal_SA_Widget_Looting_Equip:validate()
  if nil == Panel_SA_Looting_Equip then
    return
  end
  self._ui.stc_lootingBG:isValidate()
end
function PaGlobal_SA_Widget_Looting_Equip:resetDate()
  self._curEquipCount = 0
  self._lootingEquipSlotList = {}
  for index = 1, self._maxEquipCount do
    if nil ~= self._lootingEquipList.equipBg[index] then
      self._lootingEquipList.equipBg[index]:SetShow(false)
      self._lootingEquipList.icon[index]:clearItem()
      self._lootingEquipList.name[index]:SetText("")
    end
  end
end
function PaGlobal_SA_Widget_Looting_Equip:createControl()
  for index = 1, self._maxEquipCount do
    UI.getChildControl(self._ui.stc_lootingBG, "Static_NewItemBG"):SetShow(false)
    local equipItem = UI.cloneControl(self._ui.stc_lootingBG, Panel_SA_Looting_Equip, "Static_BottomBG_" .. index)
    equipItem:SetPosY(index * 51)
    self._lootingEquipList.equipBg[index] = UI.getChildControl(equipItem, "Static_NewItemBG")
    self._lootingEquipList.icon[index] = UI.getChildControl(self._lootingEquipList.equipBg[index], "Static_ItemIcon")
    self._lootingEquipList.name[index] = UI.getChildControl(self._lootingEquipList.equipBg[index], "StaticText_ItemName")
    self._lootingEquipList.name[index]:SetTextMode(CppEnums.TextMode.eTextMode_AutoWrap)
    local slot = {}
    SlotItem.new(slot, "slotIcon_" .. index, index, self._lootingEquipList.icon[index], self._slotConfig)
    slot:createChild()
    self._lootingEquipList.icon[index] = slot
  end
  self:close()
end
function PaGlobal_SA_Widget_Looting_Equip:updateBetterEquipment()
  self:resetDate()
  local whereType = CppEnums.ItemWhereType.eInstanceInventory
  local inventory = getSelfPlayer():get():getInventory(whereType)
  if nil == inventory then
    return
  end
  self._curEquipCount = 0
  local invenMaxSize = inventory:sizeXXX()
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(whereType, ii)
    if nil ~= itemWrapper and self:checkBetterItem(itemWrapper, whereType, ii) then
      self._curEquipCount = self._curEquipCount + 1
      self._lootingEquipSlotList[self._curEquipCount] = ii
    end
  end
  if self._curEquipCount > 0 then
    PaGlobal_SA_Widget_Looting_Equip_ShowAni()
    self:prepareOpen()
  else
    self:prepareClose()
  end
  for ii = 1, self._maxEquipCount do
    if ii <= #self._lootingEquipSlotList then
      local itemWrapper = getInventoryItemByType(whereType, self._lootingEquipSlotList[ii])
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local itemGrade = itemSSW:getGradeType()
        local itemGradeColor = self:convert_itemGradeColor(itemGrade)
        self._lootingEquipList.equipBg[ii]:SetShow(true)
        self._lootingEquipList.icon[ii]:setItemByStaticStatus(itemSSW, itemWrapper:getCount())
        self._lootingEquipList.name[ii]:SetText(itemSSW:getName())
        self._lootingEquipList.name[ii]:SetFontColor(itemGradeColor)
        self._lootingEquipList.icon[ii].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(" .. whereType .. "," .. PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[ii] .. ")")
        self._lootingEquipList.icon[ii].icon:addInputEvent("Mouse_RUp", "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(" .. whereType .. "," .. PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[ii] .. ")")
        self._lootingEquipList.equipBg[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(" .. whereType .. "," .. PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[ii] .. ")")
        self._lootingEquipList.equipBg[ii]:addInputEvent("Mouse_RUp", "HandleEventLUp_SA_Widget_Looting_Equip_EquipClick(" .. whereType .. "," .. PaGlobal_SA_Widget_Looting_Equip._lootingEquipSlotList[ii] .. ")")
        self._lootingEquipList.icon[ii].border:ChangeTextureInfoName(self._itemGradeTexUV.path)
        local x1, y1, x2, y2 = setTextureUV_Func(self._lootingEquipList.icon[ii].border, self._itemGradeTexUV[itemGrade].x1, self._itemGradeTexUV[itemGrade].y1, self._itemGradeTexUV[itemGrade].x2, self._itemGradeTexUV[itemGrade].y2)
        self._lootingEquipList.icon[ii].border:getBaseTexture():setUV(x1, y1, x2, y2)
        self._lootingEquipList.icon[ii].border:setRenderTexture(self._lootingEquipList.icon[ii].border:getBaseTexture())
      end
    else
      self._lootingEquipList.name[ii]:SetText(" ")
      self._lootingEquipList.icon[ii]:clearItem()
      self._lootingEquipList.equipBg[ii]:SetShow(false)
    end
  end
end
function PaGlobal_SA_Widget_Looting_Equip:checkBetterItem(itemWrapper, whereType, slotNo)
  UI.ASSERT_NAME(nil ~= whereType, "PaGlobal_SA_Widget_Looting_Equip:checkBetterItem\236\157\152 whereType nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= slotNo, "PaGlobal_SA_Widget_Looting_Equip:checkBetterItem\236\157\152 slotNo nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  local isBetter = false
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return isBetter
  end
  local isServantEquip = itemSSW:isUsableServant()
  local isEquip = itemSSW:isEquipable()
  if false == isServantEquip and true == isEquip and true == itemWrapper:checkConditions() then
    local currentEndurance = itemWrapper:get():getEndurance()
    local offencePoint = 0
    local defencePoint = 0
    local equipOffencePoint = 0
    local equipDefencePoint = 0
    local matchEquip = false
    local isAccessory = false
    offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = _inventory_updateSlot_compareSpec(whereType, slotNo, isAccessory)
    if nil ~= defencePoint and nil ~= offencePoint and 0 < currentEndurance and true == matchEquip and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
      isBetter = true
    end
  end
  return isBetter
end
function PaGlobal_SA_Widget_Looting_Equip:getAccesoryWorseEquipment_Key(itemWrapper)
  if nil == itemWrapper then
    return nil
  end
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  local firstEquipOffence = 0
  local firstEquipDeffence = 0
  local secondEquipOffence = 0
  local secondEquipDeffence = 0
  local acc
  if 16 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(8)
    if nil ~= equipItemWrapper then
      firstEquipOffence = (equipItemWrapper:getStaticStatus():getMinDamage(0) + equipItemWrapper:getStaticStatus():getMaxDamage(0)) / 2
      firstEquipDeffence = equipItemWrapper:getStaticStatus():getDefence()
    end
    equipItemWrapper2 = ToClient_getEquipmentItem(9)
    if nil ~= equipItemWrapper2 then
      secondEquipOffence = (equipItemWrapper2:getStaticStatus():getMinDamage(0) + equipItemWrapper2:getStaticStatus():getMaxDamage(0)) / 2
      secondEquipDeffence = equipItemWrapper2:getStaticStatus():getDefence()
    end
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      local firstEquipStat = firstEquipOffence + firstEquipDeffence
      local secondEquipStat = secondEquipOffence + secondEquipDeffence
      if firstEquipStat > secondEquipStat then
        acc = 9
      else
        acc = 8
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 8
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = 9
    else
      acc = 8
    end
  elseif 17 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(10)
    if nil ~= equipItemWrapper then
      firstEquipOffence = (equipItemWrapper:getStaticStatus():getMinDamage(0) + equipItemWrapper:getStaticStatus():getMaxDamage(0)) / 2
      firstEquipDeffence = equipItemWrapper:getStaticStatus():getDefence()
    end
    equipItemWrapper2 = ToClient_getEquipmentItem(11)
    if nil ~= equipItemWrapper2 then
      secondEquipOffence = (equipItemWrapper2:getStaticStatus():getMinDamage(0) + equipItemWrapper2:getStaticStatus():getMaxDamage(0)) / 2
      secondEquipDeffence = equipItemWrapper2:getStaticStatus():getDefence()
    end
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      local firstEquipStat = firstEquipOffence + firstEquipDeffence
      local secondEquipStat = secondEquipOffence + secondEquipDeffence
      if firstEquipStat > secondEquipStat then
        acc = 11
      else
        acc = 10
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 10
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = 11
    else
      acc = 10
    end
  end
  return acc
end
function PaGlobal_SA_Widget_Looting_Equip:convert_itemGradeColor(grade)
  UI.ASSERT_NAME(nil ~= grade, "PaGlobal_SA_Widget_Looting_Equip:convert_itemGradeColor\236\157\152 grade nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if 0 == grade then
    return 4293388263
  elseif 1 == grade then
    return 4288921664
  elseif 2 == grade then
    return 4283938018
  elseif 3 == grade then
    return 4293904710
  elseif 4 == grade then
    return 4294929482
  else
    return UI_color.C_FFFFFFFF
  end
end
