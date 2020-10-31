FishHookedState = { }
FishHookedState.__index = FishHookedState
FishHookedState.Name = "FishHookedState"

setmetatable(FishHookedState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function FishHookedState.new()
  local self = setmetatable({}, FishHookedState)

  self.localPlayer = Infinity.BDO.getLocalPlayer()

  self.lastValidationTick = 0  
  
  return self
end

function FishHookedState:NeedToRun()    
    if self.localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
      
    if self.lastValidationTick + 250 >= Infinity.Win32.GetTickCount() then
      return false
    end
       
    self.lastValidationTick = Infinity.Win32.GetTickCount()

    return self.localPlayer:getCharacterControler():getCurrentAnimation():getName() == "FISHING_HOOK_ING"
end

function FishHookedState:Run()      
    --print("Fish Hooked!")
    
    --Infinity.BDO.Input.PressKeys_Once({KeyCode_SPACE}, 50)
    Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
    Infinity.BDO.Input.setKeyInputFlagValue(0x20000)
end