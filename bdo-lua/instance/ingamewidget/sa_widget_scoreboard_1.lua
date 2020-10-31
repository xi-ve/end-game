function PaGlobal_SA_Widget_ScoreBoard:initialize()
  if true == PaGlobal_SA_Widget_ScoreBoard._initialize then
    return
  end
  self._ui.stc_resultIcon = UI.getChildControl(Panel_SA_Widget_ScoreBoard, "StaticText_ResultIcon")
  self._ui.stc_totalResultIcon = UI.getChildControl(Panel_SA_Widget_ScoreBoard, "StaticText_TotalResultIcon")
  self._ui.stc_myRankBG = UI.getChildControl(Panel_SA_Widget_ScoreBoard, "Static_MyRankBG")
  self._ui.stc_myCharIcon = UI.getChildControl(self._ui.stc_myRankBG, "Static_CharacterIcon")
  self._ui.txt_myUserID = UI.getChildControl(self._ui.stc_myRankBG, "StaticText_UserID")
  self._ui.txt_myRankValue = UI.getChildControl(self._ui.stc_myRankBG, "StaticText_MyRankValue")
  self._ui.txt_myKillValue = UI.getChildControl(self._ui.stc_myRankBG, "StaticText_MyKillScoreValue")
  self._ui.stc_otherRankIcon = UI.getChildControl(Panel_SA_Widget_ScoreBoard, "Static_OtherRankIcon")
  self._ui.list2_scoreList = UI.getChildControl(Panel_SA_Widget_ScoreBoard, "List2_ScoreList")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SA_Widget_ScoreBoard:registEventHandler()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_ScoreBoard_ReSizePanel")
  registerEvent("EventSelfPlayerDead", "FromClient_SA_Widget_ScoreBoard_MyRecord")
  registerEvent("FromClient_BattleRoyaleWinner", "PaGlobal_SA_Widget_ScoreBoard_SetWinner")
  registerEvent("FromClient_BattleRoyaleRecord", "FromClient_SA_Widget_ScoreBoard_MyRecord")
  registerEvent("FromClient_BattleRoyaleStateChanged", "FromClient_SA_Widget_ScoreBoard_BattleRoyaleStateChanged")
  self._ui.list2_scoreList:registEvent(CppEnums.PAUIList2EventType.luaChangeContent, "PaGlobal_SA_Widget_ScoreBoard_CreateListControl")
  self._ui.list2_scoreList:createChildContent(CppEnums.PAUIList2ElementManagerType.list)
end
function PaGlobal_SA_Widget_ScoreBoard:prepareOpen()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard:open()
end
function PaGlobal_SA_Widget_ScoreBoard:open()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  Panel_SA_Widget_ScoreBoard:SetShow(true)
end
function PaGlobal_SA_Widget_ScoreBoard:prepareClose()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  PaGlobal_SA_Widget_ScoreBoard:close()
end
function PaGlobal_SA_Widget_ScoreBoard:close()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  Panel_SA_Widget_ScoreBoard:SetShow(false)
end
function PaGlobal_SA_Widget_ScoreBoard:update()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
end
function PaGlobal_SA_Widget_ScoreBoard:validate()
  if nil == Panel_SA_Widget_ScoreBoard then
    return
  end
  self._ui.stc_resultIcon:isValidate()
  self._ui.stc_totalResultIcon:isValidate()
  self._ui.stc_myRankBG:isValidate()
  self._ui.stc_myCharIcon:isValidate()
  self._ui.txt_myUserID:isValidate()
  self._ui.txt_myRankValue:isValidate()
  self._ui.txt_myKillValue:isValidate()
  self._ui.stc_otherRankIcon:isValidate()
  self._ui.list2_scoreList:isValidate()
end
function PaGlobal_SA_Widget_ScoreBoard:showOtherRank(isShow)
  for idx = 1, self._maxWinnerPlayer do
  end
  self._ui.stc_otherRankIcon:SetShow(isShow)
  local listManager = self._ui.list2_scoreList:getElementManager()
  local myRank = ToClient_ShadowArenaScoreCount()
  if nil ~= listManager then
    listManager:clearKey()
    local endIdx = myRank - 1
    if endIdx < 1 then
      return
    end
    for i = 1, endIdx + 1 do
      listManager:pushKey(toInt64(0, i))
    end
  end
end
function PaGlobal_SA_Widget_ScoreBoard:showAllRank(isShow)
  self._ui.stc_otherRankIcon:SetShow(isShow)
  local listManager = self._ui.list2_scoreList:getElementManager()
  if nil ~= listManager then
    listManager:clearKey()
    local maxPlayerCount = ToClient_BattleRoyaleTotalPlayerCount()
    for i = 1, maxPlayerCount do
      listManager:pushKey(toInt64(0, i))
    end
  end
end
function PaGlobal_SA_Widget_ScoreBoard:setWinnerInfo(idx, nickName, classType)
  local killCnt = 0
  local classSymbolInfo = CppEnums.ClassType_Symbol[classType]
end
