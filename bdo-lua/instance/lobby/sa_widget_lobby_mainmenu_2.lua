function PaGlobal_Lobby_MainMenu_Open()
  if nil == PaGlobal_Lobby_MainMenu then
    return
  end
  PaGlobal_Lobby_MainMenu:prepareOpen()
end
function PaGlobal_Lobby_MainMenu_Close()
  if nil == PaGlobal_Lobby_MainMenu then
    return
  end
  PaGlobal_Lobby_MainMenu:prepareClose()
end
function HandleEventLup_MainMenu_PlayTap()
  InitializeCharacterSelectMenu(__eBattleRoyaleMode_Solo)
end
function HandleEventLup_MainMenu_partyTap()
  InitializeCharacterSelectMenu(__eBattleRoyaleMode_Team)
end
function joinparty()
  ToClient_ShadowArenaJoinParty(11718)
end
function InitializeCharacterSelectMenu(battleRoyaleMode)
  if nil == SA_Widget_Lobby_MainMenu then
    return
  end
  local self = PaGlobal_Lobby_MainMenu
  if nil == self then
    return
  end
  PaGlobal_Lobby_MainMenu_Close()
  PaGlobal_Lobby_TopMenu_Close()
  PaGlobal_Lobby_ChatingMenu_Close()
  PaGlobal_Lobby_CharacterSelect_Bottom_Open(battleRoyaleMode)
  PaGlobal_Lobby_CharacterSelect_ItemSlot_Open()
  PaGlobal_Lobby_CharacterSelect_List_Open()
  PaGlobal_Lobby_CharacterSelect_Top_Open()
  if __eBattleRoyaleMode_Team == battleRoyaleMode then
    ToClient_BattleRoyaleMakeParty()
  end
end
