function PaGlobal_Cash_Revival_BuyItem_All:initialize()
  if nil == Panel_Cash_Revival_BuyItem_All or true == PaGlobal_Cash_Revival_BuyItem_All._initialize then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "Static_BG")
  PaGlobal_Cash_Revival_BuyItem_All._ui.txt_notify = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "StaticText_Notify")
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "Static_ItemListBG")
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "Button_Confirm_PC")
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "Button_Cancel_PC")
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_keyGuide_ConsoleUI = UI.getChildControl(Panel_Cash_Revival_BuyItem_All, "Static_consoleKeyGuide")
  PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template = UI.getChildControl(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG, "RadioButton_ItemSlot")
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIconBG_template = UI.getChildControl(PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template, "Static_ItemIconBG")
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIcon_template = UI.getChildControl(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIconBG_template, "Static_ItemIcon")
  PaGlobal_Cash_Revival_BuyItem_All._ui.txt_itemName_template = UI.getChildControl(PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template, "StaticText_ItemName")
  PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template:SetShow(false)
  Panel_Cash_Revival_BuyItem_All:setGlassBackground(true)
  Panel_Cash_Revival_BuyItem_All:ActiveMouseEventEffect(true)
  PaGlobal_Cash_Revival_BuyItem_All._originListBgSizeY = PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetSizeY()
  PaGlobal_Cash_Revival_BuyItem_All._originStcBgSizeY = PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:GetSizeY()
  PaGlobal_Cash_Revival_BuyItem_All._originPanelSizeY = Panel_Cash_Revival_BuyItem_All:GetSizeY()
  PaGlobal_Cash_Revival_BuyItem_All:setConsole()
  PaGlobal_Cash_Revival_BuyItem_All:registEventHandler()
  PaGlobal_Cash_Revival_BuyItem_All:validate()
  PaGlobal_Cash_Revival_BuyItem_All._initialize = true
end
function PaGlobal_Cash_Revival_BuyItem_All:setConsole()
  if true == PaGlobal_Cash_Revival_BuyItem_All._isConsole then
    PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:SetShow(false)
    PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC:SetShow(false)
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_keyGuide_ConsoleUI:SetShow(true)
  else
    PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:SetShow(true)
    PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC:SetShow(true)
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_keyGuide_ConsoleUI:SetShow(false)
  end
end
function PaGlobal_Cash_Revival_BuyItem_All:registEventHandler()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:addInputEvent("Mouse_LUp", "HandleEventLUp_Cash_Revival_BuyItem_All_Confirm()")
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC:addInputEvent("Mouse_LUp", "PaGlobal_Cash_Revival_BuyItem_All_Close()")
  registerEvent("FromClient_NotifyCacheRespawn", "FromClient_Cash_Revival_BuyItem_All_NotifyCacheRespawn")
  registerEvent("onScreenResize", "FromClient_Cash_Revival_BuyItem_All_OnScreenReSize")
end
function PaGlobal_Cash_Revival_BuyItem_All:prepareOpen()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All:update()
  FromClient_Cash_Revival_BuyItem_All_OnScreenReSize()
  PaGlobal_Cash_Revival_BuyItem_All:open()
end
function PaGlobal_Cash_Revival_BuyItem_All:open()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  Panel_Cash_Revival_BuyItem_All:SetShow(true)
end
function PaGlobal_Cash_Revival_BuyItem_All:prepareClose()
  if nil == Panel_Cash_Revival_BuyItem_All or false == Panel_Cash_Revival_BuyItem_All:GetShow() then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All:close()
end
function PaGlobal_Cash_Revival_BuyItem_All:close()
  if nil == Panel_Cash_Revival_BuyItem_All or false == Panel_Cash_Revival_BuyItem_All:GetShow() then
    return
  end
  Panel_Cash_Revival_BuyItem_All:SetShow(false)
end
function PaGlobal_Cash_Revival_BuyItem_All:radioButtonAllHide()
  for itemIdx = 0, PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount - 1 do
    local UiBase = PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[itemIdx]
    UiBase.radioButton:SetCheck(false)
    UiBase.radioButton:SetShow(false)
  end
end
function PaGlobal_Cash_Revival_BuyItem_All:update()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData = {}
  PaGlobal_Cash_Revival_BuyItem_All:radioButtonAllHide()
  PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount = 0
  local idx = 0
  local cashInvenItem
  for cashInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
    cashInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, cashInvenIdx)
    if cashInvenItem ~= nil then
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx] = {}
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].name = cashInvenItem:getStaticStatus():getName()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].iconPath = cashInvenItem:getStaticStatus():getIconPath()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].slotNo = cashInvenIdx
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eCashInventory
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].count = cashInvenItem:get():getCount_s64()
      idx = idx + 1
    end
  end
  PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount = #PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData + 1
  PaGlobal_Cash_Revival_BuyItem_All._ui.txt_notify:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_UseAbleItem_Notify_Msg"))
  local slotStartX = PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetPosX() + 10
  local slotStartY = PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetPosY() + 10
  local slotGapX = PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template:GetSizeX() + 10
  local slotGapY = PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template:GetSizeY() + 10
  local slotCols = 2
  local slotRows = (PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount - 1) / slotCols
  for itemIdx = 0, PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount - 1 do
    if nil == PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[itemIdx] then
      local tempSlot = {}
      local CreateRadioButton = UI.createControl(__ePAUIControl_RadioButton, Panel_Cash_Revival_BuyItem_All, "RadioButton_ItemSlot_" .. itemIdx)
      CopyBaseProperty(PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template, CreateRadioButton)
      CreateRadioButton:SetShow(false)
      tempSlot.radioButton = CreateRadioButton
      local CreateIconBG = UI.createControl(__ePAUIControl_Static, CreateRadioButton, "Static_ItemIconBG_" .. itemIdx)
      CopyBaseProperty(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIconBG_template, CreateIconBG)
      tempSlot.itemIconBG = CreateIconBG
      local CreateIcon = UI.createControl(__ePAUIControl_Static, CreateIconBG, "Static_ItemIcon_" .. itemIdx)
      CopyBaseProperty(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIcon_template, CreateIcon)
      tempSlot.itemIcon = CreateIcon
      local CreateItemName = UI.createControl(__ePAUIControl_StaticText, CreateRadioButton, "StaticText_ItemName_" .. itemIdx)
      CopyBaseProperty(PaGlobal_Cash_Revival_BuyItem_All._ui.txt_itemName_template, CreateItemName)
      tempSlot.itemNameText = CreateItemName
      PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[itemIdx] = tempSlot
      PaGlobal_Cash_Revival_BuyItem_All._itemUIMaxCount = PaGlobal_Cash_Revival_BuyItem_All._itemUIMaxCount + 1
    end
    local col = itemIdx % slotCols
    local row = math.floor(itemIdx / slotCols)
    local posX = slotStartX + slotGapX * col
    local posY = slotStartY + slotGapY * row
    PaGlobal_Cash_Revival_BuyItem_All._itemListRow = row
    local UiBase = PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[itemIdx]
    UiBase.radioButton:SetPosX(posX)
    UiBase.radioButton:SetPosY(posY)
    UiBase.radioButton:SetCheck(false)
    UiBase.radioButton:SetShow(true)
    if nil ~= PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[itemIdx].iconPath then
      UiBase.itemIcon:ChangeTextureInfoNameDefault("icon/" .. PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[itemIdx].iconPath)
    end
    UiBase.itemNameText:SetText(PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[itemIdx].name .. "(" .. tostring(PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[itemIdx].count) .. ")")
    UiBase.itemIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Cash_Revival_BuyItem_All_SelectItem( " .. itemIdx .. " )")
    UiBase.radioButton:addInputEvent("Mouse_LUp", "HandleEventLUp_Cash_Revival_BuyItem_All_SelectItem( " .. itemIdx .. " )")
  end
  if PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount < 4 then
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:SetSize(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetSizeX(), PaGlobal_Cash_Revival_BuyItem_All._originListBgSizeY)
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:SetSize(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:GetSizeX(), PaGlobal_Cash_Revival_BuyItem_All._originStcBgSizeY)
    Panel_Cash_Revival_BuyItem_All:SetSize(Panel_Cash_Revival_BuyItem_All:GetSizeX(), PaGlobal_Cash_Revival_BuyItem_All._originPanelSizeY)
  else
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:SetSize(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetSizeX(), 10 + slotGapY * math.ceil(PaGlobal_Cash_Revival_BuyItem_All._cashRevivalCount / slotCols))
    local bgSizeY = PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:GetSizeY() + PaGlobal_Cash_Revival_BuyItem_All._ui.txt_notify:GetSizeY() + PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:GetSizeY() + 20
    PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:SetSize(PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:GetSizeX(), bgSizeY)
    Panel_Cash_Revival_BuyItem_All:SetSize(Panel_Cash_Revival_BuyItem_All:GetSizeX(), PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:GetSizeY() + 50)
  end
end
function PaGlobal_Cash_Revival_BuyItem_All:validate()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_BG:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.txt_notify:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemlistBG:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_keyGuide_ConsoleUI:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.rdo_itemSlot_template:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIconBG_template:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.stc_itemIcon_template:isValidate()
  PaGlobal_Cash_Revival_BuyItem_All._ui.txt_itemName_template:isValidate()
end
