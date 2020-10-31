LootSession = { }
LootSession.__index = LootSession

setmetatable(LootSession, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LootSession.new()
  local self = setmetatable({}, LootSession)   
    
  self.StartDate = {}
  self.StartDate.Year = 0
  self.StartDate.Month = 0
  self.StartDate.Day = 0
  self.StartDate.Hour = 0
  self.StartDate.Minute = 0
  self.StartDate.Second = 0

  self.StartTick = 0

  self.EndDate = {}
  self.EndDate.Year = 0
  self.EndDate.Month = 0
  self.EndDate.Day = 0
  self.EndDate.Hour = 0
  self.EndDate.Minute = 0
  self.EndDate.Second = 0

  self.EndTick = 0
  
  self.DurationTick = 0
  
  self.LastTick_AddItem = 0

  self.ItemStats = {}

  return self
end

function LootSession:initNew()

  local date_table = os.date("*t")

  self.StartDate.Year = date_table.year
  self.StartDate.Month = date_table.month
  self.StartDate.Day = date_table.day
  self.StartDate.Hour = date_table.hour
  self.StartDate.Minute = date_table.min
  self.StartDate.Second = date_table.sec

  self.StartTick = Infinity.Win32.GetTickCount()

  self.EndDate.Year = date_table.year
  self.EndDate.Month = date_table.month
  self.EndDate.Day = date_table.day
  self.EndDate.Hour = date_table.hour
  self.EndDate.Minute = date_table.min
  self.EndDate.Second = date_table.sec

  self.EndTick = self.StartTick

  self.LastTick_AddItem = self.StartTick

  return self
end

function LootSession:initFromFile(file)

  local json = JSON:new()
  table.merge(self, json:decode(Infinity.FileSystem.ReadFile("\\Sessions\\" .. file)))

  return self
end

function LootSession:updateDuration()

  local date_table = os.date("*t")

  self.EndDate.Year = date_table.year
  self.EndDate.Month = date_table.month
  self.EndDate.Day = date_table.day
  self.EndDate.Hour = date_table.hour
  self.EndDate.Minute = date_table.min
  self.EndDate.Second = date_table.sec

  self.EndTick = Infinity.Win32.GetTickCount()

  self.DurationTick = self.EndTick - self.StartTick
end

function LootSession:getDurationInHours()

  if self.DurationTick <= 0 then
    return 0
  end

  return self.DurationTick / 1000 / 60 / 60
end

function LootSession:getDurationFormated()

  return string.format("%02.fD %02.f:%02.f:%02.f", math.floor((self.DurationTick / 1000) /(60 * 60 * 24)), math.floor((self.DurationTick / 1000) /(60 * 60)), math.floor((self.DurationTick / 1000) / 60) % 60, (self.DurationTick / 1000) % 60)
end

function LootSession:saveToFile()

  if table.length(self.ItemStats) <= 0 then
    return
  end

  local fileName = self.StartDate.Year .. "-" .. self.StartDate.Month .. "-" .. self.StartDate.Day .. " " .. self.StartDate.Hour .. "_" .. self.StartDate.Minute .. "_" .. self.StartDate.Second .. ".json"

  local json = JSON:new()
  Infinity.FileSystem.WriteFile("\\Sessions\\" .. fileName, json:encode_pretty(self))
end

function LootSession:exportToCSV()

  local csvOutput = "Name\tItemEnchantKey\tItemId\tEnchantLevel\tCount\t/Hour\n"

  for k,v in pairs(self.ItemStats) do
    
    local itemEnchantKey = v.ItemEnchantKey
    local itemId = Utils.getItemId(itemEnchantKey)
    local enchantLevel = Utils.getEnchantLevel(itemEnchantKey)

    csvOutput = csvOutput .. v.Name .. "\t" .. itemEnchantKey .. "\t" .. itemId .. "\t" .. enchantLevel .. "\t" .. v.Count .. "\t" .. string.format("%.2f", (v.Count / self:getDurationInHours())) .. "\n"
  end

  csvOutput = csvOutput .. "\n\nSession Duration\n" .. self:getDurationFormated()

  local fileName = self.StartDate.Year .. "-" .. self.StartDate.Month .. "-" .. self.StartDate.Day .. " " .. self.StartDate.Hour .. "_" .. self.StartDate.Minute .. "_" .. self.StartDate.Second .. ".csv"
  
  Infinity.FileSystem.WriteFile("\\CSV\\" .. fileName, csvOutput)
end

function LootSession:getItemName(itemEnchantKey)

  local code = 
      [[
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(]] .. Utils.getItemId(itemEnchantKey) .. [[, ]] .. Utils.getEnchantLevel(itemEnchantKey) .. [[))
        
        if itemSSW ~= nil then
          return itemSSW:getName()
        end

        return "nA."
      ]]

      return Infinity.BDO.Lua.Execute(code)
end

function LootSession:addItem(itemEnchantKey, count) 

  --print("LootSession:addItem -> " .. itemEnchantKey .. " ; " .. count)

  if self:getItemStats(itemEnchantKey) == nil then
    
    local name = self:getItemName(itemEnchantKey)
    local enchantLevel = Utils.getEnchantLevel(itemEnchantKey)

    if name ~= "nA." and enchantLevel > 0 then
      name = name .. " +" .. tostring(enchantLevel)
    end

    table.insert(self.ItemStats, {ItemEnchantKey = itemEnchantKey, Name = name, Count = count})
  else

    self:increaseItemCount(itemEnchantKey, count)
  end

  self.LastTick_AddItem = Infinity.Win32.GetTickCount()

  return self
end

function LootSession:increaseItemCount(itemEnchantKey, count)

  for k,v in pairs(self.ItemStats) do
    
    if v.ItemEnchantKey == itemEnchantKey then
      
      v.Count = v.Count + count
      break
    end
  end
end

function LootSession:addDuration(duration)
  
  self.DurationTick = self.DurationTick + duration

  return self
end

function LootSession:mergeLootSession(lootSession)

  for k, stats in pairs(lootSession.ItemStats) do
    
    self:addItem(stats.ItemEnchantKey, stats.Count)    
  end

  self:addDuration(lootSession.DurationTick)

  return self
end

function LootSession:getItemStats(itemEnchantKey)

  for k,v in pairs(self.ItemStats) do
    
    if v.ItemEnchantKey == itemEnchantKey then
      return v
    end
  end

  return nil
end