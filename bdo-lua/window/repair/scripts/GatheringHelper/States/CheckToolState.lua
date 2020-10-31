CheckToolState = { }
CheckToolState.__index = CheckToolState
CheckToolState.Name = "CheckToolState"

setmetatable(CheckToolState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function CheckToolState.new()
  local self = setmetatable({}, CheckToolState) 
    
  self.noTools = false

  return self
end

function CheckToolState:NeedToRun()
  if LocalPlayer.isDead() then
    return false
  end
  
  if not Equip.hasToolEquipped() then
    return false
  end

  if self.noTools then
    return false
  end

  return Equip.getToolDurability() <= 0
end

function CheckToolState:Run()      
    local invSlot = Inventory.getNextToolSlot()

    if invSlot == -1 then
      if Equip.hasToolEquipped() then
        Equip.unequip(2)
      end

      self.noTools = true
      return
    end

    Equip.equip(invSlot)  
end