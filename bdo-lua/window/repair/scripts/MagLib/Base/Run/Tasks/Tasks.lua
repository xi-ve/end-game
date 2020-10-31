MagLib.Run.Tasks = {}

function MagLib.Run.Tasks.onPulse_Beginning()
	MagLib.Run.Tasks.Handler.onPulse_Beginning()
end

function MagLib.Run.Tasks.onPulse_End()
	MagLib.Run.Tasks.Handler.onPulse_End()
end

function MagLib.Run.Tasks.new(name, timeout, func)
	local task = MagLib.Run.Tasks.Task(timeout, 0);
	task.run = func
	task.name = name
	task:start()

	MagLib.Run.Tasks.Handler.addTask(task)
	return task
end

function MagLib.Run.Tasks.newDelayed(name, timeout, func, delay)
	local task = MagLib.Run.Tasks.Task(timeout, delay);
	task.run = func
	task.name = name
	task:start()

	MagLib.Run.Tasks.Handler.addTask(task)
	return task
end
