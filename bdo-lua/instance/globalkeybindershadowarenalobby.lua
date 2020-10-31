local VCK = CppEnums.VirtualKeyCode
local GlobalKeyBinder_CheckKeyPressed = function(keyCode)
  return isKeyDown_Once(keyCode)
end
function CommonWindowFunction(uiInputType, Function, param)
  if true == GlobalKeyBinder_CheckCustomKeyPressed(uiInputType) then
    Function(param)
    return true
  end
end
function GlobalKeyBinder_UpdateShadowArenaLobby(deltaTime)
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_RETURN) then
    ChatInput_Show()
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) and nil ~= SA_Widget_Lobby_CharacterSelect_ItemShop and true == SA_Widget_Lobby_CharacterSelect_ItemShop:GetShow() then
    PaGlobal_Lobby_CharacterSelect_ItemShop_Close()
    return
  end
end
registerEvent("EventGlobalKeyBinderShadowArenaLobby", "GlobalKeyBinder_UpdateShadowArenaLobby")
