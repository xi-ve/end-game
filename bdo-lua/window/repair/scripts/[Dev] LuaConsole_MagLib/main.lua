Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
  LuaMainWindow:OnDrawGuiCallback()
end )

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
	if MagLib.onPulse_Beginning() then
		return
	end
	MagLib.onPulse_End()
end)
