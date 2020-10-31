Packet = { }
Packet.__index = Packet

setmetatable(Packet, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Packet.new(isEncrypted, opCode, name, byteBuffer)
  local self = setmetatable({}, Packet)   
  
  if byteBuffer == nil then

    self.opCode = opCode    
    self.isEncrypted = 0
    self.Name = name

    if isEncrypted then
      self.isEncrypted = 1
    end

    self.byteBuffer = ByteBuffer(1)

    --[[Construct Packet Header]]--
    self.byteBuffer:putShort(0)
    self.byteBuffer:put(self.isEncrypted)
    self.byteBuffer:putShort(self.opCode)
  else
    
    self.Data = byteBuffer
    self.Data:setReadPos(5)
    self.Data:setWritePos(5)
  end  

  return self
end

function Packet:fromArray(tArray) --packet body data without first 5 bytes(header)
  self.byteBuffer:setWritePos(5)

  for k,v in pairs(tArray) do
    self.byteBuffer:put(v)
  end

  return self
end

function Packet:toString()
  local column = 0
  local text = ""

  for i = 0, self.byteBuffer.size - 1 do
    
    local b = self.byteBuffer:get()

    text = text .. string.format("%02X", b) .. " "

    column = column + 1

    if column == 16 then

      text = text .. "\n"
      column = 0
    end
  end

  return text
end

function Packet:send()
  self.byteBuffer:_putShort(self.byteBuffer.size, 0)

  Infinity.Net.Send(self.byteBuffer, self.Name)
end

function Packet:receive()
  self.byteBuffer:_putShort(self.byteBuffer.size, 0)

  Infinity.Net.Receive(self.byteBuffer)
end