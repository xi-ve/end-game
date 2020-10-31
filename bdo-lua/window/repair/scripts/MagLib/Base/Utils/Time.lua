local Time = {}

local msInSecond = 1000
local msInMinute = msInSecond * 60
local msInHour = msInMinute * 60

Time.msToTimeString = function(ms)
	local hours = math.floor(ms / msInHour)
	ms = ms - (hours * msInHour)
	local minutes = math.floor(ms / msInMinute)
	ms = ms - (minutes * msInMinute)
	local seconds = math.floor(ms / msInSecond)
	ms = math.floor(ms - (seconds * msInSecond))

	if hours > 0 then
		return hours .. ":" .. minutes .. ":" .. seconds .. " hrs"
	elseif minutes > 0 then
		return minutes .. ":" .. seconds .. " minutes"
	elseif seconds > 0 then
		return seconds .. " seconds"
	else
		return ms .. " ms"
	end
end

MagLib.Utils.Time = Time
