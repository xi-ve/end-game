function PaGlobal_MusicSetting_All_ShowTooltip(index, trackType)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if nil == index then
    return
  end
  if nil == trackType then
    return
  end
  local button = PaGlobal_MusicSetting_All._ui._rbtn_Track[index].control
  if nil == button then
    return
  end
  TooltipSimple_Show(button, PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. trackType))
end
function FromClient_UpdateMusicSettingPartyReady(actorKeyRaw, isAllow)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  PaGlobal_MusicSetting_All:updateResembleState(actorKeyRaw, isAllow)
end
function PaGlobal_MusicSetting_All_ShowAni()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_MusicSetting_All)
  local aniInfo1 = Panel_Window_MusicSetting_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MusicSetting_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MusicSetting_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MusicSetting_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MusicSetting_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MusicSetting_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_MusicSetting_All_HideAni()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  Panel_Window_MusicSetting_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_MusicSetting_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_MusicSetting_All_SelectTrack(index)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  PaGlobal_MusicSetting_All._trackIndex = index
  PaGlobal_MusicSetting_All:updatePlayTime(PaGlobal_MusicSetting_All._trackIndex)
end
function PaGlobal_MusicSetting_All_Select_Character(index)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  PaGlobal_MusicSetting_All._selectIndex = index
end
function PaGlobal_MusicSetting_All_List2Update(content, key)
  if nil == Panel_Window_MusicSetting_All or false == Panel_Window_MusicSetting_All:GetShow() then
    return
  end
  local key32 = Int64toInt32(key)
  local characterList = PaGlobal_MusicSetting_All._characterIndexList[key32]
  if nil == characterList then
    return
  end
  for ii = 1, 2 do
    local radioButton = UI.getChildControl(content, "RadioButton_CharacterSlot_" .. tostring(ii - 1))
    local characterData
    if nil ~= characterList[ii] then
      characterData = getCharacterDataByIndex(characterList[ii])
    end
    if nil ~= characterData then
      radioButton:SetText(getCharacterName(characterData))
      radioButton:SetShow(true)
      if PaGlobal_MusicSetting_All._selectIndex ~= characterList[ii] then
        radioButton:SetCheck(false)
      else
        radioButton:SetCheck(true)
      end
      radioButton:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_Select_Character(" .. characterList[ii] .. ")")
    else
      radioButton:SetShow(false)
    end
  end
end
function PaGlobal_MusicSetting_All_ClickSolo()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if PaGlobal_MusicSetting_All._type._SOLO == PaGlobal_MusicSetting_All._currentType then
    return
  end
  PaGlobal_MusicSetting_All._currentType = PaGlobal_MusicSetting_All._type._SOLO
  PaGlobal_MusicSetting_All:closeResemble()
end
function PaGlobal_MusicSetting_All_ClickResemble()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if false == PaGlobal_MusicSetting_All:resembleRequestAble(true) then
    return
  end
  if PaGlobal_MusicSetting_All._type._RESEMBLE == PaGlobal_MusicSetting_All._currentType then
    return
  end
  PaGlobal_MusicSetting_All._currentType = PaGlobal_MusicSetting_All._type._RESEMBLE
  PaGlobal_MusicSetting_All:openResemble()
end
function PaGlobal_MusicSetting_All_ResembleRequest()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local isCheckedDistance = true
  if false == ToClient_IsPlayMusicAble(isCheckedDistance) then
    return
  end
  if false == PaGlobal_MusicSetting_All:resembleRequestAble(true) then
    return
  end
  if false == Toclient_isHaveInstrument(PaGlobal_MusicSetting_All._trackIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInstrumentItem"))
    return
  end
  local selectCharacterPanelSizeY = PaGlobal_MusicSetting_All._ui._static_selectCharaterBg:GetSizeY()
  if true == _ContentsGroup_InstrumentActivation then
    PaGlobal_MusicSetting_All._ui._static_playKindBg:SetPosY(PaGlobal_MusicSetting_All._ui._static_playKindBg:GetPosY() + selectCharacterPanelSizeY)
  end
  PaGlobal_MusicSetting_All._isRequestResemble = true
  PaGlobal_MusicSetting_All:openResemble()
  ToClient_PlayPartyMusicReq(PaGlobal_MusicSetting_All._musicIndex, PaGlobal_MusicSetting_All._trackIndex)
  PaGlobal_MusicSetting_All:updatePlayKind()
end
function PaGlobal_MusicSetting_All_PlayMusicSolo()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if false == _ContentsGroup_InstrumentActivation or -1 == PaGlobal_MusicSetting_All._selectIndex then
    ToClient_PlayMusic_Other(PaGlobal_MusicSetting_All._musicIndex, PaGlobal_MusicSetting_All._trackIndex)
  else
    ToClient_PlayMusic_Summon(PaGlobal_MusicSetting_All._musicIndex, PaGlobal_MusicSetting_All._trackIndex, PaGlobal_MusicSetting_All._selectIndex)
  end
end
function PaGlobal_MusicSetting_All_PlayMusicResemble()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local isWaitMember = false
  for _, partyInfo in pairs(PaGlobal_MusicSetting_All._partyInfo) do
    if nil ~= partyInfo and PaGlobal_MusicSetting_All._state._WAIT == partyInfo._state then
      isWaitMember = true
      break
    end
  end
  if true == isWaitMember then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayMusicWaitMember"))
    return
  end
  ToClient_PartyMusicStartReq()
end
function PaGlobal_MusicSetting_All_PlayMusic()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if true == PaGlobal_PlayMusic_All_IsShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayMusic"))
    return
  end
  if PaGlobal_MusicSetting_All._currentType == PaGlobal_MusicSetting_All._type._SOLO then
    PaGlobal_MusicSetting_All_PlayMusicSolo()
  elseif PaGlobal_MusicSetting_All._currentType == PaGlobal_MusicSetting_All._type._RESEMBLE then
    PaGlobal_MusicSetting_All_PlayMusicResemble()
  end
end
function PaGlobal_MusicSetting_All_CloseForPlayMusic()
  PaGlobal_MusicSetting_All:prepareClose()
end
function PaGlobal_MusicSetting_All_Close()
  local closeResembleAndNotify = function()
    ToClient_RequestCancelResemble()
    PaGlobal_MusicSetting_All:prepareClose()
    PaGlobal_MusicBoard_All_Open()
  end
  if true == PaGlobal_MusicSetting_All._isRequestResemble then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_CANCEL_RESEMBLE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxMemo,
      functionYes = closeResembleAndNotify,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_MusicSetting_All:prepareClose()
    PaGlobal_MusicBoard_All_Open()
  end
end
function PaGlobal_MusicSetting_All_Open(musicIndex)
  PaGlobal_MusicBoard_All_Close()
  PaGlobal_MusicSetting_All:prepareOpen(musicIndex)
end
