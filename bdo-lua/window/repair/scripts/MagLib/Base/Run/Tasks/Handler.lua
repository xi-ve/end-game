local getTime = MagLib.getTime

local Handler = {}
local tasks = {}

Handler.getTasks = function()
	return tasks
end

Handler.addTask = function(task)
	table.insert(tasks, task)
end

Handler.removeTask = function(task)
	for k, v in pairs(tasks) do
		if v == task then
			v:invalidate()
			table.remove(tasks, k)
			break
		end
	end
end

Handler.onPulse_Beginning = function()
	Handler.process(EPulseTimingMode.Beginning)
end

Handler.onPulse_End = function()
	Handler.process(EPulseTimingMode.End)
end

-- Checks every tasks if they have the right timing mode and calls their execute function
Handler.process = function(timingMode)
	local time = getTime()
	for k, v in ipairs(tasks) do
		if v.pulseTimingMode == timingMode then
			if v:execute() then
				Handler.removeTask(v)
			end
		end
	end
end

MagLib.Run.Tasks.Handler = Handler
