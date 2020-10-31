PaGlobal_GuildRegistSoldier_All = {
  _ui = {
    btn_Close = nil,
    stc_Main = nil,
    edit_Search = nil,
    stc_Keyguide_X = nil,
    btn_Invite = nil,
    stc_Desc = nil,
    txt_Desc = nil,
    stc_Bottom_KeyGuide = nil,
    stc_Keyguide_B = nil,
    stc_Keyguide_A = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildRegistSoldier_All_Init")
function FromClient_GuildRegistSoldier_All_Init()
  PaGlobal_GuildRegistSoldier_All:initialize()
end
function PaGlobal_GuildRegistSoldier_All:initialize()
  if nil == Panel_GuildRegistSoldier_All or true == self._initialize then
    return
  end
  local stc_Title = UI.getChildControl(Panel_GuildRegistSoldier_All, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(stc_Title, "Button_Close")
  self._ui.stc_Main = UI.getChildControl(Panel_GuildRegistSoldier_All, "Static_MainArea")
  self._ui.edit_Search = UI.getChildControl(self._ui.stc_Main, "Edit_Search_Guild")
  self._ui.stc_Keyguide_X = UI.getChildControl(self._ui.edit_Search, "StaticText_X_ConsoleUI")
  self._ui.btn_Invite = UI.getChildControl(self._ui.stc_Main, "Button_Invite")
  self._ui.stc_Desc = UI.getChildControl(self._ui.stc_Main, "Static_DescEdge")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_Desc, "StaticText_Desc")
  self._ui.stc_Bottom_KeyGuide = UI.getChildControl(Panel_GuildRegistSoldier_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_Keyguide_A = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_Keyguide_B = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  PaGlobal_GuildRegistSoldier_All:validate()
  PaGlobal_GuildRegistSoldier_All:registEventHandler()
  PaGlobal_GuildRegistSoldier_All:swichPlatform()
  PaGlobal_GuildRegistSoldier_All._initialize = true
end
function PaGlobal_GuildRegistSoldier_All:registEventHandler()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_GuildRegistSoldier_All:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_Guild_RegistSolider_All_SendInvite()")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_RegistSolider_All_Close()")
    self._ui.btn_Invite:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_RegistSolider_All_SendInvite()")
    self._ui.edit_Search:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_RegistSolider_All_SetName()")
  end
end
function PaGlobal_GuildRegistSoldier_All:swichPlatform()
  self._ui.stc_Bottom_KeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui.stc_Keyguide_X:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui.btn_Close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.btn_Invite:SetShow(not _ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.edit_Search:SetSize(self._ui.stc_Desc:GetSizeX(), self._ui.edit_Search:GetSizeY())
    self._ui.stc_Keyguide_X:ComputePos()
    local keyTables = {
      self._ui.stc_Keyguide_A,
      self._ui.stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyTables, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_GuildRegistSoldier_All:prepareOpen()
  PaGlobal_GuildRegistSoldier_All:open()
  HandleEventLUp_Guild_RegistSolider_All_SetName()
  PaGlobalFunc_Guild_RegistSolider_All_OnScreenResize()
end
function PaGlobal_GuildRegistSoldier_All:open()
  Panel_GuildRegistSoldier_All:SetShow(true)
end
function PaGlobal_GuildRegistSoldier_All:prepareClose()
  ClearFocusEdit(self._ui.edit_Search)
  PaGlobal_GuildRegistSoldier_All:close()
end
function PaGlobal_GuildRegistSoldier_All:close()
  Panel_GuildRegistSoldier_All:SetShow(false)
end
function PaGlobal_GuildRegistSoldier_All:validate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Main:isValidate()
  self._ui.edit_Search:isValidate()
  self._ui.stc_Keyguide_X:isValidate()
  self._ui.btn_Invite:isValidate()
  self._ui.stc_Desc:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_Bottom_KeyGuide:isValidate()
  self._ui.stc_Keyguide_A:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
end
function PaGlobalFunc_Guild_RegistSolider_All_Open()
  if nil == Panel_GuildRegistSoldier_All or true == Panel_GuildRegistSoldier_All:GetShow() then
    return
  end
  PaGlobal_GuildRegistSoldier_All:prepareOpen()
end
function PaGlobalFunc_Guild_RegistSolider_All_OnScreenResize()
  if nil == Panel_GuildRegistSoldier_All then
    return
  end
  Panel_GuildRegistSoldier_All:ComputePos()
end
function HandleEventLUp_Guild_RegistSolider_All_Close()
  if nil == Panel_GuildRegistSoldier_All or false == Panel_GuildRegistSoldier_All:GetShow() then
    return
  end
  PaGlobal_GuildRegistSoldier_All:prepareClose()
end
function HandleEventLUp_Guild_RegistSolider_All_SendInvite()
  local receiverName = PaGlobal_GuildRegistSoldier_All._ui.edit_Search:GetEditText()
  if "" == receiverName then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDGEGISTSOLDIER_NONAME_ALERT"))
    return
  end
  FGlobal_AgreementVolunteer_Master_Open(receiverName)
  ClearFocusEdit(PaGlobal_GuildRegistSoldier_All._ui.edit_Search)
  PaGlobal_GuildRegistSoldier_All:prepareClose()
end
function HandleEventLUp_Guild_RegistSolider_All_SetName()
  PaGlobal_GuildRegistSoldier_All._ui.edit_Search:SetEditText("", true)
  SetFocusEdit(PaGlobal_GuildRegistSoldier_All._ui.edit_Search)
end
