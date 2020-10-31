local Table = {}
function Table.findKey(t, key)
	-- Log.debugLog("table findKey")
	for k, v in pairs(t) do
		if k == key then
			return v
		end
	end
	return nil
end

function Table.findIndex(t, value)
	-- Log.debugLog("table findIndex")
	for k, v in pairs(t) do
		if v == value then
			return k
		end
	end

	return nil
end

function Table.contains(t, value)
	for k, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

function Table.containsSubstring(t, s)
	for k, v in pairs(t) do
		if string.match(s, v) then
			return true
		end
	end
	return false
end

function Table.valueLength(t)
	local count = 0
	for k, v in pairs(t) do
		if v ~= nil then
			count = count + 1
		end
	end
	return count
end

function Table.firstBorder(t)
	local count = 0
	local done = false
	local index = 0
	while (not done) do
		if t[index + 1] ~= nil then
			index = index + 1
		else
			done = true
		end
	end
	return index
end

function Table.deepLength(t)
	local count = 0
	for k, v in pairs(t) do
		if v ~= nil then
			if type(v) == "table" then
				count = count + Table.deepLength(v)
			else
				count = count + 1
			end
		end
	end
	return count
end

function Table.toString(t)
	-- Log.debugLog("table toString")
	local print_r_cache = {}
	local string = [[]]
	local function sub_print_r(t, indent)
		if (print_r_cache[tostring(t)]) then
			string = string .. indent .. "*" .. tostring(t) .. "\n"
		else
			print_r_cache[tostring(t)] = true
			if (type(t) == "table") then
				for pos, val in pairs(t) do
					pos = tostring(pos)
					if (type(val) == "table") then
						string = string .. indent .. "[" .. pos .. "] => " .. tostring(t) .. " {" .. "\n"
						sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
						string = string .. indent .. string.rep(" ", string.len(pos) + 6) .. "}" .. "\n"
					elseif (type(val) == "string") then
						string = string .. indent .. "[" .. pos .. '] => "' .. val .. '"' .. "\n"
					elseif (type(val) == "userdata") then
						string = string .. indent .. "[" .. pos .. "] Userdata => " .. tostring(t) .. " {" .. "\n"
						sub_print_r(getmetatable(val), indent .. string.rep(" ", string.len(pos) + 8))
						string = string .. indent .. string.rep(" ", string.len(pos) + 6) .. "}" .. "\n"
					else
						string = string .. indent .. "[" .. pos .. "] => " .. tostring(val) .. "\n"
					end
				end
			else
				string = string .. indent .. tostring(t) .. "\n"
			end
		end
	end
	if (type(t) == "table") then
		string = string .. tostring(t) .. " {" .. "\n"
		sub_print_r(t, "  ")
		string = string .. "}" .. "\n"
	else
		sub_print_r(t, "  ")
	end

	return string
end

function Table.toString_lessInfo(t)

	local print_r_cache = {}
	local string = [[]]
	local function sub_print_r(t, indent)
		if (print_r_cache[tostring(t)]) then
			string = string .. indent .. "*" .. tostring(t) .. "\n"
		else
			print_r_cache[tostring(t)] = true
			if (type(t) == "table") then
				for pos, val in pairs(t) do
					pos = tostring(pos)
					if (type(val) == "table") then
						string = string .. indent .. "[" .. pos .. "] => " .. tostring(t) .. " {" .. "\n"
						sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
						string = string .. indent .. string.rep(" ", string.len(pos) + 6) .. "}" .. "\n"
					elseif (type(val) == "string") then
						string = string .. indent .. "[" .. pos .. "] => " .. tostring(val) .. "\n"
					elseif (type(val) == "userdata") then
						string = string .. indent .. "[" .. pos .. "] Userdata => " .. tostring(t) .. " {" .. "\n"
						sub_print_r(getmetatable(val), indent .. string.rep(" ", string.len(pos) + 8))
						string = string .. indent .. string.rep(" ", string.len(pos) + 6) .. "}" .. "\n"
					elseif (type(val) == "function") then
						string = string .. indent .. "[" .. pos .. "] => function\n"
					else
						string = string .. indent .. "[" .. pos .. "] => " .. tostring(val) .. "\n"
					end
				end
			else
				string = string .. indent .. tostring(t) .. "\n"
			end
		end
	end
	if (type(t) == "table") then
		string = string .. tostring(t) .. " {" .. "\n"
		sub_print_r(t, "  ")
		string = string .. "}" .. "\n"
	else
		sub_print_r(t, "  ")
	end

	return string
end

function Table.removeIndex(t, index)
	-- Log.debugLog("table removeIndex")
	local newTable = {}
	for k, v in pairs(t) do
		-- print("k:" .. k .. " | index: " .. index)
		if k ~= index then
			Table.insert(newTable, v)
		end
	end
	return newTable
end

function Table.copy(orig)
	-- Log.debugLog("table copy")
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[Table.copy(orig_key)] = Table.copy(orig_value)
		end
		setmetatable(copy, Table.copy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end

	return copy
end

function Table.removeKey(t, key)
	-- Log.debugLog("table removeKey")

	local i = 0
	local keys, values = {}, {}
	for k, v in pairs(t) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end

	while i > 0 do
		if keys[i] == key then
			Table.remove(keys, i)
			Table.remove(values, i)
			break
		end
		i = i - 1
	end

	local a = {}
	if #keys >= 1 then
		for i2 = 1, #keys do
			a[keys[i2]] = values[i2]
		end
	end

	return a
end

function Table.deepDiff(original, new)
	local iDiff = {}

	for keyN, valueN in pairs(new) do
		if table.findKey(original, keyN) == nil then
			table.insert(iDiff, keyN)
		else
			if type(valueN) == "table" then
				local diffs = Table.deepDiff(original[keyN], valueN)
				if #diffs > 0 then
					table.insert(iDiff, keyN)
				end
			else
				if valueN ~= original[keyN] then
					table.insert(iDiff, keyN)
				end
			end

		end
	end

	return iDiff
end

function Table.stringFind(t, s)
	for k, v in pairs(t) do
		local index = string.find(v, s)
		if index then
			-- print(s .. " IS element of " .. v)
			return k
		else
			-- print(s .. " not element of " .. v)
		end
	end
	return nil
end

-- Deletes a specifc amounts of entries and moves up the table, only works on tables without holes. TODO: Make it work on tables with holes.
function Table.removeFirst(t, amountToDelete)
	local tLength = #t
	-- Removing entries

	for i = 1, amountToDelete do
		t[i] = nil
	end

	-- Moving up all other entries
	for j = amountToDelete + 1, tLength do
		t[j - amountToDelete] = t[j]
		t[j] = nil
	end

	return t
end

-- Makes an Table holeless (no nils until last value)
function Table.removeHoles(t)
	local tLenght = Table.valueLength(t)
	local entryIndexes = {}

	for index, value in pairs(t) do
		table.insert(entryIndexes, index)
	end

	table.sort(entryIndexes, function(a, b)
		return a < b
	end)
	local newIndex, oldIndex
	for nIndex, oIndex in ipairs(entryIndexes) do
		newIndex = nIndex
		oldIndex = oIndex
		t[newIndex] = t[oldIndex] -- This should not delete values we still need, since newIndex should always be smaller or equal oldIndex
	end

	-- Old index is now the highest index in the table that has a value and newIndex is the last entry we wanna keep. We set everything in between to nil

	for j = newIndex + 1, oldIndex do
		t[j] = nil
	end

	return t
end

function Table.clear(t)
	local kList = {}
	for index, value in pairs(t) do
		table.insert(kList, index)
	end

	for _, k in pairs(kList) do
		t[k] = nil
	end
end

MagLib.Utils.Table = Table
