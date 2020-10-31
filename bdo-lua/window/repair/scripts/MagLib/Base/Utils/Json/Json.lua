MagLib.Utils.Json = {}

local userdatas = {}

userdatas.Vector3 = {
	keys = {"X", "Y", "Z", "getDistance", "getDistance2D"},

	serialize = function(vector)
		return {X = vector.X, Y = vector.Y, Z = vector.Z}
	end,

	deserialize = function(t)
		return Vector3(t.X, t.Y, t.Z)
	end
}

userdatas.ImVec4 = {
	keys = {"x", "y", "z", "w"},

	---@param vec4 ImVec4
	serialize = function(vec4)
		return {x = vec4.x, y = vec4.y, z = vec4.z, w = vec4.w}
	end,

	deserialize = function(t)
		return ImVec4(t.x, t.y, t.z, t.w)
	end
}

-- Be sure this is last since this is most general one
userdatas.ImVec2 = {
	keys = {"x", "y"},

	serialize = function(vec2)
		return {x = vec2.x, y = vec2.y}
	end,

	deserialize = function(t)
		return ImVec2(t.x, t.y)
	end
}

MagLib.Utils.Json.addUserdataHandler = function(key, handler)
	userdatas[key] = handler
end

local tableObjects = {}

-- Recursive deserialization
MagLib.Utils.Json.deserialize = function(raw)
	if not raw then
		return {}
	end

	local data = {}

	for k, v in pairs(raw) do
		if type(k) == "string" then
			-- Checking if it is only a number, in which case we load it as a number
			if k:match("^[0-9]*$") then
				k = tonumber(k)
			end
		end
		local vType = type(v)
		if vType == "number" or vType == "string" or vType == "boolean" then
			-- If it is a number or a string or a boolean, then we can just copy it
			data[k] = v
		elseif vType == "table" then
			local serializationType = v.serializationType
			local serializedFrom = v.serializedFrom
			if serializationType then
				-- A table we serialized from a userdata object or tableObject
				if serializedFrom == "Userdata" then
					data[k] = userdatas[serializationType].deserialize(v)
				elseif serializedFrom == "TableObject" then
					data[k] = tableObjects[serializationType].deserialize(v)
				end
			else
				-- A normal table
				data[k] = MagLib.Utils.Json.deserialize(v)
			end
		end

	end

	return data
end

-- Recursive serialization
MagLib.Utils.Json.serialize = function(t)
	local raw = {}
	for k, v in pairs(t) do
		local vType = type(v)
		if vType == "number" or vType == "string" or vType == "boolean" then
			-- If it is a number or a string or a boolean, then we can just copy it
			raw[k] = v
		elseif vType == "table" then
			-- First we check if it is a tableObjects, else we just recursivly serialize
			local isNormalTable = true
			for serializationType, oInfo in pairs(tableObjects) do
				-- Check if it is the right object infos
				local isRightObject = true
				for _, key in pairs(oInfo.keys) do
					if not v[key] then
						isRightObject = false
						break
					end
				end

				-- If it is the right infos
				if isRightObject then
					-- Serialize it and get out of the loop
					isNormalTable = false
					raw[k] = oInfo.serialize(v)
					break
				end
			end

			if isNormalTable then
				raw[k] = MagLib.Utils.Json.serialize(v)
			end
		elseif vType == "userdata" then
			-- Iterate over all userdatas
			for serializationType, userdataInfo in pairs(userdatas) do
				-- Check if it is the right userdata infos
				local isRightUserdata = true
				for _, key in pairs(userdataInfo.keys) do
					if not v[key] then
						isRightUserdata = false
						break
					end
				end

				-- If it is the right infos
				if isRightUserdata then
					-- Serialize it and get out of the loop
					raw[k] = userdataInfo.serialize(v)
					raw[k].serializationType = serializationType
					raw[k].serializedFrom = "Userdata"
					break
				end
			end
		end
	end

	return raw
end

MagLib.Utils.Json.saveTableToJsonFile = function(filePath, table, isAbsolute)
	Infinity.FileSystem.WriteFile(filePath, JSON:encode_pretty(MagLib.Utils.Json.serialize(table)), isAbsolute)
end

MagLib.Utils.Json.loadTableFromJsonFile = function(filePath, isAbsolute)
	local jsonString = Infinity.FileSystem.ReadFile(filePath, isAbsolute)
	return MagLib.Utils.Json.deserialize(JSON:decode(jsonString))
end
