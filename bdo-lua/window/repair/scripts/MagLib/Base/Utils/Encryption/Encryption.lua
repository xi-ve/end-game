MagLib.Utils.Encryption = {}
MagLib.Utils.Encryption.exchangeCharWithByte = function(s)
	local len = string.len(s)
	local hex = ""

	for i = 1, len do
		local ord = string.byte(s, i)
		hex = hex .. "\\" .. ord
	end

	return hex
end
