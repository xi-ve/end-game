function FromClient_SA_Widget_Quest_RefreshMission()
  if nil == Panel_SA_Widget_Quest or false == Panel_SA_Widget_Quest:GetShow() then
    return
  end
  PaGlobal_SA_Widget_Quest:refreshMission()
  PaGlobal_SA_Widget_Quest:updateMissionCondition()
  PaGlobal_SA_Widget_Quest_ShowAni()
end
function FromClient_SA_Widget_Quest_UpdateMission()
  PaGlobal_SA_Widget_Quest:updateMissionCondition()
end
function FromClient_SA_Widget_Quest_CompleteMission()
  if nil == Panel_SA_Widget_Quest or false == Panel_SA_Widget_Quest:GetShow() then
    return
  end
  local successTitle = ToClient_GetClearedMissionTitle()
  if successTitle == PaGlobal_SA_Widget_Quest._ui.txt_questTitle:GetText() then
    PaGlobal_SA_Widget_Quest._ui.txt_questTitle:SetFontColor(Defines.Color.C_FFF26A6A)
    PaGlobal_SA_Widget_Quest._ui.txt_questTitle:SetText(PaGlobal_SA_Widget_Quest._strMissionSuccess1)
    PaGlobal_SA_Widget_Quest._ui.txt_questCondition:SetShow(true)
    PaGlobal_SA_Widget_Quest._ui.txt_questCondition:SetFontColor(Defines.Color.C_FFF26A6A)
    PaGlobal_SA_Widget_Quest._ui.txt_questCondition:SetText(PaGlobal_SA_Widget_Quest._strMissionSuccess2)
    PaGlobal_SA_Widget_Quest._ui.stc_questIcon:addInputEvent("Mouse_On", "")
    PaGlobal_SA_Widget_Quest._ui.stc_questIcon:addInputEvent("Mouse_Out", "")
  end
end
function FromClient_SA_Widget_Quest_ReSizePanel()
  PaGlobal_SA_Widget_Quest._ui.stc_questBG:ComputePos()
  PaGlobal_SA_Widget_Quest._ui.stc_questIcon:ComputePos()
  PaGlobal_SA_Widget_Quest._ui.txt_questTitle:ComputePos()
  PaGlobal_SA_Widget_Quest._ui.txt_questCondition:ComputePos()
end
function PaGlobal_SA_Widget_Quest_ShowMissionNotifyMessage(deltatime)
  PaGlobal_SA_Widget_Quest:showMissionNotifyMessage(deltatime)
end
function PaGlobal_SA_Widget_Quest_CatchClassChange()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if classType ~= __eClassType_BlackSpirit then
    PaGlobal_SA_Widget_Quest._isBlackSpirit = false
  else
    PaGlobal_SA_Widget_Quest._isBlackSpirit = true
  end
end
function PaGlobal_SA_Widget_Quest_ShowAni()
  local panel = Panel_SA_Widget_Quest
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 40, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
