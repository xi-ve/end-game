function PaGlobal_DropItem_All:initialize()
  if true == PaGlobal_DropItem_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stcText_Title = UI.getChildControl(Panel_Window_DropItem_All, "StaticText_Title")
  self._ui._static_1 = UI.getChildControl(Panel_Window_DropItem_All, "Static_1")
  self._ui._console._stc_keyGuideBG = UI.getChildControl(Panel_Window_DropItem_All, "Static_KeyGuide_Console")
  self._ui._console._txt_selectKey = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Select_Console")
  self._ui._console._txt_closeKey = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Close_Console")
  self._ui._console._txt_wayPointKey = UI.getChildControl(self._ui._console._stc_keyGuideBG, "StaticText_Waypoint_Console")
  self._ui._pc._btn_close = UI.getChildControl(self._ui._stcText_Title, "Button_Win_Close")
  self._ui._pc._btn_autoNaviButton = UI.getChildControl(self._ui._static_1, "Button_Navi")
  self._ui._list2Region = UI.getChildControl(Panel_Window_DropItem_All, "List2_Region")
  self._ui._stc_bottomDescBg = UI.getChildControl(Panel_Window_DropItem_All, "Static_DescBg")
  self._ui._txt_bottomDesc = UI.getChildControl(self._ui._stc_bottomDescBg, "StaticText_Desc")
  self._ui._stcText_SelectedRegionName = UI.getChildControl(self._ui._static_1, "StaticText_SelectedRegionName")
  self._ui._stcText_NeedAp = UI.getChildControl(self._ui._static_1, "StaticText_NeedAp")
  self._ui._frame_DropItem = UI.getChildControl(self._ui._static_1, "Frame_RegionDropItem")
  self._ui._frame_Content = UI.getChildControl(self._ui._frame_DropItem, "Frame_1_Content")
  self._ui._scroll = UI.getChildControl(self._ui._frame_DropItem, "Frame_1_VerticalScroll")
  local itemGroup = {
    "Static_WeaponGroup",
    "Static_ArmorGroup",
    "Static_AccessoryGroup",
    "Static_EtcGroup"
  }
  for idx = 0, self.groupType.loopCount do
    self._ui._stc_itemGroupUi[idx] = UI.getChildControl(self._ui._frame_Content, itemGroup[idx + 1])
    self._ui._stc_slotTempleteBg[idx] = UI.getChildControl(self._ui._stc_itemGroupUi[idx], "Static_ItemSlotBg")
    self._ui._stc_slotTempleteBg[idx]:SetShow(false)
  end
  local bgName = {
    "DropItem_WeaponSlotBg_",
    "DropItem_ArmorSlotBg_",
    "DropItem_AccessorySlotBg_",
    "DropItem_EtcSlotBg_"
  }
  local slotName = {
    "DropItem_WeaponSlot_",
    "DropItem_ArmorSlot_",
    "DropItem_AccessorySlot_",
    "DropItem_EtcSlot_"
  }
  for typeIndex = 0, self.groupType.loopCount do
    self._ui._slotBg[typeIndex] = {}
    for slotIndex = 0, self._maxSlot - 1 do
      self._ui._slotBg[typeIndex][slotIndex] = UI.createControl(__ePAUIControl_Static, self._ui._stc_itemGroupUi[typeIndex], bgName[typeIndex + 1] .. slotIndex)
      CopyBaseProperty(self._ui._stc_slotTempleteBg[typeIndex], self._ui._slotBg[typeIndex][slotIndex])
      self._ui._slotBg[typeIndex][slotIndex]:SetPosX(20 + slotIndex % 7 * 55)
      self._ui._slotBg[typeIndex][slotIndex]:SetPosY(55 + math.floor(slotIndex / 7) * 55)
      self._ui._slotBg[typeIndex][slotIndex]:SetShow(false)
      self._ui._slot[typeIndex][slotIndex] = {}
      SlotItem.new(self._ui._slot[typeIndex][slotIndex], slotName[typeIndex + 1] .. slotIndex, slotIndex, self._ui._slotBg[typeIndex][slotIndex], self._slotConfig)
      self._ui._slot[typeIndex][slotIndex]:createChild()
    end
  end
  local isPc = false == self._isConsole
  for k, control in pairs(self._ui._pc) do
    control:SetShow(isPc)
  end
  for k, control in pairs(self._ui._console) do
    control:SetShow(self._isConsole)
  end
  self._keyGuides = {
    self._ui._console._txt_wayPointKey,
    self._ui._console._txt_selectKey,
    self._ui._console._txt_closeKey
  }
  self._ui._list2Region:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stcText_SelectedRegionName:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._panelSizeY = Panel_Window_DropItem_All:GetSizeY()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_DropItem_All:registEventHandler()
  if nil == Panel_Window_DropItem_All then
    return
  end
  if true == self._isConsole then
    for typeIndex = 0, self.groupType.loopCount do
      for slotIndex = 0, self._maxSlot - 1 do
        self._ui._slotBg[typeIndex][slotIndex]:addInputEvent("Mouse_On", "HandleEventOn_DropItem_All_SetIsTargetChange(true)")
        if true == _ContentsGroup_RenewUI_Tooltip then
          self._ui._slotBg[typeIndex][slotIndex]:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventPad_DropItem_All_ShowDetailTooltip(" .. typeIndex .. " ," .. slotIndex .. ")")
        end
      end
    end
  else
    self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_DropItem_All_Close()")
    self._ui._pc._btn_autoNaviButton:addInputEvent("Mouse_LUp", "HandleEventLUp_DropItem_All_SetNavi()")
  end
  for typeIndex = 0, self.groupType.loopCount do
    for slotIndex = 0, self._maxSlot - 1 do
      self._ui._slot[typeIndex][slotIndex].icon:addInputEvent("Mouse_On", "HandleEventOn_DropItem_All_ItemTooltip_Show(" .. typeIndex .. "," .. slotIndex .. ")")
      self._ui._slot[typeIndex][slotIndex].icon:addInputEvent("Mouse_Out", "HandleEventOut_DropItem_All_ItemTooltip_Hide()")
    end
  end
  registerEvent("onScreenResize", "FromClient_DropItem_All_PanelResize")
  if true == self._isConsole then
    Panel_Window_DropItem_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_DropItem_All_SetNavi()")
  end
  self._ui._list2Region:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DropItem_All_UpdateRegionButton")
end
function PaGlobal_DropItem_All:validate()
  if nil == Panel_Window_DropItem_All then
    return
  end
  self._ui._stcText_Title:isValidate()
  self._ui._static_1:isValidate()
  self._ui._console._stc_keyGuideBG:isValidate()
  self._ui._console._txt_selectKey:isValidate()
  self._ui._console._txt_closeKey:isValidate()
  self._ui._console._txt_wayPointKey:isValidate()
  self._ui._pc._btn_close:isValidate()
  self._ui._pc._btn_autoNaviButton:isValidate()
  self._ui._list2Region:isValidate()
  self._ui._stc_bottomDescBg:isValidate()
  self._ui._stcText_SelectedRegionName:isValidate()
  self._ui._stcText_NeedAp:isValidate()
  self._ui._frame_DropItem:isValidate()
  self._ui._frame_Content:isValidate()
  for idx = 0, self.groupType.loopCount do
    self._ui._stc_itemGroupUi[idx]:isValidate()
    self._ui._stc_slotTempleteBg[idx]:isValidate()
  end
  self._ui._scroll:isValidate()
end
function PaGlobal_DropItem_All:prepareOpen()
  if nil == Panel_Window_DropItem_All then
    return
  end
  self._ui._list2Region:getElementManager():clearKey()
  for index = 0, ToClient_RegionDropItem_GetRegionKeySize() - 1 do
    local regionKey_s64 = ToClient_RegionDropItem_GetRegionKeyByIndex(index)
    self._ui._list2Region:getElementManager():pushKey(regionKey_s64)
  end
  self:Select_Region(ToClient_RegionDropItem_GetRegionKeyByIndex(0))
  self._isTargetChange = false
  self:updateConsoleKey(false)
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  PaGlobal_DropItem_All:open()
  PaGlobal_DropItem_All:resize()
end
function PaGlobal_DropItem_All:open()
  if nil == Panel_Window_DropItem_All then
    return
  end
  Panel_Window_DropItem_All:SetShow(true)
end
function PaGlobal_DropItem_All:resize()
  if nil == Panel_Window_DropItem_All or false == Panel_Window_DropItem_All:GetShow() then
    return
  end
  self._ui._stcText_Title:ComputePos()
  self._ui._pc._btn_close:ComputePos()
  self._ui._list2Region:ComputePos()
  self._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_bottomDesc:SetText(self._ui._txt_bottomDesc:GetText())
  local bgSizeY = self._ui._stc_bottomDescBg:GetSizeY()
  local textSizeY = self._ui._txt_bottomDesc:GetTextSizeY()
  local gabY = 10
  if bgSizeY < textSizeY + gabY then
    local addSizeY = textSizeY + gabY - bgSizeY
    self._ui._stc_bottomDescBg:SetSize(self._ui._stc_bottomDescBg:GetSizeX(), textSizeY + gabY)
    Panel_Window_DropItem_All:SetSize(Panel_Window_DropItem_All:GetSizeX(), self._panelSizeY + addSizeY)
  end
  self._ui._stc_bottomDescBg:ComputePos()
  self._ui._txt_bottomDesc:ComputePos()
  self._ui._static_1:ComputePos()
  self._ui._stcText_SelectedRegionName:ComputePos()
  self._ui._stcText_NeedAp:ComputePos()
  self._ui._frame_DropItem:ComputePos()
  self._ui._frame_Content:ComputePos()
  for idx = 0, self.groupType.loopCount do
    self._ui._stc_itemGroupUi[idx]:ComputePos()
    self._ui._stc_slotTempleteBg[idx]:ComputePos()
  end
  self._ui._scroll:ComputePos()
  self._ui._pc._btn_autoNaviButton:ComputePos()
  Panel_Window_DropItem_All:ComputePos()
end
function PaGlobal_DropItem_All:prepareClose()
  if nil == Panel_Window_DropItem_All then
    return
  end
  self._currentButton = nil
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_DropItem_All:close()
end
function PaGlobal_DropItem_All:close()
  if nil == Panel_Window_DropItem_All then
    return
  end
  Panel_Window_DropItem_All:SetShow(false)
end
function PaGlobal_DropItem_All:Select_Region(regionKey)
  if nil == Panel_Window_DropItem_All then
    return
  end
  self._selectedRegionKey = regionKey
  local key64 = toInt64(0, regionKey)
  if true == self._isConsole then
    local currentContent = self._ui._list2Region:GetContentByKey(key64)
    if nil ~= currentContent then
      self._currentButton = UI.getChildControl(currentContent, "RadioButton_RegionName")
    end
    ToClient_padSnapSetTargetGroup(PaGlobal_DropItem_All._ui._frame_Content)
    ToClient_padSnapResetControl()
  end
  PaGlobal_DropItem_All:SetDropItem(regionKey)
end
function PaGlobal_DropItem_All:SetDropItem(regionKey)
  if nil == Panel_Window_DropItem_All then
    return
  end
  local regionInfo = getRegionInfoWrapper(regionKey)
  if true == _ContentsGroup_RenewUI then
    self._ui._stcText_SelectedRegionName:SetText(regionInfo:getAreaName())
  else
    self._ui._stcText_SelectedRegionName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DROPITEM_SELECTEDAREA", "areaName", regionInfo:getAreaName()))
  end
  local needAttackPoint = ToClient_RegionDropItem_GetNeedAttackPoint(regionKey)
  if nil ~= needAttackPoint then
    self._ui._stcText_NeedAp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DROPITEM_ATTACKPOINT_TEXT", "apCount", tostring(needAttackPoint)))
  end
  local itemCount = ToClient_GetRegionDropItemSize(regionKey)
  if 0 < itemCount then
    for iIndex = 0, self.groupType.loopCount do
      self._itemKeyByType[iIndex] = {}
    end
    for index = 0, itemCount - 1 do
      local itemSSW = ToClient_GetRegionDropItemWrapper(regionKey, index)
      local itemKey = itemSSW:get()._key:get()
      if itemSSW:isEquipable() then
        if itemSSW:get():isWeapon() or itemSSW:get():isSubWeapon() or itemSSW:get():isAwakenWeapon() then
          table.insert(self._itemKeyByType[self.groupType.weapon], itemKey)
        elseif CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
          table.insert(self._itemKeyByType[self.groupType.acc], itemKey)
        else
          table.insert(self._itemKeyByType[self.groupType.armor], itemKey)
        end
      else
        table.insert(self._itemKeyByType[self.groupType.etc], itemKey)
      end
    end
  end
  self:Slot_Init()
  local nextPosY = 0
  for index = 0, self.groupType.loopCount do
    if 0 < #self._itemKeyByType[index] then
      self._ui._stc_itemGroupUi[index]:SetShow(true)
      self._ui._stc_itemGroupUi[index]:SetPosY(nextPosY)
      local posY = 0
      for sIndex = 1, #self._itemKeyByType[index] do
        self._ui._slotBg[index][sIndex - 1]:SetShow(true)
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._itemKeyByType[index][sIndex]))
        self._ui._slot[index][sIndex - 1]:setItemByStaticStatus(itemSSW)
      end
      nextPosY = nextPosY + self._ui._slotBg[index][#self._itemKeyByType[index] - 1]:GetPosY() + 50
    else
      self._ui._stc_itemGroupUi[index]:SetShow(false)
    end
  end
  local contentSize = math.max(330, nextPosY)
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), contentSize)
  self._ui._scroll:SetInterval(contentSize / 100 * 1.2)
  self._ui._scroll:GetControlButton():SetSize(self._ui._scroll:GetControlButton():GetSizeX(), math.min(325, 325 / contentSize * 250))
  self._ui._frame_DropItem:UpdateContentScroll()
  self._ui._scroll:SetControlTop()
  self._ui._frame_DropItem:UpdateContentPos()
end
function PaGlobal_DropItem_All:Slot_Init()
  if nil == Panel_Window_DropItem_All then
    return
  end
  for tIndex = 0, 3 do
    for index = 0, self._maxSlot - 1 do
      self._ui._slotBg[tIndex][index]:SetShow(false)
    end
  end
end
function PaGlobal_DropItem_All:ItemTooltip_Show(typeIndex, slotIndex)
  if nil == Panel_Window_DropItem_All then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._itemKeyByType[typeIndex][slotIndex + 1]))
  if nil ~= itemSSW then
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, self._ui._slot[typeIndex][slotIndex].icon)
    else
      Panel_Tooltip_Item_SetPosition(slotIndex, self._ui._slot[slotIndex], "dropItem")
      Panel_Tooltip_Item_Show(itemSSW, Panel_Window_DropItem_All, true)
    end
  end
end
function PaGlobal_DropItem_All:ItemTooltip_Hide()
  if nil == Panel_Window_DropItem_All then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_DropItem_All:SetNavi()
  if nil == Panel_Window_DropItem_All then
    return
  end
  if nil == self._selectedRegionKey then
    return
  end
  local regionInfo = getRegionInfoWrapper(self._selectedRegionKey)
  local pos3D = regionInfo:getPosition()
  if regionInfo:hasBaseWaypoint() then
    pos3D = regionInfo:getPosition()
  elseif 249 == self._selectedRegionKey then
    pos3D = float3(-337181.94, 10127, -248922)
  elseif 948 == self._selectedRegionKey then
    pos3D = float3(32478, -8076, 254519)
  elseif 949 == self._selectedRegionKey then
    pos3D = float3(143790, -7280, 423527)
  elseif 688 == self._selectedRegionKey or 689 == self._selectedRegionKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_DESERTALERT"))
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), false, false)
end
function PaGlobal_DropItem_All:updateConsoleKey(isSnapRight)
  self._ui._console._txt_wayPointKey:SetShow(isSnapRight)
  self._ui._console._txt_selectKey:SetShow(true)
  self._ui._console._txt_closeKey:SetShow(true)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui._console._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
