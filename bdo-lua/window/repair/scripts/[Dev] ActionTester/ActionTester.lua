ActionTester = { }
ActionTester.Running = false

ActionTester.Cache_Actions = {}
ActionTester.Queue_Actions = {}
ActionTester.Queue_CurrentIndex = 0

function ActionTester.Start()
  ActionTester.Running = true	    
end

function ActionTester.Stop()
  ActionTester.Running = false  
end

function ActionTester.OnPulse()
  if ActionTester.Running == false then
    return
  end 
end

function ActionTester.peekNextQueueIndex()	
	if ActionTester.Queue_CurrentIndex >= table.length(ActionTester.Queue_Actions) then
		return 1
	end

	return ActionTester.Queue_CurrentIndex + 1
end

function ActionTester.getNextQueueIndex()
	ActionTester.Queue_CurrentIndex = ActionTester.Queue_CurrentIndex + 1

	if ActionTester.Queue_CurrentIndex >= table.length(ActionTester.Queue_Actions) then
		ActionTester.Queue_CurrentIndex = 1
	end

	return ActionTester.Queue_CurrentIndex
end

function ActionTester.processQueue(action)
	
	local nextIndex = ActionTester.getNextQueueIndex()
	local peekIndex = ActionTester.peekNextQueueIndex()	

	if action == ActionTester.Queue_Actions[nextIndex].Name then
		
		Infinity.BDO.ActionBranchManager.queueNextAction(ActionTester.Queue_Actions[peekIndex].Branch)
	end
end

function ActionTester.OnSelfActionChanged(action)
	
	if not ActionTester.hasCachedAction(action) then		
		
		table.insert(ActionTester.Cache_Actions, {Name = action, Branch = Infinity.BDO.ActionBranchManager.getPCPackageRaw_ActionBranch_ByName(action)})
	end

	if table.length(ActionTester.Queue_Actions) > 0 then
		ActionTester.processQueue(action)   
	end
end

function ActionTester.hasCachedAction(action)

	for k,actionObject in pairs(ActionTester.Cache_Actions) do
		
		if actionObject.Name == action then
			return true
		end
	end

	return false;
end

function ActionTester.OnGuiDraw()
	MainWindow.DrawMainWindow()
end