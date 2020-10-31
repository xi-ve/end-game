function PaGlobal_Guild_Manufacture_All:initialize()
  if true == PaGlobal_Guild_Manufacture_All._initialize or nil == Panel_Guild_Manufacture_All then
    return
  end
  self._ui.stc_topArea = UI.getChildControl(Panel_Guild_Manufacture_All, "Static_TopArea")
  self._ui.txt_subTitle = UI.getChildControl(self._ui.stc_topArea, "StaticText_SubTitle")
  self._ui.stc_mainArea = UI.getChildControl(Panel_Guild_Manufacture_All, "Static_MainArea")
  self._ui.stc_slotBG = UI.getChildControl(self._ui.stc_mainArea, "Static_ManufactureSlotBG_0")
  PaGlobal_Guild_Manufacture_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Guild_Manufacture_All:setDefaultData()
  PaGlobal_Guild_Manufacture_All:registEventHandler()
  PaGlobal_Guild_Manufacture_All:switchPlatform()
  PaGlobal_Guild_Manufacture_All:validate()
  PaGlobal_Guild_Manufacture_All._initialize = true
end
function PaGlobal_Guild_Manufacture_All:registEventHandler()
  registerEvent("FromClient_Guild_Manufacture_Refresh", "FromClient_Guild_Manufacture_All_Refresh")
  registerEvent("FromClient_Guild_Manufacture_CompletePrice", "FromClient_Guild_Manufacture_All_CompletePrice")
end
function PaGlobal_Guild_Manufacture_All:setDefaultData()
  for ii = 0, __eGuildManufactureProductItemCount - 1 do
    local slot = {
      _backGround = nil,
      _productItemEnchantKey = nil,
      _productItemCount_s64 = nil,
      [__eGuildManufactureStateNone] = {
        _backGround = nil,
        _productSlot = nil,
        _productItemName = nil,
        _noMakeText = nil,
        _selectButton = nil,
        _setButton = nil
      },
      [__eGuildManufactureStateProceeding] = {
        _backGround = nil,
        _productSlot = nil,
        _productItemName = nil,
        _productItemCount = nil,
        _startButton = nil,
        _deleteButton = nil,
        _requiredSlot = Array.new(),
        _requiredItem = Array.new()
      },
      [__eGuildManufactureStateCreating] = {
        _backGround = nil,
        _productSlot = nil,
        _productItemName = nil,
        _productItemCount = nil,
        _completeDate = nil
      },
      [__eGuildManufactureStateComplete] = {
        _backGround = nil,
        _productSlot = nil,
        _productItemName = nil,
        _productItemCount = nil,
        _receiveButton = nil
      }
    }
    slot._backGround = UI.cloneControl(self._ui.stc_slotBG, self._ui.stc_mainArea, "Static_ManufactureSlot_" .. ii)
    slot[__eGuildManufactureStateNone]._backGround = UI.getChildControl(slot._backGround, "Static_NoneSelectBG")
    slot[__eGuildManufactureStateProceeding]._backGround = UI.getChildControl(slot._backGround, "Static_SelectBG")
    slot[__eGuildManufactureStateCreating]._backGround = UI.getChildControl(slot._backGround, "Static_ReadyBG")
    slot[__eGuildManufactureStateComplete]._backGround = UI.getChildControl(slot._backGround, "Static_CompleteBG")
    function slot:SetShow(isShow)
      slot[__eGuildManufactureStateNone]._backGround:SetShow(isShow)
      slot[__eGuildManufactureStateProceeding]._backGround:SetShow(isShow)
      slot[__eGuildManufactureStateCreating]._backGround:SetShow(isShow)
      slot[__eGuildManufactureStateComplete]._backGround:SetShow(isShow)
    end
    local noneSlot = slot[__eGuildManufactureStateNone]
    local tempProductSlot0 = {}
    tempProductSlot0.bg = UI.getChildControl(noneSlot._backGround, "Static_Result_IconBG")
    SlotItem.new(tempProductSlot0, "ProductItemIcon_" .. ii, ii, tempProductSlot0.bg, self._slotConfig)
    tempProductSlot0:createChild()
    tempProductSlot0.icon:SetPosX(13)
    tempProductSlot0.icon:SetPosY(13)
    if true == PaGlobal_Guild_Manufacture_All._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        tempProductSlot0.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip_ForConsole(" .. ii .. ")")
      else
        tempProductSlot0.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateNone)")
        tempProductSlot0.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
      end
    else
      tempProductSlot0.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateNone)")
      tempProductSlot0.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
      tempProductSlot0.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_Guild_Manufacture_All_ItemUnSet(" .. ii .. ")")
    end
    noneSlot._productSlot = tempProductSlot0
    noneSlot._productItemName = UI.getChildControl(noneSlot._backGround, "Static_Result_Name")
    noneSlot._noMakeText = UI.getChildControl(noneSlot._backGround, "StaticText_NoMake")
    noneSlot._selectButton = UI.getChildControl(noneSlot._backGround, "Button_ManufactureSelect")
    noneSlot._setButton = UI.getChildControl(noneSlot._backGround, "Button_ManufactureStart")
    noneSlot._noMakeText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_MANUFACTURE_NONESTATE"))
    noneSlot._noMakeText:SetShow(true)
    noneSlot._selectButton:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Manufacture_All_Select(" .. ii .. ")")
    noneSlot._setButton:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Manufacture_All_Set(" .. ii .. ")")
    local proceedingSlot = slot[__eGuildManufactureStateProceeding]
    local tempProductSlot = {}
    tempProductSlot.bg = UI.getChildControl(proceedingSlot._backGround, "Static_ResultSlot")
    SlotItem.new(tempProductSlot, "ProductItemIcon_" .. ii, ii, tempProductSlot.bg, self._slotConfig)
    tempProductSlot:createChild()
    if true == PaGlobal_Guild_Manufacture_All._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        tempProductSlot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip_ForConsole(" .. ii .. ")")
      else
        tempProductSlot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateProceeding)")
        tempProductSlot.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
      end
    else
      tempProductSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateProceeding)")
      tempProductSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
    end
    proceedingSlot._productSlot = tempProductSlot
    proceedingSlot._productItemName = UI.getChildControl(proceedingSlot._backGround, "StaticText_ItemName")
    proceedingSlot._productItemCount = UI.getChildControl(proceedingSlot._backGround, "StaticText_ItemCount")
    proceedingSlot._startButton = UI.getChildControl(proceedingSlot._backGround, "Button_ManufactureStart")
    proceedingSlot._deleteButton = UI.getChildControl(proceedingSlot._backGround, "Button_ReSelect")
    proceedingSlot._startButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Manufacture_All_Start(" .. ii .. ")")
    proceedingSlot._deleteButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Manufacture_All_Delete(" .. ii .. ")")
    local tempMaterialSlot = UI.getChildControl(proceedingSlot._backGround, "Static_SlotBG")
    local tempMaterialCount = UI.getChildControl(proceedingSlot._backGround, "StaticText_MaterialCount")
    local columnCount = 3
    local slotGapX = 30
    local slotGapY = 30
    local slotSizeX = tempMaterialSlot:GetSizeX()
    local slotSizeY = tempMaterialSlot:GetSizeY()
    local startPosX = (proceedingSlot._backGround:GetSizeX() - columnCount * slotSizeX - (columnCount - 1) * slotGapX) * 0.5
    local startPosY = tempMaterialSlot:GetPosY()
    for jj = 0, __eGuildManufactureRequiredItemCount - 1 do
      local tempSlot = {}
      tempSlot.bg = UI.createControl(__ePAUIControl_Static, proceedingSlot._backGround, "Static_StuffItemBG" .. jj + 1)
      CopyBaseProperty(tempMaterialSlot, tempSlot.bg)
      tempSlot.bg:SetShow(true)
      SlotItem.new(tempSlot, "RequiredItemIcon_" .. ii .. "_" .. jj, jj, tempSlot.bg, self._slotConfig)
      tempSlot:createChild()
      tempSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Manufacture_All_UpdateItem(" .. ii .. "," .. jj .. ")")
      if true == PaGlobal_Guild_Manufacture_All._isConsole then
        if true == _ContentsGroup_RenewUI_Tooltip then
          tempSlot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip_ForConsole(" .. ii .. ", " .. jj .. ")")
        else
          tempProductSlot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip(true," .. ii .. ", " .. jj .. ")")
          tempProductSlot.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip(false)")
        end
      else
        tempSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip(true," .. ii .. ", " .. jj .. ")")
        tempSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_RequireItemTooltip(false)")
      end
      proceedingSlot._requiredSlot[jj] = tempSlot
      local tempItemInfo = {
        enchantKey = nil,
        countText = nil,
        countValue_s64 = nil
      }
      tempItemInfo.countText = UI.createControl(__ePAUIControl_StaticText, proceedingSlot._backGround, "Static_StuffItemCount" .. jj + 1)
      CopyBaseProperty(tempMaterialCount, tempItemInfo.countText)
      tempItemInfo.countText:SetShow(true)
      proceedingSlot._requiredItem[jj] = tempItemInfo
      local row = jj % columnCount
      local col = math.floor(jj / columnCount)
      tempSlot.bg:SetPosX(startPosX + (slotSizeX + slotGapX) * row)
      tempSlot.bg:SetPosY(startPosY + (slotSizeY + slotGapY) * col)
      tempItemInfo.countText:SetPosX(tempSlot.bg:GetPosX())
      tempItemInfo.countText:SetPosY(tempSlot.bg:GetPosY() + slotSizeY)
    end
    tempMaterialSlot:SetShow(false)
    tempMaterialCount:SetShow(false)
    local readySlot = slot[__eGuildManufactureStateCreating]
    local tempProductSlot2 = {}
    tempProductSlot2.bg = UI.getChildControl(readySlot._backGround, "Static_Result_IconBG")
    SlotItem.new(tempProductSlot2, "ProductItemIcon_" .. ii, ii, tempProductSlot2.bg, self._slotConfig)
    tempProductSlot2:createChild()
    tempProductSlot2.icon:SetPosX(13)
    tempProductSlot2.icon:SetPosY(13)
    if true == PaGlobal_Guild_Manufacture_All._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        tempProductSlot2.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip_ForConsole(" .. ii .. ")")
      else
        tempProductSlot2.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateCreating)")
        tempProductSlot2.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
      end
    else
      tempProductSlot2.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateCreating)")
      tempProductSlot2.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
    end
    readySlot._productSlot = tempProductSlot2
    readySlot._productItemName = UI.getChildControl(readySlot._backGround, "Static_Result_Name")
    readySlot._productItemCount = UI.getChildControl(readySlot._backGround, "StaticText_Count")
    readySlot._completeDate = UI.getChildControl(readySlot._backGround, "StaticText_CompleteTime")
    readySlot._completeDate:SetTextMode(__eTextMode_AutoWrap)
    local completeSlot = slot[__eGuildManufactureStateComplete]
    local tempProductSlot3 = {}
    tempProductSlot3.bg = UI.getChildControl(completeSlot._backGround, "Static_Result_IconBG")
    SlotItem.new(tempProductSlot3, "ProductItemIcon_" .. ii, ii, tempProductSlot3.bg, self._slotConfig)
    tempProductSlot3:createChild()
    tempProductSlot3.icon:SetPosX(13)
    tempProductSlot3.icon:SetPosY(13)
    if true == PaGlobal_Guild_Manufacture_All._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        tempProductSlot3.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip_ForConsole(" .. ii .. ")")
      else
        tempProductSlot3.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateCreating)")
        tempProductSlot3.bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
      end
    else
      tempProductSlot3.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(true," .. ii .. ", __eGuildManufactureStateComplete)")
      tempProductSlot3.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Manufacture_All_ProductItemTooltip(false)")
    end
    completeSlot._productSlot = tempProductSlot3
    completeSlot._productItemName = UI.getChildControl(completeSlot._backGround, "Static_Result_Name")
    completeSlot._productItemCount = UI.getChildControl(completeSlot._backGround, "StaticText_Count")
    completeSlot._resultMessage = UI.getChildControl(completeSlot._backGround, "StaticText_ResultMessage")
    completeSlot._receiveButton = UI.getChildControl(completeSlot._backGround, "Button_Receive")
    completeSlot._resultMessage:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_MANUFACTURE_COMPLETE_TEXT"))
    completeSlot._receiveButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_Manufacture_All_Receive(" .. ii .. ")")
    local gap = 10
    slot._backGround:SetPosX(ii * self._ui.stc_slotBG:GetSizeX() + 15 + gap * ii)
    self._slot[ii] = slot
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  if true == selfProxy:get():isGuildMember() then
    for ii = 0, __eGuildManufactureProductItemCount - 1 do
      PaGlobal_Guild_Manufacture_All:refreshState(ii)
    end
  end
  self._ui.stc_slotBG:SetShow(false)
end
function PaGlobal_Guild_Manufacture_All:switchPlatform()
end
function PaGlobal_Guild_Manufacture_All:prepareOpen()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Manufacture_All:open()
end
function PaGlobal_Guild_Manufacture_All:open()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_Manufacture_All:SetShow(true)
end
function PaGlobal_Guild_Manufacture_All:prepareClose()
  if nil == Panel_GuildMain_All then
    return
  end
  PaGlobal_Guild_Manufacture_All:close()
end
function PaGlobal_Guild_Manufacture_All:close()
  if nil == Panel_GuildMain_All then
    return
  end
  Panel_Guild_Manufacture_All:SetShow(false)
end
function PaGlobal_Guild_Manufacture_All:validate()
  self._ui.stc_topArea:isValidate()
  self._ui.txt_subTitle:isValidate()
  self._ui.stc_mainArea:isValidate()
  self._ui.stc_slotBG:isValidate()
end
function PaGlobal_Guild_Manufacture_All:refreshState(index)
  self._slot[index]:SetShow(false)
  local infoWrapper = ToClient_GetGuildManufactureInfoWrapper(index)
  if nil ~= infoWrapper then
    local state = infoWrapper:getState()
    if __eGuildManufactureStateNone == state then
      self:__updateNoneState(index, infoWrapper)
    elseif __eGuildManufactureStateProceeding == state then
      self:__updateProceedingState(index, infoWrapper, false)
    elseif __eGuildManufactureStateReady == state then
      self:__updateProceedingState(index, infoWrapper, true)
    elseif __eGuildManufactureStateCreating == state then
      self:__updateCreatingState(index, infoWrapper)
    elseif __eGuildManufactureStateComplete == state then
      self:__updateCompleteState(index, infoWrapper)
    else
      _PA_ASSERT(false, "PaGlobal_Guild_Manufacture_All:refresh() \236\151\134\235\138\148 state \234\176\146 \236\158\133\235\139\136\235\139\164. %s", state)
    end
  else
    self._slot[index][__eGuildManufactureStateNone]._backGround:SetShow(true)
  end
end
function PaGlobal_Guild_Manufacture_All:__updateNoneState(index, infoWrapper)
  self._slot[index]._productItemEnchantKey = nil
  self._slot[index]._productItemCount_s64 = nil
  local slot = self._slot[index][__eGuildManufactureStateNone]
  slot._backGround:SetShow(true)
  slot._productSlot.bg:SetShow(false)
  slot._productItemName:SetShow(false)
  slot._setButton:SetShow(false)
  slot._noMakeText:SetShow(true)
  slot._productSlot:clearItem()
end
function PaGlobal_Guild_Manufacture_All:__updateProceedingState(index, infoWrapper, isReady)
  local itemEnchantKey = infoWrapper:getProductItemEnchantKey()
  local itemStatic = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemStatic then
    return
  end
  local guildManufactureStaticWrapper = ToClient_GetGuildManufactureStaticStatusWrapper(itemEnchantKey)
  if nil == guildManufactureStaticWrapper then
    return
  end
  self._slot[index]._productItemEnchantKey = itemEnchantKey
  self._slot[index]._productItemCount_s64 = infoWrapper:getProductItemCount()
  local slot = self._slot[index][__eGuildManufactureStateProceeding]
  slot._productSlot:setItemByStaticStatus(itemStatic)
  slot._productItemName:SetText(itemStatic:getName())
  slot._productItemCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. tostring(infoWrapper:getProductItemCount()))
  for ii = 0, __eGuildManufactureRequiredItemCount - 1 do
    local requiredItemEnchantKey = infoWrapper:getRequiredItemEnchantKey(ii)
    local requiredItemStatic = getItemEnchantStaticStatus(requiredItemEnchantKey)
    local itemCount_s64 = infoWrapper:getRequiredItemCount(ii)
    local itemMaxCount_s64 = guildManufactureStaticWrapper:getRequiredItemCount(ii) * self._slot[index]._productItemCount_s64
    if nil ~= requiredItemStatic then
      slot._requiredSlot[ii]:setItemByStaticStatus(requiredItemStatic)
      slot._requiredItem[ii].countText:SetText(tostring(itemMaxCount_s64 - itemCount_s64) .. "/" .. tostring(itemMaxCount_s64))
    else
      slot._requiredSlot[ii]:clearItem()
      slot._requiredItem[ii].countText:SetText("")
    end
    slot._requiredItem[ii].enchantKey = requiredItemEnchantKey
    slot._requiredItem[ii].countValue_s64 = itemCount_s64
    if 0 >= Int64toInt32(itemCount_s64) then
      slot._requiredSlot[ii].bg:SetEnable(false)
      slot._requiredSlot[ii].icon:SetMonoTone(true)
    else
      slot._requiredSlot[ii].bg:SetEnable(true)
      slot._requiredSlot[ii].icon:SetMonoTone(false)
    end
  end
  if true == isReady then
    slot._startButton:SetEnable(true)
    slot._startButton:SetMonoTone(false)
  else
    slot._startButton:SetEnable(false)
    slot._startButton:SetMonoTone(true)
  end
  slot._backGround:SetShow(true)
end
function PaGlobal_Guild_Manufacture_All:__updateCreatingState(index, infoWrapper)
  local itemEnchantKey = infoWrapper:getProductItemEnchantKey()
  local itemStatic = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemStatic then
    return
  end
  self._slot[index]._productItemEnchantKey = itemEnchantKey
  self._slot[index]._productItemCount_s64 = infoWrapper:getProductItemCount()
  local slot = self._slot[index][__eGuildManufactureStateCreating]
  slot._productSlot:setItemByStaticStatus(itemStatic)
  slot._productItemName:SetText(itemStatic:getName())
  slot._productItemCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. tostring(infoWrapper:getProductItemCount()))
  local time_s64 = PATime(infoWrapper:getCompleteDate())
  local completeDate = string.format(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_TIME_FORMAT_STR"), time_s64:GetYear(), time_s64:GetMonth(), time_s64:GetDay(), time_s64:GetHour(), time_s64:GetMinute())
  slot._completeDate:SetText(completeDate)
  slot._backGround:SetShow(true)
end
function PaGlobal_Guild_Manufacture_All:__updateCompleteState(index, infoWrapper)
  local itemEnchantKey = infoWrapper:getProductItemEnchantKey()
  local itemStatic = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemStatic then
    return
  end
  self._slot[index]._productItemEnchantKey = itemEnchantKey
  self._slot[index]._productItemCount_s64 = infoWrapper:getProductItemCount()
  local slot = self._slot[index][__eGuildManufactureStateComplete]
  slot._productSlot:setItemByStaticStatus(itemStatic)
  slot._productItemName:SetText(itemStatic:getName())
  slot._productItemCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. tostring(infoWrapper:getProductItemCount()))
  slot._backGround:SetShow(true)
end
