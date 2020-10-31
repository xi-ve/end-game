local getTime = Infinity.Win32.GetPerformanceCounter
local lastPulseTime = 0
local lastPulseDur = -1
local avgPulseDur = 0
local pulsesCount = 0

local function onPulse()
  if lastPulseTime == 0 then
    lastPulseTime = getTime()
  end
  lastPulseDur = getTime() - lastPulseTime
  avgPulseDur = ((avgPulseDur * pulsesCount) + lastPulseDur) / (pulsesCount + 1)
  pulsesCount = pulsesCount + 1

  lastPulseTime = getTime()
end

local function onGuiDraw()
  ImGui.Begin("FPSStats")
  ImGui.Text("Last Pulse time: " .. lastPulseDur .. " ms")
  ImGui.SameLine()
  if ImGui.Button("Reset") then
    lastPulseDur = -1
    avgPulseDur = 0
    pulsesCount = 0
  end
  ImGui.Text("Average FPS: " .. math.floor(1000 / avgPulseDur) .. " FPS")

  ImGui.End()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
  onPulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
  onGuiDraw()
end)
