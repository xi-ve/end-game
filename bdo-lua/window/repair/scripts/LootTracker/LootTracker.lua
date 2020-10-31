LootTracker = { }
LootTracker.Running = false

LootTracker.CurrentSession = LootSession():initNew()
LootTracker.CurrentSession_NextUpdate = 0
LootTracker.CurrentSession_UpdateInterval = 500
LootTracker.CurrentSession_SaveInterval = 60000
LootTracker.CurrentSession_NextSave = Infinity.Win32.GetTickCount() + LootTracker.CurrentSession_SaveInterval

LootTracker.Session_Today = LootSession():initNew()
LootTracker.Session_7Days = LootSession():initNew()
LootTracker.Session_14Days = LootSession():initNew()
LootTracker.Session_30Days = LootSession():initNew()
LootTracker.Session_Total = LootSession():initNew()

LootTracker.AllSessions = {}

function LootTracker.Start()

  LootTracker.loadLootSessions()

  LootTracker.Running = true
end

function LootTracker.resetLootSessions()

	LootTracker.Session_Today = LootSession():initNew()
	LootTracker.Session_7Days = LootSession():initNew()
	LootTracker.Session_14Days = LootSession():initNew()
	LootTracker.Session_30Days = LootSession():initNew()
	LootTracker.Session_Total = LootSession():initNew()
end

function LootTracker.getDateFromPast(daysAgo)

	local seconds_since_xxx = os.time() 
	seconds_since_xxx = seconds_since_xxx - (daysAgo * 24 * 60 * 60)  

	return os.date("*t", seconds_since_xxx)
end

function LootTracker.getDateDiff_Days(dDay, dMonth, dYear)
	local reference = os.time{day=dDay, year=dYear, month=dMonth}
	local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
	local wholedays = math.floor(daysfrom)

	return wholedays
end

function LootTracker.loadLootSession_Today()

	local addedSession = 0

	for k,lootSession in pairs(LootTracker.AllSessions) do
		
		if 	lootSession.StartDate.Year == LootTracker.CurrentSession.StartDate.Year and
			lootSession.StartDate.Month == LootTracker.CurrentSession.StartDate.Month and
			lootSession.StartDate.Day == LootTracker.CurrentSession.StartDate.Day then

			LootTracker.Session_Today:mergeLootSession(lootSession)
			addedSession = addedSession + 1
		end	
	end

	print("loadLootSession_Today added " .. addedSession .. " to LootTracker.Session_Today")
end

function LootTracker.loadLootSession_7Days()
	
	local addedSession = 0

	for k,lootSession in pairs(LootTracker.AllSessions) do
		
		if LootTracker.getDateDiff_Days(lootSession.StartDate.Day, lootSession.StartDate.Month, lootSession.StartDate.Year) <= 7 then

			LootTracker.Session_7Days:mergeLootSession(lootSession)
			addedSession = addedSession + 1
		end	
	end

	print("loadLootSession_7Days added " .. addedSession .. " to LootTracker.Session_7Days")
end

function LootTracker.loadLootSession_14Days()
	
	local addedSession = 0

	for k,lootSession in pairs(LootTracker.AllSessions) do
		
		if 	LootTracker.getDateDiff_Days(lootSession.StartDate.Day, lootSession.StartDate.Month, lootSession.StartDate.Year) <= 14 then

			LootTracker.Session_14Days:mergeLootSession(lootSession)
			addedSession = addedSession + 1
		end	
	end

	print("loadLootSession_14Days added " .. addedSession .. " to LootTracker.Session_14Days")
end

function LootTracker.loadLootSession_30Days()
	
	local addedSession = 0

	for k,lootSession in pairs(LootTracker.AllSessions) do
		
		if 	LootTracker.getDateDiff_Days(lootSession.StartDate.Day, lootSession.StartDate.Month, lootSession.StartDate.Year) <= 30 then

			LootTracker.Session_30Days:mergeLootSession(lootSession)

			addedSession = addedSession + 1
		end	
	end

	print("loadLootSession_30Days added " .. addedSession .. " to LootTracker.Session_30Days")
end

function LootTracker.loadLootSession_Total()

	local addedSession = 0

	for k,lootSession in pairs(LootTracker.AllSessions) do
		
		LootTracker.Session_Total:mergeLootSession(lootSession)

		addedSession = addedSession + 1
	end

	print("loadLootSession_Total added " .. addedSession .. " to LootTracker.Session_Total")
end

function LootTracker.loadAllSessions()

	local files = Infinity.FileSystem.GetFiles("\\Sessions\\*.json")
	
	for k,fileName in pairs(files) do
		
		print("loadAllSessions file loaded: " .. fileName)
		table.insert(LootTracker.AllSessions, LootSession():initFromFile(fileName))
	end
end

function LootTracker.loadLootSessions()

	LootTracker.loadAllSessions()

	LootTracker.loadLootSession_Today()
	LootTracker.loadLootSession_7Days()
	LootTracker.loadLootSession_14Days()
	LootTracker.loadLootSession_30Days()
	LootTracker.loadLootSession_Total()
end

function LootTracker.deleteFile(filePath)

	os.remove(filePath)
end

function LootTracker.deleteAllSessionFiles()

	local files = Infinity.FileSystem.GetFiles("\\Sessions\\*.json")
	
	for k,fileName in pairs(files) do
		
		LootTracker.deleteFile(Infinity.Scripting.CurrentScript.DirectoryAsString .. "\\Sessions\\" .. fileName)
	end
end

function LootTracker.Stop()
  LootTracker.Running = false 

  LootTracker.CurrentSession:saveToFile()
end

function LootTracker.OnPulse()
	if not LootTracker.Running then
		return
	end

	if LootTracker.CurrentSession_NextUpdate <= Infinity.Win32.GetTickCount() then
		LootTracker.CurrentSession:updateDuration()

		LootTracker.CurrentSession_NextUpdate = Infinity.Win32.GetTickCount() + LootTracker.CurrentSession_UpdateInterval

		if LootTracker.CurrentSession.StartDate.Day ~= os.date("*t").day then

			LootTracker.CurrentSession:saveToFile()
			LootTracker.CurrentSession = LootSession():initNew()

			LootTracker.CurrentSession_NextSave = Infinity.Win32.GetTickCount() + LootTracker.CurrentSession_SaveInterval
		end
	end

	if LootTracker.CurrentSession_NextSave <= Infinity.Win32.GetTickCount() then
		LootTracker.CurrentSession:saveToFile()

		LootTracker.CurrentSession_NextSave = Infinity.Win32.GetTickCount() + LootTracker.CurrentSession_SaveInterval
	end
end

function LootTracker.onAddItemToInventory(packet)
	packet:parse()	

	if packet.Parsed.ToActorKey == Infinity.BDO.getLocalPlayer():getActorKey() and packet.Parsed.ToWhereType == 0 then	

		local elapsedSinceLastAddItem = Infinity.Win32.GetTickCount() - LootTracker.CurrentSession.LastTick_AddItem

		LootTracker.CurrentSession:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count)

		LootTracker.Session_Today:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count):addDuration(elapsedSinceLastAddItem)
		LootTracker.Session_7Days:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count):addDuration(elapsedSinceLastAddItem)
		LootTracker.Session_14Days:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count):addDuration(elapsedSinceLastAddItem)
		LootTracker.Session_30Days:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count):addDuration(elapsedSinceLastAddItem)
		LootTracker.Session_Total:addItem(packet.Parsed.ItemEnchantKey, packet.Parsed.Count):addDuration(elapsedSinceLastAddItem)
	end
end

function LootTracker.OnPacketReceive(byteBuffer)		
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()
	
	local name = OpCodes.getAckName(opCode)
	
	if name == "AddItemToInventory" then
		LootTracker.onAddItemToInventory(AddItemToInventoryAck(byteBuffer))
	end
end

function LootTracker.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function LootTracker.OnRenderD2D()	
end