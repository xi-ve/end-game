AntiCC = { }

local action_damage_standup = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranch_ByName("DAMAGE_STANDUP")
local action_damage_bound_nomal = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranch_ByName("DAMAGE_BOUND_NOMAL")

function AntiCC.OnSelfActionChanged(action)
		
	if action == "DAMAGE_DOWN" then
		Infinity.BDO.ActionBranchManager.queueNextAction(action_damage_standup)
	elseif action == "DAMAGE_BOUND" then
		Infinity.BDO.ActionBranchManager.queueNextAction(action_damage_bound_nomal)
	end
end