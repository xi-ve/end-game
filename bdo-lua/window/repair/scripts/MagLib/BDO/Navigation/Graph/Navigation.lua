MagLib.BDO.Navigation.Graph = {}
MagLib.BDO.Navigation.Graph.settings = {
	-- Teleport
	tp_delay = 200,
	tp_maxDistance = 300,
	use_tp = true,
	tp_height_offset = 30,
	-- Pathing
	skip_path_nodes = true,
	emulate_human_movement = false,
	interpolation_movement_smoothness = 3,
	interpolation_path_smoothness = 3,
	use_T2 = true,

	-- Stop distances
	stop_distance_nodes = 100,
	stop_distance_npc = 250
}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Navigation_Graph", MagLib.BDO.Navigation.Graph.settings)

MagLib.BDO.Navigation.Graph.lastJumpTime = 0

function MagLib.BDO.Navigation.Graph.moveTo(dest, isNode)
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.moveTo(dest, isNode)
end

function MagLib.BDO.Navigation.Graph.stop()
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.stop()
end

function MagLib.BDO.Navigation.Graph.onPulse_End()
	if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
		MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.navigate()
	end
end

function MagLib.BDO.Navigation.Graph.getCurrentDest()
	if MagLib.BDO.Navigation.Graph.Profiles.currentProfie then
		return MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.dest
	else
		return nil
	end
end

function MagLib.BDO.Navigation.Graph.pause()
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.paused = true
end

function MagLib.BDO.Navigation.Graph.unpause()
	MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.paused = false
end
