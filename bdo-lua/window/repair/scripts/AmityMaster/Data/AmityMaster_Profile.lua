--[[

Contains profile data:
	- Npc name (arbitrary atm)
	- requiredAmity (if item buying is enabled, then this should be the minimum amity requirement for buying it) (if item buying is disabled, the script will stop running when it hits this threshold)
	- buyItem (enables or disables item buying)
	- buyItemName (item that will be bought if item buying is enabled)
	- useWareHousemoney (if enabled, uses warehouse money instead of inventory money)

]]--

AmityMaster_Profile = { }
AmityMaster_Profile.__index = AmityMaster_Profile

setmetatable(AmityMaster_Profile, {
	__call = function (cls, ...)
		return cls.new(...)
	end,
})

function AmityMaster_Profile.new()
	local self = setmetatable({}, AmityMaster_Profile)
	self.npcName = ""
	self.requiredAmity = 0
	--self.buyItem = false
	--self.buyItemName = ""
	--self.useWarehouseMoney = false
	self.win = {}
	self.lose = {}
	return self
end