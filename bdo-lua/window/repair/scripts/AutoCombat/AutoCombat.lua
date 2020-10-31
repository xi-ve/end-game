AutoCombat = { }
AutoCombat.Running = false
AutoCombat.Settings = Settings()

AutoCombat.Routine = nil

AutoCombat.LastTick = 0

AutoCombat.Cached_MonsterTarget = nil
AutoCombat.Cached_PlayerTarget = nil

AutoCombat.MonstersInRange = {}
AutoCombat.ClosestMonsterAttack = nil

AutoCombat.PlayersInRange = {}
AutoCombat.ClosestPlayerAttack = nil

function AutoCombat.Start()	
  	AutoCombat.LoadSettings()
  	AutoCombat.LoadRoutine()    
end

function AutoCombat.Stop()
  	AutoCombat.SaveSettings() 
end

function AutoCombat.StartCombat()
	Infinity.BDO.Input.clearQueue()
	AutoCombat.Running = true
end

function AutoCombat.StopCombat()
	AutoCombat.Running = false
	Infinity.BDO.Input.clearQueue()
end

function AutoCombat.OnPulse()
	if AutoCombat.LastTick + 100 > Infinity.Win32.GetTickCount() then
		return
	end

	AutoCombat.LastTick = Infinity.Win32.GetTickCount()

	if AutoCombat.Routine == nil then
		return
	end

	if Infinity.BDO.Input.IsKeyPressed(AutoCombat.Routine.Hotkey) then
		AutoCombat.Running = true
	else
		AutoCombat.Running = false		
	end

  	if AutoCombat.Running then    	
    	AutoCombat.Cached_MonsterTarget = TargetHelper.getClosestMonsterTarget(AutoCombat.Routine.TargetRange)
    	AutoCombat.MonstersInRange = TargetHelper.getMonstersInRange(AutoCombat.Routine.TargetRange)
    	AutoCombat.ClosestMonsterAttack = TargetHelper.getClosestMonsterAttack(AutoCombat.MonstersInRange)

    	AutoCombat.Cached_PlayerTarget = TargetHelper.getClosestPlayerTarget(AutoCombat.Routine.TargetRange)
    	AutoCombat.PlayersInRange = TargetHelper.getPlayersInRange(AutoCombat.Routine.TargetRange)
    	AutoCombat.ClosestPlayerAttack = TargetHelper.getClosestPlayerAttack(AutoCombat.MonstersInRange)

    	if AutoCombat.ClosestPlayerAttack ~= nil and AutoCombat.Routine.onPlayerAttack ~= nil then
    		AutoCombat.Routine:onPlayerAttack(AutoCombat.ClosestPlayerAttack)
    	end

    	if AutoCombat.Cached_PlayerTarget ~= nil and AutoCombat.Routine.onPlayerPulse ~= nil then

    		AutoCombat.Routine.Target = AutoCombat.Cached_PlayerTarget
    		AutoCombat.Routine:onPlayerPulse()
    	end   

    	if AutoCombat.ClosestMonsterAttack ~= nil and AutoCombat.Routine.onMonsterAttack ~= nil then
    		AutoCombat.Routine:onMonsterAttack(AutoCombat.ClosestMonsterAttack)
    	end

    	if AutoCombat.Cached_MonsterTarget ~= nil and AutoCombat.Routine.onPulse ~= nil then

    		AutoCombat.Routine.Target = AutoCombat.Cached_MonsterTarget
    		AutoCombat.Routine:onPulse()
    	end    	
  	end
end

function AutoCombat.OnRenderD2D()
	if not AutoCombat.Running or AutoCombat.Routine == nil then
		return
	end

	RenderHelper.DrawWorldCircle(Infinity.BDO.getLocalPlayer():getPosition(), 50, "FF505000", 3, false)

	if AutoCombat.Routine.Target ~= nil then
		RenderHelper.DrawWorldCircle(AutoCombat.Routine.Target:getPosition(), 50, "FFFF5000", 3, false)
		RenderHelper.DrawWorldLine(Infinity.BDO.getLocalPlayer():getPosition(), AutoCombat.Routine.Target:getPosition(), "FF808080", 3)
		--RenderHelper.DrawWorldText(AutoCombat.Routine.Target:getPosition():getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition()), 16, "FFFFFFFF", AutoCombat.Routine.Target:getPosition())
	end

	if AutoCombat.ClosestMonsterAttack ~= nil then
		RenderHelper.DrawWorldCircle(AutoCombat.ClosestMonsterAttack:getPosition(), 50, "FF505050", 3, false)
	end

	--for k,v in pairs(AutoCombat.MonstersInRange) do
		--RenderHelper.DrawWorldCircle(v:getPosition(), 50, "80805000", 3, false)
		--RenderHelper.DrawWorldText(v:getCharacterControler():getCurrentAnimation():getName(), 16, "FFFFFFFF", v:getPosition())
	--end
end

function AutoCombat.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function AutoCombat.OnSelfActionChanged(action)
	if AutoCombat.Routine == nil then
		return
	end

	AutoCombat.Routine.CurrentAction = action

	for kT, saType in pairs(AutoCombat.Routine.SkillActions) do
		for kS,skillAction in pairs(saType) do
			skillAction:onSelfActionChange(action)
		end		
	end
end

function AutoCombat.LoadRoutine()	
	if AutoCombat.Settings.LastRoutine == "" then
		return
	end

    local code = Infinity.FileSystem.ReadFile("Routines/" .. AutoCombat.Settings.LastRoutine)
    local combatRoutineFunc, combatRoutineError = load(code)

    if combatRoutineFunc == nil then
        print(string.format("Unable to load combat script: func %s err %s", tostring(combatRoutineFunc), tostring(combatRoutineError)))
        return
    end

    AutoCombat.Routine = combatRoutineFunc()

    if not AutoCombat.Routine then
        print("Unable to load combat routine !")
        AutoCombat.Routine = nil
        return
    end
    
    if not AutoCombat.Routine.onPulse then
        print("Combat script doesn't have :onPulse function !")
        AutoCombat.Routine = nil
        return
    end 
end

function AutoCombat.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoCombat.Settings))
end

function AutoCombat.LoadSettings()
    local json = JSON:new()
    AutoCombat.Settings = Settings()
    
    table.merge(AutoCombat.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end