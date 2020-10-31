function PaGlobal_MusicSetting_All:initialize()
  if true == PaGlobal_MusicSetting_All._initialize then
    return
  end
  self._instrumentTrackListSize = Toclient_MidiInstrumentTrackCount()
  Panel_Window_MusicSetting_All:SetShow(false)
  Panel_Window_MusicSetting_All:setGlassBackground(true)
  Panel_Window_MusicSetting_All:ActiveMouseEventEffect(false)
  self._ui._static_MainBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_MainBg")
  local titleBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_TitleBG")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Win_Close_PC")
  self._ui._static_txt_title = UI.getChildControl(titleBg, "StaticText_Title")
  local musicInfoBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_MusicInfoBg")
  self._ui._txt_MusicName = UI.getChildControl(musicInfoBg, "StaticText_MusicValue")
  self._ui._txt_MusicName:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_PlayTime = UI.getChildControl(musicInfoBg, "StaticText_TimeValue")
  self._ui._txt_AuthorName = UI.getChildControl(musicInfoBg, "StaticText_ComposerValue")
  self._ui._txt_AuthorName:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_ConposerName = UI.getChildControl(musicInfoBg, "StaticText_ArrangerValue")
  self._ui._txt_ConposerName:SetTextMode(__eTextMode_LimitText)
  self._ui._static_playKindBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_PlayKindBg")
  self._ui._rbtn_Track = {}
  for index = 0, self._instrumentTrackListSize - 1 do
    local midiType = Toclient_getTrackTypeByIndex(index)
    if -1 ~= midiType then
      self._ui._rbtn_Track[index] = {}
      self._ui._rbtn_Track[index].control = UI.getChildControl(self._ui._static_playKindBg, "RadioButton_Instrument_" .. midiType + 1)
      self._ui._rbtn_Track[index].midiType = midiType
    end
  end
  self._trackGapX = 5
  self._trackStartPosX = self._ui._static_playKindBg:GetPosX() + self._ui._static_playKindBg:GetSizeX() - self._trackGapX
  self._ui._rbtn_Solo = UI.getChildControl(self._ui._static_playKindBg, "RadioButton_Solo")
  self._ui._rbtn_Resemble = UI.getChildControl(self._ui._static_playKindBg, "RadioButton_Ensemble")
  self._ui._btn_Request = UI.getChildControl(self._ui._static_playKindBg, "Button_Request")
  self._ui._static_stateBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_StateBg")
  self._ui._txt_party = {}
  for index = 0, self._partyCnt do
    self._partyInfo[index] = {}
    self._partyInfo[index]._txt_Name = UI.getChildControl(self._ui._static_stateBg, "StaticText_Party" .. index + 1)
    self._partyInfo[index]._txt_State = UI.getChildControl(self._ui._static_stateBg, "StaticText_State" .. index + 1)
    self._partyInfo[index]._actorKeyRaw = 0
  end
  self._ui._static_BottomBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_BottomGroup")
  self._ui._btn_Play = UI.getChildControl(self._ui._static_BottomBg, "Button_Play")
  self._ui._btn_Cancel = UI.getChildControl(self._ui._static_BottomBg, "Button_Cancel")
  self._ui._static_selectCharaterBg = UI.getChildControl(Panel_Window_MusicSetting_All, "Static_CharacterSelect")
  self._ui._static_selectCharaterList = UI.getChildControl(self._ui._static_selectCharaterBg, "List2_1")
  self._resembleGap = self._ui._static_stateBg:GetSizeY() + self._ui._btn_Request:GetSizeY()
  self._panelDefaultSizeY = Panel_Window_MusicSetting_All:GetSizeY()
  self._mainBgDefaultSizeY = self._ui._static_MainBg:GetSizeY()
  PaGlobal_MusicSetting_All:registEventHandler()
  PaGlobal_MusicSetting_All:validate()
  local selectCharacterPanelSizeY = self._ui._static_selectCharaterBg:GetSizeY()
  if false == _ContentsGroup_InstrumentActivation then
    self._playKindBgPos = self._ui._static_playKindBg:GetPosY() - selectCharacterPanelSizeY
  else
    self._playKindBgPos = self._ui._static_playKindBg:GetPosY()
  end
  self._ui._static_stateBg:SetPosY(self._ui._static_stateBg:GetPosY() - selectCharacterPanelSizeY)
  PaGlobal_MusicSetting_All._initialize = true
  self._ui._static_txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "MUSIC_BAND_NAME", "familyname", getFamilyName()))
end
function PaGlobal_MusicSetting_All:registEventHandler()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  registerEvent("FromClient_UpdateMusicSettingPartyReady", "FromClient_UpdateMusicSettingPartyReady")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_Close()")
  for index = 0, self._instrumentTrackListSize - 1 do
    local midiType = Toclient_getTrackTypeByIndex(index)
    if -1 ~= midiType then
      self._ui._rbtn_Track[index].control:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_SelectTrack(" .. midiType .. ")")
      self._ui._rbtn_Track[index].control:addInputEvent("Mouse_On", "PaGlobal_MusicSetting_All_ShowTooltip(" .. index .. "," .. midiType .. ")")
      self._ui._rbtn_Track[index].control:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    end
  end
  self._ui._rbtn_Solo:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_ClickSolo()")
  self._ui._rbtn_Resemble:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_ClickResemble()")
  self._ui._btn_Request:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_ResembleRequest()")
  self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_Close()")
  self._ui._btn_Play:addInputEvent("Mouse_LUp", "PaGlobal_MusicSetting_All_PlayMusic()")
  self._ui._static_selectCharaterList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_MusicSetting_All_List2Update")
  self._ui._static_selectCharaterList:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Window_MusicSetting_All:RegisterShowEventFunc(true, "PaGlobal_MusicSetting_All_ShowAni()")
  Panel_Window_MusicSetting_All:RegisterShowEventFunc(false, "PaGlobal_MusicSetting_All_HideAni()")
end
function PaGlobal_MusicSetting_All:prepareOpen(musicIndex)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  if not ToClient_IsPopUpToggle() then
    return
  end
  if isGameTypeKR2() then
    return
  end
  self._selectIndex = -1
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  self:resize()
  self._musicIndex = musicIndex
  self._isRequestResemble = false
  self:update(musicIndex)
  self:updatePlayKind()
  self:clearTrackButton()
  self:setResembleButton()
  self._ui._rbtn_Resemble:SetCheck(false)
  self._ui._rbtn_Solo:SetCheck(true)
  PaGlobal_MusicSetting_All_ClickSolo()
  self:createCharacterButton()
  PaGlobal_MusicSetting_All:open()
end
function PaGlobal_MusicSetting_All:resembleRequestAble(inNotify)
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  local isLeader = selfPlayer:isPartyLeader(selfActorKeyRaw)
  local hasParty = selfPlayer:get():hasParty()
  if false == hasParty then
    if true == inNotify then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPartyNotExist"))
    end
    return false
  end
  if false == isLeader then
    if true == inNotify then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPartyNotLeader"))
    end
    return false
  end
  return true
end
function PaGlobal_MusicSetting_All:setResembleButton()
  local able = self:resembleRequestAble(false)
  self._ui._rbtn_Resemble:SetMonoTone(false == able)
  self._ui._rbtn_Resemble:SetIgnore(false == able)
end
function PaGlobal_MusicSetting_All:clearTrackButton()
  self._ui._btn_Play:SetEnable(true)
  self._ui._btn_Play:SetMonoTone(false)
  local defaultSetting = false
  local defaultIndex = 0
  for index = 0, self._instrumentTrackListSize - 1 do
    if true == self._ui._rbtn_Track[index].control:GetShow() then
      defaultIndex = index
      defaultSetting = true
      break
    end
  end
  if false == defaultSetting then
    PaGlobal_MusicSetting_All_SelectTrack(-1)
    return
  end
  for index = 0, self._instrumentTrackListSize - 1 do
    self._ui._rbtn_Track[index].control:SetCheck(index == defaultIndex)
  end
  PaGlobal_MusicSetting_All_SelectTrack(self._ui._rbtn_Track[defaultIndex].midiType)
end
function PaGlobal_MusicSetting_All:open()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  Panel_Window_MusicSetting_All:SetShow(true)
end
function PaGlobal_MusicSetting_All:prepareClose()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  PaGlobal_MusicSetting_All:close()
end
function PaGlobal_MusicSetting_All:close()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  Panel_Window_MusicSetting_All:SetShow(false)
end
function PaGlobal_MusicSetting_All:clearResemble()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  for index = 0, self._partyCnt do
    self._partyInfo[index]._txt_Name:SetShow(false)
    self._partyInfo[index]._txt_State:SetShow(false)
  end
end
function PaGlobal_MusicSetting_All:closeResemble()
  if false == _ContentsGroup_InstrumentActivation then
    local selectCharacterPanelSizeY = self._ui._static_selectCharaterBg:GetSizeY()
    Panel_Window_MusicSetting_All:SetSize(Panel_Window_MusicSetting_All:GetSizeX(), self._panelDefaultSizeY - self._resembleGap - selectCharacterPanelSizeY)
    self._ui._static_MainBg:SetSize(self._ui._static_MainBg:GetSizeX(), self._mainBgDefaultSizeY - self._resembleGap - selectCharacterPanelSizeY)
    self._ui._static_selectCharaterBg:SetShow(false)
    self._ui._static_playKindBg:SetPosY(self._playKindBgPos)
  else
    Panel_Window_MusicSetting_All:SetSize(Panel_Window_MusicSetting_All:GetSizeX(), self._panelDefaultSizeY - self._resembleGap)
    self._ui._static_selectCharaterBg:SetShow(true)
    self._ui._static_MainBg:SetSize(self._ui._static_MainBg:GetSizeX(), self._mainBgDefaultSizeY - self._resembleGap)
    self._ui._static_playKindBg:SetPosY(self._playKindBgPos)
  end
  self._ui._static_BottomBg:ComputePos()
  self._ui._btn_Request:SetShow(false)
  self._ui._static_stateBg:SetShow(false)
  self._ui._btn_Play:SetEnable(true)
  self._ui._btn_Play:SetMonoTone(false)
end
function PaGlobal_MusicSetting_All:openResemble()
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if partyMemberCount > self._partyCnt + 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MUSICPLAYER_MAXCOUNT"))
    self._ui._btn_Play:SetEnable(false)
    self._ui._btn_Play:SetMonoTone(true)
    return
  else
    self._ui._btn_Play:SetEnable(true)
    self._ui._btn_Play:SetMonoTone(false)
  end
  self._ui._btn_Request:SetShow(true)
  self._ui._static_stateBg:SetShow(true)
  local selectCharacterPanelSizeY = self._ui._static_selectCharaterBg:GetSizeY()
  self._ui._static_selectCharaterBg:SetShow(false)
  if true == _ContentsGroup_InstrumentActivation then
    self._ui._static_playKindBg:SetPosY(self._ui._static_playKindBg:GetPosY() - selectCharacterPanelSizeY)
  end
  Panel_Window_MusicSetting_All:SetSize(Panel_Window_MusicSetting_All:GetSizeX(), self._panelDefaultSizeY - selectCharacterPanelSizeY)
  self._ui._static_MainBg:SetSize(self._ui._static_MainBg:GetSizeX(), self._mainBgDefaultSizeY - selectCharacterPanelSizeY)
  self._ui._static_BottomBg:ComputePos()
  self:clearResemble()
  local realIndex = 0
  for index = 0, partyMemberCount - 1 do
    local memberData = RequestParty_getPartyMemberAt(index)
    if nil ~= memberData then
      self._partyInfo[realIndex]._txt_Name:SetShow(true)
      self._partyInfo[realIndex]._txt_State:SetShow(true)
      self._partyInfo[realIndex]._txt_Name:SetText(memberData:name())
      self._partyInfo[realIndex]._txt_State:SetText(PaGlobal_MusicSetting_All._stateStr._WAIT)
      self._partyInfo[realIndex]._actorKeyRaw = memberData:getActorKey()
      self._partyInfo[realIndex]._state = self._state._WAIT
      realIndex = realIndex + 1
    end
  end
end
function PaGlobal_MusicSetting_All:updatePlayKind()
  self._ui._rbtn_Solo:SetIgnore(self._isRequestResemble)
  self._ui._rbtn_Solo:SetMonoTone(self._isRequestResemble)
  self._ui._btn_Request:SetIgnore(self._isRequestResemble)
  self._ui._btn_Request:SetMonoTone(self._isRequestResemble)
end
function PaGlobal_MusicSetting_All:clearButton()
  for index = 0, self._instrumentTrackListSize - 1 do
    self._ui._rbtn_Track[index].control:SetShow(false)
  end
end
function PaGlobal_MusicSetting_All:setButtonPos()
  local startX = self._trackStartPosX
  for index = self._instrumentTrackListSize - 1, 0, -1 do
    local button = self._ui._rbtn_Track[index].control
    if nil ~= button and true == button:GetShow() then
      startX = startX - self._trackGapX - button:GetSizeX()
      button:SetPosX(startX)
    end
  end
end
function PaGlobal_MusicSetting_All:setTrackList(musicInfo)
  if nil == musicInfo then
    return
  end
  self:clearButton()
  for index = 0, self._instrumentTrackListSize - 1 do
    if false == musicInfo:isEmpty(self._ui._rbtn_Track[index].midiType) and true == Toclient_isHaveInstrument(self._ui._rbtn_Track[index].midiType) then
      self._ui._rbtn_Track[index].control:SetShow(true)
    end
  end
  self:setButtonPos()
end
function PaGlobal_MusicSetting_All:update(musicIndex)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local musicInfo = ToClient_GetMusicInfoByIndex(musicIndex)
  if nil == musicInfo then
    return
  end
  self._ui._txt_MusicName:SetText(musicInfo:getMusicName())
  self._ui._txt_PlayTime:SetText(musicInfo:getMaxPlayTime())
  self._ui._txt_AuthorName:SetText(musicInfo:getAuthorName())
  self._ui._txt_ConposerName:SetText(musicInfo:getLastComposer())
  self:setTrackList(musicInfo)
end
function PaGlobal_MusicSetting_All:updatePlayTime(trackIndex)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local musicInfo = ToClient_GetMusicInfoByIndex(self._musicIndex)
  if nil == musicInfo then
    return
  end
  local timeTickCount = musicInfo:getTrackPlayTime(trackIndex)
  local endSellTimeValue = PATime(timeTickCount / 1000)
  local timeStr = string.format("%.02d", endSellTimeValue:GetMinute()) .. ":" .. string.format("%.02d", endSellTimeValue:GetSecond())
  self._ui._txt_PlayTime:SetText(timeStr)
end
function PaGlobal_MusicSetting_All:updateResembleState(actorKeyRaw, isAllow)
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local str = ""
  for _, partyInfo in pairs(self._partyInfo) do
    if nil ~= partyInfo and actorKeyRaw == partyInfo._actorKeyRaw then
      if true == isAllow then
        str = PaGlobal_MusicSetting_All._stateStr._READY
        partyInfo._state = self._state._READY
      else
        str = PaGlobal_MusicSetting_All._stateStr._REFUSE
        partyInfo._state = self._state._REFUSE
      end
      partyInfo._txt_State:SetText(str)
      break
    end
  end
end
function PaGlobal_MusicSetting_All:validate()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  self._ui._static_selectCharaterBg:isValidate()
  self._ui._static_selectCharaterList:isValidate()
  self._ui._static_playKindBg:isValidate()
  self._ui._static_txt_title:isValidate()
end
function PaGlobal_MusicSetting_All:resize()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  Panel_Window_MusicSetting_All:SetPosX(getScreenSizeX() * 0.5 - Panel_Window_MusicSetting_All:GetSizeX() * 0.5)
  Panel_Window_MusicSetting_All:SetPosY(getScreenSizeY() * 0.5 - Panel_Window_MusicSetting_All:GetSizeY() * 0.5)
end
function PaGlobal_MusicSetting_All:createCharacterButton()
  if nil == Panel_Window_MusicSetting_All then
    return
  end
  local characterCount = getCharacterDataCount()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  self._ui._static_selectCharaterList:getElementManager():clearKey()
  self._selectIndex = -1
  local newLine = true
  local lineNo = 1
  self._characterIndexList = {}
  for ii = 0, characterCount - 1 do
    local characterData = getCharacterDataByIndex(ii)
    if nil ~= characterData and __eClassType_ShyWaman == getCharacterClassType(characterData) and selfPlayer:getCharacterNo_64() ~= characterData._characterNo_s64 then
      if true == newLine then
        self._characterIndexList[lineNo] = Array.new()
        newLine = false
      end
      if nil ~= self._characterIndexList[lineNo] then
        self._characterIndexList[lineNo]:push_back(ii)
        if 2 == #self._characterIndexList[lineNo] then
          newLine = true
          lineNo = lineNo + 1
        end
      end
    end
  end
  for ii = 1, #self._characterIndexList do
    self._ui._static_selectCharaterList:getElementManager():pushKey(toInt64(0, ii))
  end
end
