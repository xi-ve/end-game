local nextWeatherTick = 0
local selectedWeatherType = 0
local selectedWeatherTime = 15

local function setWeatherTime(weatherType, weatherTime)
  local code = "setWeatherTime("..weatherType..","..weatherTime..")"
  Infinity.BDO.Lua.Execute(code)
end

function onAutoLoginAutoLoad()
	setWeatherTime(selectedWeatherType, selectedWeatherTime)
end

function onGUIDraw()
  ImGui.Begin("WeatherTool")

  _, selectedWeatherType = ImGui.InputInt("type", selectedWeatherType, 0, 0, 0)
  _, selectedWeatherTime = ImGui.InputInt("time", selectedWeatherTime, 0, 0, 0)

  if ImGui.Button("Apply") then
    setWeatherTime(selectedWeatherType, selectedWeatherTime)
  end

  ImGui.End()
end

Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnGUIDraw", onGUIDraw)
Infinity.Scripting.CurrentScript:RegisterCallback("Infinity.OnAutoLoginAutoLoad", onAutoLoginAutoLoad)