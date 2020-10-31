MagLib.BDO.Events.CharacterChanged = {}
local activated = false
MagLib.BDO.Events.CharacterChanged.activate = function()
	if activated then
		return
	else
		activated = true
	end

	-- Module
	local module = MagLib.Run.Modules.RunModule("Character Changed Observer", 1000, 2500,
                                            	MagLib.Run.Modules.TimingMode.TimedNonCritical,
                                            	MagLib.Run.EPulseTimingMode.Beginning)
	local savedName = MagLib.BDO.Actors.LocalPlayer.get():getName()
	module.run = function()
		local name = MagLib.BDO.Actors.LocalPlayer.get():getName()
		if savedName ~= name then
			MagLib.Events.triggerEvent("CharacterChanged", {oldName = savedName, newName = name})
			savedName = MagLib.BDO.Actors.LocalPlayer.get():getName()
		end
	end

	module.start()
	MagLib.Run.Modules.Handler.addModule(module)
end
