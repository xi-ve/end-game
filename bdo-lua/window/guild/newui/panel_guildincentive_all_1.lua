function PaGlobal_GuildIncentive_All:initialize()
  if true == PaGlobal_GuildIncentive_All._initialize then
    return
  end
  PaGlobal_GuildIncentive_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_GuildIncentive_All:ControlAll_Init()
  PaGlobal_GuildIncentive_All:ControlPc_Init()
  PaGlobal_GuildIncentive_All:ControlConsole_Init()
  PaGlobal_GuildIncentive_All:ControlSetShow()
  PaGlobal_GuildIncentive_All:registEventHandler()
  PaGlobal_GuildIncentive_All:validate()
  PaGlobal_GuildIncentive_All._initialize = true
end
function PaGlobal_GuildIncentive_All:ControlAll_Init()
  if nil == Panel_GuildIncentive_All then
    return
  end
  self._ui.stc_backBg = UI.getChildControl(Panel_GuildIncentive_All, "Static_BackBG")
  self._ui.stc_titleBg = UI.getChildControl(Panel_GuildIncentive_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_Title")
  self._ui.txt_moneyAll = UI.getChildControl(Panel_GuildIncentive_All, "StaticText_Money_All")
  self._ui.txt_moneyFree = UI.getChildControl(Panel_GuildIncentive_All, "StaticText_Money_Free")
  self._ui.stc_mainBg = UI.getChildControl(Panel_GuildIncentive_All, "Static_MainArea")
  self._ui.edit_money = UI.getChildControl(self._ui.stc_mainBg, "Edit_MoneyVal")
  self._ui.stc_descBg = UI.getChildControl(self._ui.stc_mainBg, "Static_DescEdge")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBg, "StaticText_Desc")
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_FOUNDATION_DESC"))
end
function PaGlobal_GuildIncentive_All:ControlPc_Init()
  if nil == Panel_GuildIncentive_All then
    return
  end
  self._ui_pc.btn_confirm = UI.getChildControl(self._ui.stc_mainBg, "Button_Deposit")
  self._ui_pc.btn_cancle = UI.getChildControl(self._ui.stc_mainBg, "Button_Cancel")
end
function PaGlobal_GuildIncentive_All:ControlConsole_Init()
  if nil == Panel_GuildIncentive_All then
    return
  end
  self._ui_console.stc_keyGuideX = UI.getChildControl(self._ui.edit_money, "StaticText_X_ConsoleUI")
  self._ui_console.stc_keyGuideBottomBg = UI.getChildControl(Panel_GuildIncentive_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.stc_keyGuideA = UI.getChildControl(self._ui_console.stc_keyGuideBottomBg, "StaticText_A_ConsoleUI")
  self._ui_console.stc_keyGuideB = UI.getChildControl(self._ui_console.stc_keyGuideBottomBg, "StaticText_B_ConsoleUI")
end
function PaGlobal_GuildIncentive_All:ControlSetShow()
  if nil == Panel_GuildIncentive_All then
    return
  end
  if true == self._isConsole then
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_cancle:SetShow(false)
    self._ui_console.stc_keyGuideX:SetShow(true)
    self._ui_console.stc_keyGuideBottomBg:SetShow(true)
    Panel_GuildIncentive_All:SetSize(Panel_GuildIncentive_All:GetSizeX(), Panel_GuildIncentive_All:GetSizeY() - self._ui_pc.btn_cancle:GetSizeY() - 10)
    self._ui.stc_backBg:SetSize(self._ui.stc_backBg:GetSizeX(), self._ui.stc_backBg:GetSizeY() - self._ui_pc.btn_cancle:GetSizeY() - 10)
  else
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_cancle:SetShow(true)
    self._ui_console.stc_keyGuideX:SetShow(false)
    self._ui_console.stc_keyGuideBottomBg:SetShow(false)
  end
  self._configSize._panelY = Panel_GuildIncentive_All:GetSizeY()
  self._configSize._mainBgY = self._ui.stc_mainBg:GetSizeY()
  self._configSize._backBgY = self._ui.stc_backBg:GetSizeY()
  self._configSize._bottomY = self._ui.stc_descBg:GetSizeY()
end
function PaGlobal_GuildIncentive_All:prepareOpen()
  if nil == Panel_GuildIncentive_All then
    return
  end
  self._ui.edit_money:SetEditText("0", true)
  PaGlobal_GuildIncentive_All:open()
  PaGlobal_GuildIncentive_All:update()
  PaGlobal_GuildIncentive_All:resize()
end
function PaGlobal_GuildIncentive_All:open()
  if nil == Panel_GuildIncentive_All then
    return
  end
  Panel_GuildIncentive_All:SetShow(true)
end
function PaGlobal_GuildIncentive_All:prepareClose()
  if nil == Panel_GuildIncentive_All then
    return
  end
  PaGlobal_GuildIncentive_All:close()
end
function PaGlobal_GuildIncentive_All:close()
  if nil == Panel_GuildIncentive_All then
    return
  end
  Panel_GuildIncentive_All:SetShow(false)
end
function PaGlobal_GuildIncentive_All:update()
  if nil == Panel_GuildIncentive_All then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds = myGuildListInfo:getGuildBusinessFunds_s64()
  local businessFunds10 = businessFunds * toInt64(0, 10) / toInt64(0, 100)
  local businessFunds30 = businessFunds * toInt64(0, 40) / toInt64(0, 100)
  self._ui.txt_moneyAll:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_moneyFree:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_moneyAll:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDINCENTIVE_ALL_GUILDMONEY_ALL", "businessFunds", tostring(makeDotMoney(businessFunds))))
  self._ui.txt_moneyFree:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDINCENTIVE_ALL_GUILDMONEY_FREE", "businessFunds10", tostring(makeDotMoney(businessFunds10)), "businessFunds30", tostring(makeDotMoney(businessFunds30))))
end
function PaGlobal_GuildIncentive_All:registEventHandler()
  if nil == Panel_GuildIncentive_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildIncentive_All_Resize")
  if true == self._isConsole then
    Panel_GuildIncentive_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildIncentive_All_Editing()")
    Panel_GuildIncentive_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildIncentive_All_MainShowToggle()")
  else
    self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIncentive_All_MainShowToggle()")
    self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIncentive_All_Close()")
    self._ui.edit_money:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIncentive_All_Editing()")
  end
end
function PaGlobal_GuildIncentive_All:validate()
  if nil == Panel_GuildIncentive_All then
    return
  end
end
function PaGlobal_GuildIncentive_All:resize()
  if nil == Panel_GuildIncentive_All then
    return
  end
  local gabY = 5
  if self._ui.stc_descBg:GetSizeY() < self._ui.txt_desc:GetTextSizeY() + 5 then
    local addSizeY = self._ui.txt_desc:GetTextSizeY() + 5 - self._ui.stc_descBg:GetSizeY()
    Panel_GuildIncentive_All:SetSize(Panel_GuildIncentive_All:GetSizeX(), self._configSize._panelY + addSizeY)
    self._ui.stc_backBg:SetSize(self._ui.stc_backBg:GetSizeX(), self._configSize._backBgY + addSizeY)
    self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._configSize._mainBgY + addSizeY)
    self._ui.stc_descBg:SetSize(self._ui.stc_descBg:GetSizeX(), self._configSize._bottomY + addSizeY)
  end
  Panel_GuildIncentive_All:ComputePos()
  self._ui_console.stc_keyGuideBottomBg:ComputePos()
  local keyguides = {
    self._ui_console.stc_keyGuideA,
    self._ui_console.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_keyGuideBottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
