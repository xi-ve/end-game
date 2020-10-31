---Simple Enum implementation
---Can also be used by just doing Enum() rather than MagLib.Core.Enum()
---One can add new entries by doing enum:add(key).
---These enums can be generated as global enums if wanted.
---It will register as name_key. If your enum is called ETestEnum and you do ETestEnum:add("TestEntry") it will register ETestEnum_TestEntry in the global table.
---This can be configured by setting the second constructor parameter to true/false (default false)
---It will throw an error if an invalid entry is searched for (only if done over the object. Not working for the global entries).
---Error reporting can be disabled by setting the third constructor parameter to false (default true).
---@Module MagLib.Core.Enum
---@alias Enum
Enum = Class()
Enum:setClassName("Enum")

-- We need to preset these, so the metatbale functions properly handle them!
Enum.entries = {}
Enum.name = ""
Enum.registerAsGlobals = false
Enum.enableErrors = true

function Enum:init(name, registerAsGlobals, enableErrors)
	self.name = name
	self.entries = {}

	if registerAsGlobals == nil then
		registerAsGlobals = false
	end
	self.registerAsGlobals = registerAsGlobals

	if enableErrors == nil then
		enableErrors = true
	end

	self.enableErrors = enableErrors
end

-- Helper function that returns the next free enum value in a Enum.entris table
local findNextFreeEnumValue = function(t)
	local i = 0
	while (true) do
		if not table.find(t, i) then
			return i
		end

		i = i + 1
	end
end

function Enum:add(key, value)
	if self.enableErrors and value ~= nil and type(value) ~= "number" then
		MagLib.logger.warning(tostring(value) .. " is not a proper enum value for Enum " .. self.name ..
                      			". Please use numbers!")
	end
	if (value == nil) then
		value = findNextFreeEnumValue(self.entries)
	end

	self.entries[key] = value

	if self.registerAsGlobals then
		_G[self.name .. "_" .. key] = value
	end
end

function Enum:containsKey(key)
	return self.entries[key] ~= nil
end

function Enum:containsValue(value)
	return table.find(self.entries, value);
end

function Enum:valueToKey(value)
	for key, v in pairs(self.entries) do
		if v == value then
			return key
		end
	end

	return "Unknown"
end

local mt = getmetatable(Enum)

mt.__index = function(self, key)
	local lv = rawget(self, key)
	if lv then
		return lv
	end

	-- print("Enum trying to retrive value of " .. key)
	-- table.print(self)
	local v = self.entries[key]
	if v == nil and self.enableErrors then
		MagLib.logger.error(tostring(key) .. " is not an entry from Enum " .. self.name .. "!")
	end

	return v
end

mt.__newindex = function(self, key, value)
	-- print("newindex [" .. key .. "] = " .. value)
	if self.enableErrors and self.entries[key] ~= nil then
		MagLib.logger.warning("The entry " .. key .. " of the enum " .. self.name .. " has been overwritten!")
	end

	self:add(key, value)
end

setmetatable(Enum, mt)

MagLib.Core.Enum = Enum
