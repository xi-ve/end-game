TargetSelector = {}

-- Settings
local settings = {maxDistanceToPlayer = 1000}
MagLib.Core.Settings.addSettingsToHandler("MagLib_TargetSelector", settings)

TargetSelector.runtimeSettings = {}

-- Filter function
local filterFunctions = {}

---Add a filter function or updates it if a name is supplied
TargetSelector.addFilterFunction = function(func, name)
	local found = false
	-- Updating old filterFunction if there is one wiht the same name (~= nil)
	for _, v in pairs(filterFunctions) do
		if v.name ~= nil and v.name == name then
			v.func = func
			found = true
			break
		end
	end
	-- If it is a new func or a func with name == nil, we add it
	if not found then
		table.insert(filterFunctions, {func = func, name = name})
	end
end

---Removing a filter function
TargetSelector.removeFilterFunction = function(name_or_function)
	local index = nil

	if type(name_or_function) == "string" then
		for k, v in pairs(filterFunctions) do
			if v.name ~= nil and v.name == name_or_function then
				index = k
				break
			end
		end
	elseif type(name_or_function) == "function" then
		for k, v in pairs(filterFunctions) do
			if v.func == name_or_function then
				index = k
				break
			end
		end
	end
	if index then
		table.remove(filterFunctions, index)
	else
		MagLib.error("No filter function found with identifier " .. tostring(name_or_function))
	end
end

---Checks if a target is valid 
TargetSelector.isValidTarget = function(mob)
	local valid = true
	for _, func in pairs(filterFunctions) do
		if not func(mob) then
			valid = false
			break
		end
	end
end

local mobSortingFunction = function(a, b)
	local pPos = MagLib.BDO.Actors.LocalPlayer.getPos()
	local distA = pPos:getDistance(a:getPosition())
	local distB = pPos:getDistance(b:getPosition())
	return distA < distB
end

TargetSelector.overrideMobSortingFunction = function(func)
	mobSortingFunction = func
end

---Returns a valid target
TargetSelector.selectTarget = function()
	local mobs = MagLib.BDO.Actors.getMobsInRange_ReachableStraightLine(settings.maxDistanceToPlayer)
	table.sort(mobs, mobSortingFunction)
	return mobs[1]
end

MagLib.BDO.Actions.Combat.TargetSelector = TargetSelector
