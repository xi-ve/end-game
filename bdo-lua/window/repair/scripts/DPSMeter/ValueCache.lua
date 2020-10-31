ValueCache = { }
ValueCache.__index = ValueCache

EFFECT_NORMAL_HIT = 0
EFFECT_CRIT_HIT = 1
EFFECT_BLOCK = 2
EFFECT_IMPACT = 3
EFFECT_RESIST = 4
EFFECT_MISS = 5
EFFECT_HEAL = 6
EFFECT_EXP = 8

setmetatable(ValueCache, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ValueCache.new()
  local self = setmetatable({}, ValueCache)   
    
  self.Log = {}

  self.Values = {}
  self.Values.DealtDamage = 0
  self.Values.TotalHit = 0
  self.Values.Miss = 0
  self.Values.Hit = 0
  self.Values.CritHit = 0
  self.Values.Block = 0
  self.Values.Impact = 0
  self.Values.Resist = 0

  self.TotalTicks = 0
  self.LastTick = 0

  return self
end

function ValueCache:reset()
  self.TotalTicks = 0
  self.LastTick = 0

  self.Log = {}

  self.Values.DealtDamage = 0
  self.Values.TotalHit = 0
  self.Values.Miss = 0
  self.Values.Hit = 0
  self.Values.CritHit = 0
  self.Values.Block = 0
  self.Values.Impact = 0
  self.Values.Resist = 0
end

function ValueCache:isLocalPlayerDealtDamage(attackerKey)
  return Infinity.BDO.getLocalPlayer():getActorKey() == attackerKey
end

function ValueCache:getColorByType(effectType)

  if effectType == EFFECT_NORMAL_HIT then         
    return "80FFFFFF"
  elseif effectType == EFFECT_CRIT_HIT then    
    return "80FF0000"
  elseif effectType == EFFECT_BLOCK then    
    return "80FFFF00"
  elseif effectType == EFFECT_IMPACT then    
    return "8000FFFF"
  elseif effectType == EFFECT_RESIST then    
    return "80505050"
  elseif effectType == EFFECT_MISS then    
    return "80805080"
  else                            -- any other
    return "80205000"
  end
end

function ValueCache:drawStats()
  
  local hUptime = ((self.TotalTicks / 1000) /(60 * 60))
  local sUptime = self.TotalTicks / 1000

  ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("80FFFFFF"))
  ImGui.Text(string.format("UpTime:  %02.f:%02.f:%02.f", math.floor(hUptime), math.floor((self.TotalTicks / 1000) / 60) % 60, (self.TotalTicks / 1000) % 60))
  ImGui.PopStyleColor(1)

  if sUptime > 0 then

    ImGui.Spacing()

    ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FFFFFF00"))
    ImGui.Text("DPS: " .. math.floor(self.Values.DealtDamage / sUptime))
    ImGui.PopStyleColor(1)
  end

  ImGui.Spacing()

  if self.Values.TotalHit > 0 then

    ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FF008050"))
    ImGui.Text("Total Hits: " .. self.Values.TotalHit)
    ImGui.SameLine()
    ImGui.Text("Missed Hits: " .. self.Values.Miss .. " (" .. math.floor((self.Values.Miss / self.Values.TotalHit)*100) .. "%%)")
    ImGui.PopStyleColor(1)

    ImGui.Spacing()

    ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString("FF505050"))
    ImGui.Text("Normal Hits: " .. self.Values.Hit .. " (" .. math.floor((self.Values.Hit / self.Values.TotalHit)*100) .. "%%)")
    ImGui.Text("Crit Hits: " .. self.Values.CritHit .. " (" .. math.floor((self.Values.CritHit / self.Values.TotalHit)*100) .. "%%)")
    ImGui.Text("Blocked Hits: " .. self.Values.Block .. " (" .. math.floor((self.Values.Block / self.Values.TotalHit)*100) .. "%%)")
    ImGui.Text("Impact Hits: " .. self.Values.Impact .. " (" .. math.floor((self.Values.Impact / self.Values.TotalHit)*100) .. "%%)")
    ImGui.Text("Resisted Hits: " .. self.Values.Resist .. " (" .. math.floor((self.Values.Resist / self.Values.TotalHit)*100) .. "%%)")  
    ImGui.PopStyleColor(1)
  end
end

function ValueCache:drawLog()
  
  ImGui.Spacing()
  ImGui.Spacing()

  for k,v in pairs(self.Log) do
    
    ImGui.PushStyleColor2(ImGuiCol_Text, RenderHelper.GetColorImVec4FromHexColorString(self:getColorByType(v.Type)))

    ImGui.Text(v.Value .. " " .. v.Prefix)

    ImGui.PopStyleColor(1)
  end
end

function ValueCache:getEffectTypePrefix(effectType)

  if effectType == EFFECT_NORMAL_HIT then         
    return "Hit"
  elseif effectType == EFFECT_CRIT_HIT then    
    return "Crit"
  elseif effectType == EFFECT_BLOCK then    
    return "Block"
  elseif effectType == EFFECT_IMPACT then    
    return "Impact"
  elseif effectType == EFFECT_RESIST then    
    return "Resist"
  elseif effectType == EFFECT_MISS then    
    return "Miss"
  elseif effectType == EFFECT_EXP then    
    return "Exp"
  elseif effectType == EFFECT_HEAL then    
    return "Heal"
  else
    return "Unknown(" .. tostring(effectType) .. ")"
  end
end

function ValueCache:addLogEntry(value, effectType)

  table.insert(self.Log, {Type = effectType, Value = value, Prefix = self:getEffectTypePrefix(effectType)})

  if table.length(self.Log) > 12 then
    table.remove(self.Log, 1)
  end
end

function ValueCache:addValueByType(value, effectType)

  value = math.abs(value)
  
  self:addLogEntry(value, effectType)

  if value > 0 and effectType < 6 then
    self.Values.DealtDamage = self.Values.DealtDamage + value
  end

  if effectType < 6 then
    self.Values.TotalHit = self.Values.TotalHit + 1
  end

  if effectType == EFFECT_NORMAL_HIT then         
    self.Values.Hit = self.Values.Hit + 1
  elseif effectType == EFFECT_CRIT_HIT then    
    self.Values.CritHit = self.Values.CritHit + 1
  elseif effectType == EFFECT_BLOCK then    
    self.Values.Block = self.Values.Block + 1
  elseif effectType == EFFECT_IMPACT then    
    self.Values.Impact = self.Values.Impact + 1
  elseif effectType == EFFECT_RESIST then    
    self.Values.Resist = self.Values.Resist + 1
  elseif effectType == EFFECT_MISS then    
    self.Values.Miss = self.Values.Miss + 1
  elseif effectType == EFFECT_EXP then  
    --do nothing on received exp
  elseif effectType == EFFECT_HEAL then  
    --do nothing on received exp
  end
end

function ValueCache:onAddDamage(attackerKey, attackeeKey, value, effectType, isNotSelf) 
  
  if self:isLocalPlayerDealtDamage(attackerKey) then
    
    --self.UpdateTicks = true
    self:addValueByType(value, effectType)

    if self.LastTick == 0 then
      self.LastTick = Infinity.Win32.GetTickCount()
    end

    self.TotalTicks = self.TotalTicks + (Infinity.Win32.GetTickCount() - self.LastTick)
    self.LastTick = Infinity.Win32.GetTickCount()
  end
end

function ValueCache:onPulse()  
end