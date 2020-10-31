function FromClient_SA_NakMessage_ReSizePanel()
  PaGlobal_SA_NakMessage._ui.stc_messageBg:ComputePos()
  PaGlobal_SA_NakMessage._ui.stc_messageIcon:ComputePos()
  PaGlobal_SA_NakMessage._ui.txt_message:ComputePos()
  PaGlobal_SA_NakMessage._default.posX = Panel_SA_NakMessage:GetPosY()
  PaGlobal_SA_NakMessage._default.posY = Panel_SA_NakMessage:GetPosY()
  local val = (getScreenSizeX() - Panel_SA_NakMessage:GetSizeX()) * 0.5
  Panel_SA_NakMessage:SetPosX(val)
end
function Proc_ShowMessage_Ack(message, showRate, posX, posY, isSoundOff, isCenter)
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(message, showRate, isSoundOff)
  chatting_sendMessage("", message, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  Panel_SA_NakMessage:SetVerticalTop()
  Panel_SA_NakMessage:SetSpanSize(PaGlobal_SA_NakMessage._defaultSpanX, PaGlobal_SA_NakMessage._defaultSpanY)
  if nil == posX or nil == posY then
    PaGlobal_SA_NakMessage._targetPosX = nil
    PaGlobal_SA_NakMessage._targetPosY = nil
  elseif nil ~= isCenter then
    Panel_SA_NakMessage:SetVerticalMiddle()
    Panel_SA_NakMessage:SetSpanSize(0, 0)
    PaGlobal_SA_NakMessage._targetPosX = Panel_SA_NakMessage:GetPosX()
    PaGlobal_SA_NakMessage._targetPosY = Panel_SA_NakMessage:GetPosY()
  else
    PaGlobal_SA_NakMessage._targetPosX = posX
    PaGlobal_SA_NakMessage._targetPosY = posY
  end
end
function Proc_ShowMessage_Ack_With_ChatType(message, showRate, chatType, chatSystemType)
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(message, showRate)
  chatting_sendMessage("", message, chatType, chatSystemType)
end
function Proc_ShowBigMessage_Ack_WithOut_ChattingMessage(message)
  local messages = message
  if "table" ~= type(message) then
    messages = {
      main = message,
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SELECTREWARD_MSG_SUB"),
      addMsg = ""
    }
  end
  Proc_ShowMessage_Ack_For_RewardSelect(messages, 3, 4)
end
function Proc_ShowMessage_Ack_WithOut_ChattingMessage(message, showRate, isSoundOff)
  if nil == isSoundOff or false == isSoundOff then
    _AudioPostEvent_SystemUiForXBOX(8, 1)
    audioPostEvent_SystemUi(8, 1)
  end
  if nil == showRate then
    PaGlobal_SA_NakMessage._animationEndTime = 2.3
    PaGlobal_SA_NakMessage._elapsedTime = 2.3
  else
    PaGlobal_SA_NakMessage._animationEndTime = showRate
    PaGlobal_SA_NakMessage._elapsedTime = showRate
  end
  PaGlobal_SA_NakMessage._curIndex = PaGlobal_SA_NakMessage._curIndex + 1
  PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._curIndex] = message
  Panel_SA_NakMessage:SetShow(true, false)
end
function Proc_ShowMessage_FrameEvent(messageNum)
  local frameEventMessageIds = {
    [0] = "LUA_FRAMEEVENT_TOO_LESS_HP",
    "LUA_FRAMEEVENT_TOO_MANY_DETERMINATION",
    "LUA_FRAMEEVENT_TOO_MANY_HP",
    "LUA_FRAMEEVENT_TOO_LESS_MP",
    "LUA_FRAMEEVENT_NOT_EXIST_COMBINE_WAVE_TARGET",
    "LUA_FRAMEEVENT_NOT_EXIST_EQUIPITEM",
    "LUA_FRAMEEVENT_NOT_TAMING_1",
    "LUA_FRAMEEVENT_NOT_PHANTOMCOUNT",
    "LUA_FRAMEEVENT_NOT_CANNON_SHOT",
    "LUA_FRAMEEVENT_NOT_CANNON_BALL_SHOT",
    "LUA_FRAMEEVENT_NOT_HORES_HP_UP",
    "LUA_FRAMEEVENT_NOT_HORES_MP_UP",
    "LUA_FRAMEEVENT_NOT_HORES_SPEED_UP",
    "LUA_FRAMEEVENT_NOT_SORCERESS_GROGGY",
    "LUA_FRAMEEVENT_NOT_MANY_HOLY",
    "LUA_RENTALSHIP_CANNON_FAIL"
  }
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, frameEventMessageIds[messageNum]))
end
function NakMessageUpdate(updateTime)
  PaGlobal_SA_NakMessage._elapsedTime = PaGlobal_SA_NakMessage._elapsedTime + updateTime
  if PaGlobal_SA_NakMessage._elapsedTime >= PaGlobal_SA_NakMessage._animationEndTime then
    if PaGlobal_SA_NakMessage._processIndex < PaGlobal_SA_NakMessage._curIndex then
      PaGlobal_SA_NakMessage:messageOpen()
      PaGlobal_SA_NakMessage._processIndex = PaGlobal_SA_NakMessage._processIndex + 1
      Panel_SA_NakMessage:SetShow(true, false)
      PaGlobal_SA_NakMessage._tempMsg = PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._processIndex]
      PaGlobal_SA_NakMessage._ui.txt_message:SetText(PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._processIndex])
      if false == PaGlobal_SA_NakMessage._posSet then
        if PaGlobal_SA_NakMessage._default.sizeX < PaGlobal_SA_NakMessage._ui.txt_message:GetTextSizeX() then
          local resizeX = PaGlobal_SA_NakMessage._ui.txt_message:GetTextSizeX() - PaGlobal_SA_NakMessage._default.sizeX + 40
          Panel_SA_NakMessage:SetSize(PaGlobal_SA_NakMessage._default.sizeX + resizeX, Panel_SA_NakMessage:GetSizeY())
        else
          Panel_SA_NakMessage:SetSize(PaGlobal_SA_NakMessage._default.sizeX, Panel_SA_NakMessage:GetSizeY())
        end
        if nil ~= PaGlobal_SA_NakMessage._targetPosX and nil ~= PaGlobal_SA_NakMessage._targetPosY then
          Panel_SA_NakMessage:SetPosX(PaGlobal_SA_NakMessage._targetPosX)
          Panel_SA_NakMessage:SetPosY(PaGlobal_SA_NakMessage._targetPosY)
          PaGlobal_SA_NakMessage._targetPosX = nil
          PaGlobal_SA_NakMessage._targetPosY = nil
        else
          Panel_SA_NakMessage:SetPosX((getScreenSizeX() - Panel_SA_NakMessage:GetSizeX()) * 0.5)
          Panel_SA_NakMessage:SetPosY(PaGlobal_SA_NakMessage._default.posY)
        end
        PaGlobal_SA_NakMessage._ui.txt_message:ComputePos()
      end
      PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._processIndex] = nil
      PaGlobal_SA_NakMessage._elapsedTime = 0
      PaGlobal_SA_NakMessage._posSet = true
    else
      PaGlobal_SA_NakMessage._posSet = false
      Panel_SA_NakMessage:SetShow(false, false)
      PaGlobal_SA_NakMessage._curIndex = 0
      PaGlobal_SA_NakMessage._processIndex = 0
    end
  elseif PaGlobal_SA_NakMessage._processIndex < PaGlobal_SA_NakMessage._curIndex and PaGlobal_SA_NakMessage._tempMsg == PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._processIndex + 1] then
    PaGlobal_SA_NakMessage._processIndex = PaGlobal_SA_NakMessage._processIndex + 1
    PaGlobal_SA_NakMessage._messageData[PaGlobal_SA_NakMessage._processIndex] = nil
  end
end
function renderModeChange_NakMessagePostRestoreFunction(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  if 0 ~= PaGlobal_SA_NakMessage._processIndex then
    Panel_SA_NakMessage:SetShow(true, false)
  end
end
function NakMessagePanel_Reset()
  PaGlobal_SA_NakMessage._curIndex = 0
  PaGlobal_SA_NakMessage._processIndex = 0
  PaGlobal_SA_NakMessage._messageData = {}
end
function PaGlobal_SA_NakMessage_ShowAni()
  if nil == Panel_SA_NakMessage then
    return
  end
end
function PaGlobal_SA_NakMessage_HideAni()
  if nil == Panel_SA_NakMessage then
    return
  end
end
