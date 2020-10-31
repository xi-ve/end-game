Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.CombineRelics = true
  self.CombineBooks = true
  self.CombineScrolls = true
  self.CombineDolls = true
  self.CombineEventItems = true
  self.CombineUnderwaterRelic = true

  return self
end
