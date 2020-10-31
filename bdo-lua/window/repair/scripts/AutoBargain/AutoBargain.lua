AutoBargain = { }
AutoBargain.Running = false

AutoBargain.TradeGame_Started = false
AutoBargain.TradeGame_NextDice = 1

AutoBargain.Task_NextFrame = nil
AutoBargain.Task_NextFrameSkip = 0

function AutoBargain.Start()
  AutoBargain.Running = true	    
end

function AutoBargain.Stop()
  AutoBargain.Running = false  
end

function AutoBargain.OnPulse()
  if AutoBargain.Running == false then
    return
  end  

  if AutoBargain.Task_NextFrame ~= nil then

  	if AutoBargain.Task_NextFrameSkip == 0 then
  		AutoBargain.Task_NextFrameSkip = 1
  		return
  	end

  	if AutoBargain.Task_NextFrameSkip == 1 then

  		AutoBargain.Task_NextFrameSkip = 0

  		AutoBargain.Task_NextFrame()
  		AutoBargain.Task_NextFrame = nil
  	end
  end
end

function AutoBargain.OnRenderD2D()
end

function AutoBargain.OnGuiDraw()
end

function AutoBargain.TradeGame_CanStart()
	local code =
	[[
		return getSelfPlayer():getWp() >= 5
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function AutoBargain.TradeGame_Start()
	local code =
	[[
		local talker = dialog_getTalker()

  		if nil == talker then
    		return false
  		end

		ToClient_TradeGameStart(talker:getActorKey())

		return true
	]]

	return Infinity.BDO.Lua.Execute(code)
end

function AutoBargain.TradeGame_Dice(vDice)
	local code =
	[[		
		ToClient_TradeGameDice(]] .. vDice .. [[)
	]]

	Infinity.BDO.Lua.Execute(code)
end

function AutoBargain.TradeGame_GetNextDice()
	if AutoBargain.TradeGame_NextDice == 0 then
		AutoBargain.TradeGame_NextDice = 1
	else
		AutoBargain.TradeGame_NextDice = 0
	end

	return AutoBargain.TradeGame_NextDice
end

function AutoBargain.On_FromClient_DialogFunctionClick_Contents_Shop(args)
	AutoBargain.TradeGame_Started = false
end

function AutoBargain.On_FromClient_MarketItemList_All_UpdateItemList(args)
	if not AutoBargain.TradeGame_Started then

		if not AutoBargain.TradeGame_CanStart() then
			print("Cant start TradeGame. Low on Energy!")
			return
		end

		if not AutoBargain.TradeGame_Start() then
			print("Failed to start TradeGame")
		end
	end
end

function AutoBargain.On_FromClient_TradeGameStart(args)
	AutoBargain.TradeGame_Started = true

	AutoBargain.TradeGame_Dice(AutoBargain.TradeGame_GetNextDice())
end

function AutoBargain.On_FromClient_TradeGameResult(args)
	local isSuccess = args[1]

	if isSuccess == "true" then
		print("Succeeded!")
	else
		print("Failed! Restatring TradeGame.")

		if not AutoBargain.TradeGame_CanStart() then
			print("Cant start TradeGame. Low on Energy!")
			return
		end

		AutoBargain.Task_NextFrame = AutoBargain.TradeGame_Start
	end
end

function AutoBargain.On_FromClient_TradeGameReciveDice(args)
	AutoBargain.TradeGame_Dice(AutoBargain.TradeGame_GetNextDice())
end