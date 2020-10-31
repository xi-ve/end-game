MagLib.Core.Scripting = {}
MagLib.Core.Scripting.isScriptLoaded = function(scriptName)
	local script = Infinity.Scripting.GetScript(scriptName)
	if script == nil then
		return false
	end
	return script.IsRunning
end

MagLib.Core.Scripting.executeIn = function(scriptName, code)
	local script = Infinity.Scripting.GetScript(scriptName)
	if script.IsRunning == false then
		print("Starting " .. scriptName .. " since it is not started!")
		script:Start()
	end
	local thisScript = Infinity.Scripting.CurrentScript

	return thisScript:LuaExec(script, code)
end
