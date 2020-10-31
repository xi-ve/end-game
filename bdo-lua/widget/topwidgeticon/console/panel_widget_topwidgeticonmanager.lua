TopWidgetIconType = {
  LandVehicle = 1,
  SeaVehicle = 2,
  Pet = 3,
  Garden = 4,
  Camp = 5,
  Fairy = 6,
  Summon = 7,
  Maid = 8,
  GuildServant = 9,
  Count = 10
}
local TopWidgetIconManager_info = {
  _pos = {
    sizeX = 60,
    sizeY = 60,
    spaceX = 14,
    startPosX = 20
  },
  _panelTable = {
    [TopWidgetIconType.LandVehicle] = Panel_Widget_Servant_Renew,
    [TopWidgetIconType.SeaVehicle] = Panel_Widget_Wharf_Renew,
    [TopWidgetIconType.Pet] = Panel_Widget_Pet_Renew,
    [TopWidgetIconType.Garden] = Panel_Widget_GardenIcon_Renew,
    [TopWidgetIconType.Camp] = Panel_Icon_Camp,
    [TopWidgetIconType.Fairy] = Panel_Widget_FairyIcon_Renew,
    [TopWidgetIconType.Summon] = Panel_Widget_SummonIcon_Renew,
    [TopWidgetIconType.Maid] = Panel_Widget_MaidIcon_Renew,
    [TopWidgetIconType.GuildServant] = Panel_Widget_GuildServantIcon_Renew
  },
  _openFunction = {
    [TopWidgetIconType.LandVehicle] = PaGlobalFunc_TopIcon_Servant_Open,
    [TopWidgetIconType.SeaVehicle] = PaGlobalFunc_TopIcon_Wharf_Open,
    [TopWidgetIconType.Pet] = PaGlobalFunc_TopIcon_Pet_Open,
    [TopWidgetIconType.Garden] = PaGlobal_TopIcon_Garden_Open,
    [TopWidgetIconType.Camp] = PaGlobalFunc_TopIcon_Camp_Open,
    [TopWidgetIconType.Fairy] = nil,
    [TopWidgetIconType.Summon] = PaGlobalFunc_TopIcon_Summon_Open,
    [TopWidgetIconType.Maid] = PaGlobalFunc_TopIcon_Maid_Open,
    [TopWidgetIconType.GuildServant] = nil
  },
  _closeFunction = {
    [TopWidgetIconType.LandVehicle] = PaGlobalFunc_TopIcon_Servant_Close,
    [TopWidgetIconType.SeaVehicle] = PaGlobalFunc_TopIcon_Wharf_Close,
    [TopWidgetIconType.Pet] = PaGlobalFunc_TopIcon_Pet_Close,
    [TopWidgetIconType.Garden] = PaGlobal_TopIcon_Garden_Close,
    [TopWidgetIconType.Camp] = PaGlobalFunc_TopIcon_Camp_Close,
    [TopWidgetIconType.Fairy] = nil,
    [TopWidgetIconType.Summon] = PaGlobalFunc_TopIcon_Summon_Close,
    [TopWidgetIconType.Maid] = PaGlobalFunc_TopIcon_Maid_Close,
    [TopWidgetIconType.GuildServant] = nil
  }
}
function PaGlobalFunc_TopIcon_GetPartyWidgetPosY()
  local self = TopWidgetIconManager_info
  local endPosY = self._panelTable[TopWidgetIconType.LandVehicle]:GetPosY() + self._panelTable[TopWidgetIconType.LandVehicle]:GetSizeY()
  return endPosY
end
function PaGlobalFunc_TopIcon_GetShowAllCheck()
  local self = TopWidgetIconManager_info
  local retval = false
  for key, value in pairs(self._panelTable) do
    if nil ~= value and true == value:GetShow() then
      retval = true
      break
    end
  end
  return retval
end
function PaGlobalFunc_TopIcon_UpdatePos()
  local self = TopWidgetIconManager_info
  local basePosX = (getOriginScreenSizeX() - getScreenSizeX()) / 2 + self._pos.startPosX
  for key, value in pairs(self._panelTable) do
    if nil ~= value and true == value:GetShow() then
      value:SetPosX(basePosX)
      basePosX = basePosX + self._pos.sizeX + self._pos.spaceX
    end
  end
end
function PaGlobalFunc_TopIcon_Show(IconType)
  local self = TopWidgetIconManager_info
  if nil == IconType or IconType >= TopWidgetIconType.Count then
    return
  end
  if nil == self._openFunction[IconType] then
    self._panelTable[IconType]:SetShow(true)
  else
    self._openFunction[IconType]()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobalFunc_Widget_Party_All_Resize()
  else
    FromClient_Party_Resize()
  end
end
function PaGlobalFunc_TopIcon_Exit(IconType)
  local self = TopWidgetIconManager_info
  if nil == IconType or IconType >= TopWidgetIconType.Count then
    return
  end
  if nil == self._closeFunction[IconType] then
    self._panelTable[IconType]:SetShow(false)
  else
    self._closeFunction[IconType]()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobalFunc_Widget_Party_All_Resize()
  else
    FromClient_Party_Resize()
  end
end
function FromClient_TopIcon_Inite()
  registerEvent("onScreenResize", "FromClient_TopIcon_Resize")
end
function FromClient_TopIcon_Resize()
  PaGlobalFunc_TopIcon_UpdatePos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_Inite")
