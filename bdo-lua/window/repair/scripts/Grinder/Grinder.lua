Grinder = { }
Grinder.Running = false
Grinder.Settings = Settings()
Grinder.Navigator = Navigator()

Grinder.FSM = FSM()

Grinder.Routine = nil

Grinder.MoveState = nil
Grinder.CombatState = nil

function Grinder.OnAutoLoginAutoLoad()
  Grinder.StartBot()
end

function Grinder.Start()
  Grinder.LoadSettings()
  Grinder.LoadRoutine() 
end

function Grinder.StartBot()
	Grinder.Running = true
	  	
  Grinder.FSM = FSM()
  
  Grinder.MoveState = MoveState(Grinder.Navigator.CurrentProfile, Grinder.Settings.UseTpNav)	
  Grinder.MoveState:SetCallback_DestinationReached(Grinder.OnDestinationReached)
  
  Grinder.CombatState = CombatState()

  Grinder.FSM:AddState(AntiStuckState())
	Grinder.FSM:AddState(Grinder.CombatState)
	Grinder.FSM:AddState(Grinder.MoveState)	
end

function Grinder.StopBot()
  Grinder.Running = false
end

function Grinder.Stop()
  Grinder.SaveSettings()
end

function Grinder.OnPulse()
	Grinder.Navigator:OnPulse()

  if Grinder.Running == false then
    return
  end

  if Grinder.Settings.UseTpNav then
    if Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby() then
      Grinder.MoveState.UseTp = false
    else
      Grinder.MoveState.UseTp = true
    end
  end

  Grinder.FSM:Pulse()
end

function Grinder.OnSelfActionChanged(action)
	if Grinder.Routine == nil then
		return
	end

	Grinder.Routine.CurrentAction = action

	for kT, sa in pairs(Grinder.Routine.SkillActions) do
		sa:onSelfActionChange(action)
	end
end

function Grinder.OnDestinationReached()
  Grinder.MoveState.ShouldRun = false
end

function Grinder.OnGuiDraw()
	MainWindow.DrawMainWindow()
	Grinder.Navigator:OnGuiDraw()
end

function Grinder.OnRenderD2D()
	Grinder.Navigator:OnRenderD2D()
end

function Grinder.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Grinder.Settings))
end

function Grinder.LoadSettings()
    local json = JSON:new()
    Grinder.Settings = Settings()
    
    table.merge(Grinder.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end

function Grinder.LoadRoutine()	
	if Grinder.Settings.LastRoutine == "" then
		return
	end

    local code = Infinity.FileSystem.ReadFile("Routines/" .. Grinder.Settings.LastRoutine)
    local combatRoutineFunc, combatRoutineError = load(code)

    if combatRoutineFunc == nil then
        print(string.format("Unable to load combat script: func %s err %s", tostring(combatRoutineFunc), tostring(combatRoutineError)))
        return
    end

    Grinder.Routine = combatRoutineFunc()

    if not Grinder.Routine then
        print("Unable to load combat routine !")
        Grinder.Routine = nil
        return
    end
    
    if not Grinder.Routine.onPulse then
        print("Combat script doesn't have :onPulse function !")
        Grinder.Routine = nil
        return
    end 
end