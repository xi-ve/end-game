local _panel = Panel_Widget_ChallengeAlert
local challengeAlert = {
  _ui = {
    bg = UI.getChildControl(_panel, "Static_AlertMessageBg"),
    title = UI.getChildControl(_panel, "StaticText_Message"),
    desc = UI.getChildControl(_panel, "StaticText_Desc"),
    progressBg = UI.getChildControl(_panel, "Static_ProgressBg"),
    progress = UI.getChildControl(_panel, "Progress2_Challenge"),
    state = UI.getChildControl(_panel, "StaticText_ProgressState"),
    _stc_icon = UI.getChildControl(_panel, "Static_Icon")
  },
  _conditionMaxCount = 0,
  _currentCount = {},
  _maxCount = {},
  _time = 0,
  _progressQuestInfo = {},
  _currentIndex = 0,
  _waitTime = 0,
  _progressOpen = false
}
local enumState = {
  UI_ALERT_STATE_START = 0,
  UI_ALERT_STATE_PROGRASSING = 1,
  UI_ALERT_STATE_SUB_SATISFIED = 2,
  UI_ALERT_STATE_ALL_SATISFIED = 3,
  UI_ALERT_STATE_COUNT = 4
}
function challengeAlert:update(titleStr, descStr, questGroupNo, questNo, alertState)
  self._ui.title:SetTextMode(__eTextMode_LimitText)
  self._ui.title:SetText(titleStr)
  self._ui.desc:SetTextMode(__eTextMode_LimitText)
  self._ui.desc:SetText(descStr)
  if nil == questGroupNo then
    self._ui.state:SetShow(false)
    self._ui.progressBg:SetShow(false)
    self._ui.progress:SetShow(false)
  elseif nil ~= self._progressQuestInfo[questGroupNo] then
    self._ui.bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_OpenBookShelfQuest(" .. questGroupNo .. ", " .. questNo .. ")")
    if enumState.UI_ALERT_STATE_START == alertState then
      self._ui.state:SetShow(false)
      self._ui.progressBg:SetShow(false)
      self._ui.progress:SetShow(false)
    elseif enumState.UI_ALERT_STATE_PROGRASSING == alertState then
      self._ui.state:SetShow(true)
      self._ui.progressBg:SetShow(true)
      self._ui.progress:SetShow(true)
      self._ui.state:SetText(tostring(self._currentCount[questGroupNo][questNo][self._currentIndex]) .. " / " .. tostring(self._maxCount[questGroupNo][questNo][self._currentIndex]))
      self._ui.progress:SetProgressRate(self._currentCount[questGroupNo][questNo][self._currentIndex] / self._maxCount[questGroupNo][questNo][self._currentIndex] * 100)
      self._ui.progress:SetSmoothMode(true)
    elseif enumState.UI_ALERT_STATE_SUB_SATISFIED == alertState then
      self._ui.state:SetShow(true)
      self._ui.progressBg:SetShow(true)
      self._ui.progress:SetShow(true)
      self._ui.state:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_COMPLETE2"))
      self._ui.progress:SetSmoothMode(false)
      self._ui.progress:SetProgressRate(100)
    elseif enumState.UI_ALERT_STATE_ALL_SATISFIED == alertState then
      self._ui.state:SetShow(true)
      self._ui.progressBg:SetShow(true)
      self._ui.progress:SetShow(true)
      self._ui.state:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_COMPLETE"))
      self._ui.progress:SetSmoothMode(false)
      self._ui.progress:SetProgressRate(100)
    end
  end
end
function challengeAlert:SetProgress()
  if nil ~= self._progressQuestInfo[questGroupNo] then
    self._ui.bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_Achievement_OpenBookShelfQuest(" .. questGroupNo .. ", " .. questNo .. ")")
    if enumState.UI_ALERT_STATE_PROGRASSING == alertState then
      self._ui.state:SetShow(true)
      self._ui.progressBg:SetShow(true)
      self._ui.progress:SetShow(true)
      self._ui.state:SetText(self._currentCount[questGroupNo][questNo][self._currentIndex] .. " / " .. self._maxCount[questGroupNo][questNo][self._currentIndex])
      self._ui.progress:SetProgressRate(self._currentCount[questGroupNo][questNo][self._currentIndex] / self._maxCount[questGroupNo][questNo][self._currentIndex] * 100)
    end
  end
end
function challengeAlert:showAni()
  _panel:ResetVertexAni(false)
  local MoveAni = _panel:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  MoveAni:SetHideAtEnd(false)
  MoveAni:SetStartPosition(_panel:GetSizeX() * -1, _panel:GetPosY())
  MoveAni:SetEndPosition(10, _panel:GetPosY())
  MoveAni:SetDisableWhileAni(true)
  _panel:SetShow(true)
  _panel:ClearUpdateLuaFunc()
  _panel:RegisterUpdateFunc("FromClient_ChallengeAlert_UpdatePerFrame")
end
function challengeAlert:UpdateWaitFunc(deltaTime)
  self._waitTime = self._waitTime + deltaTime
  if self._waitTime < 5 then
    challengeAlert:popNextAlert()
  end
end
function challengeAlert:hideAni()
  self._waitTime = 0
  _panel:ClearUpdateLuaFunc()
  _panel:RegisterUpdateFunc("challengeAlert:UpdateWaitFunc")
  _panel:ResetVertexAni(false)
  local MoveAni = _panel:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  MoveAni:SetStartPosition(_panel:GetPosX(), _panel:GetPosY())
  MoveAni:SetEndPosition(_panel:GetSizeX() * -1, _panel:GetPosY())
  MoveAni:SetHideAtEnd(true)
  MoveAni:SetDisableWhileAni(true)
  challengeAlert:popNextAlert()
end
function challengeAlert:popNextAlert()
  TooltipSimple_Hide()
  self._progressOpen = false
  ToClient_PopAlertQueue()
  self._waitTime = 0
end
function challengeAlert:open(titleStr, descStr, questGroupNo, questNo, alertState)
  if false == _contentsgroup_achievementquest then
    return
  end
  self._progressOpen = true
  self._time = 0
  self:update(titleStr, descStr, questGroupNo, questNo, alertState)
  self:SetProgress()
  self:showAni()
end
function challengeAlert:close()
  self:hideAni()
end
function FromClient_ChallengeAlert_UpdatePerFrame(deltaTime)
  local self = challengeAlert
  self._time = self._time + deltaTime
  if self._time > 7 then
    self._time = 0
    self:hideAni()
  elseif self._time > 2 then
    self:SetProgress()
  end
end
function challengeAlert:setProgressCount()
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return
  end
  self._progressQuestInfo = {}
  local specialQuestCount = questListInfo:getSpecialQuestCount()
  for ii = 1, specialQuestCount do
    local specialQuestNo = questListInfo:getSpecialQuestAt(ii - 1)
    if nil == specialQuestNo then
      return
    end
    local questInfoWrapper = questList_getQuestStatic(specialQuestNo._group, specialQuestNo._quest)
    local questNo = questInfoWrapper:getQuestNo()
    local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
    if nil ~= questInfo and ToClient_isProgressingQuest(questNo._group, questNo._quest) then
      local questCondition = questInfo:getDemandAt(0)
      self._progressQuestInfo[questNo._group] = questCondition._currentCount
    end
  end
end
function FromClient_NewQuestAlert(isAccept, questNoRaw)
  if not isAccept then
    return
  end
  local self = challengeAlert
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  if nil ~= questInfoWrapper then
    local questNo = questInfoWrapper:getQuestNo()
    local _questType = questInfoWrapper:getQuestType()
    local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
    if nil == self._maxCount[questNo._group] then
      self._maxCount[questNo._group] = {}
    end
    if nil == self._maxCount[questNo._group][questNo._quest] then
      self._maxCount[questNo._group][questNo._quest] = {}
    end
    if nil == self._currentCount[questNo._group] then
      self._currentCount[questNo._group] = {}
    end
    if nil == self._currentCount[questNo._group][questNo._quest] then
      self._currentCount[questNo._group][questNo._quest] = {}
    end
    if nil ~= questInfo and 10 == _questType then
      challengeAlert:setProgressCount()
      self._conditionMaxCount = questInfo:getDemandCount()
      for index = 0, self._conditionMaxCount - 1 do
        local questCondition = questInfo:getDemandAt(index)
        self._maxCount[questNo._group][questNo._quest][index] = questCondition._destCount
        self._currentCount[questNo._group][questNo._quest][index] = questCondition._currentCount
      end
      self._currentIndex = 0
      ToClient_PushToAlertQueue(questInfo, enumState.UI_ALERT_STATE_START)
    end
  end
end
function challengeAlert:init()
  self:registEventHandler()
  self:setProgressCount()
end
function challengeAlert:registEventHandler()
  registerEvent("FromClient_notifyUpdateSpecialQuest", "FromClient_notifyUpdateSpecialQuest_challengeAlert")
  registerEvent("EventQuestUpdateNotify", "FromClient_NewQuestAlert")
  registerEvent("EventQuestPopAlertQueue", "FromClient_PopQuestAlert")
end
function FromClient_PopQuestAlert(info)
  local questInfoWrapper = info:getQuestInfo()
  if false == questInfoWrapper:isValid() then
    challengeAlert:popNextAlert()
    return
  end
  local titleStr = questInfoWrapper:getTitle()
  local questNo = questInfoWrapper:getQuestNo()
  local state = info:getAlertState()
  local descStr = ""
  if enumState.UI_ALERT_STATE_START == state then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHALLENGEALERT_NEW_ALERT")
  else
    descStr = questInfoWrapper:getDesc()
  end
  local self = challengeAlert
  self:open(titleStr, descStr, questNo._group, questNo._quest, state)
end
function FromClient_notifyUpdateSpecialQuest_challengeAlert(questNoRaw)
  if false == _ContentsGroup_AchievementQuest then
    return
  end
  local self = challengeAlert
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  if nil ~= questInfoWrapper then
    local questNo = questInfoWrapper:getQuestNo()
    local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
    if nil == self._maxCount[questNo._group] then
      self._maxCount[questNo._group] = {}
    end
    if nil == self._maxCount[questNo._group][questNo._quest] then
      self._maxCount[questNo._group][questNo._quest] = {}
    end
    if nil == self._currentCount[questNo._group] then
      self._currentCount[questNo._group] = {}
    end
    if nil == self._currentCount[questNo._group][questNo._quest] then
      self._currentCount[questNo._group][questNo._quest] = {}
    end
    if nil ~= questInfo then
      self._conditionMaxCount = questInfo:getDemandCount()
      local complateCount = 0
      for index = 0, self._conditionMaxCount - 1 do
        local questCondition = questInfo:getDemandAt(index)
        if 0 ~= questCondition._currentCount and self._currentCount[questNo._group][questNo._quest][index] ~= questCondition._currentCount then
          self._maxCount[questNo._group][questNo._quest][index] = questCondition._destCount
          self._currentCount[questNo._group][questNo._quest][index] = questCondition._currentCount
          self._currentIndex = index
          if questCondition._currentCount == questCondition._destCount then
            ToClient_PushToAlertQueue(questInfo, enumState.UI_ALERT_STATE_SUB_SATISFIED, index)
          else
            ToClient_PushToAlertQueue(questInfo, enumState.UI_ALERT_STATE_PROGRASSING, index)
          end
        end
        if questCondition._currentCount == questCondition._destCount then
          complateCount = complateCount + 1
        end
      end
      if complateCount == self._conditionMaxCount then
        ToClient_PushToAlertQueue(questInfo, enumState.UI_ALERT_STATE_ALL_SATISFIED, -1)
      end
    end
  end
end
function FromClient_ChallengeAlert_Init()
  local self = challengeAlert
  self:init()
  self:popNextAlert()
end
function testChallenge(questNoRaw)
  local self = challengeAlert
  self:open("test", "desc")
end
registerEvent("FromClient_luaLoadComplete", "FromClient_ChallengeAlert_Init")
