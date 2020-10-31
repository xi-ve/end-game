PetFeed = { }
PetFeed.Settings = Settings()
PetFeed.Running = false

PetFeed.LastCheck = 0

function PetFeed.Start()
  	PetFeed.Running = true
	    
	PetFeed.LoadSettings()
end

function PetFeed.Stop()
  PetFeed.Running = false  

  PetFeed.SaveSettings()
end

function PetFeed.tryFeedPets()
	print("Trying to feed Pets!")

	if not Pets.hasUnsealedPets() then
		print("No Unsealed Pets found!")
		return
	end

	if not Pets.hasPetFood() then
		print("No Petfood found!")
		return
	end

	Pets.feedAll(0)
	print("Feeding Done!")
end

function PetFeed.OnPulse()
  if PetFeed.Running == false then
    return
  end

  if PetFeed.LastCheck + ((PetFeed.Settings.CheckInterval * 60) * 1000) <= Infinity.Win32.GetTickCount() then
  	PetFeed.LastCheck = Infinity.Win32.GetTickCount()

  	PetFeed.tryFeedPets()
  end
end

function PetFeed.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function PetFeed.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(PetFeed.Settings))
end

function PetFeed.LoadSettings()
    local json = JSON:new()
    PetFeed.Settings = Settings()
    
    table.merge(PetFeed.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end