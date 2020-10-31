function PaGlobal_Lobby_ChatingMenu_Open()
  if nil == PaGlobal_Lobby_ChatingMenu then
    return
  end
  PaGlobal_Lobby_ChatingMenu:prepareOpen()
end
function PaGlobal_Lobby_ChatingMenu_Close()
  if nil == PaGlobal_Lobby_ChatingMenu then
    return
  end
  PaGlobal_Lobby_ChatingMenu:prepareClose()
end
