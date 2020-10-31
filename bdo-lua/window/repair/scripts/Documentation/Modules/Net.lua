---@class SocketConnection
local SocketConnection = {}

---Returns the name of the connections
---@return string name
function SocketConnection:getName()
end

---Returns true if the given selection is still alive
---@return boolean isAlive
function SocketConnection:isAlive()
end

---Sends the data of a bytebuffer over the SocketConnetion
---@param bb ByteBuffer
---@return boolean success
function SocketConnection:sendData(bb)
end

---@class TCPSocketManager
local TCPSocketManager = {}

---Returns a table with all SocketConnections where the key is the name of the connection and the value is the SocketConnection object
---@return table<string,SocketConnection> connections
function TCPSocketManager:getSocketConnections()
end

---Returns the SocketConnection with a given name. Nil if no connection with the name exists
---@param name string
---@return SocketConnection socketConnection
function TCPSocketManager:getSocketConnection(name)
end

---Creates a new connection
---@param name string
---@param ip string
---@param port string
---@return boolean success
function TCPSocketManager:newConnection(name, ip, port)
end

---Closes a connection with the given name
---@param name string
---@return boolean success
function TCPSocketManager:closeConnection(name)
end

Infinity.Net = {}

---Sends a ByteBuffer as packet to the Game servers.
---@param bb ByteBuffer
---@param packetName string
function Infinity.Net.Send(bb, packetName)
end

---Makes the game think it received a given ByteBuffer from the game server
---@param bb ByteBuffer
function Infinity.Net.Receive(bb)
end

---Gets the TCPSocketManager which allows creation of TCP Connections, from which you can send and receive data
---@return TCPSocketManager tcpSocketManager
function TCPSocketManager.getTCPSocketManager()
end
