function PaGlobal_FairyTierUpgrade_All:initialize()
  if true == PaGlobal_FairyTierUpgrade_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairyTierUpgrade_All, "Static_TitleBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Win_Close")
  self._ui.stc_MainBG = UI.getChildControl(Panel_Window_FairyTierUpgrade_All, "Static_MainBG")
  self._ui_pc.btn_Detail_pc = UI.getChildControl(self._ui.stc_MainBG, "Button_DetailGuide_PC")
  self._ui.stc_FairyBG = UI.getChildControl(self._ui.stc_MainBG, "Static_FairyBG")
  self._ui.stc_FairyIcon = UI.getChildControl(self._ui.stc_FairyBG, "Static_FairyIcon")
  for i = 1, self._rimCount do
    self._rim[i] = {}
    self._rim[i]._uiControl = UI.getChildControl(self._ui.stc_FairyBG, "Static_Seq" .. tostring(i))
    self._rim[i]._currentDegree = 0
    self._rim[i]._rotateTarget = 0
    self._rim[i]._accel = 0
    self._rim[i]._aniValue = {}
    self._rim[i]._state = self._RIM_ANI_STATE.IDLE
  end
  self._ui.txt_Percentage = UI.getChildControl(self._ui.stc_MainBG, "StaticText_SuccessChance")
  self._ui.stc_Blcok_Sucess = UI.getChildControl(self._ui.stc_MainBG, "Static_Block_Success")
  self._ui.stc_Blcok_Fail = UI.getChildControl(self._ui.stc_MainBG, "Static_Block_Fail")
  self._ui.stc_Blcok_TierUpgrade = UI.getChildControl(self._ui.stc_MainBG, "Static_Block_TierUpgrade")
  self._ui.stc_HoneyGroup = UI.getChildControl(Panel_Window_FairyTierUpgrade_All, "Static_HoneyliquorGroup")
  self._ui.stc_HoneyBG = UI.getChildControl(self._ui.stc_HoneyGroup, "Static_HoneyBG")
  self._rdo_Honey = {}
  for i = 1, self._HoenyCount do
    self._rdo_Honey[i] = {}
    self._rdo_Honey[i]._uiControl = UI.getChildControl(self._ui.stc_HoneyBG, "RadioButton_ButtonBG" .. tostring(i))
    self._rdo_Honey[i].iconBG = UI.getChildControl(self._rdo_Honey[i]._uiControl, "Static_ItemIconBG")
    self._rdo_Honey[i].icon = UI.getChildControl(self._rdo_Honey[i]._uiControl, "Static_ItemIcon")
    self._rdo_Honey[i].name = UI.getChildControl(self._rdo_Honey[i]._uiControl, "StaticText_ItemName")
    self._rdo_Honey[i].count = UI.getChildControl(self._rdo_Honey[i]._uiControl, "StaticText_ItemCount")
  end
  self._ui.stc_SliderBG = UI.getChildControl(self._ui.stc_HoneyGroup, "Static_ItemSlider")
  self._ui.txt_SelectName = UI.getChildControl(self._ui.stc_SliderBG, "StaticText_SliderTitle")
  self._ui.txt_SelectCount = UI.getChildControl(self._ui.stc_SliderBG, "HpSlider_CurrentValue")
  self._ui.progress2_Honey = UI.getChildControl(self._ui.stc_SliderBG, "Progress2_Hp")
  self._ui.txt_MinCount = UI.getChildControl(self._ui.stc_SliderBG, "StaticText_ItemCount_MIN")
  self._ui.txt_MaxCount = UI.getChildControl(self._ui.stc_SliderBG, "StaticText_ItemCount_MAX")
  self._ui_pc.slider_Honey_pc = UI.getChildControl(self._ui.stc_SliderBG, "Slider_HpSlider_PC")
  self._ui_pc.btnSlider_Honey_pc = UI.getChildControl(self._ui_pc.slider_Honey_pc, "Slider_Hp_Button_PC")
  self._ui_console.slider_Honey_console = UI.getChildControl(self._ui.stc_SliderBG, "Slider_HpSlider_Console")
  self._ui.stc_BottomButtonBG = UI.getChildControl(Panel_Window_FairyTierUpgrade_All, "Static_BottomBTNGroup")
  self._ui_pc.btn_Upgrade_pc = UI.getChildControl(self._ui.stc_BottomButtonBG, "Button_Upgrade_PC")
  self._ui_console.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_BottomButtonBG, "StaticText_Upgrade_Console")
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_Window_FairyTierUpgrade_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Detail")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Select")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Cancle")
  self._keyguide = {
    self._ui_console.stc_KeyGuide_X,
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.slider_Honey = self._ui_pc.slider_Honey_pc
  else
    self._ui.slider_Honey = self._ui_console.slider_Honey_console
  end
  self:SetUiSetting()
  self:AlignKeyGuide()
  PaGlobal_FairyTierUpgrade_All:registEventHandler()
  PaGlobal_FairyTierUpgrade_All:validate()
  PaGlobal_FairyTierUpgrade_All._initialize = true
end
function PaGlobal_FairyTierUpgrade_All:SetUiSetting()
  if nil == Panel_FairyInfo_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  self._ui.stc_BottomKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
end
function PaGlobal_FairyTierUpgrade_All:AlignKeyGuide()
  if nil == Panel_FairyInfo_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui_console.stc_KeyGuide_Y
  }, self._ui.stc_BottomButtonBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_FairyTierUpgrade_All:registEventHandler()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyTierUpgrade_Close_All()")
  self._ui.slider_Honey:addInputEvent("Mouse_LPress", "InputMLPress_FairyTierUpgrade_SliderUpdate_All()")
  self._ui_pc.btnSlider_Honey_pc:addInputEvent("Mouse_LPress", "InputMLPress_FairyTierUpgrade_SliderUpdate_All()")
  self._ui_pc.btn_Upgrade_pc:addInputEvent("Mouse_LUp", "InputMLClick_FairyTierUpgrade_TierUpgrade_All()")
  self._ui_pc.btn_Detail_pc:addInputEvent("Mouse_On", "InputMOn_FairyTierUpgrade_ShowToolTip_All(true)")
  self._ui_pc.btn_Detail_pc:addInputEvent("Mouse_Out", "InputMOn_FairyTierUpgrade_ShowToolTip_All(false)")
  if true == _ContentsGroup_UsePadSnapping then
  end
  registerEvent("FromClient_FairyTierUpgrade_Success", "FromClient_FairyTierUpgrade_TierUpSuccess")
  registerEvent("FromClient_FairyTierUpgrade_Failed", "FromClient_FairyTierUpgrade_TierUpFailed")
  Panel_Window_FairyTierUpgrade_All:RegisterUpdateFunc("FromClient_FairyTierUpgrade_UpdatePerFrame")
end
function PaGlobal_FairyTierUpgrade_All:prepareOpen(PositionReset)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ClothInventory_All_Close()
  else
    ClothInventory_Close()
  end
  if nil ~= Panel_Window_FairyGrowth_All and true == Panel_Window_FairyGrowth_All:GetShow() then
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  if true == Panel_Window_FairyTierUpgrade_All:GetShow() then
    return
  end
  if false == PaGlobal_FairyInfo_EnableFairyUpgrade_All() then
    local contentString = ""
    if false == PaGlobal_FairyInfo_isMaxLevel_All() then
      contentString = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_UPGRADE_CHECK_LEVEL_MSG")
    else
      contentString = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_UPGRADE_MSG")
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_TITLE"),
      content = contentString,
      functionApply = function()
      end,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if 0 == PaGlobal_FairyInfo_getUpgradeStack_All() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_NOTE_STACK"),
      functionApply = function()
      end,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if 0 < ToClient_getFairyUnsealedList() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_NOTE_UNSEALED"),
      functionApply = function()
      end,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if PaGlobal_FairyInfo_isMaxTier_All() then
    return
  end
  if true == PositionReset then
    self:setPosition()
  end
  self._ui.stc_FairyIcon:SetShow(true)
  self._ui.stc_FairyIcon:ChangeTextureInfoName(PaGlobal_FairyInfo_GetIconPath_All())
  self._result = 0
  self:clearFeedItem()
  for i = 1, self._rimCount do
    self._rim[i]._currentDegree = math.random(-180, 180)
    self._rim[i]._rotateTarget = self._rim[i]._currentDegree
    self._rim[i]._uiControl:SetRotate(math.rad(self._rim[i]._currentDegree))
    self._rim[i]._accel = 0
    self._rim[i]._state = self._RIM_ANI_STATE.IDLE
    self:initIdleAnimation(self._rim[i])
  end
  self._maxSuccessRate = ToClient_getFairyTierUpgradeMaxRate(PaGlobal_FairyInfo_FairyTier_All())
  self._ui_pc.btn_Upgrade_pc:SetMonoTone(true)
  self._ui_pc.btn_Upgrade_pc:SetIgnore(true)
  self._ui_pc.btnSlider_Honey_pc:SetIgnore(true)
  self:update()
  PaGlobal_FairyTierUpgrade_All:open()
end
function PaGlobal_FairyTierUpgrade_All:initIdleAnimation(rim)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  rim._aniValue[1] = math.random(0, 2 * math.pi)
  rim._aniValue[2] = math.random(2, 4)
  rim._aniValue[3] = math.random(3, 7)
end
function PaGlobal_FairyTierUpgrade_All:idleAnimation(rim, index, deltaTime)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  local acc = rim._rotateTarget - rim._currentDegree
  if 0.1 < math.abs(acc) then
    rim._accel = self:limitAcceleration(acc, 40) * self._rimSpeed
    rim._currentDegree = self:negate360Turn(rim._currentDegree + rim._accel * deltaTime)
    rim._uiControl:SetRotate(math.rad(rim._currentDegree))
  else
    rim._rotateTarget = rim._currentDegree
    if 2 * math.pi < rim._aniValue[1] then
      rim._aniValue[1] = 0
      self:initIdleAnimation(rim)
    end
    rim._aniValue[1] = rim._aniValue[1] + rim._aniValue[2] * deltaTime
    rim._accel = math.sin(rim._aniValue[1]) * rim._aniValue[3]
    rim._currentDegree = self:negate360Turn(rim._currentDegree + rim._accel * deltaTime)
    rim._uiControl:SetRotate(math.rad(rim._currentDegree))
  end
end
function PaGlobal_FairyTierUpgrade_All:open()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  Panel_Window_FairyTierUpgrade_All:SetShow(true)
end
function PaGlobal_FairyTierUpgrade_All:prepareClose()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self:clearFeedItem()
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  TooltipSimple_Hide()
  PaGlobal_FairyTierUpgrade_All:close()
end
function PaGlobal_FairyTierUpgrade_All:close()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  Panel_Window_FairyTierUpgrade_All:SetShow(false)
end
function PaGlobal_FairyTierUpgrade_All:update()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self:updateHoneyData()
  self:updateHoneyButton()
  self:updateKeyGuide()
end
function PaGlobal_FairyTierUpgrade_All:updateKeyGuide()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if _ContentsGroup_UsePadSnapping then
    self._ui_console.stc_KeyGuide_X:SetShow(true)
    self._ui_console.stc_KeyGuide_Y:SetShow(0 ~= PaGlobal_FairyInfo_getUpgradeStack_All())
    self._ui_console.stc_KeyGuide_A:SetShow(0 ~= PaGlobal_FairyInfo_getUpgradeStack_All())
    Panel_Window_FairyTierUpgrade_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLClick_FairyTierUpgrade_TierUpgrade_All()")
    Panel_Window_FairyTierUpgrade_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMOn_FairyTierUpgrade_ShowToolTip_All(true)")
  else
    self._ui_pc.btn_Upgrade_pc:SetShow(true)
  end
  self:AlignKeyGuide()
end
function PaGlobal_FairyTierUpgrade_All:validate()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.stc_FairyBG:isValidate()
  self._ui.stc_FairyIcon:isValidate()
  for i = 1, self._rimCount do
    self._rim[i]._uiControl:isValidate()
  end
  self._ui.txt_Percentage:isValidate()
  self._ui.stc_Blcok_Sucess:isValidate()
  self._ui.stc_Blcok_Fail:isValidate()
  self._ui.stc_Blcok_TierUpgrade:isValidate()
  self._ui_pc.btn_Detail_pc:isValidate()
  self._ui.stc_HoneyGroup:isValidate()
  self._ui.stc_HoneyBG:isValidate()
  for i = 1, self._HoenyCount do
    self._rdo_Honey[i]._uiControl:isValidate()
    self._rdo_Honey[i].iconBG:isValidate()
    self._rdo_Honey[i].icon:isValidate()
    self._rdo_Honey[i].name:isValidate()
    self._rdo_Honey[i].count:isValidate()
  end
  self._ui.stc_SliderBG:isValidate()
  self._ui.txt_SelectName:isValidate()
  self._ui.txt_SelectCount:isValidate()
  self._ui.progress2_Honey:isValidate()
  self._ui.txt_MinCount:isValidate()
  self._ui.txt_MaxCount:isValidate()
  self._ui_pc.slider_Honey_pc:isValidate()
  self._ui_console.slider_Honey_console:isValidate()
  self._ui.stc_BottomButtonBG:isValidate()
  self._ui_pc.btn_Upgrade_pc:isValidate()
  self._ui_console.stc_KeyGuide_Y:isValidate()
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_X:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairyTierUpgrade_All:setPosition()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  Panel_Window_FairyTierUpgrade_All:ComputePos()
end
function PaGlobal_FairyTierUpgrade_All:clearFeedItem()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._currentItemKey = nil
  self._currentItemWrapper = nil
  self._currentItemSSW = nil
  self._currentItemStackCount = 0
  self._currentItemWhereType = nil
  self._currentItemSlotNo = nil
  self._currentItemClickIndex = -1
  self:setRimRotation(0, 0)
  self._isResultAnimating = false
  self._ui.txt_Percentage:SetShow(true)
  self._ui.txt_Percentage:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_ITEMSELECT_TEXT"))
  for i = 1, self._HoenyCount do
    self._rdo_Honey[i]._uiControl:SetIgnore(true)
    self._rdo_Honey[i].icon:SetShow(false)
    self._rdo_Honey[i].name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_NO_HAVE_ITEM"))
    self._rdo_Honey[i].count:SetText("")
  end
  self._ui.txt_SelectName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_ITEMSELECT_TEXT"))
  self._ui.txt_SelectCount:SetShow(false)
  self._ui.txt_MinCount:SetShow(false)
  self._ui.txt_MaxCount:SetShow(false)
  self._ui.slider_Honey:SetIgnore(true)
  self:setSlider(0)
end
function PaGlobal_FairyTierUpgrade_All:setSlider(fValue)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._ui.slider_Honey:SetControlPos(fValue)
  self._ui.progress2_Honey:SetProgressRate(fValue)
end
function PaGlobal_FairyTierUpgrade_All:updateHoneyData()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local cashInvenSize = selfPlayer:getInventorySlotCount(true)
  self._itemList = {}
  self._currentItemCount = 0
  local isItemFind = false
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenIdx)
    if nil ~= itemWrapper and false == self:filterForTierUpgrade(invenIdx, false, CppEnums.ItemWhereType.eInventory) then
      self._currentItemCount = self._currentItemCount + 1
      self._itemList[self._currentItemCount] = {}
      self._itemList[self._currentItemCount].slotNo = invenIdx
      self._itemList[self._currentItemCount].whereType = CppEnums.ItemWhereType.eInventory
      isItemFind = true
    end
  end
  if false == isItemFind then
    self._currentItemCount = self._currentItemCount + 1
    self._itemList[self._currentItemCount] = {}
    self._itemList[self._currentItemCount].slotNo = nil
    self._itemList[self._currentItemCount].whereType = nil
  else
    isItemFind = false
  end
  for invenIdx = 0, cashInvenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, invenIdx)
    if nil ~= itemWrapper and false == self:filterForTierUpgrade(invenIdx, false, CppEnums.ItemWhereType.eCashInventory) then
      self._currentItemCount = self._currentItemCount + 1
      self._itemList[self._currentItemCount] = {}
      self._itemList[self._currentItemCount].slotNo = invenIdx
      self._itemList[self._currentItemCount].whereType = CppEnums.ItemWhereType.eCashInventory
      isItemFind = true
    end
  end
  if false == isItemFind then
    self._currentItemCount = self._currentItemCount + 1
    self._itemList[self._currentItemCount] = {}
    self._itemList[self._currentItemCount].slotNo = nil
    self._itemList[self._currentItemCount].whereType = nil
  end
  for i = 1, self._currentItemCount do
    if nil == self._itemList[i].slotNo then
      self._rdo_Honey[i].count:SetText(Int64toInt32(0))
    else
      local slotNo = self._itemList[i].slotNo
      local whereType = self._itemList[i].whereType
      local itemWrapper = getInventoryItemByType(whereType, slotNo)
      self._rdo_Honey[i].count:SetText(Int64toInt32(itemWrapper:getCount()))
    end
  end
end
function PaGlobal_FairyTierUpgrade_All:updateHoneyButton()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(54030))
  if nil == itemSSW then
    return
  end
  local itemName = itemSSW:getName()
  local iconPath = itemSSW:getIconPath()
  self._rdo_Honey[1].name:SetTextMode(__eTextMode_LimitText)
  self._rdo_Honey[1].name:SetText(itemName)
  self._rdo_Honey[1].icon:SetShow(true)
  self._rdo_Honey[1].icon:ChangeTextureInfoName("Icon/" .. iconPath)
  itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(18448))
  if nil == itemSSW then
    return
  end
  itemName = itemSSW:getName()
  iconPath = itemSSW:getIconPath()
  self._rdo_Honey[2].name:SetTextMode(__eTextMode_LimitText)
  self._rdo_Honey[2].name:SetText(itemName)
  self._rdo_Honey[2].icon:SetShow(true)
  self._rdo_Honey[2].icon:ChangeTextureInfoName("Icon/" .. iconPath)
  for i = 1, self._currentItemCount do
    self._rdo_Honey[i].icon:SetIgnore(true)
    self._rdo_Honey[i].iconBG:SetIgnore(true)
    self._rdo_Honey[i]._uiControl:SetIgnore(false)
    self._rdo_Honey[i]._uiControl:setRenderTexture(self._rdo_Honey[i]._uiControl:getBaseTexture())
    if 0 ~= PaGlobal_FairyInfo_getUpgradeStack_All() then
      self._rdo_Honey[i]._uiControl:addInputEvent("Mouse_LUp", "InputMLClick_FairyTierUpgrade_SelectHoney_All(" .. i .. ")")
    else
      self._rdo_Honey[i]._uiControl:addInputEvent("Mouse_LUp", "")
    end
    if false == _ContentsGroup_UsePadSnapping then
      self._rdo_Honey[i]._uiControl:addInputEvent("Mouse_On", "InputMOn_FairyTierUpgrade_ShowItemToolTip_All(" .. i .. ", true)")
      self._rdo_Honey[i]._uiControl:addInputEvent("Mouse_Out", "InputMOn_FairyTierUpgrade_ShowItemToolTip_All(" .. i .. ", false)")
    end
  end
end
function PaGlobal_FairyTierUpgrade_All:filterForTierUpgrade(slotNo, notUse_itemWrappers, whereType)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  if itemWrapper:isFairyTierUpgradeItem(PaGlobal_FairyInfo_FairyTier_All()) then
    return false
  else
    return true
  end
end
function PaGlobal_FairyTierUpgrade_All:selectHoney(index)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if nil == self._itemList[index].slotNo then
    if _ContentsGroup_UsePadSnapping then
      self._ui_console.stc_KeyGuide_Y:SetShow(false)
      Panel_Window_FairyTierUpgrade_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    else
      self._ui_pc.btn_Upgrade_pc:SetMonoTone(true)
      self._ui_pc.btn_Upgrade_pc:SetIgnore(true)
    end
    self._ui_pc.btnSlider_Honey_pc:SetIgnore(true)
    self._currentItemClickIndex = index
    self._ui.txt_SelectName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_ITEMSELECT_TEXT"))
    self._ui.txt_SelectCount:SetShow(false)
    self._ui.txt_MinCount:SetShow(false)
    self._ui.txt_MaxCount:SetShow(false)
    self._ui.slider_Honey:SetIgnore(true)
    self._currentItemStackCount = 0
    self:setSlider(0)
    return
  else
    if _ContentsGroup_UsePadSnapping then
      self._ui_console.stc_KeyGuide_Y:SetShow(true)
      Panel_Window_FairyTierUpgrade_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLClick_FairyTierUpgrade_TierUpgrade_All()")
    else
      self._ui_pc.btn_Upgrade_pc:SetMonoTone(false)
      self._ui_pc.btn_Upgrade_pc:SetIgnore(false)
    end
    self._ui_pc.btnSlider_Honey_pc:SetIgnore(false)
    self._currentItemClickIndex = index
  end
  local slotNo = self._itemList[index].slotNo
  local whereType = self._itemList[index].whereType
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  self._currentItemWrapper = itemWrapper
  self._currentItemSlotNo = slotNo
  self._currentItemKey = self._currentItemWrapper:get():getKey()
  if nil == self._currentItemKey then
    return
  end
  self._currentItemSSW = itemWrapper:getStaticStatus()
  local itemCount = itemWrapper:getCount()
  local itemName = self._currentItemSSW:getName()
  self._currentItemCountInInventory = Int64toInt32(itemCount)
  self._currentItemWhereType = whereType
  self._currentSuccessRate = ToClient_getFairyTierUpgradeRate(PaGlobal_FairyInfo_FairyTier_All(), self._currentItemKey)
  self._maxSubjectCount = math.floor(self._maxSuccessRate / self._currentSuccessRate)
  local availableSubjectCount = math.min(self._currentItemCountInInventory, self._maxSubjectCount)
  self._ui.txt_SelectName:SetText(tostring(itemName))
  self._ui.txt_SelectCount:SetShow(true)
  self._ui.txt_MinCount:SetShow(true)
  self._ui.txt_MaxCount:SetShow(true)
  self._ui.txt_MaxCount:SetText(availableSubjectCount)
  self._ui.slider_Honey:SetIgnore(false)
  self._currentItemStackCount = 1
  self:setSlider(0)
  self:updateSlider()
  self:updateKeyGuide()
end
function PaGlobal_FairyTierUpgrade_All:setSubjectItemCount(count)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._maxSubjectCount = math.floor(self._maxSuccessRate / self._currentSuccessRate)
  local availableSubjectCount = math.min(self._currentItemCountInInventory, self._maxSubjectCount)
  if count > availableSubjectCount then
    count = availableSubjectCount
  elseif count < 1 then
    count = 1
  end
  self._currentItemSSW = getItemEnchantStaticStatus(self._currentItemKey)
  self._currentItemStackCount = count
  self._ui.txt_SelectCount:SetText(count)
  local successPercentStr = tostring(self:decimalRoundForPercentValue(self._currentSuccessRate / 10000 * self._currentItemStackCount))
  if self._maxSubjectCount == self._currentItemStackCount then
    successPercentStr = "100"
  end
  successPercentStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_TIERUPGRADE_PERCENT") .. " : " .. successPercentStr .. "%"
  self._ui.txt_Percentage:SetText(successPercentStr)
  self._ui.txt_Percentage:ResetVertexAni()
  self._ui.txt_Percentage:SetVertexAniRun("Percentage_Ani_Scale", true)
  self._ui.txt_Percentage:SetVertexAniRun("Percentage_Ani_Move", true)
  local rimProgress = self._currentItemStackCount / self._maxSubjectCount
  local rimInPosition = math.floor(rimProgress * self._rimCount)
  local rimRemainder = rimProgress * self._rimCount - rimInPosition
  self:setRimRotation(rimInPosition, rimRemainder)
end
function PaGlobal_FairyTierUpgrade_All:decimalRoundForPercentValue(value)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if 100 <= value then
    return 100
  elseif 99 < value and value < 100 then
    return 99
  elseif 0 < value and value < 1 then
    return 1
  else
    return math.floor(value)
  end
end
function PaGlobal_FairyTierUpgrade_All:setRimRotation(rimInPosition, rimRemainder)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  for i = 1, self._rimCount do
    if i <= rimInPosition then
      if 0 < self._rim[i]._currentDegree then
        if self._rim[i]._currentDegree < 90 then
          self._rim[i]._rotateTarget = 0
        else
          self._rim[i]._rotateTarget = 180
        end
      elseif self._rim[i]._currentDegree > -90 then
        self._rim[i]._rotateTarget = 0
      else
        self._rim[i]._rotateTarget = -180
      end
      self._rim[i]._state = self._RIM_ANI_STATE.ROTATING
    elseif 0.01 < rimRemainder then
      if 0 < self._rim[i]._currentDegree then
        if self._rim[i]._currentDegree < 90 then
          self._rim[i]._rotateTarget = 90 - rimRemainder * 90
        else
          self._rim[i]._rotateTarget = 90 + rimRemainder * 90
        end
      elseif self._rim[i]._currentDegree > -90 then
        self._rim[i]._rotateTarget = -90 + rimRemainder * 90
      else
        self._rim[i]._rotateTarget = -90 - rimRemainder * 90
      end
      rimRemainder = 0
      self._rim[i]._state = self._RIM_ANI_STATE.ROTATING
    else
      if self._RIM_ANI_STATE.IDLE ~= self._rim[i]._state then
        self._rim[i]._rotateTarget = math.random(-180, 180)
        self:initIdleAnimation(self._rim[i])
      end
      self._rim[i]._state = self._RIM_ANI_STATE.IDLE
    end
  end
end
function PaGlobal_FairyTierUpgrade_All:TierUpgrade()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if 0 == PaGlobal_FairyInfo_getUpgradeStack_All() then
    return
  end
  self._maxSubjectCount = math.floor(self._maxSuccessRate / self._currentSuccessRate)
  if self._currentItemStackCount >= self._maxSubjectCount then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYUPGRADE_CONFIRM"),
      functionYes = PaGlobal_FairyTierUpgrade_TierUpgradeConfirm_All,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FAIRYTIERUPGRADE_ONTRY_DESC", "percentage", tostring(self:decimalRoundForPercentValue(self._currentSuccessRate / 10000 * self._currentItemStackCount))),
      functionYes = PaGlobal_FairyTierUpgrade_TierUpgradeConfirm_All,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_FairyTierUpgrade_All:TierUpgradeConfirm()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if nil == self._currentItemWrapper then
    return
  end
  if 0 == PaGlobal_FairyInfo_getUpgradeStack_All() then
    return
  end
  if 0 < ToClient_getFairyUnsealedList() then
    return
  end
  if PaGlobal_FairyInfo_isMaxTier_All() then
    return
  end
  self._ui.stc_Blcok_TierUpgrade:AddEffect("fUI_Fairy_TierUpgrade_01A_XB", false, 0, 0)
  ToClient_FairyTierUpgradeRequest(PaGlobal_FairyInfo_GetFairyNo_All(), self._currentItemWhereType, self._currentItemSlotNo, self._currentItemStackCount)
  self._ui.slider_Honey:SetIgnore(true)
  for i = 1, self._rimCount do
    if i % 2 == 1 then
      self._rim[i]._accel = math.random(-1260, -900) / self._resultAniLength
    else
      self._rim[i]._accel = math.random(900, 1260) / self._resultAniLength
    end
    self._rim[i]._state = self._RIM_ANI_STATE.WAITING_FOR_RESULT
  end
  self._isResultAnimating = true
  self._ui_pc.btn_Upgrade_pc:SetMonoTone(true)
  for i = 1, self._HoenyCount do
    self._rdo_Honey[i]._uiControl:SetIgnore(true)
  end
  Panel_Window_FairyTierUpgrade_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._ui_console.stc_KeyGuide_Y:SetShow(false)
  audioPostEvent_SystemUi(21, 1)
  _AudioPostEvent_SystemUiForXBOX(21, 1)
end
function PaGlobal_FairyTierUpgrade_All:limitAcceleration(val, limit)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if limit < val then
    return limit
  elseif val < -limit then
    return -limit
  else
    return val
  end
end
function PaGlobal_FairyTierUpgrade_All:negate360Turn(degree)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if 360 < degree then
    return degree - 360
  elseif degree < -360 then
    return degree + 360
  else
    return degree
  end
end
function PaGlobal_FairyTierUpgrade_All:rotating(rim, deltaTime)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  local acc = rim._rotateTarget - rim._currentDegree
  rim._accel = self:limitAcceleration(acc, 40) * self._rimSpeed
  rim._currentDegree = self:negate360Turn(rim._currentDegree + rim._accel * deltaTime)
  rim._uiControl:SetRotate(math.rad(rim._currentDegree))
  if 0.1 >= math.abs(acc) then
    rim._currentDegree = self:negate360Turn(rim._rotateTarget)
    rim._uiControl:SetRotate(math.rad(rim._currentDegree))
    rim._state = self._RIM_ANI_STATE.INDICATING
  end
end
function PaGlobal_FairyTierUpgrade_All:indicating(rim, deltaTime)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  rim._accel = 0
  rim._rotateTarget = 0
end
function PaGlobal_FairyTierUpgrade_All:waitingForResult(rim, deltaTime)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  rim._currentDegree = self:negate360Turn(rim._currentDegree + rim._accel * deltaTime)
  rim._uiControl:SetRotate(math.rad(rim._currentDegree))
  if not self._isResultAnimating then
    rim._accel = rim._accel * 0.9
  end
end
function PaGlobal_FairyTierUpgrade_All:resultAniUpdate(deltaTime)
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  self._resultAniElapsed = self._resultAniElapsed + deltaTime
  if self._resultAniLength < self._resultAniElapsed then
    self._isResultAnimating = false
    self._resultAniElapsed = 0
    self:onResultAnimationFinish()
  end
end
function PaGlobal_FairyTierUpgrade_All:onResultAnimationFinish()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if self._result == self._RESULT_TYPE.UNDEFINED then
    self._isResultAnimating = true
    self._resultAniElapsed = 0
  else
    self:setSubjectItemCount(0)
    self:update()
    self:clearFeedItem()
    self._ui_console.stc_KeyGuide_Y:SetShow(false)
    self._ui.txt_Percentage:SetShow(false)
    if self._result == self._RESULT_TYPE.SUCCESS then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSuccessFairyUpgrade"), 1.6, Panel_Window_FairyTierUpgrade_All:GetPosX() + self._resultMessagePosX, Panel_Window_FairyTierUpgrade_All:GetPosY() + self._resultMessagePosY)
      self._ui.stc_Blcok_Sucess:AddEffect("fUI_Fairy_TierUpgrade_Success_01A_XB", false, 0, 4)
      audioPostEvent_SystemUi(21, 2)
      _AudioPostEvent_SystemUiForXBOX(21, 2)
    elseif self._result == self._RESULT_TYPE.FAIL then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoFailFairyUpgrade"), 1.6, Panel_Window_FairyTierUpgrade_All:GetPosX() + self._resultMessagePosX, Panel_Window_FairyTierUpgrade_All:GetPosY() + self._resultMessagePosY)
      self._ui.stc_Blcok_Fail:AddEffect("fUI_Fairy_TierUpgrade_Fail_01A_XB", false, 0, 4)
    end
    self._ui.stc_FairyIcon:SetShow(false)
  end
end
function PaGlobal_FairyTierUpgrade_All:updateSlider()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if nil == self._currentItemKey then
    return
  end
  if _ContentsGroup_UsePadSnapping and isPadPressed(__eJoyPadInputType_A) then
    return
  end
  local availableSubjectCount = math.min(self._currentItemCountInInventory, self._maxSubjectCount)
  local count = availableSubjectCount * self._ui.slider_Honey:GetControlPos()
  if true == _ContentsGroup_UsePadSnapping then
    if count < self._currentItemStackCount then
      count = self._currentItemStackCount - 1
    elseif count > self._currentItemStackCount then
      count = self._currentItemStackCount + 1
    end
  end
  if availableSubjectCount < count then
    count = availableSubjectCount
  elseif count < 1 then
    count = 1
  end
  local currentPercent = count / availableSubjectCount * 100
  self:setSubjectItemCount(math.floor(count))
  self._ui.slider_Honey:SetControlPos(currentPercent)
  self._ui.progress2_Honey:SetProgressRate(currentPercent)
end
function PaGlobal_FairyTierUpgrade_All:updateIcon()
  if nil == Panel_Window_FairyTierUpgrade_All then
    return
  end
  if false == Panel_Window_FairyTierUpgrade_All:GetShow() then
    return
  end
  self._ui.stc_FairyIcon:ChangeTextureInfoName(PaGlobal_FairyInfo_GetIconPath_All())
end
function PaGlobal_FairyTierUpgrade_All:showToolTip(isShow)
  local control, name, desc
  name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRYTIERUPGRADE_TITLE")
  desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_TIERUPGRADE_DEC_All")
  if false == _ContentsGroup_RenewUI then
    if true == isShow then
      TooltipSimple_Show(self._ui_pc.btn_Detail_pc, name, desc)
    else
      TooltipSimple_Hide()
    end
  else
    if PaGlobalFunc_FloatingTooltip_GetShow() and isShow then
      PaGlobalFunc_FloatingTooltip_Close()
      return
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.PlainText, desc, Defines.TooltipTargetType.PlainText, Panel_Window_FairyTierUpgrade_All)
  end
end
function PaGlobal_FairyTierUpgrade_All:showItemToolTip(index, isShow)
  if _ContentsGroup_RenewUI and nil ~= PaGlobalFunc_TooltipInfo_GetShow and PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if index == self._currentItemClickIndex then
    self._rdo_Honey[index]._uiControl:setRenderTexture(self._rdo_Honey[index]._uiControl:getClickTexture())
  else
    self._rdo_Honey[index]._uiControl:setRenderTexture(self._rdo_Honey[index]._uiControl:getBaseTexture())
  end
  local itemSSW
  if 1 == index then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(54030))
  elseif 2 == index then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(18448))
  end
  if nil == itemSSW then
    return
  end
  if true == isShow then
    if false == _ContentsGroup_RenewUI then
      Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FairyTierUpgrade_All, true)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
