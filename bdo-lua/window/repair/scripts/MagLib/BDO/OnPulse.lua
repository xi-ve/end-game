local onPulse = function()
	if not MagLib.disableNav then
		MagLib.BDO.Navigation.onPulse_End()
	end
end
MagLib.Events.addEventHandler("MagLib_OnPulse", onPulse)
