local UI = MagLib.UI

local indexCounter = 0

MagLib.UI.MenuBar = function()
	indexCounter = indexCounter + 1
	local MenuBar = {index = indexCounter}
	local currentIndex = 1
	local tabs = {}

	MenuBar.addTab = function(text, drawFunc)
		table.insert(tabs, {text = text, drawFunc = drawFunc})
	end

	MenuBar.drawMenuBar = function()
		if ImGui.BeginMenuBar() then
			-- Then draw each tab "button"
			for index, tabInfo in pairs(tabs) do
				if ImGui.BeginMenu(tabInfo.text .. "##menu_entry_" .. tabInfo.text, true) then
					currentIndex = index
					ImGui.EndMenu()
				end
			end
			ImGui.EndMenuBar()
		end
	end

	MenuBar.drawCurrentTab = function()
		tabs[currentIndex].drawFunc()
	end

	return MenuBar
end
