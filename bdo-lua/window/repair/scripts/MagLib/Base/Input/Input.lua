MagLib.Input = {}
local settings = {}
MagLib.Core.Settings.addSettingsToHandler("MagLib_Input", settings)

local getTime = MagLib.getTime
local isKeyPressed = MagLib.GameFunctions.isKeyPressed
MagLib.Events.addEventHandler("IsKeyPressedFunctionUpdated", function()
	isKeyPressed = MagLib.GameFunctions.isKeyPressed
end)
local keyDown = MagLib.GameFunctions.keyDown
MagLib.Events.addEventHandler("KeyDownFunctionUpdated", function()
	keyDown = MagLib.GameFunctions.keyDown
end)
local keyUp = MagLib.GameFunctions.keyUp
MagLib.Events.addEventHandler("KeyUpFunctionUpdated", function()
	keyUp = MagLib.GameFunctions.keyUp
end)

local keyStrings = MagLib.Constants.keyStrings

local keyData = {}
MagLib.Input.keyData = keyData
MagLib.Input.reset = function()
	for _, key in pairs(keyData) do
		keyData[key] = {pressUntil = 0}
	end
end

local debug = false
MagLib.Input.press = function(keys, delay)
	if debug then
		local s = ""
		for k, v in pairs(keys) do
			s = s .. keyStrings[v] .. ","
		end
		s = MagLib.Utils.Strings.trimRight(s, 1)
		print("Pressing Keys: " .. s .. " for " .. tostring(delay) .. " ms")
	end

	if type(keys) == "number" then
		keys = {keys}
	end

	local curTime = getTime()
	for _, key in pairs(keys) do
		if not keyData[key] then
			keyData[key] = {pressUntil = curTime + delay}
		else
			local old_pressUntil = keyData[key].pressUntil
			local new_pressUntil = curTime + delay
			if new_pressUntil > old_pressUntil then
				keyData[key].pressUntil = new_pressUntil
			end
		end
	end
end

local inputModule = MagLib.Run.Modules.RunModule("Input Manager", 0, 0, MagLib.Run.Modules.TimingMode.Exact,
                                                 MagLib.Run.EPulseTimingMode.Beginning)
inputModule.run = function()
	local time = getTime()

	local keysToDown = {}
	local keysToUp = {}
	local keysToRemove = {}
	local keysThatShouldBePressed = {}

	-- Iterating over all keys in the keyData list
	for keyValue, keyEntry in pairs(keyData) do
		local shouldBePressed = (keyEntry.pressUntil > time)
		local isPressed = isKeyPressed(keyValue)
		if shouldBePressed then
			table.insert(keysThatShouldBePressed, keyValue)
			if not isPressed then
				table.insert(keysToDown, keyValue)
			end
		else
			if isPressed then
				table.insert(keysToUp, keyValue)
			else
				table.insert(keysToRemove, keyValue)
			end
		end
	end

	if #keysToDown > 0 then
		for _, key in pairs(keysToDown) do
			keyDown(key)
		end
	end

	if #keysToUp > 0 then
		for _, key in pairs(keysToUp) do
			keyUp(key)
		end
	end

	for _, v in pairs(keysToRemove) do
		-- print("Removing " .. tostring(v) .. " from keyData")
		keyData[v] = nil
	end

	MagLib.Events.triggerEvent("InputModuleOnRun", keysThatShouldBePressed)
end
inputModule.start()
MagLib.Run.Modules.Handler.addModule(inputModule)
