MagLib.BDO.Navigation = {}
MagLib.BDO.Navigation.Modes = {Graph = 1, Mesh = 2}
local settings = {navigationMode = MagLib.BDO.Navigation.Modes.Graph}
MagLib.BDO.Navigation.settings = settings

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

function MagLib.BDO.Navigation.moveTo(dest, isNode, stopDistance)
	if settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
			MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.moveTo(dest, isNode, stopDistance)
		end
	end
end

function MagLib.BDO.Navigation.activeMoveToNpc(actorData, stopDistance)
	local pos = Vector3(actorData.posX, actorData.posY, actorData.posZ)
	local pPos = getPPos()
	local distance = pos:getDistance(pPos)
	if distance < stopDistance then
		MagLib.BDO.Navigation.stop()
		return true
	else
		MagLib.BDO.Navigation.moveTo(pos, true, stopDistance)
		return false
	end
end

function MagLib.BDO.Navigation.stop()
	if settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
			MagLib.BDO.Navigation.Graph.stop()
		end
	end
	MagLib.BDO.Actors.LocalPlayer.stopMoving()
end

local onPulse_End = function()
	if settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
			MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.navigate()
		end
	end
end

MagLib.Events.addEventHandler("MagLib_OnPulse_End", onPulse_End)

function MagLib.BDO.Navigation.getCurrentDest()
	if settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
			return MagLib.BDO.Navigation.Graph.Profiles.currentProfile.nav.dest
		else
			return nil
		end
	end
end

function MagLib.BDO.Navigation.onRenderD2D()
	if settings.navigationMode == MagLib.BDO.Navigation.Modes.Graph then
		if MagLib.BDO.Navigation.Graph.Profiles.currentProfile then
			MagLib.BDO.Navigation.Graph.RenderD2D.onRenderD2D()
		end
	end
end

function MagLib.BDO.Navigation.pause()
	MagLib.BDO.Navigation.Graph.pause()
end

function MagLib.BDO.Navigation.unpause()
	MagLib.BDO.Navigation.Graph.unpause()
end

function MagLib.BDO.Navigation.init()
	MagLib.BDO.Navigation.Graph.Profiles.init()
end
