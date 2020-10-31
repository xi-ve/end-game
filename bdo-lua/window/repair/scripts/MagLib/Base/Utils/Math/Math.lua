local Math = {}
Math.PI = 3.14159265358979323846
local PI = Math.PI

Math.isFloat = function(number)
	return tostring(number % 1) ~= "0"
end

Math.round = function(num, numDecimalPlaces)
	if numDecimalPlaces and numDecimalPlaces > 0 then
		local mult = 10 ^ numDecimalPlaces
		return math.floor(num * mult + 0.5) / mult
	else
		local mult = 10 ^ numDecimalPlaces
		numDecimalPlaces = numDecimalPlaces * mult * 2 -- negates its negative status
		return math.floor(num * mult + 0.5) / mult
	end
	return math.floor(num + 0.5)
end

Math.roundUp = function(num)
	return math.floor(num) + 1
end

Math.roundDown = function(num)
	return math.floor(num)
end

Math.average = function(numbers)
	local amount = #numbers
	if amount == 0 then
		return 0
	end

	local sum = 0
	for _, num in pairs(numbers) do
		sum = sum + num
	end

	return sum / amount
end

Math.gcd = function(m, n)
	while n ~= 0 do
		local tmp = m
		m = n
		n = tmp % n
	end

	return m
end

Math.lcm = function(m, n)
	return (m ~= 0 and n ~= 0) and m * n / Math.gcd(m, n) or 0
end

Math.divides = function(a, b)
	return b % a == 0
end

Math.normalizeYaw = function(yaw)
	while (yaw > PI) do
		yaw = -PI + (yaw - PI)
	end

	while (yaw < (-PI)) do
		yaw = PI + (yaw + PI)
	end

	return yaw
end

Math.yawToRot = function(yaw)
	if yaw > 0 then
		return yaw
	else
		return PI + (PI - math.abs(yaw))
	end
end

Math.compareFloats = function(a, b, numDecimalPlaces)
	a = Math.round(a, numDecimalPlaces)
	b = Math.round(b, numDecimalPlaces)
	local dif = math.abs(a - b)
	return not (dif >= (1 / (10 ^ numDecimalPlaces)))
end

Math.minTableToFuncReturnValue = function(table, func)
	local min = 1 / 0
	local minValue = nil
	local minValueIndex = nil
	for k, v in pairs(table) do
		local returnValue = func(v)
		if returnValue < min then
			min = returnValue
			minValue = v
			minValueIndex = k
		end
	end

	return minValue, min, minValueIndex
end

Math.binaryToDecimal = function(s)
	local num = 0
	local ex = string.len(s) - 1
	local l = 0
	local b

	l = ex + 1
	for i = 1, l do
		b = string.sub(s, i, i)
		if b == "1" then
			num = num + 2 ^ ex
		end
		ex = ex - 1
	end

	return string.format("%u", num)
end

Math.decimalToBinary = function(num)
	return
end

Math.toUnsignedShort = function(input)
	return
end

Math.Bit = {}
Math.Bit.xor = function(x, y)
	return bit.bxor(x, y)
end

Math.Bit.isBitSet = function(number, bitIndexFromRight)
	return bit.band(number, bit.lshift(1, (bitIndexFromRight - 1))) == 1
end

MagLib.Utils.Math = Math
