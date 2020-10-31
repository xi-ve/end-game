AddDeadBodiesAck = { }
AddDeadBodiesAck.__index = AddDeadBodiesAck

setmetatable(AddDeadBodiesAck, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function AddDeadBodiesAck.new(byteBuffer)
  local self = setmetatable({}, AddDeadBodiesAck)   
    
  self.isEncrypted = false
  self.opCode = OpCodes.getAckOpCode("AddDeadBodys")
  self.minDataSize = OpCodes.getAckMinDataSizeByOpCode(self.opCode)
  self.maxDataSize = OpCodes.getAckMaxDataSizeByOpCode(self.opCode)
  self.rawDataOffset = 5

  self.headerDataSize = self.minDataSize
  self.deadBodyEntryDataSize = PacketStruct_Offsets.ACK.AddDeadBodys.DeadBodyEntrySize
  self.maxDeadBodyEntries = (self.maxDataSize - self.minDataSize)/self.deadBodyEntryDataSize

  self.Packet = Packet(self.isEncrypted, self.opCode, "", byteBuffer)

  return self
end

function AddDeadBodiesAck:parse()
  self.Parsed = {}
      
  self.Parsed.Count = self.Packet.Data:_getShort(self.rawDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.Count)
    
  self.Parsed.Bodies = {}

  for i = 0, self.Parsed.Count - 1 do

    local entryDataOffset = self.rawDataOffset + (self.deadBodyEntryDataSize * i)

    local body = {}
        
    body.ActorId = self.Packet.Data:_getShort(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.ActorId)
    body.ActorKey = self.Packet.Data:_getInt(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.ActorKey)
        
    local x = self.Packet.Data:_getFloat(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.PosX)
    local y = self.Packet.Data:_getFloat(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.PosX + 4)
    local z = self.Packet.Data:_getFloat(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.PosX + 8)
    body.Position = Vector3(x, y, z)
    
    body.HasLoot = self.Packet.Data:_get(entryDataOffset + PacketStruct_Offsets.ACK.AddDeadBodys.HasLoot) == 0

    table.insert(self.Parsed.Bodies, body)
  end 

  return self
end

function AddDeadBodiesAck:construct()

  return self
end