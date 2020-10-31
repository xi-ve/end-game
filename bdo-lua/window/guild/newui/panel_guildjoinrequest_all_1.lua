function PaGlobal_GuildJoinRequestList_All:initialize()
  if true == PaGlobal_GuildJoinRequestList_All._initialize then
    return
  end
  PaGlobal_GuildJoinRequestList_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildJoinRequestList_All:ControlAll_Init()
  PaGlobal_GuildJoinRequestList_All:ControlPc_Init()
  PaGlobal_GuildJoinRequestList_All:ControlConsole_Init()
  PaGlobal_GuildJoinRequestList_All:ControlSetShow()
  PaGlobal_GuildJoinRequestList_All:registEventHandler()
  PaGlobal_GuildJoinRequestList_All:validate()
  PaGlobal_GuildJoinRequestList_All._initialize = true
end
function PaGlobal_GuildJoinRequestList_All:ControlAll_Init()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_GuildJoinRequestList_All, "Static_List_BG")
  self._ui._title.txt_level = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_Level")
  self._ui._title.txt_class = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_Class")
  self._ui._title.txt_name = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_CharName")
  self._ui._title.txt_contribute = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_ContributedTendency")
  self._ui._title.txt_attck = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_Attack")
  self._ui._title.txt_awakeAttack = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_AwakenAttack")
  self._ui._title.txt_defence = UI.getChildControl(self._ui.stc_titleBg, "StaticText_M_Defence")
  self._ui.list2_request = UI.getChildControl(Panel_GuildJoinRequestList_All, "List2_RequestListBG")
  self._ui.stc_bottomBg = UI.getChildControl(Panel_GuildJoinRequestList_All, "Static_BottonBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_Desc")
  if true == _ContentsGroup_RenewUI then
    self._ui._title.txt_contribute:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMEMBERLIST_ALL_CONTRIBUTE_TITLE"))
  end
end
function PaGlobal_GuildJoinRequestList_All:ControlPc_Init()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
  self._ui_pc.btn_refresh = UI.getChildControl(self._ui.stc_bottomBg, "Button_Refresh")
end
function PaGlobal_GuildJoinRequestList_All:ControlConsole_Init()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
end
function PaGlobal_GuildJoinRequestList_All:ControlSetShow()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
  self._ui._title.txt_attck:SetShow(false)
  self._ui._title.txt_awakeAttack:SetShow(false)
  self._ui._title.txt_defence:SetShow(false)
  self._ui_pc.btn_refresh:SetShow(not self._isConsole)
end
function PaGlobal_GuildJoinRequestList_All:prepareOpen()
  PaGlobal_GuildJoinRequestList_All:open()
  PaGlobal_GuildJoinRequestList_All:Refresh()
  PaGlobal_GuildJoinRequestList_All:resize()
end
function PaGlobal_GuildJoinRequestList_All:open()
  Panel_GuildJoinRequestList_All:SetShow(true)
end
function PaGlobal_GuildJoinRequestList_All:prepareClose()
  PaGlobal_GuildJoinRequestList_All:close()
end
function PaGlobal_GuildJoinRequestList_All:close()
  Panel_GuildJoinRequestList_All:SetShow(false)
end
function PaGlobal_GuildJoinRequestList_All:update()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  local applicantsSize = ToClient_getGuildApplicantsSize()
  self._ui.list2_request:getElementManager():clearKey()
  if 0 < applicantsSize then
    for ii = 0, applicantsSize - 1 do
      self._ui.list2_request:getElementManager():pushKey(ii)
    end
  end
end
function PaGlobal_GuildJoinRequestList_All:registEventHandler()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
  registerEvent("FromClient_loadCompleteGuildApplicants", "FromClient_GuildJoinRequestList_All_loadCompleteGuildApplicants")
  registerEvent("FromClient_deleteGuildApplicant_Guild", "FromClient_GuildJoinRequestList_All_deleteGuildApplicantGuild")
  self._ui.list2_request = UI.getChildControl(Panel_GuildJoinRequestList_All, "List2_RequestListBG")
  self._ui.list2_request:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildJoinRequestList_All_CreateControlList2")
  self._ui.list2_request:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._title.txt_contribute:SetEnableArea(0, 0, self._ui._title.txt_contribute:GetTextSizeX(), self._ui._title.txt_contribute:GetSizeY())
  self._ui._title.txt_contribute:addInputEvent("Mouse_On", "PaGlobal_GuildJoinRequestList_All:ShowToolTip(true)")
  self._ui._title.txt_contribute:addInputEvent("Mouse_Out", "PaGlobal_GuildJoinRequestList_All:ShowToolTip(false)")
  if true == self._isConsole then
    PaGlobal_GuildMain_All._ui.stc_Recruit_Bg:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_GuildJoinRequestList_All_Refresh()")
  else
    self._ui_pc.btn_refresh:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildJoinRequestList_All_Refresh()")
  end
end
function PaGlobal_GuildJoinRequestList_All:validate()
  if nil == Panel_GuildJoinRequestList_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui._title.txt_level:isValidate()
  self._ui._title.txt_class:isValidate()
  self._ui._title.txt_name:isValidate()
  self._ui._title.txt_contribute:isValidate()
  self._ui._title.txt_attck:isValidate()
  self._ui._title.txt_awakeAttack:isValidate()
  self._ui._title.txt_defence:isValidate()
  self._ui.list2_request:isValidate()
  self._ui.stc_bottomBg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui_pc.btn_refresh:isValidate()
end
function PaGlobal_GuildJoinRequestList_All:resize()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  self._ui.list2_request:ComputePos()
end
function PaGlobal_GuildJoinRequestList_All:ShowToolTip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  local control = self._ui._title.txt_contribute
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_CONTRIBUTEDTENDENCY_DESC")
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_GuildJoinRequestList_All:Refresh()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  ToClient_requestGuildApplicants()
end
function PaGlobal_GuildJoinRequestList_All:WhisperToPlayer(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(index)
  if nil == applicantInfoWrapper then
    return
  end
  FGlobal_ChattingInput_ShowWhisper(applicantInfoWrapper:getUserNickName())
end
function PaGlobal_GuildJoinRequestList_All:requestDeleteApplicant(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._RECRUIT) then
    return
  end
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(index)
  if nil == applicantInfoWrapper then
    return
  end
  local function requestDeleteApplicant()
    ToClient_requestDeleteGuildApplicant(__eGuildApplicantType_Delete_Guild, applicantInfoWrapper:getGuildNo(), applicantInfoWrapper:getUserNo())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETEUSERTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETEUSERCONFIRM")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestDeleteApplicant,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_GuildJoinRequestList_All:createList(content, index)
  local key = Int64toInt32(index)
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(key)
  if nil == applicantInfoWrapper then
    return
  end
  local txt_charName = UI.getChildControl(content, "StaticText_CharName")
  local txt_class = UI.getChildControl(content, "StaticText_Class")
  local txt_level = UI.getChildControl(content, "StaticText_Level")
  local txt_contributedTendency = UI.getChildControl(content, "StaticText_ContributedTendency")
  local txt_attack = UI.getChildControl(content, "StaticText_Attack")
  local txt_awakenAttack = UI.getChildControl(content, "StaticText_AwakenAttack")
  local txt_defence = UI.getChildControl(content, "StaticText_Defence")
  local btn_whisper = UI.getChildControl(content, "Button_Whisper")
  local btn_delete = UI.getChildControl(content, "Button_Delete")
  btn_whisper:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHAT_SUB_TXT_WHISPER"))
  btn_delete:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLYJOIN_EXCEPT"))
  btn_whisper:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestList_All:WhisperToPlayer(" .. key .. ")")
  btn_delete:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestList_All:requestDeleteApplicant(" .. key .. ")")
  btn_whisper:SetSize(btn_whisper:GetTextSizeX() + 20, btn_whisper:GetSizeY())
  btn_delete:SetSize(btn_delete:GetTextSizeX() + 20, btn_delete:GetSizeY())
  btn_whisper:SetSpanSize(btn_delete:GetSpanSize().x + btn_delete:GetSizeX() + 5, btn_whisper:GetSpanSize().y)
  btn_delete:ComputePos()
  btn_whisper:ComputePos()
  txt_charName:SetText(tostring(applicantInfoWrapper:getUserNickName() .. "(" .. applicantInfoWrapper:getCharacterName() .. ")"))
  txt_charName:ComputePos()
  txt_class:SetText(CppEnums.ClassType2String[applicantInfoWrapper:getClassType()])
  txt_level:SetText(tostring(applicantInfoWrapper:getLevel()))
  txt_contributedTendency:SetText(tostring(applicantInfoWrapper:getWp() .. " / " .. applicantInfoWrapper:getExplorationPoint()))
  txt_attack:SetShow(false)
  txt_awakenAttack:SetShow(false)
  txt_defence:SetShow(false)
end
