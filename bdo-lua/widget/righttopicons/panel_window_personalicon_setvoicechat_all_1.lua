function PaGlobal_SetVoiceChat_All:initialize()
  if true == PaGlobal_SetVoiceChat_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit_All()
  self:controlInit_Pc()
  self:controlInit_Console()
  self:controlSetShow()
  PaGlobal_SetVoiceChat_All:registEventHandler()
  PaGlobal_SetVoiceChat_All:validate()
  PaGlobal_SetVoiceChat_All._initialize = true
end
function PaGlobal_SetVoiceChat_All:controlInit_All()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Window_SetVoiceChat_All, "StaticText_SetVoiceChatTitle")
  self._ui.stc_insideBg = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Static_InsideBg")
  self._ui.stc_micHeadPhoneOnOffBg = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Static_MicHeadphoneOnOffBG")
  self._ui.txt_micHeadPhoneOnOff = UI.getChildControl(Panel_Window_SetVoiceChat_All, "StaticText_MicHeadphoneOnOff")
  self._ui.stc_micHeadPhoneCheckBg = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Static_MicHeadPhoneCheckBg")
  self._ui.chk_mic = UI.getChildControl(self._ui.stc_micHeadPhoneCheckBg, "Checkbox_MicOnOff")
  self._ui.chk_listen = UI.getChildControl(self._ui.stc_micHeadPhoneCheckBg, "CheckButton_SpeakerOnOff")
  self._ui.chk_pushMic = UI.getChildControl(self._ui.stc_micHeadPhoneCheckBg, "CheckButton_PushToTalkOnOff")
  self._ui.slider_volControl_0 = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Slider_MicVolControl_0")
  self._ui.slider_volControl_1 = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Slider_MicVolControl_1")
  self._ui.slider_volControl_2 = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Slider_MicVolControl_2")
  self._ui.slider_volControl_3 = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Slider_MicVolControl_3")
  local defaultPosY = 135
  for sliderIdx = 0, self._config.sliderCount - 1 do
    local tempSlot = {}
    tempSlot.titleBg = UI.createAndCopyBasePropertyControl(Panel_Window_SetVoiceChat_All, "Static_MicBG", Panel_Window_SetVoiceChat_All, "Panel_SetVoiceChat_TitleBg_" .. sliderIdx)
    tempSlot.title = UI.createAndCopyBasePropertyControl(Panel_Window_SetVoiceChat_All, "StaticText_MicTitle", tempSlot.titleBg, "Panel_SetVoiceChat_Title_" .. sliderIdx)
    tempSlot.vol_0 = UI.createAndCopyBasePropertyControl(Panel_Window_SetVoiceChat_All, "StaticText_MicVol_0", tempSlot.titleBg, "Panel_SetVoiceChat_Vol_0_" .. sliderIdx)
    tempSlot.vol_50 = UI.createAndCopyBasePropertyControl(Panel_Window_SetVoiceChat_All, "StaticText_MicVol_50", tempSlot.titleBg, "Panel_SetVoiceChat_Vol_50_" .. sliderIdx)
    tempSlot.vol_100 = UI.createAndCopyBasePropertyControl(Panel_Window_SetVoiceChat_All, "StaticText_MicVol_100", tempSlot.titleBg, "Panel_SetVoiceChat_Vol_100_" .. sliderIdx)
    local slider
    if 0 == sliderIdx then
      slider = self._ui.slider_volControl_0
    elseif 1 == sliderIdx then
      slider = self._ui.slider_volControl_1
    elseif 2 == sliderIdx then
      slider = self._ui.slider_volControl_2
    elseif 3 == sliderIdx then
      slider = self._ui.slider_volControl_3
    end
    Panel_Window_SetVoiceChat_All:RemoveControl(slider)
    tempSlot.titleBg:AddChild(slider)
    tempSlot.vol_Slider = slider
    tempSlot.vol_SliderBtn = UI.getChildControl(tempSlot.vol_Slider, "Slider_MicVol_Button")
    tempSlot.vol_SliderBtnConsole = UI.getChildControl(tempSlot.vol_SliderBtn, "Static_Move_Console")
    tempSlot.vol_Slider:SetShow(true)
    tempSlot.vol_SliderBtnConsole:SetShow(false)
    tempSlot.titleBg:SetPosY(defaultPosY + 75 * sliderIdx)
    tempSlot.title:SetPosX(10)
    tempSlot.title:SetPosY(1)
    tempSlot.vol_0:SetPosX(5)
    tempSlot.vol_0:SetPosY(25)
    tempSlot.vol_50:SetPosX(tempSlot.vol_Slider:GetSizeX() / 2 - tempSlot.vol_50:GetSizeX() / 3)
    tempSlot.vol_50:SetPosY(25)
    tempSlot.vol_100:SetPosX(tempSlot.vol_Slider:GetSizeX() - tempSlot.vol_100:GetSizeX())
    tempSlot.vol_100:SetPosY(25)
    tempSlot.vol_Slider:SetPosX(5)
    tempSlot.vol_Slider:SetPosY(50)
    tempSlot.vol_Slider:SetControlPos(0)
    tempSlot.title:SetText(self._titleArray[sliderIdx])
    self._uiPool[sliderIdx] = tempSlot
  end
  self._ui.chk_mic:SetTextMode(__eTextMode_AutoWrap)
  self._ui.chk_mic:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SETVOICECHAT_TALK"))
  self._ui.chk_mic:SetEnableArea(0, 0, self._ui.chk_mic:GetTextSizeX() + 25, self._ui.chk_mic:GetSizeY())
  self._ui.chk_listen:SetTextMode(__eTextMode_AutoWrap)
  self._ui.chk_listen:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SETVOICECHAT_HEARING"))
  self._ui.chk_listen:SetEnableArea(0, 0, self._ui.chk_listen:GetTextSizeX() + 25, self._ui.chk_listen:GetSizeY())
  self._ui.chk_pushMic:SetTextMode(__eTextMode_AutoWrap)
  self._ui.chk_pushMic:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SETVOICECHAT_PUSHTOTALK"))
  self._ui.chk_pushMic:SetEnableArea(0, 0, self._ui.chk_pushMic:GetTextSizeX() + 25, self._ui.chk_pushMic:GetSizeY())
end
function PaGlobal_SetVoiceChat_All:controlInit_Pc()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_title, "Button_WinClose")
  self._ui_pc.btn_confirm = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Button_Confirm")
  self._ui_pc.btn_cancle = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Button_Cancel")
end
function PaGlobal_SetVoiceChat_All:controlInit_Console()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  self._ui_console.stc_bottomGuideBg = UI.getChildControl(Panel_Window_SetVoiceChat_All, "Static_KeyGuide_Console")
  self._ui_console.stc_guideA = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_Select_Console")
  self._ui_console.stc_guideB = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_Close_Console")
  self._ui_console.stc_guideY = UI.getChildControl(self._ui_console.stc_bottomGuideBg, "StaticText_Confirm_Console")
end
function PaGlobal_SetVoiceChat_All:controlSetShow()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_confirm:SetShow(true)
    self._ui_pc.btn_cancle:SetShow(true)
    self._ui_console.stc_bottomGuideBg:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_confirm:SetShow(false)
    self._ui_pc.btn_cancle:SetShow(false)
    self._ui_console.stc_bottomGuideBg:SetShow(true)
  end
end
function PaGlobal_SetVoiceChat_All:prepareOpen()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if false == _ContentsGroup_VoiceChat then
    return
  end
  PaGlobal_SetVoiceChat_All:update()
  PaGlobal_SetVoiceChat_All:resize()
  PaGlobal_SetVoiceChat_All:open()
end
function PaGlobal_SetVoiceChat_All:open()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if true == Panel_Window_SetVoiceChat_All:GetShow() then
    _AudioPostEvent_SystemUiForXBOX(8, 14)
  end
  Panel_Window_SetVoiceChat_All:SetShow(true)
end
function PaGlobal_SetVoiceChat_All:prepareClose()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  PaGlobal_SetVoiceChat_All:saveInfo()
  PaGlobal_SetVoiceChat_All:close()
end
function PaGlobal_SetVoiceChat_All:close()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  Panel_Window_SetVoiceChat_All:SetShow(false)
end
function PaGlobal_SetVoiceChat_All:update()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  PaGlobal_SetVoiceChat_All:getSavingInfo()
  self._uiPool[0].vol_Slider:SetControlPos(self._config.openMicVolume)
  self._uiPool[1].vol_Slider:SetControlPos(self._config.openHeadphoneVolume)
  self._uiPool[2].vol_Slider:SetControlPos(self._config.openMicSensitivity)
  self._uiPool[3].vol_Slider:SetControlPos(self._config.openMicAmplification)
  self._ui.chk_mic:SetCheck(self._config.openIsMicOn)
  self._ui.chk_listen:SetCheck(self._config.openIsHeadphoneOn)
  self._ui.chk_pushMic:SetCheck(self._config.openIsPushToTalk)
  self:enableSetConectMic()
end
function PaGlobal_SetVoiceChat_All:enableSetConectMic()
  if false == ToClient_IsConnectedMic() then
    self._ui.chk_mic:SetCheck(false)
    self._ui.chk_pushMic:SetCheck(false)
    self._ui.chk_mic:SetIgnore(true)
    self._ui.chk_pushMic:SetIgnore(true)
    self._ui.chk_mic:SetMonoTone(true, true)
    self._ui.chk_pushMic:SetMonoTone(true, true)
  else
    self._ui.chk_mic:SetIgnore(false)
    self._ui.chk_pushMic:SetIgnore(false)
    self._ui.chk_mic:SetMonoTone(false, true)
    self._ui.chk_pushMic:SetMonoTone(false, true)
  end
  self._ui.chk_pushMic:SetShow(not self._isConsole)
end
function PaGlobal_SetVoiceChat_All:registEventHandler()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SetVoiceChat_All_Close()")
    self._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "PaGlobalFunc_SetVoiceChat_All_Close()")
    self._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_Confirm()")
    self._ui.chk_mic:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    self._ui.chk_listen:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    self._ui.chk_pushMic:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    for index = 0, self._config.sliderCount - 1 do
      self._uiPool[index].vol_Slider:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_Volume( " .. index .. " )")
      self._uiPool[index].vol_SliderBtn:addInputEvent("Mouse_LPress", "HandleMove_SetVoiceChat_All_Volume( " .. index .. " )")
      self._uiPool[index].vol_SliderBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_SetVoiceChat_All_Volume(" .. index .. ")")
    end
  else
    self._ui.chk_mic:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    self._ui.chk_listen:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    self._ui.chk_pushMic:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_SetVoiceChat_All_SetOnOff()")
    Panel_Window_SetVoiceChat_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SetVoiceChat_All_Confirm()")
    self._ui.chk_mic:addInputEvent("Mouse_On", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(true)")
    self._ui.chk_mic:addInputEvent("Mouse_Out", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(false)")
    self._ui.chk_listen:addInputEvent("Mouse_On", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(true)")
    self._ui.chk_listen:addInputEvent("Mouse_Out", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(false)")
    self._ui.chk_pushMic:addInputEvent("Mouse_On", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(true)")
    self._ui.chk_pushMic:addInputEvent("Mouse_Out", "HandleEventOn_SetVoiceChat_All_ConsoleSelectGuide(false)")
    for index = 0, self._config.sliderCount - 1 do
      self._uiPool[index].vol_Slider:addInputEvent("Mouse_LPress", "HandleMove_SetVoiceChat_All_Volume(" .. index .. ")")
    end
  end
  registerEvent("onScreenResize", "FromClient_SetVoiceChat_All_OnScreenResize")
end
function PaGlobal_SetVoiceChat_All:validate()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.stc_insideBg:isValidate()
  self._ui.stc_micHeadPhoneOnOffBg:isValidate()
  self._ui.txt_micHeadPhoneOnOff:isValidate()
  self._ui.chk_mic:isValidate()
  self._ui.chk_listen:isValidate()
  self._ui.chk_pushMic:isValidate()
  self._ui.slider_volControl_0:isValidate()
  self._ui.slider_volControl_1:isValidate()
  self._ui.slider_volControl_2:isValidate()
  self._ui.slider_volControl_3:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_confirm:isValidate()
  self._ui_pc.btn_cancle:isValidate()
  self._ui_console.stc_bottomGuideBg:isValidate()
  self._ui_console.stc_guideA:isValidate()
  self._ui_console.stc_guideB:isValidate()
  self._ui_console.stc_guideY:isValidate()
end
function PaGlobal_SetVoiceChat_All:resize()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  local voiceChatButton
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    voiceChatButton = FGlobal_GetPersonalIconControl(2)
  else
    voiceChatButton = PaGlobalFunc_Widget_FunctionButton_Control(Widget_Function_Type.SetVoice)
  end
  if false == self._isConsole then
    Panel_Window_SetVoiceChat_All:SetSize(Panel_Window_SetVoiceChat_All:GetSizeX(), self._uiSize.panelsizeY_pc)
    Panel_Window_SetVoiceChat_All:SetPosX(Panel_Radar:GetPosX() - Panel_Window_SetVoiceChat_All:GetSizeX())
    Panel_Window_SetVoiceChat_All:SetPosY(voiceChatButton:GetPosY() + voiceChatButton:GetSizeY() + 5)
  else
    local screenX = getOriginScreenSizeX()
    local screenY = getOriginScreenSizeY()
    Panel_Window_SetVoiceChat_All:SetSize(Panel_Window_SetVoiceChat_All:GetSizeX(), self._uiSize.panelsizeY_console)
    Panel_Window_SetVoiceChat_All:SetPosX(screenX / 2 - Panel_Window_SetVoiceChat_All:GetSizeX() / 2)
    Panel_Window_SetVoiceChat_All:SetPosY(screenY / 2 - Panel_Window_SetVoiceChat_All:GetSizeY() / 2 - 20)
    self._ui_console.stc_bottomGuideBg:ComputePos()
    local keyGuideList = {
      self._ui_console.stc_guideY,
      self._ui_console.stc_guideA,
      self._ui_console.stc_guideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_bottomGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SetVoiceChat_All:getSavingInfo()
  self._config.openIsMicOn = ToClient_isVoiceChatMic(self._VOICE_TYPE.enVoiceChatType_Guild)
  self._config.openIsHeadphoneOn = ToClient_isVoiceChatListen(self._VOICE_TYPE.enVoiceChatType_Guild)
  self._config.openIsPushToTalk = ToClient_isVoiceChatPushToTalk()
  self._config.openMicVolume = ToClient_getMicVolume()
  self._config.openHeadphoneVolume = ToClient_getSpeakerVolume()
  self._config.openMicSensitivity = ToClient_getMicSensitivity()
  self._config.openMicAmplification = math.ceil(ToClient_getMicAdjustment() * 100) - 100
end
function PaGlobal_SetVoiceChat_All:setSavingInfo()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  self._config.openIsMicOn = self._ui.chk_mic:IsCheck()
  self._config.openIsHeadphoneOn = self._ui.chk_listen:IsCheck()
  self._config.openIsPushToTalk = self._ui.chk_pushMic:IsCheck()
  self._config.openMicVolume = math.ceil(self._uiPool[0].vol_Slider:GetControlPos() * 100)
  self._config.openHeadphoneVolume = math.ceil(self._uiPool[1].vol_Slider:GetControlPos() * 100)
  self._config.openMicSensitivity = math.ceil(self._uiPool[2].vol_Slider:GetControlPos() * 100)
  self._config.openMicAmplification = math.ceil(self._uiPool[3].vol_Slider:GetControlPos() * 100)
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  if false == ToClient_isLoggedInVoiceChatServer() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
  end
  self:prepareClose()
end
function PaGlobal_SetVoiceChat_All:saveInfo()
  local selfPlayer = getSelfPlayer():get()
  local isMicOn = self._config.openIsMicOn
  local isHeadphoneOn = self._config.openIsHeadphoneOn
  local isPushToTalk = self._config.openIsPushToTalk
  local micVolume = self._config.openMicVolume
  local headphoneVolume = self._config.openHeadphoneVolume
  local micSensitivity = self._config.openMicSensitivity
  local micAmplification = self._config.openMicAmplification
  if true == ToClient_IsConnectedMic() then
    ToClient_setMicOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, isMicOn)
  else
    ToClient_setMicOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, false)
  end
  ToClient_setSpeakerOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, isHeadphoneOn)
  ToClient_setPushToTalkOnOff(isPushToTalk)
  ToClient_setMicVolume(micVolume)
  ToClient_setSpeakerVolume(headphoneVolume)
  ToClient_setMicSensitivity(micSensitivity)
  ToClient_setMicAdjustment(micAmplification)
  ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, selfPlayer:getUserNo(), isMicOn, isHeadphoneOn, false)
  self:changeStatePersonalIcon()
end
function PaGlobal_SetVoiceChat_All:setChkOnOff()
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  local isMicOn = self._ui.chk_mic:IsCheck()
  local isHeadphoneOn = self._ui.chk_listen:IsCheck()
  local isPushToTalk = self._ui.chk_pushMic:IsCheck()
  self:SetTalkButtonByCheck(isMicOn)
  local getVoiceChatOnOff = ToClient_isVoiceChatListen()
  if isHeadphoneOn ~= getVoiceChatOnOff then
    ToClient_setSpeakerOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, isHeadphoneOn)
  end
  ToClient_setPushToTalkOnOff(isPushToTalk)
  self:changeStatePersonalIcon()
end
function PaGlobal_SetVoiceChat_All:setVolume(sliderIdx)
  if nil == Panel_Window_SetVoiceChat_All then
    return
  end
  local slider = self._uiPool[sliderIdx].vol_Slider
  if nil == slider then
    return
  end
  local posPercent = slider:GetControlPos() * 100
  if 0 == sliderIdx then
    ToClient_setMicVolume(posPercent)
    if 0 < posPercent then
      self._ui.chk_mic:SetCheck(true)
    else
      self._ui.chk_mic:SetCheck(false)
    end
  elseif 1 == sliderIdx then
    ToClient_setSpeakerVolume(posPercent)
    if 0 < posPercent then
      self._ui.chk_listen:SetCheck(true)
    else
      self._ui.chk_listen:SetCheck(false)
    end
  elseif 2 == sliderIdx then
    ToClient_setMicSensitivity(posPercent)
  elseif 3 == sliderIdx then
    ToClient_setMicAdjustment(posPercent)
  end
  self:setChkOnOff()
end
function PaGlobal_SetVoiceChat_All:SetTalkButtonByCheck(isCheck)
  if false == isCheck then
    ToClient_setMicOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, false)
    return
  end
  if false == ToClient_IsConnectedMic() then
    self._ui.chk_mic:SetCheck(false)
    return
  end
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil ~= guildInfo then
    local myMemberInfo = guildInfo:getMemberByUserNo(getSelfPlayer():get():getUserNo())
    if false == myMemberInfo:isVoicePermissionHas() and false == getSelfPlayer():get():isGuildMaster() then
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_YOUHAVENOPERMISSION"),
        functionYes = MessageBox_Empty_function,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
      self._ui.chk_mic:SetCheck(false)
      return
    end
  end
  self._ui.chk_mic:SetCheck(true)
  ToClient_setMicOnOff(self._VOICE_TYPE.enVoiceChatType_Guild, true)
end
function PaGlobal_SetVoiceChat_All:changeStatePersonalIcon()
  if true == self._isConsole then
    return
  end
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    FGlobal_VoiceChatState()
  else
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.SetVoice)
  end
end
