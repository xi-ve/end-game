MagLib.BDO.Navigation.Graph.DirectNavigator = function()
	local settings = MagLib.BDO.Navigation.Graph.settings
	local getTime = MagLib.getTime
	local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
	local Player = MagLib.BDO.Actors.LocalPlayer
	local Vector = MagLib.Utils.Vector
	local self = {}
	self.dest = nil
	self.arrived = false
	self.isNavigating = false

	self.stopDistance = 100

	self.moveTo = function(dest, navigate_directly)
		if (not self.dest) or Vector.equal(dest, self.dest) == false then
			self.dest = dest
			self.arrived = false
			self.isNavigating = true
		end

		-- if navigate_directly then
		--  self.navigate()
		-- end
	end

	self.stop = function()
		self.dest = nil
		self.isNavigating = false
		self.arrived = true
	end

	self.reset = function()
		self.dest = nil
		self.isNavigating = false
		self.arrived = false
	end

	self.navigate = function()
		if self.arrived then
			self.reset()
			return false
		end

		if self.dest == nil then
			return false
		end

		local pPos = getPPos()

		if pPos:getDistance(self.dest) < self.stopDistance then
			self.stop()
			return true
		end

		self.direct_moveTo(self.dest)

		pPos = nil

		return true
	end

	self.direct_moveTo = function(dest, callOnMoveTo)
		if MagLib.BDO.Navigation.Graph.Teleport.isTpAllowed() then
			MagLib.BDO.Navigation.Graph.Teleport.tpTo(dest)
		else
			Player.moveTo(dest)
			if callOnMoveTo then
				self.onMoveTo(dest)
			end
		end
	end

	self.onMoveTo = function(dest)
		-- TODO
	end

	return self
end
