function FromClient_resetCoherentUIForMusicAlbum()
  if nil == Panel_Window_MusicAlbum_All or false == Panel_Window_MusicAlbum_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_MusicAlbum_All_Close()
end
function FromClient_MusicAlbum_loadMusic(path, filename)
  local isPlayOnly = false
  if nil ~= string.find(filename, ".bdom", -5) then
    isPlayOnly = false
  elseif nil ~= string.find(filename, ".bdmt", -5) then
    isPlayOnly = true
  else
    return
  end
  ToClient_RequestDownloadMusic(path, filename, isPlayOnly)
end
function PaGloabal_MusicAlbum_All_ShowAni()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_MusicAlbum_All)
  local aniInfo1 = Panel_Window_MusicAlbum_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MusicAlbum_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MusicAlbum_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MusicAlbum_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MusicAlbum_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MusicAlbum_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_MusicAlbum_All_HideAni()
  if nil == Panel_Window_MusicAlbum_All then
    return
  end
  Panel_Window_MusicAlbum_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_MusicAlbum_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_MusicAlbum_All_Close()
  PaGlobal_MusicAlbum_All:prepareClose()
end
function PaGlobal_MusicAlbum_All_Open()
  PaGlobal_MusicAlbum_All:prepareOpen()
  PaGlobal_MusicShare_All_Close()
  PaGlobal_MusicBoard_All_Close()
end
