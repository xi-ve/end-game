---Manages ActionSequence classes.
-- Starts the ActionSequences in order and waits for them to finish before queing the next one.
-- @module MagLib.BDO.Actions.ActionSequenceManager
local AM = {}

local lPlayer = MagLib.BDO.Actors.LocalPlayer
local getPPos = lPlayer.getPos
local getTime = MagLib.getTime

local blockUntil = 0

-- Current ActionSequence
local currentActionSequence = nil

AM.getCurrentActionSequence = function()
	return currentActionSequence
end

AM.cancelCurrentActionSequence = function()
	currentActionSequence = nil
end

-- Skill Queue
local actionSequenceQueue = MagLib.Core.Queue()

AM.isActionSequenceQueued = function()
	if blockUntil > getTime() then
		return true -- blocked rn
	end

	return not actionSequenceQueue:isEmpty()
end

AM.popNextActionSequence = function()
	return actionSequenceQueue:pop()
end

AM.queueActionSequence = function(actionSequence)
	-- If we do not currently have an action queued and are not in an action
	if not AM.isActionSequenceQueued() and currentActionSequence == nil then
		-- We start the action
		actionSequence.start()
		currentActionSequence = actionSequence
	else
		-- We queue the action
		actionSequenceQueue:push(actionSequence)
	end
end

AM.clearQueue = function()
	actionSequenceQueue = nil -- Mby better if we first set it to nil for gc?
	actionSequenceQueue = MagLib.Core.Queue(50, "ActionSequenceQueue")
end

-- won't execute next actionSeq (current actionSeq still continues) and isActionSequenceQueued always returns true
AM.block = function(ms)
	blockUntil = MagLib.getTime() + ms
end

-- Module that checks isFinished of currentAction and goes to next actionseq in queue
local module = MagLib.Run.Modules.RunModule("ActionSequenceManager", 10, 25,
                                            MagLib.Run.Modules.TimingMode.TimedCritical,
                                            MagLib.Run.EPulseTimingMode.Beginning)
module.run = function()
	if blockUntil > getTime() then
		return -- blocked rn
	end

	if currentActionSequence and currentActionSequence.isFinished() then
		if AM.isActionSequenceQueued() then
			currentActionSequence = AM.popNextActionSequence()
			currentActionSequence.start()
		else
			currentActionSequence = nil
		end
	end
end
module.start()
MagLib.Run.Modules.Handler.addModule(module)

-- Making it local for more performance reasons
local onSelfActionChanged = function(action)
	-- If we are not currently in any ActionSequence, then no need to do anything.
	if currentActionSequence == nil then
		return
	end

	-- We call the process of the current ActionSequence, it will return true if the actionSequence is finished
	currentActionSequence.onSelfActionChanged(action)
end
AM.onSelfActionChanged = onSelfActionChanged
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnSelfActionChanged", onSelfActionChanged)

MagLib.BDO.Actions.ActionSequenceManager = AM
