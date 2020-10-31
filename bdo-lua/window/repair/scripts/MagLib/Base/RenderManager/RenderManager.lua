MagLib.RenderManager = {}

local modules = {}
MagLib.RenderManager.addModule = function(module)
	table.insert(modules, module)
end

MagLib.RenderManager.removeModule = function(module)
	local toRemoveIndex
	for _, v in pairs(modules) do
		if v == module then
			toRemoveIndex = k
			break
		end
	end

	if toRemoveIndex ~= nil then
		table.remove(modules, toRemoveIndex)
		return true
	end

	return false
end

MagLib.RenderManager.onRenderD2D = function()
	for _, v in pairs(modules) do
		if v.active then
			v.render()
		end
	end
end
