Speedhack = {}
Speedhack.Running = false
Speedhack.Settings = Settings()
Speedhack.CurrentProfile = ProfileSettings()

Speedhack.lastTick = 0
Speedhack.VehicleReseted = false
Speedhack.PlayerReseted = false

Speedhack.PlayerManualSet = false
Speedhack.VehicleManualSet = false

Speedhack.applyPlayerMovement = false
Speedhack.applyVehicleSpeeds = false

Speedhack.vehicleActorKeyOverride = 0

Speedhack.lastAnimReset = 0

function Speedhack.OnAutoLoginAutoLoad()
	Speedhack.StartBot()
end

function Speedhack.Start()
	Speedhack.LoadSettings()

	if Speedhack.Settings.LastProfile ~= "" then
		print("Loading Last Profile")
		Speedhack.LoadLastProfile()
	end
end

function Speedhack.Stop()
	Speedhack.Running = false

	Speedhack.SaveCurrentProfile()
	Speedhack.SaveSettings()

	Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
	Speedhack.changeVehicleAnimSpeed(1.0)
end

function Speedhack.StartBot()
	if Speedhack.CurrentProfile.Name == "" then
		print("No Profile Selected")
		return
	end

	Speedhack.Running = true

	Speedhack.VehicleReseted = false
end

function Speedhack.StopBot()
	Speedhack.Running = false

	-- print("Speedhack.StopBot()")

	if Speedhack.CurrentProfile.MvmtPlayer.Enabled and not Speedhack.PlayerReseted then
		Speedhack.applyPlayerMovement = false
		Speedhack.PlayerReseted = true
		Speedhack.PlayerManualSet = false

		-- print("set mvmt speed 0")
		Infinity.BDO.getLocalPlayer():setMovementSpeed(0)
	end

	if Speedhack.CurrentProfile.Vehicle.Enabled and not Speedhack.VehicleReseted then
		Speedhack.VehicleReseted = true
		Speedhack.applyVehicleSpeeds = false
		Speedhack.VehicleManualSet = false

		-- print("set vehicle speeds to default")
		Speedhack.applyVehicleStats(Speedhack.CurrentProfile.Vehicle.Speed.Default * 10000,
                            		Speedhack.CurrentProfile.Vehicle.Accel.Default * 10000,
                            		Speedhack.CurrentProfile.Vehicle.Turn.Default * 10000,
                            		Speedhack.CurrentProfile.Vehicle.Brake.Default * 10000)
	end

	-- print("set anim to 1.0")
	Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)

	-- print("set vehicle anim to 1.0")
	Speedhack.changeVehicleAnimSpeed(1.0)
end

function Speedhack.applyVehicleStats(speed, accel, turn, brake)
	if not Speedhack.CurrentProfile.Vehicle.Enabled then
		return
	end

	if Infinity.BDO.getMyVehicle() == nil then
		-- print("Could not find current vehicle!")
		return
	end

	if not Infinity.BDO.getMyVehicle():isValid() then
		-- print("Could not find current vehicle!")
		return
	end

	speed = math.floor(speed)
	accel = math.floor(accel)
	turn = math.floor(turn)
	brake = math.floor(brake)

	local actorKey = Infinity.BDO.getMyVehicle():getActorKey()

	if Speedhack.vehicleActorKeyOverride ~= 0 and actorKey ~= Speedhack.vehicleActorKeyOverride then
		actorKey = Speedhack.vehicleActorKeyOverride
	end

	SetServantStats():construct(actorKey, speed, accel, turn, brake).Packet:receive()
end

function Speedhack.changeVehicleAnimSpeed(value)
	if Infinity.BDO.getMyVehicle() == nil then
		-- print("Could not find current vehicle!")
		return
	end

	if not Infinity.BDO.getMyVehicle():isValid() then
		-- print("Could not find current vehicle!")
		return
	end

	Infinity.BDO.getMyVehicle():getCharacterControler():getCharacterScene():setAnimationSpeed(value)
end

function Speedhack.hasNonWhiteListedPlayers()
	return Infinity.Whitelist.IsNonWhitelistedPlayerStreamed()
end

function Speedhack.applySpeeds()
	if not Infinity.BDO.getLocalPlayer():isValid() or Infinity.BDO.getLocalPlayer():getIsDead() then
		return
	end
	-- print("applySpeeds")
	local applyVehicleSpeeds = true

	if Speedhack.hasNonWhiteListedPlayers() then
		-- print("NearbyPlayersStop")
		if Speedhack.CurrentProfile.AnimEnabled and
			Speedhack.getWhitelistedActionObject(Infinity.BDO.getLocalPlayer():getCharacterControler():getCurrentAnimation()
                                     				:getName()) ~= nil then

			-- print("set anim to default")
			Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
		else

			-- print("set anim to 1.0")
			Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
		end

		-- print("set vehicle anim to 1.0")
		Speedhack.changeVehicleAnimSpeed(1.0)

		if Speedhack.CurrentProfile.MvmtPlayer.Enabled and not Speedhack.PlayerReseted then
			Speedhack.applyPlayerMovement = false
			Speedhack.PlayerReseted = true
			Speedhack.PlayerManualSet = false

			-- print("set mvmt speed to 0")
			Infinity.BDO.getLocalPlayer():setMovementSpeed(0)
		end

		if Speedhack.CurrentProfile.Vehicle.Enabled and not Speedhack.VehicleReseted then
			Speedhack.VehicleReseted = true
			Speedhack.applyVehicleSpeeds = false
			Speedhack.VehicleManualSet = false

			-- print("set vehicle speeds to default")
			Speedhack.applyVehicleStats(Speedhack.CurrentProfile.Vehicle.Speed.Default * 10000,
                            			Speedhack.CurrentProfile.Vehicle.Accel.Default * 10000,
                            			Speedhack.CurrentProfile.Vehicle.Turn.Default * 10000,
                            			Speedhack.CurrentProfile.Vehicle.Brake.Default * 10000)
		end

		applyVehicleSpeeds = false
		return
	end

	if Speedhack.CurrentProfile.AnimEnabled then
		-- print("AnimEnabled")
		local actionObject = Speedhack.getWhitelistedActionObject(Infinity.BDO.getLocalPlayer():getCharacterControler()
                                                          			:getCurrentAnimation():getName())

		if actionObject ~= nil then

			if Speedhack.CurrentProfile.UseGlobalSpeedValue then
				Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(
					Speedhack.CurrentProfile.Speed)
			else
				Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(actionObject.Speed)
			end
		else

			Infinity.BDO.getLocalPlayer():getCharacterControler():getCharacterScene():setAnimationSpeed(1.0)
		end
	end

	if Speedhack.CurrentProfile.Vehicle.AnimEnabled and Infinity.BDO.getMyVehicle() and
		Infinity.BDO.getMyVehicle():isValid() then
		if table.find(Speedhack.CurrentProfile.Vehicle.WhitelistedAnimations,
              		Infinity.BDO.getMyVehicle():getCharacterControler():getCurrentAnimation():getName()) ~= nil then
			Speedhack.changeVehicleAnimSpeed(Speedhack.CurrentProfile.Vehicle.AnimSpeed)
		else
			Speedhack.changeVehicleAnimSpeed(1.0)
		end
	end

	if Speedhack.CurrentProfile.Vehicle.Enabled and applyVehicleSpeeds and Infinity.BDO.getMyVehicle() and
		Infinity.BDO.getMyVehicle():isValid() then
		Speedhack.VehicleReseted = false

		local vehicleSpeeds = Servant.getSpeeds(Infinity.BDO.getMyVehicle():getActorKey())

		if vehicleSpeeds ~= nil and table.length(vehicleSpeeds) == 5 then

			applyVehicleSpeeds = false

			if Speedhack.CurrentProfile.Vehicle.Speed.Enabled and vehicleSpeeds[1] ~=
				math.floor(Speedhack.CurrentProfile.Vehicle.Speed.Value * 10000) then
				applyVehicleSpeeds = true
				vehicleSpeeds[1] = math.floor(Speedhack.CurrentProfile.Vehicle.Speed.Value * 10000)
			end

			if Speedhack.CurrentProfile.Vehicle.Accel.Enabled and vehicleSpeeds[2] ~=
				math.floor(Speedhack.CurrentProfile.Vehicle.Accel.Value * 10000) then
				applyVehicleSpeeds = true
				vehicleSpeeds[2] = math.floor(Speedhack.CurrentProfile.Vehicle.Accel.Value * 10000)
			end

			if Speedhack.CurrentProfile.Vehicle.Turn.Enabled and vehicleSpeeds[3] ~=
				math.floor(Speedhack.CurrentProfile.Vehicle.Turn.Value * 10000) then
				applyVehicleSpeeds = true
				vehicleSpeeds[3] = math.floor(Speedhack.CurrentProfile.Vehicle.Turn.Value * 10000)
			end

			if Speedhack.CurrentProfile.Vehicle.Brake.Enabled and vehicleSpeeds[4] ~=
				math.floor(Speedhack.CurrentProfile.Vehicle.Brake.Value * 10000) then
				applyVehicleSpeeds = true
				vehicleSpeeds[4] = math.floor(Speedhack.CurrentProfile.Vehicle.Brake.Value * 10000)
			end

			if applyVehicleSpeeds then

				Speedhack.applyVehicleStats(vehicleSpeeds[1], vehicleSpeeds[2], vehicleSpeeds[3], vehicleSpeeds[4])
			end
		end
	end

	if Speedhack.CurrentProfile.MvmtPlayer.Enabled and not Speedhack.PlayerManualSet then
		Speedhack.PlayerManualSet = true
		Speedhack.PlayerReseted = false
		Speedhack.applyPlayerMovement = true

		local desiredSpeed = math.floor(Speedhack.CurrentProfile.MvmtPlayer.Speed * 10000)
		Infinity.BDO.getLocalPlayer():setMovementSpeed(desiredSpeed)
	end
end

function Speedhack.OnPulse()
	if Speedhack.Running == false then
		return
	end

	if Speedhack.lastTick + 200 > Infinity.Win32.GetTickCount() then
		return
	end

	Speedhack.lastTick = Infinity.Win32.GetTickCount()

	Speedhack.applySpeeds()
end

function Speedhack.OnSetCharacterSpeeds(actorKey, speedIndex, speedValue)
	if not Speedhack.CurrentProfile.MvmtPlayer.Enabled then
		return
	end

	if not Speedhack.applyPlayerMovement then
		return
	end

	if speedIndex == 0 then

		local desiredSpeed = math.floor(Speedhack.CurrentProfile.MvmtPlayer.Speed * 10000)
		Infinity.BDO.getLocalPlayer():setMovementSpeed(desiredSpeed)
	end
end

function Speedhack.OnSetServantStats(packet)
	packet:parse()

	Speedhack.vehicleActorKeyOverride = packet.Parsed.ActorKey
end

function Speedhack.OnPacketReceive(byteBuffer)
	local packetLength = byteBuffer:getShort()
	local isEncrypted = byteBuffer:get()
	local opCode = byteBuffer:getShort()

	if OpCodes.getAckName(opCode) == "SetServantStats" then
		Speedhack.OnSetServantStats(SetServantStats(byteBuffer))
	end
end

function Speedhack.OnGuiDraw()
	MainWindow.DrawMainWindow()
end

function Speedhack.SaveSettings()
	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Settings.json", json:encode_pretty(Speedhack.Settings))
end

function Speedhack.LoadSettings()
	local json = JSON:new()
	Speedhack.Settings = Settings()

	table.merge(Speedhack.Settings, json:decode(Infinity.FileSystem.ReadFile("Settings.json")))
end

function Speedhack.SaveCurrentProfile()
	if Speedhack.CurrentProfile.Name == "" then
		return
	end

	local json = JSON:new()
	Infinity.FileSystem.WriteFile("Profiles\\" .. Speedhack.CurrentProfile.Name .. ".json",
                              	json:encode_pretty(Speedhack.CurrentProfile))
end

function Speedhack.LoadLastProfile()
	local json = JSON:new()
	Speedhack.CurrentProfile = ProfileSettings()

	table.merge(Speedhack.CurrentProfile,
            	json:decode(Infinity.FileSystem.ReadFile("Profiles\\" .. Speedhack.Settings.LastProfile)))
end

function Speedhack.getWhitelistedActionObject(name)

	for k, v in pairs(Speedhack.CurrentProfile.WhitelistedAnimations) do

		if v.Name == name then
			return v
		end
	end

	return nil
end
