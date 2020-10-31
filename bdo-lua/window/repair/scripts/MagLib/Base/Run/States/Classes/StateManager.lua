---StateManager
-- @module MagLib.Run.States.StateManager
-- @alias SM
local indexCounter = 0

--- Constructor
-- Constructs a simple state manager that runs a state until its run function returns true, in which case it goes to the next state in the list.
-- Last state is connected to first state.
-- @function this
MagLib.Run.States.StateManager = function(name, shouldRepeat)
	indexCounter = indexCounter + 1
	local SM = {index = indexCounter, name = name or "", shouldRepeat = shouldRepeat or false, running = true}

	local states = {}
	SM.currentState = -1
	SM.currentStateIndex = -1

	local logger = MagLib.Core.Log.newLogger("StateManager_" .. name)

	SM.getIndex = function(state)
		return MagLib.Utils.Table.findIndex(states, state)
	end

	SM.restart = function()
		SM.setState(1)
		SM.running = true
	end

	SM.addState = function(state, position)
		if position then
			table.insert(states, position, state)
		else
			table.insert(states, state)
		end
	end

	SM.removeState = function(state_or_index)
		local index
		if type(state_or_index) == "number" then
			index = state_or_index
		else
			index = SM.getIndex(state_or_index)
		end

		table.remove(index)
		MagLib.Utils.Table.removeHoles(states)
	end

	SM.setState = function(state_or_index)
		local index
		if type(state_or_index) == "number" then
			index = state_or_index
		else
			index = SM.getIndex(state_or_index)
		end
		SM.currentStateIndex = index
		SM.currentState = states[index]
		if SM.currentState then
			logger.trace("Switched to State " .. SM.currentState.name)
			if SM.currentState.onStateChangedTo then
				SM.currentState.onStateChangedTo()
			end
		end
	end

	SM.setStateToPrevious = function()
		local curIndex = SM.getIndex(SM.currentIndex)
		SM.setState(curIndex - 1)
	end

	SM.setStateToNext = function()
		local curIndex = SM.getIndex(SM.currentIndex)
		SM.setState(curIndex + 1)
	end

	SM.run = function()
		if not SM.running then
			return false
		end

		if (#states == 0) then
			logger.debug("Empty StateManagers onPulse called." .. tostring(SM))
			SM.running = false
			return true
		end

		-- last state was finished and last states index in the states table + 1 is nil. Setting currentState to first state
		if (SM.currentState == nil) then
			if SM.shouldRepeat then
				SM.setState(1)
			else
				SM.running = false
				return false
			end
		end

		-- First run
		if (SM.currentState == -1) then
			SM.setState(1)
		end

		local finished = SM.currentState:run()

		if finished then
			logger.trace("Finished State " .. SM.currentState.name)
			SM.setState(SM.currentStateIndex + 1)
		end

		return true
	end

	SM.printStates = function()
		local s = ""
		for k, v in pairs(states) do
			s = s .. "\n" .. tostring(v)
		end

		print("States in StateManager " .. SM.name .. ": " .. s)
	end

	SM = setmetatable(SM, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			local state = "None"
			if n.currentState and n.currentState ~= -1 then
				state = n.currentState.name
			end
			return "StateManager " .. n.name .. " | Current state: " .. tostring(state)
		end
	})

	return SM
end
