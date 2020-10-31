CCreator = {}
CCreator.version = "V0.3"
CCreator.time = 0

CCreator.script = {
    combatScriptName = "Combatscript Name",
    combatScriptAwakening = true,
    autoAttackRange = 255,
    skills = {}
}

--[[local exampleSkill = {
    name = "asd asd",
    nameLua = "asd_asd",
    tempName = "asd asd",
    forceCd = false,
    forceCdMs = 1000,
    ids = {1, 2, 3, 4},
    range = 500,
    keys = {
        {key = KeyCode_SHIFT, keyName = "KeyCode_SHIFT", recording = false},
        {key = KeyCode_E, keyName = "KeyCode_E", recording = false}
    },
    conditions = {
        {
            conditionTable = Conditions.targetHpMoreThanCondition,
            value = "0"
        }
    }
}
table.insert(CCreator.script.skills, exampleSkill)]]


CCreator.created = false
CCreator.msg = ""
CCreator.createdError = false

function CCreator.saveCurrentScript()
    print("Saving " .. CCreator.script.combatScriptName .."!")
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("\\SavedCombatscripts\\" .. CCreator.script.combatScriptName .. ".json", json:encode_pretty(CCreator.script))
end

function CCreator.loadScript(name)
    print("Loading " .. name .."!")
    local json = JSON:new()
    CCreator.script = json:decode(Infinity.FileSystem.ReadFile("\\SavedCombatscripts\\" .. name .. ".json"))
end



local conditionsSorted = {}
for k, v in pairs(Conditions) do
    table.insert(conditionsSorted, v)
end

local function sortByConditionIndex(a, b)
    return a.index < b.index
end
table.sort(conditionsSorted, sortByConditionIndex)

CCreator.conditionNames = {}
CCreator.conditions = {}
for k, v in pairs(conditionsSorted) do
    table.insert(CCreator.conditionNames, v.text)
    table.insert(CCreator.conditions, v)

    CCreator.conditionKeys = {}
end

CCreator.recordingStartedTime = 0



function CCreator.start()
    print("Combatscript Creator started!")
end

function CCreator.stop()
    print("Combatscript Creator stopped!")
end

function CCreator.onPulse()
    --Updating time variable
    CCreator.time = Infinity.Win32.GetTickCount()

    --Key recording feature
    --There is 500ms delay between clicking the record button and recording starting to prevent LButton to just directly be taken as new key
    if CCreator.recordingStartedTime + 450 < CCreator.time then
        --For every skill
        for k, skill in ipairs(CCreator.script.skills) do
            --for every key
            for keyIndex, key in ipairs(skill.keys) do
                --if key is set to recording
                if key.recording == true then
                    --Check every possible key
                    for keyName, keyValue in pairs(CCreator.VirtualKeyCode) do
                        --If key is pressed, we count that key as the recorded key and use it
                        if Infinity.BDO.Input.IsKeyPressed(keyValue) == true then
                            key.recording = false
                            key.keyName = keyName
                            key.key = keyValue
                            return
                        end
                    end
                end
            end
        end
    end
end


function CCreator.createCombatscript()

    local skillInits, skillInitError = CCreator.createSkillInit()
    local skillActionsTable, skillActionsTableError = CCreator.createSkillActionsTable()

    if (skillInitError) then
        CCreator.created = true
        CCreator.msg = skillInits
        CCreator.createdError = true
        return
    end

    if (skillActionsTableError) then
        CCreator.created = true
        CCreator.msg = skillActionsTable
        CCreator.createdError = true
        return
    end

    local combatStanceFunctionBody = CCreator.getCombatStanceFunctionBody()
    local combatStanceNumber = CCreator.getCombatStanceNumber()
    local skillUsage = CCreator.getSkillUsages()

    local cs = [[
    CombatRoutine = {}
    CombatRoutine.__index = CombatRoutine
    CombatRoutine.Name = "]].. CCreator.script.combatScriptName ..[["

    function CombatRoutine.new()
        local self = setmetatable({}, CombatRoutine)
        ]].. skillInits ..[[
        ]].. skillActionsTable .. [[

        self:init()
        return self
    end

    function CombatRoutine:getCombatRange()
        local biggestRange = ]] .. CCreator.script.autoAttackRange .. [[ --basic attack range
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
        ]].. combatStanceFunctionBody ..[[
    end

    CombatRoutine.lastUsed = 0

    function CombatRoutine:combat(targetKey)
        local target = ActorUtils.getActor(targetKey)

        if target then
            local targetPos = target:getPosition()
            local distToTarget = targetPos:getDistance(Cache.playerPos)

            CombatRoutine.lastUsed = Cache.time

            --Going toCombatstance
            if Infinity.BDO.getLocalPlayer():getCombatStance() ~= ]] .. combatStanceNumber .. [[ then
                CombatRoutine:setCombatStance()
                return
            end

            ]] .. skillUsage .. [[


        end
    end


    ]] .. CCreator.getSetMetatable() .. [[


    return CombatRoutine()
    ]]

    local filename = "\\createdScripts\\" .. CCreator.script.combatScriptName .. ".lua"
    Infinity.FileSystem.WriteFile(filename, cs)
    CCreator.msg = "Success!"
    CCreator.createdError = false
    CCreator.created = true

end

function CCreator.getSkillUsages()
    local skillUsage = "if "
    for k, v in ipairs(CCreator.script.skills) do
        skillUsage = skillUsage .. "self." .. v.nameLua .. ":canUse(target)"

        for _, condition in pairs(v.conditions) do
            local conditionTable = condition.conditionTable

            skillUsage = skillUsage .. " and " .. condition.conditionTable.code

            if conditionTable.hasValue then
                local value = condition.value
                if conditionTable.valueIsString then
                    value = "\"" .. value .. "\""
                end
                skillUsage = skillUsage .. value
            end
        end

        skillUsage = skillUsage .. " then \n"
        skillUsage = skillUsage .. "self." .. v.nameLua .. ":use(target)\n"

        if CCreator.script.skills[k + 1] ~= nil then
            skillUsage = skillUsage .. "elseif "
        else
            skillUsage = skillUsage .. [[
            elseif distToTarget < ]] .. CCreator.script.autoAttackRange .. [[ then
                Grinder.CombatUtils.doAutoAttack(target)
            else
                --Moving to the enemy, making the bot stay close to the enemy/closing distance
                Grinder.currentDest = target:getPosition()
                Grinder.currentDestIsNode = false
                Grinder.navigationPulse()
            end

            ]]
        end
    end


    return skillUsage
end


function CCreator.getCombatStanceNumber()
    if CCreator.script.combatScriptAwakening then
        return "2"
    else
        return "1"
    end
end

function CCreator.getCombatStanceFunctionBody()
    if CCreator.script.combatScriptAwakening then
        return [[
        Input.pressOnce({KeyCode_C}, 250)
        Grinder.wait(1000)
        ]]
    else
        return [[
        Input.pressOnce({KeyCode_TAB}, 250)
        Grinder.wait(1000)
        ]]
    end
end

function CCreator.createSkillActionsTable()
    local skillActionsTable = "self.SkillActions = { \n"

    if not CCreator.script.skills or #CCreator.script.skills == 0 then
        return "Please add at least one skill", true
    end

    for k, v in pairs(CCreator.script.skills) do
        skillActionsTable = skillActionsTable .. "self." .. v.nameLua
        if CCreator.script.skills[k + 1] ~= nil then
            skillActionsTable = skillActionsTable .. ",\n"
        end
    end

    skillActionsTable = skillActionsTable .. "\n }"
    return skillActionsTable, false

end


function CCreator.createSkillInit()
    local initCode = "--Init all skills here \n"

    for k, v in pairs(CCreator.script.skills) do
        --Generate keys table
        local keys = "{"
        if (v.keys and #v.keys > 0 ) then
            for _, key in pairs(v.keys) do
                keys = keys .. key.key .. ","
            end
            keys = keys:sub(0, keys:len() - 1) --removes the last ","
            keys = keys .. "}"
        else
            return "ERROR: Skill " .. v.name .. "needs set key!", true
        end

        --Generate ids table
        local ids = "{"
        if (v.ids and #v.ids > 0) then
            for _, id in pairs(v.ids) do
                ids = ids .. id .. ","
            end
            ids = ids:sub(0, ids:len() - 1) --removes the last ","
            ids = ids .. "}"
        else
            return "ERROR: Skill " .. v.name .. "needs set id!", true
        end


        local skillInit = "self." .. v.nameLua .. " = Grinder_SkillAction(\"" .. v.name .. "\", " .. keys ..", " .. ids..", nil, " .. v.range ..")"

        if v.forceCd then
            skillInit = skillInit .. "\n" .. "self." .. v.nameLua .. ":forceReuseCycle(".. v.forceCdMs ..")"
        end

        initCode = initCode .. skillInit .. "\n"
    end
    return initCode, false
end

CCreator.VirtualKeyCode = 
{
    KeyCode_LBUTTON = 1,
    KeyCode_RBUTTON = 2,
    KeyCode_CANCEL = 3,
    KeyCode_MBUTTON = 4,
    KeyCode_BACK = 8,
    KeyCode_TAB = 9,
    KeyCode_CLEAR = 12,
    KeyCode_RETURN = 13,
    KeyCode_SHIFT = 16,
    KeyCode_CONTROL = 17,
    KeyCode_MENU = 18,
    KeyCode_PAUSE = 19,
    KeyCode_CAPITAL = 20,
    KeyCode_ESCAPE = 27,
    KeyCode_SPACE = 32,
    KeyCode_PGUP = 33,
    KeyCode_PGDN = 34,
    KeyCode_END = 35,
    KeyCode_HOME = 36,
    KeyCode_LEFT = 37,
    KeyCode_UP = 38,
    KeyCode_RIGHT = 39,
    KeyCode_DOWN = 40,
    KeyCode_SELECT = 41,
    KeyCode_PRINT = 42,
    KeyCode_EXECUTE = 43,
    KeyCode_SNAPSHOT = 44,
    KeyCode_INSERT = 45,
    KeyCode_DELETE = 46,
    KeyCode_HELP = 47,
    KeyCode_0 = 48,
    KeyCode_1 = 49,
    KeyCode_2 = 50,
    KeyCode_3 = 51,
    KeyCode_4 = 52,
    KeyCode_5 = 53,
    KeyCode_6 = 54,
    KeyCode_7 = 55,
    KeyCode_8 = 56,
    KeyCode_9 = 57,
    KeyCode_A = 65,
    KeyCode_B = 66,
    KeyCode_C = 67,
    KeyCode_D = 68,
    KeyCode_E = 69,
    KeyCode_F = 70,
    KeyCode_G = 71,
    KeyCode_H = 72,
    KeyCode_I = 73,
    KeyCode_J = 74,
    KeyCode_K = 75,
    KeyCode_L = 76,
    KeyCode_M = 77,
    KeyCode_N = 78,
    KeyCode_O = 79,
    KeyCode_P = 80,
    KeyCode_Q = 81,
    KeyCode_R = 82,
    KeyCode_S = 83,
    KeyCode_T = 84,
    KeyCode_U = 85,
    KeyCode_V = 86,
    KeyCode_W = 87,
    KeyCode_X = 88,
    KeyCode_Y = 89,
    KeyCode_Z = 90,
    KeyCode_NUMPAD0 = 96,
    KeyCode_NUMPAD1 = 97,
    KeyCode_NUMPAD2 = 98,
    KeyCode_NUMPAD3 = 99,
    KeyCode_NUMPAD4 = 100,
    KeyCode_NUMPAD5 = 101,
    KeyCode_NUMPAD6 = 102,
    KeyCode_NUMPAD7 = 103,
    KeyCode_NUMPAD8 = 104,
    KeyCode_NUMPAD9 = 105,
    KeyCode_MULTIPLY = 106,
    KeyCode_ADD = 107,
    KeyCode_SEPARATOR = 108,
    KeyCode_SUBTRACT = 109,
    KeyCode_DECIMAL = 110,
    KeyCode_DIVIDE = 111,
    KeyCode_F1 = 112,
    KeyCode_F2 = 113,
    KeyCode_F3 = 114,
    KeyCode_F4 = 115,
    KeyCode_F5 = 116,
    KeyCode_F6 = 117,
    KeyCode_F7 = 118,
    KeyCode_F8 = 119,
    KeyCode_F9 = 120,
    KeyCode_F10 = 121,
    KeyCode_F11 = 122,
    KeyCode_F12 = 123,
    KeyCode_F13 = 124,
    KeyCode_F14 = 125,
    KeyCode_F15 = 126,
    KeyCode_F16 = 127,
    KeyCode_F17 = 128,
    KeyCode_F18 = 129,
    KeyCode_F19 = 130,
    KeyCode_F20 = 131,
    KeyCode_F21 = 132,
    KeyCode_F22 = 133,
    KeyCode_F23 = 134,
    KeyCode_F24 = 135,
    KeyCode_OEM_2 = 191,
    KeyCode_OEM_3 = 192,
    KeyCode_OEM_7 = 222
}

function CCreator.getSetMetatable()
    local setMetaTableCode = [[
    setmetatable(CombatRoutine, {
        __call = function (cls, ...)
        return cls.new(...)
    end,
    })
    ]]
    return setMetaTableCode
end
