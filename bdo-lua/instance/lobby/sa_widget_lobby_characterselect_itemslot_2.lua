function PaGlobal_Lobby_CharacterSelect_ItemSlot_Open()
  if nil == PaGlobal_Lobby_CharacterSelect_ItemSlot then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemSlot:prepareOpen()
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot_Close()
  if nil == PaGlobal_Lobby_CharacterSelect_ItemSlot then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemSlot:prepareClose()
end
function PaGlobal_Lobby_CharacterSelect_ItemSlot_SelectItem(index, itemKey, count)
  if nil == PaGlobal_Lobby_CharacterSelect_ItemSlot then
    return
  end
  PaGlobal_Lobby_CharacterSelect_ItemSlot:setItem(index - 1, itemKey, count)
  PaGlobal_Lobby_CharacterSelect_ItemSlot:update()
end
function HandleEventLup_Button_CharacterItemShop()
  PaGlobal_Lobby_CharacterSelect_ItemShop_Open()
end
