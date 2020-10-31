CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Autoattack Range"

setmetatable(CombatRoutine, {
    __call = function (cls, ...)
    return cls.new(...)
end,
})


CombatRoutine.lastAttackTime = 0

function CombatRoutine.new()
local self = setmetatable({}, CombatRoutine)

self.SkillActions = {}

self.TargetRange = 500

self.Target = nil

self.QueuedAction = false
self.QueuedDefenseAction = false

self.CurrentAction = nil

self:init()

return self
end

function CombatRoutine:getCombatRange()
return 700
end

function CombatRoutine:init()
for kT, sa in pairs(self.SkillActions) do
    sa.DoneActionCallback = function(sA) self:onDoneAction(sA) end
end
end

function CombatRoutine:setCombatStance()
--Actor.setAction("BT_WAIT")
end

function CombatRoutine:setAWCombatStance()
--Actor.setAction("BT_ARO_WAIT")
end

function CombatRoutine:onMonsterAttack(attacker)
if self.QueuedDefenseAction then
    return
end
end

function CombatRoutine:combat(targetKey)

local target = ActorUtils.getActor(targetKey)

if target then
    if target:getPosition():getDistance(Cache.playerPos) < 700 then
        Grinder.CombatUtils.doAutoAttack(target, true)
    else
        Grinder.currentDest = target:getPosition()
        Grinder.currentDestIsNode = false
        Grinder.navigationPulse()
    end
end

end


function CombatRoutine:onDoneAction(skillAction)
self.QueuedAction = false
end

return CombatRoutine()
