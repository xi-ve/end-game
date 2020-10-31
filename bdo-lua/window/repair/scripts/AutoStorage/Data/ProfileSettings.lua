ProfileSettings = {}
ProfileSettings.__index = ProfileSettings

setmetatable(ProfileSettings, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function ProfileSettings.new()
	local self = setmetatable({}, ProfileSettings)

	self.Name = ""
	self.ItemFilters = {}
	self.ProfileVersion = 1

	self.forceClearWeightPctThreshold = 110

	self.enableRandomWaits = true
	self.minWaitPushingToWarehouse = 2500
	self.maxWaitPushingToWarehouse = 15000

	return self
end
