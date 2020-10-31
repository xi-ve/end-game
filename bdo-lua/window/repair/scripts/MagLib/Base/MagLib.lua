--- MagLib
-- MagLib is a framework as well as a wrapper containing everything you, making the creation of an Infiniy lua script faster and easier.
-- MagLib does all the heavy lifting!
-- @module MagLib
MagLib = {}

EnvIsLuaJit = (jit ~= nil)

MagLib.version = "0.19.2"
MagLib.devVersion = false

local settings = {unaccurateTimings = false}
MagLib.settings = settings

--- Returns current os time in ms
-- @return Current os time in ms
-- @param forceAccurateTime if true will force the usage of PerformanceCounter even if unaccurateTimings in the MagLib settings is true
MagLib.getTime = function(forceAccurateTime)
	if Infinity.Win32 and Infinity.Win32.GetPerformanceCounter and ((not settings.unaccurateTimings) or forceAccurateTime) then
		return Infinity.Win32.GetPerformanceCounter()
	else
		return Infinity.Win32.GetTickCount()
	end
end

---Sleep for a given amount of milliseconds.
--- If we are running LuaJit, we are not using a busy wait, but rather the c SLeep function
-- @param ms to sleep
MagLib.sleep = function(ms) -- For documentation
end

if EnvIsLuaJit then
	local ffi = require("ffi")
	ffi.cdef[[
    void Sleep(int ms);
  ]]

	MagLib.sleep = function(ms)
		ffi.C.Sleep(ms)
	end
else
	MagLib.sleep = function(ms)
		local endTime = MagLib.getTime() + ms
		while (MagLib.getTime() < endTime) do
		end
	end
end

--- Contains default logger instance.
-- @see MagLib.Core.Log.Logger
MagLib.logger = nil

--- Ends the currently executed script
function MagLib.endScript()
	local script = Infinity.Scripting.CurrentScript
	script:Stop()
end

--- Handles MagLib shutdown.
-- Is registered as a callback itself, so you do not need to call this in most cases.
function MagLib.onStop()
	if MagLib.Net and MagLib.Net.Tcp then
		MagLib.Net.Tcp.onExit()
	end

	if MagLib.Events then
		MagLib.Events.triggerEvent("EndScript")
	end

	if not MagLib.disableLogging and MagLib.Core.Log then
		MagLib.Core.Log.onPulse_End()
	end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function()
	MagLib.onStop()
end)
