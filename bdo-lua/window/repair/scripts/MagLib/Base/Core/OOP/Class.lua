---Simple class implementation
-- based and improved/extended upon https://github.com/jonstoler/class.lua/blob/master/class.lua
-- @Module MagLib.Core.Class
-- @alias Class
local class = {}

-- default (empty) constructor
function class:init(...)
end

-- class name handling
class.className = "UnnamedClass"
function class:setClassName(name)
	if type(name) ~= "string" then
		MagLib.logger.error(tostring(name) .. " is not a string! Class names need to be strings!")
	end

	self.className = name
end

function ClassType(c)
	if c.className then
		return c.className
	else
		return "NotAClassObject"
	end
end

--- Returns a copy of the current object state as a table.
--- The object can then be recreated with deserialize(t)
function class:serialize()
	local data = {}
	-- TODO

	return data
end

function class:deserialize(data)
	-- TODO
end

local function copyTable(table, destination)
	table = table or {}
	local result = destination or {}

	for k, v in pairs(table) do
		if not result[k] then
			if type(v) == "table" and k ~= "__index" and k ~= "__newindex" then
				result[k] = copyTable(v)
			else
				result[k] = v
			end
		end
	end

	return result
end

-- create a subclass
function class:extend(obj, isAbstract, justCopy)
	obj = obj or {}
	if isAbstract == nil then
		isAbstract = false
	end

	if justCopy == nil then
		justCopy = false
	end

	copyTable(self, obj)

	-- Settings isAbstract flag. Needs to be done after copyTable so we overwrite the parents isAbstract flag
	obj.isAbstract = isAbstract

	local mt = getmetatable(self)

	if mt == nil then
		mt = {}
	end

	-- create new objects directly, like o = Object()
	mt.__call = function(self, ...)
		return self:new(...)
	end

	setmetatable(obj, mt)

	return obj
end

-- create an instance of an object with constructor parameters
function class:new(...)
	if self.isAbstract then
		MagLib.logger.error("Cannot create instance of abstract class " .. self.className)
		return nil
	end

	local obj = self:extend({}, nil, true)
	if obj.init then
		obj:init(...)
	end

	return obj
end

function Class(attr, isAbstract)
	attr = attr or {}
	return class:extend(attr, isAbstract)
end

MagLib.Core.Class = Class -- For completeness sake
