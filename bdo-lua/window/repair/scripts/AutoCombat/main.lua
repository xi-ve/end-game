Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function() 
    AutoCombat.Start()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function() 
    AutoCombat.Stop()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    AutoCombat.OnPulse()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    AutoCombat.OnGuiDraw()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", function()
    AutoCombat.OnRenderD2D()
  end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnSelfActionChanged", AutoCombat.OnSelfActionChanged)