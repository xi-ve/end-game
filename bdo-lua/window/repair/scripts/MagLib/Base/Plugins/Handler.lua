---Plugin Handler
-- @module MagLib.Plugins.Handler
-- @alias Handler
local Handler = {}
MagLib.Plugins.Handler = Handler

local plugins = {}
---Returns the plugin index of a loaded plugin
---@param searchedPlugin the Plugin that you want to get the index of
---@return number index of the Plugin.
Handler.getPluginIndex = function(searchedPlugin)
	for index, plugin in ipairs(plugins) do
		if plugin.index == searchedPlugin.index then
			return index
		end
	end

	return nil
end

---Loads a given Plugin 
---@param plugin the Plugin you want to load
Handler.loadPlugin = function(plugin)
	local index = Handler.getPluginIndex(plugin)
	if index then
		plugins[index] = plugin
	else
		table.insert(plugins, plugin)
	end
end

---Removes a given Plugin
---@param plugin the Plugin to remove
Handler.removePlugin = function(plugin)
	local index = Handler.getPluginIndex(plugin)
	if index then
		table.remove(plugins, index)
	end
end
