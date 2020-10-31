local settings = {useKeyflag = true, resetKeyFlagMs = 20, isKeyPressedChecksKeyFlag = true}
MagLib.Core.Settings.addSettingsToHandler("MagLib_BDO_Input", settings)

local keyFlags = MagLib.BDO.Constants.keyFlags
local isBitSet = MagLib.Utils.Math.Bit.isBitSet

local currentlyResetting = false
local currentlyResetting_originalKeyFlag = 0

local getFlagValueOfKey = function(key)
	return keyFlags[key]
end

local isKeyPressed = function(key)
	-- First check if pressed over keyboard
	local keyboardPressed = Infinity.BDO.Input.IsKeyPressed(key)
	if (keyboardPressed) then
		return true
	end

	-- Then check if it is pressed over keyflag
	if settings.isKeyPressedChecksKeyFlag then
		local currentFlag = Infinity.BDO.Input.getKeyInputFlagValue()
		if currentlyResetting then
			currentFlag = currentlyResetting_originalKeyFlag
		end

		local flagValue = getFlagValueOfKey(key)
		if flagValue then
			return bit.band(currentFlag, flagValue) ~= 0
		end
	end

	return false
end
MagLib.GameFunctions.setIsKeyPressedFunction(isKeyPressed)

local keyDown = function(key)
	if currentlyResetting then
		return
	end

	-- print("keydown: " .. key)
	local flagValue = getFlagValueOfKey(key)
	if settings.useKeyflag and flagValue then
		-- Can be set over keyflag 
		-- We do this is inputModuleOnRun
	else
		-- Not a keyflag key
		Infinity.BDO.Input.PressKeys_Down({key})
	end

	-- print("Keyflag: " .. Infinity.BDO.Input.getKeyInputFlagValue())
end
MagLib.GameFunctions.setKeyDownFunction(keyDown)

local keyUp = function(key)
	-- Uping keyboard 
	local keyboardPressed = Infinity.BDO.Input.IsKeyPressed(key)
	if (keyboardPressed) then
		Infinity.BDO.Input.PressKeys_Up({key})
	end

	-- Upping over keyflag
	local flagValue = getFlagValueOfKey(key)
	if settings.useKeyflag and flagValue then
		local currentFlag = Infinity.BDO.Input.getKeyInputFlagValue()
		if bit.band(currentFlag, flagValue) ~= 0 then
			-- The keyflag bit is currently set, so we can just subtract to up the key in the keyflag
			-- print("Deducting " .. flagValue .." from keyflag")
			local newFlag = currentFlag - flagValue
			-- Setting new value
			if newFlag == 0 then
				Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
			else
				Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
			end
			Infinity.BDO.Input.setKeyInputFlagValue(newFlag)
		end
	end

	-- print("Keyflag: " .. Infinity.BDO.Input.getKeyInputFlagValue())
end
MagLib.GameFunctions.setKeyUpFunction(keyUp)

-- Resetting keyflag when needed
local lastCheckModResult = 0
local inputModuleOnRun = function(keysThatAreCurrentlyPressed)
	if settings.useKeyflag then
		if currentlyResetting then
			-- print("Resetting done")
			Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
			Infinity.BDO.Input.setKeyInputFlagValue(currentlyResetting_originalKeyFlag)
			currentlyResetting = false
			return
		end

		local time = MagLib.getTime()
		local modToResetResult = math.floor(time % settings.resetKeyFlagMs)

		-- Making sure the flag contains all the keys it should 
		local newFlag = Infinity.BDO.Input.getKeyInputFlagValue()
		for _, key in pairs(keysThatAreCurrentlyPressed) do
			local flagValue = getFlagValueOfKey(key)
			if flagValue ~= nil then
				newFlag = bit.bor(newFlag, flagValue)
			end
		end
		Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
		Infinity.BDO.Input.setKeyInputFlagValue(newFlag)
		if newFlag == 0 then
			Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
		elseif (modToResetResult < lastCheckModResult) then
			currentlyResetting = true
			currentlyResetting_originalKeyFlag = newFlag
			Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
			-- Infinity.BDO.Input.setKeyInputFlagValue(0)
			lastCheckModResult = 0
		else
			Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
			Infinity.BDO.Input.setKeyInputFlagValue(newFlag)
			lastCheckModResult = modToResetResult
		end
	end
end
MagLib.GameFunctions.setInputModuleOnRunFunction(inputModuleOnRun)

-- Registering EndScript callback
MagLib.Events.addEventHandler("EndScript", function()
	Infinity.BDO.Input.setIsKeyInputFlagOverride(false)
	Infinity.BDO.Input.setKeyInputFlagValue(0)
end)
