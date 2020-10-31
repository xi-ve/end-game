Radar = { }
Radar.Running = false
Radar.Settings = Settings()

Radar.lastTick = 0

Radar.worldMapIsShow = false

function Radar.Start()	
	Radar.worldMapIsShow = Infinity.BDO.Lua.Execute("return ToClient_WorldMapIsShow()")

  	Radar.Running = true	

  	Radar.LoadSettings()    
end

function Radar.Stop()
  Radar.Running = false  

  Radar.SaveSettings()
end

function Radar.OnPulse()
  if Radar.Running == false then
    return
  end

  if Radar.lastTick + 200 > Infinity.Win32.GetTickCount() then
  	return
  end

  Radar.lastTick = Infinity.Win32.GetTickCount()
  
  MainWindow.loadNearbyActors()
end

function Radar.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function Radar.getTableByActorType(actorType)

	if actorType == -1 then
		return Infinity.BDO.getActorList(EActorType_All)
	elseif actorType == 0 then
		return Infinity.BDO.getActorList(EActorType_Player)
	elseif actorType == 1 then
		return Infinity.BDO.getActorList(EActorType_Monster)
	elseif actorType == 2 then
		return Infinity.BDO.getActorList(EActorType_Npc)
	elseif actorType == 3 then
		return Infinity.BDO.getActorList(EActorType_Vehicle)
	elseif actorType == 4 then
		return Infinity.BDO.getActorList(EActorType_Gate)
	elseif actorType == 5 then
		return Infinity.BDO.getActorList(EActorType_Alterego)
	elseif actorType == 6 then
		return Infinity.BDO.getActorList(EActorType_Collect)
	elseif actorType == 7 then
		return Infinity.BDO.getActorList(EActorType_Household)
	elseif actorType == 8 then
		return Infinity.BDO.getActorList(EActorType_Installation)
	elseif actorType == 9 then
		return Infinity.BDO.getActorList(EActorType_Deadbody)
	end

	return {}
end

function Radar.shouldRenderById(filterIds, actorId)
	for k,v in pairs(filterIds) do
		if v == actorId then
			return true
		end
	end

	return false
end

function Radar.renderActors()
	local shouldRender = true

	local wmFactor = 1.0

	if Radar.worldMapIsShow then
		wmFactor = 8.0
	end

	for kF,filter in pairs(Radar.Settings.Filters) do

		if filter.Enabled then

			for kA,actor in pairs(Radar.getTableByActorType(filter.ActorType)) do

				shouldRender = true

				if table.length(filter.Ids) ~= 0 and not Radar.shouldRenderById(filter.Ids, actor:getActorId()) then
					shouldRender = false
				end

				if actor:getIsDead() then
					shouldRender = false
				end

				if shouldRender then

					if filter.DrawStyle == (MainWindow.DrawStyles).Circle then
						RenderHelper.DrawWorldCircle(actor:getPosition(), filter.Size * wmFactor, filter.Color, filter.Thickness, filter.Fill)						
					elseif filter.DrawStyle == (MainWindow.DrawStyles).Square then
						RenderHelper.DrawWorldSquare(actor:getPosition(), filter.Size * wmFactor, filter.Color, filter.Thickness, filter.Fill)
					elseif filter.DrawStyle == (MainWindow.DrawStyles).HitBox then
						RenderHelper.DrawHitBox(actor, filter.Color, filter.Thickness)
					end
				end
			end				
		end
	end
end

function Radar.OnRenderD2D()
	Radar.renderActors()
end

function Radar.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Radar.Settings))
end

function Radar.LoadSettings()
    local json = JSON:new()
    Radar.Settings = Settings()
    
    table.merge(Radar.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end

function Radar.OnWorldMapOpen(args)	
	Radar.worldMapIsShow = true
	--print(tostring(Radar.worldMapIsShow))
end

function Radar.OnExitWorldMap(args)	
	Radar.worldMapIsShow = false
	--print(tostring(Radar.worldMapIsShow))
end