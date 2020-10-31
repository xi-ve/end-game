function PaGlobal_Lobby_CharacterSelect_List_Open()
  if nil == PaGlobal_Lobby_CharacterSelect_List then
    return
  end
  PaGlobal_Lobby_CharacterSelect_List:prepareOpen()
end
function PaGlobal_Lobby_CharacterSelect_List_Close()
  if nil == PaGlobal_Lobby_CharacterSelect_List then
    return
  end
  PaGlobal_Lobby_CharacterSelect_List:prepareClose()
end
function HandleEventLup_SelectClass(index)
  if nil == PaGlobal_Lobby_CharacterSelect_List then
    return
  end
  if PaGlobal_Lobby_CharacterSelect_List._nowSelectIndex == index then
    return
  end
  if nil ~= PaGlobal_Lobby_CharacterSelect_List._nowSelectIndex then
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[PaGlobal_Lobby_CharacterSelect_List._nowSelectIndex]:ResetVertexAni()
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[PaGlobal_Lobby_CharacterSelect_List._nowSelectIndex]:SetVertexAniRun("Ani_Move_Pos_Select2", true)
  end
  PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo = ToClient_getShadowArenaClassTypeByIndex(index - 1)
  PaGlobal_Lobby_CharacterSelect_List._nowSelectIndex = index
  selectShadowArenaCharacter(index - 1)
  if __eClassType_Shadow_Warrior_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -75, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Warrior_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -10, -180, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Maehwa_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -15, -190, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Maehwa_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -80, 0, -0.1, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Sorcerer_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -15, -180, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Sorcerer_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -75, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Giant_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -40, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Giant_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, 10, -100, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Kunoichi_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -80, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Kunoichi_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, -200, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_BladeMaster_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_BladeMaster_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_WizardWoman_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -5, -180, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_WizardWoman_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -55, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Valkyrie_Type1 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  elseif __eClassType_Shadow_Valkyrie_Type2 == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  else
    resetShadowArenaCharacter(0, 0, 0, 0, index - 1)
    viewCharacter(index - 1, 0, -30, 0, 0, false, false)
    viewCharacterPitchRoll(0, 0)
    setWeatherTime(7, 15)
    viewCharacterFov(0.64)
  end
  PaGlobal_Lobby_CharacterSelect_CharacterInfo_Open(PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo, nil)
end
function HandleEventOnOut_CharacterSelect_List_MoveEffect(index, isShow)
  local classType = ToClient_getShadowArenaClassTypeByIndex(index - 1)
  if classType == PaGlobal_Lobby_CharacterSelect_List._nowSelectClassNo then
    return
  end
  if true == isShow then
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[index]:ResetVertexAni()
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[index]:SetVertexAniRun("Ani_Move_Pos_Select", true)
  else
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[index]:ResetVertexAni()
    PaGlobal_Lobby_CharacterSelect_List._ui._RadioButton_CharacterSlot_Activation[index]:SetVertexAniRun("Ani_Move_Pos_Select2", true)
  end
end
