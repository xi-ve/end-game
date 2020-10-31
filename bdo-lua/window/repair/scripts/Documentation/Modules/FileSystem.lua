Infinity.FileSystem = {}

---Writes a string to a file, overriding the previous content. Supports both relative paths to the scripts root path and absolute paths. isAbolutePath is false by default.
---@param filePath string
---@param content string
---@param isAbolutePath boolean
function Infinity.FileSystem.WriteFile(filePath, content, isAbolutePath)
end
---Writes a ByteBuffer's content to a file, overriding the previous content. Supports both relative paths to the scripts root path and absolute paths. isAbolutePath is false by default.
---@param filePath string
---@param data ByteBuffer
---@param[opt=false] isAbolutePath boolean
function Infinity.FileSystem.WriteBinaryFile(filePath, data, isAbolutePath)
end

---Returns the content of a file as a string. Supports both relative paths to the scripts root path and absolute paths. isAbolutePath is false by default.
---@param filePath string
---@param isAbolutePath boolean
function Infinity.FileSystem.ReadFile(filePath, isAbolutePath)
end

---Returns paths all files pathing a search mask path. A valid path for example would be "C:\\Users\\user\\Desktop\\ReffSucks\\*.json". isAbolutePath is false by default.
---@param searchMask string
---@param isAbolutePath boolean
---@return table<number, string> filePaths
function Infinity.FileSystem.GetFiles(searchMask, isAbolutePath)
end

---Returns all files in a directory per deep recursion (so including subfolders). isAbolutePath is false by default.
---@param directoryPath string
---@param isAbolutePath boolean
function Infinity.FileSystem.GetAllFiles(directoryPath, isAbolutePath)
end
