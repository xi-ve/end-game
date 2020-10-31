PacketSniffer = { }
PacketSniffer.Running = false

PacketSniffer.Queue = {}

PacketSniffer.Queue_Limit = 100

PacketSniffer.Listen = false

function PacketSniffer.Start()
  PacketSniffer.Running = true
	    
end

function PacketSniffer.Stop()
  PacketSniffer.Running = false  
end

function PacketSniffer.addToQueue(byteBuffer, name, isIncoming)
	if not PacketSniffer.Listen then
		return
	end

	local sPacket = SnifferPacket(byteBuffer, name, isIncoming)

	local add = true

	if MainWindow.FilterName ~= "" and string.find(string.lower(sPacket.Name), string.lower(MainWindow.FilterName)) == nil then
    	add = false
    end

    if MainWindow.FilterOpCode ~= "" and string.find(tostring(sPacket.opCode), MainWindow.FilterOpCode) == nil then
        add = false
    end

    if MainWindow.FilterLengthMin ~= "" and sPacket.length < tonumber(MainWindow.FilterLengthMin) then
        add = false
    end

    if MainWindow.FilterLengthMax ~= "" and sPacket.length > tonumber(MainWindow.FilterLengthMax) then
        add = false
    end

    if table.find(MainWindow.OpCodeBlackList, sPacket.opCode) ~= nil then
    	add = false
    end

    if add then
		table.insert(PacketSniffer.Queue, sPacket)

		if MainWindow.LogAllToFiles then
			sPacket:dumpToFile("\\PacketDumps\\")
		end

		if PacketRecorder.show and PacketRecorder.recording then
			if PacketRecorder.CurrentProfile.AutoRecordSkip > 0 then				
				if PacketRecorder.CurrentProfile.AutoRecordSkipped >= PacketRecorder.CurrentProfile.AutoRecordSkip then
					PacketRecorder.CurrentProfile.AutoRecordSkipped = 0
					table.insert(PacketRecorder.CurrentProfile.Queue, sPacket)	
				else
					PacketRecorder.CurrentProfile.AutoRecordSkipped = PacketRecorder.CurrentProfile.AutoRecordSkipped + 1			
				end
			else
				table.insert(PacketRecorder.CurrentProfile.Queue, sPacket)
			end			
		end
	end

	if table.length(PacketSniffer.Queue) == PacketSniffer.Queue_Limit then		
		table.remove(PacketSniffer.Queue, 1)
	end
end

function PacketSniffer.OnPacketReceive(byteBuffer)	
	if not MainWindow.showIn then
		return
	end

	PacketSniffer.addToQueue(byteBuffer, "", true)	
end

function PacketSniffer.OnPacketSend(byteBuffer, name)	
	if not MainWindow.showOut then
		return
	end

	PacketSniffer.addToQueue(byteBuffer, name, false)
end

function PacketSniffer.OnGuiDraw()
	MainWindow.DrawMainWindow() 

	for k,v in pairs(MainWindow.PacketInspectors) do
		v:draw(k)
	end

	PacketRecorder.DrawMainWindow()
end

function PacketSniffer.DumpToFile(byteBuffer, filename)    
    Infinity.FileSystem.WriteBinaryFile(filename, byteBuffer)
end