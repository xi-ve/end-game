function PaGlobal_VolunteerRankWeb_Open()
  if false == _ContentsGroup_BattleFieldVolunteer then
    return
  end
  if nil == PaGlobal_VolunteerRankWeb then
    return
  end
  if nil == Panel_Window_VolunteerRankWeb then
    return
  end
  PaGlobal_VolunteerRankWeb:prepareOpen()
  PaGlobal_VolunteerRankWeb:open()
end
function PaGlobal_VolunteerRankWeb_Close()
  if nil == PaGlobal_VolunteerRankWeb then
    return
  end
  if nil == Panel_Window_VolunteerRankWeb then
    return
  end
  PaGlobal_VolunteerRankWeb:prepareClose()
  PaGlobal_VolunteerRankWeb:close()
end
function PaGlobal_VolunteerRankWeb_ShowAni()
  if nil == PaGlobal_VolunteerRankWeb then
    return
  end
  if nil == Panel_Window_VolunteerRankWeb then
    return
  end
  PaGlobal_VolunteerRankWeb:showAni()
end
function PaGlobal_VolunteerRankWeb_HideAni()
  if nil == PaGlobal_VolunteerRankWeb then
    return
  end
  if nil == Panel_Window_VolunteerRankWeb then
    return
  end
  PaGlobal_VolunteerRankWeb:hideAni()
end
function FromClient_resetCoherentUIForVolunteerRankWeb()
  if Panel_Window_VolunteerRankWeb:GetShow() then
    TooltipSimple_Hide()
    PaGlobal_VolunteerRankWeb_Close()
  end
end
