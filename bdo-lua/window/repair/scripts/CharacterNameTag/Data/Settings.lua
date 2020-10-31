Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
    
  self.Vars = {}

  self.Vars.ShowPlayerLevels = {VarName = "g_ShowPlayerLevels", Value = false}
  self.Vars.ShowMonsterLevels = {VarName = "g_ShowMonsterLevels", Value = false}
  self.Vars.ShowKnowledgeHint = {VarName = "g_ShowKnowledgeHint", Value = false}
  self.Vars.ShowObtainedKnowledge = {VarName = "g_ShowObtainedKnowledge", Value = false}
  --self.Vars.ShowHpBarWithoutKnowledge = {VarName = "g_ShowHpBarWithoutKnowledge", Value = false}
  self.Vars.ShowMonsterHp = {VarName = "g_ShowMonsterHp", Value = false}
  self.Vars.ShowPlayerHp = {VarName = "g_ShowPlayerHp", Value = false}
  --self.Vars.ShowPlayerGearScore = {VarName = "g_ShowPlayerGearScore", Value = false}

  return self
end
