local s_isEmpty = MagLib.Utils.Strings.isEmpty
local doubleSquareBrackets = string.rep(string.char(91), 2)
local doubleSquareBracketsClose = string.rep(string.char(93), 2)
MagLib.Utils.Encryption.Lua.randomizeComments = function(code)
	-- First doing single line comments
	local newCode = ""

	for line in code:gmatch("([^\r\n]*)[\r\n]") do
		if not s_isEmpty(line) then
			local firstRealChar = nil
			for i = 1, string.len(line) do
				local char = line:sub(i)
				if not table.find(MagLib.Utils.Strings.spaceBytes, string.byte(char)) then
					firstRealChar = i
					break
				end
			end

			if firstRealChar ~= nil then
				local firstTwoChars = line:sub(firstRealChar, firstRealChar + 1)
				if firstTwoChars == "--" then
					local thirdFourthChars = line:sub(firstRealChar + 2, firstRealChar + 3)
					if thirdFourthChars ~= doubleSquareBrackets then
						local preString = ""
						if firstRealChar ~= 1 then
							preString = line:sub(1, firstRealChar)
						end
						line = preString .. "--" .. MagLib.Utils.Strings.unrandomString(string.len(line))
					end
				end
			end
		end

		newCode = newCode .. line .. "\n"
	end

	-- Now we iterate over newCode searching for multiline comments

	local returnCode = ""
	local inMultiLineComment = false
	for line in newCode:gmatch("([^\r\n]*)[\r\n]") do
		local firstRealChar = nil
		for i = 1, string.len(line) do
			local char = line:sub(i)
			if not table.find(MagLib.Utils.Strings.spaceBytes, string.byte(char)) then
				firstRealChar = i
				break
			end
		end

		if firstRealChar ~= nil then
			local preString = ""
			if firstRealChar ~= 1 then
				preString = line:sub(1, firstRealChar)
			end

			local firstTwoChars = line:sub(firstRealChar, firstRealChar + 1)
			local thirdFourthChars = line:sub(firstRealChar + 2, firstRealChar + 3)

			if not inMultiLineComment then
				-- Only searching for multiline comment start
				if (firstTwoChars .. thirdFourthChars) == "--" .. doubleSquareBrackets then
					inMultiLineComment = true
					line = preString .. "--" .. doubleSquareBrackets .. " " .. MagLib.Utils.Strings.unrandomString(string.len(line))
				end
			else
				-- Currently in MultilineComment
				local commentEnded = line:find(doubleSquareBracketsClose)
				local postString = ""
				if commentEnded ~= nil then
					postString = doubleSquareBracketsClose
					inMultiLineComment = false
				end
				line = preString .. MagLib.Utils.Strings.unrandomString(string.len(line)) .. postString
			end
		end

		returnCode = returnCode .. line .. "\n"
	end
	return returnCode
end
