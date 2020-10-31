function FromClient_resetCoherentUIForComposition()
  if nil == Panel_Window_Composition_All or false == Panel_Window_Composition_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_Composition_All_Close()
end
function FromClient_OpenMusicListLocalRepository()
  PaGlobal_Composition_All_Close()
  PaGlobal_MusicBoard_All_Open()
end
function PaGlobal_Composition_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_Composition_All then
    return
  end
  PaGlobal_Composition_All._updateTempSaveTime = PaGlobal_Composition_All._updateTempSaveTime + deltaTime
  if PaGlobal_Composition_All._tempSaveTimer < PaGlobal_Composition_All._updateTempSaveTime then
    PaGlobal_Composition_All._ui._webControl:TriggerEvent("FromClient_TemporarySave", "")
    PaGlobal_Composition_All._updateTempSaveTime = 0
  end
end
function PaGloabal_Composition_All_ShowAni()
  if nil == Panel_Window_Composition_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_Composition_All)
  local aniInfo1 = Panel_Window_Composition_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_Composition_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Composition_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_Composition_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Composition_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Composition_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_Composition_All_HideAni()
  if nil == Panel_Window_Composition_All then
    return
  end
  Panel_Window_Composition_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_Composition_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_Composition_All_Close()
  PaGlobal_Composition_All:prepareClose()
  PaGlobal_MusicBoard_All_Open()
end
function PaGlobal_Composition_All_Open()
  PaGlobal_Composition_All:prepareOpen()
  PaGlobal_MusicBoard_All_Close()
end
function PaGlobal_Composition_All_OpenForEdit(musicIndex)
  PaGlobal_Composition_All:prepareOpen(musicIndex)
end
