FishBot = { }
FishBot.Running = false
FishBot.Navigator = Navigator()

FishBot.Settings = Settings()

FishBot.FSM = FSM()

FishBot.LootStats = {}
FishBot.GradeStats = {[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0}
FishBot.StartTick = 0
FishBot.UpTime = 0

FishBot.AvailableDurability = 0
FishBot.StartDurability = 0
FishBot.DurabilityPerHour = 0

FishBot.FreeInventorySlots = 0

FishBot.FishingSpot = nil
FishBot.TentSpot = nil

FishBot.TeleportState = TeleportState()
FishBot.CheckSpotState = CheckSpotState()
FishBot.SpotTeleportState = SpotTeleportState()

FishBot.ItemMarketState = ItemMarketState()
FishBot.RepairState = RepairState()
FishBot.TransferToContainerState = TransferToContainerState()
FishBot.TradeState = TradeState()
FishBot.VendorState = VendorState()

FishBot.StartFishingState = StartFishingState()
FishBot.CancelFishingState = CancelFishingState()

FishBot.DetectionStopState = DetectionStopState()

function FishBot.AddGradeToStats(grade)
  if grade == nil or grade < 0 or grade > 4 then
    return
  end

  FishBot.GradeStats[grade] = FishBot.GradeStats[grade] + 1
end

function FishBot.ResetStats()
  FishBot.StartTick = Infinity.Win32.GetTickCount()
  FishBot.UpTime = 0

  FishBot.LootStats = {}
  FishBot.GradeStats = {[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0}

  FishBot.AvailableDurability = 0
  FishBot.StartDurability = 0
  FishBot.DurabilityPerHour = 0

  FishBot.FreeInventorySlots = 0
end

function FishBot.OnAutoLoginAutoLoad()
  FishBot.StartBot()
end

function FishBot.Start()
  FishBot.LoadSettings()

  FishBot.FishingSpot = Vector3(FishBot.Settings.FishingSpot.X, FishBot.Settings.FishingSpot.Y, FishBot.Settings.FishingSpot.Z)
  FishBot.TentSpot = Vector3(FishBot.Settings.TentSpot.X, FishBot.Settings.TentSpot.Y, FishBot.Settings.TentSpot.Z)
end

function FishBot.StartBot()
  FishBot.TeleportState = TeleportState()
  FishBot.CheckSpotState = CheckSpotState()
  FishBot.SpotTeleportState = SpotTeleportState()

  FishBot.ItemMarketState = ItemMarketState()
  FishBot.RepairState = RepairState()
  FishBot.TransferToContainerState = TransferToContainerState()
  FishBot.TradeState = TradeState()
  FishBot.VendorState = VendorState()

  FishBot.StartFishingState = StartFishingState()
  FishBot.CancelFishingState = CancelFishingState()

  FishBot.DetectionStopState = DetectionStopState()

  FishBot.FSM = FSM()   

  FishBot.FSM:AddState(CheckVisibleUiState()) 
  FishBot.FSM:AddState(GetStatsState())

  FishBot.FSM:AddState(FishBot.TeleportState)
  FishBot.FSM:AddState(FishBot.CheckSpotState)

  FishBot.FSM:AddState(FishBot.VendorState)
  FishBot.FSM:AddState(FishBot.TradeState)
  FishBot.FSM:AddState(FishBot.ItemMarketState)
  FishBot.FSM:AddState(FishBot.RepairState)
  FishBot.FSM:AddState(FishBot.TransferToContainerState)

  FishBot.FSM:AddState(FishBot.SpotTeleportState)

  FishBot.FSM:AddState(FishBot.DetectionStopState)
  FishBot.FSM:AddState(UnableToSkipState())

  FishBot.FSM:AddState(DeleteRodState()) 

  FishBot.FSM:AddState(EquipRodState()) 
  FishBot.FSM:AddState(FishBot.StartFishingState)  
  FishBot.FSM:AddState(FishBot.CancelFishingState)
  FishBot.FSM:AddState(FishHookedState())
  FishBot.FSM:AddState(CatchFishMinigameState())
  FishBot.FSM:AddState(LootState())

  FishBot.ResetStats()
  
  FishBot.FishingSpot = Vector3(FishBot.Settings.FishingSpot.X, FishBot.Settings.FishingSpot.Y, FishBot.Settings.FishingSpot.Z)
  FishBot.TentSpot = Vector3(FishBot.Settings.TentSpot.X, FishBot.Settings.TentSpot.Y, FishBot.Settings.TentSpot.Z)

  FishBot.Running = true	
end

function FishBot.Stop()
  FishBot.SaveSettings()  
end

function FishBot.StopBot()
  FishBot.Running = false  
end

function FishBot.OnPulse()
  FishBot.Navigator:OnPulse()

  if FishBot.Running == false then
    return
  end
  
  FishBot.UpTime = Infinity.Win32.GetTickCount() - FishBot.StartTick
  
  FishBot.FSM:Pulse()
end

function FishBot.OnGuiDraw()
	MainWindow.DrawMainWindow()
  FishBot.Navigator:OnGuiDraw()
end

function FishBot.RenderSpot()  
  RenderHelper.DrawWorldCircle(FishBot.FishingSpot, 60, "FF00FF00", 5, false)
  RenderHelper.DrawWorldText("Fishing Spot", 16, "FFFF0000", FishBot.FishingSpot, 0, 20)

  RenderHelper.DrawWorldCircle(FishBot.TentSpot, 60, "FF00FF00", 5, false)
  RenderHelper.DrawWorldText("Tent Spot", 16, "FFFF0000", FishBot.TentSpot, 0, 20)
end

function FishBot.OnRenderD2D()
  FishBot.Navigator:OnRenderD2D()

  if FishBot.Settings.RenderSpot then
    FishBot.RenderSpot()
  end
end

function FishBot.OnInventoryAddItem(args)	
  if not FishBot.Running then
    return
  end
	

  local itemId = tonumber(args[1])
  local slot = tonumber(args[2])

  local itemName = Inventory.getItemName(slot)

  if itemName == nil then
    itemName = "nA."
  end

  FishBot.addLootStats(itemId, itemName, 1)  
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

function FishBot.onFishingTime(packet)
  packet:parse()

  FishBot.CancelFishingState.Cache_CatchTime = packet.Parsed.NextCatchTime

  if not FishBot.isValidFishgrade(packet.Parsed.Grade) then

    FishBot.CancelFishingState:Run()
  end
end

function FishBot.OnPacketReceive(byteBuffer)  
  byteBuffer:skip(3)
  local opCode = byteBuffer:getShort()
   
  if OpCodes.getAckName(opCode) == "StartActionNak" and FishBot.TeleportState.TeleportMove then
    FishBot.TeleportState:SetNext()
  elseif OpCodes.getAckName(opCode) == "GetTradeShopItems" then
    --print("GetTradeShopItems")
    FishBot.TradeState:onGetTradeShopItems(GetTradeShopItems(byteBuffer))
  elseif OpCodes.getAckName(opCode) == "FishingTime" then
    FishBot.onFishingTime(FishingTimeAck(byteBuffer))
  end
end

function FishBot.isValidFishgrade(fishgrade)
  if not FishBot.Settings.PredictGrades.White.Enabled and not FishBot.Settings.PredictGrades.Green.Enabled and not FishBot.Settings.PredictGrades.Blue.Enabled and not FishBot.Settings.PredictGrades.Yellow.Enabled and not FishBot.Settings.PredictGrades.Orange.Enabled then
    return true
  end

  if fishgrade == White and FishBot.Settings.PredictGrades.White.Enabled then
    return true
  elseif fishgrade == Green and FishBot.Settings.PredictGrades.Green.Enabled then
    return true
  elseif fishgrade == Blue and FishBot.Settings.PredictGrades.Blue.Enabled then
    return true
  elseif fishgrade == Yellow and FishBot.Settings.PredictGrades.Yellow.Enabled then
    return true
  elseif fishgrade == Orange and FishBot.Settings.PredictGrades.Orange.Enabled then
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