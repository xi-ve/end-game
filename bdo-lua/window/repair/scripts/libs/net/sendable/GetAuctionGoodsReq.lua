GetAuctionGoodsReq = { }
GetAuctionGoodsReq.__index = GetAuctionGoodsReq

setmetatable(GetAuctionGoodsReq, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function GetAuctionGoodsReq.new()
  local self = setmetatable({}, GetAuctionGoodsReq)   
  
  self.Name = "ListAuctionGoodsVer2Req"
   
  self.isEncrypted = true  
  self.opCode = OpCodes.getReqOpCode("ListAuctionGoodsVer2") 
  self.rawDataOffset = 5

  self.Packet = Packet(self.isEncrypted, self.opCode, self.Name)
  
  -- manual offset update here cause autogen cant handle this yet
  self.Size = 21    -- total data - 5(header)

  self.Offsets = 
  {
    AuctionType = 0x6, --eDataType_BYTE               
    PageIndex = 0x2, --eDataType_DWORD      
    SkillFilter = 0xD, --eDataType_BYTE       
    GenderFilter = 0xC, --eDataType_WORD      
    TierFilter = 0x7, --eDataType_WORD      
    NpcActorKey = 0xF, --eDataType_DWORD 
    IsNpcShop = 0xE, --eDataType_BYTE  
  }  

  return self
end

function GetAuctionGoodsReq:construct(auctionType, skillFilter, tierFilter, pageIndex, npcActorKey, genderFilter, isNpcShop)  
    
  self.Packet.byteBuffer:putEmptyBytes(self.Size)

  self.Packet.byteBuffer:_put(auctionType, self.rawDataOffset + self.Offsets.AuctionType)     -- 4 fix for Horse Market   -- CppEnums.AuctionType
  self.Packet.byteBuffer:_putInt(pageIndex, self.rawDataOffset + self.Offsets.PageIndex)  
  self.Packet.byteBuffer:_put(skillFilter, self.rawDataOffset + self.Offsets.SkillFilter)
  self.Packet.byteBuffer:_put(genderFilter, self.rawDataOffset + self.Offsets.GenderFilter)  
  self.Packet.byteBuffer:_putShort(tierFilter, self.rawDataOffset + self.Offsets.TierFilter)  
  self.Packet.byteBuffer:_putInt(npcActorKey, self.rawDataOffset + self.Offsets.NpcActorKey)
  self.Packet.byteBuffer:_put(isNpcShop, self.rawDataOffset + self.Offsets.IsNpcShop)         -- 0|1

  return self
end