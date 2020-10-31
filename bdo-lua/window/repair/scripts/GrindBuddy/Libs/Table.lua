function table.findKey(t, key)
    --Log.debugLog("table findKey")
    for k, v in pairs(t) do
        if k == key then
            return v
        end
    end
    return nil
end

function table.findIndex(t, value)
    --Log.debugLog("table findIndex")
    local i = 1
    for k, v in pairs(t) do
        if v == value then
            return i
        end
        i = i + 1
    end

    i = nil

    return 0
end

function table.valueLength(t)
    local count = 0
    for k, v in pairs(t) do
        if v ~= nil then
            count = count + 1
        end
    end
    return count
end

function table.firstBorder(t)
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

function table.deepLength(t)
    local count = 0
    for k, v in pairs(t) do
        if v ~= nil then
            if type(v) == "table" then
                count = count + table.deepLength(v)
            else
                count = count + 1
            end
        end
    end
    return count
end

function table.toString( t )
    --Log.debugLog("table toString")
    local print_r_cache = {}
    local string = [[]]
    local function sub_print_r(t, indent)
        if (print_r_cache[tostring(t)]) then
            string = string .. indent .. "*" .. tostring(t) .. "\n"
        else
            print_r_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        string = string .. indent.."["..pos.."] => "..tostring(t).." {" .. "\n"
                        sub_print_r(val, indent..string.rep(" ", string.len(pos) + 8))
                        string = string .. indent..string.rep(" ", string.len(pos) + 6).."}" .. "\n"
                    elseif (type(val) == "string") then
                        string = string .. indent.."["..pos..'] => "'..val..'"' .. "\n"
                    elseif (type(pos) ~= "userdata") then
                        string = string .. indent.."["..pos.."] => "..tostring(val) .. "\n"
                    end
                end
            else
                string = string .. indent..tostring(t) .. "\n"
            end
        end
    end
    if (type(t) == "table") then
        string = string .. tostring(t).." {" .. "\n"
        sub_print_r(t, "  ")
        string = string .. "}" .. "\n"
    else
        sub_print_r(t, "  ")
    end

    return string
end

function table.removeIndex(t, index)
    --Log.debugLog("table removeIndex")
    local newTable = {}
    for k, v in pairs(t) do
        --print("k:" .. k .. " | index: " .. index)
        if k ~= index then
            table.insert(newTable, v)
        end
    end
    return newTable
end

function table.copy(orig)
    --Log.debugLog("table copy")
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[table.copy(orig_key)] = table.copy(orig_value)
        end
        setmetatable(copy, table.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end

    orig_type = nil

    return copy
end

function table.removeKey(t, key)
    --Log.debugLog("table removeKey")

    local i = 0
    local keys, values = {}, {}
    for k, v in pairs(t) do
        i = i + 1
        keys[i] = k
        values[i] = v
    end

    while i > 0 do
        if keys[i] == key then
            table.remove(keys, i)
            table.remove(values, i)
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
