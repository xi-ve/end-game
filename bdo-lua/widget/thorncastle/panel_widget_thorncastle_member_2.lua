function FromClient_ThornCastle_Member_updatePartyList()
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    return
  end
  PaGlobal_ThornCastle_Member:updatePartyList()
end
registerEvent("ResponseParty_updatePartyList", "FromClient_ThornCastle_Member_updatePartyList")
