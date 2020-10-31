--spits out a table with indexies of nT which differ from T
--supports T[n] = Value
--supports T[n] = {nObjects}
function table.diff(T, nT) 
    local iDiff = {}

    for keyNT, valueNT in pairs(nT) do

        if table.findKey(T, keyNT) == nil then
            table.insert(iDiff, keyNT)
        else

            if type(valueNT) == "table" then
                local isDiff = false

                for k,v in pairs(valueNT) do

                    if T[keyNT][k] ~= v then

                        isDiff = true
                        break
                    end
                end

                if isDiff then
                    table.insert(iDiff, keyNT)
                end
            else
                if valueNT ~= T[keyNT] then
                    table.insert(iDiff, keyNT)
                end
            end
        end
    end

    return iDiff
end

function table.combinestring(T, seperator)
    local sOut = ""

    if T == nil then
        return sOut
    end

    local tCount = table.length(T)
    
    if tCount == 0 then
        return sOut
    end

    if tCount == 1 then
        return tostring(T[1])
    end

    for i = 1, tCount do
        
        if i == tCount then

            sOut = sOut .. tostring(T[i])
        else

            sOut = sOut .. tostring(T[i]) .. seperator
        end
    end

    return sOut
end

function table.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function table.find(t, value)
    for k,v in pairs(t) do
        if v == value then
            return k
        end
    end
    return nil
end

function table.findKey(t, key)
    for k,v in pairs(t) do
        if k == key then
            return v
        end
    end
    return nil
end

function table.findIndex(t, value)
    local i = 1
    for k,v in pairs(t) do
        if v == value then
            return i
        end
        i = i + 1
    end
    return 0
end

function table.merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then table.merge(a[k],v) else a[k]=v end end
    end
    return a
end

function table.print ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

--- Performs a deep copy of other tables into the given table.
---
--- Note: This function mutates tbl. For non-mutable use, pass {} as the first
--- param.
---
---@param tbl table The table to copy into.
---@param other table The other table to copy from.
---@return table tbl Returns tbl.
function table.deepcopy(tbl, other, ...)
    if type(other) ~= 'table' or type(tbl) ~= 'table' then return tbl end

    for k, v in pairs(other) do
        if type(v) == 'table' then
            if type(tbl[k]) == 'table' then
                table.deepcopy(tbl[k], v)
            else
                tbl[k] = table.clone(v)
            end
        else
            tbl[k] = v
        end
    end

    return table.deepcopy(tbl, ...)
end

--- Assigns attributes to tbl from other tables.
---
--- This function differs from table.deepcopy; it does not 'merge' subtables and
--- existing subtables are overwritten.
---
--- Note: This function mutates tbl. For non-mutable use, pass {} as the first
--- param.
---
---@param tbl table The table to copy into.
---@param other table The other table to copy from.
---@return table tbl Returns tbl.
function table.assign(tbl, other, ...)
    if type(other) ~= 'table' or type(tbl) ~= 'table' then return tbl end

    for k, v in pairs(other) do
        if tbl[k] == nil then
            if type(v) == 'table' then
                tbl[k] = table.clone(v)
            else
                tbl[k] = v
            end
        end
    end

    return table.assign(tbl, ...)
end

--- Clones a table. This is essentially a deepcopy of a table onto a new table.
---
---@param t table The table to clone.
---@return table cloned The cloned table
function table.clone(t)
    local clone = table.deepcopy({}, t)
    local mt = getmetatable(t)
    setmetatable(clone, mt)
    return clone
end

--- Derives a table from parent tables. This creates a deepcopy of one or more
--- tables into a new table.
---
---@param parent table The parent table.
---@return table derived The derived table
function table.derive(parent, ...)
    return table.deepcopy(table.clone(parent), ...)
end

--- Shuffles a table.
---
--- This is a mutation-free function that creates a copy of the original table.
---
---@param original table The original table
---@return table shuffled The shuffled table
function table.shuffle(original)
    local t = table.clone(original)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end