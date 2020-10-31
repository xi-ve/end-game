function PaGlobal_InventoryEquip_Detail_Renew_Open()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(false)
end
function PaGlobal_InventoryEquip_Detail_Renew_Open_BySimpleInventory()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(true)
end
function PaGlobal_InventoryEquip_Detail_Renew_Close()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareClose()
end
function FromClient_InventoryEquip_Detail_Renew_EquipmentChanged()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
end
function HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
end
function HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedSet()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
end
