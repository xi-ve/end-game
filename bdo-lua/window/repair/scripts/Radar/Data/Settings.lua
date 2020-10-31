Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.Filters = 
  	{
  		{Enabled = true, Name = "Players", ActorType = 0, DrawStyle = 1, Color = "50FF0050", Size = 50, Thickness = 1, Fill = true, Ids = {}},
  		{Enabled = true, Name = "Monsters", ActorType = 1, DrawStyle = 2, Color = "FFFF0000", Size = 50, Thickness = 2, Fill = false, Ids = {}},
  		{Enabled = true, Name = "Npcs", ActorType = 2, DrawStyle = 1, Color = "80505050", Size = 50, Thickness = 1, Fill = true, Ids = {}},
  		{Enabled = true, Name = "Collectables", ActorType = 6, DrawStyle = 2, Color = "5000FF00", Size = 50, Thickness = 1, Fill = true, Ids = {}}
	}

  return self
end
