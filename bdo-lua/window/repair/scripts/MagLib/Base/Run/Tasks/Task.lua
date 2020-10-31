--[[
  A Task is a class that includes a run function that will be executed by the respective handler after a set delay.
  If the run return returns false/nil, then the task will be readded to the task list, if the run function returns true, that should mean that the task was finished and the task doesn't get readded again.
@Parameter:
  name => The name, for displaying/debugging
  pulseTimingMode => Should run at beginning or end of pulse, see EPulseTimingMode
  run => The function to be executed. Should return either 
  timeout => timeout after creation (Not after adding it to the handler!) that the task is deleted because it is considered "failed"
  

  After creating a Task you are expected to set the run function afterwards. You can also set an onTimeout function to be called on timeout
]] --
local Task = MagLib.Run.Runnable:extend()
Task.name = "Unnamed Task"
Task.pulseTimingMode = EPulseTimingMode.Beginning
Task.startDelay = 0
Task.timeout = 1 / 0

function Task:init(timeout, startDelay)
	if startDelay ~= nil then
		self.startDelay = startDelay
	end

	if timeout ~= nil then
		self.timeout = timeout
	end

	self:Runnable_init()
end

function Task:onTimeout()
	-- Default empty onTimeout func
end

function Task:forceTimeout()
	self.timeout = 0
end

---Should return true if the Task is finished
function Task:run()
	return true -- Default empty tasks run func
end

function Task:stop()
	MagLib.Run.Tasks.Handler.removeTask(self)
end

-- Keeping Runnable execute so we can call it in our own execute
Task.Runnable_execute = Task.execute
---Runs the Task, returns true if the task is finished or not active, else false
function Task:execute()
	-- Checking that Task was not invalidated
	if not self:isValid() then
		MagLib.logger.error("Tried to execute invalidated Task " .. self.name)
		return true
	end

	-- Checking that startDelay ran out and we are not timed out. Else execute original Runnable_execute
	if not self.active then
		return false
	end -- We do this check even though Runnable_execute checks it as well to ensure we don't time out while not active.

	local time = MagLib.getTime()

	if self.initTime + self.startDelay > time then
		return false -- We are not past the startDelay, we are not finished yet either
	end

	if self.initTime + self.timeout < time then
		-- We timed out
		if MagLib.Run.verboseLogging then
			MagLib.logger.trace("Task " .. self.name .. " timed out!")
		end

		self:onTimeout()
		return true
	end

	if MagLib.Run.verboseLogging then
		MagLib.logger.trace("Running task " .. self.name .. ".")
	end

	return self:Runnable_execute();
end

local mt = getmetatable(Task)
mt.__tostring = function(a)
	return "Task: " .. a.name .. " | #" .. a.index
end
setmetatable(Task, mt)

MagLib.Run.Tasks.Task = Task
