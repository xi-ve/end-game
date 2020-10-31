local dumpString = MagLib.Utils.Encryption.exchangeCharWithByte
local trashTable = {
	"Game", "???", "Infinity", "MagLib", "Navigation", "tmp", "moveTo", "loadstring", "crash__", "Tampering Detected!",
 "blockACPacket", "Obfuscation", "Login", "Password", "authServer", "authServerPort", "authServerIp", "and", "break",
 "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return",
 "then", "true", "until", "while", "+", "-", "*", "/", "%", "^", "#", "==", "~=", "<=", ">=", "<", ">", "=", "()", ")",
 "{}", "}", "[", "]", ";", ":", ",", ".", "..", "...", "get", "set", "code", "execute", "DEBUG"
}

MagLib.Utils.Encryption.Lua.generateTrashHeader = function()
	local header = ""
	for i = 1, 100 do
		header = header .. "local var" .. string.rep("_", i) .. " = {} \n"
	end
	return header
end

MagLib.Utils.Encryption.Lua.generateTrashCode = function()
	local x = math.random(1, #trashTable)
	local randomName = trashTable[x]
	local mode = math.random(1, 3)
	if mode == 1 then
		return table.concat{
			"var", string.rep("_", math.random(5, 30)), " = ", "tostring(var____[#var____ - " .. x .. "]) .. ",
   "tostring('" .. dumpString("load(\"return " .. randomName .. "\")()") .. "')", "\n"
		}
	elseif mode == 2 then
		return table.concat{"var", string.rep("_", math.random(5, 30)), " = var____[", math.random(1, 31), "]\n"}
	else
		return table.concat{"local var", ("_"):rep(math.random(101, 300)), " = ", '"' .. dumpString(randomName) .. '"', "\n"}
	end
end

MagLib.Utils.Encryption.Lua.addTrashCode = function(originalCode)

end
