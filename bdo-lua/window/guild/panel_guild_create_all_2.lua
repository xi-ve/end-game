function PaGlobal_Guild_Create_All_Open(isClan)
  UI.ASSERT_NAME(nil ~= isClan, "PaGlobal_Guild_Create_All_Open\236\157\152 isClan nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  PaGlobal_Guild_Create_All._isClan = isClan
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= myGuildListInfo then
    PaGlobal_Guild_Create_All._ui.stc_guildName:SetEditText(myGuildListInfo:getName())
    HandleEventLUp_Guild_Create_All_clickedConfirm()
  else
    PaGlobal_Guild_Create_All:prepareOpen()
  end
end
function PaGlobal_Guild_Create_All_Close()
  PaGlobal_Guild_Create_All:prepareClose()
end
function PaGlobalFunc_Guild_Create_All_HideVirtualKeyboard(str)
  if nil ~= str then
    ClearFocusEdit()
    PaGlobal_Guild_Create_All._ui.stc_guildName:SetEditText(str)
  end
end
function HandleEventLUp_Guild_Create_All_clickedConfirm()
  if PaGlobal_Guild_Create_All._ui.stc_guildName:GetEditText() == "" then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POPUP_ENTER_GUILDNAME"))
    ClearFocusEdit()
    return
  end
  local createType = -1
  local isRaisingGuildGrade = false
  local guildName = PaGlobal_Guild_Create_All._ui.stc_guildName:GetEditText()
  local businessFunds = 100000
  local messageTitle = ""
  local messageContent = ""
  if true == PaGlobal_Guild_Create_All._isClan then
    createType = 0
  else
    createType = 1
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildListInfo then
      local myGuildGrade = myGuildListInfo:getGuildGrade()
      if 0 ~= myGuildGrade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_NOGUILD_NOUPGRADE_ACK"))
        ClearFocusEdit()
        return
      end
      isRaisingGuildGrade = true
    end
  end
  if false == isRaisingGuildGrade then
    if 0 == createType then
      messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_CREATE_CLAN_MESSAGEBOX_TITLE")
      messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREATE_CLAN_MESSAGEBOX_MSG", "name", guildName)
    else
      messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_CREATE_GUILD_MESSAGEBOX_TITLE")
      messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREATE_GUILD_MESSAGEBOX_MSG", "name", guildName)
    end
    local messageBoxData = {
      title = messageTitle,
      content = messageContent,
      functionYes = function()
        ToClient_RequestCreateGuild(guildName, createType, businessFunds)
        ClearFocusEdit()
        if PaGlobal_Guild_Create_All._isConsole then
          PaGlobal_Guild_Create_All._isConfirm = true
          _AudioPostEvent_SystemUiForXBOX(50, 1)
        end
        PaGlobal_CreateClan_All_Close()
      end,
      functionNo = function()
        PaGlobal_Guild_Create_All._ui.stc_guildName:SetEditText("")
        ClearFocusEdit()
      end,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    ToClient_RequestRaisingGuildGrade(createType, businessFunds)
  end
end
function HandleEventLUp_Guild_Create_All_clickedCancel()
  PaGlobal_Guild_Create_All_Close(false)
end
function Input_Guild_Create_All_setFocus()
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_Guild_Create_All._ui.stc_guildName)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_Guild_Create_All._ui.stc_guildName:SetEditText(PaGlobal_Guild_Create_All._ui.stc_guildName:GetEditText(), true)
end
function FromClient_Guild_Create_All_onScreenResize()
  Panel_Guild_Create_All:ComputePos()
  PaGlobal_Guild_Create_All._ui.stc_nameBg:ComputePos()
  PaGlobal_Guild_Create_All._ui.stc_guildName:ComputePos()
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:ComputePos()
  if false == PaGlobal_Guild_Create_All._isConsole then
    PaGlobal_Guild_Create_All._ui_pc.btn_close:ComputePos()
    PaGlobal_Guild_Create_All._ui_pc.btn_confirm:ComputePos()
    PaGlobal_Guild_Create_All._ui_pc.btn_cancle:ComputePos()
  else
    PaGlobal_Guild_Create_All._ui_console.btn_confirm:ComputePos()
    PaGlobal_Guild_Create_All._ui_console.btn_close:ComputePos()
  end
end
function PaGlobal_Guild_Create_All_checkedGuildEditUI(uiEdit)
  if nil == Panel_Guild_Create_All then
    return
  end
  if nil == uiEdit then
    return false
  end
  return uiEdit:GetKey() == PaGlobal_Guild_Create_All._ui.stc_guildName:GetKey()
end
function PaGlobal_Guild_Create_All_ShowAni()
  if nil == Panel_Guild_Create_All then
    return
  end
end
function PaGlobal_Guild_Create_All_HideAni()
  if nil == Panel_Guild_Create_All then
    return
  end
end
