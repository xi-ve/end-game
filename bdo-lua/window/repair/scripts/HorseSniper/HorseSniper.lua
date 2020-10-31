HorseSniper = { }
HorseSniper.Running = false
HorseSniper.Settings = Settings()

HorseSniper.Packet_GetAuctionGoods = {}
HorseSniper.Packet_GetAuctionGoods.init_PacketStruct = true

HorseSniper.Packet_GetAuctionGoods.size = -1
HorseSniper.Packet_GetAuctionGoods.opCode = -1
HorseSniper.Packet_GetAuctionGoods.o_auctionRegisterType = -1
HorseSniper.Packet_GetAuctionGoods.o_skillFilter = -1
HorseSniper.Packet_GetAuctionGoods.o_tierFilter = -1
HorseSniper.Packet_GetAuctionGoods.o_pageIndex = -1
HorseSniper.Packet_GetAuctionGoods.o_npcActorKey = -1
HorseSniper.Packet_GetAuctionGoods.o_genderFilter = -1

HorseSniper.Filters = {}
HorseSniper.CurrentFilter_Index = 1

HorseSniper.CurrentPageData_Loaded = false

function HorseSniper.Start()
  HorseSniper.LoadSettings()      
	    
  --AuctionRegisterType 4
  --SkillFilter 5
  --TierFilter 7
  --PageIndex 3
  --GenderFilter 2

  print("Packet structure is not initiated yet!\n-Open up Horse Market at the NPC\n-Set Skill Filter to Start Accel\n-Set Tier Filter to 7\n-Set Page to 4\n-Set Gender Filter to All\n-Press Refresh until Struct Init is completed!")
end

function HorseSniper.Stop()
    HorseSniper.SaveSettings() 
end

function HorseSniper.StartBot()
  if not HorseSniper.Packet_GetAuctionGoods.init_PacketStruct then
    return
  end

  HorseSniper.initFilters()

  HorseSniper.requestDataCurrentFilter()

  HorseSniper.Running = true      
end

function HorseSniper.StopBot()
  HorseSniper.Running = false  
end

function HorseSniper.initFilters()
  HorseSniper.Filters = {}
  HorseSniper.CurrentFilter_Index = 1

  for k,filter in pairs(HorseSniper.Settings.Filters) do
    
    local skills = {}

    for kS,skill in pairs(filter.Skills) do
      
      table.insert(skills, skill.Index)
    end

    table.insert(HorseSniper.Filters, {TierIndex = filter.TierIndex, GenderIndex = filter.GenderIndex, Skills = skills, Courser = filter.Courser, CurrentPageIndex = 0})
  end
end

function HorseSniper.setNextFilter()
  HorseSniper.Filters[HorseSniper.CurrentFilter_Index].CurrentPageIndex = 0

  if HorseSniper.CurrentFilter_Index + 1 > table.length(HorseSniper.Filters) then
    HorseSniper.CurrentFilter_Index = 1
  else
    HorseSniper.CurrentFilter_Index = HorseSniper.CurrentFilter_Index + 1
  end
end

function HorseSniper.getCurrentFilter()
  return HorseSniper.Filters[HorseSniper.CurrentFilter_Index]
end

function HorseSniper.increaseCurrentFilterPage()
  HorseSniper.Filters[HorseSniper.CurrentFilter_Index].CurrentPageIndex = HorseSniper.Filters[HorseSniper.CurrentFilter_Index].CurrentPageIndex + 1

  local code = 
  [[
    RequestAuctionNextPage(0, PaGlobal_ServantMarket_All._isFromNpc)   
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function HorseSniper.requestDataCurrentFilter()

  --local packet = GetAuctionGoodsReq()

  --packet:construct(Statics.Enums.EAuctionRegisterType.ServantMarket, 0, HorseSniper.getCurrentFilter().TierIndex, HorseSniper.getCurrentFilter().CurrentPageIndex, Utils.findNpc_StableShop():getActorKey(), HorseSniper.getCurrentFilter().GenderIndex).Packet:send()

  local code = 
  [[
    SetAuctionServantTierFilter(]] .. HorseSniper.getCurrentFilter().TierIndex .. [[, true)
    setAuctionServantSexFilter(]] .. HorseSniper.getCurrentFilter().GenderIndex .. [[, true)
    setAuctionServantSkillFilter(0, true)    
  ]]

  Infinity.BDO.Lua.Execute(code)
end

function HorseSniper.check_hasSkills(horseSkills, filterSkills)
  local hasAllSkills = true

  if filterSkills[1] == 0 then
    return hasAllSkills
  end

  for k,filterSkillIndex in pairs(filterSkills) do
    
    if table.find(horseSkills, filterSkillIndex) == nil then

      hasAllSkills = false
      break
    end
  end

  return hasAllSkills
end

function HorseSniper.check_hasTier(horseTier, filterTier)
  if filterTier == 0 then
    return true
  end

  if horseTier == filterTier then
    return true
  end

  return false
end

function HorseSniper.check_hasMoney(horsePrice)

  local warehouseMoney = GoodsAuction.getHorseMarketWarehouseMoney()

  if warehouseMoney == nil then
    return false
  end

  if horsePrice > warehouseMoney then
    return false
  end

  return true
end

function HorseSniper.check_hasFreeStableSlots()

  local freeSlots = GoodsAuction.getHorseMarketgetStableFreeSlots()

  if freeSlots == nil then
    return false
  end

  if freeSlots <= 0 then
    return false
  end

  return true
end

function HorseSniper.buyHorseByIndex(index)
  print("trying to buy on slot " .. index)
  --HorseSniper.StopBot()
  GoodsAuction.buyServantInHorseMarketBySlotIndex(index)
end

function HorseSniper.scanAvailableHorses(maxCount)

  for i = 0, maxCount - 1 do

    local horseData = GoodsAuction.getHorseMarketServantDataByIndex(i)
    local horseSkills = GoodsAuction.getHorseMarketServantSkillDataByIndex(i)

    local skip = false

    if HorseSniper.getCurrentFilter().Courser and not horseData.IsStallion then
      skip = true
    end

    if not skip and HorseSniper.check_hasTier(horseData.Tier, HorseSniper.getCurrentFilter().TierIndex) and HorseSniper.check_hasSkills(horseSkills, HorseSniper.getCurrentFilter().Skills) then

      if HorseSniper.check_hasMoney(horseData.Price) and HorseSniper.check_hasFreeStableSlots() then

        HorseSniper.buyHorseByIndex(i)
        return true
      else
        print("Not enough money in warehouse or not enough free slots in stable!")
      end
    end
  end

  return false
end

--[[function HorseSniper.processFilters()  
  local availableHorses = GoodsAuction.getHorseMarketServantListCount()

  if availableHorses <= 0 then

    HorseSniper.setNextFilter()
    HorseSniper.requestDataCurrentFilter()
    return
  end

  HorseSniper.increaseCurrentFilterPage()
  HorseSniper.requestDataCurrentFilter()

  if not HorseSniper.scanAvailableHorses(availableHorses) then
    print("no horse available for purchase")
    HorseSniper.increaseCurrentFilterPage()
    HorseSniper.requestDataCurrentFilter()
  else
    print("horse available for purchase")
    HorseSniper.requestDataCurrentFilter()
  end
end]]--

function HorseSniper.OnPulse()
  if not HorseSniper.Running then
    return
  end

  --if not HorseSniper.CurrentPageData_Loaded then
    --return
  --end

  --HorseSniper.CurrentPageData_Loaded = false

  --HorseSniper.processFilters()
end

function HorseSniper.tryInitPacketStruct(byteBuffer)
	print("Trying to automatically generate packet structure!")

	local npc_HorseMarket = Utils.findNpc_StableShop()

	if npc_HorseMarket == nil then
		print("Could not find any Stable NPC! Make sure you opened the Horse Market via NPC and not via WorldMap!")
		return
	end

  HorseSniper.Packet_GetAuctionGoods.o_auctionRegisterType = -1
  HorseSniper.Packet_GetAuctionGoods.o_skillFilter = -1
  HorseSniper.Packet_GetAuctionGoods.o_tierFilter = -1
  HorseSniper.Packet_GetAuctionGoods.o_pageIndex = -1
  HorseSniper.Packet_GetAuctionGoods.o_npcActorKey = -1
  HorseSniper.Packet_GetAuctionGoods.o_genderFilter = -1

	HorseSniper.Packet_GetAuctionGoods.size = byteBuffer:_getShort(0)
  HorseSniper.Packet_GetAuctionGoods.opCode = byteBuffer:_getShort(3)
	
	local blackList_scannedBytes = {0, 1, 2, 3, 4}

	-- trying to get o_npcActorKey
	for i_nak = 0, HorseSniper.Packet_GetAuctionGoods.size - 1 do

		if table.find(blackList_scannedBytes, i_nak) == nil then

    		local value = byteBuffer:_getInt(i_nak)

    		if value == npc_HorseMarket:getActorKey() then

    			HorseSniper.Packet_GetAuctionGoods.o_npcActorKey = i_nak

    			table.insert(blackList_scannedBytes, i_nak)
    			table.insert(blackList_scannedBytes, i_nak + 1)
    			table.insert(blackList_scannedBytes, i_nak + 2)
    			table.insert(blackList_scannedBytes, i_nak + 3)

    			print("Offset NpcActorKey found! " .. i_nak)
    			break
    		end
    	end
  	end

  	-- trying to get o_pageIndex
	for i_pi = 0, HorseSniper.Packet_GetAuctionGoods.size - 1 do

		if table.find(blackList_scannedBytes, i_pi) == nil then

    		local value = byteBuffer:_getInt(i_pi)

    		if value == 3 then

    			HorseSniper.Packet_GetAuctionGoods.o_pageIndex = i_pi

    			table.insert(blackList_scannedBytes, i_pi)
    			table.insert(blackList_scannedBytes, i_pi + 1)
    			table.insert(blackList_scannedBytes, i_pi + 2)
    			table.insert(blackList_scannedBytes, i_pi + 3)

    			print("Offset PageIndex found! " .. i_pi)
    			break
    		end
    	end
  	end

  	-- trying to get other filter offsets
	for i_fo = 0, HorseSniper.Packet_GetAuctionGoods.size - 1 do

		if table.find(blackList_scannedBytes, i_fo) == nil then
			
    		local value = byteBuffer:_get(i_fo)

    		if value == 4 then

    			HorseSniper.Packet_GetAuctionGoods.o_auctionRegisterType = i_fo

    			table.insert(blackList_scannedBytes, i_fo)

    			print("Offset AuctionRegisterType found! " .. i_fo)
    		elseif value == 5 then

    			HorseSniper.Packet_GetAuctionGoods.o_skillFilter = i_fo

    			table.insert(blackList_scannedBytes, i_fo)

    			print("Offset SkillFilter found! " .. i_fo)
    		elseif value == 7 then

    			HorseSniper.Packet_GetAuctionGoods.o_tierFilter = i_fo

    			table.insert(blackList_scannedBytes, i_fo)

    			print("Offset TierFilter found! " .. i_fo)
    		elseif value == 2 then

    			HorseSniper.Packet_GetAuctionGoods.o_genderFilter = i_fo

    			table.insert(blackList_scannedBytes, i_fo)

    			print("Offset GenderFilter found! " .. i_fo)
    		end
    	end
  	end
  	
	if HorseSniper.Packet_GetAuctionGoods.o_auctionRegisterType ~= -1 and 
		HorseSniper.Packet_GetAuctionGoods.o_skillFilter ~= -1 and 
		HorseSniper.Packet_GetAuctionGoods.o_tierFilter ~= -1 and 
		HorseSniper.Packet_GetAuctionGoods.o_pageIndex ~= -1 and 
		HorseSniper.Packet_GetAuctionGoods.o_npcActorKey ~= -1 and 
		HorseSniper.Packet_GetAuctionGoods.o_genderFilter ~= -1 then

		HorseSniper.Packet_GetAuctionGoods.init_PacketStruct = true
		print("Packet Struct Init Completed!")
	else

		print("Packet Struct Init Failed!")
	end
end

function HorseSniper.OnPacketSend(byteBuffer, name)	
	local length = byteBuffer:getShort()
  	byteBuffer:skip(1)
  	local opCode = byteBuffer:getShort()

  	if not HorseSniper.Packet_GetAuctionGoods.init_PacketStruct then

    	if length >= 20 and length <= 30 then
          print("OpCode: " .. opCode)
      		HorseSniper.tryInitPacketStruct(byteBuffer)
    	end
  	end
end

function HorseSniper.onUpdateSlotData(args)
  if not HorseSniper.Running then
    return
  end
  
  --print("HorseSniper.onUpdateSlotData")

  local availableHorses = GoodsAuction.getHorseMarketServantListCount()

  if availableHorses <= 0 then

    HorseSniper.setNextFilter()
    HorseSniper.requestDataCurrentFilter()
    return
  end
  
  if not HorseSniper.scanAvailableHorses(availableHorses) then
    print("no horse available for purchase")
    HorseSniper.increaseCurrentFilterPage()
    --HorseSniper.requestDataCurrentFilter()
  else
    print("horse available for purchase")
    HorseSniper.requestDataCurrentFilter()
  end

  --HorseSniper.CurrentPageData_Loaded = true
end

function HorseSniper.OnGuiDraw()
	MainWindow.DrawMainWindow() 	
end

function HorseSniper.SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(HorseSniper.Settings))
end

function HorseSniper.LoadSettings()
    local json = JSON:new()
    HorseSniper.Settings = Settings()
    
    table.merge(HorseSniper.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))    
end