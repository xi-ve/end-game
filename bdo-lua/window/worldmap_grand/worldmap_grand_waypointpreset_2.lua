function PaGlobal_Worldmap_Grand_WaypointPreset_Open()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointPreset:prepareOpen()
end
function PaGlobal_Worldmap_Grand_WaypointPreset_Close()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_Worldmap_Grand_WaypointPreset:prepareClose()
  end
end
function PaGlobal_Worldmap_Grand_WaypointPreset_Update()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointPreset:update()
end
function HandleEventLUp_Worldmap_Grand_WaypointPreset_Waypoint(idx)
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointPreset._targetIdx = idx
end
function HandleEventLUp_Worldmap_Grand_WaypointPreset_Apply()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  local self = PaGlobal_Worldmap_Grand_WaypointPreset
  local targetIdx = self._targetIdx
  if nil == targetIdx then
    return
  end
  self._ui._waypointBtn[targetIdx]:SetMonoTone(false)
  self._ui._waypointBtn[targetIdx]:SetIgnore(false)
  ToClient_ApplyWorldMapNaviGuidePath(targetIdx - 1)
end
function HandleEventLUp_Worldmap_Grand_WaypointPreset_Delete()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  local self = PaGlobal_Worldmap_Grand_WaypointPreset
  local targetIdx = self._targetIdx
  if nil == targetIdx then
    return
  end
  self._ui._waypointBtn[targetIdx]:SetMonoTone(true)
  self._ui._waypointBtn[targetIdx]:SetIgnore(true)
  self._ui._waypointBtn[targetIdx]:SetCheck(false)
  ToClient_RemoveWorldMapNaviGuidePath(targetIdx - 1)
  self._targetIdx = nil
end
function HandleEventLUp_Worldmap_Grand_WaypointPreset_Close()
  if nil == PaGlobal_Worldmap_Grand_WaypointPreset then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointPreset_Close()
end
