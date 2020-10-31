function FromClient_resetCoherentUIForMusicShare()
  if nil == Panel_Window_MusicShare_All or false == Panel_Window_MusicShare_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_MusicShare_All_Close()
end
function FromClient_MusicShare_UploadMusic(title, defaultName, paramList)
  local paramCount = 0
  local subNameStringBDC = ""
  local myUserNo = getSelfPlayer():get():getUserNo()
  local isEmpty = false
  local isEditable = true
  for key, value in pairs(paramList) do
    isEmpty = true
    if ".bdom" ~= string.sub(value, 1, 5) then
      return
    end
    if "_0" == string.sub(value, 6, 7) then
      isEditable = false
    elseif "_1" == string.sub(value, 6, 7) then
      isEditable = true
    end
    subNameStringBDC = string.sub(value, 5, -2)
    if "" == subNameStringBDC then
      subNameStringBDC = "_"
    end
    paramCount = paramCount + 1
    if 1 < paramCount then
      return
    end
  end
  if true == isEmpty then
    ToClient_RequestUploadAlbum(PaGlobal_MusicShare_All._musicIndex, isEditable)
  end
end
function PaGloabal_MusicShare_All_ShowAni()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Window_MusicShare_All)
  local aniInfo1 = Panel_Window_MusicShare_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_MusicShare_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_MusicShare_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_MusicShare_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_MusicShare_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_MusicShare_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_MusicShare_All_HideAni()
  if nil == Panel_Window_MusicShare_All then
    return
  end
  Panel_Window_MusicShare_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_MusicShare_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_MusicShare_All_Close()
  PaGlobal_MusicShare_All:prepareClose()
  PaGlobal_MusicBoard_All_Open()
end
function PaGlobal_MusicShare_All_Open(musicIndex)
  PaGlobal_MusicShare_All:prepareOpen(musicIndex)
  PaGlobal_MusicAlbum_All_Close()
  PaGlobal_MusicBoard_All_Close()
end
