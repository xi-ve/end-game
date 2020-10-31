DPSMeter = { }
DPSMeter.ValueCache = ValueCache.new()

function DPSMeter.Start()	    
end

function DPSMeter.Stop() 
end

function DPSMeter.OnPulse()
	DPSMeter.ValueCache:onPulse()
end

function DPSMeter.OnGuiDraw()
	GUI.Draw()
end

function DPSMeter.OnAddDamage(attackerActorKey, attackeeActorKey, value, effectType, isNotSelf)
	DPSMeter.ValueCache:onAddDamage(attackerActorKey, attackeeActorKey, value, effectType, isNotSelf)
end