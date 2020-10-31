local Teleport = {}
Teleport.allowWithPlayers = false
Teleport.lastTpTime = 0
local getTime = MagLib.getTime
local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos

function Teleport.isTpAllowed()
	local settings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph")

	if not settings.use_tp then
		return false
	end

	if Infinity.Whitelist.IsNonWhitelistedPlayerStreamed() and not Teleport.allowWithPlayers then
		return false
	end

	return true
end

function Teleport.tpTo(dest, force, maxDistance, delay)

	local settings = MagLib.Core.Settings.getSetting("MagLib_Navigation_Graph")
	if not force and not Teleport.isTpAllowed() then
		return false
	end

	local time = getTime()

	maxDistance = maxDistance or settings.tp_maxDistance
	delay = delay or settings.tp_delay

	-- print("MAYBE? Time since last tp: " .. (time - Teleport.lastTpTime))
	if Teleport.lastTpTime + delay > time then
		return false
	end
	-- print("TP DONE: Time since last tp: " .. (time - Teleport.lastTpTime))
	Teleport.lastTpTime = time

	local from = getPPos()

	if Infinity.BDO.getLocalPlayer():getMovementControler():getIsMoving() then
		Infinity.BDO.getLocalPlayer():getMovementControler():setIsMoving(false)
	end

	local distance = from:getDistance(dest)

	if distance > maxDistance then
		local rVec = MagLib.BDO.Raycast.rVec(from, dest) -- rVec always has length 1
		rVec = MagLib.Utils.Vector.multiply(rVec, maxDistance * 0.9) -- Makes it not too long
		rVec = Vector3(rVec.X, rVec.Y, rVec.Z)
		dest = MagLib.Utils.Vector.addition(from, rVec)

		rVec = nil
	end
	dest = Vector3(dest.X, dest.Y + settings.tp_height_offset, dest.Z)
	Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(dest)

	distance = nil
	dest = nil
	from = nil
	time = nil

	return true
end

MagLib.BDO.Navigation.Graph.Teleport = Teleport
