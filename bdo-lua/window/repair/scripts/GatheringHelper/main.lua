Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function() 
    GatheringHelper.Start()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function() 
    GatheringHelper.Stop()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    GatheringHelper.OnPulse()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    GatheringHelper.OnGuiDraw()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", function()
    GatheringHelper.OnRenderD2D()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", function()
    GatheringHelper.OnAutoLoginAutoLoad()
  end)