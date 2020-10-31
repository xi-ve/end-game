function PaGlobal_GuildApplyJoinList:init()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_TitleArea, "Button_Close")
  self._ui._stc_guildList = Array.new()
  self._ui._stc_guildMark = Array.new()
  self._ui._txt_guildName = Array.new()
  self._ui._btn_delete = Array.new()
  self._maxJoinCount = ToClient_getMaxJoinCountToGuildPR()
  local baseControl = UI.getChildControl(self._ui._stc_MainBG, "Static_GuildList_Temp")
  local baseControl_GuildMark = UI.getChildControl(baseControl, "Static_GuildMark")
  local baseControl_GuildName = UI.getChildControl(baseControl, "StaticText_GuildName")
  local baseControl_ButtonDelete = UI.getChildControl(baseControl, "Button_Delete")
  for ii = 0, self._maxJoinCount - 1 do
    local targetControl = UI.cloneControl(baseControl, Panel_Guild_ApplyJoinList, "Static_GuildList_" .. ii)
    targetControl:SetPosY(47 + 47 * ii)
    self._ui._stc_guildList[ii] = targetControl
    self._ui._stc_guildMark[ii] = UI.getChildControl(targetControl, "Static_GuildMark")
    self._ui._txt_guildName[ii] = UI.getChildControl(targetControl, "StaticText_GuildName")
    self._ui._btn_delete[ii] = UI.getChildControl(targetControl, "Button_Delete")
  end
  deleteControl(baseControl)
  baseControl = nil
  deleteControl(baseControl_GuildMark)
  baseControl_GuildMark = nil
  deleteControl(baseControl_GuildName)
  baseControl_GuildName = nil
  deleteControl(baseControl_ButtonDelete)
  baseControl_ButtonDelete = nil
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
  else
  end
  self._ui._txt_noGuildText = UI.getChildControl(self._ui._stc_MainBG, "StaticText_NoGuild")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:checkApplyListClose()")
  self:clear()
  registerEvent("FromClient_loadCompleteUserGuildApplicantList", "FromClient_loadCompleteUserGuildApplicantList")
  registerEvent("FromClient_deleteGuildApplicant_User", "FromClient_deleteGuildApplicant_User")
  Panel_Guild_ApplyJoinList:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "PaGlobal_GuildApplyJoinList:close()")
end
function PaGlobal_GuildApplyJoinList:clear()
  for ii = 0, self._maxJoinCount - 1 do
    self._ui._stc_guildList[ii]:SetShow(false)
  end
  self._ui._txt_noGuildText:SetShow(false)
end
function PaGlobal_GuildApplyJoinList:open()
  PaGlobal_GuildApplyJoinList:clear()
  PaGlobal_GuildApplyJoinList:update()
  Panel_Guild_ApplyJoinList:SetShow(true)
end
function PaGlobal_GuildApplyJoinList:close()
  Panel_Guild_ApplyJoinList:SetShow(false)
end
function PaGlobal_GuildApplyJoinList:update()
  local self = PaGlobal_GuildApplyJoinList
  local applicantListSize = ToClient_getUserGuildApplicantListSize()
  if applicantListSize <= 0 or applicantListSize > self._maxJoinCount then
    self:clear()
    self._ui._txt_noGuildText:SetShow(true)
    return
  end
  for ii = 0, applicantListSize - 1 do
    local wrapper = ToClient_getUserGuildApplicantWrapper(ii)
    if nil == wrapper then
      return
    end
    self._ui._stc_guildList[ii]:SetShow(true)
    local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), self._ui._stc_guildMark[ii])
    if false == isSet then
      self._ui._stc_guildMark[ii]:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_guildMark[ii], 183, 1, 188, 6)
      self._ui._stc_guildMark[ii]:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui._stc_guildMark[ii]:setRenderTexture(self._ui._stc_guildMark[ii]:getBaseTexture())
    else
      self._ui._stc_guildMark[ii]:getBaseTexture():setUV(0, 0, 1, 1)
      self._ui._stc_guildMark[ii]:setRenderTexture(self._ui._stc_guildMark[ii]:getBaseTexture())
    end
    self._ui._txt_guildName[ii]:SetText(tostring(wrapper:getGuildName()))
    self._ui._btn_delete[ii]:addInputEvent("Mouse_LUp", "PaGlobal_GuildApplyJoinList:requestDeleteApplicant(" .. ii .. ")")
  end
  self._ui._txt_noGuildText:SetShow(false)
end
function PaGlobal_GuildApplyJoinList:requestDeleteApplicant(index)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local userNo = selfPlayer:get():getUserNo()
  local wrapper = ToClient_getUserGuildApplicantWrapper(ii)
  if nil == wrapper then
    return
  end
  local function requestDeleteApplicant()
    ToClient_requestDeleteGuildApplicant(__eGuildApplicantType_Delete_User, wrapper:getGuildNo(), userNo)
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERDELETE")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestDeleteApplicant,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
