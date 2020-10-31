SkillHelper = {}

function SkillHelper.getNextUsableSkillAction(skillActions, target)
	for kS,skillAction in pairs(skillActions) do
		if skillAction:canUse(target) then
			return skillAction
		end
	end

	return nil
end