Processing = {}

function Processing.startInventoryManufacture(actionName, itemSlot0, itemSlot1, itemSlot2, itemSlot3, itemSlot4)
	local code = 
	[[
		Manufacture_Do(38, "]] .. actionName .. [[", 0, ]] .. itemSlot0 .. [[, ]] .. itemSlot1 .. [[, ]] .. itemSlot2 .. [[, ]] .. itemSlot3 .. [[, ]] .. itemSlot4 .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end