local Strings = {}
Strings.spaceBytes = {0, 10, 11, 13, 32}
local hexColorChars = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}

Strings.split = function(s, sep)
	local tmp = {}
	local done = false
	while not done do
		local sepIndex = s:find(sep)
		if sepIndex ~= nil then
			table.insert(tmp, s:sub(0, sepIndex - 1))
			if s:len() == sepIndex then -- Sep is last char, just end
				done = true
			else
				s = s:sub(sepIndex + 1)
			end
		else
			table.insert(tmp, s)
			done = true
		end
	end

	s = nil
	sep = nil
	return tmp
end

Strings.splitRegex = function(s, d)
	local t = {}
	local i = 0
	local f
	local match = '(.-)' .. d .. '()'

	if string.find(s, d) == nil then
		return {s}
	end

	for sub, j in string.gmatch(s, match) do
		i = i + 1
		t[i] = sub
		f = j
	end

	if i ~= 0 then
		t[i + 1] = string.sub(s, f)
	end

	return t
end

Strings.isEmpty = function(s)
	return s == "" or s == nil or s == " "
end

Strings.trimRight = function(s, amount)
	return s:sub(1, s:len() - amount)
end

Strings.trimLeft = function(s, amount)
	return s:sub(1 + amount, s:len())
end

Strings.unrandomString = function(minLength)
	local r = ""
	for i = 1, math.random(minLength, minLength * 50) do
		local x = math.random(1, 100)
		if x < 20 then
			r = r .. string.char(math.random(32, 90))
		elseif x < 75 then
			r = r .. string.char(math.random(94, 126))
		else
			r = r .. string.char(math.random(128, 255))
		end
	end
	return r
end

Strings.toASCIINumber = function(c)
	if (c:len() ~= 1) then
		print("MagLib.Utils.Strings.toASCIINumber called with string of length " .. c:len())
		return -1
	end

	return string.byte(c)
end

Strings.isASpecialCharacter = function(c)
	if (c:len() ~= 1) then
		print("MagLib.Utils.Strings.isASpecialCharacter called with string of length " .. c:len())
		return true
	end

	local cNumber = MagLib.Utils.Strings.toASCIINumber(c)
	local isNumberChar = (cNumber > 47 and cNumber < 58)
	local isCapitalChar = (cNumber > 64 and cNumber < 91)
	local isSmallChar = (cNumber > 96 and cNumber < 123)

	return not (isNumberChar or isCapitalChar or isSmallChar)
end
MagLib.Utils.Strings = Strings
