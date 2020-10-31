function PaGlobalFunc_Guild_Manufacture_All_SetProductItem(index, itemEnchantKey)
  if nil == Panel_GuildMain_All then
    return
  end
  local itemEnchantKey = itemEnchantKey
  local itemStatic = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemStatic then
    return
  end
  PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey = itemEnchantKey
  PaGlobal_Guild_Manufacture_All._slot[index]._productItemCount_s64 = toInt64(0, 1)
  local slot = PaGlobal_Guild_Manufacture_All._slot[index][__eGuildManufactureStateNone]
  slot._productSlot:setItemByStaticStatus(itemStatic)
  slot._productSlot.bg:SetShow(true)
  slot._backGround:SetShow(true)
  slot._productItemName:SetText(itemStatic:getName())
  slot._productItemName:SetShow(true)
  slot._noMakeText:SetShow(false)
  slot._setButton:SetShow(true)
end
function PaGlobalFunc_Guild_Manufacture_All_Update()
  for ii = 0, __eGuildManufactureProductItemCount - 1 do
    PaGlobal_Guild_Manufacture_All._slot[ii]:SetShow(false)
  end
  local listWrapper = ToClient_GetGuildManufactureListWrapper()
  if nil ~= listWrapper then
    for ii = 0, __eGuildManufactureProductItemCount - 1 do
      local infoWrapper = listWrapper:getInfo(ii)
      if nil ~= infoWrapper then
        local state = infoWrapper:getState()
        if __eGuildManufactureStateNone == state then
          PaGlobal_Guild_Manufacture_All:__updateNoneState(ii, infoWrapper)
        elseif __eGuildManufactureStateProceeding == state then
          PaGlobal_Guild_Manufacture_All:__updateProceedingState(ii, infoWrapper, false)
        elseif __eGuildManufactureStateReady == state then
          PaGlobal_Guild_Manufacture_All:__updateProceedingState(ii, infoWrapper, true)
        elseif __eGuildManufactureStateCreating == state then
          PaGlobal_Guild_Manufacture_All:__updateCreatingState(ii, infoWrapper)
        elseif __eGuildManufactureStateComplete == state then
          PaGlobal_Guild_Manufacture_All:__updateCompleteState(ii, infoWrapper)
        else
          _PA_ASSERT(false, "PaGlobal_Guild_Manufacture:refresh() \236\151\134\235\138\148 state \234\176\146 \236\158\133\235\139\136\235\139\164. %s", state)
        end
      else
        PaGlobal_Guild_Manufacture_All._slot[ii][__eGuildManufactureStateNone]._backGround:SetShow(true)
      end
    end
  else
    for ii = 0, __eGuildManufactureProductItemCount - 1 do
      PaGlobal_Guild_Manufacture_All._slot[ii][__eGuildManufactureStateNone]._backGround:SetShow(true)
    end
  end
end
function PaGlobalFunc_Guild_Manufacture_All_Start(index)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    ToClient_Guild_Manufacture_Start(index, PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
end
function PaGlobalFunc_Guild_Manufacture_All_Delete(index)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    local function manufactureDeleteYes()
      ToClient_Guild_Manufacture_Delete(index, PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey)
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_DELETE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_DELETE_CONTENT"),
      functionYes = manufactureDeleteYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "center")
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
end
function PaGlobalFunc_Guild_Manufacture_All_Complete(index)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    ToClient_Guild_Manufacture_NowComplete(index, PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey, toInt64(0, 0), 0)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
end
function PaGlobalFunc_Guild_Manufacture_All_Receive(index)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    ToClient_Guild_Manufacture_Receive(index, PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
end
function PaGlobalFunc_Guild_Manufacture_All_UpdateItem(mainIndex, subIndex)
  local function manufactureConfirmYes()
    local slot = PaGlobal_Guild_Manufacture_All._slot[mainIndex][__eGuildManufactureStateProceeding]
    local itemEnchantKey = slot._requiredItem[subIndex].enchantKey
    local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
    if __eTInventorySlotNoUndefined == slotNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_INVENTORY"))
      return
    end
    local itemWrapper = getInventoryItem(slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() then
      local stackCount_s64 = itemWrapper:getCount()
      local requiredCount_s64 = slot._requiredItem[subIndex].countValue_s64
      if stackCount_s64 > requiredCount_s64 then
        Panel_NumberPad_Show(true, requiredCount_s64, slotNo, PaGlobalFunc_Guild_Manufacture_All_Update_RequiredItemCount, nil, mainIndex, nil, subIndex)
      else
        Panel_NumberPad_Show(true, stackCount_s64, slotNo, PaGlobalFunc_Guild_Manufacture_All_Update_RequiredItemCount, nil, mainIndex, nil, subIndex)
      end
    end
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_NOTICE_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_DELETE_CONTENT_ITEM"),
    functionYes = manufactureConfirmYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_Guild_Manufacture_All_Update_RequiredItemCount(inputNumber, slotNo, mainIndex, subIndex)
  local slot = PaGlobal_Guild_Manufacture_All._slot[mainIndex][__eGuildManufactureStateProceeding]
  local itemEnchantKey = slot._requiredItem[subIndex].enchantKey
  ToClient_Guild_Manufacture_Update(mainIndex, subIndex, itemEnchantKey, CppEnums.ItemWhereType.eInventory, slotNo, inputNumber)
end
function HandleEventLUp_Guild_Manufacture_All_Select(index)
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    PaGlobalFunc_Guild_ManufactureSelect_All_Open(index)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
end
function HandleEventLUp_Guild_Manufacture_All_Set(index)
  if nil == PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_ITEM"))
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isGuildMaster() then
    ToClient_Guild_Manufacture_Set(index, PaGlobal_Guild_Manufacture_All._slot[index]._productItemEnchantKey, PaGlobal_Guild_Manufacture_All._slot[index]._productItemCount_s64)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_PERMISSION"))
  end
  if true == PaGlobalFunc_Guild_ManufactureSelect_All_GetShow() then
    PaGlobalFunc_Guild_ManufactureSelect_All_Close()
  end
end
function HandleEventLUp_Guild_Manufacture_All_ItemUnSet(index)
  local slot = PaGlobal_Guild_Manufacture_All._slot[index][__eGuildManufactureStateNone]
  slot._productSlot.bg:SetShow(false)
  slot._productItemName:SetShow(false)
  slot._setButton:SetShow(false)
  slot._noMakeText:SetShow(true)
  slot._productSlot:clearItem()
  HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)
end
function HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(isShow, index, state)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local slot = PaGlobal_Guild_Manufacture_All._slot[index]
  if nil == slot._productItemEnchantKey then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(slot._productItemEnchantKey)
  if nil ~= itemStatic then
    Panel_Tooltip_Item_SetPosition(index, slot[state], "guildManufactureProductItem")
    Panel_Tooltip_Item_Show(itemStatic, slot[state]._productSlot.bg, true)
  end
end
function HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip_ForConsole(index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local slot = PaGlobal_Guild_Manufacture_All._slot[index]
  if nil == slot._productItemEnchantKey then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(slot._productItemEnchantKey)
  if nil ~= itemStatic then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip(isShow, mainIndex, subIndex)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local slot = PaGlobal_Guild_Manufacture_All._slot[mainIndex][__eGuildManufactureStateProceeding]
  if nil == slot or nil == slot._requiredItem[subIndex] or nil == slot._requiredItem[subIndex].enchantKey then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(slot._requiredItem[subIndex].enchantKey)
  if nil ~= itemStatic then
    Panel_Tooltip_Item_SetPosition(subIndex, PaGlobal_Guild_Manufacture_All._slot[mainIndex], "guildManufactureRequiredItem")
    Panel_Tooltip_Item_Show(itemStatic, slot._requiredSlot[subIndex].bg, true)
  end
end
function HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip_ForConsole(mainIndex, subIndex)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local slot = PaGlobal_Guild_Manufacture_All._slot[mainIndex][__eGuildManufactureStateProceeding]
  if nil == slot or nil == slot._requiredItem[subIndex] or nil == slot._requiredItem[subIndex].enchantKey then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(slot._requiredItem[subIndex].enchantKey)
  if nil ~= itemStatic then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function FromClient_Guild_Manufacture_All_CompletePrice(index, itemEnchantKey, price_s64)
  local function manufactureCompleteYes()
    ToClient_Guild_Manufacture_NowComplete(index, itemEnchantKey, price_s64, 1)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_NOW_TITLE"),
    content = string.format(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_MESSAGE_NOW"), makeDotMoney(price_s64)),
    functionYes = manufactureCompleteYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "center")
end
function FromClient_Guild_Manufacture_All_Refresh(index)
  if false == PaGlobal_Guild_Manufacture_All._ui.stc_mainArea:GetShow() then
    return
  end
  PaGlobal_Guild_Manufacture_All:refreshState(index)
end
