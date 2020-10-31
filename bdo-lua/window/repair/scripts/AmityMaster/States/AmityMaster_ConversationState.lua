--[[

Logic for handling the amity minigame

]]--

AmityMaster_ConversationState = { }

local delayed_stage3to4 = false
local addedPlayCount = false

-- Each if-block of code in this function represents a gamestate. Only one block will be executed every call.
function AmityMaster_ConversationState.OnPulse() 


	-- Get required identifiers for gameState
	local comment2Active = Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGame_Base, \"StaticText_Comment_2\"):GetShow()")
	local applyButtonActive = Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGame_Right, \"Button_Apply_New\"):GetShow()")
	local gameEndButtonActive = Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGame_Base, \"Button_GameEnd\"):GetShow()")
	local centerPanelActive = Infinity.BDO.Lua.Execute("return Panel_MentalGame_Center:GetShow()")

	
	-- Check if game finished (end dialog with amity earned, etc...)
	if centerPanelActive then
		-- Do nothing (except increase playcount)
		if not addedPlayCount then
			AmityMaster.playCount = AmityMaster.playCount + 1 -- Add playCount
			addedPlayCount = true
		end
		return true
	end			
	
	
	-- Check if conversation ended (different from finished)
	if gameEndButtonActive then
		
		-- Continue with next conversation or finish
		
		if not delayed_stage3to4 then
			AmityMaster.Wait(0.25)
			delayed_stage3to4 = true
			return true
		end
		
		local continueButtonShown = Infinity.BDO.Lua.Execute("return UI.getChildControl(Panel_MentalGame_Base, \"Button_TryAgain\"):GetShow()")
		if continueButtonShown then
			Infinity.BDO.Lua.Execute("MentalKnowledge_TryAgain_LClick()")
		else
			Infinity.BDO.Lua.Execute("MentalKnowledge_GameEnd_LClick()")
		end
		AmityMaster_ConversationState.ResetLocalVariables()
		AmityMaster.subPlayCount = AmityMaster.subPlayCount + 1 -- Add subPlayCount
		AmityMaster.Wait(0.25)
		return true
		
	end
	
	
	-- Check if waiting
	if (not comment2Active) and (not applyButtonActive) and (not gameEndButtonActive) then
		-- Do nothing
		return true
	end
	
	
	-- Check if apply button shown
	if applyButtonActive then
		-- Press apply button
		Infinity.BDO.Lua.Execute("MentalKnowledge_Apply_LClick()")
		AmityMaster.Wait(0.25)
		return true
		
	end
	
	
	-- Check if there are empty slots (comment2 shown)
	if comment2Active then
		
		local goalType = tonumber(Infinity.BDO.Lua.Execute("return getMentalgameObject():getGoalType()"))
		if goalType == 4 then -- 4 is failed sparks == failed sparks consecutive
			AmityMaster_ConversationState.EnterNPCs(AmityMaster.profile.lose)
		else
			AmityMaster_ConversationState.EnterNPCs(AmityMaster.profile.win)
		end
		return true
		
	end
	
	
	AmityMaster.Stop("Unknown conversation game state reached")

	
end

function AmityMaster_ConversationState.ResetLocalVariables() 

	delayed_stage3to4 = false
	addedPlayCount = false

end

function AmityMaster_ConversationState.EnterNPCs(knowledgeComboNames) -- You need to call this n amount of times, where n is the length of the combo

	-- Get all the available knowledge strings
	local knowledgeCount = tonumber(Infinity.BDO.Lua.Execute("return getMentalgameObject():getCardCount()"))
	local availableKnowledge = {}
	for i = 1, knowledgeCount do
		availableKnowledge[i] = Infinity.BDO.Lua.Execute("return getMentalgameObject():getCard(" .. i - 1 .. "):getName()")		
	end
	
	local filledSlotCount = tonumber(Infinity.BDO.Lua.Execute("return getMentalgameObject():getFilledSlotCount()"))
	
	-- Find index of next knowledge piece that needs to be slotten and click it
	for i = 1, #availableKnowledge do
		if knowledgeComboNames[filledSlotCount + 1] == availableKnowledge[i] then
			Infinity.BDO.Lua.Execute("MentalKnowledge_OnRDown_Card(" .. i - 1 .. ")")				
			AmityMaster.Wait(0.25)
			return true
		end
	end
	
	AmityMaster.Stop("Knowledge not found: " .. knowledgeComboNames[filledSlotCount + 1])	
	
end