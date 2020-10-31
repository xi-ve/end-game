---Plugin Class
-- @module MagLib.Plugins.Plugin
local indexCounter = 0

---Constructor
---@param name Name of the Plugin
---@param desc A Description of the Plugin
local Plugin = function(name, desc)
	indexCounter = indexCounter + 1
	local Plugin = {
		init = function()
		end,
		hooks = function()
		end,
		index = indexCounter,
		name = name,
		description = desc,
		enabled = false
	}

	Plugin = setmetatable(Plugin, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end,
		__tostring = function(n)
			return "Plugin " .. n.name .. ": \n" .. n.description
		end
	})

	return Plugin
end

MagLib.Plugins.Plugin = Plugin
