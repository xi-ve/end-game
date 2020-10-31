CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Autoattack"


CombatRoutine.lastAttackTime = 0

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)

    self.SkillActions = {}

    self.TargetRange = 500

    self.Target = nil

    self.QueuedAction = false
    self.QueuedDefenseAction = false

    self.CurrentAction = nil

    self.Dash = Grinder_SkillAction("Flash Step", {KeyCode_SHIFT, KeyCode_W}, {2631, 2632, 2633}, nil, 1000)

    self:init()

    return self
end

function CombatRoutine:getCombatRange()
    return 450
end

function CombatRoutine:init()
    for kT, sa in pairs(self.SkillActions) do
        sa.DoneActionCallback = function(sA) self:onDoneAction(sA) end
    end
end

function CombatRoutine:setCombatStance()
end

function CombatRoutine:setAWCombatStance()
end

function CombatRoutine:onMoveTo(dest, isNode)

    local distanceToDest = dest:getDistance(Cache.playerPos)
    if isNode then
        if distanceToDest < 900 and distanceToDest > 0 and self.Dash:canUse(nil) then
            self.Dash:useToPos(dest)
        end
    else
        if distanceToDest < 1000 and distanceToDest > 450 and self.Dash:canUse(nil) then
            self.Dash:useToPos(dest)
        end
    end
end

function CombatRoutine:combat(targetKey)

    local target = ActorUtils.getActor(targetKey)

    if target then
        local distToTarget = target:getPosition():getDistance(Cache.playerPos)

        if distToTarget > 450 and self.Dash:canUse(target) then
            self.Dash:use(target)
        elseif distToTarget < 330 then
            Grinder.CombatUtils.doAutoAttack(target)
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

setmetatable(CombatRoutine, {
    __call = function (cls, ...)
    return cls.new(...)
end,
})

return CombatRoutine()
