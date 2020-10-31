local indexCounter = 0

MagLib.Run.States.State = function(name, work)
	indexCounter = indexCounter + 1
	local State = {
		index = indexCounter,
		name = name or "",
		work = work or function()
			return true
		end,
		onStatedChangedTo = function()
		end
	}
	local getTime = MagLib.getTime
	local waitUntil = 0

	State.wait = function(ms)
		local newWaitUntil = getTime() + ms
		if newWaitUntil > waitUntil then
			waitUntil = newWaitUntil
		end
	end

	State.run = function()
		if getTime() > waitUntil then
			return State:work()
		else
			return false
		end
	end

	State = setmetatable(State, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			return "State " .. n.name
		end
	})

	return State
end
