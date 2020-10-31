local indexCounter = 0
local UI = MagLib.UI

MagLib.UI.Popups.Popup = function(name, drawFunc, timeout, shouldDestructOnTimeout)
	indexCounter = indexCounter + 1
	local Popup = {
		index = indexCounter,
		name = name,
		drawFunc = drawFunc,
		timeout = timeout or (1 / 0),
		createTime = MagLib.getTime(),
		shouldDestructOnTimeout = shouldDestructOnTimeout
	}

	Popup.vars = {} -- For persistent vars over multiple popups
	local active = true
	local destruct = false

	Popup.refreshTimeout = function()
		active = true
		Popup.createTime = MagLib.getTime()
	end

	Popup.close = function()
		destruct = true
	end

	Popup.deactivate = function()
		active = false
	end

	Popup.activate = function()
		active = true
	end

	Popup.shouldDestruct = function()
		return destruct
	end

	Popup.draw = function()
		if not active then
			return false
		end

		if Popup.createTime + Popup.timeout < MagLib.getTime() then
			active = false
			if Popup.shouldDestructOnTimeout then
				destruct = true
			end
			return false
		end

		-- ImGui.PushStyleVar2(ImGuiStyleVar_WindowMinSize, ImVec2(350, 200))
		UI.newWindow(name .. "##" .. Popup.index)
		Popup:drawFunc()
		UI.endWindow()
		-- ImGui.PopStyleVar(1)

		return true
	end

	Popup = setmetatable(Popup, {
		__eq = function(a, b)
			return a.index == b.index
		end,
		__lt = function(a, b)
			return a.index < b.index
		end, -- Not really needed, keeping it anyways for now
		__tostring = function(n)
			return "Popup " .. n.name
		end
	})

	return Popup
end
