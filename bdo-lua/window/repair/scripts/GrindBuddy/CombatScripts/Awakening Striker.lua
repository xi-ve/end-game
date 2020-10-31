--Leave this as is and change the name

CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Striker Awakening"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)

    --Reg Skills
    self.fury = Grinder_SkillAction("Descent of Fury", {KeyCode_SHIFT, KeyCode_E}, {2559}, nil, 500)

    --Offensive Skills
    self.crush = Grinder_SkillAction("Ultimate Crush", {KeyCode_S, KeyCode_LBUTTON}, {2562, 2563, 2564, 2565}, nil, 500, false)
    self.infDest = Grinder_SkillAction("Infernal Destructive", {KeyCode_F}, {2566, 2567, 2568, 2569}, nil, 500)
    self.sCrush = Grinder_SkillAction("Skull Crusher", {KeyCode_SHIFT, KeyCode_F}, {2570, 2571, 2572, 2573}, nil, 450)
    self.fallout = Grinder_SkillAction("Fallout", {KeyCode_RBUTTON}, {2643}, nil, 400)
    self.echo = Grinder_SkillAction("Black Spirit: Echo Spirit", {KeyCode_SHIFT, KeyCode_Q}, {3787}, nil, 500)


    --Dash Skills
    self.sCannon = Grinder_SkillAction("Spiral Cannon", {KeyCode_SHIFT, KeyCode_LBUTTON}, {2574, 2575, 2576}, nil, 800) --dash with attack
    self.ramp = Grinder_SkillAction("Black Spirit: Rampaging", {KeyCode_W, KeyCode_F}, {3788, 3789, 3790}, nil, 600)
    self.fStep = Grinder_SkillAction("Flash Step", {KeyCode_W, KeyCode_SHIFT}, {2443, 2444, 2445}, nil, 800)

    --Put all SkillActions in here
    self.SkillActions = {
        self.crush,
        self.infDest,
        self.sCrush,
        self.fallout,
        self.echo,
        self.sCannon,
        self.ramp,
        self.fStep
    }

    --Init like this
    self.QueuedDefenseAction = false

    self.CurrentAction = nil

    self:init()

    return self
end

function CombatRoutine:onMoveTo(dest, isNode)
    if isNode and dest:getDistance2D(Cache.playerPos) > 250 and self.fStep:canUse(nil) then --if u give canUse nil, it will not check for distance to the target
        self.fStep:useToPos(dest)
    end

end

function CombatRoutine:getCombatRange()
    local biggestRange = 255 --basic attack range
    for _, sa in pairs(self.SkillActions) do
        if sa:canUse() then
            if sa.AttackableRange > biggestRange then
                biggestRange = sa.AttackableRange
            end
        end
    end
    return biggestRange
end

function CombatRoutine:init()
    --You can just use this as is
    for kT, sa in pairs(self.SkillActions) do
        sa.DoneActionCallback = function(sA) self:onDoneAction(sA) end
    end
end

--Setting Normal Combat stance
function CombatRoutine:setCombatStance()
    Actor.setAction("BT_WAIT")
end

--Setting Awakening Combat stance
function CombatRoutine:setAWCombatStance()
    Input.pressOnce({KeyCode_C}, 250)
    Grinder.wait(1000)
end

--You could que defense actions here based on the attacker, like dodging cc etc. etc.
function CombatRoutine:onMonsterAttack(attacker)
    if self.QueuedDefenseAction then
        --Already queued a defense action
        return
    else
        return
    end
end

CombatRoutine.lastUsed = 0

function CombatRoutine:combat(targetKey)

    if self.QueuedDefenseAction then
        return
    end

    local target = ActorUtils.getActor(targetKey)

    --If  we got a valid target
    if target then

        local targetPos = target:getPosition()
        local distToTarget = targetPos:getDistance(Cache.playerPos)

        --Only input 100 times a sec
        if CombatRoutine.lastUsed + 10 > Cache.time then
            return
        end
        --Going to Awakening Combatstance
        if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
            self:setAWCombatStance()
            return
        end

        if Player.getHpPercent() < 50 and self.fury:canUse(target) then
            --Recover HP
            self.fury:use(target)
        elseif self.sCannon:canUse(target) and distToTarget > 450 then --Dashing closer
            self.sCannon:use(target)
        elseif self.ramp:canUse(target) and distToTarget > 250 then
            self.ramp:use(target)
        elseif self.fStep:canUse(target) and distToTarget > 500 then
            self.fStep:use(target)
        elseif self.echo:canUse(target) then --Following are all offensive skills
            self.echo:use(target)
        elseif self.infDest:canUse(target) then
            self.infDest:use(target)
        elseif self.sCrush:canUse(target) then
            self.sCrush:use(target)
        elseif self.crush:canUse(target) then
            self.crush:use(target)
        elseif target:getPosition():getDistance(Cache.playerPos) < 255 then
            Grinder.CombatUtils.doAutoAttack(target)
        else
            --Moving to the enemy, making the bot stay close to the enemy/closing distance
            Grinder.currentDest = target:getPosition()
            Grinder.currentDestIsNode = false
            Grinder.navigationPulse()
        end

        CombatRoutine.lastUsed = Cache.time
    end
end

setmetatable(CombatRoutine, {
    __call = function (cls, ...)
    return cls.new(...)
end,
})

return CombatRoutine()
