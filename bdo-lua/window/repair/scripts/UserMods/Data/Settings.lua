Settings = { }
Settings.__index = Settings

setmetatable(Settings, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Settings.new()
  local self = setmetatable({}, Settings)
      
  	self.Abilities = 
  	{
  		--{Name = "Movement", Type = EAbilityStats_Movement, Enabled = false, Value = 5, MinValue = 5, MaxValue = 10},
  		--{Name = "Attack", Type = EAbilityStats_Attack, Enabled = false, Value = 5, MinValue = 5, MaxValue = 10},
  		--{Name = "Cast", Type = EAbilityStats_Cast, Enabled = false, Value = 5, MinValue = 5, MaxValue = 10},
  		--{Name = "Crit", Type = EAbilityStats_Crit, Enabled = false, Value = 0, MinValue = 0, MaxValue = 5},
  		--{Name = "Luck", Type = EAbilityStats_Luck, Enabled = false, Value = 0, MinValue = 0, MaxValue = 5},
  		--{Name = "Fishing", Type = EAbilityStats_Fishing, Enabled = false, Value = 0, MinValue = 0, MaxValue = 5},
  		{Name = "Gathering", Type = EAbilityStats_Gathering, Enabled = false, Value = 0, MinValue = 0, MaxValue = 5},
	}

	self.Resistances =
	{
		--{Name = "Knockdown", Type = EResistance_Knockdown, Enabled = false, Value = 20, MinValue = 20, MaxValue = 100},
		--{Name = "Stun", Type = EResistance_Stun, Enabled = false, Value = 20, MinValue = 20, MaxValue = 100},
		--{Name = "Knockback", Type = EResistance_Knockback, Enabled = false, Value = 20, MinValue = 20, MaxValue = 100},
		--{Name = "Catch", Type = EResistance_Catch, Enabled = false, Value = 20, MinValue = 20, MaxValue = 100},
	}

	self.Productions =
	{
		{Name = "Alchemy", Type = EDecreaseTime_Alchemy, Enabled = false, Value = 0, MinValue = 0, MaxValue = 10.0},
		{Name = "Cooking", Type = EDecreaseTime_Cooking, Enabled = false, Value = 0, MinValue = 0, MaxValue = 10.0}
	}

	self.Others =
	{
		--{Name = "Add Critrate", Enabled = false, Value = 0, MinValue = 0, MaxValue = 100.0},
		{Name = "Jump Height", Enabled = false, Value = 0, MinValue = 0, MaxValue = 50000.0},
	}

	self.Diving =
	{
		UnlimitedBreath = false
	}

  return self
end
