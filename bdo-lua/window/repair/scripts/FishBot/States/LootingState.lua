LootingState = { }
LootingState.__index = LootingState
LootingState.Name = "Looting"

setmetatable(LootingState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LootingState.new()
  local self = setmetatable({}, LootingState) 
  self.lastValidationTick = 0 
  return self
end

function LootingState:NeedToRun()
    
    if localPlayer:getIsDead() then
        return false
    end
        
    if self.lastValidationTick + 500 >= Infinity.Win32.GetTickCount() then
      return false
    end

    return UI.getShow("Panel_Window_Looting_All")
end

function LootingState:Run()      
    print("Looting!")

    self.lastValidationTick = Infinity.Win32.GetTickCount()  

    --if FishBot.Settings.Speedhack.Enabled then
      --Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
    --end

    for i=0, 11 do
      if Looting.hasItem(i) then
        local itemId = Looting.getItemId(i)
        
        if itemId ~= nil and FishBot.isValidItemId(itemId, i) then
          local itemName = Looting.getItemName(i)
          local itemCount = Looting.getItemCount(i)
          
          if itemCount == nil then
            itemCount = 1
          end

          Looting.pickItem(i, itemCount)

          FishBot.addLootStats(itemId, itemName, itemCount)
        end
      end
    end  

    Infinity.BDO.Lua.Execute("Panel_Window_Looting_All:SetShow(false, false)")
end