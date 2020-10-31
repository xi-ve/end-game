MagLib.Utils.Encryption.Lua = {}
MagLib.Utils.Encryption.Lua.encryptRunableString = function(string)
	local func = load(string)
	if func == nil then
		print("Error encrypting runable string. Seems like the given string is not valid lua code")
		return ""
	end
	return "return load('" .. MagLib.Utils.Encryption.exchangeCharWithByte(string.dump(func)) .. "')()"
end

MagLib.Utils.Encryption.Lua.encryptAllFiles_Deep = function(folderPath, outputFolder, fileBlacklist)
	if fileBlacklist == nil then
		fileBlacklist = {}
	end
	local allFiles = Infinity.FileSystem.GetAllFiles(folderPath, true)
	local count = #allFiles
	local doneCount = 1

	-- Sorting table by string length
	local function cmp(a, b)
		return string.len(a) < string.len(b)
	end
	table.sort(allFiles, cmp)

	-- Getting a list of folders and creaing folder structure before hand
	local outputFolders = {}

	for k, path in pairs(allFiles) do
		local relativePath = string.gsub(path, folderPath, "")
		local outputPath = outputFolder .. relativePath
		local tmp = MagLib.Utils.Strings.split(outputPath, "\\")
		local outputFolderPath = string.gsub(outputPath, tmp[#tmp], "")
		if not table.find(outputFolders, outputFolderPath) then
			table.insert(outputFolders, outputFolderPath)
		end
	end

	print("Creating " .. #outputFolders .. " folders to recreate original file structure!")
	for k, path in ipairs(outputFolders) do
		os.execute("if not exist \"" .. path .. "\" mkdir \"" .. path .. "\"")
	end

	print("Beginning to encrypting the files.")
	local taskFunc = function()
		if #allFiles == 0 then
			print("Finished!")
			return true
		end
		local filePath = allFiles[1]

		print(doneCount .. "/" .. count .. " : " .. filePath)
		local relativePath = string.gsub(filePath, folderPath, "")
		local outputPath = outputFolder .. relativePath

		if string.find(filePath, ".lua") ~= nil and not table.find(fileBlacklist, filePath) then
			-- File
			local content = MagLib.Utils.Encryption.Lua.encryptRunableString(Infinity.FileSystem.ReadFile(filePath, true))
			if MagLib.Utils.Strings.isEmpty(content) then
				print("ERROR: Failed getting encrypted code. File does not seem to be a working lua file. Copying original file!")
				MagLib.Core.IO.copyFile(filePath, outputPath)
			else
				print("Writing to output File!")
				Infinity.FileSystem.WriteFile(outputPath, content, true)
			end
		else
			-- Just create a direct copy
			print("Copying file over since it is not a lua file!")
			MagLib.Core.IO.copyFile(filePath, outputPath)
		end

		doneCount = doneCount + 1
		table.remove(allFiles, 1)
		return false

	end
	local encryptTask = MagLib.Run.Tasks.new("EncryptLuaAllFiles_Deep", 9999999999, taskFunc)
end
