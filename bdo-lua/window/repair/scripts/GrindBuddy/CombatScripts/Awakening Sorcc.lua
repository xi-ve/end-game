CombatRoutine = {}
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Awakening Sorcc"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)

    self.explosionKey = 1
    self.delayBetweenSkills = 500
    self.lastSkillUsed = 0



    --Init all skills here
    self.Cartians_Protection = Grinder_SkillAction("Cartians Protection", {2}, {1783}, nil, 500)
    self.Shadow_Leap = Grinder_SkillAction("Shadow Leap", {87, 70}, {1790}, nil, 1000)
    self.Grim_Reaper = Grinder_SkillAction("Grim Reaper", {69}, {1792}, nil, 750)
    self.Dead_Hunt = Grinder_SkillAction("Dead Hunt", {83, 1}, {1788, 1785, 1786, 1787}, nil, 500)
    self.Grim_Reapers_Judgment = Grinder_SkillAction("Grim Reapers Judgment", {1, 2}, {1793, 1794, 1795, 1796}, nil, 500)
    self.Cartians_Nightmare = Grinder_SkillAction("Cartians Nightmare", {16, 69}, {1807, 1808, 1809, 1810}, nil, 500)
    self.Violation = Grinder_SkillAction("Violation", {87, 2}, {1804, 1805, 1806}, nil, 500)
    self.TurnBack_Slash = Grinder_SkillAction("TurnBack Slash", {83, 2}, {1780, 1781, 1782}, nil, 500)
    self.BladeOfDarkness = Grinder_SkillAction("BladeOfDarkness", {16, 2}, {1798, 1799, 1800}, nil, 500)
    self.ShardExplosion = Grinder_SkillAction("Shards of Darkness", self.explosionKey - 1, {1356}, nil, 500, true)
    self.ShardExplosion.Quickslot = self.explosionKey - 1

    self.SkillActions = {
        self.Cartians_Protection,
        self.Shadow_Leap,
        self.Grim_Reaper,
        self.Dead_Hunt,
        self.Grim_Reapers_Judgment,
        self.Cartians_Nightmare,
        self.Violation,
        self.TurnBack_Slash,
        self.BladeOfDarkness,
        self.ShardExplosion
    }
    self:init()
    return self
end

function CombatRoutine:onRenderGUI()
    ImGui.Begin("Awakening Sorcc")
    ImGui.Text("Shard Explosion Quickslot Number:")

    changed, self.explosionKey = ImGui.InputInt("##shard_explosion_slot", self.explosionKey)
    if changed then
        self.ShardExplosion.Quickslot = self.explosionKey - 1
    end

    ImGui.Text("Min. delay between skills:")

    changed, self.delayBetweenSkills = ImGui.InputInt("##delay_between_skills", self.delayBetweenSkills)

    ImGui.End()

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

    self.lastSwitchedStanceTime = 0

    self.castExplosion = function(target)
        if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 1 then
            Input.pressOnce({KeyCode_C}, 50)
            self.lastSwitchedStanceTime = Cache.time
            Grinder.wait(500)
            return
        end

        self.ShardExplosion:use(target)
        Grinder.resetNav()
        Grinder.wait(1000) --wait one second
    end

end


--Setting Awakening Combat stance
function CombatRoutine:setCombatStance()
    Input.pressOnce({KeyCode_C}, 250)
    Grinder.wait(1000)
end

--Setting Awakening Combat stance


CombatRoutine.lastUsed = 0

function CombatRoutine:combat(targetKey)

    if self.lastSwitchedStanceTime + 250 > Cache.time then
        return
    end

    local target = ActorUtils.getActor(targetKey)

    if target then
        local targetPos = target:getPosition()
        local distToTarget = targetPos:getDistance(Cache.playerPos)

        --Limit inputs to 20 per second
        if CombatRoutine.lastUsed + 50 > Cache.time then
            return
        end
        CombatRoutine.lastUsed = Cache.time

        if self.lastSkillUsed + self.delayBetweenSkills < Cache.time then

            self.lastSkillUsed = Cache.time

            if self.ShardExplosion:canUse(target) and Player.getMpPercent() < 40 and Infinity.BDO.Lua.Execute("return (getSelfPlayer():get():getSubResourcePoint() > 20)") then
                self.castExplosion(target)
                return
            end

            --Going toCombatstance
            if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
                CombatRoutine:setCombatStance()
                self.lastSwitchedStanceTime = Cache.time
                return
            end


            if self.Cartians_Protection:canUse(target) and Player.getMpPercent() > 30 then
                self.Cartians_Protection:use(target)
            elseif self.Shadow_Leap:canUse(target) and Player.getMpPercent() > 50 and distToTarget > 500 then
                self.Shadow_Leap:use(target)
            elseif self.Grim_Reaper:canUse(target) and distToTarget > 300 then
                self.Grim_Reaper:use(target)
            elseif self.Dead_Hunt:canUse(target) and Player.getMpPercent() > 30 then
                self.Dead_Hunt:use(target)
            elseif self.Grim_Reapers_Judgment:canUse(target) and Player.getMpPercent() > 30 then
                self.Grim_Reapers_Judgment:use(target)
            elseif self.Cartians_Nightmare:canUse(target) and Player.getMpPercent() > 30 then
                self.Cartians_Nightmare:use(target)
            elseif self.Violation:canUse(target) and Player.getMpPercent() > 30 then
                self.Violation:use(target)
            elseif self.TurnBack_Slash:canUse(target) and Player.getMpPercent() > 30 then
                self.TurnBack_Slash:use(target)
            elseif self.BladeOfDarkness:canUse(target) and Player.getMpPercent() > 30 then
                self.BladeOfDarkness:use(target)
            elseif distToTarget < 300 then
                Grinder.CombatUtils.doAutoAttack(target)
            else
                --Moving to the enemy, making the bot stay close to the enemy/closing distance
                Grinder.currentDest = target:getPosition()
                Grinder.currentDestIsNode = false
                Grinder.navigationPulse()
            end

        end
    end

end


setmetatable(CombatRoutine, {
__call = function (cls, ...)
return cls.new(...)
end,
})


return CombatRoutine()
