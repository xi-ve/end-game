Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart",Grinder.start)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", Grinder.stop)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", Grinder.onGuiDraw)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", Grinder.onPulse)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", Grinder.OnRenderD2D)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", Grinder.OnAutoLoginAutoLoad)


--Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnLuaLoadComplete", function() end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnSelfActionChanged", Grinder.OnSelfActionChanged)
--Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPacketReceive", Grinder.OnPacketReceive)
