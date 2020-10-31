--[[

Delegates OnPulse to the correct state

]]--

AmityMaster = { }

AmityMaster.profile = nil
AmityMaster.settings = nil

AmityMaster.isRunning = false

AmityMaster.playCount = 0
AmityMaster.subPlayCount = 0
AmityMaster.limitByPlayCount = false
AmityMaster.limitBySubPlayCount = false
AmityMaster.requiredPlayCount = 0
AmityMaster.requiredSubPlayCount = 0

local timer = nil

function AmityMaster.OnAutoLoginAutoLoad() 
	
end

function AmityMaster.OnPulse() 

	if (timer ~= nil) and (not timer:Expired()) then
		return true
	end

	if AmityMaster.isRunning then
	
		-- End bot if there is a limit on playcount
		if AmityMaster.limitBySubPlayCount and (AmityMaster.subPlayCount >= AmityMaster.requiredSubPlayCount) then
			AmityMaster.Stop("Reached required subPlayCount of " .. tostring(AmityMaster.requiredSubPlayCount))
			return true
		end
		
		if AmityMaster.limitByPlayCount and (AmityMaster.playCount >= AmityMaster.requiredPlayCount) then
			AmityMaster.Stop("Reached required playCount of " .. tostring(AmityMaster.playCount))
			return true
		end
		--
	
		-- Stop bot if no profile is loaded
		if AmityMaster.profile == nil then
			AmityMaster.Stop("No profile loaded")
			return true
		end
		
		-- Stop bot if not enough energy and not in minigame
		local inMentalGame = Infinity.BDO.Lua.Execute("return isShow_MentalGame()") 
		local curEnergy = tonumber(Infinity.BDO.Lua.Execute("return getSelfPlayer():getWp()"))
		if (not inMentalGame) and (curEnergy < 6) then
			AmityMaster.Stop("Not Enough Energy")
			return true
		end

		-- Stop bot if (over-weight or inventory full) and buyItem is true
		if AmityMaster.profile.buyItem then			
			if not LocalPlayer.hasFreeWeight() then
				AmityMaster.Stop("At or over 100% weight")
				return true
			end
			
			if Inventory.getFreeSlotCount() < 1 then
				AmityMaster.Stop("Not enough free space")
				return true
			end
		end
		
		-- Check if in Amity minigame
		if inMentalGame then
			AmityMaster_ConversationState.OnPulse()
			return true
		end
		
		-- Check if in dialog with NPC
		
		if Infinity.BDO.Lua.Execute("return dialog_isTalking()") then
			AmityMaster_NpcDialogState.OnPulse()
			return true
		end
	
		-- If not, stop bot
		AmityMaster.Stop("Not interacting with NPC")
	
	end

end

function AmityMaster.Start() 

	print("Starting AmityMaster!")
	AmityMaster.isRunning = true
	AmityMaster_ConversationState.ResetLocalVariables() 
	AmityMaster.ResetPlayCount()

end

function AmityMaster.Stop(reason)

	if reason == nil then reason = "" end
	print("Stopping AmityMaster! (" .. reason .. ")")
	AmityMaster.isRunning = false
	AmityMaster.limitByPlayCount = false
	AmityMaster.limitBySubPlayCount = false

end

function AmityMaster.Wait(seconds) 

	timer = Timer(seconds * AmityMaster.settings.delayMultiplier)
	timer:Start()

end

function AmityMaster.GetNpcName() 

	return Infinity.BDO.Lua.Execute("return UI.getChildControl( Panel_Npc_Dialog, \"Static_NPC_Name\" ):GetText()")
	
end

function AmityMaster.ResetPlayCount() 

	AmityMaster.playCount = 0
	AmityMaster.subPlayCount = 0

end