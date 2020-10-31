local indexCounter = 0

local getPPos = MagLib.BDO.Actors.LocalPlayer.getPos
local getTime = MagLib.getTime

local base_comboTimeout = 3500
local skillTimeout = 1000

local Table = MagLib.Utils.Table

MagLib.BDO.Actions.Combat.inCombo = false

MagLib.BDO.Actions.Combat.Combo = function(name)
	local CM = MagLib.BDO.Actions.Combat.CombatManager

	indexCounter = indexCounter + 1
	local Combo = {
		index = indexCounter,
		name = name,
		comboTimeout = base_comboTimeout,
		skillTimeout = skillTimeout,
		skills = {}
	}

	Combo.addSkill = function(skill)
		table.insert(Combo.skills, {skill = skill, used = false})
		Combo.comboTimeout = Combo.comboTimeout + 200
	end

	Combo.canUse = function()

	end

	Combo.onFinish = function()
	end

	Combo.use = function(position)

	end

	function Combo:toString()
		return ('Combo: %s |'):format(self.name)
	end
	Combo = setmetatable(Combo, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			return n:toString()
		end
	})

	return Combo
end
