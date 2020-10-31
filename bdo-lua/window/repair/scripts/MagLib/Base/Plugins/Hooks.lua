--- Hook utilities for Infinity Lua
--- Paritally inspired by https://github.com/vallentin/hook.lua
---@module MagLib.Plugins.Hooks
---@alias Hooks
local Hooks = {}
MagLib.Plugins.Hooks = Hooks

-- Table of all hooks
local hooks = {}
---Returns a list of all hooked functions
---@return table table with all hooked functions
Hooks.getAllHooks = function()
	return hooks
end

local callHookedFunc = function(hookedFunc, ...)
	-- Creating local vars that are used in the f() 
	local calledIndex = 0
	local amountOfHooks = #hookedFunc.__hooks

	-- Defining f
	local f
	f = function(...)
		calledIndex = calledIndex + 1
		if calledIndex == amountOfHooks + 1 then
			calledIndex = nil
			return hookedFunc.__func()
		else
			return hookedFunc.__hooks[calledIndex](f, ...)
		end
	end

	-- Starting recursive calling of all hooked funcs
	return f(f, ...)
end

-- Creates the inital hook
local initialHook = function(func, hook)
	local hookedFunc = {}
	hookedFunc.__hooks = {hook}
	hookedFunc.__func = func

	setmetatable(hookedFunc, {
		_call = function(f, ...)
			return callHookedFunc(hookedFunc, ...)
		end
	})

	table.insert(hooks, hookedFunc)
	return hookedFunc
end

-- Adds a hook to an already hooked function
local addHook = function(func, hook)
	table.insert(func.__hooks, hook)
	return func
end

local isHooked = function(func)
	if type(func) == "table" and func.__hooks and type(func.__hooks) == "table" then
		return true
	else
		return false
	end
end
Hooks.isHooked = isHooked

---Adds a new hook for the function
---@param func the function to hook
---@param hook the new function
---@return function updated function
Hooks.addHook = function(func, hook)
	if hook == nil or type(hook) ~= "function" then
		MagLib.logger.debug("Hooks.addHook received non existing hook function or given hook parameter is not a function.")
		return func
	elseif func == nil then
		MagLib.logger.debug("Hooks.addHook received non existing function to hook")
		return nil
	end

	if isHooked(func) then
		return addHook(func, hook)
	else
		return initialHook(func, hook)
	end
end

---Removes a hook from the function
---@param func the function the hook is hooked to
---@param hook the hook function that should be removed
---@return function updated function
Hooks.removeHook = function(func, hook)
	if isHooked(func) then
		for i = #func.__hooks, 1, -1 do
			-- Removing all found hooks
			if func.__hooks[i] == hook then
				table.remove(func.__hooks, i)
			end
		end

		-- If no hooks left, we just return original function
		if #func.__hooks == 0 then
			return Hooks.clear()
		end
	end

	return func
end

---Clears the function from any hooks, returns original function
---@param func function to clear
---@return function original function
Hooks.clear = function(func)
	if isHooked(func) then
		-- Removing it from hooks table
		for i = #hooks, 1, -1 do
			if hooks[i] == func then
				table.remove(hooks, i)
			end
		end

		-- Destroying table and returning original func
		local oFunc = func.__func
		func = nil
		return oFunc
	else
		-- Not hooked, returning original function
		return func
	end
end

---Returns all hooks of a specific function.
---@param func function to get hooks off
---@return table table of hook functions
Hooks.getHooks = function(func)
	local attachedHooks = {}
	if isHooked(func) then
		for i = 1, #func.__hooks do
			attachedHooks[i] = func.__hooks[i]
		end
	end

	return attachedHooks
end

-- Hooking example. Let's say we have three hooks for the default print function
--[[
local hook1 = function(oFunc, msg)
    --Modifying the incoming parameters
    return oFunc(msg, "hooked!")
end

local hook2 = function(oFunc, ...)
    --Getting parameters if there is a variable amount of arguments and modifying every one.
    for k, v in ipairs(arg) do
        arg[k] =  v .. "^_^"
    end
    return oFunc(table.unpack(arg))
end

local hook3 = function(oFunc, msg)
    --Changing return parameters. Print returns nil normaly, but let's make it return true.
    oFunc(msg)
    return true
    --If you have a function that has return values you can do
    --local r1, r2 = oFunc(...)
    --return r1 * 15, 0
    --to modify the return values if your function for example returns two values.
end

--Adding the hooks.
print = MagLib.Plugins.Hooks.addHook(print, hook1)
print = MagLib.Plugins.Hooks.addHook(print, hook2)
print = MagLib.Plugins.Hooks.addHook(print, hook3)
--The order in which you add the hooks matters!
--MagLib.Plugins.Handler handles the orders of which plugins are initialized. Hence no need to worry there though.

--Now we test if the hooks work
local printReturn = print("Test!")
--First hook 1 is called. So parameters are now ("Test!", "hooked!")
--Then hook 1 calls hook 2. Parameters are now ("Test!^_^", "hooked!^_^")
--Then hook 2 calls hook 3. It prints "Test!^_^    hooked!^_^"
--printReturn is true now, due to hook 3 and hook 2 and hook 1 nicely returning the values
]]
