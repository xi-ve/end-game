local Vector = {}
local Math = MagLib.Utils.Math
function Vector.tableToVector3(t)
	if t == nil then
		return
	end
	return Vector3(t.X, t.Y, t.Z)
end

function Vector.toString(t)
	if t == nil then
		return ""
	end
	return "X: " .. t.X .. ", Y: " .. t.Y .. ", Z: " .. t.Z
end

function Vector.copy(v)
	return Vector3(v.X, v.Y, v.Z)
end

function Vector.fromString(s)
	s = s:sub(4) -- Cutting "X: "
	local commaPos = s:find(",")
	local x = tonumber(s:sub(0, commaPos - 1))
	s = s:sub(commaPos + 1)
	s = s:sub(5) -- Cutting "Y: "
	commaPos = s:find(",")
	local y = tonumber(s:sub(0, commaPos - 1))
	s = s:sub(commaPos + 1)
	local z = tonumber(s:sub(5)) -- Cutting "Z: "
	return Vector3(x, y, z)
end

function Vector.vectorExistsInTable(t, vectorToFind)
	if t == nil or vectorToFind == nil then
		return
	end
	for k, v in pairs(t) do
		if v.X == vectorToFind.X and v.Y == vectorToFind.Y and v.Z == vectorToFind.Z then
			return true
		end
	end
	return false
end

function Vector.findVectorInTable(t, vectorToFind)
	if t == nil or vectorToFind == nil then
		return nil
	end
	for k, v in pairs(t) do
		if v.X == vectorToFind.X and v.Y == vectorToFind.Y and v.Z == vectorToFind.Z then
			return k
		end
	end
	return nil
end

function Vector.subtract(v1, v2)
	if v1.Z then
		return Vector3(v1.X - v2.X, v1.Y - v2.Y, v1.Z - v2.Z)
	else
		return Vector2(v1.X - v2.X, v1.Y - v2.Y)
	end
end
Vector.sub = Vector.subtract

function Vector.addition(v1, v2)
	if v1.Z then
		return Vector3(v1.X + v2.X, v1.Y + v2.Y, v1.Z + v2.Z)
	else
		return Vector2(v1.X + v2.X, v1.Y + v2.Y)
	end
end
Vector.add = Vector.addition

function Vector.multiply(v1, mod)
	if v1.Z then
		return Vector3(v1.X * mod, v1.Y * mod, v1.Z * mod)
	else
		return Vector2(v1.X * mod, v1.Y * mod)
	end
end
Vector.mult = Vector.multiply

function Vector.divide(v1, mod)
	if v1.Z then
		return Vector3(v1.X / mod, v1.Y / mod, v1.Z / mod)
	else
		return Vector2(v1.X / mod, v1.Y / mod)
	end
end

Vector.div = Vector.divide

function Vector.Distance2(v1, v2)
	local distanceVec = Vector.subtract(v1, v2)
	local distance = Vector.getLength(distanceVec)

	distanceVec = nil
	return distance
end

function Vector.getLength(v)
	local length = 0
	if v.Z then
		length = math.sqrt(((v.X ^ 2) + (v.Y ^ 2) + (v.Z ^ 2)))
	else
		length = math.sqrt(((v.X ^ 2) + (v.Y ^ 2)))
	end
	return length
end

function Vector.modifyLength(vector, wantedLength)
	local rVecLength = Vector.getLength(vector)
	local multiplier = wantedLength / rVecLength

	if vector.Z then
		return Vector3(vector.X * multiplier, vector.Y * multiplier, vector.Z * multiplier)
	else
		return Vector2(vector.X * multiplier, vector.Y * multiplier)
	end
end

function Vector.rVec(pos1, pos2)
	local rVec = Vector3(pos2.X - pos1.X, pos2.Y - pos1.Y, pos2.Z - pos1.Z)
	if rVec.X == 0 and rVec.Y == 0 and rVec.Z == 0 then
		return Vector3(0, 0, 0)
	end

	return Vector.modifyLength(rVec, 1)
end

function Vector.rVec2D(pos1, pos2, wantedSize)
	local rVec = Vector2(pos2.X - pos1.X, pos2.Y - pos1.Y)
	if rVec.X == 0 and rVec.Y == 0 then
		return Vector2(0, 0)
	end
	local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2)))

	local returnRVec = rVec
	if wantedSize then
		local rVecMultiplier = wantedSize / rVecLength
		returnRVec = Vector2(math.floor(rVec.X * rVecMultiplier + 0.5), math.floor(rVec.Y * rVecMultiplier + 0.5))
	end

	return returnRVec
end

function Vector.equal(v1, v2)
	if v1.X == v2.X and v1.Y == v2.Y and v1.Z == v2.Z then
		return true
	else
		return false
	end
end

function Vector.equal2D(v1, v2)
	if v1.X == v2.X and v1.Z == v2.Z then
		return true
	else
		return false
	end
end

function Vector.equalWithYTollerance(v1, v2, tollerance)
	if v1.X == v2.X and math.abs(v1.Y - v2.Y) < tollerance and v1.Z == v2.Z then
		return true
	else
		return false
	end
end

function Vector.floor(v)
	return Vector3(math.floor(v.X), math.floor(v.Y), math.floor(v.Z))
end

function Vector.vectorTableToString(table)
	local s = "\nVector Table: \n"
	for k, v in pairs(table) do
		s = s .. Vector.toString(v) .. "\n"
	end
	return s
end

function Vector.twoLinesCollide(start1, vec1, start2, vec2, yAxisMaxDiff)
	if yAxisMaxDiff == nil then
		yAxisMaxDiff = 150
	end
	--[[
  start1 = Vector.floor(start1)
  start2 = Vector.floor(start2)
  vec1 = Vector.floor(vec1)
  vec2 = Vector.floor(vec2)
  ]]
	-- We treat it as 2D Vectors as that is a lot simpler and then just check that the yAxis at the collision points is not too different
	local lambda_over = (-vec2.Z * (start2.X - start1.X) + vec2.X * (start2.Z - start1.Z))
	local lambda_under = (-vec1.X * vec2.Z + vec1.Z * vec2.X)
	local lambda
	if lambda_over == 0 then
		lambda = 0
	elseif lambda_under == 0 then
		lambda = 1 / 0
	else
		lambda = lambda_over / lambda_under
	end

	local mue_over = (-vec1.Z * (start2.X - start1.X) + vec1.X * (start2.Z - start1.Z))
	local mue_under = (-vec1.X * vec2.Z + vec1.Z * vec2.X)
	local mue
	if mue_over == 0 then
		mue = 0
	elseif mue_under == 0 then
		mue = 1 / 0
	else
		mue = mue_over / mue_under
	end

	local collision1 = Vector.addition(start1, Vector.multiply(vec1, lambda))
	local collision2 = Vector.addition(start2, Vector.multiply(vec2, mue))
	local isCollision2D = MagLib.Utils.Math.compareFloats(collision1.X, collision2.X, 0) and
                      		MagLib.Utils.Math.compareFloats(collision1.Z, collision2.Z, 0)
	local isCollisionY = math.abs(collision1.Y - collision2.Y) <= yAxisMaxDiff
	if not isCollisionY then
		-- print("YDif: " ..math.abs(collision1.Y - collision2.Y))
	end
	return isCollision2D, isCollisionY, lambda, mue
end

Vector.rotateHorizontal = function(vector, angle)
	local sinOfAngle = math.sin(angle)
	local cosOfAngle = math.cos(angle)

	if vector.Z then
		return Vector3(vector.X * cosOfAngle - vector.Z * sinOfAngle, vector.Y, vector.X * sinOfAngle + vector.Z * cosOfAngle)
	else
		return Vector2(vector.X * cosOfAngle - vector.Y * sinOfAngle, vector.X * sinOfAngle + vector.Y * cosOfAngle)
	end
end

MagLib.Utils.Vector = Vector
