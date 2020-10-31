MagLib.Core.Try = function(f, catch_f, suppressError)
	local status, res = pcall(f)
	if not status then
		if not suppressError then
			print("Error: " .. tostring(res))
		end

		if catch_f then
			catch_f(res)
		end
	else
		return res
	end
end
