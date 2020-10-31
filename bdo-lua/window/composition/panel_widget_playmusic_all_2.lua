function PaGlobal_PlayMusic_All_IsShow()
  if nil == Panel_Widget_PlayMusic_All then
    return false
  end
  return Panel_Widget_PlayMusic_All:GetShow()
end
function PaGlobal_PlayMusic_All_StopMusic()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  ToClient_StopMusic(true)
end
function FromClient_PlayMusic_Stop()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  PaGlobal_PlayMusic_All_Close()
end
function FromClient_PlayMusic_Start()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  PaGlobal_PlayMusic_All_Open()
  PaGlobal_MusicSetting_All_CloseForPlayMusic()
  PaGlobal_MusicBoard_All_CloseForPlayMusic()
end
function FromClient_PlayMusic_Close()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  PaGlobal_MusicSetting_All_CloseForPlayMusic()
end
function FromClient_IncreaseExp()
end
function PaGlobal_PlayMusic_All_ShowBubbleBox()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  PaGlobal_PlayMusic_All._ui._static_bubbleBox:SetShow(true)
end
function PaGlobal_PlayMusic_All_HideBubbleBox()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  PaGlobal_PlayMusic_All._ui._static_bubbleBox:SetShow(false)
end
function PaGlobal_PlayMusic_All_ShowAni()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Widget_PlayMusic_All)
  local aniInfo1 = Panel_Widget_PlayMusic_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Widget_PlayMusic_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Widget_PlayMusic_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Widget_PlayMusic_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Widget_PlayMusic_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Widget_PlayMusic_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_PlayMusic_All_HideAni()
  if nil == Panel_Widget_PlayMusic_All then
    return
  end
  Panel_Widget_PlayMusic_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Widget_PlayMusic_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_PlayMusic_All_Close()
  PaGlobal_PlayMusic_All:prepareClose()
end
function PaGlobal_PlayMusic_All_Open()
  PaGlobal_PlayMusic_All:prepareOpen()
end
