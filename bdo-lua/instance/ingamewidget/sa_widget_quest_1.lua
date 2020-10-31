function PaGlobal_SA_Widget_Quest:initialize()
  if true == PaGlobal_SA_Widget_Quest._initialize then
    return
  end
  self._ui.stc_questBG = UI.getChildControl(Panel_SA_Widget_Quest, "Static_QuestBG")
  self._ui.stc_questIcon = UI.getChildControl(self._ui.stc_questBG, "Static_QuestIcon")
  self._ui.txt_questTitle = UI.getChildControl(self._ui.stc_questBG, "StaticText_QuestTitle")
  self._ui.txt_questCondition = UI.getChildControl(self._ui.stc_questBG, "StaticText_Questcondition")
  self:registEventHandler()
  self:validate()
  self._templetePosOffsetY = self._ui.stc_questBG:GetPosY()
  if 1 <= ToClient_GetProgressMissionInfoCount() then
    self:refreshMission()
    self:updateMissionCondition()
  else
    self._ui.stc_questBG:SetShow(false)
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local curClassType = selfPlayer:getClassType()
  if nil ~= curClassType and __eClassType_BlackSpirit == curClassType then
    self._isBlackSpirit = true
  else
    self._isBlackSpirit = false
  end
  if true == ToClient_IsContentsGroupOpen("1340") then
    self:prepareOpen()
  end
  self._initialize = true
end
function PaGlobal_SA_Widget_Quest:registEventHandler()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Quest_ReSizePanel")
  registerEvent("FromClient_AcceptMission", "FromClient_SA_Widget_Quest_RefreshMission")
  registerEvent("FromClient_CompleteMission", "FromClient_SA_Widget_Quest_CompleteMission")
  registerEvent("FromClient_UpdateMission", "FromClient_SA_Widget_Quest_UpdateMission")
  registerEvent("FromClient_DeleteMission", "FromClient_SA_Widget_Quest_RefreshMission")
  registerEvent("FromClient_ClassChangeBattleRoyale", "PaGlobal_SA_Widget_Quest_CatchClassChange")
  Panel_SA_Widget_Quest:RegisterUpdateFunc("PaGlobal_SA_Widget_Quest_ShowMissionNotifyMessage")
end
function PaGlobal_SA_Widget_Quest:prepareOpen()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  PaGlobal_SA_Widget_Quest:open()
end
function PaGlobal_SA_Widget_Quest:open()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  Panel_SA_Widget_Quest:SetShow(true)
end
function PaGlobal_SA_Widget_Quest:prepareClose()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  PaGlobal_SA_Widget_Quest:close()
end
function PaGlobal_SA_Widget_Quest:close()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  Panel_SA_Widget_Quest:SetShow(false)
end
function PaGlobal_SA_Widget_Quest:update()
  if nil == Panel_SA_Widget_Quest then
    return
  end
end
function PaGlobal_SA_Widget_Quest:validate()
  if nil == Panel_SA_Widget_Quest then
    return
  end
  self._ui.stc_questBG:isValidate()
  self._ui.stc_questIcon:isValidate()
  self._ui.txt_questTitle:isValidate()
  self._ui.txt_questCondition:isValidate()
end
function PaGlobal_SA_Widget_Quest:refreshMission()
  self._missionCount = ToClient_GetProgressMissionInfoCount()
  self._ui.stc_questBG:SetShow(false)
  local progressMissionInfo = ToClient_GetProgressMissionInfoByIndex(0)
  if nil == progressMissionInfo then
    return
  end
  local missionInfo = {}
  missionInfo._title = progressMissionInfo:getMissionTitle()
  missionInfo._rewardDesc = progressMissionInfo:getMissionDescription()
  missionInfo._showType = progressMissionInfo:getMissionShowType()
  missionInfo._alreadyShow = false
  missionInfo._bonusMoneyRate = math.ceil(ToClient_GetProgressMissionBonusMoneyRate(0) / 100000) / 10
  missionInfo._itemKey = ToClient_GetProgressMissionItemKeyByIndex(0, 0)
  missionInfo._itemCount = ToClient_GetProgressMissionItemCountByIndex(0, 0)
  self._progressMissionInfo[0] = missionInfo
  self._ui.stc_questBG:SetShow(true)
  self._ui.txt_questTitle:SetText(missionInfo._title)
  local conditionCount = progressMissionInfo:getCompleteConditionCount()
  if 1 == conditionCount then
    self._ui.txt_questCondition:SetShow(false)
  elseif 1 < conditionCount then
    self._ui.txt_questCondition:SetShow(true)
  end
end
function PaGlobal_SA_Widget_Quest:updateMissionCondition()
  local missionInfo = ToClient_GetProgressMissionInfoByIndex(0)
  if nil == missionInfo then
    return
  end
  for ii = 0, missionInfo:getCompleteConditionCount() - 1 do
    local descText = ""
    descText = "- " .. descText .. missionInfo:getConditionText(ii)
    local maxConditionCount = missionInfo:getMaxConditionCount(ii)
    local conditionCount = missionInfo:getConditionCount(ii)
    if 1 < maxConditionCount then
      descText = descText .. " (" .. tostring(conditionCount) .. "/" .. tostring(maxConditionCount) .. ")"
    end
    self._ui.txt_questCondition:SetText(descText)
    if maxConditionCount == conditionCount then
      self._ui.txt_questCondition:SetFontColor(Defines.Color.C_FF888888)
    end
    self._ui.txt_questCondition:SetShow(true)
    if self._ui.stc_questBG:GetSizeX() - self._ui.stc_questIcon:GetSizeX() < self._ui.txt_questCondition:GetTextSizeX() + self._ui.txt_questCondition:GetPosX() then
      local gapX = self._ui.txt_questCondition:GetTextSizeX() + self._ui.txt_questCondition:GetPosX() - (self._ui.stc_questBG:GetSizeX() - self._ui.stc_questIcon:GetSizeX()) + 5
      self._ui.stc_questBG:SetSize(self._ui.stc_questBG:GetSizeX() + gapX, self._ui.stc_questBG:GetSizeY())
      FromClient_SA_Widget_Quest_ReSizePanel()
    end
  end
end
function PaGlobal_SA_Widget_Quest:showMissionNotifyMessage(deltatime)
  if self._missionCount < 1 then
    return
  end
  local isNakShow = false
  local showNakMissionIndex = -1
  local showType = self._progressMissionInfo[0]._showType
  if false == self._progressMissionInfo[0]._alreadyShow then
    local isShow = self:checkShowType(showType)
    if true == isShow then
      self._progressMissionInfo[0]._alreadyShow = true
      isNakShow = true
      if __eShowType_Before == showType and false == self._isBlackSpirit then
        isNakShow = false
      end
      showNakMissionIndex = 0
    end
  end
  if true == self._progressMissionInfo[0]._alreadyShow then
    self._ui.stc_questBG:SetShow(true)
  else
    self._ui.stc_questBG:SetShow(false)
  end
end
function PaGlobal_SA_Widget_Quest:checkShowType(showType)
  local isShow = false
  local brStartTime = ToClient_BattleRoyaleStartTime()
  local serverUtcTime = getServerUtc64()
  if Int64toInt32(brStartTime) < 1 then
    return true
  end
  local elapsedTime = 0
  if nil ~= brStartTime and nil ~= serverUtcTime then
    elapsedTime = Int64toInt32(serverUtcTime - brStartTime)
  end
  if elapsedTime < 23 then
    return
  end
  local elapsedMinutes = math.floor(elapsedTime / 60)
  if __eShowType_Before == showType then
    return true
  elseif __eShowType_Start == showType and false == self._isBlackSpirit then
    isShow = true
  elseif __eShowType_Time0 == showType and 5 <= elapsedMinutes then
    isShow = true
  elseif __eShowType_Time1 == showType and 10 <= elapsedMinutes then
    isShow = true
  elseif __eShowType_Time2 == showType and 15 <= elapsedMinutes then
    isShow = true
  elseif __eShowType_Time3 == showType and 20 <= elapsedMinutes then
    isShow = true
  end
  return isShow
end
