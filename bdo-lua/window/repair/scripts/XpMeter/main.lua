Bot = {}

function Bot.GetLevel()
    return Infinity.BDO.getLocalPlayer():getLevel()
end

function Bot.GetExpPercent()
    return (Infinity.BDO.getLocalPlayer():getCurrentExp():getUnsafe() / Infinity.BDO.getLocalPlayer():getRequiredExp():getUnsafe()) * 100
end

function Bot.ResetStats()
    Bot.LastLevel = Bot.GetLevel()
    Bot.LastExp = Bot.GetExpPercent()
    Bot.AvgExpPerSecond = 0
end

function Bot.Pulse()
    if Bot.Start == false then
        return
    end

    if Bot.PulseTimer == nil or Bot.PulseTimer:Expired() then
        Bot.PulseTimer = Timer(1)
        Bot.PulseTimer:Start()
    else
        return
    end

    local player = Infinity.BDO.getLocalPlayer()

    if player == nil then
        return
    end

    local level = Bot.GetLevel()
    local exp = Bot.GetExpPercent()

    if level ~= Bot.LastLevel then
        Bot.ResetStats()
        return
    end

    local expGain = exp - Bot.LastExp

    local window = 60 * 3
    if Bot.AvgExpPerSecond == 0 then
        Bot.AvgExpPerSecond = expGain
    else
        Bot.AvgExpPerSecond = (Bot.AvgExpPerSecond * (window - 1) + expGain) / window
    end

    Bot.LastLevel = level
    Bot.LastExp = exp
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function() 

    ImGui.Begin("XP-Meter")
    
        ImGui.SetWindowSize(ImVec2(220,100), ImGuiCond_FirstUseEver)

        if Bot.AvgExpPerSecond ~= nil and Bot.AvgExpPerSecond >= 0 then
            local average = Bot.AvgExpPerSecond

            ImGui.Text(string.format("Per minute: %.03f", average * 60))
            ImGui.Text(string.format("Per hour: %.03f", average * 60 * 60))

            -- ImGui.Text(string.format("Exp: %.03f", Bot.GetExpPercent()))
            -- ImGui.Text(string.format("Last exp: %.03f", Bot.LastExp))

            local total = (100 - Bot.LastExp) / Bot.AvgExpPerSecond
            local seconds = math.fmod(total, 60)
            local minutes = math.fmod(total, 60 * 60) / 60
            local hours = math.floor(total / 60 / 60)
            
            if average ~= 0 then
                if hours > 0 then
                    ImGui.Text(string.format("Time for next level: %.f:%02.f:%02.f", hours, minutes, seconds))
                else
                    ImGui.Text(string.format("Time for next level: %.f:%02.f", minutes, seconds))
                end
            else
                ImGui.Text("Time for next level: 0:00")
            end
        end

        if ImGui.Button("Reset##btn_reset", ImVec2(ImGui.GetContentRegionAvailWidth(), 20)) then
            Bot.ResetStats()
        end

        ImGui.End()    
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
    Bot.Pulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStart", function()
    Bot.Start = true
    Bot.ResetStats()
end)
 
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnScriptStop", function()
    Bot.Start = false
end)