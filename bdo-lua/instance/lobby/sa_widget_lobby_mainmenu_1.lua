function PaGlobal_Lobby_MainMenu:initialize()
  if true == self._initialize then
    return
  end
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  self._ui._playButton = UI.getChildControl(SA_Widget_Lobby_MainMenu, "Button_GamePlay")
  self._ui._partyButton = UI.getChildControl(SA_Widget_Lobby_MainMenu, "Button_TeamPlay")
  self:registEventHandler()
  self:validate()
  self:prepareOpen()
  self._initialize = true
end
function PaGlobal_Lobby_MainMenu:registEventHandler()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  self._ui._playButton:addInputEvent("Mouse_LUp", "HandleEventLup_MainMenu_PlayTap()")
  self._ui._partyButton:addInputEvent("Mouse_LUp", "HandleEventLup_MainMenu_partyTap()")
end
function PaGlobal_Lobby_MainMenu:prepareOpen()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  ToClient_GetStoredBattleRoyaleEntryInfo()
  PaGlobal_Lobby_MainMenu:open()
end
function PaGlobal_Lobby_MainMenu:open()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  SA_Widget_Lobby_MainMenu:SetShow(true)
  resetShadowArenaCharacter(0, 0, -160, -1)
  viewCharacterPitchRoll(0, 0)
  viewCharacterFov(0.64)
  setWeatherTime(7, 15)
  _isOpenLobbyMainUI = false
end
function PaGlobal_Lobby_MainMenu:prepareClose()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  SA_Widget_Lobby_MainMenu:ClearUpdateLuaFunc()
  PaGlobal_Lobby_MainMenu:close()
end
function PaGlobal_Lobby_MainMenu:close()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  SA_Widget_Lobby_MainMenu:SetShow(false)
  _isOpenLobbyMainUI = true
end
function PaGlobal_Lobby_MainMenu:update()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
end
function PaGlobal_Lobby_MainMenu:validate()
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  self._ui._playButton:isValidate()
end
