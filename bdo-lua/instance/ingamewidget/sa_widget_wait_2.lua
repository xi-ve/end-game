function FromClient_SA_Widget_Wait_ReSizePanel()
  Panel_SA_Widget_Wait:ComputePos()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_title:ComputePos()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value1:ComputePos()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value2:ComputePos()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value:ComputePos()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_title:SetText("")
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value1:SetText("")
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value:SetText("")
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value2:SetText("")
  PaGlobal_SA_Widget_Wait._ui.txt_wait_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_WAITTITLE"))
  PaGlobal_SA_Widget_ComputeJoinPlayerCount()
end
function FromClient_SA_Widget_Wait_ChangeBattleRoyalePlayerCount()
  PaGlobal_SA_Widget_ComputeJoinPlayerCount()
  FromClient_SA_Widget_Wait_ReSizePanel()
end
function PaGlobal_SA_Widget_ComputeJoinPlayerCount()
  PaGlobal_SA_Widget_Wait._maxPlayerCnt = ToClient_BattleRoyaleTotalPlayerCount()
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value1:SetText(PaGlobal_SA_Widget_Wait._maxPlayerCnt)
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value:SetText("/")
  PaGlobal_SA_Widget_Wait._ui.txt_wait_value2:SetText(PaGlobal_SA_Widget_Wait._beforeCnt)
end
function PaGlobal_SA_Widget_Wait_Open()
  PaGlobal_SA_Widget_Wait:prepareOpen()
end
function PaGlobal_SA_Widget_Wait_Close()
  PaGlobal_SA_Widget_Wait:prepareClose()
end
function PaGlobal_SA_Widget_Wait_ChangeSurvival()
  PaGlobal_SA_Widget_Wait_Close()
  PaGlobal_SA_Widget_Survival_Open()
  PaGlobal_Minimap_Open()
end
function PaGlobal_SA_Widget_Wait_ShowAni()
  if nil == Panel_SA_Widget_Wait then
    return
  end
end
function PaGlobal_SA_Widget_Wait_HideAni()
  if nil == Panel_SA_Widget_Wait then
    return
  end
end
