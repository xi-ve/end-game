local Fairy = {}

Fairy.getLevel = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_GetLevel()")
end

Fairy.getName = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_GetFairyName()")
end

Fairy.getTier = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_FairyTier()")
end

Fairy.getSkillCount = function()
	return Infinity.BDO.Lua.Execute("return PaGloblFunc_FairyInfo_GetFairySkillCount()")
end

Fairy.getUpgradeStack = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_getUpgradeStack()")
end

Fairy.isUnsealed = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_isUnseal()")
end

Fairy.isMaxTier = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyInfo_isMaxTier()")
end

Fairy.isMaxLevel = function()
	local fairyLevel = Fairy.getLevel()
	local fairyTier = Fairy.getTier()
	if fairyLevel >= (fairyTier + 1) * 10 then
		return true
	else
		return false
	end
end

Fairy.sealOrUnseal = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_ClickSummonButton()")
end

Fairy.lanternOnOff = function()
	return Infinity.BDO.Lua.Execute("return ToClient_RequestFairyLanterOnOff()")
end

Fairy.openGrowthUI = function()
	return Infinity.BDO.Lua.Execute("return PaGlobal_FairyUpgrade_Open(false)")
end

Fairy.upgrade = function(itemData)
	local code = [[
  local slotNo = ]] .. itemData.slot .. [[
  local itemWrapper = getInventoryItem(slotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  ToClient_FairyFeedingRequest(PaGlobal_FairyInfo_GetFairyNo(), itemWrapper:get():getKey(), slotNo, 1, false)
  ]]

	Infinity.BDO.Lua.Execute(code)
end

Fairy.canUseRespawn = function()
	return Infinity.BDO.Lua.Execute("return ToClient_Fairy_CanRespawn()")
end

MagLib.BDO.Fairy = Fairy
