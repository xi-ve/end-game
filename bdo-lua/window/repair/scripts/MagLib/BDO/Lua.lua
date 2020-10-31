local Lua = {}

Lua.printMetatableKeys = function(codeToGetTable)
	local code = [[
      local function getTable()
        ]] .. codeToGetTable .. [[
end
local metatable = getmetatable(getTable())
local returnString = ""
for k, v in pairs(metatable) do
  returnString = returnString .. k .. "|"
end
return returnString
]]
	local metatableKeysAsString = Infinity.BDO.Lua.Execute(code)
	local metatableKeys = MagLib.Utils.Strings.split(metatableKeysAsString, "|")
	table.print(metatableKeys)
end

Lua.getEnum = function(key)
	local code = [[
        local keyValue = {}
        for key, value in pairs(]] .. tostring(key) .. [[) do
            table.insert(keyValue, key)
            table.insert(keyValue, value)
        end

        return unpack(keyValue)
    ]]

	local keyValue = {Infinity.BDO.Lua.Execute(code)}
	local enum = {}
	for i = 1, #keyValue, 2 do
		enum[keyValue[i]] = keyValue[i + 1]
	end

	return enum
end

MagLib.BDO.Lua = Lua
