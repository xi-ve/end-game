local waitUntil = 0
local getTime = MagLib.getTime
--- Waits for set amount of time.
-- Be aware that this will NOT stop code execution for the rest of the pulse.
-- Until the onPulse or current callback is returned, it will continue execution.
-- Then it will skip the following onPulse callbacks until the wait time is over
---@param ms Time to wait in ms
function MagLib.wait(ms)
	local newWaitUntil = getTime() + ms
	if newWaitUntil > waitUntil then
		waitUntil = newWaitUntil
	end
end

--- Returns if we should wait and not execute anything.
-- @return bool: If we should wait
-- @see MagLib.wait
function MagLib.shouldWait()
	return waitUntil > getTime()
end

--- Returns how long we should keep waiting.
-- @return number: Amount of time left to wait in ms
function MagLib.getWaitMsLeft()
	local ms = waitUntil - getTime()
	if ms < 0 then
		ms = 0
	end
	return ms
end

-- Pulse related stuff
local notInGame = false
local waitAfterReenteringGame = 2500
local perfMon = nil

---First main pulse function.
-- Should be called at the beginning of your onPulse before your own code.
-- @return true if you should not execute anything else because we are either waiting or not in game.
-- @see MagLib.wait
-- @see MagLib.onPulse_End
-- @usage
-- local function onPulse()
--  if MagLib.onPulse_Beginning() then
--    return
--  end
--  --Your code
--  MagLib.onPulse_End()
-- end
function MagLib.onPulse_Beginning()
	-- Calling stat related function at the beginning

	if not MagLib.disableStats then
		MagLib.Core.Stats.onPulse_Beginning()
	end

	-- perfMon.next("MagLib onPulse Beginning_Checks")

	--[[TODO: Some kind of check if we are in the game world.
            Could be done by overwritting some isInGame or isInValidGameState function from the game specific handlers.
    ]]

	if notInGame then
		notInGame = false
		MagLib.wait(waitAfterReenteringGame)
	end

	if MagLib.shouldWait() then
		if not MagLib.disableStats then
			MagLib.Core.Stats.onPulse_End() -- Ensuring stats are updated
		end
		-- perfMon.next("Userscript")
		return true
	end

	-- perfMon.next("MagLib onPulse Beginning_Run")
	-- Run modules/tasks
	MagLib.Run.onPulse_Beginning()

	-- Running MagLib onPulse_Beginning stuff
	MagLib.Events.triggerEvent("MagLib_OnPulse_Beginning")

	-- Continue as usual
	-- perfMon.next("Userscript")
	return false
end

---Second main pulse function.
-- Should be called after your own code in your onPulse as the last thing called.
-- @see MagLib.onPulse_Beginning
-- @usage
-- local function onPulse()
--  if MagLib.onPulse_Beginning() then
--    return
--  end
--  --Your code
--  MagLib.onPulse_End()
-- end
function MagLib.onPulse_End()
	-- perfMon.next("MagLib onPulse End_Checks")

	-- perfMon.next("MagLib onPulse End_Run")
	-- Run modules/tasks
	MagLib.Run.onPulse_End()

	-- Running MagLib onPulse_End stuff
	MagLib.Events.triggerEvent("MagLib_OnPulse_End")

	-- Logger
	-- perfMon.next("MagLib onPulse End_Logger")
	if not MagLib.disableLogging then
		MagLib.Core.Log.onPulse_End()
	end

	-- Stats
	-- perfMon.next("MagLib onPulse End_Stats")
	if not MagLib.disableStats then
		MagLib.Core.Stats.onPulse_End()
	end

	-- Assuming after this the userscript returns/ends the onPulse function
	-- perMon.next("BDO Engine")
end
