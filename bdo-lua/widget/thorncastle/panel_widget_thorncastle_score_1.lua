function PaGlobal_ThornCastle_Score:initialize()
  if true == PaGlobal_ThornCastle_Score._initialize then
    return
  end
  self._ui._allyTeamSign[1] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_MyTeam_L")
  self._ui._allyTeamSign[2] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_MyTeam_R")
  self._ui._teamSocre[1] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_Score_Blue")
  self._ui._teamSocre[2] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_Score_Red")
  self._ui._teamNameText[1] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_TeamName_Blue")
  self._ui._teamNameText[2] = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_TeamName_Red")
  self._ui._timer = UI.getChildControl(Panel_Widget_ThornCastle_ScorePanel, "StaticText_Time")
  PaGlobal_ThornCastle_Score:registEventHandler()
  PaGlobal_ThornCastle_Score:validate()
  PaGlobal_ThornCastle_Score._initialize = true
  self._ui._timer:SetText("00:00")
  self._ui._teamNameText[1]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_THORNCASTLE_TEAMNAME_BLUE"))
  self._ui._teamNameText[2]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_THORNCASTLE_TEAMNAME_RED"))
  self._ui._teamSocre[1]:SetText("0")
  self._ui._teamSocre[2]:SetText("0")
  for ii = 1, 2 do
    self._ui._allyTeamSign[ii]:SetShow(false)
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    self:prepareOpen()
  else
    self:prepareClose()
  end
  local elepsedTime = ToClient_GetInstanceDungeonElepsedTime()
  if 0 ~= elepsedTime then
    PaGlobal_ThornCastle_Score:StartTimer(elepsedTime)
    for ii = 1, 2 do
      self._ui._teamSocre[ii]:SetText(tostring(ToClient_GetTeamPoint(ii - 1)))
    end
  end
end
function PaGlobal_ThornCastle_Score:prepareOpen()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  local teamNo = ToClient_GetOthilitaTeamNo()
  self._ui._allyTeamSign[teamNo + 1]:SetShow(true)
  self:open()
end
function PaGlobal_ThornCastle_Score:open()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  Panel_Widget_ThornCastle_ScorePanel:SetShow(true)
end
function PaGlobal_ThornCastle_Score:prepareClose()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  self:close()
end
function PaGlobal_ThornCastle_Score:close()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  Panel_Widget_ThornCastle_ScorePanel:SetShow(false)
end
function ThornCastle_Time_Update(upadateTime)
  local self = PaGlobal_ThornCastle_Score
  if nil == self then
    return
  end
  self._ui._timer:SetText(convertSecondsToClockTime(ToClient_GetInstanceDungeonElepsedTime()))
end
function PaGlobal_ThornCastle_Score:validate()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  for ii = 1, 2 do
    self._ui._allyTeamSign[ii]:isValidate()
    self._ui._teamNameText[ii]:isValidate()
    self._ui._teamSocre[ii]:isValidate()
  end
  self._ui._timer:isValidate()
end
function PaGlobal_ThornCastle_Score:registEventHandler()
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  registerEvent("FromClient_ThornCastleUpdateTeamPoint", "FromClient_Widget_ThornCastle_Update_Team_Point")
  registerEvent("FromClient_Widget_ThornCastle_Start_Notify", "FromClient_Widget_ThornCastle_Update_Start_Timer")
end
function PaGlobal_ThornCastle_Score:UpdateTeamPoint(teamNo, point)
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  self._ui._teamSocre[teamNo + 1]:SetText(tostring(point))
end
function PaGlobal_ThornCastle_Score:StartTimer(startTime)
  if nil == Panel_Widget_ThornCastle_ScorePanel then
    return
  end
  Panel_Widget_ThornCastle_ScorePanel:RegisterUpdateFunc("ThornCastle_Time_Update")
end
function FromClient_Widget_ThornCastle_Update_Team_Point(teamNo, point)
  if false == PaGlobal_ThornCastle_Score._initialize then
    return
  end
  PaGlobal_ThornCastle_Score:UpdateTeamPoint(teamNo, point)
end
function FromClient_Widget_ThornCastle_Update_Start_Timer(startTime)
  if false == PaGlobal_ThornCastle_Score._initialize then
    return
  end
  PaGlobal_ThornCastle_Score:StartTimer(startTime)
end
