CombatRoutine = {}
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Awakening Witch"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)
    --Init all skills here
    self.Summon = Grinder_SkillAction("Summon", {70}, {2200, 2204}, nil, 1000)
    self.Summon:forceReuseCycle(60000)
    self.EquilBreak = Grinder_SkillAction("EquilBreak", {16, 1}, {2179, 2180, 2181, 2182}, nil, 400)
    self.FissureW = Grinder_SkillAction("FissureW", {83, 1, 2}, {2187, 2188, 2189, 2190}, nil, 350)
    self.Voltaic = Grinder_SkillAction("Voltaic", {16, 70}, {2193, 2194, 2195, 2196}, nil, 350)
    self.Detonative = Grinder_SkillAction("Detonative", {87, 70}, {2183, 2184, 2185}, nil, 350)
    self.ThunderS = Grinder_SkillAction("ThunderS", {83, 70}, {2190, 2191, 2192}, nil, 350)
    self.Yoke = Grinder_SkillAction("Yoke", {16, 2}, {2197, 2198, 2199}, nil, 500)
    self.psyche = Grinder_SkillAction("psyche", {16, 69}, {2165}, nil, 1000)
    self.SkillActions = {
        self.Summon,
        self.EquilBreak,
        self.FissureW,
        self.Voltaic,
        self.Detonative,
        self.ThunderS,
        self.Yoke,
        self.psyche
    }
    self:init()
    return self
end

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

--Setting Awakening Combat stance
function CombatRoutine:setCombatStance()
    Input.pressOnce({KeyCode_C}, 250)
    Grinder.wait(1000)
end

CombatRoutine.lastUsed = 0

function CombatRoutine:combat(targetKey)
    local target = ActorUtils.getActor(targetKey)

    if target then
        local targetPos = target:getPosition()
        local distToTarget = targetPos:getDistance(Cache.playerPos)

        --Limit inputs to 20 per second
        if CombatRoutine.lastUsed + 50 > Cache.time then
            return
        end
        CombatRoutine.lastUsed = Cache.time

        --Going toCombatstance
        if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
            CombatRoutine:setCombatStance()
            return
        end

        --if self.Summon:canUse(target) and Player.getHpPercent() > 90 and Player.getMpPercent() > 30 then
        --print("1")
        --self.Summon:use(target)
        --else
        if self.psyche:canUse(target) and distToTarget > 300 then
            --print("2")
            self.psyche:use(target)
        elseif self.EquilBreak:canUse(target) and Player.getMpPercent() > 30 then
            --print("3")
            self.EquilBreak:use(target)
        elseif self.FissureW:canUse(target) and Player.getMpPercent() > 30 then
            --print("4")
            self.FissureW:use(target)
        elseif self.Voltaic:canUse(target) and Player.getMpPercent() > 30 then
            --print("5")
            self.Voltaic:use(target)
        elseif self.Detonative:canUse(target) and Player.getMpPercent() > 30 then
            --print("6")
            self.Detonative:use(target)
        elseif self.ThunderS:canUse(target) and Player.getMpPercent() > 30 then
            --print("7")
            self.ThunderS:use(target)
        elseif self.Yoke:canUse(target) and Player.getMpPercent() > 30 then
            --print("8")
            self.Yoke:use(target)
        elseif distToTarget < 300 then
            --print("9")
            Grinder.CombatUtils.doAutoAttack(target)
        else
            --print("10")
            --Moving to the enemy, making the bot stay close to the enemy/closing distance
            Grinder.currentDest = target:getPosition()
            Grinder.currentDestIsNode = false
            Grinder.navigationPulse()
        end



    end
end


setmetatable(CombatRoutine, {
    __call = function (cls, ...)
    return cls.new(...)
end,
})


return CombatRoutine()
