local indexCounter = 0

MagLib.BDO.Actions.Combat.Profile = function(filePath)
	indexCounter = indexCounter + 1
	local Profile = {filePath = filePath, name = nil, extension = nil}
	Profile._init = nil
	Profile._combat = nil
	Profile._onPulse = nil
	Profile._onMoveTo = nil
	Profile._onUnload = nil
	Profile._onGUIRender = nil

	function Profile:init()
		if self._init then
			self:_init()
		end
	end
	function Profile:combat()
		if self._combat then
			self:_combat()
		end
	end
	function Profile:onPulse()
		if self._onPulse then
			self:_onPulse()
		end
	end
	function Profile:onMoveTo(dest, isNode)
		if self._onMoveTo then
			self:_onMoveTo(dest, isNode)
		end
	end
	function Profile:onUnload()
		if self._onUnload then
			self:_onUnload()
		end
	end
	function Profile:onGUIDraw(shouldDoOwnWindow)
		if self._onGUIDraw then
			self:_onGUIDraw(shouldDoOwnWindow)
		end
	end

	-- Get File extension by iterating over every char backwards and searching for a '.'
	local pathLen = filePath:len()
	local extensionDotPos = nil
	for i = pathLen, 1, -1 do
		local char = filePath:sub(i, i)
		if char == '.' and Profile.extension == nil then
			Profile.extension = filePath:sub(i + 1, pathLen)
			extensionDotPos = i
		end
		if char == "\\" then
			if extensionDotPos then
				Profile.name = filePath:sub(i + 1, extensionDotPos - 1)
			else
				print("ERROR: Could not find extension for " .. filePath)
			end
			break
		end

	end

	Profile.load = function()
		-- Resetting CM
		MagLib.BDO.Actions.Combat.CombatManager.reset()
		if Profile.extension == "lua" then
			Profile.loadFromLua()
		end

		Profile.init(Profile)
		print("Loading " .. Profile.extension .. " CombatProfile " .. Profile.name .. " from " .. Profile.filePath)
		MagLib.BDO.Actions.Combat.CombatManager.loadedProfile = Profile
	end

	Profile.loadFromLua = function()
		local tmp = MagLib.Core.IO.loadLua(Profile.filePath, true)
		Profile._init = tmp.init
		Profile._combat = tmp.combat
		Profile._onPulse = tmp.onPulse
		Profile._onMoveTo = tmp.onMoveTo
		Profile._onUnload = tmp.onUnload
		Profile._onGUIDraw = tmp.onGUIDraw
	end

	Profile.loadFromJson = function()
		-- TODO:
	end

	Profile.loadFromXml = function()
		-- TODO:
	end

	Profile.loadFromTxt = function()
		-- TODO:
	end

	return Profile
end
