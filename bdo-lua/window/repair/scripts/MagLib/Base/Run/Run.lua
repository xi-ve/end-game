MagLib.Run = {}
MagLib.Run.verboseLogging = false

function MagLib.Run.onPulse_Beginning()
	MagLib.Run.Tasks.onPulse_Beginning()
	MagLib.Run.Modules.onPulse_Beginning()
end

function MagLib.Run.onPulse_End()
	MagLib.Run.Tasks.onPulse_End()
	MagLib.Run.Modules.onPulse_End()
end
