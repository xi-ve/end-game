function PaGlobal_Arsha_SelectMember_All:initialize()
  if true == PaGlobal_Arsha_SelectMember_All._initialize or nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_ArshaSelectMember_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleArea, "StaticText_Title")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_ArshaSelectMember_All, "Static_Bg")
  self._ui.txt_titleLineBg = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Line")
  self._ui.txt_titleCheck = UI.getChildControl(self._ui.stc_mainBg, "StaticText_CheckTitle")
  self._ui.txt_titleClass = UI.getChildControl(self._ui.stc_mainBg, "StaticText_ClassTitle")
  self._ui.txt_titleLevel = UI.getChildControl(self._ui.stc_mainBg, "StaticText_LevelTitle")
  self._ui.txt_titleName = UI.getChildControl(self._ui.stc_mainBg, "StaticText_NameTitle")
  self._ui.txt_titleState = UI.getChildControl(self._ui.stc_mainBg, "StaticText_StateTitle")
  self._ui.list2_member = UI.getChildControl(self._ui.stc_mainBg, "List2_Member")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_Window_ArshaSelectMember_All, "Static_BottomBg")
  self._ui.txt_ourTeamState = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_OurTeamState")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Win_Close")
  self._ui_pc.btn_confirm = UI.getChildControl(self._ui.stc_bottomBg, "Button_Adjust")
  self._ui_console.stc_keyGuideBG = UI.getChildControl(Panel_Window_ArshaSelectMember_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_keyGuideY = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_SelectMember_All:validate()
  PaGlobal_Arsha_SelectMember_All:registEventHandler()
  PaGlobal_Arsha_SelectMember_All:swichPlatform(self._isConsole)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == ToClient_CompetitionMatchType() and CppEnums.CompetitionFightState.eCompetitionFightState_SelectAttend == ToClient_CompetitionFightState() then
    PaGlobalFunc_Arsha_SelectMember_All_Open()
  end
  PaGlobal_Arsha_SelectMember_All._initialize = true
end
function PaGlobal_Arsha_SelectMember_All:swichPlatform(isConsole)
  self._ui_pc.btn_close:SetShow(not isConsole)
  self._ui_pc.btn_confirm:SetShow(not isConsole)
  if true == isConsole then
    self:setAlignKeyGuide()
  end
  if true ~= isGameTypeKorea() then
    self._ui.txt_titleCheck:SetShow(false)
  end
end
function PaGlobal_Arsha_SelectMember_All:prepareOpen()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  PaGlobal_Arsha_SelectMember_All:open()
  PaGlobal_Arsha_SelectMember_All:update()
  PaGlobal_Arsha_SelectMember_All:resize()
end
function PaGlobal_Arsha_SelectMember_All:dataclear()
end
function PaGlobal_Arsha_SelectMember_All:open()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  Panel_Window_ArshaSelectMember_All:SetShow(true)
end
function PaGlobal_Arsha_SelectMember_All:prepareClose()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  PaGlobal_Arsha_SelectMember_All:close()
end
function PaGlobal_Arsha_SelectMember_All:close()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  Panel_Window_ArshaSelectMember_All:SetShow(false)
end
function PaGlobal_Arsha_SelectMember_All:update()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  self:updateMemberList()
end
function PaGlobal_Arsha_SelectMember_All:dataClear()
  self._attendUserNoTemp = toInt64(-1, -1)
end
local EnableControl = function(target, isEnable)
  if true == isEnable then
    target:SetEnable(true)
    target:SetMonoTone(false)
    target:SetIgnore(false)
  else
    target:SetEnable(false)
    target:SetMonoTone(true)
    target:SetIgnore(true)
  end
end
local EnableText = function(targetText, isEnable)
  if true == isEnable then
    targetText:SetFontAlpha(1)
  else
    targetText:SetFontAlpha(0.65)
  end
end
function PaGlobal_Arsha_SelectMember_All:updateMemberList()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  local myTeamNo = ToClient_GetMyTeamNo()
  local isSelfTeamMaster = ToClient_Arsha_IsMySelfTeamMaster()
  local isAttendSetted = ToClient_IsMyTeamAttendSetted()
  if true == isAttendSetted then
    local attendUserInfo = ToClient_GetArshaAttendUserInfo(myTeamNo)
    if nil == attendUserInfo then
      return
    end
    PaGlobal_Arsha_SelectMember_All._attendUserNoTemp = attendUserInfo:getUserNo()
  end
  if true == self._isConsole then
    if true == isSelfTeamMaster then
      self._ui_console.stc_keyGuideBG:SetShow(true)
      PaGlobal_Arsha_SelectMember_All:setAlignKeyGuide()
      if false == isAttendSetted then
        self._ui_console.txt_keyGuideY:SetShow(true)
        Panel_Window_ArshaSelectMember_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Arsha_SelectMemeber_All_ConfirmAttendMember()")
      else
        self._ui_console.txt_keyGuideY:SetShow(false)
        Panel_Window_ArshaSelectMember_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
    else
      self._ui_console.stc_keyGuideBG:SetShow(false)
    end
  else
    self._ui_pc.btn_confirm:SetShow(isSelfTeamMaster)
    EnableControl(self._ui_pc.btn_confirm, not isAttendSetted)
  end
  local ListTeamCount = ToClient_GetTeamUserInfoCount(myTeamNo)
  self._ui.list2_member:getElementManager():clearKey()
  if 0 < ListTeamCount then
    for ii = 0, ListTeamCount - 1 do
      self._ui.list2_member:getElementManager():pushKey(ii)
    end
  end
  if true == isAttendSetted then
    self._ui.txt_ourTeamState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING_OTHERATTEND"))
  elseif true == ToClient_Arsha_IsMySelfTeamMaster() then
    self._ui.txt_ourTeamState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_SELECT_AND_CONFIRM"))
  else
    self._ui.txt_ourTeamState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_SELECTING_OURATTEND"))
  end
end
function PaGlobal_Arsha_SelectMember_All:updateMemberContent(content, userIdx)
  local myTeamNo = ToClient_GetMyTeamNo()
  local teamInfo = ToClient_GetArshaTeamInfo(myTeamNo)
  if nil == teamInfo then
    return
  end
  local userInfo = ToClient_GetTeamUserInfoAt(myTeamNo, Int64toInt32(userIdx))
  if nil == userInfo then
    return
  end
  local isAttendSet = ToClient_IsMyTeamAttendSetted()
  local isDead = userInfo:isDeadInPersonalMatch()
  local selectedUserInfo = ToClient_GetEntryInfoByUserNo(self._attendUserNoTemp)
  local userNo = userInfo:getUserNo()
  local selectedUserNo = -1
  if nil ~= selectedUserInfo then
    selectedUserNo = selectedUserInfo:getUserNo()
  end
  local parentBG = UI.getChildControl(content, "Static_ParentBG")
  parentBG:setNotImpactScrollEvent(true)
  local rdo_attend = UI.getChildControl(parentBG, "RadioButton_SelectAttend")
  local stc_classIcon = UI.getChildControl(parentBG, "Static_ClassIcon")
  local txt_level = UI.getChildControl(parentBG, "StaticText_Level")
  local txt_name = UI.getChildControl(parentBG, "StaticText_CharacterName")
  local txt_state = UI.getChildControl(parentBG, "StaticText_State")
  local stc_masterIcon = UI.getChildControl(parentBG, "Static_TeamMasterIcon")
  PaGlobalFunc_Util_ChangeTextureClass(stc_classIcon, userInfo:getCharacterClass())
  txt_name:SetText(userInfo:getCharacterName())
  txt_level:SetText(tostring(userInfo:getCharacterLevel()))
  local isSelfTeamMaster = ToClient_Arsha_IsMySelfTeamMaster()
  if true == self._isConsole then
    if true == isSelfTeamMaster then
      parentBG:SetIgnore(false)
      parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    else
      parentBG:SetIgnore(true)
    end
  end
  local isEnable = true
  if true == isAttendSet then
    EnableControl(rdo_attend, false)
    rdo_attend:SetCheck(self._attendUserNoTemp == userNo)
    if selectedUserNo == userNo then
      txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_ENTRYSTATUS_FIGHTING"))
    elseif true == userInfo:isDeadInPersonalMatch() then
      txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_ENTRYSTATUS_DEFEATTED"))
    else
      txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_ENTRYSTATUS_WAITING"))
    end
  else
    EnableControl(rdo_attend, true)
    rdo_attend:SetShow(true)
    if true == userInfo:isDeadInPersonalMatch() then
      txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_ENTRYSTATUS_DEFEATTED"))
      rdo_attend:SetShow(false)
    else
      txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_ENTRYSTATUS_WAITING"))
      rdo_attend:SetCheck(self._attendUserNoTemp == userNo)
      if true == isSelfTeamMaster and true == self._isConsole then
        parentBG:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Arsha_SelectMember_SetAttend(" .. Int64toInt32(userIdx) .. ")")
      else
        rdo_attend:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_SelectMember_SetAttend(" .. Int64toInt32(userIdx) .. ")")
      end
    end
  end
  stc_masterIcon:SetShow(false)
  if false == isSelfTeamMaster then
    rdo_attend:SetShow(false)
    if userNo == teamInfo:getTeamMaster() then
      stc_masterIcon:SetShow(true)
    end
  end
end
function PaGlobal_Arsha_SelectMember_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Arsha_SelectMember_All._ui_console.txt_keyGuideY,
    PaGlobal_Arsha_SelectMember_All._ui_console.txt_keyGuideA
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Arsha_SelectMember_All._ui_console.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Arsha_SelectMember_All:registEventHandler()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_SelectMember_All_Close()")
  self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Arsha_SelectMemeber_All_ConfirmAttendMember()")
  self._ui.list2_member:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Arsha_SelectMember_UpdateList")
  self._ui.list2_member:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_SelectAttendTimeAlert", "FromClient_Arsha_SelectMember_All_SelectAttendTimeAlert")
  registerEvent("FromClient_PersonalMatchAttendSetted", "FromClient_Arsha_SelectMember_All_PersonalMatchAttendSetted")
  registerEvent("FromClient_PersonalMatchMasterSetted", "FromClient_Arsha_SelectMember_All_PersonalMatchMasterSetted")
  registerEvent("FromClient_ArshaMyAttendSetResult", "FromClient_Arsha_SelectMember_All_ArshaMyAttendSetResult")
  registerEvent("FromClient_FirstMatchStart", "FromClient_Arsha_SelectMember_All_ResetArshaSelectAttendUI")
  registerEvent("FromClient_ArshaTeamAttendOut", "FromClient_Arsha_SelectMembet_All_ResetSelectMemberUI")
  registerEvent("FromClient_UpdateEntryList", "FromClient_Arsha_SelectMembet_All_UpdateEntryList")
  registerEvent("FromClient_UpdateTeamScore", "FromClient_Arsha_SelectMembet_All_UpdateTeamScore")
end
function PaGlobal_Arsha_SelectMember_All:validate()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.txt_titleLineBg:isValidate()
  self._ui.txt_titleCheck:isValidate()
  self._ui.txt_titleClass:isValidate()
  self._ui.txt_titleLevel:isValidate()
  self._ui.txt_titleName:isValidate()
  self._ui.txt_titleState:isValidate()
  self._ui.list2_member:isValidate()
  self._ui.stc_bottomBg:isValidate()
  self._ui.txt_ourTeamState:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_console.stc_keyGuideBG:isValidate()
  self._ui_console.txt_keyGuideY:isValidate()
  self._ui_console.txt_keyGuideA:isValidate()
end
function PaGlobal_Arsha_SelectMember_All:resize()
  if nil == Panel_Window_ArshaSelectMember_All then
    return
  end
  Panel_Window_ArshaSelectMember_All:ComputePos()
end
