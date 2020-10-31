function PaGlobal_SA_Widget_Lobby_BG_Open()
  PaGlobal_SA_Widget_Lobby_BG:prepareOpen()
end
function PaGlobal_SA_Widget_Lobby_BG_Close()
  PaGlobal_SA_Widget_Lobby_BG:prepareClose()
end
function FromClient_SA_Widget_Lobby_BG_ResizePanel()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  SA_Widget_Lobby_BG:SetSize(screenSizeX, screenSizeY)
  SA_Widget_Lobby_BG:ComputePos()
end
function PaGlobal_SA_Widget_Lobby_BG_ShowAni()
  if nil == SA_Widget_Lobby_BG then
    return
  end
end
function PaGlobal_SA_Widget_Lobby_BG_HideAni()
  if nil == SA_Widget_Lobby_BG then
    return
  end
end
