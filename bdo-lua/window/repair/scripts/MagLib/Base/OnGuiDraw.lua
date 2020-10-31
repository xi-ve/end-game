--[[
	Making this local since there is no need for an outside script to manage it (Like for onPulse and onRenderD2D)
	Most UI stuff will still be called from the actual script rather than here.
]] local drawUI = function()
	-- UI stuff

	-- Popups
	MagLib.UI.Popups.draw()
end

local draw = true
local onGuiDraw = function()
	-- Load new theme if new one was selected
	if MagLib.UI.ThemeEngine.selectThemeIndex ~= 0 and MagLib.UI.ThemeEngine.selectThemeIndex ~=
		MagLib.UI.ThemeEngine.currentThemeIndex then
		MagLib.UI.ThemeEngine.selectTheme(MagLib.UI.ThemeEngine.selectThemeIndex)
	end

	-- Draw stuff
	if draw then
		MagLib.Core.Try(drawUI, function(error)
			print("Error in UI: " .. tostring(error))
			draw = false
		end)
	end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", onGuiDraw)
