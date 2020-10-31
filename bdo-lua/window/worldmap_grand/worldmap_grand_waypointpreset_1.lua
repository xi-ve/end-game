function PaGlobal_Worldmap_Grand_WaypointPreset:initialize()
  if nil == Panel_Worldmap_WaypointPreset then
    return
  end
  if true == self._initialize then
    return
  end
  for idx = 1, self._maxCount do
    self._ui._waypointBtn[idx] = UI.getChildControl(Panel_Worldmap_WaypointPreset, "RadioButton_Saved_" .. tostring(idx))
  end
  self._ui._applyBtn = UI.getChildControl(Panel_Worldmap_WaypointPreset, "Button_Apply")
  self._ui._deleteBtn = UI.getChildControl(Panel_Worldmap_WaypointPreset, "Button_Delete")
  self._ui._closeBtn = UI.getChildControl(Panel_Worldmap_WaypointPreset, "Button_Close")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Worldmap_Grand_WaypointPreset:registEventHandler()
  if nil == Panel_Worldmap_WaypointPreset then
    return
  end
  for idx = 1, self._maxCount do
    self._ui._waypointBtn[idx]:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointPreset_Waypoint(" .. tostring(idx) .. ")")
  end
  self._ui._applyBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointPreset_Apply()")
  self._ui._deleteBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointPreset_Delete()")
  self._ui._closeBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Worldmap_Grand_WaypointPreset_Close()")
end
function PaGlobal_Worldmap_Grand_WaypointPreset:validate()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  for idx = 1, self._maxCount do
    self._ui._waypointBtn[idx]:isValidate()
  end
  self._ui._applyBtn:isValidate()
  self._ui._deleteBtn:isValidate()
  self._ui._closeBtn:isValidate()
end
function PaGlobal_Worldmap_Grand_WaypointPreset:prepareOpen()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  for idx = 1, self._maxCount do
    self._ui._waypointBtn[idx]:SetCheck(false)
  end
  self:update()
  self:open()
end
function PaGlobal_Worldmap_Grand_WaypointPreset:open()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  Panel_Worldmap_WaypointPreset:SetShow(true)
  if nil == Panel_NaviButton then
    return
  end
  Panel_NaviButton:SetShow(false)
end
function PaGlobal_Worldmap_Grand_WaypointPreset:prepareClose()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  self:close()
end
function PaGlobal_Worldmap_Grand_WaypointPreset:close()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  WorldMapPopupManager:pop()
  Panel_Worldmap_WaypointPreset:SetShow(false)
end
function PaGlobal_Worldmap_Grand_WaypointPreset:update()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  for idx = 1, self._maxCount do
    local isExist = ToClient_IsExistWorldMapNaviGuidePath(idx - 1)
    if true == isExist then
      self._ui._waypointBtn[idx]:SetMonoTone(false)
      self._ui._waypointBtn[idx]:SetIgnore(false)
    else
      self._ui._waypointBtn[idx]:SetMonoTone(true)
      self._ui._waypointBtn[idx]:SetIgnore(true)
    end
  end
end
