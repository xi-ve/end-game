CombatRoutine = {}
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Awakening Mystic"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)
    --Init all skills here
    self.Transquility = Grinder_SkillAction("Transquility", {16, 32}, {2806}, nil, 1000)
    self.Dragonize = Grinder_SkillAction("Dragonize", {16, 69}, {2773}, nil, 1000)
    self.Sea_Burial = Grinder_SkillAction("Sea Burial", {87, 2}, {2788, 2789, 2790}, nil, 800)
    self.Tidal_Burst = Grinder_SkillAction("Tidal Burst", {16, 2}, {2776, 2777, 2778, 2779}, nil, 400)
    self.Spiral_Torpedo = Grinder_SkillAction("Spiral Torpedo", {87, 70}, {2793, 2794, 2795}, nil, 400)
    self.Rapid_Stream = Grinder_SkillAction("Rapid Stream", {16, 1}, {2781, 2782, 2783, 2791}, nil, 400)
    self.Dragon_Shatter = Grinder_SkillAction("Dragon Shatter", {2}, {2798}, nil, 400)
    self.Rising_Dragon = Grinder_SkillAction("Rising Dragon", {16, 81}, {2799, 2800, 2801, 2802}, nil, 400)
    self.Wave_Orb = Grinder_SkillAction("Wave Orb", {1, 2}, {2784, 2785, 2786}, nil, 500)
    self.Hurrican_Sweep = Grinder_SkillAction("Hurrican Sweep", {70}, {2803}, nil, 400)
    self.Wolfs_Frenzy = Grinder_SkillAction("Wolfs Frenzy", {16, 70}, {2796}, nil, 400)
    self.Dragons_Rip = Grinder_SkillAction("Dragons Rip", {83, 69}, {2804}, nil, 500)
    self.SkillActions = {
        self.Transquility,
        self.Dragonize,
        self.Sea_Burial,
        self.Tidal_Burst,
        self.Spiral_Torpedo,
        self.Rapid_Stream,
        self.Dragon_Shatter,
        self.Rising_Dragon,
        self.Wave_Orb,
        self.Hurrican_Sweep,
        self.Wolfs_Frenzy,
        self.Dragons_Rip
    }
    self:init()
    return self
end

function CombatRoutine:getCombatRange()
    local biggestRange = 280 --basic attack range
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
    Grinder.forceKeyUp = false

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
    Grinder.resetNav()

    if target then
        local targetPos = target:getPosition()
        local distToTarget = targetPos:getDistance(Cache.playerPos)

        --Limit inputs to 10 per second
        if CombatRoutine.lastUsed + 100 > Cache.time then
            return
        end
        CombatRoutine.lastUsed = Cache.time

        --Going toCombatstance
        if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
            CombatRoutine:setCombatStance()
            return
        end

        if self.Transquility:canUse(target) and Player.getWpPercent() < 50 then
            self.Transquility:use(target)
        elseif self.Dragonize:canUse(target) and Player.getHpPercent() < 80 then
            self.Dragonize:use(target)
        elseif self.Sea_Burial:canUse(target) and distToTarget > 600 then
            self.Sea_Burial:use(target)
        elseif self.Tidal_Burst:canUse(target) then
            self.Tidal_Burst:use(target)
        elseif self.Spiral_Torpedo:canUse(target) then
            self.Spiral_Torpedo:use(target)
        elseif self.Rapid_Stream:canUse(target) then
            self.Rapid_Stream:use(target)
        elseif self.Dragon_Shatter:canUse(target) then
            self.Dragon_Shatter:use(target)
        elseif self.Rising_Dragon:canUse(target) then
            self.Rising_Dragon:use(target)
        elseif self.Wave_Orb:canUse(target) then
            self.Wave_Orb:use(target)
        elseif self.Hurrican_Sweep:canUse(target) then
            self.Hurrican_Sweep:use(target)
        elseif self.Wolfs_Frenzy:canUse(target) then
            self.Wolfs_Frenzy:use(target)
        elseif self.Dragons_Rip:canUse(target) then
            self.Dragons_Rip:use(target)
        elseif distToTarget < 280 then
            Grinder.CombatUtils.doAutoAttack(target)
        else
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
