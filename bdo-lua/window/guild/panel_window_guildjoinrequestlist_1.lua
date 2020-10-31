function PaGlobal_GuildJoinRequestList:init()
  if nil == Panel_Window_Guild then
    return
  end
  self._ui._guildBG = UI.getChildControl(Panel_Window_Guild, "Static_Frame_RecruitmentBG")
  local static_List_BG = UI.getChildControl(Panel_Window_GuildJoinRequestList, "Static_List_BG")
  local static_bottonBG = UI.getChildControl(Panel_Window_GuildJoinRequestList, "Static_BottonBg")
  self._ui._txt_contributedTendency = UI.getChildControl(static_List_BG, "StaticText_M_ContributedTendency")
  self._ui._btn_refresh = UI.getChildControl(static_bottonBG, "Button_Refresh")
  self._ui._list2_requestList = UI.getChildControl(Panel_Window_GuildJoinRequestList, "List2_RequestListBG")
  self._ui._list2_requestList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildJoinRequestList_CreateControlList2")
  self._ui._list2_requestList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._guildBG:MoveChilds(self._ui._guildBG:GetID(), Panel_Window_GuildJoinRequestList)
  self._ui._txt_contributedTendency:addInputEvent("Mouse_On", "PaGlobal_GuildJoinRequestList:ShowToolTip(true)")
  self._ui._txt_contributedTendency:addInputEvent("Mouse_Out", "PaGlobal_GuildJoinRequestList:ShowToolTip(false)")
  self._ui._btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_GuildJoinRequestList:Refresh()")
  registerEvent("FromClient_loadCompleteGuildApplicants", "FromClient_loadCompleteGuildApplicants")
  registerEvent("FromClient_deleteGuildApplicant_Guild", "FromClient_deleteGuildApplicant_Guild")
end
function PaGlobal_GuildJoinRequestList:open()
  if true == _ContentsGroup_NewUI_Guild_All then
    if nil == Panel_GuildMain_All then
      return
    end
  elseif nil == Panel_Window_Guild then
    return
  end
  PaGlobal_GuildJoinRequestList:Refresh()
  self._ui._guildBG:SetShow(true)
end
function PaGlobal_GuildJoinRequestList:close()
  if nil == Panel_Window_Guild then
    return
  end
  self._ui._guildBG:SetShow(false)
end
function PaGlobal_GuildJoinRequestList:update()
  if nil == Panel_Window_Guild then
    return
  end
  local self = PaGlobal_GuildJoinRequestList
  if nil == self then
    return
  end
  if nil == self._ui._guildBG then
    return
  end
  if false == self._ui._guildBG:GetShow() then
    return
  end
  local applicantsSize = ToClient_getGuildApplicantsSize()
  self._ui._list2_requestList:getElementManager():clearKey()
  if 0 < applicantsSize then
    for ii = 0, applicantsSize - 1 do
      self._ui._list2_requestList:getElementManager():pushKey(ii)
    end
  end
  self._ui._list2_requestList:ComputePos()
end
function PaGlobal_GuildJoinRequestList:WhisperToPlayer(index)
  if nil == Panel_Window_Guild then
    return
  end
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(index)
  if nil == applicantInfoWrapper then
    return
  end
  FGlobal_ChattingInput_ShowWhisper(applicantInfoWrapper:getUserNickName())
end
function PaGlobal_GuildJoinRequestList:requestDeleteApplicant(index)
  if nil == Panel_Window_Guild then
    return
  end
  local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(index)
  if nil == applicantInfoWrapper then
    return
  end
  local function requestDeleteApplicant()
    ToClient_requestDeleteGuildApplicant(__eGuildApplicantType_Delete_Guild, applicantInfoWrapper:getGuildNo(), applicantInfoWrapper:getUserNo())
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETEUSERTITLE")
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
function PaGlobal_GuildJoinRequestList:Refresh()
  if nil == Panel_Window_Guild then
    return
  end
  ToClient_requestGuildApplicants()
end
function PaGlobal_GuildJoinRequestList:ShowToolTip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local self = PaGlobal_GuildJoinRequestList
  local control = self._ui._txt_contributedTendency
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_JOIN_CONTRIBUTEDTENDENCY_DESC")
  TooltipSimple_Show(control, name, desc)
end
