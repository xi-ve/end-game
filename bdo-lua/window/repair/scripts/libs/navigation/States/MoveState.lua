MoveState = { }
MoveState.__index = MoveState
MoveState.Name = "MoveState"

setmetatable(MoveState, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function MoveState.new(profile, useTp)
  local self = setmetatable({}, MoveState) 
  
  self.Checkpoints = self:ConvertCheckpoints(profile.Checkpoints)

  self.MvmtController = Infinity.BDO.getLocalPlayer():getMovementControler()

  self.TotalCP = 0
  self.CurrentCPIndex = 1

  self.UseTp = false

  if useTp ~= nil and useTp then
    self.UseTp = true
  end

  self.Callbacks = 
  {
    DestinationReached = nil
  }

  self.ShouldRun = true

  self:Init()

  return self
end

function MoveState:ConvertCheckpoints(tCheckpoints)
  local tCP = {}

  for k,v in pairs(tCheckpoints) do
    table.insert(tCP, NavigatorUtils.TableToVec3(v))
  end

  return tCP
end

function MoveState:Init()
  self.TotalCP = table.length(self.Checkpoints)

  local closestCP = NavigatorUtils.GetClosestCheckpoint(self.Checkpoints, Infinity.BDO.getLocalPlayer():getPosition())

  if closestCP == nil then
    print("[MoveState] Could not find closest Checkpoint!")
    return
  end

  self.CurrentCPIndex = closestCP.Index

  print("[MoveState] " .. self.TotalCP .. " Checkpoints initiated!")
  print("[MoveState] Current Checkpoint Index: " .. self.CurrentCPIndex)
end

function MoveState:NeedToRun()
  if LocalPlayer.isDead() then
    return false
  end
  
  return self.ShouldRun
end

function MoveState:Run()
    local destDistance = self:GetCurrent():getDistance(Infinity.BDO.getLocalPlayer():getPosition())

    if destDistance <= 100 then
      --print("destDistance <= 100")

      if not self.UseTp and self.MvmtController:getIsMoving() then
        self:ResetMvmtController()
      end

      self:OnDestinationReached()

      self:SetNext()
    elseif destDistance >= 1500 then
      --print("destDistance >= 1500")

      if not NavigatorUtils.isNavMoving() then
        NavigatorUtils.moveToAutoPath(self:GetCurrent())
      end
    else
      --print("destDistance else")

      local canMoveNext = false

      --print("isMoving: " .. tostring(self.MvmtController:getIsMoving()))
      if not self.UseTp and not self.MvmtController:getIsMoving() then
        canMoveNext = true
      elseif self.UseTp then
        canMoveNext = true
      end

      if canMoveNext then
        --print("canMoveNext")
        self:MoveTo(self:GetCurrent())
      else
        --print("not canMoveNext")
        --aldrdy moving
      end
    end
end

function MoveState:OnDestinationReached() 
  if self.Callbacks.DestinationReached == nil then
    return
  end

  self.Callbacks.DestinationReached()
end

function MoveState:SetCallback_DestinationReached(func)
  self.Callbacks.DestinationReached = func
end

function MoveState:MoveTo(dest)

  if not self.UseTp then

    self.MvmtController:setDestination(dest)
    self.MvmtController:setOrigin(Infinity.BDO.getLocalPlayer():getPosition())
    self.MvmtController:setIsMoving(true)
  else

    Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(Vector3(dest.X, dest.Y + 25, dest.Z))
  end
end

function MoveState:ResetMvmtController()
  self.MvmtController:setIsMoving(false)
  self.MvmtController:setDestination(Vector3(0,0,0))
  self.MvmtController:setOrigin(Vector3(0,0,0))
end

function MoveState:GetCurrent()
  return self.Checkpoints[self.CurrentCPIndex]
end

function MoveState:GetNext()
  if self.CurrentCPIndex == self.TotalCP then
    return self.Checkpoints[1]
  end

  return self.Checkpoints[self.CurrentCPIndex + 1]
end

function MoveState:SetNext()
  if self.CurrentCPIndex == self.TotalCP then
    self.CurrentCPIndex = 1
    return
  end

  self.CurrentCPIndex = self.CurrentCPIndex + 1
end

function MoveState:GetPrevious()
  if self.CurrentCPIndex == 1 then
    return self.Checkpoints[self.TotalCP]
  end

  return self.Checkpoints[self.CurrentCPIndex - 1]
end

function MoveState:SetPrevious()
  if self.CurrentCPIndex == 1 then
    self.CurrentCPIndex = self.TotalCP
    return
  end

  self.CurrentCPIndex = self.CurrentCPIndex - 1
end
