local indexCounter = 0

MagLib.Net.Tcp.Packet = function(name, opCode)
	indexCounter = indexCounter + 1
	local Packet = {name = name, opCode = opCode, data = MagLib.Core.VariableCollection(), index = indexCounter}
	Packet.reset = function()
		Packet.data = nil
	end

	Packet.getByteBuffer = function()
		-- Making a new ByteBuffer which will have the opCode and the data
		local dataBB = Packet.data.toByteBuffer()
		local bb = ByteBuffer(Packet.data.size + 4)
		bb:putShort(Packet.opCode)
		bb:putShort(MagLib.CurrentScriptuID)

		-- Copying bytes from data => bb
		for i = 0, dataBB.size - 1 do
			local byte = dataBB:get()
			bb:put(byte)
		end

		return bb
	end

	Packet = setmetatable(Packet, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			return "Packet " .. n.name .. " ( " .. opCode .. ")"
		end
	})

	return Packet
end
