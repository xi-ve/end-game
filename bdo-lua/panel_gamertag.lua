function PaGlobal_CheckGamerTag(isServerSelect)
  if not ToClient_isDataDownloadStart() then
    return
  end
  Panel_GamerTag:SetShow(true)
  local bg = UI.getChildControl(Panel_GamerTag, "Static_GameTagBG")
  local text = UI.getChildControl(bg, "StaticText_GameTagText")
  local GamerTagString = "Unknown"
  if true == ToClient_isPS4() then
    GamerTagString = ToClient_getSelfPlayerOnlineId()
  else
    GamerTagString = ToClient_XboxGamerTag()
  end
  text:SetText(GamerTagString)
  local percentText = UI.getChildControl(bg, "StaticText_GameTagPercentText")
  if false == ToClient_isDataDownloadComplete() then
    percentText:SetShow(true)
    text:ComputePos()
  else
    percentText:SetShow(false)
    text:SetPosY(bg:GetPosY() + bg:GetSizeY() / 2 - text:GetTextSizeY() / 2)
  end
  if true == _ContentsGroup_NewUI_ServerSelect_All then
    if true == isServerSelect then
      local getConsoleUIOffset = ToClient_GetConsoleUIOffset()
      local uiOffsetX = getOriginScreenSizeX() * getConsoleUIOffset
      local uiOffsetY = getOriginScreenSizeY() * getConsoleUIOffset
      Panel_GamerTag:SetHorizonRight()
      Panel_GamerTag:SetVerticalBottom()
      local spanX = Panel_GamerTag:GetSizeX() * 0.5 + PaGlobal_ServerSelect_All_GetBannerSizeX()
      local spanY = PaGlobal_ServerSelect_All_GetBannerSizeY() - 10
      if 0 < getConsoleUIOffset then
        spanX = spanX + uiOffsetX
        spanY = spanY + uiOffsetY
      end
      Panel_GamerTag:SetSpanSize(spanX, spanY)
    else
      Panel_GamerTag:ComputePos()
    end
  end
end
function FGlobal_DataInstallation_PerFrameUpdate()
  local bg = UI.getChildControl(Panel_GamerTag, "Static_GameTagBG")
  local percentText = UI.getChildControl(bg, "StaticText_GameTagPercentText")
  if true == ToClient_isDataDownloadComplete() or 100 <= ToClient_getDataDownloadProgress() then
    percentText:SetText("Installation Complete")
    return
  end
  percentText:SetText("Installation : " .. tostring(ToClient_getDataDownloadProgress()) .. "%")
end
Panel_GamerTag:RegisterUpdateFunc("FGlobal_DataInstallation_PerFrameUpdate")
