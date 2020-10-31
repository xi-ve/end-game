function FromClient_SA_Window_MessageBox_ReSizePanel()
  Panel_SA_Window_MessageBox:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.stc_exitBG:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.txt_content:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.stc_buttons:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.btn_yes:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.btn_no:ComputePos()
  PaGlobal_SA_Window_MessageBox._ui.btn_close:ComputePos()
end
function PaGlobal_SA_Window_MessageBox_Open()
  PaGlobal_SA_Window_MessageBox:prepareOpen()
end
function PaGlobal_SA_Window_MessageBox_Close()
  PaGlobal_SA_Window_MessageBox:prepareClose()
end
function PaGlobal_SA_Window_MessageBox_UpdatePerFrame(deltaTime)
  if false == PaGlobal_SA_Window_MessageBox._currentMessageBoxData.isTimeCount then
    return
  end
  PaGlobal_SA_Window_MessageBox._elapsedTime = PaGlobal_SA_Window_MessageBox._elapsedTime + deltaTime
  if PaGlobal_SA_Window_MessageBox._elapsedTime < PaGlobal_SA_Window_MessageBox._currentMessageBoxData.countTime then
    if nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.timeString then
      local remainTime = math.floor(PaGlobal_SA_Window_MessageBox._currentMessageBoxData.countTime - PaGlobal_SA_Window_MessageBox._elapsedTime)
      local timerText = remainTime .. PaGlobal_SA_Window_MessageBox._currentMessageBoxData.timeString
      PaGlobal_SA_Window_MessageBox._ui.txt_content:SetText(timerText .. [[


]] .. PaGlobal_SA_Window_MessageBox._currentMessageBoxData.content)
    end
  elseif nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.afterFunction then
    PaGlobal_SA_Window_MessageBox._currentMessageBoxData.isTimeCount = false
    PaGlobal_SA_Window_MessageBox._currentMessageBoxData.afterFunction()
  end
end
function MessageBox.showMessageBox(MessageData, position, isGameExit, keyUse, refuseType)
  if nil == Panel_SA_Window_MessageBox or true == Panel_SA_Window_MessageBox:GetShow() then
    return
  end
  PaGlobal_SA_Window_MessageBox:setCurrentMessageData(MessageData, keyUse)
  PaGlobal_SA_Window_MessageBox_Open()
end
function PaGlobal_SA_Window_MessageBox:setCurrentMessageData(MessageData, keyUse)
  PaGlobal_SA_Window_MessageBox._ui.btn_yes:SetShow(false)
  PaGlobal_SA_Window_MessageBox._ui.btn_no:SetShow(false)
  PaGlobal_SA_Window_MessageBox._functionKeyUse = true
  if nil ~= keyUse then
    PaGlobal_SA_Window_MessageBox._functionKeyUse = keyUse
  end
  if nil ~= MessageData.content then
    PaGlobal_SA_Window_MessageBox._ui.txt_content:SetText(MessageData.content)
  end
  local buttonCount = 0
  if nil ~= MessageData.functionYes then
    PaGlobal_SA_Window_MessageBox._ui.btn_yes:SetShow(true)
    PaGlobal_SA_Window_MessageBox._ui.btn_yes:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES"))
    buttonCount = buttonCount + 1
  end
  if nil ~= MessageData.functionNo then
    PaGlobal_SA_Window_MessageBox._ui.btn_no:SetShow(true)
    PaGlobal_SA_Window_MessageBox._ui.btn_no:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO"))
    buttonCount = buttonCount + 1
  end
  local contentTextSizeY = PaGlobal_SA_Window_MessageBox._ui.txt_content:GetTextSizeY()
  if contentTextSizeY > PaGlobal_SA_Window_MessageBox._originContentSizeY then
    local gap = contentTextSizeY - PaGlobal_SA_Window_MessageBox._originContentSizeY
    PaGlobal_SA_Window_MessageBox._ui.txt_content:SetSize(PaGlobal_SA_Window_MessageBox._ui.txt_content:GetSizeX(), PaGlobal_SA_Window_MessageBox._originContentSizeY + gap)
    Panel_SA_Window_MessageBox:SetSize(Panel_SA_Window_MessageBox:GetSizeX(), PaGlobal_SA_Window_MessageBox._originPanelSizeY + gap)
    PaGlobal_SA_Window_MessageBox._ui.stc_exitBG:SetSize(Panel_SA_Window_MessageBox:GetSizeX(), PaGlobal_SA_Window_MessageBox._originPanelSizeY + gap)
    FromClient_SA_Window_MessageBox_ReSizePanel()
  else
    PaGlobal_SA_Window_MessageBox._ui.txt_content:SetSize(PaGlobal_SA_Window_MessageBox._ui.txt_content:GetSizeX(), PaGlobal_SA_Window_MessageBox._originContentSizeY)
    Panel_SA_Window_MessageBox:SetSize(Panel_SA_Window_MessageBox:GetSizeX(), PaGlobal_SA_Window_MessageBox._originPanelSizeY)
    PaGlobal_SA_Window_MessageBox._ui.stc_exitBG:SetSize(Panel_SA_Window_MessageBox:GetSizeX(), PaGlobal_SA_Window_MessageBox._originPanelSizeY)
    FromClient_SA_Window_MessageBox_ReSizePanel()
  end
  if 0 == buttonCount then
    local contentSpanSizeY = (Panel_SA_Window_MessageBox:GetSizeY() - PaGlobal_SA_Window_MessageBox._ui.txt_content:GetSizeY()) / 2
    PaGlobal_SA_Window_MessageBox._ui.txt_content:SetSpanSize(PaGlobal_SA_Window_MessageBox._ui.txt_content:GetSpanSize().x, contentSpanSizeY)
  end
  if 0 == buttonCount then
    PaGlobal_SA_Window_MessageBox._ui.btn_close:SetShow(false)
  elseif 1 == buttonCount then
    PaGlobal_SA_Window_MessageBox._ui.btn_yes:SetPosX(PaGlobal_SA_Window_MessageBox._ui.stc_buttons:GetSizeX() / 2 - PaGlobal_SA_Window_MessageBox._ui.btn_yes:GetSizeX() / 2)
    PaGlobal_SA_Window_MessageBox._ui.btn_no:SetPosX(PaGlobal_SA_Window_MessageBox._ui.stc_buttons:GetSizeX() / 2 - PaGlobal_SA_Window_MessageBox._ui.btn_yes:GetSizeX() / 2)
    PaGlobal_SA_Window_MessageBox._ui.btn_close:SetShow(true)
  elseif 2 == buttonCount then
    PaGlobal_SA_Window_MessageBox._ui.btn_yes:SetPosX(0)
    PaGlobal_SA_Window_MessageBox._ui.btn_no:SetPosX(PaGlobal_SA_Window_MessageBox._ui.btn_yes:GetSizeX() + 10)
    PaGlobal_SA_Window_MessageBox._ui.btn_close:SetShow(true)
  end
  if true == MessageData.isTimeCount then
    Panel_SA_Window_MessageBox:RegisterUpdateFunc("PaGlobal_SA_Window_MessageBox_UpdatePerFrame")
  end
  PaGlobal_SA_Window_MessageBox._currentMessageBoxData = MessageData
end
function HandleEventLUp_SA_Window_MessageBox_YesButtonUp()
  local functionYes
  if nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData and nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionYes then
    functionYes = PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionYes
  end
  if functionYes ~= nil then
    PaGlobal_SA_Window_MessageBox_Close()
    functionYes()
  end
end
function HandleEventLUp_SA_Window_MessageBox_NoButtonUp()
  local functionNo
  if nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData and nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionNo then
    functionNo = PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionNo
  end
  if functionNo ~= nil then
    PaGlobal_SA_Window_MessageBox_Close()
    functionNo()
  end
end
function MessageBox_Empty_function()
end
function MessageBox.isPopUp()
  return Panel_SA_Window_MessageBox:GetShow()
end
function MessageBox.keyProcessEnter()
  if not PaGlobal_SA_Window_MessageBox._functionKeyUse then
    return
  end
  local enterkeyExecute
  if nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData and nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionYes then
    enterkeyExecute = PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionYes
  end
  if enterkeyExecute ~= nil then
    PaGlobal_SA_Window_MessageBox_Close()
    enterkeyExecute()
  end
end
function MessageBox.keyProcessEscape()
  if not PaGlobal_SA_Window_MessageBox._functionKeyUse then
    return
  end
  if nil ~= PaGlobal_SA_Window_MessageBox._currentMessageBoxData.functionNo then
    HandleEventLUp_SA_Window_MessageBox_NoButtonUp()
  else
    PaGlobal_SA_Window_MessageBox_Close()
  end
end
function allClearMessageData()
  PaGlobal_SA_Window_MessageBox_Close()
end
