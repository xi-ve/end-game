function PaGlobal_Lobby_CharacterSelect_Top_Open()
  PaGlobal_Lobby_CharacterSelect_Top:prepareOpen()
end
function PaGlobal_Lobby_CharacterSelect_Top_Close()
  PaGlobal_Lobby_CharacterSelect_Top:prepareClose()
end
function HandleEventLup_Button_MainMenu()
  PaGlobal_Lobby_MainMenu_Open()
  PaGlobal_Lobby_TopMenu_Open()
  PaGlobal_Lobby_ChatingMenu_Open()
  PaGlobal_Lobby_CharacterSelect_Bottom_Close()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo_Close()
  PaGlobal_Lobby_CharacterSelect_FriendsSlot_Close()
  PaGlobal_Lobby_CharacterSelect_InviteFriend_Close()
  PaGlobal_Lobby_CharacterSelect_ItemSlot_Close()
  PaGlobal_Lobby_CharacterSelect_List_Close()
  PaGlobal_Lobby_CharacterSelect_Top_Close()
end
