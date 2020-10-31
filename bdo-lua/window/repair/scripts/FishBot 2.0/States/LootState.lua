LootState = { }
LootState.__index = LootState
LootState.Name = "LootState"

setmetatable(LootState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LootState.new()
  local self = setmetatable({}, LootState)
      
  self.localPlayer = Infinity.BDO.getLocalPlayer()
    
  return self
end

function LootState:NeedToRun()    
    if self.localPlayer:getIsDead() then
        return false
    end
          
    return UI.getShow("Panel_Window_Looting_All")
end

function LootState:Run()
  --print("LootState:Run()")
  
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

          --FishBot.addLootStats(itemId, itemName, itemCount)
        end
      end
    end  

    Infinity.BDO.Lua.Execute("Panel_Window_Looting_All:SetShow(false, false)")
end