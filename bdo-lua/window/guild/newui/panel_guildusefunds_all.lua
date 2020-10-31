PaGlobal_GuildUseFund_All = {
  _ui = {
    _btn_close = nil,
    _stc_main = nil,
    _edit_Input = nil,
    _stc_keyguide_X = nil,
    _btn_set = nil,
    _stc_desc = nil,
    _txt_desc = nil,
    _chk_funds_unlimit = nil,
    _stc_bottom_keyguide = nil,
    _stc_keyguide_B = nil
  },
  _limitPrice = 0,
  _isVolunteer = false,
  _selectIndex = nil,
  _selectUserNo = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildUseFund_All_Init")
function FromClient_GuildUseFund_All_Init()
  PaGlobal_GuildUseFund_All:initialize()
end
function PaGlobal_GuildUseFund_All:initialize()
  if true == PaGlobal_GuildUseFund_All._initialize or nil == Panel_GuildUseFund_All then
    return
  end
  local stc_title = UI.getChildControl(Panel_GuildUseFund_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Close")
  self._ui._stc_main = UI.getChildControl(Panel_GuildUseFund_All, "Static_MainArea")
  self._ui._edit_Input = UI.getChildControl(self._ui._stc_main, "Edit_Search_Guild")
  self._ui._stc_keyguide_X = UI.getChildControl(self._ui._edit_Input, "StaticText_X_ConsoleUI")
  self._ui._btn_set = UI.getChildControl(self._ui._stc_main, "Button_Set")
  self._ui._stc_desc = UI.getChildControl(self._ui._stc_main, "Static_DescEdge")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_desc, "StaticText_Desc")
  self._ui._chk_funds_unlimit = UI.getChildControl(self._ui._stc_main, "CheckButton_FundsUnlimit")
  self._ui._stc_bottom_keyguide = UI.getChildControl(Panel_GuildUseFund_All, "Static_KeyGuide_ConsoleUI")
  self._ui._stc_keyguide_B = UI.getChildControl(self._ui._stc_bottom_keyguide, "StaticText_B_ConsoleUI")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  PaGlobal_GuildUseFund_All:validate()
  PaGlobal_GuildUseFund_All:registEventHandler()
  PaGlobal_GuildUseFund_All:swichPlatform()
  PaGlobal_GuildUseFund_All._initialize = true
end
function PaGlobal_GuildUseFund_All:registEventHandler()
  if nil == Panel_GuildUseFund_All then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildUseFund_All_Close()")
  self._ui._btn_set:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildUseFund_All_ApplyMemberPriceLimit()")
  self._ui._edit_Input:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildUseFund_All_SetFunds()")
  self._ui._chk_funds_unlimit:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildUseFund_All_CheckLimit()")
end
function PaGlobal_GuildUseFund_All:swichPlatform()
  self._ui._stc_bottom_keyguide:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui._stc_keyguide_X:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui._btn_close:SetShow(not _ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_set:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildUseFund_All_SetFunds()")
    self._ui._chk_funds_unlimit:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildUseFund_All_SetFunds()")
  end
end
function PaGlobal_GuildUseFund_All:prepareOpen(selectIndex, IsShow, isVolunteer)
  if nil == Panel_GuildUseFund_All then
    return
  end
  self._limitPrice = 0
  self._isVolunteer = false
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWrapper then
    return
  end
  local guildMember
  if true == isVolunteer then
    guildMember = myGuildWrapper:getVolunteerMember(selectIndex)
    if nil == guildMember then
      return
    end
    self.isVolunteer = true
  else
    guildMember = myGuildWrapper:getMember(selectIndex)
  end
  if nil == guildMember then
    return
  end
  self._selectUserNo = guildMember:getUserNo()
  local isLimit = guildMember:getIsPriceLimit()
  self._ui._edit_Input:SetIgnore(not isLimit)
  self._ui._chk_funds_unlimit:SetCheck(not isLimit)
  if true == isLimit then
    self._limitPrice = guildMember:getPriceLimit()
    self._ui._edit_Input:SetText(makeDotMoney(self._limitPrice))
  else
    self._ui._edit_Input:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
  end
  self._selectIndex = selectIndex
  PaGlobal_GuildUseFund_All:open()
  PaGlobal_GuildUseFund_All_OnScreenResize()
end
function PaGlobal_GuildUseFund_All:update(input, param)
  if true == self._ui._chk_funds_unlimit:IsCheck() then
    self._ui._edit_Input:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
    self._ui._edit_Input:SetIgnore(true)
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local limitPriceMax = myGuildInfo:getGuildBusinessFunds_s64()
  if input > limitPriceMax then
    input = limitPriceMax
  end
  self._limitPrice = input
  self._ui._edit_Input:SetIgnore(false)
  self._ui._edit_Input:SetText(makeDotMoney(self._limitPrice))
end
function PaGlobal_GuildUseFund_All:open()
  if nil == Panel_GuildUseFund_All then
    return
  end
  Panel_GuildUseFund_All:SetShow(true)
end
function PaGlobal_GuildUseFund_All:prepareClose()
  if nil == Panel_GuildUseFund_All then
    return
  end
  PaGlobal_GuildUseFund_All:close()
end
function PaGlobal_GuildUseFund_All:close()
  if nil == Panel_GuildUseFund_All then
    return
  end
  Panel_GuildUseFund_All:SetShow(false)
end
function PaGlobal_GuildUseFund_All:validate()
  if nil == Panel_GuildUseFund_All then
    return
  end
end
function PaGlobalFunc_GuildUseFund_All_ShowToggle(selectIndex, isShow, isVolunteer)
  if nil == isShow then
    return
  end
  if true == isShow and nil ~= selectIndex then
    PaGlobal_GuildUseFund_All:prepareOpen(selectIndex, isShow, isVolunteer)
  else
    PaGlobal_GuildUseFund_All:prepareClose()
    Panel_NumberPad_Close()
  end
end
function PaGlobal_GuildUseFund_All_OnScreenResize()
  if nil == Panel_GuildUseFund_All then
    return
  end
  Panel_GuildUseFund_All:ComputePos()
end
function PaGlobalFunc_GuildUseFund_All_Close()
  PaGlobal_GuildUseFund_All:prepareClose()
  Panel_NumberPad_Close()
end
function PaGlobalFunc_GuildUseFund_All_SetFunds()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  if true == PaGlobal_GuildUseFund_All._ui._chk_funds_unlimit:IsCheck() then
    return
  end
  Panel_NumberPad_Show(true, myGuildInfo:getGuildBusinessFunds_s64(), 0, PaGlobalFunc_GuildUseFund_All_InputNumber)
end
function PaGlobalFunc_GuildUseFund_All_CheckLimit()
  PaGlobal_GuildUseFund_All._limitPrice = 0
  if true == PaGlobal_GuildUseFund_All._ui._chk_funds_unlimit:IsCheck() then
    PaGlobal_GuildUseFund_All._ui._edit_Input:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_USEGUILDFUNDS_UNLIMITED"))
    PaGlobal_GuildUseFund_All._ui._edit_Input:SetIgnore(true)
  else
    PaGlobal_GuildUseFund_All._ui._edit_Input:SetText("0")
    PaGlobal_GuildUseFund_All._ui._edit_Input:SetIgnore(false)
  end
end
function PaGlobalFunc_GuildUseFund_All_ApplyMemberPriceLimit()
  if true == PaGlobal_GuildUseFund_All._ui._chk_funds_unlimit:IsCheck() then
    ToClient_SetGuildMemberPriceLimit(PaGlobal_GuildUseFund_All._selectUserNo, 0, false)
  else
    ToClient_SetGuildMemberPriceLimit(PaGlobal_GuildUseFund_All._selectUserNo, PaGlobal_GuildUseFund_All._limitPrice, true)
  end
  PaGlobalFunc_GuildUseFund_All_ShowToggle(nil, false, false)
end
function PaGlobalFunc_GuildUseFund_All_InputNumber(input, param)
  PaGlobal_GuildUseFund_All:update(input, param)
end
