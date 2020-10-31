ProfileSettings = { }
ProfileSettings.__index = ProfileSettings

setmetatable(ProfileSettings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ProfileSettings.new()
  local self = setmetatable({}, ProfileSettings)
    
  self.Name = ""

  self.AnimEnabled = false
  self.Speed = 1.0
  self.UseGlobalSpeedValue = true
  self.DefaultSpeed = 1.0
  self.WhitelistedAnimations = {}
  
  self.MvmtPlayer = {}
  self.MvmtPlayer.Enabled = false
  self.MvmtPlayer.Speed = 20.0
  self.MvmtPlayer.StopOnAnimHack = false

  self.Vehicle = {}
  self.Vehicle.Enabled = false

  self.Vehicle.Speed = {}
  self.Vehicle.Speed.Enabled = true
  self.Vehicle.Speed.Value = 100.0
  self.Vehicle.Speed.Default = 100.0

  self.Vehicle.Accel = {}
  self.Vehicle.Accel.Enabled = true
  self.Vehicle.Accel.Value = 100.0
  self.Vehicle.Accel.Default = 100.0

  self.Vehicle.Turn = {}
  self.Vehicle.Turn.Enabled = true
  self.Vehicle.Turn.Value = 100.0
  self.Vehicle.Turn.Default = 100.0

  self.Vehicle.Brake = {}
  self.Vehicle.Brake.Enabled = true
  self.Vehicle.Brake.Value = 100.0
  self.Vehicle.Brake.Default = 100.0
  
  self.Vehicle.AnimEnabled = false
  self.Vehicle.AnimSpeed = 1.0
  self.Vehicle.WhitelistedAnimations = {}

  return self
end
