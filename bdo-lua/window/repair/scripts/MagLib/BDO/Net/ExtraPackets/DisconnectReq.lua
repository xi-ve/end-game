DisconnectReq = {}
DisconnectReq.__index = DisconnectReq

function DisconnectReq.new()
	local self = setmetatable({}, DisconnectReq)
	self.Name = "DisconnectReq"

	-- size 12 bytes
	self.isEncrypted = false
	self.opCode = 5102

	self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)

	return self
end

function DisconnectReq:construct()
	self.Packet.byteBuffer:putEmptyBytes(6)
	self.Packet.byteBuffer:put(64)
	return self
end

setmetatable(DisconnectReq, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})
