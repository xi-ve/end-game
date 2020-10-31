Application = {}

Application.FSM = nil

Application.IsStarted = false
Application.LastPulseTick = 0
Application.ActiveNPC = nil
Application.AmityTarget = 0

function Application.Start()
    DebugManager.Trace("Application.Start()")

    MagLib.configure({
        disableInputModule = true,
        disableRegionObserver = true,
        disableActionSequenceManagerModule = true,
        disableNavigationD2DModule = true,
        disableSettingsModule = false,
        disableNavigationSystem = true,
        disableStatKeeping = true,
        disableLogging = false
    })

    Application.Reset()

    Application.IsStarted = true
end

function Application.Stop()
    DebugManager.Trace("Application.Stop()")

    Application.Reset()
end

function Application.Pulse()
    DebugManager.Trace("Application.Pulse()", DEBUG_VERBOSITY_LOUD)

    if not Application.IsStarted or (Application.ActiveNPC == nil) then
        return
    end

    if MagLib.onPulse_Beginning() then
        return
    end

    if (Infinity.Win32.GetTickCount() - Application.LastPulseTick) < PULSE_INTERVAL then
        return
    end

    Application.FSM:Pulse()

    Application.LastPulseTick = Infinity.Win32.GetTickCount()

    MagLib.onPulse_End()
end

function Application.Reset()
    DebugManager.Trace("Application.Reset()")

    Application.FSM = FSM()

    Application.IsStarted = false
    Application.LastPulseTick = 0
    Application.ActiveNPC = nil
    Application.AmityTarget = 500

    Application.FSM:AddState(ExecuteConversationState())
    Application.FSM:AddState(FinishConversationState())
    Application.FSM:AddState(InsertCardsState())
    Application.FSM:AddState(StartDialogState())
    Application.FSM:AddState(StartMentalGameState())
end