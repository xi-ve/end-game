local Receiver = {}
local packetCallbacks = {}

local addCallback = function(opCode)
	packetCallbacks[opCode] = {}
end

Receiver.addPacketHandler = function(opCode, func)
	if packetCallbacks[opCode] == nil then
		addCallback(opCode)
	end
	table.insert(packetCallbacks[opCode], func)
end

local packetHandler = function(byteBuffer)
	local packet = SnifferPacket(byteBuffer)
	local opCode = packet.opCode
	if packetCallbacks[opCode] ~= nil then
		for _, func in pairs(packetCallbacks[opCode]) do
			func(byteBuffer)
		end
	end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPacketReceive", packetHandler)

MagLib.BDO.Net.Receiver = Receiver
