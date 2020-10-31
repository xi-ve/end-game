StopProcessingState = {}
StopProcessingState.__index = StopProcessingState
StopProcessingState.Name = "Stop Processing"

setmetatable(StopProcessingState, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function StopProcessingState.new()
	local self = setmetatable({}, StopProcessingState)
	self.lastValidationTick = 0
	return self
end

function StopProcessingState:NeedToRun()
	-- We want to check if we want to cancel the processing because we are overweight (It will cancel automatically if needed materials are missing)
	if self.lastValidationTick + 100 >= Infinity.Win32.GetTickCount() then
		return false
	end
	self.lastValidationTick = Infinity.Win32.GetTickCount()

	self.currentAction = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()
	if self.currentAction == "WAIT" or self.currentAction == "WAIT2" then
		return false -- We are not processing
	end

	local weightPct = Inventory.getInventoryWeightPercent()
	if weightPct >= 85 then
		print("Over 85% Weight. Canceling Processing.")
		-- Check if there is something we can deposit
		return true
	end

	return false
end

function StopProcessingState:Run()
	print("Force stopping processing due to overweight!")
	self.lastValidationTick = Infinity.Win32.GetTickCount()
	local action = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranch_ByName("WAIT")
	Infinity.BDO.ActionBranchManager.queueNextAction(action, 0)
end
