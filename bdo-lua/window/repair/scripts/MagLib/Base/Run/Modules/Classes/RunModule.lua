local indexCounter = 0

--[[
  A RunModule is a class that includes a needToRun and a run function, as well as a min and max Interval.
  The RunHandler Handler handles RunModules and calls the run function based on maxInterval between runs and the needsToRun function.

@Parameter:
  name => The name, for displaying/debugging
  minInterval => min Interval allowed between calling needsToRun() => run()
  maxInterval => max Interval allowed between calling needsToRun() => run(), due to how the system works, mostly stuff will be executed close to minInterval, but for huge systems with a lot of big, ressource heavy calls, this might be
  timingMode => Mode of execution timing.
  runMode => MagLib.Run.EPulseTimingMode.Beginning or MagLib.Run.EPulseTimingMode.End, determines when in a pulse to execute

  After creating a RunModule you are expected to set the needsToRun function or at least the run function (needsToRun returns true as default)
]]
MagLib.Run.Modules.RunModule = function(name, minInterval, maxInterval, timingMode, runMode)
	local everyPulse = (maxInterval == 0) or (maxInterval == 1)

	indexCounter = indexCounter + 1
	local Module = {
		active = false,
		needToRun = function()
			return true
		end,
		run = function()
		end,
		index = indexCounter,
		timingMode = timingMode,
		runMode = runMode,
		name = name,
		everyPulse = everyPulse,
		maxInterval = maxInterval,
		minInterval = minInterval,
		priority = 0,
		lastRun = 0
	}
	Module = setmetatable(Module, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			return "RunModule: " .. n.name .. " | Active: " .. tostring(n.active) .. " | #" .. n.index .. " | Priority: " ..
       				n.priority
		end
	})
	Module.start = function()
		Module.active = true
	end
	Module.stop = function()
		Module.active = false
	end

	return Module
end
