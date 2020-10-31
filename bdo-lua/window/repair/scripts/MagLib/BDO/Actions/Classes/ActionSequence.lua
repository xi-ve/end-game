--- An ingame Action wrapper.
-- The usage example below is NOT needed if you use it with the Skill class. It handles all of it. In that case you only need the constructor.
-- @module MagLib.BDO.Actions.ActionSequence
-- @alias A
-- @see MagLib.BDO.Actions.ActionSequenceManager
-- @usage
-- local actionSeq = MagLib.BDO.Actions.ActionSequence("start_animation_bla", {"end_animation_1", "end_animation_2"}, nil, 100)
-- actionSeq.keys = {KeyCode_W, KeyCode_LBUTTON}
--
-- --There are two ways to do it. Just queue it in the ActionSequenceManager for ease of use:
-- MagLib.BDO.Actions.ActionSequenceManager.queueActionSequence(actionSeq)
--
-- ---------------------------------------
-- --OR start it yourself.
-- actionSeq.start()
--
-- --In this case where you start it yourself you want to register (somewhere only once, not in onPulse or any callback)
-- local onSelfActionChanged = function(action)
--  local actionSeq = whereEverItGetsCurrentActionSequenceFrom()
--  actionSeq.onSelfActionChanged(action)
-- end
-- Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnSelfActionChanged", onSelfActionChanged)
--
-- --In most cases you just want to use the ActionSequenceManger. It does all the heavy lifting for you.
--
---Constructor
---@param startAnimation The first animation of the ActionSequence
---@param endAnimations The possible last animations of the ActionSequence. If any of these happen we know the animation is in the last step.
---@param timeout Timeout in ms after which the ActionSequence gets canceled if not completed. Default 1000
---@param endDelay Amount of time in ms the last step/animation takes, before we can queue the next animation. Default 250
-- @function this
local function ActionSequence(startAnimation, endAnimations, timeout, endDelay)
	if endAnimations == nil then
		endAnimations = {startAnimation}
	end

	-- Add default endAnimations substrings
	table.insert(endAnimations, "WAIT")
	table.insert(endAnimations, "RUN")
	table.insert(endAnimations, "_FALL")

	local A = {
		startAnimation = startAnimation,
		startAction = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranch_ByName(startAnimation),
		endAnimations = endAnimations,
		endDelay = endDelay or 0,
		timeout = timeout or 1000,
		onFinishCallback = nil
	}

	---Table of keys which should be pressed to start the ActionSequence (temp workaround)
	A.keys = nil
	---Time in ms how the long the keys which start the ActionSequence should be pressed.
	A.keyPressDelay = 150

	local currentBranchIndex = 1
	--- Will be true if the end animation was found
	A.endAnimationFound = false

	--- Will be set to the time in ms at which the AtionSequence will end earliest.
	A.returnAt = nil
	local setReturnAt = function(newReturnAt)
		if not A.returnAt or newReturnAt < A.returnAt then
			A.returnAt = newReturnAt
		end
	end

	---Time in ms at which the action was started
	A.actionStartTime = 0

	---If you set this to a function, it will be called instead of doing the normal start routine for a ActionSequence.
	-- Do NOT override .start . It does more stuff.
	A.customStart = nil

	---Starts the ActionSequence. For now due to the ActionSystem not being feature complete yet we still need .keys to be set to the right keys to start the action. In a later version this will not be needed anymore.
	A.start = function()
		-- Infinity.BDO.ActionBranchManager.queueNextAction(A.startAction)
		-- MagLib.logger.info("Starting Action " .. startAnimation)
		if A.customStart then
			A.customStart()
		else
			if not A.keys then
				MagLib.logger.warning("Please set keys for the ActionSequence " .. A.startAnimation ..
                      					" in the CombatProfile. This is only temporal until the issues of the ActionBranchManager are solved. Will try to start over the ActionBranchManager")
				Infinity.BDO.ActionBranchManager.queueNextAction(A.startAction)
			else
				MagLib.Input.press(A.keys, A.keyPressDelay)
			end
		end

		local time = MagLib.getTime()
		setReturnAt(time + A.timeout) -- Setting timeout
		A.actionStartTime = time
		A.endAnimationFound = false
	end

	---Checks if the ActionSequence is finished.
	-- @return bool: true if the ActionSequence is finished, else false.
	A.isFinished = function()
		if A.returnAt and A.endAnimationFound then
			if A.returnAt <= MagLib.getTime() then
				-- MagLib.logger.info("Finished ActionSequence")
				-- Checking if a onFinishCallback exists
				if A.onFinishCallback then
					-- Calling callback function
					A.onFinishCallback()
				end

				local actionTimeNeeded = MagLib.getTime() - A.actionStartTime
				-- MagLib.logger.info("Action finished after a total of " .. actionTimeNeeded .. "ms!")
				return true
			else
				return false
			end
		end
	end

	---Should be called on every onSelfActionChanged callback with the new action. Determines when an action is finished
	-- If you use the ActionSequenceManager he will do this.
	---@param action new animation name.
	A.onSelfActionChanged = function(action)
		if A.endAnimationFound then
			return
		end

		if MagLib.Utils.Table.containsSubstring(A.endAnimations, action) then
			local actionTimeNeeded = MagLib.getTime() - A.actionStartTime
			MagLib.logger.info("Found end animation after " .. actionTimeNeeded .. "ms! Waiting another " .. A.endDelay .. " ms")
			setReturnAt(MagLib.getTime() + A.endDelay)
			A.endAnimationFound = true
		end

	end

	return A
end

MagLib.BDO.Actions.ActionSequence = function()
end -- for doc tool
MagLib.BDO.Actions.ActionSequence = ActionSequence

--[[
Test code:

local actionSeq1 = MagLib.BDO.Actions.ActionSequence("BT_ARO_Skill_Backstab_Swing_B_1Lv_Start", "BT_ARO_Skill_Backstab_Swing_B_1Lv", 2000, 1250)
local actionSeq2 = MagLib.BDO.Actions.ActionSequence("BT_ARO_Skill_JangPoong_R_3Lv", nil, 1500, 250)

MagLib.BDO.Actions.ActionSequenceManager.queueActionSequence(actionSeq1)
MagLib.BDO.Actions.ActionSequenceManager.queueActionSequence(actionSeq2)
]]
--[[

ActionPack Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentActionPack()


Infinity.BDO.ActionBranchManager = { --Infinity regsitered table with funcs.
  void .queueNextAction(actionName)
  ActionBranch .getPCPackageRaw_ActionBranch_ByName(actionName)
  table<ActionBranch> .getPCPackageRaw_ActionBranches()
  table<index, PackageMap> .getPCPackageRaw_PackageMaps()

}

ActionPack = { --type
  number .adress
  table<actionName, ActionPack> :getList_Package0()
  string :getActionHash()
  table<ActionBranch> :getActionBranches()
  string :getValueList()
}

ActionBranch = { --type
    number .adress
    string :getExecute() -- actionName
    string :getActionHash()
    FrameHeader :getFrameHeader()
    string :getActionFileName()
}

PackageMap = { --type
  number .adress
  string :getPackageHash()
  table<index, ActionChart> :getActionCharts()
}

ActionChart = { --type
  string :getName
  PackageMap :getParentPackageMap()
  ActionChartData :getActionChartData()
}

ActionChartData = { --type
  number :getTargetTypes()
  number :getStartFrame()
  number :getEndFrame()
  number :getAnimationSpeed()
  number :getSkillId()
}


]]
