MagLib.Core.Stats = {}
local getTime = MagLib.getTime

MagLib.Core.Stats.pulseStartTime = 0

-- Performance related stuff
-- Start time is used to check for runtime performance and to decide what module to use.
local lastPulseTime = 0
local averagePulseTime = 0
local pulseTimes = {}

MagLib.Core.Stats.getPulseAverage = function()
	return averagePulseTime
end
MagLib.Core.Stats.getLastPulseTime = function()
	return lastPulseTime
end

local function addPulseTime(time)
	table.insert(pulseTimes, 1, time)
	if (#pulseTimes > 500) then
		table.remove(pulseTimes, 501)
	end
end

local function calculatePulseAverage()
	local sum = 0
	for _, v in ipairs(pulseTimes) do
		sum = sum + v
	end
	return sum / #pulseTimes
end

-- Returns the pulseTimes table used for performance profiling, containing the last 500 pulse times
function MagLib.Core.Stats.getPulseTimes()
	return pulseTimes
end

function MagLib.Core.Stats.updatePulseTime()
	-- Setting performance and average pulse time
	lastPulseTime = getTime() - MagLib.Core.Stats.pulseStartTime
	addPulseTime(lastPulseTime)
	averagePulseTime = calculatePulseAverage()
end

function MagLib.Core.Stats.onPulse_Beginning()
	MagLib.Core.Stats.pulseStartTime = getTime()
end

function MagLib.Core.Stats.onPulse_End()
	MagLib.Core.Stats.updatePulseTime()
end
