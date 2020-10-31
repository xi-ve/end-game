StaySafeTask = {}
StaySafeTask.inBA = false
StaySafeTask.enterBANextPulse = false
StaySafeTask.enterBATime = 0

StaySafeTask.runningToRepair = false
StaySafeTask.arrivedToRepair = false
StaySafeTask.arrivedToRepairTime = 0

StaySafeTask.serverBlacklist = {}

local waitUntil = 0
local wait = function(ms)
	local time = Infinity.Win32.GetPerformanceCounter()
	local newWaitUntil = time + ms
	if newWaitUntil > waitUntil then
		waitUntil = newWaitUntil
	end
end

local shouldWait = function()
	return Infinity.Win32.GetPerformanceCounter() < waitUntil
end

StaySafeTask.lastSwapped = MagLib.getTime()
StaySafeTask.nextSwap = nil

function StaySafeTask.resetTimerSwap()
	StaySafeTask.lastSwapped = Cache.time
	StaySafeTask.nextSwap = nil
end
function StaySafeTask.reset()
	waitUntil = 0
	StaySafeTask.resetTimerSwap()
end

local reenterWorldWaitDelay = 5000

function StaySafeTask.work()
	-- Log.debugLog("StaySafeTask work")

	if shouldWait() then
		return true
	end

	if Grinder.settings.switch_channel_after_given_time and StaySafeTask.nextSwap == nil then
		-- Determine next switch time
		local randomNumber = math.random()
		local possibleVariation = Grinder.settings.switch_channel_after_max_minutes -
                          			Grinder.settings.switch_channel_after_min_minutes
		local minOffset = possibleVariation * randomNumber
		local nextSwapInMinutes = Grinder.settings.switch_channel_after_min_minutes + minOffset
		StaySafeTask.nextSwap = Cache.time + (nextSwapInMinutes * 60 * 1000)
	end

	local shouldSwapDueToTimer = Grinder.settings.switch_channel_after_given_time and StaySafeTask.nextSwap < Cache.time

	local isPlayerNearby = Player.isPlayerNearby()
	local isTownrun = (Grinder.currentlyDoingTownrun or Grinder.forceTownRun or Grinder.currentlyFinishedTownrun)
	local isTownrunSecurityEnabled = Grinder.settings.useSecurityOnTownrun

	if not isPlayerNearby and not shouldSwapDueToTimer then
		return false
	end

	if isTownrun and not isTownrunSecurityEnabled then
		return false -- Currently doing townrun where players are allowed and we should not swap
	end

	local isCloseToGrindspot = StaySafeTask.isPlayerCloseToGrindspot(4000)
	local securityShouldTrigger = isCloseToGrindspot or (isTownrun and isTownrunSecurityEnabled)

	-- Server swap
	if securityShouldTrigger and (isPlayerNearby or shouldSwapDueToTimer) then
		if not shouldSwapDueToTimer and Grinder.lastTimeNotInGame + reenterWorldWaitDelay >
			Infinity.Win32.GetPerformanceCounter() then
			Log.log("Detected a player shortly after reentering the world. Waiting a bit and triggering security again!")
			local timeToWait = (Grinder.lastTimeNotInGame + reenterWorldWaitDelay) - Infinity.Win32.GetPerformanceCounter()
			Grinder.wait(timeToWait)
			wait(timeToWait)
			return true
		end

		-- Selecting a server
		Server.updateChannels()

		local possibleServer = {}

		local currentChannelIndex = Server.getCurrentChannelIndex()
		for k, v in pairs(Server.channel) do
			local isAllowed = false
			if v.chIndex ~= currentChannelIndex then -- Not the same server
				for name, allowed in pairs(Grinder.settings.switch_channel_settings) do
					if v.name == name and allowed and
						(not StaySafeTask.serverBlacklist[v.chIndex] or StaySafeTask.serverBlacklist[v.chIndex] < Cache.time) then
						isAllowed = true
					end
				end
			end

			if isAllowed then
				table.insert(possibleServer, v.chIndex)
			end
		end

		local amountOfPossibleServer = #possibleServer
		if amountOfPossibleServer > 0 then
			math.randomseed(Cache.time)
			local selectedIndex = math.random(1, amountOfPossibleServer)
			local chIndex = possibleServer[selectedIndex]

			local cd
			if Server.isSeasonChannel(chIndex) then
				cd = Server.getSeasonChannelCooldown()
			else
				cd = Server.getChannelCooldown()
			end

			if not shouldSwapDueToTimer then
				Log.log("Player detected!", true)
			else
				Log.log("Swapping due to timer!", true)
			end

			if cd > 0 then
				Log.log("Switching from channel " .. Server.getCurrentChannelName() .. " to channel " .. Server.getName(chIndex) ..
        					" (ID: " .. chIndex .. ") over channel select", true)

				Infinity.BDO.reEnterWorld(Server.getChannelNo(chIndex), Player.me():getName())
				Grinder.currentProfile.nav.stop()
				Grinder.wait(6000)
				wait(6000)
			else
				local switched = Server.changeToChannel(chIndex)
				-- Blocking the same server from being picked again soon, so we switch through a lot of servers
				StaySafeTask.serverBlacklist[chIndex] = Cache.time + ((15 * 60 * 1000) * (amountOfPossibleServer - 1))

				if switched then -- if switching failed we blacklist the server anyways (because it failed), but not waiting, since we wanna try again
					Log.log(
						"Switching from channel " .. Server.getCurrentChannelName() .. " to channel " .. Server.getName(chIndex) ..
							" (ID: " .. chIndex .. ")", true)
					wait(6000)
				else
					Log.log("Failed switching from " .. Server.getCurrentChannelName() .. " to channel " .. Server.getName(chIndex) ..
        						" (ID: " .. chIndex .. ")", true)
					return false
				end
			end

			StaySafeTask.lastSwapped = Cache.time
			StaySafeTask.nextSwap = nil
			return true
		else
			print("No channel available to swap to! Please enable more channel! Exiting game as a security measure!")
			Infinity.Win32:TerminateProcess()
		end
	end
	return false
end

function StaySafeTask.isPlayerCloseToGrindspot(range)
	Log.debugLog("isPlayerCloseToGrindspot")
	local _areas = Grinder.currentProfile.areas
	local pPos = Cache.playerPos
	for _, area in pairs(_areas) do
		for _, spot in pairs(area.spots) do
			if (pPos:getDistance(Vector3(spot.X, spot.Y, spot.Z)) < range) then
				return true
			end
		end
	end

	return false
end
