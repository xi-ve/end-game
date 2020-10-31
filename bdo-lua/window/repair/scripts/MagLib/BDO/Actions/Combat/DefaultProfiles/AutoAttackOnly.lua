local Actions = MagLib.BDO.Actions
local Combat = Actions.Combat
local CM = Combat.CombatManager
local Skill = Combat.Skill
local Stances = Combat.SkillUseStances
local LocalPlayer = MagLib.BDO.Actors.LocalPlayer
local UI = MagLib.UI

local Profile = {}
function Profile:init()

	self.settings = {
		autoAttackRange = 350
		-- useRunning = false
	}
	MagLib.Core.Settings.addSettingsToHandler("CombatRoutine_AutoAttackOnly", self.settings)

	CM.Skills.autoAttackPriority = 1
	CM.Skills.autoAttackRange = self.settings.autoAttackRange
end

--[[
function Profile:onMoveTo(dest, movingOverNodes)
    if not self.settings.useRunning then return end

    local distToDest = LocalPlayer.getPos():getDistance(dest)
    if distToDest > 300 then 
        MagLib.Input.press({KeyCode_SHIFT}, 150)
    end
end
]]

function Profile:onGUIDraw(shouldDoOwnWindow)
	if shouldDoOwnWindow then
		UI.newWindow("AutoAttackOnly CombatProfile")
	end
	self.settings.autoAttackRange = UI.SliderInt("AutoAttack Range", self.settings.autoAttackRange, 50, 800)

	if shouldDoOwnWindow then
		UI.endWindow()
	end
end

return Profile
