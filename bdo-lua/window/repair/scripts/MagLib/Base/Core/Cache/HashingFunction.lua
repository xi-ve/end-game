local HashingFunction = Class()
function HashingFunction:init(hashFunc)
	self.hashFunc = hashFunc
end

function HashingFunction:hash(v)
	return self.f(v)
end

MagLib.Core.Cache.HashingFunction = HashingFunction
