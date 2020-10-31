function PaGlobal_Arena_Waiting:initialize()
  if true == self._initialize then
    return
  end
  local titleBG = UI.getChildControl(Panel_Arena_Waiting, "Static_TitleBG")
  self._ui.btn_close_pc = UI.getChildControl(titleBG, "Button_Win_Close_PC")
  local mainBG = UI.getChildControl(Panel_Arena_Waiting, "Static_MainBg")
  self._ui.txt_total = UI.getChildControl(mainBG, "StaticText_Total_Value")
  self._ui.txt_myTurn = UI.getChildControl(mainBG, "StaticText_MyTurn_Value")
  local bottomBG = UI.getChildControl(Panel_Arena_Waiting, "Static_BottomGroup")
  self._ui.btn_refresh = UI.getChildControl(bottomBG, "Button_Refresh")
  self._ui.btn_close = UI.getChildControl(bottomBG, "Button_Close")
  self._ui.txt_desc = UI.getChildControl(Panel_Arena_Waiting, "StaticText_DescBox")
  self._ui.stc_consoleBG = UI.getChildControl(Panel_Arena_Waiting, "Static_BottomConsoleButtons")
  self:registEventHandler()
  self:validate()
  FromClient_NotifyBattleGroundPvPWaitingList()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_ARENA_WAITING_DESC"))
  if self._ui.txt_desc:GetSizeY() < self._ui.txt_desc:GetTextSizeY() then
    local padding = self._ui.txt_desc:GetTextSizeY() - self._ui.txt_desc:GetSizeY()
    self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
    Panel_Arena_Waiting:SetSize(Panel_Arena_Waiting:GetSizeX(), Panel_Arena_Waiting:GetSizeY() + padding)
    UI.getChildControl(Panel_Arena_Waiting, "Static_BottomGroup"):ComputePosAllChild()
  end
  if true == self._isConsole then
    self._ui.btn_close_pc:SetShow(false)
    self._ui.btn_refresh:SetShow(false)
    self._ui.btn_close:SetShow(false)
    Panel_Arena_Waiting:SetSize(Panel_Arena_Waiting:GetSizeX(), Panel_Arena_Waiting:GetSizeY() - (self._ui.btn_close:GetSizeY() + 15))
    self._ui.stc_consoleBG:SetShow(true)
  end
  if true == self._isConsole then
    self._ui.stc_consoleBG:ComputePosAllChild()
    self._ui.txt_desc:ComputePosAllChild()
    local keyGuides = {
      UI.getChildControl(self._ui.stc_consoleBG, "Button_Refresh"),
      UI.getChildControl(self._ui.stc_consoleBG, "Button_Cancel")
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_consoleBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._initialize = true
end
function PaGlobal_Arena_Waiting:registEventHandler()
  if nil == Panel_Arena_Waiting then
    return
  end
  registerEvent("onScreenResize", "FromClient_Arena_Waiting_ReSizePanel()")
  registerEvent("FromClient_NotifyBattleGroundPvPWaitingList", "FromClient_NotifyBattleGroundPvPWaitingList")
  self._ui.btn_close_pc:addInputEvent("Mouse_LUp", "PaGlobal_Arena_Waiting_Close()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Arena_Waiting_Close()")
  self._ui.btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_Arena_Waiting_Refresh()")
  if true == self._isConsole then
    Panel_Arena_Waiting:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Arena_Waiting_Refresh()")
  end
end
function PaGlobal_Arena_Waiting:prepareOpen()
  if nil == Panel_Arena_Waiting then
    return
  end
  PaGlobal_Arena_Waiting:open()
end
function PaGlobal_Arena_Waiting:open()
  if nil == Panel_Arena_Waiting then
    return
  end
  Panel_Arena_Waiting:SetShow(true)
end
function PaGlobal_Arena_Waiting:prepareClose()
  if nil == Panel_Arena_Waiting then
    return
  end
  Panel_Arena_Waiting:ClearUpdateLuaFunc()
  PaGlobal_Arena_Waiting:close()
end
function PaGlobal_Arena_Waiting:close()
  if nil == Panel_Arena_Waiting then
    return
  end
  Panel_Arena_Waiting:SetShow(false)
end
function PaGlobal_Arena_Waiting:validate()
  if nil == Panel_Arena_Waiting then
    return
  end
  self._ui.btn_close_pc:isValidate()
  self._ui.txt_total:isValidate()
  self._ui.txt_myTurn:isValidate()
  self._ui.btn_refresh:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.txt_desc:isValidate()
end
