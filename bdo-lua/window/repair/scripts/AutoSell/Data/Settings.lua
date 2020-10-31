Settings = {}
Settings.__index = Settings

setmetatable(Settings, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})

function Settings.new()
	local self = setmetatable({}, Settings)

	self.LastProfile = ""

	self.MoneyCollect = {}
	self.MoneyCollect.Enabled = true

	self.RenderNpcs = false

	return self
end
