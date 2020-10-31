function PaGlobal_Worldmap_Grand_WaypointOption_Open()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption:prepareOpen()
end
function PaGlobal_Worldmap_Grand_WaypointOption_Apply()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption:apply()
end
function PaGlobal_Worldmap_Grand_WaypointOption_Close()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  else
    PaGlobal_Worldmap_Grand_WaypointOption:prepareClose()
  end
end
function PaGlobal_Worldmap_Grand_WaypointOption_Update()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption:update()
end
function PaGlobal_Worldmap_Grand_WaypointTypeOption_SetOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption:setTypeOption(option)
end
function PaGlobal_Worldmap_Grand_WaypointStyleOption_SetOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption:setStyleOption(option)
end
function HandleEventLUp_Worldmap_Grand_WaypointOption_Apply()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption_Apply()
  PaGlobal_Worldmap_Grand_WaypointOption_Close()
end
function HandleEventLUp_Worldmap_Grand_WaypointOption_Close()
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointOption_Close()
end
function HandleEventLUp_Worldmap_Grand_WaypointTypeOption_SetOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointTypeOption_SetOption(option)
end
function HandleEventLUp_Worldmap_Grand_WaypointStyleOption_SetOption(option)
  if nil == PaGlobal_Worldmap_Grand_WaypointOption then
    return
  end
  PaGlobal_Worldmap_Grand_WaypointStyleOption_SetOption(option)
end
