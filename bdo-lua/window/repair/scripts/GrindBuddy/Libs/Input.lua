Input = {}
Input.currentlyPressedKeys = {} -- Element: {startTime = 123123123, delay = 100, pressed = true}

Input.waitingForReset = false

function Input._keysUp(keys)
    Log.debugLog("Upping keys " .. table.toString(keys))
    Infinity.BDO.Input.PressKeys_Up(keys)
end

function Input.waitForReset()
    Input.waitingForReset = true
end

function Input.pressOnce(keys, delay)
    Log.debugLog("Input pressOnce: delay =  " .. delay .. " keys " .. table.toString(keys))
    for _, key in pairs(keys) do
        if not Input.currentlyPressedKeys[key] then
            --is not currently pressed
            Input.currentlyPressedKeys[key] = {startTime = Cache.time, delay = delay, pressed = false}
        else
            local startTime = Input.currentlyPressedKeys[key].startTime
            local savedDelay = Input.currentlyPressedKeys[key].delay
            if (startTime + savedDelay) < Cache.time + delay then
                --Should be pressed longer than saved info, updating
                local alreadyPressed = Infinity.BDO.Input.IsKeyPressed(key) --maintaining pressed status
                Input.currentlyPressedKeys[key] = {startTime = Cache.time, delay = delay, pressed = alreadyPressed}
            end
        end
    end
end

function Input.reset()
    local didSth = false
    --[[if not Infinity.BDO.Input.isEmptyQueue() then
        Infinity.BDO.Input.clearQueue()
        didSth = true
    end

    local keysToUp = {}
    for _, v in ipairs(Grinder.VirtualKeyCode) do
        if Infinity.BDO.Input.IsKeyPressed(v) then
            Infinity.BDO.Input.PressKeys_Up(v)
            table.insert("KeysToUp")
        end
    end

    didSth = true
    Input.currentlyPressedKeys = {}]]
    return didSth
end

function Input.onPulse()
    --[]
    local keysToUp = {}
    local keysToDown = {}

    local secureMode = Grinder.settings.secureInput

    if secureMode then
        if Infinity.BDO.getLocalPlayer():getCharacterControler():getNextAction() then
            Grinder.wait(100)
            keysToUp = nil
            keysToDown = nil
            secureMode = nil
            return true
        end
    end

    for k, v in pairs(Input.currentlyPressedKeys) do
        local currentTime = Infinity.Win32.GetTickCount()
        local timeUntilDown = v.startTime + v.delay
        if timeUntilDown < currentTime then
            table.insert(keysToUp, k)
        elseif v.pressed == false then
            table.insert(keysToDown, k)
            v.pressed = true
        end

        secureMode = nil
        currentTime = nil
        timeUntilDown = nil
    end

    if #keysToDown > 0 then
        --Log.debugLog("Downing " .. table.toString(keysToDown))
        Infinity.BDO.Input.PressKeys_Down(keysToDown)
        if secureMode then
            Grinder.wait(100)
        end

        secureMode = nil
        keysToUp = nil
        keysToDown = nil
        return true
    end

    keysToDown = nil

    for _, k in pairs(keysToUp) do
        if Input.currentlyPressedKeys[k] then
            Input.currentlyPressedKeys[k] = nil
        end
    end

    if #keysToUp > 0 then
        --Log.debugLog("Upping " .. table.toString(keysToUp))
        Infinity.BDO.Input.PressKeys_Up(keysToUp)
        if secureMode then
            Grinder.wait(50)
        end
        keysToUp = nil
        secureMode = nil
        return true
    end

    keysToUp = nil
    secureMode = nil

    if Grinder.settings.allow_waiting_for_key_reset or Input.waitingForReset then
        if table.valueLength(Input.currentlyPressedKeys) > 0 then
            Grinder.wait(10)
            return true
        else
            Input.waitingForReset = false
        end
    end

    return false
end
