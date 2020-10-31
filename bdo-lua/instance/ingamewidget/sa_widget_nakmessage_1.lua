local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
function PaGlobal_SA_NakMessage:initialize()
  if true == PaGlobal_SA_NakMessage._initialize then
    return
  end
  self._ui.stc_messageBg = UI.getChildControl(Panel_SA_NakMessage, "Static_NakMessageBG")
  self._ui.stc_messageIcon = UI.getChildControl(Panel_SA_NakMessage, "Static_MessageIcon")
  self._ui.txt_message = UI.getChildControl(Panel_SA_NakMessage, "StaticText_MessageBox")
  Panel_SA_NakMessage:setFlushAble(false)
  self._default.sizeX = Panel_SA_NakMessage:GetSizeX()
  self._default.sizeY = Panel_SA_NakMessage:GetSizeY()
  self._default.posX = Panel_SA_NakMessage:GetPosY()
  self._default.posY = Panel_SA_NakMessage:GetPosY()
  self._defaultSpanX = Panel_SA_NakMessage:GetSpanSize().x
  self._defaultSpanY = Panel_SA_NakMessage:GetSpanSize().y
  PaGlobal_SA_NakMessage:registEventHandler()
  PaGlobal_SA_NakMessage:validate()
  PaGlobal_SA_NakMessage._initialize = true
end
function PaGlobal_SA_NakMessage:registEventHandler()
  if nil == Panel_SA_NakMessage then
    return
  end
  Panel_SA_NakMessage:RegisterUpdateFunc("NakMessageUpdate")
  registerEvent("onScreenResize", "FromClient_SA_NakMessage_ReSizePanel()")
  registerEvent("FromClient_RenderModeChangeState", "renderModeChange_NakMessagePostRestoreFunction")
  registerEvent("showMessage_ack", "Proc_ShowMessage_Ack_WithOut_ChattingMessage")
  registerEvent("showBigMessage_ack", "Proc_ShowBigMessage_Ack_WithOut_ChattingMessage")
  registerEvent("showMessage_FrameEvent", "Proc_ShowMessage_FrameEvent")
  registerEvent("onScreenResize", "FromClient_SA_NakMessage_ReSizePanel")
end
function PaGlobal_SA_NakMessage:prepareOpen()
  if nil == Panel_SA_NakMessage then
    return
  end
  PaGlobal_SA_NakMessage:open()
end
function PaGlobal_SA_NakMessage:open()
  if nil == Panel_SA_NakMessage then
    return
  end
  Panel_SA_NakMessage:SetShow(true)
end
function PaGlobal_SA_NakMessage:prepareClose()
  if nil == Panel_SA_NakMessage then
    return
  end
  PaGlobal_SA_NakMessage:close()
end
function PaGlobal_SA_NakMessage:close()
  if nil == Panel_SA_NakMessage then
    return
  end
  Panel_SA_NakMessage:SetShow(false)
end
function PaGlobal_SA_NakMessage:update()
  if nil == Panel_SA_NakMessage then
    return
  end
end
function PaGlobal_SA_NakMessage:validate()
  if nil == Panel_SA_NakMessage then
    return
  end
  self._ui.stc_messageBg:isValidate()
  self._ui.stc_messageIcon:isValidate()
  self._ui.txt_message:isValidate()
end
function PaGlobal_SA_NakMessage:messageOpen()
  Panel_SA_NakMessage:ResetVertexAni()
  local axisY = Panel_SA_NakMessage:GetSizeY() / 2
  local aniInfo = Panel_SA_NakMessage:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo1 = Panel_SA_NakMessage:addScaleAnimation(0, 3.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartScale(0.85)
  aniInfo1:SetEndScale(1)
  aniInfo1.AxisY = axisY
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_SA_NakMessage:addScaleAnimation(0.15, self._animationEndTime - 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_PI)
  aniInfo2:SetStartScale(1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisY = axisY
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  local aniInfo3 = Panel_SA_NakMessage:addColorAnimation(self._animationEndTime - 0.15, self._animationEndTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = Panel_SA_NakMessage:addScaleAnimation(self._animationEndTime - 0.15, self._animationEndTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartScale(1)
  aniInfo4:SetEndScale(0.7)
  aniInfo4.AxisY = axisY
  aniInfo4.ScaleType = 2
  aniInfo4.IsChangeChild = true
end
