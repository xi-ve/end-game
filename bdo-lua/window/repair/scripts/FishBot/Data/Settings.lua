Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.CatchGrades = {}
  self.CatchGrades.White = {Enabled = false}
  self.CatchGrades.Green = {Enabled = true}
  self.CatchGrades.Blue = {Enabled = false}
  self.CatchGrades.Yellow = {Enabled = false}
  self.CatchGrades.Orange = {Enabled = false}

  self.PredictGrades = {}
  self.PredictGrades.White = {Enabled = false}
  self.PredictGrades.Green = {Enabled = true}
  self.PredictGrades.Blue = {Enabled = false}
  self.PredictGrades.Yellow = {Enabled = false}
  self.PredictGrades.Orange = {Enabled = false}

  self.Items = {}

  self.Speedhack = {Enabled = false, Value = 10.0}
  self.DeleteRods = {Enabled = true}
  self.PredictMode = {Enabled = false}
  self.AllLoot = {Enabled = false}

  self.NearbyPlayersStop = true
  self.NearbyPlayersStopPredict = true
  self.NearbyPlayersFishingStop = false
  self.RandomCatchTimer = false
  self.NearbyPlayersRandomCatchTimer = false

  self.AutoCombineRelics = false

  self.TentRepair = false
  return self
end
