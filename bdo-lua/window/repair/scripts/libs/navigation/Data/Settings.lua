NavigatorSettings = { }
NavigatorSettings.__index = NavigatorSettings

setmetatable(NavigatorSettings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function NavigatorSettings.new()
  local self = setmetatable({}, NavigatorSettings)
    
  self.LastProfile = ""
  
  return self
end
