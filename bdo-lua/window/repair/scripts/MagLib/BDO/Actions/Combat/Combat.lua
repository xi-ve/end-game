---Everything Combat related
-- @module MagLib.BDO.Actions.Combat
-- @alias Combat
local Combat = {}
--- Possible stances that a skill can be used in
Combat.SkillUseStances = {
	Normal = 1, -- Pre-Awakening
	Awakening = 2, -- Awakening
	Both = 3 -- Both Pre-Awakening and Awakening
}

---Does an Autoattack regardless of class.
-- Needs to be called at least every 50ms to maintain the AutoAttack. Else it will be canceled since the key is not pressed down anymore.
---@param position Vector3 towards which position the AutoAttacks should be directed
Combat.doAutoAttack = function(position)
	-- TODO: Replace with ActionSequence (for all classes and stances) after we figure out how.
	local changedSth = false
	-- Facing the target
	if not MagLib.BDO.Actors.LocalPlayer.faceTowards(position) then
		changedSth = true
	end
	-- Setting camera
	if not MagLib.BDO.Camera.setCamera(position) then
		changedSth = true
	end

	if changedSth then
		return false
	end
	MagLib.Input.press({KeyCode_LBUTTON}, 50)
	return true
end

MagLib.BDO.Actions.Combat = Combat
