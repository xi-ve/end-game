MainWindow = { }
MainWindow.TabNames = {"Current Session", "Today", "Last 7 Days", "Last 14 Days", "Last 30 Days", "Total"}
MainWindow.CurrentTabIndex = 1

function MainWindow.DrawMainWindow()	
    ImGui.Begin("LootTracker")
        
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
   
    local pushedStyleColors = 0

    for i=1, table.length(MainWindow.TabNames) do
    	
    	if i == MainWindow.CurrentTabIndex then

    		ImGui.PushStyleColor2(ImGuiCol_Button, ImVec4(0, 0.5, 0, 1))
    		pushedStyleColors = pushedStyleColors + 1
    	end

    	if ImGui.SmallButton(MainWindow.TabNames[i] .. "##tab_selector_" .. i) then
    		MainWindow.CurrentTabIndex = i
    	end
    	
    	ImGui.PopStyleColor(pushedStyleColors)
    	pushedStyleColors = 0

    	if i < table.length(MainWindow.TabNames) then
    		ImGui.SameLine()
    	end
    end    
    
    MainWindow.drawContent()

    if ImGui.SmallButton("Reset Current Session##reset_current_session") then

		LootTracker.CurrentSession:saveToFile()
		LootTracker.CurrentSession = LootSession():initNew()
	end

	if ImGui.SmallButton("Delete All Session Files##delete_all_session_files") then

		LootTracker.CurrentSession:saveToFile()
		LootTracker.CurrentSession = LootSession():initNew()

		LootTracker.deleteAllSessionFiles()
		LootTracker.resetLootSessions()
	end

    ImGui.End()
end

function MainWindow.drawContent()

	local lootSession = MainWindow.getLootSessionBySelectedTab()

	ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(0.5, 0.5, 0.5, 1))

	ImGui.Text("Session Duration: " .. lootSession:getDurationFormated())

	ImGui.PopStyleColor(1)

	ImGui.Columns(3)
	ImGui.SetColumnWidth(0, 300)
	ImGui.SetColumnWidth(1, 100)
	ImGui.SetColumnWidth(2, 100)

	ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(1, 0.5, 0, 1))

	ImGui.Text("Item")
	ImGui.NextColumn()
	ImGui.Text("Total")
	ImGui.NextColumn()
	ImGui.Text("/Hour")
	ImGui.NextColumn()	

	ImGui.PopStyleColor(1)

	if lootSession ~= nil then

		ImGui.PushStyleColor2(ImGuiCol_Text, ImVec4(0.3, 0.6, 0.6, 1))

		local durationHours = lootSession:getDurationInHours()

		for k,stats in pairs(lootSession.ItemStats) do
		
			ImGui.Text(stats.Name)
			ImGui.NextColumn()
			ImGui.Text(stats.Count)
			ImGui.NextColumn()
			ImGui.Text(string.format("%.2f", (stats.Count / durationHours)))
			ImGui.NextColumn()
		end

		ImGui.PopStyleColor(1)
	end

	if ImGui.SmallButton("Export this Session to CSV##export_to_csv") then

		lootSession:exportToCSV()
	end

	ImGui.Columns(1)	
end

function MainWindow.getLootSessionBySelectedTab()

	if MainWindow.CurrentTabIndex == 1 then
		return LootTracker.CurrentSession
	elseif MainWindow.CurrentTabIndex == 2 then
		return LootTracker.Session_Today
	elseif MainWindow.CurrentTabIndex == 3 then
		return LootTracker.Session_7Days
	elseif MainWindow.CurrentTabIndex == 4 then
		return LootTracker.Session_14Days
	elseif MainWindow.CurrentTabIndex == 5 then
		return LootTracker.Session_30Days
	elseif MainWindow.CurrentTabIndex == 6 then
		return LootTracker.Session_Total
	end
end