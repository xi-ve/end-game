WorkerFeed = { }
WorkerFeed.Settings = Settings()
WorkerFeed.Running = false

WorkerFeed.LastCheck = 0

function WorkerFeed.Start()
  	WorkerFeed.Running = true
	    
	WorkerFeed.LoadSettings()
end

function WorkerFeed.Stop()
  WorkerFeed.Running = false  

  WorkerFeed.SaveSettings()
end

function WorkerFeed.tryRepeatWorkers()
  print("Trying to repeat all Workers!")

  Workers.repeatAll()
  print("All Worker Tasks Repeated!")
end

function WorkerFeed.tryRestoreWorkers()
	print("Trying to restore Workers!")

  if Workers.getWorkerCount() == 0 then
    print("No Workers found!")
    return
  end

  if not Workers.hasRecoveryItems() then
    print("No Recovery Item found!")
    return
  end	

  Workers.recoverAll(0)
  print("Recovered All Worker!")
end

function WorkerFeed.OnPulse()
  if WorkerFeed.Running == false then
    return
  end

  if WorkerFeed.LastCheck + ((WorkerFeed.Settings.CheckInterval * 60) * 1000) <= Infinity.Win32.GetTickCount() then
  	WorkerFeed.LastCheck = Infinity.Win32.GetTickCount()

  	WorkerFeed.tryRestoreWorkers()

    if WorkerFeed.Settings.RepeatAll then
      WorkerFeed.tryRepeatWorkers()
    end
  end
end

function WorkerFeed.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function WorkerFeed.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(WorkerFeed.Settings))
end

function WorkerFeed.LoadSettings()
    local json = JSON:new()
    WorkerFeed.Settings = Settings()
    
    table.merge(WorkerFeed.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end