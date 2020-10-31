function PaGlobalFunc_DialogSearch_All_Open()
  PaGlobal_DialogSearch_All:prepareOpen()
end
function PaGlobalFunc_DialogSearch_All_Close()
  PaGlobal_DialogSearch_All:prepareClose()
end
function PaGlobalFunc_DialogSearch_All_OnScreenResize()
  PaGlobal_DialogSearch_All:resize()
end
function HandleEventLUp_DialogSearch_All_Close()
  PaGlobalFunc_DialogSearch_All_Close()
end
function PaGlobalFunc_SearchMode_IsSearchMode()
  return PaGlobal_DialogSearch_All._isSearchMode
end
function searchView_PushLeft()
  PaGlobal_DialogSearch_All._variable.directionIndex = 0
  local normalToDegree = PaGlobal_DialogSearch_All:isMoveAbleAngle()
  PaGlobal_DialogSearch_All._additionYaw = PaGlobal_DialogSearch_All._additionYaw + PaGlobal_DialogSearch_All._ptichValue
  search_additionYaw2(PaGlobal_DialogSearch_All._additionYaw)
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_PushTop()
  PaGlobal_DialogSearch_All._variable.directionIndex = 1
  local normalToDegree = PaGlobal_DialogSearch_All:isMoveAbleAngle()
  if normalToDegree < PaGlobal_DialogSearch_All._moveAbleAngleUp then
    if normalToDegree > PaGlobal_DialogSearch_All._moveAbleAngleUp then
      return
    end
    PaGlobal_DialogSearch_All._additionPitch = PaGlobal_DialogSearch_All._additionPitch - PaGlobal_DialogSearch_All._yawValue
    search_additionPitch2(PaGlobal_DialogSearch_All._additionPitch)
  end
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_PushRight()
  PaGlobal_DialogSearch_All._variable.directionIndex = 2
  local normalToDegree = PaGlobal_DialogSearch_All:isMoveAbleAngle()
  PaGlobal_DialogSearch_All._additionYaw = PaGlobal_DialogSearch_All._additionYaw - PaGlobal_DialogSearch_All._ptichValue
  search_additionYaw2(PaGlobal_DialogSearch_All._additionYaw)
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_PushBottom()
  PaGlobal_DialogSearch_All._variable.directionIndex = 3
  local normalToDegree = PaGlobal_DialogSearch_All:isMoveAbleAngle()
  if normalToDegree > PaGlobal_DialogSearch_All._moveAbleAngleDown + 5 then
    if normalToDegree < PaGlobal_DialogSearch_All._moveAbleAngleDown then
      return
    end
    PaGlobal_DialogSearch_All._additionPitch = PaGlobal_DialogSearch_All._additionPitch + PaGlobal_DialogSearch_All._yawValue
    search_additionPitch2(PaGlobal_DialogSearch_All._additionPitch)
  end
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_Detail()
  PaGlobal_DialogSearch_All._moveCameraDistance = PaGlobal_DialogSearch_All._moveCameraDistance - 10
  search_LookAtPosDistance(PaGlobal_DialogSearch_All._moveCameraDistance)
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_ZoomIn()
  if PaGlobal_DialogSearch_All._moveCameraDistance > 300 then
    PaGlobal_DialogSearch_All._moveCameraDistance = PaGlobal_DialogSearch_All._moveCameraDistance - 10
    search_LookAtPosDistance(PaGlobal_DialogSearch_All._moveCameraDistance)
  end
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_ZoomOut()
  if PaGlobal_DialogSearch_All._moveCameraDistance < 1200 then
    PaGlobal_DialogSearch_All._moveCameraDistance = PaGlobal_DialogSearch_All._moveCameraDistance + 10
    search_LookAtPosDistance(PaGlobal_DialogSearch_All._moveCameraDistance)
  end
  PaGlobal_DialogSearch_All:checkSearchObject()
end
function searchView_CheckDistance()
end
