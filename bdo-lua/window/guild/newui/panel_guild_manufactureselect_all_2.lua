function PaGlobalFunc_Guild_ManufactureSelect_All_Open(index)
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  PaGlobal_Guild_ManufactureSelect_All:prepareOpen(index)
end
function PaGlobalFunc_Guild_ManufactureSelect_All_Close()
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  PaGlobal_Guild_ManufactureSelect_All:prepareClose()
end
function HandleEventOnOut_Guild_ManufactureSelect_All_ShowTooltip(isShow, index)
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  if false == isShow then
    FGlobal_Hide_Tooltip_Work(nil, true)
    return
  end
  local manufacture = ToClient_GetGuildManufactureStaticStatusWrapper(PaGlobal_Guild_ManufactureSelect_All._itemEnchantKey[index])
  if nil == manufacture then
    return
  end
  local itemStatic = ToClient_getItemExchangeSourceStaticStatusWrapper(manufacture:getExchangeKey())
  if nil ~= itemStatic then
    Panel_Tooltip_Item_SetPosition(index, PaGlobal_Guild_ManufactureSelect_All._ui.stc_mainArea, "guildManufactureProductItemSelect")
    FGlobal_Show_Tooltip_Work(itemStatic, Panel_Guild_ManufactureSelect_All, nil, nil, true)
  end
end
function HandleEventLUp_Guild_ManufactureSelect_All_Select(index)
  if nil == Panel_Guild_ManufactureSelect_All then
    return
  end
  PaGlobalFunc_Guild_Manufacture_All_SetProductItem(PaGlobal_Guild_ManufactureSelect_All._index, PaGlobal_Guild_ManufactureSelect_All._itemEnchantKey[index])
  PaGlobal_Guild_ManufactureSelect_All:prepareClose()
end
function PaGlobalFunc_Guild_ManufactureSelect_All_GetShow()
  if nil == Panel_Guild_ManufactureSelect_All then
    return false
  end
  return Panel_Guild_ManufactureSelect_All:GetShow()
end
