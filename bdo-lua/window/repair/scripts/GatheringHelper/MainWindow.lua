MainWindow = { }

MainWindow.Actors_Names = {}
MainWindow.Actors_Ids = {}

local selected_Actor_Index = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("GatheringHelper")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if GatheringHelper.Running then
        btnText = "Stop"
    end

    if ImGui.Button(btnText) then
        if GatheringHelper.Running then
            GatheringHelper.StopBot()
        else
            GatheringHelper.StartBot()
        end
    end

    valueChanged, GatheringHelper.Settings.ShowRangeCircle = ImGui.Checkbox("Show Range Circle##id_range_circle_enabled", GatheringHelper.Settings.ShowRangeCircle)
    valueChanged, GatheringHelper.Settings.StopRangeCollectOnNearbyPlayers = ImGui.Checkbox("Stop RangeCollect On NearbyPlayers##id_player_stop_enabled", GatheringHelper.Settings.StopRangeCollectOnNearbyPlayers)
    valueChanged, GatheringHelper.Settings.StopNavigatorOnNearbyPlayers = ImGui.Checkbox("Stop Navigator On NearbyPlayers##id_player_stop_enabled", GatheringHelper.Settings.StopNavigatorOnNearbyPlayers)
    valueChanged, GatheringHelper.Settings.UseAutoNav = ImGui.Checkbox("Use Navigator##id_navigator_enabled", GatheringHelper.Settings.UseAutoNav)
    valueChanged, GatheringHelper.Settings.UseTpNav = ImGui.Checkbox("Use TP Nav##use_tp_nav", GatheringHelper.Settings.UseTpNav)
    
    if ImGui.CollapsingHeader("Filter##id_filter") then

    	if ImGui.Button("Load Actors") then

            MainWindow.getActorsForFilter()
        end

    	if ImGui.SmallButton("Add") then

            local canAdd = true

            for k,v in pairs(GatheringHelper.Settings.Actors) do
            	
            	if v.ActorId == MainWindow.Actors_Ids[selected_Actor_Index] then

            		canAdd = false
            		break
            	end
            end

            if canAdd then

            	table.insert(GatheringHelper.Settings.Actors, {Name = MainWindow.Actors_Names[selected_Actor_Index], ActorId = MainWindow.Actors_Ids[selected_Actor_Index]})
				selected_Actor_Index = 1
				valueChanged = true

                MainWindow.getActorsForFilter()
            end
        end

        ImGui.SameLine()

        _, selected_Actor_Index = ImGui.Combo("Select Actor##id_actors", selected_Actor_Index, MainWindow.Actors_Names)

        ImGui.Columns(3)
        ImGui.SetColumnWidth(0, 25)
        ImGui.SetColumnWidth(1, 100)
        ImGui.SetColumnWidth(2, 375)

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("ActorId")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(GatheringHelper.Settings.Actors) do

            if ImGui.SmallButton("X##id_actor_filter_delete_" .. k) then                
                table.remove(GatheringHelper.Settings.Actors, k)

                valueChanged = true
                break
            end

            ImGui.NextColumn()
            
            ImGui.Text(v.ActorId)
            ImGui.NextColumn()
            ImGui.Text(v.Name)
            ImGui.NextColumn()
        end
    end

    if ImGui.Button("Show Navigator") then

        if not GatheringHelper.Navigator.ShowGui then

            GatheringHelper.Navigator.ShowGui = true
        end
    end

    if valueChanged == true then
        GatheringHelper.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.getActorsForFilter()

	local names = {}
	local ids = {}

	for k,v in pairs(Infinity.BDO.getActorList(EActorType_All)) do

		if Interaction.canCollect(v:getActorKey()) then

			if table.find(ids, v:getActorId()) == nil then

                local canAdd = true

                for kk,vv in pairs(GatheringHelper.Settings.Actors) do
                    if vv.ActorId == v:getActorId() then
                        canAdd = false
                        break
                    end
                end

                if canAdd then
                    local bName = v:getName()

				    table.insert(names, bName)
				    table.insert(ids, v:getActorId())                
                end
			end			
		end
	end

	MainWindow.Actors_Names = names
	MainWindow.Actors_Ids = ids

	names = nil
	ids = nil
end