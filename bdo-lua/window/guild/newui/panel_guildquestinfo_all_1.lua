function PaGlobal_GuildQuestInfo_All:initialize()
  if true == PaGlobal_GuildQuestInfo_All._initialize or nil == Panel_GuildQuestInfo_All then
    return
  end
  self._ui.stc_TitleArea = UI.getChildControl(Panel_GuildQuestInfo_All, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Win_Close")
  self._ui.stc_MainArea = UI.getChildControl(Panel_GuildQuestInfo_All, "Static_MainArea")
  self._ui.txt_QuestTitle = UI.getChildControl(self._ui.stc_MainArea, "StaticText_QuestTitle")
  self._ui.txt_QuestDesc = UI.getChildControl(self._ui.stc_MainArea, "StaticText_QuestDesc")
  self._ui.txt_QuestCondition = UI.getChildControl(self._ui.stc_MainArea, "StaticText_QuestCondition")
  self._ui.txt_QuestTime = UI.getChildControl(self._ui.stc_MainArea, "StaticText_QuestLimitTime")
  self._ui.txt_QuestFunds = UI.getChildControl(self._ui.stc_MainArea, "StaticText_QuestGuildFunds")
  self._ui.stc_SlotArea = UI.getChildControl(self._ui.stc_MainArea, "Static_SlotArea")
  self._ui.stc_MoneyArea = UI.getChildControl(self._ui.stc_SlotArea, "Static_MoneyArea")
  self._ui.txt_RewardMoney = UI.getChildControl(self._ui.stc_MoneyArea, "StaticText_QuestRewardMoney")
  self._ui.stc_BaseArea = UI.getChildControl(self._ui.stc_SlotArea, "Static_BaseArea")
  self._ui.txt_MoneyTitle = UI.getChildControl(self._ui.stc_MoneyArea, "StaticText_MoneyTitle")
  local baseArea = UI.getChildControl(self._ui.stc_SlotArea, "Static_BaseArea")
  self._ui.txt_BaseTitle = UI.getChildControl(baseArea, "StaticText_BaseTitle")
  self._ui.txt_MoneyTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_BaseTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_MoneyTitle:SetText(self._ui.txt_MoneyTitle:GetText())
  self._ui.txt_BaseTitle:SetText(self._ui.txt_BaseTitle:GetText())
  local slotBg = UI.createAndCopyBasePropertyControl(self._ui.stc_SlotArea, "Static_SlotBG", self._ui.stc_MoneyArea, "MoneySlotBg")
  self._moneySlot = {}
  SlotItem.new(self._moneySlot, "MoneyReward", 0, slotBg, self._rewardSlotConfig)
  self._moneySlot:createChild()
  self._moneySlot.slotBg = slotBg
  Panel_Tooltip_Item_SetPosition(0, self._moneySlot, "Dialog_GuildQuestReward_Money")
  for slotIdx = 0, self._defaultSlotCount - 1 do
    local slotBg = UI.createAndCopyBasePropertyControl(self._ui.stc_SlotArea, "Static_SlotBG", self._ui.stc_BaseArea, "RewardSlotBg_" .. slotIdx)
    slotBg:SetPosX(slotBg:GetPosX() + self._slotXGap * math.floor(slotIdx % 6))
    slotBg:SetPosY(slotBg:GetPosY() + self._slotYGap * math.floor(slotIdx / 6))
    local slot = {}
    SlotItem.new(slot, "BaseReward_" .. slotIdx, slotIdx, slotBg, self._rewardSlotConfig)
    slot:createChild()
    slot.slotBg = slotBg
    Panel_Tooltip_Item_SetPosition(slotIdx, slot, "Dialog_GuildQuestReward_Base")
    self._rewardSlot[slotIdx] = slot
  end
  self._rewardSlot[11].slotBg:SetIgnore(true)
  self._ui.btn_function = UI.getChildControl(Panel_GuildQuestInfo_All, "Button_Function")
  self._ui.stc_KeyGuideArea = UI.getChildControl(Panel_GuildQuestInfo_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuideX = UI.getChildControl(self._ui.stc_KeyGuideArea, "StaticText_X_ConsoleUI")
  self._ui.stc_KeyGuideA = UI.getChildControl(self._ui.stc_KeyGuideArea, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuideB = UI.getChildControl(self._ui.stc_KeyGuideArea, "StaticText_B_ConsoleUI")
  self._keyGuides = {
    self._ui.stc_KeyGuideX,
    self._ui.stc_KeyGuideA,
    self._ui.stc_KeyGuideB
  }
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_QuestTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_QuestDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_QuestCondition:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_QuestFunds:SetShow(false)
  PaGlobal_GuildQuestInfo_All:validate()
  PaGlobal_GuildQuestInfo_All:registEventHandler(self._isConsole)
  PaGlobal_GuildQuestInfo_All:swichPlatform(self._isConsole)
  PaGlobal_GuildQuestInfo_All._initialize = true
end
function PaGlobal_GuildQuestInfo_All:registEventHandler(isConsole)
  if nil == Panel_GuildQuestInfo_All then
    return
  end
  registerEvent("ResponseUpdateGuildQuest", "PaGlobal_GuildQuestInfo_UpdateProgressingQuest_All")
  if isConsole then
    PaGlobal_registerPanelOnBlackBackground(Panel_GuildQuestInfo_All)
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_Close_All()")
  end
end
function PaGlobal_GuildQuestInfo_All:swichPlatform(isConsole)
  if isConsole then
    self._ui.btn_function:SetShow(false)
    self._ui.btn_Close:SetShow(false)
  end
end
function PaGlobal_GuildQuestInfo_All:prepareOpen()
  if true == self._isProgressingQuest then
    self:updateProgressingQuest()
  else
    self:update()
  end
  self:open()
end
function PaGlobal_GuildQuestInfo_All:open()
  Panel_GuildQuestInfo_All:SetShow(true)
end
function PaGlobal_GuildQuestInfo_All:prepareClose()
  self:close()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_GuildQuestInfo_All:close()
  Panel_GuildQuestInfo_All:SetShow(false)
end
function PaGlobal_GuildQuestInfo_All:validate()
  if nil == Panel_GuildQuestInfo_All then
    return
  end
end
function PaGlobal_GuildQuestInfo_All:resizePanel(isMoneyShow)
  self._ui.stc_MoneyArea:SetShow(isMoneyShow)
  if isMoneyShow then
    self._ui.stc_BaseArea:SetPosY(self._ui.stc_MoneyArea:GetSizeY())
  else
    self._ui.stc_BaseArea:SetPosY(0)
  end
  self._ui.stc_SlotArea:SetSize(self._ui.stc_SlotArea:GetSizeX(), self._ui.stc_BaseArea:GetPosY() + self._ui.stc_BaseArea:GetSizeY() + self._gapSizeYSmall)
  if self._isProgressingQuest then
    self._ui.stc_SlotArea:SetPosY(self._ui.txt_QuestCondition:GetPosY() + self._ui.txt_QuestCondition:GetTextSizeY() + self._gapSizeYSmall)
  else
    self._ui.stc_SlotArea:SetPosY(self._ui.txt_QuestTime:GetPosY() + self._ui.txt_QuestTime:GetSizeY() + self._gapSizeYSmall)
  end
  local totalMainSizeY = self._ui.stc_SlotArea:GetPosY() + self._ui.stc_SlotArea:GetSizeY()
  local currentSizeY = self._ui.stc_MainArea:GetSizeY()
  if currentSizeY == totalMainSizeY then
    return
  end
  local gapSizeY = totalMainSizeY - currentSizeY
  self._ui.stc_MainArea:SetSize(self._ui.stc_MainArea:GetSizeX(), totalMainSizeY)
  Panel_GuildQuestInfo_All:SetSize(Panel_GuildQuestInfo_All:GetSizeX(), Panel_GuildQuestInfo_All:GetSizeY() + gapSizeY)
  self._ui.btn_function:ComputePos()
  self._ui.stc_KeyGuideArea:ComputePos()
end
function PaGlobal_GuildQuestInfo_All:update()
  if nil == Panel_GuildQuestInfo_All then
    return
  end
  local questInfo = PaGlobal_GuildQuest_GetQuestInfo_ByIndex(self._currentQuestIndex)
  self._acceptQuestIndex = questInfo._questIndex
  if nil == questInfo then
    return
  end
  local requireGuildRank = questInfo:getGuildQuestGrade()
  local requireGuildRankStr = ""
  if 1 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif 2 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif 3 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  elseif 4 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  self._ui.txt_QuestTitle:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", questInfo:getTitle(), "requireGuildRankStr", requireGuildRankStr))
  self._ui.txt_QuestCondition:SetShow(false)
  self._ui.txt_QuestDesc:SetPosY(self._ui.txt_QuestTitle:GetPosY() + self._ui.txt_QuestTitle:GetTextSizeY() + self._gapSizeYBig)
  self._ui.txt_QuestDesc:SetText(questInfo:getDesc())
  local isShowPreOcc = false
  if false == isShowPreOcc then
    local questTime = PaGlobal_GuildQuest_GetQuestTimeFormatString(questInfo:getLimitMinute())
    self._ui.txt_QuestTime:SetText(questTime)
    self._ui.txt_QuestTime:SetShow(true)
    self._ui.txt_QuestTime:SetPosY(self._ui.txt_QuestDesc:GetPosY() + self._ui.txt_QuestDesc:GetTextSizeY() + self._gapSizeYBig)
  else
    self._ui.txt_QuestTime:SetShow(false)
  end
  local baseRewardTable = {}
  local slotIndex = 0
  local isMoneyShow = false
  for baseIndex = 0, self._defaultSlotCount - 1 do
    local baseReward = questInfo:getGuildQuestBaseRewardAt(baseIndex)
    if nil ~= baseReward then
      self._rewardSlot[slotIndex].slotBg:SetIgnore(false)
      if __eRewardItem == baseReward:getType() then
        local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(baseReward:getItemEnchantKey()))
        if 1 == itemStatic:get()._key:getItemKey() then
          self:setMoneySlot(baseReward, itemStatic)
          isMoneyShow = true
        else
          self:setReward(baseReward, slotIndex)
          self._rewardSlot[slotIndex].icon:SetShow(true)
          slotIndex = slotIndex + 1
        end
      else
        self:setReward(baseReward, slotIndex)
        self._rewardSlot[slotIndex].icon:SetShow(true)
        slotIndex = slotIndex + 1
      end
    else
      self._rewardSlot[slotIndex].icon:SetShow(false)
      self._rewardSlot[slotIndex].slotBg:SetIgnore(true)
      slotIndex = slotIndex + 1
    end
  end
  if self._isConsole then
    self:alignKeyGuides()
  elseif ToClient_isProgressingGuildQuest() then
    self._ui.btn_function:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self._ui.btn_function:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_Close_All()")
  else
    self._ui.btn_function:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_QUEST_BTN_LIST_C_ACCEPT"))
    self._ui.btn_function:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildQuestInfo_AcceptQuest_All()")
  end
  self:resizePanel(isMoneyShow)
end
function PaGlobal_GuildQuestInfo_All:setMoneySlot(moneyReward, itemStatic)
  local count = moneyReward:getItemCount()
  self._moneySlot._item = moneyReward:getItemEnchantKey()
  self._moneySlot:setItemByStaticStatus(itemStatic, count)
  self._moneySlot.count:SetShow(false)
  self._ui.txt_RewardMoney:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDQUEST_REWARD_MONEY_TXT", "count", makeDotMoney(count)))
  if self._isConsole then
    if true == _ContentsGroup_RenewUI_Tooltip then
      self._moneySlot.slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_GuildQuestInfo_All_ItemTooltip(" .. self._moneySlot._item .. ")")
    else
      self._moneySlot.slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. 0 .. ",\"Dialog_GuildQuestReward_Money\",true)")
    end
  else
    self._moneySlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. 0 .. ",\"Dialog_GuildQuestReward_Money\",true)")
  end
  self._moneySlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. 0 .. ",\"Dialog_GuildQuestReward_Money\",false)")
end
function PaGlobal_GuildQuestInfo_All:setReward(reward, idx)
  local uiSlot = self._rewardSlot[idx]
  local rewardType = reward:getType()
  local questType = "guild"
  uiSlot._type = reward:getType()
  uiSlot:clearItem()
  uiSlot.icon:SetAlpha(1)
  local mouseOnEnvet, mouseOutEvent
  if __eRewardExp == rewardType then
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    mouseOnEnvet = "rewardTooltip( \"Exp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"Exp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardSkillExp == rewardType then
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds")
    mouseOnEnvet = "rewardTooltip( \"SkillExp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"SkillExp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardExpGrade == rewardType then
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds")
    mouseOnEnvet = "rewardTooltip( \"ExpGrade\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"ExpGrade\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardSkillExpGrade == rewardType then
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds")
    mouseOnEnvet = "rewardTooltip( \"SkillExpGrade\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"SkillExpGrade\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardLifeExp == rewardType then
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds")
    mouseOnEnvet = "rewardTooltip( \"ProductExp\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"ProductExp\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardItem == rewardType then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward:getItemEnchantKey()))
    uiSlot:setItemByStaticStatus(itemStatic, reward:getItemCount())
    uiSlot._item = reward:getItemEnchantKey()
    mouseOnEnvet = "Panel_Tooltip_Item_Show_GeneralStatic(" .. idx .. ",\"Dialog_GuildQuestReward_Base\",true)"
    mouseOutEvent = "Panel_Tooltip_Item_Show_GeneralStatic(" .. idx .. ",\"Dialog_GuildQuestReward_Base\",false)"
  elseif __eRewardIntimacy == rewardType then
    uiSlot.count:SetText(tostring(reward:getIntimacyValue()))
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/00000000_Special_Contributiveness.dds")
    mouseOnEnvet = "rewardTooltip( \"Intimacy\", true, \"" .. questType .. "\", " .. idx .. " )"
    mouseOutEvent = "rewardTooltip( \"Intimacy\", false, \"" .. questType .. "\", " .. idx .. " )"
  elseif __eRewardKnowledge == rewardType then
    uiSlot.count:SetText("")
    uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds")
    mouseOnEnvet = "rewardTooltip( \"Knowledge\", true, \"" .. questType .. "\", " .. idx .. "," .. reward._mentalCard .. " )"
    mouseOutEvent = "rewardTooltip( \"Knowledge\", false, \"" .. questType .. "\", " .. idx .. "," .. reward._mentalCard .. " )"
  else
    mouseOnEnvet = ""
    mouseOutEvent = ""
  end
  if nil == mouseOnEnvet or nil == mouseOutEvent then
    return
  end
  if self._isConsole and true == _ContentsGroup_RenewUI_Tooltip then
    uiSlot.icon:addInputEvent("Mouse_On", "")
    uiSlot.icon:addInputEvent("Mouse_Out", "")
    uiSlot.slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_GuildQuestInfo_All_ItemTooltip(" .. reward:getItemEnchantKey() .. ")")
  elseif self._isConsole then
    uiSlot.slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, mouseOnEnvet)
    uiSlot.slotBg:addInputEvent("Mouse_Out", mouseOutEvent)
  else
    uiSlot.icon:addInputEvent("Mouse_On", mouseOnEnvet)
    uiSlot.icon:addInputEvent("Mouse_Out", mouseOutEvent)
  end
end
function PaGlobal_GuildQuestInfo_All:updateProgressingQuest()
  if false == ToClient_isProgressingGuildQuest() then
    self:close()
    return
  end
  local requireGuildRank = ToClient_getCurrentGuildQuestGrade()
  local requireGuildRankStr = ""
  if 1 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif 2 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif 3 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  elseif 4 == requireGuildRank then
    requireGuildRankStr = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  self._ui.txt_QuestTitle:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_LIMIT", "currentGuildQuestName", ToClient_getCurrentGuildQuestName(), "requireGuildRankStr", requireGuildRankStr))
  self._ui.txt_QuestDesc:SetPosY(self._ui.txt_QuestTitle:GetPosY() + self._ui.txt_QuestTitle:GetTextSizeY() + self._gapSizeYBig)
  self._ui.txt_QuestDesc:SetText(ToClient_getCurrentGuildQuestDesc())
  local conditionStr = ""
  local questConditionCount = ToClient_getCurrentGuildQuestConditionCount()
  for idx = 0, questConditionCount - 1 do
    local currentGuildQuestInfo = ToClient_getCurrentGuildQuestConditionAt(idx)
    conditionStr = conditionStr .. currentGuildQuestInfo._desc .. " ( " .. currentGuildQuestInfo._currentCount .. " / " .. currentGuildQuestInfo._destCount .. " ) " .. "\n"
  end
  self._ui.txt_QuestCondition:SetText(conditionStr)
  self._ui.txt_QuestCondition:SetShow(true)
  self._ui.txt_QuestCondition:SetPosY(self._ui.txt_QuestDesc:GetPosY() + self._ui.txt_QuestDesc:GetTextSizeY() + self._gapSizeYSmall)
  self._ui.txt_QuestTime:SetShow(false)
  local baseRewardTable = {}
  local slotIndex = 0
  local isMoneyShow = false
  for baseIndex = 0, self._defaultSlotCount - 1 do
    local baseReward = ToClient_getCurrentGuildQuestBaseRewardAt(baseIndex)
    if nil ~= baseReward then
      self._rewardSlot[slotIndex].slotBg:SetIgnore(false)
      if __eRewardItem == baseReward:getType() then
        local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(baseReward:getItemEnchantKey()))
        if 1 == itemStatic:get()._key:getItemKey() then
          self:setMoneySlot(baseReward, itemStatic)
          isMoneyShow = true
        else
          self:setReward(baseReward, slotIndex)
          self._rewardSlot[slotIndex].icon:SetShow(true)
          slotIndex = slotIndex + 1
        end
      else
        self:setReward(baseReward, slotIndex)
        self._rewardSlot[slotIndex].icon:SetShow(true)
        slotIndex = slotIndex + 1
      end
    else
      self._rewardSlot[slotIndex].icon:SetShow(false)
      self._rewardSlot[slotIndex].slotBg:SetIgnore(true)
      slotIndex = slotIndex + 1
    end
  end
  self._ui.btn_function:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
  self._ui.btn_function:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_Close_All()")
  self:alignKeyGuides()
  self:resizePanel(isMoneyShow)
end
function PaGlobal_GuildQuestInfo_All:alignKeyGuides()
  if not self._isConsole then
    return
  end
  local isProgressing = ToClient_isProgressingGuildQuest()
  self._ui.stc_KeyGuideA:SetShow(not isProgressing)
  if isProgressing then
    Panel_GuildQuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  else
    Panel_GuildQuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildQuestInfo_AcceptQuest_All()")
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuides, self._ui.stc_KeyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
