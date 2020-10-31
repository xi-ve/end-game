function PaGlobal_BloodAltar_CreateStageList(content, key)
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All:createStageList(content, key)
end
function HandleEventLUp_BloodAltar_SelectStage(index)
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  PaGlobal_BloodAltar_All._selectStageIndex = index
  if false == PaGlobal_BloodAltar_All._isConsole then
    PaGlobal_BloodAltar_All:startButtonUpdate()
  else
    HandleEventLUp_BloodAltar_StartStage()
  end
end
function HandleEventLUp_BloodAltar_StartStage()
  local MessageBox_StartStage = function()
    if -1 < PaGlobal_BloodAltar_All._selectStageIndex then
      ToClient_SetSubScriptForInstanceField(PaGlobal_BloodAltar_All._selectStageIndex)
    end
  end
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  if true == ToClient_GetInstanceSavageDefenceIsBlockDirectEnter(PaGlobal_BloodAltar_All._selectStageIndex) and false == PaGlobal_BloodAltar_All._isConsole then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_USE_DIRECT_JOIN_ITEM_TITLE")
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BLOODALTAR_USE_DIRECT_JOIN_ITEM_DESC", "count", ToClient_GetInstanceDirectJoinNeedItemCount(PaGlobal_BloodAltar_All._selectStageIndex))
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_StartStage,
      functionNo = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    MessageBox_StartStage()
  end
end
function HandleEventLUp_BloodAltar_OpenPartySetting()
  if nil == Panel_Window_PartySetting then
    return
  end
  PaGlobalFunc_PartySetting_ForBloodAltar()
end
function PaGlobalFunc_PartySetting_GetOpenType()
  if nil == PaGlobal_BloodAltar_All._openType and false == Panel_Window_BloodAltar_All._isConsole then
    return 0
  end
  return PaGlobal_BloodAltar_All._openType
end
function PaGlobalFunc_BloodAltar_SetOpenType(type)
  if nil == type or false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobal_BloodAltar_All._openType = type
end
function FromClient_BloodAltar_EndInstanceSavageDefenceWave(isMaxProcess)
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  local StringMsg = {
    PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_SUCCESS_GAME"),
    PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_FAIL_END"),
    PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_MOVE_CHANNEL")
  }
  PaGlobal_BloodAltarGauge_All:prepareClose()
  if false == isMaxProcess then
    local Msg = {
      main = StringMsg[2],
      sub = StringMsg[3],
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(Msg, 5, 73, false)
  else
    local Msg = {
      main = StringMsg[1],
      sub = StringMsg[3],
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(Msg, 5, 72, false)
  end
end
function FromClient_BloodAltar_CheckSetSubScriptInstanceFieldAck(type)
  if nil == Panel_Window_BloodAltar_All or nil == Panel_Widget_BloodAltarGauge_All then
    return
  end
  local openType = ToClient_checkSetSubScriptInstanceField()
  PaGlobal_BloodAltar_All._openType = openType
  if __eInstanceSetSubScriptType_CantSet == openType then
  elseif __eInstanceSetSubScriptType_Setable == openType then
    PaGlobal_BloodAltarGauge_All:prepareClose()
    PaGlobal_BloodAltar_All:prepareOpen()
  elseif __eInstanceSetSubScriptType_Setable_UsePearl == openType then
    if false == PaGlobal_BloodAltarRetry_All._isConsole then
      PaGlobal_BloodAltarRetry_All:prepareOpen()
    else
      PaGlobalFunc_BlooaAltarRetry_RetryCheck(false)
    end
  else
    _PA_LOG("\235\172\184\236\158\165\237\153\152", "FromClient_BloodAltar_CheckSetSubScriptInstanceFieldAck\236\151\144 \235\140\128\237\149\156 \236\158\152\235\170\187\235\144\156 \236\160\145\234\183\188")
  end
  _PA_LOG("Common", "Panel_Window_BloodAltar_All_2.lua / type : " .. tostring(type) .. " / " .. "ToClient_checkSetSubScriptInstanceField() : " .. tostring(openType))
end
function FromClient_BloodAltar_SetSubScriptForInstanceFieldResult(isSuccess, rv)
  if nil == Panel_Window_BloodAltar_All then
    return
  end
  if true == isSuccess then
    PaGlobal_BloodAltar_All._currentStageIndex = PaGlobal_BloodAltar_All._selectStageIndex
    PaGlobal_BloodAltar_All:prepareClose()
    PaGlobal_BloodAltarRetry_All:prepareClose()
  end
end
