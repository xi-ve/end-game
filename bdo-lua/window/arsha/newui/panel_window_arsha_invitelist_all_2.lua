function PaGlobalFunc_Arsha_InviteList_All_Open()
  PaGlobal_Arsha_InviteList_All:prepareOpen()
end
function PaGlobalFunc_Arsha_InviteList_All_Close()
  PaGlobal_Arsha_InviteList_All:prepareClose()
end
function HandleEventLUp_ArshaInviteList_All_JoinDecision(idx, isAccept)
  if nil == idx then
    return
  end
  local waitListInfo = ToClient_GetJoinRequesterListAt(idx)
  if nil == waitListInfo then
    return
  end
  local userNo_s64 = waitListInfo:getUserNo()
  ToClient_ResponseJoinCompetition(userNo_s64, isAccept)
end
function PaGlobalFunc_ArshaInviteList_All_ListUpdate(contents, key)
  local idx = Int64toInt32(key)
  local parentBG = UI.getChildControl(contents, "Static_ParentBG")
  parentBG:setNotImpactScrollEvent(true)
  local txt_level = UI.getChildControl(parentBG, "StaticText_Level")
  local txt_class = UI.getChildControl(parentBG, "StaticText_Class")
  local txt_name = UI.getChildControl(parentBG, "StaticText_Name")
  local txt_kind = UI.getChildControl(parentBG, "StaticText_KindOf")
  local btn_accept = UI.getChildControl(parentBG, "Button_InviteAccept")
  local btn_deny = UI.getChildControl(parentBG, "Button_InviteDeny")
  local waitListInfo = ToClient_GetJoinRequesterListAt(idx)
  if nil == waitListInfo then
    return
  end
  local userNo = waitListInfo:getUserNo()
  local userLevel = waitListInfo:getCharacterLevel()
  local userClass = waitListInfo:getCharacterClass()
  local userName = waitListInfo:getUserName()
  local characterName = waitListInfo:getCharacterName()
  local teamNo = waitListInfo:getTeamNo()
  local kindOfValue = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_PARTICIPANT")
  if 0 == teamNo then
    kindOfValue = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_PARTICIPANT")
  else
    kindOfValue = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_OBSERVER")
  end
  txt_level:SetText(userLevel)
  txt_class:SetText(getCharacterClassName(userClass))
  txt_name:SetText(characterName)
  txt_kind:SetText(tostring(kindOfValue))
  if true == PaGlobal_Arsha_InviteList_All._isConsole then
    btn_accept:SetShow(false)
    btn_deny:SetShow(false)
    parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ArshaInviteList_All_JoinDecision(" .. idx .. ", true)")
    parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ArshaInviteList_All_JoinDecision(" .. idx .. ", false)")
  else
    btn_accept:addInputEvent("Mouse_LUp", "HandleEventLUp_ArshaInviteList_All_JoinDecision(" .. idx .. ", true)")
    btn_deny:addInputEvent("Mouse_LUp", "HandleEventLUp_ArshaInviteList_All_JoinDecision(" .. idx .. ", false)")
  end
end
function FromClient_ArshaInviteList_All_UpdateJoinRequesterList()
  PaGlobal_Arsha_InviteList_All:update()
end
