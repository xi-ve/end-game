function HandleEventLUp_FarmInfo_All_Close()
  PaGlobal_FarmInfo_All_Close()
end
function HandleEventOn_FarmInfo_All_Tooltip(eType)
  local control = PaGlobal_FarmInfo_All._ui._txt_tooltipTitles[eType]
  local name, desc
  if PaGlobal_FarmInfo_All._ePlantType.livestock == PaGlobal_FarmInfo_All._plantType then
    if PaGlobal_FarmInfo_All._eTooltipType.temperature == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_TEMPERATURE_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_TEMPERATURE_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.humidity == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HUMIDITY_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HUMIDITY_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.undergroundWater == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_UNDERGROUNDWATER_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_UNDERGROUNDWATER_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.compost == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_COMPOST_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_COMPOST_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.growing == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_GROWING_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_GROWING_DESC_2")
    elseif PaGlobal_FarmInfo_All._eTooltipType.helth == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HEALTH_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HEALTH_DESC_2")
    elseif PaGlobal_FarmInfo_All._eTooltipType.needWater == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_NEEDWATER_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_NEEDWATER_DESC_2")
    end
  elseif PaGlobal_FarmInfo_All._ePlantType.crops == PaGlobal_FarmInfo_All._plantType then
    if PaGlobal_FarmInfo_All._eTooltipType.temperature == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_TEMPERATURE_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_TEMPERATURE_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.humidity == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HUMIDITY_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HUMIDITY_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.undergroundWater == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_UNDERGROUNDWATER_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_UNDERGROUNDWATER_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.compost == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_COMPOST_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_COMPOST_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.growing == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_GROWING_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_GROWING_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.helth == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HEALTH_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_HEALTH_DESC")
    elseif PaGlobal_FarmInfo_All._eTooltipType.needWater == eType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_NEEDWATER_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_FARMINFO_NEEDWATER_DESC")
    end
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_FarmInfo_All_ShowAni()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
end
function PaGlobal_FarmInfo_All_HideAni()
  if nil == Panel_Housing_FarmInfo_All then
    return
  end
end
function FromClient_FarmInfo_All_InterActionHarvestInformation(actorKeyRaw)
  PaGlobal_FarmInfo_All:prepareOpen(PaGlobal_FarmInfo_All._ePopupType.interaction, actorKeyRaw)
end
function FromClient_FarmInfo_All_UpdatePerFrame(deltaTime)
  PaGlobal_FarmInfo_All:updateCursor()
end
function PaGlobal_FarmInfo_All_InstallModeOpen()
  PaGlobal_FarmInfo_All:prepareOpen(PaGlobal_FarmInfo_All._ePopupType.installation)
end
function PaGlobal_FarmInfo_All_Close()
  PaGlobal_FarmInfo_All:prepareClose()
end
function PaGlobal_FarmInfo_All_GetShowPanel()
  if nil == Panel_Housing_FarmInfo_All then
    return false
  end
  return Panel_Housing_FarmInfo_All:GetShow()
end
