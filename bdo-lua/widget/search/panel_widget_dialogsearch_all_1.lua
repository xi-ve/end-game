function PaGlobal_DialogSearch_All:initialize()
  if true == PaGlobal_DialogSearch_All._initialize or nil == Panel_Widget_Dialog_Search_All then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Widget_Dialog_Search_All, "StaticText_Title")
  self._ui._stc_bottomBg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_BottomDescBG")
  self._ui._txt_bottomDesc = UI.getChildControl(self._ui._stc_bottomBg, "StaticText_Desc")
  self._ui._plus.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Plus")
  self._ui._up.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Up")
  self._ui._minus.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Minus")
  self._ui._left.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Left")
  self._ui._down.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Down")
  self._ui._right.bg = UI.getChildControl(Panel_Widget_Dialog_Search_All, "Static_Right")
  self._ui._plus.icon = UI.getChildControl(self._ui._plus.bg, "Static_Icon")
  self._ui._up.icon = UI.getChildControl(self._ui._up.bg, "Static_Icon")
  self._ui._minus.icon = UI.getChildControl(self._ui._minus.bg, "Static_Icon")
  self._ui._left.icon = UI.getChildControl(self._ui._left.bg, "Static_Icon")
  self._ui._down.icon = UI.getChildControl(self._ui._down.bg, "Static_Icon")
  self._ui._right.icon = UI.getChildControl(self._ui._right.bg, "Static_Icon")
  self._ui._plus.txt = UI.getChildControl(self._ui._plus.bg, "StaticText_Plus")
  self._ui._up.txt = UI.getChildControl(self._ui._up.bg, "StaticText_Up")
  self._ui._minus.txt = UI.getChildControl(self._ui._minus.bg, "StaticText_Minus")
  self._ui._left.txt = UI.getChildControl(self._ui._left.bg, "StaticText_Left")
  self._ui._down.txt = UI.getChildControl(self._ui._down.bg, "StaticText_Down")
  self._ui._right.txt = UI.getChildControl(self._ui._right.bg, "StaticText_Right")
  local keyIndexSet = {
    button_Q = 12,
    button_W = 0,
    button_A = 2,
    button_S = 1,
    button_D = 3,
    button_E = 13
  }
  self._ui._plus.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_Q))
  self._ui._up.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_W))
  self._ui._minus.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_E))
  self._ui._left.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_A))
  self._ui._down.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_S))
  self._ui._right.txt:SetText(keyCustom_GetString_ActionKey(keyIndexSet.button_D))
  local gabY = 5
  local descSizeY = self._ui._txt_bottomDesc:GetSizeY()
  self._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEARCH_BOTTOMDESC"))
  local textSizeY = self._ui._txt_bottomDesc:GetTextSizeY() + gabY
  if descSizeY < textSizeY + gabY then
    local addedSizeY = textSizeY + gabY - descSizeY
    self._ui._txt_bottomDesc:SetSize(self._ui._txt_bottomDesc:GetSizeX(), self._ui._txt_bottomDesc:GetSizeY() + addedSizeY)
    self._ui._stc_bottomBg:SetSize(self._ui._stc_bottomBg:GetSizeX(), self._ui._stc_bottomBg:GetSizeY() + addedSizeY)
    self._ui._stc_bottomBg:SetSpanSize(self._ui._stc_bottomBg:GetSpanSize().x, self._ui._stc_bottomBg:GetSpanSize().y - addedSizeY)
    self._ui._stc_bottomBg:ComputePos()
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._isSearchMode = false
  PaGlobal_DialogSearch_All:validate()
  PaGlobal_DialogSearch_All:registEventHandler()
  PaGlobal_DialogSearch_All._initialize = true
end
function PaGlobal_DialogSearch_All:registEventHandler()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_DialogSearch_All_OnScreenResize")
  registerEvent("EventQuestSearch", "PaGlobalFunc_DialogSearch_All_Open")
  self._ui._plus.bg:addInputEvent("Mouse_LPress", "searchView_ZoomIn()")
  self._ui._minus.bg:addInputEvent("Mouse_LPress", "searchView_ZoomOut()")
  self._ui._up.bg:addInputEvent("Mouse_LPress", "searchView_PushTop()")
  self._ui._left.bg:addInputEvent("Mouse_LPress", "searchView_PushLeft()")
  self._ui._down.bg:addInputEvent("Mouse_LPress", "searchView_PushBottom()")
  self._ui._right.bg:addInputEvent("Mouse_LPress", "searchView_PushRight()")
end
function PaGlobal_DialogSearch_All:prepareOpen()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  self._variable.currentNpcCharacterKey = dialog_getTalkNpcKey()
  if 0 == self._variable.currentNpcCharacterKey then
    return
  end
  if true == self:checkClearSearchQuest(self._variable.currentNpcCharacterKey) then
    return
  end
  if false == _ContentsGroup_RenewUI_SearchMode then
    PaGlobal_DialogSearch_All:open()
  else
    PaGlobalFunc_ConsoleKeyGuide_SetPos()
  end
  PaGlobal_DialogSearch_All:update()
  PaGlobalFunc_DialogSearch_All_OnScreenResize()
end
function PaGlobal_DialogSearch_All:update()
  self._searchClearQuest[self._variable.currentNpcCharacterKey] = nil
  self._isSearchMode = true
  self._isShowSearchObject = false
  setCutSceneCameraEditMode(true)
  openClientChangeScene(self._variable.currentNpcCharacterKey, 1)
  self._moveCameraDistance = search_initCameraDistance()
  self._findCameraDistance = search_conditionDistance()
  self._findCameraAngle = search_conditionAngle()
  self._moveAbleAngleUp = search_getMoveAbleAngleUp()
  self._moveAbleAngleDown = search_getMoveAbleAngleDown()
  if true == _ContentsGroup_RenewUI_SearchMode then
    ToClient_padSnapResetControl()
    PaGlobalFunc_ConsoleKeyGuide_SetGuide(0)
  end
end
function PaGlobal_DialogSearch_All:dataclear()
  self._isSearchMode = false
  self._additionYaw = 0
  self._additionPitch = 0
  self._moveAbleAngleUp = 60
  self._moveAbleAngleDown = -40
  search_additionYaw2(self._additionYaw)
  search_additionPitch2(self._additionPitch)
  setCutSceneCameraEditMode(false)
end
function PaGlobal_DialogSearch_All:open()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  Panel_Widget_Dialog_Search_All:SetShow(true)
end
function PaGlobal_DialogSearch_All:prepareClose()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  PaGlobal_DialogSearch_All:dataclear()
  if false == _ContentsGroup_RenewUI_SearchMode then
    PaGlobal_DialogSearch_All:close()
  else
    PaGlobalFunc_ConsoleKeyGuide_SetState(nil)
    PaGlobalFunc_ConsoleKeyGuide_SetPos()
    ToClient_padSnapResetControl()
    PaGlobalFunc_ConsoleKeyGuide_PopGuide()
  end
end
function PaGlobal_DialogSearch_All:close()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  Panel_Widget_Dialog_Search_All:SetShow(false)
end
function PaGlobal_DialogSearch_All:validate()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._stc_bottomBg:isValidate()
  self._ui._txt_bottomDesc:isValidate()
  self._ui._plus.bg:isValidate()
  self._ui._up.bg:isValidate()
  self._ui._minus.bg:isValidate()
  self._ui._left.bg:isValidate()
  self._ui._down.bg:isValidate()
  self._ui._right.bg:isValidate()
  self._ui._plus.icon:isValidate()
  self._ui._up.icon:isValidate()
  self._ui._minus.icon:isValidate()
  self._ui._left.icon:isValidate()
  self._ui._down.icon:isValidate()
  self._ui._right.icon:isValidate()
  self._ui._plus.txt:isValidate()
  self._ui._up.txt:isValidate()
  self._ui._minus.txt:isValidate()
  self._ui._left.txt:isValidate()
  self._ui._down.txt:isValidate()
  self._ui._right.txt:isValidate()
end
function PaGlobal_DialogSearch_All:resize()
  if nil == Panel_Widget_Dialog_Search_All then
    return
  end
  Panel_Widget_Dialog_Search_All:ComputePos()
  self._ui._txt_title:ComputePos()
  self._ui._stc_bottomBg:ComputePos()
  self._ui._txt_bottomDesc:ComputePos()
  self._ui._plus.bg:ComputePos()
  self._ui._up.bg:ComputePos()
  self._ui._minus.bg:ComputePos()
  self._ui._left.bg:ComputePos()
  self._ui._down.bg:ComputePos()
  self._ui._right.bg:ComputePos()
  self._ui._plus.icon:ComputePos()
  self._ui._up.icon:ComputePos()
  self._ui._minus.icon:ComputePos()
  self._ui._left.icon:ComputePos()
  self._ui._down.icon:ComputePos()
  self._ui._right.icon:ComputePos()
  self._ui._plus.txt:ComputePos()
  self._ui._up.txt:ComputePos()
  self._ui._minus.txt:ComputePos()
  self._ui._left.txt:ComputePos()
  self._ui._down.txt:ComputePos()
  self._ui._right.txt:ComputePos()
end
function PaGlobal_DialogSearch_All:checkClearSearchQuest(npcCharacterKey)
  if nil == PaGlobal_DialogSearch_All._searchClearQuest[npcCharacterKey] then
    return false
  end
  local count = questList_getCheckedProgressQuestCount()
  for index = 0, count - 1 do
    local questData = questList_getCheckedProgressQuestAt(index)
    local result = questData:getDetectConditionByCharacterKey(npcCharacterKey)
    if true == result then
      return false
    end
  end
  return true
end
function PaGlobal_DialogSearch_All:checkSearchObject()
  if true == self:checkClearSearchQuest(self._variable.currentNpcCharacterKey) then
    return
  end
  if self._findCameraDistance < self._moveCameraDistance then
    if true == self._isShowSearchObject then
      self._isShowSearchObject = false
      showSceneCharacter(1, false)
    end
    return
  end
  local curCameraPosition = getCameraPosition()
  local objectPos = getSceneCharacterSpawnPosition(1)
  local objectLookPos = search_getObjectLookPos()
  local objectToDir = Util.Math.calculateDirection(objectPos, objectLookPos)
  local cameraToObjectDir = Util.Math.calculateDirection(objectPos, curCameraPosition)
  local calcDot = Util.Math.calculateDot(cameraToObjectDir, objectToDir)
  local angle = math.acos(calcDot)
  local toDegree = angle * 180 / math.pi
  if toDegree < self._findCameraAngle then
    if false == self._isShowSearchObject then
      showSceneCharacter(1, true)
      self._isShowSearchObject = true
      if false == self:checkClearSearchQuest(self._variable.currentNpcCharacterKey) then
        self._searchClearQuest[self._variable.currentNpcCharacterKey] = true
        click_DialogSearchObject()
        ReqeustDialog_retryTalk()
        PaGlobalFunc_DialogSearch_All_Close()
      end
    end
  elseif true == self._isShowSearchObject then
    self._isShowSearchObject = false
    showSceneCharacter(1, false)
  end
end
function PaGlobal_DialogSearch_All:isMoveAbleAngle()
  local curCameraPosition = getCameraPosition()
  local objectPos = getSceneCharacterSpawnPosition(1)
  local objectLookPos = search_getObjectLookPos()
  local noYObjectPos = float3(objectPos.x, 0, objectPos.z)
  local noYCurCameraPos = float3(curCameraPosition.x, 0, curCameraPosition.z)
  local noYObjectToCameraDir = Util.Math.calculateDirection(noYObjectPos, noYCurCameraPos)
  local ObjectTocameraDir = Util.Math.calculateDirection(objectPos, curCameraPosition)
  local normalaCalc = Util.Math.calculateDot(ObjectTocameraDir, noYObjectToCameraDir)
  local normalAngle = math.acos(normalaCalc)
  local normalToDegree = normalAngle * 180 / math.pi
  if curCameraPosition.y < objectPos.y then
    normalToDegree = -normalToDegree
  end
  return normalToDegree
end
