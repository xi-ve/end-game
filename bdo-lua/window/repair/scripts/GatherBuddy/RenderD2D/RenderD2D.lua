local onRenderD2D = function()
    MagLib.onRenderD2D()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnRenderD2D", onRenderD2D)