local tempBloodAltarPanel = Panel_Widget_BloodAltar_RandomMatch
PaGlobal_BloodAltarJoin = {
  _ui = {
    btn_cancel = nil,
    stc_Console_desc = nil,
    txt_Console_desc = nil
  },
  _isBloodAltarWait = false,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_BloodAltarJoin_luaLoadComplete")
function FromClient_BloodAltarJoin_luaLoadComplete()
  PaGlobal_BloodAltarJoin:initialize()
end
function PaGlobal_BloodAltarJoin:initialize()
  if true == PaGlobal_BloodAltarJoin._initialize then
    return
  end
  self._ui.btn_cancel = UI.getChildControl(tempBloodAltarPanel, "Button_Cancel")
  self.stc_Console_desc = UI.getChildControl(tempBloodAltarPanel, "Static_Console_Tip")
  self.txt_Console_desc = UI.getChildControl(self.stc_Console_desc, "StaticText_Console_Desc")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self.stc_Console_desc:SetShow(self._isConsole)
  self._ui.btn_cancel:SetShow(not self._isConsole)
  if true == self._isConsole then
    self.txt_Console_desc:SetTextMode(__eTextMode_AutoWrap)
    self.txt_Console_desc:SetText(self.txt_Console_desc:GetText())
    self.txt_Console_desc:ComputePos()
    self.stc_Console_desc:SetPosY(self.txt_Console_desc:GetPosY() + 75)
    Panel_Widget_BloodAltar_RandomMatch:SetSize(Panel_Widget_BloodAltar_RandomMatch:GetSizeX() - self._ui.btn_cancel:GetSizeX(), Panel_Widget_BloodAltar_RandomMatch:GetSizeY() + self.txt_Console_desc:GetTextSizeY() + 10)
    registerEvent("onScreenResize", "FromClient_BloodAltarJoin_Reposition")
  else
    self._ui.btn_cancel:addInputEvent("Mouse_LUp", "ToClient_CancelInstanceSavageDefenceRandomParty()")
  end
  if true == ToClient_IsInstanceRandomMatching() and __eInstanceContentsType_SavageDefence == ToClient_getInstanceRandomMatchingContentsType() then
    PaGlobal_BloodAltarJoin:prepareOpen()
  end
  registerEvent("FromClient_RandomMatchAck", "FromClient_BloodAltarJoin_RandomMatchAck")
  PaGlobal_BloodAltarJoin._initialize = true
end
function FromClient_BloodAltarJoin_RandomMatchAck(isJoin, instanceType, mode)
  if true == isJoin then
    if __eInstanceContentsType_SavageDefence ~= instanceType then
      return
    end
    _PA_LOG("\235\172\184\236\158\165\237\153\152", "[\237\148\188\236\157\152\236\160\156\235\139\168]\235\158\156\235\141\164\235\167\164\236\185\173 \235\140\128\234\184\176\236\131\129\237\131\156")
    PaGlobal_BloodAltarJoin._isBloodAltarWait = true
    PaGlobal_BloodAltarJoin:prepareOpen()
  else
    _PA_LOG("\235\172\184\236\158\165\237\153\152", "[\237\148\188\236\157\152\236\160\156\235\139\168]\235\158\156\235\141\164\235\167\164\236\185\173 \236\183\168\236\134\140")
    PaGlobal_BloodAltarJoin._isBloodAltarWait = false
    PaGlobal_BloodAltarJoin:prepareClose()
  end
end
function PaGlobal_BloodAltarJoin:prepareOpen()
  if nil == tempBloodAltarPanel then
    return
  end
  if true == self._isConsole then
    FromClient_BloodAltarJoin_Reposition()
  end
  PaGlobal_BloodAltarJoin:open()
end
function PaGlobal_BloodAltarJoin:open()
  if nil == tempBloodAltarPanel then
    return
  end
  tempBloodAltarPanel:SetShow(true)
end
function PaGlobal_BloodAltarJoin:prepareClose()
  if nil == tempBloodAltarPanel then
    return
  end
  PaGlobal_BloodAltarJoin:close()
end
function PaGlobal_BloodAltarJoin:close()
  if nil == tempBloodAltarPanel then
    return
  end
  tempBloodAltarPanel:SetShow(false)
end
function PaGlobal_HandleClicked_BloodAltar_Open()
  local partyMemberCount = RequestParty_getPartyMemberCount()
  if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
    Panel_Menu:SetShow(false, true)
  elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
    Panel_Menu_New:SetShow(false, true)
  elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
    Panel_Widget_Menu_Remake:SetShow(false, true)
  end
  if true == PaGlobal_BloodAltarJoin._isConsole and true == Panel_Widget_BloodAltar_RandomMatch:GetShow() then
    ToClient_CancelInstanceSavageDefenceRandomParty()
    return
  end
  if partyMemberCount < 1 and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    local MessageBox_Join = function()
      _PA_LOG("\235\172\184\236\158\165\237\153\152", "\235\158\156\235\141\164\235\167\164\236\185\173 \236\152\164\237\148\136")
      ToClient_JoinInstanceSavageDefenceRandomParty()
    end
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RAMDOMMATCH_MSGTITLE")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RAMDOMMATCH_MSGDESC")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Join,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local MessageBox_Exit = function()
      if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
        ToClient_InstanceSavageDefenceUnJoin()
      elseif true == PaGlobal_BloodAltarJoin._isConsole then
        ToClient_InstanceSavageDefenceJoin(__eSavageDefenceMode_Normal)
      else
        ToClient_InstanceSavageDefenceJoin(__eSavageDefenceMode_Normal)
      end
    end
    local messageBoxTitle = ""
    local messageBoxMemo = ""
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_EXIT_TITLE")
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_EXIT_DESC")
    else
      messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_OPEN_TITLE")
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_OPEN_DESC")
    end
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Exit,
      functionNo = MessageBox_Empty_function,
      exitButton = not PaGlobal_BloodAltarJoin._isConsole,
      priority = CppEnums.PAUIMB_PRIORITY.LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function FromClient_BloodAltarJoin_Reposition()
  Panel_Widget_BloodAltar_RandomMatch:SetPosX(Panel_Radar:GetPosX() - Panel_Widget_BloodAltar_RandomMatch:GetSizeX())
  Panel_Widget_BloodAltar_RandomMatch:SetPosY(Panel_TimeBar:GetPosY() + 100 - Panel_TimeBar:GetSizeY())
end
