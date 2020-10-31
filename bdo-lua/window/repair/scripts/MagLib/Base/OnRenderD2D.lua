---Maglib Render2D2 call.
-- Should be called from your on onRenderD2D function. Not doing so results in no rendering from MagLibs side (which can be what you want, hence the option to not call it)
function MagLib.onRenderD2D()
	-- RenderModules
	MagLib.Events.triggerEvent("OnRenderStart")
	if MagLib.RenderManager then
		MagLib.RenderManager.onRenderD2D()
	end
end
