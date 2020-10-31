local BA = {}

BA.enter = function()
	if not BA.isInside() then
		MagLib.logger.info("Entering BA!")
		Infinity.BDO.Lua.Execute("ToClient_JoinPvpBattleGround(0)")
		return true
	end

	return false
end

BA.exit = function()
	if BA.isInside() then
		MagLib.logger.info("Exiting BA!")
		Infinity.BDO.Lua.Execute("ToClient_UnJoinPvpBattleGround()")
		return true
	end
	return false
end

BA.isInside = function()
	return Infinity.BDO.Lua.Execute("return ToClient_IsJoinPvpBattleGround()")
end

MagLib.BDO.BattleArena = BA
