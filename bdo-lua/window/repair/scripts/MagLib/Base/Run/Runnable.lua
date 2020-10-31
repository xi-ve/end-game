---An abstract class representing a runnable thing.
---Modules, Tasks and States inherit this
---All classes extending Runnable MUST call self:Runnable_init() in their :init() for everything to work properly
local Runnable = Class({
	-- Managed
	valid = true,
	index = nil, -- Set in :init
	initTime = nil, -- Set in :init
	active = false,
	waitUntil = 0,
	lastRunTime = 0,
	-- Set by constructor
	name = "Unnamed Runnable",
	pulseTimingMode = EPulseTimingMode.Beginning
}, true)
Runnable:setClassName("Runnable")

function Runnable:run()
	-- Default empty run function
end

local indexCounter = 0
local getIndexCounter = function()
	local retVal = indexCounter
	indexCounter = indexCounter + 1
	return retVal
end

-- Init function, giving it a different name so it gets copied over when extending
function Runnable:Runnable_init()
	self.index = getIndexCounter()
	self.initTime = MagLib.getTime()
end
Runnable.init = Runnable.Runnable_init

function Runnable:run()
	-- Empty default run function
end

---Sets the active flag to true
function Runnable:start()
	self.active = true
end

---Sets the active flag to false
function Runnable:stop()
	self.active = false
end

function Runnable:invalidate()
	self.valid = false
end

function Runnable:isValid()
	return self.valid
end

---Sets an internal waitUntil flag that is considered when the runnable is executed.
---Essentially a Runnable will not do anything for the given amount of milliseconds 
function Runnable:wait(ms)
	local newWaitUntil = MagLib.getTime() + ms
	if newWaitUntil > self.waitUntil then
		self.waitUntil = newWaitUntil
	end
end

---Returns true if the Runnable is in a waiting state/will wait, else false
function Runnable:shouldWait()
	return self.waitUntil > MagLib.getTime()
end

---Should be called by the handler of the Runnable.
---It handles the active and waiting checks.
---It then executes the :run function and updates the lastRunTime variable
function Runnable:execute()
	if (not self.active) or (self.waitUntil > MagLib.getTime()) then
		return false
	end

	local retVal = self:run()
	self.lastRunTime = MagLib.getTime()
	return retVal
end

local mt = getmetatable(Runnable)
mt.__eq = function(a, b)
	return a.index == b.index
end

mt.__tostring = function(a)
	return "Runnable: " .. a.name .. "| #" .. a.index
end
setmetatable(Runnable, mt)

MagLib.Run.Runnable = Runnable
