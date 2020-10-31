--[[

Contains methods to load and save
	- Profile json files
	- Settings json files

]]--

AmityMaster_Loader = { }

function AmityMaster_Loader.GetProfile(path) -- Returns profile object

	local profile = AmityMaster_Profile()
	AmityMaster_Loader.LoadFromJsonFile(profile, path)
	return profile

end

-- Save profile not really required atm

function AmityMaster_Loader.GetSettings() -- Returns settings object

	local settings = AmityMaster_Settings()
	AmityMaster_Loader.LoadFromJsonFile(settings, "Settings.json")
	return settings

end

function AmityMaster_Loader.SaveSettings(settings)
	AmityMaster_Loader.SaveToJsonFile(settings, "Settings.json")
end

function AmityMaster_Loader.SaveToJsonFile(t, path) -- Saves given table object to given path

	local json = JSON:new()
    Infinity.FileSystem.WriteFile(path, json:encode_pretty(t))

end

function AmityMaster_Loader.LoadFromJsonFile(t, path) -- Merges given table with the json file loaded from given path

	local json = JSON:new()
	table.merge(t, json:decode(Infinity.FileSystem.ReadFile(path)))

end

function AmityMaster_Loader.PrintSettings(settings) -- Testing purposes

	print (" -- Current settings -- ")
	
	print("Last used profile: " .. settings.lastProfileName)
	
	print(" -- End of settings -- ")

end

function AmityMaster_Loader.PrintProfile(profile) -- Testing purposes

	print(" -- Current profile -- ")
	
	print("NPC Name: " .. profile.npcName)
	print("Required Amity: " .. tostring(profile.requiredAmity))
	print("Buy Item: " .. tostring(profile.buyItem))
	print("Buy Item Name: " .. profile.buyItemName)
	print("Use warehouse money: " .. tostring(profile.useWarehouseMoney))
	
	print(" -- [WIN] -- ")
	for i = 1, #profile.win do
		print("#" .. i .. " " .. profile.win[i])
	end
	
	print(" -- [LOSE] -- ")
	for i = 1, #profile.lose do
		print("#" .. i .. " " .. profile.lose[i])
	end
	
	print(" -- End of profile -- ")

end