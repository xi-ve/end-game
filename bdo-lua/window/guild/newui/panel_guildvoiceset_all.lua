PaGlobal_GuildVoiceSet_All = {
  _ui = {
    stc_CenterBG = nil,
    txt_MicTitle = nil,
    txt_HearingTitle = nil,
    check_Mic = nil,
    check_Hearing = nil,
    stc_KeyGuide_Bg = nil,
    stc_keyGuide_A = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_Y = nil
  },
  _btnType = {mic = 0, listen = 1},
  _btnFlag = {},
  _currentMember = nil,
  _startBtnGapY = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildVoiceSet_All_Init")
function FromClient_GuildVoiceSet_All_Init()
  PaGlobal_GuildVoiceSet_All:initialize()
end
function PaGlobal_GuildVoiceSet_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildVoiceSet_All then
    return
  end
  self._ui.stc_CenterBG = UI.getChildControl(Panel_GuildVoiceSet_All, "Static_CenterBg")
  self._ui.txt_MicTitle = UI.getChildControl(self._ui.stc_CenterBG, "StaticText_MicTitle")
  self._ui.txt_HearingTitle = UI.getChildControl(self._ui.stc_CenterBG, "StaticText_HearingTitle")
  self._ui.check_Mic = UI.getChildControl(self._ui.stc_CenterBG, "CheckButton_Mic")
  self._ui.check_Hearing = UI.getChildControl(self._ui.stc_CenterBG, "CheckButton_Hearing")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_GuildVoiceSet_All, "Static_BottomBg")
  self._ui.stc_keyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self.keyguide = {
    self._ui.stc_keyGuide_A,
    self._ui.stc_keyGuide_Y,
    self._ui.stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  Panel_GuildVoiceSet_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_registerPanelOnBlackBackground(Panel_GuildVoiceSet_All)
  self._startBtnGapY = self._ui.txt_MicTitle:GetPosY()
  self._ui.txt_MicTitle:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MIC_PERMISSION_TITLE"))
  self._ui.txt_HearingTitle:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MUTE_USER_TITLE"))
  PaGlobal_GuildVoiceSet_All:registerEvent()
  PaGlobal_GuildVoiceSet_All:validate()
end
function PaGlobal_GuildVoiceSet_All:registerEvent()
  Panel_GuildVoiceSet_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventYUp_GuildVoiceSet_All_Confirm()")
  self._ui.check_Mic:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildVoiceSet_All_SetCheckToggle(" .. 0 .. ")")
  self._ui.check_Hearing:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildVoiceSet_All_SetCheckToggle(" .. 1 .. ")")
end
function PaGlobal_GuildVoiceSet_All:validate()
  self._ui.stc_CenterBG:isValidate()
  self._ui.stc_KeyGuide_Bg:isValidate()
end
function PaGlobal_GuildVoiceSet_All:prepareOpen()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  local memberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  local guildMemberInfo = guildInfo:getMember(memberIdx)
  self._currentMember = guildMemberInfo
  if nil == guildMemberInfo then
    return
  end
  self:update()
  PaGlobal_GuildVoiceSet_All:open()
end
function PaGlobal_GuildVoiceSet_All:open()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  Panel_GuildVoiceSet_All:SetShow(true)
end
function PaGlobal_GuildVoiceSet_All:prepareClose()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_GuildVoiceSet_All:close()
end
function PaGlobal_GuildVoiceSet_All:close()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  Panel_GuildVoiceSet_All:SetShow(false)
end
function PaGlobal_GuildVoiceSet_All:update()
  self._ui.txt_MicTitle:SetShow(false)
  self._ui.txt_HearingTitle:SetShow(false)
  self._ui.check_Mic:SetShow(false)
  self._ui.check_Hearing:SetShow(false)
  local isSaying = self._currentMember:isVoicePermissionHas()
  local memberGrade = self._currentMember:getGrade()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local isUnMuteMember = false
  if 0 < self._currentMember:getVoiceVolume() then
    isUnMuteMember = true
  else
    isUnMuteMember = false
  end
  self._btnFlag[self._btnType.mic] = isSaying
  self._btnFlag[self._btnType.listen] = isUnMuteMember
  if isGuildMaster or isGuildSubMaster and 0 ~= memberGrade then
    self._ui.txt_MicTitle:SetShow(true)
    self._ui.check_Mic:SetShow(true)
  end
  if false == self._currentMember:isSelf() then
    self._ui.txt_HearingTitle:SetShow(true)
    self._ui.check_Hearing:SetShow(true)
  end
  self._ui.check_Mic:SetCheck(isSaying)
  self._ui.check_Hearing:SetCheck(isUnMuteMember)
  PaGlobalFunc_GuildVoiceSet_All_SetCheckText()
end
function PaGlobalFunc_GuildVoiceSet_All_Open()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  PaGlobal_GuildVoiceSet_All:prepareOpen()
end
function PaGlobalFunc_GuildVoiceSet_All_Close()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  PaGlobal_GuildVoiceSet_All:prepareClose()
end
function HandleEventYUp_GuildVoiceSet_All_Confirm()
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  local memberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  local guildMemberInfo = guildInfo:getMember(memberIdx)
  local targetMemberUserNo = guildMemberInfo:getUserNo()
  local targetMemberGrade = guildMemberInfo:getGrade()
  local targetMemberListen = guildMemberInfo:isVoiceChatListen()
  local myGuildInfo = guildInfo:getMemberByUserNo(getSelfPlayer():get():getUserNo())
  local myGuildGrade = guildMemberInfo:getGrade()
  local isSaying = PaGlobal_GuildVoiceSet_All._btnFlag[PaGlobal_GuildVoiceSet_All._btnType.mic]
  local isHearing = PaGlobal_GuildVoiceSet_All._btnFlag[PaGlobal_GuildVoiceSet_All._btnType.listen]
  if targetMemberGrade > myGuildGrade then
    ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, targetMemberUserNo, isSaying, targetMemberListen, true)
  end
  if true == isHearing then
    ToClient_VoiceChatChangeVolume(__eVoiceChatType_Guild, targetMemberUserNo, 100)
  else
    ToClient_VoiceChatChangeVolume(__eVoiceChatType_Guild, targetMemberUserNo, 0)
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_GuildVoiceSet_All:close()
end
function HandleEventLUp_GuildVoiceSet_All_SetCheckToggle(btnType)
  if nil == Panel_GuildVoiceSet_All then
    return
  end
  if nil == PaGlobal_GuildVoiceSet_All._btnFlag[btnType] then
    return
  end
  PaGlobal_GuildVoiceSet_All._btnFlag[btnType] = not PaGlobal_GuildVoiceSet_All._btnFlag[btnType]
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobalFunc_GuildVoiceSet_All_SetCheckText()
end
function PaGlobalFunc_GuildVoiceSet_All_SetCheckText()
  if true == PaGlobal_GuildVoiceSet_All._btnFlag[PaGlobal_GuildVoiceSet_All._btnType.mic] then
    PaGlobal_GuildVoiceSet_All._ui.check_Mic:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MIC_PERMISSION_ALLOW"))
  else
    PaGlobal_GuildVoiceSet_All._ui.check_Mic:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_MIC_PERMISSION_BLOCK"))
  end
  if true == PaGlobal_GuildVoiceSet_All._btnFlag[PaGlobal_GuildVoiceSet_All._btnType.listen] then
    PaGlobal_GuildVoiceSet_All._ui.check_Hearing:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_LISTEN_UNMUTE"))
  else
    PaGlobal_GuildVoiceSet_All._ui.check_Hearing:SetText(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_LISTEN_MUTE"))
  end
end
