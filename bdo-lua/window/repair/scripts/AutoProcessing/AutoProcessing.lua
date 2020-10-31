AutoProcessing = {}
AutoProcessing.Running = false
AutoProcessing.Settings = Settings()
AutoProcessing.StartTick = 0
AutoProcessing.UpTime = 0

AutoProcessing.FSM = FSM()
AutoProcessing.StopProcessingState = nil
AutoProcessing.StartProcessingState = nil
AutoProcessing.InventoryCleanState = nil

function AutoProcessing.OnAutoLoginAutoLoad()
	AutoProcessing.StartBot()
end

function AutoProcessing.Start()
	AutoProcessing.LoadSettings()
end

function AutoProcessing.Stop()
	AutoProcessing.SaveSettings()
end

function AutoProcessing.StartBot()
	print("Started!")

	AutoProcessing.StartTick = Infinity.Win32.GetTickCount()
	AutoProcessing.UpTime = 0

	AutoProcessing.FSM = FSM()

	AutoProcessing.StopProcessingState = StopProcessingState()
	AutoProcessing.StartProcessingState = StartProcessingState()
	AutoProcessing.InventoryCleanState = InventoryCleanState()

	AutoProcessing.FSM:AddState(CheckStopState())
	AutoProcessing.FSM:AddState(AutoProcessing.StopProcessingState)
	AutoProcessing.FSM:AddState(AutoProcessing.InventoryCleanState)
	AutoProcessing.FSM:AddState(AutoProcessing.StartProcessingState)

	AutoProcessing.Running = true
end

function AutoProcessing.StopBot()
	AutoProcessing.Running = false

	print("Stopped!")
end

function AutoProcessing.OnPulse()
	if AutoProcessing.Running == false then
		return
	end

	AutoProcessing.UpTime = Infinity.Win32.GetTickCount() - AutoProcessing.StartTick

	AutoProcessing.FSM:Pulse()
end

function AutoProcessing.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function AutoProcessing.SaveSettings()
	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoProcessing.Settings))
end

function AutoProcessing.LoadSettings()
	local json = JSON:new()
	AutoProcessing.Settings = Settings()

	table.merge(AutoProcessing.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function AutoProcessing.shouldMoveToWarehouse(itemId)
	for k, v in pairs(AutoProcessing.Settings.MoveToWarehouse) do
		if v.ItemId == itemId then
			return true
		end
	end

	return false
end
