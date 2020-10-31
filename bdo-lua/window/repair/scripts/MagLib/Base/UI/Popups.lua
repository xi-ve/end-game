local Popups = {}

-- All popup classes
local popups = {}

Popups.new = function(name, drawFunc, timeout)
	table.insert(popups, MagLib.UI.Popups.Popup(name, drawFunc, timeout))
end

Popups.addPopup = function(popup)
	table.insert(popups, popup)
end

Popups.draw = function()
	local toRemoveIndexes = {}
	for k, v in ipairs(popups) do
		v:draw()
		if v.shouldDestruct() then
			table.insert(toRemoveIndexes, k)
		end
	end

	local amountToRemove = #toRemoveIndexes
	if amountToRemove > 0 then
		for i = amountToRemove, 1, -1 do
			table.remove(popups, toRemoveIndexes[i])
		end
	end
end

MagLib.UI.Popups = Popups
