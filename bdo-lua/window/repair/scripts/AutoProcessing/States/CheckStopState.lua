CheckStopState = {}
CheckStopState.__index = CheckStopState
CheckStopState.Name = "Check Stop"

setmetatable(CheckStopState, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function CheckStopState.new()
	local self = setmetatable({}, CheckStopState)
	self.lastValidationTick = 0

	self.localPlayer = Infinity.BDO.getLocalPlayer()

	self.containerActor = Utils.findInstallation_Container()
	self.warehouseActor = Utils.findNpc_Warehouse()
	return self
end

function CheckStopState:NeedToRun()
	if self.lastValidationTick + 2000 >= Infinity.Win32.GetTickCount() then
		return false
	end

	self.lastValidationTick = Infinity.Win32.GetTickCount()

	if self.warehouseActor == nil and self.containerActor then
		print("Stopped cause no warehousemanager/container found!")
		return true
	end

	--[[if self.warehouseActor ~= nil then
     if self.warehouseActor:getPosition():getDistance(self.localPlayer:getPosition()) > 400.0 then      
      print("Stopped cause distance to warehouse manager is too big! Move closer!")
      return true
     end
    end

    if self.containerActor ~= nil then
     if self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) > 400.0 then      
      print("Stopped cause distance to container is too big! Move closer!")
      return true
     end
    end

    if self.containerActor ~= nil and self.warehouseActor ~= nil then
     if self.containerActor:getPosition():getDistance(self.localPlayer:getPosition()) > 400.0 and self.warehouseActor:getPosition():getDistance(self.localPlayer:getPosition()) > 400.0 then      
      print("Stopped cause distance to container/warehousemanager is too big! Move closer!")
      return true
     end
    end]] --

	if LocalPlayer.isDead() then
		print("Stopped cause player is dead!")
		return true
	elseif Inventory.getFreeSlotCount() <= 0 then
		print("Stopped cause no more inventory slots!")
		return true
	end

	if LocalPlayer.getWeightPercent() >= 100.0 then
		-- Checking if we can deposit something
		local canDeposit = false
		local invenMaxSize = Inventory.getMaxSize()

		for i = 0, invenMaxSize - 1 do
			local name
			local itemId
			local count

			name, itemId, count = Inventory.getItemData(i)
			if AutoProcessing.shouldMoveToWarehouse(itemId) then
				canDeposit = true
			end
		end

		if not canDeposit then
			print("Stopped cause too much weight!")
			return true
		end
	end

	return false
end

function CheckStopState:Run()
	AutoProcessing.StopBot()
end
