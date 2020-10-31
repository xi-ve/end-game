function PaGlobal_BarterInfoSearch_Refresh_Close()
  PaGlobal_BarterInfoRefresh:close()
end
function PaGlobal_BarterInfoSearch_RequestChangeBarterList()
  ToClient_requrstChangeBarterList(PaGlobal_BarterInfoRefresh._selectIndex)
  PaGlobal_BarterInfoRefresh:close()
end
