Skills = {}

function Skills.isLearned(skillNo)
	local code =
	[[
		local skillStatic = getSkillStaticStatus(]] .. skillNo .. [[, 1)

		if skillStatic == nil then
			return false
		end

		local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()

		if skillTypeSSW == nil then
			return false
		end

		local level = getLearnedSkillLevel(skillTypeSSW)

		return level >= 1
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Skills.getRequired(skillNo)
	local code =
	[[
		local requiredMP = -1
		local requiredStamina = -1
		local reuseCycle = -1

		local skillStatic = getSkillStaticStatus(]] .. skillNo .. [[, 1)

		if skillStatic ~= nil then
			requiredMP = skillStatic:get()._requireMp
			requiredStamina = skillStatic:get()._requireSp
			reuseCycle = skillStatic:get()._reuseCycle
		end

		return requiredMP, requiredStamina, reuseCycle
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function Skills.getIsUsableWhileInCoolTime(skillNo)
	local code =
	[[		
		local skillStatic = getSkillStaticStatus(]] .. skillNo .. [[, 1)

		if skillStatic ~= nil then
			return skillStatic:get():isUsableWhileInCoolTime()
		end

		return false
	]]

	return Infinity.BDO.Lua.Execute(code)
end