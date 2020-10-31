function PaGlobal_SA_Widget_Lobby_BG:initialize()
  if true == self._initialize then
    return
  end
  self:registEventHandler()
  self:validate()
  PaGlobal_SA_Widget_Lobby_BG_Open()
  FromClient_SA_Widget_Lobby_BG_ResizePanel()
  self._initialize = true
end
function PaGlobal_SA_Widget_Lobby_BG:registEventHandler()
  if nil == SA_Widget_Lobby_BG then
    return
  end
  registerEvent("onScreenResize", "FromClient_SA_Widget_Lobby_BG_ResizePanel()")
  SA_Widget_Lobby_BG:RegisterShowEventFunc(true, "PaGloabl_SA_Widget_Lobby_BG_ShowAni()")
  SA_Widget_Lobby_BG:RegisterShowEventFunc(false, "PaGloabl_SA_Widget_Lobby_BG_HideAni()")
end
function PaGlobal_SA_Widget_Lobby_BG:prepareOpen()
  if nil == SA_Widget_Lobby_BG then
    return
  end
  PaGlobal_SA_Widget_Lobby_BG:open()
end
function PaGlobal_SA_Widget_Lobby_BG:open()
  if nil == SA_Widget_Lobby_BG then
    return
  end
  SA_Widget_Lobby_BG:SetShow(true)
end
function PaGlobal_SA_Widget_Lobby_BG:prepareClose()
  if nil == SA_Widget_Lobby_BG then
    return
  end
  PaGlobal_SA_Widget_Lobby_BG:close()
end
function PaGlobal_SA_Widget_Lobby_BG:close()
  if nil == SA_Widget_Lobby_BG then
    return
  end
  SA_Widget_Lobby_BG:SetShow(false)
end
function PaGlobal_SA_Widget_Lobby_BG:update()
  if nil == SA_Widget_Lobby_BG then
    return
  end
end
function PaGlobal_SA_Widget_Lobby_BG:validate()
  if nil == SA_Widget_Lobby_BG then
    return
  end
end
