PacketRecorder = { }
PacketRecorder.show = false

PacketRecorder.recording = false

PacketRecorder.AvailablesProfiles = {}
PacketRecorder.Profiles_SelectedIndex = 1

PacketRecorder.CurrentProfile = {Name = "New Profile", Queue = {}, LoopCount = 1, AutoRecordSkip = 0, AutoRecordSkipped = 0}

function PacketRecorder.DrawMainWindow()  
    if not PacketRecorder.show then
        return
    end

    ImGui.Begin("PacketRecorder")

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
            
    if ImGui.Button("Clear Queue") then
        PacketRecorder.CurrentProfile.Queue = {}
        PacketRecorder.CurrentProfile.AutoRecordSkipped = 0
    end

    local recordingText = "Start Recorder"

    if PacketRecorder.recording then
        recordingText = "Stop Recorder"
    end

    if ImGui.Button(recordingText) then
        if PacketRecorder.recording then
            PacketRecorder.recording = false
        else
            PacketRecorder.recording = true
        end
    end

    _, PacketRecorder.Profiles_SelectedIndex = ImGui.Combo("Profiles##id_profiles", PacketRecorder.Profiles_SelectedIndex, PacketRecorder.AvailablesProfiles)

    ImGui.SameLine()

    if ImGui.Button("Load") then
        if table.length(PacketRecorder.AvailablesProfiles) > 0 then
            PacketRecorder.loadProfile(PacketRecorder.AvailablesProfiles[PacketRecorder.Profiles_SelectedIndex])
        end
    end
    
    _, PacketRecorder.CurrentProfile.Name = ImGui.InputText("Profile Name##profile_name", PacketRecorder.CurrentProfile.Name)

    _, PacketRecorder.CurrentProfile.LoopCount = ImGui.SliderInt("Loop Count##loop_count", PacketRecorder.CurrentProfile.LoopCount, 1, 1000)
    _, PacketRecorder.CurrentProfile.AutoRecordSkip = ImGui.SliderInt("Skip Count##skip_count", PacketRecorder.CurrentProfile.AutoRecordSkip, 0, 10)

    if ImGui.Button("Play Forward") then
        PacketRecorder.recording = false
        PacketRecorder.playPacketsForward()
    end

    ImGui.SameLine()

    if ImGui.Button("Play Backward") then
        PacketRecorder.recording = false
        PacketRecorder.playPacketsBackward()
    end

    ImGui.SameLine()

    if ImGui.Button("Save Profile") then
        PacketRecorder.saveProfile()
        PacketRecorder.loadProfiles()
    end

    for k,v in pairs(PacketRecorder.CurrentProfile.Queue) do
                
        if v.isIncoming then

            ImGui.Text("[IN] " .. v.Name .. " (" .. v.length .. " Bytes)")

            ImGui.SameLine()

            if ImGui.SmallButton("X##delete_" .. k) then

                table.remove(PacketRecorder.CurrentProfile.Queue, k)
                break
            end            
        else

            ImGui.Text("[OUT] [" .. v.opCode .. "] (" .. v.length .. " Bytes)")

            ImGui.SameLine()

            if ImGui.SmallButton("X##delete_" .. k) then

                table.remove(PacketRecorder.CurrentProfile.Queue, k)
                break
            end  
        end
    end

    ImGui.End()
end

function PacketRecorder.clearRecorder()
    PacketRecorder.CurrentProfile.Queue = {}
    PacketRecorder.recording = false
end

function PacketRecorder.playPacketsForward()
    for i = 1, PacketRecorder.CurrentProfile.LoopCount do
        for k,v in pairs(PacketRecorder.CurrentProfile.Queue) do
            if v.isIncoming then
                v:receive()
            else
                v:send()
            end
        end
    end
end

function PacketRecorder.playPacketsBackward()
    local tLength = table.length(PacketRecorder.CurrentProfile.Queue)

    for ii = 1, PacketRecorder.CurrentProfile.LoopCount do
        for i = tLength, 1 do
            if PacketRecorder.CurrentProfile.Queue[i].isIncoming then
                PacketRecorder.CurrentProfile.Queue[i]:receive()
            else
                PacketRecorder.CurrentProfile.Queue[i]:send()
            end
        end
    end
end

function PacketRecorder.loadProfiles()
    PacketRecorder.AvailablesProfiles = { }

    for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.json")) do
        table.insert(PacketRecorder.AvailablesProfiles, v)

    end
end

function PacketRecorder.loadProfile(fileName)
    local json = JSON:new()
    local packetJson = {}    

    table.merge(packetJson, json:decode(Infinity.FileSystem.ReadFile("Profiles\\" .. fileName)))

    PacketRecorder.CurrentProfile.Name = packetJson.Name
    PacketRecorder.CurrentProfile.LoopCount = packetJson.LoopCount
    PacketRecorder.CurrentProfile.AutoRecordSkip = packetJson.AutoRecordSkip
    PacketRecorder.CurrentProfile.AutoRecordSkipped = packetJson.AutoRecordSkipped

    PacketRecorder.CurrentProfile.Queue = {}

    for k,packetJson in pairs(packetJson.Queue) do
        local totalBytes = table.length(packetJson.Data)

        local data = ByteBuffer(1)
        
        for kk,byte in pairs(packetJson.Data) do
            data:put(byte)
        end
        
        data:setReadPos(0)
        data:setWritePos(0)

        local snifferPacket = SnifferPacket(data, packetJson.Name, packetJson.IsIncoming)

        table.insert(PacketRecorder.CurrentProfile.Queue, snifferPacket)
    end
end

function PacketRecorder.saveProfile()
    local profile = {Name = PacketRecorder.CurrentProfile.Name, LoopCount = PacketRecorder.CurrentProfile.LoopCount, AutoRecordSkip = PacketRecorder.CurrentProfile.AutoRecordSkip, AutoRecordSkipped = PacketRecorder.CurrentProfile.AutoRecordSkipped, Queue = {}}

    for k,snifferPacket in pairs(PacketRecorder.CurrentProfile.Queue) do
        local packetJson = {}

        packetJson.IsIncoming = snifferPacket.isIncoming
        packetJson.Name = snifferPacket.Name
        packetJson.Data = PacketRecorder.parsePacketToArray(snifferPacket.data)

        table.insert(profile.Queue, packetJson)
    end

    local json = JSON:new()
    Infinity.FileSystem.WriteFile("\\Profiles\\" .. profile.Name .. ".json", json:encode_pretty(profile))
end

function PacketRecorder.parsePacketToArray(byteBuffer)
  local dataArray = {}

  for i = 0, byteBuffer.size - 1 do
    
    local b = byteBuffer:_get(i)

    table.insert(dataArray, b)
    
  end

  return dataArray
end

PacketRecorder.loadProfiles()