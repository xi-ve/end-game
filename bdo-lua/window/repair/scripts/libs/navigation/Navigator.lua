Navigator = {}
Navigator.__index = Navigator

setmetatable(Navigator, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Navigator.new()
  local self = setmetatable({}, Navigator)   
  
  self.ShowGui = false
  self.ShowCheckpoints = true

  self.ProfileNames = {}
  self.ProfileSelectedIndex = 1

  self.Profiles = {}
  self.CurrentProfile = {Name = "", Checkpoints = {}}

  self.Recorder = nil

  self.Settings = NavigatorSettings()

  self.MaxNodeDistance = 200

  self:LoadSettings()

  self:LoadProfiles()

  return self
end

function Navigator:OnPulse()
	if self.Recorder ~= nil then

		if self.Recorder.IsRunning then
			self.Recorder:OnPulse()
		end
	end
end

function Navigator:OnRenderD2D()
	if not self.ShowCheckpoints or not self.ShowGui then
		return
	end

	for k,v in pairs(self.CurrentProfile.Checkpoints) do
		RenderHelper.DrawWorldSquare(NavigatorUtils.TableToVec3(v), 20, "FFFF0000", 3, true)
	end

	if self.Recorder ~= nil then

		for k,v in pairs(self.Recorder.Checkpoints) do
			RenderHelper.DrawWorldSquare(NavigatorUtils.TableToVec3(v), 20, "FF00FF50", 3, false)
		end
	end
end

function Navigator:OnGuiDraw()
	if not self.ShowGui then
		return
	end

	ImGui.Begin("Navigator")

	ImGui.SetWindowSize(ImVec2(500,500), ImGuiCond_FirstUseEver)

	if ImGui.SmallButton("Close") then
		self.ShowGui = false
	end

	ImGui.Spacing()

	if ImGui.SmallButton("Reload Profiles") then
		self.ProfileNames = {}
		self.Profiles = {}

		self:LoadProfiles()
	end

	_, self.ProfileSelectedIndex = ImGui.Combo("Profiles##profiles", self.ProfileSelectedIndex, self.ProfileNames)

	ImGui.SameLine()

	if ImGui.SmallButton("Load") then
		if self.CurrentProfile ~= nil and self.Profiles[self.ProfileSelectedIndex] ~= nil then
			self.CurrentProfile = self.Profiles[self.ProfileSelectedIndex]

			self.Settings.LastProfile = self.CurrentProfile.Name
			
			self:SaveSettings()
		else
			--No profile selected, we can't load what isn't selected and doesn't exist!
			print("No profile selected! Select a profile first.")
		end
	end

	ImGui.Spacing()

	if ImGui.Button("New Profile") then
		self.CurrentProfile = {Name = "New Profile", Checkpoints = {}}
	end

	ImGui.SameLine()

	if ImGui.Button("Save") then
		self:SaveProfile(self.CurrentProfile)

		self.Settings.LastProfile = self.CurrentProfile.Name

		self:SaveSettings()
	end

	_, self.CurrentProfile.Name =  ImGui.InputText("Name##name", self.CurrentProfile.Name)

	ImGui.Spacing()

	ImGui.Text("Checkpoints: " .. table.length(self.CurrentProfile.Checkpoints))

	ImGui.SameLine()

	if ImGui.SmallButton("Clear") then
		self.CurrentProfile.Checkpoints = {}
	end

	_, self.ShowCheckpoints = ImGui.Checkbox("Show Checkpoints##show_checkpoints", self.ShowCheckpoints)

	local recorderText = "Start Recorder"

	if self.Recorder ~= nil and self.Recorder.IsRunning then
		recorderText = "Stop Recorder"
	end

	if ImGui.Button(recorderText) then
		
		if self.Recorder == nil then
			self.Recorder = Recorder()
			self.Recorder:Start()
		else
			if not self.Recorder.IsRunning then
				self.Recorder:Start()
			else
				self.Recorder:Stop()

				for k,v in pairs(self.Recorder.Checkpoints) do
					table.insert(self.CurrentProfile.Checkpoints, v)
				end

				self.Recorder:Reset()
			end
		end
	end

	--ImGui.SameLine()

	if ImGui.Button("Import NavPath") then

		if NavigatorUtils.hasNavPath() then
			
			self.CurrentProfile.Checkpoints = {}

			local nPath = NavigatorUtils.getNavPath()
			local nPathCount = table.length(nPath)

			for i=1,nPathCount do
				
				local previousNode = nil
				local currentNode = nPath[i]
				local nextNode = nil

				if i > 1 then
					previousNode = nPath[i - 1]
				end

				if i < nPathCount then
					nextNode = nPath[i + 1]
				end

				if nextNode ~= nil then

					local dstNextNode = currentNode:getDistance(nextNode)

					if dstNextNode > self.MaxNodeDistance then

						local stepSize = math.floor(dstNextNode / self.MaxNodeDistance)

						local currentStepNode = currentNode

						table.insert(self.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentStepNode))

						local newStepDist = dstNextNode / stepSize
						
						for step=1,stepSize do							
							
							local lerpPct =  (newStepDist * step) / dstNextNode

							currentStepNode = currentNode:Lerp(currentNode, nextNode, lerpPct)

							table.insert(self.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentStepNode))
						end
					else

						table.insert(self.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentNode))
					end
				else

					table.insert(self.CurrentProfile.Checkpoints, NavigatorUtils.Vec3ToTable(currentNode))
				end
			end
		end
	end

	--ImGui.SameLine()

	_, self.MaxNodeDistance = ImGui.SliderInt("(NavPath)SubNode Distance##max_subnode_distance", self.MaxNodeDistance, 50, 2000)

	if self.Recorder ~= nil and self.Recorder.IsRunning then
		
		local pauseText = "Pause"

		if self.Recorder.Paused then
			pauseText = "Unpause"
		end

		if ImGui.Button(pauseText) then
			if self.Recorder.Paused then
				self.Recorder.Paused = false
			else
				self.Recorder.Paused = true
			end
		end
	end

	if self.Recorder ~= nil then

		_, self.Recorder.CheckpointDistance = ImGui.SliderFloat("Checkpoint Distance##cp_distance", self.Recorder.CheckpointDistance, 50, 2000)
		_, self.Recorder.CheckpointHeightOffset = ImGui.SliderFloat("Checkpoint Height Offset##cp_offset", self.Recorder.CheckpointHeightOffset, 0, 2000)
	end

	ImGui.End()
end

function Navigator:LoadProfiles()
	local files = Infinity.FileSystem.GetFiles("\\NavigatorProfiles\\*.json")

	for k,v in pairs(files) do
		
		local json = JSON:new()
    	local t = {}    

    	table.merge(t, json:decode(Infinity.FileSystem.ReadFile("NavigatorProfiles\\" .. v)))

    	if t.Name == self.Settings.LastProfile then
    		self.CurrentProfile = t
    		self.ProfileSelectedIndex = k
    	end

    	table.insert(self.ProfileNames, t.Name)
    	table.insert(self.Profiles, t)
	end

	print("Navigator Profiles Loaded!")
end

function Navigator:SaveProfiles()
	for k,v in pairs(self.Profiles) do

		local json = JSON:new()
    	Infinity.FileSystem.WriteFile("\\NavigatorProfiles\\" .. v.Name .. ".json", json:encode_pretty(v))
	end

	print("Navigator Profiles Saved!")
end

function Navigator:SaveProfile(profile)
	local json = JSON:new()
    Infinity.FileSystem.WriteFile("\\NavigatorProfiles\\" .. profile.Name .. ".json", json:encode_pretty(profile))
	
	print("Navigator Profile Saved!")
end

function Navigator:SaveSettings()
    local json = JSON:new()
    Infinity.FileSystem.WriteFile("NavigatorSettings.json", json:encode_pretty(self.Settings))
end

function Navigator:LoadSettings()
    local json = JSON:new()
    self.Settings = NavigatorSettings()
    
    table.merge(self.Settings, json:decode(Infinity.FileSystem.ReadFile("NavigatorSettings.json")))    
end