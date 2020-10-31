function PaGlobal_TopIcon_GuildServant:initialize()
  if true == PaGlobal_TopIcon_GuildServant._initialize then
    return
  end
  PaGlobal_TopIcon_GuildServant:registEventHandler()
  PaGlobal_TopIcon_GuildServant:checkCondition()
  PaGlobal_TopIcon_GuildServant:onScreenResize()
  PaGlobal_TopIcon_GuildServant._initialize = true
end
function PaGlobal_TopIcon_GuildServant:registEventHandler()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  registerEvent("FromClient_GuildServantListUpdate", "FromClient_TopIcon_GuildServant_Update")
  registerEvent("FromClient_ServantUnseal", "FromClient_TopIcon_GuildServant_Update")
  registerEvent("FromClient_ServantSeal", "FromClient_TopIcon_GuildServant_Update")
  registerEvent("onScreenResize", "FromClient_TopIcon_GuildServant_Resize")
end
function PaGlobal_TopIcon_GuildServant:open()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.GuildServant)
end
function PaGlobal_TopIcon_GuildServant:close()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.GuildServant)
end
function PaGlobal_TopIcon_GuildServant:checkCondition()
  if nil == Panel_Widget_GuildServantIcon_Renew then
    return
  end
  local guildServantCount = guildstable_getUnsealGuildServantCount()
  for index = 0, guildServantCount - 1 do
    local servantWrapper = guildStable_getUnsealGuildServantAt(index)
    local vehicleType = servantWrapper:getVehicleType()
    if CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_Train == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_SiegeTower == vehicleType or CppEnums.VehicleType.Type_LargeSiegeTower == vehicleType then
      PaGlobal_TopIcon_GuildServant:open()
      return
    end
  end
  PaGlobal_TopIcon_GuildServant:close()
end
function PaGlobal_TopIcon_GuildServant:onScreenResize()
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  Panel_Widget_GuildServantIcon_Renew:SetPosY(posY)
end
