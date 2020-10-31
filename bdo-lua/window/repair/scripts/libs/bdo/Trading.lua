Trading = {}

function Trading.sellAll()
	local code = 
	[[
		local inventory = getSelfPlayer():get():getInventory()
  		local s64_inventoryItemCount = toInt64(0, 0)
  		local s64_TradeItemNo = toInt64(0, 0)
		local myInventortySellAbleCount = npcShop_getSellCount()
  		
  		for ii = 0, myInventortySellAbleCount do
    		local shopItemWrapper = npcShop_getItemSell(ii)

    		if nil ~= shopItemWrapper then
      			local tradeType = shopItemWrapper:getStaticStatus():get()._tradeType
      			s64_TradeItemNo = npcShop_getItemNo(ii)
      			s64_inventoryItemCount = inventory:getItemCountByItemNo_s64(s64_TradeItemNo)

      			if tradeType ~= 5 then        			       			
        			npcShop_doSellInTradeShop(ii, Int64toInt32(s64_inventoryItemCount), 0, 0)
      			end
    		end
  		end
	]]

	Infinity.BDO.Lua.Execute(code)
end