function PaGlobal_AltarRankWeb_Open()
  if false == PaGlobal_AltarRankWeb.isConsole and false == _ContentsGroup_BattleFieldVolunteer then
    return
  end
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb:prepareOpen()
  PaGlobal_AltarRankWeb:open()
end
function PaGlobal_AltarRankWeb_Close()
  if nil == PaGlobal_AltarRankWeb then
    return
  end
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb:prepareClose()
  PaGlobal_AltarRankWeb:close()
end
function Input_AltarRankWeb_ToWebBanner(key)
  PaGlobal_AltarRankWeb._webControl:TriggerEvent("FromClient_GamePadInputForWebBanner", key)
end
function PaGlobal_AltarRankWeb_ShowAni()
  if nil == PaGlobal_AltarRankWeb then
    return
  end
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb:showAni()
end
function PaGlobal_AltarRankWeb_HideAni()
  if nil == PaGlobal_AltarRankWeb then
    return
  end
  if nil == Panel_AltarRank_Web then
    return
  end
  PaGlobal_AltarRankWeb:hideAni()
end
function FromClient_resetCoherentUIForAltarRank()
  if Panel_AltarRank_Web:GetShow() then
    TooltipSimple_Hide()
    PaGlobal_AltarRankWeb_Close()
  end
end
