MainWindow = { }
MainWindow.AnimationLog = {}
MainWindow.AnimationLogVehicle = {}

MainWindow.AvailablesProfiles = {}
MainWindow.Profiles_SelectedIndex = 1
MainWindow.NewProfile_Name = ""
MainWindow.NewProfile_Active = false
MainWindow.NewProfile = nil

function MainWindow.DrawMainWindow()
	local valueChanged = false

    ImGui.Begin("Speedhack")

    ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

    local btnText = "Start"

    if Speedhack.Running == true then
    	btnText = "Stop"
    end

    if ImGui.Button(btnText) then
    	if Speedhack.Running == true then
    		Speedhack.StopBot()
    	else
    		Speedhack.StartBot()
    	end
    end
        
    ImGui.TextColored(RenderHelper.GetColorImVec4FromHexColorString("FFE9F542"), "Use at your own risk!")

    valueChanged, MainWindow.Profiles_SelectedIndex = ImGui.Combo("Profiles##id_profiles", table.findIndex(MainWindow.AvailablesProfiles, Speedhack.Settings.LastProfile), MainWindow.AvailablesProfiles)

        if valueChanged then

            Speedhack.Settings.LastProfile = MainWindow.AvailablesProfiles[MainWindow.Profiles_SelectedIndex]
            print("Profile selected : " .. Speedhack.Settings.LastProfile)

            local doStart = false

            if Speedhack.Running then
                doStart = true
            end

            if doStart then
                Speedhack.StopBot()
            end

            Speedhack.LoadLastProfile()            

            if doStart then
                Speedhack.StartBot()
            end
        end

        if ImGui.Button("New Profile##new_profile") then

            MainWindow.NewProfile_Active = true
            MainWindow.NewProfile = ProfileSettings()
        end

        if MainWindow.NewProfile_Active then

            _, MainWindow.NewProfile_Name = ImGui.InputText("Name##new_profile_name", MainWindow.NewProfile_Name)

            if ImGui.Button("Save##new_profile_save") then

                if MainWindow.NewProfile_Name ~= "" then

                    MainWindow.NewProfile.Name = MainWindow.NewProfile_Name
                    Speedhack.Settings.LastProfile = MainWindow.NewProfile.Name .. ".json"

                    Speedhack.CurrentProfile = MainWindow.NewProfile

                    Speedhack.SaveCurrentProfile()                    
                    Speedhack.LoadLastProfile()
                    MainWindow.RefreshAvailableProfiles()

                    MainWindow.NewProfile_Name = ""
                    MainWindow.NewProfile = nil
                    MainWindow.NewProfile_Active = false
                    
                    valueChanged = true
                end
            end
        end

        if Speedhack.CurrentProfile.Name ~= "" and not MainWindow.NewProfile_Active then

if ImGui.CollapsingHeader("Animation Hack(Cast/Attack)##id_animhack") then

    valueChanged, Speedhack.CurrentProfile.AnimEnabled = ImGui.Checkbox("Enabled##id_anim_enabled", Speedhack.CurrentProfile.AnimEnabled)
    valueChanged, Speedhack.CurrentProfile.Speed = ImGui.SliderFloat("Speed##speed_value", Speedhack.CurrentProfile.Speed, 1.0, 20)
    ImGui.SameLine()
    valueChanged, Speedhack.CurrentProfile.UseGlobalSpeedValue = ImGui.Checkbox("Use Global Value##id_anim_speed_global_value", Speedhack.CurrentProfile.UseGlobalSpeedValue)
    --valueChanged, Speedhack.CurrentProfile.DefaultSpeed = ImGui.SliderFloat("Default Speed##speed_value_default", Speedhack.CurrentProfile.DefaultSpeed, 1.0, 20)

    if valueChanged then
        Speedhack.SaveCurrentProfile() 
    end

    if ImGui.CollapsingHeader("Config##id_config") then

    	if ImGui.Button("Clear Log") then
    		MainWindow.AnimationLog = {}
    	end

    	MainWindow.cacheCurrentAnimation()

    	ImGui.Columns(2)
        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(MainWindow.AnimationLog) do
        	
        	if ImGui.Button("Add##id_animation_add_" .. k) then                
                
                if Speedhack.getWhitelistedActionObject(v) == nil then

                	table.insert(Speedhack.CurrentProfile.WhitelistedAnimations, {Name = v, Speed = Speedhack.CurrentProfile.Speed})
                    MainWindow.clearLogEntry(v)

                    Speedhack.SaveCurrentProfile() 
                	valueChanged = true    
                else
                	print("Whitelist already contains that animation!")
                end                            
            end

            ImGui.NextColumn()
        	ImGui.Text(v)
        	ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("Whitelisted Animations##id_whitelist") then
        
        if ImGui.Button("Clear Whitelist") then
            Speedhack.CurrentProfile.WhitelistedAnimations = {}

            Speedhack.SaveCurrentProfile() 
            valueChanged = true
        end

        ImGui.Columns(3)       

        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()
        ImGui.Text("Speed")
        ImGui.NextColumn()

        for k,v in pairs(Speedhack.CurrentProfile.WhitelistedAnimations) do
        	
        	if ImGui.Button("X##id_animation_delete_" .. k) then                
                table.remove(Speedhack.CurrentProfile.WhitelistedAnimations, k)

                Speedhack.SaveCurrentProfile() 
                valueChanged = true
                break
            end

            ImGui.NextColumn()
        	ImGui.Text(v.Name)
        	ImGui.NextColumn()
            valueChanged, v.Speed = ImGui.SliderFloat("##action_speed_value_" .. k, v.Speed, 1.0, 20.0)
            if valueChanged then
                Speedhack.SaveCurrentProfile() 
            end

            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end
end

if ImGui.CollapsingHeader("Movementspeed Hack(Player)##id_mvmthack_player") then

    valueChanged, Speedhack.CurrentProfile.MvmtPlayer.Enabled = ImGui.Checkbox("Enabled##id_mvmthack_player_enabled", Speedhack.CurrentProfile.MvmtPlayer.Enabled)
    
    valueChanged, Speedhack.CurrentProfile.MvmtPlayer.Speed = ImGui.SliderFloat("Speed##mvmthack_player_speed_value", Speedhack.CurrentProfile.MvmtPlayer.Speed, 1.0, 300)

    if valueChanged then
        Speedhack.SaveCurrentProfile() 
    end
end

if ImGui.CollapsingHeader("Speedhack(Vehicle)##id_hack_vehicle") then

    valueChanged, Speedhack.CurrentProfile.Vehicle.Enabled = ImGui.Checkbox("Enabled##id_hack_vehicle_enabled", Speedhack.CurrentProfile.Vehicle.Enabled)
    
    valueChanged, Speedhack.CurrentProfile.Vehicle.Speed.Enabled = ImGui.Checkbox("##hack_vehicle_speed_enabled", Speedhack.CurrentProfile.Vehicle.Speed.Enabled)
    ImGui.SameLine()
    valueChanged, Speedhack.CurrentProfile.Vehicle.Speed.Value = ImGui.SliderFloat("Speed##hack_vehicle_speed_value", Speedhack.CurrentProfile.Vehicle.Speed.Value, 100.0, 500.0)
    valueChanged, Speedhack.CurrentProfile.Vehicle.Speed.Default = ImGui.SliderFloat("Speed Default##hack_vehicle_speed_default", Speedhack.CurrentProfile.Vehicle.Speed.Default, 100.0, 500.0)
        
    valueChanged, Speedhack.CurrentProfile.Vehicle.Accel.Enabled = ImGui.Checkbox("##hack_vehicle_accel_enabled", Speedhack.CurrentProfile.Vehicle.Accel.Enabled)
    ImGui.SameLine()
    valueChanged, Speedhack.CurrentProfile.Vehicle.Accel.Value = ImGui.SliderFloat("Accel##hack_vehicle_accel_value", Speedhack.CurrentProfile.Vehicle.Accel.Value, 100.0, 500.0)
    valueChanged, Speedhack.CurrentProfile.Vehicle.Accel.Default = ImGui.SliderFloat("Accel Default##hack_vehicle_accel_default", Speedhack.CurrentProfile.Vehicle.Accel.Default, 100.0, 500.0)
    
    valueChanged, Speedhack.CurrentProfile.Vehicle.Turn.Enabled = ImGui.Checkbox("##hack_vehicle_turn_enabled", Speedhack.CurrentProfile.Vehicle.Turn.Enabled)
    ImGui.SameLine()
    valueChanged, Speedhack.CurrentProfile.Vehicle.Turn.Value = ImGui.SliderFloat("Turn##hack_vehicle_turn_value", Speedhack.CurrentProfile.Vehicle.Turn.Value, 100.0, 500.0)
    valueChanged, Speedhack.CurrentProfile.Vehicle.Turn.Default = ImGui.SliderFloat("Turn Default##hack_vehicle_turn_default", Speedhack.CurrentProfile.Vehicle.Turn.Default, 100.0, 500.0)
    
    valueChanged, Speedhack.CurrentProfile.Vehicle.Brake.Enabled = ImGui.Checkbox("##hack_vehicle_brake_enabled", Speedhack.CurrentProfile.Vehicle.Brake.Enabled)
    ImGui.SameLine()
    valueChanged, Speedhack.CurrentProfile.Vehicle.Brake.Value = ImGui.SliderFloat("Brake##hack_vehicle_brake_value", Speedhack.CurrentProfile.Vehicle.Brake.Value, 100.0, 500.0)
    valueChanged, Speedhack.CurrentProfile.Vehicle.Brake.Default = ImGui.SliderFloat("Brake Default##hack_vehicle_brake_default", Speedhack.CurrentProfile.Vehicle.Brake.Default, 100.0, 500.0)

    if valueChanged then
        Speedhack.SaveCurrentProfile() 
    end

    if ImGui.CollapsingHeader("Animation Hack(Vehicle)##id_animhack_vehicle") then

    valueChanged, Speedhack.CurrentProfile.Vehicle.AnimEnabled = ImGui.Checkbox("Enabled##id_anim_enabled_vehicle", Speedhack.CurrentProfile.Vehicle.AnimEnabled)
    valueChanged, Speedhack.CurrentProfile.Vehicle.AnimSpeed = ImGui.SliderFloat("Speed##speed_value_vehicle", Speedhack.CurrentProfile.Vehicle.AnimSpeed, 1.0, 20)

    if valueChanged then
        Speedhack.SaveCurrentProfile() 
    end

    if ImGui.CollapsingHeader("Config##id_config_vehicle") then

        if ImGui.Button("Clear Log") then
            MainWindow.AnimationLogVehicle = {}
        end

        MainWindow.cacheCurrentAnimationVehicle()

        ImGui.Columns(2)
        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(MainWindow.AnimationLogVehicle) do
            
            if ImGui.Button("Add##id_animation_vehicle_add_" .. k) then                
                
                if table.find(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations, v) == nil then

                    table.insert(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations, v)
                    MainWindow.clearLogEntryVehicle(v)

                    Speedhack.SaveCurrentProfile() 
                    valueChanged = true    
                else
                    print("Whitelist already contains that animation!")
                end                            
            end

            ImGui.NextColumn()
            ImGui.Text(v)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end

    if ImGui.CollapsingHeader("Whitelisted Animations##id_whitelist_vehicle") then
        
        if ImGui.Button("Clear Whitelist") then
            Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations = {}

            Speedhack.SaveCurrentProfile() 
            valueChanged = true
        end

        ImGui.Columns(2)
        ImGui.Text("")
        ImGui.NextColumn()
        ImGui.Text("Name")
        ImGui.NextColumn()

        for k,v in pairs(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations) do
            
            if ImGui.Button("X##id_animation_vehicle_delete_" .. k) then                
                table.remove(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations, k)

                Speedhack.SaveCurrentProfile() 
                valueChanged = true
                break
            end

            ImGui.NextColumn()
            ImGui.Text(v)
            ImGui.NextColumn()
        end

        ImGui.Columns(1)
    end
end
end
end

    if valueChanged then
    	Speedhack.SaveSettings()
    end

    ImGui.End()
end

function MainWindow.clearLogEntry(action)
    for k,v in pairs(MainWindow.AnimationLog) do
        if v == action then
            table.remove(MainWindow.AnimationLog, k)
            break
        end
    end
end

function MainWindow.clearLogEntryVehicle(action)
    for k,v in pairs(MainWindow.AnimationLogVehicle) do
        if v == action then
            table.remove(MainWindow.AnimationLogVehicle, k)
            break
        end
    end
end

function MainWindow.cacheCurrentAnimation()
	
	local currentAnimation = Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation():getName()

	if table.find(MainWindow.AnimationLog, currentAnimation) == nil and Speedhack.getWhitelistedActionObject(currentAnimation) == nil then

		table.insert(MainWindow.AnimationLog, currentAnimation)
	end
end

function MainWindow.cacheCurrentAnimationVehicle()
    
    if Infinity.BDO.getMyVehicle() == nil then
        return
    end

    if not Infinity.BDO.getMyVehicle():isValid() then    
        return
    end

    local currentAnimation = Infinity.BDO.getMyVehicle():getCharacterControler():getCurrentAnimation():getName()

    if table.find(MainWindow.AnimationLogVehicle, currentAnimation) == nil and table.find(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations, currentAnimation) == nil then

        table.insert(MainWindow.AnimationLogVehicle, currentAnimation)
    end
end

function MainWindow.RefreshAvailableProfiles()
    MainWindow.AvailablesProfiles = { }

    for k, v in pairs(Infinity.FileSystem.GetFiles("Profiles\\*.json")) do
        table.insert(MainWindow.AvailablesProfiles, v)

    end
end

MainWindow.RefreshAvailableProfiles()