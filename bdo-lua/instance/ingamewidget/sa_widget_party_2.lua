function PaGlobalFunc_SA_Widget_Party_Open()
  PaGlobal_SA_Widget_Party:createPartyList()
  PaGlobal_SA_Widget_Party:updatePartyList()
  PaGlobal_SA_Widget_Party:prepareOpen()
end
function PaGlobalFunc_SA_Widget_Party_Close()
  PaGlobal_SA_Widget_Party:prepareClose()
end
function FromClient_SA_Widget_Party_ReSizePanel()
  Panel_SA_Widget_Party:ComputePos()
  PaGlobal_SA_Widget_Party._ui.stc_partyMeber:ComputePos()
  if PaGlobal_SA_Widget_Party._partyMemberCount == 0 then
    return
  end
  local startPosY = PaGlobal_SA_Widget_Party._ui.stc_partyMeber:GetPosY()
  for member = 1, PaGlobal_SA_Widget_Party._partyMemberCount do
    if nil ~= PaGlobal_SA_Widget_Party._partyMember[member].control then
      PaGlobal_SA_Widget_Party._partyMember[member].control:ComputePos()
      PaGlobal_SA_Widget_Party._partyMember[member].control:SetPosY(startPosY + (PaGlobal_SA_Widget_Party._partyMember[member].control:GetSizeY() + PaGlobal_SA_Widget_Party._gabY) * (member - 1))
    end
  end
end
function FromClient_SA_Widget_Party_CreatePartyList()
  PaGlobal_SA_Widget_Party:createPartyList()
end
function FromClient_SA_Widget_Party_UpdatePartyList()
  PaGlobal_SA_Widget_Party:updatePartyList()
end
function PaGlobalFunc_SA_Widget_Party_RenderModeChange(prevRenderModeList, nextRenderModeList)
  UI.ASSERT_NAME(nil ~= prevRenderModeList, "PaGlobalFunc_SA_Widget_Party_RenderModeChange\236\157\152 prevRenderModeList nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  UI.ASSERT_NAME(nil ~= nextRenderModeList, "PaGlobalFunc_SA_Widget_Party_RenderModeChange\236\157\152 nextRenderModeList nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_SA_Widget_Party:renderModeChange(prevRenderModeList, nextRenderModeList)
end
function PaGlobalFunc_SA_Widget_Party_PartyMemberCount()
  return PaGlobal_SA_Widget_Party._partyMemberCount
end
function PaGlobalFunc_SA_Widget_Party_GetShow()
  if nil ~= Panel_SA_Widget_Party then
    return Panel_SA_Widget_Party:GetShow()
  end
end
function PaGlobalFunc_SA_Widget_Party_SetScreenSize()
  PaGlobal_SA_Widget_Party:setScreenSize()
end
function PaGlobal_SA_Widget_Party_ShowAni()
  if nil == Panel_SA_Widget_Party then
    return
  end
end
function PaGlobal_SA_Widget_Party_HideAni()
  if nil == Panel_SA_Widget_Party then
    return
  end
end
