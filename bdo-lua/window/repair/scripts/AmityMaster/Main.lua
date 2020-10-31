Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function()
	AmityMaster.settings = AmityMaster_Loader.GetSettings() 
	AmityMaster_Gui.RefreshAvailableProfiles()
	AmityMaster_Gui.SetProfilesSelectedIndexByName(AmityMaster.settings.lastProfileName)
	AmityMaster_Gui.ResizeAutoFit()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function()
    AmityMaster_Loader.SaveSettings(AmityMaster.settings)
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function() 
    AmityMaster_Gui.OnDrawGui()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    AmityMaster.OnPulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", function()
    AmityMaster.OnAutoLoginAutoLoad()
end)

-- Helper function for ternary operations
function ternary(cond, T, F)
	if cond then return T else return F end
end