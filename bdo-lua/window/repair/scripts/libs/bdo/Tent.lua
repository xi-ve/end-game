Tent = {}

function Tent.hasInstalledTent()

	local code = 
	[[
		return ToClient_requestCheckHasServantCampingTent()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Tent.installTent()

	local code = 
	[[
		ToClient_requestServantUnsealCampingTent(0)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function Tent.remoteCollectTent()

	local code = 
	[[
		ToClient_requestServantCompulsionSealCampingTent()
	]]

	Infinity.BDO.Lua.Execute(code)
end