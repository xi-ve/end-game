TargetLock = { }
TargetLock.Settings = Settings()
TargetLock.Running = false
TargetLock.Target = nil

local PI = 3.14159265358979323846

function TargetLock.Start()
  TargetLock.LoadSettings()	    
end

function TargetLock.Stop()
  TargetLock.Running = false
  TargetLock.SaveSettings()
end

function TargetLock.Toggle()
  if TargetLock.Running then
    TargetLock.Running = false
    TargetLock.Target = nil
  else
    TargetLock.Running = true
  end
end

local nextCheckInterval = 100
local nextCheck = Infinity.Win32.GetTickCount() + nextCheckInterval

function TargetLock.checkKeyPressed()
  if Infinity.Win32.GetTickCount() < nextCheck then
    return
  end

  nextCheck = Infinity.Win32.GetTickCount() + nextCheckInterval

  if Infinity.BDO.Input.IsKeyPressed(VirtualKeys.Table[TargetLock.Settings.SelectedVKeyIndex]) then
    TargetLock.Toggle()
  end
end

function TargetLock.faceTarget()
  local targetPos = TargetLock.Target:getPosition()
  local rotFaceTarget = targetPos:getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
  local yawFaceTarget = rotFaceTarget - (2*PI)
  --local pitchFaceTarget = -0.8

  Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)
  Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
  --Infinity.BDO.getCameraManager():setPitch(pitchFaceTarget)  

  Infinity.BDO.Selection.setNewAttackTarget(TargetLock.Target:getActorKey())  
end

function TargetLock.lockTarget()
  if TargetLock.Target == nil then
    TargetLock.Target = Infinity.BDO.getLocalPlayer():getCrossHairTarget()

    if TargetLock.Target ~= nil and TargetLock.Target:getActorType() ~= EActorType_Player then
      TargetLock.Target = nil
    end

    return
  else
    if not TargetLock.Target:isValid() or TargetLock.Target:getIsDead() then

      TargetLock.Target = nil
      return
    end
  end

  TargetLock.faceTarget()
end

function TargetLock.OnPulse()
  TargetLock.checkKeyPressed()

  if TargetLock.Running == false then
    return
  end

  TargetLock.lockTarget()
end

function TargetLock.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function TargetLock.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(TargetLock.Settings))
end

function TargetLock.LoadSettings()
    local json = JSON:new()
    TargetLock.Settings = Settings()
    
    table.merge(TargetLock.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end