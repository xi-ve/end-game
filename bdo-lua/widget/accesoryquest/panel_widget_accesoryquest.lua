local _panel = Panel_Widget_AccesoryQuest
local AccesoryQuest = {
  _ui = {
    txt_title = UI.getChildControl(_panel, "StaticText_QuestTitle"),
    btn_apply = UI.getChildControl(_panel, "Button_Reward"),
    stc_rewardBg = UI.getChildControl(_panel, "Static_RewardGage_Bg"),
    progress_reward = UI.getChildControl(_panel, "Progress2_RewardGage"),
    txt_rewardValue = UI.getChildControl(_panel, "StaticText_RewardValue"),
    txt_questDesc = UI.getChildControl(_panel, "StaticText_QuestDesc"),
    stc_itemSlotBg = UI.getChildControl(_panel, "Static_ItemSlotBg"),
    stc_keyGuideBg = UI.getChildControl(_panel, "Static_KeyGuideBg_Console"),
    stc_keyGuideMenu = nil
  },
  _currentQuestGroup = 0,
  _nowRegionKey = 0,
  _itemSlot = nil,
  _nowQuestNo = nil,
  _nowAccesoryQuestCount = nil,
  _showFlag = false,
  _showTimeRegionKey = 0,
  _consoleAddPosX = 50,
  _panelPosY = 0,
  _isConsole = false,
  _initialize = false
}
function AccesoryQuest:initialize()
  if false == _ContentsGroup_AccesoryQuest then
    _panel:SetShow(_ContentsGroup_AccesoryQuest)
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local nowRegionInfo = selfPlayer:getCurrentRegionInfo()
    if nil ~= nowRegionInfo then
      self._nowRegionKey = Int64toInt32(nowRegionInfo:getRegionKey())
    end
  end
  local slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createClassEquipBG = true,
    createCash = true
  }
  local slot = {}
  SlotItem.new(slot, "slotIcon_" .. 0, 0, self._ui.stc_itemSlotBg, slotConfig)
  slot:createChild()
  self._itemSlot = slot
  Panel_Tooltip_Item_SetPosition(0, self._itemSlot, "AccesoryQuest_Base")
  self._ui.txt_title:SetTextMode(__eTextMode_AutoWrap)
  self._isConsole = ToClient_isConsole()
  if true == self._isConsole then
    self._ui.stc_keyGuideMenu = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_Menu")
    if nil ~= self._ui.stc_keyGuideMenu then
      local keyGuideTable = {
        self._ui.stc_keyGuideMenu
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
    self._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_COMPLETE"))
  end
  self:validate()
  self:registEventHandler()
  self._showTimeRegionKey = 0
  self._nowRegionKey = 0
  self:update()
  self._initialize = true
end
function AccesoryQuest:registEventHandler()
  self._ui.btn_apply:addInputEvent("Mouse_LUp", "Input_AccesoryQuest_ApplyReward()")
  registerEvent("FromClient_UpdateQuestList", "FromClient_AccesoryQuest_UpdateQuestList")
  registerEvent("selfPlayer_regionChanged", "FromClient_AccesoryQuest_selfPlayer_regionChanged")
  registerEvent("FromClient_notifyUpdateRegionMonsterKillQuest", "FromClient_AccesoryQuest_notifyUpdateRegionMonsterKillQuest")
  registerEvent("EventQuestUpdateNotify", "FromClient_AccesoryQuest_EventQuestUpdateNotify")
  registerEvent("onScreenResize", "PaGlobalFunc_AccesoryQuest_OnScreenResize")
end
function AccesoryQuest:open()
  _panel:SetShow(true)
end
function AccesoryQuest:close()
  _panel:SetShow(false)
end
function FromClient_AccesoryQuest_EventQuestUpdateNotify(isAccept, questNoRaw)
  local self = AccesoryQuest
  if true == _panel:GetShow() then
    self:update()
  end
end
function PaGlobal_AccesoryQuest_SetCurrentRegionQuestInfo()
  local self = AccesoryQuest
  local questList = ToClient_GetQuestList()
  local nowRegionInfo = getSelfPlayer():getCurrentRegionInfo()
  if nil == questList then
    return false
  end
  if nil == nowRegionInfo then
    return false
  end
  local accesoryQuestCount = questList:getRegionMonsterKillQuestCount()
  self._nowRegionKey = Int64toInt32(nowRegionInfo:getRegionKey())
  for i = 0, accesoryQuestCount - 1 do
    local accesoryQuestNo = questList:getRegionMonsterKillQuestAt(i)
    if nil == accesoryQuestNo then
      return false
    end
    local questInfoWrapper = questList_getQuestStatic(accesoryQuestNo._group, accesoryQuestNo._quest)
    if nil == questInfoWrapper then
      return false
    end
    if self._nowRegionKey == questInfoWrapper:getRegionKey() then
      local questNo = questInfoWrapper:getQuestNo()
      if nil == questNo then
        return false
      end
      self._nowQuestNo = questNo
      return i
    end
  end
  return false
end
function AccesoryQuest:update()
  local questList = ToClient_GetQuestList()
  if nil == questList then
    return
  end
  self._showFlag = false
  local accesoryQuestCount = questList:getRegionMonsterKillQuestCount()
  for ii = 0, accesoryQuestCount - 1 do
    local accesoryQuestNo = questList:getRegionMonsterKillQuestAt(ii)
    if nil == accesoryQuestNo then
      return
    end
    self._nowAccesoryQuestCount = accesoryQuestCount
    local questInfoWrapper = questList_getQuestStatic(accesoryQuestNo._group, accesoryQuestNo._quest)
    local questCount = questList:getClearedRegionMonsterKillQuestCount()
    if nil ~= questInfoWrapper and self._nowRegionKey == questInfoWrapper:getRegionKey() then
      local questNo = questInfoWrapper:getQuestNo()
      if nil ~= questNo then
        local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
        local questWrapper = ToClient_getQuestWrapper(questNo)
        self._nowQuestNo = questNo
        if nil ~= questInfo and nil ~= questWrapper and ToClient_isProgressingQuest(questNo._group, questNo._quest) then
          local questBasicCnt = questWrapper:getQuestBaseRewardCount()
          if 0 < questBasicCnt then
            local baseRewardWrapper = questWrapper:getQuestBaseRewardAt(0)
            local baseReward
            if nil ~= baseRewardWrapper then
              baseReward = baseRewardWrapper:get()
            end
            if nil ~= baseReward then
              local slotOption = {}
              slotOption._type = baseReward._type
              if __eRewardItem == slotOption._type then
                slotOption._item = baseReward:getItemEnchantKey()
                slotOption._count = baseReward._itemCount
                local selfPlayer = getSelfPlayer()
                if nil ~= selfPlayer then
                  local classType = selfPlayer:getClassType()
                  slotOption._isEquipable = baseReward:isEquipable(classType)
                end
              end
              self:setAccesoryQuestRewardShow(slotOption)
            end
          end
          local questCondition = questInfo:getDemandAt(0)
          self._ui.txt_title:SetText(questInfo:getTitle())
          if nil ~= questCondition then
            self._ui.txt_rewardValue:SetText(questCondition._currentCount .. " / " .. questCondition._destCount)
            local rate = math.floor(questCondition._currentCount / questCondition._destCount * 100)
            self._ui.progress_reward:SetProgressRate(rate - 0.1)
            if false == questInfo:isSatisfied() then
              self._ui.txt_questDesc:SetShow(true)
              self._ui.btn_apply:SetShow(false)
              self._showFlag = true
              self._itemSlot.icon:SetMonoTone(true)
              if true == self._isConsole then
                self._ui.stc_keyGuideBg:SetShow(false)
              end
              break
            else
              self._ui.txt_questDesc:SetShow(false)
              self._ui.btn_apply:SetShow(true)
              self._showFlag = true
              self._itemSlot.icon:SetMonoTone(false)
              if true == self._isConsole then
                self._ui.stc_keyGuideBg:SetShow(true)
              end
              break
            end
          end
        end
      end
    end
  end
  if true == self._showFlag then
    AccesoryQuest:resizePosition()
    if self._nowRegionKey ~= self._showTimeRegionKey then
      self:ShowAni()
      self._showTimeRegionKey = self._nowRegionKey
    end
    self:open()
  elseif true == _panel:GetShow() then
    self:HideAni()
    self._showTimeRegionKey = 0
  end
  if false == self._isConsole then
    PaGlobalFunc_BetterEquipment_OnScreenResize()
  end
end
function AccesoryQuest:resizePosition()
  local panelSizeY = AccesoryQuest._ui.txt_title:GetTextSizeY() + AccesoryQuest._ui.txt_questDesc:GetTextSizeY() + AccesoryQuest._ui.btn_apply:GetSizeY() + 35
  Panel_Widget_AccesoryQuest:SetSize(Panel_Widget_AccesoryQuest:GetSizeX(), panelSizeY)
  AccesoryQuest._ui.txt_title:ComputePos()
  AccesoryQuest._ui.stc_rewardBg:ComputePos()
  AccesoryQuest._ui.progress_reward:ComputePos()
  AccesoryQuest._ui.txt_rewardValue:ComputePos()
  AccesoryQuest._ui.stc_itemSlotBg:ComputePos()
  AccesoryQuest._ui.txt_questDesc:ComputePos()
  AccesoryQuest._ui.btn_apply:ComputePos()
  AccesoryQuest._ui.stc_keyGuideBg:ComputePos()
end
function Input_AccesoryQuest_ApplyReward()
  if true == PaGlobalFunc_AccesoryQuest_IsSatisfied() then
    local index = PaGlobal_AccesoryQuest_SetCurrentRegionQuestInfo()
    if false == index then
      return
    end
    ToClient_RequestCompleteRegionMonsterKillQuest(index)
  end
end
function PaGlobalFunc_AccesoryQuest_IsSatisfied()
  local questNo = AccesoryQuest._nowQuestNo
  if nil == questNo then
    return false
  end
  local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
  local questWrapper = ToClient_getQuestWrapper(questNo)
  if nil ~= questInfo and nil ~= questWrapper and ToClient_isProgressingQuest(questNo._group, questNo._quest) and true == questInfo:isSatisfied() then
    return true
  end
  return false
end
function AccesoryQuest:setAccesoryQuestRewardShow(reward)
  local uiSlot = self._itemSlot
  if nil ~= uiSlot then
    if __eRewardItem == reward._type then
      local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
      if nil ~= itemStatic then
        uiSlot:setItemByStaticStatus(itemStatic, reward._count)
        uiSlot._item = reward._item
        uiSlot.icon:SetSize(40, 40)
        uiSlot.icon:SetHorizonCenter()
        uiSlot.icon:SetVerticalMiddle()
      end
      uiSlot.icon:addInputEvent("Mouse_On", "Input_AccesoryQuest_ShowToolTip(true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Input_AccesoryQuest_ShowToolTip(false)")
    elseif __eRewardIntimacy == reward._type then
      uiSlot.count:SetText("")
      uiSlot.icon:ChangeTextureInfoName("Icon/New_Icon/00000000_Special_Contributiveness.dds")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "")
      uiSlot.icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function Input_AccesoryQuest_ShowToolTip(isOn)
  Panel_Tooltip_Item_Show_GeneralStatic(0, "AccesoryQuest_Base", isOn)
end
function FromClient_AccesoryQuest_selfPlayer_regionChanged(regionData)
  if nil == regionData then
    return
  end
  local self = AccesoryQuest
  self._nowRegionKey = Int64toInt32(regionData:getRegionKey())
  self:update()
  PaGlobalFunc_AccesoryQuest_resetPosition()
end
function FromClient_AccesoryQuest_UpdateQuestList()
  local self = AccesoryQuest
  self:update()
  PaGlobalFunc_AccesoryQuest_resetPosition()
end
function AccesoryQuest:resetPosition()
  if false == self._initialize then
    return
  end
  local radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  if true == _panel:GetShow() then
    if true == Panel_Radar:GetShow() then
      _panel:SetPosX(Panel_Radar:GetPosX() - Panel_Widget_AccesoryQuest:GetSizeX())
    elseif true == Panel_WorldMiniMap:GetShow() then
      _panel:SetPosX(Panel_WorldMiniMap:GetPosX() - Panel_Widget_AccesoryQuest:GetSizeX())
    end
    if true == self._isConsole then
      _panel:SetPosX(_panel:GetPosX() - self._consoleAddPosX)
    end
  end
  self._panelPosY = _panel:GetPosY()
  local tempPanel
  if true == PcEnduranceToggle() or PaGlobalFunc_Endurance_InvenSlot_All_GetShow() then
    tempPanel = PaGlobalPlayerWeightList.weight
    local invenSlotIcon = PaGlobal_Endurance_InvenSlot_All._ui.txt_InvenSlotIcon
    if nil ~= tempPanel then
      if invenSlotIcon:GetShow() then
        _panel:SetPosY(invenSlotIcon:GetPosY() + invenSlotIcon:GetSizeY() + Panel_Widget_AccesoryQuest:GetSizeY() + 30)
      else
        _panel:SetPosY(tempPanel:GetPosY() + tempPanel:GetSizeY() + Panel_Widget_AccesoryQuest:GetSizeY() + 80)
      end
      self._panelPosY = _panel:GetPosY()
    end
  else
    if true == PaGlobalHorseEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalHorseEnduranceList.panel
    elseif true == PaGlobalCarriageEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalCarriageEnduranceList.panel
    elseif true == PaGlobalShipEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalShipEnduranceList.panel
    elseif true == PaGlobalSailShipEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalSailShipEnduranceList.panel
    elseif nil ~= PaGlobalPlayerEnduranceList.enduranceInfo[0] and true == PaGlobalPlayerEnduranceList.enduranceInfo[0].control:GetShow() then
      tempPanel = PaGlobalPlayerEnduranceList.panel
    end
    if nil ~= tempPanel then
      _panel:SetPosY(tempPanel:GetPosY() + tempPanel:GetSizeY() + 30)
      self._panelPosY = _panel:GetPosY()
    end
  end
end
function AccesoryQuest:ShowAni()
  local alarmMoveAni1 = Panel_Widget_AccesoryQuest:addMoveAnimation(0, 0.6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alarmMoveAni1:SetStartPosition(getScreenSizeX() + 10, self._panelPosY)
  local endPosX = Panel_Radar:GetPosX() - Panel_Widget_AccesoryQuest:GetSizeX()
  if true == self._isConsole then
    endPosX = endPosX - self._consoleAddPosX
  end
  alarmMoveAni1:SetEndPosition(endPosX, self._panelPosY)
  alarmMoveAni1.IsChangeChild = true
  Panel_Widget_AccesoryQuest:CalcUIAniPos(alarmMoveAni1)
  alarmMoveAni1:SetDisableWhileAni(true)
  alarmMoveAni1:SetHideAtEnd(false)
end
function AccesoryQuest:HideAni()
  local alarmMoveAni2 = Panel_Widget_AccesoryQuest:addMoveAnimation(0, 0.6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local startPosX = Panel_Radar:GetPosX() - Panel_Widget_AccesoryQuest:GetSizeX()
  if true == self._isConsole then
    startPosX = startPosX - self._consoleAddPosX
  end
  alarmMoveAni2:SetStartPosition(startPosX, self._panelPosY)
  alarmMoveAni2:SetEndPosition(getScreenSizeX() + 10, self._panelPosY)
  alarmMoveAni2.IsChangeChild = true
  Panel_Widget_AccesoryQuest:CalcUIAniPos(alarmMoveAni2)
  alarmMoveAni2:SetHideAtEnd(true)
end
function AccesoryQuest:validate()
  if nil == Panel_Widget_AccesoryQuest then
    UI.ASSERT_NAME(false, "Panel_Widget_AccesoryQuest\236\157\180 \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    return
  end
  self._ui.txt_title:isValidate()
  self._ui.btn_apply:isValidate()
  self._ui.stc_rewardBg:isValidate()
  self._ui.progress_reward:isValidate()
  self._ui.txt_rewardValue:isValidate()
  self._ui.txt_questDesc:isValidate()
  self._ui.stc_itemSlotBg:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
  if true == self._isConsole then
    self._ui.stc_keyGuideMenu:isValidate()
  end
end
function PaGlobalFunc_AccesoryQuest_ReturnPanelShow()
  local self = AccesoryQuest
  return self._showFlag
end
function PaGlobalFunc_AccesoryQuest_OnScreenResize()
  local self = AccesoryQuest
  self:resetPosition()
end
function PaGlobalFunc_AccesoryQuest_resetPosition()
  local self = AccesoryQuest
  self:resetPosition()
  if false == ToClient_isConsole() then
    PaGlobalFunc_BetterEquipment_OnScreenResize()
  end
end
function FromClient_AccesoryQuest_notifyUpdateRegionMonsterKillQuest(questNoRaw)
end
function FromClient_AccesoryQuest_luaLoadComplete()
  local self = AccesoryQuest
  self:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_AccesoryQuest_luaLoadComplete")
