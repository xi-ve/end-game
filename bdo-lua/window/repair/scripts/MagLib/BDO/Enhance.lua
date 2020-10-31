local Enhance = {}

Enhance.getFailstackCount = function()

	local code = [[
      local enchantInfo = getEnchantInformation()
      return enchantInfo:ToClient_getFailCount()
    ]]
	return Infinity.BDO.Lua.Execute(code)
	-- end
end

-- Enhancement
Enhance.enhance = function(itemSlot, stoneKey)
	local stoneSlot = MagLib.BDO.Inventory.getItemSlotByKey(stoneKey)
	EnchantItemReq():construct(itemSlot, stoneSlot).Packet:send()
end

-- Extract Failstacks
Enhance.extractFailstacks = function(bookKey)
	local slot = MagLib.BDO.Inventory.getItemSlotByKey(bookKey)
	local code = [[
    ToClient_ConvertEnchantFailCountToItem(0, ]] .. slot .. [[)
  ]]
	Infinity.BDO.Lua.Execute(code)

	-- Delayed Resetting Inventory filter
	local task = MagLib.Run.Tasks.Task(1000, 50)
	task.run = MagLib.BDO.Inventory.resetFilter
	task.name = "ResetInventoryFilter Task"
	task:start()
	MagLib.Run.Tasks.Handler.addTask(task)
end

MagLib.BDO.Enhance = Enhance
