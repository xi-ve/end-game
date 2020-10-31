AutoFood = { }
AutoFood.Running = false
AutoFood.Settings = Settings()

AutoFood.FSM = FSM()

function AutoFood.OnAutoLoginAutoLoad()
  AutoFood.StartBot()
end

function AutoFood.Start()
  AutoFood.LoadSettings()  
end

function AutoFood.Stop()
  AutoFood.SaveSettings()
end

function AutoFood.StartBot()
  if NewConditionWindow.Show then
    print("Not able to start cause New Conditional Buff Window is still opened!")
    return
  end

  print("Started!")
  
  AutoFood.FSM = FSM()

  AutoFood.FSM:AddState(ApplyConditionalBuffs())  

  AutoFood.Running = true
end

function AutoFood.StopBot()
  AutoFood.Running = false

  print("Stopped!")
end

function AutoFood.OnPulse()
  if AutoFood.Running == false then
    return
  end
    
  AutoFood.FSM:Pulse()
end

function AutoFood.OnGuiDraw()
	MainWindow.DrawMainWindow()
  NewConditionWindow.DrawMainWindow()
end

function AutoFood.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoFood.Settings))
end

function AutoFood.LoadSettings()
    local json = JSON:new()
    AutoFood.Settings = Settings()
    
    table.merge(AutoFood.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end