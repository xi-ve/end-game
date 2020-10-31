function PaGlobal_SA_Window_WorldMap_Open()
  PaGlobal_SA_Window_WorldMap:prepareOpen()
end
function PaGlobal_SA_Window_WorldMap_Close()
  PaGlobal_SA_Window_WorldMap:prepareClose()
end
function FromClient_SA_Window_WorldMap_ReSizePanel()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  PaGlobal_SA_Window_WorldMap._ui.stc_blackBG:SetSize(screenSizeX, screenSizeY)
  PaGlobal_SA_Window_WorldMap._ui.stc_blackBG:ComputePos()
  PaGlobal_SA_Window_WorldMap._ui.stc_blackBG:SetShow(true)
end
function FromClinet_SA_Window_WorldMap_LostRegionInfo()
  PaGlobal_SA_Window_WorldMap._lostRegionInfo.isCallNextRegion = true
  PaGlobal_SA_Window_WorldMap:resizeMinimap(PaGlobal_SA_Window_WorldMap:getSizeScale())
  PaGlobal_SA_Window_WorldMap:updateCurrentLostRegionInfo(PaGlobal_SA_Window_WorldMap._lostRegionRefreshTime, true)
  PaGlobal_SA_Window_WorldMap:updateNextLostRegionInfo(false)
end
function FromClient_SA_Window_WorldMap_ResponseSendPositionGuide(PinInfo)
  if true == PinInfo._isPermanent then
    return
  end
  if false == PaGlobal_SA_Window_WorldMap.isShow then
    return
  end
  PaGlobal_SA_Window_WorldMap:addPing(PinInfo._position)
end
function PaGlobal_SA_Window_WorldMap_UpdatePerFrame(deltaTime)
  PaGlobal_SA_Window_WorldMap:updatePlayerPos(deltaTime, false)
  PaGlobal_SA_Window_WorldMap:updateCurrentLostRegionInfo(deltaTime, false)
  PaGlobal_SA_Window_WorldMap:updatePartyMember(deltaTime)
end
function PaGlobal_SA_Window_WorldMap_ShowAni()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
end
function PaGlobal_SA_Window_WorldMap_HideAni()
  if nil == Panel_SA_Window_WorldMap then
    return
  end
end
