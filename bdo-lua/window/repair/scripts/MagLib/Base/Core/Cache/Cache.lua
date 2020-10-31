MagLib.Core.Cache = {}

local Cache = Class()
function Cache:init(hashingFunction, getValueFunc, isStillValidFunc)
	self.values = {}
	self.hashingFunction = hashingFunction
	self.getValueFunc = getValueFunc
	self.isStillValidFunc = isStillValidFunc
end

function Cache:getHash(key)
	if self.hashingFunction then
		return self.hashingFunction(key)
	else
		return key
	end
end

function Cache:setValueByKey(key, value)
	self.values[self:getHash(key)] = value
end

function Cache:setValueByHash(hash, value)
	self.values[hash] = value
end

function Cache:clear()
	self.values = {}
end

function Cache:cleanup()
	if self.isStillValidFunc then
		local toRemoveKeys = {}
		for key, v in pairs(self.values) do
			if not self.isStillValidFunc(key, v) then
				table.insert(toRemoveKeys, key)
			end
		end

		for _, key in pairs(toRemoveKeys) do
			toRemoveKeys[key] = nil
		end
	else
		MagLib.logger.info("Cache:cleanup() called but no isStillValidFunc defined")
	end
end

---Returns the value from cache.
---If there is not value for the given key, it will either return what getValueFunc (if set) returns with the key as the parameter (and update the cache) or nil
function Cache:getValue(key)
	local hash = self:getHash(key)

	local value = self.values[hash]
	-- If there is no valid entry and we have a func to get a valid value, we use it to get a value, update the cache and return it.
	if not value and self.getValueFunc then
		value = self.getValueFunc(key)
		self:setValueByHash(hash, value)
	end

	return value
end

MagLib.Core.Cache.Cache = Cache
