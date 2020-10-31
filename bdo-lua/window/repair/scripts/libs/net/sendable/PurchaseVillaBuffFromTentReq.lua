PurchaseVillaBuffFromTentReq = { }
PurchaseVillaBuffFromTentReq.__index = PurchaseVillaBuffFromTentReq

setmetatable(PurchaseVillaBuffFromTentReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PurchaseVillaBuffFromTentReq.new()
  local self = setmetatable({}, PurchaseVillaBuffFromTentReq)   
  
  self.Name = "PurchaseVillaBuffFromTentReq"

  self.isEncrypted = false
  self.opCode = OpCodes.getReqOpCode("PurchaseVillaBuffFromTent") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  return self
end

function PurchaseVillaBuffFromTentReq:construct(buffIndex)

  self.Packet.byteBuffer:putEmptyBytes(PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.Size)

  self.Packet.byteBuffer:_put(1, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.FixValue01)
  self.Packet.byteBuffer:_putInt(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.FixValue02)
  self.Packet.byteBuffer:_putInt(-1, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.FixValue02 + 4)
  self.Packet.byteBuffer:_putShort(buffIndex, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.BuffIndex)
  self.Packet.byteBuffer:_putShort(1, self.rawDataOffset + PacketStruct_Offsets.REQ.PurchaseVillaBuffFromTentReq.FixValue03)
  
  return self
end