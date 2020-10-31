function showTooltip_Item(target, itemWrapper, isSSW, isItemWrapper, chattingLinkedItem, index, isNextEnchantInfo, invenSlotNo, itemNamingStr)  
    audioPostEvent_SystemUi(1, 13)
    _AudioPostEvent_SystemUiForXBOX(1, 13)
    target.mainPanel:SetShow(true, false)
    local ret, ret2 = Panel_Tooltip_Item_ShowInfo(target, itemWrapper, isSSW, isItemWrapper, chattingLinkedItem, index, isNextEnchantInfo, invenSlotNo, itemNamingStr)
  
    local itemId = 0
    if isSSW and not isItemWrapper then    
  
      itemId = itemWrapper:get()._key:getItemKey() 
    else    
  
      itemId = ((itemWrapper:get()):getKey()):getItemKey()
    end
  
    target.itemName:SetText(target.itemName:GetText() .. " <PAColor0xffe7d583>[" .. tostring(itemId) .. "]<PAOldColor>")
  
    return ret, ret2
  end