--[[

Contains settings data
	- lastProfileName (name of last profile used)

]]--

AmityMaster_Settings = { }
AmityMaster_Settings.__index = AmityMaster_Settings

setmetatable(AmityMaster_Settings, {
	__call = function (cls, ...)
		return cls.new(...)
	end,
})

function AmityMaster_Settings.new()
	local self = setmetatable({}, AmityMaster_Settings)
	self.lastProfileName = ""
	self.delayMultiplier = 1
	return self
end