local Respawn = {}
Respawn.Types = {
	None = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_None",
	Immediate = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Immediate",
	ByOtherPlayer = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_ByOtherPlayer",
	Exploration = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Exploration",
	NearTown = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_NearTown",
	TimeOver = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_TimeOver",
	InSiegeingFortress = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_InSiegeingFortress",
	LocalWar = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_LocalWar",
	AdvancedBase = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_AdvancedBase",
	GuildSpawn = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildSpawn",
	Competition = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Competition",
	SavageDefence = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_SavageDefence",
	Volunteer = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Volunteer",
	GuildBatle = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildBatle",
	Plunder = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Plunder",
	GuildTeamBattle = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_GuildTeamBattle",
	OutsideGate = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_OutsideGate",
	InsideGate = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_InsideGate",
	Count = "PaGlobal_DeadMessage_All._eRespawnType.respawnType_Count"
}

local Types = Respawn.Types

local getCashRespawnItemSlot = function()
	local code = [[
    local tmp = nil
    for itemSlot = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
      tmp = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, itemSlot)
      if tmp then
        return itemSlot
      end
    end
    return -1
  ]]

	return Infinity.BDO.Lua.Execute(code)
end

Respawn.respawn = function(type, fromPvp, useFairy)
	if not fromPvp then
		fromPvp = false
	end

	if MagLib.BDO.Actors.LocalPlayer.get():getIsDead() then
		local itemSlot, itemWhereType
		local regionKey = Infinity.BDO.Lua.Execute("return getSelfPlayer():getRegionKey()")
		if type == Types.Exploration or type == Types.NearTown then
			itemSlot = 255
			itemWhereType = 0
		elseif type == Types.Immediate then
			if useFairy then
				itemSlot = 0
			else
				local respawnItemSlot = getCashRespawnItemSlot()
				if respawnItemSlot == -1 then
					print("No Respawn Item found!")
					return false
				end
				itemSlot = respawnItemSlot
			end
			itemWhereType = "CppEnums.ItemWhereType.eCashInventory"
		end
		-- MagLib.logger.info("Reviving...")
		local code = "deadMessage_Revival(" .. type .. ", " .. itemSlot .. ", " .. itemWhereType ..
             			", getSelfPlayer():getRegionKey(), " .. tostring(fromPvp) .. ", toInt64(0, 0), " .. tostring(useFairy) ..
             			") \n"
		code = code .. "SetUIMode(Defines.UIMode.eUIMode_Default)"
		print(code)
		Infinity.BDO.Lua.Execute(code)
		return true
	else
		print("You cannot respawn! You are not dead!")
		return false
	end
end

MagLib.BDO.Respawn = Respawn
