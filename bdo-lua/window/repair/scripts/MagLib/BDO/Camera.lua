--- Camera handling
-- @module MagLib.BDO.Camera
-- @alias Camera
local Camera = {}
local getPPos = MagLib.BDO.Actors.LocalPlayer.getPosition

---Grabs camera position
-- @return Vector3 camera position
Camera.getPos = function()
	return Infinity.BDO.getCameraManager():getCameraPosition()
end

---Returns camera yaw
-- @return number camera yaw
Camera.getYaw = function()
	return Infinity.BDO.getCameraManager():getYaw()
end

Camera.setYaw = function(v)
	Infinity.BDO.getCameraManager():setYaw(v)
end

---Returns camera pitch
---@eturn number camera pitch
Camera.getPitch = function()
	return Infinity.BDO.getCameraManager():getPitch()
end

Camera.setPitch = function(v)
	return Infinity.BDO.getCameraManager():setPitch(v)
end

---Sets camera to look towards a specific position.
---@param to Vector3 of what to look at
Camera.setCamera = function(to)
	local PI = MagLib.Utils.Math.PI

	Infinity.BDO.getCameraManager():setPitch(-0.8)

	local rotFaceTarget = to:getRotationToFace(getPPos())
	local yawFaceTarget = MagLib.Utils.Math.normalizeYaw(rotFaceTarget - (2 * PI))
	local curYaw = Camera.getYaw()
	if MagLib.Utils.Math.compareFloats(curYaw, yawFaceTarget, 1) then
		return true
	else
		Camera.setYaw(yawFaceTarget)
		return false
	end
end

MagLib.BDO.Camera = Camera
