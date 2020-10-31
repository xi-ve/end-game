MagLib.Events = {}

local eventCallbacks = {}
-- Just an arbitrary list of events that MagLib uses internally. No real need to do this, but is nice to read/keep track
eventCallbacks["OnInit_Base"] = {} -- see MagLib/Base/Init.lua
eventCallbacks["AfterInit_Base"] = {} -- see MagLib/Base/Init.lua
eventCallbacks["Messages_ReceiveWhisper"] = {}
eventCallbacks["Navigation_NewDest"] = {}
eventCallbacks["Navigation_ReachedDest"] = {}
eventCallbacks["EndScript"] = {}
eventCallbacks["Shop_BuyComplete"] = {} -- | {itemKey = itemKey, amount = amount}
eventCallbacks["LuaLoaded"] = {} -- see MagLib/BDO/Events/LuaLoaded.lua |
eventCallbacks["LuaLoadedLate"] = {} -- see MagLib/BDO/Events/LuaLoaded.lua |
eventCallbacks["SwitchedRegion"] = {} -- see  MagLib/BDO/Events/SwitchedRegion.lua  |{oldRegionKey, newRegionKey}
eventCallbacks["ProfileChanged"] = {} -- see MagLib/BDO/Navigation/Graph/Profiles.lua |
eventCallbacks["ItemsLooted"] = {} -- see MagLib/BDO/Looting.lua | {{slot, itemKey, count}, {...}}
eventCallbacks["LifeSkillExpChanged"] = {} -- see MagLib/BDO/Events/ExpChanged.lua | {craftType, oldLevel, newLevel, oldExpValue, newExpValue, expChanged}
eventCallbacks["ExpChanged"] = {} -- see MagLib/BDO/Events/ExpChanged.lua | {oldExpValue, newExpValue, expChanged}
eventCallbacks["CharacterChanged"] = {} -- see MagLib/BDO/Events/CharacterChanged.lua | {oldName, newName}

eventCallbacks["InventoryItemCountIncreased"] = {}
eventCallbacks["InventoryItemCountDecreased"] = {}
local addEvent = function(eventName) eventCallbacks[eventName] = {} end

MagLib.Events.addEventHandler = function(eventName, func)
    if eventCallbacks[eventName] == nil then addEvent(eventName) end
    table.insert(eventCallbacks[eventName], func)
end

MagLib.Events.triggerEvent = function(eventName, ...)
    if eventCallbacks[eventName] then
        local eventHandlers = eventCallbacks[eventName]
        for _, func in pairs(eventHandlers) do func(...) end
    end
end

local inGameEventCallbacks = {}
local addInGameEvent =
    function(eventName) inGameEventCallbacks[eventName] = {} end

MagLib.Events.addInGameEventHandler = function(eventName, func)
    if inGameEventCallbacks[eventName] == nil then addInGameEvent(eventName) end
    table.insert(inGameEventCallbacks[eventName], func)
end

local inGameEventHandler = function(eventName)
    if inGameEventCallbacks[eventName] ~= nil then
        for _, func in pairs(inGameEventCallbacks[eventName]) do func() end
    end
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnBDOEventFired",
                                                  inGameEventHandler)
