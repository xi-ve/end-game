Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function() 
    App.Start()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function() 
    App.Stop()
    end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
    App.OnGuiDraw()
  end)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnLuaLoadComplete", function()
    App.OnLuaLoadComplete()
  end)