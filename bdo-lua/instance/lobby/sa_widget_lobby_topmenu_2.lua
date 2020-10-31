function PaGlobal_Lobby_TopMenu_Open()
  if nil == PaGlobal_Lobby_TopMenu then
    return
  end
  PaGlobal_Lobby_TopMenu:prepareOpen()
end
function PaGlobal_Lobby_TopMenu_Close()
  if nil == PaGlobal_Lobby_TopMenu then
    return
  end
  PaGlobal_Lobby_TopMenu:prepareClose()
end
function HandleEventLup_Select_TopMenuTap(selectedState)
  if nil == PaGlobal_Lobby_TopMenu then
    return
  end
  local lobbyMainMenu = PaGlobal_Lobby_MainMenu
  if nil == lobbyMainMenu then
    return
  end
end
