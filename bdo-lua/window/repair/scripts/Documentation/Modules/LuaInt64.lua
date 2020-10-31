---LuaJit doesn't support 64bit integers, hence we provide our own userdata that fills that functionality.
---It supports addition, subtraction, multiplication and division with other LuaInt64 objects, but not with lua numbers
---@class LuaInt64
local LuaInt64 = {}

---Creates a new LuaInt64 object from a lua number
---@param value number
function LuaInt64(value)
end

---Returns the closest double value of the LuaInt64 (Can be inaccurate/Not the exact value!)
---@return number closestDouble
function LuaInt64:getUnsafe()
end

---Sets the internal value as a int64 parsed from the given string. Does NOT return a new LuaInt64.
---@param string string
function LuaInt64:fromString(string)
end
