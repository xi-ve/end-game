Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.AutoLoot = {}
  self.AutoLoot.Enabled = true
  self.AutoLoot.Delay = 250

  self.AutoEquip = {}
  self.AutoEquip.Enabled = true
  self.AutoEquip.Delay = 250
  self.AutoEquip.ForceCancel = false

  return self
end
