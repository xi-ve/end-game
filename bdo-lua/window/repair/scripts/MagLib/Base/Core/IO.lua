-- @module MagLib.Core.IO
MagLib.Core.IO = {}

MagLib.Core.IO.fileNonEmpty = function(path, isAbsolutePath)
	local content = Infinity.FileSystem.ReadFile(path, isAbsolutePath)
	return content ~= "" and content ~= nil
end

---Returns the extension of a file as a string
---@param filePath path to file 
-- @return string Extension
MagLib.Core.IO.getFileExtension = function(filePath)
	local pathLen = filePath:len()
	for i = pathLen, 1, -1 do
		local char = filePath:sub(i, i)
		if char == '.' then
			return filePath:sub(i + 1, pathLen)
		end
		if char == "\\" or char == "/" then
			return ""
		end
	end
end

---Returns the name of a file as a string
---@param filePath path to file 
-- @return string fileName
MagLib.Core.IO.getFileName = function(filePath)
	local pathLen = filePath:len()
	local extensionBeginIndex = -1
	for i = pathLen, 0, -1 do
		local char
		if i > 0 then
			char = filePath:sub(i, i)
			if char == '.' then
				extensionBeginIndex = i
			end
		end
		if extensionBeginIndex ~= -1 and (i == 0 or char == "\\" or char == "/") then
			return filePath:sub(i + 1, extensionBeginIndex - 1)
		end
	end
end

MagLib.Core.IO.loadLua = function(filePath, isAbsolute)
	local code = Infinity.FileSystem.ReadFile(filePath, isAbsolute)
	if (code == nil) then
		print("ERROR: Could not load lua code from " .. filePath)
	end
	local func, error = load(code)
	if error then
		print("ERROR: Error while reading lua code from " .. filePath .. "\n Error Message: " .. tostring(error))
	end
	return func()
end

--[[
Return an (absolute or relative) path of a script folder
]]
MagLib.Core.IO.findScriptFolder = function(folderName, wantAbsolute)

end

MagLib.Core.IO.deleteAllFiles_deep = function(filePath)
	local code = [[rmdir "]] .. filePath .. [[" / s / q]]
	os.execute(code)
end

MagLib.Core.IO.copyFile = function(from, to, useOS)
	-- Read the file as bytebuffer
	if useOS then
		os.execute("xcopy \"" .. from .. "\" \"" .. to .. "\"")
	else
		local bb = ByteBuffer()
		bb:fromFile(from)
		-- write bytebuffer to file
		Infinity.FileSystem.WriteBinaryFile(to, bb, true)
	end
end

MagLib.Core.IO.readSpecificLine = function(filePath, lineNumber)
	local content = Infinity.FileSystem.ReadFile(filePath)
	local count = 0
	for line in content:gmatch("([^\r\n]*)[\r\n]") do
		count = count + 1
		if count == lineNumber then
			return line
		end
	end

	return nil
end

MagLib.Core.IO.forEveryFileInDirectory = function(directory, func)
	local files = Infinity.FileSystem.GetAllFiles(directory, true)
	for _, file in pairs(files) do
		func(file)
	end
end

MagLib.Core.IO.existsDirectory = function(absoluteDirectoryPath)
	local fileHandle, strError = io.open(absoluteDirectoryPath .. "\\*.*", "r")
	if fileHandle ~= nil then
		io.close(fileHandle)
		return true
	else
		if string.match(strError, "No such file or directory") then
			return false
		else
			return true
		end
	end
end
