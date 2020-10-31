StartFishingState = { }
StartFishingState.__index = StartFishingState
StartFishingState.Name = "Start Fishing"

setmetatable(StartFishingState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function StartFishingState.new()
  local self = setmetatable({}, StartFishingState)
  Infinity.BDO.Input.clearQueue()

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.characterController = self.localPlayer:getCharacterControler()

  self.totalCasts = 0
  
  self.lastRun = 0

  return self
end

function StartFishingState:NeedToRun()    
    if self.localPlayer:getIsDead() then
        return false
    end
       
    if self.lastRun + 400 > Infinity.Win32.GetTickCount() then
      --return false
    end

    self.lastRun = Infinity.Win32.GetTickCount()

    if not Equip.hasFishingRodEquipped() then
        return false
    end
        
    return  LocalPlayer.hasFreeWeight() and
            Inventory.getFreeSlotCount()  > 1 and
            self.characterController:getCurrentAnimation():getName() == "WAIT" and 
            FishBot.SpotTeleportState.isFishingSpot --and Infinity.BDO.Input.isEmptyQueue()    
end

function StartFishingState:Run()
  --print("StartFishingState:Run()") 

  local curDirection = self.localPlayer:getCharacterControler():getCharacterScene():getRotation()

  if string.format("%.1f", curDirection) ~= string.format("%.1f", FishBot.Settings.FishingSpotDirection) then
    self.localPlayer:getCharacterControler():getCharacterScene():setRotation(FishBot.Settings.FishingSpotDirection)
    print("Changed Direction")
    return
  end

  for k,v in pairs(Statics.SplatFisher) do
      local slot = Inventory.getCashItemSlotItemId(v)

      if slot ~= 0 then
        --print("Equipping " .. slot)
        Equip.equipCash(slot)         
      end
    end

  FishBot.AddGradeToStats(Fishing.getFishGrade())

  --Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 50) 
  Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
  Infinity.BDO.Input.setKeyInputFlagValue(0x20000)

  self.totalCasts = self.totalCasts + 1    
end