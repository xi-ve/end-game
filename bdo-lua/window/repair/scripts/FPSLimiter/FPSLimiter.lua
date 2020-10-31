local settings = 
{
  fpsLimit = 120,
  active = false,
}
MagLib.Core.Settings.addSettingsToHandler("FPSLimiter", settings)


local getTime = MagLib.getTime

local lastPulseTime = nil
local function onPulse()

  if settings.fpsLimit < 10 then 
    settings.fpsLimit = 10 
  end

  if MagLib.onPulse_Beginning() then return end

  if settings.active and lastPulseTime ~= nil then 
    local wantedDelta = 1000 / settings.fpsLimit
    local delta = getTime() - lastPulseTime
    if delta < wantedDelta then 
      MagLib.sleep(wantedDelta - delta)
    end
  end

  MagLib.onPulse_End()

  lastPulseTime = MagLib.getTime()
end

local UI = MagLib.UI
local function onGuiDraw()
  UI.Begin("FPS Limiter")
  ImGui.SetWindowSize(ImVec2(430, 120))
  UI.Text("Limiting the FPS over this script will free up a lot of CPU ressources!")
  settings.active = UI.Checkbox("Active: ", settings.active)
  settings.fpsLimit = UI.InputInt("FPS Limit: ", settings.fpsLimit)
  UI.End()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnPulse", function()
  onPulse()
end)

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", function()
  onGuiDraw()
end)
