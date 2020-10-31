VectorUtils = {}

function VectorUtils.tableToVector3(t)
    if t == nil then
        return
    end
    return Vector3(t.X, t.Y, t.Z)
end

function VectorUtils.toString(t)
    if t == nil then
        return ""
    end
    return "X: " .. t.X .. ", Y: " .. t.Y .. ", Z: " .. t.Z
end

function VectorUtils.vectorExistsInTable(t, vectorToFind)
    Log.debugLog("vectorExistsInTable")
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

function VectorUtils.subtract(v1, v2)
    if v1.Z then
        return Vector3(v1.X - v2.X, v1.Y - v2.Y, v1.Z - v2.Z)
    else
        return Vector2(v1.X - v2.X, v1.Y - v2.Y)
    end
end
VectorUtils.sub = VectorUtils.subtract

function VectorUtils.addition(v1, v2)
    if v1.Z then
        return Vector3(v1.X + v2.X, v1.Y + v2.Y, v1.Z + v2.Z)
    else
        return Vector2(v1.X + v2.X, v1.Y + v2.Y)
    end
end
VectorUtils.add = VectorUtils.addition

function VectorUtils.multiply(v1, mod)
    if v1.Z then
        return Vector3(v1.X * mod, v1.Y * mod, v1.Z * mod)
    else
        return Vector2(v1.X * mod, v1.Y * mod)
    end
end
VectorUtils.mult = VectorUtils.multiply

function VectorUtils.divide(v1, mod)
    if v1.Z then
        return Vector3(v1.X / mod, v1.Y / mod, v1.Z / mod)
    else
        return Vector2(v1.X / mod, v1.Y / mod)
    end
end

VectorUtils.div = VectorUtils.divide

function VectorUtils.Distance2(v1, v2)
    local distanceVec = VectorUtils.subtract(v1, v2)
    local distance = VectorUtils.getLength(distanceVec)

    distanceVec = nil
    return distance
end

function VectorUtils.getLength(v)
    local length = 0
    if v.Z then
        length = math.sqrt(((v.X ^ 2) + (v.Y ^ 2) + (v.Z ^ 2)))
    else
        length = math.sqrt(((v.X ^ 2) + (v.Y ^ 2)))
    end
    return length
end

function VectorUtils.rVec(pos1, pos2)
    local rVec = Vector3(pos2.X - pos1.X, pos2.Y - pos1.Y, pos2.Z - pos1.Z)
    if rVec.X == 0 and rVec.Y == 0 and rVec.Z == 0 then
        return Vector3(0, 0, 0)
    end
    local rVecLength = math.sqrt(((rVec.X ^ 2) + (rVec.Y ^ 2) + (rVec.Z ^ 2)))
    local rVecMultiplier = 1 / rVecLength
    local normedRVec = Vector3(rVec.X * rVecMultiplier, rVec.Y * rVecMultiplier, rVec.Z * rVecMultiplier)

    rVec = nil
    rVecLength = nil
    rVecMultiplier = nil


    return normedRVec
end

function VectorUtils.equal(v1, v2)
    if v1.X == v2.X and v1.Y == v2.Y and v1.Z == v2.Z then
        return true
    else
        return false
    end
end
