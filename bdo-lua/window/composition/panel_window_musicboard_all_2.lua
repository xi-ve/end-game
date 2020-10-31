function PaGlobal_MusicBoard_All_FilterTooltipShow(index, midiType)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if nil == index then
    return
  end
  if nil == midiType then
    return
  end
  local control = PaGlobal_MusicBoard_All._ui._checkBox_Filter[index]
  if nil == control then
    return
  end
  TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. midiType))
end
function PaGlobal_MusicBoard_All_ListTooltipShow(key, index)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  local content = PaGlobal_MusicBoard_All._ui._list2:GetContentByKey(key)
  if nil == content then
    return
  end
  local control = UI.getChildControl(content, "Radiobutton_Instrument_" .. index + 1)
  if nil == control then
    return
  end
  TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. index))
end
function PaGlobal_MusicBoard_All_ListEtcTooltip(key)
  local content = PaGlobal_MusicBoard_All._ui._list2:GetContentByKey(key)
  if nil == content then
    return
  end
  local control = UI.getChildControl(content, "Radiobutton_Instrument_etc")
  if nil == control then
    return
  end
  TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_INSTRUMENT_ETC"))
end
function PaGlobal_MusicBoard_All_OpenAlbum()
  PaGlobal_MusicAlbum_All_Open()
end
function PaGlobal_MusicBoard_All_SoundOption()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if true == _ContentsGroup_NewUI_GameOption_All then
    PaGlobal_GameOption_All:Open()
    PaGlobal_GameOption_All:GoCategory("Sound")
  else
    PaGlobal_Option:Open()
    PaGlobal_Option:GoCategory("Sound")
  end
end
function FromClient_IncreaseExp_MusicBoard(level, exp, isLevelUp)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if false == Panel_Window_MusicBoard_All:GetShow() then
    return
  end
  PaGlobal_MusicBoard_All._ui._txt_GradeValue:SetText(ToClient_GetMusicRank())
end
function FromClient_OpenMusicBoardToPartyMusic()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  local agree = function()
    PaGlobal_MusicBoard_All_OpenForResemble()
  end
  local refuse = function()
    ToClient_PlayPartyMusicRefuseReq()
  end
  local leaderName = RequestParty_getLeaderName()
  if "" == leaderName then
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MUSIC_REQUEST_RESEMBLE_NOTY", "name", leaderName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = agree,
    functionNo = refuse,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_ClosePartyMusic(isCloseToPlayMusic)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if true == PaGlobal_MusicBoard_All._isResemble then
    PaGlobal_MusicBoard_All_CloseByResemble()
    if false == isCloseToPlayMusic then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_CANCEL_RESEMBLE_NOTIFY"))
    end
  end
end
function FromClient_InstrumentItem_Use(itemKey)
  if nil == itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    return
  end
  if true == _ContentsGroup_InstrumentShop then
    PaGlobal_MyInstruments_All_Update()
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INSTRUMENTITEM_USE", "instrumentItem", itemSSW:getName()))
end
function PaGlobal_MusicBoard_All_Share()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if -1 == PaGlobal_MusicBoard_All._etcMusicIndex then
    return
  end
  local musicInfo = ToClient_GetMusicInfoByIndex(PaGlobal_MusicBoard_All._etcMusicIndex)
  if nil == musicInfo then
    return
  end
  if getSelfPlayer() == nil then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  if false == musicInfo:getIsEditable() and userNo ~= musicInfo:getAuthorUserNo() and Defines.s64_const.s64_m1 ~= musicInfo:getAuthorUserNo() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOMUSICSHARE"))
    return
  end
  PaGlobal_MusicShare_All_Open(PaGlobal_MusicBoard_All._etcMusicIndex)
end
function PaGlobal_MusicBoard_All_Delete()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if -1 == PaGlobal_MusicBoard_All._etcMusicIndex then
    return
  end
  local deleteComplete = function()
    ToClient_DeleteMusicLocalRepository(PaGlobal_MusicBoard_All._etcMusicIndex)
    ToClient_loadMusicList()
    PaGlobal_MusicBoard_All:update()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_MUSIC_COMPOSITION_DELETE_NOTY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = deleteComplete,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_MusicBoard_All_Edit(key)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if nil ~= key then
    PaGlobal_MusicBoard_All._etcMusicIndex = key
  end
  if -1 == PaGlobal_MusicBoard_All._etcMusicIndex then
    return
  end
  local musicInfo = ToClient_GetMusicInfoByIndex(PaGlobal_MusicBoard_All._etcMusicIndex)
  if nil == musicInfo then
    return
  end
  if getSelfPlayer() == nil then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  if false == musicInfo:getIsEditable() and userNo ~= musicInfo:getAuthorUserNo() and Defines.s64_const.s64_m1 ~= musicInfo:getAuthorUserNo() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOMUSICEDIT"))
    return
  end
  PaGlobal_Composition_All_OpenForEdit(PaGlobal_MusicBoard_All._etcMusicIndex)
  TooltipSimple_Hide()
  PaGlobal_MusicBoard_All_Close()
end
function PaGlobal_MusicBoard_All_ClickedFilter()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  PaGlobal_MusicBoard_All:update()
end
function PaGlobal_MusicBoard_All_Ready()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  ToClient_PlayPartyMusicReadyReq(PaGlobal_MusicBoard_All._musicIndex, PaGlobal_MusicBoard_All._trackIndex)
end
function PaGlobal_MusicBoard_All_Refuse()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  PaGlobal_MusicBoard_All_Close()
end
function PaGlobal_MusicBoard_All_SelectTrack(musicIndex, trackIndex)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  PaGlobal_MusicBoard_All._musicIndex = musicIndex
  PaGlobal_MusicBoard_All._trackIndex = trackIndex
  PaGlobal_MusicBoard_All:updateReadyButton()
end
function PaGlobal_MusicBoard_All_PlayMusic_OpenSetting(musicIndex)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  PaGlobal_MusicSetting_All_Open(musicIndex)
end
function PaGlobal_MusicBoard_All_PlayMusic_Self(musicIndex)
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  if true == PaGlobal_PlayMusic_All_IsShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayMusic"))
    return
  end
  ToClient_PlayMusic_Self(musicIndex)
end
function PaGlobal_MusicBoard_All_PlayMusic_OpenSubMenu(musicIndex)
  PaGlobal_MusicBoard_All:OpenSubMenu(musicIndex)
end
function PaGlobal_MusicBoard_All_ShowAni()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_MusicBoard_All)
  local aniInfo1 = Panel_Window_MusicBoard_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MusicBoard_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MusicBoard_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MusicBoard_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MusicBoard_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MusicBoard_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_MusicBoard_All_HideAni()
  if nil == Panel_Window_MusicBoard_All then
    return
  end
  Panel_Window_MusicBoard_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_MusicBoard_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_MusicBoard_All_CloseByResemble()
  PaGloabl_SelectInstruments_All_Close(false)
  PaGlobal_MusicBoard_All:prepareClose()
end
function PaGlobal_MusicBoard_All_CloseForPlayMusic()
  PaGlobal_MusicBoard_All:prepareClose()
end
function PaGlobal_MusicBoard_All_Close()
  if true == PaGlobal_MusicBoard_All._isResemble then
    ToClient_PlayPartyMusicRefuseReq()
  end
  PaGlobal_MusicBoard_All:prepareClose()
end
function PaGlobal_MusicBoard_All_Open()
  PaGlobal_MusicBoard_All:prepareOpen(false)
end
function PaGlobal_MusicBoard_All_OpenForResemble()
  PaGlobal_MusicBoard_All:prepareOpen(true)
end
