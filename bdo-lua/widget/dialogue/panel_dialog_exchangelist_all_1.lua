function PaGlobal_DialogExchange_All:initialize()
  if true == PaGlobal_DialogExchange_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  local listContent = UI.getChildControl(self._ui.list2_exchange, "List2_2_Content")
  local itemNeed = UI.getChildControl(listContent, "Static_TargetSlot")
  local itemResult = UI.getChildControl(listContent, "Static_ResultSlot")
  local slotNeed = {}
  SlotItem.new(slotNeed, "ExchangeList_All_NeedSlot_", 0, itemNeed, self._slotConfig)
  slotNeed:createChild()
  slotNeed.empty = true
  slotNeed:clearItem()
  slotNeed.icon:SetPosX(1)
  slotNeed.icon:SetPosY(1)
  slotNeed.icon:SetSize(40, 40)
  slotNeed.enchantText:SetSize(38, 38)
  slotNeed.border:SetSize(40, 40)
  local slotResult = {}
  SlotItem.new(slotResult, "ExchangeList_All_ResultSlot_", 0, itemResult, self._slotConfig)
  slotResult:createChild()
  slotResult.empty = true
  slotResult:clearItem()
  slotResult.icon:SetPosX(1)
  slotResult.icon:SetPosY(1)
  slotResult.icon:SetSize(35, 35)
  slotResult.enchantText:SetSize(33, 33)
  slotResult.border:SetSize(35, 35)
  PaGlobal_DialogExchange_All:registEventHandler()
  PaGlobal_DialogExchange_All:validate()
  PaGlobal_DialogExchange_All._initialize = true
end
function PaGlobal_DialogExchange_All:controlAll_Init()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  self._ui.list2_exchange = UI.getChildControl(Panel_Dialog_Exchange_All, "List2_Exchange_List")
  self._ui.stc_titleBg = UI.getChildControl(Panel_Dialog_Exchange_All, "Static_Title")
end
function PaGlobal_DialogExchange_All:controlPc_Init()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  self._ui_pc.stc_bottomGuideBg = UI.getChildControl(Panel_Dialog_Exchange_All, "Static_BottomGuide_PCUI")
  self._ui_pc.txt_listGuide = UI.getChildControl(self._ui_pc.stc_bottomGuideBg, "StaticText_listMoveGuide")
end
function PaGlobal_DialogExchange_All:controlConsole_Init()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Dialog_Exchange_All, "Static_BottomButton_ConsoleUI")
  self._ui_console.stc_guidIconA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_KeyGuideSelect_ConsoleUI")
  self._ui_console.stc_guidIconB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_KeyGuideCancel_ConsoleUI")
end
function PaGlobal_DialogExchange_All:controlSetShow()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.stc_bottomGuideBg:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    self._ui_pc.stc_bottomGuideBg:SetShow(false)
    self._ui_console.stc_bottomGuideBg:SetShow(true)
  end
end
function PaGlobal_DialogExchange_All:prepareOpen()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if true == PaGlobal_DialogExchange_All._isExchange then
    PaGlobal_DialogExchange_All._isExchange = false
  end
  if false == self._isConsole then
    PaGlobalFunc_DialogKeyManager_All_SetConfirmFunc(HandleEventLUp_ExchangeList_All_ClickButton)
    PaGlobalFunc_DialogKeyManager_All_SetTarget(Panel_Dialog_Exchange_All, PaGlobal_DialogExchange_All._ui.list2_exchange, "RadioButton_Exchange", "StaticText_Spacebar")
    PaGlobalFunc_DialogKeyManager_All_SetClear(false, false, true, true)
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_DialogMain_All:buttonSpaceBarcheck(false)
  PaGlobal_DialogExchange_All:resize()
  PaGlobal_DialogExchange_All:open()
  PaGlobal_DialogExchange_All:update()
end
function PaGlobal_DialogExchange_All:open()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  Panel_Dialog_Exchange_All:SetShow(true, true)
end
function PaGlobal_DialogExchange_All:prepareClose(showAni)
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if false == Panel_Dialog_Exchange_All:GetShow() then
    return
  end
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  self._ui.list2_exchange:getElementManager():clearKey()
  self._lastTopIndex = 0
  self._isExchange = false
  self._selectIndex = 0
  self._resultItemMsg.count = nil
  self._resultItemMsg.name = nil
  PaGlobal_DialogMain_All:buttonSpaceBarcheck(true)
  PaGlobalFunc_DialogKeyManager_All_SetClear(true, true, true, true)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_DialogExchange_All:close(showAni)
end
function PaGlobal_DialogExchange_All:close(showAni)
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  if false == showAni then
    Panel_Dialog_Exchange_All:SetShow(false)
  else
    Panel_Dialog_Exchange_All:SetShow(false, true)
  end
end
function PaGlobal_DialogExchange_All:update()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  PaGlobalFunc_DialogMain_All_SetExchangeNpcDialog()
  local toIndex = PaGlobal_DialogExchange_All._ui.list2_exchange:getCurrenttoIndex()
  local scrollvalue = 0
  if 0 ~= toIndex then
    self._lastTopIndex = toIndex
    scrollvalue = self._ui.list2_exchange:GetVScroll():GetControlPos()
  end
  if self._dialogListCount ~= dialogData:getDialogButtonCount() then
    self._lastTopIndex = 0
  end
  self._dialogListCount = dialogData:getDialogButtonCount()
  self._ui.list2_exchange:getElementManager():clearKey()
  PaGlobalFunc_DialogKeyManager_All_SetClear(false, false, true, false)
  if 0 >= self._dialogListCount then
    HandleEventLUp_DialogMain_All_BackClick()
    return
  end
  for index = 1, self._dialogListCount do
    self._ui.list2_exchange:getElementManager():pushKey(toInt64(0, index))
    local dialogButton = dialogData:getDialogButtonAt(index - 1)
    if true == dialogButton._enable and true == dialogButton._invenPushable then
      PaGlobalFunc_DialogKeyManager_All_EnableListPush(index - 1)
    end
  end
  if 0 ~= self._lastTopIndex then
    self._ui.list2_exchange:setCurrenttoIndex(self._lastTopIndex)
    self._ui.list2_exchange:GetVScroll():SetControlPos(scrollvalue)
    self._lastTopIndex = 0
  end
end
function PaGlobal_DialogExchange_All:resize()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  local uiOffsetX = 0
  if true == self._isConsole then
    uiOffsetX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  end
  Panel_Dialog_Exchange_All:SetPosX(getScreenSizeX() - Panel_Dialog_Exchange_All:GetSizeX() - 20 + uiOffsetX)
  Panel_Dialog_Exchange_All:SetPosY(math.max(0, (getScreenSizeY() - Panel_Npc_Dialog_All:GetSizeY()) / 2 - Panel_Dialog_Exchange_All:GetSizeY() / 2))
  if true == self._isConsole then
    local guideIconGroup = {
      self._ui_console.stc_guidIconA,
      self._ui_console.stc_guidIconB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui_console.stc_bottomGuideBg:ComputePos()
  else
    self._ui_pc.txt_listGuide:SetText(self._listKeyGuideString)
    self._ui_pc.stc_bottomGuideBg:SetSize(self._ui_pc.txt_listGuide:GetTextSizeX() + 50, self._ui_pc.stc_bottomGuideBg:GetSizeY())
    self._ui_pc.stc_bottomGuideBg:ComputePos()
    self._ui_pc.txt_listGuide:ComputePos()
  end
end
function PaGlobal_DialogExchange_All:registEventHandler()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  self._ui.list2_exchange:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ExchangeList_All_UpdateNormalNPCButtonlist")
  self._ui.list2_exchange:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Dialog_Exchange_All:RegisterShowEventFunc(true, "PaGlobalFunc_DialogExchange_All_ShowAni()")
  Panel_Dialog_Exchange_All:RegisterShowEventFunc(false, "PaGlobalFunc_DialogExchange_All_HideAni()")
  registerEvent("FromClient_ExchangeItemArrived", "FromClient_DialogFunctionExchange_Response")
  registerEvent("FromClient_WpChanged", "FromClient_DialogFunctionExchange_Response")
  registerEvent("FromClient_InventoryUpdate", "FromClient_DialogFunctionExchange_ResponseInventory")
end
function PaGlobal_DialogExchange_All:validate()
  if nil == Panel_Dialog_Exchange_All then
    return
  end
  self._ui.list2_exchange:isValidate()
  self._ui.stc_titleBg:isValidate()
end
function PaGlobal_DialogExchange_All:dialogNormalNpcControlSet(control, key)
  if nil == key then
    _PA_ASSERT_NAME(false, "PaGlobal_DialogExchange_All:dialogNormalNpcControlSet key\234\176\128 nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  if true == self._isConsole then
    control:SetIgnore(false)
    self._ui.list2_exchange:SetIgnore(false)
  else
    control:SetIgnore(true)
    self._ui.list2_exchange:SetIgnore(true)
  end
  local index = Int64toInt32(key) - 1
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local dialogButton = dialogData:getDialogButtonAt(index)
  local dialogText = dialogButton:getText()
  local displayData = Dialog_getButtonDisplayData(index)
  local btn_exchange = UI.getChildControl(control, "RadioButton_Exchange")
  local stc_beforeItem = UI.getChildControl(control, "Static_TargetSlot")
  local stc_wpItem = UI.getChildControl(control, "Static_WpSlot")
  local stc_afterItem = UI.getChildControl(control, "Static_ResultSlot")
  local txt_beforeName = UI.getChildControl(control, "StaticText_BeforeTemplete")
  local txt_haveCount = UI.getChildControl(control, "StaticText_CountTemplete")
  local txt_afterName = UI.getChildControl(control, "StaticText_AfterTemplete")
  local stc_spacebarIcon = UI.getChildControl(control, "StaticText_Spacebar")
  local slotNeedItem, slotResultItem
  slotNeedItem = {}
  SlotItem.reInclude(slotNeedItem, "ExchangeList_All_NeedSlot_", 0, stc_beforeItem, self._slotConfig)
  slotNeedItem:clearItem()
  slotResultItem = {}
  SlotItem.reInclude(slotResultItem, "ExchangeList_All_ResultSlot_", 0, stc_afterItem, self._slotConfig)
  slotResultItem:clearItem()
  stc_beforeItem:ChangeTextureInfoName("")
  stc_afterItem:ChangeTextureInfoName("")
  txt_beforeName:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_afterName:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_haveCount:SetTextMode(__eTextMode_Limit_AutoWrap)
  slotNeedItem.icon:SetShow(true)
  stc_wpItem:SetShow(false)
  btn_exchange:SetCheck(false)
  btn_exchange:setNotImpactScrollEvent(true)
  stc_spacebarIcon:SetShow(false)
  local needItemKey = dialogButton:getNeedItemKey()
  local needItemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(needItemKey))
  local needItemCount = dialogButton:getNeedItemCount()
  local needItemCaphrasLevel = dialogButton:getNeedCaphrasLevel()
  local needItemColorGrade = ""
  local needItemName = ""
  local needItemIcon = ""
  local needItemEnchantLevel = -1
  local needItemStaticKey = needItemKey
  if nil ~= needItemWrapper and nil ~= needItemWrapper:get() and nil ~= needItemWrapper:get()._key then
    needItemStaticKey = needItemWrapper:get()._key:getItemKey()
    needItemEnchantLevel = needItemWrapper:get()._key:getEnchantLevel()
    slotNeedItem:setItemByStaticStatus(needItemWrapper)
  end
  local isWp = false
  if nil == needItemWrapper then
    if 0 < dialogButton:getNeedWp() then
      isWp = true
    end
  else
    needItemColorGrade = needItemWrapper:getGradeType()
    needItemName = needItemWrapper:getName()
    needItemIcon = needItemWrapper:getIconPath()
  end
  local resultItemKey = dialogButton:getResultItemKeyRaw()
  local resultItemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(resultItemKey))
  local resultItemCount = 1
  local resultItemColorGrade = ""
  local resultItemName = ""
  local resultItemIcon = ""
  local itemType = 0
  if false == isWp then
    local caphrasStr = ""
    if 0 < needItemCaphrasLevel then
      caphrasStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOGEXCHANGE_CAPHRAS_LEV", "lev", tostring(needItemCaphrasLevel + 1))
    end
    local enchantLevelString = ""
    if 15 < needItemEnchantLevel then
      enchantLevelString = HighEnchantLevel_ReplaceString(needItemEnchantLevel) .. " "
    end
    txt_beforeName:SetText(self:getGradeToColorString(needItemColorGrade) .. enchantLevelString .. needItemName .. caphrasStr .. "<PAOldColor> x" .. tostring(needItemCount))
    slotNeedItem.icon:SetShow(true)
    stc_wpItem:SetShow(false)
    if 0 < needItemCaphrasLevel then
      txt_haveCount:SetText("")
    else
      local haveCount = PaGlobal_DialogExchange_All:enchangeItemHaveCount(needItemStaticKey, needItemEnchantLevel)
      txt_haveCount:SetText("<PAColor0xFFFFC832>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", haveCount) .. "<PAOldColor>")
      if true == txt_haveCount:IsLimitText() then
        txt_haveCount:SetText("<PAColor0xFFFFC832>" .. haveCount .. "<PAOldColor>")
      end
    end
  else
    needItemCount = dialogButton:getNeedWp()
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local Wp = selfPlayer:getWp()
    needItemName = PAGetStringParam1(Defines.StringSheet_GAME, "DIALOG_NEED_WP", "wp", needItemCount)
    txt_beforeName:SetText(self:getGradeToColorString(needItemColorGrade) .. needItemName)
    txt_haveCount:SetText("<PAColor0xFFFFC832>" .. Wp .. " " .. PAGetString(Defines.StringSheet_GAME, "DIALOG_WP_GOT") .. "<PAOldColor>")
    slotNeedItem.icon:SetShow(false)
    stc_wpItem:SetShow(true)
    if true == txt_haveCount:IsLimitText() then
      txt_haveCount:SetText("<PAColor0xFFFFC832>" .. Wp .. "<PAOldColor>")
    end
  end
  if nil == resultItemWrapper then
    resultItemName = dialogText
    resultItemCount = ""
    slotResultItem.icon:SetShow(false)
    txt_afterName:SetSpanSize(85, txt_afterName:GetSpanSize().y)
    txt_afterName:SetText(self:getGradeToColorString(resultItemColorGrade) .. resultItemName .. "<PAOldColor>")
  else
    itemType = resultItemWrapper:getItemType()
    resultItemColorGrade = resultItemWrapper:getGradeType()
    resultItemName = resultItemWrapper:getName()
    resultItemIcon = resultItemWrapper:getIconPath()
    slotResultItem:setItemByStaticStatus(resultItemWrapper)
    slotResultItem.icon:SetShow(true)
    txt_afterName:SetSpanSize(125, txt_afterName:GetSpanSize().y)
    txt_afterName:SetText(self:getGradeToColorString(resultItemColorGrade) .. resultItemName .. "<PAOldColor> x " .. tostring(resultItemCount))
  end
  txt_afterName:ComputePos()
  if false == self._isConsole then
    slotNeedItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ExchangeList_All_ItemTooltipNormalNpc(" .. needItemKey .. ",true)")
    slotNeedItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ExchangeList_All_ItemTooltipNormalNpc(" .. needItemKey .. ",false)")
  end
  if false == self._isConsole then
    slotResultItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ExchangeList_All_ItemTooltipNormalNpc(" .. resultItemKey .. ",true)")
    slotResultItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ExchangeList_All_ItemTooltipNormalNpc(" .. resultItemKey .. ",false)")
  end
  if true == dialogButton._enable and true == dialogButton._invenPushable and true == dialogButton:checkConditions() then
    btn_exchange:SetMonoTone(false)
    slotNeedItem.icon:SetMonoTone(false)
    slotResultItem.icon:SetMonoTone(false)
    txt_beforeName:SetMonoTone(false)
    txt_afterName:SetMonoTone(false)
    txt_haveCount:SetMonoTone(false)
    txt_haveCount:SetText("<PAColor0xFFFFC832>" .. PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGEXCHANGE_HASITEM") .. "<PAOldColor>")
    btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeList_All_ClickButton(" .. index .. ")")
    txt_haveCount:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeList_All_ClickButton(" .. index .. ")")
    PaGlobalFunc_DialogKeyManager_All_EnableKeyShow()
  else
    btn_exchange:SetMonoTone(true, true)
    slotNeedItem.icon:SetMonoTone(true, true)
    slotResultItem.icon:SetMonoTone(true, true)
    txt_beforeName:SetMonoTone(true, true)
    txt_afterName:SetMonoTone(true, true)
    txt_haveCount:SetMonoTone(true, true)
    btn_exchange:addInputEvent("Mouse_LUp", "")
    txt_haveCount:addInputEvent("Mouse_LUp", "")
  end
  local limitTextChecks = {
    txt_beforeName,
    txt_afterName,
    txt_haveCount
  }
  for ii = 1, #limitTextChecks do
    if true == limitTextChecks[ii]:IsLimitText() then
      limitTextChecks[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_ExchangeList_All_SimpleTooltip(true," .. ii .. "," .. index .. ")")
      limitTextChecks[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_ExchangeList_All_SimpleTooltip(false," .. ii .. "," .. index .. ")")
    end
  end
end
function PaGlobal_DialogExchange_All:getGradeToColorString(grade)
  if 0 == grade then
    return "<PAColor0xFFC4C4C4>"
  elseif 1 == grade then
    return "<PAColor0xFF83A543>"
  elseif 2 == grade then
    return "<PAColor0xFF438DCC>"
  elseif 3 == grade then
    return "<PAColor0xFFF5BA3A>"
  elseif 4 == grade then
    return "<PAColor0xFFD05D48>"
  else
    return "<PAColor0xFFC4C4C4>"
  end
end
function PaGlobal_DialogExchange_All:expirationItemCheck(itemKey)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenUseSize = getSelfPlayer():get():getInventorySlotCount(true)
  local useStartSlot = inventorySlotNoUserStart()
  for i = useStartSlot, invenUseSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return false
        end
        local _itemKey = itemSSW:get()._key:get()
        if itemKey == _itemKey then
          local itemExpiration = itemWrapper:getExpirationDate()
          if nil ~= itemExpiration and false == itemExpiration:isIndefinite() then
            local remainTime = Int64toInt32(getLeftSecond_s64(itemExpiration))
            if remainTime <= 0 then
              return true
            else
              return false
            end
          end
        end
      end
    end
  end
  return false
end
function PaGlobal_DialogExchange_All:enchangeItemHaveCount(itemKey, enchantLevel)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local itemCount = 0
  local inventory = selfProxy:getInventory()
  local invenUseSize = getSelfPlayer():get():getInventorySlotCount(true)
  local useStartSlot = inventorySlotNoUserStart()
  for i = useStartSlot, invenUseSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper and itemKey == itemWrapper:get():getKey():getItemKey() then
        local itemCount_32 = Int64toInt32(itemWrapper:get():getCount_s64())
        if 0 == itemCount_32 then
          return itemCount_32
        end
        if false == itemWrapper:getStaticStatus():isStackable() then
          local itemEnchantlevel = itemWrapper:getStaticStatus():get()._key:getEnchantLevel()
          if -1 ~= enchantLevel and enchantLevel == itemEnchantlevel then
            itemCount = itemCount + itemCount_32
          end
        else
          itemCount = itemCount_32
          return itemCount
        end
      end
    end
  end
  return itemCount
end
function PaGlobal_DialogExchange_All:sealedItemCheck(itemKey)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local inventory = selfProxy:getInventory()
  local invenSize = getSelfPlayer():get():getInventorySlotCount(true)
  for i = 1, invenSize - 1 do
    if not inventory:empty(i) then
      local itemWrapper = getInventoryItem(i)
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return false
        end
        local _itemKey = itemSSW:get()._key:get()
        if itemKey == _itemKey then
          if true == itemWrapper:isSealed() then
            return true
          else
            return false
          end
        end
      end
    end
  end
  return false
end
