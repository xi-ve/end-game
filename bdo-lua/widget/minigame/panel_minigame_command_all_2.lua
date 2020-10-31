function PaGloabl_Command_All_ShowAni()
  if nil == Panel_MiniGame_Command_All then
    return
  end
end
function PaGloabl_Command_All_HideAni()
  if nil == Panel_MiniGame_Command_All then
    return
  end
end
function PaGloabl_Command_All_StartGame()
  PaGlobal_Command_All:startGame()
end
function PaGloabl_Command_All_EndGame()
  PaGlobal_Command_All:endGame()
end
function PaGlobal_Command_All_CommandInput(keyType)
  PaGlobal_Command_All:commandInput(keyType)
end
function PaGlobal_Command_All_UpdateText(deltaTime)
  PaGlobal_Command_All:updateText(deltaTime)
end
function PaGlobal_Command_All_CommandInputByPad(keyType)
  local changeKeyType = -1
  if __eQuickTimeEventPadType_Up == keyType or __eQuickTimeEventPadType_DpadUp == keyType then
    changeKeyType = CppEnums.ActionInputType.ActionInputType_MoveFront
  elseif __eQuickTimeEventPadType_Down == keyType or __eQuickTimeEventPadType_DpadDown == keyType then
    changeKeyType = CppEnums.ActionInputType.ActionInputType_MoveBack
  elseif __eQuickTimeEventPadType_Left == keyType or __eQuickTimeEventPadType_DpadLeft == keyType then
    changeKeyType = CppEnums.ActionInputType.ActionInputType_MoveLeft
  elseif __eQuickTimeEventPadType_Right == keyType or __eQuickTimeEventPadType_DpadRight == keyType then
    changeKeyType = CppEnums.ActionInputType.ActionInputType_MoveRight
  end
  if true == Panel_MiniGame_Command_All:GetShow() then
    PaGlobal_Command_All_CommandInput(changeKeyType)
  end
end
