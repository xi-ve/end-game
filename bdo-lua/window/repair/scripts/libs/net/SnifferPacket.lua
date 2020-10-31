SnifferPacket = { }
SnifferPacket.__index = SnifferPacket

setmetatable(SnifferPacket, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function SnifferPacket.new(byteBuffer, name, isIncoming)
  local self = setmetatable({}, SnifferPacket)   
  
  self.isIncoming = isIncoming

  self.data = byteBuffer:clone()

  self.length = self.data:getShort()  
  self.isEncrypted = self.data:get()
  self.opCode = self.data:getShort()

  self.Name = name

  if isIncoming then
    self.Name = OpCodes.getAckName(self.opCode)
  else
    self.Name = OpCodes.getReqName(self.opCode)
  end
    
  self:resetBufferPositions()

  return self
end

function SnifferPacket:dumpToFile(directory)
  local direction = "[IN]"
  local name = self.Name

  if not self.isIncoming then
    direction = "[OUT]"      
  end

  if name == "" or name == "nA." then
    name = tostring(self.opCode)
  end

  local filename = directory .. tostring(Infinity.Win32.GetTickCount()) .. "_" .. direction .. "_" .. name .. "_" .. self.length .. ".bin"

  Infinity.FileSystem.WriteBinaryFile(filename, self.data)
end

function SnifferPacket:resetBufferPositions()
  self.data:setReadPos(0)
  self.data:setWritePos(0)
end

function SnifferPacket:send() 
  self.data:_put(1, 2)
  Infinity.Net.Send(self.data, self.Name)
end

function SnifferPacket:receive()
  Infinity.Net.Receive(self.data)
end