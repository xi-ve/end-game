local UI_Color = Defines.Color
function FGlobal_UI_CharacterInfo_Basic_Global_CraftColorReplace(lev)
  local levColor = UI_Color.C_FFC4C4C4
  if 1 <= lev and lev <= 10 then
    levColor = UI_Color.C_FFC4C4C4
  elseif 11 <= lev and lev <= 20 then
    levColor = UI_Color.C_FF76B24D
  elseif 21 <= lev and lev <= 30 then
    levColor = UI_Color.C_FF3B8BBE
  elseif 31 <= lev and lev <= 40 then
    levColor = UI_Color.C_FFEBC467
  elseif 41 <= lev and lev <= 50 then
    levColor = UI_Color.C_FFD04D47
  elseif 51 <= lev and lev <= 80 then
    levColor = UI_Color.C_FFB23BC7
  elseif 81 <= lev and lev <= 130 then
    levColor = UI_Color.C_FFC78045
  end
  return levColor
end
function FGlobal_UI_CharacterInfo_Basic_Global_CraftLevelReplace(lev)
  if 1 <= lev and lev <= 10 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_1") .. lev
  elseif 11 <= lev and lev <= 20 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_2") .. lev - 10
  elseif 21 <= lev and lev <= 30 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_3") .. lev - 20
  elseif 31 <= lev and lev <= 40 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_4") .. lev - 30
  elseif 41 <= lev and lev <= 50 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40
  elseif 51 <= lev and lev <= 80 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_6") .. lev - 50
  elseif 81 <= lev and lev <= 130 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80
  end
  return lev
end
function FGlobal_UI_CharacterInfo_Basic_Global_CheckIntroduceUiEdit(targetUI)
  if false == PaGlobal_CharacterInfoPanel_GetShowPanelStatus() then
    return
  end
  local self = PaGlobal_CharacterInfoBasic
  return nil ~= targetUI and targetUI:GetKey() == self._ui._multilineEdit:GetKey()
end
