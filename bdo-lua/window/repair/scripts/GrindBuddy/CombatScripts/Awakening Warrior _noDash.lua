--Leave this as is and change the name

CombatRoutine = { }
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Warrior Awakening"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)

    --Buff Skills
    self.burningM = Grinder_SkillAction("Burning Moxie", {KeyCode_SHIFT, KeyCode_SPACE}, {1763}, nil, 1000) --WP recovery


    --Offensive Skills
    self.solarF = Grinder_SkillAction("Solar Flare", {KeyCode_W, KeyCode_LBUTTON}, {1733, 1734, 1735, 1736}, nil, 500)
    self.merc = Grinder_SkillAction("Merciless", {KeyCode_S, KeyCode_RBUTTON}, {1765, 1766, 1767, 1768}, nil, 350)
    self.bStrike = Grinder_SkillAction("Balanced Strike", {KeyCode_W, KeyCode_RBUTTON}, {1726, 1727, 1728}, nil, 450)
    self.pulv = Grinder_SkillAction("Pulverize", {KeyCode_S, KeyCode_LBUTTON}, {1751, 1752, 1753}, nil, 300)


    --Dash Skills
    self.chase = Grinder_SkillAction("Head Chase", {KeyCode_W, KeyCode_SHIFT}, {1723, 1724, 1725}, nil, 700) --normal dash
    self.chase:forceReuseCycle(1000)

    --Put all SkillActions in here
    self.SkillActions = {
        self.burningM,
        self.solarF,
        self.merc,
        self.bStrike,
        self.pulv,
        self.chase
    }

    --Init like this
    self.QueuedDefenseAction = false

    self.CurrentAction = nil

    self:init()

    return self
end

function CombatRoutine:onMoveTo(dest, isNode)
    --local distanceToDest = dest:getDistance(Cache.playerPos)
    --if isNode and distanceToDest > 300 and self.chase:canUse(nil) then --if u give canUse nil, it will not check for distance to the target
        --self.chase:useToPos(dest)
    --end
end

--attackingMobs is always >0 and attackingMobs[1] is always the closest mob to the player
--[[function CombatRoutine:onGetAttacked(attackingMobs)
    if Player.getHpPercent() < 40 and self.chase:canUse(nil) then
        --Dodge backwards of the closest enemy if hp under 40%
        local closestMob = attackingMobs[1]
        local closestMobPos = closestMob:getPosition()
        local vecAwayFromMob = VectorUtils.subtract(Cache.playerPos, closestMobPos) --GrindBuddy interal: returns a vector that is Cache.playerPos - closestMobPos subtracted elementwise
        --vecAwayFromMob is now the vector mob -> player (playerPos - closestMobPos, other way around would be player -> mob), so we just apply that again and get a position that is in the opposite direction of the mob, so we just use chase in that direction to get away from the mob
        local dodgeDest = VectorUtils.addition(Cache.playerPos, vecAwayFromMob)
        Log.log("AwakeningWarrior: Dodging away from attacking mob because of low hp!")
        self.chase:useToPos(dodgeDest)
        Grinder.resetNav() --resets nav, hence player is not running anywhere
    end
end]]

function CombatRoutine:getCombatRange()
    local biggestRange = 300 --basic attack range
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

        if self.burningM:canUse(target) then--and Player.getMpPercent() < 30 then
            --Recover SP
            self.burningM:use(target)
        elseif self.chase:canUse(target) and distToTarget > 450 then
            --Dashing closer
            self.chase:use(target)
        elseif self.solarF:canUse(target) then --Following are all offensive skills
            self.solarF:use(target)
        elseif self.bStrike:canUse(target) then
            self.bStrike:use(target)
        elseif self.merc:canUse(target) then
            self.merc:use(target)
        elseif self.pulv:canUse(target) then
            self.pulv:use(target)
        elseif target:getPosition():getDistance(Cache.playerPos) < 300 then
            Grinder.CombatUtils.doAutoAttack(target)
        else
            --Moving to the enemy, making the bot stay close to the enemy/closing distance
            Grinder.currentDest = targetPos
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
