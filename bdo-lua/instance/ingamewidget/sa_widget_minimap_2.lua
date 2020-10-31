function PaGloabl_SA_Widget_Minimap_Open()
  PaGlobal_SA_Widget_Minimap:prepareOpen()
end
function PaGloabl_SA_Widget_Minimap_Close()
  PaGlobal_SA_Widget_Minimap:prepareClose()
end
function HandleEventLUp_SA_Widget_Minimap_ExitButton()
  local Leave_Out = function()
    ToClient_ExitBattleRoyale()
    PaGlobal_SA_Widget_Minimap_Leave_MessageBox_WaitProcess()
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
function FromClinet_SA_Widget_Minimap_LostRegionInfo()
  PaGlobal_SA_Widget_Minimap._lostRegionInfo.isCallNextRegion = true
  PaGlobal_SA_Widget_Minimap:resizeMinimap(PaGlobal_SA_Widget_Minimap:getSizeScale())
  PaGlobal_SA_Widget_Minimap:updateCurrentLostRegionInfo(PaGlobal_SA_Widget_Minimap._lostRegionRefreshTime, true)
  PaGlobal_SA_Widget_Minimap:updateNextLostRegionInfo(false)
end
function FromClient_WatchTimer_BattleRoyaleStateChanged(state)
  if 2 == state then
    PaGlobal_SA_Widget_Minimap._ui.txt_remainTimer:SetShow(true)
  end
end
function FromClient_WatchTimer_ClassChangeBattleRoyale()
  PaGlobal_SA_Widget_Minimap._ui.txt_remainTimer:SetShow(false)
end
function FromClient_WatchTimer_BattleRoyaleRecord()
end
function FromClient_SA_Widget_Minimap_ResizePanel()
  PaGlobal_SA_Widget_Minimap._ui.stc_miniMap:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.stc_regionCondition:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.txt_remainTimer:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.stc_InvenBG:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.txt_inven:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.stc_keyInven:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.stc_EscBG:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.stc_keyEsc:ComputePos()
  PaGlobal_SA_Widget_Minimap._ui.txt_Esc:ComputePos()
end
function FromClient_SA_Widget_Minimap_ResponseSendPositionGuide(PinInfo)
  if true == PinInfo._isPermanent then
    return
  end
  if false == PaGlobal_SA_Widget_Minimap.isShow then
    return
  end
end
function PaGloabl_SA_Widget_Minimap_UpdatePerFrame(deltaTime)
  PaGlobal_SA_Widget_Minimap:updatePlayerPos(deltaTime, false)
  PaGlobal_SA_Widget_Minimap:updateCurrentLostRegionInfo(deltaTime, false)
  PaGlobal_SA_Widget_Minimap:updateRemainTimer(deltaTime)
end
function PaGlobal_SA_Widget_Minimap_Leave_MessageBox_WaitProcess()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGloabl_SA_Widget_Minimap_ShowAni()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
end
function PaGloabl_SA_Widget_Minimap_HideAni()
  if nil == Panel_SA_Widget_Minimap then
    return
  end
end
