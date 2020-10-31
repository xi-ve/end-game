CombatRoutine = {}
CombatRoutine.__index = CombatRoutine
CombatRoutine.Name = "Awakening Wizard"

function CombatRoutine.new()
    local self = setmetatable({}, CombatRoutine)

    self.Healing_Aura_Slot = 5

    --Quickslot skills
    self.Healing_Aura = Grinder_SkillAction("Healing Aura", self.Healing_Aura_Slot, {899, 900, 901, 902, 903}, nil, 1000, true)
    self.Healing_Aura.Quickslot = self.Healing_Aura_Slot - 1

    self.useTeleport = false

    --Healing
    self.Sage_Light = Grinder_SkillAction("Sages Light", {KeyCode_SHIFT, KeyCode_X}, {2749}, nil, 750)

    --Offensive Skills
    self.Aqua_Jail = Grinder_SkillAction("Aqua Jail", {16, 1}, {2225, 2226, 2227, 2228}, nil, 500)
    self.Cataclysm = Grinder_SkillAction("Cataclysm", {16, 70}, {2232, 2233, 2234, 2235}, nil, 500)
    self.Bolide_of_Destruction = Grinder_SkillAction("Bolide of Destruction", {83, 70}, {2243, 2244, 2245}, nil, 500)
    self.Hellfire = Grinder_SkillAction("Hellfire", {87, 70}, {2239, 2240, 2241, 2242}, nil, 500)

    --TP Skill
    self.teleport = Grinder_SkillAction("Teleport", {KeyCode_SHIFT, KeyCode_SPACE}, {909, 910, 911}, nil, 0)


    --Combat skills
    self.SkillActions = {
        self.Healing_Aura,
        self.Aqua_Jail,
        self.Cataclysm,
        self.Bolide_of_Destruction,
        self.Hellfire
    }
    self:init()
    return self
end

function CombatRoutine:getCombatRange()
    local biggestRange = 500 --basic attack range
    for _, sa in pairs(self.SkillActions) do
        if sa:canUse() then
            if sa.AttackableRange > biggestRange then
                biggestRange = sa.AttackableRange
            end
        end
    end
    return biggestRange
end

function CombatRoutine:onRenderGUI()
    ImGui.Begin("Awakening Wizard")
    ImGui.Text("Healing Aura Quickslot Number:")

    changed, self.Healing_Aura_Slot = ImGui.InputInt("##healing_aura_slot", self.Healing_Aura_Slot)
    if changed then
        self.Healing_Aura.Quickslot = self.Healing_Aura_Slot - 1
    end

    ImGui.Text("Use Teleport:")
    ImGui.SameLine()
    _, self.useTeleport = ImGui.Checkbox("##useTeleport", self.useTeleport)

    ImGui.End()

end

function CombatRoutine:init()
    --You can just use this as is
    for kT, sa in pairs(self.SkillActions) do
        sa.DoneActionCallback = function(sA) self:onDoneAction(sA) end
    end
end

function CombatRoutine:onMoveTo(dest, isNode)
    if self.useTeleport and Infinity.BDO.getLocalPlayer():getCombatStance() == 2 then
        local distanceToDest = dest:getDistance(Cache.playerPos)
        if isNode then
            if distanceToDest > 750 and self.teleport:canUse(nil) then
                self.teleport:useToPos(dest)
            end
        else
            if distanceToDest > 750 and distanceToDest < 1000 and self.teleport:canUse(nil) then
                self.teleport:useToPos(dest)
            end
        end
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

        --Going to Combatstance
        if Infinity.BDO.getLocalPlayer():getCombatStance() ~= 2 then
            CombatRoutine:setCombatStance()
            return
        end

        if self.Sage_Light:canUse(target) and Player.getHpPercent() < 60 then
            self.Sage_Light:use(target)
        elseif self.Healing_Aura:canUse(target) and Player.getHpPercent() < 70 then
            self.Healing_Aura:use(target)
        elseif self.Aqua_Jail:canUse(target) and Player.getMpPercent() > 30 then
            self.Aqua_Jail:use(target)
        elseif self.Cataclysm:canUse(target) and Player.getMpPercent() > 30 then
            self.Cataclysm:use(target)
        elseif self.Bolide_of_Destruction:canUse(target) and Player.getMpPercent() > 30 then
            self.Bolide_of_Destruction:use(target)
        elseif self.Hellfire:canUse(target) and Player.getMpPercent() > 30 then
            self.Hellfire:use(target)
        elseif distToTarget < 500 then
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
