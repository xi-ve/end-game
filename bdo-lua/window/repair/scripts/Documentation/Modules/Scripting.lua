---Represents a Script.
---@class Script
local Script = {}
---@type boolean
Script.IsRunning = false
---@type string
Script.Name = ""
---@type string
Script.Directory = ""

---Starts the script
function Script:Start()
end
---Stops the script
function Script:Stop()
end

---Registers a callback. The function will be called when the callback with the given name is triggered
---@param name string
---@param func function
function Script:RegisterCallback(name, func)
end
---Unregisters a callback.
---@param name string
---@param func function
function Script:UnregisterCallback(name, func)
end

---Kept for legacy support, same as Script:RegisterCallback
function Script:RegisterGlobalHook(name, func)
end
---Kept for legacy support, same as Script:UnregisterCallback
function Script:UnregisterGlobalHook(name, func)
end

---Executes lua code in the executeeScript, supports returning values to this script. Can only return strings and numbers, no tables.
---@param executeeScript Script
---@param code string
function Script:LuaExec(executeeScript, code)
end

Infinity.Scripting = {}
---The current script
---@type Script
Infinity.Scripting.CurrentScript = Script

---Returns an array with all available scripts.
---@return table<integer, Script> scripts
function Infinity.Scripting.getAllScripts()
end

---Returns the script with the given name (case sensitive) name if existing.
---@param scriptName Script
---@return Script script
function Infinity.Scripting.GetScript(scriptName)
end
