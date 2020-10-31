GatheringHelper = { }
GatheringHelper.Running = false
GatheringHelper.Settings = Settings()
GatheringHelper.Navigator = Navigator()

GatheringHelper.lastTick = 0

GatheringHelper.currentTarget = nil

GatheringHelper.FSM = FSM()

GatheringHelper.MoveState = nil

function GatheringHelper.OnAutoLoginAutoLoad()
	GatheringHelper.StartBot()
end

function GatheringHelper.Start()
  GatheringHelper.LoadSettings()
end

function GatheringHelper.StartBot()
	GatheringHelper.Running = true
	    
  	Infinity.BDO.Selection.reset()

  	GatheringHelper.FSM = FSM()

  	if GatheringHelper.Settings.UseAutoNav then  		

  		if GatheringHelper.Navigator.CurrentProfile.Name == "" then
  			print("No Last Loaded Profile found in Navigator!")
  		else
  			GatheringHelper.MoveState = MoveState(GatheringHelper.Navigator.CurrentProfile, GatheringHelper.Settings.UseTpNav)	

  			GatheringHelper.MoveState:SetCallback_DestinationReached(GatheringHelper.OnDestinationReached)

  			GatheringHelper.FSM:AddState(GatheringHelper.MoveState)
		end
	end

	GatheringHelper.FSM:AddState(CheckToolState())
	GatheringHelper.FSM:AddState(DeleteToolState())
end

function GatheringHelper.StopBot()
  GatheringHelper.Running = false

  Infinity.BDO.Selection.reset()  
end

function GatheringHelper.Stop()
  GatheringHelper.SaveSettings()
end

function GatheringHelper.shouldGather(actorId)
	if table.length(GatheringHelper.Settings.Actors) == 0 then
		return true
	end

	for k,v in pairs(GatheringHelper.Settings.Actors) do
            	
       	if v.ActorId == actorId then

       		return true
       	end
    end

    return false
end

function GatheringHelper.tryCollect()
	if UI.getShow("Panel_Window_Looting_All") then

		Infinity.BDO.Lua.Execute("HandleEventLUp_Looting_All_LootAll(true)")
		Actor.setAction("WAIT")
		return
	end

	if string.find(string.lower(Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()), "wait") == nil then
		Infinity.BDO.Selection.reset()
		return
	end

	if Infinity.BDO.Selection.isOverride() and GatheringHelper.currentTarget ~= nil and Interaction.hasInteractable() then
		Interaction.interact(8)
		return
	end
		
	GatheringHelper.currentTarget = nil

	if GatheringHelper.Settings.UseAutoNav then
		if GatheringHelper.MoveState ~= nil and GatheringHelper.MoveState.ShouldRun then
			return
		end
	end

	local scanDistance = 1000

	if GatheringHelper.Settings.StopRangeCollectOnNearbyPlayers and Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby() then
		scanDistance = 200
	end

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_All)) do

		if v:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) <= scanDistance and Interaction.canCollect(v:getActorKey()) and GatheringHelper.shouldGather(v:getActorId()) then

			GatheringHelper.currentTarget = v
			Infinity.BDO.Selection.setTarget(v:getActorKey())			
		end
	end

	if GatheringHelper.Settings.UseAutoNav then

		if GatheringHelper.MoveState ~= nil then

			if GatheringHelper.currentTarget == nil then

				if GatheringHelper.Settings.StopNavigatorOnNearbyPlayers and Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby() then
  					return
  				end

				GatheringHelper.MoveState.ShouldRun = true
			end
		end
	end	
end

function GatheringHelper.OnPulse()
	GatheringHelper.Navigator:OnPulse()

  if GatheringHelper.Running == false then
    return
  end
  
  if GatheringHelper.lastTick + 200 > Infinity.Win32.GetTickCount() then
  	return
  end

  GatheringHelper.lastTick = Infinity.Win32.GetTickCount()

  if GatheringHelper.Settings.UseAutoNav and GatheringHelper.Settings.UseTpNav then
    if Infinity.BDO.getLocalPlayer():getIsOtherPlayersNearby() then
      GatheringHelper.MoveState.UseTp = false
    else
      GatheringHelper.MoveState.UseTp = true
    end
  end

  GatheringHelper.FSM:Pulse()	

  if LocalPlayer.getWp() <= 0 then
  	return
  end

  GatheringHelper.tryCollect()
end

function GatheringHelper.OnDestinationReached()
	GatheringHelper.MoveState.ShouldRun = false
end

function GatheringHelper.OnGuiDraw()
	MainWindow.DrawMainWindow()
	GatheringHelper.Navigator:OnGuiDraw()
end

function GatheringHelper.OnRenderD2D()

	if GatheringHelper.Settings.ShowRangeCircle then

		RenderHelper.DrawWorldCircle(Infinity.BDO.getLocalPlayer():getPosition(), 1000, "50FF5000", 4, false)
	end

	GatheringHelper.Navigator:OnRenderD2D()
end

function GatheringHelper.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(GatheringHelper.Settings))
end

function GatheringHelper.LoadSettings()
    local json = JSON:new()
    GatheringHelper.Settings = Settings()
    
    table.merge(GatheringHelper.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end