AutoLoot = { }
AutoLoot.Running = false

AutoLoot.lastTick = 0
AutoLoot.lootActors = {}
AutoLoot.lootItems = {}

AutoLoot.Settings = Settings()

AutoLoot.Template_AddDeadBodiesAck = AddDeadBodiesAck()
AutoLoot.Template_GetDroppedItemsAck = GetDroppedItemsAck()
AutoLoot.Template_PickupDroppedItemAck = PickupDroppedItemAck()

AutoLoot.TP_Pickup = false

function AutoLoot.Start()
  AutoLoot.Running = true	

  AutoLoot.LoadSettings()
end

function AutoLoot.Stop()
  AutoLoot.Running = false  

  AutoLoot.SaveSettings()
end

function AutoLoot.lootDeadbodies()
	local dist = 0

	for k,lootActor in pairs(AutoLoot.lootActors) do
				
		dist = Infinity.BDO.getLocalPlayer():getPosition():getDistance(lootActor.Position)

		if dist <= 300.0 then
						
			--print("GetDroppedItemListReq")
			GetDroppedItemListReq():construct(lootActor.ActorKey).Packet:send()
			--break
		elseif dist > 300 and dist < 1000 and AutoLoot.TP_Pickup then
			
			Infinity.BDO.getLocalPlayer():getCharacterControler():setPhysPos(lootActor.Position)
			GetDroppedItemListReq():construct(lootActor.ActorKey).Packet:send()			
			break
		elseif dist >= 5000 then								

			table.remove(AutoLoot.lootActors, k)
			break
		end
	end
end

function AutoLoot.OnPulse()
	if not AutoLoot.Running then
		return
	end

	if AutoLoot.lastTick + 100 > Infinity.Win32.GetTickCount() then
		return
	end

	AutoLoot.lastTick = Infinity.Win32.GetTickCount()

	if LocalPlayer.isDead() then
        return
    end

	if table.length(AutoLoot.lootActors) > 0 then
		AutoLoot.lootDeadbodies()
	end	
end

function AutoLoot.onNewDeadBodys(packet)	
	--print("New DeadBody")
	packet:parse()

	for k,v in pairs(packet.Parsed.Bodies) do
		
		if v.HasLoot then
            --print("HasLoot ActorKey: " .. v.ActorKey)
      		table.insert(AutoLoot.lootActors, {ActorKey = v.ActorKey, Position = v.Position, Count = 0})
    	end
	end	
end

function AutoLoot.onDroppedItems(packet)
	packet:parse()

	local totalCount = packet.Parsed.ListCount

	for i = 1, packet.Parsed.ListCount do

		--print("PickDropped -- ActorKey: " .. tostring(packet.Parsed.ActorKey) .. " Index: " .. tostring(packet.Parsed.Items[i].Index) .. " Count: " .. tostring(packet.Parsed.Items[i].Count))
		
		local itemId = packet.Parsed.Items[i].ItemEnchantKey
		
		if not AutoLoot.shouldNotLoot(itemId) then
			PickupDroppedItemReq():construct(LocalPlayer.getActorKey(), packet.Parsed.ActorKey, packet.Parsed.Items[i].Index, packet.Parsed.Items[i].Count).Packet:send()
		else
			totalCount = totalCount - 1
		end			

	end

	if totalCount > 0 then

		AutoLoot.addCountByActorKey(packet.Parsed.ActorKey, totalCount)
	else

		AutoLoot.removeActorKeyFromQueue(packet.Parsed.ActorKey)
	end	
end

function AutoLoot.onPickupDroppedItems(packet)
	packet:parse()	

	local aK = AutoLoot.getKeyByActorKey(packet.Parsed.DeadBody_ActorKey)

	if aK ~= nil then

		AutoLoot.lootActors[aK].Count = AutoLoot.lootActors[aK].Count - 1

		if AutoLoot.lootActors[aK].Count <= 0 then

			table.remove(AutoLoot.lootActors, aK)
		end
	end
end

function AutoLoot.onRemoveActor(packet)
	packet:parse()	

	for k,lootActor in pairs(AutoLoot.lootActors) do
		if lootActor.ActorKey == packet.Parsed.ActorKey then
			table.remove(AutoLoot.lootActors, k)
			break
		end
	end
end

function AutoLoot.OnPacketReceive(byteBuffer)		
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()
	
	local name = OpCodes.getAckName(opCode)
	
	if name == "AddDeadBodys" then
		AutoLoot.onNewDeadBodys(AddDeadBodiesAck(byteBuffer))
	elseif name == "GetDroppedItems" then
		AutoLoot.onDroppedItems(GetDroppedItemsAck(byteBuffer))
	elseif name == "PickupDroppedItem" then
		AutoLoot.onPickupDroppedItems(PickupDroppedItemAck(byteBuffer))
	elseif name == "RemoveActor" then
		AutoLoot.onRemoveActor(RemoveActorAck(byteBuffer))
	end
end

function AutoLoot.removeActorKeyFromQueue(actorKey)
	for k,v in pairs(AutoLoot.lootActors) do
		
		if v.ActorKey == actorKey then

			table.remove(AutoLoot.lootActors, k)
			break
		end
	end
end

function AutoLoot.addCountByActorKey(actorKey, count)
	for k,v in pairs(AutoLoot.lootActors) do
		
		if v.ActorKey == actorKey then

			v.Count = count
			break
		end
	end
end

function AutoLoot.getKeyByActorKey(actorKey)
	for k,v in pairs(AutoLoot.lootActors) do
		
		if v.ActorKey == actorKey then

			return k
		end
	end

	return nil
end

function AutoLoot.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function AutoLoot.drawLootActors()
	for k,v in pairs(AutoLoot.lootActors) do		
		RenderHelper.DrawWorldCircle(v.Position, 40, "80FFFF00", 1, true)		
	end
end

function AutoLoot.OnRenderD2D()
	if AutoLoot.Settings.DrawLootActors then
		AutoLoot.drawLootActors()
	end
end

function AutoLoot.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(AutoLoot.Settings))
end

function AutoLoot.LoadSettings()
    local json = JSON:new()
    AutoLoot.Settings = Settings()
    
    table.merge(AutoLoot.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end

function AutoLoot.shouldNotLoot(itemId)
	for k,v in pairs(AutoLoot.Settings.BlackList) do
		
		if v.ItemId == itemId then

			return true
		end
	end

	return false
end
