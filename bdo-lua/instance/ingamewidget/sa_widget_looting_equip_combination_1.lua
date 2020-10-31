function PaGlobal_SA_Widget_Looting_Equip_Combination:initialize()
  if true == PaGlobal_SA_Widget_Looting_Equip_Combination._initialize then
    return
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_topBg = UI.getChildControl(Panel_SA_Looting_Equip_Combination, "Static_TopBG")
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_gatherIcon = UI.getChildControl(PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_topBg, "Static_GatherIcon")
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.txt_msg = UI.getChildControl(PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_topBg, "StaticText_Message")
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_lootingBG = UI.getChildControl(Panel_SA_Looting_Equip_Combination, "Static_BottomBG")
  PaGlobal_SA_Widget_Looting_Equip_Combination:registEventHandler()
  PaGlobal_SA_Widget_Looting_Equip_Combination:validate()
  PaGlobal_SA_Widget_Looting_Equip_Combination:createControl()
  PaGlobal_SA_Widget_Looting_Equip_Combination._combinationItemCount = __eShadowArenaItemCombinationMaxCount
  PaGlobal_SA_Widget_Looting_Equip_Combination._initialize = true
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.txt_msg:SetShow(false)
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:registEventHandler()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  registerEvent("FromClient_ShadowArenaUpdateItemCombination", "FromClient_SA_Widget_Looting_Equip_Combination_UpdateItemCombination")
  registerEvent("FromClient_InventoryUpdate", "FromClient_SA_Widget_Looting_Equip_Combination_UpdateItemCombination")
  registerEvent("EventEquipmentUpdate", "FromClient_ShadowArenaUpdateItemCombination_UpdateEquipment")
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:prepareOpen()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination:open()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:open()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  Panel_SA_Looting_Equip_Combination:SetShow(true)
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:prepareClose()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  self._materialItemKey = nil
  PaGlobal_SA_Widget_Looting_Equip_Combination:close()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:close()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  Panel_SA_Looting_Equip_Combination:SetShow(false)
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:validate()
  if nil == Panel_SA_Looting_Equip_Combination then
    return
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_topBg:isValidate()
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_gatherIcon:isValidate()
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.txt_msg:isValidate()
  PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_lootingBG:isValidate()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:createControl()
  for index = 1, PaGlobal_SA_Widget_Looting_Equip_Combination._maxCombinationCount do
    local equipItem = UI.cloneControl(PaGlobal_SA_Widget_Looting_Equip_Combination._ui.stc_lootingBG, Panel_SA_Looting_Equip_Combination, "Static_BottomBG_" .. index)
    equipItem:SetPosY(index * 51)
    local _combinationListContent = {
      equipBg = {},
      icon = {},
      name = {}
    }
    for ii = 1, PaGlobal_SA_Widget_Looting_Equip_Combination._combinationItemCount do
      _combinationListContent.equipBg[ii] = UI.getChildControl(equipItem, "Static_NewItemBG" .. ii)
      _combinationListContent.icon[ii] = UI.getChildControl(_combinationListContent.equipBg[ii], "Static_ItemIcon")
      local slot = {}
      SlotItem.new(slot, "slotIcon_" .. ii, ii, _combinationListContent.icon[ii], PaGlobal_SA_Widget_Looting_Equip_Combination._slotConfig)
      slot:createChild()
      _combinationListContent.icon[ii] = slot
      PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index] = _combinationListContent
    end
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination:close()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:resetData()
  for index = 1, PaGlobal_SA_Widget_Looting_Equip_Combination._maxCombinationCount do
    if nil ~= PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index] then
      for ii = 1, PaGlobal_SA_Widget_Looting_Equip_Combination._combinationItemCount do
        PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index].equipBg[ii]:SetShow(false)
        PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index].icon[ii]:clearItem()
      end
    end
  end
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:updateItemCombinationList()
  PaGlobal_SA_Widget_Looting_Equip_Combination:resetData()
  if false == ToClient_ShadowArenaCombinationAble() then
    PaGlobal_SA_Widget_Looting_Equip_Combination:prepareClose()
    return
  end
  for index = 1, PaGlobal_SA_Widget_Looting_Equip_Combination._maxCombinationCount do
    for ii = 0, __eShadowArenaItemCombinationMaxCount - 1 do
      self._materialItemKey = ToClient_getCombinationableItemKey(index)
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._materialItemKey))
      PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index].equipBg[ii + 1]:SetShow(true)
      PaGlobal_SA_Widget_Looting_Equip_Combination._combinationList[index].icon[ii + 1]:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
    end
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination:prepareOpen()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:checkEquipItem()
  if nil == self._materialItemKey then
    return
  end
  local equipNoMin = CppEnums.EquipSlotNo.rightHand
  local equipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  for equipNo = equipNoMin, equipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if nil ~= itemWrapper and self._materialItemKey == itemWrapper:get():getKey():getItemKey() then
      Equipment_RClick(equipNo)
      local unEquipMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMCOMBINATION_ALERT")
      Proc_ShowMessage_Ack(unEquipMsg)
      return true
    end
  end
  return false
end
function PaGlobal_SA_Widget_Looting_Equip_Combination:convert_itemGradeColor(grade)
  UI.ASSERT_NAME(nil ~= grade, "PaGlobal_SA_Widget_Looting_Equip_Combination:convert_itemGradeColor\236\157\152 grade nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\236\154\176\236\160\149\235\172\180")
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
