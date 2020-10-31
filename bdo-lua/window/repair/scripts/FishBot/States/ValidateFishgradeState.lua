ValidateFishgradeState = { }
ValidateFishgradeState.__index = ValidateFishgradeState
ValidateFishgradeState.Name = "Validate Fishgrade"

setmetatable(ValidateFishgradeState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ValidateFishgradeState.new()
  local self = setmetatable({}, ValidateFishgradeState) 
  self.lastValidationTick = 0  
  self.currentAction = ""
  return self
end

function ValidateFishgradeState:NeedToRun()
    
    if not FishBot.Settings.PredictMode.Enabled then
      return false
    end

    if localPlayer:getIsDead() then
        return false
    end
        
    if not Equip.hasFishingRodEquipped() then
        return false
    end
        
    if self.lastValidationTick + 250 >= Infinity.Win32.GetTickCount() then
      return false
    end

    if (FishBot.Settings.NearbyPlayersStopPredict or FishBot.Settings.NearbyPlayersFishingStop) and localPlayer:getIsOtherPlayersNearby() then            
      return false
    end

    self.currentAction = localPlayer:getCharacterControler():getCurrentAnimation():getName()

    return self.currentAction == "FISHING_WAIT"
end

function ValidateFishgradeState:Run()      
    self.lastValidationTick = Infinity.Win32.GetTickCount()

    --if FishBot.Settings.Speedhack.Enabled then
      --Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
    --end

    if not FishBot.isValidFishgrade(Fishing.getFishGrade()) then
      print("Fishgrade doesnt match. Switching Rod!")

      local nextRodSlot = Inventory.getNextFishingRodSlot()
      local nextMainhandSlot = -1--Inventory.getNextMainhandSlot()
      
      if nextRodSlot ~= -1 then
        Equip.equip(nextRodSlot)
        print("Equipped New Rod!")
        FishBot.EquipRodState.skipNextCheck = true
      elseif nextMainhandSlot ~= -1 then
        Equip.equip(nextMainhandSlot)
        print("Equipped Mainhand!")        
      else
        Equip.unequip(0)
        print("Unequipped Rod!")
      end      
    end
end