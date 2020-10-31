MagLib.Net.Tcp = {}
local connections = {}

MagLib.Net.Tcp.getConnections = function()
	return connections
end

MagLib.Net.Tcp.createConnection = function(name, host, port)
	local old_conn = MagLib.Net.Tcp.getConnection(name)
	if (old_conn ~= nil) then
		print("There already exists a TCP connection with the name " .. name)
		print("Using the same connection.")
		return old_conn
	end
	local conn = MagLib.Net.Tcp.Connection(name, host, port)
	table.insert(connections, conn)
	return conn
end

MagLib.Net.Tcp.getConnection = function(name)
	for k, v in pairs(connections) do
		if (v.name == name) then
			return v
		end
	end

	-- Mby a connection was created outside of .Connect(), then we return it
	local tmp = Infinity.Net.getTCPSocketManager():getSocketConnection(name)
	if tmp ~= nil then
		return tmp
	end

	return nil
end

-- Internal
function MagLib.Net.Tcp.onExit()
	--[[for k, v in pairs(connections) do
        MagLib.Net.Tcp.closeConnection(v:getName())
    end]]
end
