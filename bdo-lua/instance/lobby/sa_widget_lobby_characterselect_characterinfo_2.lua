function PaGlobal_Lobby_CharacterSelect_CharacterInfo_Open(selectCharacterNo, battleType)
  if nil == PaGlobal_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  if nil == selectCharacterNo then
    return
  end
  if nil ~= battleType then
    PaGlobal_Lobby_CharacterSelect_CharacterInfo_SetSelectBattleType(battleType)
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo_SetSelectCharacterInfo(selectCharacterNo)
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:createSkillIcon()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:setSkillName()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo_ShowCharacterSelectAni()
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:prepareOpen()
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo_Close()
  if nil == PaGlobal_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:prepareClose()
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo_SetSelectCharacterInfo(selectCharacterNo)
  if nil == PaGlobal_Lobby_CharacterSelect_CharacterInfo or nil == selectCharacterNo then
    return
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo._nowSelectClassNo = selectCharacterNo
  PaGlobal_Lobby_CharacterSelect_CharacterInfo._characterName = getClassName(selectCharacterNo)
  PaGlobal_Lobby_CharacterSelect_CharacterInfo._characterDesc = getClassDescription(selectCharacterNo)
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo_SetSelectBattleType(battleType)
  if nil == PaGlobal_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo._selectBattleType = battleType
end
function FromClient_PaGlobal_Lobby_CharacterSelect_CharacterInfo_ReSizePanel()
  if nil == PaGlobal_Lobby_CharacterSelect_CharacterInfo then
    return
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo:resizePanel()
end
function HandleEventOn_Lobby_CharacterSelect_CharacterInfo_ShowToolTip(isShow, skillNo, index)
  if false == isShow then
    Panel_SkillTooltip_Hide()
  else
    Panel_SkillTooltip_Show_SA_Lobby(skillNo, false, "LobbySkill", index)
  end
end
function PaGlobal_Lobby_CharacterSelect_CharacterInfo_ShowCharacterSelectAni()
  local panel = SA_Widget_Lobby_CharacterSelect_CharacterInfo
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 60, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
  panel:CalcUIAniPos(moveAni)
end
