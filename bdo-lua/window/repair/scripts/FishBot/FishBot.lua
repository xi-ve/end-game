FishBot = { }
FishBot.Running = false
FishBot.Settings = Settings()
FishBot.StartTick = 0
FishBot.UpTime = 0

FishBot.AvailableDurability = 0
FishBot.StartDurability = 0
FishBot.DurabilityPerHour = 0

FishBot.LootStats = {}

FishBot.FSM = FSM()
FishBot.EquipRodState = nil
FishBot.FishHookedState = nil

localPlayer = nil

function FishBot.Start() 
	FishBot.LoadSettings() 	
end

function FishBot.Stop()
  FishBot.Running = false 

  Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)

  FishBot.SaveSettings()   
end

function FishBot.StartBot()
    localPlayer = Infinity.BDO.getLocalPlayer()

  	FishBot.FSM = FSM()

    FishBot.EquipRodState = EquipRodState()
    FishBot.FishHookedState = FishHookedState()
    
    FishBot.FSM:AddState(GetStatsState())
    FishBot.FSM:AddState(CheckVisibleUiState())
    FishBot.FSM:AddState(RepairState())
    FishBot.FSM:AddState(SpeedhackState())
    FishBot.FSM:AddState(CheckStopState())
    FishBot.FSM:AddState(DeleteRodState())
  	FishBot.FSM:AddState(FishBot.EquipRodState)
  	FishBot.FSM:AddState(StartFishingState())
  	FishBot.FSM:AddState(ValidateFishgradeState())
  	FishBot.FSM:AddState(FishBot.FishHookedState)
  	FishBot.FSM:AddState(CatchFishMinigameState())
    FishBot.FSM:AddState(LootingState())
    --FishBot.FSM:AddState(MakePuzzleState())

    FishBot.StartTick = Infinity.Win32.GetTickCount()
    FishBot.UpTime = 0

    FishBot.AvailableDurability = 0
    FishBot.StartDurability = 0
    FishBot.DurabilityPerHour = 0
    
	 FishBot.Running = true
end

function FishBot.StopBot()
  FishBot.Running = false

  Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
 
  FishBot.inventoryInit = false
end

function FishBot.OnPulse()
  if FishBot.Running == false then
    return
  end

  FishBot.UpTime = Infinity.Win32.GetTickCount() - FishBot.StartTick

  FishBot.FSM:Pulse()
end

function FishBot.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function FishBot.OnRenderD2D()  
  if not FishBot.Settings.TentRepair then
    return
  end

  local tent = Servant.getTent()

  if tent == nil then
    return
  end

    local lpPos = Infinity.BDO.getLocalPlayer():getPosition()

    RenderHelper.DrawWorldCircle(tent:getPosition(), 30, "FF00FF00", 1, true)

    local lineColor = "FF00FF00"

    if tent:getPosition():getDistance(lpPos) > 1000 then
      lineColor = "FFFF0000"
    end

    RenderHelper.DrawWorldLine(lpPos, tent:getPosition(), lineColor, 2)
    RenderHelper.DrawWorldText("Auto Repair(Tent)", 16, "FFFF0000", tent:getPosition(), 0, 20)
end

function FishBot.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(FishBot.Settings))
end

function FishBot.LoadSettings()
    local json = JSON:new()
    FishBot.Settings = Settings()
    
    table.merge(FishBot.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end

function FishBot.isValidFishgrade(fishgrade)
  if not FishBot.Settings.PredictGrades.White.Enabled and not FishBot.Settings.PredictGrades.Green.Enabled and not FishBot.Settings.PredictGrades.Blue.Enabled and not FishBot.Settings.PredictGrades.Yellow.Enabled and not FishBot.Settings.PredictGrades.Orange.Enabled then
    return true
  end

	if fishgrade == EItemGrade_White and FishBot.Settings.PredictGrades.White.Enabled then
		return true
	elseif fishgrade == EItemGrade_Green and FishBot.Settings.PredictGrades.Green.Enabled then
		return true
	elseif fishgrade == EItemGrade_Blue and FishBot.Settings.PredictGrades.Blue.Enabled then
		return true
	elseif fishgrade == EItemGrade_Yellow and FishBot.Settings.PredictGrades.Yellow.Enabled then
    return true
	elseif fishgrade == EItemGrade_Orange and FishBot.Settings.PredictGrades.Orange.Enabled then
		return true
	end

	return false
end

function FishBot.isValidItemId(itemId, slot)
  if FishBot.Settings.AllLoot.Enabled then
    return true
  end

  if table.length(FishBot.Settings.Items) <= 0 then

    return FishBot.isValidGrade(itemId, slot)
  end
  
  if table.find(FishBot.Settings.Items, itemId) ~= nil or FishBot.isValidGrade(itemId, slot) then
    return true
  end
  
  return false
end

function FishBot.isValidGrade(itemId, slot)
  if not FishBot.Settings.CatchGrades.White.Enabled and not FishBot.Settings.CatchGrades.Green.Enabled and not FishBot.Settings.CatchGrades.Blue.Enabled and not FishBot.Settings.CatchGrades.Yellow.Enabled and not FishBot.Settings.CatchGrades.Orange.Enabled then
    return false
  end

  local grade = Looting.getItemGrade(slot)

  if grade == 0 and FishBot.Settings.CatchGrades.White.Enabled then
    return true
  elseif grade == 1 and FishBot.Settings.CatchGrades.Green.Enabled then
    return true
  elseif grade == 2 and FishBot.Settings.CatchGrades.Blue.Enabled then
    return true
  elseif grade == 3 and FishBot.Settings.CatchGrades.Yellow.Enabled then
    return true
  elseif grade == 4 and FishBot.Settings.CatchGrades.Orange.Enabled then
    return true
  end

  return false
end

function FishBot.addLootStats(itemId, itemName, itemCount)
  if table.findKey(FishBot.LootStats, itemId) == nil then
    FishBot.LootStats[itemId] = {Name = itemName, Count = itemCount}
  else
    FishBot.LootStats[itemId].Count = FishBot.LootStats[itemId].Count + itemCount
  end
end