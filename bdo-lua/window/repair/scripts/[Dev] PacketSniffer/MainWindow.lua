MainWindow = { }

MainWindow.showNewHexEditor = false
MainWindow.showIn = true
MainWindow.showOut = true

MainWindow.PacketInspectors = {}

MainWindow.OpCodeBlackList = {}

MainWindow.FilterName = ""
MainWindow.FilterOpCode = ""
MainWindow.FilterLengthMin = ""
MainWindow.FilterLengthMax = ""

MainWindow.LogAllToFiles = false

function MainWindow.DrawMainWindow()     
    ImGui.Begin("PacketSniffer")
            
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    _, MainWindow.showIn = ImGui.Checkbox("In##id_in", MainWindow.showIn)

    ImGui.SameLine()

    _, MainWindow.showOut = ImGui.Checkbox("Out##id_out", MainWindow.showOut)

    ImGui.SameLine()

    if ImGui.Button("Clear##clear") then

        MainWindow.FilterName = ""
        MainWindow.FilterOpCode = ""
        MainWindow.FilterLengthMin = ""
        MainWindow.FilterLengthMax = ""

        MainWindow.OpCodeBlackList = {}

        PacketSniffer.Queue = {}
    end

    ImGui.SameLine()

    _, MainWindow.showNewHexEditor = ImGui.Checkbox("New Editor##id_new_editor", MainWindow.showNewHexEditor)

    ImGui.SameLine()

    local btnText = "Start"

    if PacketSniffer.Listen == true then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if PacketSniffer.Listen == true then
            PacketSniffer.Listen = false
        else
            PacketSniffer.Listen = true
        end
    end

    ImGui.SameLine()

    local recorder_btnText = "Show Recorder"

    if PacketRecorder.show then
        recorder_btnText = "Hide Recorder"
    end

    if ImGui.Button(recorder_btnText) then
        if PacketRecorder.show then
            PacketRecorder.show = false

            PacketRecorder.clearRecorder()
        else
            PacketRecorder.show = true
        end
    end

    _, MainWindow.LogAllToFiles = ImGui.Checkbox("Log All To Files##log_all", MainWindow.LogAllToFiles)

    if ImGui.Button("Blacklist Current OpCodes") then

        for k,v in pairs(PacketSniffer.Queue) do

            if table.find(MainWindow.OpCodeBlackList, v.opCode) == nil then

                table.insert(MainWindow.OpCodeBlackList, v.opCode)
            end
        end

        PacketSniffer.Queue = {}
    end

    local inputChanged = false

    inputChanged, MainWindow.FilterName = ImGui.InputText("Filter by Name##filter_name", MainWindow.FilterName)

    if inputChanged then        
        PacketSniffer.Queue = {}
    end

    inputChanged, MainWindow.FilterOpCode =  ImGui.InputText("Filter by OpCode##filter_opcode", MainWindow.FilterOpCode)

    if inputChanged then        
        PacketSniffer.Queue = {}
    end

    inputChanged, MainWindow.FilterLengthMin =  ImGui.InputText("Filter by Min Length##filter_minlength", MainWindow.FilterLengthMin)

    if inputChanged then        
        PacketSniffer.Queue = {}
    end

    inputChanged, MainWindow.FilterLengthMax =  ImGui.InputText("Filter by Max Length##filter_maxlength", MainWindow.FilterLengthMax)

    if inputChanged then        
        PacketSniffer.Queue = {}
    end

    for k,v in pairs(PacketSniffer.Queue) do
                
        --[[if ImGui.SmallButton("Ignore##add_ignore_" .. k) then

            table.remove(PacketSniffer.Queue, k)

            if table.find(MainWindow.OpCodeBlackList, v.opCode) == nil then

                table.insert(MainWindow.OpCodeBlackList, v.opCode)

                for kk,vv in pairs(PacketSniffer.Queue) do

                    if vv.opCode == v.opCode then
                        table.remove(PacketSniffer.Queue, kk)
                    end
                end
            end

            break
        end

        ImGui.SameLine()]]--

        if v.isIncoming and MainWindow.showIn then

            ImGui.Text("[IN] " .. v.Name .. " (" .. v.length .. " Bytes)")

            ImGui.SameLine()

            if ImGui.Button("Inspect##inspect_" .. k) then

                table.insert(MainWindow.PacketInspectors, PacketInspector(v))
            end

            if PacketRecorder.show then
                ImGui.SameLine()

                if ImGui.Button("Recorder Add##recorder_add_" .. k) then

                    table.insert(PacketRecorder.CurrentProfile.Queue, v)
                end
            end
        elseif not v.isIncoming and MainWindow.showOut then

            if v.Name == "nA." then
                ImGui.Text("[OUT] nA. [" .. v.opCode .. "] (" .. v.length .. " Bytes)")
            else
                ImGui.Text("[OUT] " .. v.Name .. " (" .. v.length .. " Bytes)")
            end            

            ImGui.SameLine()

            if ImGui.Button("Inspect##inspect_" .. k) then

                table.insert(MainWindow.PacketInspectors, PacketInspector(v))
            end

            if PacketRecorder.show then
                ImGui.SameLine()

                if ImGui.Button("Recorder Add##recorder_add_" .. k) then

                    table.insert(PacketRecorder.CurrentProfile.Queue, v)
                end
            end
        end
    end
    
    ImGui.End()
end