MagLib.Run.Modules = {}
MagLib.Run.Modules.TimingMode = {
	TimedCritical = 1, -- Tried to be executed as close to minInterval as possible
	TimedNonCritical = 2, -- Executes it if over minInterval and performance is okay.
	Exact = 3 -- Will execute on (nearly)the exact ms of minInterval (mby some ms off due to how ticks work or even more if other modules with Exact or TimedCritical Mode lock up the tick by big calculations)
}

MagLib.Run.Modules.onPulse_Beginning = function()
	MagLib.Run.Modules.Handler.onPulse_Beginning()
end

MagLib.Run.Modules.onPulse_End = function()
	MagLib.Run.Modules.Handler.onPulse_End()
end
