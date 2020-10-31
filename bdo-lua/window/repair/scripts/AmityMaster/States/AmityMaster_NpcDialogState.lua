--[[

Logic for handling buy requests and starting new conversations

]]--

AmityMaster_NpcDialogState = { }

function AmityMaster_NpcDialogState.OnPulse() 

	local amity = tonumber(Infinity.BDO.Lua.Execute(
		[[
		local _intimacyProgressBG = UI.getChildControl(Panel_Npc_Dialog, "Static_ProgressBG")
		local _intimacyFruitageValue = UI.getChildControl(_intimacyProgressBG, "StaticText_Fruitage_Value")
		
		return _intimacyFruitageValue:GetText()
		]]))
	if amity > AmityMaster.profile.requiredAmity then
	
	
		if not AmityMaster.profile.buyItem then -- Stop the bot since we've reached the required amity value
			AmityMaster.Stop("Reached required amity value")
			return true
		end
		
		
		-- Check if shop is open, if not, open the shop and wait a little
		local shopOpen = Infinity.BDO.Lua.Execute("return Panel_Window_NpcShop:GetShow()")
		if not shopOpen then
		
			Infinity.BDO.Lua.Execute("npcShop_requestList()")
			AmityMaster.Wait(0.25)
			return true
			
		else 
		
			-- Get item index in shop
			local itemIndex = AmityMaster_NpcDialogState.GetShopItemIndexByName(AmityMaster.profile.buyItemName)
			if itemIndex == nil then 
				AmityMaster.Stop("Can't find " .. tostring(AmityMaster.profile.buyItemName) .. " in shop")
				return true
			end
			
			-- Check whether to use warehouse money
			local useWarehouseMoney = ternary(AmityMaster.profile.useWarehouseMoney, 2, 0)
			-- Buy the item and wait
			Infinity.BDO.Lua.Execute("npcShop_doBuy(" .. itemIndex .. ", 1, " .. useWarehouseMoney .. ", 0)")
			AmityMaster.Wait(0.25)
			return true
			
		end
		
		
	else 
	
		-- Start next conversation and wait
		AmityMaster_NpcDialogState.StartNewConversation()
		AmityMaster.Wait(0.25)
		return true
	
	end
	
end

function AmityMaster_NpcDialogState.GetShopItemIndexByName(itemName)

	for i = 0, NpcShop.BuyItemCount - 1 do
        local item = NpcShop.GetBuyItemByIndex(i)
        if item.ItemEnchantStaticStatus.Name == itemName then
            return i
        end
    end
    return nil

end

function AmityMaster_NpcDialogState.StartNewConversation()

	Infinity.BDO.Lua.Execute(	
	"local dialogData = ToClient_GetCurrentDialogData() " ..
	"local buttonIndex = nil " ..
	"for i = 0, 5 do " ..
		"local btn = dialogData:getFuncButtonAt(i) "..
		"local type = tonumber(btn._param) " ..
		"if type == CppEnums.ContentsType.Contents_IntimacyGame then " .. 
			"buttonIndex = i "..
			"break " ..
		"end " ..
	"end " ..
	"HandleClickedFuncButton(buttonIndex) "
	)

end