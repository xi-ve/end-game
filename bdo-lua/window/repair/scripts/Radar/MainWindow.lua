MainWindow = { }
MainWindow.ActorTypes = {"All", "Player", "Monster", "Npc", "Vehicle", "Gate", "Alterego", "Collect", "Household", "Installation", "Deadbody"}
MainWindow.DrawStylesNames = {"Circle", "Square", "HitBox"}
MainWindow.DrawStyles = {Circle = 1, Square = 2, HitBox = 3}

local NewFilter_Name = "New Filter"
local NewFilter_ActorType = EActorType_All
local NewFilter_ActorType_ComboBoxSelectedIndex = 1
local NewFilter_DrawStyle = (MainWindow.DrawStyles).Circle
local NewFilter_DrawStyle_ComboBoxSelectedIndex = 1
local NewFilter_Color = "FFFFFFFF"
local NewFilter_Size = 50
local NewFilter_Thickness = 1
local NewFilter_Fill = false
local NewFilter_ActorId = ""
local NewFilter_ActorIds = {}
local NewFilter_ActorNames = {}

MainWindow.Nearby_Actors_Names = {}
MainWindow.Nearby_Actors_Ids = {}
MainWindow.Nearby_Actors_ComboBoxSelectedIndex = 1

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("Radar")
    
    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)
    
    if ImGui.CollapsingHeader("Filters##id_filters") then
        if ImGui.CollapsingHeader("New Filter##id_new_filter") then     
            if ImGui.Button("Add Filter##new_filter_add") then
                if MainWindow.getFilterByName(NewFilter_Name) == nil then
                    NewFilter_ActorType = MainWindow.getActorTypeBySelectedIndex(NewFilter_ActorType_ComboBoxSelectedIndex)
                    NewFilter_DrawStyle = NewFilter_DrawStyle_ComboBoxSelectedIndex
                    
                    if NewFilter_Color:len() == 8 then
                        table.insert(Radar.Settings.Filters, {Enabled = true, Name = NewFilter_Name, ActorType = tonumber(tostring(NewFilter_ActorType)), DrawStyle = tonumber(tostring(NewFilter_DrawStyle)), Color = NewFilter_Color, Size = NewFilter_Size, Thickness = NewFilter_Thickness, Fill = NewFilter_Fill, Ids = NewFilter_ActorIds})

                        NewFilter_Name = "New Filter"
                        NewFilter_ActorType = EActorType_All
                        NewFilter_ActorType_ComboBoxSelectedIndex = 1
                        NewFilter_DrawStyle = (MainWindow.DrawStyles).Circle
                        NewFilter_DrawStyle_ComboBoxSelectedIndex = 1
                        NewFilter_Color = "FFFFFFFF"
                        NewFilter_Thickness = 1
                        NewFilter_Fill = false
                        NewFilter_ActorIds = {}
                        NewFilter_ActorNames = {}

                        valueChanged = true

                        print("Added New Filter!")
                    else
                        print("Color string has invalid length! Must be 8 chars (eg. FF000000!")
                    end
                else
                    print("Filter with this name alrdy exists! Choose another name!")
                end
            end

            ImGui.Spacing()

            _, NewFilter_Name = ImGui.InputText("Name##new_filter_name", NewFilter_Name)
            _, NewFilter_ActorType_ComboBoxSelectedIndex = ImGui.Combo("ActorType##new_filter_actortype", NewFilter_ActorType_ComboBoxSelectedIndex, MainWindow.ActorTypes)
            _, NewFilter_DrawStyle_ComboBoxSelectedIndex = ImGui.Combo("DrawStyle##new_filter_drawstyle", NewFilter_DrawStyle_ComboBoxSelectedIndex, MainWindow.DrawStylesNames)
            _, NewFilter_Color = ImGui.InputText("Color##new_filter_color", NewFilter_Color)
            ImGui.SameLine()            

            if NewFilter_Color:len() < 8 or NewFilter_Color:len() > 8 then

            else
                local btnColor = RenderHelper.GetColorImVec4FromHexColorString(NewFilter_Color)
                ImGui.ColorButton("Color##new_filter_color_preview", btnColor, ImVec2(20,20))
            end

            _, NewFilter_Size = ImGui.SliderInt("Size##new_filter_size", NewFilter_Size, 10, 100)
            _, NewFilter_Thickness = ImGui.SliderInt("Thickness##new_filter_thickness", NewFilter_Thickness, 1, 10)
            _, NewFilter_Fill = ImGui.Checkbox("Fill##new_filter_fill", NewFilter_Fill)

            ImGui.Spacing()

            if ImGui.Button("Add##new_filter_actor_add") then
                local addy_ActorId = MainWindow.Nearby_Actors_Ids[MainWindow.Nearby_Actors_ComboBoxSelectedIndex]
                local addy_ActorName = MainWindow.Nearby_Actors_Names[MainWindow.Nearby_Actors_ComboBoxSelectedIndex]

                if NewFilter_ActorId ~= "" then
                    addy_ActorId = tonumber(NewFilter_ActorId)
                    addy_ActorName = "Custom Actor"
                end            

                if addy_ActorId ~= nil and table.find(NewFilter_ActorIds, addy_ActorId) == nil then
                    table.insert(NewFilter_ActorIds, addy_ActorId)
                    table.insert(NewFilter_ActorNames, addy_ActorName)

                    NewFilter_ActorId = ""
                end
            end
            
            _, NewFilter_ActorId = ImGui.InputText("Custom ActorId##new_filter_custom_actorid", NewFilter_ActorId)
            _, MainWindow.Nearby_Actors_ComboBoxSelectedIndex = ImGui.Combo("Nearby Actors##nearby_actors", MainWindow.Nearby_Actors_ComboBoxSelectedIndex, MainWindow.Nearby_Actors_Names)

            ImGui.Columns(3)
            ImGui.Text("")
            ImGui.NextColumn()
            ImGui.Text("ActorId")
            ImGui.NextColumn()
            ImGui.Text("Name")
            ImGui.NextColumn() 

            for k,v in pairs(NewFilter_ActorIds) do
                if ImGui.Button("X##actor_filter_remove_" .. k) then
                    table.remove(NewFilter_ActorIds, k)
                    table.remove(NewFilter_ActorNames, k)

                    break
                end

                ImGui.NextColumn()

                ImGui.Text(v)
                ImGui.NextColumn()
                ImGui.Text(NewFilter_ActorNames[k])
                ImGui.NextColumn() 

            end
        end

        ImGui.Spacing()

        if ImGui.CollapsingHeader("Existing Filters##id_existing_filters") then
            ImGui.Columns(10)
            ImGui.Text("")
            ImGui.NextColumn()
            ImGui.Text("Enabled")
            ImGui.NextColumn()
            ImGui.Text("Name")
            ImGui.NextColumn()
            ImGui.Text("ActorType")
            ImGui.NextColumn() 
            ImGui.Text("DrawStyle")
            ImGui.NextColumn() 
            ImGui.Text("Color")
            ImGui.NextColumn() 
            ImGui.Text("Size")
            ImGui.NextColumn() 
            ImGui.Text("Thickness")
            ImGui.NextColumn() 
            ImGui.Text("Fill")
            ImGui.NextColumn() 
            ImGui.Text("Ids")
            ImGui.NextColumn() 

            for k,v in pairs(Radar.Settings.Filters) do                
                if ImGui.Button("X##filter_remove_" .. k) then
                    table.remove(Radar.Settings.Filters, k)

                    valueChanged = true
                    break
                end

                ImGui.NextColumn()

                valueChanged, Radar.Settings.Filters[k].Enabled = ImGui.Checkbox("##filter_enabled_" .. k, Radar.Settings.Filters[k].Enabled)

                ImGui.NextColumn()
                ImGui.Text(v.Name)
                ImGui.NextColumn()
                ImGui.Text(MainWindow.ActorTypes[v.ActorType + 2])
                ImGui.NextColumn() 
                ImGui.Text(MainWindow.DrawStylesNames[v.DrawStyle])
                ImGui.NextColumn() 
                ImGui.Text(v.Color)
                ImGui.NextColumn() 
                ImGui.Text(v.Size)
                ImGui.NextColumn() 
                ImGui.Text(v.Thickness)
                ImGui.NextColumn() 
                ImGui.Text(tostring(v.Fill))    
                ImGui.NextColumn() 
                ImGui.Text(MainWindow.tableToString(v.Ids))
                ImGui.NextColumn() 
            end
        end
    end

    if valueChanged then
        Radar.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.loadNearbyActors()    
    local names = {}
    local ids = {}
    
    for k,v in pairs(Radar.getTableByActorType(NewFilter_ActorType_ComboBoxSelectedIndex - 2)) do
        if v ~= nil and table.find(ids, v:getActorId()) == nil then
            table.insert(names, v:getName())
            table.insert(ids, v:getActorId())
        end
    end

    MainWindow.Nearby_Actors_Names = names
    MainWindow.Nearby_Actors_Ids = ids

    names = nil
    ids = nil
end

function MainWindow.getFilterByName(name)
    for k,v in pairs(Radar.Settings.Filters) do
        if v.Name == name then
            return v
        end
    end

    return nil
end

function MainWindow.getActorTypeBySelectedIndex(index)    
    if index == 1 then
        return -1
    elseif index == 2 then
        return 0
    elseif index == 3 then
        return 1
    elseif index == 4 then
        return 2
    elseif index == 5 then
        return 3
    elseif index == 6 then
        return 4
    elseif index == 7 then
        return 5
    elseif index == 8 then
        return 6
    elseif index == 9 then
        return 7
    elseif index == 10 then
        return 8
    elseif index == 11 then
        return 9
    end
end

function MainWindow.getDrawStyleBySelectedIndex(index)
    return MainWindow.DrawStyles[index]
end

function MainWindow.tableToString(table)
    local s = ""

    for k,v in pairs(table) do
        if s:len() == 0 then
            s = tostring(v)
        else
            s = s .. ", " .. tostring(v)
        end
    end

    return s
end