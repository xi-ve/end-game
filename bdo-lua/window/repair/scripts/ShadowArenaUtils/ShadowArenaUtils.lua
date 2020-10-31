ShadowArenaUtils = { }
ShadowArenaUtils.Running = false
ShadowArenaUtils.Settings = Settings()

ShadowArenaUtils.Looting_NextTick = 0
ShadowArenaUtils.Equip_NextTick = 0

function ShadowArenaUtils.Start()
  ShadowArenaUtils.LoadSettings()

  ShadowArenaUtils.Running = true  	    
end

function ShadowArenaUtils.Stop()
  ShadowArenaUtils.Running = false  

  ShadowArenaUtils.SaveSettings()
end

function ShadowArenaUtils.injectModules()
	local code =
	[[
		function isBetterItem(itemWrapper, whereType, slotNo)
  			local ret = false
  			local itemSSW = itemWrapper:getStaticStatus()

  			if nil == itemSSW then
    			return ret
  			end

  			local isServantEquip = itemSSW:isUsableServant()
  			local isEquip = itemSSW:isEquipable()

  			if not isServantEquip and true == isEquip then
    			local currentEndurance = itemWrapper:get():getEndurance()
    			local offencePoint = 0
    			local defencePoint = 0
    			local equipOffencePoint = 0
    			local equipDefencePoint = 0
    			local matchEquip = false
    			local isAccessory = false

    			offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = _inventory_updateSlot_compareSpec(whereType, slotNo, isAccessory)

    			if nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
      				ret = true
    			end
  			end

  			return ret
		end

		g_ShadowArenaUtils_Modules_Loaded = true
	]]

	Infinity.BDO.Lua.Execute(code)
end

function ShadowArenaUtils.getBetterItem()
	if Infinity.BDO.Lua.Execute("return g_ShadowArenaUtils_Modules_Loaded") ~= true then
  		ShadowArenaUtils.injectModules()
  		print("injected Modules!")
  	end

	local code =
	[[
		local inventoryWhereType = CppEnums.ItemWhereType.eInstanceInventory
		local inventorySlot = 0
		local equipSlot = 0
		
  		local inventory = getSelfPlayer():get():getInventory(inventoryWhereType)

  		if nil ~= inventory then
    		
    		local invenMaxSize = inventory:sizeXXX()

    		for ii = 0, invenMaxSize - 1 do

    			local itemWrapper = getInventoryItemByType(inventoryWhereType, ii)

    			if nil ~= itemWrapper and isBetterItem(itemWrapper, inventoryWhereType, ii) then
      				
    				local equipType = itemWrapper:getStaticStatus():getEquipType()

      				inventorySlot = ii
      				equipSlot = (itemWrapper:getStaticStatus()):getEquipSlotNo()

      				if 16 == equipType or 17 == equipType then
      					equipSlot = PaGlobalFunc_GetAccesoryWorseEquipment_Key(itemWrapper)
      				end

      				if equipSlot ~= nil then
      					break
      				end
    			end
  			end
  		end

  		return inventoryWhereType, inventorySlot, equipSlot
	]]

	local inventoryWhereType = 0
	local inventorySlot = 0
	local equipSlot = 0
	
	inventoryWhereType, inventorySlot, equipSlot = Infinity.BDO.Lua.Execute(code)

	if inventorySlot == 0 then
		return nil
	end

	local bItem = {InventoryWhereType = inventoryWhereType, InventorySlot = inventorySlot, EquipSlot = equipSlot}
	return bItem
end

function ShadowArenaUtils.hasFreeInventorySlots()
	local code =
	[[
		local inventory = Inventory_GetCurrentInventory()
		return inventory:getFreeCount()
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function ShadowArenaUtils.processLoot()
	if not ShadowArenaUtils.Settings.AutoLoot.Enabled then
		return
	end

	if ShadowArenaUtils.Looting_NextTick > Infinity.Win32.GetTickCount() then
		return
	end

	ShadowArenaUtils.Looting_NextTick = Infinity.Win32.GetTickCount() + ShadowArenaUtils.Settings.AutoLoot.Delay
	
	if Infinity.BDO.getLocalPlayer():getIsDead() then
		return
	end

	if Infinity.BDO.Lua.Execute("return (ToClient_BattleRoyaleTotalPlayerCount() - 1) <= 2") then
		return
	end

	if not ShadowArenaUtils.hasFreeInventorySlots() then
		return
	end

	for actorKey,actor in pairs(Infinity.BDO.getActorList(EActorType_Loot)) do
		
		if actor:getPosition():getDistance(Infinity.BDO.getLocalPlayer():getPosition()) <= 200 then

			print("Looting Item from Ground!")
			Infinity.BDO.getLocalPlayer():sa_lootItem(actor)
			break
		end
	end
end

function ShadowArenaUtils.processEquip()
	if not ShadowArenaUtils.Settings.AutoEquip.Enabled then
		return
	end

	if ShadowArenaUtils.Equip_NextTick > Infinity.Win32.GetTickCount() then
		return
	end

	ShadowArenaUtils.Equip_NextTick = Infinity.Win32.GetTickCount() + ShadowArenaUtils.Settings.AutoEquip.Delay
	
	if Infinity.BDO.getLocalPlayer():getIsDead() then
		return
	end
	
	local bItem = ShadowArenaUtils.getBetterItem()

	if bItem == nil then
		return
	end
	
	print("Equipping better item from InventorySlot " .. bItem.InventorySlot .. " to EquipSlot " .. bItem.EquipSlot)

	--if ShadowArenaUtils.Settings.AutoEquip.ForceCancel then
		--Actor.setAction("BT_WAIT")
	--end

	EquipItemReq():construct(Infinity.BDO.getLocalPlayer():getActorKey(), bItem.InventoryWhereType, bItem.InventorySlot, bItem.EquipSlot).Packet:send()
end

function ShadowArenaUtils.OnPulse()
  if ShadowArenaUtils.Running == false then
    return
  end

  ShadowArenaUtils.processLoot()
  ShadowArenaUtils.processEquip()
end

function ShadowArenaUtils.OnRenderD2D()
end

function ShadowArenaUtils.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function ShadowArenaUtils.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(ShadowArenaUtils.Settings))
end

function ShadowArenaUtils.LoadSettings()
    local json = JSON:new()
    ShadowArenaUtils.Settings = Settings()
    
    table.merge(ShadowArenaUtils.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end