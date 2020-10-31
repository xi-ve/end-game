Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function()
    Application.Start()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function()
    Application.Stop()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    Application.Pulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    UIManager.GUIDraw()
end)