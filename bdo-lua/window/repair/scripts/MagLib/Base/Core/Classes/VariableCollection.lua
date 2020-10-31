-- Collection of variable to be converted to bytebuffers reliably and consistently.
local indexCounter = 0

MagLib.Core.VariableCollection = function()
	indexCounter = indexCounter + 1
	local collection = {index = indexCounter, variables = {}}

	collection.addString = function(name, byteSize, initValue, position)
		collection.variables[position] = {name = name, type = "String", byteSize = byteSize, value = nil}
		if initValue ~= nil then
			collection.setString(initValue)
		end
	end
	collection.setString = function(name, value)
		for k, v in ipairs(collection.variables) do
			if v.name == name then
				if v.type ~= "String" then
					print("Variable " .. name .. " is not a string")
					return false
				end
				if v.byteSize < string.len(value) then
					print("New value for Variable " .. name .. " should be \"" .. value .. "\" but that would be " ..
      						tostring(string.len(value)) .. " bytes while the set byteSize is only " .. v.byteSize)
					return false
				end
				v.value = value
				return true
			end
		end
		print("There is no variable called " .. name .. "in this VariableCollection")
		return false
	end

	collection.addShort = function(name, initValue, position)
		collection.variables[position] = {name = name, type = "Short", value = nil}
		if initValue ~= nil then
			collection.setShort(initValue)
		end
	end
	collection.setShort = function(name, value)
		for k, v in ipairs(collection.variables) do
			if v.name == name then
				if v.type ~= "Short" then
					print("Variable " .. name .. " is not a short")
					return false
				end
				if value < (-32768) or value > 32767 then
					print("Value " .. value .. "  is not in the range of a short (name: " .. name .. ")")
					return false
				end

				v.value = value
				return true
			end
		end

		print("There is no variable called " .. name .. " in this VariableCollection")
		return false
	end

	collection.addInt = function(name, initValue, position)
		collection.variables[position] = {name = name, type = "Int", value = nil}
		if initValue ~= nil then
			collection.setInt(initValue)
		end
	end
	collection.setInt = function(name, value)
		for k, v in ipairs(collection.variables) do
			if v.name == name then
				if v.type ~= "Int" then
					print("Variable " .. name .. " is not a Int")
					return false
				end
				if value < (-2147483648) or (value > 2147483647) then
					print("Value " .. value .. "  is not in the range of a Int (name: " .. name .. ")")
					return false
				end

				v.value = value
				return true
			end
		end

		print("There is no variable called " .. name .. " in this VariableCollection")
		return false
	end

	collection.addDouble = function(name, initValue, position)
		collection.variables[position] = {name = name, type = "Double", value = nil}
		if initValue ~= nil then
			collection.setDouble(initValue)
		end
	end
	collection.setDouble = function(name, value)
		for k, v in ipairs(collection.variables) do
			if v.name == name then
				if v.type ~= "Double" then
					print("Variable " .. name .. " is not a Double")
					return false
				end
				if value < (2 ^ (-1022)) or (value > 2 ^ (1023)) then
					print("Value " .. value .. "  is not in the range of a Double (name: " .. name .. ")")
					return false
				end

				v.value = value
				return true
			end
		end

		print("There is no variable called " .. name .. " in this VariableCollection")
		return false
	end

	collection.toByteBuffer = function()
		local bytesNeeded = 0
		local _ = nil
		for _, v in ipairs(collection.variables) do
			if v.type == "String" then
				bytesNeeded = bytesNeeded + v.byteSize
			elseif v.type == "Short" then
				bytesNeeded = bytesNeeded + 2
			elseif v.type == "Int" then
				bytesNeeded = bytesNeeded + 4
			elseif v.type == "Double" then
				bytesNeeded = bytesNeeded + 8
			end
		end

		local bb = ByteBuffer(bytesNeeded)

		for _, v in ipairs(collection.variables) do
			if v.type == "String" then
				if v.value == nil then
					bb:putEmptyBytes(v.byteSize)
				else
					local sSize = string.len(v.value)
					local emptyBytesAmount = v.byteSize - sSize
					bb:putString(v.value)
					bb:putEmptyBytes(emptyBytesAmount)
				end
			elseif v.type == "Short" then
				if v.value == nil then
					bb:putEmptyBytes(2)
				else
					bb:putShort(v.value)
				end
			elseif v.type == "Int" then
				if v.value == nil then
					bb:putEmptyBytes(4)
				else
					bb:putInt(v.value)
				end
			elseif v.type == "Double" then
				if v.value == nil then
					bb:putEmptyBytes(8)
				else
					bb:putDouble(v.value)
				end
			end
		end

	end

end
