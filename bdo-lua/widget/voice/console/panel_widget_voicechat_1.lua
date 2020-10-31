function PaGlobal_VoiceChat:initialize()
  if true == PaGlobal_VoiceChat._initialize then
    return
  end
  self._ui.stc_mainBG = UI.getChildControl(Panel_Widget_Voice, "Static_BG")
  self._ui.txt_Spearker = UI.getChildControl(self._ui.stc_mainBG, "StaticText_Speaker")
  local row = 1
  local col = 0
  self._gapX = self._ui.stc_mainBG:GetSizeX()
  self._gapY = self._ui.stc_mainBG:GetSizeY()
  self._speaker = {}
  self._speakerBG = {}
  self._speaker[1] = self._ui.txt_Spearker
  self._speakerBG[1] = self._ui.stc_mainBG
  self._speakerBG[1]:SetPosX(self._gapX)
  for index = 2, self._MaxPoolCount do
    local controlBG = UI.cloneControl(self._ui.stc_mainBG, Panel_Widget_Voice, "StaticText_SpeakerBG_" .. index)
    local control = UI.getChildControl(controlBG, "StaticText_Speaker")
    controlBG:SetPosX((1 - col) * self._gapX)
    controlBG:SetPosY(row * self._gapY)
    self._speakerBG[index] = controlBG
    self._speaker[index] = control
    row = row + 1
    if 0 == row % 5 then
      row = 0
      col = col + 1
    end
  end
  Panel_Widget_Voice:SetSize(self._ui.stc_mainBG:GetSizeX() * 2, self._ui.stc_mainBG:GetSizeY() * row)
  self:reposition()
  PaGlobal_VoiceChat:registEventHandler()
  PaGlobal_VoiceChat:validate()
  FromClient_VoiceChat_UpdateVoiceChatState()
  PaGlobal_VoiceChat._initialize = true
end
function PaGlobal_VoiceChat:registEventHandler()
  if nil == Panel_Widget_Voice then
    return
  end
  registerEvent("FromClient_UpdateVoiceSpeakStatus", "FromClient_VoiceChat_UpdateSpeakerStatus")
  registerEvent("FromClient_StartVoiceChat", "FromClient_VoiceChat_Open")
  registerEvent("FromClient_StopVoiceChat", "FromClient_VoiceChat_Close")
end
function PaGlobal_VoiceChat:prepareOpen()
  if nil == Panel_Widget_Voice then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_VoiceChat:open()
  if nil == Panel_Widget_Voice then
    return
  end
  Panel_Widget_Voice:SetShow(true)
end
function PaGlobal_VoiceChat:prepareClose()
  if nil == Panel_Widget_Voice then
    return
  end
  self._userID = {}
  PaGlobal_VoiceChat:close()
end
function PaGlobal_VoiceChat:close()
  if nil == Panel_Widget_Voice then
    return
  end
  Panel_Widget_Voice:SetShow(false)
end
function PaGlobal_VoiceChat:update()
  if nil == Panel_Widget_Voice then
    return
  end
  local index = 1
  for key, value in pairs(self._userID) do
    if index > self._MaxPoolCount then
      break
    end
    self._speaker[index]:SetText(value)
    self._speakerBG[index]:SetShow(true)
    index = index + 1
  end
  if index < self._MaxPoolCount then
    for i = index, self._MaxPoolCount do
      self._speakerBG[i]:SetShow(false)
    end
  end
end
function PaGlobal_VoiceChat:validate()
  if nil == Panel_Widget_Voice then
    return
  end
  self._ui.stc_mainBG:isValidate()
  for index = 1, self._MaxPoolCount do
    self._speaker[index]:isValidate()
  end
end
function PaGlobal_VoiceChat:reposition()
  if nil == Panel_Widget_Voice then
    return
  end
  local posX = Panel_Radar:GetPosX() - Panel_Widget_Voice:GetSizeX() - 20
  local posY = Panel_Radar:GetPosY() + 100
  Panel_Widget_Voice:SetPosX(posX)
  Panel_Widget_Voice:SetPosY(posY)
end
function PaGlobal_VoiceChat:updateSpearkStatus(userId, isShow)
  if nil == Panel_Widget_Voice then
    return
  end
  if isShow then
    self._userID[userId] = userId
  else
    self._userID[userId] = nil
  end
  self:update()
end
