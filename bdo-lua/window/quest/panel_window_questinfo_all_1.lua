function PaGlobal_QuestInfo_All:initialize()
  if true == PaGlobal_QuestInfo_All._initialize then
    return
  end
  PaGlobal_QuestInfo_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_QuestInfo_All:ControlAll_Init()
  PaGlobal_QuestInfo_All:ControlPc_Init()
  PaGlobal_QuestInfo_All:ControlConsole_Init()
  PaGlobal_QuestInfo_All:ControlSetShow()
  PaGlobal_QuestInfo_All:registEventHandler()
  PaGlobal_QuestInfo_All:validate()
  PaGlobal_QuestInfo_All._initialize = true
end
function PaGlobal_QuestInfo_All:ControlAll_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_TitleBg")
  self._ui.stc_subBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_SubBg")
  self._ui.txt_attributionType = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestAttribution")
  self._ui.txt_questGroupTitle = UI.getChildControl(self._ui.stc_subBg, "StaticText_GroupTitle")
  self._ui.txt_questTitle = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestTitle")
  self._ui.chk_autoNavi = UI.getChildControl(self._ui.stc_subBg, "CheckButton_ListMain_AutoNavi")
  self._ui.chk_questNavi = UI.getChildControl(self._ui.stc_subBg, "Checkbox_ListMain_QuestNavi")
  self._ui.chk_questGiveUp = UI.getChildControl(self._ui.stc_subBg, "Checkbox_ListMain_QuestGiveup")
  self._ui.stc_questIconBg = UI.getChildControl(self._ui.stc_subBg, "Static_QuestIconBG")
  self._ui.stc_questIcon = UI.getChildControl(self._ui.stc_questIconBg, "Static_QuestIcon")
  self._ui.txt_acceptNPC = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestAcceptNPC")
  self._ui.txt_completeNPC = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestCompleteNpc")
  self._ui.txt_condition = UI.getChildControl(self._ui.stc_subBg, "StaticText_QuestCondition")
  self._ui.frame_questDesc = UI.getChildControl(self._ui.stc_subBg, "Frame_QuestDesc")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_questDesc, "Frame_1_Content")
  self._ui.txt_frameDesc = UI.getChildControl(self._ui.frame_content, "StaticText_Desc")
  self._ui.stc_rewardGroupBg = UI.getChildControl(self._ui.stc_subBg, "Static_RewardGroup")
  self._ui.stc_baseRewardBg = UI.getChildControl(self._ui.stc_rewardGroupBg, "Static_BaseRewardBG")
  self._ui.txt_baseRewardTitle = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlotBg[index] = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._baseRewardSlot[index] = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Slot_" .. index)
    if true == self._isConsole then
      self._ui._baseRewardSlotBg[index]:SetIgnore(false)
      self._ui._baseRewardSlot[index]:SetIgnore(true)
    end
  end
  self._ui.stc_selectRewardBg = UI.getChildControl(self._ui.stc_rewardGroupBg, "Static_SelectRewardBG")
  self._ui.txt_selectRewardTitle = UI.getChildControl(self._ui.stc_baseRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlotBg[index] = UI.getChildControl(self._ui.stc_selectRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._selectRewardSlot[index] = UI.getChildControl(self._ui.stc_selectRewardBg, "Static_Slot_" .. index)
    if true == self._isConsole then
      self._ui._selectRewardSlotBg[index]:SetIgnore(false)
      self._ui._selectRewardSlot[index]:SetIgnore(true)
    end
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlot[index]:SetIgnore(true)
    self._uiBackBaseReward[index] = self._ui._baseRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "BaseReward_" .. index, index, self._ui._baseRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_On", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listBaseRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Base")
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlot[index]:SetIgnore(true)
    self._uiBackSelectReward[index] = self._ui._selectRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "SelectReward_" .. index, index, self._ui._selectRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_On", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listSelectRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Select")
  end
  self._originDescBgSizeY = self._ui.frame_questDesc:GetSizeY()
end
function PaGlobal_QuestInfo_All:ControlPc_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui_pc.btn_giveUp = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Quest_GiveUp")
  self._ui_pc.btn_callSpirit = UI.getChildControl(Panel_Window_QuestInfo_All, "Button_Quest_CallSpirit")
  self._ui_pc.chk_questNavi = UI.getChildControl(Panel_Window_QuestInfo_All, "CheckBtn_Quest_Navi")
  self._ui_pc.chk_autoNavi = UI.getChildControl(Panel_Window_QuestInfo_All, "CheckBtn_Quest_AutoNavi")
end
function PaGlobal_QuestInfo_All:ControlConsole_Init()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_QuestInfo_All, "Static_ConsoleKeyGuide")
  self._ui_console.stc_tooltip = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_ItemInfo")
  self._ui_console.stc_scroll = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Scroll")
  self._ui_console.stc_giveUp = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Giveup")
  self._ui_console.stc_navi = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Navi")
  self._ui_console.stc_close = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Close")
end
function PaGlobal_QuestInfo_All:ControlSetShow()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_giveUp:SetShow(false)
    self._ui_pc.btn_callSpirit:SetShow(false)
    self._ui_pc.chk_questNavi:SetShow(false)
    self._ui_pc.chk_autoNavi:SetShow(false)
    self._ui_console.stc_keyGuideBg:SetShow(true)
    self._ui_console.stc_scroll:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_giveUp:SetShow(true)
    self._ui_pc.btn_callSpirit:SetShow(true)
    self._ui_pc.chk_questNavi:SetShow(true)
    self._ui_pc.chk_autoNavi:SetShow(true)
    self._ui_console.stc_keyGuideBg:SetShow(false)
    self._ui_console.stc_scroll:SetShow(false)
  end
end
function PaGlobal_QuestInfo_All:resetCheckButton()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui_pc.chk_questNavi:SetCheck(false)
  self._ui_pc.chk_autoNavi:SetCheck(false)
  self._ui.chk_autoNavi:SetCheck(false)
  self._ui.chk_questNavi:SetCheck(false)
end
function PaGlobal_QuestInfo_All:prepareOpen()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobal_QuestInfo_All:resetControlShow()
  PaGlobal_QuestInfo_All:update()
  PaGlobal_QuestInfo_All:rePosition()
  PaGlobal_QuestInfo_All:open()
end
function PaGlobal_QuestInfo_All:open()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_QuestInfo_All:GetShow() then
    return
  end
  if true == self._isConsole or true == Panel_Window_Quest_All:IsUISubApp() then
    Panel_Window_QuestInfo_All:SetShow(true)
  else
    Panel_Window_QuestInfo_All:SetShow(true, true)
  end
end
function PaGlobal_QuestInfo_All:prepareClose()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_QuestInfo_All:IsUISubApp() then
    Panel_Window_QuestInfo_All:CloseUISubApp()
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_QuestInfo_All:close()
end
function PaGlobal_QuestInfo_All:close()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._OpenInfo = {}
  Panel_Window_QuestInfo_All:SetShow(false, false)
end
function PaGlobal_QuestInfo_All:update()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  PaGlobal_QuestInfo_All:infoUpdate()
  PaGlobal_QuestInfo_All:rewardUpdate()
  PaGlobal_QuestInfo_All:resize()
  if true == Panel_Window_Quest_All:IsUISubApp() then
    PaGlobal_QuestInfo_All:rePosition()
  end
end
function PaGlobal_QuestInfo_All:openInfoSave(groupId, questId, uiCondition, groupTitle, questGroupCount, fromQuestWidget, isRecommand, isNextQuest, isCleared, isAccepted, uiIdx)
  for k, v in ipairs(self._OpenInfo) do
    v = nil
  end
  self._OpenInfo._groupId = groupId
  self._OpenInfo._questId = questId
  self._OpenInfo._uiCondition = uiCondition
  self._OpenInfo._groupTitle = groupTitle
  self._OpenInfo._questGroupCount = questGroupCount
  self._OpenInfo._fromQuestWidget = fromQuestWidget
  self._OpenInfo._isRecommand = isRecommand
  self._OpenInfo._isNextQuest = isNextQuest
  self._OpenInfo._isCleared = isCleared
  self._OpenInfo._isAccepted = isAccepted
  self._OpenInfo._uiIdx = uiIdx
  if nil == uiIdx then
    self._OpenInfo._uiIdx = -1
  end
end
function PaGlobal_QuestInfo_All:resetControlShow()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if false == self._OpenInfo._isCleared or nil == self._OpenInfo._isCleared then
    if false == self._isConsole then
      self._ui_pc.btn_callSpirit:SetShow(true)
      self._ui_pc.btn_giveUp:SetShow(true)
      self._ui_pc.chk_questNavi:SetShow(true)
      self._ui_pc.chk_autoNavi:SetShow(true)
      self._ui.chk_autoNavi:SetShow(true)
      self._ui.chk_questNavi:SetShow(true)
      self._ui.chk_questGiveUp:SetShow(true)
    else
      self._ui_console.stc_tooltip:SetShow(true)
      self._ui_console.stc_giveUp:SetShow(true)
      self._ui_console.stc_navi:SetShow(true)
    end
    self._ui.txt_baseRewardTitle:SetShow(true)
    self._ui.txt_selectRewardTitle:SetShow(true)
    for i = 0, 11 do
    end
  end
end
function PaGlobal_QuestInfo_All:infoUpdate()
  local questInfo = questList_getQuestStatic(self._OpenInfo._groupId, self._OpenInfo._questId)
  if nil == questInfo then
    return
  end
  if nil == self._OpenInfo._isNextQuest then
    self._OpenInfo._isNextQuest = false
  end
  self._ui.txt_questGroupTitle:SetShow(true)
  if "nil" ~= self._OpenInfo._groupTitle then
    local tempValue = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_QUESTINFO_GROUP_TITLE_ALL", "groupTitle", self._OpenInfo._groupTitle, "questId", self._OpenInfo._questId, "questGroupCount", self._OpenInfo._questGroupCount)
    self._ui.txt_questGroupTitle:SetText(tempValue)
  elseif true == self._OpenInfo._isRecommand then
    self._ui.txt_questGroupTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUESTWINDOW_TAB_RECOMMAND"))
  else
    self._ui.txt_questGroupTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_QUESTINFO_NORMAL_TITLE"))
  end
  self._ui.txt_questTitle:SetShow(true)
  self._ui.txt_questTitle:SetText(questInfo:getTitle())
  UI.setLimitTextAndAddTooltip(self._ui.txt_questGroupTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_questTitle)
  if false == self._isConsole then
    self._ui.chk_questNavi:SetShow(true)
    self._ui.chk_questNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
    self._ui.chk_autoNavi:SetShow(true)
    self._ui.chk_autoNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", true, " .. self._OpenInfo._uiIdx .. " )")
    local isProgressQuest = ToClient_isProgressingQuest(self._OpenInfo._groupId, self._OpenInfo._questId)
    self._ui.chk_questGiveUp:SetShow(isProgressQuest)
    self._ui.chk_questGiveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
    self._ui_pc.btn_giveUp:SetShow(not self._OpenInfo._isNextQuest)
    self._ui_pc.btn_giveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
    if 10 > getSelfPlayer():get():getLevel() or nil ~= self._OpenInfo._isAccepted and 0 == self._OpenInfo._isAccepted then
      self._ui.chk_questGiveUp:SetShow(false)
      self._ui_pc.btn_giveUp:SetShow(false)
    end
    self._ui_pc.btn_callSpirit:SetShow(false)
    self._ui_pc.btn_callSpirit:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestInfo_All_CallSpirit()")
    self._ui_pc.chk_questNavi:SetShow(true)
    self._ui_pc.chk_questNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
    self._ui_pc.chk_autoNavi:SetShow(true)
    self._ui_pc.chk_autoNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", true, " .. self._OpenInfo._uiIdx .. " )")
    self._ui.chk_questNavi:SetCheck(false)
    self._ui_pc.chk_questNavi:SetCheck(false)
    self._ui.chk_autoNavi:SetCheck(false)
    self._ui_pc.chk_autoNavi:SetCheck(false)
    local _questGroupId, _questId, _naviInfoAgain, _naviIsAutoRun = _QuestWidget_ReturnQuestState()
    if self._OpenInfo._groupId == _questGroupId and self._OpenInfo._questId == _questId then
      if true == _naviInfoAgain then
        self._ui.chk_questNavi:SetCheck(false)
        self._ui_pc.chk_questNavi:SetCheck(false)
      else
        self._ui.chk_questNavi:SetCheck(true)
        self._ui_pc.chk_questNavi:SetCheck(true)
        if true == _naviIsAutoRun then
          self._ui.chk_autoNavi:SetCheck(true)
          self._ui_pc.chk_autoNavi:SetCheck(true)
        end
      end
    end
    if false == self._OpenInfo._isNextQuest then
      if 0 == self._OpenInfo._uiCondition and 0 == questInfo:getCompleteNpc():get() then
        self._ui.chk_questNavi:SetShow(false)
        self._ui_pc.chk_questNavi:SetShow(false)
        self._ui.chk_autoNavi:SetShow(false)
        self._ui_pc.chk_autoNavi:SetShow(false)
        self._ui_pc.btn_callSpirit:SetShow(true)
      end
      local questPosCount = questInfo:getQuestPositionCount()
      if 0 ~= self._OpenInfo._uiCondition and 0 == questPosCount then
        self._ui.chk_questNavi:SetShow(false)
        self._ui.chk_autoNavi:SetShow(false)
        self._ui_pc.chk_questNavi:SetShow(false)
        self._ui_pc.chk_autoNavi:SetShow(false)
      end
    end
  else
    if false == self._OpenInfo._isNextQuest then
      self._ui_console.stc_giveUp:SetShow(true)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleClicked_QuestWidget_QuestGiveUp(" .. self._OpenInfo._groupId .. "," .. self._OpenInfo._questId .. ")")
    else
      self._ui_console.stc_giveUp:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    if 10 > getSelfPlayer():get():getLevel() or nil ~= self._OpenInfo._isAccepted and 0 == self._OpenInfo._isAccepted then
      self._ui_console.stc_giveUp:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui_console.stc_navi:SetShow(true)
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._OpenInfo._groupId .. ", " .. self._OpenInfo._questId .. ", " .. self._OpenInfo._uiCondition .. ", false, " .. self._OpenInfo._uiIdx .. " )")
    if false == self._OpenInfo._isNextQuest then
      local questPosCount = questInfo:getQuestPositionCount()
      if 0 == self._OpenInfo._uiCondition and 0 == questInfo:getCompleteNpc():get() or 0 ~= self._OpenInfo._uiCondition and 0 == questPosCount then
        self._ui_console.stc_navi:SetShow(false)
        Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    end
  end
  self._ui.stc_questIconBg:SetShow(true)
  self._ui.stc_questIcon:SetShow(true)
  self._ui.stc_questIcon:ChangeTextureInfoName(questInfo:getIconPath())
  local completeNpc = questInfo:getCompleteDisplay()
  self._ui.txt_completeNPC:SetShow(true)
  self._ui.txt_completeNPC:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_completeNPC:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "QUESTLIST_COMPLETETARGET", "getCompleteDisplay", completeNpc))
  local demandCount = questInfo:getDemadCount()
  local demandString = ""
  for demandIndex = 0, demandCount - 1 do
    local demand = questInfo:getDemandAt(demandIndex)
    demandString = demandString .. "- " .. demand._desc .. "\n"
  end
  self._ui.txt_condition:SetShow(true)
  self._ui.txt_condition:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_condition:SetAutoResize(true)
  self._ui.txt_condition:SetText(tostring(ToClient_getReplaceDialog(demandString)))
  local gabY = 20
  self._ui.frame_questDesc:SetSpanSize(self._ui.frame_questDesc:GetSpanSize().x, self._ui.txt_condition:GetSpanSize().y + self._ui.txt_condition:GetSizeY() + 5)
  self._ui.txt_frameDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_frameDesc:SetText(ToClient_getReplaceDialog(questInfo:getDesc()))
  self._ui.txt_frameDesc:setLocalizedStaticType(18)
  self._ui.txt_frameDesc:setLocalizedKey(questInfo:getDescLocalizedKey())
  self._ui.txt_frameDesc:SetIgnore(true)
  self._ui.txt_frameDesc:SetSize(self._ui.txt_frameDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY())
  self._ui.frame_content:SetSize(self._ui.txt_frameDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY())
  if self._originDescBgSizeY < self._ui.txt_frameDesc:GetTextSizeY() + gabY then
    self._ui.frame_questDesc:SetSize(self._ui.frame_questDesc:GetSizeX(), self._originDescBgSizeY)
  else
    self._ui.frame_questDesc:SetSize(self._ui.frame_questDesc:GetSizeX(), self._ui.txt_frameDesc:GetTextSizeY() + gabY)
  end
  self._ui.frame_questDesc:GetVScroll():SetControlTop()
  self._ui.frame_questDesc:UpdateContentScroll()
  self._ui.frame_questDesc:UpdateContentPos()
  UIScroll.SetButtonSize(self._ui.frame_questDesc:GetVScroll(), self._ui.frame_questDesc:GetSizeY(), self._ui.frame_content:GetSizeY())
  self._ui.stc_rewardGroupBg:SetSpanSize(self._ui.stc_rewardGroupBg:GetSpanSize().x, self._ui.frame_questDesc:GetSpanSize().y + self._ui.frame_questDesc:GetSizeY() + 5)
  if true == self._isConsole then
    self._ui.chk_autoNavi:SetShow(false)
    self._ui.chk_questNavi:SetShow(false)
    self._ui.chk_questGiveUp:SetShow(false)
    self._ui_pc.btn_giveUp:SetShow(false)
    self._ui_pc.btn_callSpirit:SetShow(false)
    self._ui_pc.chk_questNavi:SetShow(false)
    self._ui_pc.chk_autoNavi:SetShow(false)
    if true == self._ui.frame_questDesc:GetVScroll():GetShow() then
      self._ui_console.stc_scroll:SetShow(true)
    else
      self._ui_console.stc_scroll:SetShow(false)
    end
  end
end
function PaGlobal_QuestInfo_All:rewardUpdate()
  if true == self._OpenInfo._isCleared then
    self._ui.stc_rewardGroupBg:SetShow(false)
    if false == self._isConsole then
      self._ui.chk_autoNavi:SetShow(false)
      self._ui.chk_questNavi:SetShow(false)
      self._ui.chk_questGiveUp:SetShow(false)
      self._ui_pc.btn_giveUp:SetShow(false)
      self._ui_pc.btn_callSpirit:SetShow(false)
      self._ui_pc.chk_questNavi:SetShow(false)
      self._ui_pc.chk_autoNavi:SetShow(false)
    else
      self._ui_console.stc_tooltip:SetShow(false)
      self._ui_console.stc_giveUp:SetShow(false)
      self._ui_console.stc_navi:SetShow(false)
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
      Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
    end
    return
  end
  self._ui.stc_rewardGroupBg:SetShow(true)
  if nil == self._OpenInfo or nil == self._OpenInfo._groupId or nil == self._OpenInfo._questId then
    UI.ASSERT_NAME(nil ~= self._OpenInfo, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo is nil.", "\234\185\128\236\156\164\236\167\128")
    UI.ASSERT_NAME(nil ~= self._OpenInfo._groupId, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo._groupId is nil.", "\234\185\128\236\156\164\236\167\128")
    UI.ASSERT_NAME(nil ~= self._OpenInfo._questId, "PaGlobal_QuestInfo_All:rewardUpdate() self._OpenInfo._questId is nil.", "\234\185\128\236\156\164\236\167\128")
    return
  end
  local questInfo = questList_getQuestStatic(self._OpenInfo._groupId, self._OpenInfo._questId)
  if nil == questInfo then
    UI.ASSERT_NAME(nil ~= self._OpenInfo._questId, "PaGlobal_QuestInfo_All:rewardUpdate() questInfo is nil.", "\234\185\128\236\156\164\236\167\128")
    return
  end
  local baseCount = questInfo:getQuestBaseRewardCount()
  local selectCount = questInfo:getQuestSelectRewardCount()
  self._baseReward = {}
  for baseIdx = 1, baseCount do
    local baseReward = questInfo:getQuestBaseRewardAt(baseIdx - 1)
    self._baseReward[baseIdx] = {}
    self._baseReward[baseIdx]._type = baseReward:getType()
    if __eRewardExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getExperience()
    elseif __eRewardSkillExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getSkillExperience()
    elseif __eRewardLifeExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getProductExperience()
    elseif __eRewardItem == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._item = baseReward:getItemEnchantKey()
      self._baseReward[baseIdx]._count = baseReward:getItemCount()
    elseif __eRewardIntimacy == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._character = baseReward:getIntimacyCharacter()
      self._baseReward[baseIdx]._value = baseReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._mentalCard = baseReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._season = baseReward:getSeasonNo()
    end
  end
  self._selectReward = {}
  for selectIdx = 1, selectCount do
    local selectReward = questInfo:getQuestSelectRewardAt(selectIdx - 1)
    self._selectReward[selectIdx] = {}
    self._selectReward[selectIdx]._type = selectReward:getType()
    if __eRewardExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getExperience()
    elseif __eRewardSkillExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getSkillExperience()
    elseif __eRewardLifeExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getProductExperience()
    elseif __eRewardItem == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._item = selectReward:getItemEnchantKey()
      self._selectReward[selectIdx]._count = selectReward:getItemCount()
    elseif __eRewardIntimacy == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._character = selectReward:getIntimacyCharacter()
      self._selectReward[selectIdx]._value = selectReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._mentalCard = selectReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._season = selectReward:getSeasonNo()
    end
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackBaseReward[index]:SetShow(false)
    if index < #self._baseReward then
      self:setReward(self._listBaseRewardSlots[index], self._baseReward[index + 1], index, "main")
      self._uiBackBaseReward[index]:SetShow(true)
    end
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackSelectReward[index]:SetShow(false)
    if index < #self._selectReward then
      self:setReward(self._listSelectRewardSlots[index], self._selectReward[index + 1], index, "sub")
      self._uiBackSelectReward[index]:SetShow(true)
    end
  end
end
function PaGlobal_QuestInfo_All:setReward(uiSlot, reward, index, questType)
  uiSlot._type = reward._type
  uiSlot:clearItem()
  uiSlot.count:SetText("")
  uiSlot.icon:SetAlpha(1)
  uiSlot.icon:ChangeTextureInfoName("")
  local texturePathList = {
    [__eRewardExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardSkillExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds",
    [__eRewardExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds",
    [__eRewardSkillExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds",
    [__eRewardLifeExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardIntimacy] = "Icon/New_Icon/00000000_Special_Contributiveness.dds",
    [__eRewardKnowledge] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds",
    [__eRewardCharacterStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardFamilyStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardFamilyStatPoint] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardSeasonReward] = "Icon/New_Icon/03_ETC/00750592.dds"
  }
  local typeStr = {
    [__eRewardExp] = "Exp",
    [__eRewardSkillExp] = "SkillExp",
    [__eRewardExpGrade] = "ExpGrade",
    [__eRewardSkillExpGrade] = "SkillExpGrade",
    [__eRewardLifeExp] = "ProductExp",
    [__eRewardIntimacy] = "Intimacy",
    [__eRewardKnowledge] = "Knowledge",
    [__eRewardCharacterStat] = "CharacterStat",
    [__eRewardFamilyStat] = "FamilyStat",
    [__eRewardFamilyStatPoint] = "FamilyStatPoint",
    [__eRewardSeasonReward] = "SeasonReward"
  }
  local questTypeSlotBg
  if true == self._isConsole then
    if "main" == questType then
      questTypeSlotBg = self._ui._baseRewardSlotBg[index]
    else
      questTypeSlotBg = self._ui._selectRewardSlotBg[index]
    end
  end
  if nil ~= texturePathList[reward._type] then
    uiSlot.count:SetText("")
    uiSlot.icon:ChangeTextureInfoName(texturePathList[reward._type])
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    end
  end
  if __eRewardItem == reward._type then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
    uiSlot:setItemByStaticStatus(itemStatic, reward._count)
    uiSlot._item = reward._item
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEventX_QuestInfo_All_RewardItemTooltip(" .. index .. ", \"" .. questType .. "\")")
      elseif "main" == questType then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
      else
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
      end
    elseif "main" == questType then
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
    end
  elseif __eRewardIntimacy == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    end
  elseif __eRewardKnowledge == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    end
  elseif __eRewardSeasonReward == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. typeStr[reward._type] .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    end
  end
end
function PaGlobal_QuestInfo_All:registEventHandler()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  Panel_Window_QuestInfo_All:setGlassBackground(true)
  Panel_Window_QuestInfo_All:RegisterShowEventFunc(true, "PaGlobalFunc_QuestInfo_All_ShowAni()")
  Panel_Window_QuestInfo_All:RegisterShowEventFunc(false, "PaGlobalFunc_QuestInfo_All_HideAni()")
  if true == self._isConsole then
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_X, "")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEvent_QuestInfo_All_MoveScroll(1)")
    Panel_Window_QuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEvent_QuestInfo_All_MoveScroll(-1)")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_QuestInfo_All_Close()")
  end
end
function PaGlobal_QuestInfo_All:validate()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_subBg:isValidate()
  self._ui.txt_attributionType:isValidate()
  self._ui.txt_questGroupTitle:isValidate()
  self._ui.txt_questTitle:isValidate()
  self._ui.chk_autoNavi:isValidate()
  self._ui.chk_questNavi:isValidate()
  self._ui.chk_questGiveUp:isValidate()
  self._ui.stc_questIconBg:isValidate()
  self._ui.stc_questIcon:isValidate()
  self._ui.txt_acceptNPC:isValidate()
  self._ui.txt_completeNPC:isValidate()
  self._ui.txt_condition:isValidate()
  self._ui.frame_questDesc:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.txt_frameDesc:isValidate()
  self._ui.stc_rewardGroupBg:isValidate()
  self._ui.stc_baseRewardBg:isValidate()
  self._ui.txt_baseRewardTitle:isValidate()
  self._ui.stc_selectRewardBg:isValidate()
  self._ui.txt_selectRewardTitle:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_giveUp:isValidate()
  self._ui_pc.btn_callSpirit:isValidate()
  self._ui_pc.chk_questNavi:isValidate()
  self._ui_pc.chk_autoNavi:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_tooltip:isValidate()
  self._ui_console.stc_giveUp:isValidate()
  self._ui_console.stc_scroll:isValidate()
  self._ui_console.stc_navi:isValidate()
  self._ui_console.stc_close:isValidate()
end
function PaGlobal_QuestInfo_All:resize()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  local subBgAddSizeList = {
    self._ui.txt_questTitle,
    self._ui.stc_questIconBg,
    self._ui.txt_condition,
    self._ui.frame_questDesc,
    self._ui.stc_rewardGroupBg
  }
  local subBgSizeY = 0
  local gabY = 95
  for k, v in ipairs(subBgAddSizeList) do
    if nil ~= v and true == v:GetShow() then
      subBgSizeY = subBgSizeY + v:GetSizeY()
    end
  end
  self._ui.stc_subBg:SetSize(self._ui.stc_subBg:GetSizeX(), subBgSizeY + gabY)
  local pcAddBtnSizeY = self._ui_pc.chk_questNavi:GetSizeY()
  if true == self._isConsole or true == self._OpenInfo._isCleared then
    pcAddBtnSizeY = -10
  end
  local panelSizeY = self._ui.stc_titleBg:GetSizeY() + self._ui.stc_subBg:GetSizeY() + pcAddBtnSizeY
  Panel_Window_QuestInfo_All:SetSize(Panel_Window_QuestInfo_All:GetSizeX(), panelSizeY + 10)
  for k, v in ipairs(self._ui) do
    if nil ~= v and true == v:GetShow() then
      v:ComputePos()
    end
  end
  if true == self._isConsole then
    local keyGuideList = {
      self._ui_console.stc_tooltip,
      self._ui_console.stc_scroll,
      self._ui_console.stc_giveUp,
      self._ui_console.stc_navi,
      self._ui_console.stc_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    local bottomBtnList = {
      [1] = self._ui_pc.chk_autoNavi,
      [2] = self._ui_pc.chk_questNavi,
      [3] = self._ui_pc.btn_callSpirit,
      [4] = self._ui_pc.btn_giveUp
    }
    local spanSizeX = 10
    for i = 1, #bottomBtnList do
      if nil ~= bottomBtnList[i] and true == bottomBtnList[i]:GetShow() then
        bottomBtnList[i]:SetSpanSize(spanSizeX, bottomBtnList[i]:GetSpanSize().y)
        spanSizeX = spanSizeX + bottomBtnList[i]:GetSizeX() + 10
        bottomBtnList[i]:ComputePos()
      end
    end
  end
end
function PaGlobal_QuestInfo_All:rePosition()
  if nil == Panel_Window_QuestInfo_All then
    return
  end
  if true == Panel_Window_Quest_All:GetShow() then
    if true == Panel_Window_Quest_All:IsUISubApp() then
      Panel_Window_QuestInfo_All:SetPosX(Panel_Window_Quest_All:GetScreenParentPosX() + Panel_Window_Quest_All:GetSizeX() + 5)
      Panel_Window_QuestInfo_All:SetPosY(Panel_Window_Quest_All:GetScreenParentPosY())
      PaGlobal_QuestInfo_All:open()
      Panel_Window_QuestInfo_All:OpenUISubApp()
    else
      Panel_Window_QuestInfo_All:SetPosX(Panel_Window_Quest_All:GetPosX() + Panel_Window_Quest_All:GetSizeX() + 5)
      Panel_Window_QuestInfo_All:SetPosY(Panel_Window_Quest_All:GetPosY())
    end
  else
    Panel_Window_QuestInfo_All:SetPosX(getScreenSizeX() - getScreenSizeX() / 2 - Panel_Window_QuestInfo_All:GetSizeX() / 2)
    Panel_Window_QuestInfo_All:SetPosY(getScreenSizeY() - getScreenSizeY() / 2 - Panel_Window_QuestInfo_All:GetSizeY() / 2)
  end
end
