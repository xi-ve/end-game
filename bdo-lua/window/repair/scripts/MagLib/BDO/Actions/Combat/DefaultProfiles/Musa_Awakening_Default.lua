local Profile = {}
local Actions = MagLib.BDO.Actions
local Combat = Actions.Combat
local CM = Combat.CombatManager
local Skill = Combat.Skill
local Stances = Combat.SkillUseStances
local LocalPlayer = MagLib.BDO.Actors.LocalPlayer
-- Examble settings file
local settings = {exampleSettingsTable = {exampleBool = true, exampleNumber = 123.456, exampleString = "Mag > Reff"}}
MagLib.Core.Settings.addSettingsToHandler("Musa_Awakening_Default", settings) -- MagLibs settings handler is persistent. This table will always be saved in ScriptFolder/Settings/settingsName.json. The initial values are the default values and will be overwritten with the ones from the settings file upon adding it to the settings handler.

-- Skills

-- Dashes
local chaseActionSeq = Actions.ActionSequence("BT_ARO_DASH_F2_START", {"BT_ARO_DASH_F2_END"}, nil, 0)
chaseActionSeq.keys = {KeyCode_W, KeyCode_RBUTTON}
local chase = Skill("Chase", {1455, 1456, 1457}, Stances.Both, chaseActionSeq)

-- Spammer
local dividerActionSeq = Actions.ActionSequence("BT_skill_GhostSword_D_1AT", {"BT_skill_GhostSword_D_2AT"}, nil, 0)
dividerActionSeq.keys = {KeyCode_E}
local divider = Skill("Divider", {1285, 1286, 1287, 1288, 425, 3162}, Stances.Normal, dividerActionSeq)
divider.forceCooldown(0)

-- AOE
local btbActionSeq = Actions.ActionSequence("BT_ARO_Skill_Low_Swing_3Lv", {"BT_ARO_Skill_Low_Swing_End"}, nil, 0)
btbActionSeq.keys = {KeyCode_SHIFT, KeyCode_LBUTTON}
local btb = Skill("Below the Belt", {2018, 2019, 2020}, Stances.Awakening, btbActionSeq)

local fieryCrevicesActionSeq = Actions.ActionSequence("BT_ARO_Skill_Dash_Jump_Att_3Lv", {"BT_ARO_Skill_Dash_Jump_End"},
                                                      nil, 0)
fieryCrevicesActionSeq.keys = {KeyCode_F}
local fieryCrevices = Skill("Fiery Crevices", {2012, 2013, 2014}, Stances.Awakening, fieryCrevicesActionSeq)

function Profile.init(self)
	-- Init the CM Skills
	CM.Skills.autoAttackPriority = 0.55
	CM.Skills.autoAttackRange = 350
	-- Skills

	-- Dashes
	CM.addSkill(chase, CM.SkillTypes.Dash, {dashDistance = 750}, 1)

	-- Spammer
	CM.addSkill(divider, CM.SkillTypes.ST, {range = 350}, 1)

	-- AOE
	CM.addSkill(btb, CM.SkillTypes.AOE, {range = 350, aoeRadius = 450, considerGroupMobCount = 3}, 1.2)
	CM.addSkill(fieryCrevices, CM.SkillTypes.AOE, {range = 350, aoeRadius = 450, considerGroupMobCount = 3}, 1.1)

end

function Profile.combat(self, target)
	-- If not using the CombatManager Skill Managment, you can handle skills and co yourself here.
end

local refreshMp = false
function Profile.onPulse(self)
	-- Called every pulse
	if MagLib.BDO.Actors.LocalPlayer.getMp() < 30 then
		refreshMp = true
	elseif MagLib.BDO.Actors.LocalPlayer.getMp() > 150 then
		refreshMp = false
	end

	if refreshMp then
		CM.Skills.autoAttackPriority = 1.05 -- Slightly higher than Divider. so it uses autoattacks to get WP, but lower than AOE spells if AOE is good, so it still uses AOE when good.
	else
		CM.Skills.autoAttackPriority = 0.55
	end
end
function Profile.onMoveTo(self, dest, movingOverNodes)
	-- Called every time when currently moving somewhere
end
function Profile.onUnload(self)
	-- Called when this profile is unloaded due to any reason
end

return Profile
