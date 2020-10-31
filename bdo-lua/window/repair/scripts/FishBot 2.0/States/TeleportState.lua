TeleportState = { }
TeleportState.__index = TeleportState
TeleportState.Name = "TeleportState"

setmetatable(TeleportState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function TeleportState.new()
  local self = setmetatable({}, TeleportState) 
  
  self.TpPacket = DoActionTeleport():construct(0,0,0)
  
  self.TeleportMove = false

  self.Profiles = {}

  self.CurrentProfile = nil
  
  self.CurrentCPIndex = 1
  self.TotalCP = 0

  self.DestinationIndex = 1

  self.Reverse = false
  self.Step = 1

  self.LastTick = 0

  self.localPlayer = Infinity.BDO.getLocalPlayer()
  self.characterController = self.localPlayer:getCharacterControler()
  self.characterScene = self.localPlayer:getCharacterControler():getCharacterScene()

  self.lastTick_HiddenTravel = 0
  self.CurrentAction = ""
  self.wasCrouched = false

  self:init() 

  return self
end

function TeleportState:init()  
  local files = Infinity.FileSystem.GetFiles("\\NavigatorProfiles\\*.json")

  for k,v in pairs(files) do      
    local json = JSON:new()
    local t = {}    

    table.merge(t, json:decode(Infinity.FileSystem.ReadFile("NavigatorProfiles\\" .. v)))
        
    if FishBot.Settings.Paths.Repair ~= "" and t.Name == FishBot.Settings.Paths.Repair then
      t.Checkpoints = self:ConvertCheckpoints(t.Checkpoints)
      table.insert(self.Profiles, t)
    elseif FishBot.Settings.Paths.Market ~= "" and t.Name == FishBot.Settings.Paths.Market then
      t.Checkpoints = self:ConvertCheckpoints(t.Checkpoints)
      table.insert(self.Profiles, t)
    elseif FishBot.Settings.Paths.Storage ~= "" and t.Name == FishBot.Settings.Paths.Storage then
      t.Checkpoints = self:ConvertCheckpoints(t.Checkpoints)
      table.insert(self.Profiles, t)
    elseif FishBot.Settings.Paths.Trade ~= "" and t.Name == FishBot.Settings.Paths.Trade then
      t.Checkpoints = self:ConvertCheckpoints(t.Checkpoints)
      table.insert(self.Profiles, t)
    elseif FishBot.Settings.Paths.Vendor ~= "" and t.Name == FishBot.Settings.Paths.Vendor then
      t.Checkpoints = self:ConvertCheckpoints(t.Checkpoints)
      table.insert(self.Profiles, t)
    end
  end
end

function TeleportState:NeedToRun()            
    return self.TeleportMove
end

function TeleportState:Reset()
  self.TeleportMove = false

  self.CurrentProfile = nil
  
  self.CurrentCPIndex = 1
  self.TotalCP = 0

  self.DestinationIndex = 1

  self.Reverse = false
  self.Step = 1  

  self.wasCrouched = false

  Actor.setAction("WAIT")
  Infinity.BDO.Input.clearQueue()
end

function TeleportState:HiddenTravel()
  --print("TeleportState:HiddenTravel")
  if self.lastTick_HiddenTravel + 1000 > Infinity.Win32.GetTickCount() then
    return
  end

  self.lastTick_HiddenTravel = Infinity.Win32.GetTickCount()

  if self.characterScene:getAnimationSpeed() > 1.0 then
    self.characterScene:setAnimationSpeed(1.0)
  end

  if Equip.hasAnyFishingRodEquipped() then    
    --Equip.unequip(0)

    local mhSlot = Inventory.getNextMainhandSlot()

    if mhSlot ~= -1 then
      Equip.equip(mhSlot, 0)
    end
  end

  if not LocalPlayer.getIsHiddenName() then
    --print("Trying to equip Camo")
    local normalEquipped = false

    for k,v in pairs(Statics.Camouflage.Normal) do
      local slot = Inventory.getCashItemSlotItemId(v)

      if slot ~= 0 then
        --print("Equipping " .. slot)
        Equip.equipCash(slot)  
        normalEquipped = true
      end
    end

    if not normalEquipped then
      for k,v in pairs(Statics.Camouflage.Desert) do
      local slot = Inventory.getCashItemSlotItemId(v)

      if slot ~= 0 then
        --print("Equipping " .. slot)
        Equip.equipCash(slot)
      end
    end
    end    
  end
end

function TeleportState:Run() 
  --print("TeleportState:Run() ")
  
  if self.LastTick + FishBot.Settings.TeleportDelay > Infinity.Win32.GetTickCount() then
    return
  end

  self.LastTick = Infinity.Win32.GetTickCount()

  self.CurrentAction = self.characterController:getCurrentAnimation():getName()

  self.CurrentCPIndex = self:GetClosestNodeIndex()

  if self.CurrentCPIndex == self.DestinationIndex then
    self:Reset()
    return
  end

  self:HiddenTravel()
    
  if FishBot.Settings.UseCrouchWhileTeleport and not self.wasCrouched and string.find(self.CurrentAction, "WAIT") ~= nil then    

    if string.find(self.CurrentAction, "HUNKERDOWN_CREEP_WAIT") ~= nil then
      
      Infinity.BDO.Input.clearQueue()
      self.wasCrouched = true
      return
    end

    Infinity.BDO.Input.clearQueue()

    if string.find(self.CurrentAction, "HUNKERDOWN_WAIT") == nil then
      --print("trying to crouch")
      Infinity.BDO.Input.PressKeys_Once({KeyCode_Q}, 50)
    else
      self.wasCrouched = true
    end

    return
  end

  local destDistance = self:GetCurrent():getDistance2D(Infinity.BDO.getLocalPlayer():getPosition())

  if destDistance <= 100 then
      
    self:SetNext()
  end

  self:teleportToCoords(self:GetCurrent().X, self:GetCurrent().Y + FishBot.Settings.VerticalOffset, self:GetCurrent().Z) 
end

function TeleportState:SetPath(profileName, reverse)  
    print("TeleportState:SetPath ProfileName: " .. profileName)

    self.Reverse = reverse

    if self.Reverse then
      self.Step = -1
    end
    
    for k,v in pairs(self.Profiles) do      
        if v.Name == profileName then
          self.CurrentProfile = v
          break
        end
    end

    if self.CurrentProfile ~= nil then      
      self.TotalCP = table.length(self.CurrentProfile.Checkpoints)

      self.DestinationIndex = self.TotalCP

      if reverse then
        self.DestinationIndex = 1
      end

      local closestCP = NavigatorUtils.GetClosestCheckpoint(self.CurrentProfile.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition())

      if closestCP ~= nil then
        self.CurrentCPIndex = closestCP.Index 
      end
    else

      print("Could not find any profile for path!")
      return
    end

    print("Set New Path")
    --print("ProfileName: " .. self.CurrentProfile.Name)
    --print("Checkpoints: " .. table.length(self.CurrentProfile.Checkpoints))
    --print("Current CP: " .. self.CurrentCPIndex)
    --print("Destination CP: " .. self.DestinationIndex)
    --print("Reverse: " .. tostring(self.Reverse))

    if FishBot.Settings.AutoDelay then
      local nodeStepSize = self.CurrentProfile.Checkpoints[1]:getDistance2D(self.CurrentProfile.Checkpoints[2])
      FishBot.Settings.TeleportDelay = math.floor(0.3 * nodeStepSize)

      if FishBot.Settings.TeleportDelay < 20 then
        FishBot.Settings.TeleportDelay = 20
      end
    end

    self.TeleportMove = true
end

function TeleportState:ConvertCheckpoints(tCheckpoints)
  local tCP = {}

  for k,v in pairs(tCheckpoints) do
    table.insert(tCP, NavigatorUtils.TableToVec3(v))
  end

  return tCP
end

function TeleportState:GetClosestNodeIndex()
  return NavigatorUtils.GetClosestCheckpointByJSONTable(self.CurrentProfile.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition()).Index
end

function TeleportState:GetCurrent()
  return self.CurrentProfile.Checkpoints[self.CurrentCPIndex]
end

function TeleportState:GetNext()
if not self.Reverse then  
  if self.CurrentCPIndex == self.TotalCP then
    return self.CurrentProfile.Checkpoints[1]
  end
else
  if self.CurrentCPIndex == 1 then
    return self.CurrentProfile.Checkpoints[self.TotalCP]
  end
end

  return self.CurrentProfile.Checkpoints[self.CurrentCPIndex + self.Step]
end

function TeleportState:SetNext()
if not self.Reverse then  
  if self.CurrentCPIndex == self.TotalCP then
    self.CurrentCPIndex = 1
    return
  end
else
  if self.CurrentCPIndex == 1 then
    self.CurrentCPIndex = self.TotalCP
    return
  end
end

  self.CurrentCPIndex = self.CurrentCPIndex + self.Step
end

function TeleportState:GetPrevious()
if not self.Reverse then  
  if self.CurrentCPIndex == 1 then
    return self.CurrentProfile.Checkpoints[self.TotalCP]
  end
else
  if self.CurrentCPIndex == self.TotalCP then
    return self.CurrentProfile.Checkpoints[1]
  end
end

  return self.CurrentProfile.Checkpoints[self.CurrentCPIndex - self.Step]
end

function TeleportState:SetPrevious()
if not self.Reverse then  
  if self.CurrentCPIndex == 1 then
    self.CurrentCPIndex = self.TotalCP
    return
  end
else
  if self.CurrentCPIndex == self.TotalCP then
    self.CurrentCPIndex = 1
    return
  end
end

  self.CurrentCPIndex = self.CurrentCPIndex - self.Step
end

function TeleportState:teleportToCoords(x, y, z)
    
    --self.TpPacket:update(x,y,z).Packet:send()

    Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(Vector3(x,y,z))
    --Infinity.BDO.Input.PressKeys_Down({KeyCode_SPACE})    
end