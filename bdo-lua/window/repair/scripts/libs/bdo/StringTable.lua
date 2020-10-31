StringTable = {}
--[[StringTable.Table0_HashKey = Infinity.BDO.StringTable.getTableHashKey()
StringTable.Table0_StringKey = Infinity.BDO.StringTable.getTableStringKey()

function StringTable.getString(hash)
	return StringTable.Table0_HashKey[hash]
end

function StringTable.getHash(string)
	return StringTable.Table0_StringKey[string]
end]]--