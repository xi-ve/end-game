function PaGlobal_FairyGrowth_All:initialize()
  if true == PaGlobal_FairyGrowth_All._initialize then
    return
  end
  self._ui.stc_TitleBG = UI.getChildControl(Panel_Window_FairyGrowth_All, "Static_TitleBarBG")
  self._ui_pc.btn_Close_pc = UI.getChildControl(self._ui.stc_TitleBG, "Button_Close")
  self._ui.stc_LeftSlotGroupBG = UI.getChildControl(Panel_Window_FairyGrowth_All, "Static_Left_ItemSlotBG")
  self._ui.stc_LeftSlotBG = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Static_ItemSlotBG")
  self._ui.stc_FairyIcon = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Static_ItemSlot1")
  self._ui.stc_FeedIcon = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Static_ItemSlot2")
  self._ui.txt_FeedCount = UI.getChildControl(self._ui.stc_FeedIcon, "StaticText_ItemCount")
  self._ui.progress2_Preview = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Progress2_PreviewExp")
  self._ui.progress2_Exp = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Progress2_Exp")
  self._ui.txt_PreviewLevel = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Static_PreviewLevel")
  self._ui.txt_PreviewExpRate = UI.getChildControl(self._ui.stc_LeftSlotGroupBG, "Static_PreviewExpRate")
  self._ui.txt_GuideText = UI.getChildControl(Panel_Window_FairyGrowth_All, "StaticText_GuideTextBox")
  self._ui_pc.btn_GrowthConfirm_pc = UI.getChildControl(Panel_Window_FairyGrowth_All, "Button_GrowthConfirm_PC")
  self._ui.stc_FeedItemGroupBG = UI.getChildControl(Panel_Window_FairyGrowth_All, "Static_FeedItemGroup")
  self._ui.list2_FeedItem = UI.getChildControl(self._ui.stc_FeedItemGroupBG, "List2_1")
  self._ui.txt_FeedItemTitle = UI.getChildControl(self._ui.stc_FeedItemGroupBG, "StaticText_FeedTitle")
  self._ui.txt_NoEquip = UI.getChildControl(self._ui.stc_FeedItemGroupBG, "StaticText_NoEquip")
  self._ui.stc_HoneySlotGroupBG = UI.getChildControl(Panel_Window_FairyGrowth_All, "Static_HoneyliquorGroup")
  self._ui.stc_HoneyBG = UI.getChildControl(self._ui.stc_HoneySlotGroupBG, "Static_HoneyBG")
  self._rdo_Honey = {}
  for i = 1, self._MAX_HONEY_COUNT do
    self._rdo_Honey[i] = {}
    self._rdo_Honey[i].uiControl = UI.getChildControl(self._ui.stc_HoneyBG, "RadioButton_ButtonBG" .. tostring(i))
    self._rdo_Honey[i].iconBG = UI.getChildControl(self._rdo_Honey[i].uiControl, "Static_ItemIconBG")
    self._rdo_Honey[i].icon = UI.getChildControl(self._rdo_Honey[i].uiControl, "Static_ItemIcon")
    self._rdo_Honey[i].name = UI.getChildControl(self._rdo_Honey[i].uiControl, "StaticText_ItemName")
    self._rdo_Honey[i].count = UI.getChildControl(self._rdo_Honey[i].uiControl, "StaticText_ItemCount")
  end
  self._ui.stc_BottomKeyGuide = UI.getChildControl(Panel_Window_FairyGrowth_All, "Static_KeyGuide_Console")
  self._ui_console.stc_KeyGuide_LTX = UI.getChildControl(self._ui.stc_BottomKeyGuide, "Static_Stream_Console")
  self._ui_console.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Detail_Console")
  self._ui_console.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Growth_Console")
  self._ui_console.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Summon_Console")
  self._ui_console.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_BottomKeyGuide, "StaticText_Close_Console")
  self._keyguide = {
    self._ui_console.stc_KeyGuide_LTX,
    self._ui_console.stc_KeyGuide_X,
    self._ui_console.stc_KeyGuide_A,
    self._ui_console.stc_KeyGuide_B
  }
  self._ui_console.stc_KeyGuide_LTX:SetText("           " .. self._ui_console.stc_KeyGuide_LTX:GetText())
  self:AdjustPanelSize()
  self:SetUiSetting()
  self:AlignKeyGuide()
  local totalSizeX = self._ui_pc.btn_GrowthConfirm_pc:GetSizeX()
  local keyguideSizeX = self._ui_console.stc_KeyGuide_Y:GetSizeX() + self._ui_console.stc_KeyGuide_Y:GetTextSizeX() + 20
  local posX = self._ui_pc.btn_GrowthConfirm_pc:GetPosX() + (totalSizeX - keyguideSizeX) / 2
  self._ui_console.stc_KeyGuide_Y:SetPosX(posX)
  PaGlobal_FairyGrowth_All:registEventHandler()
  PaGlobal_FairyGrowth_All:validate()
  PaGlobal_FairyGrowth_All._initialize = true
end
function PaGlobal_FairyGrowth_All:AdjustPanelSize()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self._ui.txt_FeedItemTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_FeedItemTitle:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_FAIRYINFO_GROWTH_ITEM"))
  local addSizeY = self._ui.txt_FeedItemTitle:GetTextSizeY() - self._ui.txt_FeedItemTitle:GetSizeY()
  if 0 < addSizeY then
    self._ui.list2_FeedItem:SetSize(self._ui.list2_FeedItem:GetSizeX(), self._ui.list2_FeedItem:GetSizeY() - addSizeY)
    self._ui.list2_FeedItem:SetSpanSize(self._ui.list2_FeedItem:GetSpanSize().x, self._ui.list2_FeedItem:GetSpanSize().y + addSizeY)
  end
  self._ui.txt_GuideText:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_GuideText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FAIRY_UPGRADE_DEC_All"))
  local originSizeY = self._ui.txt_GuideText:GetSizeY()
  local textSizeY = self._ui.txt_GuideText:GetTextSizeY()
  if originSizeY > textSizeY then
    return
  end
  addSizeY = textSizeY + 10 - originSizeY
  Panel_Window_FairyGrowth_All:SetSize(Panel_Window_FairyGrowth_All:GetSizeX(), Panel_Window_FairyGrowth_All:GetSizeY() + addSizeY)
  self._ui.list2_FeedItem:SetSize(self._ui.list2_FeedItem:GetSizeX(), self._ui.list2_FeedItem:GetSizeY() + addSizeY)
  self._ui.txt_GuideText:SetSize(self._ui.txt_GuideText:GetSizeX(), textSizeY + 10)
  self._ui.txt_GuideText:SetText(self._ui.txt_GuideText:GetText())
  Panel_Window_FairyGrowth_All:ComputePosAllChild()
end
function PaGlobal_FairyGrowth_All:SetUiSetting()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  for _, value in pairs(self._ui_pc) do
    value:SetShow(not _ContentsGroup_UsePadSnapping)
  end
  for _, value in pairs(self._ui_console) do
    value:SetShow(_ContentsGroup_UsePadSnapping)
  end
  self._ui.stc_BottomKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
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
  for i = 1, self._MAX_HONEY_COUNT do
    self._rdo_Honey[i].uiControl:SetMonoTone(false)
    self._rdo_Honey[i].icon:SetIgnore(true)
    self._rdo_Honey[i].iconBG:SetIgnore(true)
    self._rdo_Honey[i].uiControl:SetIgnore(false)
    self._rdo_Honey[i].uiControl:addInputEvent("Mouse_LUp", "InputMLUp_FairyGorwth_SelectFeedingItem(" .. i .. ", true)")
    if false == _ContentsGroup_UsePadSnapping then
      self._rdo_Honey[i].uiControl:addInputEvent("Mouse_On", "InputMOn_FairyGrowth_ShowItemTooltip(" .. i .. ", true,  true)")
    else
      self._rdo_Honey[i].uiControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMOn_FairyGrowth_ShowItemTooltip(" .. i .. ", true,  true)")
    end
    self._rdo_Honey[i].uiControl:addInputEvent("Mouse_Out", "InputMOn_FairyGrowth_ShowItemTooltip(" .. i .. ", true,  false)")
  end
end
function PaGlobal_FairyGrowth_All:AlignKeyGuide()
  if nil == Panel_Window_FairyGrowth_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyguide, self._ui.stc_BottomKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_FairyGrowth_All:registEventHandler()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self._ui_pc.btn_Close_pc:addInputEvent("Mouse_LUp", "PaGlobal_FairyGrowth_Close_All()")
  self._ui_pc.btn_GrowthConfirm_pc:addInputEvent("Mouse_LUp", "InputMLUp_FairyGrowth_RequestGrowth()")
  self._ui.list2_FeedItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_FairyGrowth_All_CreateFeedList")
  self._ui.list2_FeedItem:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_PetInfoChanged", "FromClient_FairyGrowth_PetInfoChanged_All")
  Panel_Window_FairyGrowth_All:RegisterUpdateFunc("PaGlobal_FairyGrowth_All_FairyGrowthAni")
end
function PaGlobal_FairyGrowth_All:prepareOpen(PositionReset)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  PaGlobal_FairyPanel_ALL_Close()
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ClothInventory_All_Close()
  else
    ClothInventory_Close()
  end
  if true == PaGlobal_FairyInfo_isMaxLevel_All() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFairyFusionLevel"))
    return
  end
  if ToClient_getFairyUnsealedList() < 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedUnsealFairy"))
    return
  end
  if true == PositionReset then
    PaGlobal_FairyGrowth_All:SetPosition()
  end
  PaGlobal_FairyGrowth_All:Clear()
  PaGlobal_FairyGrowth_All:update()
  PaGlobal_FairyGrowth_All:open()
end
function PaGlobal_FairyGrowth_All:SetPosition()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  Panel_Window_FairyGrowth_All:ComputePos()
end
function PaGlobal_FairyGrowth_All:Clear()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  for i = 1, self._MAX_HONEY_COUNT do
    self._rdo_Honey[i].uiControl:setRenderTexture(self._rdo_Honey[i].uiControl:getBaseTexture())
    self._currentSelectHoneyItemIndex = -1
  end
  if nil ~= self._selectListBar then
    local chk_Item = UI.getChildControl(self._selectListBar, "CheckButton_ButtonBG")
    chk_Item:setRenderTexture(chk_Item:getBaseTexture())
    self._selectListBar = nil
  end
  self._currentSelectEquipItemIndex = -1
  self._currentSelectHoneyItemIndex = -1
  self._currentItemEnchantKey = nil
  self._currentItemSlotNo = 0
  self._currentItemStackCount = 0
  self._isAnimating = false
  self._ani_TimeStamp = 0
  self._previewExpRate = 0
  self._previewLevel = 0
  self._animeExp = 0
  self._animeLv = 0
  self._diffExp = 0
  self._ui_pc.btn_GrowthConfirm_pc:SetIgnore(false)
  self._ui_pc.btn_GrowthConfirm_pc:SetMonoTone(false)
  self._ui_console.stc_KeyGuide_LTX:SetShow(false)
  Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
  self._ui.stc_FeedIcon:ChangeTextureInfoName("")
  self._ui_console.stc_KeyGuide_Y:SetMonoTone(true)
  Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
end
function PaGlobal_FairyGrowth_All:open()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  Panel_Window_FairyGrowth_All:SetShow(true)
end
function PaGlobal_FairyGrowth_All:prepareClose()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if nil ~= self._currentItemEnchantKey then
    self:clearFeedItem()
    return
  end
  Panel_NumberPad_Close()
  if false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
  TooltipSimple_Hide()
  PaGlobal_FairyGrowth_All:close()
end
function PaGlobal_FairyGrowth_All:close()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  Panel_Window_FairyGrowth_All:SetShow(false)
end
function PaGlobal_FairyGrowth_All:update()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self:updateLeftTop()
  self:updateFeedingList()
  self:updateHoneyList()
  if 0 < self._itemListCount + self._honeyListCount then
    self._ui_console.stc_KeyGuide_X:SetShow(true)
  else
    self._ui_console.stc_KeyGuide_X:SetShow(false)
  end
  self:AlignKeyGuide()
end
function PaGlobal_FairyGrowth_All:updateLeftTop()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if nil ~= PaGlobal_FairyInfo_GetIconPath_All() then
    self._ui.stc_FairyIcon:ChangeTextureInfoName(PaGlobal_FairyInfo_GetIconPath_All())
  end
  if true == PaGlobal_FairyInfo_isMaxLevel_All() then
    PaGlobal_FairyGrowth_Close_All()
    return
  end
  if self._currentItemStackCount <= 1 then
    self._ui.txt_FeedCount:SetShow(false)
  else
    self._ui.txt_FeedCount:SetText(self._currentItemStackCount)
    self._ui.txt_FeedCount:SetShow(true)
  end
  local ExpRate = PaGlobal_FairyInfo_CurrentExpRate_All()
  local currentLevel = PaGlobal_FairyInfo_GetLevel_All()
  self._ui.progress2_Exp:SetProgressRate(ExpRate)
  self._ui.progress2_Exp:SetCurrentProgressRate(ExpRate)
  self._ui.progress2_Preview:SetProgressRate(0)
  self._ui.progress2_Preview:SetCurrentProgressRate(0)
  self._ui.txt_PreviewLevel:SetText("Lv." .. tostring(currentLevel))
  self._ui.txt_PreviewExpRate:SetText(string.format("%.2f", ExpRate) .. "%")
  if currentLevel < self._previewLevel then
    self._ui.progress2_Exp:SetProgressRate(0)
    self._ui.progress2_Exp:SetCurrentProgressRate(0)
    self._ui.progress2_Preview:SetProgressRate(self._previewExpRate * 100)
    self._ui.progress2_Preview:SetCurrentProgressRate(self._previewExpRate * 100)
    self._ui.txt_PreviewLevel:SetText("Lv." .. tostring(self._previewLevel))
    self._ui.txt_PreviewExpRate:SetText(string.format("%.2f", self._previewExpRate * 100) .. "%")
  elseif currentLevel == self._previewLevel and 0 ~= self._previewLevel then
    self._ui.progress2_Preview:SetProgressRate(self._previewExpRate * 100)
    self._ui.progress2_Preview:SetCurrentProgressRate(self._previewExpRate * 100)
    self._ui.txt_PreviewExpRate:SetText(string.format("%.2f", self._previewExpRate * 100) .. "%")
  elseif (PaGlobal_FairyInfo_FairyTier_All() + 1) * 10 == self._previewLevel then
    self._ui.txt_PreviewLevel:SetText("Lv." .. tostring(self._previewLevel))
    self._ui.progress2_Preview:SetProgressRate(100)
    self._ui.progress2_Preview:SetCurrentProgressRate(100)
    self._ui.txt_PreviewExpRate:SetText(string.format("%.2f", 100) .. "%")
  end
end
function PaGlobal_FairyGrowth_All:updateFeedingList()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._ui.list2_FeedItem:getElementManager():clearKey()
  self._itemList = {}
  self._currentSelectEquipItemIndex = -1
  self._itemListCount = 0
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenIdx)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      local itemKey = item:getKey():getItemKey()
      if false == self:filterForFeeding(invenIdx, false, CppEnums.ItemWhereType.eInventory) then
        if 0 == self._itemListCount then
          self._itemListCount = self._itemListCount + 1
          self._itemList[self._itemListCount] = {}
          self._itemList[self._itemListCount].itemKey = itemKey
          self._itemList[self._itemListCount].slotNo = invenIdx
          if true == itemWrapper:getStaticStatus():isStackable() then
            self._itemList[self._itemListCount].count = Int64toInt32(itemWrapper:getCount())
          else
            self._itemList[self._itemListCount].count = Int64toInt32(1)
          end
          self._ui.list2_FeedItem:getElementManager():pushKey(toInt64(0, self._itemListCount))
        else
          local isFind = false
          local tmpItemListCount = self._itemListCount
          for i = 1, tmpItemListCount do
            if itemKey == self._itemList[i].itemKey then
              self._itemList[i].count = self._itemList[i].count + 1
              isFind = true
              tmpItemListCount = i + 1
            end
          end
          if false == isFind then
            self._itemListCount = self._itemListCount + 1
            self._itemList[self._itemListCount] = {}
            self._itemList[self._itemListCount].itemKey = itemKey
            self._itemList[self._itemListCount].slotNo = invenIdx
            if true == itemWrapper:getStaticStatus():isStackable() then
              self._itemList[self._itemListCount].count = Int64toInt32(itemWrapper:getCount())
            else
              self._itemList[self._itemListCount].count = Int64toInt32(1)
            end
            self._ui.list2_FeedItem:getElementManager():pushKey(toInt64(0, self._itemListCount))
          end
        end
      end
    end
  end
  if 0 == self._itemListCount then
    self._ui.txt_NoEquip:SetShow(true)
  else
    self._ui.txt_NoEquip:SetShow(false)
  end
end
function PaGlobal_FairyGrowth_All:filterForFeeding(slotNo, notUse_itemWrappers, whereType)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return true
  end
  local item = itemWrapper:get()
  if nil == item then
    return true
  end
  local itemKey = item:getKey():getItemKey()
  if nil == itemKey then
    return true
  end
  if 54030 == itemKey then
    return true
  end
  if true == itemWrapper:isFairyFeedItem() then
    return false
  end
  return true
end
function PaGlobal_FairyGrowth_All:createFeedList(control, key64)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  local key = Int64toInt32(key64)
  if nil == self._itemList[key] then
    return
  end
  local slotNo = self._itemList[key].slotNo
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local itemName = itemSSW:getName()
  local chk_Item = UI.getChildControl(control, "CheckButton_ButtonBG")
  local stc_IconBG = UI.getChildControl(chk_Item, "Static_ItemIconBG")
  local stc_Icon = UI.getChildControl(chk_Item, "Static_ItemIcon")
  local txt_Name = UI.getChildControl(chk_Item, "StaticText_ItemName")
  local txt_Count = UI.getChildControl(chk_Item, "StaticText_Count")
  if key == self._currentSelectEquipItemIndex then
    chk_Item:setRenderTexture(chk_Item:getClickTexture())
    self._selectListBar = control
  else
    chk_Item:setRenderTexture(chk_Item:getBaseTexture())
  end
  chk_Item:setNotImpactScrollEvent(true)
  stc_Icon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
  if nil ~= fontColor then
    txt_Name:SetFontColor(fontColor)
  else
    txt_Name:SetFontColor(self._itemGradeColor[__eItemGradeNormal])
  end
  txt_Name:SetTextMode(__eTextMode_LimitText)
  txt_Name:SetText(itemName)
  txt_Count:SetText(tostring(self._itemList[key].count))
  stc_Icon:SetIgnore(true)
  stc_IconBG:SetIgnore(true)
  chk_Item:addInputEvent("Mouse_LUp", "InputMLUp_FairyGorwth_SelectFeedingItem(" .. key .. ", false)")
  if false == _ContentsGroup_UsePadSnapping then
    chk_Item:addInputEvent("Mouse_On", "InputMOn_FairyGrowth_ShowItemTooltip(" .. key .. ", false,  true)")
  else
    chk_Item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "InputMOn_FairyGrowth_ShowItemTooltip(" .. key .. ", false,  true)")
  end
  chk_Item:addInputEvent("Mouse_Out", "InputMOn_FairyGrowth_ShowItemTooltip(" .. key .. ", false,  false)")
end
function PaGlobal_FairyGrowth_All:updateHoneyList()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  local cashInvenSize = selfPlayer:getInventorySlotCount(true)
  self._honeyList = {}
  self._honeyListCount = 0
  local isItemFind = false
  for invenIdx = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenIdx)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item then
        local itemKey = item:getKey():getItemKey()
        if nil ~= itemKey and 54030 == itemKey then
          self._honeyListCount = self._honeyListCount + 1
          self._honeyList[self._honeyListCount] = {}
          self._honeyList[self._honeyListCount].slotNo = invenIdx
          self._honeyList[self._honeyListCount].whereType = CppEnums.ItemWhereType.eInventory
          isItemFind = true
        end
      end
    end
  end
  if false == isItemFind then
    self._honeyListCount = self._honeyListCount + 1
    self._honeyList[self._honeyListCount] = {}
    self._honeyList[self._honeyListCount].slotNo = nil
    self._honeyList[self._honeyListCount].whereType = nil
  else
    isItemFind = false
  end
  for invenIdx = 0, cashInvenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventoryBag, invenIdx)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item then
        local itemKey = item:getKey():getItemKey()
        if nil ~= itemKey and 18448 == itemKey then
          self._honeyListCount = self._honeyListCount + 1
          self._honeyList[self._honeyListCount] = {}
          self._honeyList[self._honeyListCount].slotNo = invenIdx
          self._honeyList[self._honeyListCount].whereType = CppEnums.ItemWhereType.eCashInventoryBag
          isItemFind = true
        end
      end
    end
  end
  if false == isItemFind then
    self._honeyListCount = self._honeyListCount + 1
    self._honeyList[self._honeyListCount] = {}
    self._honeyList[self._honeyListCount].slotNo = nil
    self._honeyList[self._honeyListCount].whereType = nil
  end
  for i = 1, self._MAX_HONEY_COUNT do
    if nil == self._honeyList[i].slotNo then
      self._rdo_Honey[i].count:SetText(Int64toInt32(0))
      self._rdo_Honey[i].uiControl:SetMonoTone(true)
    else
      local slotNo = self._honeyList[i].slotNo
      local whereType = self._honeyList[i].whereType
      local itemWrapper = getInventoryItemByType(whereType, slotNo)
      self._rdo_Honey[i].count:SetText(Int64toInt32(itemWrapper:getCount()))
      self._rdo_Honey[i].uiControl:SetMonoTone(false)
    end
  end
end
function PaGlobal_FairyGrowth_All:validate()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self._ui.stc_TitleBG:isValidate()
  self._ui_pc.btn_Close_pc:isValidate()
  self._ui.stc_LeftSlotGroupBG:isValidate()
  self._ui.stc_LeftSlotBG:isValidate()
  self._ui.stc_FairyIcon:isValidate()
  self._ui.stc_FeedIcon:isValidate()
  self._ui.txt_FeedCount:isValidate()
  self._ui.progress2_Preview:isValidate()
  self._ui.progress2_Exp:isValidate()
  self._ui.txt_PreviewLevel:isValidate()
  self._ui.txt_PreviewExpRate:isValidate()
  self._ui.txt_GuideText:isValidate()
  self._ui_pc.btn_GrowthConfirm_pc:isValidate()
  self._ui.stc_FeedItemGroupBG:isValidate()
  self._ui.list2_FeedItem:isValidate()
  self._ui.txt_NoEquip:isValidate()
  self._ui.stc_HoneySlotGroupBG:isValidate()
  self._ui.stc_HoneyBG:isValidate()
  for i = 1, self._MAX_HONEY_COUNT do
    self._rdo_Honey[i].uiControl:isValidate()
    self._rdo_Honey[i].iconBG:isValidate()
    self._rdo_Honey[i].icon:isValidate()
    self._rdo_Honey[i].name:isValidate()
    self._rdo_Honey[i].count:isValidate()
  end
  self._ui.stc_BottomKeyGuide:isValidate()
  self._ui_console.stc_KeyGuide_LTX:isValidate()
  self._ui_console.stc_KeyGuide_X:isValidate()
  self._ui_console.stc_KeyGuide_Y:isValidate()
  self._ui_console.stc_KeyGuide_A:isValidate()
  self._ui_console.stc_KeyGuide_B:isValidate()
end
function PaGlobal_FairyGrowth_All:petInfoChanged(petNo)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if true == Panel_Window_FairyGrowth_All:GetShow() and petNo == PaGlobal_FairyInfo_GetFairyNo_All() then
    self:Clear()
    self:update()
  end
end
function PaGlobal_FairyGrowth_All:selectFeedingItem(index, isHoney)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if true == self._isAnimating then
    return
  end
  local itemWrapper, itemSSW
  if isHoney then
    if nil ~= self._selectListBar then
      local chk_Item = UI.getChildControl(self._selectListBar, "CheckButton_ButtonBG")
      chk_Item:setRenderTexture(chk_Item:getBaseTexture())
      self._selectListBar = nil
    end
    self._currentSelectEquipItemIndex = -1
    local itemCount = 0
    if nil ~= self._honeyList[index].slotNo then
      local slotNo = self._honeyList[index].slotNo
      local whereType = self._honeyList[index].whereType
      itemWrapper = getInventoryItemByType(whereType, slotNo)
    end
    if nil == itemWrapper then
      Panel_NumberPad_Close()
      return
    end
    itemCount = Int64toInt32(itemWrapper:getCount())
    local currentItemIsStackable = itemWrapper:getStaticStatus():isStackable()
    if true == currentItemIsStackable and 1 < itemCount then
      Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), self._honeyList[index].slotNo, PaGlobal_FairyGrowth_All_SetFeedItem, false, itemWrapper:get():getKey())
    elseif 0 ~= itemCount then
      Panel_NumberPad_Close()
      self:setFeedItem(itemWrapper:get():getCount_s64(), self._honeyList[index].slotNo, itemWrapper:get():getKey())
    end
    _isHoneySelect = true
    self._currentSelectHoneyItemIndex = index
  else
    if true == _isHoneySelect then
      for i = 1, self._MAX_HONEY_COUNT do
        self._rdo_Honey[i].uiControl:setRenderTexture(self._rdo_Honey[i].uiControl:getBaseTexture())
      end
    end
    self._currentSelectHoneyItemIndex = -1
    local slotNo = self._itemList[index].slotNo
    itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil == itemWrapper then
      return
    end
    itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    local itemCount = toInt64(0, self._itemList[index].count)
    local currentItemIsStackable = itemWrapper:getStaticStatus():isStackable()
    if itemCount > Defines.s64_const.s64_1 then
      Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobal_FairyGrowth_All_SetFeedItem, false, itemWrapper:get():getKey())
    else
      Panel_NumberPad_Close()
      self:setFeedItem(itemCount, slotNo, itemWrapper:get():getKey())
    end
    self._currentSelectEquipItemIndex = index
    for itemCount = 1, self._itemListCount do
      self._ui.list2_FeedItem:requestUpdateByKey(toInt64(0, itemCount))
    end
    _isHoneySelect = false
  end
end
function PaGlobal_FairyGrowth_All:setFeedItem(count, slotNo, itemKey)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if nil == itemKey then
    return
  end
  if true == self._isAnimating then
    return
  end
  self._currentItemEnchantKey = itemKey
  local itemSSW = getItemEnchantStaticStatus(self._currentItemEnchantKey)
  self._currentItemSlotNo = slotNo
  self._currentItemStackCount = Int64toInt32(count)
  if nil == itemSSW then
    return
  end
  self._ui.stc_FeedIcon:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
  self._ui.stc_FeedIcon:SetShow(true)
  self._ui_console.stc_KeyGuide_LTX:SetShow(false)
  local currentItemIsStackable = itemSSW:isStackable()
  ToClient_CalculateUpgradeExp(PaGlobal_FairyInfo_GetFairyNo_All(), self._currentItemEnchantKey, self._currentItemSlotNo, self._currentItemStackCount, not currentItemIsStackable)
  self._previewExpRate = ToClient_GetFutureFairyExp()
  self._previewLevel = ToClient_GetFutureFairyLevel()
  self._currentItemStackCount = Int64toInt32(ToClient_GetFeedCount())
  if _ContentsGroup_UsePadSnapping then
    self._ui_console.stc_KeyGuide_Y:SetMonoTone(false)
    Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "InputMLUp_FairyGrowth_RequestGrowth()")
  else
    self._ui.stc_FeedIcon:addInputEvent("Mouse_RUp", "PaGlobal_FairyGrowth_ClearFeedItem_All()")
  end
  self:updateLeftTop()
end
function PaGlobal_FairyGrowth_All:requestGrowth()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if nil == self._currentItemEnchantKey then
    return
  end
  local function FunctionYesOverExp()
    audioPostEvent_SystemUi(21, 0)
    _AudioPostEvent_SystemUiForXBOX(21, 0)
    self._isAnimating = true
    self._ui_pc.btn_GrowthConfirm_pc:SetIgnore(true)
    self._ui_pc.btn_GrowthConfirm_pc:SetMonoTone(true)
    self._ui_console.stc_KeyGuide_Y:SetMonoTone(true)
    self._ui_console.stc_KeyGuide_LTX:SetShow(false)
    Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    self._ui.stc_FairyIcon:AddEffect("CO_UI_Fairy_01A_XB", false, -75, 7)
    self._ui.stc_FairyIcon:AddEffect("CO_UI_Fairy_01B_XB", false, 75, 7)
    self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_01A_XB", false, 0, 0)
    self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_02B", false, 0, 0)
    self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_03A_XB", false, 0, -2)
    self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_04A_XB", false, 0, 167)
    self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_02A", false, 1, 167)
    self._ui.stc_FairyIcon:AddEffect("CO_Empty", false, 1, 167)
  end
  local function FunctionYes()
    if nil == self._currentItemEnchantKey then
      return
    end
    local isOverExp = ToClient_isOverExpFairyFeeding(PaGlobal_FairyInfo_GetFairyNo_All(), self._currentItemEnchantKey, self._currentItemStackCount)
    if false == isOverExp then
      audioPostEvent_SystemUi(21, 0)
      _AudioPostEvent_SystemUiForXBOX(21, 0)
      self._isAnimating = true
      self._ui_pc.btn_GrowthConfirm_pc:SetIgnore(true)
      self._ui_pc.btn_GrowthConfirm_pc:SetMonoTone(true)
      self._ui_console.stc_KeyGuide_Y:SetMonoTone(true)
      self._ui_console.stc_KeyGuide_LTX:SetShow(false)
      Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      Panel_Window_FairyGrowth_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
      self._ui.stc_FairyIcon:AddEffect("CO_UI_Fairy_01A_XB", false, -75, 7)
      self._ui.stc_FairyIcon:AddEffect("CO_UI_Fairy_01B_XB", false, 75, 7)
      self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_01A_XB", false, 0, 0)
      self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_02B", false, 0, 0)
      self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_03A_XB", false, 0, -2)
      self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_04A_XB", false, 0, 167)
      self._ui.stc_FairyIcon:AddEffect("fUI_Fairy_02A", false, 1, 167)
      self._ui.stc_FairyIcon:AddEffect("CO_Empty", false, 1, 167)
    else
      local __title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
      local __contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_UPGRADE_OVEREXP_ALERT")
      local __messageBoxData = {
        title = __title,
        content = __contenet,
        functionYes = FunctionYesOverExp,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(__messageBoxData)
    end
  end
  _futureLevel = self._previewLevel
  _futureExp = self._previewExpRate
  local ExpRate = PaGlobal_FairyInfo_CurrentExpRate_All() / 100
  local currentLevel = PaGlobal_FairyInfo_GetLevel_All()
  local diffLevel = _futureLevel - currentLevel
  if 0 < diffLevel then
    self._diffExp = (_futureExp + diffLevel + (1 - ExpRate)) / self._const_aniTime - 0.3
  else
    self._diffExp = (_futureExp - ExpRate) / (self._const_aniTime - 0.3)
  end
  self._animeLv = currentLevel
  self._animeExp = ExpRate
  local _title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local _contenet = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRY_UPGRADE_ALERT")
  local messageBoxData = {
    title = _title,
    content = _contenet,
    functionYes = FunctionYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_FairyGrowth_All:updateAni(deltaTime)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if nil == self._currentItemEnchantKey then
    return
  end
  if true == self._isAnimating then
    self._ani_TimeStamp = self._ani_TimeStamp + deltaTime
    self._animeExp = self._animeExp + self._diffExp * deltaTime
    if self._animeExp > 1 then
      self._animeLv = self._animeLv + 1
      self._animeExp = self._animeExp - 1
    end
    if self._previewLevel <= self._animeLv then
      self._animeLv = self._previewLevel
      if self._previewExpRate <= self._animeExp then
        self._animeExp = self._previewExpRate
      end
    end
    self._ui.progress2_Preview:SetProgressRate(self._animeExp * 100)
    self._ui.progress2_Preview:SetCurrentProgressRate(self._animeExp * 100)
    self._ui.txt_PreviewLevel:SetText("Lv." .. tostring(self._animeLv))
    self._ui.txt_PreviewExpRate:SetText(string.format("%.2f", self._animeExp * 100) .. "%")
    if self._const_aniTime <= self._ani_TimeStamp then
      self._isAnimating = false
      local itemSSW = getItemEnchantStaticStatus(self._currentItemEnchantKey)
      local currentItemIsStackable = itemSSW:isStackable()
      ToClient_FairyFeedingRequest(PaGlobal_FairyInfo_GetFairyNo_All(), self._currentItemEnchantKey, self._currentItemSlotNo, self._currentItemStackCount, not currentItemIsStackable)
      self._ani_TimeStamp = 0
      self._ui_pc.btn_GrowthConfirm_pc:SetIgnore(false)
      self._ui_pc.btn_GrowthConfirm_pc:SetMonoTone(false)
    end
  end
end
function PaGlobal_FairyGrowth_All:onlyUpdate()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self:updateLeftTop()
end
function PaGlobal_FairyGrowth_All:clearFeedItem()
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  self:Clear()
  self:updateLeftTop()
end
function PaGlobal_FairyGrowth_All:showItemTooltip(index, isHoney, isShow)
  if nil == Panel_Window_FairyGrowth_All then
    return
  end
  if _ContentsGroup_RenewUI and PaGlobalFunc_TooltipInfo_GetShow() and isShow then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper, itemSSW, whereType, slotNo
  for i = 1, self._MAX_HONEY_COUNT do
    if self._currentSelectHoneyItemIndex ~= i then
      self._rdo_Honey[i].uiControl:setRenderTexture(self._rdo_Honey[i].uiControl:getBaseTexture())
    end
  end
  if false == isHoney then
    if nil ~= self._itemList[index] then
      whereType = CppEnums.ItemWhereType.eInventory
      slotNo = self._itemList[index].slotNo
      itemWrapper = getInventoryItemByType(whereType, slotNo)
    end
    self._ui.list2_FeedItem:requestUpdateByKey(toInt64(0, index))
    if nil == itemWrapper then
      return
    end
    itemSSW = itemWrapper:getStaticStatus()
  elseif 1 == index then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(54030))
  elseif 2 == index then
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(18448))
  end
  if nil == itemSSW then
    return
  end
  if true == isShow then
    if false == _ContentsGroup_RenewUI then
      Panel_Tooltip_Item_Show(itemSSW, Panel_Window_FairyGrowth_All, true)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
    end
  elseif false == _ContentsGroup_RenewUI then
    Panel_Tooltip_Item_hideTooltip()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
