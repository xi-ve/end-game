function PaGlobalFunc_SeasonBanner_Open()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  PaGlobal_SeasonBanner:prepareOpen()
end
function PaGlobalFunc_SeasonBanner_Close()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  PaGlobal_SeasonBanner:prepareClose()
end
function PaGlobalFunc_SeasonBanner_OnScreenResize()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_Window_SeasonBanner:SetSize(screenSizeX, screenSizeY)
  PaGlobal_SeasonBanner._ui.stc_blackBG:SetSize(screenSizeX, screenSizeY)
  Panel_Window_SeasonBanner:ComputePosAllChild()
end
function PaGlobalFunc_SeasonBanner_SpaceKeyInput()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  if PaGlobal_SeasonBanner._endPageNo == PaGlobal_SeasonBanner._currentPageNo then
    HandleEventLUp_SeasonBanner_SetSeasonCharacter()
  else
    HandleEventLUp_SeasonBanner_ChangePage(true)
  end
end
function HandleEventLUp_SeasonBanner_ChangePage(nextPage)
  if nil == Panel_Window_SeasonBanner then
    return
  end
  PaGlobal_SeasonBanner:changePage(nextPage)
end
function HandleEventLUp_SeasonBanner_SetSeasonCharacter()
  if nil == Panel_Window_SeasonBanner then
    return
  end
  if nil ~= PaGlobalFunc_Customization_SetSeasonCharacter then
    PaGlobalFunc_Customization_SetSeasonCharacter()
  end
  PaGlobalFunc_SeasonBanner_Close()
end
