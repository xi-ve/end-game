---A game independent hotkey handler
---@Module MagLib.Hotkeys
---@alias Hotkeys 
local Hotkeys = {}

--[[ Test Code
MagLib.Hotkeys.addHotkey(KeyCode_K, function(key, deltaTime, event)
    print("Key was downed. It was last upped " .. deltaTime .. " ms ago!")
end, MagLib.Hotkeys.KeyEvents.OnKeyDown)

MagLib.Hotkeys.addHotkey(KeyCode_K, function(key, deltaTime, event)
    print("Key was downed. It was downed for " .. deltaTime .. " ms!")
end, MagLib.Hotkeys.KeyEvents.OnKeyUp)
]]

---@class KeyEvent
---Used by MagLib.Hotkeys to determine if it should trigger on keyDown or key up
Hotkeys.KeyEvents = Enum("TriggerEvents", false, true)
Hotkeys.KeyEvents:add("OnKeyDown")
Hotkeys.KeyEvents:add("OnKeyUp")

---Represents one key, function, keyEvent combination.
---Internally used by the MagLib.Hotkeys handler and should not be used out of the internal scope.
---@class HotkeyCallback
local HotkeyCallback = MagLib.Core.Class()
HotkeyCallback.key = nil
HotkeyCallback.triggerEvent = nil
function HotkeyCallback:callback()
	print("Hotkey for key " .. self.key .. " is not properly set up yet! There was an error somewhere!")
end

function HotkeyCallback:init(key, callback, triggerEvent)
	self.triggerEvent = triggerEvent
	if self.triggerEvent == nil then
		self.triggerEvent = Hotkeys.KeyEvents.OnKeyDown
	end

	print("Registering hotkey for key " .. key .. " and trigger " .. tostring(Hotkeys.KeyEvents:valueToKey(triggerEvent)))

	if (not callback) or type(callback) ~= "function" then
		MagLib.logger.error(debug.traceback("Cannot create a hotkey callback without a valid callback function!"))
	else
		self.callback = callback
	end

	if (not key) or type(key) ~= "number" then
		MagLib.logger.error(debug.traceback("Cannot create a hotkey callback without a valid key!"))
		self.key = 999
	else
		self.key = key
	end
end

local registeredHotkeyCallbacks = {}
local savedKeyStates = {}

local settings = {}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Hotkeys", settings)

---Registers a new hotkey with a callback.
---MagLib will call the callback with parameters (key, deltaTime, event) function if a key is pressed.
---Deltatime is the time since the last state change, so for OnKeyUp how long the key was downed and for OnKeyDown how long since the last KeyUp
---triggerEvent is Hotkeys.KeyEvents.OnKeyDown or Hotkeys.KeyEvents.OnKeyUp
---@param key number
---@param callback function
---@param triggerEvent KeyEvent
Hotkeys.addHotkey = function(key, callback, triggerEvent)
	triggerEvent = triggerEvent or Hotkeys.KeyEvents.OnKeyDown
	if (not registeredHotkeyCallbacks[key]) then
		registeredHotkeyCallbacks[key] = {}
	end
	table.insert(registeredHotkeyCallbacks[key], HotkeyCallback(key, callback, triggerEvent))

	if (savedKeyStates[key] == nil) then
		savedKeyStates[key] = {isPressed = false, stateChangeTime = MagLib.getTime()}
	end
end

---Removes a specific hotkey callback
---@param key number
---@param callback function
---@param triggerEvent KeyEvent
Hotkeys.removeHotkey = function(key, callback, triggerEvent)
	local toRemoveIndex = nil
	if key == nil then
		-- iterate every key
		for _, callbackList in pairs(registeredHotkeyCallbacks) do
			for index, hotkeyCallback in pairs(callbackList) do
				if hotkeyCallback.callback == callback and hotkeyCallback.triggerEvent == triggerEvent then
					toRemoveIndex = index
					break
				end
			end
		end
	else
		-- Iterate only that key 
		if registeredHotkeyCallbacks[key] == nil then
			return
		end

		for index, hotkeyCallback in pairs(registeredHotkeyCallbacks[key]) do
			if hotkeyCallback.callback == callback and hotkeyCallback.triggerEvent == triggerEvent then
				toRemoveIndex = index
				break
			end
		end
	end

	if toRemoveIndex then
		table.remove(registeredHotkeyCallbacks[key], toRemoveIndex)
		if #registeredHotkeyCallbacks[key] == 0 then
			-- If no function in registeredHotkeyCallbacks for this specific key anymore, we can remove the table on that entry to speed up the module checking.
			registeredHotkeyCallbacks[key] = nil
			-- Also resetting saved key state
			savedKeyStates[key] = nil
		end
	end
end

Hotkeys.reset = function()
	registeredHotkeyCallbacks = {}
end

-- TODO: Make this cleaner
local isKeyPressed
if Infinity.BDO then
	isKeyPressed = Infinity.BDO.Input.IsKeyPressed
else
	isKeyPressed = function(key)
		return Infinity.Win32.GetAsyncKeyState(key) ~= 0
	end
end

-- Module that handles the actual hotkey handling
local module = MagLib.Run.Modules.RunModule("HotkeyModule", 0, 0, MagLib.Run.Modules.TimingMode.TimedCritical,
                                            MagLib.Run.EPulseTimingMode.Beginning)

module.run = function()
	local time = MagLib.getTime()

	for key, callbacks in pairs(registeredHotkeyCallbacks) do
		local isPressed = isKeyPressed(key)
		if (isPressed ~= savedKeyStates[key].isPressed) then
			local keyEvent = nil
			if isPressed then
				-- KeyDown
				keyEvent = Hotkeys.KeyEvents.OnKeyDown
			else
				-- KeyUp
				keyEvent = Hotkeys.KeyEvents.OnKeyUp
			end

			for _, callback in pairs(callbacks) do
				if (callback.triggerEvent == keyEvent) then
					callback.callback(key, time - savedKeyStates[key].stateChangeTime, callback.triggerEvent)
				end
			end

			savedKeyStates[key].isPressed = isPressed
			savedKeyStates[key].stateChangeTime = time
		end
	end
end
module.start()
MagLib.Run.Modules.Handler.addModule(module)

MagLib.Hotkeys = Hotkeys
