function PaGlobal_SeasonReward_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_SeasonReward_All, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.list2_season = UI.getChildControl(Panel_Window_SeasonReward_All, "List2_LeftContent")
  self._ui.stc_centerBG = UI.getChildControl(Panel_Window_SeasonReward_All, "Static_CenterBG01")
  self._ui.stc_topBG = UI.getChildControl(self._ui.stc_centerBG, "Static_TopBG")
  self._ui.stc_slotGroup = UI.getChildControl(self._ui.stc_topBG, "Static_SlotSelectGroup")
  self._ui.template_radioSlot = UI.getChildControl(self._ui.stc_slotGroup, "RadioButton_ItemSlotBG")
  self._ui.txt_seasonTitle = UI.getChildControl(self._ui.stc_topBG, "StaticText_SeasonTitle")
  self._ui.stc_rewardBG = UI.getChildControl(self._ui.stc_centerBG, "Static_RewardBG")
  self._ui.stc_itemSlotBG = UI.getChildControl(self._ui.stc_rewardBG, "Static_ItemSlotBG")
  self._ui.stc_itemSlot = UI.getChildControl(self._ui.stc_itemSlotBG, "Static_ItemSlot")
  self._ui.txt_itemName = UI.getChildControl(self._ui.stc_rewardBG, "StaticText_MasterpieceName")
  self._ui.txt_ready = UI.getChildControl(self._ui.stc_rewardBG, "StaticText_Ready")
  self._ui.txt_complete = UI.getChildControl(self._ui.stc_rewardBG, "StaticText_Complete")
  self._ui.txt_lock = UI.getChildControl(self._ui.stc_rewardBG, "StaticText_Lock")
  self._ui.stc_normalEffect = UI.getChildControl(self._ui.stc_rewardBG, "Static_Effect_Normal")
  self._ui.stc_exchangeEffect = UI.getChildControl(self._ui.stc_rewardBG, "Static_Effect_Exchange")
  self._ui.stc_descBG = UI.getChildControl(self._ui.stc_centerBG, "Static_Condition_Desc")
  self._ui.txt_conditionDesc = UI.getChildControl(self._ui.stc_descBG, "MultilineText_Condition")
  self._ui.stc_bottomBG = UI.getChildControl(self._ui.stc_centerBG, "Static_BottomBg")
  self._ui.txt_ticketCount = UI.getChildControl(self._ui.stc_bottomBG, "StaticText_CurrentPrice_Value")
  self._ui.btn_exchange = UI.getChildControl(self._ui.stc_centerBG, "Button_Exchange")
  self._ui.stc_keyguideBG = UI.getChildControl(Panel_Window_SeasonReward_All, "Static_ButtonGuide_C")
  self._ui.stc_keyguideA = UI.getChildControl(self._ui.stc_keyguideBG, "Static_GuideA_C")
  self._ui.stc_keyguideB = UI.getChildControl(self._ui.stc_keyguideBG, "Static_GuideB_C")
  local rewardSlot = {}
  SlotItem.new(rewardSlot, "slotIcon_" .. 1, 1, self._ui.stc_itemSlot, self._slotConfig)
  rewardSlot:createChild()
  self._ui.rewardItemSlot = rewardSlot
  for index = 1, self._maxRewardCount do
    local radioButton = UI.cloneControl(self._ui.template_radioSlot, self._ui.stc_slotGroup, "RadioButton_ItemSlot" .. tostring(index))
    local selectIcon = UI.getChildControl(radioButton, "Static_SelectTexture")
    local slot = {}
    SlotItem.new(slot, "slotIcon_" .. index, index, radioButton, self._slotConfig)
    slot:createChild()
    slot.selectIcon = selectIcon
    slot.bg = radioButton
    slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SeasonReward_All_SelectRewardIndex(" .. index .. ")")
    self._ui.rewardSlotList[index] = slot
  end
  self._ui.template_radioSlot:SetShow(false)
  self._slotGroupSizeX = self._ui.stc_slotGroup:GetSizeX()
  self._ui.txt_complete:SetText("<PAColor0xff76b24d>" .. self._ui.txt_complete:GetText() .. "<PAOldColor>")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SeasonReward_All:registEventHandler()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_SeasonReward_All_OnScreenResize")
  registerEvent("FromClient_ResponseSelectSeasonReward", "FromClient_SeasonReward_All_ResponseSelectSeasonReward")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SeasonReward_All_Close()")
  self._ui.btn_exchange:addInputEvent("Mouse_LUp", "PaGlobal_SeasonReward_All_ReceiveReward()")
  self._ui.list2_season:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SeasonReward_All_CreateSeasonList")
  self._ui.list2_season:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_SeasonReward_All:listUpdate()
  local seasonCount = ToClient_getSeasonCount()
  self._ui.list2_season:getElementManager():clearKey()
  for index = 1, seasonCount do
    self._ui.list2_season:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_SeasonReward_All:contentUpdate()
  local isReceivable = false
  local lastClearSeasonNo = ToClient_getCompleteLastSeasonNo()
  local isReceivedReward = ToClient_isSelectedRewardSeasonNo(self._selectedSeasonNo)
  if lastClearSeasonNo < self._selectedSeasonNo then
    isReceivable = false
  elseif true == isReceivedReward then
    isReceivable = false
  else
    isReceivable = true
  end
  self._ui.btn_exchange:SetEnable(isReceivable)
  self._ui.btn_exchange:SetMonoTone(not isReceivable)
  self._ui.rewardItemSlot.icon:SetMonoTone(not isReceivable)
  local seasonRewardCount = ToClient_getRewardCountBySeason(self._selectedSeasonNo)
  if 2 <= seasonRewardCount then
    self._ui.stc_slotGroup:SetShow(true)
    self._ui.txt_seasonTitle:ComputePos()
    self:rewardListUpdate(seasonRewardCount, isReceivable)
  else
    self._ui.stc_slotGroup:SetShow(false)
    self._ui.txt_seasonTitle:SetPosY(self._ui.stc_slotGroup:GetPosY())
  end
  local seasonRewardStaticStatus = getSeasonRewardStaticStatus(self._selectedSeasonNo)
  if nil ~= seasonRewardStaticStatus then
    local seasonNameKey = seasonRewardStaticStatus:getSeasonName()
    local seasonName = PAGetString(Defines.StringSheet_GAME, seasonNameKey)
    self._ui.txt_seasonTitle:SetText(seasonName)
    local descKey = seasonRewardStaticStatus:getDescription()
    local desc = PAGetString(Defines.StringSheet_GAME, descKey)
    self._ui.txt_conditionDesc:SetText(desc)
  else
    self._ui.txt_seasonTitle:SetText("")
    self._ui.txt_conditionDesc:SetText("")
  end
  local rewardItemEnchantKey = ToClient_getRewardByIndex(self._selectedSeasonNo, self._selectedItemIndex - 1)
  if nil == rewardItemEnchantKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(rewardItemEnchantKey)
  if nil == itemSSW then
    return
  end
  self._ui.rewardItemSlot:setItemByStaticStatus(itemSSW)
  self._ui.rewardItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SeasonReward_All_ShowRewardItemTooltip(true, " .. rewardItemEnchantKey:getItemKey() .. "," .. rewardItemEnchantKey:getEnchantLevel() .. ")")
  self._ui.rewardItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SeasonReward_All_ShowRewardItemTooltip(false)")
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local itemName = itemSSW:getName()
  if 0 < enchantLevel then
    if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == itemSSW:isSpecialEnchantItem() then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemSSW:getName()
    elseif 1 == itemSSW:getItemType() and 15 < enchantLevel then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemSSW:getName()
    end
  end
  self._ui.txt_itemName:SetText(itemName)
  self._ui.txt_ready:SetShow(false)
  self._ui.txt_complete:SetShow(false)
  self._ui.txt_lock:SetShow(false)
  if lastClearSeasonNo < self._selectedSeasonNo then
    self._ui.txt_lock:SetShow(true)
    local latestSeasonNo = ToClient_getSeasonCount()
    self._ui.txt_lock:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONREWARDSELECT_LOCK"))
  elseif true == isReceivedReward then
    self._ui.txt_complete:SetShow(true)
  else
    self._ui.txt_ready:SetShow(true)
  end
  local haveTicketCount = ToClient_getRemainCompleteSeasonCount()
  self._ui.txt_ticketCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SEASONREWARDSELECT_TICKET_COUNT", "count", haveTicketCount))
  self._ui.stc_normalEffect:EraseAllEffect()
  if true == isReceivable then
    self._ui.stc_normalEffect:AddEffect("fUI_Season_Gift_01B", true, 0, 0)
    audioPostEvent_SystemUi(28, 1)
    _AudioPostEvent_SystemUiForXBOX(28, 1)
  end
end
function PaGlobal_SeasonReward_All:rewardListUpdate(rewardCount, isReceivable)
  for index = 1, self._maxRewardCount do
    local slot = self._ui.rewardSlotList[index]
    if nil == slot then
      return
    end
    slot.icon:SetMonoTone(not isReceivable)
    if rewardCount < index then
      slot.bg:SetShow(false)
      slot.bg:SetCheck(false)
    else
      slot.bg:SetShow(true)
      local isSelected = index == self._selectedItemIndex
      slot.selectIcon:SetShow(isSelected)
      slot.bg:SetCheck(isSelected)
      local rewardItemEnchantKey = ToClient_getRewardByIndex(self._selectedSeasonNo, index - 1)
      if nil == rewardItemEnchantKey then
        return
      end
      local itemSSW = getItemEnchantStaticStatus(rewardItemEnchantKey)
      if nil == itemSSW then
        return
      end
      slot:setItemByStaticStatus(itemSSW)
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SeasonReward_All_ShowListItemTooltip(true, " .. index .. ", " .. rewardItemEnchantKey:getItemKey() .. "," .. rewardItemEnchantKey:getEnchantLevel() .. ")")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SeasonReward_All_ShowListItemTooltip(false)")
      local slotTotalSize = self._slotSizeX * rewardCount
      local startPosX = (self._slotGroupSizeX - slotTotalSize) * 0.5
      slot.bg:SetPosX(startPosX + self._slotSizeX * (index - 1))
    end
  end
end
function PaGlobal_SeasonReward_All:prepareOpen()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  self._selectedSeasonNo = 1
  PaGlobal_SeasonReward_All:listUpdate()
  PaGlobal_SeasonReward_All:contentUpdate()
  PaGlobal_SeasonReward_All:open()
end
function PaGlobal_SeasonReward_All:open()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  Panel_Window_SeasonReward_All:SetShow(true)
end
function PaGlobal_SeasonReward_All:prepareClose()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  PaGlobal_SeasonReward_All:close()
end
function PaGlobal_SeasonReward_All:close()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
  Panel_Window_SeasonReward_All:SetShow(false)
end
function PaGlobal_SeasonReward_All:validate()
  if nil == Panel_Window_SeasonReward_All then
    return
  end
end
