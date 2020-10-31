function FromClient_SA_Widget_Looting_Equip_Combination_UpdateItemCombination()
  PaGlobal_SA_Widget_Looting_Equip_Combination:updateItemCombinationList()
end
function FromClient_ShadowArenaUpdateItemCombination_UpdateEquipment()
  if true == PaGlobal_SA_Widget_Looting_Equip_Combination._isKeyUp then
    PaGlobal_SA_Widget_Looting_Equip_Combination_RequestItem()
    PaGlobal_SA_Widget_Looting_Equip_Combination._isKeyUp = false
  end
end
function PaGlobal_SA_Widget_Looting_Equip_Combination_CombinationKeyUp()
  if true == DragManager:isDragging() then
    DragManager:clearInfo()
    return
  end
  if true == ToClient_ShadowArenaCombinationAble() then
    if false == PaGlobal_SA_Widget_Looting_Equip_Combination:checkEquipItem() then
      PaGlobal_SA_Widget_Looting_Equip_Combination_RequestItem()
    else
      PaGlobal_SA_Widget_Looting_Equip_Combination._isKeyUp = true
    end
    local resultItemkey = ToClient_getCombinationResultItemKey()
    PaGlobal_SA_Widget_Looting_AddCombinationResultItem(resultItemkey)
  end
  PaGlobal_SA_Widget_Looting_Equip_Combination:updateItemCombinationList()
end
function PaGlobal_SA_Widget_Looting_Equip_Combination_RequestItem()
  ToClient_RequestItemCombination()
  PaGlobal_SA_Widget_Looting_Equip_Combination:prepareClose()
end
