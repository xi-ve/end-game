local currentRegionKey = MagLib.BDO.getCurrentRegionKey()

local module = MagLib.Run.Modules.RunModule("Region Observer", 500, 2500,
                                            MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                            MagLib.Run.EPulseTimingMode.Beginning)

module.run = function()
	local regionKey = MagLib.BDO.getCurrentRegionKey()
	if regionKey ~= currentRegionKey then
		-- Region key changed
		MagLib.Events.triggerEvent("SwitchedRegion", {oldRegionKey = currentRegionKey, newRegionKey = regionKey})
		currentRegionKey = regionKey
	end
end
module.start()
MagLib.Run.Modules.Handler.addModule(module)
