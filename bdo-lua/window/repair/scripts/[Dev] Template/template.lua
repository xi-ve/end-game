Template = { }
Template.Running = false

Template.MeshScanDistance = 1000
Template.MeshScanSegments = 500

local Mesh_ColliderPoints = {}

function Template.Start()
  Template.Running = true
	    
end

function Template.Stop()
  Template.Running = false  
end

function Template.TestRayCast()
	local fNPC = Infinity.BDO.getActorByActorKey(352943104)
	local lPlayerPosTemp = Infinity.BDO.getLocalPlayer():getPosition()
	local lPlayerPos = Vector3(lPlayerPosTemp.X, lPlayerPosTemp.Y + 100, lPlayerPosTemp.Z)

	if fNPC == nil then
		return
	end
	
	local fNPCTempPos = fNPC:getPosition()
	local fNPCPos = Vector3(fNPCTempPos.X, fNPCTempPos.Y + 100, fNPCTempPos.Z)

	RenderHelper.DrawWorldCircle(fNPCPos, 20, "FFFF0000", 2, false)

  	local rVec = lPlayerPos:getDirectionVector(fNPCPos)
  	local rCast = Infinity.BDO.getSceneManager():CastRay(lPlayerPos, rVec, lPlayerPos:getDistance(fNPCPos), 1, 32)

  	if rCast == 0 then

  		RenderHelper.DrawWorldLine(lPlayerPos, fNPCPos, "FF00FF00", 2)
  	else

  		RenderHelper.DrawWorldLine(lPlayerPos, fNPCPos, "FFFF0000", 2)
  	end
end

function Template.CollisionTest()
	local lPlayerPosTemp = Infinity.BDO.getLocalPlayer():getPosition()
	local lPlayerPos = Vector3(lPlayerPosTemp.X, lPlayerPosTemp.Y + 100, lPlayerPosTemp.Z) 

	local radius = 500
	local segments = 500
	local segmentSize = 360 / segments;

	for angle = 0, 360, segmentSize do
		local x = lPlayerPos.X + (radius * math.cos(angle / (180 / math.pi)))
		local z = lPlayerPos.Z + (radius * math.sin(angle / (180 / math.pi)))

		local nPos = Vector3(x, lPlayerPos.Y, z)
			
		local rVec = lPlayerPos:getDirectionVector(nPos)
  		local rCast = Infinity.BDO.getSceneManager():CastRay(lPlayerPos, rVec, radius, 1, 32)

  		if rCast == 0 then  			
  			RenderHelper.DrawWorldSquare(nPos, 3, "FF00FF00", 1, true)
  		else
  			x = lPlayerPos.X + (rCast * math.cos(angle / (180 / math.pi)))
			z = lPlayerPos.Z + (rCast * math.sin(angle / (180 / math.pi)))

			nPos = Vector3(x, lPlayerPos.Y, z)

  			RenderHelper.DrawWorldSquare(nPos, 3, "FFFF0000", 1, true)
  		end

		angle = angle + segmentSize
	end				
end

function Template.ScanMesh()
	local cPoints = {}

	local lPlayerPos = Infinity.BDO.getLocalPlayer():getPosition()

	local radius = Template.MeshScanDistance
	local segments = Template.MeshScanSegments
	local segmentSize = 360 / segments;

	local startHeight = 50
	local stopHeight = 1000
	local stepHeight = 20

	local x = 0
	local z = 0

	for i = startHeight, stopHeight, stepHeight do

		local lPlayerPosTemp = Vector3(lPlayerPos.X, lPlayerPos.Y + i, lPlayerPos.Z) 

		for angle = 0, 360, segmentSize do

			x = lPlayerPosTemp.X + (radius * math.cos(angle / (180 / math.pi)))
			z = lPlayerPosTemp.Z + (radius * math.sin(angle / (180 / math.pi)))

			local nPos = Vector3(x, lPlayerPosTemp.Y, z)
			
			local rVec = lPlayerPosTemp:getDirectionVector(nPos)
  			local rCast = Infinity.BDO.getSceneManager():CastRay(lPlayerPosTemp, rVec, radius, 1, 32)

  			if rCast == 0 then  			
  				
  			else
  				x = lPlayerPos.X + (rCast * math.cos(angle / (180 / math.pi)))
				z = lPlayerPos.Z + (rCast * math.sin(angle / (180 / math.pi)))

				nPos = Vector3(x, lPlayerPosTemp.Y, z)

  				table.insert(cPoints, nPos)
  			end

			angle = angle + segmentSize
		end			
	end

	Mesh_ColliderPoints = cPoints
	print(table.length(Mesh_ColliderPoints) .. " Collider Points generated!")
end

function Template.ClearMesh()
	Mesh_ColliderPoints = {}
end

local PI = 3.14159265358979323846

function Template.faceTarget(target)
	if target == nil then
		print("No Target!")
		return
	end

	local rotFaceTarget = target:getPosition():getRotationToFace(Infinity.BDO.getLocalPlayer():getPosition())
	local yawFaceTarget = rotFaceTarget - (2*PI)
	
	if Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getRotation() ~= rotFaceTarget then
		Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setRotation(rotFaceTarget)		
	end

	if Infinity.BDO.getCameraManager():getYaw() ~= yawFaceTarget then
		Infinity.BDO.getCameraManager():setYaw(yawFaceTarget)
	end
end

function Template.getTarget()
	local lastDistance = 1000000
	local lastTarget = nil

	--print("ListCount: " .. Infinity.BDO.getActorListCount(ActorType_Monster))

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_Monster)) do
		local cDist = v:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition())

		if cDist < lastDistance then
			lastDistance = cDist
			lastTarget = v
		end
	end

	return lastTarget
end

local lastFaceTo = 0
local cachedPos = Infinity.BDO.getLocalPlayer():getPosition()

function Template.tpTest()
	local curPos = Infinity.BDO.getLocalPlayer():getPosition()

	if Infinity.BDO.Input.IsKeyPressed(KeyCode_F5) then
		
		Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(Vector3(cachedPos.X + 5000, cachedPos.Y + 1000, curPos.Z))
	end
end

function Template.lockClosestMonster()
	local t = Infinity.BDO.getActorList(EActorType_Monster)
	local tt = {}

    for k,v in pairs(t) do

    	if not v:getIsDead() then
        	table.insert(tt, v)
    	end
    end

    table.sort(tt, function(a, b) return a:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) < b:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) end)

    if table.length(tt) > 0 then

    	local closestMonster = tt[1]

    	Infinity.BDO.Selection.setNewAttackTarget(closestMonster:getActorKey())
    else

    	Infinity.BDO.Selection.resetAttackTarget()
    end
end

nextJumpTick = Infinity.Win32.GetTickCount()



function Template.OnPulse()
  if Template.Running == false then
    return
  end     	

  	--Infinity.BDO.getUIManager():setIsCursorActive(false)
  	--Infinity.BDO.getCameraManager():setYaw(0.5)
  	--Infinity.BDO.getCameraManager():setPitch(0.5)

  	--Infinity.BDO.Input.setIsKeyInputFlagOverride(true)
    --Infinity.BDO.Input.setKeyInputFlagValue(0x40000)
end

function Template.renderTestPoints()

	local points = Infinity.BDO.getCameraManager():getTestPoints()

	--[[for k,v in pairs(Infinity.BDO.getCameraManager():getTestPoints()) do
		
		RenderHelper.DrawWorldCircle(v, 2, "FFFF0000", 2, true)
	end]]--

	--[[
		local points = Infinity.BDO.getCameraManager():getTestPoints()

		return points[3]:getDistance(points[1])
	]]--

	RenderHelper.DrawWorldCircle(points[3], 2, "FFFF0000", 2, true)
end

function Template.renderScannedMesh()

	for k,v in pairs(Mesh_ColliderPoints) do

		RenderHelper.DrawWorldSquare(v, 3, "FFFF0000", 1, true)
	end
end

function Template.renderCharacterSceneTestPoints()
	local points = Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():getTestPoints()

	for k,v in pairs(points) do

		RenderHelper.DrawWorldSquare(v, 3, "FFFF0000", 1, true)
	end
end

function Template.OnRenderD2D()
	--Template.CollisionTest()
	--Template.TestRayCast()
	--Template.renderTestPoints()
	Template.renderScannedMesh()

	--Template.renderCharacterSceneTestPoints()
end

function Template.OnLuaLoadComplete()
	print("BDO Lua Load Complete!")
end

function Template.OnSelfActionChanged(action)
    
end

function Template.OnBDOEventFired(event)
	if 	event ~= "FromClient_InterAction_UpdatePerFrame" and
	 	event ~= "FromClient_LuaTimer_UpdatePerFrame" and 
	 	event ~= "EventGlobalKeyBinder" and 
	 	event ~= "FromClient_responseItemMarkgetInfo" then
	 	
		print("OnBDOEventFired --> " .. event)
	end
end

function Template.OnPacketReceive(byteBuffer)	
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()
	
	if OpCodes.getAckName(opCode) == "FishingTime" then
		
		
	end
end

function Template.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function Template.OnTCPSocketReceive(socketConnectionName, buffer)
	print("OnTCPSocketReceive SocketConnection: " .. socketConnectionName .. " RecvBytes: " .. tostring(buffer.size))
end

function Template.OnAddDamage(attackeeActorKey, attackerActorKey, value, effectType, isNotSelf)
	print("[[--OnAddDamage--]]")
	print("AttackeeActorKey: " .. attackeeActorKey)
	print("AttackerActorKey: " .. attackerActorKey)
	print("Value: " .. value)
	print("EffectType: " .. effectType)
	print("IsNotSelf: " .. tostring(isNotSelf))
	print("-------------------")
end

function Template.OnServantInventory_updateSlotData(args)	
	print("OnServantInventory_updateSlotData (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnDamageOutputFunction_OnDamage(args)	
	print("OnDamageOutputFunction_OnDamage (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnActorCreate(args)	
	print("OnActorCreate (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnActorDelete(args)	
	print("OnActorDelete (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnInventoryAddItem(args)	
	print("OnInventoryAddItem (" .. table.combinestring(args, ",") .. ")")
end


function Template.OnInventoryUpdateSlotDatabyAddItem(args)	
	print("OnInventoryUpdateSlotDatabyAddItem (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnInventoryUpdateSlotData(args)	
	print("OnInventoryUpdateSlotData (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnHorseMarketUpdateSlotData(args)	
	print("OnHorseMarketUpdateSlotData (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnPanelLootingUpdate(args)	
	print("OnPanelLootingUpdate (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnWarehouseOpenByInstallation(args)	
	print("OnWarehouseOpenByInstallation (" .. table.combinestring(args, ",") .. ")")
end

function Template.OnItemmarket_ListUpdate(args)
	print("OnItemmarket_ListUpdate (" .. table.combinestring(args, ",") .. ")")
end