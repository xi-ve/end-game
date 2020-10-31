local indexCounter = 0
local getTime = MagLib.getTime

MagLib.Net.Tcp.Connection = function(name, host, port, connection)
	indexCounter = indexCounter + 1
	local Connection = {name = name, index = indexCounter, conn = connection, LastSendPacketTime = -1}
	Connection.close = function()
		Infinity.Net.getTCPSocketManager():closeConnection(Connection.name)
	end

	Connection.connect = function()
		Infinity.Net.getTCPSocketManager():newConnection(name, host, port, true)
		Connection.conn = Infinity.Net.getTCPSocketManager():getSocketConnection(name)
	end

	Connection.sendPacket = function(packet)
		Connection.sendByteBuffer(packet.getByteBuffer())
	end

	Connection.sendByteBuffer = function(bb)
		Connection.conn:sendData(bb)
		Connection.LastSendPacketTime = getTime()
	end

	----------------------
	if Connection.conn == nil then
		Connection.connect()
	end

	return Connection
end
