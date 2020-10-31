function MagLib.Run.Modules.createHandler()
	local getTime = MagLib.getTime

	local self = {}
	self.modules = {}

	self.getModule = function(index_or_name)
		for k, v in pairs(self.modules) do
			if v.index == index_or_name or v.name == index_or_name then
				return v
			end
		end
	end

	self.addModule = function(module)
		table.insert(self.modules, module)
	end

	self.removeModule = function(module_or_index)
		local index = module_or_index
		if type(index) == "table" then -- meaning we got a module as parameter and not an index
			index = index.index
		end

		for k, v in pairs(self.modules) do
			if v.index == index then
				table.remove(self.modules, k)
				break
			end
		end
	end

	-- Runs the module and sets the lastRun time
	self.runModule = function(module)
		if module.needToRun() then
			module.run()
			if MagLib.Run.verboseLogging then
				print("Running module " .. module.name .. ". It was last ran " .. getTime() - module.lastRun .. " ms ago!")
			end
		end
		module.lastRun = getTime()
	end

	-- TODO: Should calculate a maxMsPerPulse. If maxIntervals are often missed, increase the maxMsPerPulse, or some other fancy system like targetted fps or sth.
	self.getMaxMsPerPulse = function()
		return 10
	end

	self.modes = MagLib.Run.Modules.TimingMode

	self.onPulse_Beginning = function()
		self.process(self.getModules_WithRunMode(MagLib.Run.EPulseTimingMode.Beginning))
	end

	self.onPulse_End = function()
		self.process(self.getModules_WithRunMode(MagLib.Run.EPulseTimingMode.End))
	end

	self.getModules_WithRunMode = function(runMode)
		local tmp = {}
		for _, v in pairs(self.modules) do
			if v.runMode == runMode then
				table.insert(tmp, v)
			end
		end

		return tmp
	end

	-- Decides on what module(s) to run, run it/them until the maxMsPerPulse is hit and then return.
	self.process = function(modules)
		local startTime = MagLib.Core.Stats.pulseStartTime
		local maxMsPerPulse = self.getMaxMsPerPulse()

		local tmpModuleList = {}

		for _, module in pairs(modules) do
			if module.active then
				local lastRun = module.lastRun
				local lastRunMsAgo = startTime - lastRun

				local timingMode = module.timingMode
				local maxInterval = module.maxInterval
				local minInterval = module.minInterval

				-- Priority calculation:
				local priority
				if module.everyPulse then
					-- Execute every pulse
					priority = math.huge
				elseif minInterval > lastRunMsAgo then
					-- Last run time is lower than minInterval
					priority = 0
				else
					if maxInterval <= lastRunMsAgo then
						-- We are over maxInterval so we execute
						priority = math.huge
					else
						-- We are over minInterval but less than maxInterval
						local diffToMinInterval = lastRunMsAgo - minInterval
						local diffToMaxInterval = maxInterval - lastRunMsAgo
						local interval = maxInterval - minInterval

						-- Calculate priority based on the different modes
						if timingMode == self.modes.TimedCritical then
							priority = (20 / interval) + (6 / diffToMinInterval) + (3 / diffToMaxInterval)
						elseif timingMode == self.modes.Exact then
							priority = math.huge -- We are >= minInterval, so we want to run
						elseif timingMode == self.modes.TimedNonCritical then
							priority = (80 / interval) + ((interval / diffToMaxInterval) / 15)
						else
							print("Unknown TimingMode in Module " .. module.name)
						end
					end
				end
				module.priority = priority
				table.insert(tmpModuleList, module)
				-- print("Name: " .. module.name .. " lastRunMsAgo: ".. lastRunMsAgo .."Priority: " .. priority)
			end
		end
		-- Sorting the temp module list by priority
		table.sort(tmpModuleList, function(a, b)
			-- print(tostring(a))
			-- print(a.name .. ": " .. tostring(a.priority) .. " | " .. b.name .. ": " .. tostring(b.priority))
			return a.priority > b.priority
		end)

		local ranModules = false
		for k, module in ipairs(tmpModuleList) do
			local prio = module.priority
			-- First we check that the priority is == math.huge, in which case, just execute it.
			if prio == math.huge then
				self.runModule(module)
				ranModules = true
			else
				local msLeft = maxMsPerPulse - (getTime() - startTime)
				if msLeft > 0 and prio > (0.25 - (msLeft / 100)) then
					self.runModule(module)
					ranModules = true
				else
					break
				end
			end
		end

		if ranModules then
			if MagLib.Run.verboseLogging then
				print("Executing Modules took " .. getTime() - startTime .. "ms!")
			end
		end

	end

	return self
end

-- set Handler
MagLib.Run.Modules.Handler = MagLib.Run.Modules.createHandler()
