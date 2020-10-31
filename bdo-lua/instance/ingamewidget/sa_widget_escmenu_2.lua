function PaGlobal_SA_Widget_ESCMenu_Open()
  PaGlobal_SA_Widget_ESCMenu:prepareOpen()
end
function PaGlobal_SA_Widget_ESCMenu_Close()
  PaGlobal_SA_Widget_ESCMenu:prepareClose()
end
function HandleEventLUp_SA_Widget_ESCMenu_ExitClick()
  local Leave_Out = function()
    ToClient_ExitBattleRoyale()
    PaGlobal_SA_Widget_ESCMenu_MessageBox_WaitProcess()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_TITLE")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_BEFORE_LOBBY")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = Leave_Out,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_SA_Widget_ESCMenu_ReSizePanel()
  Panel_SA_Widget_ESCMenu:SetSize(Panel_SA_Widget_ESCMenu:GetSizeX(), getScreenSizeY())
  Panel_SA_Widget_ESCMenu:ComputePosAllChild()
end
function PaGlobal_SA_Widget_ESCMenu_ShowToggle()
  if nil ~= Panel_SA_Widget_Inventory and true == Panel_SA_Widget_Inventory:GetShow() then
    PaGlobal_SA_Widget_Inventory_Close()
    return
  end
  local isShow = Panel_SA_Widget_ESCMenu:GetShow()
  if false == isShow then
    PaGlobal_SA_Widget_ESCMenu:prepareOpen()
    PaGlobal_SA_Widget_ESCMenu_ShowAni()
  else
    PaGlobal_SA_Widget_ESCMenu:prepareClose()
  end
  return isShow
end
function PaGlobal_SA_Widget_ESCMenu_ShowAni()
  local panel = Panel_SA_Widget_ESCMenu
  local moveAni = panel:addMoveAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(panel:GetPosX() + 100, panel:GetPosY())
  moveAni:SetEndPosition(panel:GetPosX(), panel:GetPosY())
end
function PaGlobal_SA_Widget_ESCMenu_MessageBox_WaitProcess()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, false)
end
