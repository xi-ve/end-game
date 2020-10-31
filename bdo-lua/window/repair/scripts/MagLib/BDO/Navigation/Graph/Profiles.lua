MagLib.BDO.Navigation.Graph.Profiles = {}
local profileDirectory = "\\Profiles"
MagLib.BDO.Navigation.Graph.Profiles.currentProfile = nil
MagLib.BDO.Navigation.Graph.Profiles.availableProfiles = {}

local settings = {currentProfile_Name = ""}

MagLib.Core.Settings.addSettingsToHandler("MagLib_Navigation_Profiles", settings)

function MagLib.BDO.Navigation.Graph.Profiles.init()
	MagLib.BDO.Navigation.Graph.Profiles.refreshProfiles()
end

function MagLib.BDO.Navigation.Graph.Profiles.loadLastProfileFromSettings()
	local curProf = settings.currentProfile_Name
	if curProf and curProf ~= "" then
		MagLib.BDO.Navigation.Graph.Profiles.loadProfile(curProf)
	end
end
-- Reload profile when swapping settingsprofile
MagLib.Events.addEventHandler("SettingsProfileLoaded", MagLib.BDO.Navigation.Graph.Profiles.loadLastProfileFromSettings)

function MagLib.BDO.Navigation.Graph.Profiles.newProfile(name)
	MagLib.logger.info("Creating new Profile " .. name)
	if MagLib.BDO.Navigation.Graph.Profiles.currentProfile ~= nil then
		MagLib.BDO.Navigation.Graph.Profiles.unloadProfile()
	end
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile = MagLib.BDO.Navigation.Graph.Profile(name)
	MagLib.BDO.Navigation.Graph.Profiles.saveProfile()

	MagLib.Events.triggerEvent("ProfileChanged")
end

function MagLib.BDO.Navigation.Graph.Profiles.unloadProfile()
	if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
		MagLib.logger.info("Unloading current Profile")
		MagLib.BDO.Navigation.Graph.Profiles.currentProfile.onUnload()
		MagLib.BDO.Navigation.Graph.Profiles.currentProfile = nil
	end

	MagLib.Events.triggerEvent("ProfileChanged")
end

function MagLib.BDO.Navigation.Graph.Profiles.saveProfile()
	local profile = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	if profile then
		local raw = profile.toRaw()
		local name = profile.name

		MagLib.logger.info("Saving profile with the name " .. name)

		local fileName = profileDirectory .. "\\" .. name .. ".json"

		local json_string = JSON:encode_pretty(raw)
		Infinity.FileSystem.WriteFile(fileName, json_string)
	end
	MagLib.BDO.Navigation.Graph.Profiles.refreshProfiles()
end

function MagLib.BDO.Navigation.Graph.Profiles.loadProfile(name)
	MagLib.logger.info("Loading profile with the name " .. tostring(name))
	local fileName = profileDirectory .. "\\" .. name .. ".json"
	local json = Infinity.FileSystem.ReadFile(fileName)
	local raw = JSON:decode(json)
	if raw.navGraph and raw.navGraph.connections then
		MagLib.logger.info("Converting legacy Profile to new Profile structure...")
		raw = MagLib.BDO.Navigation.Graph.Profiles.convertToRawFromLegacy(raw)
	end
	if MagLib.BDO.Navigation.Graph.Profiles.currentProfile ~= nil then
		MagLib.BDO.Navigation.Graph.Profiles.unloadProfile()
	end
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile = MagLib.BDO.Navigation.Graph.Profile(name)
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile.initFromRaw(raw)
	settings.currentProfile_Name = name

	MagLib.Events.triggerEvent("ProfileChanged")
end

function MagLib.BDO.Navigation.Graph.Profiles.getCurrentProfileIndex()
	local current = MagLib.BDO.Navigation.Graph.Profiles.currentProfile
	if current then
		for k, profile in ipairs(MagLib.BDO.Navigation.Graph.Profiles.availableProfiles) do
			if current.name == profile then
				return k
			end
		end
	end
	return -1
end

function MagLib.BDO.Navigation.Graph.Profiles.getCurrentProfile()
	return MagLib.BDO.Navigation.Graph.Profiles.currentProfile
end

function MagLib.BDO.Navigation.Graph.Profiles.refreshProfiles()
	MagLib.BDO.Navigation.Graph.Profiles.availableProfiles = {} -- Reset table on refresh for now
	local _profiles_dir = profileDirectory .. "\\*.json"
	local _profiles = Infinity.FileSystem.GetFiles(_profiles_dir)
	for _, name in ipairs(_profiles) do
		table.insert(MagLib.BDO.Navigation.Graph.Profiles.availableProfiles, name:sub(1, name:len() - 5))
	end
end

function MagLib.BDO.Navigation.Graph.Profiles.convertToRawFromLegacy(raw)
	local new = {}
	new.areas = raw.areas
	new.npcs = raw.npcs

	new.graph = {}
	new.graph.graph = {nodes = {}, edges = {}}
	for k, v in pairs(raw.navGraph.nodes) do
		table.insert(new.graph.graph.nodes, {X = v.X, Y = v.Y, Z = v.Z, index = v.Id})
	end

	for k, v in pairs(raw.navGraph.connections) do
		for _, toCon in pairs(v) do
			table.insert(new.graph.graph.edges, {fromIndex = k, toIndex = toCon})
		end
	end

	new.graph.key_graph = {nodes = {}, edges = {}}

	return new
end
